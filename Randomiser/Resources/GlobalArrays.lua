-- CAR LIST
RandomCarPool = {
	"ambul",
	"apu_v",
	"atv_v",
	"bart_v",
	"bbman_v",
	"bookb_v",
	"burns_v",
	"burnsarm",
	"carhom_v",
	"cArmor",
	"cBlbart",
	"cBone",
	"cCellA",
	"cCellB",
	"cCellC",
	"cCellD",
	"cCola",
	"cCube",
	"cCurator",
	"cDonut",
	"cDuff",
	"cFire_v",
	"cHears",
	"cKlimo",
	"cletu_v",
	"cLimo",
	"cMilk",
	"cNerd",
	"cNonup",
	"coffin",
	"comic_v",
	"compactA",
	"cPolice",
	"cSedan",
	"cVan",
	"dune_v",
	"elect_v",
	"famil_v",
	"fishtruc",
	"fone_v",
	"frink_v",
	"garbage",
	"glastruc",
	"gramp_v",
	"gramR_v",
	"hallo",
	"hbike_v",
	"homer_v",
	"honor_v",
	"hype_v",
	"icecream",
	"IStruck",
	"knigh_v",
	"krust_v",
	"lisa_v",
	"marge_v",
	"minivanA",
	"moe_v",
	"mono_v",
	"mrplo_v",
	"nuctruck",
	"oblit_v",
	"otto_v",
	"pickupA",
	"pizza",
	"plowk_v",
	"redbrick",
	"rocke_v",
	"schoolbu",
	"scorp_v",
	"sedanA",
	"sedanB",
	"ship",
	"skinn_v",
	"smith_v",
	"snake_v",
	"sportsA",
	"sportsB",
	"SUVA",
	"taxiA",
	"tt",
	"votetruc",
	"wagonA",
	"wiggu_v",
	"willi_v",
	"witchcar",
	"zombi_v",
	"huskA"
}

CustomCarPool = {}
CustomCarSounds = {}

RandomCarPoolPlayer = {table.unpack(RandomCarPool)}
for i = #RandomCarPoolPlayer, 1, -1 do
	if not GetSetting(RandomCarPoolPlayer[i] .. "Player") then
		table.remove(RandomCarPoolPlayer, i)
	end
end
RandomCarPoolTraffic = {table.unpack(RandomCarPool)}
for i = #RandomCarPoolTraffic, 1, -1 do
	if not GetSetting(RandomCarPoolTraffic[i] .. "Traffic") then
		table.remove(RandomCarPoolTraffic, i)
	end
end
RandomCarPoolMission = {table.unpack(RandomCarPool)}
for i = #RandomCarPoolMission, 1, -1 do
	if not GetSetting(RandomCarPoolMission[i] .. "Mission") then
		table.remove(RandomCarPoolMission, i)
	end
end
RandomCarPoolChase = {table.unpack(RandomCarPool)}
for i = #RandomCarPoolChase, 1, -1 do
	if not GetSetting(RandomCarPoolChase[i] .. "Chase") then
		table.remove(RandomCarPoolChase, i)
	end
end

-- DRIVER LIST
CarDrivers = {}
CarDrivers["apu"] = {"apu_v"}
CarDrivers["bart"] = {"bart_v", "honor_v"}
CarDrivers["cletus"] = {"cletu_v"}
CarDrivers["cbg"] = {"comic_v"}
CarDrivers["lisa"] = {"elect_v", "lisa_v"}
CarDrivers["homer"] = {"famil_v", "homer_v"}
CarDrivers["frink"] = {"frink_v"}
CarDrivers["grandpa"] = {"gramp_v", "gramR_v"}
CarDrivers["marge"] = {"marge_v"}
CarDrivers["otto"] = {"otto_v"}
CarDrivers["skinner"] = {"skinn_m1", "skinn_v"}
CarDrivers["smithers"] = {"smith_v"}
CarDrivers["snake"] = {"snake_v"}
CarDrivers["wiggum"] = {"wiggu_v"}
CarDrivers["zmale1"] = {"zombi_v"}

