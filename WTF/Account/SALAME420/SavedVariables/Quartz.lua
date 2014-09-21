
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
		["Player"] = {
			["profiles"] = {
				["Default"] = {
					["h"] = 30,
					["targetname"] = true,
					["w"] = 270,
					["hideicon"] = true,
					["font"] = "Accidental Presidency",
					["border"] = "None",
					["fontsize"] = 16,
					["y"] = 254.9999847412109,
					["texture"] = "VuhDo - Plain",
					["timefontsize"] = 16,
					["x"] = 825.0006103515625,
				},
				["Switch"] = {
					["targetname"] = true,
					["w"] = 270,
					["x"] = 822.9998168945313,
					["hideicon"] = true,
					["h"] = 26,
					["fontsize"] = 16,
					["y"] = 179.9999542236328,
					["font"] = "Accidental Presidency",
					["timefontsize"] = 16,
					["border"] = "None",
					["texture"] = "VuhDo - Plain",
				},
			},
		},
		["EnemyCasts"] = {
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
					["x"] = 825.0003051757813,
					["iconposition"] = "left",
					["border"] = "None",
					["texture"] = "VuhDo - Plain",
					["y"] = 234.0000457763672,
					["timefontsize"] = 16,
					["font"] = "Cabin",
				},
				["Switch"] = {
					["w"] = 270,
					["texture"] = "VuhDo - Plain",
					["y"] = 159.9999237060547,
					["x"] = 820.9998779296875,
					["border"] = "None",
					["hideicon"] = true,
					["h"] = 16,
					["timefontsize"] = 16,
					["font"] = "Cabin",
					["iconposition"] = "left",
				},
			},
		},
		["Mirror"] = {
			["profiles"] = {
				["Default"] = {
					["mirroranchor"] = "free",
					["mirrory"] = 961.9996948242188,
					["mirrorgrowdirection"] = "down",
					["mirrorheight"] = 20,
					["mirrortexture"] = "VuhDo - Plain",
					["mirrorfont"] = "Accidental Presidency",
					["mirrorx"] = 878.0000610351563,
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
		["Jartzart - Area 52"] = "Switch",
		["Feronaz - Area 52"] = "Default",
		["Drominus - Area 52"] = "Default",
		["Oldfero - Area 52"] = "Default",
	},
	["profiles"] = {
		["Default"] = {
			["channelingcolor"] = {
				0.0392156862745098, -- [1]
				0.03529411764705882, -- [2]
				0.1176470588235294, -- [3]
				1, -- [4]
			},
			["borderalpha"] = 0,
			["completecolor"] = {
				0.00392156862745098, -- [1]
				0.03137254901960784, -- [2]
				0.00392156862745098, -- [3]
				1, -- [4]
			},
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
				["Swing"] = false,
				["GCD"] = false,
				["Buff"] = false,
				["Timer"] = false,
				["Pet"] = false,
				["Focus"] = false,
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
			["castingcolor"] = {
				0.02352941176470588, -- [1]
				0.01176470588235294, -- [2]
				nil, -- [3]
				1, -- [4]
			},
			["backgroundalpha"] = 0.28,
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
