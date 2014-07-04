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

local module = {};
module.onEvent = {};
module.options = {};

local L = addon.L;

local const = addon.const;

local misc  = {};

module.anchorFrame = CreateFrame("Button", "hfLootRoll", UIParent);
module.anchorFrame.context = {}; --CreateFrame("Frame", "hfLootRollFrameDropDownMenu", UIParent, "UIDropDownMenuTemplate");

function misc.dummy()
end

function module.onLoad()
	module.initGUI();

	if ( module.options.hidden ) then
		module.anchorFrame:Toggle();
	end
	
	if ( module.options.mainFramePos ) then
		local point   = module.options.mainFramePos.point;
		local relTo   = module.options.mainFramePos.relativeTo;
		local relPoint = module.options.mainFramePos.relativePoint;
		local xOff    = module.options.mainFramePos.xOfs;
		local yOff    = module.options.mainFramePos.yOfs;
		module.anchorFrame:ClearAllPoints();
		module.anchorFrame:SetPoint(point, relTo, relPoint, xOff, yOff);
	end

	--UIDropDownMenu_Initialize(module.anchorFrame.context, module.anchorFrame.context.init, "MENU")

	module:AddContextButton({
		notCheckable = true,
		text = L"LOCK_FRAMES",
		func = function() module.anchorFrame:Toggle() end
	})

	addon:GetModule('slash'):AddCommand("lock", function()
		addon:GetModule("gui").anchorFrame:Hide();
	end);

	addon:GetModule('slash'):AddCommand("unlock", function()
		addon:GetModule("gui").anchorFrame:Show();
	end);

	addon:GetModule('slash'):AddCommand("toggle", function()
		module.anchorFrame:Toggle();
	end, L"SLASH_TOGGLE_FRAMES");

	--module.anchorFrame:SetScript("OnClick", module.anchorFrame.onClick)
	
	-- add warning to showLootSpam checkbox
	OPTION_TOOLTIP_SHOW_LOOT_SPAM = OPTION_TOOLTIP_SHOW_LOOT_SPAM .. "|n|cffff0000" .. L"LOOT_SPAM_WARNING" .. "|r";
end

function module.onEvent.UPDATE_ROLL(event, rollID)
	local roll = addon.rolls:GetByID(rollID);
	if ( roll ) then
		module.framesHolder:UpdateRoll(rollID, roll);
	end
end

-- this event fired when player made selection or roll was timed out
-- timeout is handled here only if player didn't made selection
-- timeout with selection made should be handled by lootframe
function module.onEvent.CANCEL_ROLL(event, rollID)
	module.framesHolder:FreeRoll(rollID);

	-- if player made selection - we suggest that it's onselect event, else - onfinish
	local selection = module.framesHolder:CheckSelection(rollID);
	if ( selection ) then
		module.framesHolder:CloseRoll(rollID, "onselect", true);
	else
		module.framesHolder:CloseRoll(rollID, "onselect", true);
		module.framesHolder:CloseRoll(rollID, "onfinish", true);
	end

	module.framesHolder:LockRoll(rollID);
end

function module.onEvent.NEW_ROLL(event, rollID, rollTime)
	module.framesHolder:StartRoll(rollID, rollTime);
end

-- this event fired when roll finished
function module.onEvent.WIN_ROLL(event, rollID, winner)
	module.framesHolder:CloseRoll(rollID, "onfinish");
	module.framesHolder:CloseRoll(rollID, "onselect");
	module.framesHolder:SetWinner(rollID, winner);
	module.framesHolder:LockRoll(rollID);
end

local rollConfirmPopup;
local rollAutoConfirmer = CreateFrame("Frame");
rollAutoConfirmer:SetScript("OnEvent", function(self, event, ...)
	local rollId, roll = ...;
    ConfirmLootRoll(rollId, roll);
end);
rollAutoConfirmer.Enable = function(self)
	rollConfirmPopup = StaticPopupDialogs["CONFIRM_LOOT_ROLL"];
	StaticPopupDialogs["CONFIRM_LOOT_ROLL"] = nil;
	self:RegisterEvent("CONFIRM_LOOT_ROLL");
	self:RegisterEvent("CONFIRM_DISENCHANT_ROLL");
end
rollAutoConfirmer.Disable = function(self)
	StaticPopupDialogs["CONFIRM_LOOT_ROLL"] = rollConfirmPopup 
		or StaticPopupDialogs["CONFIRM_LOOT_ROLL"];
	self:UnregisterEvent("CONFIRM_LOOT_ROLL");
	self:UnregisterEvent("CONFIRM_DISENCHANT_ROLL");
end

