--[[

	hfLootFrame - World of Warcraft addon that provides opportunities 
	for creating loot frames

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
	Creates loot roll frame, available methods:
	
	hf_Widgets.LootFrame_v2(name, parent)
		creates new loot frame
		
		name: frame name (string)
		parent: frame parent (string|table)
		
		returns created frame (table)
			  
	lootframe:ResetCounters()
		sets all counters to 0

	lootframe:SetRollID(rollID)
		sets rollID handled by this frame
		
		rollID: handled rollID (number)

	lootframe:SetIcon(texture)
		sets item icon
		
		texture: icon texture (string|table)

	lootframe:SetName(name)
		sets item name
		
		name: item name (string)

	lootframe:SetBoP(bop)
		sets bop indicator
		
		bop: if true - show bop indicator (boolean)

	lootframe:SetQuality(quality)
		sets item quality
		
		quality: new quality (number)

	lootframe:SetTime(rollTime)
		sets total roll time
		
		rollTime: time in ms (number)

	lootframe:SetBarColor(...)
		sets backgound color
		
		...: arguments for :SetVertexColor and :SetStatusbarColor (list)

	lootframe:UpdateSparkPosition()
		places spark at the statusbar edge

	lootframe:UpdateSizes([width, height]).
		updates child elements' sizes accordingly to current frame size
		
		width: frame width, by defaults uses current frame width (number)
		height: frame height, by defaults uses current frame height (number)

	lootframe:StopTimer()
		stops time counting

	lootframe:ShowWinner(name)
		displays winner name
		
		name: name to display (string)

	lootframe:Disable()
		turns frame off and hides it

	lootframe:ShowTooltip()
		shows tooltip for linked item

	lootframe:DisableInteraction(mode)
		disables interactions
		
		mode: 1 - disable buttons only, 
			  2 - disable all mouse events, 
			  3 - make frame click-through,
			  4 - initial lock (number)

	lootframe:EnableInteraction(mode)
		enables interactions
		
		mode: 1 - enable buttons only, 
			  2 - enable all mouse events,
			  3 - disable click-through mode,
			  4 - turn initial lock off  (number)

	lootframe:IsInteractionEnabled(mode)
		checks, if interaction in given mode is enabled
		
		mode: 1, 2, 3, or 4 (number)
	
		returns true, if intercation enabled, false or nil otherwise

	lootframe:SetInteraction()
		updates interaction config

	lootframe:GetSelection()
		returns "need", "greed", "disenchant", "pass" or nil depending on selection made(string);

	lootframe:Appear()
		makes frame to appear smoothly

	lootframe:Disappear()
		makes frame to disappear smoothly and then disables it

	lootframe:SetOption(option, ...)
		sets frame option
		
		option: option to change (string)
		...: new value(s) (list)
	
	lootframe.itemLink - link defines item tooltip (string)
	
	lootframe.onDisable (self) - function called before disabling (function)
	
	lootframe.onClick (self, button) - function called after bar clicking (function)
	
	lootframe.onTimeOut (self) - function called after time out (function)
	
	lootFrame.tooltipExtra - string that will be added to item tooltip when hovering bar (string)
]]

local WIDGET = "LootFrame_v2";

--@non-debug@
local REV = 60;
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

local ADDON_NAME = ...;

local L = {};
L["Item tooltip will be here"] = "Item tooltip will be here";
if ( GetLocale() == "ruRU" ) then
	L["Item tooltip will be here"] = "Здесь будет описание предмета";
end

local DEFAULT_TEXTURE = "Interface\\AddOns\\" .. ADDON_NAME .. "\\textures\\Smoothv2";
local UPDATE_INTERVAL = 0.05;
local ALPHA_SPEED     = 1.6 * UPDATE_INTERVAL;
local INIT_LOCK_TIME  = 0.7;

local function formatTime(secondsLeft)
    if ( secondsLeft < 0 ) then
		return "0";
    elseif ( secondsLeft < 60 ) then
        return string.format("%.0f", secondsLeft);
    elseif ( secondsLeft < 3600 ) then
        return string.format("%.0fm", secondsLeft / 60);
    elseif ( secondsLeft < 86400 ) then
        return string.format("%.0fh", secondsLeft / 3600);
    else
        return string.format("%.0fd", secondsLeft / 86400);
	end
end

local function setAlphaAnim(anim, order, change, dur)
	anim:SetOrder(order);
	anim:SetChange(change);
	anim:SetDuration(dur);
end

local methods = {};

methods.ResetCounters = function(self, _priv)
	self.Need.counter:SetText("0");
	self.Greed.counter:SetText("0");
	self.Pass.counter:SetText("0");
	self.Disenchant.counter:SetText("0");
end

methods.SetRollID = function(self, _priv, rollID)
	self.rollID = rollID;
	self.Need.rollID = rollID;
	self.Greed.rollID = rollID;
	self.Pass.rollID = rollID;
	self.Disenchant.rollID = rollID;
end

methods.SetIcon = function(self, _priv, texture)
	self.Icon:SetNormalTexture(texture);
end

methods.SetName = function(self, _priv, name)
	self.ItemName:SetText(name);
end

methods.SetBoP = function(self, _priv, bop)
	_priv.bop = bop;
	if ( bop and _priv.displayBoP) then
		self.BoPIndicator:Show();
	else
		self.BoPIndicator:Hide();
	end
end

