--[[

	hfLootLog - plug-in for hfLootRoll that adds loot logging

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

if ( not hfLootRoll ) then
	return;
end

local ADDON_NAME, addon = ...;

local DATABASE_VERSION = 2;

local const = hfLootRoll.const;

local module = {};
module.options = {}

module.logListener = CreateFrame("Frame");
module.logCleaner  = CreateFrame("Frame");
module.logCleaner.threshold = 15;
module.logCleaner.active = true;

module.DB = {};
	
module.idIter = 1;

module.rollEvents = {
	{ LOOT_ROLL_ROLLED_DE, 				"rollAsDisenchant" },
	{ LOOT_ROLL_ROLLED_GREED, 			"rollAsGreed" },
	{ LOOT_ROLL_ROLLED_NEED, 			"rollAsNeed" },
 	{ LOOT_ROLL_YOU_WON, 				"rollWon" },
 	{ LOOT_ROLL_YOU_WON_NO_SPAM_DE, 	"rollWonDisenchant" },
 	{ LOOT_ROLL_YOU_WON_NO_SPAM_GREED, 	"rollWonGreed" },
	{ LOOT_ROLL_YOU_WON_NO_SPAM_NEED, 	"rollWonNeed" },
	{ LOOT_ROLL_WON, 					"rollWon" },
	{ LOOT_ROLL_WON_NO_SPAM_DE, 		"rollWonDisenchant" },
 	{ LOOT_ROLL_WON_NO_SPAM_GREED, 		"rollWonGreed" },
 	{ LOOT_ROLL_WON_NO_SPAM_NEED, 		"rollWonNeed" },
};

module.lootEvents = {
	LOOT_ITEM_MULTIPLE,
	LOOT_ITEM,
	LOOT_ITEM_PUSHED_SELF_MULTIPLE,
	LOOT_ITEM_PUSHED_SELF,
	LOOT_ITEM_SELF_MULTIPLE,
	LOOT_ITEM_SELF, 
};

module.loggingThresholds = {
	quality = 3,
	notLogged = {},
	logInInstances = {
		["none"]  = false,
		["party"] = true,
		["raid"]  = true,
	},
	logMoney = false,
	logOnlyMine = false,
};

module.active = true;

local Deformat = LibStub("LibDeformat-3.0");

local function cloneTable(t, recursive, moveTo)
	local clone = moveTo or {};
	for k, v in pairs(t) do
		if ( type(v) == "table" and recursive ) then
			clone[k] = cloneTable(v, true);
		else
			clone[k] = v;
		end
	end
	return clone;
end

addon.loaded = false;
addon.loader = CreateFrame("Frame");
addon.loader:RegisterEvent("ADDON_LOADED");
addon.loader:SetScript("OnEvent", function(self, event, loadedAddon)
	if ( ADDON_NAME == loadedAddon ) then	
		if ( not hfLootLogDB ) then
			hfLootLogDB = {};
			hfLootLogDB.version = DATABASE_VERSION;
		end	
		
		if ( module.loaded ) then
			module:init();
		end
		
		addon.loaded = true;
	end
end);

function module:updateDBv1tov2()
	for i = 1, #hfLootLogDB do
		local oldEntry = hfLootLogDB[i];
		
		if ( type(oldEntry) == "table"
			 and type(oldEntry[1]) == "number"
			 and type(oldEntry[2]) == "string"
			 and type(oldEntry[3]) == "string"
			 and type(oldEntry[4]) == "number") then
		
			hfLootLogDB[i] = {
				["time"]      = oldEntry[1],
				["character"] = oldEntry[2],
				["itemLink"]  = oldEntry[3],
				["itemName"]  = oldEntry[3]:match("|h%[?(.-)%]?|h"),
				["itemID"]    = oldEntry[3]:match("|Hitem:(.-):"),
				["count"]     = oldEntry[4],
				["id"]        = self.idIter,
			};
			self.idIter = self.idIter + 1;
		else
			tremove(hfLootLogDB, i);
			i = i - 1;
		end
	end
	
	hfLootLogDB.version = 2;
end

function module:updateDB()
	if ( hfLootLogDB.version == 1 ) then
		self:updateDBv1tov2()
	end
end

function module.onLoad()

	-- if there are DB saved in hfLootRollOptions - importing it
	if ( module.options.DB ) then
		module.oldDB = module.options.DB;
		module.oldDBVersion = module.options.DBversion or 1;
		module.options.DB = nil;
		module.options.DBversion = nil;
	end
	
	if ( addon.loaded ) then
		module:init();
	end
	
	module.loaded = true;
end

-- this method called after loading both hfLootLog and hfLootRoll
function module:init()
	if ( module.oldDB ) then
		hfLootLogDB = module.oldDB;
		hfLootLogDB.version = module.oldDBVersion;
	end

	if ( not hfLootLogDB.version ) then
		hfLootLogDB.version = 1;
	end
	if ( hfLootLogDB.version < DATABASE_VERSION ) then
		module:updateDB();
	end
	
	for _, v in ipairs(hfLootLogDB) do
		if ( module.idIter <= v.id ) then
			module.idIter = v.id + 1;
		end
	end
	
	module.options.logging = true;
	
	hfLootRoll:FireEvent("LOG_UPDATE");
end

function module:addEntry(name, itemLink, count, rollType, source)
	tinsert(hfLootLogDB, {
		["time"]      = time(),
		["character"] = name,
		["itemLink"]  = itemLink,
		["itemName"]  = itemLink:match("|h%[?(.-)%]?|h"),
		["itemID"]    = itemLink:match("|Hitem:(.-):"),
		["count"]     = count,
		["id"]        = self.idIter,
		["rollType"]  = rollType,
		["source"]    = source,
	});
	self.idIter = self.idIter + 1;
	
	hfLootRoll:FireEvent("LOG_UPDATE");
end

function module:clearLog()
	wipe(hfLootLogDB);
	
	hfLootRoll:FireEvent("LOG_UPDATE");
end


function module.matchFilter(entry, filter)	
	if ( filter == nil ) then
		return true;
	end
	if ( filter.timeMin ) then
		if ( entry.time < filter.timeMin ) then
			return false;
		end
	end
	if ( filter.timeMax ) then
		if ( entry.time > filter.timeMax ) then
			return false;
		end
	end
	if ( filter.character ) then
		if ( entry.character ~= filter.character ) then
			return false;
		end
	end
	if ( filter.item ) then
		local itemName = entry.itemName;
		local itemID   = entry.itemID;
		if ( (not itemName:match(filter.item)) and filter.item ~= itemID ) then
			return false;
		end
	end
	if ( filter.quality ) then
		local _, _, quality = GetItemInfo(entry.itemID);
		if ( not filter.quality[quality] ) then
			return false;
		end
	end
	
	return true;
end

function module:getFilteredDB(filter)
	if ( hfLootLogDB == nil ) then
		return {};
	elseif ( not filter or (#hfLootLogDB == 0) ) then
		return cloneTable(hfLootLogDB, true);
	end
	
	local filteredDB = {};
	
	for i = 1, #hfLootLogDB do
		if ( self.matchFilter(hfLootLogDB[i], filter) ) then
			tinsert(filteredDB, hfLootLogDB[i]);
		end
	end
	
	return filteredDB;
end

local funcCache = {};
local function makeComparator(compType, isDesc)
	local hash = compType .. tostring(isDesc);
	if ( funcCache[hash] ) then
		return funcCache[hash];
	end

	local compSign = isDesc and "<" or ">";
	local compField;
	local needDefault = false;
	local byTimeIfEqual = true;
	if ( compType == "Name" ) then
		compField = "character";
	elseif ( compType == "Item" ) then
		compField = "itemName";
	elseif ( compType == "Roll" ) then
		compField = "rollType";
		needDefault = true;
	elseif ( compType == "Source" ) then
		compField = "source";
		needDefault = true;
	else
		compField = "time";
		byTimeIfEqual = false;
	end
	
	local a, b;
	if ( needDefault ) then
		a = [[(a.]] .. compField .. [[ or "")]];
		b = [[(b.]] .. compField .. [[ or "")]];
	else
		a = [[a.]] .. compField;
		b = [[b.]] .. compField;
	end
	
	local funcString = [[
		return function(a, b)
	]];
	if ( byTimeIfEqual ) then
		funcString = funcString .. [[ 
			if ( ]] .. a .. [[ == ]] .. b .. [[ ) then 
				return a.time ]] .. compSign .. [[ b.time;
			end 
		]];
	end
	funcString = funcString .. [[ 
			return ]] .. a .. compSign .. b .. [[; 
		end
	]];
	
	local func = loadstring(funcString)();
	
	funcCache[hash] = func;
	
	return func;
end

function module:SortDB(DB, sortType, sortDesc)
	sort(DB, makeComparator(sortType, sortDesc));
	
	return DB;
end

function module:checkThreshold(name, itemLink)
	local threshold = self.loggingThresholds;
	
	local _, instType = IsInInstance();
	if ( not threshold.logInInstances["none"] ) then
		if ( not threshold.logInInstances[instType] ) then
			return false;
		end
	end

	local _, _, quality, _, _, _, _, stack = GetItemInfo(itemLink);
	local itemName = itemLink:match("|h%[?(.-)%]?|h");
	local itemID   = itemLink:match("|Hitem:(.-):");
	
	if ( threshold.notLogged[itemName] or threshold.notLogged[itemID] ) then
		return false;
	end
	
	if ( quality == nil ) then
		quality = 7;
	end
	if ( quality < threshold.quality ) then
		return false;
	end
	
	if ( stack == nil ) then
		stack = 0;
	end
	if ( (stack == 2147483647) and (not threshold.logMoney) ) then
		return false;
	end
	
	if ( (name ~= const.PLAYER_NAME) and threshold.logOnlyMine ) then
		return false;
	end
	
	return true;
end

--[[
	usages:
		msglootProcessor(name, itemLink, count)
		msglootProcessor(name, itemLink) 
		msglootProcessor(itemLink, count)
		msglootProcessor(itemLink)
		
	defaults:
		name:  const.PLAYER_NAME
		count: 1
]]
local itemRollsTypes = {};
local itemRollsResults = {};
function module.logListener.msglootProcessor(...)
	local name;
	local itemLink;
	local count;
	local arg1, arg2, arg3 = ...;
	if ( arg3 ) then
		name     = arg1;
		itemLink = arg2;
		count    = arg3;
	elseif ( arg2 ) then
		if ( type(arg2) == "number" ) then
			name 	 = const.PLAYER_NAME;
			itemLink = arg1;
			count    = arg2;
		else
			name     = arg1;
			itemLink = arg2;
			count    = 1;
		end
	else
		name 	 = const.PLAYER_NAME;
		itemLink = arg1;
		count    = 1;
	end
	
	if ( module:checkThreshold(name, itemLink) ) then
		local _, _, _, _, _, _, itemSubType = GetItemInfo(itemLink);
		
		-- if it is enchanting material - appending source
		if ( itemSubType == select(7, GetAuctionItemSubClasses(6)) ) then 
			if ( itemRollsResults[name] and (itemRollsResults[name].type == "disenchant") ) then
				module:addEntry(name, itemLink, count, "disenchant", itemRollsResults[name].item);
				itemRollsResults[name] = nil;
				return;
			end
		end
		
		if ( itemRollsResults[name] ) then
			if ( itemRollsResults[name].item == itemLink ) then
				module:addEntry(name, itemLink, count, itemRollsResults[name].type);
				itemRollsResults[name] = nil;
				return;
			end
		end
		
		module:addEntry(name, itemLink, count);
	end
end

local function saveRollResult(name, rollType, itemLink)
	itemRollsResults[name] = {
		["type"] = rollType,
		["item"] = itemLink,
	};
end

function module.logListener.rollAsGreed(rollResult, itemLink, name)
	itemRollsTypes[itemLink] = itemRollsTypes[itemLink] or {};
	itemRollsTypes[itemLink][name] = "greed";
end
function module.logListener.rollAsNeed(rollResult, itemLink, name)
	itemRollsTypes[itemLink] = itemRollsTypes[itemLink] or {};
	itemRollsTypes[itemLink][name] = "need";
end
function module.logListener.rollAsDisenchant(rollResult, itemLink, name)
	itemRollsTypes[itemLink] = itemRollsTypes[itemLink] or {};
	itemRollsTypes[itemLink][name] = "disenchant";
end
function module.logListener.rollWon(name, itemLink)
	if ( not itemLink ) then
		itemLink = name;
		name = const.PLAYER_NAME;
	end
	if ( itemRollsTypes[itemLink] ) then
		saveRollResult(name, itemRollsTypes[itemLink][name], itemLink);
		itemRollsTypes[itemLink] = nil;
	end
end
function module.logListener.rollWonGreed(name, rollResult, itemLink)
	if ( not itemLink ) then
		itemLink = rollResult;
		rollResult = name;
		name = const.PLAYER_NAME;
	end
	saveRollResult(name, "greed", itemLink);
	itemRollsTypes[itemLink] = nil;
end
function module.logListener.rollWonNeed(name, rollResult, itemLink)
	if ( not itemLink ) then
		itemLink = rollResult;
		rollResult = name;
		name = const.PLAYER_NAME;
	end
	saveRollResult(name, "need", itemLink);
	itemRollsTypes[itemLink] = nil;
end
function module.logListener.rollWonDisenchant(name, rollResult, itemLink)
	if ( not itemLink ) then
		itemLink = rollResult;
		rollResult = name;
		name = const.PLAYER_NAME;
	end
	saveRollResult(name, "disenchant", itemLink);
	itemRollsTypes[itemLink] = nil;
end

function module.logListener.onEvent(self, event, ...)
	if ( event == "CHAT_MSG_LOOT" ) then
		if ( module.active ) then
			local text = ...;
			for i, pattern in ipairs(module.lootEvents) do 
				local match1, match2, match3 = Deformat(text, pattern);
				if ( match1 ) then
					self.msglootProcessor(match1, match2, match3);
					return;
				end
			end
			for i, rollevent in ipairs(module.rollEvents) do
				local match1, match2, match3 = Deformat(text, rollevent[1]);
				if ( match1 ) then
					self[rollevent[2]](match1, match2, match3);
					return;
				end
			end
		end
	end
end

module.logListener:SetScript("OnEvent", module.logListener.onEvent);
module.logListener:RegisterEvent("CHAT_MSG_LOOT");

module.logCleaner.elapsed = 3540;
module.logCleaner:SetScript("OnUpdate", function(self, elapsed)
	if ( self.active ) then
		self.elapsed = self.elapsed + elapsed;
		if ( self.elapsed > 3600 ) then
			self.elapsed = 0;
			self:cleanOld();
		end
	end
end)

function module.logCleaner:cleanOld()
	local curTime = time();
	local i = 1;
	while ( i <= #hfLootLogDB ) do
		local daysElapsed = difftime(curTime, hfLootLogDB[i].time) / 86400;
		if ( daysElapsed > self.threshold ) then
			tremove(hfLootLogDB, i);
			i = i - 1;
		end
		i = i + 1;
	end
end

hfLootRoll:AddModule("log", module);