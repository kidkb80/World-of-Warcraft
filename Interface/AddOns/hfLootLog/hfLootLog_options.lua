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

if ( not hfLootRoll ) then
	return;
end

local const = hfLootRoll.const;

local module = {};
module.options = {};
module.onEvent = {};

local L = addon.L;

defaultOptions = {
	autoDelete = true,
	autoDeleteDays = 7,
	quality = 3,
	notLogged = {},
	loggingEnabled = true,
	logMoney = false,
	logOnlyMine = false,
	logInInstances = {
		["none"]  = false,
		["party"] = true,
		["raid"]  = true,
	},
};

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

local backupOptions = {};

function module.onLoad()
	if ( not module.globalOptions.perCharacter ) then
		module.globalOptions.custom = {};
		module.globalOptions.perCharacter = {};
		module.globalOptions.perCharacter[const.PLAYER_NAME_FULL] = cloneTable(defaultOptions, true);
	elseif ( not module.globalOptions.perCharacter[const.PLAYER_NAME_FULL] ) then
		module.globalOptions.perCharacter[const.PLAYER_NAME_FULL] = cloneTable(defaultOptions, true);
	end
	module.currentOptions = module.globalOptions.perCharacter[const.PLAYER_NAME_FULL];
	module.currentOptions.lastTime = module.currentOptions.lastTime or 0;
	
	if ( module.globalOptions["Default"] ) then
		if ( module.currentOptions.lastTime < module.globalOptions["Default"].lastTime ) then
			cloneTable(module.globalOptions["Default"], true, module.currentOptions);
		end
	end
	module.currentOptions.lastTime = time();

	local logPanel = module:initLogPanel();
	logPanel.name = L"LOG";
	logPanel.okay = function(self)
		module.currentOptions.lastTime = time();
		module.currentOptions.autoDeleteDays = tonumber(logPanel.edtbxAutoDeleteDays:GetText()) or 99;
		hfLootRoll:GetModule("log").logCleaner.threshold = module.currentOptions.autoDeleteDays;
		hfLootRoll:GetModule("log").logCleaner.elapsed = 3599;
	end
	logPanel.cancel = function(self)
		module:restore(backupOptions);
		module.currentOptions.lastTime = time();
	end
	logPanel.refresh = function(self)
		cloneTable(module.currentOptions, true, backupOptions);
	end
	logPanel.default = function(self)
		module:restore(defaultOptions);
	end
	logPanel:SetScript("OnShow", function(self)
		self.edtbxAutoDeleteDays:SetText(module.currentOptions.autoDeleteDays);
		self.edtbxAutoDeleteDays:SetCursorPosition(0);
	end);
	hfLootRoll:GetModule('options'):AddSubPanel(logPanel);
end

