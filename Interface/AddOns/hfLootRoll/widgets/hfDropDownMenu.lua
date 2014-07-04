--[[

	hfDropDownMenu - World of Warcraft addon that provides dropdown 
	menu with textures under buttons and customizable fonts

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
	Creates dropdown menu for texture or font selection, available methods:
	
	hf_Widgets.DropDown(name, parent)
		creates new DropDownMenu
		
		name: dropdown frame name (string)
		parent: dropdown frame parent (string or table)
		
		returns created dropdown (table)
	
	dropdown:AddButton(texture, font, name)
		adds button to menu with given texture
		
		texture: path to texture (string)
		name: text that will be displayed in dropdown list (string)
	
	dropdown:ClearButtons()
		removes all buttons from dropdown
	
	dropdown:Toggle()
		toggles menu
		
	dropdown:GetSelectedFont()
		returns path to selected font (string)
		
	dropdown:GetSelectedTexture()
		returns path to selected texture (string)
		
	dropdown:SetSelection(buttonInfo)
		sets current selected value by given buton info table
		
		buttonInfo: table with 'texture' and 'name' fields (table)
		
	dropdown:SetSelectionByID(id)
		sets current selected value by given button id
		
		id: button id (number)
		
		returns if font set successfully - true (boolean)
				else - nil (nil)
		
	dropdown:SetSelectionByFont(font)
		sets current selected value by given font
		
		font: path to font (string)
		
		returns if font set successfully - true (boolean)
				else - nil (nil)
		
	dropdown:SetSelectionByTexture(texture)
		sets current selected value by given texture
		
		texture: path to texture (string)
		
		returns if texture set successfully - true (boolean)
				else - nil (nil)
		
	dropdown:SetWidth(width)
		analogue of UIDropDownMenu_SetWidth
		
		width: new dropdown menu width (number)
	
	dropdown:SetButtonWidth(width)
		analogue of UIDropDownMenu_SetButtonWidth
		
		width: new dropdown button width (number)
	
]]

local WIDGET = "DropDown";

--@non-debug@
local REV = 42;
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

local MAX_ROWS = 10;
local ROW_HEIGHT = 15;
local LIST_WIDTH = 95;
local SHOW_TIME = 2;

local dropdownlist;

local methods = {};
	
methods.Toggle = function(self, _priv)
	if ( dropdownlist.opened ) then
		if ( dropdownlist.opened == self ) then
			dropdownlist:close();
		else
			dropdownlist:close();
			dropdownlist:setData(_priv.buttons);
			dropdownlist:open(self);
		end
	else
		dropdownlist:setData(_priv.buttons);
		dropdownlist:open(self);
	end
end

methods.AddButton = function(self, _priv, texture, font, name, value)
	assert( (type(texture) == "string") or (texture == nil)
		, WIDGET .. ":AddButton() Bad argument #1 (string expected, got " .. type(texture) .. ")");
	assert( (type(font) == "string") or (font == nil)
		, WIDGET .. ":AddButton() Bad argument #2 (string expected, got " .. type(font) .. ")");
	assert( type(name) == "string"
		, WIDGET .. ":AddButton() Bad argument #3 (string expected, got " .. type(name) .. ")");
	
	tinsert(_priv.buttons, {
		texture = texture, 
		font = font, 
		text = name, 
		value = (value ~= nil) and value or #_priv.buttons + 1,
	});
end

methods.ClearButtons = function(self, _priv)
	wipe(_priv.buttons);
end

methods.GetSelectedTexture = function(self, _priv)
	return _priv.selectedTexturePath;
end

methods.GetSelectedFont = function(self, _priv)
	return _priv.selectedFontPath;
end

