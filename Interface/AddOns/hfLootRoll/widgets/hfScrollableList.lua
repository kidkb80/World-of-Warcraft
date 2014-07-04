--[[

	hfScrollableList - World of Warcraft addon that provides opportunities 
	for creating scrollable lists

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
	Creates scrollable lists, available methods:
	
	hf_Widgets.ScrollableList(name, parent, highlightSelected[, highlightType])
		creates new scrollable list
		
		name: scrolllist frame name (string)
		parent: scrolllist frame parent (string or table)
		highlightSelected: if entries must be highlighted after selection (boolean)
		highlightType: highlight type, possible values: "OPTIONS" (string)
		
		returns created scrollable lists (table)
	
	scrolllist:SetData(dataTable)
		sets data table that determines list entries
		
		dataTable: table with list entries info in follwing format:
			{
				["value"]   = value returned when button clicked, must be unique for each entry (any type),
				["text"]    = shown text (string),
				["texture"] = path to texture that shown under text, optional (string),
				["font"]    = path to font used for text, optional (string),
			} (table)
	
	scrolllist:Update()
		should be called after data table change
	
	scrolllist:SetScroll(offset)
		sets scroll offset
		
		offset: scroll offset, a number between 0 and number of entries minus
				number of shown entries
	
	scrolllist:GetScroll()
		returns current scroll offset
	
	scrolllist:GetSelectedValue()
		returns value according to currently selected entry or nil if nothing selected
		
	scrolllist:setSelectedValue(value)
		sets selection in accordance with given value, if such entry
		doesn't exist - does nothing
		
		value: entry with this value will be selected (any type)
		
	scrolllist:ClearSelection()
		removes selection
	
	scrolllist:SetHeight(height)
		sets height of scrolllist
		
		height: new scrolllist height (number)
	
	scrolllist:SetSize(width, height)
		sets sizes of scrolllist
		
		width: new scrolllist width (number)
		height: new scrolllist height (number)
	
	scrolllist:SetRowHeight(height)
		sets height of entry
		
		height: new entry height (number)
		
	scrollist.setFunc (self, value) - function called when element selected
	
]]

local WIDGET = "ScrollableList";

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

local DEFAULT_ROW_HEIGHT = 20;
	
local function setMaxWidth(_priv, isMax)
	_priv.scrollframe:ClearAllPoints();
	if ( isMax ) then
		_priv.scrollframe:SetPoint("TOPLEFT", 5, -5);
		_priv.scrollframe:SetPoint("BOTTOMRIGHT", -5, 5);
	else
		_priv.scrollframe:SetPoint("TOPLEFT", 5, -5);
		_priv.scrollframe:SetPoint("BOTTOMRIGHT", -(7 + _G[_priv.scrollframe:GetName() .. "ScrollBar"]:GetWidth()), 5);
	end
end
		
local function rowSetText(self, text)
	self.text:SetText(text);
end

local function rowSetTexture(self, texture)
	if ( texture == nil ) then
		self.texture:Hide();
	else
		self.texture:SetTexture(texture);
		self.texture:Show();
	end
end

local function rowSetFont(self, font)
	if ( font == nil ) then
		font = GameFontWhiteSmall:GetFont();
	end
	local _, size, flags = self.text:GetFont();
	self.text:SetFont(font, size, flags);
end

local function rowSetValue(self, value)
	self.value = value;
end

local function rowSetHeight(self, height)
	self:SetHeight(height);
end

local function rowSetDataID(self, id)
	self.dataID = id;
end

local function rowSelect(self, silent)
	self.highlight:Show();
	if ( self.highlightSelected ) then
		self.lockHilghlight = 1;
		self.highlight:SetAlpha(0.7);
	end
	
	local scrolllist = self:GetParent():GetParent();
	
	scrolllist.selected = self.dataID;
	if ( not silent ) then
		if ( scrolllist.setFunc ) then
			scrolllist:setFunc(self.value);
		end
	end
end

local function rowOnClick(self, button)
	self:GetParent():GetParent():ClearSelection();
	self:select();
end

local function rowOnEnter(self)
	local scrolllist = self:GetParent():GetParent();
	
	self.highlight:Show();
	if ( scrolllist.commonOnEnter ) then
		scrolllist.commonOnEnter(scrolllist);
	end
end

local function rowOnLeave(self)
	local scrolllist = self:GetParent():GetParent();
	
	if ( not self.lockHilghlight ) then
		self.highlight:Hide();
	end
	if ( scrolllist.commonOnLeave ) then
		scrolllist.commonOnLeave(scrolllist);
	end
end
	
