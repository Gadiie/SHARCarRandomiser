-- Override GetPath to fix slashes for us
OriginalGetPath = GetPath
GetPath = function ()
    return FixSlashes(OriginalGetPath(), false, true)
end

function ShuffleTbl(tbl)
	local tblN = #tbl
	local j
	
	for i = tblN, 1, -1 do
		j = math.random(i)
		tbl[i], tbl[j] = tbl[j], tbl[i]
	end
end

function GetRandomFromTbl(tbl, rmv)
	if rmv == nil then
		rmv = false
	end
    local i = math.random(#tbl)
    local result = tbl[i]
    if rmv then
        table.remove(tbl, i)
    end
    return result
end

function GetRandomFromKVTbl(tbl, rmv)
	if rmv == nil then
		rmv = false
	end
	local keyset = {}
	for k in pairs(tbl) do
		table.insert(keyset, k)
	end
    local k = keyset[math.random(#keyset)]
	local v = tbl[k]
    if rmv then
        tbl[k] = nil
    end
    return k, v
end

function ExistsInTbl(tbl, needle, caseSensitive)
	if tbl == nil then
		return false
	end
	if caseSensitive == nil then
		caseSensitive = true
	end
	if not caseSensitive then
		needle = needle:lower()
	end
	for i = 1, #tbl do
		local haystack = tbl[i]
		if not caseSensitive then
			haystack = haystack:lower()
		end
		if haystack == needle then
			return true
		end
	end
	return false
end

function CloneKVTable(tbl)
	local clone = {}
	for k,v in pairs(tbl) do
		clone[k] = v
	end
	return clone
end

function CountTable(tbl)
	local count = 0
	for _ in pairs(tbl) do
		count = count + 1
	end
	return count
end

function findLast(haystack, needle)
	local i=haystack:match(".*"..needle.."()")
	if i==nil then return nil else return i-1 end
end

function round(num, numDecimalPlaces)
  local mult = 10^(numDecimalPlaces or 0)
  return math.floor(num * mult + 0.5) / mult
end

-- Some functions for converting binary numbers in strings to Lua numbers
function String1ToInt(str)
    return str:byte(1)
end

function String4ToInt(str)
    local b1, b2, b3, b4 = str:byte(1, 4)
    return b1 + (b2 * 256) + (b3 * 256 * 256) + (b4 * 256 *256*256)
end

function IntToString4(int)
    local b1 = int % 256
    local b2 = math.floor(int / 256) % 256
    local b3 = math.floor(int / 256 / 256) % 256
    local b4 = math.floor(int / 256 / 256 / 256) % 256
    return string.char(b1, b2, b3, b4)
end

-- Iterate a chunk to find its subchunks, because simple pattern matching can find false matches

function FindSubchunks(Chunk, ID)
    local LengthStr = Chunk:sub(5, 8)
    local Position = 1 + String4ToInt(LengthStr)
    return function()
        while Position < Chunk:len() do
            local ChunkID = Chunk:sub(Position + 0, Position + 3)
            local ChunkLength = String4ToInt(Chunk:sub(Position + 8, Position + 11))
            Position = Position + ChunkLength
            if ChunkID == ID then
                return Position - ChunkLength, ChunkLength
            end
        end
        return nil
    end
end

-- Simple use of iterator to the find the first chunk of an ID
function FindSubchunk(Chunk, ID)
    return FindSubchunks(Chunk, ID)()
end

-- Extract a string from a P3D chunk
function GetP3DString(Chunk, Offset)
    local NLength = String1ToInt(Chunk:sub(Offset, Offset))
    local Name =  Chunk:sub(Offset + 1, Offset + NLength)
    return Name, NLength
end

-- Change a string inside a P3D string
-- Returns the new P3D, the change in length for updating header data, and the original string
function SetP3DString(Chunk, Offset, NewString)
	local OrigName, OrigLength = GetP3DString(Chunk, Offset)
    local LengthByte = string.char(NewString:len())
	local New = Chunk:sub(1, Offset - 1) .. LengthByte .. NewString .. Chunk:sub(Offset + OrigLength + 1)
    local Delta = NewString:len() - OrigLength
    return New, Delta, OrigName
end

function GetP3DInt4(Chunk, Offset)
    return String4ToInt(Chunk:sub(Offset, Offset + 3))
end

function SetP3DInt4(Chunk, Offset, NewValue)
    NewValue = IntToString4(NewValue)
    return Chunk:sub(1, Offset - 1) .. NewValue .. Chunk:sub(Offset + 4)
end

function AddP3DInt4(Chunk, Offset, Adjust)
    local New = GetP3DInt4(Chunk, Offset) + Adjust
    return SetP3DInt4(Chunk, Offset, New)
end

--Remove a substring from a string
function RemoveString(Str, Start, End)
    return Str:sub(1, Start - 1) .. Str:sub(End)
end

-- Transforms an ASCII string to "UTF-16" kinda
function AsciiToUTF16(String)
	local Out = ""
	for i = 1, #String do
		Out = Out .. String:sub(i,i) .. "\0"
	end
	return Out
end

-- Uncomment to print more debug messages about the P3D file patching process
function p3d_debug(message)
    -- print(message)
end

function ReplaceCharacterSkinSkel(Original, Replace)
    -- Copy textures over
    local Textures = ""
	for position, length in FindSubchunks(Replace, TEXTURE_CHUNK) do
		Textures = Textures .. Replace:sub(position, position + length - 1)
	end

    -- Copy shaders over
	local Shaders = ""
	local ShaderList = {}
	for position, length in FindSubchunks(Replace, SHADER_CHUNK) do
		local ShaderName = GetP3DString(Replace, position + 12)
		ShaderList[ShaderName] = true
		local Shader =  Replace:sub(position, position + length - 1)
		Shaders = Shaders .. Shader
	end

    -- Remove clashing shaders
	local Adjust = 0
	for position, length in FindSubchunks(Original, SHADER_CHUNK) do
		local ShaderName = GetP3DString(Original, position + 12 - Adjust)
		if ShaderList[ShaderName] then
			p3d_debug("Removing clashing shader " .. ShaderName)
			Original = RemoveString(Original, position - Adjust, position + length - Adjust)
            Adjust = Adjust + length
		end
	end
    
    -- Find meshes
    local Meshes = ""
    for position, length in FindSubchunks(Replace, MESH_CHUNK) do
        Meshes = Meshes .. Replace:sub(position, position + length - 1)
    end
    
    -- Locate the new animation
    ANIndex, ANLength = FindSubchunk(Replace, ANIMATION_CHUNK)
    local Animation = ""
    if ANIndex ~= nil then
        p3d_debug("Replacing eyeball animation")
        Animation = Replace:sub(ANIndex, ANIndex + ANLength - 1)        
        -- Remove the original animation
        local ANIndex, ANLength = FindSubchunk(Original, ANIMATION_CHUNK)
        if ANIndex ~= nil then
            Original = RemoveString(Original, ANIndex, ANIndex + ANLength)
        end
    end
    
    -- Load new skeleton
    local SKIndex, SKLength = FindSubchunk(Replace, SKELETON_CHUNK)
    local NewSkel = Replace:sub(SKIndex, SKIndex + SKLength - 1)
    
    -- Load new skin
    local SNIndex, SNLength = FindSubchunk(Replace, SKIN_CHUNK)
    local NewSkin = Replace:sub(SNIndex, SNIndex + SNLength - 1)
    
    -- Find Original Skeleton, Remove it
    SKIndex, SKLength = FindSubchunk(Original, SKELETON_CHUNK)
    local SkelName, SkelNLength = GetP3DString(Original, SKIndex + 12)
    Original = RemoveString(Original, SKIndex, SKIndex + SKLength)
    
    -- Find Original Skin
    SNIndex, SNLength = FindSubchunk(Original, SKIN_CHUNK)
    local SkinName, SkinNLength = GetP3DString(Original, SNIndex + 12)
    
    -- Change names and update lengths
    NewSkel, SkelDelta, OSName = SetP3DString(NewSkel, 13, SkelName)
    NewSkel = AddP3DInt4(NewSkel, 5, SkelDelta)
    NewSkel = AddP3DInt4(NewSkel, 9, SkelDelta)
    NewSkin, SkinDelta, OS2Name = SetP3DString(NewSkin, 13, SkinName)
    local SkelNameIndex = SkinName:len() + 18
    NewSkin, SkinDelta2, OS3Name = SetP3DString(NewSkin, SkelNameIndex, SkelName)
    NewSkin = AddP3DInt4(NewSkin, 5, SkinDelta + SkinDelta2)
    NewSkin = AddP3DInt4(NewSkin, 9, SkinDelta + SkinDelta2)
    
    p3d_debug(OSName .. "->" .. SkelName .. OS2Name .. "->" .. SkinName .. OS3Name .. "->" .. SkelName)
    
    -- Add to original model
    Original = Original:sub(1, SNIndex - 1) .. Textures .. Shaders .. Animation .. NewSkel .. Meshes .. NewSkin .. Original:sub(SNIndex + SNLength)
    
    -- Locate the new OFC, if one exists
    local NFCIndex, NFCLength = FindSubchunk(Replace, OLD_FRAME_CONTROLLER_CHUNK)
    if NFCIndex ~= nil then
        p3d_debug("Replacing eyeball frame controller")
        -- Locate original OFC
        local OFCIndex, OFCLength = FindSubchunk(Original, OLD_FRAME_CONTROLLER_CHUNK)
        if OFCIndex ~= nil then
            -- Get new OFC   
            local NFC = Replace:sub(NFCIndex, NFCIndex + NFCLength - 1)
            -- Replace the original OFC with the new one
            Original = Original:sub(1, OFCIndex - 1) .. NFC .. Original:sub(OFCIndex + OFCLength)
        end
    end
    
    -- Locate the new comp drawable prop list
    local CDIndex, CDLength = FindSubchunk(Replace, COMP_DRAW_CHUNK)
    local CD = Replace:sub(CDIndex, CDIndex + CDLength - 1)
    local CDPIndex, CDPLength = FindSubchunk(CD, COMP_DRAW_PROP_LIST_SUBCHUNK)
    local CDP = CD:sub(CDPIndex, CDPIndex + CDPLength - 1)
    
    -- Replace the old comp drawable prop list
    local CDIndex, CDLength = FindSubchunk(Original, COMP_DRAW_CHUNK)
    local CD = Original:sub(CDIndex, CDIndex + CDLength - 1)
    local CDPIndex, CDPLength = FindSubchunk(CD, COMP_DRAW_PROP_LIST_SUBCHUNK)
    Original = Original:sub(1, CDIndex + CDPIndex - 2) .. CDP .. Original:sub(CDIndex + CDPIndex - 1 + CDPLength)
    Original = AddP3DInt4(Original, CDIndex + 8, CDP:len() - CDPLength)
    
    -- Update file length
    Original = SetP3DInt4(Original, 9, Original:len())
    
    return Original
end

function endsWith(String,End)
   return End=='' or string.sub(String:lower(),-string.len(End))==End:lower()
end

function GetFiles(tbl, dir, extensions, count)
    if count == nil then
        count = 1
    end
	DirectoryGetEntries(dir, function(name, directory)
		if directory then
			GetFiles(tbl, dir .. name, extensions, count)
		else
			for i = 1, count do
				for i = 1, #extensions do
					local extension = extensions[i]
					if endsWith(name, extension) then
						table.insert(tbl, dir .. "/" .. name)
						break
					end
				end
			end
		end
		return true
	end)
end

function GetDirs(tbl, dir)
	DirectoryGetEntries(dir, function(name, directory)
		if directory then
			table.insert(tbl, name)
		end
		return true
	end)
end

function DebugPrint(msg, level)
	if level == nil then
		level = 0
	end
	if Settings.DebugLevel < level then
		return false
	end
	local currTime = os.date("*t")
	local currTimeStr = string.format("[%02d-%02d-%02d %02d:%02d:%02d] ", currTime.year, currTime.month, currTime.day, currTime.hour, currTime.min, currTime.sec)
	local prefix = "<Randomiser v" .. ModVersion .. "> "
	print(currTimeStr .. prefix .. msg)
	return true
end

function SetCarCameraIndex(CarModel, Index)
    for pos, length in FindSubchunks(CarModel, CAR_CAMERA_DATA_CHUNK) do
        local cameraID = GetP3DInt4(CarModel, pos + 12)
        if cameraID > 256 then
            Index = Index + 256
        end
        CarModel = SetP3DInt4(CarModel, pos + 12, Index)
    end
    return CarModel
end

function FixP3DString(str)
	local strLen = str:len()
	if strLen == 0 then return str end
	local l = 0
	for i=1,strLen do
		if str:byte(i) ~= 0 then
			l = l + 1
		else
			break
		end
	end
	return str:sub(1, l)
end

function MakeP3DString(str, minLen)
	local strLen = str:len()
	local diff = strLen % 4
	if diff > 0 then
		for i=1,4-diff do
			str = str .. string.char(0)
		end
	end
	if minLen then
		diff = minLen - str:len()
		if diff > 0 then
			for i=1,diff do
				str = str .. string.char(0)
			end
		end
	end
	return str
end

function ReplaceCar(Original, Replace)
	local cam = nil
	for pos, length in FindSubchunks(Replace, CAR_CAMERA_DATA_CHUNK) do
        local cameraID = GetP3DInt4(Replace, pos + 12)
        if cameraID <= 256 then
            cam = cameraID
			break
        end
    end
	if not cam then return Original end
	Original = SetCarCameraIndex(Original, cam)
	local CompIndex, CompLength = FindSubchunk(Original, COMP_DRAW_CHUNK)
    local OldName, OldCompNLength = GetP3DString(Original, CompIndex + 12)
	CompIndex, CompLength = FindSubchunk(Replace, COMP_DRAW_CHUNK)
    local NewName, CompNLength = GetP3DString(Replace, CompIndex + 12)
	NewName = FixP3DString(NewName)
	local Adjust = 0
	for pos, length in FindSubchunks(Original, COLLISION_OBJECT_CHUNK) do
		local name, _ = GetP3DString(Original, pos + 12 + Adjust)
		local diff = 0
		if FixP3DString(name):sub(-2) == "BV" then
			local name2 = MakeP3DString(NewName .. "BV", name:len())
			diff = name2:len() - name:len()
			Original = SetP3DString(Original, pos + 12 + Adjust, name2)
		else
			local name2 = MakeP3DString(NewName, name:len())
			diff = name2:len() - name:len()
			Original = SetP3DString(Original, pos + 12 + Adjust, name2)
		end
		Original = SetP3DInt4(Original, pos + 8 + Adjust, length + diff)
		Adjust = Adjust + diff
	end
	Adjust = 0
	for pos, length in FindSubchunks(Original, PHYSICS_OBJECT_CHUNK) do
		local name, _ = GetP3DString(Original, pos + 12 + Adjust)
		local diff = 0
		if FixP3DString(name):sub(-2) == "BV" then
			local name2 = MakeP3DString(NewName .. "BV", name:len())
			diff = name2:len() - name:len()
			Original = SetP3DString(Original, pos + 12 + Adjust, name2)
		else
			local name2 = MakeP3DString(NewName, name:len())
			diff = name2:len() - name:len()
			Original = SetP3DString(Original, pos + 12 + Adjust, name2)
		end
		Original = SetP3DInt4(Original, pos + 8 + Adjust, length + diff)
		Adjust = Adjust + diff
	end
	Adjust = 0
	for pos, length in FindSubchunks(Original, COMP_DRAW_CHUNK) do
		local diff = 0
		local name, _ = GetP3DString(Original, pos + 12 + Adjust)
		if name == OldName then
			local name2 = MakeP3DString(NewName, name:len())
			diff = name2:len() - name:len()
			Original = SetP3DString(Original, pos + 12 + Adjust, name2)
			Original = SetP3DInt4(Original, pos + 8 + Adjust, length + diff)
			Adjust = Adjust + diff
		end
    end
    Original = SetP3DInt4(Original, 9, Original:len())
    return Original
end