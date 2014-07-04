--[[

	hfOptionsPanel - World of Warcraft addon that provides opportunities 
	for creating options panel

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
	hf_Widgets.OptionsPanel(name)
		creates options panel
		
		returns created panel (table)
		
	optionsPanel:LinkOptionsTable(optionsTable)
		links options panel with options table
		
		optionsTable: reference to options table (table)
		
	optionsPanel:AddSubPanel(name, title)
		adds sub panel, used to visually split options blocks
		
		name: sub panel identifier (string)
		title: panel title (string)
		
	optionsPanel:StartBlock(subPanelName, title)
		controls between StartBlock and EndBlock will be bounded into a visible titled block
		blocks can be nested
		
		subPanelName: sub panel identifier (string)
		title: block title (string)
		
	optionsPanel:EndBlock(subPanelName)
		closes block on the top of stack
		
		subPanelName: sub panel identifier (string)
		
	optionsPanel:SkipLine(subPanelName)
		inserts blank line
		
		subPanelName: sub panel where blank line should be inserted (string)
		
	optionsPanel:EndLine(subPanelName[, offset])
		ends current line
		
		subPanelName: sub panel where line should be finished (string)
		offset: distance between current and next lines, LINE_OFFSET by default (number)
		
	optionsPanel:AddTabbedFrame(subPanelName, height, firsTabTitle)
		adds tabbed block
		
		subPanelName: sub panel where tabbed frame should be added (string)
		height: tabbed frame height (number)
		firsTabTitle: first tab title (string)
		
	optionsPanel:AddTab(subPanelName, tabTitle)
		adds tab to current tabbed block
		
		subPanelName: sub panel where tab should be added (string)
		tabTitle: tab title (string)
		
	optionsPanel:EndTabbedFrame(subPanelName)
		closes current tabbed frame
		
		subPanelName: sub panel where tabbed frame should be closed (string)
		
	optionsPanel:Indent(subPanelName, offset)
		offsets cursor x position
		
		subPanelName: sub panel (string)
		offset: distance from current x position (number)
	
	optionsPanel:AddControl(subPanelName, endLine, name, ctype, optionName, func, properties)
		creates new control
		
		subPanelName: identifier of sub panel to which add control (string)
		endLine: if set, next control will be at the next line (boolean)
		name: control name (string)
		ctype: control type, possible values:
		       - "checkBox"
		       - "slider"
		       - "dropDown"
		       - "mediaDropDown"
		       - "colorSwatch"
		       - "button"                    (string)
		optionName: key for value in optionsTable that will be changed by this control (string)
		func: function that will be called when value changed, arguments depend on control type (function)
		properties: list of control properties, depends on control type (list)
	
	optionsPanel:SetControl(optionName, valuesList)
		sets control that manages given option, if exists
		
		optionName: key for value in optionsTable whom control should be set (string)
		valuesList: value or values list (list)
		
	optionsPanel:SetValues(optionsTable)
		sets all control values in accordance with given table
		
		optionsTable: table with new values, if some value is omitted, it will not be changed (table)
]]
local ADDON_NAME = ...;

local WIDGET = "OptionsPanel";

--@non-debug@
local REV = 47;
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

local PANEL_WIDTH = 600;
local SUBPANEL_WIDTH = 370;
local SUBPANEL_OFFSET = 33;
local SUBPANEL_EDGE = 16;

local BLOCK_EDGE = 16;

local LINE_OFFSET = 50;
local COLUMN_OFFSET = 170;
local MARGIN_LEFT = 15;
local MARGIN_TOP = 30;
	
