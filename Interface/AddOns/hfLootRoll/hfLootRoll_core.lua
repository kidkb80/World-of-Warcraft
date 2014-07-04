--[[

	hfLootRoll - World of Warcraft addon that provides improved loot roll frames

	Copyright (C) 2010 Ruslan Burykin <Heckffy@gmail.com>

	This program is free software; you can redistribute it and/or
	modify it under the terms of the GNU General Public License
	as published by the Free Software Foundation; either version 2
	of the License, or (at your option) any later version.

	This program is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	GNU General Public License for more details.

	You should have received a copy of the GNU General Public License
	along with this program; if not, write to the Free Software
	Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

]]

local ADDON_NAME, addon = ...;
hfLootRoll = addon;

local L = addon.L;

local Deformat = LibStub("LibDeformat-3.0");

local const = addon.const;

addon.core = {};
local core = addon.core;

addon.rolls = {}
local rolls = addon.rolls;

addon.modules = {};

function rolls:RemoveRollByID(rollID)
	if ( self["id" .. rollID] ) then
		wipe(self["id" .. rollID]);
		self["id" .. rollID] = nil;
	end
end

function rolls:AddRoll(rollID, rollTime)
	self["id" .. rollID] = {
		["time"]     = rollTime,
		["needers"]  = {},
		["greeders"] = {},
		["disers"]   = {},
		["passers"]  = {},
		["winner"]   = nil,
	};
end

function rolls:GetByID(rollID)
	return self["id" .. rollID];
end

core.rollMap = {};

core.processorMap = {
	{ LOOT_ROLL_GREED_SELF,			"greedProcessor" },
	{ LOOT_ROLL_GREED, 				"greedProcessor" },
	{ LOOT_ROLL_NEED_SELF, 			"needProcessor" },
	{ LOOT_ROLL_NEED, 				"needProcessor" },
	{ LOOT_ROLL_PASSED_SELF, 		"passProcessor" },
	{ LOOT_ROLL_PASSED_SELF_AUTO, 	"passProcessor" },
	{ LOOT_ROLL_PASSED, 			"passProcessor" },
	{ LOOT_ROLL_PASSED_AUTO, 		"passProcessor" },
	{ LOOT_ROLL_PASSED_AUTO_FEMALE, "passProcessor" },
	{ LOOT_ROLL_DISENCHANT_SELF, 	"disenchantProcessor" },
	{ LOOT_ROLL_DISENCHANT, 		"disenchantProcessor" },
	{ LOOT_ROLL_ALL_PASSED, 		"allpassedProcessor" },
	{ LOOT_ROLL_YOU_WON, 			"winProcessor" },
	{ LOOT_ROLL_WON, 				"winProcessor" },
}

function core.openRoll(rollID)
	local rollTime = GetLootRollTimeLeft(rollID) / 1000;
	local _, name  = GetLootRollItemInfo(rollID);
	core.rollMap[name] = rollID;
	rolls:AddRoll(rollID, rollTime);
	addon:FireEvent("NEW_ROLL", rollID, rollTime);
end

function core.processRoll(action, arg1, arg2)
	local itemLink;
	local name;
	if ( arg2 ) then
		name     = arg1;
		itemLink = arg2;
	else
		name	 = const.PLAYER_NAME;
		itemLink = arg1;
	end
	
	local itemName = itemLink:match("|h%[?(.-)%]?|h");
	local rollID   = core.rollMap[itemName];
	if ( rollID and rolls:GetByID(rollID) ) then
		tinsert(rolls:GetByID(rollID)[action], name);
		addon:FireEvent("UPDATE_ROLL", rollID);
	end
end

function core.closeRoll(itemName)
	local rollID = core.rollMap[itemName];
	if ( rollID ~= nil ) then
		rolls:RemoveRollByID(rollID)
	end
end

--[[
	usages: 
		processor(itemLink) 
		processor(name, itemLink)
]]
function core.greedProcessor(arg1, arg2)
	core.processRoll("greeders", arg1, arg2);
end

function core.needProcessor(arg1, arg2)
	core.processRoll("needers", arg1, arg2);
end

function core.disenchantProcessor(arg1, arg2)
	core.processRoll("disers", arg1, arg2);
end

function core.passProcessor(arg1, arg2)
	core.processRoll("passers", arg1, arg2);
end