function module.onEvent.SETTING_CHANGED(event, set_name, ...)
	if ( set_name == "AnchorLock" ) then
		local value = ...;
		if ( value ) then
			module.anchorFrame:Hide();
		else
			module.anchorFrame:Show();
		end
		
	elseif ( set_name == "AnchorPos" ) then
		local pos = ...;
		module.anchorFrame:ClearAllPoints();
		module.anchorFrame:SetPoint(pos.point, pos.relativeTo, pos.relativePoint, pos.xOfs, pos.yOfs);
		
	elseif ( set_name == "Width" ) then
		local value = ...;
		module.framesHolder:SetOption("Width", value);
		module.anchorFrame:SetWidth(value);
		
	elseif ( set_name == "Autoconfirm" ) then
		local autoconfirm = ...;
		if ( autoconfirm ) then
			rollAutoConfirmer:Enable();
		else
			rollAutoConfirmer:Disable();
		end
	else
		module.framesHolder:SetOption(set_name, ...);
	end
end


function module.anchorFrame:Toggle()
	local isShown = module.anchorFrame:IsShown();
	if ( isShown ) then
		module.anchorFrame:Hide()
	else
		module.anchorFrame:RegisterForClicks("RightButtonUp")
		module.anchorFrame:Show()
	end
	isShown = not isShown;
	addon:FireEvent("ANCHOR_TOGGLE", isShown);
end

function module.anchorFrame.onClick(self, button)
	if ( button == "RightButton" ) then
		--ToggleDropDownMenu(1, nil, module.anchorFrame.context, module.anchorFrame, 0, 0);
	end
end

module.anchorFrame.context.buttonInfos = {}

function module.anchorFrame.context.init()
	for _, info in pairs(module.anchorFrame.context.buttonInfos) do
		--UIDropDownMenu_AddButton(info)
	end
end

function module:AddContextButton(info)
	tinsert(self.anchorFrame.context.buttonInfos, info)
end

function module.initGUI()
	module.anchorFrame:SetPoint("CENTER");
	module.anchorFrame:SetBackdrop{
		bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", 
		edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", 
		tile = true, tileSize = 16, 
		edgeSize = 16, 
		insets = { 
			left = 4, 
			right = 4, 
			top = 4,
			bottom = 4
		}
	} 
	module.anchorFrame:SetScript("OnHide", function()
		module.options.hidden = true;
	end);
	module.anchorFrame:SetScript("OnShow", function()
		module.options.hidden = false;
	end);
	module.anchorFrame:SetFrameStrata("MEDIUM");

	module.anchorFrame.header = module.anchorFrame:CreateFontString(nil , "OVERLAY")
	module.anchorFrame.header:SetFontObject("GameFontNormal")
	module.anchorFrame.header:SetAllPoints(module.anchorFrame)
	module.anchorFrame.header:SetText("hfLootRoll")

	module.anchorFrame:SetBackdropColor(.2, .2, .2, .5)
	module.anchorFrame:SetWidth(150);
	module.anchorFrame:SetHeight(20);
	module.anchorFrame:SetMovable(true);
	module.anchorFrame:EnableMouse(true);
	module.anchorFrame:SetUserPlaced(false);
	module.anchorFrame:SetToplevel(true);
	module.anchorFrame:RegisterForClicks("RightButtonUp")
	module.anchorFrame:SetScript("OnMouseDown", function(self, button)
		if ( button == "LeftButton" ) then
			module.anchorFrame:StartMoving()
		end
	end)
	module.anchorFrame:SetScript("OnMouseUp", function(self)
		self:StopMovingOrSizing()
		self:SetUserPlaced(false);
	end);

	module.framesWrapper = CreateFrame("Frame", "hfLootFramesWrapper", UIParent);
	module.framesWrapper:SetAllPoints(module.anchorFrame);
	module.framesWrapper:Show();
	
	module.framesHolder = hf_Widgets.LootFrameHolder_v2("hfLootFrames", module.framesWrapper);

	GroupLootFrame1:UnregisterAllEvents()
	GroupLootFrame1.Show = misc.dummy
	GroupLootFrame1:Hide()
	GroupLootFrame2:UnregisterAllEvents()
	GroupLootFrame2.Show = misc.dummy
	GroupLootFrame2:Hide()
	GroupLootFrame3:UnregisterAllEvents()
	GroupLootFrame3.Show = misc.dummy
	GroupLootFrame3:Hide()
	GroupLootFrame4:UnregisterAllEvents()
	GroupLootFrame4.Show = misc.dummy
	GroupLootFrame4:Hide()
end

addon:AddModule("gui", module);
