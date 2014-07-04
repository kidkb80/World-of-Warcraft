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
local MAX_BAR_WIDTH  = 2000;
local MIN_BAR_WIDTH  = 100;
local MAX_BAR_HEIGHT = 400;
local MIN_BAR_HEIGHT = 15;

local module = {};
module.onEvent = {};

local L = addon.L;
local const = addon.const;

local examplesController = CreateFrame("Frame");

local LibSharedMedia;
local LSMinited = false;
addon:RegisterOnLoadLib("LibSharedMedia-3.0", function(lib)
	LibSharedMedia = lib;
	module:InitLSM();
end);

local function cloneTable(t, recursive, moveTo)
	local clone = moveTo or {};
	for k, v in pairs(t) do
		if ( type(v) == "table" and recursive ) then
			if ( clone[k] and (type(clone[k]) == "table") ) then
				cloneTable(v, true, clone[k]);
			else
				clone[k] = cloneTable(v, true);
			end
		else
			clone[k] = v;
		end
	end
	return clone;
end
	
local defaultOptions = {
	configMode = false,

	anchorPos = { 
		["point"]         = "BOTTOMLEFT",
		["relativeTo"]    = "UIParent",
		["relativePoint"] = "BOTTOMLEFT",
		["xOfs"]          = UIParent:GetWidth()/2-90,
		["yOfs"]          = UIParent:GetHeight()/2-15,
	},
	anchorLocked = false,
	bgTexture = const.DEFAULT_TEXTURE,
	offset    = 10,
	direction = "DOWN",
	height    = 33,
	width     = 210,
	scale     = 1,
	useBgTime = true,
	iconScale = 1,
	font      = GameFontNormal:GetFont(),
	fontSize  = 14,
	sparkOpacity = 1,
	opacity   = 1,
	combatOpacity = 0.5,
	showBoP   = false,
	showILvl  = false,
	
	borderTexture = "none",
	borderSize = 1,
	borderOffset = 0,
	borderColorByQuality = false,
	borderColor = {
		r = 1,
		g = 1,
		b = 1,
		a = 1,
	},
	
	uncom = {
		r = ITEM_QUALITY_COLORS[2].r,
		g = ITEM_QUALITY_COLORS[2].g,
		b = ITEM_QUALITY_COLORS[2].b,
	},
	rare = {
		r = ITEM_QUALITY_COLORS[3].r,
		g = ITEM_QUALITY_COLORS[3].g,
		b = ITEM_QUALITY_COLORS[3].b,
	},
	epic = {
		r = ITEM_QUALITY_COLORS[4].r,
		g = ITEM_QUALITY_COLORS[4].g,
		b = ITEM_QUALITY_COLORS[4].b,
	},
	default = {
		r = 0.5,
		g = 0.5,
		b = 0.5,
	},
	
	showWho   = true,
	showWhoColorize = true,
	showTTOnIconOnly = false,
	showComparisonTT = true,
	
	nameColorByQuality = true,
	nameColor = {
		r = 0.8,
		g = 0.8,
		b = 0.8,
		a = 1,
	},
	nameJustifyH = "LEFT",
	nameJustifyV = "TOP",
	nameFontSize = 12,
	nameOffsetX  = 10,
	nameOffsetY  = 8,
	nameShow     = true,
	
	winnerNameColorByClass = true,
	winnerNameColor = {
		r = 0.9,
		g = 0.8,
		b = 0.2,
		a = 1,
	},
	winnerNameJustifyH = "CENTER",
	winnerNameJustifyV = "MIDDLE",
	winnerNameFontSize = 19,
	winnerNameOffsetX  = 2,
	winnerNameOffsetY  = 1,
	winnerShow         = true,
	
	behavior = {
		disappearAfterSelect = false,
		disappearAfterSelectDelay = 0,
		disappearAfterRollFinish = true,
		disappearAfterRollFinishDelay = 20,
		disappearManually = false,
		closeButton = "RightButton",
		closeButtonModifier = "n/a",
		clickthroughInCombat = false,
		inCombatInteractionModifier = "SHIFT",
		maxPanels = 8,
		autoconfirm = false,
	},
}

local function repairTableStructure(t, template)
	for k, v in pairs(template) do
		if ( (type(v) == "table") and (type(t[k]) ~= "table") ) then
			t[k] = {};
			repairTableStructure(t[k], v, true);
		elseif ( t[k] == nil ) then
			t[k] = v;
		end
	end
end

local backupOptions = {};

function module.onLoad()
	if ( not module.globalOptions.perCharacter ) then
		module.globalOptions.custom = {};
		module.globalOptions.perCharacter = {};
		module.globalOptions.perCharacter[const.PLAYER_NAME_FULL] = cloneTable(module.options, true);
		wipe(module.options);
	elseif ( not module.globalOptions.perCharacter[const.PLAYER_NAME_FULL] ) then
		module.globalOptions.perCharacter[const.PLAYER_NAME_FULL] = cloneTable(module.options, true);
		wipe(module.options);
	end
	module.currentOptions = module.globalOptions.perCharacter[const.PLAYER_NAME_FULL];
	module.currentOptions.lastTime = module.currentOptions.lastTime or 0;
	
	if ( module.globalOptions["Default"] ) then
		if ( module.currentOptions.lastTime < module.globalOptions["Default"].lastTime ) then
			cloneTable(module.globalOptions["Default"], true, module.currentOptions);
		end
	end
	module.currentOptions.lastTime = time();
	
	repairTableStructure(module.currentOptions, defaultOptions);
	
	module:InitOptionsFrame();
	
	local rootPanel = CreateFrame("Frame");
	rootPanel.name = "hfLootRoll";
	rootPanel.title = rootPanel:CreateFontString("hfLootRollOptionsPanelTitle", nil, "GameFontNormalLarge");
	rootPanel.title:SetPoint("TOPLEFT", 16, -16);
	rootPanel.title:SetText(ADDON_NAME);
	rootPanel.title:SetJustifyH("LEFT");
	rootPanel.title:SetJustifyV("TOP");
	rootPanel.subtitle = rootPanel:CreateFontString("hfLootRollOptionsPanelSubTitle", nil, "GameFontHighlightSmall");
	rootPanel.subtitle:SetPoint("TOPLEFT", rootPanel.title, "BOTTOMLEFT", 0, -8);
	rootPanel.subtitle:SetPoint("RIGHT", -32, 0);
	rootPanel.subtitle:SetText(L"DESCRIPTION");
	rootPanel.subtitle:SetNonSpaceWrap(true);
	rootPanel.subtitle:SetJustifyH("LEFT");
	rootPanel.subtitle:SetJustifyV("TOP");
	rootPanel.subtitle:SetSize(0, 32);
	rootPanel.version = rootPanel:CreateFontString("hfLootRollOptionsPanelSubTitle", nil, "GameFontHighlightSmall");
	rootPanel.version:SetPoint("TOPLEFT", rootPanel.subtitle, "BOTTOMLEFT", 0, -8);
	rootPanel.version:SetPoint("RIGHT", -32, 0);
	rootPanel.version:SetText(L"VERSION" .. ": " .. tostring(GetAddOnMetadata(ADDON_NAME, "Version")));
	rootPanel.version:SetJustifyH("LEFT");
	rootPanel.version:SetJustifyV("TOP");
	rootPanel.version:SetSize(0, 32);
	
	--[===[@debug@
	rootPanel.memory1 = rootPanel:CreateFontString("hfLootRollOptionsPanel1Title", nil, "GameFontNormalLarge");
	rootPanel.memory1:SetPoint("TOPLEFT", rootPanel.version, "BOTTOMLEFT", 0, -8);
	rootPanel.memory2 = rootPanel:CreateFontString("hfLootRollOptionsPanel2Title", nil, "GameFontNormalLarge");
	rootPanel.memory2:SetPoint("TOPLEFT", rootPanel.memory1, "BOTTOMLEFT", 0, -8);
	rootPanel:SetScript("OnShow", function(self)
		UpdateAddOnMemoryUsage()
		self.memory1:SetText(math.ceil(GetAddOnMemoryUsage("hfLootRoll")));
		self.memory2:SetText(math.ceil(GetAddOnMemoryUsage("hfLootLog")));
	end);
	--@end-debug@]===]
	
	module.rootPanel = rootPanel;

	local appearancePanel = module:InitAppearancePanel();
	appearancePanel.name = L"APPEARANCE";
	appearancePanel.okay = function(self)
		module.currentOptions.lastTime = time();
	end
	appearancePanel.cancel = function(self)
		module:Restore(backupOptions);
		module.currentOptions.lastTime = time();
	end
	appearancePanel.refresh = function(self)
		cloneTable(module.currentOptions, true, backupOptions);
	end
	appearancePanel.default = function(self)
		module:Restore(defaultOptions);
	end
	
	local function openSettings()
		module.optionsFrame:Show();
	end
	
	addon:GetModule('gui'):AddContextButton({
		notCheckable = true,
		text = L"OPEN_SETTINGS",
		func = openSettings,
	});
	
	addon:GetModule('slash'):AddCommand("settings", openSettings, L"SLASH_OPEN_SETTINGS");
	
	local behaviorPanel = module:InitBehaviorPanel();
	behaviorPanel.name = L"BEHAVIOR";
	behaviorPanel.default = function(self)
		module:Restore(defaultOptions);
	end
	
	local profilesPanel = module:InitProfilesPanel();
	profilesPanel.name = L"PRESETS";
	profilesPanel.default = function(self)
		module:Restore(defaultOptions);
	end
	
	module:Restore(module.initialOptions);
	
	module:AddSubPanel(profilesPanel);
	module:AddSubPanel(appearancePanel);
	module:AddSubPanel(behaviorPanel);
