
--
--  Achieved!
--    by Tuhljin
--


local THIS_VERSION = GetAddOnMetadata(..., "Version")
local THIS_TITLE = GetAddOnMetadata(..., "Title")

local AlertPosition, AlertPosition_Default
local draggable, unlockedText_prev

local function chatprint(msg, premsg)
	premsg = not premsg and "|cff7eff00["..THIS_TITLE.."]|r " or ""
	DEFAULT_CHAT_FRAME:AddMessage(premsg..msg, 0.741, 1, 0.467)
end

local function copytab(from, to)
  for k,v in pairs(from) do
    if(type(v) == "table") then
      to[k] = {}
      copytab(v, to[k]);
    else
      to[k] = v;
    end
  end
end

local frame1Moved
local currentAnchor2, currentScale1, currentScale2, currentScaleD = "TOP", 1, 1, 1

--local orig_AlertFrame_FixAnchors
local function new_AlertFrame_FixAnchors(...)
	local frame, frame2, frameD = AchievementAlertFrame1, AchievementAlertFrame2, DungeonCompletionAlertFrame1

	local scale = AlertPosition.Scale or 1
	if (frame and currentScale1 ~= scale) then
		frame:SetScale(scale)
		currentScale1 = scale
	end
	if (frame2 and currentScale2 ~= scale) then
		frame2:SetScale(scale)
		currentScale2 = scale
	end
	if (frameD and currentScaleD ~= scale) then
		frameD:SetScale(scale)
		currentScaleD = scale
	end

	if (not AlertPosition.enabled) then
		if (frame1Moved) then
			frame:ClearAllPoints()
			frame:SetPoint("BOTTOM", UIParent, "BOTTOM", 0, 128)
			frame1Moved = nil
		end
		--orig_AlertFrame_FixAnchors(...)
		AchievementAlertFrame_FixAnchors(...)
	elseif (frame) then
		TjDragIt.LoadPosition(frame, AlertPosition)
		frame1Moved = true
	end

	local rel, y, point, dy = AlertPosition.AttachPoint or "TOP", 0
	if (rel == "TOP") then
		point, y = "BOTTOM", -10
	elseif (rel == "BOTTOM") then
		point, y = "TOP", 10
	elseif (rel == "RIGHT") then
		point, dy = "LEFT", 4
	else
		point, dy = "RIGHT", 4
	end
	if (frame2 and currentAnchor2 ~= rel) then
		frame2:ClearAllPoints()
		frame2:SetPoint(point, frame, rel, 0, y);
		currentAnchor2 = rel
	end
	if (frameD:IsShown()) then
		-- Based on part of DungeonCompletionAlertFrame_FixAnchors():
		for i=MAX_ACHIEVEMENT_ALERTS, 1, -1 do
			local achframe = _G["AchievementAlertFrame"..i];
			if ( achframe and achframe:IsShown() ) then
				frameD:ClearAllPoints()
				frameD:SetPoint(point, achframe, rel, 0, dy or y);
				return;
			end
		end
		-- If no achievement alerts are shown...
		if (AlertPosition.enabled) then
			TjDragIt.LoadPosition(frameD, AlertPosition) -- Place in alert frame 1's spot
		else
			frameD:ClearAllPoints()
			DungeonCompletionAlertFrame_FixAnchors()
		end
	end
end

hooksecurefunc("AlertFrame_AnimateIn", function(frame)
	if (AlertPosition.HoldTime and not frame:IsMouseOver()) then
		frame.waitAndAnimOut.animOut:SetStartDelay(AlertPosition.HoldTime)
	end
end)

local function Init(self)
	Achieved_Settings = Achieved_Settings or { AlertPosition_Default = {} }
	Achieved_Settings.Version = THIS_VERSION
	AlertPosition_Default = Achieved_Settings.AlertPosition_Default

	Achieved_CharVars = Achieved_CharVars or {}
	Achieved_CharVars.Version = THIS_VERSION
	if (not Achieved_CharVars.AlertPosition) then
		Achieved_CharVars.AlertPosition = {}
		copytab(AlertPosition_Default, Achieved_CharVars.AlertPosition)
	end
	AlertPosition = Achieved_CharVars.AlertPosition

	--orig_AlertFrame_FixAnchors = AlertFrame_FixAnchors
	AlertFrame_FixAnchors = new_AlertFrame_FixAnchors
end

local MainFrame = CreateFrame("Frame")
MainFrame:Hide()
MainFrame:RegisterEvent("VARIABLES_LOADED")
MainFrame:SetScript("OnEvent", Init)



local function fadeoutAlertFrame(frame)
	if (frame.id == "drag") then  frame.id = "fadeout";  end
	frame.waitAndAnimOut.animOut:SetStartDelay(0)
	frame.waitAndAnimOut:Play()
end

local function AlertAnimOut_OnPlay(self)
	if (self:GetRegionParent().id == "drag") then  self:Stop();  end