methods.SetSelection = function(self, _priv, button)
	local newTexture;
	if ( button.texture == "none" ) then
		newTexture = nil;
	else
		newTexture = button.texture;
	end
	self.selectedTexture:SetTexture(newTexture);
	_priv.selectedTexturePath = button.texture
	if ( button.font ) then
		local _, size, flags = self.text:GetFont();
		self.text:SetFont(button.font, size, flags);
		_priv.selectedFontPath = button.font;
	end
	self.text:SetText(button.text);
	
	if ( self.setFunc ) then
		self.setFunc(self, button.texture, button.font, button.value);
	end
end

methods.SetSelectionByID = function(self, _priv, id)
	assert( type(id) == "number"
		, WIDGET .. ":SetSelectionByID() Bad argument #1 (string expected, got " .. type(id) .. ")");
	
	local selectedButton = _priv.buttons[id];
	
	if ( not selectedButton ) then
		return nil;
	else
		self:SetSelection(selectedButton);
		return true;
	end
end

methods.SetSelectionByFont = function(self, _priv, font)
	assert( type(font) == "string"
		, WIDGET .. ":SetSelectionByFont() Bad argument #1 (string expected, got " .. type(font) .. ")");
	
	local selectedButton;
	for _, button in ipairs(_priv.buttons) do
		if ( button.font == font ) then
			selectedButton = button;
		end
	end
	
	if ( not selectedButton ) then
		return nil;
	else
		self:SetSelection(selectedButton);
		return true;
	end
end

methods.SetSelectionByTexture = function(self, _priv, texture)
	assert( (texture == nil) or (type(texture) == "string")
		, WIDGET .. ":SetSelectionByTexture() Bad argument #1 (string expected, got " .. type(texture) .. ")");
	
	local selectedButton;
	for _, button in ipairs(_priv.buttons) do
		if ( button.texture == texture ) then
			selectedButton = button;
		end
	end
	
	if ( not selectedButton ) then
		return nil;
	else
		self:SetSelection(selectedButton);
		return true;
	end
end

methods.SetSelectionByValue = function(self, _priv, value)	
	local selectedButton;
	for _, button in ipairs(_priv.buttons) do
		if ( button.value == value ) then
			selectedButton = button;
		end
	end
	
	if ( not selectedButton ) then
		return nil;
	else
		self:SetSelection(selectedButton);
		return true;
	end
end

methods.SetWidth = function(self, _priv, width)
	_priv.dropdownmiddletex:SetWidth(width);
	self:originalSetWidth(width + 50);
	self.text:SetWidth(width - 25);
end

methods.SetButtonWidth = function(self, _priv, width)
	_priv.dropdownbutton:SetWidth(width);
end

local function setData(self, dataTable)
	self.data = dataTable;
	self.list:SetData(self.data);
end

