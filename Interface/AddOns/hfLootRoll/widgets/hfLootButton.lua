--[[

	hfLootButton - World of Warcraft addon that provides opportunities 
	for creating loot roll buttons

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

--[[
	Creates loot roll button, available methods:
	
	hf_Widgets.LootButton(name, parent, rollType, counterXOff, counterYOff)
		creates new loot button
		
		name: button name (string)
		parent: button's parent (string or table)
		rollType: button type: "pass"/"need"/"greed"/"disenchant" (string)
		counterXOff: counter string x offset (number)
		counterYOff: counter string y offset (number)
		
		returns created button (table)
		
	lootbutton:SetSizes(size)
		sets button height and width
		
		size: new size (number)
		
	lootbutton:SetEnabled(enabled, reason)
		enables/disables button
		
		enabled: true to enable, false to disable (boolean)
		reason: if disabled, text that will be shown in tooltip (string)
		
	lootbutton:SetHighlight(enabled)
		enables/disables highlight
		
		enabled: true to enable, false to disable (boolean)
	
	lootbutton.characterList - list of names should be shown in tooltip (table)
	
	lootbutton.showWhoColorize - if true, names in tooltip vill be colored by class (boolean)
	
	lootbutton.tooltipText - text will be shown in tooltip (string)
		
	lootbutton.reason - text that should be shown in tooltip if button is disabled (string)
	
	lootbutton.doNotRoll - if this flag is checked, roll will not be performed and onClick woll not be called (boolean)
	
	lootbutton.rollID - rollID that will be used when button is clicked (number)
	
	lootbutton.onClick (self, button) - function called after clicking (function)
]]

local ADDON_NAME = ...;

local WIDGET = "LootButton";

--@non-debug@
local REV = 40;
--@end-non-debug@
--[===[@debug@
local REV = 99999;
--@end-debug@]===]

if ( hf_Widgets == nil ) then
	hf_Widgets = {}
end

if ( (hf_Widgets[WIDGET] ~= nil)
	and (hf_Widgets[WIDGET].r >= REV) ) then
	return;
end

local L = {};
L["Unknown reason :("] = "Unknown reason :(";
if ( GetLocale() == "ruRU" ) then
	L["Unknown reason :("] = "Неизвестная причина :(";
end

local IS_CATACLYSM = select(4, GetBuildInfo()) >= 40000;
	
local ROLE_ICONS = {
	["TANK"] = "|TInterface\\LFGFrame\\UI-LFG-ICON-PORTRAITROLES.blp:16:16:0:%d:64:64:0:19:22:41|t ",
	["HEALER"] = "|TInterface\\LFGFrame\\UI-LFG-ICON-PORTRAITROLES.blp:16:16:0:%d:64:64:20:39:1:20|t ",
	["DAMAGER"] = "|TInterface\\LFGFrame\\UI-LFG-ICON-PORTRAITROLES.blp:16:16:0:%d:64:64:20:39:22:41|t ",
};

local function addCharactersToTooltip(self)
	if ( self.characterList ) then		
		for _, name in ipairs(self.characterList) do
		
			local r, g, b = 1, 1, 1;
			if ( self.showWhoColorize ) then
				local _, class = UnitClass(name);
				if ( class ) then
					r = RAID_CLASS_COLORS[class].r * 1.2;
					g = RAID_CLASS_COLORS[class].g * 1.2;
					b = RAID_CLASS_COLORS[class].b * 1.2;
				end
			end
			
			local icon = "";
			if ( IS_CATACLYSM ) then
				local role = UnitGroupRolesAssigned(name);				
				icon = ROLE_ICONS[role] or "";
			else
				local isTank, isHealer, isDamage = UnitGroupRolesAssigned(name);
				if ( isTank ) then
					icon = ROLE_ICONS.TANK;
				elseif ( isHealer ) then
					icon = ROLE_ICONS.HEALER;
				elseif ( isDamage ) then
					icon = ROLE_ICONS.DAMAGER;
				end
			end
			
			GameTooltip:AddLine(icon .. name, r, g, b);
			
		end
	end
end

local methods = {};

methods.SetSizes = function(self, _priv, size)
	self:SetSize(size, size);
end

-- disables only self.onClick() script, doesn't disable RollOnLoot()
methods.SetEnabled = function(self, _priv, value, reason)
	if ( value ) then
		self:SetHighlightTexture(_priv.highltghtTexture);
		self:SetAlpha(1);
		SetDesaturation(self:GetNormalTexture(), false);
		SetDesaturation(self:GetPushedTexture(), false);
	else
		self:SetHighlightTexture(nil);
		self:SetAlpha(0.55);
		SetDesaturation(self:GetNormalTexture(), true);
		SetDesaturation(self:GetPushedTexture(), true);
	end
	_priv.enabled = value;
	self.reason = reason;
end
	
methods.SetHighlight = function(self, _priv, highlightEnabled)
	if ( highlightEnabled ) then
		self.Highlight:Show();
	else
		self.Highlight:Hide();
	end
end

local function constructor(name, parent, rollType, counterXOff, counterYOff)
	assert( type(name) == "string"
		, WIDGET .. " constructor: Bad argument #1 (string expected, got " .. type(name) .. ")");
	assert( (type(parent) == "string") 
		or ( type(parent) == "table" 
			and type(parent.IsObjectType) == "function" 
			and parent:IsObjectType("Frame") )
		, WIDGET .. " constructor: Bad argument #2 (string or Frame expected, got " .. type(parent) .. ")");
	assert( type(rollType) == "string"
		, WIDGET .. " constructor: Bad argument #3 (string expected, got " .. type(rollType) .. ")");
	assert( type(counterXOff) == "number"
		, WIDGET .. " constructor: Bad argument #4 (number expected, got " .. type(counterXOff) .. ")");
	assert( type(counterYOff) == "number"
		, WIDGET .. " constructor: Bad argument #5 (number expected, got " .. type(counterYOff) .. ")");

	local rollButton = CreateFrame("Button", name, parent);
	
	local _priv = {};
	
	rollButton.ArtLayer = CreateFrame("Frame", nil, rollButton);
	rollButton.ArtLayer:SetAllPoints();
	
	rollButton.Highlight = rollButton.ArtLayer:CreateTexture(name .. "HighlightTex", "ARTWORK");
	rollButton.Highlight:SetAllPoints();
	rollButton.Highlight:SetBlendMode("ADD");
	rollButton.Highlight:Hide();
	
	rollButton.counter = rollButton.ArtLayer:CreateFontString(name .. "Counter", "OVERLAY", "GameFontNormal");
	rollButton.counter:SetVertexColor(1, 1, 1);
	local ffilename, fsize = rollButton.counter:GetFont();
	rollButton.counter:SetFont(ffilename, fsize, "THICKOUTLINE");
	rollButton.counter:SetPoint("CENTER", counterXOff or 0, counterYOff or 0);
	rollButton.counter:SetText("0");
	
	_priv.enabled = true;
	
	if ( rollType == "pass" ) then
		_priv.normalTexture = "Interface/Buttons/UI-GroupLoot-Pass-Up";
		_priv.highltghtTexture = "Interface\\AddOns\\" .. ADDON_NAME .. "\\textures\\pass-highlight-fixed";
		_priv.pushedTexture = "Interface\\AddOns\\" .. ADDON_NAME .. "\\textures\\pass-down-fixed";
		_priv.size = 18;
		_priv.rollindex = 0;
		rollButton.tooltipText = PASS;
	elseif ( rollType == "need" ) then
		_priv.normalTexture = "Interface/Buttons/UI-GroupLoot-Dice-Up";
		_priv.highltghtTexture = "Interface/Buttons/UI-GroupLoot-Dice-Highlight";
		_priv.pushedTexture = "Interface/Buttons/UI-GroupLoot-Dice-Down";
		_priv.size = 20;
		_priv.rollindex = 1;
		rollButton.tooltipText = NEED;
	elseif ( rollType == "greed" ) then
		_priv.normalTexture = "Interface/Buttons/UI-GroupLoot-Coin-Up";
		_priv.highltghtTexture = "Interface/Buttons/UI-GroupLoot-Coin-Highlight";
		_priv.pushedTexture = "Interface/Buttons/UI-GroupLoot-Coin-Down";
		_priv.size = 20;
		_priv.rollindex = 2;
		rollButton.tooltipText = GREED;
	elseif ( rollType == "disenchant" ) then
		_priv.normalTexture = "Interface/Buttons/UI-GroupLoot-DE-Up";
		_priv.highltghtTexture = "Interface/Buttons/UI-GroupLoot-DE-Highlight";
		_priv.pushedTexture = "Interface/Buttons/UI-GroupLoot-DE-Down";
		_priv.size = 20;
		_priv.rollindex = 3;
		rollButton.tooltipText = ROLL_DISENCHANT;
	else
		error(WIDGET .. " constructor: invalid rollType");
	end
	
	rollButton.Highlight:SetTexture(_priv.highltghtTexture);
		
	rollButton:SetSize(_priv.size, _priv.size);
	rollButton.originalSize = _priv.size;
	rollButton:SetNormalTexture(_priv.normalTexture);
	rollButton:SetHighlightTexture(_priv.highltghtTexture, "ADD");
	rollButton:SetPushedTexture(_priv.pushedTexture);
	rollButton:SetMotionScriptsWhileDisabled(true);
	rollButton:SetScript("OnClick", function(self, button)
		if ( self.doNotRoll ) then
			return;
		end
		
		if ( self.onClick and _priv.enabled ) then
			self:onClick(button);
		end
		if ( button == "LeftButton" ) then
			RollOnLoot(self.rollID, _priv.rollindex);
		end
	end);
	
	rollButton:SetScript("OnEnter", function(self)
		GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
		GameTooltip:AddLine(self.tooltipText);
		if ( self.lootFrame.showWhoRolled ) then
			addCharactersToTooltip(self);
		end
		if ( not _priv.enabled ) then
			GameTooltip:AddLine(self.reason, RED_FONT_COLOR.r, RED_FONT_COLOR.g, RED_FONT_COLOR.b, true);
		end
		GameTooltip:Show();
	end);
	rollButton:SetScript("OnLeave", function(self)
		GameTooltip:Hide(); 
	end);
	
	rollButton.reason = L["Unknown reason :("];
	
	-- registering methods
	for methodName, method in pairs(methods) do
		rollButton[methodName] = function(self, ...)
			return method(self, _priv, ...);
		end
	end
	
	return rollButton;
end

hf_Widgets[WIDGET] = setmetatable({
	c = constructor,
	r = REV,
},
{
	__call = function(t, ...)
		return t.c(...);
	end
});