end

function module.onEvent.ANCHOR_TOGGLE(event, isShown)
	if ( not module.appearancePanel ) then
		return;
	end
	
	module.appearancePanel:SetControl("anchorLocked", not isShown);
end

function module:AddSubPanel(panel)
	tinsert(self.optionsFrame.categoriesList, {
		text = panel.name,
		value = panel,
	});
	self.optionsFrame.categories:Update();
end

examplesController.shown = false;
examplesController.timers = {};

-- ids must be negative, to prevent real rollID collision
examplesController.exmplParams = {
	{
		['quality'] = 3,
		['time'] = 3600,
		['bop']  = false,
		['icon'] = "Interface\\Icons\\INV_Misc_QuestionMark",
		['name'] = "Some rare item",
		['id']   = -3,
		['ilvl'] = 1,
		['slot'] = "",
	},
	{
		['quality'] = 2,
		['time'] = 120,
		['bop']  = false,
		['icon'] = "Interface\\Icons\\INV_Misc_Desecrated_PlateHelm",
		['name'] = "Some uncommon helmet, ilvl 100",
		['id']   = -4,
		['ilvl'] = 100,
		['slot'] = "INVTYPE_HEAD",
	},
	{
		['quality'] = 4,
		['time'] = 7200,
		['bop']  = true,
		['icon'] = "Interface\\Icons\\INV_Misc_Desecrated_PlateBracer",
		['name'] = "Some BoP epic wrist, ilvl 1000",
		['id']   = -1,
		['ilvl'] = 1000,
		['slot'] = "INVTYPE_WRIST",
	},
	{
		['quality'] = 3,
		['time'] = 60,
		['bop']  = true,
		['icon'] = "Interface\\Icons\\INV_Trinket_Naxxramas03",
		['name'] = "Some BoP rare trinket, ilvl 200",
		['id']   = -2,
		['ilvl'] = 200,
		['slot'] = "INVTYPE_TRINKET",
	},
};

examplesController.timer = 0;
local winnerSet = false;
local examplesControllerOnUpdate = function(self, elapsed)
	self.timer = self.timer + elapsed;
	if ( self.timer > 1 ) then
	
		for i, exmpl in ipairs(self.exmplParams) do
			local gui = addon:GetModule('gui');
			
			self.timers[i] = self.timers[i] - self.timer;
			
			local rollOpened = false;
			for _, frame in ipairs(gui.framesHolder.frames) do
				if ( frame.rollID == exmpl.id ) then
					rollOpened = true;
				end
			end
			
			if ( not rollOpened ) then
				self.timers[i] = exmpl.time + 2;
				gui.framesHolder:StartRoll(exmpl.id, exmpl.time, true, exmpl.icon
				                           , exmpl.quality, exmpl.bop, exmpl.name
										   , exmpl.ilvl, exmpl.slot);
			end
			
			if ( i == 4 ) then
				if ( (not winnerSet) and (self.timers[i] < (exmpl.time - 2)) ) then
					gui.framesHolder:CloseRoll(exmpl.id, "onfinish");
					gui.framesHolder:CloseRoll(exmpl.id, "onselect");
					gui.framesHolder:SetWinner(exmpl.id, "Winner");
					gui.framesHolder:LockRoll(exmpl.id);
					winnerSet = true;
				elseif ( winnerSet and (self.timers[i] > (exmpl.time - 2)) ) then
					winnerSet = false;
				end
			end
		end
		
		self.timer = 0;
	end
end

function examplesController:ShowExample()
	self.shown = true;
	local gui = addon:GetModule('gui');
	for i, exmpl in ipairs(self.exmplParams) do
		if ( i == 4 ) then
			winnerSet = false;
		end
		self.timers[i] = exmpl.time + 2;
		gui.framesHolder:StartRoll(exmpl.id, exmpl.time, true, exmpl.icon
								   , exmpl.quality, exmpl.bop, exmpl.name
								   , exmpl.ilvl, exmpl.slot);
	end
	self.timer = 0;
	self:SetScript("OnUpdate", examplesControllerOnUpdate);
end

function examplesController:HideExample()
	self:SetScript("OnUpdate", nil);
	self.shown = false;
	local gui = addon:GetModule('gui');
	for i, exmpl in ipairs(self.exmplParams) do
		gui.framesHolder:CloseRoll(exmpl.id, "force");
	end
end

