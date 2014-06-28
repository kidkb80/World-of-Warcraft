
ElvDB = {
	["profileKeys"] = {
		["Drominus - Area 52"] = "Feronis - Skywall",
		["Gaulthain - Skywall"] = "Feronis - Skywall",
		["Anaiis - Skywall"] = "Default",
		["Oldfero - Area 52"] = "Feronis - Skywall",
		["Drominus - Skywall"] = "Feronis - Skywall",
		["Dalhian - Skywall"] = "Default",
		["Cidareth - Skywall"] = "Cidareth - Skywall",
		["Gurund - Area 52"] = "Default",
		["Gaulthain - Area 52"] = "Gaulthain - Area 52",
		["Feronaz - Area 52"] = "Feronis - Skywall",
		["Feronis - Skywall"] = "Feronis - Skywall",
		["Malkyn - Dragonblight"] = "Malkyn - Dragonblight",
		["Toradol - Skywall"] = "Toradol - Skywall",
		["Noremedy - Skywall"] = "Feronis - Skywall",
		["Cecliann - Skywall"] = "Cecliann - Skywall",
		["Feronaz - Skywall"] = "Default",
	},
	["gold"] = {
		["Dragonblight"] = {
			["Malkyn"] = 1433952,
		},
		["Area 52"] = {
			["Gaulthain"] = 83178270,
			["Gurund"] = 457714,
			["Feronaz"] = 456957,
			["Drominus"] = 16148079,
			["Oldfero"] = 287274609,
		},
		["Skywall"] = {
			["Anaiis"] = 786960,
			["Feronis"] = 456621,
			["Toradol"] = 1052503,
			["Cidareth"] = 214351,
			["Dalhian"] = 582606,
			["Gaulthain"] = 83178270,
			["Noremedy"] = 11646335,
			["Cecliann"] = 2,
			["Feronaz"] = 2408595,
			["Drominus"] = 12935612,
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
					["enabled"] = false,
					["talentGroup"] = 1,
					["specGroup"] = 1,
				},
				["Oldfero - Area 52"] = {
					["profile"] = "Feronis - Skywall",
					["enabled"] = true,
					["talentGroup"] = 2,
					["specGroup"] = 2,
				},
				["Noremedy - Skywall"] = {
					["profile"] = "Feronis - Skywall",
					["specGroup"] = 1,
					["talentGroup"] = 1,
					["enabled"] = false,
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
					["r"] = 0.67,
					["g"] = 0.83,
					["b"] = 0.45,
				},
				["bordercolor"] = {
					["r"] = 0.31,
					["g"] = 0.31,
					["b"] = 0.31,
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
				["ElvUF_TargetMover"] = "BOTTOMElvUIParentBOTTOM282132",
				["ElvUF_PetMover"] = "BOTTOMElvUIParentBOTTOM0150",
				["ElvAB_3"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-49923",
				["ElvUF_PlayerMover"] = "BOTTOMElvUIParentBOTTOM-285142",
				["AlertFrameMover"] = "TOPRIGHTElvUIParentTOPRIGHT-509-197",
				["DebuffsMover"] = "TOPRIGHTElvUIParentTOPRIGHT-233-147",
				["ElvUF_TargetTargetMover"] = "BOTTOMElvUIParentBOTTOM0110",
			},
			["hideTutorial"] = 1,
			["unitframe"] = {
				["colors"] = {
					["auraBarBuff"] = {
						["r"] = 0.41,
						["g"] = 0.8,
						["b"] = 0.94,
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
						["aurabar"] = {
							["enable"] = false,
						},
						["portrait"] = {
							["enable"] = true,
						},
						["castbar"] = {
							["height"] = 9.000010490417481,
							["width"] = 225.0000762939453,
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
							["noDuration"] = false,
							["attachTo"] = "FRAME",
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
					["Actionbar5DataPanel"] = "Combat/Arena Time",
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
					["font"] = "Friz Quadrata TT",
				},
				["fontOutline"] = "OUTLINE",
				["healthBar"] = {
					["text"] = {
						["enable"] = true,
					},
					["lowHPScale"] = {
						["enable"] = true,
					},
				},
				["font"] = "Friz Quadrata TT",
				["buffs"] = {
					["font"] = "Friz Quadrata TT",
				},
			},
			["utils"] = {
				["enableTokens"] = false,
				["enableSystem"] = false,
			},
			["general"] = {
				["totems"] = {
					["enable"] = false,
				},
				["backdropfadecolor"] = {
					["b"] = 0.1019607843137255,
					["g"] = 0.1019607843137255,
					["r"] = 0.04313725490196078,
				},
				["valuecolor"] = {
					["a"] = 1,
					["b"] = 0,
					["g"] = 0.5,
					["r"] = 1,
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
					["mouseover"] = true,
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
				["ENERGY"] = {
				},
				["MANA"] = {
				},
				["backdropcolor"] = {
					["r"] = 0.05098039215686274,
					["g"] = 0.1176470588235294,
					["b"] = 0.1176470588235294,
				},
				["castColor"] = {
				},
				["castNoInterrupt"] = {
				},
				["health"] = {
				},
				["RUNIC_POWER"] = {
				},
				["autoRepair"] = "PLAYER",
				["reputation"] = {
					["textFormat"] = "CURPERC",
					["height"] = 14,
					["mouseover"] = true,
					["textSize"] = 8,
					["width"] = 412,
				},
				["font"] = "Friz Quadrata TT",
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
				["tabFontSize"] = 12,
				["panelTabTransparency"] = true,
				["panelHeight"] = 157,
				["tabFont"] = "Friz Quadrata TT",
				["font"] = "Friz Quadrata TT",
				["tabFontOutline"] = "MONOCROMEOUTLINE",
				["panelWidth"] = 400,
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
			["VAT"] = {
				["barHeight"] = 6,
				["enableStaticColor"] = true,
				["spacing"] = -7,
			},
			["bab"] = {
				["chooseAb"] = "BAR1",
			},
			["bui"] = {
				["installed"] = true,
				["transparentDts"] = true,
			},
			["movers"] = {
				["RaidMarkerBarAnchor"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT90178",
				["MinimapButtonAnchor"] = "TOPRIGHTElvUIParentTOPRIGHT-25-283",
				["LocationLiteMover"] = "TOPElvUIParentTOP0-7",
				["LeftChatMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT021",
				["GMMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT0182",
				["BuffsMover"] = "TOPRIGHTElvUIParentTOPRIGHT-2810",
				["ElvUF_Raid10Mover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT9316",
				["BossButton"] = "BOTTOMElvUIParentBOTTOM292",
				["LootFrameMover"] = "TOPLEFTElvUIParentTOPLEFT403-242",
				["DigSiteProgressBarMover"] = "BOTTOMElvUIParentBOTTOM0315",
				["ElvUF_AssistMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT59242",
				["PetAB"] = "BOTTOMElvUIParentBOTTOM-600",
				["ElvUF_RaidpetMover"] = "TOPLEFTElvUIParentTOPLEFT0-74",
				["ElvUF_TargetAuraMover"] = "BOTTOMElvUIParentBOTTOM227193",
				["ElvUF_PartyMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT0491",
				["ElvUF_FocusMover"] = "BOTTOMElvUIParentBOTTOM119101",
				["LocationMover"] = "TOPElvUIParentTOP0-7",
				["ElvUF_PlayerMover"] = "BOTTOMElvUIParentBOTTOM-241325",
				["ClassBarMover"] = "BOTTOMElvUIParentBOTTOM0272",
				["MicrobarMover"] = "TOPLEFTElvUIParentTOPLEFT00",
				["BossHeaderMover"] = "TOPRIGHTElvUIParentTOPRIGHT0-363",
				["VehicleSeatMover"] = "TOPRIGHTElvUIParentTOPRIGHT-281-161",
				["ElvUF_TargetTargetMover"] = "BOTTOMElvUIParentBOTTOM55254",
				["ExperienceBarMover"] = "TOPElvUIParentTOP-17-15",
				["TooltipMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-178157",
				["ElvUF_TargetMover"] = "BOTTOMElvUIParentBOTTOM243320",
				["ElvUF_TargetCastbarMover"] = "BOTTOMElvUIParentBOTTOM221307",
				["BuiDashboardMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT0175",
				["ElvUF_Raid40Mover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT7179",
				["FarmToolAnchor"] = "TOPLEFTElvUIParentTOPLEFT00",
				["ArenaHeaderMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT0331",
				["ElvAB_1"] = "BOTTOMElvUIParentBOTTOM3316",
				["FarmPortalAnchor"] = "TOPLEFTElvUIParentTOPLEFT00",
				["ElvUF_PlayerCastbarMover"] = "BOTTOMElvUIParentBOTTOM-219312",
				["LossControlMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT438359",
				["ElvAB_4"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-1177",
				["ReputationBarMover"] = "TOPElvUIParentTOP-170",
				["AltPowerBarMover"] = "BOTTOMElvUIParentBOTTOM29593",
				["ElvAB_3"] = "BOTTOMElvUIParentBOTTOM-2830",
				["ElvAB_5"] = "BOTTOMElvUIParentBOTTOM2950",
				["ElvUF_PlayerAuraMover"] = "BOTTOMElvUIParentBOTTOM-229190",
				["ElvUF_Raid25Mover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT28176",
				["ElvUF_PetMover"] = "BOTTOMElvUIParentBOTTOM-57254",
				["TotemBarMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT4000",
				["BNETMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT148182",
				["ShiftAB"] = "BOTTOMElvUIParentBOTTOM1510",
				["ElvAB_2"] = "BOTTOMElvUIParentBOTTOM3279",
				["TargetPowerBarMover"] = "BOTTOMElvUIParentBOTTOM247215",
				["ElvAB_6"] = "BOTTOMElvUIParentBOTTOM10",
				["FarmSeedAnchor"] = "TOPLEFTElvUIParentTOPLEFT00",
				["ElvUF_TankMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT130213",
				["tokenHolderMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-40121",
				["WatchFrameMover"] = "TOPRIGHTElvUIParentTOPRIGHT-30-340",
				["PlayerPowerBarMover"] = "BOTTOMElvUIParentBOTTOM-230168",
				["RightChatMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT121",
				["AlertFrameMover"] = "TOPRIGHTElvUIParentTOPRIGHT-331-418",
				["DebuffsMover"] = "TOPLEFTElvUIParentTOPLEFT2060",
				["MinimapMover"] = "TOPRIGHTElvUIParentTOPRIGHT00",
			},
			["tooltip"] = {
				["healthBar"] = {
					["font"] = "Friz Quadrata TT",
					["fontOutline"] = "OUTLINE",
				},
			},
			["actionbar"] = {
				["bar3"] = {
					["buttons"] = 10,
					["buttonspacing"] = 4,
					["backdrop"] = true,
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
				["bar5"] = {
					["buttons"] = 10,
					["buttonspacing"] = 4,
					["backdrop"] = true,
					["buttonsPerRow"] = 5,
					["buttonsize"] = 28,
				},
				["bar1"] = {
					["buttons"] = 6,
					["buttonspacing"] = 4,
					["buttonsPerRow"] = 6,
				},
				["font"] = "Friz Quadrata TT",
				["bar6"] = {
					["enabled"] = true,
					["point"] = "TOPLEFT",
					["backdrop"] = true,
					["heightMult"] = 2,
					["buttonsize"] = 30,
				},
				["stanceBar"] = {
					["buttonsize"] = 28,
				},
				["barPet"] = {
					["point"] = "BOTTOMLEFT",
					["buttonsPerRow"] = 10,
					["buttonsize"] = 24,
				},
				["bar4"] = {
					["buttonspacing"] = 4,
					["mouseover"] = true,
					["buttonsPerRow"] = 12,
					["buttonsize"] = 29,
				},
			},
			["bags"] = {
				["yOffset"] = 154,
			},
			["unitframe"] = {
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
					["party"] = {
						["width"] = 159,
						["enable"] = false,
						["height"] = 25,
					},
					["raid40"] = {
						["enable"] = false,
					},
					["focus"] = {
						["power"] = {
							["height"] = 5,
						},
						["width"] = 122,
						["castbar"] = {
							["height"] = 4,
							["width"] = 121.9999389648438,
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
							["text_format"] = "",
						},
						["height"] = 33,
						["buffs"] = {
							["sizeOverride"] = 0,
							["anchorPoint"] = "TOPLEFT",
							["perrow"] = 9,
						},
						["castbar"] = {
							["height"] = 12,
							["width"] = 225,
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
							["height"] = 8,
							["detachedWidth"] = 212,
						},
						["aurabar"] = {
							["enable"] = false,
						},
						["health"] = {
							["xOffset"] = 8,
							["position"] = "BOTTOMLEFT",
							["yOffset"] = 4,
						},
						["height"] = 33,
						["buffs"] = {
							["sizeOverride"] = 0,
							["enable"] = true,
							["anchorPoint"] = "TOPRIGHT",
							["perrow"] = 9,
							["attachTo"] = "FRAME",
						},
						["castbar"] = {
							["width"] = 225,
							["height"] = 12,
						},
					},
					["assist"] = {
						["enable"] = false,
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
					["boss"] = {
						["castbar"] = {
							["height"] = 5.999995231628418,
							["width"] = 215.9999694824219,
						},
					},
				},
				["font"] = "Friz Quadrata TT",
				["colors"] = {
					["colorhealthbyvalue"] = false,
					["healthclass"] = true,
					["customhealthbackdrop"] = true,
					["health_backdrop"] = {
						["r"] = 0.1882352941176471,
						["g"] = 0,
						["b"] = 0,
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
					["disconnected"] = {
						["r"] = 0.3686274509803922,
						["g"] = 0.3294117647058824,
						["b"] = 0.2862745098039216,
					},
					["castNoInterrupt"] = {
						["r"] = 0.1411764705882353,
						["g"] = 0.01176470588235294,
						["b"] = 0.2352941176470588,
					},
					["tapped"] = {
						["r"] = 0.8588235294117647,
						["g"] = 0.8274509803921568,
						["b"] = 0.8588235294117647,
					},
					["health"] = {
						["r"] = 0.5607843137254902,
						["g"] = 0.9529411764705882,
						["b"] = 0.1490196078431373,
					},
				},
				["fontOutline"] = "OUTLINE",
				["statusbar"] = "BuiMelliDark",
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
					["Actionbar5DataPanel"] = "",
					["RightMiniPanel"] = "System",
					["Actionbar3DataPanel"] = "",
					["RightChatDataPanel"] = {
						["middle"] = "Bags",
						["left"] = "Cecile Meter Overlay",
					},
					["LeftChatDataPanel"] = {
						["right"] = "Durability",
						["left"] = "Guild",
						["middle"] = "Friends",
					},
				},
				["fontOutline"] = "MONOCROMEOUTLINE",
				["leftChatPanel"] = false,
				["rightChatPanel"] = false,
				["font"] = "Friz Quadrata TT",
				["actionbar5"] = false,
				["actionbar1"] = false,
				["actionbar3"] = false,
			},
			["loclite"] = {
				["dtheight"] = 16,
				["lpfont"] = "Bui Visitor1",
				["trunc"] = true,
				["lpwidth"] = 220,
				["lpfontflags"] = "MONOCHROMEOUTLINE",
				["lpauto"] = false,
				["lpfontsize"] = 10,
			},
			["currentTutorial"] = 1,
			["auras"] = {
				["timeXOffset"] = -1,
				["debuffs"] = {
					["size"] = 38,
				},
				["fadeThreshold"] = 10,
				["font"] = "Friz Quadrata TT",
				["fontOutline"] = "MONOCROMEOUTLINE",
				["consolidatedBuffs"] = {
					["fontSize"] = 12,
					["fontOutline"] = "MONOCROMEOUTLINE",
					["font"] = "Friz Quadrata TT",
				},
				["buffs"] = {
					["horizontalSpacing"] = 3,
					["size"] = 38,
				},
			},
		},
		["Toradol - Skywall"] = {
			["bui"] = {
				["installed"] = true,
			},
			["currentTutorial"] = 5,
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
		["Anaiis - Skywall"] = {
			["bui"] = {
				["installed"] = true,
			},
			["currentTutorial"] = 1,
			["general"] = {
				["loginmessage"] = false,
				["valuecolor"] = {
					["r"] = 0.67,
					["g"] = 0.83,
					["b"] = 0.45,
				},
				["bordercolor"] = {
					["r"] = 0.31,
					["g"] = 0.31,
					["b"] = 0.31,
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
				["MinimapMover"] = "TOPRIGHTElvUIParentTOPRIGHT05",
				["ElvAB_3"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-49923",
				["LeftChatMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT-2-5",
				["PetAB"] = "TOPRIGHTElvUIParentTOPRIGHT-35-459",
				["BNETMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT4186",
				["ElvUF_TargetTargetMover"] = "BOTTOMElvUIParentBOTTOM0110",
				["TotemBarMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT411-6",
				["ElvUF_FocusMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-422307",
				["ElvAB_6"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT3178",
				["TooltipMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-44",
				["ElvUF_PlayerMover"] = "BOTTOMElvUIParentBOTTOM-285142",
				["BossHeaderMover"] = "TOPRIGHTElvUIParentTOPRIGHT-79-463",
				["ElvUF_PetMover"] = "BOTTOMElvUIParentBOTTOM0150",
				["ArenaHeaderMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-55250",
				["RightChatMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT6-6",
				["AlertFrameMover"] = "TOPRIGHTElvUIParentTOPRIGHT-482-341",
				["DebuffsMover"] = "TOPRIGHTElvUIParentTOPRIGHT-225-144",
				["ElvUF_TargetMover"] = "BOTTOMElvUIParentBOTTOM282138",
			},
			["hideTutorial"] = 1,
			["unitframe"] = {
				["colors"] = {
					["auraBarBuff"] = {
						["r"] = 0.41,
						["g"] = 0.8,
						["b"] = 0.94,
					},
					["castClassColor"] = true,
					["healthclass"] = true,
				},
				["units"] = {
					["boss"] = {
						["height"] = 40,
						["width"] = 200,
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
						["portrait"] = {
							["enable"] = true,
						},
						["castbar"] = {
							["height"] = 9.000010490417481,
							["width"] = 215.0000457763672,
						},
						["height"] = 45,
						["aurabar"] = {
							["enable"] = false,
						},
						["width"] = 260,
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
							["attachTo"] = "FRAME",
							["enable"] = true,
						},
						["aurabar"] = {
							["enable"] = false,
						},
						["width"] = 260,
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
					["Actionbar3DataPanel"] = "Combat/Arena Time",
					["Actionbar5DataPanel"] = "Cecile Meter Overlay",
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
					["b"] = 0.1019607843137255,
					["g"] = 0.1019607843137255,
					["r"] = 0.1019607843137255,
				},
				["reputation"] = {
					["height"] = 12,
					["textFormat"] = "CURMAX",
					["textSize"] = 8,
					["width"] = 412,
				},
				["bordercolor"] = {
					["b"] = 0.31,
					["g"] = 0.31,
					["r"] = 0.31,
				},
				["minimap"] = {
					["locationText"] = "HIDE",
					["size"] = 212,
				},
				["font"] = "Friz Quadrata TT",
				["bottomPanel"] = false,
				["backdropfadecolor"] = {
					["b"] = 0.05490196078431373,
					["g"] = 0.05490196078431373,
					["r"] = 0.05490196078431373,
				},
				["valuecolor"] = {
					["a"] = 1,
					["b"] = 0,
					["g"] = 0.5,
					["r"] = 1,
				},
				["experience"] = {
					["textFormat"] = "CURPERC",
					["width"] = 412,
				},
				["topPanel"] = false,
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
				["ElvUF_AssistMover"] = "TOPLEFTElvUIParentTOPLEFT4-392",
				["PetAB"] = "BOTTOMElvUIParentBOTTOM013",
				["ElvAB_1"] = "BOTTOMElvUIParentBOTTOM092",
				["ElvAB_2"] = "BOTTOMElvUIParentBOTTOM058",
				["ElvUF_TargetMover"] = "BOTTOMElvUIParentBOTTOM231182",
				["RightChatMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-222",
				["ReputationBarMover"] = "TOPElvUIParentTOP-40",
				["ElvUF_PetMover"] = "BOTTOMElvUIParentBOTTOM0191",
				["AltPowerBarMover"] = "TOPElvUIParentTOP0-66",
				["ElvAB_3"] = "BOTTOMElvUIParentBOTTOM29558",
				["ElvAB_5"] = "BOTTOMElvUIParentBOTTOM-29558",
				["tokenHolderMover"] = "TOPLEFTElvUIParentTOPLEFT4-119",
				["PlayerPowerBarMover"] = "BOTTOMElvUIParentBOTTOM-231215",
				["WatchFrameMover"] = "TOPRIGHTElvUIParentTOPRIGHT-122-292",
				["ElvUF_TargetCastbarMover"] = "BOTTOMElvUIParentBOTTOM231147",
				["BNETMover"] = "TOPRIGHTElvUIParentTOPRIGHT-4-199",
				["ShiftAB"] = "BOTTOMElvUIParentBOTTOM0134",
				["TargetPowerBarMover"] = "BOTTOMElvUIParentBOTTOM247215",
				["LocationMover"] = "TOPElvUIParentTOP0-7",
				["ArenaHeaderMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-56346",
				["ElvUF_Raid25Mover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT2179",
				["ElvUF_TankMover"] = "TOPLEFTElvUIParentTOPLEFT4-292",
				["BossHeaderMover"] = "TOPRIGHTElvUIParentTOPRIGHT-56-397",
				["TotemBarMover"] = "TOPLEFTElvUIParentTOPLEFT4360",
				["ElvUF_PlayerMover"] = "BOTTOMElvUIParentBOTTOM-231182",
				["ElvUF_PartyMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT4210",
				["AlertFrameMover"] = "TOPElvUIParentTOP0-140",
				["DebuffsMover"] = "TOPRIGHTElvUIParentTOPRIGHT-189-134",
				["MinimapMover"] = "TOPRIGHTElvUIParentTOPRIGHT-94-13",
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
						["b"] = 0.79,
						["g"] = 0.51,
						["r"] = 0.58,
					},
					["castClassColor"] = true,
					["castColor"] = {
						["b"] = 0.1,
						["g"] = 0.1,
						["r"] = 0.1,
					},
					["transparentCastbar"] = true,
					["transparentAurabars"] = true,
					["health"] = {
						["b"] = 0.1,
						["g"] = 0.1,
						["r"] = 0.1,
					},
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
						["power"] = {
							["xOffset"] = 2,
							["height"] = 5,
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
					["targettarget"] = {
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
					["buttonsize"] = 30,
					["backdrop"] = true,
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
			["loclite"] = {
				["lpfont"] = "Bui Visitor1",
				["lpfontsize"] = 10,
				["lpfontflags"] = "MONOCHROMEOUTLINE",
				["lpwidth"] = 220,
				["dtheight"] = 16,
				["lpauto"] = false,
				["trunc"] = true,
			},
			["nameplate"] = {
				["font"] = "Bui Visitor1",
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
				["font"] = "Bui Visitor1",
				["consolidatedBuffs"] = {
					["font"] = "Bui Visitor1",
					["fontOutline"] = "MONOCROMEOUTLINE",
				},
			},
		},
		["Gurund - Area 52"] = {
			["bui"] = {
				["installed"] = true,
			},
			["currentTutorial"] = 2,
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
		["Skywall"] = {
			["currentTutorial"] = 1,
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
		["Feronaz - Area 52"] = {
			["nameplate"] = {
				["font"] = "Bui Visitor1",
			},
			["currentTutorial"] = 5,
			["general"] = {
				["fontSize"] = 10,
				["stickyFrames"] = false,
				["backdropcolor"] = {
					["r"] = 0.07058823529411765,
					["g"] = 0.08627450980392157,
					["b"] = 0.1176470588235294,
				},
				["topPanel"] = false,
				["bordercolor"] = {
					["r"] = 0.31,
					["g"] = 0.31,
					["b"] = 0.31,
				},
				["minimap"] = {
					["locationText"] = "HIDE",
					["size"] = 150,
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
				["lpfontsize"] = 10,
				["both"] = false,
				["displayOther"] = "NONE",
				["lpwidth"] = 220,
				["lpfontflags"] = "MONOCHROMEOUTLINE",
				["trunc"] = true,
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
				["ElvUF_AssistMover"] = "TOPLEFTElvUIParentTOPLEFT4-392",
				["ElvAB_1"] = "BOTTOMElvUIParentBOTTOM092",
				["ElvAB_2"] = "BOTTOMElvUIParentBOTTOM058",
				["PetAB"] = "BOTTOMElvUIParentBOTTOM013",
				["ElvUF_TargetMover"] = "BOTTOMElvUIParentBOTTOM231182",
				["RightChatMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-222",
				["ReputationBarMover"] = "TOPRIGHTElvUIParentTOPRIGHT-2-181",
				["AltPowerBarMover"] = "TOPElvUIParentTOP0-66",
				["ElvAB_3"] = "BOTTOMElvUIParentBOTTOM29558",
				["ElvAB_5"] = "BOTTOMElvUIParentBOTTOM-29558",
				["PlayerPowerBarMover"] = "BOTTOMElvUIParentBOTTOM-231215",
				["BossHeaderMover"] = "TOPRIGHTElvUIParentTOPRIGHT-56-397",
				["VehicleSeatMover"] = "TOPLEFTElvUIParentTOPLEFT155-81",
				["TargetPowerBarMover"] = "BOTTOMElvUIParentBOTTOM247215",
				["BNETMover"] = "TOPRIGHTElvUIParentTOPRIGHT-4-199",
				["ShiftAB"] = "BOTTOMElvUIParentBOTTOM0134",
				["ArenaHeaderMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-56346",
				["LocationMover"] = "TOPElvUIParentTOP0-7",
				["ElvUF_TargetCastbarMover"] = "BOTTOMElvUIParentBOTTOM231147",
				["WatchFrameMover"] = "TOPRIGHTElvUIParentTOPRIGHT-122-292",
				["ElvUF_TankMover"] = "TOPLEFTElvUIParentTOPLEFT4-292",
				["tokenHolderMover"] = "TOPLEFTElvUIParentTOPLEFT4-119",
				["ElvUF_PetMover"] = "BOTTOMElvUIParentBOTTOM0191",
				["ElvUF_PlayerMover"] = "BOTTOMElvUIParentBOTTOM-231182",
				["ElvUF_PartyMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT4210",
				["AlertFrameMover"] = "TOPElvUIParentTOP0-140",
				["DebuffsMover"] = "TOPRIGHTElvUIParentTOPRIGHT-189-134",
				["MinimapMover"] = "TOPRIGHTElvUIParentTOPRIGHT-4-6",
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
					["auraBarBuff"] = {
						["r"] = 0,
						["g"] = 0.44,
						["b"] = 0.87,
					},
					["transparentCastbar"] = true,
					["transparentAurabars"] = true,
					["castClassColor"] = true,
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
						["buffs"] = {
							["noConsolidated"] = false,
							["sizeOverride"] = 22,
							["useBlacklist"] = false,
							["enable"] = true,
							["playerOnly"] = false,
							["yOffset"] = -6,
							["clickThrough"] = true,
							["xOffset"] = 50,
							["useFilter"] = "TurtleBuffs",
							["perrow"] = 1,
							["noDuration"] = false,
						},
						["healPrediction"] = true,
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
						["castbar"] = {
							["icon"] = false,
							["width"] = 300,
						},
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
						["threatStyle"] = "ICONTOPRIGHT",
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
						["power"] = {
							["height"] = 5,
						},
						["width"] = 122,
						["castbar"] = {
							["height"] = 6,
							["width"] = 122,
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
						["health"] = {
							["xOffset"] = -40,
							["text_format"] = "",
							["yOffset"] = -25,
						},
						["castbar"] = {
							["icon"] = false,
							["width"] = 300,
						},
						["height"] = 33,
						["buffs"] = {
							["anchorPoint"] = "TOPLEFT",
							["sizeOverride"] = 30,
							["yOffset"] = 2,
						},
						["name"] = {
							["xOffset"] = 8,
							["position"] = "RIGHT",
							["text_format"] = "[healthcolor][health:current-percent] [namecolor][name:medium] [difficultycolor][smartlevel] [shortclassification]",
							["yOffset"] = -25,
						},
						["threatStyle"] = "ICONTOPLEFT",
					},
					["pet"] = {
						["height"] = 24,
						["power"] = {
							["height"] = 5,
						},
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
						["buffs"] = {
							["noConsolidated"] = false,
							["sizeOverride"] = 22,
							["useBlacklist"] = false,
							["enable"] = true,
							["playerOnly"] = false,
							["yOffset"] = -6,
							["clickThrough"] = true,
							["xOffset"] = 50,
							["useFilter"] = "TurtleBuffs",
							["perrow"] = 1,
							["noDuration"] = false,
						},
						["healPrediction"] = true,
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
						["width"] = 80,
						["health"] = {
							["text_format"] = "[healthcolor][health:deficit]",
							["frequentUpdates"] = true,
							["position"] = "BOTTOM",
						},
						["name"] = {
							["text_format"] = "[namecolor][name:short]",
							["position"] = "TOP",
						},
						["buffs"] = {
							["noConsolidated"] = false,
							["sizeOverride"] = 22,
							["useBlacklist"] = false,
							["enable"] = true,
							["playerOnly"] = false,
							["yOffset"] = -6,
							["clickThrough"] = true,
							["xOffset"] = 50,
							["useFilter"] = "TurtleBuffs",
							["perrow"] = 1,
							["noDuration"] = false,
						},
						["height"] = 45,
						["verticalSpacing"] = 9,
						["GPSArrow"] = {
							["size"] = 40,
						},
						["roleIcon"] = {
							["position"] = "BOTTOMRIGHT",
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
				["dtheight"] = 16,
				["lpfontsize"] = 10,
				["trunc"] = true,
				["lpwidth"] = 220,
				["lpfontflags"] = "MONOCHROMEOUTLINE",
				["lpauto"] = false,
				["lpfont"] = "Bui Visitor1",
			},
			["bui"] = {
				["installed"] = true,
			},
			["chat"] = {
				["tabFont"] = "Bui Visitor1",
				["font"] = "Bui Prototype",
				["tabFontOutline"] = "MONOCROMEOUTLINE",
				["panelHeight"] = 150,
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
					["enabled"] = false,
					["buttonsize"] = 26,
					["buttonspacing"] = 4,
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
				["enableTokens"] = false,
				["enableSystem"] = false,
			},
			["general"] = {
				["totems"] = {
					["enable"] = false,
				},
				["fontSize"] = 13,
				["tinyWorldMap"] = false,
				["FOCUS"] = {
				},
				["minimap"] = {
					["size"] = 236,
				},
				["health_backdrop"] = {
				},
				["backdropfadecolor"] = {
					["b"] = 0.1019607843137255,
					["g"] = 0.1019607843137255,
					["r"] = 0.04313725490196078,
				},
				["valuecolor"] = {
					["a"] = 1,
					["b"] = 0,
					["g"] = 0.5,
					["r"] = 1,
				},
				["ENERGY"] = {
				},
				["loginmessage"] = false,
				["MANA"] = {
				},
				["stickyFrames"] = false,
				["backdropcolor"] = {
					["b"] = 0.06274509803921569,
					["g"] = 0.06274509803921569,
					["r"] = 0.02745098039215686,
				},
				["topPanel"] = false,
				["autoRepair"] = "PLAYER",
				["RUNIC_POWER"] = {
				},
				["disconnected"] = {
				},
				["castNoInterrupt"] = {
				},
				["tapped"] = {
				},
				["experience"] = {
					["height"] = 11,
					["textFormat"] = "CURPERC",
					["width"] = 412,
				},
				["reputation"] = {
					["textFormat"] = "CURPERC",
					["height"] = 14,
					["mouseover"] = true,
					["textSize"] = 8,
					["width"] = 412,
				},
				["health"] = {
				},
				["font"] = "Friz Quadrata TT",
				["castColor"] = {
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
				["panelTabTransparency"] = true,
				["panelHeight"] = 154,
				["tabFont"] = "Friz Quadrata TT",
				["tabFontOutline"] = "MONOCROMEOUTLINE",
				["tabFontSize"] = 12,
				["panelWidth"] = 428,
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
			["movers"] = {
				["RaidMarkerBarAnchor"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-221176",
				["PetAB"] = "BOTTOMElvUIParentBOTTOM-2930",
				["LocationLiteMover"] = "TOPElvUIParentTOP0-7",
				["LeftChatMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT021",
				["GMMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT0174",
				["BuffsMover"] = "TOPRIGHTElvUIParentTOPRIGHT-2810",
				["ElvUF_Raid10Mover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT0515",
				["BossButton"] = "BOTTOMElvUIParentBOTTOM-176352",
				["LootFrameMover"] = "TOPLEFTElvUIParentTOPLEFT148-210",
				["DigSiteProgressBarMover"] = "BOTTOMElvUIParentBOTTOM0315",
				["ElvUF_RaidpetMover"] = "TOPLEFTElvUIParentTOPLEFT132-23",
				["ElvUF_TargetAuraMover"] = "BOTTOMElvUIParentBOTTOM227193",
				["MinimapMover"] = "TOPRIGHTElvUIParentTOPRIGHT00",
				["ElvUF_FocusMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-461121",
				["ClassBarMover"] = "BOTTOMElvUIParentBOTTOM-150143",
				["MicrobarMover"] = "TOPLEFTElvUIParentTOPLEFT00",
				["ElvUF_Raid25Mover"] = "TOPLEFTElvUIParentTOPLEFT0-468",
				["VehicleSeatMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-279270",
				["RightChatMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-222",
				["ExperienceBarMover"] = "TOPElvUIParentTOP-17-15",
				["MinimapButtonAnchor"] = "TOPRIGHTElvUIParentTOPRIGHT0-262",
				["ElvUF_TargetTargetMover"] = "BOTTOMElvUIParentBOTTOM-4137",
				["WatchFrameMover"] = "TOPRIGHTElvUIParentTOPRIGHT-30-340",
				["LossControlMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT469181",
				["ElvUF_Raid40Mover"] = "TOPLEFTElvUIParentTOPLEFT0-456",
				["tokenHolderMover"] = "TOPLEFTElvUIParentTOPLEFT4-119",
				["BuiDashboardMover"] = "TOPLEFTElvUIParentTOPLEFT4-8",
				["ElvAB_1"] = "BOTTOMElvUIParentBOTTOM-164",
				["ElvAB_2"] = "BOTTOMElvUIParentBOTTOM-1326",
				["ElvUF_TargetMover"] = "BOTTOMElvUIParentBOTTOM228152",
				["ElvAB_6"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-4175",
				["ElvAB_4"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-5212",
				["ElvAB_5"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-4290",
				["AltPowerBarMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-457188",
				["ElvAB_3"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT4290",
				["ReputationBarMover"] = "TOPElvUIParentTOP-170",
				["TargetPowerBarMover"] = "BOTTOMElvUIParentBOTTOM247215",
				["TotemBarMover"] = "TOPLEFTElvUIParentTOPLEFT00",
				["ElvUF_TargetCastbarMover"] = "BOTTOMElvUIParentBOTTOM229130",
				["ElvUF_PlayerAuraMover"] = "BOTTOMElvUIParentBOTTOM-229190",
				["BNETMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT185176",
				["ShiftAB"] = "BOTTOMElvUIParentBOTTOM2780",
				["ElvUF_PetMover"] = "BOTTOMElvUIParentBOTTOM-6168",
				["ElvUF_PlayerCastbarMover"] = "BOTTOMElvUIParentBOTTOM7108",
				["ArenaHeaderMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT0175",
				["PlayerPowerBarMover"] = "BOTTOMElvUIParentBOTTOM-230168",
				["ElvUF_TankMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT0415",
				["BossHeaderMover"] = "TOPRIGHTElvUIParentTOPRIGHT0-471",
				["ElvUF_PlayerMover"] = "BOTTOMElvUIParentBOTTOM-229146",
				["LocationMover"] = "TOPElvUIParentTOP0-7",
				["ElvUF_PartyMover"] = "TOPLEFTElvUIParentTOPLEFT120-456",
				["AlertFrameMover"] = "TOPRIGHTElvUIParentTOPRIGHT-418-240",
				["DebuffsMover"] = "TOPLEFTElvUIParentTOPLEFT2060",
				["ElvUF_AssistMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT0326",
			},
			["tooltip"] = {
				["healthBar"] = {
					["fontOutline"] = "OUTLINE",
					["font"] = "Friz Quadrata TT",
				},
			},
			["bags"] = {
				["yOffset"] = 150,
			},
			["unitframe"] = {
				["font"] = "Friz Quadrata TT",
				["colors"] = {
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
							["b"] = 0.1176470588235294,
							["g"] = 0.5294117647058824,
							["r"] = 0.4705882352941176,
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
					["colorhealthbyvalue"] = false,
					["disconnected"] = {
						["b"] = 0.2862745098039216,
						["g"] = 0.3294117647058824,
						["r"] = 0.3686274509803922,
					},
					["customhealthbackdrop"] = true,
					["health_backdrop"] = {
						["b"] = 0,
						["g"] = 0,
						["r"] = 0.1882352941176471,
					},
					["health"] = {
						["b"] = 0.1490196078431373,
						["g"] = 0.9529411764705882,
						["r"] = 0.5607843137254902,
					},
					["tapped"] = {
						["b"] = 0.8588235294117647,
						["g"] = 0.8274509803921568,
						["r"] = 0.8588235294117647,
					},
					["castNoInterrupt"] = {
						["b"] = 0.2352941176470588,
						["g"] = 0.01176470588235294,
						["r"] = 0.1411764705882353,
					},
					["auraBarTurtle"] = false,
					["classResources"] = {
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
				},
				["fontOutline"] = "OUTLINE",
				["statusbar"] = "BuiMelliDark",
				["units"] = {
					["raid10"] = {
						["power"] = {
							["power"] = false,
						},
					},
					["pet"] = {
						["height"] = 22,
						["width"] = 126,
						["power"] = {
							["height"] = 5,
						},
					},
					["boss"] = {
						["castbar"] = {
							["height"] = 5.999995231628418,
							["width"] = 215.9999694824219,
						},
					},
					["targettarget"] = {
						["height"] = 22,
						["power"] = {
							["height"] = 5,
						},
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
						["health"] = {
							["xOffset"] = 8,
							["yOffset"] = 4,
						},
						["debuffs"] = {
							["anchorPoint"] = "TOPLEFT",
							["sizeOverride"] = 0,
							["attachTo"] = "FRAME",
							["clickThrough"] = true,
						},
						["portrait"] = {
							["enable"] = true,
						},
						["power"] = {
							["hideonnpc"] = false,
						},
						["height"] = 43,
						["buffs"] = {
							["anchorPoint"] = "TOPLEFT",
							["sizeOverride"] = 0,
							["attachTo"] = "DEBUFFS",
						},
						["name"] = {
							["text_format"] = "",
							["position"] = "RIGHT",
						},
						["aurabar"] = {
							["enable"] = false,
							["maxDuration"] = 120,
						},
					},
					["arena"] = {
						["castbar"] = {
							["height"] = 6.000012397766113,
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
							["sizeOverride"] = 0,
							["clickThrough"] = true,
						},
						["portrait"] = {
							["enable"] = true,
						},
						["castbar"] = {
							["width"] = 460,
						},
						["height"] = 43,
						["buffs"] = {
							["enable"] = true,
							["sizeOverride"] = 0,
						},
						["health"] = {
							["xOffset"] = 8,
							["yOffset"] = 4,
							["position"] = "BOTTOMLEFT",
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
					["RightChatDataPanel"] = {
						["middle"] = "Bags",
						["left"] = "Cecile Meter Overlay",
					},
					["LeftChatDataPanel"] = {
						["right"] = "Durability",
						["left"] = "Guild",
						["middle"] = "Friends",
					},
					["BuiLeftChatDTPanel"] = {
						["right"] = "BuiMail",
					},
					["Actionbar3DataPanel"] = "",
					["RightMiniPanel"] = "System",
					["Actionbar5DataPanel"] = "",
				},
				["font"] = "Friz Quadrata TT",
				["actionbar3"] = false,
				["leftChatPanel"] = false,
				["actionbar1"] = false,
				["fontOutline"] = "MONOCROMEOUTLINE",
				["rightChatPanel"] = false,
			},
			["actionbar"] = {
				["bar3"] = {
					["buttons"] = 10,
					["buttonspacing"] = 4,
					["buttonsPerRow"] = 5,
					["backdrop"] = true,
					["buttonsize"] = 28,
				},
				["bar2"] = {
					["enabled"] = true,
					["backdrop"] = true,
					["buttonsize"] = 29,
					["buttonspacing"] = 4,
				},
				["bar1"] = {
					["buttonspacing"] = 4,
					["backdrop"] = true,
					["buttonsize"] = 34,
				},
				["bar5"] = {
					["buttons"] = 10,
					["buttonspacing"] = 4,
					["buttonsPerRow"] = 5,
					["backdrop"] = true,
					["buttonsize"] = 28,
				},
				["font"] = "Friz Quadrata TT",
				["fontOutline"] = "MONOCROMEOUTLINE",
				["stanceBar"] = {
					["backdrop"] = true,
				},
				["barPet"] = {
					["buttonsize"] = 24,
					["buttonsPerRow"] = 5,
				},
				["bar4"] = {
					["enabled"] = false,
					["buttonsPerRow"] = 12,
					["buttonsize"] = 29,
					["buttonspacing"] = 4,
				},
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
			["auras"] = {
				["timeXOffset"] = -1,
				["debuffs"] = {
					["size"] = 38,
				},
				["fontOutline"] = "MONOCROMEOUTLINE",
				["fadeThreshold"] = 10,
				["buffs"] = {
					["horizontalSpacing"] = 3,
					["size"] = 38,
				},
				["consolidatedBuffs"] = {
					["fontSize"] = 12,
					["font"] = "Friz Quadrata TT",
					["fontOutline"] = "MONOCROMEOUTLINE",
				},
				["font"] = "Friz Quadrata TT",
			},
			["currentTutorial"] = 1,
			["bui"] = {
				["installed"] = true,
				["transparentDts"] = true,
			},
		},
		["Drominus - Area 52"] = {
			["bui"] = {
				["installed"] = true,
			},
			["currentTutorial"] = 2,
			["RightChatPanelFaded"] = true,
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
					["r"] = 0.07058823529411765,
					["g"] = 0.08627450980392157,
					["b"] = 0.1176470588235294,
				},
				["topPanel"] = false,
				["minimap"] = {
					["locationText"] = "HIDE",
					["size"] = 199,
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
					["textFormat"] = "CURPERC",
					["width"] = 412,
				},
				["reputation"] = {
					["textFormat"] = "CURPERC",
					["mouseover"] = true,
					["width"] = 412,
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
				["displayOther"] = "NONE",
				["lpwidth"] = 220,
				["lpfontflags"] = "MONOCHROMEOUTLINE",
				["trunc"] = true,
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
				["MinimapMover"] = "TOPRIGHTElvUIParentTOPRIGHT00",
				["VehicleSeatMover"] = "TOPLEFTElvUIParentTOPLEFT00",
				["MinimapButtonAnchor"] = "TOPRIGHTElvUIParentTOPRIGHT0-223",
				["ExperienceBarMover"] = "TOPElvUIParentTOP-15-10",
				["BuiDashboardMover"] = "TOPLEFTElvUIParentTOPLEFT139-153",
				["ElvUF_TargetMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-481392",
				["ElvUF_PartyMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT4210",
				["LossControlMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT503188",
				["ElvUF_Raid40Mover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT4211",
				["PlayerPowerBarMover"] = "BOTTOMElvUIParentBOTTOM-231215",
				["TotemBarMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT4120",
				["ElvAB_1"] = "BOTTOMElvUIParentBOTTOM-1220",
				["ElvAB_2"] = "BOTTOMElvUIParentBOTTOM1185",
				["BossHeaderMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT0360",
				["ElvUF_PlayerMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT484386",
				["ElvAB_4"] = "BOTTOMElvUIParentBOTTOM286",
				["ElvUF_TargetTargetMover"] = "BOTTOMElvUIParentBOTTOM72152",
				["AltPowerBarMover"] = "BOTTOMElvUIParentBOTTOM2460",
				["ElvAB_3"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT48155",
				["ElvAB_5"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-48762",
				["ArenaHeaderMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT0406",
				["LocationMover"] = "TOPElvUIParentTOP0-7",
				["TargetPowerBarMover"] = "BOTTOMElvUIParentBOTTOM247215",
				["ElvUF_TargetCastbarMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-481360",
				["BNETMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT164170",
				["ShiftAB"] = "BOTTOMElvUIParentBOTTOM0134",
				["WatchFrameMover"] = "TOPRIGHTElvUIParentTOPRIGHT-91-256",
				["ElvUF_Raid25Mover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT2179",
				["ElvAB_6"] = "BOTTOMElvUIParentBOTTOM255",
				["ReputationBarMover"] = "TOPElvUIParentTOP-290",
				["ElvUF_TankMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT0539",
				["tokenHolderMover"] = "TOPLEFTElvUIParentTOPLEFT4-119",
				["ElvUF_PetMover"] = "BOTTOMElvUIParentBOTTOM-71152",
				["PetAB"] = "BOTTOMElvUIParentBOTTOM00",
				["RightChatMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-222",
				["AlertFrameMover"] = "TOPRIGHTElvUIParentTOPRIGHT-298-271",
				["DebuffsMover"] = "TOPRIGHTElvUIParentTOPRIGHT-237-138",
				["ElvUF_AssistMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT0457",
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
					["raid25"] = {
						["power"] = {
							["enable"] = false,
						},
					},
					["focus"] = {
						["power"] = {
							["height"] = 5,
						},
						["width"] = 122,
						["castbar"] = {
							["height"] = 6,
							["width"] = 122,
						},
					},
					["raid10"] = {
						["power"] = {
							["power"] = false,
						},
					},
					["pet"] = {
						["height"] = 17,
						["power"] = {
							["height"] = 5,
						},
						["width"] = 96,
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
							["sizeOverride"] = 26,
							["bossAuras"] = true,
						},
						["width"] = 96,
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
						["threatStyle"] = "ICONTOPRIGHT",
						["height"] = 35,
						["buffs"] = {
							["anchorPoint"] = "TOPLEFT",
							["sizeOverride"] = 26,
							["yOffset"] = 2,
						},
						["health"] = {
							["xOffset"] = 2,
							["yOffset"] = -25,
						},
						["aurabar"] = {
							["enable"] = false,
							["maxDuration"] = 120,
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
				["dtheight"] = 16,
				["lpfontsize"] = 10,
				["trunc"] = true,
				["lpwidth"] = 220,
				["lpfontflags"] = "MONOCHROMEOUTLINE",
				["lpauto"] = false,
				["lpfont"] = "Bui Visitor1",
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
			["utils"] = {
				["twidth"] = 120,
				["enableSystem"] = false,
				["enableTokens"] = false,
				["dwidth"] = 120,
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
					["heightMult"] = 2,
					["buttonsize"] = 28,
					["backdrop"] = true,
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
			["bui"] = {
				["installed"] = true,
			},
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
		["Cecliann - Skywall"] = {
			["bui"] = {
				["installed"] = true,
			},
			["currentTutorial"] = 2,
			["general"] = {
				["fontSize"] = 10,
				["stickyFrames"] = false,
				["backdropcolor"] = {
					["r"] = 0.1058823529411765,
					["g"] = 0.05490196078431373,
					["b"] = 0.0392156862745098,
				},
				["topPanel"] = false,
				["minimap"] = {
					["locationText"] = "HIDE",
					["size"] = 150,
				},
				["font"] = "Bui Prototype",
				["bottomPanel"] = false,
				["backdropfadecolor"] = {
					["r"] = 0.1254901960784314,
					["g"] = 0.05490196078431373,
					["b"] = 0.05098039215686274,
				},
				["valuecolor"] = {
					["a"] = 1,
					["r"] = 1,
					["g"] = 0.5,
					["b"] = 0,
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
				["ElvUF_AssistMover"] = "TOPLEFTElvUIParentTOPLEFT4-392",
				["ElvAB_1"] = "BOTTOMElvUIParentBOTTOM092",
				["ElvAB_2"] = "BOTTOMElvUIParentBOTTOM058",
				["PetAB"] = "BOTTOMElvUIParentBOTTOM013",
				["TargetPowerBarMover"] = "BOTTOMElvUIParentBOTTOM247215",
				["ElvUF_PartyMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT4210",
				["ReputationBarMover"] = "TOPRIGHTElvUIParentTOPRIGHT-2-181",
				["AltPowerBarMover"] = "TOPElvUIParentTOP0-66",
				["ElvAB_3"] = "BOTTOMElvUIParentBOTTOM29558",
				["ElvAB_5"] = "BOTTOMElvUIParentBOTTOM-29558",
				["PlayerPowerBarMover"] = "BOTTOMElvUIParentBOTTOM-231215",
				["BossHeaderMover"] = "TOPRIGHTElvUIParentTOPRIGHT-56-397",
				["ElvUF_TargetTargetMover"] = "BOTTOMElvUIParentBOTTOM0164",
				["LocationMover"] = "TOPElvUIParentTOP0-7",
				["BNETMover"] = "TOPRIGHTElvUIParentTOPRIGHT-4-199",
				["ShiftAB"] = "BOTTOMElvUIParentBOTTOM0134",
				["ArenaHeaderMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-56346",
				["ElvUF_PlayerMover"] = "BOTTOMElvUIParentBOTTOM-231182",
				["ElvUF_TargetCastbarMover"] = "BOTTOMElvUIParentBOTTOM231147",
				["ElvUF_Raid25Mover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT2179",
				["ElvUF_TankMover"] = "TOPLEFTElvUIParentTOPLEFT4-292",
				["tokenHolderMover"] = "TOPLEFTElvUIParentTOPLEFT4-119",
				["WatchFrameMover"] = "TOPRIGHTElvUIParentTOPRIGHT-122-292",
				["ElvUF_PetMover"] = "BOTTOMElvUIParentBOTTOM0191",
				["RightChatMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-222",
				["AlertFrameMover"] = "TOPElvUIParentTOP0-140",
				["DebuffsMover"] = "TOPRIGHTElvUIParentTOPRIGHT-189-134",
				["MinimapMover"] = "TOPRIGHTElvUIParentTOPRIGHT-4-6",
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
						["castbar"] = {
							["height"] = 4.000008583068848,
							["icon"] = false,
							["width"] = 299.9999694824219,
						},
						["width"] = 300,
						["power"] = {
							["xOffset"] = 2,
							["height"] = 5,
							["hideonnpc"] = false,
							["detachedWidth"] = 298,
							["yOffset"] = -25,
						},
						["name"] = {
							["xOffset"] = 8,
							["position"] = "RIGHT",
							["text_format"] = "[healthcolor][health:current-percent] [namecolor][name:medium] [difficultycolor][smartlevel] [shortclassification]",
							["yOffset"] = -25,
						},
						["threatStyle"] = "ICONTOPLEFT",
						["height"] = 33,
						["buffs"] = {
							["anchorPoint"] = "TOPLEFT",
							["sizeOverride"] = 30,
							["yOffset"] = 2,
						},
						["health"] = {
							["xOffset"] = -40,
							["text_format"] = "",
							["yOffset"] = -25,
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
					["raid25"] = {
						["power"] = {
							["enable"] = false,
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
				["dtheight"] = 16,
				["lpfontsize"] = 10,
				["trunc"] = true,
				["lpwidth"] = 220,
				["lpfontflags"] = "MONOCHROMEOUTLINE",
				["lpauto"] = false,
				["lpfont"] = "Bui Visitor1",
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
					["buttonsize"] = 30,
					["backdrop"] = true,
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
			["nameplate"] = {
				["font"] = "Bui Visitor1",
			},
			["chat"] = {
				["tabFont"] = "Bui Visitor1",
				["font"] = "Bui Prototype",
				["tabFontOutline"] = "MONOCROMEOUTLINE",
				["panelHeight"] = 150,
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
		["Drominus - Area 52"] = "Drominus - Area 52",
		["Gaulthain - Skywall"] = "Gaulthain - Skywall",
		["Anaiis - Skywall"] = "Anaiis - Skywall",
		["Oldfero - Area 52"] = "Oldfero - Area 52",
		["Drominus - Skywall"] = "Drominus - Skywall",
		["Dalhian - Skywall"] = "Dalhian - Skywall",
		["Cidareth - Skywall"] = "Cidareth - Skywall",
		["Gurund - Area 52"] = "Gurund - Area 52",
		["Gaulthain - Area 52"] = "Gaulthain - Area 52",
		["Feronaz - Area 52"] = "Feronaz - Area 52",
		["Feronis - Skywall"] = "Feronis - Skywall",
		["Malkyn - Dragonblight"] = "Malkyn - Dragonblight",
		["Toradol - Skywall"] = "Toradol - Skywall",
		["Noremedy - Skywall"] = "Noremedy - Skywall",
		["Cecliann - Skywall"] = "Cecliann - Skywall",
		["Feronaz - Skywall"] = "Feronaz - Skywall",
	},
	["profiles"] = {
		["Drominus - Area 52"] = {
			["general"] = {
				["raidmarkerbar"] = {
					["backdrop"] = true,
				},
				["normTex"] = "Glaze2",
				["minimapbar"] = {
					["mouseover"] = true,
					["backdrop"] = true,
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
				["glossTex"] = "Armory",
				["minimap"] = {
					["hideincombat"] = true,
				},
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
		["Anaiis - Skywall"] = {
			["install_complete"] = "6.9996",
		},
		["Oldfero - Area 52"] = {
			["general"] = {
				["raidmarkerbar"] = {
					["visibility"] = "INPARTY",
					["enable"] = false,
				},
				["namefont"] = "Friz Quadrata TT",
				["minimapbar"] = {
					["mouseover"] = true,
					["backdrop"] = true,
				},
				["dmgfont"] = "Friz Quadrata TT",
			},
			["CBPO"] = {
				["warned"] = true,
			},
			["farmer"] = {
				["enabled"] = false,
			},
			["addonskins"] = {
				["BigWigsHalfBar"] = true,
				["DBMFontFlag"] = "THICKOUTLINE",
				["EmbedLeftWidth"] = 132,
				["DBMFontSize"] = 14,
				["DBMFont"] = "Friz Quadrata TT",
				["DBMSkinHalf"] = true,
			},
			["theme"] = "default",
			["install_complete"] = "6.9998",
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
				["DBMFont"] = "2002",
				["DBMFontSize"] = 14,
				["EmbedSystem"] = true,
				["EmbedBelowTop"] = true,
			},
			["theme"] = "classic",
			["install_complete"] = "6.9996",
		},
		["Dalhian - Skywall"] = {
			["general"] = {
				["raidmarkerbar"] = {
					["enable"] = false,
				},
				["minimapbar"] = {
					["mouseover"] = true,
				},
			},
			["theme"] = "classic",
			["install_complete"] = "6.9996",
		},
		["Cidareth - Skywall"] = {
		},
		["Gurund - Area 52"] = {
			["general"] = {
				["minimapbar"] = {
					["mouseover"] = true,
				},
			},
			["install_complete"] = "6.9999",
		},
		["Gaulthain - Area 52"] = {
			["install_complete"] = "6.9996",
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
		["Feronis - Skywall"] = {
			["theme"] = "default",
			["install_complete"] = "6.9996",
		},
		["Malkyn - Dragonblight"] = {
		},
		["Toradol - Skywall"] = {
			["install_complete"] = "6.9996",
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
					["backdrop"] = true,
					["mouseover"] = true,
				},
			},
			["install_complete"] = "6.9996",
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