-- PED LIST
RandomPedPool = {
	"apu",
	"askinner",
	"a_american", 
	"a_army",  
	"a_besharp", 
	"barney",  
	"bart",  
	"beeman",  
	"boy1", 
	"boy2", 
	"boy3", 
	"boy4", 
	"brn_unf", 
	"bum", 
	"burns", 
	"busm1", 
	"busm2",  
	"busw1", 
	"b_football", 
	"b_hugo", 
	"b_man",  
	"b_military", 
	"b_ninja", 
	"b_tall", 
	"captain", 
	"carl", 
	"cbg", 
	"cletus", 
	"const1", 
	"const2", 
	"dolph", 
	--"eddie", 
	"farmr1", 
	"fem1", 
	"fem2", 
	"fem3", 
	"fem4", 
	"frankenstein", 
	"frink", 
	"gil", 
	"girl1", 
	"girl2", 
	"girl3", 
	"girl4", 
	--"grandpa", 
	"hibbert", 
	"homer", 
	"hooker", 
	"h_donut", 
	"h_evil", 
	"h_fat", 
	"h_scuzzy", 
	"h_stcrobe", 
	"h_undrwr", 
	"jasper", 
	"jimbo", 
	"joger1", 
	"joger2", 
	"kearney", 
	--"krusty", 
	--"lenny", 
	"lisa", 
	"louie", 
	"lou", 
	"l_cool", 
	"l_florida", 
	"l_jersey", 
	"male1", 
	"male2", 
	"male3", 
	"male4", 
	"male5", 
	"male6", 
	"marge", 
	"milhouse", 
	"mobstr", 
	--"moe", 
	--"moleman", 
	"m_pink", 
	"m_police", 
	"m_prison", 
	"ned", 
	"nelson", 
	"nriviera", 
	"nuclear", 
	"olady1", 
	"olady2", 
	"olady3", 
	"otto", 
	--"patty", 
	--"ralph", 
	"rednk1", 
	"rednk2", 
	"sail1", 
	"sail2", 
	"sail3", 
	"sail4", 
	"selma", 
	"skinner", 
	"smithers", 
	"snake", 
	"teen", 
	"wiggum", 
	--"willie", 
	"witch", 
	"zfem1", 
	"zfem5", 
	"zmale1",  
	"zmale3", 
	"zmale4"
}

-- Char P3D List
RandomCharP3DPool = {
	"apu_m",
	"askinn_m",
	"a_amer_m",
	"a_army_m",
	"a_besh_m",
	"barney_m",
	"bart_m",
	"beeman_m",
	"boy1_m",
	"boy2_m",
	"boy3_m",
	"boy4_m",
	"brn_un_m",
	"bum_m",
	"burns_m",
	"busm1_m",
	"busm2_m",
	"busw1_m",
	"b_foot_m",
	"b_hugo_m",
	"b_man_m",
	"b_mili_m",
	"b_ninj_m",
	"b_tall_m",
	"captai_m",
	"carl_m",
	"cbg_m",
	"cletus_m",
	"const1_m",
	"const2_m",
	"dolph_m",
	"eddie_m",
	"farmr1_m",
	"fem1_m",
	"fem2_m",
	"fem3_m",
	"fem4_m",
	"franke_m",
	"frink_m",
	"gil_m",
	"girl1_m",
	"girl2_m",
	"girl3_m",
	"girl4_m",
	"grandp_m",
	"hibber_m",
	"homer_m",
	"hooker_m",
	"h_donu_m",
	"h_evil_m",
	"h_fat_m",
	"h_scuz_m",
	"h_stcr_m",
	"h_undr_m",
	"jasper_m",
	"jimbo_m",
	"joger1_m",
	"joger2_m",
	"kearne_m",
	"krusty_m",
	"lenny_m",
	"lisa_m",
	"louie_m",
	"lou_m",
	"l_cool_m",
	"l_flor_m",
	"l_jers_m",
	"male1_m",
	"male2_m",
	"male3_m",
	"male4_m",
	"male5_m",
	"male6_m",
	"marge_m",
	"milhou_m",
	"mobstr_m",
	"moe_m",
	"molema_m",
	"m_pink_m",
	"m_poli_m",
	"m_pris_m",
	"ned_m",
	"nelson_m",
	"nrivie_m",
	"nuclea_m",
	"olady1_m",
	"olady2_m",
	"olady3_m",
	"otto_m",
	"patty_m",
	"ralph_m",
	"rednk1_m",
	"rednk2_m",
	"sail1_m",
	"sail2_m",
	"sail3_m",
	"sail4_m",
	"selma_m",
	"skinne_m",
	"smithe_m",
	"snake_m",
	"teen_m",
	"wiggum_m",
	"willie_m",
	"witch_m",
	"zfem1_m",
	"zfem5_m",
	"zmale1_m",
	"zmale3_m",
	"zmale4_m"
}