local slotTypeMap = {
	["INVTYPE_AMMO"]     = {0},
	["INVTYPE_HEAD"]     = {1},
	["INVTYPE_NECK"]     = {2},
	["INVTYPE_SHOULDER"] = {3},
	["INVTYPE_BODY"]     = {4},
	["INVTYPE_CHEST"]    = {5},
	["INVTYPE_ROBE"]     = {5},
	["INVTYPE_WAIST"]    = {6},
	["INVTYPE_LEGS"]     = {7},
	["INVTYPE_FEET"]     = {8},
	["INVTYPE_WRIST"]    = {9},
	["INVTYPE_HAND"]     = {10},
	["INVTYPE_FINGER"]   = {11,12},
	["INVTYPE_TRINKET"]  = {13,14},
	["INVTYPE_CLOAK"]    = {15},
	["INVTYPE_WEAPON"]   = {16,17},
	["INVTYPE_SHIELD"]   = {17},
	["INVTYPE_2HWEAPON"] = {16},
	["INVTYPE_WEAPONMAINHAND"] = {16},
	["INVTYPE_WEAPONOFFHAND"] = {17},
	["INVTYPE_HOLDABLE"] = {17},
	["INVTYPE_RANGED"]   = {18},
	["INVTYPE_THROWN"]   = {18},
	["INVTYPE_RANGEDRIGHT"] = {18},
	["INVTYPE_RELIC"]    = {18},
	["INVTYPE_TABARD"]   = {19},
};

methods.SetILvl = function(self, _priv, ilvl, compslot)
	if ( (type(ilvl) ~= "number") or (compslot == "") or (not slotTypeMap[compslot]) ) then
		self.LvlIndicator.tex:Hide();
		return;
	end
	
	self.LvlIndicator.tex:Show();
	
	_priv.ilvl = ilvl;
	_priv.slot = compslot;
	local compilvl;
	
	local slotID = slotTypeMap[compslot][1];
	local itemID = GetInventoryItemID("player", slotID);
	if ( not itemID ) then
		compilvl = 0;
	else
		compilvl = select(4, GetItemInfo(itemID));
	end
	
	slotID = slotTypeMap[compslot][2];
	if ( slotID ) then
		itemID = GetInventoryItemID("player", slotID);
		if ( not itemID ) then
			compilvl = 0;
		else
			compilvl = math.min(select(4, GetItemInfo(itemID)), compilvl);
		end
	end
	
	if ( compilvl < ilvl ) then
		self.LvlIndicator.tex:SetTexture("Interface\\AddOns\\" .. ADDON_NAME .. "\\textures\\up");
	elseif ( compilvl > ilvl ) then
		self.LvlIndicator.tex:SetTexture("Interface\\AddOns\\" .. ADDON_NAME .. "\\textures\\down");
	else
		self.LvlIndicator.tex:SetTexture("Interface\\AddOns\\" .. ADDON_NAME .. "\\textures\\equal");
	end
end

methods.SetQuality = function(self, _priv, quality)
	self.quality = quality;
	
	local color = _priv.colorTable[quality] or ITEM_QUALITY_COLORS[quality];
	
	self:SetBarColor(color.r, color.g, color.b);
	
	if ( _priv.nameColorByQuality ) then
		self.ItemName:SetVertexColor(color.r, color.g, color.b);
	end
	
	if ( _priv.borderColorByQuality ) then
		self.Border:SetBackdropBorderColor(color.r, color.g, color.b, _priv.colorTable.Border.a);
	else
		self.Border:SetBackdropBorderColor(_priv.colorTable.Border.r
											, _priv.colorTable.Border.g
											, _priv.colorTable.Border.b
											, _priv.colorTable.Border.a);
	end
end

methods.SetTime = function(self, _priv, rollTime)
	self.timeLeft = rollTime
	self.Bar:SetMinMaxValues(0, rollTime);
	self.Bar:SetValue(rollTime);
	self.Bar.sparkHolder:SetWidth(self.Bar:GetWidth())
end

methods.SetBarColor = function(self, _priv, ...)
	if ( _priv.barTimer ) then
		self.Bar:SetStatusBarColor(...);
		self.StaticBg:SetVertexColor(_priv.colorTable.Bg.r, _priv.colorTable.Bg.g, _priv.colorTable.Bg.b);
	else
		self.StaticBg:SetVertexColor(...);
	end
end

methods.UpdateSparkPosition = function(self, _priv)
	if ( _priv.barTimer ) then
		if ( self.timeLeft ) then
			self.Bar.sparkHolder:SetWidth(self.Bar:GetWidth()
				* self.Bar:GetValue() / select(2, self.Bar:GetMinMaxValues()));
		else
			self.Bar.sparkHolder:SetWidth(0);
		end
	end
end

methods.UpdateSizes = function(self, _priv, width, height)
	if ( width == nil ) then
		width = self:GetWidth();
		height = self:GetHeight();
	end
	
	-- if we don't change value after resizing - bar will be displayed incorrectly
	local oldBarValue = self.Bar:GetValue();
	self.Bar:SetValue(oldBarValue + 1);
	self.Bar:SetValue(oldBarValue);
	
	self.Bar.spark:SetHeight(height*1.5);
	self.Bar.spark:SetWidth(height/2.5);
	
	self:UpdateSparkPosition();
	
	local iconSize = height * _priv.iconScale;
	if ( iconSize ~= self.Icon:GetWidth() ) then
		self.Icon:SetWidth(iconSize);
		self.Icon:SetHeight(iconSize);
		self.BoPIndicator:SetWidth(iconSize * 0.35);
		self.BoPIndicator:SetHeight(iconSize * 0.35);
		self.LvlIndicator:SetWidth(iconSize * 0.35);
		self.LvlIndicator:SetHeight(iconSize * 0.35);
	end
	
	-- Rescaling buttons in loot frame so they do not go beyond frame
	local sizeFactor = height * 0.9 / self.Need.originalSize;
	local minWidth = height * _priv.iconScale
					 + self.Need.originalSize * sizeFactor
					 + self.Greed.originalSize * sizeFactor
					 + self.Disenchant.originalSize * sizeFactor
					 + self.Pass.originalSize * sizeFactor
					 + self.TimerWrapper:GetWidth()
					 + 20;
	
	local buttonSizeMultiplier;
	if ( width < minWidth ) then
		local freeSpace = width - (self.TimerWrapper:GetWidth() + height * _priv.iconScale + 20);
		local originalSizeSum = self.Need.originalSize 
								+ self.Greed.originalSize 
								+ self.Disenchant.originalSize
								+ self.Pass.originalSize;
		buttonSizeMultiplier = freeSpace * _priv.buttonsScale / originalSizeSum;
	else
		buttonSizeMultiplier = sizeFactor * _priv.buttonsScale;
	end
		
	self.Need:SetSizes(buttonSizeMultiplier * self.Need.originalSize);
	self.Greed:SetSizes(buttonSizeMultiplier * self.Greed.originalSize);
	self.Disenchant:SetSizes(buttonSizeMultiplier * self.Disenchant.originalSize);
	self.Pass:SetSizes(buttonSizeMultiplier * self.Pass.originalSize);