local function update(self)
	local visibleRowsNum = math.min(#self.data, MAX_ROWS);
	self:SetHeight(visibleRowsNum*(ROW_HEIGHT)+23);
end

local function open(self, dropdown)
	local uiScale;
	local uiParentScale = UIParent:GetScale();
	if ( GetCVar("useUIScale") == "1" ) then
		uiScale = tonumber(GetCVar("uiscale"));
		if ( uiParentScale < uiScale ) then
			uiScale = uiParentScale;
		end
	else
		uiScale = uiParentScale;
	end
	self:SetScale(uiScale);
	
	local buttonWidth = dropdown:GetWidth();
	self:SetWidth(buttonWidth - 30)
	
	self.opened = dropdown;
	self:Show();
	self:update();
	self.showTimer = SHOW_TIME;
	if ( self:IsMouseOver() ) then
		self.showTimer = nil;
	end
	self:SetPoint("TOPLEFT", dropdown, "BOTTOMLEFT", 10, 3);
end

local function close(self)
	self.opened = nil;
	self:Hide();
end

local function toggle(self)
	if ( self:IsVisible() ) then
		self:close();
	else
		self:open();
	end
end

local function stopShowTimer()
	dropdownlist.showTimer = nil;
end

local function startShowTimer()
	dropdownlist.showTimer = SHOW_TIME;
end

local function initDropDownList()
	if ( dropdownlist ) then
		return;
	end

	dropdownlist = CreateFrame("Frame", "TexturesDropDownList", parent);
	dropdownlist.list = hf_Widgets.ScrollableList("TexturesDropDownListScrollFrame", dropdownlist, false);
	dropdownlist.list.setFunc = function(self, value)
		dropdownlist.opened:SetSelectionByValue(value);
		dropdownlist:close();
	end
	dropdownlist.list:SetPoint("TOPLEFT", 7, -7);
	dropdownlist.list:SetPoint("BOTTOMRIGHT", -7, 5);
	dropdownlist.list:SetRowHeight(ROW_HEIGHT);
	dropdownlist.list.commonOnEnter = stopShowTimer;
	dropdownlist.list.commonOnLeave = startShowTimer;
	dropdownlist:SetWidth(LIST_WIDTH);
	dropdownlist:SetFrameStrata("TOOLTIP");
	dropdownlist:EnableMouse(true);
	dropdownlist:EnableMouseWheel(true);

	dropdownlist.setData = setData;
	dropdownlist.update  = update;
	dropdownlist.open    = open;
	dropdownlist.close   = close;
	dropdownlist.toggle  = toggle;
	
	local backdrop = CreateFrame("Frame", "TexturesDropDownListBackdrop", dropdownlist);
	backdrop:SetAllPoints(); 
	backdrop:SetBackdrop({ 
		bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background-Dark", 
		edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border", 
		tile = true, 
		tileSize = 32, 
		edgeSize = 32, 
		insets = { 
			left = 11, 
			right = 12, 
			top = 12, 
			bottom = 9, 
		},
	});
	
	dropdownlist:SetScript("OnUpdate", function(self, elapsed)
		if ( not self.showTimer ) then
			return;
		end
		self.showTimer = self.showTimer - elapsed;
		if ( self.showTimer < 0 ) then
			self:Hide();
			self.showTimer = nil;
		end
	end);
	
	dropdownlist:SetScript("OnHide", function(self, elapsed)
		self.opened = nil;
	end);
end

local function constructor(name, parent)	
	assert( type(name) == "string"
		, WIDGET .. " constructor: Bad argument #1 (string expected, got " .. type(name) .. ")");
	assert( (type(parent) == "string") 
		or ( type(parent) == "table" 
			and type(parent.IsObjectType) == "function" 
			and parent:IsObjectType("Frame") )
		, WIDGET .. " constructor: Bad argument #2 (string or Frame expected, got " .. type(parent) .. ")");
	
	initDropDownList();
	
	local dropdown = CreateFrame("Frame", name, parent);
	
	local _priv = {};
	
	dropdown:SetSize(40, 32);
	
	_priv.dropdownlefttex = dropdown:CreateTexture(name .. "Left", "BACKGROUND");
	_priv.dropdownlefttex:SetTexture("Interface\\Glues\\CharacterCreate\\CharacterCreate-LabelFrame");
	_priv.dropdownlefttex:SetSize(25, 64);
	_priv.dropdownlefttex:SetPoint("TOPLEFT", 0, 17);
	_priv.dropdownlefttex:SetTexCoord(0, 0.1953125, 0, 1);
	
	_priv.dropdownmiddletex = dropdown:CreateTexture(name .. "Middle", "BACKGROUND");
	_priv.dropdownmiddletex:SetTexture("Interface\\Glues\\CharacterCreate\\CharacterCreate-LabelFrame");
	_priv.dropdownmiddletex:SetSize(115, 64);
	_priv.dropdownmiddletex:SetPoint("LEFT", _priv.dropdownlefttex, "RIGHT");
	_priv.dropdownmiddletex:SetTexCoord(0.1953125, 0.8046875, 0, 1);
	
	_priv.dropdownrighttex = dropdown:CreateTexture(name .. "Right", "BACKGROUND");
	_priv.dropdownrighttex:SetTexture("Interface\\Glues\\CharacterCreate\\CharacterCreate-LabelFrame");
	_priv.dropdownrighttex:SetSize(25, 64);
	_priv.dropdownrighttex:SetPoint("LEFT", _priv.dropdownmiddletex, "RIGHT");
	_priv.dropdownrighttex:SetTexCoord(0.8046875, 1, 0, 1);
	
	dropdown.text = dropdown:CreateFontString(name .. "Text", "OVERLAY", "GameFontHighlightSmall");
	dropdown.text:SetSize(0, 10);
	dropdown.text:SetJustifyH("LEFT");
	dropdown.text:SetJustifyV("MIDDLE");
	dropdown.text:SetPoint("LEFT", dropdown, "LEFT", 28, 1);
	
	_priv.dropdownbutton = CreateFrame("Button", name .. "Button", dropdown);
	_priv.dropdownbutton:SetSize(24, 24);
	_priv.dropdownbutton:SetPoint("TOPRIGHT", _priv.dropdownrighttex, "TOPRIGHT", -16, -18);
	_priv.dropdownbutton:SetScript("OnClick", function(self)
		self:GetParent():Toggle();
		PlaySound("igMainMenuOptionCheckBoxOn");
	end);
	_priv.dropdownbutton:SetNormalTexture("Interface\\ChatFrame\\UI-ChatIcon-ScrollDown-Up");
	_priv.dropdownbutton:SetPushedTexture("Interface\\ChatFrame\\UI-ChatIcon-ScrollDown-Down");
	_priv.dropdownbutton:SetDisabledTexture("Interface\\ChatFrame\\UI-ChatIcon-ScrollDown-Disabled");
	_priv.dropdownbutton:SetHighlightTexture("Interface\\Buttons\\UI-Common-MouseHilight", "ADD");
	
	_priv.dropdownbuttonnormaltex = _priv.dropdownbutton:GetNormalTexture();
	_priv.dropdownbuttonnormaltex:ClearAllPoints();
	_priv.dropdownbuttonnormaltex:SetSize(24, 24);
	_priv.dropdownbuttonnormaltex:SetPoint("RIGHT");
	
	_priv.dropdownbuttonpushtex = _priv.dropdownbutton:GetPushedTexture();
	_priv.dropdownbuttonpushtex:ClearAllPoints();
	_priv.dropdownbuttonpushtex:SetSize(24, 24);
	_priv.dropdownbuttonpushtex:SetPoint("RIGHT");
	
	_priv.dropdownbuttondistex = _priv.dropdownbutton:GetDisabledTexture();
	_priv.dropdownbuttondistex:ClearAllPoints();
	_priv.dropdownbuttondistex:SetSize(24, 24);
	_priv.dropdownbuttondistex:SetPoint("RIGHT");
	
	_priv.dropdownbuttonhltex = _priv.dropdownbutton:GetHighlightTexture();
	_priv.dropdownbuttonhltex:ClearAllPoints();
	_priv.dropdownbuttonhltex:SetSize(24, 24);
	_priv.dropdownbuttonhltex:SetPoint("RIGHT");
	
	dropdown.selectedTexture = dropdown:CreateTexture(name .. "Texture", "ARTWORK");
	dropdown.selectedTexture:SetPoint("TOPLEFT", _priv.dropdownmiddletex, "TOPLEFT", 0, -25);
	dropdown.selectedTexture:SetPoint("BOTTOMRIGHT", _priv.dropdownmiddletex, "BOTTOMRIGHT", -14, 26);
	dropdown.selectedTexture:SetVertexColor(.5, .5, .5);
	
	_priv.buttons = {};
	
	dropdown:SetScript("OnHide", function(self)
		if ( dropdownlist.opened == self ) then
			dropdownlist:close();
		end
	end);
	
	dropdown.originalSetWidth = dropdown.SetWidth;
	
	-- registering methods
	for methodName, method in pairs(methods) do
		dropdown[methodName] = function(self, ...)
			return method(self, _priv, ...);
		end
	end
	
	return dropdown;
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