-- Icon P3D List
IconP3DPool = {
	"\\char\\apu",
	"\\char\\barne",
	"\\char\\barneuni",
	"\\char\\bart",
	"\\char\\burns",
	"\\char\\carl",
	"\\char\\cbg",
	"\\char\\cletus",
	"\\char\\drhibert",
	"\\char\\drnick",
	"\\char\\frink",
	"\\char\\grampa",
	"\\char\\homer",
	"\\char\\jimbo",
	"\\char\\kearney",
	"\\char\\krusty",
	"\\char\\lenny",
	"\\char\\lisa",
	"\\char\\louie",
	"\\char\\marage",
	"\\char\\milhouse",
	"\\char\\moe",
	"\\char\\moleman",
	"\\char\\ned",
	"\\char\\nelson",
	"\\char\\otto",
	"\\char\\ralph",
	"\\char\\scaptain",
	"\\char\\sjail",
	"\\char\\skinner",
	"\\char\\smithers",
	"\\char\\snake",
	"\\char\\svt",
	"\\char\\wiggum",
	"\\location\\android",
	"\\location\\aztec",
	"\\location\\bartroom",
	"\\location\\bowlera",
	"\\location\\casino",
	"\\location\\cemetery",
	"\\location\\chum",
	"\\location\\cletushs",
	"\\location\\dmv",
	"\\location\\duff",
	"\\location\\google",
	"\\location\\grocery",
	"\\location\\hermans",
	"\\location\\hospital",
	"\\location\\itcstore",
	"\\location\\java",
	"\\location\\kburger",
	"\\location\\krustylu",
	"\\location\\kwike",
	"\\location\\lardlads",
	"\\location\\lbsc",
	"\\location\\lexicon",
	"\\location\\mansion",
	"\\location\\moehouse",
	"\\location\\moes",
	"\\location\\monorail",
	"\\location\\museum",
	"\\location\\noise",
	"\\location\\observ",
	"\\location\\parking",
	"\\location\\planethy",
	"\\location\\playgrou",
	"\\location\\police",
	"\\location\\pwrplant",
	"\\location\\retire",
	"\\location\\right",
	"\\location\\school",
	"\\location\\scream",
	"\\location\\ship",
	"\\location\\simpsons",
	"\\location\\sitnrota",
	"\\location\\spsign",
	"\\location\\squidp",
	"\\location\\stadium",
	"\\location\\taffy",
	"\\location\\townhall",
	"\\location\\trynsave",
	"\\location\\ufo",
	"\\location\\wallewea",
	"\\location\\wstation",
	"\\object\\antifung",
	"\\object\\barrel",
	"\\object\\blender",
	"\\object\\blood",
	"\\object\\boards",
	"\\object\\bonestor",
	"\\object\\buzzcola",
	"\\object\\caffeine",
	"\\object\\cardboar",
	"\\object\\chainsaw",
	"\\object\\colacrat",
	"\\object\\comic",
	"\\object\\cooler",
	"\\object\\diaper",
	"\\object\\digest",
	"\\object\\donuts",
	"\\object\\firework",
	"\\object\\firstaid",
	"\\object\\fish",
	"\\object\\flatmeat",
	"\\object\\folder",
	"\\object\\heart",
	"\\object\\icecream",
	"\\object\\inhaler",
	"\\object\\kbmeal",
	"\\object\\ketchup",
	"\\object\\key",
	"\\object\\kids",
	"\\object\\lasercra",
	"\\object\\lasergun",
	"\\object\\lasersta",
	"\\object\\lawnchr",
	"\\object\\lawnmwr",
	"\\object\\litter",
	"\\object\\lundry",
	"\\object\\map",
	"\\object\\monkey",
	"\\object\\photo",
	"\\object\\pills",
	"\\object\\powercou",
	"\\object\\race",
	"\\object\\radio",
	"\\object\\record",
	"\\object\\redhat",
	"\\object\\setelite",
	"\\object\\sock",
	"\\object\\tamacco",
	"\\object\\tomoto",
	"\\object\\tooth",
	"\\object\\tshirt",
	"\\object\\tuxedo",
	"\\vehicle\\apu_v",
	"\\vehicle\\arm_v",
	"\\vehicle\\blimo_v",
	"\\vehicle\\bsedan_v",
	"\\vehicle\\celph_v",
	"\\vehicle\\cletus_v",
	"\\vehicle\\cola_v",
	"\\vehicle\\cvan_v",
	"\\vehicle\\frink_v",
	"\\vehicle\\krusty_v",
	"\\vehicle\\milk_v",
	"\\vehicle\\skinn_v",
	"\\vehicle\\smith_v",
	"\\vehicle\\sports_v",
	"\\vehicle\\wiggu_v"
}