end

methods.StopTimer = function(self, _priv)
	_priv.timerStopped = true;
end

methods.ShowWinner = function(self, _priv, name)
	_priv.winner = name;
	
	self.Winner:SetText(name);
	
	if ( name and _priv.showWinner ) then
		self.Winner:Show();
		
		if ( _priv.winnerColorByClass ) then
			local r, g, b = _priv.winnerColor.r, _priv.winnerColor.g, _priv.winnerColor.b;
			local _, class = UnitClass(name);
			if ( class ) then
				r = RAID_CLASS_COLORS[class].r;
				g = RAID_CLASS_COLORS[class].g;
				b = RAID_CLASS_COLORS[class].b;
			end
			self.Winner:SetVertexColor(r, g, b);
		else
			self.Winner:SetVertexColor(_priv.winnerColor.r
										, _priv.winnerColor.g
										, _priv.winnerColor.b);
		end
		
		self.animWinner:Play();
		
		self.WinnerGlow:SetText(name);
		self.WinnerGlow:Show();
		
		self.animGlow1:Play();
	else
		self.Winner:Hide();
	end
	
	self:StopTimer();
	
	self.Bar:SetMinMaxValues(0,1);
	self.Bar:GetStatusBarTexture():SetTexCoord(0, 1, 0, 1);
	self.Bar:SetValue(1);
	self.Bar.spark:Hide();
	
	self.animGlow2:Play();
end

methods.Disable = function(self, _priv)

	if ( self.onDisable ) then
		self:onDisable();
	end

	self.quality  = nil;
	self.busy     = false;
	self.rollID   = nil;
	self.timeLeft = nil;
	self.Need.characterList = nil;
	self.Greed.characterList = nil;
	self.Disenchant.characterList = nil;
	self.Pass.characterList = nil;
	
	self:Hide();
end

methods.ShowTooltip = function(self, _priv, hoveringBar)
	GameTooltip:SetOwner(self.Icon, "ANCHOR_RIGHT");
	
	if ( self.itemLink ) then		
		GameTooltip:SetHyperlink(self.itemLink);
		
		if ( _priv.ttShowComparison ) then
			GameTooltip_ShowCompareItem(GameTooltip, 1);
		end
	else
		GameTooltip:ClearLines();
		GameTooltip:AddLine(L["Item tooltip will be here"]);
	end
	
	if ( hoveringBar and self.tooltipExtra ) then
		GameTooltip:AddLine(self.tooltipExtra);
	end
	
	GameTooltip:Show();
end

methods.DisableInteraction = function(self, _priv, mode)
	_priv.interactions[mode] = false;
	self:SetInteraction();
end

methods.EnableInteraction = function(self, _priv, mode)
	_priv.interactions[mode] = true;
	self:SetInteraction();
end

methods.IsInteractionEnabled = function(self, _priv, mode)
	return _priv.interactions[mode];
end

methods.SetInteraction = function(self, _priv)
	if ( _priv.interactions[1] and _priv.interactions[4] ) then
		self.Need.doNotRoll = false;
		self.Greed.doNotRoll = false;
		self.Disenchant.doNotRoll = false;
		self.Pass.doNotRoll = false;
		self.Icon:SetScript("OnClick", _priv.iconOnClickCB);
	else
		self.Need.doNotRoll = true;
		self.Greed.doNotRoll = true;
		self.Disenchant.doNotRoll = true;
		self.Pass.doNotRoll = true;
		self.Icon:SetScript("OnClick", nil);
	end
	
	if ( not (_priv.interactions[2] and _priv.interactions[3]) ) then
		self.Need:EnableMouse(false);
		self.Greed:EnableMouse(false);
		self.Pass:EnableMouse(false);
		self.Disenchant:EnableMouse(false);
	else
		self.Need:EnableMouse(true);
		self.Greed:EnableMouse(true);
		self.Pass:EnableMouse(true);
		self.Disenchant:EnableMouse(true);
	end
	
	if ( _priv.interactions[3] ) then
		self.TimerWrapper:EnableMouse(true);
		self.Icon:EnableMouse(true);
		self.Bar:EnableMouse(true);
	else
		self.TimerWrapper:EnableMouse(false);
		self.Icon:EnableMouse(false);
		self.Bar:EnableMouse(false);
	end
end

methods.GetSelection = function(self, _priv)
	return _priv.selection;
end

methods.Appear = function(self, _priv)
	_priv.selection = nil;
	_priv.disappearing = false;
	_priv.appearing = true;
	_priv.winner = nil;
	_priv.timerStopped = false;
	_priv.timedOut = false;
	self.Winner:Hide();
	self.WinnerGlow:Hide();
	self:SetAlpha(0);
	self:Show();
	
	if ( _priv.barTimer ) then
		self.Bar.spark:Show();
	else
		self.Bar.spark:Hide();
	end
	
	self.Need:SetHighlight(false);
	self.Greed:SetHighlight(false);
	self.Pass:SetHighlight(false);
	self.Disenchant:SetHighlight(false);
	
	self:DisableInteraction(4);
	_priv.initLockTimer = INIT_LOCK_TIME;
end

methods.Disappear = function(self, _priv)
	_priv.appearing = false;
	_priv.disappearing = true;
end