function module:initLogPanel()
	local initialOptions = {};
	for option, value in pairs(defaultOptions) do
		local val;
		if ( self.currentOptions[option] == nil ) then
			val = value;
		else
			val = self.currentOptions[option];
		end
		initialOptions[option] = ((type(val) == "table") and cloneTable(val, true)) or val;
	end

	local panel = CreateFrame("Frame", "hfLootLogOptionsPanel");
	self.logPanel = panel;
	
	panel.cboxEnableLog = hf_Widgets.CheckBox("hfLootLogOptionsEnableLog", panel, "");
	panel.cboxEnableLog.setFunc = function(setting)
		if ( setting == "1" ) then
			module.currentOptions.loggingEnabled = true;
			hfLootRoll:GetModule("log").active = true;
			panel.cboxEnableLog.text:SetText("|cff55ff55" .. L"LOG_ENABLED" .. "|r");
		else
			module.currentOptions.loggingEnabled = false;
			hfLootRoll:GetModule("log").active = false;
			panel.cboxEnableLog.text:SetText("|cffff5555" .. L"LOG_DISABLED" .. "|r");
		end
	end
	panel.cboxEnableLog:SetPoint("TOPLEFT", 14, -4);
	panel.cboxEnableLog:SetChecked(initialOptions.loggingEnabled);
		
	panel.drpdwnQuality = hf_Widgets.DropDown("hfLootLogOptionsQuality", panel);
	panel.drpdwnQuality.label = panel:CreateFontString("hfLootLogOptionsQualityLabel", nil, "GameFontNormal");
	panel.drpdwnQuality.label:SetPoint("TOPLEFT", panel.cboxEnableLog, "BOTTOMLEFT", 2, -15);
	panel.drpdwnQuality.label:SetText(L"QUALITY_THRESHOLD");
	panel.drpdwnQuality:SetPoint("TOPLEFT", panel.drpdwnQuality.label, "BOTTOMLEFT", -17, 0);
	panel.drpdwnQuality:SetWidth(100);
	panel.drpdwnQuality:SetButtonWidth(124);
	panel.drpdwnQuality.setFunc = function(self, texture, font, value)
		module.currentOptions.quality = value;
		hfLootRoll:GetModule("log").loggingThresholds.quality = value;
	end
	local items = {
		select(4, GetItemQualityColor(0)) .. ITEM_QUALITY0_DESC .. "|r",
		select(4, GetItemQualityColor(1)) .. ITEM_QUALITY1_DESC .. "|r",
		select(4, GetItemQualityColor(2)) .. ITEM_QUALITY2_DESC .. "|r",
		select(4, GetItemQualityColor(3)) .. ITEM_QUALITY3_DESC .. "|r",
		select(4, GetItemQualityColor(4)) .. ITEM_QUALITY4_DESC .. "|r",
	};
	for q, text in pairs(items) do
		panel.drpdwnQuality:AddButton(nil, nil, text, q - 1);
	end
	panel.drpdwnQuality:SetSelectionByValue(initialOptions.quality);
	
	panel.cboxLogMoney = hf_Widgets.CheckBox("hfLootLogOptionsLogMoney", panel, L"LOG_CURRENCY");
	panel.cboxLogMoney.setFunc = function(setting)
		if ( setting == "1" ) then
			module.currentOptions.logMoney = true;
			hfLootRoll:GetModule("log").loggingThresholds.logMoney = true;
		else
			module.currentOptions.logMoney = false;
			hfLootRoll:GetModule("log").loggingThresholds.logMoney = false;
		end
	end;
	panel.cboxLogMoney:SetPoint("TOPLEFT", panel.drpdwnQuality, "BOTTOMLEFT", 15, -10);
	panel.cboxLogMoney:SetChecked(initialOptions.logMoney);
	
	panel.cboxOnlyMine = hf_Widgets.CheckBox("hfLootLogOptionsOnlyMine", panel, L"LOG_ONLY_MINE");
	panel.cboxOnlyMine.setFunc = function(setting)
		if ( setting == "1" ) then
			module.currentOptions.logOnlyMine = true;
			hfLootRoll:GetModule("log").loggingThresholds.logOnlyMine = true;
		else
			module.currentOptions.logOnlyMine = false;
			hfLootRoll:GetModule("log").loggingThresholds.logOnlyMine = false;
		end
	end;
	panel.cboxOnlyMine:SetPoint("TOPLEFT", panel.cboxLogMoney, "BOTTOMLEFT", 0, -14);
	panel.cboxOnlyMine:SetChecked(initialOptions.logOnlyMine);
	
	local function EnableInInstanceCBoxes()
		panel.cboxInInstancesParty:Enable();
		panel.cboxInInstancesParty.text:SetTextColor(1, 1, 1);
		panel.cboxInInstancesRaid:Enable();
		panel.cboxInInstancesRaid.text:SetTextColor(1, 1, 1);
	end
	
	local function DisableInInstanceCBoxes()
		panel.cboxInInstancesParty:Disable();
		panel.cboxInInstancesParty.text:SetTextColor(0.5, 0.5, 0.5);
		panel.cboxInInstancesRaid:Disable();
		panel.cboxInInstancesRaid.text:SetTextColor(0.5, 0.5, 0.5);
	end
	
	panel.cboxInInstances = hf_Widgets.CheckBox("hfLootLogOptionsInInstances", panel, L"LOG_ONLY_INSTANCES");
	panel.cboxInInstances.setFunc = function(setting)
		if ( setting == "1" ) then
			module.currentOptions.logInInstances["none"] = false;
			hfLootRoll:GetModule("log").loggingThresholds.logInInstances["none"] = false;
			EnableInInstanceCBoxes();
		else
			module.currentOptions.logInInstances["none"] = true;
			hfLootRoll:GetModule("log").loggingThresholds.logInInstances["none"] = true;
			DisableInInstanceCBoxes();
			panel.cboxInInstancesParty:Disable();
			panel.cboxInInstancesRaid:Disable();
		end
	end;
	panel.cboxInInstances:SetPoint("TOPLEFT", panel.cboxOnlyMine, "BOTTOMLEFT", 0, -14);
	
	panel.cboxInInstancesParty = hf_Widgets.CheckBox("hfLootLogOptionsInInstancesParty", panel, L"PARTY");
	panel.cboxInInstancesParty.setFunc = function(setting)
		if ( setting == "1" ) then
			module.currentOptions.logInInstances["party"] = true;
			hfLootRoll:GetModule("log").loggingThresholds.logInInstances["party"] = true;
		else
			module.currentOptions.logInInstances["party"] = false;
			hfLootRoll:GetModule("log").loggingThresholds.logInInstances["party"] = false;
			if ( not panel.cboxInInstancesRaid:GetChecked() ) then
				panel.cboxInInstancesRaid:SetChecked(true);
				InterfaceOptionsPanel_CheckButton_Update(panel.cboxInInstancesRaid);
			end
		end
	end;
	panel.cboxInInstancesParty:SetPoint("TOPLEFT", panel.cboxInInstances, "BOTTOMLEFT", 20, -2);
	
	panel.cboxInInstancesRaid = hf_Widgets.CheckBox("hfLootLogOptionsInInstancesRaid", panel, L"RAID");
	panel.cboxInInstancesRaid.setFunc = function(setting)
		if ( setting == "1" ) then
			module.currentOptions.logInInstances["raid"] = true;
			hfLootRoll:GetModule("log").loggingThresholds.logInInstances["raid"] = true;
		else
			module.currentOptions.logInInstances["raid"] = false;
			hfLootRoll:GetModule("log").loggingThresholds.logInInstances["raid"] = false;
			if ( not panel.cboxInInstancesParty:GetChecked() ) then
				panel.cboxInInstancesParty:SetChecked(true);
				InterfaceOptionsPanel_CheckButton_Update(panel.cboxInInstancesParty);
			end
		end
	end;
	panel.cboxInInstancesRaid:SetPoint("TOPLEFT", panel.cboxInInstancesParty, "BOTTOMLEFT", 0, -2);
	
	panel.cboxInInstancesRaid:SetChecked(initialOptions.logInInstances["raid"]);
	panel.cboxInInstancesParty:SetChecked(initialOptions.logInInstances["party"]);
	panel.cboxInInstances:SetChecked(not initialOptions.logInInstances["none"]);
	
	panel.cboxAutoDelete = hf_Widgets.CheckBox("hfLootLogOptionsAutoDelete", panel, L"AUTO_DELETE_TIME_1");
	panel.cboxAutoDelete.setFunc = function(setting)
		if ( setting == "1" ) then
			module.currentOptions.autoDelete = true;
			hfLootRoll:GetModule("log").logCleaner.active = true;
		else
			module.currentOptions.autoDelete = false;
			hfLootRoll:GetModule("log").logCleaner.active = false;
		end
	end;
	panel.cboxAutoDelete:SetPoint("TOPLEFT", panel.cboxInInstancesRaid, "BOTTOMLEFT", -20, -14);
	panel.cboxAutoDelete:SetChecked(initialOptions.autoDelete);
	
	panel.edtbxAutoDeleteDays = CreateFrame("EditBox", "hfLootLogOptionsAutoDeleteDays", panel, "InputBoxTemplate");
	panel.edtbxAutoDeleteDays:SetHeight(16);
	panel.edtbxAutoDeleteDays:SetWidth(20);
	panel.edtbxAutoDeleteDays:SetMaxLetters(2);
	panel.edtbxAutoDeleteDays:SetMultiLine(false);
	panel.edtbxAutoDeleteDays:SetNumeric(true);
	panel.edtbxAutoDeleteDays:SetAutoFocus(false);
	panel.edtbxAutoDeleteDays:SetScript("OnEscapePressed", function(self)
		self:ClearFocus() 
	end);
	panel.edtbxAutoDeleteDays:SetScript("OnEnterPressed", function(self) 
		self:ClearFocus();
	end);
	panel.edtbxAutoDeleteDays:SetScript("OnTabPressed", function(self)
		self:ClearFocus();
	end);
	panel.edtbxAutoDeleteDays:SetPoint("LEFT", panel.cboxAutoDelete.text, "RIGHT", 8, 0);
	
	local edtbxAutoDeleteDaysLabel = panel:CreateFontString("hfLootLogOptionsAutoDeleteDaysLabel", "ARTWORK", "GameFontHighlight");
	edtbxAutoDeleteDaysLabel:SetPoint("LEFT", panel.edtbxAutoDeleteDays, "RIGHT", 8, 0);
	edtbxAutoDeleteDaysLabel:SetText(L"AUTO_DELETE_TIME_2");
	
	return panel;
