local hasFolder = false

DirectoryGetEntries("/GameDir", function(name, directory)
	if directory and name == "RandomDialogue" then
		hasFolder = true
	end
	return true
end)

if IsModEnabled("RandomiserDialogue") then
	local hasFolder = false

	DirectoryGetEntries("/GameData", function(name, directory)
		if directory and name == "RandomDialogue" then
			hasFolder = true
		end
		return true
	end)
	
	if hasFolder then
		GetFiles(RandomDialoguePool, "/GameData/RandomDialogue/", ".rsd", 1)
		RandomDialoguePoolN = #RandomDialoguePool
		if RandomDialoguePoolN == 0 then
            Alert("RandomiserDialogue was enabled, but no dialogue files were loaded.")
        else
            DebugPrint("Loaded " .. RandomDialoguePoolN .. " dialogue files.")
        end
	else
		Alert("RandomiserDialogue was enabled, but no RandomDialogue folder was found.")
	end
else
    Alert("You have Random Dialogue enabled without the RandomiserDialogue framework. Random Dialogue will not work without this.")
end