end

local function AlertOnEnter(self, ...)
	if (self.id ~= "fadeout") then  return self.orig_OnEnter(self, ...);  end
end

local hooked_AchAlertOnClick
local function AlertOnClick(self, button, ...)
	if (self.id == "drag") then
		if (button == "RightButton") then
			fadeoutAlertFrame(AchievementAlertFrame1)
			fadeoutAlertFrame(AchievementAlertFrame2)
			fadeoutAlertFrame(DungeonCompletionAlertFrame1)
			return;
		end
	elseif (self.orig_AchAlertOnClick and self.id ~= "fadeout" and button == "LeftButton") then
	-- The alert frames normally only respond to left clicks.
		return self.orig_AchAlertOnClick(self, button, ...)
	end
end

local function Alert1OnHide(self)
	if (self.id == "drag" or self.id == "fadeout") then
		local frame, frame2, frameD = AchievementAlertFrame1, AchievementAlertFrame2, DungeonCompletionAlertFrame1
		if (unlockedText_prev) then
			_G[frame:GetName() .. "Unlocked"]:SetText(unlockedText_prev)
			_G[frame2:GetName() .. "Unlocked"]:SetText(unlockedText_prev)
			unlockedText_prev = nil
		end
		frame2:Hide()
		frameD:Hide()
		frame.id, frame2.id, frameD.id = nil, nil, nil
		TjDragIt.DisableDragging(frame)
		draggable = nil
	end
end

local function StartDragging()
	if ( not AchievementFrame ) then  AchievementFrame_LoadUI();  end
	AchievementAlertFrame_ShowAlert(46)
	AchievementAlertFrame_ShowAlert(1206) -- WoW currently shows a maximum of 2 alerts at a time.
	local frame, frame2, frameD = AchievementAlertFrame1, AchievementAlertFrame2, DungeonCompletionAlertFrame1
	local unlockedLabel = _G[frame:GetName() .. "Unlocked"]

	if (not hooked_AchAlertOnClick) then
		hooked_AchAlertOnClick = true
		for i,fr in ipairs( { frame, frame2, frameD } ) do
			fr.orig_AchAlertOnClick = fr:GetScript("OnClick")
			fr:SetScript("OnClick", AlertOnClick)
			fr:RegisterForClicks("LeftButtonUp", "RightButtonUp")
			fr.waitAndAnimOut.animOut:HookScript("OnPlay", AlertAnimOut_OnPlay)
			fr.orig_OnEnter = fr:GetScript("OnEnter")
			fr:SetScript("OnEnter", AlertOnEnter)
		end
		frame:HookScript("OnHide", Alert1OnHide)
		TjDragIt.EnablePositionSaving(frame, AlertPosition)
	end

	frame.id, frame2.id, frameD.id = "drag", "drag", "drag"
	AlertFrame_StopOutAnimation(frame)
	AlertFrame_StopOutAnimation(frame2)
	_G[frame:GetName() .. "Name"]:SetText(ACHIEVED_STRINGS_ALERTFRAME_DRAGGABLE)
	_G[frame2:GetName() .. "Name"]:SetText(ACHIEVED_STRINGS_ALERTFRAME_DRAGGABLE2)
	if (unlockedLabel:GetFont()) then
		unlockedText_prev = unlockedText_prev or unlockedLabel:GetText()
		unlockedLabel:SetText(ACHIEVED_STRINGS_ALERTFRAME_CLOSE)
		_G[frame2:GetName() .. "Unlocked"]:SetText(ACHIEVED_STRINGS_ALERTFRAME_CLOSE)
	else
		unlockedText_prev = nil
	end

	Achieved_SpoofDungeonCompletionAlert(ACHIEVED_STRINGS_ALERTFRAME_DUNGEON)
	AlertFrame_StopOutAnimation(frameD)

	TjDragIt.EnableIndirectDragging(frame, frame, frame2, frameD)
	frame1Moved, draggable = true, true
end