end

function module.onEvent.PROFILE_NEW(event, pname)
	module.globalOptions.custom[pname] = cloneTable(module.currentOptions, true);
	module.globalOptions.custom[pname].lastTime = time();
end

function module.onEvent.PROFILE_REMOVE(event, ptype, pname)
	if ( ptype == "character" ) then
		module.globalOptions.perCharacter[pname] = nil;
	elseif ( ptype == "custom" ) then
		module.globalOptions.custom[pname] = nil;
	end
end

function module.onEvent.PROFILE_LOAD(event, ptype, pname)
	if ( ptype == "character" ) then
		module:restore(module.globalOptions.perCharacter[pname]);
	elseif ( ptype == "custom" ) then
		module:restore(module.globalOptions.custom[pname]);
	end
end

function module.onEvent.PROFILE_SHARE(event)
	if ( type(module.globalOptions["Default"]) ~= "table" ) then
		module.globalOptions["Default"] = cloneTable(module.currentOptions, true);
	else
		cloneTable(module.currentOptions, true, module.globalOptions["Default"]);
	end
	module.globalOptions["Default"].lastTime = time();
end

function module:restore(source)
	local panel = self.logPanel;
	panel.cboxEnableLog:SetChecked(source.loggingEnabled);
	panel.drpdwnQuality:SetSelectionByValue(source.quality);
	panel.cboxLogMoney:SetChecked(source.logMoney);
	panel.cboxOnlyMine:SetChecked(source.logOnlyMine);
	panel.cboxInInstancesRaid:SetChecked(source.logInInstances["raid"]);
	panel.cboxInInstancesParty:SetChecked(source.logInInstances["party"]);
	panel.cboxInInstances:SetChecked(not source.logInInstances["none"]);
	panel.cboxAutoDelete:SetChecked(source.autoDelete);
	panel.edtbxAutoDeleteDays:SetText(tostring(source.autoDeleteDays));
	panel.edtbxAutoDeleteDays:SetCursorPosition(0);
end

hfLootRoll:AddModule("log_options", module);