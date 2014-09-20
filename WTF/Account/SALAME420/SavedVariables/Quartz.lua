
Quartz3DB = {
	["namespaces"] = {
		["Swing"] = {
		},
		["Buff"] = {
		},
		["Interrupt"] = {
			["profiles"] = {
				["Default"] = {
					["interruptcolor"] = {
						0.1568627450980392, -- [1]
						0.1568627450980392, -- [2]
						0.1568627450980392, -- [3]
						1, -- [4]
					},
				},
				["Switch"] = {
					["interruptcolor"] = {
						0.1568627450980392, -- [1]
						0.1568627450980392, -- [2]
						0.1568627450980392, -- [3]
						1, -- [4]
					},
				},
			},
		},
		["Flight"] = {
			["profiles"] = {
				["Default"] = {
					["deplete"] = true,
				},
				["Switch"] = {
					["deplete"] = true,
				},
			},
		},
		["Pet"] = {
			["profiles"] = {
				["Default"] = {
					["x"] = 860.0000610351563,
				},
				["Switch"] = {
					["x"] = 860.0000610351563,
				},
			},
		},
		["EnemyCasts"] = {
		},
		["Player"] = {
			["profiles"] = {
				["Default"] = {
					["h"] = 26,
					["targetname"] = true,
					["w"] = 270,
					["y"] = 179.9999542236328,
					["font"] = "Accidental Presidency",
					["border"] = "None",
					["fontsize"] = 16,
					["hideicon"] = true,
					["texture"] = "VuhDo - Plain",
					["timefontsize"] = 16,
					["x"] = 822.9998168945313,
				},
				["Switch"] = {
					["targetname"] = true,
					["w"] = 270,
					["h"] = 26,
					["hideicon"] = true,
					["x"] = 822.9998168945313,
					["fontsize"] = 16,
					["border"] = "None",
					["font"] = "Accidental Presidency",
					["timefontsize"] = 16,
					["y"] = 179.9999542236328,
					["texture"] = "VuhDo - Plain",
				},
			},
		},
		["GCD"] = {
		},
		["Focus"] = {
			["profiles"] = {
				["Default"] = {
					["x"] = 860.0000610351563,
				},
				["Switch"] = {
					["x"] = 860.0000610351563,
				},
			},
		},
		["Target"] = {
			["profiles"] = {
				["Default"] = {
					["h"] = 16,
					["w"] = 270,
					["hideicon"] = true,
					["x"] = 820.9998779296875,
					["iconposition"] = "left",
					["border"] = "None",
					["texture"] = "VuhDo - Plain",
					["y"] = 159.9999237060547,
					["timefontsize"] = 16,
					["font"] = "Cabin",
				},
				["Switch"] = {
					["w"] = 270,
					["iconposition"] = "left",
					["y"] = 159.9999237060547,
					["x"] = 820.9998779296875,
					["font"] = "Cabin",
					["hideicon"] = true,
					["h"] = 16,
					["timefontsize"] = 16,
					["border"] = "None",
					["texture"] = "VuhDo - Plain",
				},
			},
		},
		["Range"] = {
			["profiles"] = {
				["Default"] = {
					["rangecolor"] = {
						0.196078431372549, -- [1]
						0.196078431372549, -- [2]
						0.196078431372549, -- [3]
						1, -- [4]
					},
				},
				["Switch"] = {
					["rangecolor"] = {
						0.196078431372549, -- [1]
						0.196078431372549, -- [2]
						0.196078431372549, -- [3]
						1, -- [4]
					},
				},
			},
		},
		["Mirror"] = {
			["profiles"] = {
				["Default"] = {
					["mirroranchor"] = "free",
					["mirrory"] = 1020,
					["mirrorgrowdirection"] = "down",
					["mirrorheight"] = 20,
					["mirrortexture"] = "VuhDo - Plain",
					["mirrorfont"] = "Accidental Presidency",
					["mirrorx"] = 878,
					["mirrorwidth"] = 188,
					["mirrorfontsize"] = 14,
				},
				["Switch"] = {
					["mirrorwidth"] = 188,
					["mirrorheight"] = 20,
					["mirrortexture"] = "VuhDo - Plain",
					["mirrorfont"] = "Accidental Presidency",
					["mirrory"] = 1020,
					["mirroranchor"] = "free",
					["mirrorx"] = 878,
					["mirrorgrowdirection"] = "down",
					["mirrorfontsize"] = 14,
				},
			},
		},
		["Latency"] = {
			["profiles"] = {
				["Default"] = {
					["lagtext"] = false,
					["lagcolor"] = {
						0.3019607843137255, -- [1]
						0.2941176470588235, -- [2]
						0.3137254901960784, -- [3]
						1, -- [4]
					},
					["lagembed"] = true,
				},
				["Switch"] = {
					["lagcolor"] = {
						0.3019607843137255, -- [1]
						0.2941176470588235, -- [2]
						0.3137254901960784, -- [3]
						1, -- [4]
					},
					["lagtext"] = false,
					["lagembed"] = true,
				},
			},
		},
	},
	["profileKeys"] = {
		["Oldfero - Area 52"] = "Default",
		["Feronaz - Area 52"] = "Default",
		["Drominus - Area 52"] = "Default",
		["Jartzart - Area 52"] = "Switch",
	},
	["profiles"] = {
		["Default"] = {
			["channelingcolor"] = {
				0.0392156862745098, -- [1]
				0.03529411764705882, -- [2]
				0.1176470588235294, -- [3]
				1, -- [4]
			},
			["completecolor"] = {
				0.00392156862745098, -- [1]
				0.03137254901960784, -- [2]
				0.00392156862745098, -- [3]
				1, -- [4]
			},
			["borderalpha"] = 0,
			["backgroundcolor"] = {
				nil, -- [1]
				nil, -- [2]
				nil, -- [3]
				1, -- [4]
			},
			["failcolor"] = {
				0.2666666666666667, -- [1]
				0.2588235294117647, -- [2]
				0.2666666666666667, -- [3]
				1, -- [4]
			},
			["modules"] = {
				["GCD"] = false,
				["Buff"] = false,
				["Timer"] = false,
				["Focus"] = false,
				["Pet"] = false,
				["Swing"] = false,
			},
			["castingcolor"] = {
				0.02352941176470588, -- [1]
				0.01176470588235294, -- [2]
				nil, -- [3]
				1, -- [4]
			},
			["backgroundalpha"] = 0.28,
		},
		["Switch"] = {
			["channelingcolor"] = {
				0.0392156862745098, -- [1]
				0.03529411764705882, -- [2]
				0.1176470588235294, -- [3]
				1, -- [4]
			},
			["backgroundalpha"] = 0.28,
			["castingcolor"] = {
				0.02352941176470588, -- [1]
				0.01176470588235294, -- [2]
				nil, -- [3]
				1, -- [4]
			},
			["completecolor"] = {
				0.00392156862745098, -- [1]
				0.03137254901960784, -- [2]
				0.00392156862745098, -- [3]
				1, -- [4]
			},
			["modules"] = {
				["Swing"] = false,
				["GCD"] = false,
				["Buff"] = false,
				["Timer"] = false,
				["Pet"] = false,
				["Focus"] = false,
			},
			["borderalpha"] = 0,
			["backgroundcolor"] = {
				nil, -- [1]
				nil, -- [2]
				nil, -- [3]
				1, -- [4]
			},
			["failcolor"] = {
				0.2666666666666667, -- [1]
				0.2588235294117647, -- [2]
				0.2666666666666667, -- [3]
				1, -- [4]
			},
		},
	},
}