function module:InitOptionsFrame()

	local optionsFrame = CreateFrame("Frame", "hfLootRollOptionsFrame", UIParent);
	
	optionsFrame.categoriesList = {};
	
	optionsFrame:Hide();
	optionsFrame:SetFrameStrata("HIGH");
	optionsFrame:SetHeight(540);
	optionsFrame:SetWidth(648);
	optionsFrame:SetPoint("CENTER");
	optionsFrame:SetBackdrop({
		bgFile = "Interface/DialogFrame/UI-DialogBox-Background",
		edgeFile = "Interface/DialogFrame/UI-DialogBox-Border",
		tile = true,
		tileSize = 32,
		edgeSize = 32,
		insets = {
			top = 12,
			left = 11,
			right = 11,
			bottom = 10,
		},
	});
	
	optionsFrame.cancel = CreateFrame("Button", "hfLootRollOptionsFrameCancel", optionsFrame, "UIPanelButtonTemplate");
	optionsFrame.cancel:SetWidth(96);
	optionsFrame.cancel:SetHeight(22);
	optionsFrame.cancel:SetPoint("BOTTOMRIGHT", -16, 16);
	optionsFrame.cancel:SetText(CANCEL);
	optionsFrame.cancel:SetScript("OnClick", function(self, button)
		for i, v in ipairs(optionsFrame.categoriesList) do
			if ( v.value.cancel ) then
				v.value:cancel();
			end
		end
		optionsFrame.exitByUser = true;
		optionsFrame:Hide();
	end);
	
	optionsFrame.okay = CreateFrame("Button", "hfLootRollOptionsFrameOkay", optionsFrame, "UIPanelButtonTemplate");
	optionsFrame.okay:SetWidth(96);
	optionsFrame.okay:SetHeight(22);
	optionsFrame.okay:SetPoint("BOTTOMRIGHT", optionsFrame.cancel, "BOTTOMLEFT");
	optionsFrame.okay:SetText(OKAY);
	optionsFrame.okay:SetScript("OnClick", function(self, button)
		for i, v in ipairs(optionsFrame.categoriesList) do
			if ( v.value.okay ) then
				v.value:okay();
			end
		end
		optionsFrame.exitByUser = true;
		optionsFrame:Hide();
	end);
	
	StaticPopupDialogs["CONFIRM_RESET_HFLOOTROLL_SETTINGS"] = { 
		text = L"CONFIRM_RESET_SETTINGS",
		button1 = YES,
		button2 = NO,
		OnAccept = function ()
			for i, v in ipairs(optionsFrame.categoriesList) do
				if ( v.value.default ) then
					v.value:default();
				end
				if ( v.value.refresh ) then
					v.value:refresh();
				end
			end
		end,
		OnCancel = function() end,
		timeout = 0,
		exclusive = 1,
		hideOnEscape = 1,
		whileDead = 1,
	};
	
	optionsFrame.defaults = CreateFrame("Button", "hfLootRollOptionsFrameDefaults", optionsFrame, "UIPanelButtonGrayTemplate");
	optionsFrame.defaults:SetWidth(96);
	optionsFrame.defaults:SetHeight(22);
	optionsFrame.defaults:SetPoint("BOTTOMLEFT", 16, 16);
	optionsFrame.defaults:SetText(DEFAULTS);
	optionsFrame.defaults:SetScript("OnClick", function(self, button)
		StaticPopup_Show("CONFIRM_RESET_HFLOOTROLL_SETTINGS");
	end);
	
	optionsFrame.categories = hf_Widgets.ScrollableList("hfLootRollOptionsFrameCategories", optionsFrame, true, "OPTIONS");
	optionsFrame.categories:SetWidth(175);
	optionsFrame.categories:SetPoint("TOPLEFT", 22, -25);
	optionsFrame.categories:SetPoint("BOTTOMLEFT", 22, 48);
	optionsFrame.categories:SetBackdrop({
		edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
		tile = true,
		tileSize = 16,
		edgeSize = 16,
		insets = {
			top = 5,
			left = 5,
			right = 5,
			bottom = 5,
		},
	});
	optionsFrame.categories:SetData(optionsFrame.categoriesList);
	optionsFrame.categories.setFunc = function(self, panel)
		optionsFrame.curPanel:Hide();
		optionsFrame.curPanel = panel;
		optionsFrame.container:SetScrollChild(panel);
		panel:Show();
		panel:SetPoint("TOPLEFT", 0, -7);
		panel:SetHeight(1);
		panel:SetWidth(430);
	end
	
	optionsFrame.container = CreateFrame("ScrollFrame", "hfLootRollOptionsFrameContainer", optionsFrame, "UIPanelScrollFrameTemplate");
	optionsFrame.container:SetPoint("TOPLEFT", optionsFrame.categories, "TOPRIGHT", 7, 0);
	optionsFrame.container:SetPoint("BOTTOMLEFT", optionsFrame.categories, "BOTTOMRIGHT", 7, 0);
	optionsFrame.container:SetPoint("RIGHT", -47, 0);
	optionsFrame.container:SetBackdrop({
		edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
		tile = true,
		tileSize = 16,
		edgeSize = 16,
		insets = {
			top = 5,
			left = 5,
			right = -45,
			bottom = 5,
		},
	});
	
	optionsFrame:SetScript("OnShow", function(self)
		self.exitByUser = false;
		for i, v in ipairs(self.categoriesList) do
			if ( v.value.refresh ) then
				v.value:refresh();
			end
		end
		if ( self.curPanel ) then
			self.curPanel:Hide();
		end
		self.curPanel = module.rootPanel;
		self.container:SetScrollChild(module.rootPanel);
		module.rootPanel:Show();
		module.rootPanel:SetPoint("TOPLEFT", 0, -7);
		module.rootPanel:SetHeight(1);
		module.rootPanel:SetWidth(430);
		self.categories:ClearSelection();
	end);
	
	optionsFrame:SetScript("OnHide", function(self)
		if ( not self.exitByUser ) then
			self.cancel:Click();
		end
	end);
	
	tinsert(UISpecialFrames, "hfLootRollOptionsFrame");
	
	self.optionsFrame = optionsFrame;
end

local LSMFont;
local LSMTexture;
local LSMBorderTexture;
function module:InitLSM()
	if ( LibSharedMedia and (not LSMinited) ) then
		local borders = LibSharedMedia:HashTable("border");
		local statusBars = LibSharedMedia:HashTable("statusbar");
		local fonts = LibSharedMedia:HashTable("font");
		for name, path in pairs(statusBars) do
			self.appearancePanel:SetControl("bgTexture", "add", path, nil, name);
		end
		for name, path in pairs(fonts) do
			self.appearancePanel:SetControl("font", "add", nil, path, name);
		end
		for name, path in pairs(borders) do
			if ( name ~= "None" ) then
				self.appearancePanel:SetControl("borderTexture", "add", path, nil, name);
			end
		end
		self.appearancePanel:SetControl("borderTexture", "set", LSMBorderTexture);
		self.appearancePanel:SetControl("bgTexture", "set", LSMTexture);
		self.appearancePanel:SetControl("font", "set", LSMFont);
		LSMinited = true;
	end
end

