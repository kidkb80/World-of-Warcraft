--[[
Author: Starinnia
Pitbull4_BurningEmbersBar - Adds a simple bar display of Burning Embers to Pitbull4
$Date: 2013-03-23 21:32:18 +0000 (Sat, 23 Mar 2013) $
$Revision: 5 $
Project Version: 1.0.3
contact: codemaster2010 AT gmail DOT com

Copyright (c) 2010-2013 Michael J. Murray aka Lyte of Lothar(US)
All rights reserved unless otherwise explicitly stated.
]]

if select(6, GetAddOnInfo("PitBull4_" .. (debugstack():match("[o%.][d%.][u%.]les\\(.-)\\") or ""))) ~= "MISSING" then return end

local PitBull4 = _G.PitBull4
if not PitBull4 then
	error("PitBull4_BurningEmbersBar requires PitBull4")
end

if select(2, UnitClass("player")) ~= "WARLOCK" then
	return
end

local EXAMPLE_VALUE = 0.75

local unpack = _G.unpack
local floor = math.floor
local MAX_POWER_PER_EMBER = _G.MAX_POWER_PER_EMBER
local SPELL_POWER_BURNING_EMBERS = _G.SPELL_POWER_BURNING_EMBERS
local L = LibStub("AceLocale-3.0"):GetLocale("PitBull4_BurningEmbersBar")

local PitBull4_BurningEmbersBar = PitBull4:NewModule("BurningEmbersBar", "AceEvent-3.0")

PitBull4_BurningEmbersBar:SetModuleType("bar")
PitBull4_BurningEmbersBar:SetName(L["Burning Embers bar"])
PitBull4_BurningEmbersBar:SetDescription(L["Show a bar indicating the unit's Burning Embers count."])
PitBull4_BurningEmbersBar:SetDefaults({
	position = 3,
	show_ember_tenths = true,
	only_show_current = false,
})

function PitBull4_BurningEmbersBar:OnEnable()
	self:RegisterEvent("UNIT_POWER")
	self:RegisterEvent("UNIT_DISPLAYPOWER")
	self:RegisterEvent("PLAYER_ENTERING_WORLD")
end

local function update_player(self)
	for frame in PitBull4:IterateFramesForUnitID("player") do
		if frame.BurningEmbersBar then
			self:Update(frame)
		end
	end
end

function PitBull4_BurningEmbersBar:UNIT_POWER(event, unit, kind)
	if unit ~= "player" or kind ~= "BURNING_EMBERS" then
		return
	end
	
	update_player(self)
end

function PitBull4_BurningEmbersBar:UNIT_DISPLAYPOWER(event, unit)
	if unit ~= "player" then
		return
	end
	
	update_player(self)
end

function PitBull4_BurningEmbersBar:PLAYER_ENTERING_WORLD(event)
	update_player(self)
end

local moduleUpdateFrame = PitBull4_BurningEmbersBar.UpdateFrame
function PitBull4_BurningEmbersBar:UpdateFrame(frame)
	if frame.unit ~= "player" then
		return self:ClearFrame(frame)
	end
	
	return moduleUpdateFrame(self, frame)
end

function PitBull4_BurningEmbersBar:GetValue(frame)
	local db = self:GetLayoutDB(frame)
	local val
	
	if db.only_show_current then
		local power = UnitPower("player", SPELL_POWER_BURNING_EMBERS, true)
		local full = floor(power / MAX_POWER_PER_EMBER)
		power = power - (full * MAX_POWER_PER_EMBER)
		
		val = power / MAX_POWER_PER_EMBER
	else
		if db.show_ember_tenths then
			val = UnitPower("player", SPELL_POWER_BURNING_EMBERS, true) / UnitPowerMax("player", SPELL_POWER_BURNING_EMBERS, true)
		else
			val = UnitPower("player", SPELL_POWER_BURNING_EMBERS) / UnitPowerMax("player", SPELL_POWER_BURNING_EMBERS)
		end
	end
	
	return val
end

function PitBull4_BurningEmbersBar:GetExampleValue(frame)
	return EXAMPLE_VALUE
end

function PitBull4_BurningEmbersBar:GetColor(frame, value)
	return unpack(PitBull4.PowerColors.POWER_TYPE_HEAT)
end

function PitBull4_BurningEmbersBar:GetExampleColor(frame, value)
	return unpack(PitBull4.PowerColors.POWER_TYPE_HEAT)
end

PitBull4_BurningEmbersBar:SetLayoutOptionsFunction(function(self)
	return 'show_ember_tenths', {
		name = L['Show Ember Tenths'],
		desc = L['Update the Burning Embers bar in tenth of an Ember increments.'],
		type = 'toggle',
		get = function(info)
			return PitBull4.Options.GetLayoutDB(self).show_ember_tenths
		end,
		set = function(info,value)
			PitBull4.Options.GetLayoutDB(self).show_ember_tenths = value

			PitBull4.Options.UpdateFrames()
		end
	}, 'only_show_current', {
		name = L["Only Show Current Ember"],
		desc = L["Only show the currently building Ember. You must have 'Show Ember Tenths' checked."],
		type = 'toggle',
		get = function(info)
			return PitBull4.Options.GetLayoutDB(self).only_show_current
		end,
		set = function(info, value)
			PitBull4.Options.GetLayoutDB(self).only_show_current = value

			PitBull4.Options.UpdateFrames()
		end
	}
end)
