
ElvDB = {
	["profileKeys"] = {
		["Dalhian - Skywall"] = "Feronis - Skywall",
		["Drominus - Area 52"] = "Feronis - Skywall",
		["Gaulthain - Skywall"] = "Feronis - Skywall",
		["Feronis - Skywall"] = "Feronis - Skywall",
		["Gurund - Area 52"] = "Feronis - Skywall",
		["Drominus - Skywall"] = "Feronis - Skywall",
		["Olegregg - Area 52"] = "Feronis - Skywall",
		["Anaiis - Skywall"] = "Feronis - Skywall",
		["Oldfero - Area 52"] = "Feronis - Skywall",
		["Gurund - Skywall"] = "Gurund - Skywall",
		["Cidareth - Skywall"] = "Cidareth - Skywall",
		["Feronaz - Area 52"] = "Feronis - Skywall",
		["Noremedy - Skywall"] = "Feronis - Skywall",
		["Toradol - Skywall"] = "Feronis - Skywall",
		["Gaulthain - Area 52"] = "Gaulthain - Area 52",
		["Malkyn - Dragonblight"] = "Malkyn - Dragonblight",
		["Cecliann - Skywall"] = "Cecliann - Skywall",
		["Feronaz - Skywall"] = "Default",
	},
	["gold"] = {
		["Dragonblight"] = {
			["Malkyn"] = 1433952,
		},
		["Area 52"] = {
			["Gaulthain"] = 83178270,
			["Oldfero"] = 20004002,
			["Olegregg"] = 2884,
			["Gurund"] = 10172243,
			["Drominus"] = 22616523,
			["Feronaz"] = 1824464,
		},
		["Skywall"] = {
			["Anaiis"] = 786930,
			["Feronis"] = 456591,
			["Toradol"] = 1052503,
			["Cidareth"] = 214351,
			["Dalhian"] = 764099,
			["Gaulthain"] = 83178270,
			["Noremedy"] = 24528656,
			["Cecliann"] = 2,
			["Feronaz"] = 2408595,
			["Drominus"] = 12935612,
			["Gurund"] = 580,
		},
	},
	["namespaces"] = {
		["LibDualSpec-1.0"] = {
			["char"] = {
				["Gaulthain - Skywall"] = {
					["profile"] = "Feronis - Skywall",
					["talentGroup"] = 2,
					["enabled"] = true,
				},
				["Feronaz - Area 52"] = {
					["profile"] = "Feronis - Skywall",
					["specGroup"] = 1,
					["talentGroup"] = 1,
					["enabled"] = false,
				},
				["Oldfero - Area 52"] = {
					["profile"] = "Feronis - Skywall",
					["specGroup"] = 2,
					["talentGroup"] = 2,
					["enabled"] = true,
				},
				["Noremedy - Skywall"] = {
					["profile"] = "Feronis - Skywall",
					["enabled"] = false,
					["talentGroup"] = 1,
					["specGroup"] = 1,
				},
			},
		},
	},
	["profiles"] = {
		["MAGE"] = {
			["bui"] = {
				["installed"] = true,
			},
			["currentTutorial"] = 1,
			["general"] = {
				["valuecolor"] = {
					["b"] = 0.45,
					["g"] = 0.83,
					["r"] = 0.67,
				},
				["bordercolor"] = {
					["b"] = 0.31,
					["g"] = 0.31,
					["r"] = 0.31,
				},
				["autoRepair"] = "PLAYER",
				["minimap"] = {
					["size"] = 192,
				},
			},
			["movers"] = {
				["LossControlMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT431471",
				["ElvUF_PlayerCastbarMover"] = "BOTTOMElvUIParentBOTTOM068",
				["ElvAB_1"] = "BOTTOMElvUIParentBOTTOM026",
				["ElvAB_2"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-4219",
				["GMMover"] = "TOPLEFTElvUIParentTOPLEFT4-4",
				["BuffsMover"] = "TOPRIGHTElvUIParentTOPRIGHT-232-4",
				["AltPowerBarMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT418255",
				["BossButton"] = "BOTTOMElvUIParentBOTTOM0195",
				["ElvAB_5"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT50022",
				["BNETMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT4186",
				["ElvAB_6"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-4183",
				["TooltipMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-477",
				["ElvUF_TargetTargetMover"] = "BOTTOMElvUIParentBOTTOM0110",
				["ElvUF_PetMover"] = "BOTTOMElvUIParentBOTTOM0150",
				["ElvAB_3"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-49923",
				["ElvUF_PlayerMover"] = "BOTTOMElvUIParentBOTTOM-285142",
				["AlertFrameMover"] = "TOPRIGHTElvUIParentTOPRIGHT-509-197",
				["DebuffsMover"] = "TOPRIGHTElvUIParentTOPRIGHT-233-147",
				["ElvUF_TargetMover"] = "BOTTOMElvUIParentBOTTOM282132",
			},
			["hideTutorial"] = 1,
			["unitframe"] = {
				["colors"] = {
					["auraBarBuff"] = {
						["b"] = 0.94,
						["g"] = 0.8,
						["r"] = 0.41,
					},
					["castClassColor"] = true,
					["healthclass"] = true,
				},
				["units"] = {
					["boss"] = {
						["castbar"] = {
							["height"] = 5.999995231628418,
							["width"] = 0,
						},
					},
					["focus"] = {
						["castbar"] = {
							["height"] = 5.999995231628418,
							["width"] = 189.9999694824219,
						},
					},
					["target"] = {
						["castbar"] = {
							["height"] = 9.000010490417481,
							["width"] = 225.0000762939453,
						},
						["portrait"] = {
							["enable"] = true,
						},
						["aurabar"] = {
							["enable"] = false,
						},
					},
					["arena"] = {
						["castbar"] = {
							["height"] = 5.999995231628418,
							["width"] = 193,
						},
					},
					["player"] = {
						["debuffs"] = {
							["attachTo"] = "BUFFS",
						},
						["portrait"] = {
							["enable"] = true,
						},
						["castbar"] = {
							["height"] = 9.000010490417481,
							["width"] = 225,
						},
						["buffs"] = {
							["enable"] = true,
							["attachTo"] = "FRAME",
							["noDuration"] = false,
						},
						["aurabar"] = {
							["enable"] = false,
						},
					},
				},
			},
			["datatexts"] = {
				["actionbar1"] = true,
				["actionbar5"] = true,
				["panels"] = {
					["LeftMiniPanel"] = "Time",
					["RightMiniPanel"] = "System",
					["RightChatDataPanel"] = {
						["left"] = "Durability",
						["middle"] = "Bags",
					},
					["Actionbar1DataPanel"] = {
						["left"] = "",
						["right"] = "",
					},
					["LeftChatDataPanel"] = {
						["right"] = "Friends",
						["left"] = "",
						["middle"] = "Guild",
					},
					["Actionbar5DataPanel"] = "Combat/Arena Time",
				},
				["actionbar3"] = true,
			},
			["actionbar"] = {
				["bar1"] = {
					["buttonsize"] = 36,
				},
				["bar6"] = {
					["enabled"] = true,
				},
			},
			["layoutSet"] = "dpsCaster",
		},
		["Cidareth - Skywall"] = {
		},
		["Gaulthain - Area 52"] = {
			["currentTutorial"] = 1,
			["unitframe"] = {
				["units"] = {
					["boss"] = {
						["castbar"] = {
							["height"] = 0,
							["width"] = 0,
						},
					},
					["focus"] = {
						["castbar"] = {
							["height"] = 5.999995231628418,
							["width"] = 189.9999694824219,
						},
					},
					["target"] = {
						["castbar"] = {
							["height"] = 8.999998092651367,
						},
					},
					["arena"] = {
						["castbar"] = {
							["height"] = 5.999995231628418,
							["width"] = 193,
						},
					},
					["player"] = {
						["castbar"] = {
							["width"] = 410,
						},
					},
				},
			},
			["CBPO"] = {
				["player"] = {
					["overlay"] = false,
				},
			},
		},
		["Gaulthain"] = {
			["unitframe"] = {
				["units"] = {
					["boss"] = {
						["castbar"] = {
							["height"] = 5.999995231628418,
							["width"] = 0,
						},
					},
					["focus"] = {
						["castbar"] = {
							["height"] = 5.999995231628418,
							["width"] = 189.9999694824219,
						},
					},
					["target"] = {
						["castbar"] = {
							["height"] = 8.999998092651367,
						},
					},
					["arena"] = {
						["castbar"] = {
							["height"] = 5.999995231628418,
							["width"] = 193,
						},
					},
					["player"] = {
						["castbar"] = {
							["height"] = 8.999998092651367,
							["width"] = 269.9999694824219,
						},
					},
				},
			},
		},
		["Feronis - Skywall"] = {
			["nameplate"] = {
				["debuffs"] = {
					["font"] = "2002 Bold",
				},
				["fontOutline"] = "OUTLINE",
				["healthBar"] = {
					["text"] = {
						["enable"] = true,
						["format"] = "CURRENT_MAX_PERCENT",
					},
					["lowHPScale"] = {
						["enable"] = true,
					},
				},
				["font"] = "2002 Bold",
				["buffs"] = {
					["font"] = "2002 Bold",
				},
			},
			["utils"] = {
				["enableTokens"] = false,
				["enableSystem"] = false,
			},
			["general"] = {
				["totems"] = {
					["spacing"] = 6,
					["size"] = 36,
					["growthDirection"] = "HORIZONTAL",
				},
				["mapAlpha"] = 0.78,
				["backdropfadecolor"] = {
					["r"] = 0.08627450980392157,
					["g"] = 0.1098039215686275,
					["b"] = 0.1490196078431373,
				},
				["valuecolor"] = {
					["a"] = 1,
					["r"] = 1,
					["g"] = 0.5,
					["b"] = 0,
				},
				["loginmessage"] = false,
				["stickyFrames"] = false,
				["topPanel"] = false,
				["disconnected"] = {
				},
				["tapped"] = {
				},
				["experience"] = {
					["textFormat"] = "CURPERC",
					["width"] = 412,
				},
				["RAGE"] = {
				},
				["FOCUS"] = {
				},
				["minimap"] = {
					["size"] = 236,
				},
				["health_backdrop"] = {
				},
				["bottomPanel"] = false,
				["ENERGY"] = {
				},
				["MANA"] = {
				},
				["backdropcolor"] = {
					["b"] = 0.1176470588235294,
					["g"] = 0.08627450980392157,
					["r"] = 0.07058823529411765,
				},
				["reputation"] = {
					["textFormat"] = "CURPERC",
					["height"] = 14,
					["textSize"] = 8,
					["mouseover"] = true,
					["width"] = 412,
				},
				["castNoInterrupt"] = {
				},
				["health"] = {
				},
				["font"] = "2002 Bold",
				["autoRepair"] = "PLAYER",
				["RUNIC_POWER"] = {
				},
				["castColor"] = {
				},
			},
			["CBPO"] = {
				["target"] = {
					["overlay"] = false,
				},
				["player"] = {
					["overlay"] = false,
				},
			},
			["xprep"] = {
				["show"] = "NONE",
				["textFormat"] = "CURMAX",
				["textStyle"] = "DTS",
			},
			["ufb"] = {
				["barheight"] = 15,
			},
			["hideTutorial"] = 1,
			["chat"] = {
				["tabFontSize"] = 12,
				["panelTabTransparency"] = true,
				["panelHeight"] = 157,
				["tabFont"] = "2002 Bold",
				["font"] = "2002 Bold",
				["tabFontOutline"] = "MONOCROMEOUTLINE",
				["panelWidth"] = 400,
			},
			["locplus"] = {
				["lpfont"] = "Bui Visitor1",
				["dtheight"] = 16,
				["lpauto"] = false,
				["both"] = false,
				["lpfontsize"] = 10,
				["lpfontflags"] = "MONOCHROMEOUTLINE",
				["lpwidth"] = 220,
				["trunc"] = true,
				["displayOther"] = "NONE",
				["dtwidth"] = 120,
			},
			["VAT"] = {
				["barHeight"] = 6,
				["enableStaticColor"] = true,
				["spacing"] = -7,
			},
			["bab"] = {
				["chooseAb"] = "BAR1",
			},
			["bags"] = {
				["yOffset"] = 154,
			},
			["loclite"] = {
				["lpfontsize"] = 10,
				["lpfont"] = "Bui Visitor1",
				["lpfontflags"] = "MONOCHROMEOUTLINE",
				["lpwidth"] = 220,
				["dtheight"] = 16,
				["lpauto"] = false,
				["trunc"] = true,
			},
			["movers"] = {
				["RaidMarkerBarAnchor"] = "TOPElvUIParentTOP-12-24",
				["MinimapButtonAnchor"] = "TOPRIGHTElvUIParentTOPRIGHT-25-283",
				["LocationLiteMover"] = "TOPElvUIParentTOP0-7",
				["LeftChatMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT021",
				["GMMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT0182",
				["BuffsMover"] = "TOPRIGHTElvUIParentTOPRIGHT-2810",
				["ElvUF_Raid10Mover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT9316",
				["BossButton"] = "BOTTOMElvUIParentBOTTOM4144",
				["LootFrameMover"] = "TOPLEFTElvUIParentTOPLEFT403-242",
				["DigSiteProgressBarMover"] = "BOTTOMElvUIParentBOTTOM3212",
				["MinimapMover"] = "TOPRIGHTElvUIParentTOPRIGHT00",
				["PetAB"] = "BOTTOMElvUIParentBOTTOM-600",
				["ElvUF_RaidpetMover"] = "TOPLEFTElvUIParentTOPLEFT0-74",
				["ElvUF_FocusMover"] = "BOTTOMElvUIParentBOTTOM231195",
				["RightChatMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT121",
				["ElvUF_TargetAuraMover"] = "BOTTOMElvUIParentBOTTOM227193",
				["PlayerPowerBarMover"] = "BOTTOMElvUIParentBOTTOM-230168",
				["WatchFrameMover"] = "TOPRIGHTElvUIParentTOPRIGHT-30-340",
				["ClassBarMover"] = "BOTTOMElvUIParentBOTTOM0272",
				["MicrobarMover"] = "TOPLEFTElvUIParentTOPLEFT00",
				["tokenHolderMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-40121",
				["VehicleSeatMover"] = "TOPRIGHTElvUIParentTOPRIGHT-281-161",
				["ElvUF_TargetMover"] = "BOTTOMElvUIParentBOTTOM243320",
				["ExperienceBarMover"] = "TOPElvUIParentTOP-17-15",
				["FarmSeedAnchor"] = "TOPLEFTElvUIParentTOPLEFT00",
				["ElvUF_TargetTargetMover"] = "BOTTOMElvUIParentBOTTOM55254",
				["ElvAB_6"] = "BOTTOMElvUIParentBOTTOM10",
				["BuiDashboardMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT0175",
				["ElvUF_Raid40Mover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT7179",
				["TargetPowerBarMover"] = "BOTTOMElvUIParentBOTTOM247215",
				["ElvAB_2"] = "BOTTOMElvUIParentBOTTOM3279",
				["ElvAB_1"] = "BOTTOMElvUIParentBOTTOM3316",
				["FarmPortalAnchor"] = "TOPLEFTElvUIParentTOPLEFT00",
				["ElvUF_PlayerCastbarMover"] = "BOTTOMElvUIParentBOTTOM-219312",
				["LossControlMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT438359",
				["ElvAB_4"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-4000",
				["TotemBarMover"] = "BOTTOMElvUIParentBOTTOM-569",
				["AltPowerBarMover"] = "BOTTOMElvUIParentBOTTOM31982",
				["ElvAB_3"] = "BOTTOMElvUIParentBOTTOM-2830",
				["ReputationBarMover"] = "TOPElvUIParentTOP-170",
				["ElvUF_PetMover"] = "BOTTOMElvUIParentBOTTOM-57254",
				["ElvUF_Raid25Mover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT28176",
				["ElvUF_PlayerAuraMover"] = "BOTTOMElvUIParentBOTTOM-229190",
				["ElvAB_5"] = "BOTTOMElvUIParentBOTTOM2950",
				["BNETMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT148182",
				["ShiftAB"] = "BOTTOMElvUIParentBOTTOM1510",
				["ArenaHeaderMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT0331",
				["FarmToolAnchor"] = "TOPLEFTElvUIParentTOPLEFT00",
				["ElvUF_TargetCastbarMover"] = "BOTTOMElvUIParentBOTTOM221307",
				["TooltipMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-178157",
				["ElvUF_TankMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT130213",
				["BossHeaderMover"] = "TOPRIGHTElvUIParentTOPRIGHT0-363",
				["ElvUF_PlayerMover"] = "BOTTOMElvUIParentBOTTOM-241325",
				["LocationMover"] = "TOPElvUIParentTOP0-7",
				["ElvUF_PartyMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT0491",
				["AlertFrameMover"] = "TOPRIGHTElvUIParentTOPRIGHT-331-418",
				["DebuffsMover"] = "TOPLEFTElvUIParentTOPLEFT2060",
				["ElvUF_AssistMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT59242",
			},
			["tooltip"] = {
				["healthBar"] = {
					["font"] = "2002 Bold",
					["fontOutline"] = "OUTLINE",
				},
			},
			["bui"] = {
				["installed"] = true,
				["colorTheme"] = "Hearthstone",
				["transparentDts"] = true,
				["toggleMail"] = false,
			},
			["unitframe"] = {
				["font"] = "2002 Bold",
				["units"] = {
					["tank"] = {
						["targetsGroup"] = {
							["height"] = 25,
							["width"] = 100,
						},
						["enable"] = false,
						["height"] = 25,
						["width"] = 99,
					},
					["raid10"] = {
						["power"] = {
							["power"] = false,
						},
						["enable"] = false,
					},
					["boss"] = {
						["castbar"] = {
							["height"] = 5.999995231628418,
							["width"] = 215.9999694824219,
						},
					},
					["raid40"] = {
						["enable"] = false,
					},
					["focus"] = {
						["castbar"] = {
							["height"] = 4,
							["width"] = 121.9999389648438,
						},
						["width"] = 122,
						["power"] = {
							["height"] = 5,
						},
					},
					["target"] = {
						["debuffs"] = {
							["sizeOverride"] = 0,
							["yOffset"] = -12,
							["anchorPoint"] = "BOTTOMLEFT",
							["perrow"] = 9,
							["attachTo"] = "FRAME",
						},
						["portrait"] = {
							["enable"] = true,
						},
						["aurabar"] = {
							["enable"] = false,
							["maxDuration"] = 120,
						},
						["power"] = {
							["hideonnpc"] = false,
						},
						["health"] = {
							["xOffset"] = 8,
							["yOffset"] = 4,
						},
						["name"] = {
							["text_format"] = "[namecolor][name:medium]",
						},
						["height"] = 33,
						["buffs"] = {
							["sizeOverride"] = 0,
							["anchorPoint"] = "TOPLEFT",
							["perrow"] = 9,
						},
						["castbar"] = {
							["height"] = 16,
							["width"] = 225.0000762939453,
						},
					},
					["targettarget"] = {
						["debuffs"] = {
							["enable"] = false,
							["bossAuras"] = true,
						},
						["threatStyle"] = "GLOW",
						["power"] = {
							["height"] = 5,
						},
						["width"] = 100,
						["height"] = 18,
						["buffs"] = {
							["bossAuras"] = true,
						},
					},
					["player"] = {
						["debuffs"] = {
							["sizeOverride"] = 0,
							["yOffset"] = -12,
							["anchorPoint"] = "BOTTOMRIGHT",
							["perrow"] = 9,
						},
						["portrait"] = {
							["enable"] = true,
						},
						["classbar"] = {
							["detachFromFrame"] = true,
							["detachedWidth"] = 212,
							["height"] = 8,
						},
						["aurabar"] = {
							["enable"] = false,
						},
						["health"] = {
							["xOffset"] = 8,
							["yOffset"] = 4,
							["position"] = "BOTTOMLEFT",
						},
						["castbar"] = {
							["width"] = 225,
							["height"] = 16,
							["latency"] = false,
						},
						["height"] = 33,
						["buffs"] = {
							["sizeOverride"] = 0,
							["enable"] = true,
							["anchorPoint"] = "TOPRIGHT",
							["perrow"] = 9,
							["attachTo"] = "FRAME",
						},
						["raidicon"] = {
							["attachTo"] = "LEFT",
						},
						["pvp"] = {
							["position"] = "TOPLEFT",
						},
					},
					["party"] = {
						["width"] = 159,
						["enable"] = false,
						["height"] = 25,
					},
					["raid25"] = {
						["width"] = 77,
						["enable"] = false,
						["power"] = {
							["enable"] = false,
						},
						["height"] = 34,
					},
					["arena"] = {
						["castbar"] = {
							["height"] = 6.000012397766113,
							["width"] = 193,
						},
					},
					["pet"] = {
						["power"] = {
							["height"] = 5,
						},
						["width"] = 100,
						["height"] = 18,
					},
					["assist"] = {
						["enable"] = false,
					},
				},
				["smoothbars"] = true,
				["colors"] = {
					["colorhealthbyvalue"] = false,
					["healthclass"] = true,
					["health_backdrop"] = {
						["b"] = 0,
						["g"] = 0,
						["r"] = 0.1019607843137255,
					},
					["auraBarTurtle"] = false,
					["classResources"] = {
						["DEATHKNIGHT"] = {
							nil, -- [1]
							{
								["r"] = 0.2980392156862745,
								["b"] = 0.2980392156862745,
							}, -- [2]
							{
								["r"] = 0.4823529411764706,
								["g"] = 0.7450980392156863,
								["b"] = 0.8352941176470589,
							}, -- [3]
							{
								["r"] = 0.796078431372549,
								["g"] = 0.3098039215686275,
								["b"] = 0.7529411764705882,
							}, -- [4]
						},
						["WARLOCK"] = {
							{
								["b"] = 0.196078431372549,
								["g"] = 0.1254901960784314,
								["r"] = 0.1411764705882353,
							}, -- [1]
							{
								["b"] = 0.2509803921568627,
								["g"] = 0.1568627450980392,
								["r"] = 0.1843137254901961,
							}, -- [2]
							{
								["b"] = 0.1215686274509804,
								["g"] = 0.1098039215686275,
								["r"] = 0.7019607843137254,
							}, -- [3]
						},
					},
					["power"] = {
						["MANA"] = {
							["b"] = 0.5450980392156862,
							["g"] = 0.2627450980392157,
							["r"] = 0.06274509803921569,
						},
						["RUNIC_POWER"] = {
							["g"] = 0.6352941176470588,
							["b"] = 0.7725490196078432,
						},
						["ENERGY"] = {
							["b"] = 0.1725490196078431,
							["g"] = 0.9058823529411765,
							["r"] = 0.9686274509803922,
						},
						["FOCUS"] = {
							["b"] = 0.04705882352941176,
							["g"] = 0.2549019607843137,
							["r"] = 0.4862745098039216,
						},
						["RAGE"] = {
							["b"] = 0.1137254901960784,
							["g"] = 0.04705882352941176,
							["r"] = 0.7803921568627451,
						},
					},
					["castColor"] = {
						["b"] = 0.4117647058823529,
						["g"] = 0.2196078431372549,
						["r"] = 0.3764705882352941,
					},
					["disconnected"] = {
						["b"] = 0.2862745098039216,
						["g"] = 0.3294117647058824,
						["r"] = 0.3686274509803922,
					},
					["castNoInterrupt"] = {
						["b"] = 0.2352941176470588,
						["g"] = 0.01176470588235294,
						["r"] = 0.1411764705882353,
					},
					["tapped"] = {
						["b"] = 0.8588235294117647,
						["g"] = 0.8274509803921568,
						["r"] = 0.8588235294117647,
					},
					["health"] = {
						["b"] = 0.1490196078431373,
						["g"] = 0.9529411764705882,
						["r"] = 0.5607843137254902,
					},
				},
				["fontOutline"] = "OUTLINE",
				["statusbar"] = "Minimalist",
			},
			["datatexts"] = {
				["fontSize"] = 12,
				["panelTransparency"] = true,
				["panels"] = {
					["LeftMiniPanel"] = "Time",
					["BuiRightChatDTPanel"] = {
						["left"] = "Durability",
					},
					["BuiLeftChatDTPanel"] = {
						["right"] = "BuiMail",
					},
					["LeftChatDataPanel"] = {
						["right"] = "Durability",
						["left"] = "Guild",
						["middle"] = "Friends",
					},
					["RightMiniPanel"] = "System",
					["Actionbar3DataPanel"] = "",
					["RightChatDataPanel"] = {
						["middle"] = "Bags",
						["left"] = "Cecile Meter Overlay",
					},
					["Actionbar5DataPanel"] = "",
				},
				["fontOutline"] = "MONOCROMEOUTLINE",
				["leftChatPanel"] = false,
				["rightChatPanel"] = false,
				["font"] = "2002 Bold",
				["actionbar5"] = false,
				["actionbar1"] = false,
				["actionbar3"] = false,
			},
			["actionbar"] = {
				["bar3"] = {
					["buttons"] = 10,
					["buttonspacing"] = 4,
					["buttonsPerRow"] = 5,
					["buttonsize"] = 28,
				},
				["fontOutline"] = "MONOCROMEOUTLINE",
				["bar2"] = {
					["enabled"] = true,
					["buttons"] = 7,
					["buttonspacing"] = 4,
					["buttonsize"] = 26,
				},
				["bar1"] = {
					["buttons"] = 6,
					["buttonspacing"] = 4,
					["buttonsPerRow"] = 6,
				},
				["bar5"] = {
					["buttons"] = 10,
					["buttonspacing"] = 4,
					["buttonsPerRow"] = 5,
					["buttonsize"] = 28,
				},
				["font"] = "2002 Bold",
				["bar6"] = {
					["enabled"] = true,
					["point"] = "TOPLEFT",
					["backdrop"] = true,
					["heightMult"] = 2,
					["buttonsize"] = 30,
				},
				["macrotext"] = true,
				["stanceBar"] = {
					["style"] = "classic",
					["buttonsize"] = 28,
				},
				["barPet"] = {
					["point"] = "BOTTOMLEFT",
					["backdrop"] = false,
					["buttonsPerRow"] = 10,
					["buttonsize"] = 24,
				},
				["bar4"] = {
					["point"] = "BOTTOMRIGHT",
					["buttons"] = 10,
					["buttonspacing"] = 4,
					["mouseover"] = true,
					["buttonsPerRow"] = 2,
					["buttonsize"] = 28,
					["backdrop"] = false,
				},
			},
			["auras"] = {
				["timeXOffset"] = -1,
				["debuffs"] = {
					["size"] = 38,
				},
				["fadeThreshold"] = 10,
				["font"] = "2002 Bold",
				["fontOutline"] = "MONOCROMEOUTLINE",
				["consolidatedBuffs"] = {
					["fontSize"] = 12,
					["fontOutline"] = "MONOCROMEOUTLINE",
					["font"] = "2002 Bold",
				},
				["buffs"] = {
					["horizontalSpacing"] = 3,
					["size"] = 38,
				},
			},
			["currentTutorial"] = 1,
		},
		["Toradol - Skywall"] = {
			["bui"] = {
				["installed"] = true,
			},
			["currentTutorial"] = 7,
			["hideTutorial"] = 1,
			["unitframe"] = {
				["units"] = {
					["boss"] = {
						["castbar"] = {
							["height"] = 5.999995231628418,
							["width"] = 0,
						},
					},
					["focus"] = {
						["castbar"] = {
							["height"] = 5.999995231628418,
							["width"] = 189.9999694824219,
						},
					},
					["target"] = {
						["castbar"] = {
							["height"] = 8.999998092651367,
						},
					},
					["arena"] = {
						["castbar"] = {
							["height"] = 5.999995231628418,
							["width"] = 193,
						},
					},
					["player"] = {
						["castbar"] = {
							["height"] = 8.999998092651367,
							["width"] = 269.9999694824219,
						},
					},
				},
			},
		},
		["Olegregg - Area 52"] = {
		},
		["Gurund - Skywall"] = {
		},
		["Anaiis - Skywall"] = {
			["bui"] = {
				["installed"] = true,
			},
			["currentTutorial"] = 1,
			["general"] = {
				["loginmessage"] = false,
				["valuecolor"] = {
					["b"] = 0.45,
					["g"] = 0.83,
					["r"] = 0.67,
				},
				["bordercolor"] = {
					["b"] = 0.31,
					["g"] = 0.31,
					["r"] = 0.31,
				},
				["autoRepair"] = "PLAYER",
				["minimap"] = {
					["size"] = 192,
				},
			},
			["movers"] = {
				["LossControlMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT465404",
				["RaidMarkerBarAnchor"] = "TOPLEFTElvUIParentTOPLEFT3832",
				["ElvUF_PlayerCastbarMover"] = "BOTTOMElvUIParentBOTTOM060",
				["ElvAB_1"] = "BOTTOMElvUIParentBOTTOM021",
				["ElvAB_2"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-4219",
				["GMMover"] = "TOPLEFTElvUIParentTOPLEFT4-4",
				["BuffsMover"] = "TOPRIGHTElvUIParentTOPRIGHT-225-1",
				["ElvAB_4"] = "TOPRIGHTElvUIParentTOPRIGHT2-395",
				["AltPowerBarMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT454325",
				["BossButton"] = "BOTTOMElvUIParentBOTTOM0195",
				["ElvAB_5"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT50022",
				["ElvUF_TargetMover"] = "BOTTOMElvUIParentBOTTOM282138",
				["ElvAB_3"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-49923",
				["LeftChatMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT-2-5",
				["PetAB"] = "TOPRIGHTElvUIParentTOPRIGHT-35-459",
				["BNETMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT4186",
				["ArenaHeaderMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-55250",
				["ElvUF_PetMover"] = "BOTTOMElvUIParentBOTTOM0150",
				["ElvUF_FocusMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-422307",
				["ElvAB_6"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT3178",
				["TooltipMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-44",
				["ElvUF_PlayerMover"] = "BOTTOMElvUIParentBOTTOM-285142",
				["BossHeaderMover"] = "TOPRIGHTElvUIParentTOPRIGHT-79-463",
				["TotemBarMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT411-6",
				["ElvUF_TargetTargetMover"] = "BOTTOMElvUIParentBOTTOM0110",
				["RightChatMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT6-6",
				["AlertFrameMover"] = "TOPRIGHTElvUIParentTOPRIGHT-482-341",
				["DebuffsMover"] = "TOPRIGHTElvUIParentTOPRIGHT-225-144",
				["MinimapMover"] = "TOPRIGHTElvUIParentTOPRIGHT05",
			},
			["hideTutorial"] = 1,
			["unitframe"] = {
				["colors"] = {
					["auraBarBuff"] = {
						["b"] = 0.94,
						["g"] = 0.8,
						["r"] = 0.41,
					},
					["castClassColor"] = true,
					["healthclass"] = true,
				},
				["units"] = {
					["boss"] = {
						["height"] = 40,
						["castbar"] = {
							["height"] = 5.999995231628418,
							["width"] = 0,
						},
						["width"] = 200,
					},
					["focus"] = {
						["castbar"] = {
							["height"] = 5.999995231628418,
							["width"] = 189.9999694824219,
						},
					},
					["target"] = {
						["portrait"] = {
							["enable"] = true,
						},
						["castbar"] = {
							["height"] = 9.000010490417481,
							["width"] = 215.0000457763672,
						},
						["height"] = 45,
						["width"] = 260,
						["aurabar"] = {
							["enable"] = false,
						},
					},
					["arena"] = {
						["castbar"] = {
							["height"] = 6.000012397766113,
							["width"] = 193,
						},
					},
					["player"] = {
						["debuffs"] = {
							["attachTo"] = "BUFFS",
						},
						["portrait"] = {
							["enable"] = true,
						},
						["castbar"] = {
							["height"] = 9.000010490417481,
							["width"] = 214.9999694824219,
						},
						["height"] = 45,
						["buffs"] = {
							["noDuration"] = false,
							["enable"] = true,
							["attachTo"] = "FRAME",
						},
						["width"] = 260,
						["aurabar"] = {
							["enable"] = false,
						},
					},
				},
			},
			["datatexts"] = {
				["actionbar1"] = true,
				["actionbar5"] = true,
				["panels"] = {
					["LeftMiniPanel"] = "Time",
					["RightMiniPanel"] = "System",
					["RightChatDataPanel"] = {
						["left"] = "Durability",
						["middle"] = "Bags",
					},
					["Actionbar1DataPanel"] = {
						["left"] = "",
						["right"] = "",
					},
					["Actionbar5DataPanel"] = "Cecile Meter Overlay",
					["Actionbar3DataPanel"] = "Combat/Arena Time",
					["LeftChatDataPanel"] = {
						["right"] = "Friends",
						["left"] = "",
						["middle"] = "Guild",
					},
				},
				["actionbar3"] = true,
			},
			["actionbar"] = {
				["bar1"] = {
					["buttonsize"] = 36,
				},
				["bar6"] = {
					["enabled"] = true,
				},
				["barPet"] = {
					["buttonsize"] = 26,
				},
			},
			["layoutSet"] = "dpsCaster",
		},
		["Oldfero - Area 52"] = {
			["bui"] = {
				["installed"] = true,
			},
			["currentTutorial"] = 2,
			["general"] = {
				["totems"] = {
					["enable"] = false,
				},
				["stickyFrames"] = false,
				["backdropcolor"] = {
					["r"] = 0.1019607843137255,
					["g"] = 0.1019607843137255,
					["b"] = 0.1019607843137255,
				},
				["reputation"] = {
					["height"] = 12,
					["textFormat"] = "CURMAX",
					["textSize"] = 8,
					["width"] = 412,
				},
				["bordercolor"] = {
					["r"] = 0.31,
					["g"] = 0.31,
					["b"] = 0.31,
				},
				["minimap"] = {
					["locationText"] = "HIDE",
					["size"] = 212,
				},
				["font"] = "Friz Quadrata TT",
				["bottomPanel"] = false,
				["backdropfadecolor"] = {
					["r"] = 0.05490196078431373,
					["g"] = 0.05490196078431373,
					["b"] = 0.05490196078431373,
				},
				["valuecolor"] = {
					["a"] = 1,
					["r"] = 1,
					["g"] = 0.5,
					["b"] = 0,
				},
				["topPanel"] = false,
				["experience"] = {
					["width"] = 412,
					["textFormat"] = "CURPERC",
				},
			},
			["CBPO"] = {
				["player"] = {
					["overlay"] = false,
				},
			},
			["xprep"] = {
				["textFormat"] = "CURMAX",
			},
			["ufb"] = {
				["barheight"] = 15,
			},
			["hideTutorial"] = 1,
			["chat"] = {
				["tabFont"] = "Bui Visitor1",
				["font"] = "Bui Prototype",
				["tabFontOutline"] = "MONOCROMEOUTLINE",
				["panelHeight"] = 150,
			},
			["locplus"] = {
				["lpfont"] = "Bui Visitor1",
				["dtheight"] = 16,
				["lpauto"] = false,
				["lpfontsize"] = 10,
				["both"] = false,
				["lpwidth"] = 220,
				["displayOther"] = "NONE",
				["trunc"] = true,
				["lpfontflags"] = "MONOCHROMEOUTLINE",
				["dtwidth"] = 120,
			},
			["layoutSet"] = "dpsCaster",
			["VAT"] = {
				["barHeight"] = 6,
				["enableStaticColor"] = true,
				["spacing"] = -7,
			},
			["bab"] = {
				["chooseAb"] = "BAR1",
			},
			["movers"] = {
				["ElvUF_PlayerCastbarMover"] = "BOTTOMElvUIParentBOTTOM-231147",
				["LocationLiteMover"] = "TOPElvUIParentTOP0-7",
				["LeftChatMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT222",
				["GMMover"] = "TOPLEFTElvUIParentTOPLEFT155-4",
				["BuffsMover"] = "TOPRIGHTElvUIParentTOPRIGHT-189-3",
				["ElvUF_Raid10Mover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT4210",
				["BossButton"] = "BOTTOMElvUIParentBOTTOM0283",
				["DigSiteProgressBarMover"] = "BOTTOMElvUIParentBOTTOM0315",
				["ElvUF_RaidpetMover"] = "TOPLEFTElvUIParentTOPLEFT4-444",
				["ElvUF_FocusMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-442178",
				["ClassBarMover"] = "BOTTOMElvUIParentBOTTOM-1349",
				["MicrobarMover"] = "TOPLEFTElvUIParentTOPLEFT4-4",
				["VehicleSeatMover"] = "TOPLEFTElvUIParentTOPLEFT155-81",
				["ExperienceBarMover"] = "TOPElvUIParentTOP0-11",
				["ElvUF_TargetTargetMover"] = "BOTTOMElvUIParentBOTTOM0164",
				["BuiDashboardMover"] = "TOPLEFTElvUIParentTOPLEFT4-8",
				["ElvUF_Raid40Mover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT4211",
				["MinimapMover"] = "TOPRIGHTElvUIParentTOPRIGHT-94-13",
				["PetAB"] = "BOTTOMElvUIParentBOTTOM013",
				["ElvAB_1"] = "BOTTOMElvUIParentBOTTOM092",
				["ElvAB_2"] = "BOTTOMElvUIParentBOTTOM058",
				["ElvUF_TargetMover"] = "BOTTOMElvUIParentBOTTOM231182",
				["ElvUF_PartyMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT4210",
				["ElvUF_PlayerMover"] = "BOTTOMElvUIParentBOTTOM-231182",
				["TotemBarMover"] = "TOPLEFTElvUIParentTOPLEFT4360",
				["AltPowerBarMover"] = "TOPElvUIParentTOP0-66",
				["ElvAB_3"] = "BOTTOMElvUIParentBOTTOM29558",
				["ReputationBarMover"] = "TOPElvUIParentTOP-40",
				["BossHeaderMover"] = "TOPRIGHTElvUIParentTOPRIGHT-56-397",
				["PlayerPowerBarMover"] = "BOTTOMElvUIParentBOTTOM-231215",
				["ElvUF_Raid25Mover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT2179",
				["ArenaHeaderMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-56346",
				["BNETMover"] = "TOPRIGHTElvUIParentTOPRIGHT-4-199",
				["ShiftAB"] = "BOTTOMElvUIParentBOTTOM0134",
				["LocationMover"] = "TOPElvUIParentTOP0-7",
				["TargetPowerBarMover"] = "BOTTOMElvUIParentBOTTOM247215",
				["ElvUF_TargetCastbarMover"] = "BOTTOMElvUIParentBOTTOM231147",
				["WatchFrameMover"] = "TOPRIGHTElvUIParentTOPRIGHT-122-292",
				["ElvUF_TankMover"] = "TOPLEFTElvUIParentTOPLEFT4-292",
				["tokenHolderMover"] = "TOPLEFTElvUIParentTOPLEFT4-119",
				["ElvUF_PetMover"] = "BOTTOMElvUIParentBOTTOM0191",
				["ElvAB_5"] = "BOTTOMElvUIParentBOTTOM-29558",
				["RightChatMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-222",
				["AlertFrameMover"] = "TOPElvUIParentTOP0-140",
				["DebuffsMover"] = "TOPRIGHTElvUIParentTOPRIGHT-189-134",
				["ElvUF_AssistMover"] = "TOPLEFTElvUIParentTOPLEFT4-392",
			},
			["tooltip"] = {
				["healthBar"] = {
					["font"] = "Bui Prototype",
					["fontSize"] = 9,
					["fontOutline"] = "OUTLINE",
				},
			},
			["unitframe"] = {
				["font"] = "Bui Visitor1",
				["colors"] = {
					["auraBarBuff"] = {
						["r"] = 0.58,
						["g"] = 0.51,
						["b"] = 0.79,
					},
					["castClassColor"] = true,
					["castColor"] = {
						["r"] = 0.1,
						["g"] = 0.1,
						["b"] = 0.1,
					},
					["transparentCastbar"] = true,
					["health"] = {
						["r"] = 0.1,
						["g"] = 0.1,
						["b"] = 0.1,
					},
					["transparentAurabars"] = true,
				},
				["fontOutline"] = "MONOCROMEOUTLINE",
				["statusbar"] = "BuiFlat",
				["units"] = {
					["raid10"] = {
						["power"] = {
							["power"] = false,
						},
					},
					["pet"] = {
						["height"] = 24,
						["power"] = {
							["height"] = 5,
						},
					},
					["boss"] = {
						["castbar"] = {
							["height"] = 5.999995231628418,
							["width"] = 0,
						},
					},
					["targettarget"] = {
						["height"] = 24,
						["power"] = {
							["height"] = 5,
						},
					},
					["focus"] = {
						["power"] = {
							["height"] = 5,
						},
						["width"] = 122,
						["castbar"] = {
							["height"] = 4.000008583068848,
							["width"] = 121.9999389648438,
						},
					},
					["target"] = {
						["debuffs"] = {
							["anchorPoint"] = "TOPLEFT",
						},
						["portrait"] = {
							["enable"] = true,
							["overlay"] = true,
						},
						["power"] = {
							["height"] = 5,
							["xOffset"] = 2,
							["hideonnpc"] = false,
							["detachedWidth"] = 298,
							["yOffset"] = -25,
						},
						["width"] = 300,
						["castbar"] = {
							["height"] = 4.000008583068848,
							["icon"] = false,
							["width"] = 299.9999694824219,
						},
						["health"] = {
							["xOffset"] = -40,
							["text_format"] = "",
							["yOffset"] = -25,
						},
						["name"] = {
							["xOffset"] = 8,
							["position"] = "RIGHT",
							["text_format"] = "[healthcolor][health:current-percent] [namecolor][name:medium] [difficultycolor][smartlevel] [shortclassification]",
							["yOffset"] = -25,
						},
						["height"] = 33,
						["buffs"] = {
							["anchorPoint"] = "TOPLEFT",
							["sizeOverride"] = 30,
							["yOffset"] = 2,
						},
						["threatStyle"] = "ICONTOPLEFT",
						["aurabar"] = {
							["enable"] = false,
						},
					},
					["arena"] = {
						["castbar"] = {
							["height"] = 5.999995231628418,
							["width"] = 193,
						},
					},
					["raid25"] = {
						["power"] = {
							["enable"] = false,
						},
					},
					["player"] = {
						["debuffs"] = {
							["attachTo"] = "BUFFS",
							["sizeOverride"] = 32,
							["yOffset"] = 2,
						},
						["portrait"] = {
							["enable"] = true,
							["overlay"] = true,
						},
						["castbar"] = {
							["icon"] = false,
							["width"] = 412,
						},
						["width"] = 300,
						["power"] = {
							["detachedWidth"] = 298,
							["height"] = 5,
							["yOffset"] = -25,
						},
						["health"] = {
							["xOffset"] = 2,
							["yOffset"] = -25,
						},
						["threatStyle"] = "ICONTOPRIGHT",
						["height"] = 33,
						["buffs"] = {
							["attachTo"] = "FRAME",
							["sizeOverride"] = 30,
							["enable"] = true,
							["noDuration"] = false,
							["yOffset"] = 2,
						},
						["classbar"] = {
							["detachFromFrame"] = true,
							["detachedWidth"] = 140,
							["fill"] = "spaced",
						},
						["aurabar"] = {
							["enable"] = false,
						},
					},
				},
			},
			["datatexts"] = {
				["font"] = "Bui Visitor1",
				["fontOutline"] = "MONOCROMEOUTLINE",
				["panelTransparency"] = true,
				["leftChatPanel"] = false,
				["panels"] = {
					["BuiRightChatDTPanel"] = {
						["left"] = "Mastery",
					},
					["BuiLeftChatDTPanel"] = {
						["middle"] = "Haste",
						["right"] = "BuiMail",
					},
					["LeftChatDataPanel"] = {
						["left"] = "Spell/Heal Power",
						["right"] = "Haste",
					},
				},
				["rightChatPanel"] = false,
			},
			["actionbar"] = {
				["bar3"] = {
					["buttons"] = 10,
					["buttonspacing"] = 4,
					["buttonsPerRow"] = 5,
					["backdrop"] = true,
					["buttonsize"] = 30,
				},
				["bar2"] = {
					["enabled"] = true,
					["buttonspacing"] = 4,
					["backdrop"] = true,
					["buttonsize"] = 30,
					["heightMult"] = 2,
				},
				["bar1"] = {
					["buttonspacing"] = 4,
					["buttonsize"] = 30,
				},
				["bar5"] = {
					["buttons"] = 10,
					["buttonspacing"] = 4,
					["buttonsPerRow"] = 5,
					["backdrop"] = true,
					["buttonsize"] = 30,
				},
				["font"] = "Bui Visitor1",
				["fontOutline"] = "MONOCROMEOUTLINE",
				["stanceBar"] = {
					["buttonsize"] = 24,
				},
				["barPet"] = {
					["buttonspacing"] = 4,
					["buttonsPerRow"] = 10,
					["buttonsize"] = 27,
				},
				["bar4"] = {
					["buttonspacing"] = 4,
					["buttonsize"] = 26,
				},
			},
			["auras"] = {
				["timeXOffset"] = -1,
				["debuffs"] = {
					["size"] = 30,
				},
				["fontOutline"] = "MONOCROMEOUTLINE",
				["fadeThreshold"] = 10,
				["buffs"] = {
					["horizontalSpacing"] = 3,
					["size"] = 30,
				},
				["consolidatedBuffs"] = {
					["fontOutline"] = "MONOCROMEOUTLINE",
					["font"] = "Bui Visitor1",
				},
				["font"] = "Bui Visitor1",
			},
			["nameplate"] = {
				["font"] = "Bui Visitor1",
			},
			["loclite"] = {
				["trunc"] = true,
				["lpfont"] = "Bui Visitor1",
				["dtheight"] = 16,
				["lpwidth"] = 220,
				["lpfontflags"] = "MONOCHROMEOUTLINE",
				["lpauto"] = false,
				["lpfontsize"] = 10,
			},
		},
		["Gurund - Area 52"] = {
			["bui"] = {
				["installed"] = true,
			},
			["currentTutorial"] = 2,
		},
		["Noremedy - Skywall"] = {
			["unitframe"] = {
				["units"] = {
					["boss"] = {
						["castbar"] = {
							["height"] = 5.999995231628418,
							["width"] = 0,
						},
					},
					["focus"] = {
						["castbar"] = {
							["height"] = 5.999995231628418,
							["width"] = 189.9999694824219,
						},
					},
					["target"] = {
						["castbar"] = {
							["height"] = 8.999998092651367,
						},
					},
					["arena"] = {
						["castbar"] = {
							["height"] = 5.999995231628418,
							["width"] = 193,
						},
					},
					["player"] = {
						["castbar"] = {
							["height"] = 8.999998092651367,
							["width"] = 410,
						},
					},
				},
			},
		},
		["Default"] = {
			["nameplate"] = {
				["debuffs"] = {
					["font"] = "Friz Quadrata TT",
				},
				["healthBar"] = {
					["lowHPScale"] = {
						["enable"] = true,
					},
					["text"] = {
						["enable"] = true,
					},
				},
				["fontOutline"] = "OUTLINE",
				["buffs"] = {
					["font"] = "Friz Quadrata TT",
				},
				["font"] = "Friz Quadrata TT",
			},
			["utils"] = {
				["enableSystem"] = false,
				["enableTokens"] = false,
			},
			["general"] = {
				["totems"] = {
					["enable"] = false,
				},
				["fontSize"] = 13,
				["tinyWorldMap"] = false,
				["autoRepair"] = "PLAYER",
				["minimap"] = {
					["size"] = 236,
				},
				["health_backdrop"] = {
				},
				["backdropfadecolor"] = {
					["r"] = 0.04313725490196078,
					["g"] = 0.1019607843137255,
					["b"] = 0.1019607843137255,
				},
				["valuecolor"] = {
					["a"] = 1,
					["r"] = 1,
					["g"] = 0.5,
					["b"] = 0,
				},
				["ENERGY"] = {
				},
				["loginmessage"] = false,
				["castColor"] = {
				},
				["stickyFrames"] = false,
				["backdropcolor"] = {
					["r"] = 0.02745098039215686,
					["g"] = 0.06274509803921569,
					["b"] = 0.06274509803921569,
				},
				["topPanel"] = false,
				["FOCUS"] = {
				},
				["RUNIC_POWER"] = {
				},
				["disconnected"] = {
				},
				["castNoInterrupt"] = {
				},
				["font"] = "Friz Quadrata TT",
				["experience"] = {
					["height"] = 11,
					["textFormat"] = "CURPERC",
				},
				["tapped"] = {
				},
				["health"] = {
				},
				["reputation"] = {
					["height"] = 14,
					["textFormat"] = "CURPERC",
					["mouseover"] = true,
					["textSize"] = 8,
				},
				["MANA"] = {
				},
				["RAGE"] = {
				},
			},
			["CBPO"] = {
				["target"] = {
					["overlay"] = false,
				},
				["player"] = {
					["overlay"] = false,
				},
			},
			["xprep"] = {
				["textFormat"] = "CURMAX",
			},
			["ufb"] = {
				["barheight"] = 15,
			},
			["hideTutorial"] = 1,
			["chat"] = {
				["font"] = "Friz Quadrata TT",
				["tabFontOutline"] = "MONOCROMEOUTLINE",
				["tabFont"] = "Friz Quadrata TT",
				["tabFontSize"] = 12,
				["panelTabTransparency"] = true,
			},
			["locplus"] = {
				["lpfont"] = "Bui Visitor1",
				["dtheight"] = 16,
				["lpauto"] = false,
				["lpfontsize"] = 10,
				["both"] = false,
				["displayOther"] = "NONE",
				["lpwidth"] = 220,
				["lpfontflags"] = "MONOCHROMEOUTLINE",
				["trunc"] = true,
				["dtwidth"] = 120,
			},
			["layoutSet"] = "dpsMelee",
			["VAT"] = {
				["barHeight"] = 6,
				["enableStaticColor"] = true,
				["spacing"] = -7,
			},
			["bab"] = {
				["chooseAb"] = "BAR1",
			},
			["movers"] = {
				["ElvUF_TargetMover"] = "BOTTOMElvUIParentBOTTOM278110",
				["ElvUF_PlayerMover"] = "BOTTOMElvUIParentBOTTOM-278110",
				["BossButton"] = "BOTTOMElvUIParentBOTTOM0195",
				["ElvUF_PlayerCastbarMover"] = "BOTTOMElvUIParentBOTTOM042",
				["ElvUF_PetMover"] = "BOTTOMElvUIParentBOTTOM0150",
				["ElvAB_2"] = "BOTTOMElvUIParentBOTTOM038",
				["ElvUF_TargetTargetMover"] = "BOTTOMElvUIParentBOTTOM0110",
			},
			["tooltip"] = {
				["healthBar"] = {
					["fontOutline"] = "OUTLINE",
					["font"] = "Friz Quadrata TT",
				},
			},
			["unitframe"] = {
				["statusbar"] = "BuiMelliDark",
				["colors"] = {
					["power"] = {
						["MANA"] = {
							["r"] = 0.06274509803921569,
							["g"] = 0.2627450980392157,
							["b"] = 0.5450980392156862,
						},
						["RUNIC_POWER"] = {
							["g"] = 0.6352941176470588,
							["b"] = 0.7725490196078432,
						},
						["RAGE"] = {
							["r"] = 0.7803921568627451,
							["g"] = 0.04705882352941176,
							["b"] = 0.1137254901960784,
						},
						["FOCUS"] = {
							["r"] = 0.4705882352941176,
							["g"] = 0.5294117647058824,
							["b"] = 0.1176470588235294,
						},
						["ENERGY"] = {
							["r"] = 0.9686274509803922,
							["g"] = 0.9058823529411765,
							["b"] = 0.1725490196078431,
						},
					},
					["castColor"] = {
						["r"] = 0.3764705882352941,
						["g"] = 0.2196078431372549,
						["b"] = 0.4117647058823529,
					},
					["colorhealthbyvalue"] = false,
					["disconnected"] = {
						["r"] = 0.3686274509803922,
						["g"] = 0.3294117647058824,
						["b"] = 0.2862745098039216,
					},
					["customhealthbackdrop"] = true,
					["health_backdrop"] = {
						["r"] = 0.1882352941176471,
						["g"] = 0,
						["b"] = 0,
					},
					["health"] = {
						["r"] = 0.5607843137254902,
						["g"] = 0.9529411764705882,
						["b"] = 0.1490196078431373,
					},
					["tapped"] = {
						["r"] = 0.8588235294117647,
						["g"] = 0.8274509803921568,
						["b"] = 0.8588235294117647,
					},
					["castNoInterrupt"] = {
						["r"] = 0.1411764705882353,
						["g"] = 0.01176470588235294,
						["b"] = 0.2352941176470588,
					},
					["auraBarTurtle"] = false,
					["classResources"] = {
						["WARLOCK"] = {
							{
								["r"] = 0.1411764705882353,
								["g"] = 0.1254901960784314,
								["b"] = 0.196078431372549,
							}, -- [1]
							{
								["r"] = 0.1843137254901961,
								["g"] = 0.1568627450980392,
								["b"] = 0.2509803921568627,
							}, -- [2]
							{
								["r"] = 0.7019607843137254,
								["g"] = 0.1098039215686275,
								["b"] = 0.1215686274509804,
							}, -- [3]
						},
					},
				},
				["fontOutline"] = "OUTLINE",
				["font"] = "Friz Quadrata TT",
				["units"] = {
					["raid10"] = {
						["power"] = {
							["power"] = false,
						},
					},
					["player"] = {
						["castbar"] = {
							["height"] = 28,
							["width"] = 406,
						},
						["debuffs"] = {
							["attachTo"] = "BUFFS",
							["sizeOverride"] = 0,
						},
						["buffs"] = {
							["enable"] = true,
							["sizeOverride"] = 0,
							["attachTo"] = "FRAME",
							["noDuration"] = false,
						},
						["aurabar"] = {
							["enable"] = false,
						},
					},
					["target"] = {
						["debuffs"] = {
							["sizeOverride"] = 0,
						},
						["buffs"] = {
							["sizeOverride"] = 0,
						},
						["aurabar"] = {
							["enable"] = false,
						},
					},
				},
			},
			["datatexts"] = {
				["fontSize"] = 12,
				["panelTransparency"] = true,
				["actionbar5"] = false,
				["panels"] = {
					["LeftMiniPanel"] = "Time",
					["BuiRightChatDTPanel"] = {
						["left"] = "Durability",
					},
					["BuiLeftChatDTPanel"] = {
						["right"] = "BuiMail",
					},
					["LeftChatDataPanel"] = {
						["right"] = "Durability",
						["left"] = "Guild",
						["middle"] = "Friends",
					},
					["RightChatDataPanel"] = {
						["left"] = "Cecile Meter Overlay",
						["middle"] = "Bags",
					},
					["Actionbar3DataPanel"] = "",
					["RightMiniPanel"] = "System",
					["Actionbar5DataPanel"] = "",
				},
				["font"] = "Friz Quadrata TT",
				["fontOutline"] = "MONOCROMEOUTLINE",
				["leftChatPanel"] = false,
				["actionbar1"] = false,
				["actionbar3"] = false,
				["rightChatPanel"] = false,
			},
			["loclite"] = {
				["trunc"] = true,
				["lpfontsize"] = 10,
				["dtheight"] = 16,
				["lpwidth"] = 220,
				["lpfontflags"] = "MONOCHROMEOUTLINE",
				["lpauto"] = false,
				["lpfont"] = "Bui Visitor1",
			},
			["currentTutorial"] = 1,
			["auras"] = {
				["timeXOffset"] = -1,
				["font"] = "Friz Quadrata TT",
				["fontOutline"] = "MONOCROMEOUTLINE",
				["fadeThreshold"] = 10,
				["buffs"] = {
					["horizontalSpacing"] = 3,
					["size"] = 38,
				},
				["debuffs"] = {
					["size"] = 38,
				},
				["consolidatedBuffs"] = {
					["font"] = "Friz Quadrata TT",
					["fontSize"] = 12,
					["fontOutline"] = "MONOCROMEOUTLINE",
				},
			},
			["bags"] = {
				["yOffset"] = 150,
			},
			["bui"] = {
				["installed"] = true,
				["transparentDts"] = true,
			},
		},
		["Skywall"] = {
			["unitframe"] = {
				["units"] = {
					["boss"] = {
						["castbar"] = {
							["height"] = 5.999995231628418,
							["width"] = 0,
						},
					},
					["focus"] = {
						["castbar"] = {
							["height"] = 5.999995231628418,
							["width"] = 189.9999694824219,
						},
					},
					["target"] = {
						["castbar"] = {
							["height"] = 8.999998092651367,
						},
					},
					["arena"] = {
						["castbar"] = {
							["height"] = 5.999995231628418,
							["width"] = 193,
						},
					},
					["player"] = {
						["castbar"] = {
							["height"] = 8.999998092651367,
							["width"] = 269.9999694824219,
						},
					},
				},
			},
			["currentTutorial"] = 1,
		},
		["Noremedy"] = {
		},
		["Feronaz - Area 52"] = {
			["nameplate"] = {
				["font"] = "Bui Visitor1",
			},
			["currentTutorial"] = 5,
			["general"] = {
				["fontSize"] = 10,
				["stickyFrames"] = false,
				["backdropcolor"] = {
					["b"] = 0.1176470588235294,
					["g"] = 0.08627450980392157,
					["r"] = 0.07058823529411765,
				},
				["topPanel"] = false,
				["bordercolor"] = {
					["b"] = 0.31,
					["g"] = 0.31,
					["r"] = 0.31,
				},
				["minimap"] = {
					["locationText"] = "HIDE",
					["size"] = 150,
				},
				["font"] = "Bui Prototype",
				["bottomPanel"] = false,
				["backdropfadecolor"] = {
					["b"] = 0.1490196078431373,
					["g"] = 0.1098039215686275,
					["r"] = 0.08627450980392157,
				},
				["valuecolor"] = {
					["a"] = 1,
					["b"] = 0,
					["g"] = 0.5,
					["r"] = 1,
				},
				["experience"] = {
					["enable"] = false,
					["textFormat"] = "CURPERC",
					["width"] = 412,
				},
				["reputation"] = {
					["enable"] = false,
					["textFormat"] = "CURPERC",
					["textSize"] = 8,
					["width"] = 180,
				},
			},
			["xprep"] = {
				["textFormat"] = "CURMAX",
			},
			["ufb"] = {
				["barheight"] = 15,
			},
			["auras"] = {
				["timeXOffset"] = -1,
				["font"] = "Bui Visitor1",
				["fontOutline"] = "MONOCROMEOUTLINE",
				["fadeThreshold"] = 10,
				["buffs"] = {
					["horizontalSpacing"] = 3,
					["size"] = 30,
				},
				["consolidatedBuffs"] = {
					["font"] = "Bui Visitor1",
					["fontOutline"] = "MONOCROMEOUTLINE",
				},
				["debuffs"] = {
					["size"] = 30,
				},
			},
			["locplus"] = {
				["lpfont"] = "Bui Visitor1",
				["dtheight"] = 16,
				["lpauto"] = false,
				["both"] = false,
				["lpfontsize"] = 10,
				["trunc"] = true,
				["displayOther"] = "NONE",
				["lpfontflags"] = "MONOCHROMEOUTLINE",
				["lpwidth"] = 220,
				["dtwidth"] = 120,
			},
			["layoutSet"] = "healer",
			["VAT"] = {
				["barHeight"] = 6,
				["enableStaticColor"] = true,
				["spacing"] = -7,
			},
			["movers"] = {
				["ElvUF_PlayerCastbarMover"] = "BOTTOMElvUIParentBOTTOM-231147",
				["LocationLiteMover"] = "TOPElvUIParentTOP0-7",
				["LeftChatMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT222",
				["GMMover"] = "TOPLEFTElvUIParentTOPLEFT155-4",
				["BuffsMover"] = "TOPRIGHTElvUIParentTOPRIGHT-189-3",
				["ElvUF_Raid10Mover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT4210",
				["BossButton"] = "BOTTOMElvUIParentBOTTOM0283",
				["DigSiteProgressBarMover"] = "BOTTOMElvUIParentBOTTOM0315",
				["ElvUF_RaidpetMover"] = "TOPLEFTElvUIParentTOPLEFT4-444",
				["ElvUF_FocusMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-442178",
				["ClassBarMover"] = "BOTTOMElvUIParentBOTTOM-1349",
				["MicrobarMover"] = "TOPLEFTElvUIParentTOPLEFT4-4",
				["ElvUF_Raid25Mover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT2179",
				["ExperienceBarMover"] = "BOTTOMElvUIParentBOTTOM047",
				["ElvUF_TargetTargetMover"] = "BOTTOMElvUIParentBOTTOM0164",
				["BuiDashboardMover"] = "TOPLEFTElvUIParentTOPLEFT4-8",
				["ElvUF_Raid40Mover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT4211",
				["MinimapMover"] = "TOPRIGHTElvUIParentTOPRIGHT-4-6",
				["ElvAB_1"] = "BOTTOMElvUIParentBOTTOM092",
				["ElvAB_2"] = "BOTTOMElvUIParentBOTTOM058",
				["PetAB"] = "BOTTOMElvUIParentBOTTOM013",
				["ElvUF_TargetMover"] = "BOTTOMElvUIParentBOTTOM231182",
				["ElvUF_PartyMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT4210",
				["ElvUF_PlayerMover"] = "BOTTOMElvUIParentBOTTOM-231182",
				["AltPowerBarMover"] = "TOPElvUIParentTOP0-66",
				["ElvAB_3"] = "BOTTOMElvUIParentBOTTOM29558",
				["ReputationBarMover"] = "TOPRIGHTElvUIParentTOPRIGHT-2-181",
				["ElvUF_PetMover"] = "BOTTOMElvUIParentBOTTOM0191",
				["tokenHolderMover"] = "TOPLEFTElvUIParentTOPLEFT4-119",
				["VehicleSeatMover"] = "TOPLEFTElvUIParentTOPLEFT155-81",
				["WatchFrameMover"] = "TOPRIGHTElvUIParentTOPRIGHT-122-292",
				["BNETMover"] = "TOPRIGHTElvUIParentTOPRIGHT-4-199",
				["ShiftAB"] = "BOTTOMElvUIParentBOTTOM0134",
				["ElvUF_TargetCastbarMover"] = "BOTTOMElvUIParentBOTTOM231147",
				["LocationMover"] = "TOPElvUIParentTOP0-7",
				["ArenaHeaderMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-56346",
				["TargetPowerBarMover"] = "BOTTOMElvUIParentBOTTOM247215",
				["ElvUF_TankMover"] = "TOPLEFTElvUIParentTOPLEFT4-292",
				["BossHeaderMover"] = "TOPRIGHTElvUIParentTOPRIGHT-56-397",
				["PlayerPowerBarMover"] = "BOTTOMElvUIParentBOTTOM-231215",
				["ElvAB_5"] = "BOTTOMElvUIParentBOTTOM-29558",
				["RightChatMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-222",
				["AlertFrameMover"] = "TOPElvUIParentTOP0-140",
				["DebuffsMover"] = "TOPRIGHTElvUIParentTOPRIGHT-189-134",
				["ElvUF_AssistMover"] = "TOPLEFTElvUIParentTOPLEFT4-392",
			},
			["tooltip"] = {
				["healthBar"] = {
					["fontSize"] = 9,
					["font"] = "Bui Prototype",
					["fontOutline"] = "OUTLINE",
				},
			},
			["unitframe"] = {
				["OORAlpha"] = 0.44,
				["statusbar"] = "Armory",
				["colors"] = {
					["castClassColor"] = true,
					["auraBarBuff"] = {
						["b"] = 0.87,
						["g"] = 0.44,
						["r"] = 0,
					},
					["transparentAurabars"] = true,
					["transparentCastbar"] = true,
				},
				["fontOutline"] = "MONOCROMEOUTLINE",
				["glowtime"] = 0.9000000000000001,
				["font"] = "Bui Visitor1",
				["units"] = {
					["raid10"] = {
						["horizontalSpacing"] = 9,
						["debuffs"] = {
							["anchorPoint"] = "TOPRIGHT",
							["sizeOverride"] = 16,
							["xOffset"] = -4,
							["enable"] = true,
							["yOffset"] = -7,
						},
						["power"] = {
							["power"] = false,
						},
						["positionOverride"] = "BOTTOMRIGHT",
						["rdebuffs"] = {
							["enable"] = false,
						},
						["growthDirection"] = "LEFT_UP",
						["health"] = {
							["frequentUpdates"] = true,
						},
						["height"] = 45,
						["verticalSpacing"] = 9,
						["healPrediction"] = true,
						["buffs"] = {
							["noConsolidated"] = false,
							["sizeOverride"] = 22,
							["useBlacklist"] = false,
							["enable"] = true,
							["playerOnly"] = false,
							["yOffset"] = -6,
							["clickThrough"] = true,
							["noDuration"] = false,
							["perrow"] = 1,
							["useFilter"] = "TurtleBuffs",
							["xOffset"] = 50,
						},
					},
					["targettarget"] = {
						["height"] = 24,
						["power"] = {
							["height"] = 5,
						},
					},
					["player"] = {
						["debuffs"] = {
							["attachTo"] = "BUFFS",
							["sizeOverride"] = 32,
							["yOffset"] = 2,
						},
						["portrait"] = {
							["enable"] = true,
							["overlay"] = true,
						},
						["power"] = {
							["height"] = 5,
							["detachedWidth"] = 298,
							["yOffset"] = -25,
						},
						["width"] = 300,
						["health"] = {
							["xOffset"] = 2,
							["yOffset"] = -25,
						},
						["threatStyle"] = "ICONTOPRIGHT",
						["height"] = 33,
						["buffs"] = {
							["enable"] = true,
							["sizeOverride"] = 30,
							["attachTo"] = "FRAME",
							["yOffset"] = 2,
						},
						["classbar"] = {
							["detachFromFrame"] = true,
							["detachedWidth"] = 140,
							["fill"] = "spaced",
						},
						["castbar"] = {
							["icon"] = false,
							["width"] = 300,
						},
					},
					["raid40"] = {
						["height"] = 30,
						["healPrediction"] = true,
						["health"] = {
							["frequentUpdates"] = true,
						},
						["growthDirection"] = "LEFT_UP",
					},
					["focus"] = {
						["castbar"] = {
							["height"] = 6,
							["width"] = 122,
						},
						["width"] = 122,
						["power"] = {
							["height"] = 5,
						},
					},
					["target"] = {
						["debuffs"] = {
							["anchorPoint"] = "TOPLEFT",
						},
						["portrait"] = {
							["enable"] = true,
							["overlay"] = true,
						},
						["power"] = {
							["xOffset"] = 2,
							["height"] = 5,
							["hideonnpc"] = false,
							["detachedWidth"] = 298,
							["yOffset"] = -25,
						},
						["width"] = 300,
						["health"] = {
							["xOffset"] = -40,
							["text_format"] = "",
							["yOffset"] = -25,
						},
						["threatStyle"] = "ICONTOPLEFT",
						["height"] = 33,
						["buffs"] = {
							["anchorPoint"] = "TOPLEFT",
							["sizeOverride"] = 30,
							["yOffset"] = 2,
						},
						["name"] = {
							["xOffset"] = 8,
							["yOffset"] = -25,
							["text_format"] = "[healthcolor][health:current-percent] [namecolor][name:medium] [difficultycolor][smartlevel] [shortclassification]",
							["position"] = "RIGHT",
						},
						["castbar"] = {
							["icon"] = false,
							["width"] = 300,
						},
					},
					["party"] = {
						["horizontalSpacing"] = 9,
						["debuffs"] = {
							["anchorPoint"] = "TOPRIGHT",
							["sizeOverride"] = 16,
							["xOffset"] = -4,
							["yOffset"] = -7,
						},
						["power"] = {
							["text_format"] = "",
						},
						["healPrediction"] = true,
						["growthDirection"] = "LEFT_UP",
						["roleIcon"] = {
							["position"] = "BOTTOMRIGHT",
						},
						["GPSArrow"] = {
							["size"] = 40,
						},
						["health"] = {
							["frequentUpdates"] = true,
							["text_format"] = "[healthcolor][health:deficit]",
							["position"] = "BOTTOM",
						},
						["verticalSpacing"] = 9,
						["height"] = 45,
						["buffs"] = {
							["noConsolidated"] = false,
							["sizeOverride"] = 22,
							["useBlacklist"] = false,
							["enable"] = true,
							["playerOnly"] = false,
							["yOffset"] = -6,
							["clickThrough"] = true,
							["noDuration"] = false,
							["perrow"] = 1,
							["useFilter"] = "TurtleBuffs",
							["xOffset"] = 50,
						},
						["name"] = {
							["text_format"] = "[namecolor][name:short]",
							["position"] = "TOP",
						},
						["width"] = 80,
					},
					["raid25"] = {
						["horizontalSpacing"] = 9,
						["debuffs"] = {
							["anchorPoint"] = "TOPRIGHT",
							["sizeOverride"] = 16,
							["xOffset"] = -4,
							["enable"] = true,
							["yOffset"] = -7,
						},
						["power"] = {
							["enable"] = false,
						},
						["rdebuffs"] = {
							["enable"] = false,
						},
						["growthDirection"] = "LEFT_UP",
						["health"] = {
							["frequentUpdates"] = true,
						},
						["height"] = 45,
						["verticalSpacing"] = 9,
						["healPrediction"] = true,
						["buffs"] = {
							["noConsolidated"] = false,
							["sizeOverride"] = 22,
							["useBlacklist"] = false,
							["enable"] = true,
							["playerOnly"] = false,
							["yOffset"] = -6,
							["clickThrough"] = true,
							["noDuration"] = false,
							["perrow"] = 1,
							["useFilter"] = "TurtleBuffs",
							["xOffset"] = 50,
						},
					},
					["pet"] = {
						["height"] = 24,
						["power"] = {
							["height"] = 5,
						},
					},
				},
			},
			["datatexts"] = {
				["font"] = "Bui Visitor1",
				["fontOutline"] = "MONOCROMEOUTLINE",
				["panelTransparency"] = true,
				["leftChatPanel"] = false,
				["panels"] = {
					["BuiRightChatDTPanel"] = {
						["left"] = "Mastery",
					},
					["BuiLeftChatDTPanel"] = {
						["middle"] = "Haste",
						["right"] = "BuiMail",
					},
					["LeftChatDataPanel"] = {
						["left"] = "Spell/Heal Power",
						["right"] = "Haste",
					},
				},
				["rightChatPanel"] = false,
			},
			["loclite"] = {
				["lpfont"] = "Bui Visitor1",
				["lpfontsize"] = 10,
				["lpfontflags"] = "MONOCHROMEOUTLINE",
				["lpwidth"] = 220,
				["dtheight"] = 16,
				["lpauto"] = false,
				["trunc"] = true,
			},
			["actionbar"] = {
				["bar3"] = {
					["buttons"] = 10,
					["buttonspacing"] = 4,
					["buttonsPerRow"] = 5,
					["backdrop"] = true,
					["buttonsize"] = 30,
				},
				["bar2"] = {
					["enabled"] = true,
					["buttonspacing"] = 4,
					["heightMult"] = 2,
					["backdrop"] = true,
					["buttonsize"] = 30,
				},
				["bar1"] = {
					["buttonspacing"] = 4,
					["buttonsize"] = 30,
				},
				["bar5"] = {
					["buttons"] = 10,
					["buttonspacing"] = 4,
					["buttonsPerRow"] = 5,
					["backdrop"] = true,
					["buttonsize"] = 30,
				},
				["font"] = "Bui Visitor1",
				["fontOutline"] = "MONOCROMEOUTLINE",
				["stanceBar"] = {
					["buttonsize"] = 24,
				},
				["barPet"] = {
					["buttonspacing"] = 4,
					["buttonsPerRow"] = 10,
					["buttonsize"] = 27,
				},
				["bar4"] = {
					["enabled"] = false,
					["buttonsize"] = 26,
					["buttonspacing"] = 4,
				},
			},
			["chat"] = {
				["tabFont"] = "Bui Visitor1",
				["font"] = "Bui Prototype",
				["tabFontOutline"] = "MONOCROMEOUTLINE",
				["panelHeight"] = 150,
			},
			["bui"] = {
				["installed"] = true,
			},
		},
		["WARLOCK"] = {
			["nameplate"] = {
				["font"] = "Bui Visitor1",
			},
			["currentTutorial"] = 3,
			["general"] = {
				["fontSize"] = 10,
				["stickyFrames"] = false,
				["backdropcolor"] = {
					["b"] = 0.1176470588235294,
					["g"] = 0.08627450980392157,
					["r"] = 0.07058823529411765,
				},
				["topPanel"] = false,
				["minimap"] = {
					["locationText"] = "HIDE",
					["size"] = 199,
				},
				["font"] = "Bui Prototype",
				["bottomPanel"] = false,
				["backdropfadecolor"] = {
					["r"] = 0.08627450980392157,
					["g"] = 0.1098039215686275,
					["b"] = 0.1490196078431373,
				},
				["valuecolor"] = {
					["a"] = 1,
					["r"] = 1,
					["g"] = 0.5,
					["b"] = 0,
				},
				["reputation"] = {
					["textFormat"] = "CURPERC",
					["mouseover"] = true,
					["width"] = 412,
				},
				["experience"] = {
					["width"] = 412,
					["textFormat"] = "CURPERC",
				},
			},
			["xprep"] = {
				["textFormat"] = "CURMAX",
			},
			["ufb"] = {
				["barheight"] = 15,
			},
			["hideTutorial"] = 1,
			["chat"] = {
				["tabFont"] = "Bui Visitor1",
				["font"] = "Bui Prototype",
				["tabFontOutline"] = "MONOCROMEOUTLINE",
				["panelHeight"] = 150,
			},
			["locplus"] = {
				["lpfont"] = "Bui Visitor1",
				["dtheight"] = 16,
				["lpauto"] = false,
				["both"] = false,
				["lpfontsize"] = 10,
				["trunc"] = true,
				["displayOther"] = "NONE",
				["lpfontflags"] = "MONOCHROMEOUTLINE",
				["lpwidth"] = 220,
				["dtwidth"] = 120,
			},
			["layoutSet"] = "dpsCaster",
			["VAT"] = {
				["barHeight"] = 6,
				["enableStaticColor"] = true,
				["spacing"] = -7,
			},
			["movers"] = {
				["ElvUF_PlayerCastbarMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT486352",
				["LocationLiteMover"] = "TOPElvUIParentTOP0-7",
				["LeftChatMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT222",
				["GMMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT0171",
				["BuffsMover"] = "TOPRIGHTElvUIParentTOPRIGHT-2370",
				["ElvUF_Raid10Mover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT4210",
				["BossButton"] = "BOTTOMElvUIParentBOTTOM-25810",
				["LootFrameMover"] = "TOPLEFTElvUIParentTOPLEFT200-271",
				["DigSiteProgressBarMover"] = "BOTTOMElvUIParentBOTTOM0315",
				["ElvUF_RaidpetMover"] = "TOPLEFTElvUIParentTOPLEFT0-407",
				["ElvUF_FocusMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-479265",
				["ClassBarMover"] = "BOTTOMElvUIParentBOTTOM-2257",
				["MicrobarMover"] = "TOPLEFTElvUIParentTOPLEFT00",
				["ElvUF_AssistMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT0457",
				["VehicleSeatMover"] = "TOPLEFTElvUIParentTOPLEFT00",
				["MinimapButtonAnchor"] = "TOPRIGHTElvUIParentTOPRIGHT0-223",
				["ExperienceBarMover"] = "TOPElvUIParentTOP-15-10",
				["LossControlMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT503188",
				["ElvUF_TargetMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-481392",
				["RightChatMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-222",
				["BuiDashboardMover"] = "TOPLEFTElvUIParentTOPLEFT139-153",
				["ElvUF_Raid40Mover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT4211",
				["PetAB"] = "BOTTOMElvUIParentBOTTOM00",
				["ElvUF_PetMover"] = "BOTTOMElvUIParentBOTTOM-71152",
				["ElvAB_1"] = "BOTTOMElvUIParentBOTTOM-1220",
				["ElvAB_2"] = "BOTTOMElvUIParentBOTTOM1185",
				["tokenHolderMover"] = "TOPLEFTElvUIParentTOPLEFT4-119",
				["ElvUF_PlayerMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT484386",
				["ElvAB_4"] = "BOTTOMElvUIParentBOTTOM286",
				["ReputationBarMover"] = "TOPElvUIParentTOP-290",
				["AltPowerBarMover"] = "BOTTOMElvUIParentBOTTOM2460",
				["ElvAB_3"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT48155",
				["ElvAB_5"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-48762",
				["ElvAB_6"] = "BOTTOMElvUIParentBOTTOM255",
				["ElvUF_Raid25Mover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT2179",
				["WatchFrameMover"] = "TOPRIGHTElvUIParentTOPRIGHT-91-256",
				["ElvUF_TargetCastbarMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-481360",
				["BNETMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT164170",
				["ShiftAB"] = "BOTTOMElvUIParentBOTTOM0134",
				["TargetPowerBarMover"] = "BOTTOMElvUIParentBOTTOM247215",
				["LocationMover"] = "TOPElvUIParentTOP0-7",
				["ArenaHeaderMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT0406",
				["ElvUF_TargetTargetMover"] = "BOTTOMElvUIParentBOTTOM72152",
				["ElvUF_TankMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT0539",
				["BossHeaderMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT0360",
				["PlayerPowerBarMover"] = "BOTTOMElvUIParentBOTTOM-231215",
				["TotemBarMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT4120",
				["ElvUF_PartyMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT4210",
				["AlertFrameMover"] = "TOPRIGHTElvUIParentTOPRIGHT-298-271",
				["DebuffsMover"] = "TOPRIGHTElvUIParentTOPRIGHT-237-138",
				["MinimapMover"] = "TOPRIGHTElvUIParentTOPRIGHT00",
			},
			["tooltip"] = {
				["healthBar"] = {
					["fontSize"] = 9,
					["font"] = "Bui Prototype",
					["fontOutline"] = "OUTLINE",
				},
			},
			["unitframe"] = {
				["statusbar"] = "BuiFlat",
				["colors"] = {
					["auraBarBuff"] = {
						["r"] = 0.1,
						["g"] = 0.1,
						["b"] = 0.1,
					},
					["health"] = {
						["r"] = 0.1,
						["g"] = 0.1,
						["b"] = 0.1,
					},
					["castColor"] = {
						["r"] = 0.1,
						["g"] = 0.1,
						["b"] = 0.1,
					},
					["transparentCastbar"] = true,
					["transparentAurabars"] = true,
				},
				["fontOutline"] = "MONOCROMEOUTLINE",
				["font"] = "Bui Visitor1",
				["units"] = {
					["player"] = {
						["debuffs"] = {
							["attachTo"] = "BUFFS",
							["sizeOverride"] = 32,
							["yOffset"] = 2,
						},
						["portrait"] = {
							["enable"] = true,
							["overlay"] = true,
						},
						["power"] = {
							["height"] = 5,
							["detachedWidth"] = 298,
							["yOffset"] = -25,
						},
						["width"] = 269,
						["castbar"] = {
							["icon"] = false,
							["width"] = 269,
						},
						["health"] = {
							["xOffset"] = 2,
							["yOffset"] = -25,
						},
						["threatStyle"] = "ICONTOPRIGHT",
						["height"] = 35,
						["buffs"] = {
							["attachTo"] = "FRAME",
							["sizeOverride"] = 26,
							["enable"] = true,
							["noDuration"] = false,
							["yOffset"] = 2,
						},
						["classbar"] = {
							["detachFromFrame"] = true,
							["height"] = 6,
							["detachedWidth"] = 189,
							["fill"] = "spaced",
						},
						["aurabar"] = {
							["enable"] = false,
						},
					},
					["target"] = {
						["debuffs"] = {
							["anchorPoint"] = "TOPLEFT",
							["sizeOverride"] = 32,
							["yOffset"] = 2,
						},
						["portrait"] = {
							["enable"] = true,
							["overlay"] = true,
						},
						["power"] = {
							["height"] = 5,
							["hideonnpc"] = false,
							["detachedWidth"] = 298,
							["yOffset"] = -25,
						},
						["width"] = 269,
						["castbar"] = {
							["icon"] = false,
							["width"] = 269,
						},
						["name"] = {
							["text_format"] = "",
							["position"] = "RIGHT",
						},
						["health"] = {
							["xOffset"] = 2,
							["yOffset"] = -25,
						},
						["height"] = 35,
						["buffs"] = {
							["anchorPoint"] = "TOPLEFT",
							["sizeOverride"] = 26,
							["yOffset"] = 2,
						},
						["threatStyle"] = "ICONTOPRIGHT",
						["aurabar"] = {
							["enable"] = false,
							["maxDuration"] = 120,
						},
					},
					["focus"] = {
						["castbar"] = {
							["height"] = 6,
							["width"] = 122,
						},
						["width"] = 122,
						["power"] = {
							["height"] = 5,
						},
					},
					["raid25"] = {
						["power"] = {
							["enable"] = false,
						},
					},
					["targettarget"] = {
						["debuffs"] = {
							["enable"] = false,
							["sizeOverride"] = 32,
							["bossAuras"] = true,
						},
						["threatStyle"] = "GLOW",
						["power"] = {
							["height"] = 5,
						},
						["height"] = 17,
						["buffs"] = {
							["bossAuras"] = true,
							["sizeOverride"] = 26,
						},
						["width"] = 96,
					},
					["pet"] = {
						["height"] = 17,
						["width"] = 96,
						["power"] = {
							["height"] = 5,
						},
					},
					["raid10"] = {
						["power"] = {
							["power"] = false,
						},
					},
				},
			},
			["datatexts"] = {
				["font"] = "Bui Visitor1",
				["fontOutline"] = "MONOCROMEOUTLINE",
				["panelTransparency"] = true,
				["leftChatPanel"] = false,
				["panels"] = {
					["BuiRightChatDTPanel"] = {
						["left"] = "Mastery",
					},
					["BuiLeftChatDTPanel"] = {
						["middle"] = "Haste",
						["right"] = "BuiMail",
					},
					["LeftChatDataPanel"] = {
						["left"] = "Spell/Heal Power",
						["right"] = "Haste",
					},
				},
				["rightChatPanel"] = false,
			},
			["loclite"] = {
				["lpfont"] = "Bui Visitor1",
				["lpfontsize"] = 10,
				["lpfontflags"] = "MONOCHROMEOUTLINE",
				["lpwidth"] = 220,
				["dtheight"] = 16,
				["lpauto"] = false,
				["trunc"] = true,
			},
			["bui"] = {
				["installed"] = true,
			},
			["actionbar"] = {
				["bar3"] = {
					["buttons"] = 10,
					["buttonspacing"] = 4,
					["buttonsPerRow"] = 5,
					["backdrop"] = true,
					["buttonsize"] = 26,
				},
				["bar6"] = {
					["enabled"] = true,
					["buttonspacing"] = 4,
					["backdrop"] = true,
					["buttonsize"] = 28,
					["heightMult"] = 2,
				},
				["bar2"] = {
					["enabled"] = true,
					["buttonsize"] = 30,
					["buttons"] = 7,
				},
				["bar1"] = {
					["buttons"] = 6,
				},
				["bar5"] = {
					["buttons"] = 10,
					["buttonspacing"] = 4,
					["buttonsPerRow"] = 5,
					["backdrop"] = true,
					["buttonsize"] = 26,
				},
				["font"] = "Bui Visitor1",
				["fontOutline"] = "MONOCROMEOUTLINE",
				["stanceBar"] = {
					["buttonsize"] = 24,
				},
				["barPet"] = {
					["buttonspacing"] = 4,
					["buttonsPerRow"] = 10,
					["mouseover"] = true,
					["buttonsize"] = 20,
				},
				["bar4"] = {
					["buttonspacing"] = 4,
					["buttonsPerRow"] = 12,
					["backdrop"] = false,
					["buttonsize"] = 28,
				},
			},
			["utils"] = {
				["dwidth"] = 120,
				["enableTokens"] = false,
				["enableSystem"] = false,
				["twidth"] = 120,
			},
			["auras"] = {
				["timeXOffset"] = -1,
				["font"] = "Bui Visitor1",
				["fontOutline"] = "MONOCROMEOUTLINE",
				["fadeThreshold"] = 10,
				["buffs"] = {
					["horizontalSpacing"] = 3,
					["size"] = 30,
				},
				["debuffs"] = {
					["size"] = 30,
				},
				["consolidatedBuffs"] = {
					["fontOutline"] = "MONOCROMEOUTLINE",
					["font"] = "Bui Visitor1",
				},
			},
		},
		["Drominus - Area 52"] = {
			["bui"] = {
				["installed"] = true,
			},
			["currentTutorial"] = 2,
			["RightChatPanelFaded"] = true,
		},
		["Gaulthain - Skywall"] = {
			["unitframe"] = {
				["units"] = {
					["boss"] = {
						["castbar"] = {
							["height"] = 5.999995231628418,
							["width"] = 0,
						},
					},
					["focus"] = {
						["castbar"] = {
							["height"] = 5.999995231628418,
							["width"] = 189.9999694824219,
						},
					},
					["target"] = {
						["castbar"] = {
							["height"] = 8.999998092651367,
						},
					},
					["arena"] = {
						["castbar"] = {
							["height"] = 5.999995231628418,
							["width"] = 193,
						},
					},
					["player"] = {
						["castbar"] = {
							["height"] = 8.999998092651367,
							["width"] = 269.9999694824219,
						},
					},
				},
			},
		},
		["Malkyn - Dragonblight"] = {
		},
		["Cecliann - Skywall"] = {
			["bui"] = {
				["installed"] = true,
			},
			["currentTutorial"] = 2,
			["general"] = {
				["fontSize"] = 10,
				["stickyFrames"] = false,
				["backdropcolor"] = {
					["b"] = 0.0392156862745098,
					["g"] = 0.05490196078431373,
					["r"] = 0.1058823529411765,
				},
				["topPanel"] = false,
				["minimap"] = {
					["locationText"] = "HIDE",
					["size"] = 150,
				},
				["font"] = "Bui Prototype",
				["bottomPanel"] = false,
				["backdropfadecolor"] = {
					["b"] = 0.05098039215686274,
					["g"] = 0.05490196078431373,
					["r"] = 0.1254901960784314,
				},
				["valuecolor"] = {
					["a"] = 1,
					["b"] = 0,
					["g"] = 0.5,
					["r"] = 1,
				},
				["reputation"] = {
					["enable"] = false,
					["textFormat"] = "CURPERC",
					["textSize"] = 8,
					["width"] = 180,
				},
				["experience"] = {
					["enable"] = false,
					["textFormat"] = "CURPERC",
					["width"] = 412,
				},
			},
			["xprep"] = {
				["show"] = "XP",
				["textFormat"] = "CURMAX",
			},
			["ufb"] = {
				["barheight"] = 15,
			},
			["hideTutorial"] = 1,
			["auras"] = {
				["timeXOffset"] = -1,
				["font"] = "Bui Visitor1",
				["fontOutline"] = "MONOCROMEOUTLINE",
				["fadeThreshold"] = 10,
				["buffs"] = {
					["horizontalSpacing"] = 3,
					["size"] = 30,
				},
				["debuffs"] = {
					["size"] = 30,
				},
				["consolidatedBuffs"] = {
					["fontOutline"] = "MONOCROMEOUTLINE",
					["font"] = "Bui Visitor1",
				},
			},
			["locplus"] = {
				["lpfont"] = "Bui Visitor1",
				["dtheight"] = 16,
				["lpauto"] = false,
				["both"] = false,
				["lpfontsize"] = 10,
				["trunc"] = true,
				["displayOther"] = "NONE",
				["lpfontflags"] = "MONOCHROMEOUTLINE",
				["lpwidth"] = 220,
				["dtwidth"] = 120,
			},
			["layoutSet"] = "dpsMelee",
			["VAT"] = {
				["barHeight"] = 6,
				["enableStaticColor"] = true,
				["spacing"] = -7,
			},
			["movers"] = {
				["ElvUF_PlayerCastbarMover"] = "BOTTOMElvUIParentBOTTOM-231147",
				["LocationLiteMover"] = "TOPElvUIParentTOP0-7",
				["LeftChatMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT222",
				["GMMover"] = "TOPLEFTElvUIParentTOPLEFT155-4",
				["BuffsMover"] = "TOPRIGHTElvUIParentTOPRIGHT-189-3",
				["ElvUF_Raid10Mover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT4210",
				["BossButton"] = "BOTTOMElvUIParentBOTTOM0283",
				["DigSiteProgressBarMover"] = "BOTTOMElvUIParentBOTTOM0315",
				["ElvUF_RaidpetMover"] = "TOPLEFTElvUIParentTOPLEFT4-444",
				["ElvUF_FocusMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-442178",
				["ClassBarMover"] = "BOTTOMElvUIParentBOTTOM-1349",
				["MicrobarMover"] = "TOPLEFTElvUIParentTOPLEFT4-4",
				["VehicleSeatMover"] = "TOPLEFTElvUIParentTOPLEFT155-81",
				["ExperienceBarMover"] = "BOTTOMElvUIParentBOTTOM047",
				["ElvUF_TargetMover"] = "BOTTOMElvUIParentBOTTOM231182",
				["BuiDashboardMover"] = "TOPLEFTElvUIParentTOPLEFT4-8",
				["ElvUF_Raid40Mover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT4211",
				["MinimapMover"] = "TOPRIGHTElvUIParentTOPRIGHT-4-6",
				["ElvAB_1"] = "BOTTOMElvUIParentBOTTOM092",
				["ElvAB_2"] = "BOTTOMElvUIParentBOTTOM058",
				["PetAB"] = "BOTTOMElvUIParentBOTTOM013",
				["TargetPowerBarMover"] = "BOTTOMElvUIParentBOTTOM247215",
				["RightChatMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-222",
				["ElvUF_PetMover"] = "BOTTOMElvUIParentBOTTOM0191",
				["AltPowerBarMover"] = "TOPElvUIParentTOP0-66",
				["ElvAB_3"] = "BOTTOMElvUIParentBOTTOM29558",
				["ReputationBarMover"] = "TOPRIGHTElvUIParentTOPRIGHT-2-181",
				["WatchFrameMover"] = "TOPRIGHTElvUIParentTOPRIGHT-122-292",
				["tokenHolderMover"] = "TOPLEFTElvUIParentTOPLEFT4-119",
				["ElvUF_TargetTargetMover"] = "BOTTOMElvUIParentBOTTOM0164",
				["ElvUF_Raid25Mover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT2179",
				["BNETMover"] = "TOPRIGHTElvUIParentTOPRIGHT-4-199",
				["ShiftAB"] = "BOTTOMElvUIParentBOTTOM0134",
				["ElvUF_TargetCastbarMover"] = "BOTTOMElvUIParentBOTTOM231147",
				["ElvUF_PlayerMover"] = "BOTTOMElvUIParentBOTTOM-231182",
				["ArenaHeaderMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-56346",
				["LocationMover"] = "TOPElvUIParentTOP0-7",
				["ElvUF_TankMover"] = "TOPLEFTElvUIParentTOPLEFT4-292",
				["BossHeaderMover"] = "TOPRIGHTElvUIParentTOPRIGHT-56-397",
				["PlayerPowerBarMover"] = "BOTTOMElvUIParentBOTTOM-231215",
				["ElvAB_5"] = "BOTTOMElvUIParentBOTTOM-29558",
				["ElvUF_PartyMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT4210",
				["AlertFrameMover"] = "TOPElvUIParentTOP0-140",
				["DebuffsMover"] = "TOPRIGHTElvUIParentTOPRIGHT-189-134",
				["ElvUF_AssistMover"] = "TOPLEFTElvUIParentTOPLEFT4-392",
			},
			["tooltip"] = {
				["healthBar"] = {
					["fontSize"] = 9,
					["font"] = "Bui Prototype",
					["fontOutline"] = "OUTLINE",
				},
			},
			["unitframe"] = {
				["statusbar"] = "BuiFlat",
				["colors"] = {
					["auraBarBuff"] = {
						["b"] = 0.1,
						["g"] = 0.1,
						["r"] = 0.1,
					},
					["health"] = {
						["b"] = 0.1,
						["g"] = 0.1,
						["r"] = 0.1,
					},
					["castColor"] = {
						["b"] = 0.1,
						["g"] = 0.1,
						["r"] = 0.1,
					},
					["transparentCastbar"] = true,
					["transparentAurabars"] = true,
				},
				["fontOutline"] = "MONOCROMEOUTLINE",
				["font"] = "Bui Visitor1",
				["units"] = {
					["raid10"] = {
						["power"] = {
							["power"] = false,
						},
					},
					["targettarget"] = {
						["height"] = 24,
						["power"] = {
							["height"] = 5,
						},
					},
					["boss"] = {
						["castbar"] = {
							["height"] = 5.999995231628418,
							["width"] = 0,
						},
					},
					["pet"] = {
						["height"] = 24,
						["power"] = {
							["height"] = 5,
						},
					},
					["focus"] = {
						["castbar"] = {
							["height"] = 4.000008583068848,
							["width"] = 121.9999389648438,
						},
						["width"] = 122,
						["power"] = {
							["height"] = 5,
						},
					},
					["target"] = {
						["debuffs"] = {
							["anchorPoint"] = "TOPLEFT",
						},
						["portrait"] = {
							["enable"] = true,
							["overlay"] = true,
						},
						["castbar"] = {
							["height"] = 4.000008583068848,
							["icon"] = false,
							["width"] = 299.9999694824219,
						},
						["width"] = 300,
						["power"] = {
							["height"] = 5,
							["xOffset"] = 2,
							["hideonnpc"] = false,
							["detachedWidth"] = 298,
							["yOffset"] = -25,
						},
						["name"] = {
							["xOffset"] = 8,
							["yOffset"] = -25,
							["text_format"] = "[healthcolor][health:current-percent] [namecolor][name:medium] [difficultycolor][smartlevel] [shortclassification]",
							["position"] = "RIGHT",
						},
						["health"] = {
							["xOffset"] = -40,
							["text_format"] = "",
							["yOffset"] = -25,
						},
						["height"] = 33,
						["buffs"] = {
							["anchorPoint"] = "TOPLEFT",
							["sizeOverride"] = 30,
							["yOffset"] = 2,
						},
						["threatStyle"] = "ICONTOPLEFT",
						["aurabar"] = {
							["enable"] = false,
						},
					},
					["arena"] = {
						["castbar"] = {
							["height"] = 5.999995231628418,
							["width"] = 193,
						},
					},
					["raid25"] = {
						["power"] = {
							["enable"] = false,
						},
					},
					["player"] = {
						["debuffs"] = {
							["attachTo"] = "BUFFS",
							["sizeOverride"] = 32,
							["yOffset"] = 2,
						},
						["portrait"] = {
							["enable"] = true,
							["overlay"] = true,
						},
						["power"] = {
							["height"] = 5,
							["detachedWidth"] = 298,
							["yOffset"] = -25,
						},
						["width"] = 300,
						["threatStyle"] = "ICONTOPRIGHT",
						["health"] = {
							["xOffset"] = 2,
							["yOffset"] = -25,
						},
						["castbar"] = {
							["height"] = 4.000008583068848,
							["icon"] = false,
							["width"] = 299.9999694824219,
						},
						["height"] = 33,
						["buffs"] = {
							["attachTo"] = "FRAME",
							["sizeOverride"] = 30,
							["enable"] = true,
							["noDuration"] = false,
							["yOffset"] = 2,
						},
						["classbar"] = {
							["detachFromFrame"] = true,
							["detachedWidth"] = 140,
							["fill"] = "spaced",
						},
						["aurabar"] = {
							["enable"] = false,
						},
					},
				},
			},
			["datatexts"] = {
				["font"] = "Bui Visitor1",
				["fontOutline"] = "MONOCROMEOUTLINE",
				["panelTransparency"] = true,
				["leftChatPanel"] = false,
				["panels"] = {
					["BuiRightChatDTPanel"] = {
						["left"] = "Mastery",
						["middle"] = "Bags",
					},
					["BuiLeftChatDTPanel"] = {
						["middle"] = "Haste",
						["right"] = "BuiMail",
					},
					["LeftChatDataPanel"] = {
						["left"] = "Attack Power",
						["right"] = "Haste",
					},
				},
				["rightChatPanel"] = false,
			},
			["loclite"] = {
				["lpfont"] = "Bui Visitor1",
				["lpfontsize"] = 10,
				["lpfontflags"] = "MONOCHROMEOUTLINE",
				["lpwidth"] = 220,
				["dtheight"] = 16,
				["lpauto"] = false,
				["trunc"] = true,
			},
			["chat"] = {
				["tabFont"] = "Bui Visitor1",
				["font"] = "Bui Prototype",
				["tabFontOutline"] = "MONOCROMEOUTLINE",
				["panelHeight"] = 150,
			},
			["nameplate"] = {
				["font"] = "Bui Visitor1",
			},
			["actionbar"] = {
				["bar3"] = {
					["buttons"] = 10,
					["buttonspacing"] = 4,
					["buttonsPerRow"] = 5,
					["backdrop"] = true,
					["buttonsize"] = 30,
				},
				["bar2"] = {
					["enabled"] = true,
					["buttonspacing"] = 4,
					["backdrop"] = true,
					["buttonsize"] = 30,
					["heightMult"] = 2,
				},
				["bar1"] = {
					["buttonspacing"] = 4,
					["buttonsize"] = 30,
				},
				["bar5"] = {
					["buttons"] = 10,
					["buttonspacing"] = 4,
					["buttonsPerRow"] = 5,
					["backdrop"] = true,
					["buttonsize"] = 30,
				},
				["font"] = "Bui Visitor1",
				["fontOutline"] = "MONOCROMEOUTLINE",
				["stanceBar"] = {
					["buttonsize"] = 24,
				},
				["barPet"] = {
					["buttonspacing"] = 4,
					["buttonsPerRow"] = 10,
					["buttonsize"] = 27,
				},
				["bar4"] = {
					["buttonspacing"] = 4,
					["buttonsize"] = 26,
				},
			},
		},
		["Feronaz - Skywall"] = {
			["bui"] = {
				["installed"] = true,
			},
			["currentTutorial"] = 2,
		},
	},
}
ElvPrivateDB = {
	["profileKeys"] = {
		["Dalhian - Skywall"] = "Dalhian - Skywall",
		["Drominus - Area 52"] = "Drominus - Area 52",
		["Gaulthain - Skywall"] = "Gaulthain - Skywall",
		["Feronis - Skywall"] = "Feronis - Skywall",
		["Gurund - Area 52"] = "Gurund - Area 52",
		["Drominus - Skywall"] = "Drominus - Skywall",
		["Olegregg - Area 52"] = "Olegregg - Area 52",
		["Anaiis - Skywall"] = "Anaiis - Skywall",
		["Oldfero - Area 52"] = "Oldfero - Area 52",
		["Gurund - Skywall"] = "Gurund - Skywall",
		["Cidareth - Skywall"] = "Cidareth - Skywall",
		["Feronaz - Area 52"] = "Feronaz - Area 52",
		["Noremedy - Skywall"] = "Noremedy - Skywall",
		["Toradol - Skywall"] = "Toradol - Skywall",
		["Gaulthain - Area 52"] = "Gaulthain - Area 52",
		["Malkyn - Dragonblight"] = "Malkyn - Dragonblight",
		["Cecliann - Skywall"] = "Cecliann - Skywall",
		["Feronaz - Skywall"] = "Feronaz - Skywall",
	},
	["profiles"] = {
		["Dalhian - Skywall"] = {
			["theme"] = "classic",
			["general"] = {
				["selectquestreward"] = false,
				["chatBubbles"] = "nobackdrop",
				["autorepchange"] = false,
				["namefont"] = "ElvUI Alt-Font",
				["minimapbar"] = {
					["mouseover"] = true,
				},
				["minimap"] = {
					["hideincombat"] = true,
					["fadeindelay"] = 2,
				},
			},
			["install_complete"] = "6.9996",
		},
		["Drominus - Area 52"] = {
			["general"] = {
				["raidmarkerbar"] = {
					["backdrop"] = true,
				},
				["normTex"] = "Glaze2",
				["minimapbar"] = {
					["backdrop"] = true,
					["mouseover"] = true,
				},
			},
			["install_complete"] = "6.9997",
		},
		["Gaulthain - Skywall"] = {
			["general"] = {
				["minimapbar"] = {
					["mouseover"] = true,
				},
				["raidmarkerbar"] = {
					["backdrop"] = true,
					["enable"] = false,
				},
				["namefont"] = "2002 Bold",
				["minimap"] = {
					["hideincombat"] = true,
				},
				["glossTex"] = "Armory",
			},
			["farmer"] = {
				["enabled"] = false,
			},
			["addonskins"] = {
				["EmbedLeftChat"] = true,
				["EmbedBelowTop"] = true,
				["TransparentEmbed"] = true,
			},
			["theme"] = "default",
			["install_complete"] = "6.9996",
		},
		["Feronis - Skywall"] = {
			["theme"] = "default",
			["install_complete"] = "6.9996",
		},
		["Gurund - Area 52"] = {
			["general"] = {
				["minimapbar"] = {
					["mouseover"] = true,
				},
			},
			["install_complete"] = "6.9999",
		},
		["Drominus - Skywall"] = {
			["general"] = {
				["raidmarkerbar"] = {
					["enable"] = false,
				},
				["namefont"] = "2002",
				["minimapbar"] = {
					["backdrop"] = true,
					["mouseover"] = true,
				},
			},
			["farmer"] = {
				["enabled"] = false,
			},
			["addonskins"] = {
				["EmbedLeftChat"] = true,
				["EmbedOoC"] = true,
				["EmbedBelowTop"] = true,
				["DBMFontSize"] = 14,
				["DBMFont"] = "2002",
				["EmbedSystem"] = true,
			},
			["theme"] = "classic",
			["install_complete"] = "6.9996",
		},
		["Olegregg - Area 52"] = {
			["general"] = {
				["minimapbar"] = {
					["mouseover"] = true,
				},
				["chatBubbles"] = "nobackdrop",
			},
			["install_complete"] = "6.9999",
		},
		["Anaiis - Skywall"] = {
			["install_complete"] = "6.9996",
		},
		["Oldfero - Area 52"] = {
			["general"] = {
				["minimapbar"] = {
					["mouseover"] = true,
					["backdrop"] = true,
				},
				["dmgfont"] = "2002 Bold",
				["namefont"] = "ElvUI Alt-Font",
				["chatBubbles"] = "nobackdrop",
				["minimap"] = {
					["fadeindelay"] = 2,
				},
			},
			["CBPO"] = {
				["warned"] = true,
			},
			["farmer"] = {
				["enabled"] = false,
			},
			["addonskins"] = {
				["DBMSkinHalf"] = true,
				["DBMFont"] = "Friz Quadrata TT",
				["EmbedLeftWidth"] = 132,
				["DBMFontSize"] = 14,
				["DBMFontFlag"] = "THICKOUTLINE",
				["BigWigsHalfBar"] = true,
			},
			["theme"] = "default",
			["install_complete"] = "6.9999",
		},
		["Gurund - Skywall"] = {
		},
		["Cidareth - Skywall"] = {
		},
		["Feronaz - Area 52"] = {
			["theme"] = "class",
			["general"] = {
				["raidmarkerbar"] = {
					["enable"] = false,
				},
				["minimapbar"] = {
					["backdrop"] = true,
					["mouseover"] = true,
				},
			},
			["install_complete"] = "6.9998",
		},
		["Noremedy - Skywall"] = {
			["equipment"] = {
				["misc"] = {
					["setoverlay"] = false,
				},
			},
			["farmer"] = {
				["enabled"] = false,
			},
			["general"] = {
				["pixelPerfect"] = false,
				["namefont"] = "2002 Bold",
				["raidmarkerbar"] = {
					["enable"] = false,
				},
				["minimapbar"] = {
					["mouseover"] = true,
					["backdrop"] = true,
				},
			},
			["install_complete"] = "6.9996",
		},
		["Toradol - Skywall"] = {
			["install_complete"] = "6.9996",
		},
		["Gaulthain - Area 52"] = {
			["install_complete"] = "6.9996",
		},
		["Malkyn - Dragonblight"] = {
		},
		["Cecliann - Skywall"] = {
			["theme"] = "default",
			["install_complete"] = "6.9996",
		},
		["Feronaz - Skywall"] = {
			["install_complete"] = "6.9997",
		},
	},
}