-- Random Drop Item List
RandomItemPool = {}
RandomItemPool["bonestorm"] = "art\\missions\\level01\\bonebox.p3d"
RandomItemPool["coolr"] = "art\\missions\\level01\\coolr.p3d"
RandomItemPool["flanpic"] = "art\\missions\\level01\\flanpic.p3d"
RandomItemPool["h_soda"] = "art\\missions\\level01\\h_soda.p3d"
RandomItemPool["i_soda"] = "art\\missions\\level01\\i_soda.p3d"
RandomItemPool["icebuck"] = "art\\missions\\level01\\ibucket.p3d"
RandomItemPool["inhaler"] = "art\\missions\\level01\\inhaler.p3d"
RandomItemPool["lwnchair"] = "art\\missions\\level01\\lwnchair.p3d"
RandomItemPool["mower"] = "art\\missions\\level01\\mower.p3d"
RandomItemPool["poster_t"] = "art\\missions\\level01\\poster_t.p3d"
RandomItemPool["scien"] = "art\\missions\\level01\\scien.p3d"
RandomItemPool["tomat"] = "art\\missions\\level01\\tomat.p3d"
RandomItemPool["tux"] = "art\\missions\\level01\\tux.p3d"
RandomItemPool["blend"] = "art\\missions\\level02\\blend.p3d"
RandomItemPool["bloodbag"] = "art\\missions\\level02\\bloodbag.p3d"
RandomItemPool["firewrks"] = "art\\missions\\level02\\firewrks.p3d"
RandomItemPool["i_bldbag"] = "art\\missions\\level02\\i_bldbag.p3d"
RandomItemPool["i_firewk"] = "art\\missions\\level02\\i_firewk.p3d"
RandomItemPool["monkey"] = "art\\missions\\level02\\monkey.p3d"
RandomItemPool["radio"] = "art\\missions\\level02\\radio.p3d"
RandomItemPool["roadkill"] = "art\\missions\\level02\\roadkill.p3d"
RandomItemPool["s_dish"] = "art\\missions\\level02\\satellite.p3d"
RandomItemPool["cream"] = "art\\missions\\level03\\cream.p3d"
RandomItemPool["diaper"] = "art\\missions\\level03\\diaper.p3d"
RandomItemPool["fish"] = "art\\missions\\level03\\fish.p3d"
RandomItemPool["h_soda"] = "art\\missions\\level03\\h_soda.p3d"
RandomItemPool["is_comic"] = "art\\missions\\level03\\is_comic.p3d"
RandomItemPool["jeans"] = "art\\missions\\level03\\jeans.p3d"
RandomItemPool["kmeal"] = "art\\missions\\level03\\kmeal.p3d"
RandomItemPool["laundry"] = "art\\missions\\level03\\laundry.p3d"
RandomItemPool["molemanr"] = "art\\missions\\level03\\molemanr.p3d"
RandomItemPool["rhat"] = "art\\missions\\level03\\rhat.p3d"
RandomItemPool["cola"] = "art\\missions\\level04\\cola.p3d"
RandomItemPool["cpill"] = "art\\missions\\level04\\cpill.p3d"
RandomItemPool["donut"] = "art\\missions\\level04\\donut.p3d"
RandomItemPool["i_cpill"] = "art\\missions\\level04\\i_cpill.p3d"
RandomItemPool["ketchup"] = "art\\missions\\level04\\ketchup.p3d"
RandomItemPool["cpills"] = "art\\missions\\level04\\cpills.p3d"
RandomItemPool["r_choco"] = "art\\missions\\level04\\r_choco.p3d"
RandomItemPool["r_dent"] = "art\\missions\\level04\\r_dent.p3d"
RandomItemPool["r_diaper"] = "art\\missions\\level04\\r_diaper.p3d"
RandomItemPool["r_onions"] = "art\\missions\\level04\\r_onions.p3d"
RandomItemPool["r_tomb"] = "art\\missions\\level04\\r_tomb.p3d"
RandomItemPool["folder"] = "art\\missions\\level05\\folder.p3d"
RandomItemPool["i_folder"] = "art\\missions\\level05\\i_folder.p3d"
RandomItemPool["key"] = "art\\missions\\level05\\key.p3d"
RandomItemPool["litter"] = "art\\missions\\level05\\litter.p3d"
RandomItemPool["laserbox_crate"] = "art\\missions\\level06\\laserbox.p3d"
RandomItemPool["lasergun"] = "art\\missions\\level06\\lasergun.p3d"
RandomItemPool["lasrstnd"] = "art\\missions\\level06\\lasrstnd.p3d"
RandomItemPool["s_boy1"] = "art\\missions\\level06\\s_boy1.p3d"
RandomItemPool["s_boy2"] = "art\\missions\\level06\\s_boy2.p3d"
RandomItemPool["s_girl1"] = "art\\missions\\level06\\s_girl1.p3d"
RandomItemPool["s_girl2"] = "art\\missions\\level06\\s_girl2.p3d"
RandomItemPool["map"] = "art\\missions\\level07\\map.p3d"
RandomItemPool["medkit"] = "art\\missions\\level07\\medkit.p3d"
RandomItemPool["record"] = "art\\missions\\level07\\record.p3d"
RandomItemPool["saw"] = "art\\missions\\level07\\saw.p3d"
RandomItemPool["sockg"] = "art\\missions\\level07\\sockg.p3d"
RandomItemPool["tooth"] = "art\\missions\\level07\\tooth.p3d"
RandomItemPool["wplanks"] = "art\\missions\\level07\\wplanks.p3d"