local function slashHandler(msg)
	msg = strlower(msg)
	local cmd, arg = strsplit(" ", msg)
	if (msg == ACHIEVED_STRINGS_CMD1) then  -- "drag"
		-- If neither alert frame is currently shown:
		if ( (not AchievementAlertFrame1 or not AchievementAlertFrame1:IsShown()) and
		     (not AchievementAlertFrame2 or not AchievementAlertFrame2:IsShown()) ) then
			StartDragging()
			if (not AlertPosition.enabled) then
				AlertPosition.enabled = true
				chatprint(ACHIEVED_STRINGS_DRAG_ENABLED)
			end
			chatprint(ACHIEVED_STRINGS_DRAG_START)
		end

	elseif (msg == ACHIEVED_STRINGS_CMD2) then  -- "reset"
		AlertPosition.enabled = nil
		chatprint(ACHIEVED_STRINGS_DRAG_DISABLED)
		AlertFrame_FixAnchors()
		if (draggable) then
			fadeoutAlertFrame(AchievementAlertFrame1)
			fadeoutAlertFrame(AchievementAlertFrame2)
			fadeoutAlertFrame(DungeonCompletionAlertFrame1)
			TjDragIt.DisableDragging(AchievementAlertFrame1)
			draggable = nil
		end

	elseif (cmd == ACHIEVED_STRINGS_CMD3) then  -- "anchor"
		local anchor
		if (arg == ACHIEVED_STRINGS_CMD3_ARG1) then
			anchor = "TOP"
		elseif (arg == ACHIEVED_STRINGS_CMD3_ARG2) then
			anchor = "BOTTOM"
		elseif (arg == ACHIEVED_STRINGS_CMD3_ARG3) then
			anchor = "LEFT"
		elseif (arg == ACHIEVED_STRINGS_CMD3_ARG4) then
			anchor = "RIGHT"
		end
		if (anchor) then
			AlertPosition.AttachPoint = anchor
			chatprint(ACHIEVED_STRINGS_ANCHOR_SET:format(strupper(arg)))
			AlertFrame_FixAnchors()
		else
			chatprint(ACHIEVED_STRINGS_ANCHOR_USAGE)
		end

	elseif (cmd == ACHIEVED_STRINGS_CMD4) then  -- "scale"
		arg = tonumber(arg)
		if (arg and arg > 0) then
			AlertPosition.Scale = arg
			chatprint(ACHIEVED_STRINGS_SCALE_SET:format(arg, arg*100))
			AlertFrame_FixAnchors()
		else
			chatprint(ACHIEVED_STRINGS_SCALE_USAGE)
		end

	elseif (msg == ACHIEVED_STRINGS_CMD5) then  -- "save"
		wipe(AlertPosition_Default)
		copytab(AlertPosition, AlertPosition_Default)
		chatprint(ACHIEVED_STRINGS_DEFAULT_SAVED)

	elseif (msg == ACHIEVED_STRINGS_CMD6) then  -- "load"
		wipe(AlertPosition)
		copytab(AlertPosition_Default, AlertPosition)
		chatprint(ACHIEVED_STRINGS_DEFAULT_LOADED)
		AlertFrame_FixAnchors()
		if (draggable) then
			fadeoutAlertFrame(AchievementAlertFrame1)
			fadeoutAlertFrame(AchievementAlertFrame2)
			fadeoutAlertFrame(DungeonCompletionAlertFrame1)
			TjDragIt.DisableDragging(AchievementAlertFrame1)
			draggable = nil
		end

	elseif (cmd == ACHIEVED_STRINGS_CMD7) then  -- "time"
		arg = tonumber(arg)
		if (arg and arg >= 0) then
			AlertPosition.HoldTime = arg
			chatprint(ACHIEVED_STRINGS_TIME_SET:format(arg))
		else
			chatprint(ACHIEVED_STRINGS_TIME_USAGE:format(AlertPosition.HoldTime or 4.05))
		end

	else
		chatprint("|cff7eff00"..THIS_TITLE.." |cffffffffv"..THIS_VERSION, true)
		chatprint(ACHIEVED_STRINGS_CMDLIST, true, true)
		local i = 1
		local cmd, desc, arg = ACHIEVED_STRINGS_CMD1, ACHIEVED_STRINGS_CMD1_DESC, ACHIEVED_STRINGS_CMD1_ARG
		while (cmd) do
			arg = arg and " "..arg or ""
			chatprint("- |cff7eff00"..cmd.."|r"..arg.."   |cffffffff"..(desc or ""), true)
			i = i + 1
			cmd, desc = _G["ACHIEVED_STRINGS_CMD"..i], _G["ACHIEVED_STRINGS_CMD"..i.."_DESC"]
			arg = _G["ACHIEVED_STRINGS_CMD"..i.."_ARG"]
		end
	end
end

SLASH_Achieved1 = "/achieved"
SLASH_Achieved2 = "/achd"
SlashCmdList["Achieved"] = slashHandler


do
	local origFunc, overrideName

	local function override_GetLFGCompletionReward()
		return overrideName, TYPEID_HEROIC_DIFFICULTY, "Dungeon", 0, 0, 0, 0, 4, 0;
	end

	function Achieved_SpoofDungeonCompletionAlert(name)
		origFunc = origFunc or GetLFGCompletionReward
		overrideName, GetLFGCompletionReward = name, override_GetLFGCompletionReward
		DungeonCompletionAlertFrame_ShowAlert()
		GetLFGCompletionReward = origFunc
		origFunc = nil
	end
end


-- TEST: /run AlertFrame_OnEvent(nil, "ACHIEVEMENT_EARNED", 46); AlertFrame_OnEvent(nil, "ACHIEVEMENT_EARNED", 1206); Achieved_SpoofDungeonCompletionAlert("Temple of Elemental Evil")