local function raiseRowsPool(_priv, newLimit)
	for i = #_priv.rowsPool+1, newLimit do
		local row = CreateFrame("Button", nil, _priv.rowHolder);			
		if ( i ~= 1 ) then
			row:SetPoint("TOPLEFT", _priv.rowsPool[i-1], "BOTTOMLEFT");
			row:SetPoint("TOPRIGHT", _priv.rowsPool[i-1], "BOTTOMRIGHT");
		else
			row:SetPoint("TOPLEFT", _priv.scrollframe, "TOPLEFT");
			row:SetPoint("TOPRIGHT", _priv.scrollframe, "TOPRIGHT");
		end
		row:SetHeight(_priv.rowHeight);
		row.text = row:CreateFontString(nil, "OVERLAY", "GameFontWhiteSmall");
		row.text:SetAllPoints();
		row.text:SetJustifyH("LEFT");
		row.texture = row:CreateTexture(nil, "BACKGROUND");
		row.texture:SetVertexColor(0.5, 0.5, 0.5);
		row.texture:SetAllPoints();
		row.texture:Hide();
		row.highlight = row:CreateTexture(nil, "ARTWORK");
		if ( _priv.highlightType == "OPTIONS" ) then
			row.highlight:SetTexture("Interface/QuestFrame/UI-QuestLogTitleHighlight");
			row.highlight:SetBlendMode("ADD");
			row.highlight:SetVertexColor(.196, .388, .8);
		elseif ( _priv.highlightType == "DEFAULT" ) then
			row.highlight:SetTexture("Interface/QuestFrame/UI-QuestTitleHighlight");
		end
		row.highlight:SetAllPoints();
		row.highlight:SetAlpha(0.4);
		row.highlight:Hide();
		row.highlightSelected = _priv.highlightSelected;
		
		row.select    = rowSelect;
		row.setDataID = rowSetDataID;
		row.setFont   = rowSetFont;
		row.setHeight = rowSetHeight;
		row.setText   = rowSetText;
		row.setTexture = rowSetTexture;
		row.setValue  = rowSetValue;
		
		row:SetScript("OnClick", rowOnClick);
		row:SetScript("OnEnter", rowOnEnter);
		row:SetScript("OnLeave", rowOnLeave);
		
		tinsert(_priv.rowsPool, row);
	end
end

