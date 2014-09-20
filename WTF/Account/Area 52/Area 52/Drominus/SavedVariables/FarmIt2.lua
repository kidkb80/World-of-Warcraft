
FI_SVPC_CONFIG = {
	["show"] = true,
	["Currency"] = {
		["show"] = true,
		["scale"] = 1,
		["alpha"] = 1,
		["tracking"] = true,
	},
	["version"] = 2.29,
	["scale"] = 0.82,
	["move"] = true,
	["alpha"] = 1,
	["style"] = "default",
}
FI_SVPC_STYLE = {
	["anchor"] = {
		["pad"] = 0,
		["background"] = {
			["color"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
			},
			["size"] = {
				34, -- [1]
				32, -- [2]
			},
			["alpha"] = 0.5,
			["texture"] = {
				"Interface/Tooltips/UI-Tooltip-Background", -- [1]
			},
		},
		["text"] = {
			["flags"] = "",
			["font"] = "Fonts/ARIALN.TTF",
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
			},
			["alpha"] = 1,
			["size"] = 13,
		},
		["border"] = {
			["offset"] = 2,
			["tile"] = true,
			["color"] = {
			},
			["size"] = 6,
			["alpha"] = 0.9,
			["texture"] = "Interface/Tooltips/UI-Tooltip-Border",
		},
		["size"] = {
			34, -- [1]
			34, -- [2]
		},
	},
	["button"] = {
		["number"] = {
			["flags"] = "OUTLINE",
			["font"] = "Fonts/ARIALN.TTF",
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
			},
			["alpha"] = 1,
			["size"] = 14,
		},
		["glow"] = {
			["color"] = {
				1, -- [1]
				1, -- [2]
				0, -- [3]
			},
			["alpha"] = 0.5,
			["texture"] = "Interface/CHATFRAME/CHATFRAMEBACKGROUND",
		},
		["pad"] = 4,
		["icon"] = {
			["color"] = {
			},
			["alpha"] = 1,
			["texture"] = "",
		},
		["text"] = {
			["flags"] = "OUTLINE",
			["font"] = "Fonts/FRIZQT__.TTF",
			["color"] = {
				0.5, -- [1]
				0.5, -- [2]
				0.5, -- [3]
			},
			["alpha"] = 0.75,
			["size"] = 28,
		},
		["background"] = {
			["color"] = {
			},
			["size"] = {
				36, -- [1]
				36, -- [2]
			},
			["alpha"] = 0.66,
			["texture"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
			},
		},
		["border"] = {
			["offset"] = 2,
			["tile"] = true,
			["color"] = {
			},
			["size"] = 6,
			["alpha"] = 0.9,
			["texture"] = "Interface/Tooltips/UI-Tooltip-Border",
		},
		["size"] = {
			37, -- [1]
			37, -- [2]
		},
	},
}
FI_SVPC_DATA = {
	["Sessions"] = {
		{
			["id"] = 1,
			["stop"] = 1403871517,
			["start"] = 1403867218,
		}, -- [1]
		{
			["id"] = 2,
			["stop"] = 1403889031,
			["start"] = 1403878061,
		}, -- [2]
		{
			["id"] = 3,
			["stop"] = 1403889973,
			["start"] = 1403889155,
		}, -- [3]
		{
			["id"] = 4,
			["stop"] = 1403902612,
			["start"] = 1403890011,
		}, -- [4]
		{
			["id"] = 5,
			["stop"] = 1403906157,
			["start"] = 1403903137,
		}, -- [5]
		{
			["id"] = 6,
			["stop"] = 1403917960,
			["start"] = 1403908843,
		}, -- [6]
		{
			["id"] = 7,
			["stop"] = 1403925151,
			["start"] = 1403919363,
		}, -- [7]
		{
			["id"] = 8,
			["stop"] = 1403928221,
			["start"] = 1403925629,
		}, -- [8]
	},
	["Currencies"] = {
		{
			["name"] = "",
			["count"] = 0,
			["objective"] = 0,
			["id"] = 1,
			["lastcount"] = 0,
			["icon"] = "",
			["success"] = true,
		}, -- [1]
		{
			["name"] = "",
			["count"] = 0,
			["objective"] = 0,
			["id"] = 2,
			["lastcount"] = 0,
			["icon"] = "",
			["success"] = true,
		}, -- [2]
		{
			["name"] = "",
			["count"] = 0,
			["objective"] = 0,
			["id"] = 3,
			["lastcount"] = 0,
			["icon"] = "",
			["success"] = true,
		}, -- [3]
	},
	["Groups"] = {
		{
			["show"] = true,
			["grow"] = "R",
			["move"] = false,
			["id"] = 1,
			["scale"] = 1,
			["pad"] = 5,
			["alpha"] = 1,
			["size"] = 7,
		}, -- [1]
	},
	["Buttons"] = {
		{
			["objective"] = 0,
			["success"] = false,
			["count"] = 433,
			["id"] = 1,
			["group"] = 1,
			["lastcount"] = 427,
			["item"] = 36909,
			["bank"] = false,
		}, -- [1]
		{
			["count"] = 152,
			["objective"] = 0,
			["item"] = 36912,
			["group"] = 1,
			["lastcount"] = 148,
			["id"] = 2,
			["success"] = false,
			["bank"] = false,
		}, -- [2]
		{
			["count"] = 52,
			["objective"] = 0,
			["item"] = 36907,
			["group"] = 1,
			["lastcount"] = 49,
			["id"] = 3,
			["success"] = false,
			["bank"] = false,
		}, -- [3]
		{
			["count"] = 48,
			["objective"] = 0,
			["item"] = 36901,
			["group"] = 1,
			["lastcount"] = 0,
			["id"] = 4,
			["success"] = false,
			["bank"] = false,
		}, -- [4]
		{
			["count"] = 18,
			["objective"] = 0,
			["item"] = 36904,
			["group"] = 1,
			["lastcount"] = 0,
			["id"] = 5,
			["success"] = false,
			["bank"] = false,
		}, -- [5]
		{
			["count"] = 61,
			["objective"] = 0,
			["item"] = 36906,
			["group"] = 1,
			["lastcount"] = 54,
			["id"] = 6,
			["success"] = false,
			["bank"] = false,
		}, -- [6]
		{
			["count"] = 55,
			["objective"] = 0,
			["item"] = 36905,
			["group"] = 1,
			["lastcount"] = 53,
			["id"] = 7,
			["success"] = false,
			["bank"] = false,
		}, -- [7]
		{
			["count"] = 0,
			["objective"] = 0,
			["item"] = false,
			["group"] = 1,
			["lastcount"] = 0,
			["id"] = 8,
			["success"] = false,
			["bank"] = false,
		}, -- [8]
		{
			["count"] = 0,
			["objective"] = 0,
			["item"] = false,
			["group"] = 1,
			["lastcount"] = 0,
			["id"] = 9,
			["success"] = false,
			["bank"] = false,
		}, -- [9]
		{
			["count"] = 0,
			["objective"] = 0,
			["item"] = false,
			["group"] = 1,
			["lastcount"] = 0,
			["id"] = 10,
			["success"] = false,
			["bank"] = false,
		}, -- [10]
	},
}
FI_SVPC_CACHE = {
	["Currencies"] = {
	},
}
