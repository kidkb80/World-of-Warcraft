local _, addon = ...;

local L = {};
addon.L = L;

setmetatable(L, {
	__index = function(self, key) 
		--[===[@debug@
		print("hfLootLogDebug: untranslated phrase: " .. key);
		--@end-debug@]===] 
		return key;
	end,
	
	__call = function(self, key)
		return self[key];
	end
});


L["AUTO_DELETE_TIME_1"] = "Automatically delete log entries after" -- Needs review
L["AUTO_DELETE_TIME_2"] = "days" -- Needs review
L["BINDING_HEADER"] = "hfLootLog"
L["BINDING_TOGGLE"] = "Toggle log window"
L["CLEAR_LOG"] = "Clear log" -- Needs review
L["CLEAR_LOG_POPUP"] = "Do you really want to clear log? This operation is irreversible." -- Needs review
L["CLOSE"] = "Close" -- Needs review
L["EARLIEST"] = "Earliest" -- Needs review
L["ENTRY_FORMAT"] = "%s %s received %s %s %s" -- Needs review
L["FILTERS_HIDE"] = "Hide filters" -- Needs review
L["FILTERS_SHOW"] = "Show filters" -- Needs review
L["HEADER_DATE"] = "Date"
L["HEADER_ITEM"] = "Item"
L["HEADER_NAME"] = "Name"
L["HEADER_ROLL"] = "Roll"
L["HEADER_SOURCE"] = "Source"
L["ITEM"] = "Item" -- Needs review
L["LATEST"] = "Latest" -- Needs review
L["LOG"] = "Log" -- Needs review
L["LOG_CURRENCY"] = "Log currency (emblems, badges etc.)" -- Needs review
L["LOG_DISABLED"] = "Logging disabled" -- Needs review
L["LOG_ENABLED"] = "Logging enabled" -- Needs review
L["LOG_ONLY_INSTANCES"] = "Log only in dungeons" -- Needs review
L["LOG_ONLY_MINE"] = "Log only my loot" -- Needs review
L["MANY_ENTRIES_WARNING"] = "Too many entries in database, showing only last %d records" -- Needs review
L["NAME"] = "Name" -- Needs review
L["OPEN_LOG"] = "Open log" -- Needs review
L["PARTY"] = "Party" -- Needs review
L["QUALITY_THRESHOLD"] = "Quality threshold" -- Needs review
L["RAID"] = "Raid" -- Needs review
L["SLASH_OPEN_LOG"] = "open log window" -- Needs review