function core.allpassedProcessor(itemLink)
	local itemName = itemLink:match("|h%[?(.-)%]?|h");
	local rollID   = core.rollMap[itemName];
	if ( rollID ) then
		addon:FireEvent("WIN_ROLL", rollID, L"ALL_PASSED");
		core.closeRoll(itemName);
	end
end

function core.winProcessor(arg1, arg2)
	local itemLink, name;
	itemLink = arg2 or arg1;
	name = arg2 and arg1 or const.PLAYER_NAME;
	
	local itemName = itemLink:match("|h%[?(.-)%]?|h");
	local rollID   = core.rollMap[itemName];
	if ( rollID ) then
		addon:FireEvent("WIN_ROLL", rollID, name);
		core.closeRoll(itemName);
	end
end

function addon.load()
	if ( not hfLootRollOptions ) then 
		hfLootRollOptions = {};
		hfLootRollOptions.modules = {};
	end
	if ( not hfLootRollGlobalOptions ) then 
		hfLootRollGlobalOptions = {};
		hfLootRollGlobalOptions.modules = {};
	end
	
	for moduleName, module in pairs(addon.modules) do
		if ( not hfLootRollOptions.modules[moduleName] ) then
			hfLootRollOptions.modules[moduleName] = {};
		end
		if ( not hfLootRollGlobalOptions.modules[moduleName] ) then
			hfLootRollGlobalOptions.modules[moduleName] = {};
		end
		module.options = hfLootRollOptions.modules[moduleName];
		module.globalOptions = hfLootRollGlobalOptions.modules[moduleName];
	end
end

-- modules stuff

function addon:AddModule(name, module)
	assert( type(name) == "string"
		, "hfLootRoll_core:AddModule() bad argument #1 (string expected, got " .. type(name) .. ")");
	assert( type(module) == "table"
		, "hfLootRoll_core:AddModule() bad argument #2 (table expected, got " .. type(module) .. ")");
	
	self.modules[name] = module;
	if ( hfLootRollOptions ) then
		if ( not hfLootRollOptions.modules[name] ) then
			hfLootRollOptions.modules[name] = {};
		end
		module.options = hfLootRollOptions.modules[name];
	end
	if ( hfLootRollGlobalOptions ) then
		if ( not hfLootRollGlobalOptions.modules[name] ) then
			hfLootRollGlobalOptions.modules[name] = {};
		end
		module.globalOptions = hfLootRollGlobalOptions.modules[name];
	end
	
	if ( module.onLoad ) then
		addon:RegisterOnLoad(module.onLoad);
	end
	if ( module.onEvent ) then
		addon:RegisterCallbackMap(module.onEvent);
	end
end

function addon:ModuleExists(name)
	return (self.modules[name] and true) or false;
end

function addon:RemoveModule(name)
	assert( type(name) == "string"
		, "hfLootRoll_core: bad argument #1 (string expected, got " .. tostring(module) .. ")");
	assert( self.modules[name]
		, "hfLootRoll_core: attempt to remove module that doesn't exist: " .. name);
	
	self.modules[name] = nil;
end

function addon:GetModule(name)
	assert( type(name) == "string"
		, "hfLootRoll_core: bad argument #1 (string expected, got " .. tostring(module) .. ")");
	assert( self.modules[name]
		, "hfLootRoll_core: attempt to get module that doesn't exist: " .. name);
	
	return self.modules[name];
end

local eventListener = CreateFrame("Frame");

function eventListener.onEvent(self, event, ...)
	if ( event == "START_LOOT_ROLL" ) then	
		local rollID = ...;
		core.openRoll(rollID);
	elseif ( event == "CANCEL_LOOT_ROLL" ) then	
		local rollID = ...;
		addon:FireEvent("CANCEL_ROLL", rollID);
	elseif ( event == "CHAT_MSG_LOOT" ) then
		local text = ...;
		for _, processor in ipairs(core.processorMap) do 
			local match1, match2, match3 = Deformat(text, processor[1]);
			if ( match1 ) then
				core[processor[2]](match1, match2, match3);
				return;
			end
		end	
	end
end

eventListener:SetScript("OnEvent", eventListener.onEvent);
eventListener:RegisterEvent("START_LOOT_ROLL");
eventListener:RegisterEvent("CANCEL_LOOT_ROLL");
eventListener:RegisterEvent("CHAT_MSG_LOOT");

addon:RegisterOnLoad(addon.load);