-- Presentation P3D List
PresentationP3DPool = {
	"mis01_00",
	"mis01_01",
	"mis01_02",
	"mis01_03",
	"mis01_04",
	"mis01_05",
	"mis01_06",
	"mis01_07",
	"mis01_08",
	"mis02_01",
	"mis02_02",
	"mis02_03",
	"mis02_04",
	"mis02_05",
	"mis02_06",
	"mis02_07",
	"mis02_08",
	"mis03_01",
	"mis03_02",
	"mis03_03",
	"mis03_04",
	"mis03_05",
	"mis03_06",
	"mis03_07",
	"mis03_08",
	"mis04_01",
	"mis04_02",
	"mis04_03",
	"mis04_04",
	"mis04_05",
	"mis04_06",
	"mis04_07",
	"mis04_08",
	"mis05_01",
	"mis05_02",
	"mis05_03",
	"mis05_04",
	"mis05_05",
	"mis05_06",
	"mis05_07",
	"mis05_08",
	"mis06_01",
	"mis06_02",
	"mis06_03",
	"mis06_04",
	"mis06_05",
	"mis06_06",
	"mis06_07",
	"mis06_08",
	"mis07_01",
	"mis07_02",
	"mis07_03",
	"mis07_04",
	"mis07_05",
	"mis07_06",
	"mis07_07",
	"mis07_08",
	"misXX_CP",
	"misXX_CT",
	"misXX_GB",
	"misXX_HW",
	"misXX_PS",
	"misXX_TT"
}

RandomDialoguePool = {}

--Level interiors
l1interiors = {
	"00",
	"01",
	"02",
}

l2interiors = {
	"03",
	"04"
}

l3interiors = {
	"05",
	"06"
}

l4interiors = {
	"00",
	"01",
	"07"
}

l5interiors = {
	"03",
	"04"
}

l6interiors = {
	"05",
	"06"
}

l7interiors = {
	"00",
	"01",
	"07"
}

interiorReplace = {}
iconReplace = {}
missionOrder = {}

-- Random Stats Saving
PlayerStats = {}