function module:InitAppearancePanel()

	self.currentOptions.configMode = false;
	
	local initialOptions = {};
	for option, value in pairs(self.currentOptions) do
		initialOptions[option] = (type(value) == "table") and cloneTable(value, true) or value;
	end
	LSMFont    = initialOptions.font;
	LSMTexture = initialOptions.bgTexture;
	LSMBorderTexture = initialOptions.borderTexture;

	local pos = initialOptions.anchorPos;
	addon:GetModule('gui').anchorFrame:ClearAllPoints();
	addon:GetModule('gui').anchorFrame:SetPoint(pos.point, pos.relativeTo, pos.relativePoint, pos.xOfs, pos.yOfs);
	addon:GetModule('gui').options.mainFramePos = pos;
	addon:GetModule('gui').anchorFrame:HookScript("OnMouseUp", function(self)
	
		-- reanchoring frame rel to bottom left corner in resizing purposes
		module.currentOptions.anchorPos.point         = "BOTTOMLEFT";
		module.currentOptions.anchorPos.relativeTo    = "UIParent";
		module.currentOptions.anchorPos.relativePoint = "BOTTOMLEFT";
		module.currentOptions.anchorPos.xOfs          = self:GetLeft();
		module.currentOptions.anchorPos.yOfs          = self:GetBottom();
		addon:FireEvent("SETTING_CHANGED", "AnchorPos", module.currentOptions.anchorPos);
	end);
	
	local scriptAnchorToggle = false;
	addon:GetModule('gui').anchorFrame:HookScript("OnHide", function(self)
		if ( scriptAnchorToggle ) then
			return;
		end
		module.appearancePanel:SetControl("anchorLocked", true);
	end);
	addon:GetModule('gui').anchorFrame:HookScript("OnShow", function(self)
		if ( scriptAnchorToggle ) then
			return;
		end
		module.appearancePanel:SetControl("anchorLocked", false);
	end);

	local panelScrollWrapper = CreateFrame("ScrollFrame", "hfLootRollOptionsPanelScroll", nil, "UIPanelScrollFrameTemplate");
	
	local panel = hf_Widgets.OptionsPanel("hfLootRollOptionsPanel");
	self.appearancePanel = panel;
	
	-- WIDGETS
	
	panel:LinkOptionsTable(self.currentOptions);
	
	panel:AddSubPanel("root");
	
	panel:EndLine("root", -20);
	
	panel:AddControl("root"
		, false
		, "hfLootRollOptionsConfigMode"
		, "checkBox"
		, "configMode"
		, function(checked)
			if ( checked ) then
				examplesController:ShowExample();
				module.appearancePanel.resizer:Place();
				module.appearancePanel.resizer:Show();
			else
				examplesController:HideExample();
				module.appearancePanel.resizer:Hide();
			end
			addon:FireEvent("SETTING_CHANGED", "ConfigMode", checked);
		end
		, L"CONFIG_MODE"
	);
	
	panel:AddSubPanel("tabs");
	
	panel:AddTabbedFrame("tabs", 395, L"OPTIONS_TAB_GENERAL");
	
	panel:AddControl("tabs"
		, false
		, "hfLootRollOptionsTextureSelector"
		, "mediaDropDown"
		, "bgTexture"
		, function(texture, font)
			addon:FireEvent("SETTING_CHANGED", "Texture", texture);
		end
		, L"BAR_TEXTURE"
		, {
			{
				["texture"] = "Interface\\AddOns\\" .. ADDON_NAME .. "\\textures\\Smoothv2",
				["text"]    = "Smoothv2",
			},
			{
				["texture"] = "Interface\\AddOns\\" .. ADDON_NAME .. "\\textures\\Simple",
				["text"]    = "Simple",
			},
		}
		, "texture"
	);

	panel:AddControl("tabs"
		, false
		, "hfLootRollOptionsShowTimeBar"
		, "checkBox"
		, "useBgTime"
		, function(checked)
			addon:FireEvent("SETTING_CHANGED", "UseBgTime", checked);
		end
		, L"BAR_TIMER"
	);
	
	panel:EndLine("tabs", 32);
	
	panel:AddControl("tabs"
		, false
		, "hfLootRollOptionsColorBkg"
		, "colorSwatch"
		, "default"
		, function(r, g, b)
			addon:FireEvent("SETTING_CHANGED", "Color", "Bg", r, g, b);
		end
		, L"BACKGROUND"
		, false
	);
	
	panel:EndLine("tabs", 38);
	
	panel:AddControl("tabs"
		, false
		, "hfLootRollOptionsFontSelector"
		, "mediaDropDown"
		, "font"
		, function(texture, font)
			addon:FireEvent("SETTING_CHANGED", "Font", font);
		end
		, L"FONT"
		, {
			{
				["font"] = GameFontNormal:GetFont(), 
				["text"] = "default",
			},
		}
		, "font"
	);
	
	panel:AddControl("tabs"
		, true
		, "hfLootRollOptionsFontSize"
		, "slider"
		, "fontSize"
		, function(value)
			addon:FireEvent("SETTING_CHANGED", "FontSize", value);
		end
		, L"FONT_SIZE"
		, 8
		, 25
		, 1
		, 0
		, true
	);
	
	panel:AddControl("tabs"
		, false
		, "hfLootRollOptionsScale"
		, "slider"
		, "scale"
		, function(value)
			addon:FireEvent("SETTING_CHANGED", "ButtonScale", value);
		end
		, L"BUTTONS_SCALE"
		, 0.3
		, 3
		, 0.05
		, 2
		, true
	);
	
	panel:AddControl("tabs"
		, true
		, "hfLootRollOptionsIconScale"
		, "slider"
		, "iconScale"
		, function(value)
			addon:FireEvent("SETTING_CHANGED", "IconScale", value);
		end
		, L"ICON_SCALE"
		, 0.3
		, 3
		, 0.05
		, 2
		, true
	);
	
	panel:AddControl("tabs"
		, false
		, "hfLootRollOptionsOpacity"
		, "slider"
		, "opacity"
		, function(value)
			addon:FireEvent("SETTING_CHANGED", "Opacity", value);
		end
		, L"BAR_OPACITY"
		, 0
		, 1
		, 0.05
		, 2
		, true
	);
	
	panel:AddControl("tabs"
		, true
		, "hfLootRollOptionsSparkOpacity"
		, "slider"
		, "sparkOpacity"
		, function(value)
			addon:FireEvent("SETTING_CHANGED", "SparkOpacity", value);
		end
		, L"SPARK_OPACITY"
		, 0
		, 1
		, 0.05
		, 2
		, true
	);
	
	panel:AddControl("tabs"
		, false
		, "hfLootRollOptionsCombatOpacity"
		, "slider"
		, "combatOpacity"
		, function(value)
			addon:FireEvent("SETTING_CHANGED", "CombatOpacity", value);
		end
		, L"INCOMBAT_OPACITY"
		, 0
		, 1
		, 0.05
		, 2
		, true
	);
	
	panel:EndLine("tabs", 40);
	
	panel:AddControl("tabs"
		, false
		, "hfLootRollOptionsShowBoP"
		, "checkBox"
		, "showBoP"
		, function(checked)
			addon:FireEvent("SETTING_CHANGED", "ShowBoP", checked);
		end
		, L"SHOW_BOP"
	);
	
	panel:EndLine("tabs", 30);
	
	panel:AddControl("tabs"
		, true
		, "hfLootRollOptionsShowILvl"
		, "checkBox"
		, "showILvl"
		, function(checked)
			addon:FireEvent("SETTING_CHANGED", "ShowILvl", checked);
		end
		, L"SHOW_ILVL_ICON"
	);
	
	panel:AddTab("tabs", L"OPTIONS_TAB_POSITION");
	
	panel:AddControl("tabs"
		, false
		, "hfLootRollOptionsAnchorLock"
		, "checkBox"
		, "anchorLocked"
		, function(checked)
			scriptAnchorToggle = true;
			addon:FireEvent("SETTING_CHANGED", "AnchorLock", checked);
			scriptAnchorToggle = false;
		end
		, L"LOCK_FRAMES"
	);
	
	panel:AddControl("tabs"
		, true
		, "hfLootRollOptionsPositionReset"
		, "button"
		, nil
		, function()
			panel:SetControl("anchorLocked", false);
			cloneTable(defaultOptions.anchorPos, false, module.currentOptions.anchorPos);
			addon:FireEvent("SETTING_CHANGED", "AnchorPos", module.currentOptions.anchorPos);
		end
		, L"POSITION_RESET"
	);
	
	panel:AddControl("tabs"
		, false
		, "hfLootRollOptionsHeight"
		, "slider"
		, "height"
		, function(value)
			if ( not panel.resizer.isResizing ) then
				panel.resizer:Place();
			end
			addon:FireEvent("SETTING_CHANGED", "Height", value);
		end
		, L"HEIGHT"
		, MIN_BAR_HEIGHT
		, MAX_BAR_HEIGHT
		, 1
		, 0
		, true
		, true
		, 200
		, MIN_BAR_HEIGHT+1
	);

	panel:AddControl("tabs"
		, true
		, "hfLootRollOptionsOffset"
		, "slider"
		, "offset"
		, function(value)
			addon:FireEvent("SETTING_CHANGED", "Offset", value);
		end
		, L"OFFSET"
		, 0
		, 200
		, 1
		, 0
		, true
		, true
		, 100
		, 20
	);
	
	panel:AddControl("tabs"
		, false
		, "hfLootRollOptionsWidth"
		, "slider"
		, "width"
		, function(value)
			if ( not panel.resizer.isResizing ) then
				panel.resizer:Place();
			end
			addon:FireEvent("SETTING_CHANGED", "Width", value);
		end
		, L"WIDTH"
		, MIN_BAR_WIDTH
		, MAX_BAR_WIDTH
		, 1
		, 0
		, true
		, true
		, 200
		, MIN_BAR_WIDTH+1
	);
	
	panel:AddControl("tabs"
		, true
		, "hfLootRollOptionsGrowthDir"
		, "dropDown"
		, "direction"
		, function(value)
			panel.resizer:UpdateAnchoring();
			addon:FireEvent("SETTING_CHANGED", "Direction", value);
		end
		, L"GROWTH_DIRECTION"
		, {
			{
				value = "UP",
				text  = L"DIR_UP",
			},
			{
				value = "DOWN",
				text  = L"DIR_DOWN",
			},
		}
	);
	
	panel:AddTab("tabs", L"OPTIONS_TAB_COLORS");
	
	panel:AddControl("tabs"
		, false
		, "hfLootRollOptionsColorUncommon"
		, "colorSwatch"
		, "uncom"
		, function(r, g, b)
			addon:FireEvent("SETTING_CHANGED", "Color", "Uncommon", r, g, b);
		end
		, select(4, GetItemQualityColor(2)) .. _G["ITEM_QUALITY2_DESC"] .. "|r"
		, false
	);
	
	panel:EndLine("tabs", 30);
	
	panel:AddControl("tabs"
		, false
		, "hfLootRollOptionsColorRare"
		, "colorSwatch"
		, "rare"
		, function(r, g, b)
			addon:FireEvent("SETTING_CHANGED", "Color", "Rare", r, g, b);
		end
		, select(4, GetItemQualityColor(3)) .. _G["ITEM_QUALITY3_DESC"] .. "|r"
		, false
	);
	
	panel:EndLine("tabs", 30);

	panel:AddControl("tabs"
		, false
		, "hfLootRollOptionsColorEpic"
		, "colorSwatch"
		, "epic"
		, function(r, g, b)
			addon:FireEvent("SETTING_CHANGED", "Color", "Epic", r, g, b);
		end
		, select(4, GetItemQualityColor(4)) .. _G["ITEM_QUALITY4_DESC"] .. "|r"
		, false
	);
	
	panel:EndLine("tabs", 35);
	
	panel:AddControl("tabs"
		, false
		, "hfLootRollOptionsColorsReset"
		, "button"
		, nil
		, function()
			local d = defaultOptions;
			panel:SetControl("uncom", d.uncom.r, d.uncom.g, d.uncom.b);
			panel:SetControl("rare", d.rare.r, d.rare.g, d.rare.b);
			panel:SetControl("epic", d.epic.r, d.epic.g, d.epic.b);
		end
		, L"COLORS_RESET"
	);
	
	panel:AddTab("tabs", L"OPTIONS_TAB_BORDER");
	
	panel:AddControl("tabs"
		, false
		, "hfLootRollOptionsBorderTextureSelector"
		, "mediaDropDown"
		, "borderTexture"
		, function(texture, font)
			addon:FireEvent("SETTING_CHANGED", "BorderTexture", texture);
		end
		, L"BORDER_TEXTURE"
		, {
			{
				["texture"] = "none",
				["text"]    = NONE,
			},
		}
		, "texture"
	);
	
	panel:AddControl("tabs"
		, true
		, "hfLootRollOptionsBorderSize"
		, "slider"
		, "borderSize"
		, function(value)
			addon:FireEvent("SETTING_CHANGED", "BorderSize", value);
		end
		, L"BORDER_SIZE"
		, 1
		, 40
		, 1
		, 0
		, true
	);
	
	panel:AddControl("tabs"
		, true
		, "hfLootRollOptionsBorderOffset"
		, "slider"
		, "borderOffset"
		, function(value)
			addon:FireEvent("SETTING_CHANGED", "BorderOffset", value);
		end
		, L"BORDER_OFFSET"
		, -40
		, 40
		, 1
		, 0
		, true
	);
	
	panel:AddControl("tabs"
		, false
		, "hfLootRollOptionsBorderColor"
		, "colorSwatch"
		, "borderColor"
		, function(r, g, b, a)
			addon:FireEvent("SETTING_CHANGED", "Color", "Border", r, g, b, a);
		end
		, L"BORDER_COLOR"
		, true
	);
	
	panel:AddControl("tabs"
		, true
		, "hfLootRollOptionsBorderColorByQuality"
		, "checkBox"
		, "borderColorByQuality"
		, function(checked)
			addon:FireEvent("SETTING_CHANGED", "BorderColorByQuality", checked);
		end
		, L"BORDER_COLOR_BY_QUALITY"
	);
	
	panel:AddTab("tabs", L"OPTIONS_TAB_TOOLTIPS");
	
	panel:AddControl("tabs"
		, false
		, "hfLootRollOptionsShowWhoInTooltip"
		, "checkBox"
		, "showWho"
		, function(checked)
			addon:FireEvent("SETTING_CHANGED", "ShowWho", checked);
		end
		, L"SHOW_WHO"
	);
	
	panel:EndLine("tabs", 25);
	
	panel:Indent("tabs", 30);
	
	panel:AddControl("tabs"
		, false
		, "hfLootRollOptionsShowWhoColorize"
		, "checkBox"
		, "showWhoColorize"
		, function(checked)
			addon:FireEvent("SETTING_CHANGED", "ShowWhoColorize", checked);
		end
		, L"COLOR_NAMES_BY_CLASS"
	);
	
	panel:EndLine("tabs", 30);
	
	panel:AddControl("tabs"
		, false
		, "hfLootRollOptionsShowTooltipOnIcon"
		, "checkBox"
		, "showTTOnIconOnly"
		, function(checked)
			addon:FireEvent("SETTING_CHANGED", "ShowTTIconOnly", not checked);
		end
		, L"TOOLTIP_ON_ICON"
	);
	
	panel:EndLine("tabs", 30);
	
	panel:AddControl("tabs"
		, false
		, "hfLootRollOptionsComparison"
		, "checkBox"
		, "showComparisonTT"
		, function(checked)
			addon:FireEvent("SETTING_CHANGED", "Comparison", checked);
		end
		, L"COMPARISON_TOOLTIP"
	);
	
	panel:AddTab("tabs", L"OPTIONS_TAB_ITEMNAME");
	
	panel:AddControl("tabs"
		, false
		, "hfLootRollOptionsShowName"
		, "checkBox"
		, "nameShow"
		, function(checked)
			addon:FireEvent("SETTING_CHANGED", "NameShow", checked);
		end
		, L"SHOW_ITEM_NAME"
	);
	
	panel:EndLine("tabs", 40);
	
	panel:AddControl("tabs"
		, false
		, "hfLootRollOptionsColorName"
		, "colorSwatch"
		, "nameColor"
		, function(r, g, b, a)
			addon:FireEvent("SETTING_CHANGED", "Color", "Item", r, g, b, a);
		end
		, L"ITEM_NAME_COLOR"
		, true
	);
	
	panel:AddControl("tabs"
		, true
		, "hfLootRollOptionsNameClrByQlty"
		, "checkBox"
		, "nameColorByQuality"
		, function(checked)
			addon:FireEvent("SETTING_CHANGED", "NameColorByQuality", checked);
		end
		, L"ITEM_NAME_COLOR_BY_QUALITY"
	);
	
	panel:AddControl("tabs"
		, false
		, "hfLootRollOptionsNameJustifyH"
		, "dropDown"
		, "nameJustifyH"
		, function(value)
			addon:FireEvent("SETTING_CHANGED", "NameJustifyH", value);
		end
		, L"JUSTIFY_HORIZONTAL"
		, {
			{
				value = "LEFT",
				text  = L"JUSTIFY_LEFT",
			},
			{
				value = "CENTER",
				text  = L"JUSTIFY_CENTER",
			},
			{
				value = "RIGHT",
				text  = L"JUSTIFY_RIGHT",
			},
		}
	);
	
	panel:AddControl("tabs"
		, true
		, "hfLootRollOptionsNameOffsetX"
		, "slider"
		, "nameOffsetX"
		, function(value)
			addon:FireEvent("SETTING_CHANGED", "NameOffsetX", value);
		end
		, L"OFFSET_X"
		, nil
		, nil
		, 1
		, 0
		, true
		, true
		, 80
		, 0
	);
	
	panel:AddControl("tabs"
		, false
		, "hfLootRollOptionsNameJustifyV"
		, "dropDown"
		, "nameJustifyV"
		, function(value)
			addon:FireEvent("SETTING_CHANGED", "NameJustifyV", value);
		end
		, L"JUSTIFY_VERTICAL"
		, {
			{
				value = "TOP",
				text  = L"JUSTIFY_TOP",
			},
			{
				value = "MIDDLE",
				text  = L"JUSTIFY_MIDDLE",
			},
			{
				value = "BOTTOM",
				text  = L"JUSTIFY_BOTTOM",
			},
		}
	);
	
	panel:AddControl("tabs"
		, true
		, "hfLootRollOptionsNameOffsetY"
		, "slider"
		, "nameOffsetY"
		, function(value)
			addon:FireEvent("SETTING_CHANGED", "NameOffsetY", value);
		end
		, L"OFFSET_Y"
		, nil
		, nil
		, 1
		, 0
		, true
		, true
		, 80
		, 0
	);

	panel:AddControl("tabs"
		, true
		, "hfLootRollOptionsNameFontSize"
		, "slider"
		, "nameFontSize"
		, function(value)
			addon:FireEvent("SETTING_CHANGED", "NameFontSize", value);
		end
		, L"FONT_SIZE"
		, 8
		, 25
		, 1
		, 0
		, true
	);
	
	panel:AddTab("tabs", L"OPTIONS_TAB_WINNERNAME");
	
	panel:AddControl("tabs"
		, false
		, "hfLootRollOptionsShowWinnerName"
		, "checkBox"
		, "winnerShow"
		, function(checked)
			addon:FireEvent("SETTING_CHANGED", "WinnerShow", checked);
		end
		, L"SHOW_WINNER_NAME"
	);
	
	panel:EndLine("tabs", 40);
	
	panel:AddControl("tabs"
		, false
		, "hfLootRollOptionsColorWinnerName"
		, "colorSwatch"
		, "winnerNameColor"
		, function(r, g, b, a)
			addon:FireEvent("SETTING_CHANGED", "Color", "Winner", r, g, b, a);
		end
		, L"WINNER_NAME_COLOR"
		, true
	);
	
	panel:AddControl("tabs"
		, true
		, "hfLootRollOptionsWinnerNameClrByClass"
		, "checkBox"
		, "winnerNameColorByClass"
		, function(checked)
			addon:FireEvent("SETTING_CHANGED", "WinnerNameColorByClass", checked);
		end
		, L"WINNER_NAME_COLOR_BY_CLASS"
	);
	
	panel:AddControl("tabs"
		, false
		, "hfLootRollOptionsWinnerNameJustifyH"
		, "dropDown"
		, "winnerNameJustifyH"
		, function(value)
			addon:FireEvent("SETTING_CHANGED", "WinnerNameJustifyH", value);
		end
		, L"JUSTIFY_HORIZONTAL"
		, {
			{
				value = "LEFT",
				text  = L"JUSTIFY_LEFT",
			},
			{
				value = "CENTER",
				text  = L"JUSTIFY_CENTER",
			},
			{
				value = "RIGHT",
				text  = L"JUSTIFY_RIGHT",
			},
		}
	);
	
	panel:AddControl("tabs"
		, true
		, "hfLootRollOptionsWinnerNameOffsetX"
		, "slider"
		, "winnerNameOffsetX"
		, function(value)
			addon:FireEvent("SETTING_CHANGED", "WinnerNameOffsetX", value);
		end
		, L"OFFSET_X"
		, nil
		, nil
		, 1
		, 0
		, true
		, true
		, 80
		, 0
	);
	
	panel:AddControl("tabs"
		, false
		, "hfLootRollOptionsWinnerNameJustifyV"
		, "dropDown"
		, "winnerNameJustifyV"
		, function(value)
			addon:FireEvent("SETTING_CHANGED", "WinnerNameJustifyV", value);
		end
		, L"JUSTIFY_VERTICAL"
		, {
			{
				value = "TOP",
				text  = L"JUSTIFY_TOP",
			},
			{
				value = "MIDDLE",
				text  = L"JUSTIFY_MIDDLE",
			},
			{
				value = "BOTTOM",
				text  = L"JUSTIFY_BOTTOM",
			},
		}
	);
	
	panel:AddControl("tabs"
		, true
		, "hfLootRollOptionsWinnerNameOffsetY"
		, "slider"
		, "winnerNameOffsetY"
		, function(value)
			addon:FireEvent("SETTING_CHANGED", "WinnerNameOffsetY", value);
		end
		, L"OFFSET_Y"
		, nil
		, nil
		, 1
		, 0
		, true
		, true
		, 80
		, 0
	);

	panel:AddControl("tabs"
		, true
		, "hfLootRollOptionsWinnerNameFontSize"
		, "slider"
		, "winnerNameFontSize"
		, function(value)
			addon:FireEvent("SETTING_CHANGED", "WinnerNameFontSize", value);
		end
		, L"FONT_SIZE"
		, 8
		, 25
		, 1
		, 0
		, true
	);
	
	panel:EndTabbedFrame("tabs");
	
	-- easy resize
	local firstFrame = addon:GetModule('gui').framesWrapper;
	panel.resizer = CreateFrame("Frame", "hfLootRollFramesResizePoint", UIParent);
	panel.resizer.point1 = "TOPLEFT";
	panel.resizer.point2 = "BOTTOMRIGHT";
	panel.resizer.point3 = "BOTTOMLEFT";
	panel.resizer.dir    = -1;
	panel.resizer:SetSize(15, 15);
	panel.resizer.tex = panel.resizer:CreateTexture("hfLootRollFramesResizePointTexture", "ARTWORK");
	panel.resizer.tex:SetTexture("Interface\\AddOns\\" .. ADDON_NAME .. "\\textures\\round");
	panel.resizer.tex:SetAllPoints();
	panel.resizer.tex:SetVertexColor(.9, .1, .1);
	panel.resizer.hint = panel.resizer:CreateFontString("hfLootRollFramesResizePointHint", "OVERLAY", "GameFontRed");
	panel.resizer.hint:SetPoint("TOPLEFT", panel.resizer, "CENTER", 7, -7);
	panel.resizer.hint:SetText(L"RESIZER_HINT");
	panel.resizer.hint:SetJustifyH("LEFT");
	panel.resizer.hint:SetJustifyV("TOP");
	panel.resizer.hint:SetSize(80, 50);
	panel.resizer:SetMovable(true);
	panel.resizer:EnableMouse(true);
	panel.resizer:SetUserPlaced(false);
	panel.resizer:SetToplevel(true);
	panel.resizer:SetScript("OnMouseDown", function(self, button)
		if ( button == "LeftButton" ) then
			self.isResizing = 1;
			self:StartMoving()
			addon:GetModule('gui').framesWrapper:SetAlpha(module.currentOptions.opacity/2.5);
		end
	end)
	panel.resizer:SetScript("OnMouseUp", function(self)
		self.isResizing = nil;
		self:StopMovingOrSizing();
		self:SetUserPlaced(false);
		self:Place()
		addon:GetModule('gui').framesWrapper:SetAlpha(1);
	end);
	panel.resizerwrap = CreateFrame("Frame", "hfLootRollFramesResizeWrap", UIParent);
	panel.resizerwrap:SetPoint(panel.resizer.point1, firstFrame, panel.resizer.point3);
	panel.resizerwrap:SetPoint(panel.resizer.point2, panel.resizer, "CENTER");
	panel.resizerwrap:SetScript("OnSizeChanged", function(self, width, height)
		if ( panel.resizer.isResizing ) then
			panel:SetControl("width", width);
			panel:SetControl("height", height);
		
			-- forbid moving resizer out of bounds		
			local relX, relY;
			if ( panel.resizer.dir == 1 ) then
				local left, top = firstFrame:GetLeft(), firstFrame:GetTop();
				relX, relY = left, top;
			else
				local left, bottom = firstFrame:GetLeft(), firstFrame:GetBottom();
				relX, relY = left, bottom;
			end
			
			local mouseX, mouseY = GetCursorPosition();
			mouseX = mouseX / UIParent:GetScale();
			mouseY = mouseY / UIParent:GetScale();
			
			local distX = (mouseX - relX);
			local distY = ((mouseY - relY)) * panel.resizer.dir;
			
			if ( distX > MAX_BAR_WIDTH ) then
				panel:SetControl("width", MAX_BAR_WIDTH);
				panel.resizer:UpdateAnchoring();
			elseif ( distX < MIN_BAR_WIDTH ) then
				panel:SetControl("width", MIN_BAR_WIDTH);
				panel.resizer:UpdateAnchoring();
			end
			if ( distY > MAX_BAR_HEIGHT ) then
				panel:SetControl("height", MAX_BAR_HEIGHT);
				panel.resizer:UpdateAnchoring();
			elseif ( distY < MIN_BAR_HEIGHT ) then
				panel:SetControl("height", MIN_BAR_HEIGHT);
				panel.resizer:UpdateAnchoring();
			end
		end
	end);
	panel.resizer:Hide();
	function panel.resizer:Place()
		self:ClearAllPoints();
		local xpos = module.currentOptions.width or defaultOptions.width;
		local ypos = self.dir * ((module.currentOptions.height or defaultOptions.height)
			+ addon:GetModule('gui').anchorFrame:GetHeight());
		self:SetPoint("CENTER", firstFrame, self.point1, xpos, ypos);
	end
	function panel.resizer:UpdateAnchoring()
		if ( module.currentOptions.direction == "UP" ) then
			self.point1 = "BOTTOMLEFT";
			self.point2 = "TOPRIGHT";
			self.point3 = "TOPLEFT";
			self.dir    = 1;
		elseif ( module.currentOptions.direction == "DOWN" ) then
			self.point1 = "TOPLEFT";
			self.point2 = "BOTTOMRIGHT";
			self.point3 = "BOTTOMLEFT";
			self.dir    = -1;
		end
		self:Place();
		panel.resizerwrap:ClearAllPoints();
		panel.resizerwrap:SetPoint(self.point1, firstFrame, self.point3);
		panel.resizerwrap:SetPoint(self.point2, self, "CENTER");
	end
	
	module.initialOptions = initialOptions;
	
	return panel;
