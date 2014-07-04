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

local ADDON_NAME, addon = ...;
local ADDON_PATH = "Interface\\AddOns\\" .. ADDON_NAME;


if ( not hfLootRoll ) then
	return;
end

local ROW_HEIGHT = 22;
local LOG_WIDTH  = 550;
local ARROW_UP_TEXTURE  = ADDON_PATH .. "\\textures\\arrow-up";
local ARROW_DOWN_TEXTURE  = ADDON_PATH .. "\\textures\\arrow-down";

local module = {};
module.options = {};
module.onEvent = {};

local L = addon.L;

local misc = {};

local log;

module.frame = CreateFrame("Frame", "hfLootLogFrame", UIParent);

function module.onLoad()
	log = hfLootRoll:GetModule("log");

	module:initGUI();

	module.frame:Hide();

	hfLootRoll:GetModule("gui"):AddContextButton({
		notCheckable = true;
		text = L"OPEN_LOG";
		func = function() module.frame:Toggle() end
	});

	hfLootRoll:GetModule("slash"):AddCommand("log", function()
		module.frame:Toggle();
	end, L"SLASH_OPEN_LOG");
	
	module:updateContent();
end
	
function module:updateContent()
	local filter = module:formFilter();
	self.filteredDB = log:getFilteredDB(filter);
	if ( self.sortType ) then
		log:SortDB(self.filteredDB, self.sortType, self.sortDesc);
	end
	self.visibleRowsNum = math.max(math.floor(self.frame.content:GetHeight() / ROW_HEIGHT - 1.2), 0);
	FauxScrollFrame_Update(self.frame.contentScroll, #self.filteredDB, self.visibleRowsNum, ROW_HEIGHT);
	self.frame.content:Update()
end

function module.frame:Toggle()
	if ( module.frame:IsShown() ) then
		module.frame:Hide()
	else
		module.frame:Show()
	end
end

function module.frame:OnSizeChanged()
	if ( not module.frame.loaded ) then
		return;
	end
	
	module:updateContent();
end

function module:formFilter()
	local filter = {};
	local optionsFrame = self.frame.options;
	
	filter.timeMin = optionsFrame:getMinTime();
	filter.timeMax = optionsFrame:getMaxTime();
	
	local charName = optionsFrame.charName:GetText();
	if ( charName ~= "" ) then
		filter.character = charName;
	end
	
	local item = optionsFrame.item:GetText();
	if ( item ~= "" ) then
		filter.item = item;
	end
	
	local quality0 = optionsFrame.qPoor:GetChecked();
	local quality1 = optionsFrame.qCommon:GetChecked();
	local quality2 = optionsFrame.qUncommon:GetChecked();
	local quality3 = optionsFrame.qRare:GetChecked();
	local quality4 = optionsFrame.qEpic:GetChecked();
	local quality5 = optionsFrame.qLegendary:GetChecked();
	if ( not (quality0
		 and quality1
		 and quality2
		 and quality3
		 and quality4
		 and quality5) ) then
		filter.quality = {};
		filter.quality[0] = quality0;
		filter.quality[1] = quality1;
		filter.quality[2] = quality2;
		filter.quality[3] = quality3;
		filter.quality[4] = quality4;
		filter.quality[5] = quality5;
	end
	
	return filter;
end

function module.onEvent.LOG_UPDATE()
	if ( module.frame:IsShown() ) then
		module:updateContent();
	end
end

function misc.OnWrapSizeChanged()
	if ( not module.frame.loaded ) then
		return;
	end
	
	local contentFrame = module.frame.content:getActive();
	if ( contentFrame:GetParent() ) then
		contentFrame:SetHeight(contentFrame:GetParent():GetHeight());
	end
end

function misc.OnResizeMouseDown(self)
	module.frame.content.lockoffset = module.frame.content.offset;
	module.frame:StartSizing();
end

function misc.OnResizeMouseUp(self)
	module.frame:StopMovingOrSizing();
end

function misc.OnSliderValue(self, value)
	module.frame.content.offset = value - self:GetMinMaxValues();
	module.frame.content:getActive():SetVerticalScroll(value);
end

function misc.validateDate(dateTable)
	if ( dateTable.min > 59 ) then
		return false;
	elseif ( dateTable.hour > 23 ) then
		return false;
	elseif ( dateTable.month > 12 or dateTable.month < 0.1 ) then
		return false;
	elseif ( dateTable.day < 0.1 ) then
		return false;
	end
	
	local maxDaysInMonth = {
		31, -- 1.  january
		28, -- 2.  february
		31, -- 3.  march
		30, -- 4.  april
		31, -- 5.  may
		30, -- 6.  june
		31, -- 7.  july
		31, -- 8.  august
		30, -- 9.  september
		31, -- 10. october
		30, -- 11. november
		31, -- 12. december
	}
	
	if ( dateTable.year % 4 == 0 ) then
		maxDaysInMonth[2] = 29;
		if ( dateTable.year % 100 == 0 ) then
			maxDaysInMonth[2] = 28;
			if ( dateTable.year % 400 == 0 ) then
				maxDaysInMonth[2] = 29;
			end
		end
	end
	
	if ( dateTable.day > maxDaysInMonth[dateTable.month] ) then
		return false;
	end
	
	return true;
end

function module:initGUI()

	--[[
	
	frames hierarchy:
	
	frame (Frame)
	|
	|-- frame.contentWrapper (Frame)
	|   |
	|   |-- frame.contentScroll (ScrollFrame)
	|   |
	|   |-- frame.content (Slider)
	|       |
	|       |--frame.content.header (Button)
	|       |
	|       |--frame.content.rows (Array of rows)
	|
	|-- frame.optionsWrapper (Frame)
	|   |
	|   |-- frame.options (Frame)
	|       |
	|       |-- frame.options.filters (Frame)
	|       |   |
	|       |   |-- ...
	|       |
	|       |-- ...
	|
	|-- frame.resizePoint (Button)
	
	]]
	
	--[[
		self.frame
		
		desc:
			All other frames placed on this one. Don't display anything itself.
			
		methods:
	]]
	self.frame:SetPoint("TOPLEFT", UIParent, "CENTER", -math.floor(LOG_WIDTH / 2), 200);
	self.frame:SetPoint("BOTTOMRIGHT", UIParent, "CENTER", math.floor(LOG_WIDTH / 2), -200);
	self.frame:SetMovable(true);
	self.frame:SetResizable(true);
	self.frame:SetToplevel(true);
	self.frame:SetMinResize(LOG_WIDTH, 300);
	self.frame:SetMaxResize(LOG_WIDTH, 800);
	self.frame:EnableMouse(true);
	self.frame:SetScript("OnMouseDown", function(self) self:StartMoving() end);
	self.frame:SetScript("OnMouseUp", function(self) self:StopMovingOrSizing() end);
	self.frame:SetScript("OnSizeChanged", self.frame.OnSizeChanged);
	tinsert(UISpecialFrames, self.frame:GetName());
	
	--[[
		self.frame.optionsWrapper
		
		desc:
			Provides background and borders for options frame.
			
		methods:
	]]
	self.frame.optionsWrapper = CreateFrame("Frame", "hfLootLogOptionsBkg", self.frame);
	self.frame.optionsWrapper:SetPoint("BOTTOMLEFT");
	self.frame.optionsWrapper:SetPoint("BOTTOMRIGHT");
	self.frame.optionsWrapper:SetHeight(40);
	self.frame.optionsWrapper:SetBackdrop{
		bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", 
		edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", 
		tile = true, tileSize = 16, edgeSize = 16, 
		insets = { 
			left = 4, 
			right = 4, 
			top = 4,
			bottom = 4
		}
	}
	self.frame.optionsWrapper:SetBackdropColor(.1, .1, .1);

	--[[
		self.frame.contentWrapper
		
		desc:
			Provides background and borders for log frame.
			
		methods:
	]]
	self.frame.contentWrapper = CreateFrame("Frame", "hfLootLogBkg", self.frame);
	self.frame.contentWrapper:SetPoint("TOPLEFT");
	self.frame.contentWrapper:SetPoint("TOPRIGHT");
	self.frame.contentWrapper:SetPoint("BOTTOMLEFT", self.frame.optionsWrapper, "TOPLEFT", 0, 2);
	self.frame.contentWrapper:SetPoint("BOTTOMRIGHT", self.frame.optionsWrapper, "TOPRIGHT", 0, 2);
	self.frame.contentWrapper:SetBackdrop{
		bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", 
		edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", 
		tile = true, tileSize = 16, edgeSize = 16, 
		insets = { 
			left = 4, 
			right = 4, 
			top = 4,
			bottom = 4
		}
	}
	self.frame.contentWrapper:SetBackdropColor(.1, .1, .1);
	self.frame.contentWrapper:SetScript("OnSizeChanged", function()
		module.frame:OnSizeChanged();
	end);

	--[[
		self.frame.resizePoint
		
		desc:
			A little box. Size of self.frame changed by dragging it.
			
		methods:
	]]
	self.frame.resizePoint = CreateFrame("Button", "hfLootLogResizePoint", self.frame);
	self.frame.resizePoint:SetPoint("BOTTOMRIGHT", -4, 4);
	self.frame.resizePoint:SetWidth(13);
	self.frame.resizePoint:SetHeight(13);
	self.frame.resizePoint:SetScript("OnMouseDown", misc.OnResizeMouseDown);
	self.frame.resizePoint:SetScript("OnMouseUp",   misc.OnResizeMouseUp);
	self.frame.resizePoint:SetNormalTexture("Interface/ChatFrame/UI-ChatIM-SizeGrabber-Up");
	self.frame.resizePoint:SetHighlightTexture("Interface/ChatFrame/UI-ChatIM-SizeGrabber-Highlight");				
	self.frame.resizePoint:SetPushedTexture("Interface/ChatFrame/UI-ChatIM-SizeGrabber-Down");
	
	--[[
		self.frame.contentScroll
		
		desc:
			scroll handler
			
		methods:
	]]
	self.frame.contentScroll = CreateFrame("ScrollFrame", "hfLootLogContentScroll", self.frame.contentWrapper, "FauxScrollFrameTemplate");
	self.frame.contentScroll:SetPoint("TOPLEFT", 0, -7);
	self.frame.contentScroll:SetPoint("BOTTOMRIGHT", -30, 6);
	self.frame.contentScroll:HookScript("OnVerticalScroll", function(self, offset)
		FauxScrollFrame_OnVerticalScroll(self, offset, ROW_HEIGHT);
		module.frame.content:Update();
	end);
	
	--[[
		self.frame.content
		
		desc:
			entries table holder
			
		methods:
			AddRow()
			Update()
	]]
	self.frame.content = CreateFrame("Frame", "hfLootLogContent", self.frame.contentWrapper);
	self.frame.content:SetPoint("TOPLEFT", 8, -2);
	self.frame.content:SetPoint("BOTTOMRIGHT", -38, 2);
	
	local function createContentHeader(name, text, width)
		local header = CreateFrame("Button", "hfLootLogContentHeader" .. name, self.frame.content);
		
		if ( self.frame.content.lastHeader ) then
			header:SetPoint("LEFT", self.frame.content.lastHeader, "RIGHT");
		else
			header:SetPoint("TOPLEFT");
		end
		
		if ( width ) then
			header:SetWidth(width);
		else
			header:SetPoint("RIGHT");
		end
		
		header.textNoSort = text;
		header.textAscSort = "|T" .. ARROW_DOWN_TEXTURE .. ":12:0|t" .. text;
		header.textDescSort = "|T" .. ARROW_UP_TEXTURE .. ":12:0|t" .. text;
		
		header:SetHeight(ROW_HEIGHT);
		header:SetNormalFontObject("GameFontWhite");
		header:SetText(header.textNoSort);
		header.name = name;
		header:SetScript("OnClick", function(self)
			self:GetParent():OnHeaderClick(self.name);
		end);
		
		self.frame.content.lastHeader = header;
		
		return header;
	end
	
	self.frame.content.headers = {};
	self.frame.content.headers.Date = createContentHeader("Date", L"HEADER_DATE", 130);
	self.frame.content.headers.Name = createContentHeader("Name", L"HEADER_NAME", 80);
	self.frame.content.headers.Item = createContentHeader("Item", L"HEADER_ITEM", 170);
	self.frame.content.headers.Roll = createContentHeader("Roll", L"HEADER_ROLL", 30);
	self.frame.content.headers.Source = createContentHeader("Source", L"HEADER_SOURCE");
	
	self.frame.content.rows = {};
	
	function self.frame.content:OnHeaderClick(headerID)
		if ( module.sortType == headerID ) then
			module.sortDesc = not module.sortDesc;
		else
			module.sortType = headerID;
			module.sortDesc = false;
		end
		
		for headerType, header in pairs(self.headers) do
			if ( headerType == headerID ) then
				if ( module.sortDesc ) then
					header:SetText(header.textDescSort);
				else
					header:SetText(header.textAscSort);
				end
			else
				header:SetText(header.textNoSort);
			end
		end
		
		if ( module.filteredDB ) then
			log:SortDB(module.filteredDB, module.sortType, module.sortDesc);
		end
		
		self:Update();
	end
	
	function self.frame.content:OnHyperlinkClick(link, button)
		local intLink = link and link:match("|H(.-)|h");
		if ( intLink ) then
			SetItemRef(intLink, link, button);
		end
	end
	
	function self.frame.content:AddRow()
		local rows = self.rows;
		local row = CreateFrame("Frame", "hfLootLogContentRow" .. (#rows + 1), self);
		row:SetHeight(ROW_HEIGHT);
		row:SetPoint("LEFT");
		row:SetPoint("RIGHT");
		row:SetPoint("TOP", self.lastHeader, "BOTTOM", 0, -(#rows * ROW_HEIGHT) - 3);
		
		row.delimiter = row:CreateTexture("hfLootLogContentRow" .. (#rows + 1) .. "Delimiter", "OVERLAY")
		row.delimiter:SetTexture("Interface/QuestFrame/UI-QuestTitleHighlight");
		row.delimiter:SetHeight(1);
		row.delimiter:SetPoint("TOPLEFT");
		row.delimiter:SetPoint("TOPRIGHT");
		row.delimiter:SetBlendMode("ADD");
		row.delimiter:SetAlpha(0.7);
		
		local function addCell(name, header, justify, offset, clickable)
			row[name] = row:CreateFontString("hfLootLogContentRow" .. (#rows + 1) .. name, "ARTWORK", "GameFontWhite");
			row[name]:SetWordWrap(false);
			row[name]:SetJustifyH(justify or "LEFT");
			row[name]:SetJustifyV("CENTER");
			row[name]:SetPoint("TOP", 0, offset or 0);
			row[name]:SetPoint("BOTTOM", 0, offset or 0);
			row[name]:SetPoint("LEFT", header);
			row[name]:SetPoint("RIGHT", header);
			
			if ( clickable ) then
				local hitbox = CreateFrame("Button", "hfLootLogContentRow" .. (#rows + 1) .. name .. "HitBox", row);
				hitbox:RegisterForClicks("RightButtonUp", "LeftButtonUp");
				hitbox:SetAllPoints(row[name]);
				hitbox:SetScript("OnClick", function(self, button)
					self:GetParent():GetParent():OnHyperlinkClick(row[name]:GetText(), button);
				end);
				
				row[name].hitbox = hitbox;
			end
			
			return row[name];
		end
		
		addCell("name", self.headers.Name, nil, nil, true);
		addCell("item", self.headers.Item, nil, nil, true);
		addCell("date", self.headers.Date);
		addCell("roll", self.headers.Roll, "CENTER", -6);
		addCell("source", self.headers.Source, nil, nil, true);
		
		tinsert(rows, row);
		return row;
	end
	
	function self.frame.content:Update()
		if ( not (module.filteredDB or module.visibleRowsNum) ) then
			for i = 1, #self.rows do
				self.rows[i]:Hide();
			end
			return;
		end
	
		local scrollFrame = module.frame.contentScroll;
	
		-- Extending rows pool if needed, hiding/showing rows
		local visibleRowsNum = module.visibleRowsNum;
		if ( visibleRowsNum > #self.rows ) then
			local extraRowsNum = visibleRowsNum - #self.rows;
			for i = 1, extraRowsNum do
				self:AddRow();
			end
		end
	
		local filteredDB = module.filteredDB;
		
		for i = 1, visibleRowsNum do
			local entryIndex = scrollFrame.offset + i;
			local row = self.rows[i];
			
			if ( entryIndex > #filteredDB ) then
				row:Hide();
			else
				local entry = filteredDB[entryIndex];
				
				local timeStamp = date("(%d/%m/%y) %H:%M", entry.time);
				local recipient = "|Hplayer:" .. entry.character .. "|h" .. entry.character .. "|h";
				local count     = entry.count;
				local itemLink  = (((count > 1) and (count.."x")) or "") .. entry.itemLink;
				local rollTexture = "";
				if ( entry.rollType ) then
					local texturePath = "";
					if ( entry.rollType == "disenchant" ) then
						texturePath = "Interface\\Buttons\\UI-GroupLoot-DE-Up";
					elseif ( entry.rollType == "need" ) then
						texturePath = "Interface\\Buttons\\UI-GroupLoot-Dice-Up";
					elseif ( entry.rollType == "greed" ) then
						texturePath = "Interface\\Buttons\\UI-GroupLoot-Coin-Up";
					end
					rollTexture = "|T" .. texturePath .. ":18:18|t";
				end;
				local source = entry.source or "";
				
				row.item:SetText(itemLink);
				row.name:SetText(recipient);
				row.date:SetText(timeStamp);
				row.roll:SetText(rollTexture);
				row.source:SetText(source);
				
				row:Show();
			end
		end
		
		if ( visibleRowsNum < #self.rows ) then
			for i = visibleRowsNum + 1, #self.rows do
				self.rows[i]:Hide();
			end
		end
	end
	
	-- initial sort by time
	self.frame.content.headers.Date:Click();
	
	--[[
		self.frame.options
		
		desc:
			Frame that contains control elements.
			
		methods:
	]]
	self.frame.options = CreateFrame("Frame", "hfLootLogOptions", self.frame.optionsWrapper);
	self.frame.options:SetPoint("TOPLEFT", 4, -4);
	self.frame.options:SetPoint("BOTTOMRIGHT", -4, 4);
	
	self.frame.options.closeBtn = CreateFrame("Button", "hfLootLogOptionsClose", self.frame.options, "UIPanelButtonTemplate");
	self.frame.options.closeBtn:SetPoint("BOTTOMRIGHT", -12, 6);
	self.frame.options.closeBtn:SetHeight(20);
	self.frame.options.closeBtn:SetWidth(80);
	self.frame.options.closeBtn:SetText(L"CLOSE");
	self.frame.options.closeBtn:SetScript("OnClick", function() self.frame:Hide(); end);
	
	self.frame.options.clearBtn = CreateFrame("Button", "hfLootLogOptionsClear", self.frame.options, "UIPanelButtonTemplate");
	self.frame.options.clearBtn:SetPoint("RIGHT", self.frame.options.closeBtn, "LEFT", -3, 0);
	self.frame.options.clearBtn:SetHeight(20);
	self.frame.options.clearBtn:SetWidth(80);
	self.frame.options.clearBtn:SetText(L"CLEAR_LOG");
	self.frame.options.clearBtn:SetScript("OnClick", function() StaticPopup_Show("HFLOOTROLL_LOG_CONFIRM_PURGE"); end);
	StaticPopupDialogs["HFLOOTROLL_LOG_CONFIRM_PURGE"] = {
		text = L"CLEAR_LOG_POPUP",
		button1 = YES,
		button2 = NO,
		OnAccept = function()
			hfLootRoll:GetModule("log"):clearLog();
		end,
		OnCancel = function() end,
		timeout = 0,
		whileDead = true,
		hideOnEscape = true,
	}
	
	self.frame.options.filtersToggleBtn = CreateFrame("Button", "hfLootLogOptionsToggleFilters", self.frame.options, "UIPanelButtonTemplate");
	self.frame.options.filtersToggleBtn:SetPoint("RIGHT", self.frame.options.clearBtn, "LEFT", -3, 0);
	self.frame.options.filtersToggleBtn:SetHeight(20);
	self.frame.options.filtersToggleBtn:SetWidth(80);
	self.frame.options.filtersToggleBtn.filtersShown = false;
	self.frame.options.filtersToggleBtn:SetText(L"FILTERS_SHOW")
	self.frame.options.filtersToggleBtn:SetScript("OnClick", function(self) 
		if ( self.filtersShown ) then
			module.frame.options.filters:Hide();
			module.frame.optionsWrapper:SetHeight(40);
			self.filtersShown = false;
			self:SetText(L"FILTERS_SHOW")
		else
			module.frame.options.filters:Show();
			module.frame.optionsWrapper:SetHeight(195);
			self.filtersShown = true;
			self:SetText(L"FILTERS_HIDE")
		end
	end);
	
	self.frame.options.filters = CreateFrame("Frame", "hfLootLogOptionsFilters", self.frame.options);
	self.frame.options.filters:SetPoint("TOPLEFT", 5, -10);
	self.frame.options.filters:SetPoint("BOTTOMRIGHT", -5, 50);
	self.frame.options.filters:Hide();
	
	local function CreateInputBox(name, parent, maxletters, onChange, numeric, label, labelOffset)
		if ( not onChange ) then
			onChange = function()
				module:updateContent();
			end;
		end
	
		local inputBox = CreateFrame("EditBox", name, parent, "InputBoxTemplate");
		inputBox:SetHeight(16);
		inputBox:SetWidth(maxletters * 10);
		inputBox:SetMaxLetters(maxletters);
		inputBox:SetMultiLine(false);
		inputBox:SetNumeric(numeric);
		inputBox:SetAutoFocus(false);
		inputBox:SetScript("OnEscapePressed", function(self)
			self:ClearFocus() 
			onChange(self);
		end);
		inputBox:SetScript("OnEnterPressed", function(self) 
			if ( self.next ) then
				self.next:SetFocus()
			else
				self:ClearFocus();
			end
			onChange(self);
		end);
		inputBox:SetScript("OnTabPressed", function(self)
			if ( self.next ) then
				self.next:SetFocus()
			else
				self:ClearFocus();
			end
			onChange(self);
		end);
		
		if ( label ) then
			if ( not labelOffset ) then
				labelOffset = 0;
			end		
			local labelStr = parent:CreateFontString(nil, "OVERLAY");
			labelStr:SetPoint("RIGHT", inputBox, "LEFT", -labelOffset, 0);
			labelStr:SetFontObject("GameFontNormal");
			labelStr:SetText(label);
		end
		
		function inputBox:SetNext(nextEditBox)
			self.next = nextEditBox;
		end
		
		return inputBox;
	end
	
	local function onMinChange(self)
		local optionsFrame = module.frame.options;
		local newMinTime = optionsFrame:getMinTime();
		if ( (newMinTime ~= optionsFrame.curMinTime) ) then
			module:updateContent();
			optionsFrame.curMinTime = newMinTime;
		end
	end
	
	self.frame.options.timeSelectH1 = CreateInputBox("hfLootLogOptionsTimeH1", self.frame.options.filters, 2, onMinChange, true, L"EARLIEST", 10);
	self.frame.options.timeSelectH1:SetPoint("TOPLEFT", 66, 0);
	
	self.frame.options.timeSelectM1 = CreateInputBox("hfLootLogOptionsTimeM1", self.frame.options.filters, 2, onMinChange, true, ":", 7);
	self.frame.options.timeSelectM1:SetPoint("LEFT", self.frame.options.timeSelectH1, "RIGHT", 13, 0);
	
	self.frame.options.timeSelectD1 = CreateInputBox("hfLootLogOptionsTimeD1", self.frame.options.filters, 2, onMinChange, true);
	self.frame.options.timeSelectD1:SetPoint("LEFT", self.frame.options.timeSelectM1, "RIGHT", 20, 0);
	
	self.frame.options.timeSelectMO1 = CreateInputBox("hfLootLogOptionsTimeMO1", self.frame.options.filters, 2, onMinChange, true, "/", 5);
	self.frame.options.timeSelectMO1:SetPoint("LEFT", self.frame.options.timeSelectD1, "RIGHT", 13, 0);
	
	self.frame.options.timeSelectY1 = CreateInputBox("hfLootLogOptionsTimeY1", self.frame.options.filters, 4, onMinChange, true, "/", 5);
	self.frame.options.timeSelectY1:SetPoint("LEFT", self.frame.options.timeSelectMO1, "RIGHT", 13, 0);
	
	local function onMaxChange(self)
		local optionsFrame = module.frame.options;
		local newMaxTime = optionsFrame:getMaxTime();
		if ( (newMaxTime ~= optionsFrame.curMaxTime) ) then
			module:updateContent();
			optionsFrame.curMaxTime = newMaxTime;
		end
	end
	
	self.frame.options.timeSelectH2 = CreateInputBox("hfLootLogOptionsTimeH2", self.frame.options.filters, 2, onMaxChange, true, L"LATEST", 10);
	self.frame.options.timeSelectH2:SetPoint("TOPLEFT", self.frame.options.timeSelectH1, "BOTTOMLEFT", 0, -7);
	
	self.frame.options.timeSelectM2 = CreateInputBox("hfLootLogOptionsTimeM2", self.frame.options.filters, 2, onMaxChange, true, ":", 7);
	self.frame.options.timeSelectM2:SetPoint("LEFT", self.frame.options.timeSelectH2, "RIGHT", 13, 0);
	
	self.frame.options.timeSelectD2 = CreateInputBox("hfLootLogOptionsTimeD2", self.frame.options.filters, 2, onMaxChange, true);
	self.frame.options.timeSelectD2:SetPoint("LEFT", self.frame.options.timeSelectM2, "RIGHT", 20, 0);
	
	self.frame.options.timeSelectMO2 = CreateInputBox("hfLootLogOptionsTimeMO2", self.frame.options.filters, 2, onMaxChange, true, "/", 5);
	self.frame.options.timeSelectMO2:SetPoint("LEFT", self.frame.options.timeSelectD2, "RIGHT", 13, 0);
	
	self.frame.options.timeSelectY2 = CreateInputBox("hfLootLogOptionsTimeY2", self.frame.options.filters, 4, onMaxChange, true, "/", 5);
	self.frame.options.timeSelectY2:SetPoint("LEFT", self.frame.options.timeSelectMO2, "RIGHT", 13, 0);
	
	self.frame.options.charName = CreateInputBox("hfLootLogOptionsChar", self.frame.options.filters, 18, nil, false, L"NAME", 10);
	self.frame.options.charName:SetPoint("TOPLEFT", self.frame.options.timeSelectH2, "BOTTOMLEFT", 0, -7);
	
	self.frame.options.item = CreateInputBox("hfLootLogOptionsItem", self.frame.options.filters, 50, nil, false, L"ITEM", 10);
	self.frame.options.item:SetWidth(180);
	self.frame.options.item:SetPoint("TOPLEFT", self.frame.options.charName, "BOTTOMLEFT", 0, -7);
	
	self.frame.options.timeSelectH1:SetNext(self.frame.options.timeSelectM1);
	self.frame.options.timeSelectM1:SetNext(self.frame.options.timeSelectD1);
	self.frame.options.timeSelectD1:SetNext(self.frame.options.timeSelectMO1);
	self.frame.options.timeSelectMO1:SetNext(self.frame.options.timeSelectY1);
	self.frame.options.timeSelectY1:SetNext(self.frame.options.timeSelectH2);
	self.frame.options.timeSelectH2:SetNext(self.frame.options.timeSelectM2);
	self.frame.options.timeSelectM2:SetNext(self.frame.options.timeSelectD2);
	self.frame.options.timeSelectD2:SetNext(self.frame.options.timeSelectMO2);
	self.frame.options.timeSelectMO2:SetNext(self.frame.options.timeSelectY2);
	self.frame.options.timeSelectY2:SetNext(self.frame.options.charName);
	self.frame.options.charName:SetNext(self.frame.options.item);
	self.frame.options.item:SetNext(self.frame.options.timeSelectH1);
	
	local function createLabeledCheckBox(name, parent, text)
		local checkBox = CreateFrame("CheckButton", name, parent, "InterfaceOptionsCheckButtonTemplate");
		checkBox:SetWidth(14);
		checkBox:SetHeight(14);
		checkBox:SetChecked(true);
		checkBox:SetScript("OnClick", function(self)
			module:updateContent();
		end);
		
		local label = parent:CreateFontString(nil, "OVERLAY");
		label:SetPoint("LEFT", checkBox, "RIGHT", 5, 0);
		label:SetFontObject("GameFontNormal");
		label:SetText(text);
		
		return checkBox;
	end

	self.frame.options.qPoor = createLabeledCheckBox("hfLootLogOptionsQPoor", self.frame.options.filters, select(4, GetItemQualityColor(0)) .. _G["ITEM_QUALITY0_DESC"] .. "|r");
	self.frame.options.qPoor:SetPoint("TOPLEFT", self.frame.options.item, "BOTTOMLEFT", -61, -4);
	
	self.frame.options.qCommon = createLabeledCheckBox("hfLootLogOptionsQCommon", self.frame.options.filters, select(4, GetItemQualityColor(1)) .. _G["ITEM_QUALITY1_DESC"] .. "|r");
	self.frame.options.qCommon:SetPoint("LEFT", self.frame.options.qPoor, "RIGHT", 100, 0);
	
	self.frame.options.qUncommon = createLabeledCheckBox("hfLootLogOptionsQUncommon", self.frame.options.filters, select(4, GetItemQualityColor(2)) .. _G["ITEM_QUALITY2_DESC"] .. "|r");
	self.frame.options.qUncommon:SetPoint("TOPLEFT", self.frame.options.qPoor, "BOTTOMLEFT", 0, -3);
	
	self.frame.options.qRare = createLabeledCheckBox("hfLootLogOptionsQRare", self.frame.options.filters, select(4, GetItemQualityColor(3)) .. _G["ITEM_QUALITY3_DESC"] .. "|r");
	self.frame.options.qRare:SetPoint("LEFT", self.frame.options.qUncommon, "RIGHT", 100, 0);
	
	self.frame.options.qEpic = createLabeledCheckBox("hfLootLogOptionsQEpic", self.frame.options.filters, select(4, GetItemQualityColor(4)) .. _G["ITEM_QUALITY4_DESC"] .. "|r");
	self.frame.options.qEpic:SetPoint("TOPLEFT", self.frame.options.qUncommon, "BOTTOMLEFT", 0, -3);
	
	self.frame.options.qLegendary = createLabeledCheckBox("hfLootLogOptionsQLegendary", self.frame.options.filters, select(4, GetItemQualityColor(5)) .. _G["ITEM_QUALITY5_DESC"] .. "|r");
	self.frame.options.qLegendary:SetPoint("LEFT", self.frame.options.qEpic, "RIGHT", 100, 0);
	
	function self.frame.options:getMinTime()
		local minH = tonumber(self.timeSelectH1:GetText()) or 0;
		local minM = tonumber(self.timeSelectM1:GetText()) or 0;
		local minD = tonumber(self.timeSelectD1:GetText());
		local minMO = tonumber(self.timeSelectMO1:GetText());
		local minY = tonumber(self.timeSelectY1:GetText());
		
		if ( (minD ~= nil) and (minMO ~= nil) and (minY ~= nil) ) then
			local dateTable = {min = minM, hour = minH, day = minD, month = minMO, year = minY};
			if ( misc.validateDate(dateTable) ) then
				return time(dateTable);
			end
		end
		
		return nil;
	end
	
	function self.frame.options:getMaxTime()
		local maxH = tonumber(self.timeSelectH2:GetText()) or 0;
		local maxM = tonumber(self.timeSelectM2:GetText()) or 0;
		local maxD = tonumber(self.timeSelectD2:GetText());
		local maxMO = tonumber(self.timeSelectMO2:GetText());
		local maxY = tonumber(self.timeSelectY2:GetText());
		
		if ( (maxD ~= nil) and (maxMO ~= nil) and (maxY ~= nil) ) then
			local dateTable = {min = maxM, hour = maxH, day = maxD, month = maxMO, year = maxY};
			if ( misc.validateDate(dateTable) ) then
				return time(dateTable);
			end
		end
		
		return nil;
	end
	
	self.frame.loaded = true;
end

hfLootRoll:AddModule("log_gui", module);