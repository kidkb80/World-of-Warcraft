
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
			},
		},
		["Border"] = {
			["profiles"] = {
				["Default"] = {
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
									["events"] = {
										["UNIT_MAXPOWER"] = true,
										["UNIT_POWER"] = true,
									},
									["exists"] = true,
									["code"] = "return math.abs(Power(unit,SPELL_POWER_ECLIPSE))\n",
									["location"] = "center",
									["attach_to"] = "Eclipse",
								},
								["Lua:Absolute Health"] = {
									["exists"] = true,
									["position"] = 1.00001,
									["location"] = "right",
									["code"] = "local s = Status(unit)\nif s then\n  return \" \"\nelseif HP(unit) == MaxHP(unit) then\n  return \"%s\", Short(MaxHP(unit), true)\nelse\n  return \"%s / %s\",Short(HP(unit),true),Short(MaxHP(unit),true)\nend",
									["attach_to"] = "PowerBar",
									["size"] = 0.85,
								},
								["Lua:Power"] = {
									["events"] = {
										["UNIT_MAXPOWER"] = true,
										["UNIT_POWER"] = true,
									},
									["exists"] = true,
									["code"] = "local max = MaxPower(unit)\nif max > 0 then\n  if Power(unit) == max then\n    return \"%s\", Short(Power(unit),true)\n  else\n    return \"%s / %s\",Short(Power(unit),true),Short(max,true)\n  end\nend",
									["location"] = "left",
									["position"] = 1.00001,
									["attach_to"] = "PowerBar",
									["size"] = 0.8,
								},
								["Lua:Reputation"] = {
									["enabled"] = false,
									["events"] = {
										["UNIT_FACTION"] = true,
										["UPDATE_FACTION"] = true,
									},
									["exists"] = true,
									["code"] = "local name, _, min , max, value, id = GetWatchedFactionInfo()\nif IsMouseOver() then\n  return name or ConfigMode() \nelse\n  local fs_id, fs_rep, _, _, _, _, _, fs_threshold, next_fs_threshold = GetFriendshipReputation(id)\n  if fs_id then\n    if next_fs_threshold then\n      min, max, value = fs_threshold, next_fs_threshold, fs_rep\n    else\n      min, max, value = 0, 1, 1\n    end\n  end\n  local bar_cur,bar_max = value-min,max-min\n  return \"%d/%d (%s%%)\",bar_cur,bar_max,Percent(bar_cur,bar_max)\nend",
									["location"] = "center",
									["attach_to"] = "ReputationBar",
								},
								["Lua:Name"] = {
									["events"] = {
										["PLAYER_FLAGS_CHANGED"] = true,
										["UNIT_NAME_UPDATE"] = true,
									},
									["exists"] = true,
									["code"] = "local abbr = Name(unit)\nif abbr:len() > 20 and abbr:find(\" \") then\n  abbr = abbr:gsub(\"([^ ]+) +\",\n    function(text)\n        return text:sub(1,1) .. \". \"\n    end)\nend\nreturn \"%s\", abbr;\n ",
									["location"] = "left",
									["attach_to"] = "HealthBar",
									["size"] = 1.15,
								},
								["Lua:Threat"] = {
									["enabled"] = false,
									["events"] = {
										["UNIT_THREAT_LIST_UPDATE"] = true,
										["UNIT_THREAT_SITUATION_UPDATE"] = true,
									},
									["exists"] = true,
									["code"] = "local unit_a,unit_b = ThreatPair(unit)\nif unit_a and unit_b then\n  local _,_,percent = UnitDetailedThreatSituation(unit_a, unit_b)\n  if percent and percent ~= 0 then\n    return \"%s%%\",Round(percent,1)\n  end\nend\nreturn ConfigMode()",
									["location"] = "center",
									["attach_to"] = "ThreatBar",
								},
								["Lua:Experience"] = {
									["enabled"] = false,
									["events"] = {
										["UNIT_PET_EXPERIENCE"] = true,
										["PLAYER_XP_UPDATE"] = true,
									},
									["exists"] = true,
									["code"] = "local cur, max, rest = XP(unit), MaxXP(unit), RestXP(unit)\nif rest then\n  return \"%s/%s (%s%%) R: %s%%\",cur,max,Percent(cur,max),Percent(rest,max)\nelse\n  return \"%s/%s (%s%%)\",cur,max,Percent(cur,max)\nend",
									["location"] = "center",
									["attach_to"] = "ExperienceBar",
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
									["exists"] = true,
									["code"] = "local cast_data = CastData(unit)\nif cast_data then\n  local spell,stop_message,target = cast_data.spell,cast_data.stop_message,cast_data.target\n  local stop_time,stop_duration = cast_data.stop_time\n  if stop_time then\n    stop_duration = GetTime() - stop_time\n  end\n  Alpha(-(stop_duration or 0) + 1)\n  if stop_message then\n    return stop_message\n  elseif target then\n    return \"%s (%s)\",spell,target\n  else\n    return spell \n  end\nend\nreturn ConfigMode()",
									["location"] = "left",
									["attach_to"] = "CastBar",
								},
								["Lua:Alternate power"] = {
									["enabled"] = false,
									["events"] = {
										["UNIT_MAXPOWER"] = true,
										["UNIT_POWER"] = true,
									},
									["exists"] = true,
									["code"] = "local max = MaxPower(unit,ALTERNATE_POWER_INDEX)\nif max > 0 then\n  return \"%s%%\",Percent(Power(unit,ALTERNATE_POWER_INDEX),max)\nend\nreturn ConfigMode()",
									["location"] = "right",
									["attach_to"] = "AltPowerBar",
								},
								["Lua:Cast time"] = {
									["enabled"] = false,
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
									["exists"] = true,
									["code"] = "local cast_data = CastData(unit)\nif cast_data then\n  if not cast_data.stop_time then\n    local delay,end_time = cast_data.delay, cast_data.end_time\n    local duration\n    if end_time then\n      duration = end_time - GetTime()\n    end\n    if delay and delay ~= 0 then\n      local delay_sign = '+'\n      if delay < 0 then\n        delay_sign = ''\n      end\n      if duration and duration >= 0 then\n        return \"|cffff0000%s%s|r %.1f\",delay_sign,Round(delay,1),duration\n      else\n        return \"|cffff0000%s%s|r\",delay_sign,Round(delay,1)\n      end\n    elseif duration and duration >= 0 then\n      return \"%.1f\",duration\n    end\n  end\nend\nreturn ConfigMode()",
									["location"] = "right",
									["attach_to"] = "CastBar",
								},
								["Lua:Health"] = {
									["events"] = {
										["UNIT_HEALTH"] = true,
										["UNIT_AURA"] = true,
										["UNIT_MAXHEALTH"] = true,
									},
									["exists"] = true,
									["code"] = "local s = Status(unit)\nif s then\n  return s\nelseif HP(unit) == MaxHP(unit) then\n  return \" \"\nelse\n  return \"%s%%\",Percent(HP(unit),MaxHP(unit))\nend",
									["location"] = "right",
									["position"] = 1.00001,
									["attach_to"] = "HealthBar",
									["size"] = 1.15,
								},
								["Lua:PVPTimer"] = {
									["enabled"] = false,
									["events"] = {
										["PLAYER_FLAGS_CHANGED"] = true,
									},
									["exists"] = true,
									["code"] = "if unit == \"player\" then\n  local pvp = PVPDuration()\n  if pvp then\n    return \"|cffff0000%s|r\",FormatDuration(pvp)\n  end\nend",
									["location"] = "out_right_top",
								},
								["Lua:Class"] = {
									["enabled"] = false,
									["events"] = {
										["UNIT_LEVEL"] = true,
										["UNIT_CLASSIFICATION_CHANGED"] = true,
										["UNIT_AURA"] = true,
									},
									["exists"] = true,
									["code"] = "local dr,dg,db = DifficultyColor(unit)\nlocal form = DruidForm(unit)\nlocal classification = Classification(unit)\nif UnitIsPlayer(unit) or (not UnitIsFriend(unit,\"player\") and not IsPet(unit)) then\n  local cr,cg,cb = ClassColor(unit)\n  if form then\n    return \"%s%s|cff%02x%02x%02x%s|r |cff%02x%02x%02x%s|r (%s) %s\",classification or '',classification and ' ' or '',dr,dg,db,Level(unit),cr,cg,cb,Class(unit),form,SmartRace(unit) or ''\n  else\n    return \"%s%s|cff%02x%02x%02x%s|r |cff%02x%02x%02x%s|r %s\",classification or '',classification and ' ' or '',dr,dg,db,Level(unit),cr,cg,cb,Class(unit),SmartRace(unit) or ''\n  end\nelse\n  if form then\n    return \"%s%s|cff%02x%02x%02x%s|r (%s) %s\",classification or '',classification and ' ' or '',dr,dg,db,Level(unit),form,SmartRace(unit) or ''\n  else\n    return \"%s%s|cff%02x%02x%02x%s|r %s\",classification or '',classification and ' ' or '',dr,dg,db,Level(unit),SmartRace(unit) or ''\n  end\nend",
									["location"] = "left",
									["position"] = 1.00002,
									["attach_to"] = "PowerBar",
								},
								["Lua:Druid mana"] = {
									["enabled"] = false,
									["events"] = {
										["UNIT_MAXPOWER"] = true,
										["UNIT_POWER"] = true,
									},
									["exists"] = true,
									["code"] = "if UnitPowerType(unit) ~= 0 then\n  return \"%s/%s\",Power(unit,0),MaxPower(unit,0)\nend",
									["location"] = "center",
									["attach_to"] = "DruidManaBar",
								},
								["Lua:Demonic fury"] = {
									["enabled"] = false,
									["events"] = {
										["UNIT_MAXPOWER"] = true,
										["UNIT_POWER_FREQUENT"] = true,
									},
									["exists"] = true,
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
									["events"] = {
										["UNIT_MAXPOWER"] = true,
										["UNIT_POWER"] = true,
									},
									["exists"] = true,
									["code"] = "return math.abs(Power(unit,SPELL_POWER_ECLIPSE))\n",
									["location"] = "center",
									["position"] = 5,
									["attach_to"] = "Eclipse",
								},
								["Lua:Druid mana"] = {
									["enabled"] = false,
									["events"] = {
										["UNIT_MAXPOWER"] = true,
										["UNIT_POWER"] = true,
									},
									["exists"] = true,
									["code"] = "if UnitPowerType(unit) ~= 0 then\n  return \"%s/%s\",Power(unit,0),MaxPower(unit,0)\nend",
									["location"] = "center",
									["position"] = 4,
									["attach_to"] = "DruidManaBar",
								},
								["Lua:Experience"] = {
									["enabled"] = false,
									["events"] = {
										["UNIT_PET_EXPERIENCE"] = true,
										["PLAYER_XP_UPDATE"] = true,
									},
									["exists"] = true,
									["code"] = "local cur, max, rest = XP(unit), MaxXP(unit), RestXP(unit)\nif rest then\n  return \"%s/%s (%s%%) R: %s%%\",cur,max,Percent(cur,max),Percent(rest,max)\nelse\n  return \"%s/%s (%s%%)\",cur,max,Percent(cur,max)\nend",
									["location"] = "center",
									["position"] = 2,
									["attach_to"] = "ExperienceBar",
								},
								["Lua:Reputation"] = {
									["enabled"] = false,
									["events"] = {
										["UNIT_FACTION"] = true,
										["UPDATE_FACTION"] = true,
									},
									["exists"] = true,
									["code"] = "local name, _, min , max, value, id = GetWatchedFactionInfo()\nif IsMouseOver() then\n  return name or ConfigMode() \nelse\n  local fs_id, fs_rep, _, _, _, _, _, fs_threshold, next_fs_threshold = GetFriendshipReputation(id)\n  if fs_id then\n    if next_fs_threshold then\n      min, max, value = fs_threshold, next_fs_threshold, fs_rep\n    else\n      min, max, value = 0, 1, 1\n    end\n  end\n  local bar_cur,bar_max = value-min,max-min\n  return \"%d/%d (%s%%)\",bar_cur,bar_max,Percent(bar_cur,bar_max)\nend",
									["location"] = "center",
									["position"] = 3,
									["attach_to"] = "ReputationBar",
								},
								["Lua:Name"] = {
									["events"] = {
										["PLAYER_FLAGS_CHANGED"] = true,
										["UNIT_NAME_UPDATE"] = true,
									},
									["exists"] = true,
									["code"] = "local abbr = Name(unit)\nif abbr:len() > 20 and abbr:find(\" \") then\n  abbr = abbr:gsub(\"([^ ]+) +\",\n    function(text)\n        return text:sub(1,1) .. \". \"\n    end)\nend\nreturn \"%s\", abbr;\n ",
									["location"] = "left",
									["position"] = 24,
									["attach_to"] = "HealthBar",
									["size"] = 0.95,
								},
								["Lua:Threat"] = {
									["enabled"] = false,
									["events"] = {
										["UNIT_THREAT_LIST_UPDATE"] = true,
										["UNIT_THREAT_SITUATION_UPDATE"] = true,
									},
									["exists"] = true,
									["code"] = "local unit_a,unit_b = ThreatPair(unit)\nif unit_a and unit_b then\n  local _,_,percent = UnitDetailedThreatSituation(unit_a, unit_b)\n  if percent and percent ~= 0 then\n    return \"%s%%\",Round(percent,1)\n  end\nend\nreturn ConfigMode()",
									["location"] = "center",
									["position"] = 7,
									["attach_to"] = "ThreatBar",
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
									["exists"] = true,
									["code"] = "local max = MaxPower(unit,ALTERNATE_POWER_INDEX)\nif max > 0 then\n  return \"%s%%\",Percent(Power(unit,ALTERNATE_POWER_INDEX),max)\nend\nreturn ConfigMode()",
									["location"] = "right",
									["position"] = 9,
									["attach_to"] = "AltPowerBar",
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
									["exists"] = true,
									["code"] = "local cast_data = CastData(unit)\nif cast_data then\n  local spell,stop_message,target = cast_data.spell,cast_data.stop_message,cast_data.target\n  local stop_time,stop_duration = cast_data.stop_time\n  if stop_time then\n    stop_duration = GetTime() - stop_time\n  end\n  Alpha(-(stop_duration or 0) + 1)\n  if stop_message then\n    return stop_message\n  elseif target then\n    return \"%s (%s)\",spell,target\n  else\n    return spell \n  end\nend\nreturn ConfigMode()",
									["location"] = "left",
									["position"] = 8,
									["attach_to"] = "CastBar",
								},
								["Lua:Cast time"] = {
									["enabled"] = false,
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
									["exists"] = true,
									["code"] = "local cast_data = CastData(unit)\nif cast_data then\n  if not cast_data.stop_time then\n    local delay,end_time = cast_data.delay, cast_data.end_time\n    local duration\n    if end_time then\n      duration = end_time - GetTime()\n    end\n    if delay and delay ~= 0 then\n      local delay_sign = '+'\n      if delay < 0 then\n        delay_sign = ''\n      end\n      if duration and duration >= 0 then\n        return \"|cffff0000%s%s|r %.1f\",delay_sign,Round(delay,1),duration\n      else\n        return \"|cffff0000%s%s|r\",delay_sign,Round(delay,1)\n      end\n    elseif duration and duration >= 0 then\n      return \"%.1f\",duration\n    end\n  end\nend\nreturn ConfigMode()",
									["location"] = "right",
									["position"] = 11,
									["attach_to"] = "CastBar",
								},
								["Lua:Health"] = {
									["events"] = {
										["UNIT_HEALTH"] = true,
										["UNIT_AURA"] = true,
										["UNIT_MAXHEALTH"] = true,
									},
									["exists"] = true,
									["code"] = "local s = Status(unit)\nif s then\n  return s\nelseif HP(unit) == MaxHP(unit) then\n  return \" \"\nelse\n  return \"%s%%\",Percent(HP(unit),MaxHP(unit))\nend",
									["location"] = "right",
									["position"] = 26,
									["attach_to"] = "HealthBar",
									["size"] = 0.95,
								},
								["Lua:PVPTimer"] = {
									["enabled"] = false,
									["events"] = {
										["PLAYER_FLAGS_CHANGED"] = true,
									},
									["exists"] = true,
									["code"] = "if unit == \"player\" then\n  local pvp = PVPDuration()\n  if pvp then\n    return \"|cffff0000%s|r\",FormatDuration(pvp)\n  end\nend",
									["location"] = "out_right_top",
									["position"] = 10,
								},
								["Lua:Class"] = {
									["enabled"] = false,
									["events"] = {
										["UNIT_LEVEL"] = true,
										["UNIT_CLASSIFICATION_CHANGED"] = true,
										["UNIT_AURA"] = true,
									},
									["exists"] = true,
									["code"] = "local dr,dg,db = DifficultyColor(unit)\nlocal form = DruidForm(unit)\nlocal classification = Classification(unit)\nif UnitIsPlayer(unit) or (not UnitIsFriend(unit,\"player\") and not IsPet(unit)) then\n  local cr,cg,cb = ClassColor(unit)\n  if form then\n    return \"%s%s|cff%02x%02x%02x%s|r |cff%02x%02x%02x%s|r (%s) %s\",classification or '',classification and ' ' or '',dr,dg,db,Level(unit),cr,cg,cb,Class(unit),form,SmartRace(unit) or ''\n  else\n    return \"%s%s|cff%02x%02x%02x%s|r |cff%02x%02x%02x%s|r %s\",classification or '',classification and ' ' or '',dr,dg,db,Level(unit),cr,cg,cb,Class(unit),SmartRace(unit) or ''\n  end\nelse\n  if form then\n    return \"%s%s|cff%02x%02x%02x%s|r (%s) %s\",classification or '',classification and ' ' or '',dr,dg,db,Level(unit),form,SmartRace(unit) or ''\n  else\n    return \"%s%s|cff%02x%02x%02x%s|r %s\",classification or '',classification and ' ' or '',dr,dg,db,Level(unit),SmartRace(unit) or ''\n  end\nend",
									["location"] = "left",
									["position"] = 28,
									["attach_to"] = "PowerBar",
								},
								["Lua:Power"] = {
									["enabled"] = false,
									["events"] = {
										["UNIT_MAXPOWER"] = true,
										["UNIT_POWER"] = true,
									},
									["exists"] = true,
									["code"] = "local max = MaxPower(unit)\nif max > 0 then\n  if Power(unit) == max then\n    return \"%s\", Short(Power(unit),true)\n  else\n    return \"%s / %s\",Short(Power(unit),true),Short(max,true)\n  end\nend",
									["location"] = "left",
									["position"] = 29,
									["attach_to"] = "PowerBar",
									["size"] = 0.8,
								},
								["Lua:Demonic fury"] = {
									["enabled"] = false,
									["events"] = {
										["UNIT_MAXPOWER"] = true,
										["UNIT_POWER_FREQUENT"] = true,
									},
									["exists"] = true,
									["code"] = "return \"%s/%s\",Power(unit,SPELL_POWER_DEMONIC_FURY),MaxPower(unit,SPELL_POWER_DEMONIC_FURY)\n",
									["location"] = "center",
									["position"] = 20,
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
										["UNIT_POWER"] = true,
										["UNIT_MAXPOWER"] = true,
									},
									["code"] = "return math.abs(Power(unit,SPELL_POWER_ECLIPSE))\n",
									["location"] = "center",
									["attach_to"] = "Eclipse",
								},
								["Lua:Name"] = {
									["exists"] = true,
									["events"] = {
										["PLAYER_FLAGS_CHANGED"] = true,
										["UNIT_NAME_UPDATE"] = true,
									},
									["code"] = "local abbr = Name(unit)\nif abbr:len() > 20 and abbr:find(\" \") then\n  abbr = abbr:gsub(\"([^ ]+) +\",\n    function(text)\n        return text:sub(1,1) .. \". \"\n    end)\nend\nreturn \"%s\", abbr;\n ",
									["location"] = "center",
									["attach_to"] = "PowerBar",
									["size"] = 0.75,
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
										["UNIT_POWER"] = true,
										["UNIT_MAXPOWER"] = true,
									},
									["code"] = "local max = MaxPower(unit)\nif max > 0 then\n  if Power(unit) == max then\n    return \"%s\", Short(Power(unit),true)\n  else\n    return \"%s / %s\",Short(Power(unit),true),Short(max,true)\n  end\nend",
									["location"] = "left",
									["position"] = 1.00001,
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
								["Lua:Class"] = {
									["enabled"] = false,
									["exists"] = true,
									["events"] = {
										["UNIT_LEVEL"] = true,
										["UNIT_CLASSIFICATION_CHANGED"] = true,
										["UNIT_AURA"] = true,
									},
									["code"] = "local dr,dg,db = DifficultyColor(unit)\nlocal form = DruidForm(unit)\nlocal classification = Classification(unit)\nif UnitIsPlayer(unit) or (not UnitIsFriend(unit,\"player\") and not IsPet(unit)) then\n  local cr,cg,cb = ClassColor(unit)\n  if form then\n    return \"%s%s|cff%02x%02x%02x%s|r |cff%02x%02x%02x%s|r (%s) %s\",classification or '',classification and ' ' or '',dr,dg,db,Level(unit),cr,cg,cb,Class(unit),form,SmartRace(unit) or ''\n  else\n    return \"%s%s|cff%02x%02x%02x%s|r |cff%02x%02x%02x%s|r %s\",classification or '',classification and ' ' or '',dr,dg,db,Level(unit),cr,cg,cb,Class(unit),SmartRace(unit) or ''\n  end\nelse\n  if form then\n    return \"%s%s|cff%02x%02x%02x%s|r (%s) %s\",classification or '',classification and ' ' or '',dr,dg,db,Level(unit),form,SmartRace(unit) or ''\n  else\n    return \"%s%s|cff%02x%02x%02x%s|r %s\",classification or '',classification and ' ' or '',dr,dg,db,Level(unit),SmartRace(unit) or ''\n  end\nend",
									["location"] = "left",
									["position"] = 1.00002,
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
									["code"] = "local s = Status(unit)\nif s then\n  return s\nelseif HP(unit) == MaxHP(unit) then\n  return \" \"\nelse\n  return \"%s%%\",Percent(HP(unit),MaxHP(unit))\nend",
									["location"] = "center",
									["position"] = 1.00001,
									["attach_to"] = "HealthBar",
									["size"] = 0.75,
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
									["enabled"] = false,
									["exists"] = true,
									["position"] = 1.00001,
									["location"] = "right",
									["code"] = "local s = Status(unit)\nif s then\n  return \" \"\nelseif HP(unit) == MaxHP(unit) then\n  return \"%s\", Short(MaxHP(unit), true)\nelse\n  return \"%s / %s\",Short(HP(unit),true),Short(MaxHP(unit),true)\nend",
									["attach_to"] = "PowerBar",
									["size"] = 0.85,
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
					},
				},
			},
		},
		["HostilityFader"] = {
			["profiles"] = {
				["Default"] = {
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
							["location"] = "left",
							["position"] = 30,
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
							["location"] = "right",
							["position"] = 19,
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
			},
		},
		["ExperienceBar"] = {
			["profiles"] = {
				["Default"] = {
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
		["CastBar"] = {
			["profiles"] = {
				["Default"] = {
					["global"] = {
						["enabled"] = false,
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
			},
		},
		["Aggro"] = {
			["profiles"] = {
				["Default"] = {
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
							["custom_color"] = {
								0.007843137254901961, -- [1]
								0.007843137254901961, -- [2]
								0.007843137254901961, -- [3]
								1, -- [4]
							},
							["deficit"] = true,
							["reverse"] = true,
						},
						["Tiny"] = {
							["custom_color"] = {
								0.007843137254901961, -- [1]
								0.007843137254901961, -- [2]
								0.007843137254901961, -- [3]
								1, -- [4]
							},
							["custom_background"] = {
								0.007843137254901961, -- [1]
								0.007843137254901961, -- [2]
								0.007843137254901961, -- [3]
								1, -- [4]
							},
							["background_alpha"] = 0.3,
							["deficit"] = true,
							["reverse"] = true,
						},
						["Box"] = {
							["custom_color"] = {
								0.007843137254901961, -- [1]
								0.007843137254901961, -- [2]
								0.007843137254901961, -- [3]
								1, -- [4]
							},
							["custom_background"] = {
								0.007843137254901961, -- [1]
								0.007843137254901961, -- [2]
								0.007843137254901961, -- [3]
								1, -- [4]
							},
							["reverse"] = true,
							["deficit"] = true,
							["background_alpha"] = 0.3,
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
							["custom_color"] = {
								0.01568627450980392, -- [1]
								0.01568627450980392, -- [2]
								0.01568627450980392, -- [3]
								1, -- [4]
							},
							["deficit"] = true,
							["hostility_color_npcs"] = false,
							["hostility_color"] = false,
							["reverse"] = true,
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
							["custom_color"] = {
								0.01568627450980392, -- [1]
								0.01568627450980392, -- [2]
								0.01568627450980392, -- [3]
								1, -- [4]
							},
							["hostility_color_npcs"] = false,
							["deficit"] = true,
							["reverse"] = true,
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
							["reverse"] = true,
							["hostility_color_npcs"] = false,
							["deficit"] = true,
							["hostility_color"] = false,
							["custom_color"] = {
								0.01568627450980392, -- [1]
								0.01568627450980392, -- [2]
								0.01568627450980392, -- [3]
								1, -- [4]
							},
						},
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
			},
		},
		["VisualHeal"] = {
			["profiles"] = {
				["Default"] = {
					["global"] = {
						["enabled"] = false,
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
			},
		},
		["CombatFader"] = {
			["profiles"] = {
				["Default"] = {
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
			},
		},
		["AltPowerBar"] = {
			["profiles"] = {
				["Default"] = {
					["layouts"] = {
						["Normal"] = {
							["background_alpha"] = 0.3,
							["custom_background"] = {
								0.0392156862745098, -- [1]
								0.0392156862745098, -- [2]
								0.0392156862745098, -- [3]
								1, -- [4]
							},
							["custom_color"] = {
								0.03137254901960784, -- [1]
								0.03137254901960784, -- [2]
								0.03137254901960784, -- [3]
								1, -- [4]
							},
							["deficit"] = true,
						},
						["Tiny"] = {
							["background_alpha"] = 0.3,
							["custom_background"] = {
								0.0392156862745098, -- [1]
								0.0392156862745098, -- [2]
								0.0392156862745098, -- [3]
								1, -- [4]
							},
							["custom_color"] = {
								0.03137254901960784, -- [1]
								0.03137254901960784, -- [2]
								0.03137254901960784, -- [3]
								1, -- [4]
							},
							["deficit"] = true,
						},
						["Box"] = {
							["background_alpha"] = 0.3,
							["custom_background"] = {
								0.0392156862745098, -- [1]
								0.0392156862745098, -- [2]
								0.0392156862745098, -- [3]
								1, -- [4]
							},
							["deficit"] = true,
							["custom_color"] = {
								0.03137254901960784, -- [1]
								0.03137254901960784, -- [2]
								0.03137254901960784, -- [3]
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
							["first"] = false,
							["elements"] = {
								["Default"] = {
									["exists"] = true,
								},
							},
						},
						["Tiny"] = {
							["first"] = false,
							["elements"] = {
								["Default"] = {
									["exists"] = true,
								},
							},
						},
						["Box"] = {
							["first"] = false,
							["elements"] = {
								["Default"] = {
									["exists"] = true,
								},
							},
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
			},
		},
		["Sounds"] = {
			["profiles"] = {
				["Default"] = {
					["global"] = {
						["enabled"] = false,
					},
				},
			},
		},
		["Highlight"] = {
			["profiles"] = {
				["Default"] = {
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
			},
		},
	},
	["global"] = {
		["config_version"] = 2,
	},
	["profileKeys"] = {
		["Feronaz - Area 52"] = "Default",
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
					["bar_padding"] = 0,
					["exists"] = true,
					["size_y"] = 65,
				},
				["Tiny"] = {
					["indicator_size"] = 10,
					["bar_spacing"] = 1,
					["size_x"] = 160,
					["indicator_spacing"] = 5,
					["size_y"] = 32,
					["bar_padding"] = 0,
					["exists"] = true,
				},
				["Box"] = {
					["indicator_size"] = 10,
					["bar_spacing"] = 1,
					["size_x"] = 115,
					["indicator_spacing"] = 5,
					["size_y"] = 32,
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
					["position_x"] = 237.9998168945313,
					["layout"] = "Tiny",
					["position_y"] = -299.9993591308594,
					["horizontal_mirror"] = true,
				},
				["pet"] = {
					["position_x"] = 15.99945068359375,
					["layout"] = "Box",
					["position_y"] = -373.0000610351563,
				},
				["player"] = {
					["position_x"] = -168.000244140625,
					["position_y"] = -352.0000915527344,
				},
				["focus"] = {
					["position_x"] = -206.0001831054688,
					["layout"] = "Tiny",
					["position_y"] = -299.9999694824219,
				},
				["target"] = {
					["position_x"] = 343.0016479492188,
					["position_y"] = -357.9998626708984,
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
				["targettarget"] = {
					["position_x"] = 16.00128173828125,
					["layout"] = "Box",
					["position_y"] = -336.0000610351563,
					["horizontal_mirror"] = true,
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
			["minimap_icon"] = {
				["hide"] = true,
			},
			["frame_snap"] = false,
		},
	},
}