methods.SetOption = function(self, _priv, option, ...)

	if ( option == "Texture" ) then
		local texture = ...;
		
		self.Bar:SetStatusBarTexture(texture, "BACKGROUND");
		self.Bar:GetStatusBarTexture():SetHorizTile(false);
		self.StaticBg:SetTexture(texture);
		self.StaticBg:SetHorizTile(false);
		self.BarGlow.glow:SetTexture(texture);
	
	elseif ( option == "Font" ) then
		local font = ...;
		
		for _, fontString in ipairs(_priv.strings.font) do
			local _, size, flags = fontString:GetFont();
			fontString:SetFont(font, size, flags);
		end
	
	elseif ( option == "IconScale" ) then
		_priv.iconScale = ...;
		self:UpdateSizes();
	
	elseif ( option == "ButtonScale" ) then
		_priv.buttonsScale = ...;
		self:UpdateSizes();
	
	elseif ( option == "Height" ) then
		self:SetHeight(...);
	
	elseif ( option == "Width" ) then
		self:SetWidth(...);
	
	elseif ( option == "FontSize" ) then
		local size = ...;
	
		for _, fontString in ipairs(_priv.strings.size) do
			local font, _, flags = fontString:GetFont();
			fontString:SetFont(font, size, flags);
		end
	
	elseif ( option == "SparkOpacity" ) then
		self.Bar.spark:SetAlpha(...);
	
	elseif ( option == "Opacity" ) then
		self.Bar:SetAlpha(...);
		self.StaticBg:SetAlpha(...);
	
	elseif ( option == "ShowWho" ) then
		self.showWhoRolled = ...;
	
	elseif ( option == "UseBgTime" ) then
		local use = ...;
		
		_priv.barTimer = use;
		if ( use and (not _priv.winner) ) then
			self.Bar.spark:Show();
		else
			self.Bar.spark:Hide();
		end
		
		if ( self.quality ) then
			self:SetQuality(self.quality)
		end
	
	elseif ( option == "BorderTexture" ) then
		_priv.borderTexture = ...;
		self.Border:SetBackdrop({
			edgeFile = ...,
			edgeSize = _priv.borderSize,
		});
	
	elseif ( option == "BorderSize" ) then
		_priv.borderSize = ...;
		self.Border:SetBackdrop({
			edgeFile = _priv.borderTexture,
			edgeSize = ...,
		});
	
	elseif ( option == "BorderOffset" ) then
		local offset = ...;
		self.Border:SetPoint("TOPLEFT", self.Bar, "TOPLEFT", -offset, offset);
		self.Border:SetPoint("BOTTOMRIGHT", self.Bar, "BOTTOMRIGHT", offset, -offset);
	
	elseif ( option == "BorderColorByQuality" ) then
		_priv.borderColorByQuality = ...;
		if ( ... ) then
			if ( self.quality ) then
				self:SetQuality(self.quality);
			end
		else
			self.Border:SetBackdropBorderColor(_priv.colorTable.Border.r
												, _priv.colorTable.Border.g
												, _priv.colorTable.Border.b
												, _priv.colorTable.Border.a);
		end
	
	elseif ( option == "Color" ) then
		local colorType, r, g, b, a = ...;
		
		if ( colorType == "Border" ) then
			_priv.colorTable.Border.r = r;
			_priv.colorTable.Border.g = g;
			_priv.colorTable.Border.b = b;
			_priv.colorTable.Border.a = a;
		elseif ( colorType == "Bg" ) then
			_priv.colorTable.Bg.r = r;
			_priv.colorTable.Bg.g = g;
			_priv.colorTable.Bg.b = b;
		elseif ( colorType == "Item" ) then
			_priv.colorTable.Item.r = r;
			_priv.colorTable.Item.g = g;
			_priv.colorTable.Item.b = b;
			
			if ( not _priv.nameColorByQuality ) then
				self.ItemName:SetVertexColor(r, g, b, a);
			else
				self.ItemName:SetAlpha(a);
			end
		elseif ( colorType == "Winner" ) then
			_priv.colorTable.Winner.r = r;
			_priv.colorTable.Winner.g = g;
			_priv.colorTable.Winner.b = b;
			
			self.Winner:SetAlpha(a);
			self.animWinner.anim2:SetChange(a);
			
			if ( not _priv.winnerColorByClass ) then
				self.Winner:SetVertexColor(r, g, b);
			end
		elseif ( colorType == "Uncommon" ) then
			_priv.colorTable[2].r = r;
			_priv.colorTable[2].g = g;
			_priv.colorTable[2].b = b;
		elseif ( colorType == "Rare" ) then
			_priv.colorTable[3].r = r;
			_priv.colorTable[3].g = g;
			_priv.colorTable[3].b = b;
		elseif ( colorType == "Epic" ) then
			_priv.colorTable[4].r = r;
			_priv.colorTable[4].g = g;
			_priv.colorTable[4].b = b;
		end
		if ( self.quality ) then
			self:SetQuality(self.quality);
		end
	
	elseif ( option == "ShowTTIconOnly" ) then
		_priv.ttOnBGHover = ...;
	
	elseif ( option == "Comparison" ) then
		_priv.ttShowComparison = ...;
	
	elseif ( option == "NameShow" ) then
		if ( ... ) then
			self.ItemName:Show();
		else
			self.ItemName:Hide();
		end
	
	elseif ( option == "NameColorByQuality" ) then
		_priv.nameColorByQuality = ...;
		if ( ... ) then
			if ( self.quality ) then
				self:SetQuality(self.quality);
			end
		else
			self.ItemName:SetVertexColor(_priv.colorTable.Item.r
										, _priv.colorTable.Item.g
										, _priv.colorTable.Item.b);
		end
	
	elseif ( option == "NameFontSize" ) then
		local size = ...;
		
		local font, _, flags = self.ItemName:GetFont();
		self.ItemName:SetFont(font, size, flags);
	
	elseif ( option == "NameJustifyH" ) then
		self.ItemName:SetJustifyH(...);
	
	elseif ( option == "NameJustifyV" ) then
		self.ItemName:SetJustifyV(...);
	
	elseif ( option == "NameOffsetX" ) then
		_priv.itemNameOffsetX = ...;
		self.ItemName:ClearAllPoints();
		self.ItemName:SetPoint("TOPLEFT", self, "TOPLEFT", _priv.itemNameOffsetX, _priv.itemNameOffsetY);
		self.ItemName:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", _priv.itemNameOffsetX, _priv.itemNameOffsetY);
	
	elseif ( option == "NameOffsetY" ) then
		_priv.itemNameOffsetY = ...;
		self.ItemName:ClearAllPoints();
		self.ItemName:SetPoint("TOPLEFT", self, "TOPLEFT", _priv.itemNameOffsetX, _priv.itemNameOffsetY);
		self.ItemName:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", _priv.itemNameOffsetX, _priv.itemNameOffsetY);
	
	elseif ( option == "ShowWhoColorize" ) then
		self.Need.showWhoColorize       = ...;
		self.Greed.showWhoColorize      = ...;
		self.Pass.showWhoColorize       = ...;
		self.Disenchant.showWhoColorize = ...;
	
	elseif ( option == "WinnerShow" ) then
		local show = ...;
		
		_priv.showWinner = show;
		if ( _priv.winner and show ) then
			self:ShowWinner(_priv.winner);
		else
			self.Winner:Hide();
		end
	
	elseif ( option == "WinnerNameColorByClass" ) then
		_priv.winnerColorByClass = ...;
		
		if ( _priv.winner ) then
			if ( _priv.winnerColorByClass ) then
				local r, g, b = _priv.colorTable.Winner.r, _priv.colorTable.Winner.g, _priv.colorTable.Winner.b;
				local _, class = UnitClass(_priv.winner);
				if ( class ) then
					r = RAID_CLASS_COLORS[class].r;
					g = RAID_CLASS_COLORS[class].g;
					b = RAID_CLASS_COLORS[class].b;
				end
				self.Winner:SetVertexColor(r, g, b);
			else
				self.Winner:SetVertexColor(_priv.colorTable.Winner.r
											, _priv.colorTable.Winner.g
											, _priv.colorTable.Winner.b);
			end
		end
	
	elseif ( option == "WinnerNameJustifyH" ) then
		self.Winner:SetJustifyH(...);
		self.WinnerGlow:SetJustifyH(...);
	
	elseif ( option == "WinnerNameJustifyV" ) then
		self.Winner:SetJustifyV(...);
		self.WinnerGlow:SetJustifyV(...);
	
	elseif ( option == "WinnerNameOffsetX" ) then
		_priv.winnerOffsetX = ...;
		self.Winner:ClearAllPoints();
		self.Winner:SetPoint("TOPLEFT", self, "TOPLEFT", _priv.winnerOffsetX, _priv.winnerOffsetY);
		self.Winner:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", _priv.winnerOffsetX, _priv.winnerOffsetY);
	
	elseif ( option == "WinnerNameOffsetY" ) then
		_priv.winnerOffsetY = ...;
		self.Winner:ClearAllPoints();
		self.Winner:SetPoint("TOPLEFT", self, "TOPLEFT", _priv.winnerOffsetX, _priv.winnerOffsetY);
		self.Winner:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", _priv.winnerOffsetX, _priv.winnerOffsetY);
	
	elseif ( option == "WinnerNameFontSize" ) then
		local size = ...;
		local filename, _, flags = self.Winner:GetFont();
		self.Winner:SetFont(filename, size, flags);
		self.WinnerGlow:SetFont(filename, size, flags);
	
	elseif ( option == "CloseDelay" ) then
		_priv.closeDelay = ...;
	
	elseif ( option == "ShowBoP" ) then
		_priv.displayBoP = ...;
		if ( _priv.bop and _priv.displayBoP ) then
			self.BoPIndicator:Show();
		else
			self.BoPIndicator:Hide();
		end
	
	elseif ( option == "ShowILvl" ) then
		_priv.displayILvl = ...;
		if ( _priv.displayILvl ) then
			self.LvlIndicator:Show();
		else
			self.LvlIndicator:Hide();
		end
		
	end
