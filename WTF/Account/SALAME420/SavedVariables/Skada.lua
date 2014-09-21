
SkadaDB = {
	["namespaces"] = {
		["LibDualSpec-1.0"] = {
		},
	},
	["hasUpgraded"] = true,
	["profileKeys"] = {
		["Dalhian - Skywall"] = "Default",
		["Cidareth - Skywall"] = "Default",
		["Jartzart - Area 52"] = "Switch",
		["Gaulthain - Area 52"] = "Default",
		["Feronis - Skywall"] = "Default",
		["Toradol - Skywall"] = "Default",
		["Drominus - Skywall"] = "Default",
		["Anaiis - Skywall"] = "Default",
		["Oldfero - Area 52"] = "Default",
		["Drominus - Area 52"] = "Default",
		["Feronaz - Area 52"] = "Default",
		["Gaulthain - Skywall"] = "Default",
		["Malkyn - Dragonblight"] = "Default",
		["Gurund - Area 52"] = "Default",
		["Noremedy - Skywall"] = "Default",
		["Cecliann - Skywall"] = "Default",
		["Feronaz - Skywall"] = "Default",
	},
	["profiles"] = {
		["Default"] = {
			["windows"] = {
				{
					["y"] = 176.9999389648438,
					["mode"] = "DPS",
					["point"] = "BOTTOMRIGHT",
					["x"] = -5.0003662109375,
				}, -- [1]
				{
					["titleset"] = true,
					["barheight"] = 15,
					["classicons"] = true,
					["barslocked"] = false,
					["clickthrough"] = false,
					["wipemode"] = "",
					["set"] = "current",
					["hidden"] = true,
					["y"] = -0,
					["barfont"] = "Accidental Presidency",
					["title"] = {
						["color"] = {
							["a"] = 0.8,
							["r"] = 0.1,
							["g"] = 0.1,
							["b"] = 0.3,
						},
						["bordertexture"] = "None",
						["font"] = "Accidental Presidency",
						["borderthickness"] = 2,
						["fontsize"] = 12,
						["fontflags"] = "",
						["height"] = 15,
						["margin"] = -0,
						["texture"] = "VuhDo - Plain",
					},
					["display"] = "bar",
					["barfontflags"] = "",
					["classcolortext"] = false,
					["barbgcolor"] = {
						["a"] = 0.2179481983184815,
						["b"] = 0.2666666666666667,
						["g"] = 0.2666666666666667,
						["r"] = 0.2666666666666667,
					},
					["barcolor"] = {
						["a"] = 1,
						["b"] = 0.02352941176470588,
						["g"] = 0.007843137254901961,
						["r"] = 0.007843137254901961,
					},
					["barfontsize"] = 12,
					["barorientation"] = 1,
					["snapto"] = true,
					["point"] = "BOTTOMRIGHT",
					["x"] = -5.99951171875,
					["buttons"] = {
						["segment"] = true,
						["menu"] = true,
						["mode"] = true,
						["report"] = true,
						["reset"] = true,
					},
					["barwidth"] = 215.9995574951172,
					["barspacing"] = 1,
					["modeincombat"] = "",
					["returnaftercombat"] = false,
					["scale"] = 1,
					["reversegrowth"] = false,
					["background"] = {
						["borderthickness"] = -0,
						["color"] = {
							["a"] = 0.02564108371734619,
							["b"] = 0.2509803921568627,
							["g"] = 0.2196078431372549,
							["r"] = 0.2117647058823529,
						},
						["height"] = 162.9999847412109,
						["bordertexture"] = "None",
						["margin"] = -0,
						["texture"] = "None",
					},
					["classcolorbars"] = true,
					["mode"] = "DPS",
					["enabletitle"] = false,
					["name"] = "Skada",
					["bartexture"] = "VuhDo - Plain",
				}, -- [2]
			},
			["report"] = {
				["mode"] = "Healing",
				["channel"] = "party",
			},
			["columns"] = {
				["Death log_Absorb"] = false,
				["Death log_Percent"] = false,
				["Damage taken_DTPS"] = false,
				["Deaths_Timestamp"] = false,
				["Healed players_Percent"] = false,
				["Healing spell list_Percent"] = false,
				["Healing taken_HPS"] = false,
				["Overhealing_Percent"] = false,
				["Healing_Percent"] = false,
				["Damage spell details_Percent"] = false,
				["Healing_HPS"] = false,
				["Damage_Percent"] = false,
				["Damaged mobs_Percent"] = false,
				["Healing taken_Percent"] = false,
				["Damage spell list_Percent"] = false,
				["Damage taken_Percent"] = false,
			},
		},
		["Switch"] = {
			["windows"] = {
				{
					["y"] = 176.9999389648438,
					["x"] = -5.0003662109375,
					["point"] = "BOTTOMRIGHT",
					["mode"] = "DPS",
				}, -- [1]
				{
					["titleset"] = true,
					["barheight"] = 15,
					["classicons"] = true,
					["barslocked"] = false,
					["enabletitle"] = false,
					["wipemode"] = "",
					["set"] = "current",
					["hidden"] = true,
					["y"] = -0,
					["barfont"] = "Accidental Presidency",
					["title"] = {
						["color"] = {
							["a"] = 0.8,
							["b"] = 0.3,
							["g"] = 0.1,
							["r"] = 0.1,
						},
						["bordertexture"] = "None",
						["font"] = "Accidental Presidency",
						["fontsize"] = 12,
						["borderthickness"] = 2,
						["height"] = 15,
						["fontflags"] = "",
						["margin"] = -0,
						["texture"] = "VuhDo - Plain",
					},
					["display"] = "bar",
					["barfontflags"] = "",
					["classcolortext"] = false,
					["scale"] = 1,
					["reversegrowth"] = false,
					["barfontsize"] = 12,
					["barorientation"] = 1,
					["snapto"] = true,
					["background"] = {
						["borderthickness"] = -0,
						["color"] = {
							["a"] = 0.02564108371734619,
							["r"] = 0.2117647058823529,
							["g"] = 0.2196078431372549,
							["b"] = 0.2509803921568627,
						},
						["height"] = 162.9999847412109,
						["bordertexture"] = "None",
						["margin"] = -0,
						["texture"] = "None",
					},
					["buttons"] = {
						["report"] = true,
						["menu"] = true,
						["mode"] = true,
						["segment"] = true,
						["reset"] = true,
					},
					["bartexture"] = "VuhDo - Plain",
					["barwidth"] = 215.9995574951172,
					["barspacing"] = 1,
					["name"] = "Skada",
					["clickthrough"] = false,
					["barbgcolor"] = {
						["a"] = 0.2179481983184815,
						["r"] = 0.2666666666666667,
						["g"] = 0.2666666666666667,
						["b"] = 0.2666666666666667,
					},
					["barcolor"] = {
						["a"] = 1,
						["r"] = 0.007843137254901961,
						["g"] = 0.007843137254901961,
						["b"] = 0.02352941176470588,
					},
					["mode"] = "DPS",
					["classcolorbars"] = true,
					["returnaftercombat"] = false,
					["modeincombat"] = "",
					["x"] = -5.99951171875,
					["point"] = "BOTTOMRIGHT",
				}, -- [2]
			},
			["columns"] = {
				["Damage taken_Percent"] = false,
				["Death log_Percent"] = false,
				["Damage taken_DTPS"] = false,
				["Deaths_Timestamp"] = false,
				["Healed players_Percent"] = false,
				["Healing_HPS"] = false,
				["Healing taken_HPS"] = false,
				["Healing taken_Percent"] = false,
				["Healing_Percent"] = false,
				["Damaged mobs_Percent"] = false,
				["Healing spell list_Percent"] = false,
				["Damage_Percent"] = false,
				["Damage spell details_Percent"] = false,
				["Overhealing_Percent"] = false,
				["Damage spell list_Percent"] = false,
				["Death log_Absorb"] = false,
			},
			["report"] = {
				["channel"] = "party",
				["mode"] = "Healing",
			},
		},
	},
}