local function scrolllistUpdate(scrolllist, _priv)
	local maxVisibleRows = math.floor(_priv.scrollframe:GetHeight() / _priv.rowHeight);
	local offset = FauxScrollFrame_GetOffset(_priv.scrollframe);
	
	if ( maxVisibleRows > #_priv.rowsPool ) then
		raiseRowsPool(_priv, maxVisibleRows);
	end
	
	for _, row in ipairs(_priv.rowsPool) do
		row.highlight:Hide();
		row.lockHilghlight = nil;
		row.highlight:SetAlpha(0.4);
	end
	
	local visibleRows = math.min(#_priv.data, maxVisibleRows);		
	for i = 1, visibleRows do
		local row = _priv.rowsPool[i];
		local entry = _priv.data[i+offset];
		
		row:setText(entry.text);
		row:setTexture(entry.texture);
		row:setFont(entry.font);
		row:setValue(entry.value);
		row:setHeight(_priv.rowHeight);
		row:setDataID(i+offset);
		
		if ( scrolllist.selected and (i+offset == scrolllist.selected) ) then
			row:select(true);
		end
		
		row:Show();
	end 
	
	for i = visibleRows+1, maxVisibleRows do
		local row = _priv.rowsPool[i];
		row:setDataID(nil);
		row:Hide();
	end
	
	if ( FauxScrollFrame_Update(_priv.scrollframe, #_priv.data, maxVisibleRows, _priv.rowHeight) ) then
		setMaxWidth(_priv, false);
	else
		setMaxWidth(_priv, true);
	end
end

local methods = {};
	
methods.ClearSelection = function(self, _priv)
	for _, row in ipairs(_priv.rowsPool) do
		row.highlight:Hide();
		row.lockHilghlight = nil;
		row.highlight:SetAlpha(0.4);
	end
	self.selected = nil;
end

methods.SetData = function(self, _priv, dataTable)
	self:ClearSelection();
	local oldOffset = FauxScrollFrame_GetOffset(_priv.scrollframe);
	local newOffset;
	if ( oldOffset >= (#_priv.data - math.floor(self:GetHeight() / _priv.rowHeight)) ) then
		newOffset = math.max(#dataTable - math.floor(self:GetHeight() / _priv.rowHeight), 0);
	else
		newOffset = 0;
	end
	_priv.data = dataTable;
	self:SetScroll(newOffset);
end

methods.Update = function(self, _priv)
	_priv.update();
end

methods.SetScroll = function(self, _priv, offset)
	FauxScrollFrame_OnVerticalScroll(_priv.scrollframe, offset, _priv.rowHeight, _priv.update);
end

methods.GetScroll = function(self, _priv)
	return FauxScrollFrame_GetOffset(_priv.scrollframe);
end

methods.setSelectedValue = function(self, _priv, value)
	for _, row in ipairs(_priv.rowsPool) do
		if ( (type(row.value) == type(value)) and (row.value == value) ) then
			self:ClearSelection();
			row:select();
		end
	end
end

methods.GetSelectedValue = function(self, _priv)
	if ( self.selected ) then
		return _priv.data[self.selected];
	else
		return nil;
	end
end

methods.SetRowHeight = function(self, _priv, height)
	_priv.rowHeight = height;
	_priv.update();
end

methods.SetHeight = function(self, _priv, height)
	self:originalSetHeight(height);
	_priv.update();
end

methods.SetSize = function(self, _priv, width, height)
	self:SetWidth(width);
	self:SetHeight(height);
end

local function constructor(name, parent, highlightSelected, highlightType)
	assert( type(name) == "string"
		, WIDGET .. " constructor: Bad argument #1 (string expected, got " .. type(name) .. ")");
	assert( (type(parent) == "string") 
		or ( type(parent) == "table" 
			and type(parent.IsObjectType) == "function" 
			and parent:IsObjectType("Frame") )
		, WIDGET .. " constructor: Bad argument #2 (string or Frame expected, got " .. type(parent) .. ")");
	assert( type(highlightSelected) == "boolean"
		, WIDGET .. " constructor: Bad argument #3 (boolean expected, got " .. type(highlightSelected) .. ")");
	assert( (highlightType == nil) or (type(highlightType) == "string")
		, WIDGET .. " constructor: Bad argument #4 (string expected, got " .. type(highlightType) .. ")");
	
	local scrolllist = CreateFrame("Frame", name, parent);
	
	local _priv = {};
	
	_priv.scrollframe = CreateFrame("ScrollFrame", name, scrolllist, "FauxScrollFrameTemplate");
	_priv.scrollframe:SetPoint("TOPLEFT", 5, -5);
	_priv.scrollframe:SetPoint("BOTTOMRIGHT", scrolllist, "BOTTOMRIGHT", -5, 5);
	
	_priv.rowsPool = {};
	_priv.data = {}
	_priv.rowHeight = DEFAULT_ROW_HEIGHT;
	_priv.highlightSelected = highlightSelected;
	_priv.highlightType = highlightType or "DEFAULT";
 	
	_priv.rowHolder = CreateFrame("Frame", nil, scrolllist);
	_priv.rowHolder:SetAllPoints(_priv.scrollframe);
	
	_priv.update = function()
		scrolllistUpdate(scrolllist, _priv);
	end
	
	_priv.scrollframe:SetScript("OnVerticalScroll", function(self, offset)
		FauxScrollFrame_OnVerticalScroll(self, offset, _priv.rowHeight, _priv.update);
	end);
	
	scrolllist:SetScript("OnShow", _priv.update);
	
	scrolllist:SetScript("OnSizeChanged", function(self, width, height)
		local offset = FauxScrollFrame_GetOffset(_priv.scrollframe);
		offset = math.min(#_priv.data - math.floor(_priv.scrollframe:GetHeight() / _priv.rowHeight), offset);
		offset = math.max(offset, 0);
		self:SetScroll(offset);
	end);
	
	scrolllist.originalSetHeight = scrolllist.SetHeight;
	
	local function onEnter()
		if ( scrolllist.commonOnEnter ) then
			scrolllist.commonOnEnter(scrolllist);
		end
	end
	
	local function onLeave()
		if ( scrolllist.commonOnLeave ) then
			scrolllist.commonOnLeave(scrolllist);
		end
	end
	
	local slider  = _G[_priv.scrollframe:GetName() .. "ScrollBar"];
	local btnUp   = _G[_priv.scrollframe:GetName() .. "ScrollBarScrollUpButton"];
	local btnDown = _G[_priv.scrollframe:GetName() .. "ScrollBarScrollDownButton"];
	slider:ClearAllPoints();
	slider:SetPoint("TOPLEFT", _priv.scrollframe, "TOPRIGHT", 2, -16);
	slider:SetPoint("BOTTOMLEFT", _priv.scrollframe, "BOTTOMRIGHT", 2, 16);
	slider:SetScript("OnEnter", onEnter);
	slider:SetScript("OnLeave", onLeave);
	btnUp:SetScript("OnEnter", onEnter);
	btnUp:SetScript("OnLeave", onLeave);
	btnDown:SetScript("OnEnter", onEnter);
	btnDown:SetScript("OnLeave", onLeave);
	scrolllist:SetScript("OnEnter", onEnter);
	scrolllist:SetScript("OnLeave", onLeave);
	_priv.scrollframe:SetScript("OnEnter", onEnter);
	_priv.scrollframe:SetScript("OnLeave", onLeave);
	
	-- registering methods
	for methodName, method in pairs(methods) do
		scrolllist[methodName] = function(self, ...)
			return method(self, _priv, ...);
		end
	end
	
	return scrolllist;
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