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

addon.callbacks = {};

addon.callbacks.single  = {};
addon.callbacks.maps    = {};
addon.callbacks.onloads = {};
addon.callbacks.onlibs  = {};

local addonLoaded = false;
local libsLoaded = false;

local loader = CreateFrame("Frame");
loader:SetScript("OnEvent", function(self, event, ...)
	if ( event == "ADDON_LOADED" ) then
		local addonName = ...;
		if ( addonName == ADDON_NAME ) then
			self:UnregisterEvent("ADDON_LOADED");
			for _, func in ipairs(addon.callbacks.onloads) do
				func();
			end	
			addonLoaded = true;
		end
	elseif ( event == "PLAYER_ENTERING_WORLD" ) then
		self:UnregisterEvent("PLAYER_ENTERING_WORLD");
		for libName, functable in pairs(addon.callbacks.onlibs) do
			local lib = LibStub(libName, true);
			if ( lib ) then
				for _, func in ipairs(functable) do
					func(lib);
				end;
			end
		end
		libsLoaded = true;
	end
end)
loader:RegisterEvent("ADDON_LOADED");
loader:RegisterEvent("PLAYER_ENTERING_WORLD");

function addon:FireEvent(event, ...)
	local functable = self.callbacks.single[event];
	if ( functable ) then
		for _, func in ipairs(functable) do
			func(event, ...);
		end
	end
	for _, map in ipairs(self.callbacks.maps) do
		if ( map[event] ) then
			map[event](event, ...);
		end
	end
end

function addon:RegisterCallback(event, func)
	if ( not self.callbacks.single[event] ) then
		self.callbacks.single[event] = {};
	end
	tinsert(self.callbacks.single[event], func);
end

function addon:RegisterCallbackMap(funcmap)
	tinsert(self.callbacks.maps, funcmap);
end

function addon:RegisterOnLoad(func)
	if ( not addonLoaded ) then
		tinsert(self.callbacks.onloads, func);
	else
		func();
	end
end

function addon:RegisterOnLoadLib(libName, func)
	if ( not libsLoaded ) then
		if ( not self.callbacks.onlibs[libName] ) then
			self.callbacks.onlibs[libName] = {};
		end
		tinsert(self.callbacks.onlibs[libName], func);
	else
		local lib = LibStub(libName, true);
		if ( lib ) then
			func(lib);
		end
	end
end