end

function module:InitBehaviorPanel()
	
	local _curMode = 0;
	
	local initialOptions = {};
	for option, value in pairs(self.currentOptions.behavior) do
		initialOptions[option] = (type(value) == "table") and cloneTable(value, true) or value;
	end
	
	local panel = hf_Widgets.OptionsPanel("hfLootRollOptionsPanel");
	
	self.behaviorPanel = panel;
	
	panel:LinkOptionsTable(self.currentOptions.behavior);
	
	panel:AddSubPanel("behaviorTabs");
	
	panel:EndLine("behaviorTabs", -16);
	
	panel:AddTabbedFrame("behaviorTabs", 425, L"OPTIONS_TAB_GENERAL");
	
	panel:AddControl("behaviorTabs"
		, false
		, "hfLootRollOptionsCloseButton"
		, "dropDown"
		, "closeButton"
		, function(value)
			addon:FireEvent("SETTING_CHANGED", "CloseButton", value);
		end
		, L"CLOSE_MOUSE_BUTTON"
		, {
			{
				value = "n/a",
				text  = L"BUTTON_NA",
			},
			{
				value = "LeftButton",
				text  = L"BUTTON_LEFT",
			},
			{
				value = "RightButton",
				text  = L"BUTTON_RIGHT",
			},
			{
				value = "MiddleButton",
				text  = L"BUTTON_MIDDLE",
			},
			{
				value = "Button4",
				text  = L"BUTTON_4",
			},
			{
				value = "Button5",
				text  = L"BUTTON_5",
			},
		}
	);
	
	panel:AddControl("behaviorTabs"
		, true
		, "hfLootRollOptionsCloseButtonModifier"
		, "dropDown"
		, "closeButtonModifier"
		, function(value)
			addon:FireEvent("SETTING_CHANGED", "CloseButtonModifier", value);
		end
		, L"CLOSE_MOUSE_BUTTON_MODIFIER"
		, {
			{
				value = "n/a",
				text  = L"BUTTON_NA",
			},
			{
				value = "SHIFT",
				text  = "Shift",
			},
			{
				value = "CTRL",
				text  = "Ctrl",
			},
			{
				value = "ALT",
				text  = "Alt",
			},
		}
	);
	
	panel:EndLine("behaviorTabs", 20);

	panel:AddControl("behaviorTabs"
		, true
		, "hfLootRollOptionsMaxPanels"
		, "slider"
		, "maxPanels"
		, function(value)
			addon:FireEvent("SETTING_CHANGED", "MaxPanels", value);
		end
		, L"MAX_FRAMES"
		, 4  -- should _not_ be lesser than 4
		, 20 -- should _not_ be higher than FRAMES_NUM_HARDCAP defined in hfLootFramesHolder.lua
		, 1
		, 0
		, true
	);
	
	panel:AddControl("behaviorTabs"
		, false
		, "hfLootRollOptionsClickthroughIncombat"
		, "checkBox"
		, "clickthroughInCombat"
		, function(checked)
			addon:FireEvent("SETTING_CHANGED", "ClickthroughInCombat", checked);
		end
		, L"INCOMBAT_CLICKTHROUGH"
	);
	
	panel:EndLine("behaviorTabs", 40);
	
	panel:Indent("behaviorTabs", 30);
	
	panel:AddControl("behaviorTabs"
		, true
		, "hfLootRollOptionsForceInteractionInCombat"
		, "dropDown"
		, "inCombatInteractionModifier"
		, function(value)
			addon:FireEvent("SETTING_CHANGED", "InCombatInteractionModifier", value);
		end
		, L"INCOMBAT_INTERACTION_MODIFIER"
		, {
			{
				value = "SHIFT",
				text  = "Shift",
			},
			{
				value = "CTRL",
				text  = "Ctrl",
			},
			{
				value = "ALT",
				text  = "Alt",
			},
		}
	);
	
	panel:AddControl("behaviorTabs"
		, true
		, "hfLootRollOptionsSuppressConfirm"
		, "checkBox"
		, "autoconfirm"
		, function(checked)
			addon:FireEvent("SETTING_CHANGED", "Autoconfirm", checked);
		end
		, L"AUTOCONFIRM"
	);
	
	panel:AddTab("behaviorTabs", L"DISAPPEAR_DELAY");
	
	panel:AddControl("behaviorTabs"
		, false
		, "hfLootRollOptionsDisappearAfterSelect"
		, "checkBox"
		, "disappearAfterSelect"
		, function(checked)
			if ( checked ) then
				_curMode = 0;
				panel:SetControl("disappearAfterRollFinish", false);
				panel:SetControl("disappearManually", false);
			else
				if ( _curMode == 0 ) then
					panel:SetControl("disappearAfterSelect", true);
					return;
				end
			end
			if ( checked ) then
				addon:FireEvent("SETTING_CHANGED", "DelayMode", "onselect");
			end
		end
		, L"DISAPPEAR_AFTER_SELECT"
	);
	
	panel:EndLine("behaviorTabs", 40);
	
	panel:Indent("behaviorTabs", 30);
	
	panel:AddControl("behaviorTabs"
		, false
		, "hfLootRollOptionsDisappearAfterSelectionDelay"
		, "slider"
		, "disappearAfterSelectDelay"
		, function(value)
			addon:FireEvent("SETTING_CHANGED", "DelayAfterSelect", value);
		end
		, L"DISAPPEAR_DELAY_TIME"
		, 0
		, nil
		, 1
		, 0
		, true
		, true
		, 10
		, 0
	);
	
	panel:EndLine("behaviorTabs", 40);
	
	panel:AddControl("behaviorTabs"
		, false
		, "hfLootRollOptionsDisappearAfterRollFinish"
		, "checkBox"
		, "disappearAfterRollFinish"
		, function(checked)
			if ( checked ) then
				_curMode = 1;
				panel:SetControl("disappearAfterSelect", false);
				panel:SetControl("disappearManually", false);
			else
				if ( _curMode == 1 ) then
					panel:SetControl("disappearAfterRollFinish", true);
					return;
				end
			end
			if ( checked ) then
				addon:FireEvent("SETTING_CHANGED", "DelayMode", "onfinish");
			end
		end
		, L"DISAPPEAR_AFTER_ROLL"
	);
	
	panel:EndLine("behaviorTabs", 40);
	
	panel:Indent("behaviorTabs", 30);
	
	panel:AddControl("behaviorTabs"
		, false
		, "hfLootRollOptionsDisappearAfterRollFinishDelay"
		, "slider"
		, "disappearAfterRollFinishDelay"
		, function(value)
			addon:FireEvent("SETTING_CHANGED", "DelayAfterFinish", value);
		end
		, L"DISAPPEAR_DELAY_TIME"
		, 0
		, nil
		, 1
		, 0
		, true
		, true
		, 10
		, 0
	);
	
	panel:EndLine("behaviorTabs", 40);
	
	panel:AddControl("behaviorTabs"
		, false
		, "hfLootRollOptionsDisappearManually"
		, "checkBox"
		, "disappearManually"
		, function(checked)
			if ( checked ) then
				_curMode = 3;
				panel:SetControl("disappearAfterSelect", false);
				panel:SetControl("disappearAfterRollFinish", false);
			else
				if ( _curMode == 3 ) then
					panel:SetControl("disappearManually", true);
					return;
				end
			end
			if ( checked ) then
				addon:FireEvent("SETTING_CHANGED", "DelayMode", "manual");
			end
		end
		, L"DISAPPEAR_MANUALLY"
	);
	
	panel:EndTabbedFrame("behaviorTabs");

	module.initialOptions.behavior = initialOptions;
	
	return panel;
	