local function getCurrentBlock(subpanel)
	if ( #subpanel.blockStack == 0 ) then
		return subpanel;
	else
		return subpanel.blockStack[#subpanel.blockStack];
	end
end

local methods = {};
	
methods.LinkOptionsTable = function(self, _priv, optionsTable)
	assert( type(optionsTable) == "table"
		, WIDGET .. ":LinkOptionsTable() Bad argument #1 (table expected, got " .. type(optionsTable) .. ")");
		
	_priv.optionsTable = optionsTable;
end

methods.AddSubPanel = function(self, _priv, name, title)
	local subpanel = CreateFrame("Frame", (self:GetName() or "") .. name, self);
	_priv.subPanels[name] = subpanel;
	
	local withoutArt = (title == nil);
	
	if ( not withoutArt ) then
		local titleLabel = subpanel:CreateFontString(subpanel:GetName() .. "Title"
			, "ARTWORK"
			, "GameFontNormalLarge");
		titleLabel:SetWidth(SUBPANEL_WIDTH);
		titleLabel:SetHeight(20);
		titleLabel:SetPoint("BOTTOM", subpanel, "TOP", 0, 3);
		titleLabel:SetText(title);
		titleLabel:SetJustifyH("LEFT");
		titleLabel:SetJustifyV("BOTTOM");
		
		subpanel:SetBackdrop({
			edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
			edgeSize = SUBPANEL_EDGE,
		});
	end
	
	subpanel.leftOff = withoutArt and 0 or (SUBPANEL_EDGE + 1);
	subpanel.cursorX = subpanel.leftOff;
	subpanel.cursorY = withoutArt and 0 or -(SUBPANEL_EDGE + 1);
	
	subpanel:SetWidth(SUBPANEL_WIDTH);
	subpanel:SetHeight(math.abs(subpanel.cursorY));
	if ( _priv.lastSubPanel ) then
		subpanel:SetPoint("TOPLEFT", _priv.lastSubPanel, "BOTTOMLEFT", 0, -SUBPANEL_OFFSET);
	else
		subpanel:SetPoint("TOPLEFT", MARGIN_LEFT, -MARGIN_TOP);
	end
	
	subpanel.blockStack = {};
	
	_priv.lastSubPanel = subpanel;
end

methods.Indent = function(self, _priv, subPanelName, offset)
	local subpanel = _priv.subPanels[subPanelName];
	local block = getCurrentBlock(subpanel);
	
	block.cursorX = block.cursorX + offset;
end

methods.EndLine = function(self, _priv, subPanelName, offset)
	local subpanel = _priv.subPanels[subPanelName];
	local block = getCurrentBlock(subpanel);
	
	if ( offset == nil ) then
		offset = LINE_OFFSET;
	end
	
	block:SetHeight(block:GetHeight() + offset);
	
	block.cursorY = block.cursorY - offset;
	block.cursorX = block.leftOff;
end

methods.SkipLine = function(self, _priv, subPanelName)
	if ( _priv.subPanels[subPanelName].cursorX ~= 0 ) then
		self:EndLine(subPanelName);
	end
	self:EndLine(subPanelName);
end

methods.StartBlock = function(self, _priv, subPanelName, title)
	local subpanel = _priv.subPanels[subPanelName];
	local parentBlock = getCurrentBlock(subpanel);
	
	local block = CreateFrame("Frame", nil, parentBlock);
	block:SetPoint("TOPLEFT", math.ceil(parentBlock.leftOff / 1.5), parentBlock.cursorY);
	block:SetWidth(parentBlock:GetWidth() - math.ceil(parentBlock.leftOff * 1.5));
	block:SetHeight(BLOCK_EDGE + 1);
	
	block:SetBackdrop({
		edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
		edgeSize = BLOCK_EDGE,
	});
	
	local titleLabel = block:CreateFontString(nil, "ARTWORK", "GameFontNormal");
	titleLabel:SetWidth(block:GetWidth());
	titleLabel:SetHeight(20);
	titleLabel:SetPoint("BOTTOM", block, "TOP", 0, 3);
	titleLabel:SetText(title);
	titleLabel:SetJustifyH("LEFT");
	titleLabel:SetJustifyV("BOTTOM");
	
	block.leftOff = BLOCK_EDGE + 1;
	block.cursorX = block.leftOff;
	block.cursorY = -(BLOCK_EDGE + 1);
	
	tinsert(subpanel.blockStack, block);
end

methods.EndBlock = function(self, _priv, subPanelName)
	local subpanel = _priv.subPanels[subPanelName];
	local block = getCurrentBlock(subpanel);
	
	tremove(subpanel.blockStack, #subpanel.blockStack);
	
	self:EndLine(subPanelName, block:GetHeight());
end

local function selectTab(tabbedFrame, tabIndex)
	local selectedButton;
	for i, button in ipairs(tabbedFrame.tabButtons) do
		if ( i == tabIndex ) then
			button:Select();
			tabbedFrame.tabs[i]:Show();
			selectedButton = button;
		else
			button:Deselect();
			tabbedFrame.tabs[i]:Hide();
		end
	end
	
	if ( selectedButton.firstRow ) then
		tabbedFrame.spacerLeft:SetPoint('RIGHT', selectedButton, 'LEFT', 9, 0);
		tabbedFrame.spacerRight:SetPoint('LEFT', selectedButton, 'RIGHT', -9, 0);
	else
		tabbedFrame.spacerLeft:SetPoint('RIGHT', tabbedFrame.borderTopRight, 'LEFT');
		tabbedFrame.spacerRight:SetPoint('LEFT', tabbedFrame.borderTopLeft, 'RIGHT');
	end
end

methods.AddTabbedFrame = function(self, _priv, subPanelName, height, firsTabTitle)
	local subpanel = _priv.subPanels[subPanelName];
	local block = getCurrentBlock(subpanel);
	
	local spacer = CreateFrame('Frame', nil, block);
	spacer:SetPoint("TOPLEFT", math.ceil(block.leftOff / 1.5) - 1, block.cursorY + 5);
	spacer:SetWidth(1);
	spacer:SetHeight(1);

	local tabbedFrame = CreateFrame('Frame', nil, block);
	tabbedFrame:SetPoint("TOPLEFT", spacer, "BOTTOMRIGHT");
	tabbedFrame:SetHeight(height);
	tabbedFrame:SetWidth(block:GetWidth() - math.ceil(block.leftOff * 1.5));
	
	tabbedFrame.spacer = spacer;
	
	-- border texture
	tabbedFrame.borderTopLeft = tabbedFrame:CreateTexture(nil, 'BACKGROUND');
	tabbedFrame.borderTopLeft:SetTexture('Interface/Tooltips/UI-Tooltip-Border');
	tabbedFrame.borderTopLeft:SetTexCoord(0.5, 0.625, 0, 1);
	tabbedFrame.borderTopLeft:SetHeight(BLOCK_EDGE);
	tabbedFrame.borderTopLeft:SetWidth(BLOCK_EDGE);
	tabbedFrame.borderTopLeft:SetPoint('TOPLEFT');
	tabbedFrame.borderTopRight = tabbedFrame:CreateTexture(nil, 'BACKGROUND');
	tabbedFrame.borderTopRight:SetTexture('Interface/Tooltips/UI-Tooltip-Border');
	tabbedFrame.borderTopRight:SetTexCoord(0.625, 0.75, 0, 1);
	tabbedFrame.borderTopRight:SetHeight(BLOCK_EDGE);
	tabbedFrame.borderTopRight:SetWidth(BLOCK_EDGE);
	tabbedFrame.borderTopRight:SetPoint('TOPRIGHT');
	tabbedFrame.borderBottomRight = tabbedFrame:CreateTexture(nil, 'BACKGROUND');
	tabbedFrame.borderBottomRight:SetTexture('Interface/Tooltips/UI-Tooltip-Border');
	tabbedFrame.borderBottomRight:SetTexCoord(0.875, 1, 0, 1);
	tabbedFrame.borderBottomRight:SetHeight(BLOCK_EDGE);
	tabbedFrame.borderBottomRight:SetWidth(BLOCK_EDGE);
	tabbedFrame.borderBottomRight:SetPoint('BOTTOMRIGHT');
	tabbedFrame.borderBottomLeft = tabbedFrame:CreateTexture(nil, 'BACKGROUND');
	tabbedFrame.borderBottomLeft:SetTexture('Interface/Tooltips/UI-Tooltip-Border');
	tabbedFrame.borderBottomLeft:SetTexCoord(0.75, 0.875, 0, 1);
	tabbedFrame.borderBottomLeft:SetHeight(BLOCK_EDGE);
	tabbedFrame.borderBottomLeft:SetWidth(BLOCK_EDGE);
	tabbedFrame.borderBottomLeft:SetPoint('BOTTOMLEFT');
	tabbedFrame.borderRight = tabbedFrame:CreateTexture(nil, 'BACKGROUND');
	tabbedFrame.borderRight:SetTexture('Interface/Tooltips/UI-Tooltip-Border');
	tabbedFrame.borderRight:SetTexCoord(0.125, 0.25, 0, 1);
	tabbedFrame.borderRight:SetPoint('TOPLEFT', tabbedFrame.borderTopRight, 'BOTTOMLEFT');
	tabbedFrame.borderRight:SetPoint('BOTTOMRIGHT', tabbedFrame.borderBottomRight, 'TOPRIGHT');
	tabbedFrame.borderLeft = tabbedFrame:CreateTexture(nil, 'BACKGROUND');
	tabbedFrame.borderLeft:SetTexture('Interface/Tooltips/UI-Tooltip-Border');
	tabbedFrame.borderLeft:SetTexCoord(0, 0.125, 0, 1);
	tabbedFrame.borderLeft:SetPoint('TOPLEFT', tabbedFrame.borderTopLeft, 'BOTTOMLEFT');
	tabbedFrame.borderLeft:SetPoint('BOTTOMRIGHT', tabbedFrame.borderBottomLeft, 'TOPRIGHT');
	tabbedFrame.borderBottom = tabbedFrame:CreateTexture(nil, 'BACKGROUND');
	tabbedFrame.borderBottom:SetTexture('Interface/OptionsFrame/UI-OptionsFrame-Spacer');
	tabbedFrame.borderBottom:SetHeight(BLOCK_EDGE);
	tabbedFrame.borderBottom:SetPoint('BOTTOMLEFT', tabbedFrame.borderBottomLeft, 'BOTTOMRIGHT', 0, -2);
	tabbedFrame.borderBottom:SetPoint('BOTTOMRIGHT', tabbedFrame.borderBottomRight, 'BOTTOMLEFT');
	
	local borderTopHolder = CreateFrame('Frame', nil, tabbedFrame);
	borderTopHolder:SetPoint('TOPLEFT', tabbedFrame.borderTopLeft, 'TOPRIGHT', 0, 7);
	borderTopHolder:SetPoint('BOTTOMRIGHT', tabbedFrame.borderTopRight, 'BOTTOMLEFT');
	borderTopHolder:SetFrameLevel(borderTopHolder:GetFrameLevel() + 1);
	
	tabbedFrame.spacerLeft = borderTopHolder:CreateTexture(nil, 'BACKGROUND');
	tabbedFrame.spacerLeft:SetTexture('Interface/OptionsFrame/UI-OptionsFrame-Spacer');
	tabbedFrame.spacerLeft:SetPoint('TOPLEFT');
	tabbedFrame.spacerLeft:SetHeight(BLOCK_EDGE);
	
	tabbedFrame.spacerRight = borderTopHolder:CreateTexture(nil, 'BACKGROUND');
	tabbedFrame.spacerRight:SetTexture('Interface/OptionsFrame/UI-OptionsFrame-Spacer');
	tabbedFrame.spacerRight:SetPoint('TOPRIGHT');
	tabbedFrame.spacerRight:SetHeight(BLOCK_EDGE);
	
	tabbedFrame.tabs = {};
	tabbedFrame.tabButtons = {};
	
	tabbedFrame.row = {};
	tabbedFrame.rowWidth = tabbedFrame:GetWidth();
	tabbedFrame.rowNum = 0;
	
	subpanel.currentTabbedFrame = tabbedFrame;
	
	self:AddTab(subPanelName, firsTabTitle);
end

local function justifyTabs(tabbedFrame)
	local totalWidth = tabbedFrame:GetWidth() - BLOCK_EDGE;
	local avgWidth = totalWidth / #tabbedFrame.row;
	local resizedTabsNum = 0;
	for _, tabButton in ipairs(tabbedFrame.row) do
		tabButton.width = _G[tabButton:GetName() .. "Text"]:GetWidth() 
			+ 2 * _G[tabButton:GetName() .. "Left"]:GetWidth() - 16;
			
		if ( tabButton.width <= avgWidth ) then
			resizedTabsNum = resizedTabsNum + 1;
		else
			totalWidth = totalWidth - tabButton.width;
		end
	end
	local width = totalWidth / resizedTabsNum + 16 * ((#tabbedFrame.row - 1) / #tabbedFrame.row);
	for _, tabButton in ipairs(tabbedFrame.row) do
		if ( tabButton.width <= avgWidth ) then
			tabButton:SetScript('OnShow', function(self)
				PanelTemplates_TabResize(self, 0, width);
				_G[self:GetName().."HighlightTexture"]:SetWidth(self:GetTextWidth() + 30);
			end);
		end
	end
end

methods.AddTab = function(self, _priv, subPanelName, tabTitle)
	local subpanel = _priv.subPanels[subPanelName];
	local tabbedFrame = subpanel.currentTabbedFrame;
	
	local tabButton = CreateFrame('Button', (self:GetName() or "") .. subPanelName .. tabTitle
		, tabbedFrame, 'OptionsFrameTabButtonTemplate');
	tabButton:SetText(tabTitle);
	
	tabWidth = _G[tabButton:GetName() .. "Text"]:GetWidth() 
		+ 2 * _G[tabButton:GetName() .. "Left"]:GetWidth() - 10;
		
	if ( tabbedFrame.rowWidth + tabWidth > (tabbedFrame:GetWidth() - 32) ) then
		justifyTabs(tabbedFrame);
		tabbedFrame.row = {};
		tabbedFrame.rowWidth = tabWidth;
		local tabHeight = tabButton:GetHeight() - 5;
		tabButton:SetPoint('BOTTOMLEFT', tabbedFrame, 'TOPLEFT', 6
			, -3 + tabHeight * tabbedFrame.rowNum);
		tabbedFrame.rowNum = tabbedFrame.rowNum + 1;
		tabbedFrame:SetHeight(tabbedFrame:GetHeight() - tabHeight);
		tabbedFrame.spacer:SetHeight(tabbedFrame.spacer:GetHeight() + tabHeight);
	else
		tabbedFrame.rowWidth = tabbedFrame.rowWidth + tabWidth;
		local lastTabButton = tabbedFrame.tabButtons[#tabbedFrame.tabButtons];
		tabButton:SetPoint('BOTTOMLEFT', lastTabButton, 'BOTTOMRIGHT', -16, 0);
	end
	
	tinsert(tabbedFrame.row, tabButton);
	
	tabButton.firstRow = (tabbedFrame.rowNum == 1);
	
	tabButton.left = _G[tabButton:GetName() .. "Left"];
	tabButton.middle = _G[tabButton:GetName() .. "Middle"];
	tabButton.right = _G[tabButton:GetName() .. "Right"];
	tabButton.leftDisabled = _G[tabButton:GetName() .. "LeftDisabled"];
	tabButton.middleDisabled = _G[tabButton:GetName() .. "MiddleDisabled"];
	tabButton.rightDisabled = _G[tabButton:GetName() .. "RightDisabled"];
	tabButton.id = #tabbedFrame.tabButtons + 1;
	
	function tabButton:Select()
		tabButton.left:Hide();
		tabButton.middle:Hide();
		tabButton.right:Hide();
		tabButton.leftDisabled:Show();
		tabButton.middleDisabled:Show();
		tabButton.rightDisabled:Show();
		tabButton:Disable();
	end
	
	function tabButton:Deselect()
		tabButton.left:Show();
		tabButton.middle:Show();
		tabButton.right:Show();
		tabButton.leftDisabled:Hide();
		tabButton.middleDisabled:Hide();
		tabButton.rightDisabled:Hide();
		tabButton:Enable();
	end
	
	tabButton:SetScript('OnClick', function(self, button)
		if ( button == 'LeftButton' ) then
			selectTab(tabbedFrame, self.id);
		end
	end);
	
	local tab = CreateFrame("Frame", nil, tabbedFrame);
	tab:SetAllPoints();
	tab:Hide();
	
	tab.leftOff = BLOCK_EDGE + 4;
	tab.cursorX = tab.leftOff;
	tab.cursorY = -(BLOCK_EDGE + 10);
	
	if ( #tabbedFrame.tabButtons > 0 ) then
		tremove(subpanel.blockStack, #subpanel.blockStack);
	end
	tinsert(subpanel.blockStack, tab);
	
	tinsert(tabbedFrame.tabButtons, tabButton);
	tinsert(tabbedFrame.tabs, tab);
	
	selectTab(tabbedFrame, 1);
end

methods.EndTabbedFrame = function(self, _priv, subPanelName)
	local subpanel = _priv.subPanels[subPanelName];
	tremove(subpanel.blockStack, #subpanel.blockStack);
	
	self:EndLine(subPanelName, subpanel.currentTabbedFrame:GetHeight() 
		+ subpanel.currentTabbedFrame.spacer:GetHeight());
	
	justifyTabs(subpanel.currentTabbedFrame);
	
	subpanel.currentTabbedFrame = nil;
end

methods.AddControl = function(self, _priv, subPanelName, endLine, name, ctype, optionName, func, ...)
	local subpanel = _priv.subPanels[subPanelName];
	local block = getCurrentBlock(subpanel);
	
	if ( ctype == "checkBox" ) then
		local text = ...;
		
		local cbox = {};
		
		cbox.type = ctype;
		cbox.optionName = optionName;
		cbox.func = func;
		
		cbox.obj  = hf_Widgets.CheckBox(name, block, text);
		cbox.obj:SetPoint("TOPLEFT", block.cursorX, block.cursorY);
		cbox.obj.setFunc = function(setting)
			_priv.optionsTable[cbox.optionName] = (setting == "1");
			cbox.func(setting == "1");
		end
		
		tinsert(_priv.controls, cbox);
		
	elseif ( ctype == "slider" ) then
		local text, min, max, step, digits, manual, decentered, range, position = ...;
		digits = digits or 0;
		
		local slider = {}
		
		slider.type = ctype;
		slider.optionName = optionName;
		slider.func = func;
		
		slider.min = min;
		slider.max = max;
		
		slider.obj  = hf_Widgets.Slider(name, block, text, min, max, step, manual, decentered, range, position);
		slider.obj:SetPoint("TOPLEFT", block.cursorX, block.cursorY);
		slider.obj:SetDigits(digits);
		slider.obj:SetScript("OnValueChanged", function(self, value)
			_priv.optionsTable[slider.optionName] = value;
			slider.func(value);
		end);
		
		tinsert(_priv.controls, slider);
	
	elseif ( ctype == "dropDown" ) then
		
		local text, items = ...;
		
		local drpdwn = {}
		
		drpdwn.type = ctype;
		drpdwn.optionName = optionName;
		drpdwn.func = func;

		drpdwn.obj = hf_Widgets.DropDown(name, block);
		drpdwn.obj.label = block:CreateFontString(name .. "Label", nil, "GameFontNormal");
		drpdwn.obj.label:SetPoint("TOPLEFT", block.cursorX, block.cursorY + 12);
		drpdwn.obj.label:SetText(text);
		drpdwn.obj:SetPoint("TOPLEFT", drpdwn.obj.label, "BOTTOMLEFT", -17, 0);
		drpdwn.obj:SetWidth(100);
		drpdwn.obj:SetButtonWidth(124);
		drpdwn.obj.setFunc = function(self, texture, font, value)
			_priv.optionsTable[drpdwn.optionName] = value;
			drpdwn.func(value);
		end
		for _, item in pairs(items) do
			drpdwn.obj:AddButton(nil, nil, item.text, item.value);
		end
		
		tinsert(_priv.controls, drpdwn);
		
	elseif ( ctype == "mediaDropDown" ) then

		local text, items, subtype = ...;
		
		local drpdwn = {}
		
		drpdwn.type = ctype;
		drpdwn.optionName = optionName;
		drpdwn.func = func;
		drpdwn.subtype = subtype;

		drpdwn.obj = hf_Widgets.DropDown(name, block);
		drpdwn.obj.label = block:CreateFontString(name .. "Label", nil, "GameFontNormal");
		drpdwn.obj.label:SetPoint("TOPLEFT", block.cursorX, block.cursorY + 12);
		drpdwn.obj.label:SetText(text);
		drpdwn.obj:SetPoint("TOPLEFT", drpdwn.obj.label, "BOTTOMLEFT", -17, 0);
		drpdwn.obj:SetWidth(100);
		drpdwn.obj:SetButtonWidth(124);
		drpdwn.obj.setFunc = function(self, texture, font)
			if ( subtype == "font" ) then
				_priv.optionsTable[drpdwn.optionName] = font;
			elseif ( subtype == "texture" ) then
				_priv.optionsTable[drpdwn.optionName] = texture;
			end
			drpdwn.func(texture, font);
		end
		for _, item in pairs(items) do
			drpdwn.obj:AddButton(item.texture, item.font, item.text);
		end
		
		tinsert(_priv.controls, drpdwn);
	
	elseif ( ctype == "colorSwatch" ) then

		local text, hasOpacity = ...;
		
		local swatch = {}
		
		swatch.type = ctype;
		swatch.optionName = optionName;
		swatch.func = func;
		swatch.hasOpacity = hasOpacity;
		
		swatch.obj = CreateFrame("Button", name, block);
		swatch.obj:SetNormalTexture("Interface\\ChatFrame\\ChatFrameColorSwatch");
		swatch.obj:SetSize(22, 22);
		swatch.obj:SetPoint("TOPLEFT", block.cursorX, block.cursorY);
		swatch.obj.tex = swatch.obj:CreateTexture(name .. "Texture", "BACKGROUND");
		swatch.obj.tex:SetSize(14, 14);
		swatch.obj.tex:SetPoint("CENTER");
		swatch.obj.tex:SetTexture("Interface\\AddOns\\" .. ADDON_NAME .. "\\textures\\chess");
		swatch.obj.label = block:CreateFontString(name .. "Label", nil, "GameFontNormal");
		swatch.obj.label:SetPoint("LEFT", swatch.obj, "RIGHT", 5, 0);
		swatch.obj.label:SetText(text);
		
		swatch.obj:SetScript("OnClick", function(self)
			local tex = self:GetNormalTexture();
			local oldR, oldG, oldB, oldA 
			oldR, oldG, oldB = tex:GetVertexColor();
			if ( hasOpacity ) then
				oldA = tex:GetAlpha();
			end
			ColorPickerFrame.hasOpacity = hasOpacity;
			
			ColorPickerFrame.func = function()
				local r, g, b, a, ctable;
				r, g, b = ColorPickerFrame:GetColorRGB();
				tex:SetVertexColor(r, g, b);
				if ( hasOpacity ) then
					a = 1-OpacitySliderFrame:GetValue();
					tex:SetAlpha(a);
				end
				
				ctable = _priv.optionsTable[swatch.optionName];
				ctable.r, ctable.g, ctable.b, ctable.a = r, g, b, a;
				
				swatch.func(r, g, b, a);
			end
			
			ColorPickerFrame.opacityFunc = function()
				local r, g, b, a;
				r, g, b = ColorPickerFrame:GetColorRGB();
				tex:SetVertexColor(r, g, b);
				if ( hasOpacity ) then
					a = 1-OpacitySliderFrame:GetValue();
					tex:SetAlpha(a);
				end
				
				local ctable = _priv.optionsTable[swatch.optionName];
				ctable.r, ctable.g, ctable.b, ctable.a = r, g, b, a;
				
				swatch.func(r, g, b, a);
			end
			
			ColorPickerFrame.cancelFunc = function()
				tex:SetVertexColor(oldR, oldG, oldB);
				if ( hasOpacity ) then
					tex:SetAlpha(oldA);
				end
				local ctable = _priv.optionsTable[swatch.optionName];
				ctable.r, ctable.g, ctable.b, ctable.a = oldR, oldG, oldB, oldA;
				swatch.func(oldR, oldG, oldB, oldA);
			end
			
			ColorPickerFrame:SetColorRGB(oldR, oldG, oldB);
			if ( hasOpacity ) then
				ColorPickerFrame.opacity = 1-oldA;
			end
			ColorPickerFrame:Hide();
			ColorPickerFrame:Show();
		end);
		
		tinsert(_priv.controls, swatch);
	
	elseif ( ctype == "button" ) then

		local text, width = ...;
		
		local button = {};
		
		button.type = ctype;
		
		-- it's not used, but may be necessary to control button through SetControl
		button.optionName = optionName;
		button.func = func;

		button.obj = CreateFrame("Button", name, block, "UIPanelButtonTemplate");
		button.obj:SetPoint("TOPLEFT", block.cursorX, block.cursorY);
		button.obj:SetSize(width or 135, 22);
		button.obj:SetText(text);
		
		button.obj:SetScript("OnClick", function(self)
			button.func();
		end);
		
		tinsert(_priv.controls, button);
	
	else
		error(WIDGET .. ":AddControl() unknown control type");
	end
			
	if ( endLine ) then
		self:EndLine(subPanelName);
	else
		block.cursorX = block.cursorX + COLUMN_OFFSET;
	end
end

methods.SetControl = function(self, _priv, optionName, ...)
	-- find control according given option
	local control;
	for _, icontrol in ipairs(_priv.controls) do
		if ( icontrol.optionName == optionName ) then
			control = icontrol;
			break;
		end
	end
	
	if ( control == nil ) then
		return;
	end
	
	if ( control.type == "checkBox" ) then
		local checked = ...;
		control.obj:SetChecked(checked);
		
	elseif ( control.type == "slider" ) then
		local value = ...;
		
		local avg;
		if ( control.max ~= nil ) then
			if ( control.min ~= nil ) then
				avg = (control.max + control.min) / 2;
			else
				avg = control.max - 1;
			end
		elseif ( control.min ~= nil ) then
			avg = control.min + 1;
		end
		
		-- forcing onValueChanged script
		if ( control.max ~= nil ) then
			if ( value ~= control.max ) then
				control.obj:SetValue(control.max);
			else
				control.obj:SetValue(avg);
			end
		elseif ( control.min ~= nil ) then
			if ( value ~= control.min ) then
				control.obj:SetValue(control.min);
			else
				control.obj:SetValue(avg);
			end
		else
			control.obj:SetValue(value+1);
		end
		
		-- set clamped value
		if ( control.max ~= nil ) then
			value = math.min(value, control.max);
		end
		if ( control.min ~= nil ) then
			value = math.max(value, control.min);
		end
		control.obj:SetValue(value);

	elseif ( control.type == "dropDown" ) then
		local action = ...;
		
		if ( action == "set" ) then
			local _, value = ...;
			control.obj:SetSelectionByValue(value);
		
		elseif ( action == "add" ) then
			local _, value, text = ...;
			control.obj:AddButton(nil, nil, text, value);
		end
		
	elseif ( control.type == "mediaDropDown" ) then
		local action = ...;
		
		if ( action == "set" ) then
			local _, value = ...;
			if ( control.subtype == "texture" ) then
				control.obj:SetSelectionByTexture(value);
			elseif ( control.subtype == "font" ) then
				control.obj:SetSelectionByFont(value);
			end
		
		elseif ( action == "add" ) then
			local _, texture, font, text = ...;
			control.obj:AddButton(texture, font, text);
		end
		
	elseif ( control.type == "colorSwatch" ) then
		local r, g, b, a = ...;

		local curColor = _priv.optionsTable[control.optionName];
		curColor.r, curColor.g, curColor.b, curColor.a = r, g, b, a;
		control.obj:GetNormalTexture():SetVertexColor(r, g, b);
		if ( control.hasOpacity ) then
			control.obj:GetNormalTexture():SetAlpha(a);
		end
		control.func(r, g, b, a);
	elseif ( control.type == "button" ) then
	
	end
end

methods.SetValues = function(self, _priv, valuesTable)
	for _, control in ipairs(_priv.controls) do
		local optionName = control.optionName;
		if ( (optionName ~= nil) and (valuesTable[optionName] ~= nil) ) then
			local ctype = control.type;
			if ( ctype == "checkBox" or ctype == "slider" ) then
				self:SetControl(optionName, valuesTable[optionName]);
			elseif ( ctype == "dropDown" ) then
				self:SetControl(optionName, "set", valuesTable[optionName]);
			elseif ( ctype == "mediaDropDown" ) then
				self:SetControl(optionName, "set", valuesTable[optionName]);
			elseif ( ctype == "colorSwatch" ) then
				local clr = valuesTable[optionName];
				self:SetControl(optionName, clr.r, clr.g, clr.b, clr.a);
			end
		end
	end
end

local function constructor(name)
	assert( type(name) == "string"
		, WIDGET .. " constructor: Bad argument #1 (string expected, got " .. type(name) .. ")");
		
	local optionsPanel = CreateFrame("Frame", name);
	optionsPanel:SetHeight(18);
	optionsPanel:SetWidth(PANEL_WIDTH);
	
	local _priv = {};
	
	_priv.subPanels = {};
	_priv.controls = {};
	
	-- registering methods
	for methodName, method in pairs(methods) do
		optionsPanel[methodName] = function(self, ...)
			return method(self, _priv, ...);
		end
	end

	return optionsPanel;
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