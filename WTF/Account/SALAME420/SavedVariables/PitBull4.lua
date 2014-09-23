
PitBull4DB = {
	["namespaces"] = {
		["LeaderIcon"] = {
			["profiles"] = {
				["Default"] = {
					["layouts"] = {
						["Normal"] = {
							["location"] = "left",
							["attach_to"] = "PowerBar",
						},
						["Tiny"] = {
							["enabled"] = false,
							["location"] = "left",
							["attach_to"] = "PowerBar",
						},
						["Box"] = {
							["enabled"] = false,
							["location"] = "left",
							["attach_to"] = "PowerBar",
						},
					},
				},
				["Switch"] = {
					["layouts"] = {
						["Normal"] = {
							["location"] = "left",
							["attach_to"] = "PowerBar",
						},
						["Tiny"] = {
							["enabled"] = false,
							["attach_to"] = "PowerBar",
							["location"] = "left",
						},
						["Box"] = {
							["enabled"] = false,
							["attach_to"] = "PowerBar",
							["location"] = "left",
						},
					},
				},
			},
		},
		["LibDualSpec-1.0"] = {
		},
		["RangeFader"] = {
			["profiles"] = {
				["Default"] = {
					["global"] = {
						["enabled"] = false,
					},
				},
				["Switch"] = {
					["global"] = {
						["enabled"] = false,
					},
				},
			},
		},
		["Border"] = {
			["profiles"] = {
				["Default"] = {
					["global"] = {
						["enabled"] = false,
					},
				},
				["Switch"] = {
					["global"] = {
						["enabled"] = false,
					},
				},
			},
		},
		["PhaseIcon"] = {
			["profiles"] = {
				["Default"] = {
					["layouts"] = {
						["Tiny"] = {
							["position"] = 18,
						},
					},
					["global"] = {
						["enabled"] = false,
					},
				},
				["Switch"] = {
					["layouts"] = {
						["Tiny"] = {
							["position"] = 18,
						},
					},
					["global"] = {
						["enabled"] = false,
					},
				},
			},
		},
		["ComboPoints"] = {
			["profiles"] = {
				["Default"] = {
					["layouts"] = {
						["Tiny"] = {
							["position"] = 17,
						},
					},
					["global"] = {
						["enabled"] = false,
					},
				},
				["Switch"] = {
					["layouts"] = {
						["Tiny"] = {
							["position"] = 17,
						},
					},
					["global"] = {
						["enabled"] = false,
					},
				},
			},
		},
		["RoleIcon"] = {
			["profiles"] = {
				["Default"] = {
					["layouts"] = {
						["Normal"] = {
							["position"] = 1.00001,
						},
						["Tiny"] = {
							["position"] = 27,
						},
						["Box"] = {
							["position"] = 1.00001,
						},
					},
					["global"] = {
						["enabled"] = false,
					},
				},
				["Switch"] = {
					["layouts"] = {
						["Normal"] = {
							["position"] = 1.00001,
						},
						["Tiny"] = {
							["position"] = 27,
						},
						["Box"] = {
							["position"] = 1.00001,
						},
					},
					["global"] = {
						["enabled"] = false,
					},
				},
			},
		},
		["LuaTexts"] = {
			["profiles"] = {
				["Default"] = {
					["layouts"] = {
						["Normal"] = {
							["first"] = false,
							["elements"] = {
								["Lua:Eclipse"] = {
									["enabled"] = false,
									["exists"] = true,
									["events"] = {
										["UNIT_POWER"] = true,
										["UNIT_MAXPOWER"] = true,
									},
									["code"] = "return math.abs(Power(unit,SPELL_POWER_ECLIPSE))\n",
									["location"] = "center",
									["attach_to"] = "Eclipse",
								},
								["Lua:Reputation"] = {
									["enabled"] = false,
									["exists"] = true,
									["events"] = {
										["UNIT_FACTION"] = true,
										["UPDATE_FACTION"] = true,
									},
									["code"] = "local name, _, min , max, value, id = GetWatchedFactionInfo()\nif IsMouseOver() then\n  return name or ConfigMode() \nelse\n  local fs_id, fs_rep, _, _, _, _, _, fs_threshold, next_fs_threshold = GetFriendshipReputation(id)\n  if fs_id then\n    if next_fs_threshold then\n      min, max, value = fs_threshold, next_fs_threshold, fs_rep\n    else\n      min, max, value = 0, 1, 1\n    end\n  end\n  local bar_cur,bar_max = value-min,max-min\n  return \"%d/%d (%s%%)\",bar_cur,bar_max,Percent(bar_cur,bar_max)\nend",
									["location"] = "center",
									["attach_to"] = "ReputationBar",
								},
								["Lua:Power"] = {
									["exists"] = true,
									["events"] = {
										["UNIT_POWER"] = true,
										["UNIT_MAXPOWER"] = true,
									},
									["position"] = 1.00001,
									["location"] = "left",
									["code"] = "local max = MaxPower(unit)\nif max > 0 then\n  if Power(unit) == max then\n    return \"%s\", Short(Power(unit),true)\n  else\n    return \"%s / %s\",Short(Power(unit),true),Short(max,true)\n  end\nend",
									["attach_to"] = "PowerBar",
									["size"] = 0.8,
								},
								["Lua:Experience"] = {
									["enabled"] = false,
									["exists"] = true,
									["events"] = {
										["UNIT_PET_EXPERIENCE"] = true,
										["PLAYER_XP_UPDATE"] = true,
									},
									["code"] = "local cur, max, rest = XP(unit), MaxXP(unit), RestXP(unit)\nif rest then\n  return \"%s/%s (%s%%) R: %s%%\",cur,max,Percent(cur,max),Percent(rest,max)\nelse\n  return \"%s/%s (%s%%)\",cur,max,Percent(cur,max)\nend",
									["location"] = "center",
									["attach_to"] = "ExperienceBar",
								},
								["Lua:Druid mana"] = {
									["enabled"] = false,
									["exists"] = true,
									["events"] = {
										["UNIT_POWER"] = true,
										["UNIT_MAXPOWER"] = true,
									},
									["code"] = "if UnitPowerType(unit) ~= 0 then\n  return \"%s/%s\",Power(unit,0),MaxPower(unit,0)\nend",
									["location"] = "center",
									["attach_to"] = "DruidManaBar",
								},
								["Lua:Threat"] = {
									["enabled"] = false,
									["exists"] = true,
									["events"] = {
										["UNIT_THREAT_LIST_UPDATE"] = true,
										["UNIT_THREAT_SITUATION_UPDATE"] = true,
									},
									["code"] = "local unit_a,unit_b = ThreatPair(unit)\nif unit_a and unit_b then\n  local _,_,percent = UnitDetailedThreatSituation(unit_a, unit_b)\n  if percent and percent ~= 0 then\n    return \"%s%%\",Round(percent,1)\n  end\nend\nreturn ConfigMode()",
									["location"] = "center",
									["attach_to"] = "ThreatBar",
								},
								["Lua:Class"] = {
									["enabled"] = false,
									["exists"] = true,
									["events"] = {
										["UNIT_LEVEL"] = true,
										["UNIT_CLASSIFICATION_CHANGED"] = true,
										["UNIT_AURA"] = true,
									},
									["position"] = 1.00002,
									["location"] = "left",
									["code"] = "local dr,dg,db = DifficultyColor(unit)\nlocal form = DruidForm(unit)\nlocal classification = Classification(unit)\nif UnitIsPlayer(unit) or (not UnitIsFriend(unit,\"player\") and not IsPet(unit)) then\n  local cr,cg,cb = ClassColor(unit)\n  if form then\n    return \"%s%s|cff%02x%02x%02x%s|r |cff%02x%02x%02x%s|r (%s) %s\",classification or '',classification and ' ' or '',dr,dg,db,Level(unit),cr,cg,cb,Class(unit),form,SmartRace(unit) or ''\n  else\n    return \"%s%s|cff%02x%02x%02x%s|r |cff%02x%02x%02x%s|r %s\",classification or '',classification and ' ' or '',dr,dg,db,Level(unit),cr,cg,cb,Class(unit),SmartRace(unit) or ''\n  end\nelse\n  if form then\n    return \"%s%s|cff%02x%02x%02x%s|r (%s) %s\",classification or '',classification and ' ' or '',dr,dg,db,Level(unit),form,SmartRace(unit) or ''\n  else\n    return \"%s%s|cff%02x%02x%02x%s|r %s\",classification or '',classification and ' ' or '',dr,dg,db,Level(unit),SmartRace(unit) or ''\n  end\nend",
									["attach_to"] = "PowerBar",
								},
								["Lua:PVPTimer"] = {
									["enabled"] = false,
									["exists"] = true,
									["events"] = {
										["PLAYER_FLAGS_CHANGED"] = true,
									},
									["code"] = "if unit == \"player\" then\n  local pvp = PVPDuration()\n  if pvp then\n    return \"|cffff0000%s|r\",FormatDuration(pvp)\n  end\nend",
									["location"] = "out_right_top",
								},
								["Lua:Cast time"] = {
									["enabled"] = false,
									["exists"] = true,
									["events"] = {
										["UNIT_SPELLCAST_SUCCEEDED"] = true,
										["UNIT_SPELLCAST_START"] = true,
										["UNIT_SPELLCAST_CHANNEL_START"] = true,
										["UNIT_SPELLCAST_DELAYED"] = true,
										["UNIT_SPELLCAST_CHANNEL_STOP"] = true,
										["UNIT_SPELLCAST_CHANNEL_UPDATE"] = true,
										["UNIT_SPELLCAST_STOP"] = true,
										["UNIT_SPELLCAST_INTERRUPTED"] = true,
										["UNIT_SPELLCAST_FAILED"] = true,
									},
									["code"] = "local cast_data = CastData(unit)\nif cast_data then\n  if not cast_data.stop_time then\n    local delay,end_time = cast_data.delay, cast_data.end_time\n    local duration\n    if end_time then\n      duration = end_time - GetTime()\n    end\n    if delay and delay ~= 0 then\n      local delay_sign = '+'\n      if delay < 0 then\n        delay_sign = ''\n      end\n      if duration and duration >= 0 then\n        return \"|cffff0000%s%s|r %.1f\",delay_sign,Round(delay,1),duration\n      else\n        return \"|cffff0000%s%s|r\",delay_sign,Round(delay,1)\n      end\n    elseif duration and duration >= 0 then\n      return \"%.1f\",duration\n    end\n  end\nend\nreturn ConfigMode()",
									["location"] = "right",
									["attach_to"] = "CastBar",
								},
								["Lua:Cast"] = {
									["enabled"] = false,
									["exists"] = true,
									["events"] = {
										["UNIT_SPELLCAST_DELAYED"] = true,
										["UNIT_SPELLCAST_CHANNEL_START"] = true,
										["UNIT_SPELLCAST_CHANNEL_UPDATE"] = true,
										["UNIT_SPELLCAST_START"] = true,
										["UNIT_SPELLCAST_CHANNEL_STOP"] = true,
										["UNIT_SPELLCAST_STOP"] = true,
										["UNIT_SPELLCAST_INTERRUPTED"] = true,
										["UNIT_SPELLCAST_FAILED"] = true,
									},
									["code"] = "local cast_data = CastData(unit)\nif cast_data then\n  local spell,stop_message,target = cast_data.spell,cast_data.stop_message,cast_data.target\n  local stop_time,stop_duration = cast_data.stop_time\n  if stop_time then\n    stop_duration = GetTime() - stop_time\n  end\n  Alpha(-(stop_duration or 0) + 1)\n  if stop_message then\n    return stop_message\n  elseif target then\n    return \"%s (%s)\",spell,target\n  else\n    return spell \n  end\nend\nreturn ConfigMode()",
									["location"] = "left",
									["attach_to"] = "CastBar",
								},
								["Lua:Health"] = {
									["exists"] = true,
									["events"] = {
										["UNIT_HEALTH"] = true,
										["UNIT_AURA"] = true,
										["UNIT_MAXHEALTH"] = true,
									},
									["position"] = 1.00001,
									["location"] = "right",
									["code"] = "local s = Status(unit)\nif s then\n  return s\nelseif HP(unit) == MaxHP(unit) then\n  return \" \"\nelse\n  return \"%s%%\",Percent(HP(unit),MaxHP(unit))\nend",
									["attach_to"] = "HealthBar",
									["size"] = 1.15,
								},
								["Lua:Alternate power"] = {
									["enabled"] = false,
									["exists"] = true,
									["events"] = {
										["UNIT_POWER"] = true,
										["UNIT_MAXPOWER"] = true,
									},
									["code"] = "local max = MaxPower(unit,ALTERNATE_POWER_INDEX)\nif max > 0 then\n  return \"%s%%\",Percent(Power(unit,ALTERNATE_POWER_INDEX),max)\nend\nreturn ConfigMode()",
									["location"] = "right",
									["attach_to"] = "AltPowerBar",
								},
								["Lua:Absolute Health"] = {
									["exists"] = true,
									["position"] = 1.00001,
									["location"] = "right",
									["code"] = "local s = Status(unit)\nif s then\n  return \" \"\nelseif HP(unit) == MaxHP(unit) then\n  return \"%s\", Short(MaxHP(unit), true)\nelse\n  return \"%s / %s\",Short(HP(unit),true),Short(MaxHP(unit),true)\nend",
									["attach_to"] = "PowerBar",
									["size"] = 0.85,
								},
								["Lua:Name"] = {
									["exists"] = true,
									["code"] = "local abbr = Name(unit)\nif abbr:len() > 20 and abbr:find(\" \") then\n  abbr = abbr:gsub(\"([^ ]+) +\",\n    function(text)\n        return text:sub(1,1) .. \". \"\n    end)\nend\nreturn \"%s\", abbr;\n ",
									["location"] = "left",
									["events"] = {
										["PLAYER_FLAGS_CHANGED"] = true,
										["UNIT_NAME_UPDATE"] = true,
									},
									["attach_to"] = "HealthBar",
									["size"] = 1.15,
								},
								["Lua:Demonic fury"] = {
									["enabled"] = false,
									["exists"] = true,
									["events"] = {
										["UNIT_POWER_FREQUENT"] = true,
										["UNIT_MAXPOWER"] = true,
									},
									["code"] = "return \"%s/%s\",Power(unit,SPELL_POWER_DEMONIC_FURY),MaxPower(unit,SPELL_POWER_DEMONIC_FURY)\n",
									["location"] = "center",
									["attach_to"] = "DemonicFury",
								},
							},
						},
						["Tiny"] = {
							["first"] = false,
							["elements"] = {
								["Lua:Eclipse"] = {
									["enabled"] = false,
									["exists"] = true,
									["events"] = {
										["UNIT_POWER"] = true,
										["UNIT_MAXPOWER"] = true,
									},
									["position"] = 5,
									["location"] = "center",
									["code"] = "return math.abs(Power(unit,SPELL_POWER_ECLIPSE))\n",
									["attach_to"] = "Eclipse",
								},
								["Lua:Reputation"] = {
									["enabled"] = false,
									["exists"] = true,
									["events"] = {
										["UNIT_FACTION"] = true,
										["UPDATE_FACTION"] = true,
									},
									["position"] = 3,
									["location"] = "center",
									["code"] = "local name, _, min , max, value, id = GetWatchedFactionInfo()\nif IsMouseOver() then\n  return name or ConfigMode() \nelse\n  local fs_id, fs_rep, _, _, _, _, _, fs_threshold, next_fs_threshold = GetFriendshipReputation(id)\n  if fs_id then\n    if next_fs_threshold then\n      min, max, value = fs_threshold, next_fs_threshold, fs_rep\n    else\n      min, max, value = 0, 1, 1\n    end\n  end\n  local bar_cur,bar_max = value-min,max-min\n  return \"%d/%d (%s%%)\",bar_cur,bar_max,Percent(bar_cur,bar_max)\nend",
									["attach_to"] = "ReputationBar",
								},
								["Lua:Druid mana"] = {
									["enabled"] = false,
									["exists"] = true,
									["events"] = {
										["UNIT_POWER"] = true,
										["UNIT_MAXPOWER"] = true,
									},
									["position"] = 4,
									["location"] = "center",
									["code"] = "if UnitPowerType(unit) ~= 0 then\n  return \"%s/%s\",Power(unit,0),MaxPower(unit,0)\nend",
									["attach_to"] = "DruidManaBar",
								},
								["Lua:Experience"] = {
									["enabled"] = false,
									["exists"] = true,
									["events"] = {
										["UNIT_PET_EXPERIENCE"] = true,
										["PLAYER_XP_UPDATE"] = true,
									},
									["position"] = 2,
									["location"] = "center",
									["code"] = "local cur, max, rest = XP(unit), MaxXP(unit), RestXP(unit)\nif rest then\n  return \"%s/%s (%s%%) R: %s%%\",cur,max,Percent(cur,max),Percent(rest,max)\nelse\n  return \"%s/%s (%s%%)\",cur,max,Percent(cur,max)\nend",
									["attach_to"] = "ExperienceBar",
								},
								["Lua:Name"] = {
									["exists"] = true,
									["events"] = {
										["PLAYER_FLAGS_CHANGED"] = true,
										["UNIT_NAME_UPDATE"] = true,
									},
									["position"] = 24,
									["location"] = "left",
									["code"] = "local abbr = Name(unit)\nif abbr:len() > 20 and abbr:find(\" \") then\n  abbr = abbr:gsub(\"([^ ]+) +\",\n    function(text)\n        return text:sub(1,1) .. \". \"\n    end)\nend\nreturn \"%s\", abbr;\n ",
									["attach_to"] = "HealthBar",
									["size"] = 0.95,
								},
								["Lua:Threat"] = {
									["enabled"] = false,
									["exists"] = true,
									["events"] = {
										["UNIT_THREAT_LIST_UPDATE"] = true,
										["UNIT_THREAT_SITUATION_UPDATE"] = true,
									},
									["position"] = 7,
									["location"] = "center",
									["code"] = "local unit_a,unit_b = ThreatPair(unit)\nif unit_a and unit_b then\n  local _,_,percent = UnitDetailedThreatSituation(unit_a, unit_b)\n  if percent and percent ~= 0 then\n    return \"%s%%\",Round(percent,1)\n  end\nend\nreturn ConfigMode()",
									["attach_to"] = "ThreatBar",
								},
								["Lua:Class"] = {
									["enabled"] = false,
									["exists"] = true,
									["events"] = {
										["UNIT_LEVEL"] = true,
										["UNIT_CLASSIFICATION_CHANGED"] = true,
										["UNIT_AURA"] = true,
									},
									["position"] = 28,
									["location"] = "left",
									["code"] = "local dr,dg,db = DifficultyColor(unit)\nlocal form = DruidForm(unit)\nlocal classification = Classification(unit)\nif UnitIsPlayer(unit) or (not UnitIsFriend(unit,\"player\") and not IsPet(unit)) then\n  local cr,cg,cb = ClassColor(unit)\n  if form then\n    return \"%s%s|cff%02x%02x%02x%s|r |cff%02x%02x%02x%s|r (%s) %s\",classification or '',classification and ' ' or '',dr,dg,db,Level(unit),cr,cg,cb,Class(unit),form,SmartRace(unit) or ''\n  else\n    return \"%s%s|cff%02x%02x%02x%s|r |cff%02x%02x%02x%s|r %s\",classification or '',classification and ' ' or '',dr,dg,db,Level(unit),cr,cg,cb,Class(unit),SmartRace(unit) or ''\n  end\nelse\n  if form then\n    return \"%s%s|cff%02x%02x%02x%s|r (%s) %s\",classification or '',classification and ' ' or '',dr,dg,db,Level(unit),form,SmartRace(unit) or ''\n  else\n    return \"%s%s|cff%02x%02x%02x%s|r %s\",classification or '',classification and ' ' or '',dr,dg,db,Level(unit),SmartRace(unit) or ''\n  end\nend",
									["attach_to"] = "PowerBar",
								},
								["Lua:PVPTimer"] = {
									["enabled"] = false,
									["exists"] = true,
									["events"] = {
										["PLAYER_FLAGS_CHANGED"] = true,
									},
									["position"] = 10,
									["location"] = "out_right_top",
									["code"] = "if unit == \"player\" then\n  local pvp = PVPDuration()\n  if pvp then\n    return \"|cffff0000%s|r\",FormatDuration(pvp)\n  end\nend",
								},
								["Lua:Cast time"] = {
									["enabled"] = false,
									["exists"] = true,
									["events"] = {
										["UNIT_SPELLCAST_SUCCEEDED"] = true,
										["UNIT_SPELLCAST_START"] = true,
										["UNIT_SPELLCAST_CHANNEL_START"] = true,
										["UNIT_SPELLCAST_DELAYED"] = true,
										["UNIT_SPELLCAST_CHANNEL_STOP"] = true,
										["UNIT_SPELLCAST_CHANNEL_UPDATE"] = true,
										["UNIT_SPELLCAST_STOP"] = true,
										["UNIT_SPELLCAST_INTERRUPTED"] = true,
										["UNIT_SPELLCAST_FAILED"] = true,
									},
									["position"] = 11,
									["location"] = "right",
									["code"] = "local cast_data = CastData(unit)\nif cast_data then\n  if not cast_data.stop_time then\n    local delay,end_time = cast_data.delay, cast_data.end_time\n    local duration\n    if end_time then\n      duration = end_time - GetTime()\n    end\n    if delay and delay ~= 0 then\n      local delay_sign = '+'\n      if delay < 0 then\n        delay_sign = ''\n      end\n      if duration and duration >= 0 then\n        return \"|cffff0000%s%s|r %.1f\",delay_sign,Round(delay,1),duration\n      else\n        return \"|cffff0000%s%s|r\",delay_sign,Round(delay,1)\n      end\n    elseif duration and duration >= 0 then\n      return \"%.1f\",duration\n    end\n  end\nend\nreturn ConfigMode()",
									["attach_to"] = "CastBar",
								},
								["Lua:Cast"] = {
									["enabled"] = false,
									["exists"] = true,
									["events"] = {
										["UNIT_SPELLCAST_DELAYED"] = true,
										["UNIT_SPELLCAST_CHANNEL_START"] = true,
										["UNIT_SPELLCAST_CHANNEL_UPDATE"] = true,
										["UNIT_SPELLCAST_START"] = true,
										["UNIT_SPELLCAST_CHANNEL_STOP"] = true,
										["UNIT_SPELLCAST_STOP"] = true,
										["UNIT_SPELLCAST_INTERRUPTED"] = true,
										["UNIT_SPELLCAST_FAILED"] = true,
									},
									["position"] = 8,
									["location"] = "left",
									["code"] = "local cast_data = CastData(unit)\nif cast_data then\n  local spell,stop_message,target = cast_data.spell,cast_data.stop_message,cast_data.target\n  local stop_time,stop_duration = cast_data.stop_time\n  if stop_time then\n    stop_duration = GetTime() - stop_time\n  end\n  Alpha(-(stop_duration or 0) + 1)\n  if stop_message then\n    return stop_message\n  elseif target then\n    return \"%s (%s)\",spell,target\n  else\n    return spell \n  end\nend\nreturn ConfigMode()",
									["attach_to"] = "CastBar",
								},
								["Lua:Health"] = {
									["exists"] = true,
									["events"] = {
										["UNIT_HEALTH"] = true,
										["UNIT_AURA"] = true,
										["UNIT_MAXHEALTH"] = true,
									},
									["position"] = 26,
									["location"] = "right",
									["code"] = "local s = Status(unit)\nif s then\n  return s\nelseif HP(unit) == MaxHP(unit) then\n  return \" \"\nelse\n  return \"%s%%\",Percent(HP(unit),MaxHP(unit))\nend",
									["attach_to"] = "HealthBar",
									["size"] = 0.95,
								},
								["Lua:Alternate power"] = {
									["enabled"] = false,
									["exists"] = true,
									["events"] = {
										["UNIT_POWER"] = true,
										["UNIT_MAXPOWER"] = true,
									},
									["position"] = 9,
									["location"] = "right",
									["code"] = "local max = MaxPower(unit,ALTERNATE_POWER_INDEX)\nif max > 0 then\n  return \"%s%%\",Percent(Power(unit,ALTERNATE_POWER_INDEX),max)\nend\nreturn ConfigMode()",
									["attach_to"] = "AltPowerBar",
								},
								["Lua:Absolute Health"] = {
									["enabled"] = false,
									["exists"] = true,
									["position"] = 23,
									["location"] = "right",
									["code"] = "local s = Status(unit)\nif s then\n  return \" \"\nelseif HP(unit) == MaxHP(unit) then\n  return \"%s\", Short(MaxHP(unit), true)\nelse\n  return \"%s / %s\",Short(HP(unit),true),Short(MaxHP(unit),true)\nend",
									["attach_to"] = "PowerBar",
									["size"] = 0.85,
								},
								["Lua:Power"] = {
									["enabled"] = false,
									["exists"] = true,
									["events"] = {
										["UNIT_POWER"] = true,
										["UNIT_MAXPOWER"] = true,
									},
									["position"] = 29,
									["location"] = "left",
									["code"] = "local max = MaxPower(unit)\nif max > 0 then\n  if Power(unit) == max then\n    return \"%s\", Short(Power(unit),true)\n  else\n    return \"%s / %s\",Short(Power(unit),true),Short(max,true)\n  end\nend",
									["attach_to"] = "PowerBar",
									["size"] = 0.8,
								},
								["Lua:Demonic fury"] = {
									["enabled"] = false,
									["exists"] = true,
									["events"] = {
										["UNIT_POWER_FREQUENT"] = true,
										["UNIT_MAXPOWER"] = true,
									},
									["position"] = 20,
									["location"] = "center",
									["code"] = "return \"%s/%s\",Power(unit,SPELL_POWER_DEMONIC_FURY),MaxPower(unit,SPELL_POWER_DEMONIC_FURY)\n",
									["attach_to"] = "DemonicFury",
								},
							},
						},
						["Box"] = {
							["first"] = false,
							["elements"] = {
								["Lua:Eclipse"] = {
									["enabled"] = false,
									["exists"] = true,
									["events"] = {
										["UNIT_MAXPOWER"] = true,
										["UNIT_POWER"] = true,
									},
									["code"] = "return math.abs(Power(unit,SPELL_POWER_ECLIPSE))\n",
									["location"] = "center",
									["attach_to"] = "Eclipse",
								},
								["Lua:Experience"] = {
									["enabled"] = false,
									["exists"] = true,
									["events"] = {
										["UNIT_PET_EXPERIENCE"] = true,
										["PLAYER_XP_UPDATE"] = true,
									},
									["code"] = "local cur, max, rest = XP(unit), MaxXP(unit), RestXP(unit)\nif rest then\n  return \"%s/%s (%s%%) R: %s%%\",cur,max,Percent(cur,max),Percent(rest,max)\nelse\n  return \"%s/%s (%s%%)\",cur,max,Percent(cur,max)\nend",
									["location"] = "center",
									["attach_to"] = "ExperienceBar",
								},
								["Lua:Name"] = {
									["exists"] = true,
									["code"] = "local abbr = Name(unit)\nif abbr:len() > 20 and abbr:find(\" \") then\n  abbr = abbr:gsub(\"([^ ]+) +\",\n    function(text)\n        return text:sub(1,1) .. \". \"\n    end)\nend\nreturn \"%s\", abbr;\n ",
									["location"] = "center",
									["events"] = {
										["PLAYER_FLAGS_CHANGED"] = true,
										["UNIT_NAME_UPDATE"] = true,
									},
									["attach_to"] = "PowerBar",
									["size"] = 0.75,
								},
								["Lua:Reputation"] = {
									["enabled"] = false,
									["exists"] = true,
									["events"] = {
										["UNIT_FACTION"] = true,
										["UPDATE_FACTION"] = true,
									},
									["code"] = "local name, _, min , max, value, id = GetWatchedFactionInfo()\nif IsMouseOver() then\n  return name or ConfigMode() \nelse\n  local fs_id, fs_rep, _, _, _, _, _, fs_threshold, next_fs_threshold = GetFriendshipReputation(id)\n  if fs_id then\n    if next_fs_threshold then\n      min, max, value = fs_threshold, next_fs_threshold, fs_rep\n    else\n      min, max, value = 0, 1, 1\n    end\n  end\n  local bar_cur,bar_max = value-min,max-min\n  return \"%d/%d (%s%%)\",bar_cur,bar_max,Percent(bar_cur,bar_max)\nend",
									["location"] = "center",
									["attach_to"] = "ReputationBar",
								},
								["Lua:Power"] = {
									["enabled"] = false,
									["exists"] = true,
									["events"] = {
										["UNIT_MAXPOWER"] = true,
										["UNIT_POWER"] = true,
									},
									["position"] = 1.00001,
									["location"] = "left",
									["code"] = "local max = MaxPower(unit)\nif max > 0 then\n  if Power(unit) == max then\n    return \"%s\", Short(Power(unit),true)\n  else\n    return \"%s / %s\",Short(Power(unit),true),Short(max,true)\n  end\nend",
									["attach_to"] = "PowerBar",
									["size"] = 0.8,
								},
								["Lua:Threat"] = {
									["enabled"] = false,
									["exists"] = true,
									["events"] = {
										["UNIT_THREAT_LIST_UPDATE"] = true,
										["UNIT_THREAT_SITUATION_UPDATE"] = true,
									},
									["code"] = "local unit_a,unit_b = ThreatPair(unit)\nif unit_a and unit_b then\n  local _,_,percent = UnitDetailedThreatSituation(unit_a, unit_b)\n  if percent and percent ~= 0 then\n    return \"%s%%\",Round(percent,1)\n  end\nend\nreturn ConfigMode()",
									["location"] = "center",
									["attach_to"] = "ThreatBar",
								},
								["Lua:Absolute Health"] = {
									["enabled"] = false,
									["exists"] = true,
									["position"] = 1.00001,
									["location"] = "right",
									["code"] = "local s = Status(unit)\nif s then\n  return \" \"\nelseif HP(unit) == MaxHP(unit) then\n  return \"%s\", Short(MaxHP(unit), true)\nelse\n  return \"%s / %s\",Short(HP(unit),true),Short(MaxHP(unit),true)\nend",
									["attach_to"] = "PowerBar",
									["size"] = 0.85,
								},
								["Lua:Alternate power"] = {
									["enabled"] = false,
									["exists"] = true,
									["events"] = {
										["UNIT_MAXPOWER"] = true,
										["UNIT_POWER"] = true,
									},
									["code"] = "local max = MaxPower(unit,ALTERNATE_POWER_INDEX)\nif max > 0 then\n  return \"%s%%\",Percent(Power(unit,ALTERNATE_POWER_INDEX),max)\nend\nreturn ConfigMode()",
									["location"] = "right",
									["attach_to"] = "AltPowerBar",
								},
								["Lua:Cast"] = {
									["enabled"] = false,
									["exists"] = true,
									["events"] = {
										["UNIT_SPELLCAST_DELAYED"] = true,
										["UNIT_SPELLCAST_FAILED"] = true,
										["UNIT_SPELLCAST_CHANNEL_UPDATE"] = true,
										["UNIT_SPELLCAST_INTERRUPTED"] = true,
										["UNIT_SPELLCAST_CHANNEL_STOP"] = true,
										["UNIT_SPELLCAST_STOP"] = true,
										["UNIT_SPELLCAST_START"] = true,
										["UNIT_SPELLCAST_CHANNEL_START"] = true,
									},
									["code"] = "local cast_data = CastData(unit)\nif cast_data then\n  local spell,stop_message,target = cast_data.spell,cast_data.stop_message,cast_data.target\n  local stop_time,stop_duration = cast_data.stop_time\n  if stop_time then\n    stop_duration = GetTime() - stop_time\n  end\n  Alpha(-(stop_duration or 0) + 1)\n  if stop_message then\n    return stop_message\n  elseif target then\n    return \"%s (%s)\",spell,target\n  else\n    return spell \n  end\nend\nreturn ConfigMode()",
									["location"] = "left",
									["attach_to"] = "CastBar",
								},
								["Lua:Cast time"] = {
									["enabled"] = false,
									["exists"] = true,
									["events"] = {
										["UNIT_SPELLCAST_SUCCEEDED"] = true,
										["UNIT_SPELLCAST_START"] = true,
										["UNIT_SPELLCAST_CHANNEL_START"] = true,
										["UNIT_SPELLCAST_DELAYED"] = true,
										["UNIT_SPELLCAST_CHANNEL_UPDATE"] = true,
										["UNIT_SPELLCAST_CHANNEL_STOP"] = true,
										["UNIT_SPELLCAST_STOP"] = true,
										["UNIT_SPELLCAST_INTERRUPTED"] = true,
										["UNIT_SPELLCAST_FAILED"] = true,
									},
									["code"] = "local cast_data = CastData(unit)\nif cast_data then\n  if not cast_data.stop_time then\n    local delay,end_time = cast_data.delay, cast_data.end_time\n    local duration\n    if end_time then\n      duration = end_time - GetTime()\n    end\n    if delay and delay ~= 0 then\n      local delay_sign = '+'\n      if delay < 0 then\n        delay_sign = ''\n      end\n      if duration and duration >= 0 then\n        return \"|cffff0000%s%s|r %.1f\",delay_sign,Round(delay,1),duration\n      else\n        return \"|cffff0000%s%s|r\",delay_sign,Round(delay,1)\n      end\n    elseif duration and duration >= 0 then\n      return \"%.1f\",duration\n    end\n  end\nend\nreturn ConfigMode()",
									["location"] = "right",
									["attach_to"] = "CastBar",
								},
								["Lua:Health"] = {
									["exists"] = true,
									["events"] = {
										["UNIT_HEALTH"] = true,
										["UNIT_AURA"] = true,
										["UNIT_MAXHEALTH"] = true,
									},
									["position"] = 1.00001,
									["location"] = "center",
									["code"] = "local s = Status(unit)\nif s then\n  return s\nelseif HP(unit) == MaxHP(unit) then\n  return \" \"\nelse\n  return \"%s%%\",Percent(HP(unit),MaxHP(unit))\nend",
									["attach_to"] = "HealthBar",
									["size"] = 0.75,
								},
								["Lua:PVPTimer"] = {
									["enabled"] = false,
									["exists"] = true,
									["events"] = {
										["PLAYER_FLAGS_CHANGED"] = true,
									},
									["code"] = "if unit == \"player\" then\n  local pvp = PVPDuration()\n  if pvp then\n    return \"|cffff0000%s|r\",FormatDuration(pvp)\n  end\nend",
									["location"] = "out_right_top",
								},
								["Lua:Class"] = {
									["enabled"] = false,
									["exists"] = true,
									["events"] = {
										["UNIT_LEVEL"] = true,
										["UNIT_CLASSIFICATION_CHANGED"] = true,
										["UNIT_AURA"] = true,
									},
									["position"] = 1.00002,
									["location"] = "left",
									["code"] = "local dr,dg,db = DifficultyColor(unit)\nlocal form = DruidForm(unit)\nlocal classification = Classification(unit)\nif UnitIsPlayer(unit) or (not UnitIsFriend(unit,\"player\") and not IsPet(unit)) then\n  local cr,cg,cb = ClassColor(unit)\n  if form then\n    return \"%s%s|cff%02x%02x%02x%s|r |cff%02x%02x%02x%s|r (%s) %s\",classification or '',classification and ' ' or '',dr,dg,db,Level(unit),cr,cg,cb,Class(unit),form,SmartRace(unit) or ''\n  else\n    return \"%s%s|cff%02x%02x%02x%s|r |cff%02x%02x%02x%s|r %s\",classification or '',classification and ' ' or '',dr,dg,db,Level(unit),cr,cg,cb,Class(unit),SmartRace(unit) or ''\n  end\nelse\n  if form then\n    return \"%s%s|cff%02x%02x%02x%s|r (%s) %s\",classification or '',classification and ' ' or '',dr,dg,db,Level(unit),form,SmartRace(unit) or ''\n  else\n    return \"%s%s|cff%02x%02x%02x%s|r %s\",classification or '',classification and ' ' or '',dr,dg,db,Level(unit),SmartRace(unit) or ''\n  end\nend",
									["attach_to"] = "PowerBar",
								},
								["Lua:Druid mana"] = {
									["enabled"] = false,
									["exists"] = true,
									["events"] = {
										["UNIT_MAXPOWER"] = true,
										["UNIT_POWER"] = true,
									},
									["code"] = "if UnitPowerType(unit) ~= 0 then\n  return \"%s/%s\",Power(unit,0),MaxPower(unit,0)\nend",
									["location"] = "center",
									["attach_to"] = "DruidManaBar",
								},
								["Lua:Demonic fury"] = {
									["enabled"] = false,
									["exists"] = true,
									["events"] = {
										["UNIT_MAXPOWER"] = true,
										["UNIT_POWER_FREQUENT"] = true,
									},
									["code"] = "return \"%s/%s\",Power(unit,SPELL_POWER_DEMONIC_FURY),MaxPower(unit,SPELL_POWER_DEMONIC_FURY)\n",
									["location"] = "center",
									["attach_to"] = "DemonicFury",
								},
							},
						},
					},
				},
				["Switch"] = {
					["layouts"] = {
						["Normal"] = {
							["elements"] = {
								["Lua:Eclipse"] = {
									["enabled"] = false,
									["exists"] = true,
									["code"] = "return math.abs(Power(unit,SPELL_POWER_ECLIPSE))\n",
									["location"] = "center",
									["attach_to"] = "Eclipse",
									["events"] = {
										["UNIT_MAXPOWER"] = true,
										["UNIT_POWER"] = true,
									},
								},
								["Lua:Experience"] = {
									["enabled"] = false,
									["exists"] = true,
									["code"] = "local cur, max, rest = XP(unit), MaxXP(unit), RestXP(unit)\nif rest then\n  return \"%s/%s (%s%%) R: %s%%\",cur,max,Percent(cur,max),Percent(rest,max)\nelse\n  return \"%s/%s (%s%%)\",cur,max,Percent(cur,max)\nend",
									["location"] = "center",
									["attach_to"] = "ExperienceBar",
									["events"] = {
										["UNIT_PET_EXPERIENCE"] = true,
										["PLAYER_XP_UPDATE"] = true,
									},
								},
								["Lua:Druid mana"] = {
									["enabled"] = false,
									["exists"] = true,
									["code"] = "if UnitPowerType(unit) ~= 0 then\n  return \"%s/%s\",Power(unit,0),MaxPower(unit,0)\nend",
									["location"] = "center",
									["attach_to"] = "DruidManaBar",
									["events"] = {
										["UNIT_MAXPOWER"] = true,
										["UNIT_POWER"] = true,
									},
								},
								["Lua:Reputation"] = {
									["enabled"] = false,
									["exists"] = true,
									["code"] = "local name, _, min , max, value, id = GetWatchedFactionInfo()\nif IsMouseOver() then\n  return name or ConfigMode() \nelse\n  local fs_id, fs_rep, _, _, _, _, _, fs_threshold, next_fs_threshold = GetFriendshipReputation(id)\n  if fs_id then\n    if next_fs_threshold then\n      min, max, value = fs_threshold, next_fs_threshold, fs_rep\n    else\n      min, max, value = 0, 1, 1\n    end\n  end\n  local bar_cur,bar_max = value-min,max-min\n  return \"%d/%d (%s%%)\",bar_cur,bar_max,Percent(bar_cur,bar_max)\nend",
									["location"] = "center",
									["attach_to"] = "ReputationBar",
									["events"] = {
										["UNIT_FACTION"] = true,
										["UPDATE_FACTION"] = true,
									},
								},
								["Lua:Name"] = {
									["exists"] = true,
									["code"] = "local abbr = Name(unit)\nif abbr:len() > 20 and abbr:find(\" \") then\n  abbr = abbr:gsub(\"([^ ]+) +\",\n    function(text)\n        return text:sub(1,1) .. \". \"\n    end)\nend\nreturn \"%s\", abbr;\n ",
									["location"] = "left",
									["events"] = {
										["PLAYER_FLAGS_CHANGED"] = true,
										["UNIT_NAME_UPDATE"] = true,
									},
									["attach_to"] = "HealthBar",
									["size"] = 1.15,
								},
								["Lua:Threat"] = {
									["enabled"] = false,
									["exists"] = true,
									["code"] = "local unit_a,unit_b = ThreatPair(unit)\nif unit_a and unit_b then\n  local _,_,percent = UnitDetailedThreatSituation(unit_a, unit_b)\n  if percent and percent ~= 0 then\n    return \"%s%%\",Round(percent,1)\n  end\nend\nreturn ConfigMode()",
									["location"] = "center",
									["attach_to"] = "ThreatBar",
									["events"] = {
										["UNIT_THREAT_LIST_UPDATE"] = true,
										["UNIT_THREAT_SITUATION_UPDATE"] = true,
									},
								},
								["Lua:Absolute Health"] = {
									["exists"] = true,
									["position"] = 1.00001,
									["location"] = "right",
									["code"] = "local s = Status(unit)\nif s then\n  return \" \"\nelseif HP(unit) == MaxHP(unit) then\n  return \"%s\", Short(MaxHP(unit), true)\nelse\n  return \"%s / %s\",Short(HP(unit),true),Short(MaxHP(unit),true)\nend",
									["attach_to"] = "PowerBar",
									["size"] = 0.85,
								},
								["Lua:Alternate power"] = {
									["enabled"] = false,
									["exists"] = true,
									["code"] = "local max = MaxPower(unit,ALTERNATE_POWER_INDEX)\nif max > 0 then\n  return \"%s%%\",Percent(Power(unit,ALTERNATE_POWER_INDEX),max)\nend\nreturn ConfigMode()",
									["location"] = "right",
									["attach_to"] = "AltPowerBar",
									["events"] = {
										["UNIT_MAXPOWER"] = true,
										["UNIT_POWER"] = true,
									},
								},
								["Lua:Cast"] = {
									["enabled"] = false,
									["exists"] = true,
									["code"] = "local cast_data = CastData(unit)\nif cast_data then\n  local spell,stop_message,target = cast_data.spell,cast_data.stop_message,cast_data.target\n  local stop_time,stop_duration = cast_data.stop_time\n  if stop_time then\n    stop_duration = GetTime() - stop_time\n  end\n  Alpha(-(stop_duration or 0) + 1)\n  if stop_message then\n    return stop_message\n  elseif target then\n    return \"%s (%s)\",spell,target\n  else\n    return spell \n  end\nend\nreturn ConfigMode()",
									["location"] = "left",
									["attach_to"] = "CastBar",
									["events"] = {
										["UNIT_SPELLCAST_DELAYED"] = true,
										["UNIT_SPELLCAST_FAILED"] = true,
										["UNIT_SPELLCAST_CHANNEL_UPDATE"] = true,
										["UNIT_SPELLCAST_INTERRUPTED"] = true,
										["UNIT_SPELLCAST_CHANNEL_STOP"] = true,
										["UNIT_SPELLCAST_STOP"] = true,
										["UNIT_SPELLCAST_START"] = true,
										["UNIT_SPELLCAST_CHANNEL_START"] = true,
									},
								},
								["Lua:Cast time"] = {
									["enabled"] = false,
									["exists"] = true,
									["code"] = "local cast_data = CastData(unit)\nif cast_data then\n  if not cast_data.stop_time then\n    local delay,end_time = cast_data.delay, cast_data.end_time\n    local duration\n    if end_time then\n      duration = end_time - GetTime()\n    end\n    if delay and delay ~= 0 then\n      local delay_sign = '+'\n      if delay < 0 then\n        delay_sign = ''\n      end\n      if duration and duration >= 0 then\n        return \"|cffff0000%s%s|r %.1f\",delay_sign,Round(delay,1),duration\n      else\n        return \"|cffff0000%s%s|r\",delay_sign,Round(delay,1)\n      end\n    elseif duration and duration >= 0 then\n      return \"%.1f\",duration\n    end\n  end\nend\nreturn ConfigMode()",
									["location"] = "right",
									["attach_to"] = "CastBar",
									["events"] = {
										["UNIT_SPELLCAST_SUCCEEDED"] = true,
										["UNIT_SPELLCAST_START"] = true,
										["UNIT_SPELLCAST_CHANNEL_START"] = true,
										["UNIT_SPELLCAST_DELAYED"] = true,
										["UNIT_SPELLCAST_CHANNEL_UPDATE"] = true,
										["UNIT_SPELLCAST_CHANNEL_STOP"] = true,
										["UNIT_SPELLCAST_STOP"] = true,
										["UNIT_SPELLCAST_INTERRUPTED"] = true,
										["UNIT_SPELLCAST_FAILED"] = true,
									},
								},
								["Lua:Health"] = {
									["events"] = {
										["UNIT_HEALTH"] = true,
										["UNIT_AURA"] = true,
										["UNIT_MAXHEALTH"] = true,
									},
									["exists"] = true,
									["position"] = 1.00001,
									["location"] = "right",
									["code"] = "local s = Status(unit)\nif s then\n  return s\nelseif HP(unit) == MaxHP(unit) then\n  return \" \"\nelse\n  return \"%s%%\",Percent(HP(unit),MaxHP(unit))\nend",
									["attach_to"] = "HealthBar",
									["size"] = 1.15,
								},
								["Lua:PVPTimer"] = {
									["enabled"] = false,
									["exists"] = true,
									["code"] = "if unit == \"player\" then\n  local pvp = PVPDuration()\n  if pvp then\n    return \"|cffff0000%s|r\",FormatDuration(pvp)\n  end\nend",
									["location"] = "out_right_top",
									["events"] = {
										["PLAYER_FLAGS_CHANGED"] = true,
									},
								},
								["Lua:Class"] = {
									["enabled"] = false,
									["events"] = {
										["UNIT_LEVEL"] = true,
										["UNIT_CLASSIFICATION_CHANGED"] = true,
										["UNIT_AURA"] = true,
									},
									["code"] = "local dr,dg,db = DifficultyColor(unit)\nlocal form = DruidForm(unit)\nlocal classification = Classification(unit)\nif UnitIsPlayer(unit) or (not UnitIsFriend(unit,\"player\") and not IsPet(unit)) then\n  local cr,cg,cb = ClassColor(unit)\n  if form then\n    return \"%s%s|cff%02x%02x%02x%s|r |cff%02x%02x%02x%s|r (%s) %s\",classification or '',classification and ' ' or '',dr,dg,db,Level(unit),cr,cg,cb,Class(unit),form,SmartRace(unit) or ''\n  else\n    return \"%s%s|cff%02x%02x%02x%s|r |cff%02x%02x%02x%s|r %s\",classification or '',classification and ' ' or '',dr,dg,db,Level(unit),cr,cg,cb,Class(unit),SmartRace(unit) or ''\n  end\nelse\n  if form then\n    return \"%s%s|cff%02x%02x%02x%s|r (%s) %s\",classification or '',classification and ' ' or '',dr,dg,db,Level(unit),form,SmartRace(unit) or ''\n  else\n    return \"%s%s|cff%02x%02x%02x%s|r %s\",classification or '',classification and ' ' or '',dr,dg,db,Level(unit),SmartRace(unit) or ''\n  end\nend",
									["location"] = "left",
									["position"] = 1.00002,
									["attach_to"] = "PowerBar",
									["exists"] = true,
								},
								["Lua:Power"] = {
									["events"] = {
										["UNIT_MAXPOWER"] = true,
										["UNIT_POWER"] = true,
									},
									["exists"] = true,
									["position"] = 1.00001,
									["location"] = "left",
									["code"] = "local max = MaxPower(unit)\nif max > 0 then\n  if Power(unit) == max then\n    return \"%s\", Short(Power(unit),true)\n  else\n    return \"%s / %s\",Short(Power(unit),true),Short(max,true)\n  end\nend",
									["attach_to"] = "PowerBar",
									["size"] = 0.8,
								},
								["Lua:Demonic fury"] = {
									["enabled"] = false,
									["exists"] = true,
									["code"] = "return \"%s/%s\",Power(unit,SPELL_POWER_DEMONIC_FURY),MaxPower(unit,SPELL_POWER_DEMONIC_FURY)\n",
									["location"] = "center",
									["attach_to"] = "DemonicFury",
									["events"] = {
										["UNIT_MAXPOWER"] = true,
										["UNIT_POWER_FREQUENT"] = true,
									},
								},
							},
							["first"] = false,
						},
						["Tiny"] = {
							["elements"] = {
								["Lua:Eclipse"] = {
									["enabled"] = false,
									["events"] = {
										["UNIT_MAXPOWER"] = true,
										["UNIT_POWER"] = true,
									},
									["code"] = "return math.abs(Power(unit,SPELL_POWER_ECLIPSE))\n",
									["location"] = "center",
									["position"] = 5,
									["attach_to"] = "Eclipse",
									["exists"] = true,
								},
								["Lua:Experience"] = {
									["enabled"] = false,
									["events"] = {
										["UNIT_PET_EXPERIENCE"] = true,
										["PLAYER_XP_UPDATE"] = true,
									},
									["code"] = "local cur, max, rest = XP(unit), MaxXP(unit), RestXP(unit)\nif rest then\n  return \"%s/%s (%s%%) R: %s%%\",cur,max,Percent(cur,max),Percent(rest,max)\nelse\n  return \"%s/%s (%s%%)\",cur,max,Percent(cur,max)\nend",
									["location"] = "center",
									["position"] = 2,
									["attach_to"] = "ExperienceBar",
									["exists"] = true,
								},
								["Lua:Name"] = {
									["events"] = {
										["PLAYER_FLAGS_CHANGED"] = true,
										["UNIT_NAME_UPDATE"] = true,
									},
									["exists"] = true,
									["position"] = 24,
									["location"] = "left",
									["code"] = "local abbr = Name(unit)\nif abbr:len() > 20 and abbr:find(\" \") then\n  abbr = abbr:gsub(\"([^ ]+) +\",\n    function(text)\n        return text:sub(1,1) .. \". \"\n    end)\nend\nreturn \"%s\", abbr;\n ",
									["attach_to"] = "HealthBar",
									["size"] = 0.95,
								},
								["Lua:Reputation"] = {
									["enabled"] = false,
									["events"] = {
										["UNIT_FACTION"] = true,
										["UPDATE_FACTION"] = true,
									},
									["code"] = "local name, _, min , max, value, id = GetWatchedFactionInfo()\nif IsMouseOver() then\n  return name or ConfigMode() \nelse\n  local fs_id, fs_rep, _, _, _, _, _, fs_threshold, next_fs_threshold = GetFriendshipReputation(id)\n  if fs_id then\n    if next_fs_threshold then\n      min, max, value = fs_threshold, next_fs_threshold, fs_rep\n    else\n      min, max, value = 0, 1, 1\n    end\n  end\n  local bar_cur,bar_max = value-min,max-min\n  return \"%d/%d (%s%%)\",bar_cur,bar_max,Percent(bar_cur,bar_max)\nend",
									["location"] = "center",
									["position"] = 3,
									["attach_to"] = "ReputationBar",
									["exists"] = true,
								},
								["Lua:Power"] = {
									["enabled"] = false,
									["events"] = {
										["UNIT_MAXPOWER"] = true,
										["UNIT_POWER"] = true,
									},
									["exists"] = true,
									["position"] = 29,
									["location"] = "left",
									["code"] = "local max = MaxPower(unit)\nif max > 0 then\n  if Power(unit) == max then\n    return \"%s\", Short(Power(unit),true)\n  else\n    return \"%s / %s\",Short(Power(unit),true),Short(max,true)\n  end\nend",
									["attach_to"] = "PowerBar",
									["size"] = 0.8,
								},
								["Lua:Threat"] = {
									["enabled"] = false,
									["events"] = {
										["UNIT_THREAT_LIST_UPDATE"] = true,
										["UNIT_THREAT_SITUATION_UPDATE"] = true,
									},
									["code"] = "local unit_a,unit_b = ThreatPair(unit)\nif unit_a and unit_b then\n  local _,_,percent = UnitDetailedThreatSituation(unit_a, unit_b)\n  if percent and percent ~= 0 then\n    return \"%s%%\",Round(percent,1)\n  end\nend\nreturn ConfigMode()",
									["location"] = "center",
									["position"] = 7,
									["attach_to"] = "ThreatBar",
									["exists"] = true,
								},
								["Lua:Absolute Health"] = {
									["enabled"] = false,
									["exists"] = true,
									["position"] = 23,
									["location"] = "right",
									["code"] = "local s = Status(unit)\nif s then\n  return \" \"\nelseif HP(unit) == MaxHP(unit) then\n  return \"%s\", Short(MaxHP(unit), true)\nelse\n  return \"%s / %s\",Short(HP(unit),true),Short(MaxHP(unit),true)\nend",
									["attach_to"] = "PowerBar",
									["size"] = 0.85,
								},
								["Lua:Alternate power"] = {
									["enabled"] = false,
									["events"] = {
										["UNIT_MAXPOWER"] = true,
										["UNIT_POWER"] = true,
									},
									["code"] = "local max = MaxPower(unit,ALTERNATE_POWER_INDEX)\nif max > 0 then\n  return \"%s%%\",Percent(Power(unit,ALTERNATE_POWER_INDEX),max)\nend\nreturn ConfigMode()",
									["location"] = "right",
									["position"] = 9,
									["attach_to"] = "AltPowerBar",
									["exists"] = true,
								},
								["Lua:Cast"] = {
									["enabled"] = false,
									["events"] = {
										["UNIT_SPELLCAST_DELAYED"] = true,
										["UNIT_SPELLCAST_FAILED"] = true,
										["UNIT_SPELLCAST_CHANNEL_UPDATE"] = true,
										["UNIT_SPELLCAST_INTERRUPTED"] = true,
										["UNIT_SPELLCAST_CHANNEL_STOP"] = true,
										["UNIT_SPELLCAST_STOP"] = true,
										["UNIT_SPELLCAST_START"] = true,
										["UNIT_SPELLCAST_CHANNEL_START"] = true,
									},
									["code"] = "local cast_data = CastData(unit)\nif cast_data then\n  local spell,stop_message,target = cast_data.spell,cast_data.stop_message,cast_data.target\n  local stop_time,stop_duration = cast_data.stop_time\n  if stop_time then\n    stop_duration = GetTime() - stop_time\n  end\n  Alpha(-(stop_duration or 0) + 1)\n  if stop_message then\n    return stop_message\n  elseif target then\n    return \"%s (%s)\",spell,target\n  else\n    return spell \n  end\nend\nreturn ConfigMode()",
									["location"] = "left",
									["position"] = 8,
									["attach_to"] = "CastBar",
									["exists"] = true,
								},
								["Lua:Cast time"] = {
									["enabled"] = false,
									["events"] = {
										["UNIT_SPELLCAST_SUCCEEDED"] = true,
										["UNIT_SPELLCAST_START"] = true,
										["UNIT_SPELLCAST_CHANNEL_START"] = true,
										["UNIT_SPELLCAST_DELAYED"] = true,
										["UNIT_SPELLCAST_CHANNEL_UPDATE"] = true,
										["UNIT_SPELLCAST_CHANNEL_STOP"] = true,
										["UNIT_SPELLCAST_STOP"] = true,
										["UNIT_SPELLCAST_INTERRUPTED"] = true,
										["UNIT_SPELLCAST_FAILED"] = true,
									},
									["code"] = "local cast_data = CastData(unit)\nif cast_data then\n  if not cast_data.stop_time then\n    local delay,end_time = cast_data.delay, cast_data.end_time\n    local duration\n    if end_time then\n      duration = end_time - GetTime()\n    end\n    if delay and delay ~= 0 then\n      local delay_sign = '+'\n      if delay < 0 then\n        delay_sign = ''\n      end\n      if duration and duration >= 0 then\n        return \"|cffff0000%s%s|r %.1f\",delay_sign,Round(delay,1),duration\n      else\n        return \"|cffff0000%s%s|r\",delay_sign,Round(delay,1)\n      end\n    elseif duration and duration >= 0 then\n      return \"%.1f\",duration\n    end\n  end\nend\nreturn ConfigMode()",
									["location"] = "right",
									["position"] = 11,
									["attach_to"] = "CastBar",
									["exists"] = true,
								},
								["Lua:Health"] = {
									["events"] = {
										["UNIT_HEALTH"] = true,
										["UNIT_AURA"] = true,
										["UNIT_MAXHEALTH"] = true,
									},
									["exists"] = true,
									["position"] = 26,
									["location"] = "right",
									["code"] = "local s = Status(unit)\nif s then\n  return s\nelseif HP(unit) == MaxHP(unit) then\n  return \" \"\nelse\n  return \"%s%%\",Percent(HP(unit),MaxHP(unit))\nend",
									["attach_to"] = "HealthBar",
									["size"] = 0.95,
								},
								["Lua:PVPTimer"] = {
									["enabled"] = false,
									["events"] = {
										["PLAYER_FLAGS_CHANGED"] = true,
									},
									["code"] = "if unit == \"player\" then\n  local pvp = PVPDuration()\n  if pvp then\n    return \"|cffff0000%s|r\",FormatDuration(pvp)\n  end\nend",
									["location"] = "out_right_top",
									["position"] = 10,
									["exists"] = true,
								},
								["Lua:Class"] = {
									["enabled"] = false,
									["events"] = {
										["UNIT_LEVEL"] = true,
										["UNIT_CLASSIFICATION_CHANGED"] = true,
										["UNIT_AURA"] = true,
									},
									["code"] = "local dr,dg,db = DifficultyColor(unit)\nlocal form = DruidForm(unit)\nlocal classification = Classification(unit)\nif UnitIsPlayer(unit) or (not UnitIsFriend(unit,\"player\") and not IsPet(unit)) then\n  local cr,cg,cb = ClassColor(unit)\n  if form then\n    return \"%s%s|cff%02x%02x%02x%s|r |cff%02x%02x%02x%s|r (%s) %s\",classification or '',classification and ' ' or '',dr,dg,db,Level(unit),cr,cg,cb,Class(unit),form,SmartRace(unit) or ''\n  else\n    return \"%s%s|cff%02x%02x%02x%s|r |cff%02x%02x%02x%s|r %s\",classification or '',classification and ' ' or '',dr,dg,db,Level(unit),cr,cg,cb,Class(unit),SmartRace(unit) or ''\n  end\nelse\n  if form then\n    return \"%s%s|cff%02x%02x%02x%s|r (%s) %s\",classification or '',classification and ' ' or '',dr,dg,db,Level(unit),form,SmartRace(unit) or ''\n  else\n    return \"%s%s|cff%02x%02x%02x%s|r %s\",classification or '',classification and ' ' or '',dr,dg,db,Level(unit),SmartRace(unit) or ''\n  end\nend",
									["location"] = "left",
									["position"] = 28,
									["attach_to"] = "PowerBar",
									["exists"] = true,
								},
								["Lua:Druid mana"] = {
									["enabled"] = false,
									["events"] = {
										["UNIT_MAXPOWER"] = true,
										["UNIT_POWER"] = true,
									},
									["code"] = "if UnitPowerType(unit) ~= 0 then\n  return \"%s/%s\",Power(unit,0),MaxPower(unit,0)\nend",
									["location"] = "center",
									["position"] = 4,
									["attach_to"] = "DruidManaBar",
									["exists"] = true,
								},
								["Lua:Demonic fury"] = {
									["enabled"] = false,
									["events"] = {
										["UNIT_MAXPOWER"] = true,
										["UNIT_POWER_FREQUENT"] = true,
									},
									["code"] = "return \"%s/%s\",Power(unit,SPELL_POWER_DEMONIC_FURY),MaxPower(unit,SPELL_POWER_DEMONIC_FURY)\n",
									["location"] = "center",
									["position"] = 20,
									["attach_to"] = "DemonicFury",
									["exists"] = true,
								},
							},
							["first"] = false,
						},
						["Box"] = {
							["elements"] = {
								["Lua:Eclipse"] = {
									["enabled"] = false,
									["exists"] = true,
									["code"] = "return math.abs(Power(unit,SPELL_POWER_ECLIPSE))\n",
									["location"] = "center",
									["attach_to"] = "Eclipse",
									["events"] = {
										["UNIT_POWER"] = true,
										["UNIT_MAXPOWER"] = true,
									},
								},
								["Lua:Reputation"] = {
									["enabled"] = false,
									["exists"] = true,
									["code"] = "local name, _, min , max, value, id = GetWatchedFactionInfo()\nif IsMouseOver() then\n  return name or ConfigMode() \nelse\n  local fs_id, fs_rep, _, _, _, _, _, fs_threshold, next_fs_threshold = GetFriendshipReputation(id)\n  if fs_id then\n    if next_fs_threshold then\n      min, max, value = fs_threshold, next_fs_threshold, fs_rep\n    else\n      min, max, value = 0, 1, 1\n    end\n  end\n  local bar_cur,bar_max = value-min,max-min\n  return \"%d/%d (%s%%)\",bar_cur,bar_max,Percent(bar_cur,bar_max)\nend",
									["location"] = "center",
									["attach_to"] = "ReputationBar",
									["events"] = {
										["UNIT_FACTION"] = true,
										["UPDATE_FACTION"] = true,
									},
								},
								["Lua:Power"] = {
									["enabled"] = false,
									["events"] = {
										["UNIT_POWER"] = true,
										["UNIT_MAXPOWER"] = true,
									},
									["exists"] = true,
									["position"] = 1.00001,
									["location"] = "left",
									["code"] = "local max = MaxPower(unit)\nif max > 0 then\n  if Power(unit) == max then\n    return \"%s\", Short(Power(unit),true)\n  else\n    return \"%s / %s\",Short(Power(unit),true),Short(max,true)\n  end\nend",
									["attach_to"] = "PowerBar",
									["size"] = 0.8,
								},
								["Lua:Experience"] = {
									["enabled"] = false,
									["exists"] = true,
									["code"] = "local cur, max, rest = XP(unit), MaxXP(unit), RestXP(unit)\nif rest then\n  return \"%s/%s (%s%%) R: %s%%\",cur,max,Percent(cur,max),Percent(rest,max)\nelse\n  return \"%s/%s (%s%%)\",cur,max,Percent(cur,max)\nend",
									["location"] = "center",
									["attach_to"] = "ExperienceBar",
									["events"] = {
										["UNIT_PET_EXPERIENCE"] = true,
										["PLAYER_XP_UPDATE"] = true,
									},
								},
								["Lua:Druid mana"] = {
									["enabled"] = false,
									["exists"] = true,
									["code"] = "if UnitPowerType(unit) ~= 0 then\n  return \"%s/%s\",Power(unit,0),MaxPower(unit,0)\nend",
									["location"] = "center",
									["attach_to"] = "DruidManaBar",
									["events"] = {
										["UNIT_POWER"] = true,
										["UNIT_MAXPOWER"] = true,
									},
								},
								["Lua:Threat"] = {
									["enabled"] = false,
									["exists"] = true,
									["code"] = "local unit_a,unit_b = ThreatPair(unit)\nif unit_a and unit_b then\n  local _,_,percent = UnitDetailedThreatSituation(unit_a, unit_b)\n  if percent and percent ~= 0 then\n    return \"%s%%\",Round(percent,1)\n  end\nend\nreturn ConfigMode()",
									["location"] = "center",
									["attach_to"] = "ThreatBar",
									["events"] = {
										["UNIT_THREAT_LIST_UPDATE"] = true,
										["UNIT_THREAT_SITUATION_UPDATE"] = true,
									},
								},
								["Lua:Class"] = {
									["enabled"] = false,
									["events"] = {
										["UNIT_LEVEL"] = true,
										["UNIT_CLASSIFICATION_CHANGED"] = true,
										["UNIT_AURA"] = true,
									},
									["code"] = "local dr,dg,db = DifficultyColor(unit)\nlocal form = DruidForm(unit)\nlocal classification = Classification(unit)\nif UnitIsPlayer(unit) or (not UnitIsFriend(unit,\"player\") and not IsPet(unit)) then\n  local cr,cg,cb = ClassColor(unit)\n  if form then\n    return \"%s%s|cff%02x%02x%02x%s|r |cff%02x%02x%02x%s|r (%s) %s\",classification or '',classification and ' ' or '',dr,dg,db,Level(unit),cr,cg,cb,Class(unit),form,SmartRace(unit) or ''\n  else\n    return \"%s%s|cff%02x%02x%02x%s|r |cff%02x%02x%02x%s|r %s\",classification or '',classification and ' ' or '',dr,dg,db,Level(unit),cr,cg,cb,Class(unit),SmartRace(unit) or ''\n  end\nelse\n  if form then\n    return \"%s%s|cff%02x%02x%02x%s|r (%s) %s\",classification or '',classification and ' ' or '',dr,dg,db,Level(unit),form,SmartRace(unit) or ''\n  else\n    return \"%s%s|cff%02x%02x%02x%s|r %s\",classification or '',classification and ' ' or '',dr,dg,db,Level(unit),SmartRace(unit) or ''\n  end\nend",
									["location"] = "left",
									["position"] = 1.00002,
									["attach_to"] = "PowerBar",
									["exists"] = true,
								},
								["Lua:PVPTimer"] = {
									["enabled"] = false,
									["exists"] = true,
									["code"] = "if unit == \"player\" then\n  local pvp = PVPDuration()\n  if pvp then\n    return \"|cffff0000%s|r\",FormatDuration(pvp)\n  end\nend",
									["location"] = "out_right_top",
									["events"] = {
										["PLAYER_FLAGS_CHANGED"] = true,
									},
								},
								["Lua:Cast time"] = {
									["enabled"] = false,
									["exists"] = true,
									["code"] = "local cast_data = CastData(unit)\nif cast_data then\n  if not cast_data.stop_time then\n    local delay,end_time = cast_data.delay, cast_data.end_time\n    local duration\n    if end_time then\n      duration = end_time - GetTime()\n    end\n    if delay and delay ~= 0 then\n      local delay_sign = '+'\n      if delay < 0 then\n        delay_sign = ''\n      end\n      if duration and duration >= 0 then\n        return \"|cffff0000%s%s|r %.1f\",delay_sign,Round(delay,1),duration\n      else\n        return \"|cffff0000%s%s|r\",delay_sign,Round(delay,1)\n      end\n    elseif duration and duration >= 0 then\n      return \"%.1f\",duration\n    end\n  end\nend\nreturn ConfigMode()",
									["location"] = "right",
									["attach_to"] = "CastBar",
									["events"] = {
										["UNIT_SPELLCAST_SUCCEEDED"] = true,
										["UNIT_SPELLCAST_START"] = true,
										["UNIT_SPELLCAST_CHANNEL_START"] = true,
										["UNIT_SPELLCAST_DELAYED"] = true,
										["UNIT_SPELLCAST_CHANNEL_STOP"] = true,
										["UNIT_SPELLCAST_CHANNEL_UPDATE"] = true,
										["UNIT_SPELLCAST_STOP"] = true,
										["UNIT_SPELLCAST_INTERRUPTED"] = true,
										["UNIT_SPELLCAST_FAILED"] = true,
									},
								},
								["Lua:Cast"] = {
									["enabled"] = false,
									["exists"] = true,
									["code"] = "local cast_data = CastData(unit)\nif cast_data then\n  local spell,stop_message,target = cast_data.spell,cast_data.stop_message,cast_data.target\n  local stop_time,stop_duration = cast_data.stop_time\n  if stop_time then\n    stop_duration = GetTime() - stop_time\n  end\n  Alpha(-(stop_duration or 0) + 1)\n  if stop_message then\n    return stop_message\n  elseif target then\n    return \"%s (%s)\",spell,target\n  else\n    return spell \n  end\nend\nreturn ConfigMode()",
									["location"] = "left",
									["attach_to"] = "CastBar",
									["events"] = {
										["UNIT_SPELLCAST_DELAYED"] = true,
										["UNIT_SPELLCAST_CHANNEL_START"] = true,
										["UNIT_SPELLCAST_CHANNEL_UPDATE"] = true,
										["UNIT_SPELLCAST_START"] = true,
										["UNIT_SPELLCAST_CHANNEL_STOP"] = true,
										["UNIT_SPELLCAST_STOP"] = true,
										["UNIT_SPELLCAST_INTERRUPTED"] = true,
										["UNIT_SPELLCAST_FAILED"] = true,
									},
								},
								["Lua:Health"] = {
									["events"] = {
										["UNIT_HEALTH"] = true,
										["UNIT_AURA"] = true,
										["UNIT_MAXHEALTH"] = true,
									},
									["exists"] = true,
									["position"] = 1.00001,
									["location"] = "center",
									["code"] = "local s = Status(unit)\nif s then\n  return s\nelseif HP(unit) == MaxHP(unit) then\n  return \" \"\nelse\n  return \"%s%%\",Percent(HP(unit),MaxHP(unit))\nend",
									["attach_to"] = "HealthBar",
									["size"] = 0.75,
								},
								["Lua:Alternate power"] = {
									["enabled"] = false,
									["exists"] = true,
									["code"] = "local max = MaxPower(unit,ALTERNATE_POWER_INDEX)\nif max > 0 then\n  return \"%s%%\",Percent(Power(unit,ALTERNATE_POWER_INDEX),max)\nend\nreturn ConfigMode()",
									["location"] = "right",
									["attach_to"] = "AltPowerBar",
									["events"] = {
										["UNIT_POWER"] = true,
										["UNIT_MAXPOWER"] = true,
									},
								},
								["Lua:Absolute Health"] = {
									["enabled"] = false,
									["exists"] = true,
									["position"] = 1.00001,
									["location"] = "right",
									["code"] = "local s = Status(unit)\nif s then\n  return \" \"\nelseif HP(unit) == MaxHP(unit) then\n  return \"%s\", Short(MaxHP(unit), true)\nelse\n  return \"%s / %s\",Short(HP(unit),true),Short(MaxHP(unit),true)\nend",
									["attach_to"] = "PowerBar",
									["size"] = 0.85,
								},
								["Lua:Name"] = {
									["exists"] = true,
									["code"] = "local abbr = Name(unit)\nif abbr:len() > 20 and abbr:find(\" \") then\n  abbr = abbr:gsub(\"([^ ]+) +\",\n    function(text)\n        return text:sub(1,1) .. \". \"\n    end)\nend\nreturn \"%s\", abbr;\n ",
									["location"] = "center",
									["events"] = {
										["PLAYER_FLAGS_CHANGED"] = true,
										["UNIT_NAME_UPDATE"] = true,
									},
									["attach_to"] = "PowerBar",
									["size"] = 0.75,
								},
								["Lua:Demonic fury"] = {
									["enabled"] = false,
									["exists"] = true,
									["code"] = "return \"%s/%s\",Power(unit,SPELL_POWER_DEMONIC_FURY),MaxPower(unit,SPELL_POWER_DEMONIC_FURY)\n",
									["location"] = "center",
									["attach_to"] = "DemonicFury",
									["events"] = {
										["UNIT_POWER_FREQUENT"] = true,
										["UNIT_MAXPOWER"] = true,
									},
								},
							},
							["first"] = false,
						},
					},
				},
			},
		},
		["SoulShards"] = {
		},
		["HostilityFader"] = {
			["profiles"] = {
				["Default"] = {
					["global"] = {
						["enabled"] = false,
					},
				},
				["Switch"] = {
					["global"] = {
						["enabled"] = false,
					},
				},
			},
		},
		["MasterLooterIcon"] = {
			["profiles"] = {
				["Default"] = {
					["layouts"] = {
						["Normal"] = {
							["location"] = "left",
							["attach_to"] = "PowerBar",
							["size"] = 0.9,
						},
						["Tiny"] = {
							["enabled"] = false,
							["position"] = 30,
							["location"] = "left",
							["attach_to"] = "PowerBar",
							["size"] = 0.9,
						},
						["Box"] = {
							["enabled"] = false,
							["location"] = "left",
							["attach_to"] = "PowerBar",
							["size"] = 0.9,
						},
					},
				},
				["Switch"] = {
					["layouts"] = {
						["Normal"] = {
							["location"] = "left",
							["attach_to"] = "PowerBar",
							["size"] = 0.9,
						},
						["Tiny"] = {
							["enabled"] = false,
							["position"] = 30,
							["location"] = "left",
							["attach_to"] = "PowerBar",
							["size"] = 0.9,
						},
						["Box"] = {
							["enabled"] = false,
							["location"] = "left",
							["attach_to"] = "PowerBar",
							["size"] = 0.9,
						},
					},
				},
			},
		},
		["CombatText"] = {
			["profiles"] = {
				["Default"] = {
					["layouts"] = {
						["Tiny"] = {
							["position"] = 16,
						},
					},
					["global"] = {
						["enabled"] = false,
					},
				},
				["Switch"] = {
					["layouts"] = {
						["Tiny"] = {
							["position"] = 16,
						},
					},
					["global"] = {
						["enabled"] = false,
					},
				},
			},
		},
		["ReadyCheckIcon"] = {
			["profiles"] = {
				["Default"] = {
					["layouts"] = {
						["Normal"] = {
							["location"] = "right",
							["attach_to"] = "PowerBar",
							["size"] = 1.1,
						},
						["Tiny"] = {
							["enabled"] = false,
							["position"] = 19,
							["location"] = "right",
							["attach_to"] = "PowerBar",
							["size"] = 1.1,
						},
						["Box"] = {
							["enabled"] = false,
							["location"] = "right",
							["attach_to"] = "PowerBar",
							["size"] = 1.1,
						},
					},
				},
				["Switch"] = {
					["layouts"] = {
						["Normal"] = {
							["location"] = "right",
							["attach_to"] = "PowerBar",
							["size"] = 1.1,
						},
						["Tiny"] = {
							["enabled"] = false,
							["position"] = 19,
							["location"] = "right",
							["attach_to"] = "PowerBar",
							["size"] = 1.1,
						},
						["Box"] = {
							["enabled"] = false,
							["location"] = "right",
							["attach_to"] = "PowerBar",
							["size"] = 1.1,
						},
					},
				},
			},
		},
		["Totems"] = {
			["profiles"] = {
				["Default"] = {
					["layouts"] = {
						["Tiny"] = {
							["position"] = 21,
						},
					},
					["global"] = {
						["enabled"] = false,
					},
				},
			},
		},
		["Portrait"] = {
			["profiles"] = {
				["Default"] = {
					["global"] = {
						["enabled"] = false,
					},
				},
				["Switch"] = {
					["global"] = {
						["enabled"] = false,
					},
				},
			},
		},
		["ExperienceBar"] = {
			["profiles"] = {
				["Default"] = {
					["global"] = {
						["enabled"] = false,
					},
				},
				["Switch"] = {
					["global"] = {
						["enabled"] = false,
					},
				},
			},
		},
		["RaidTargetIcon"] = {
			["profiles"] = {
				["Default"] = {
					["layouts"] = {
						["Normal"] = {
							["location"] = "right",
							["attach_to"] = "HealthBar",
							["size"] = 1.85,
						},
						["Tiny"] = {
							["position"] = 25,
							["location"] = "right",
							["attach_to"] = "HealthBar",
							["size"] = 1.85,
						},
						["Box"] = {
							["location"] = "left",
							["attach_to"] = "HealthBar",
							["size"] = 1.85,
						},
					},
				},
				["Switch"] = {
					["layouts"] = {
						["Normal"] = {
							["location"] = "right",
							["attach_to"] = "HealthBar",
							["size"] = 1.85,
						},
						["Tiny"] = {
							["location"] = "right",
							["position"] = 25,
							["attach_to"] = "HealthBar",
							["size"] = 1.85,
						},
						["Box"] = {
							["location"] = "left",
							["attach_to"] = "HealthBar",
							["size"] = 1.85,
						},
					},
				},
			},
		},
		["ShadowOrbs"] = {
		},
		["Highlight"] = {
			["profiles"] = {
				["Default"] = {
					["global"] = {
						["enabled"] = false,
					},
				},
				["Switch"] = {
					["global"] = {
						["enabled"] = false,
					},
				},
			},
		},
		["Runes"] = {
			["profiles"] = {
				["Default"] = {
					["layouts"] = {
						["Normal"] = {
							["enabled"] = false,
						},
					},
				},
			},
		},
		["CastBar"] = {
			["profiles"] = {
				["Default"] = {
					["global"] = {
						["enabled"] = false,
					},
				},
				["Switch"] = {
					["global"] = {
						["enabled"] = false,
					},
				},
			},
		},
		["BurningEmbers"] = {
			["profiles"] = {
				["Default"] = {
					["layouts"] = {
						["Normal"] = {
							["enabled"] = false,
							["background_color"] = {
								nil, -- [1]
								nil, -- [2]
								nil, -- [3]
								0.1025640964508057, -- [4]
							},
							["position"] = 1.00001,
							["location"] = "edge_top",
							["size"] = 3.3,
						},
					},
				},
			},
		},
		["BurningEmbersBar"] = {
			["profiles"] = {
				["Default"] = {
					["layouts"] = {
						["Normal"] = {
							["background_alpha"] = 0.3,
							["custom_background"] = {
								0.007843137254901961, -- [1]
								0.007843137254901961, -- [2]
								0.007843137254901961, -- [3]
								1, -- [4]
							},
							["texture"] = "VuhDo - Plain",
							["alpha"] = 0.7000000000000001,
							["position"] = 1,
							["custom_color"] = {
								0.6627450980392157, -- [1]
								0.06666666666666667, -- [2]
								0.07843137254901961, -- [3]
								1, -- [4]
							},
						},
					},
				},
			},
		},
		["Aura"] = {
			["profiles"] = {
				["Default"] = {
					["global"] = {
						["enabled"] = false,
					},
				},
				["Switch"] = {
					["global"] = {
						["enabled"] = false,
					},
				},
			},
		},
		["ReputationBar"] = {
			["profiles"] = {
				["Default"] = {
					["global"] = {
						["enabled"] = false,
					},
				},
				["Switch"] = {
					["global"] = {
						["enabled"] = false,
					},
				},
			},
		},
		["Background"] = {
			["profiles"] = {
				["Default"] = {
					["global"] = {
						["enabled"] = false,
					},
				},
				["Switch"] = {
					["global"] = {
						["enabled"] = false,
					},
				},
			},
		},
		["PowerBar"] = {
			["profiles"] = {
				["Default"] = {
					["layouts"] = {
						["Normal"] = {
							["background_alpha"] = 0.3,
							["custom_background"] = {
								0.007843137254901961, -- [1]
								0.007843137254901961, -- [2]
								0.007843137254901961, -- [3]
								1, -- [4]
							},
							["deficit"] = true,
							["reverse"] = true,
							["custom_color"] = {
								0.007843137254901961, -- [1]
								0.007843137254901961, -- [2]
								0.007843137254901961, -- [3]
								1, -- [4]
							},
						},
						["Tiny"] = {
							["background_alpha"] = 0.3,
							["custom_background"] = {
								0.007843137254901961, -- [1]
								0.007843137254901961, -- [2]
								0.007843137254901961, -- [3]
								1, -- [4]
							},
							["deficit"] = true,
							["reverse"] = true,
							["custom_color"] = {
								0.007843137254901961, -- [1]
								0.007843137254901961, -- [2]
								0.007843137254901961, -- [3]
								1, -- [4]
							},
						},
						["Box"] = {
							["background_alpha"] = 0.3,
							["custom_background"] = {
								0.007843137254901961, -- [1]
								0.007843137254901961, -- [2]
								0.007843137254901961, -- [3]
								1, -- [4]
							},
							["deficit"] = true,
							["reverse"] = true,
							["custom_color"] = {
								0.007843137254901961, -- [1]
								0.007843137254901961, -- [2]
								0.007843137254901961, -- [3]
								1, -- [4]
							},
						},
					},
				},
				["Switch"] = {
					["layouts"] = {
						["Normal"] = {
							["deficit"] = true,
							["background_alpha"] = 0.3,
							["custom_background"] = {
								0.007843137254901961, -- [1]
								0.007843137254901961, -- [2]
								0.007843137254901961, -- [3]
								1, -- [4]
							},
							["reverse"] = true,
							["custom_color"] = {
								0.007843137254901961, -- [1]
								0.007843137254901961, -- [2]
								0.007843137254901961, -- [3]
								1, -- [4]
							},
						},
						["Tiny"] = {
							["deficit"] = true,
							["background_alpha"] = 0.3,
							["custom_background"] = {
								0.007843137254901961, -- [1]
								0.007843137254901961, -- [2]
								0.007843137254901961, -- [3]
								1, -- [4]
							},
							["reverse"] = true,
							["custom_color"] = {
								0.007843137254901961, -- [1]
								0.007843137254901961, -- [2]
								0.007843137254901961, -- [3]
								1, -- [4]
							},
						},
						["Box"] = {
							["deficit"] = true,
							["background_alpha"] = 0.3,
							["custom_background"] = {
								0.007843137254901961, -- [1]
								0.007843137254901961, -- [2]
								0.007843137254901961, -- [3]
								1, -- [4]
							},
							["reverse"] = true,
							["custom_color"] = {
								0.007843137254901961, -- [1]
								0.007843137254901961, -- [2]
								0.007843137254901961, -- [3]
								1, -- [4]
							},
						},
					},
				},
			},
		},
		["HideBlizzard"] = {
			["profiles"] = {
				["Default"] = {
					["global"] = {
						["altpower"] = true,
						["aura"] = true,
						["raid"] = true,
					},
				},
				["Switch"] = {
					["global"] = {
						["altpower"] = true,
						["raid"] = true,
						["aura"] = true,
					},
				},
			},
		},
		["RestIcon"] = {
			["profiles"] = {
				["Default"] = {
					["layouts"] = {
						["Tiny"] = {
							["position"] = 14,
						},
					},
					["global"] = {
						["enabled"] = false,
					},
				},
				["Switch"] = {
					["layouts"] = {
						["Tiny"] = {
							["position"] = 14,
						},
					},
					["global"] = {
						["enabled"] = false,
					},
				},
			},
		},
		["Sounds"] = {
			["profiles"] = {
				["Default"] = {
					["global"] = {
						["enabled"] = false,
					},
				},
				["Switch"] = {
					["global"] = {
						["enabled"] = false,
					},
				},
			},
		},
		["HealthBar"] = {
			["profiles"] = {
				["Default"] = {
					["layouts"] = {
						["Normal"] = {
							["color_by_class"] = false,
							["background_alpha"] = 0.3,
							["custom_background"] = {
								0.02352941176470588, -- [1]
								0.02352941176470588, -- [2]
								0.02352941176470588, -- [3]
								1, -- [4]
							},
							["size"] = 8,
							["hostility_color_npcs"] = false,
							["deficit"] = true,
							["reverse"] = true,
							["custom_color"] = {
								0.01568627450980392, -- [1]
								0.01568627450980392, -- [2]
								0.01568627450980392, -- [3]
								1, -- [4]
							},
							["hostility_color"] = false,
						},
						["Tiny"] = {
							["color_by_class"] = false,
							["background_alpha"] = 0.3,
							["custom_background"] = {
								0.02352941176470588, -- [1]
								0.02352941176470588, -- [2]
								0.02352941176470588, -- [3]
								1, -- [4]
							},
							["size"] = 8,
							["hostility_color_npcs"] = false,
							["deficit"] = true,
							["reverse"] = true,
							["custom_color"] = {
								0.01568627450980392, -- [1]
								0.01568627450980392, -- [2]
								0.01568627450980392, -- [3]
								1, -- [4]
							},
							["hostility_color"] = false,
						},
						["Box"] = {
							["color_by_class"] = false,
							["background_alpha"] = 0.3,
							["custom_background"] = {
								0.02352941176470588, -- [1]
								0.02352941176470588, -- [2]
								0.02352941176470588, -- [3]
								1, -- [4]
							},
							["size"] = 8,
							["hostility_color_npcs"] = false,
							["deficit"] = true,
							["reverse"] = true,
							["custom_color"] = {
								0.01568627450980392, -- [1]
								0.01568627450980392, -- [2]
								0.01568627450980392, -- [3]
								1, -- [4]
							},
							["hostility_color"] = false,
						},
					},
				},
				["Switch"] = {
					["layouts"] = {
						["Normal"] = {
							["color_by_class"] = false,
							["background_alpha"] = 0.3,
							["custom_background"] = {
								0.02352941176470588, -- [1]
								0.02352941176470588, -- [2]
								0.02352941176470588, -- [3]
								1, -- [4]
							},
							["hostility_color_npcs"] = false,
							["deficit"] = true,
							["reverse"] = true,
							["hostility_color"] = false,
							["custom_color"] = {
								0.01568627450980392, -- [1]
								0.01568627450980392, -- [2]
								0.01568627450980392, -- [3]
								1, -- [4]
							},
							["size"] = 8,
						},
						["Tiny"] = {
							["color_by_class"] = false,
							["background_alpha"] = 0.3,
							["custom_background"] = {
								0.02352941176470588, -- [1]
								0.02352941176470588, -- [2]
								0.02352941176470588, -- [3]
								1, -- [4]
							},
							["hostility_color_npcs"] = false,
							["deficit"] = true,
							["reverse"] = true,
							["hostility_color"] = false,
							["custom_color"] = {
								0.01568627450980392, -- [1]
								0.01568627450980392, -- [2]
								0.01568627450980392, -- [3]
								1, -- [4]
							},
							["size"] = 8,
						},
						["Box"] = {
							["color_by_class"] = false,
							["background_alpha"] = 0.3,
							["custom_background"] = {
								0.02352941176470588, -- [1]
								0.02352941176470588, -- [2]
								0.02352941176470588, -- [3]
								1, -- [4]
							},
							["hostility_color_npcs"] = false,
							["deficit"] = true,
							["reverse"] = true,
							["hostility_color"] = false,
							["custom_color"] = {
								0.01568627450980392, -- [1]
								0.01568627450980392, -- [2]
								0.01568627450980392, -- [3]
								1, -- [4]
							},
							["size"] = 8,
						},
					},
				},
			},
		},
		["PvPIcon"] = {
			["profiles"] = {
				["Default"] = {
					["layouts"] = {
						["Tiny"] = {
							["position"] = 6,
						},
					},
					["global"] = {
						["enabled"] = false,
					},
				},
				["Switch"] = {
					["layouts"] = {
						["Tiny"] = {
							["position"] = 6,
						},
					},
					["global"] = {
						["enabled"] = false,
					},
				},
			},
		},
		["VoiceIcon"] = {
			["profiles"] = {
				["Default"] = {
					["layouts"] = {
						["Tiny"] = {
							["position"] = 22,
						},
					},
					["global"] = {
						["enabled"] = false,
					},
				},
				["Switch"] = {
					["layouts"] = {
						["Tiny"] = {
							["position"] = 22,
						},
					},
					["global"] = {
						["enabled"] = false,
					},
				},
			},
		},
		["QuestIcon"] = {
			["profiles"] = {
				["Default"] = {
					["layouts"] = {
						["Tiny"] = {
							["position"] = 15,
						},
					},
					["global"] = {
						["enabled"] = false,
					},
				},
				["Switch"] = {
					["layouts"] = {
						["Tiny"] = {
							["position"] = 15,
						},
					},
					["global"] = {
						["enabled"] = false,
					},
				},
			},
		},
		["VisualHeal"] = {
			["profiles"] = {
				["Default"] = {
					["global"] = {
						["enabled"] = false,
					},
				},
				["Switch"] = {
					["global"] = {
						["enabled"] = false,
					},
				},
			},
		},
		["DemonicFury"] = {
			["profiles"] = {
				["Default"] = {
					["layouts"] = {
						["Normal"] = {
							["position"] = 4,
						},
					},
				},
			},
		},
		["CombatFader"] = {
			["profiles"] = {
				["Default"] = {
					["global"] = {
						["enabled"] = false,
					},
				},
				["Switch"] = {
					["global"] = {
						["enabled"] = false,
					},
				},
			},
		},
		["BattlePet"] = {
			["profiles"] = {
				["Default"] = {
					["layouts"] = {
						["Tiny"] = {
							["position"] = 12,
						},
					},
					["global"] = {
						["enabled"] = false,
					},
				},
				["Switch"] = {
					["layouts"] = {
						["Tiny"] = {
							["position"] = 12,
						},
					},
					["global"] = {
						["enabled"] = false,
					},
				},
			},
		},
		["AltPowerBar"] = {
			["profiles"] = {
				["Default"] = {
					["layouts"] = {
						["Normal"] = {
							["custom_color"] = {
								0.03137254901960784, -- [1]
								0.03137254901960784, -- [2]
								0.03137254901960784, -- [3]
								1, -- [4]
							},
							["deficit"] = true,
							["background_alpha"] = 0.3,
							["custom_background"] = {
								0.0392156862745098, -- [1]
								0.0392156862745098, -- [2]
								0.0392156862745098, -- [3]
								1, -- [4]
							},
						},
						["Tiny"] = {
							["custom_color"] = {
								0.03137254901960784, -- [1]
								0.03137254901960784, -- [2]
								0.03137254901960784, -- [3]
								1, -- [4]
							},
							["deficit"] = true,
							["background_alpha"] = 0.3,
							["custom_background"] = {
								0.0392156862745098, -- [1]
								0.0392156862745098, -- [2]
								0.0392156862745098, -- [3]
								1, -- [4]
							},
						},
						["Box"] = {
							["custom_color"] = {
								0.03137254901960784, -- [1]
								0.03137254901960784, -- [2]
								0.03137254901960784, -- [3]
								1, -- [4]
							},
							["deficit"] = true,
							["background_alpha"] = 0.3,
							["custom_background"] = {
								0.0392156862745098, -- [1]
								0.0392156862745098, -- [2]
								0.0392156862745098, -- [3]
								1, -- [4]
							},
						},
					},
					["global"] = {
						["enabled"] = false,
					},
				},
				["Switch"] = {
					["layouts"] = {
						["Normal"] = {
							["custom_color"] = {
								0.03137254901960784, -- [1]
								0.03137254901960784, -- [2]
								0.03137254901960784, -- [3]
								1, -- [4]
							},
							["deficit"] = true,
							["background_alpha"] = 0.3,
							["custom_background"] = {
								0.0392156862745098, -- [1]
								0.0392156862745098, -- [2]
								0.0392156862745098, -- [3]
								1, -- [4]
							},
						},
						["Tiny"] = {
							["custom_color"] = {
								0.03137254901960784, -- [1]
								0.03137254901960784, -- [2]
								0.03137254901960784, -- [3]
								1, -- [4]
							},
							["deficit"] = true,
							["background_alpha"] = 0.3,
							["custom_background"] = {
								0.0392156862745098, -- [1]
								0.0392156862745098, -- [2]
								0.0392156862745098, -- [3]
								1, -- [4]
							},
						},
						["Box"] = {
							["custom_color"] = {
								0.03137254901960784, -- [1]
								0.03137254901960784, -- [2]
								0.03137254901960784, -- [3]
								1, -- [4]
							},
							["deficit"] = true,
							["background_alpha"] = 0.3,
							["custom_background"] = {
								0.0392156862745098, -- [1]
								0.0392156862745098, -- [2]
								0.0392156862745098, -- [3]
								1, -- [4]
							},
						},
					},
					["global"] = {
						["enabled"] = false,
					},
				},
			},
		},
		["BlankSpace"] = {
			["profiles"] = {
				["Default"] = {
					["layouts"] = {
						["Normal"] = {
							["elements"] = {
								["Default"] = {
									["exists"] = true,
								},
							},
							["first"] = false,
						},
						["Tiny"] = {
							["elements"] = {
								["Default"] = {
									["exists"] = true,
								},
							},
							["first"] = false,
						},
						["Box"] = {
							["elements"] = {
								["Default"] = {
									["exists"] = true,
								},
							},
							["first"] = false,
						},
					},
					["global"] = {
						["enabled"] = false,
					},
				},
				["Switch"] = {
					["layouts"] = {
						["Normal"] = {
							["elements"] = {
								["Default"] = {
									["exists"] = true,
								},
							},
							["first"] = false,
						},
						["Tiny"] = {
							["elements"] = {
								["Default"] = {
									["exists"] = true,
								},
							},
							["first"] = false,
						},
						["Box"] = {
							["elements"] = {
								["Default"] = {
									["exists"] = true,
								},
							},
							["first"] = false,
						},
					},
					["global"] = {
						["enabled"] = false,
					},
				},
			},
		},
		["ThreatBar"] = {
			["profiles"] = {
				["Default"] = {
					["global"] = {
						["enabled"] = false,
					},
				},
				["Switch"] = {
					["global"] = {
						["enabled"] = false,
					},
				},
			},
		},
		["CastBarLatency"] = {
			["profiles"] = {
				["Default"] = {
					["global"] = {
						["enabled"] = false,
					},
				},
				["Switch"] = {
					["global"] = {
						["enabled"] = false,
					},
				},
			},
		},
		["CombatIcon"] = {
			["profiles"] = {
				["Default"] = {
					["layouts"] = {
						["Tiny"] = {
							["position"] = 13,
						},
					},
					["global"] = {
						["enabled"] = false,
					},
				},
				["Switch"] = {
					["layouts"] = {
						["Tiny"] = {
							["position"] = 13,
						},
					},
					["global"] = {
						["enabled"] = false,
					},
				},
			},
		},
		["Aggro"] = {
			["profiles"] = {
				["Default"] = {
					["global"] = {
						["enabled"] = false,
					},
				},
				["Switch"] = {
					["global"] = {
						["enabled"] = false,
					},
				},
			},
		},
	},
	["profileKeys"] = {
		["Feronaz - Area 52"] = "Default",
		["Oldfero - Area 52"] = "Default",
		["Toradol - Skywall"] = "Default",
		["Drominus - Area 52"] = "Default",
		["Jartzart - Area 52"] = "Switch",
	},
	["global"] = {
		["config_version"] = 2,
	},
	["profiles"] = {
		["Default"] = {
			["class_order"] = {
				"WARRIOR", -- [1]
				"DEATHKNIGHT", -- [2]
				"PALADIN", -- [3]
				"MONK", -- [4]
				"PRIEST", -- [5]
				"SHAMAN", -- [6]
				"DRUID", -- [7]
				"ROGUE", -- [8]
				"MAGE", -- [9]
				"WARLOCK", -- [10]
				"HUNTER", -- [11]
			},
			["layouts"] = {
				["Normal"] = {
					["indicator_size"] = 10,
					["bar_spacing"] = 1,
					["size_x"] = 240,
					["indicator_spacing"] = 5,
					["size_y"] = 65,
					["font"] = "Accidental Presidency",
					["exists"] = true,
					["bar_padding"] = 0,
				},
				["Tiny"] = {
					["indicator_size"] = 10,
					["bar_spacing"] = 1,
					["size_x"] = 160,
					["indicator_spacing"] = 5,
					["size_y"] = 32,
					["font"] = "Accidental Presidency",
					["exists"] = true,
					["bar_padding"] = 0,
				},
				["Box"] = {
					["indicator_size"] = 10,
					["bar_spacing"] = 1,
					["size_x"] = 115,
					["indicator_spacing"] = 5,
					["size_y"] = 32,
					["font"] = "Accidental Presidency",
					["exists"] = true,
					["bar_padding"] = 0,
				},
			},
			["made_groups"] = true,
			["units"] = {
				["targettargettarget"] = {
					["enabled"] = false,
					["position_x"] = -486.0000915527344,
					["position_y"] = -83.99981689453125,
				},
				["focustarget"] = {
					["position_x"] = 222.9999389648438,
					["layout"] = "Tiny",
					["position_y"] = -420.9994964599609,
					["horizontal_mirror"] = true,
				},
				["targettarget"] = {
					["position_x"] = 2.0010986328125,
					["layout"] = "Box",
					["position_y"] = -459.0002899169922,
					["horizontal_mirror"] = true,
				},
				["player"] = {
					["position_x"] = -180.0004272460938,
					["position_y"] = -476.0002975463867,
				},
				["focus"] = {
					["position_x"] = -219.0001831054688,
					["position_y"] = -423.0001220703125,
					["layout"] = "Tiny",
				},
				["target"] = {
					["position_x"] = 185.0022583007813,
					["position_y"] = -475.0000228881836,
					["horizontal_mirror"] = true,
				},
				["pettarget"] = {
					["enabled"] = false,
					["position_x"] = -516.9993286132813,
					["position_y"] = -156.9999389648438,
				},
				["focustargettarget"] = {
					["enabled"] = false,
					["position_x"] = -481.9992065429688,
					["position_y"] = 13.000244140625,
				},
				["pet"] = {
					["position_x"] = 2.99945068359375,
					["position_y"] = -492.0000381469727,
					["layout"] = "Box",
				},
			},
			["groups"] = {
				["Party pets"] = {
					["unit_group"] = "partypet",
					["exists"] = true,
				},
				["Party"] = {
					["exists"] = true,
				},
			},
			["lock_movement"] = true,
		},
		["Switch"] = {
			["groups"] = {
				["Party pets"] = {
					["exists"] = true,
					["unit_group"] = "partypet",
				},
				["Party"] = {
					["exists"] = true,
				},
			},
			["class_order"] = {
				"WARRIOR", -- [1]
				"DEATHKNIGHT", -- [2]
				"PALADIN", -- [3]
				"MONK", -- [4]
				"PRIEST", -- [5]
				"SHAMAN", -- [6]
				"DRUID", -- [7]
				"ROGUE", -- [8]
				"MAGE", -- [9]
				"WARLOCK", -- [10]
				"HUNTER", -- [11]
			},
			["layouts"] = {
				["Normal"] = {
					["size_x"] = 240,
					["font"] = "Accidental Presidency",
					["bar_padding"] = 0,
					["bar_spacing"] = 1,
					["indicator_spacing"] = 5,
					["size_y"] = 65,
					["exists"] = true,
					["indicator_size"] = 10,
				},
				["Tiny"] = {
					["size_x"] = 160,
					["font"] = "Accidental Presidency",
					["bar_padding"] = 0,
					["bar_spacing"] = 1,
					["indicator_spacing"] = 5,
					["size_y"] = 32,
					["exists"] = true,
					["indicator_size"] = 10,
				},
				["Box"] = {
					["size_x"] = 115,
					["font"] = "Accidental Presidency",
					["bar_padding"] = 0,
					["bar_spacing"] = 1,
					["indicator_spacing"] = 5,
					["size_y"] = 32,
					["exists"] = true,
					["indicator_size"] = 10,
				},
			},
			["made_groups"] = true,
			["lock_movement"] = true,
			["units"] = {
				["targettargettarget"] = {
					["enabled"] = false,
					["position_x"] = -486.0000915527344,
					["position_y"] = -83.99981689453125,
				},
				["focustarget"] = {
					["horizontal_mirror"] = true,
					["layout"] = "Tiny",
					["position_x"] = 222.9999389648438,
					["position_y"] = -420.9994964599609,
				},
				["targettarget"] = {
					["horizontal_mirror"] = true,
					["layout"] = "Box",
					["position_x"] = 2.0010986328125,
					["position_y"] = -459.0002899169922,
				},
				["player"] = {
					["position_x"] = -180.0004272460938,
					["position_y"] = -476.0002975463867,
				},
				["focus"] = {
					["layout"] = "Tiny",
					["position_x"] = -219.0001831054688,
					["position_y"] = -423.0001220703125,
				},
				["target"] = {
					["horizontal_mirror"] = true,
					["position_x"] = 185.0022583007813,
					["position_y"] = -475.0000228881836,
				},
				["pet"] = {
					["layout"] = "Box",
					["position_x"] = 2.99945068359375,
					["position_y"] = -492.0000381469727,
				},
				["focustargettarget"] = {
					["enabled"] = false,
					["position_x"] = -481.9992065429688,
					["position_y"] = 13.000244140625,
				},
				["pettarget"] = {
					["enabled"] = false,
					["position_x"] = -516.9993286132813,
					["position_y"] = -156.9999389648438,
				},
			},
		},
	},
}