end
	
local function constructor(name, parent)

	assert( type(name) == "string"
		, WIDGET .. " constructor: Bad argument #1 (string expected, got " .. type(name) .. ")");
	assert( (type(parent) == "string") 
		or ( type(parent) == "table" 
			and type(parent.IsObjectType) == "function" 
			and parent:IsObjectType("Frame") )
		, WIDGET .. " constructor: Bad argument #2 (string or Frame expected, got " .. type(parent) .. ")");
	
	local _priv = {};

	_priv.disappearing = false;
	_priv.disappearingTimer = 0;
	_priv.selection = nil;
	_priv.itemNameOffsetX = 0;
	_priv.itemNameOffsetY = 0;
	
	_priv.nameColorByQuality = true;
	
	_priv.iconScale = 1;
	_priv.buttonsScale = 1;
	
	_priv.borderSize = 4;
	_priv.borderTexture = nil;
	_priv.borderColorByQuality = false;
	
	_priv.bop = false;
	_priv.displayBoP = false;
	
	_priv.interactions = {
		[1] = true,
		[2] = true,
		[3] = true,
	};
	
	_priv.showWinner = true;
	_priv.winnerColor = { r = 1, g = 1, b = 1 };
	_priv.winnerOffsetX = 0;
	_priv.winnerOffsetY = 0;
	
	_priv.closeDelay = 0;
	
	_priv.timedOut = false;
	
	_priv.elapsed = 0;
	
	_priv.colorTable = {
		['Border'] = { r = 1, g = 1, b = 1, a = 1 },
		['Bg'] = { r = 1, g = 1, b = 1 },
		['Winner'] = { r = 1, g = 1, b = 1 },
		['Item'] = { r = 1, g = 1, b = 1 },
		[2] = { r = 1, g = 1, b = 1 }, -- Uncommon
		[3] = { r = 1, g = 1, b = 1 }, -- Rare
		[4] = { r = 1, g = 1, b = 1 }, -- Epic
	};
	
	local LootFrame = CreateFrame("Frame", name, parent);

	_priv.iconOnClickCB = function(self, button) 
		SetItemRef(LootFrame.itemLink, LootFrame.itemLink, button);
	end
	
	-- WIDGETS
	
	LootFrame.LayerBar = CreateFrame("Frame", nil, LootFrame);
	LootFrame.LayerBar:SetFrameLevel(LootFrame.LayerBar:GetFrameLevel()+5);
	LootFrame.LayerSpark = CreateFrame("Frame", nil, LootFrame.LayerBar);
	LootFrame.LayerSpark:SetFrameLevel(LootFrame.LayerSpark:GetFrameLevel()+5);
	LootFrame.LayerBorder = CreateFrame("Frame", nil, LootFrame.LayerSpark);
	LootFrame.LayerBorder:SetFrameLevel(LootFrame.LayerBorder:GetFrameLevel()+5);
	LootFrame.LayerButtons = CreateFrame("Frame", nil, LootFrame.LayerBorder);
	LootFrame.LayerButtons:SetFrameLevel(LootFrame.LayerButtons:GetFrameLevel()+5);
	LootFrame.LayerStrings = CreateFrame("Frame", nil, LootFrame.LayerButtons);
	LootFrame.LayerStrings:SetFrameLevel(LootFrame.LayerStrings:GetFrameLevel()+5);
	
	LootFrame.LayerBar:SetAllPoints(LootFrame);
	LootFrame.LayerSpark:SetAllPoints(LootFrame);
	LootFrame.LayerBorder:SetAllPoints(LootFrame);
	LootFrame.LayerButtons:SetAllPoints(LootFrame);
	LootFrame.LayerStrings:SetAllPoints(LootFrame);
	
	LootFrame.Icon = CreateFrame("Button", name .. "Icon", LootFrame.LayerButtons);
	LootFrame.Icon:SetPoint("LEFT", LootFrame);
	
	LootFrame.BoPIndicator = CreateFrame("Frame", name .. "BoP", LootFrame.Icon);
	LootFrame.BoPIndicator:SetPoint("BOTTOMRIGHT", -1, 1);
	LootFrame.BoPIndicator.tex = LootFrame.BoPIndicator:CreateTexture(name .. "BoPTexture", "OVERLAY");
	LootFrame.BoPIndicator.tex:SetTexture("Interface\\AddOns\\" .. ADDON_NAME .. "\\textures\\bop");
	LootFrame.BoPIndicator.tex:SetAllPoints();
	
	LootFrame.LvlIndicator = CreateFrame("Frame", name .. "Lvl", LootFrame.Icon);
	LootFrame.LvlIndicator:SetPoint("BOTTOMLEFT", 1, 1);
	LootFrame.LvlIndicator.tex = LootFrame.LvlIndicator:CreateTexture(name .. "ilvlTexture", "OVERLAY");
	LootFrame.LvlIndicator.tex:SetTexture("Interface\\AddOns\\" .. ADDON_NAME .. "\\textures\\up");
	LootFrame.LvlIndicator.tex:SetAllPoints();
	
	LootFrame.Need = hf_Widgets.LootButton(name .. "Need", LootFrame.LayerButtons, "need", 1, 1);
	LootFrame.Need:SetPoint("LEFT", LootFrame.Icon, "RIGHT", 4, -1);
	LootFrame.Need.lootFrame = LootFrame;
	
	LootFrame.Greed = hf_Widgets.LootButton(name .. "Greed", LootFrame.LayerButtons, "greed", 1, 3);
	LootFrame.Greed:SetPoint("LEFT", LootFrame.Need, "RIGHT", 4, -2);
	LootFrame.Greed.lootFrame = LootFrame;
	
	LootFrame.Disenchant = hf_Widgets.LootButton(name .. "Disenchant", LootFrame.LayerButtons, "disenchant", 1, 1);
	LootFrame.Disenchant:SetPoint("LEFT", LootFrame.Greed, "RIGHT", 4, 2);
	LootFrame.Disenchant.lootFrame = LootFrame;
	
	LootFrame.Pass = hf_Widgets.LootButton(name .. "Pass", LootFrame.LayerButtons, "pass", 1, -1);
	LootFrame.Pass:SetPoint("LEFT", LootFrame.Disenchant, "RIGHT", 4, 2);
	LootFrame.Pass.lootFrame = LootFrame;
	
	LootFrame.TimerWrapper = CreateFrame("Frame", nil, LootFrame.LayerStrings);
	LootFrame.TimerWrapper:SetPoint("RIGHT", LootFrame, "RIGHT", -5, 0);
	LootFrame.TimerWrapper:SetHeight(20);
	LootFrame.TimerWrapper:SetWidth(30);
	LootFrame.TimerWrapper:EnableMouse(true);
	LootFrame.Timer = LootFrame.TimerWrapper:CreateFontString(name .. "Timer", "ARTWORK", "GameFontNormal");
	LootFrame.Timer:SetWordWrap(false);
	LootFrame.Timer:SetPoint("TOPRIGHT");
	LootFrame.Timer:SetPoint("BOTTOMRIGHT");
	LootFrame.Timer:SetJustifyH("RIGHT");
	
	LootFrame.Bar = CreateFrame("StatusBar", nil, LootFrame.LayerBar);
	LootFrame.Bar:SetPoint("RIGHT", LootFrame);
	LootFrame.Bar:SetPoint("BOTTOM", LootFrame);
	LootFrame.Bar:SetPoint("TOP", LootFrame);
	LootFrame.Bar:SetPoint("LEFT", LootFrame.Icon, "RIGHT");
	LootFrame.Bar:SetMinMaxValues(0, 1);
	LootFrame.Bar:SetValue(0);
	LootFrame.Bar:EnableMouse(true);
	LootFrame.StaticBg = LootFrame:CreateTexture(name .. "Background", "BACKGROUND");
	LootFrame.StaticBg:SetVertexColor(.5, .5, .5);
	LootFrame.StaticBg:SetPoint("TOPRIGHT");
	LootFrame.StaticBg:SetPoint("BOTTOMLEFT", LootFrame.Bar, "BOTTOMLEFT");
	LootFrame.StaticBg:SetTexture(DEFAULT_TEXTURE);
	LootFrame.StaticBg:SetHorizTile(false);
	LootFrame.Bar.sparkHolder = CreateFrame("Frame", name .. "SparkHolder", LootFrame.LayerSpark);
	LootFrame.Bar.sparkHolder:SetPoint("BOTTOMLEFT", LootFrame.Icon, "BOTTOMRIGHT");
	LootFrame.Bar.sparkHolder:SetPoint("TOPLEFT", LootFrame.Icon, "TOPRIGHT");
	LootFrame.Bar.sparkHolder:SetWidth(0);
	LootFrame.Bar.spark = LootFrame.Bar.sparkHolder:CreateTexture(name .. "Spark", "BORDER");
	LootFrame.Bar.spark:SetPoint("CENTER", LootFrame.Bar.sparkHolder, "RIGHT");
	LootFrame.Bar.spark:SetTexture("Interface\\CastingBar\\UI-CastingBar-Spark");
	LootFrame.Bar.spark:SetBlendMode("ADD");
	
	LootFrame.BarGlow = CreateFrame("Frame", nil, LootFrame);
	LootFrame.BarGlow:SetPoint("CENTER", LootFrame.Bar);
	LootFrame.BarGlow.glow = LootFrame.BarGlow:CreateTexture(name .. "BarGlow", "BORDER");
	LootFrame.BarGlow.glow:SetTexture(DEFAULT_TEXTURE);
	LootFrame.BarGlow.glow:SetAllPoints(LootFrame.Bar);
	LootFrame.BarGlow:SetAlpha(0);
	
	LootFrame.Border = CreateFrame("Frame", name .. "Border", LootFrame.LayerBorder);
	LootFrame.Border:SetPoint("TOPLEFT", LootFrame.Bar);
	LootFrame.Border:SetPoint("BOTTOMRIGHT", LootFrame.Bar);
	
	local ffilename, fsize, fflags;
	
	LootFrame.ItemName = LootFrame.LayerStrings:CreateFontString(name .. "Name", "OVERLAY", "GameFontNormal");
	LootFrame.ItemName:SetWordWrap(false);
	ffilename, fsize, fflags = LootFrame.ItemName:GetFont();
	LootFrame.ItemName:SetFont(ffilename, fsize, "OUTLINE", fflags);
	LootFrame.ItemName:SetHeight(20);
	LootFrame.ItemName:SetPoint("BOTTOMLEFT", LootFrame, "TOPLEFT");
	LootFrame.ItemName:SetPoint("BOTTOMRIGHT", LootFrame, "TOPRIGHT");
	LootFrame.ItemName:SetJustifyH("RIGHT");
	LootFrame.ItemName:SetJustifyV("BOTTOM");
	
	LootFrame.Winner = LootFrame.LayerStrings:CreateFontString(name .. "Winner", "OVERLAY", "GameFontNormal");
	LootFrame.Winner:SetWordWrap(false);
	LootFrame.Winner:SetFont(ffilename, fsize, "OUTLINE", fflags);
	LootFrame.Winner:SetHeight(20);
	LootFrame.Winner:SetPoint("TOPLEFT", LootFrame);
	LootFrame.Winner:SetPoint("BOTTOMRIGHT", LootFrame);
	LootFrame.Winner:SetJustifyH("LEFT");
	LootFrame.Winner:SetJustifyV("MIDDLE");
	
	LootFrame.WinnerGlow = LootFrame.LayerStrings:CreateFontString(name .. "WinnerGlow", "OVERLAY", "GameFontNormal");
	LootFrame.WinnerGlow:SetWordWrap(false);
	LootFrame.WinnerGlow:SetFont(ffilename, fsize, "OUTLINE", fflags);
	LootFrame.WinnerGlow:SetTextColor(1, 1, 1);
	LootFrame.WinnerGlow:SetHeight(20);
	LootFrame.WinnerGlow:SetAllPoints(LootFrame.Winner);
	LootFrame.WinnerGlow:SetJustifyH("LEFT");
	LootFrame.WinnerGlow:SetJustifyV("MIDDLE");
	LootFrame.WinnerGlow:SetAlpha(0);
	
	-- ANIMATIONS
	
	-- winner name animation
	LootFrame.animWinner = LootFrame.Winner:CreateAnimationGroup(name .. "WinnerAnim");
	LootFrame.animWinner.anim1 = LootFrame.animWinner:CreateAnimation("Alpha");
	setAlphaAnim(LootFrame.animWinner.anim1, 1, -1, 0);
	LootFrame.animWinner.anim2 = LootFrame.animWinner:CreateAnimation("Alpha");
	setAlphaAnim(LootFrame.animWinner.anim2, 2, 1, 0.5);
	
	-- glow animation
	LootFrame.animGlow1 = LootFrame.WinnerGlow:CreateAnimationGroup(name .. "GlowAnim1");
	LootFrame.animGlow1.anim1 = LootFrame.animGlow1:CreateAnimation("Alpha");
	setAlphaAnim(LootFrame.animGlow1.anim1, 1, 1, 0.3);
	LootFrame.animGlow1.anim2 = LootFrame.animGlow1:CreateAnimation("Alpha");
	setAlphaAnim(LootFrame.animGlow1.anim2, 2, -1, 1);
	
	LootFrame.animGlow2 = LootFrame.BarGlow:CreateAnimationGroup(name .. "GlowAnim2");
	LootFrame.animGlow2.anim1 = LootFrame.animGlow2:CreateAnimation("Alpha");
	setAlphaAnim(LootFrame.animGlow2.anim1, 1, 1, 0.3);
	LootFrame.animGlow2.anim2 = LootFrame.animGlow2:CreateAnimation("Alpha");
	setAlphaAnim(LootFrame.animGlow2.anim2, 2, -1, 1);
	
	
	-- SCRIPT HANDLERS
	
	LootFrame:SetScript("OnSizeChanged", function(self, width, height)
		self:UpdateSizes(width, height);
	end);
	
	LootFrame.Icon:SetScript("OnEnter", function(self)
		LootFrame:ShowTooltip();
	end);
	
	LootFrame.Icon:SetScript("OnLeave", function(self) 
		GameTooltip:Hide(); 
	end);
	
	LootFrame.Icon:SetScript("OnClick", _priv.iconOnClickCB);
	
	LootFrame.Need.onClick = function(self, button)
		if ( button == "LeftButton" ) then
			_priv.selection = "need";
		end
	end
	
	LootFrame.Greed.onClick = function(self, button)
		if ( button == "LeftButton" ) then
			_priv.selection = "greed";
		end
	end
	
	LootFrame.Disenchant.onClick = function(self, button)
		if ( button == "LeftButton" ) then
			_priv.selection = "disenchant";
		end
	end
	
	LootFrame.Pass.onClick = function(self, button)
		if ( button == "LeftButton" ) then
			_priv.selection = "pass";
		end
	end
	
	LootFrame.TimerWrapper:SetScript("OnEnter", function(self)
		if ( not _priv.timerStopped and LootFrame.timeLeft and (LootFrame.timeLeft > 0) ) then
			local secondsLeft = LootFrame.timeLeft;
			local minutesLeft;
			local secondsStr, minutesStr = "", "";
			if ( secondsLeft == nil ) then
				return;
			end
			if ( secondsLeft > 59 ) then
				minutesLeft = math.floor(secondsLeft / 60);
				secondsLeft = secondsLeft % 60;
				minutesStr = minutesLeft .. "m ";
			end
			secondsStr = math.floor(secondsLeft+0.5) .. "s";
			GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
			GameTooltip:AddLine(minutesStr .. secondsStr);
			GameTooltip:Show();
		end
	end);
	
	LootFrame.TimerWrapper:SetScript("OnLeave", function(self) 
		GameTooltip:Hide(); 
	end);
	
	LootFrame.TimerWrapper:SetScript("OnMouseUp", function(self, button) 
		if ( LootFrame.onClick ) then
			LootFrame:onClick(button);
		end
	end);
	
	LootFrame:SetScript("OnUpdate", function(self, elapsed)
		_priv.elapsed = _priv.elapsed + elapsed;
		if ( _priv.elapsed > UPDATE_INTERVAL ) then
		
			-- handling initial lock (preventing occasional selection making)
			if ( _priv.initLockTimer ~= nil ) then
				if ( _priv.initLockTimer > 0 ) then
					_priv.initLockTimer = _priv.initLockTimer - _priv.elapsed;
				else
					_priv.initLockTimer = nil;
					self:EnableInteraction(4);
				end
			end
		
			-- handling appearing/disappearing animation
			if ( _priv.appearing ) then
				local alpha = self:GetAlpha();
				
				if ( alpha + ALPHA_SPEED >= 1 ) then
					self:SetAlpha(1);
					_priv.appearing = false;
				else
					self:SetAlpha(alpha + ALPHA_SPEED);
				end
			elseif ( _priv.disappearing ) then
				local alpha = self:GetAlpha();
				
				if ( alpha - ALPHA_SPEED <= 0 ) then
					self:SetAlpha(0);
					_priv.disappearing = false;
					self:Disable();
				else
					self:SetAlpha(alpha - ALPHA_SPEED);
				end
			end
		
			-- timer handling
			if ( self.timeLeft ~= nil ) then
				self.timeLeft = self.timeLeft - _priv.elapsed;
				
				if ( self.timeLeft >= 0 and (not _priv.timerStopped) ) then
					if ( _priv.barTimer ) then
						self.Bar:SetValue(self.timeLeft);
					
						-- fix statusbar texture stretch
						self.Bar:GetStatusBarTexture():SetTexCoord(0, math.min(self.timeLeft/select(2, self.Bar:GetMinMaxValues()), 1), 0, 1);
					else
						self.Bar:SetValue(0);
					end
					self:UpdateSparkPosition();
					self.Timer:SetText(formatTime(self.timeLeft));
				elseif ( not _priv.timedOut ) then
					
					-- checking, if timers didn't desynchronize
					--[[
					local actualTimeLeft = GetLootRollTimeLeft(self.rollID);
					if ( actualTimeLeft > 0.01 ) then
						self.timeLeft = actualTimeLeft / 1000;
						
						-- if roll still continue - timer shouldn't be stopped
						_priv.timerStopped = false;
					else
					]]
					if ( self:GetSelection() ) then
						self.busy = false;
						self.Timer:SetText();
						
						if ( self.onTimeOut ) then
							self:onTimeOut();
						end
						
						_priv.timedOut = true;
					end
				end
				
				if ( _priv.timedOut and (_priv.closeDelay ~= -1)
					and (self.timeLeft + _priv.closeDelay < 0) ) then
					self.Bar.spark:Hide();
					self:Disappear();
				end
			end
			
			_priv.elapsed = 0;
		end
	end);
	
	LootFrame.Bar:SetScript("OnSizeChanged", function(self, width, height)
		LootFrame:UpdateSizes();
	end);
	
	LootFrame.Bar:SetScript("OnEnter", function(self)
		if ( _priv.ttOnBGHover ) then
			LootFrame:ShowTooltip(true);
		end
	end);
	
	LootFrame.Bar:SetScript("OnLeave", function(self)
		GameTooltip:Hide();
	end);
	
	LootFrame.Bar:SetScript("OnMouseUp", function(self, button)
		if ( LootFrame.onClick ) then
			LootFrame:onClick(button);
		end
	end);
	
	LootFrame.busy = false;

	_priv.strings = {
		['font'] = {
			LootFrame.Need.counter,
			LootFrame.Greed.counter,
			LootFrame.Disenchant.counter,
			LootFrame.Pass.counter,
			LootFrame.Timer,
			LootFrame.ItemName,
			LootFrame.Winner,
			LootFrame.WinnerGlow,
		},
		['size'] = {
			LootFrame.Need.counter,
			LootFrame.Greed.counter,
			LootFrame.Disenchant.counter,
			LootFrame.Pass.counter,
			LootFrame.Timer,
		},
	};
	
	-- registering methods
	for methodName, method in pairs(methods) do
		LootFrame[methodName] = function(self, ...)
			return method(self, _priv, ...);
		end
	end
	
	return LootFrame;
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
