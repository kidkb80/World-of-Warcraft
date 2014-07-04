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

local L = addon.L;

local module = {}
module.options = {}

module.commands = {}
module.commandInfo = {}

function module:PrintHelp()
	print("|cffee44ffhfLootRoll|r: " .. L"SLASH_AVAILABLE_COMMANDS" .. ":");
	for command, info in pairs(self.commandInfo) do
		print("    " .. command .. " - " .. info);
	end
end

function module:AddCommand(command, func, info)
	assert( type(command) == "string"
		, "hfLootRoll_slash:AddCommand() Bad argument #1 (string expected, got " .. type(command) .. ")");
	assert( type(func) == "function"
		, "hfLootRoll_slash:AddCommand() Bad argument #2 (function expected, got " .. type(func) .. ")");
	assert( not self.commands[command]
		, "hfLootRoll_slash:AddCommand() Command already exists");
	
	if ( info ) then
		assert( type(info) == "string"
			, "hfLootRoll_slash:AddCommand() Bad argument #3 (string expected, got " .. type(info) .. ")");
		self.commandInfo[command] = info;
	end
	
	self.commands[command] = func;
end

SLASH_hfLootRollRoll1 = "/hfLootRoll";
SLASH_hfLootRollRoll2 = "/hflootroll";
SLASH_hfLootRollRoll3 = "/hflr";

SlashCmdList["hfLootRollRoll"] = function(msg)
	local command = strsplit(" ", msg);
    if ( (msg ~= "") and module.commands[command] ) then
		if ( strlen(command) < strlen(msg) ) then
			module.commands[command](strsub(msg, strlen(command)+2));
		else
			module.commands[command]();
		end
    else
		module:PrintHelp();
    end
end

--[===[@debug@
SLASH_rl1 = "/rl"
SlashCmdList["rl"] = function(msg)
	ReloadUI();
end
SLASH_test1 = "/test"
SlashCmdList["test"] = function(msg)
	loadstring(msg)();
end
--@end-debug@]===]

addon:AddModule("slash", module)