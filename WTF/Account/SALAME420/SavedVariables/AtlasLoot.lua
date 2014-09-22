
AtlasLootDB = {
	["namespaces"] = {
		["WishList"] = {
		},
		["AtlasLootPanel"] = {
		},
		["DefaultFrame"] = {
			["profiles"] = {
				["Anaiis - Skywall"] = {
					["NEWpoint"] = {
						"RIGHT", -- [1]
						nil, -- [2]
						"RIGHT", -- [3]
						-100.5002517700195, -- [4]
						100.9999771118164, -- [5]
					},
				},
				["Oldfero - Area 52"] = {
					["instance"] = "SiegeofOrgrimmar",
					["NEWpoint"] = {
						"TOPRIGHT", -- [1]
						nil, -- [2]
						"TOPRIGHT", -- [3]
						-8.000759124755859, -- [4]
						-22.99943161010742, -- [5]
					},
					["module"] = "AtlasLootMoP",
				},
				["Dalhian - Skywall"] = {
					["instance"] = "SiegeofOrgrimmar",
					["module"] = "AtlasLootMoP",
				},
				["Drominus - Area 52"] = {
					["module"] = "AtlasLootMoP",
					["NEWpoint"] = {
						"RIGHT", -- [1]
						nil, -- [2]
						"RIGHT", -- [3]
						-40.50015258789063, -- [4]
						19.99993896484375, -- [5]
					},
					["instance"] = "SiegeofOrgrimmar",
				},
				["Gaulthain - Skywall"] = {
					["instance"] = "SiegeofOrgrimmar",
					["NEWpoint"] = {
						"TOP", -- [1]
						nil, -- [2]
						"TOP", -- [3]
						-3.500643968582153, -- [4]
						0, -- [5]
					},
					["DefaultFrameLocked"] = true,
					["module"] = "AtlasLootMoP",
				},
				["Feronaz - Area 52"] = {
					["instance"] = "BlackTemple",
					["NEWpoint"] = {
						nil, -- [1]
						nil, -- [2]
						"CENTER", -- [3]
						-6.747709267074242e-005, -- [4]
						0, -- [5]
					},
					["module"] = "AtlasLootBurningCrusade",
				},
				["Gurund - Area 52"] = {
					["instance"] = "Firelands",
				},
				["Noremedy - Skywall"] = {
					["module"] = "AtlasLootMoP",
					["NEWpoint"] = {
						"RIGHT", -- [1]
						nil, -- [2]
						"RIGHT", -- [3]
						-58.50034713745117, -- [4]
						43.99991989135742, -- [5]
					},
					["instance"] = "SiegeofOrgrimmar",
				},
				["Drominus - Skywall"] = {
					["instance"] = "ThroneofThunder",
					["NEWpoint"] = {
						"TOPRIGHT", -- [1]
						nil, -- [2]
						"TOPRIGHT", -- [3]
						-10.50037956237793, -- [4]
						-15.50016307830811, -- [5]
					},
					["module"] = "AtlasLootMoP",
				},
				["Feronaz - Skywall"] = {
					["module"] = "AtlasLootMoP",
					["instance"] = "SiegeofOrgrimmar",
				},
			},
		},
		["Filter"] = {
			["profiles"] = {
				["Drominus - Area 52"] = {
					["filterSlots"] = {
						["Stats"] = {
							["SPIRIT"] = false,
							["SPELL_POWER"] = false,
							["AGILITY"] = false,
							["INTELLECT"] = false,
						},
						["Armor"] = {
							["#a3#"] = false,
							["#a2#"] = false,
							["#a1#"] = false,
						},
						["WeaponsMeele"] = {
							["#w13#"] = false,
							["#w4#"] = false,
							["#w9#"] = false,
							["#w8#"] = false,
						},
						["WeaponsRanged"] = {
							["#w3#"] = false,
							["#w2#"] = false,
							["#w5#"] = false,
							["#w12#"] = false,
						},
					},
					["enable"] = true,
				},
				["Oldfero - Area 52"] = {
					["enable"] = true,
					["filterSlots"] = {
						["Stats"] = {
							["SPIRIT"] = false,
							["DODGE_RATING"] = false,
							["EXPERTISE_RATING"] = false,
							["PARRY_RATING"] = false,
							["AGILITY"] = false,
							["STRENGTH"] = false,
						},
						["Armor"] = {
							["#a3#"] = false,
							["#a2#"] = false,
							["#a4#"] = false,
						},
						["WeaponsMeeleTwoHand"] = {
							["#w6#"] = false,
							["#w1#"] = false,
							["#w10#"] = false,
						},
						["WeaponsMeele"] = {
							["#w13#"] = false,
							["#w1#"] = false,
							["#w8#"] = false,
							["#w7#"] = false,
							["#w6#"] = false,
						},
						["WeaponsRanged"] = {
							["#w3#"] = false,
							["#w2#"] = false,
							["#w5#"] = false,
						},
					},
				},
			},
		},
	},
	["profileKeys"] = {
		["Anaiis - Skywall"] = "Anaiis - Skywall",
		["Oldfero - Area 52"] = "Oldfero - Area 52",
		["Dalhian - Skywall"] = "Dalhian - Skywall",
		["Drominus - Area 52"] = "Drominus - Area 52",
		["Gaulthain - Skywall"] = "Gaulthain - Skywall",
		["Feronaz - Area 52"] = "Feronaz - Area 52",
		["Gurund - Area 52"] = "Gurund - Area 52",
		["Drominus - Skywall"] = "Drominus - Skywall",
		["Noremedy - Skywall"] = "Noremedy - Skywall",
		["Feronaz - Skywall"] = "Feronaz - Skywall",
	},
	["showWarning"] = true,
	["profiles"] = {
		["Anaiis - Skywall"] = {
		},
		["Oldfero - Area 52"] = {
		},
		["Dalhian - Skywall"] = {
			["LootTableType"] = "RaidFinder",
		},
		["Drominus - Area 52"] = {
			["LastSearch"] = "sorrowpath",
			["LootTableType"] = "Flexible",
			["QuickLooks"] = {
				{
					["module"] = "AtlasLootMoP",
					["lootPageType"] = "Flexible",
					["lootPage"] = "SoOIronJuggernaut",
					["savedName"] = "QuickLook 1",
				}, -- [1]
			},
		},
		["Gaulthain - Skywall"] = {
			["HidePanel"] = true,
			["LootTableType"] = "RaidFinder",
		},
		["Feronaz - Area 52"] = {
			["LootTableType"] = "RaidFinder",
		},
		["Gurund - Area 52"] = {
		},
		["Drominus - Skywall"] = {
			["LootTableType"] = "Flexible",
			["SearchModule"] = {
				["AtlasLootClassicWoW"] = false,
				["AtlasLootWotLK"] = false,
				["AtlasLootCataclysm"] = false,
				["AtlasLootBurningCrusade"] = false,
			},
			["LastSearch"] = "skeer",
		},
		["Noremedy - Skywall"] = {
			["LootTableType"] = "Flexible",
		},
		["Feronaz - Skywall"] = {
			["LootTableType"] = "Flexible",
		},
	},
}