end

function module:InitProfilesPanel()
	local panel = CreateFrame("Frame", "hfLootRollProfilesPanel");
	
	local function profileInfo(profileString)
		if ( profileString == nil ) then
			return nil;
		end
		
		local pname;
		local ptype;
		local divIndex = strfind(profileString, ":");
		ptype = strsub(profileString, 1, divIndex-1);
		pname = strsub(profileString, divIndex+1);
		return ptype, pname;
	end
	
	local data = {};
	local dataCustom = {};
	local dataChars = {};
	local function updateProfilesList()
		wipe(data);
		wipe(dataCustom);
		wipe(dataChars);
		for pname in pairs(module.globalOptions.custom) do
			tinsert(dataCustom, {text = pname, value = "custom:" .. pname});
		end
		sort(dataCustom, function(a, b) return a.text < b.text end)
		for pname in pairs(module.globalOptions.perCharacter) do
			tinsert(dataChars, 1, {text = pname, value = "character:" .. pname});
		end
		sort(dataChars, function(a, b) return a.text < b.text end)
		for _, v in ipairs(dataChars) do
			tinsert(data, v);
		end
		for _, v in ipairs(dataCustom) do
			tinsert(data, v);
		end
		panel.lstProfiles:SetData(data);
	end
	
	panel.lstProfiles = hf_Widgets.ScrollableList("hfLootRollProfilesList", panel, true);
	panel.lstProfiles.setFunc = function(self, value)
		panel.selected = value;
		local ptype, pname = profileInfo(value);
		if ( (ptype == "character") and (pname == const.PLAYER_NAME_FULL) ) then
			panel.btnRemove:Disable();
			panel.btnLoad:Disable();
		else
			panel.btnRemove:Enable();
			panel.btnLoad:Enable();
		end
	end
	panel.lstProfiles.label = panel:CreateFontString("hfLootRollProfilesListLabel", nil, "GameFontNormal");
	panel.lstProfiles.label:SetPoint("TOPLEFT", 16, -6);
	panel.lstProfiles.label:SetText(L"AVAILABLE_PRESETS");
	panel.lstProfiles:SetBackdrop({
		bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
		edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
		edgeSize = 16,
		tile = true,
		tileSize = 16,
		insets = {
			left = 4,
			right = 4,
			bottom = 4,
			top = 4,
		}
	});
	panel.lstProfiles:SetPoint("TOPLEFT", panel.lstProfiles.label, "BOTTOMLEFT", 0, -3);
	panel.lstProfiles:SetWidth(360);
	panel.lstProfiles:SetHeight(333);
	
	StaticPopupDialogs["HFLOOTROLL_PROFILE_NEW"] = {
		text = L"PRESET_NEW_POPUP",
		button1 = OKAY,
		button2 = CANCEL,
		hasEditBox = 1,
		OnShow = function(self)
			self.button1:Disable();
		end,
		EditBoxOnEnterPressed = function(self)
			text = self:GetText();
			local parent = self:GetParent();
			local editBox = parent.editBox;
			module:NewCustomProfile(text);
			updateProfilesList();
			editBox:SetText("");
			parent:Hide();
		end,
		EditBoxOnEscapePressed = function(self)
			self:GetParent():Hide();
		end,
		EditBoxOnTextChanged = function(self)
			text = self:GetText();
			if ( text and (#text > 0) ) then
				if ( (not module.globalOptions.perCharacter[text])
					 and (not module.globalOptions.custom[text]) ) then
					self:GetParent().button1:Enable();
					return;
				end
			end
			self:GetParent().button1:Disable();
		end,
		OnAccept = function(self, text)
			module:NewCustomProfile(self.editBox:GetText());
			updateProfilesList();
		end,
		OnCancel = function() end,
		timeout = 0,
		whileDead = true,
		hideOnEscape = true,
	};
	
	StaticPopupDialogs["HFLOOTROLL_PROFILE_REMOVE"] = {
		text = L"PRESET_DELETE_POPUP",
		button1 = YES,
		button2 = NO,
		OnAccept = function(self, text)
			module:RemoveProfile(profileInfo(panel.selected));
			updateProfilesList();
		end,
		OnCancel = function() end,
		timeout = 0,
		whileDead = true,
		hideOnEscape = true,
	};
	
	StaticPopupDialogs["HFLOOTROLL_PROFILE_SHARE"] = {
		text = L"PRESET_SHARE_POPUP",
		button1 = YES,
		button2 = NO,
		OnAccept = function(self, text)
			module:SaveForAllCharacters();
		end,
		OnCancel = function() end,
		timeout = 0,
		whileDead = true,
		hideOnEscape = true,
	};
	
	panel.btnNew = CreateFrame("Button", "hfLootRollProfilesNew", panel, "UIPanelButtonTemplate");
	panel.btnNew:SetPoint("TOPLEFT", panel.lstProfiles, "BOTTOMLEFT", 0, -5);
	panel.btnNew:SetSize(117, 22);
	panel.btnNew:SetText(L"PRESET_NEW");
	panel.btnNew:SetScript("OnClick", function(self) StaticPopup_Show("HFLOOTROLL_PROFILE_NEW"); end);
	
	panel.btnRemove = CreateFrame("Button", "hfLootRollProfilesRemove", panel, "UIPanelButtonTemplate");
	panel.btnRemove:SetPoint("LEFT", panel.btnNew, "RIGHT", 5, 0);
	panel.btnRemove:SetSize(117, 22);
	panel.btnRemove:SetText(L"PRESET_DELETE");
	panel.btnRemove:SetScript("OnClick", function(self) 
		local ptype, pname = profileInfo(panel.selected);
		if ( ptype == "character" ) then
			StaticPopup_Show("HFLOOTROLL_PROFILE_REMOVE", select(2, profileInfo(panel.selected))); 
		else
			module:RemoveProfile(ptype, pname);
			updateProfilesList();
		end
		self:Disable();
		panel.btnLoad:Disable();
	end);
	
	panel.btnLoad = CreateFrame("Button", "hfLootRollProfilesLoad", panel, "UIPanelButtonTemplate");
	panel.btnLoad:SetPoint("LEFT", panel.btnRemove, "RIGHT", 5, 0);
	panel.btnLoad:SetSize(116, 22);
	panel.btnLoad:SetText(L"PRESET_LOAD");
	panel.btnLoad:SetScript("OnClick", function(self) 
		local ptype, pname = profileInfo(panel.selected);
		module:LoadProfile(ptype, pname);
		updateProfilesList();
	end);
	
	panel.btnShare = CreateFrame("Button", "hfLootRollProfilesShare", panel, "UIPanelButtonTemplate");
	panel.btnShare:SetPoint("TOPLEFT", panel.btnNew, "BOTTOMLEFT", 0, -6);
	panel.btnShare:SetPoint("TOPRIGHT", panel.btnLoad, "BOTTOMRIGHT", 0, -6);
	panel.btnShare:SetHeight(22);
	panel.btnShare:SetText(L"PRESET_SHARE");
	panel.btnShare:SetScript("OnClick", function(self) 
		StaticPopup_Show("HFLOOTROLL_PROFILE_SHARE"); 
	end);
	
	updateProfilesList();
	
	panel:SetScript("OnShow", function(self)
		self.lstProfiles:ClearSelection();
		self.selected = nil;
		self.btnLoad:Disable();
		self.btnRemove:Disable();
	end);
	
	return panel;
end

function module:NewCustomProfile(profileName)
	if ( self.globalOptions.custom[profileName] ) then
		return;
	end
	self.globalOptions.custom[profileName] = cloneTable(self.currentOptions, true);
	self.globalOptions.custom[profileName].lastTime = time();
	addon:FireEvent("PROFILE_NEW", profileName);
end

function module:RemoveProfile(ptype, pname)
	if ( ptype == "character" ) then
		self.globalOptions.perCharacter[pname] = nil;
	elseif ( ptype == "custom" ) then
		self.globalOptions.custom[pname] = nil;
	end
	addon:FireEvent("PROFILE_REMOVE", ptype, pname);
end

function module:LoadProfile(ptype, pname)
	if ( ptype == "character" ) then
		self:Restore(self.globalOptions.perCharacter[pname]);
	elseif ( ptype == "custom" ) then
		self:Restore(self.globalOptions.custom[pname]);
	end
	addon:FireEvent("PROFILE_LOAD", ptype, pname);
end

local function getOption(source, option)
	if ( source[option] ~= nil ) then
		return source[option];
	else 
		return defaultOptions[option];
	end
end

function module:Restore(source)
	local appPanel = self.appearancePanel;
	
	local pos = getOption(source, "anchorPos");
	addon:FireEvent("SETTING_CHANGED", "AnchorPos", pos);
	cloneTable(pos, true, module.currentOptions.anchorPos);
	appPanel:SetValues(defaultOptions);
	appPanel:SetValues(source);
	
	local behPanel = self.behaviorPanel;
	
	behPanel:SetValues(defaultOptions.behavior);
	behPanel:SetValues(source.behavior);
	
	-- resetting anchor position
	local anchorVis = getOption(source, "anchorLocked");
	appPanel:SetControl("anchorLocked", not anchorVis);
	appPanel:SetControl("anchorLocked", anchorVis);
end

function module:SaveForAllCharacters()
	if ( type(self.globalOptions["Default"]) ~= "table" ) then
		self.globalOptions["Default"] = cloneTable(self.currentOptions, true);
	else
		cloneTable(self.currentOptions, true, self.globalOptions["Default"]);
	end
	self.globalOptions["Default"].lastTime = time();
	addon:FireEvent("PROFILE_SHARE");
end

hfLootRoll:AddModule("options", module);
