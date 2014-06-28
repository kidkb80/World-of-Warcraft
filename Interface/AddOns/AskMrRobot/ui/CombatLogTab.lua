local _, AskMrRobot = ...

-- initialize the ExportTab class
AskMrRobot.CombatLogTab = AskMrRobot.inheritsFrom(AskMrRobot.Frame)

-- helper to create text for this tab
local function CreateText(tab, font, relativeTo, xOffset, yOffset, text)
    local t = tab:CreateFontString(nil, "ARTWORK", font)
	t:SetPoint("TOPLEFT", relativeTo, "BOTTOMLEFT", xOffset, yOffset)
	t:SetPoint("RIGHT", tab, "RIGHT", -25, 0)
	t:SetWidth(t:GetWidth())
	t:SetJustifyH("LEFT")
	t:SetText(text)
    
    return t
end

local function newCheckbox(tab, label, tooltipTitle, description, onClick)
	local check = CreateFrame("CheckButton", "AmrCheck" .. label, tab, "InterfaceOptionsCheckButtonTemplate")
	check:SetScript("OnClick", function(self)
		PlaySound(self:GetChecked() and "igMainMenuOptionCheckBoxOn" or "igMainMenuOptionCheckBoxOff")
		onClick(self, self:GetChecked() and true or false)
	end)
	check.label = _G[check:GetName() .. "Text"]
	check.label:SetText(label)
	check.tooltipText = tooltipTitle
	check.tooltipRequirement = description
	return check
end

function AskMrRobot.CombatLogTab:new(parent)

	local tab = AskMrRobot.Frame:new(nil, parent)	
	setmetatable(tab, { __index = AskMrRobot.CombatLogTab })
	tab:SetPoint("TOPLEFT")
	tab:SetPoint("BOTTOMRIGHT")
	tab:Hide()

	local text = tab:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
	text:SetPoint("TOPLEFT", 0, -5)
	text:SetText("Combat Logging")
    
	local manulText = CreateText(tab, "GameFontWhite", text, 0, -15, "Manual:")
	manulText:SetJustifyV("MIDDLE")
    manulText:SetHeight(30)
	    
    local btn = CreateFrame("Button", "AmrCombatLogStart", tab, "UIPanelButtonTemplate")
	btn:SetPoint("TOPLEFT", text, "BOTTOMLEFT", 75, -15)
	btn:SetText("Start Logging")
	btn:SetWidth(120)
	btn:SetHeight(30)
    tab.btnStart = btn
    
    btn:SetScript("OnClick", function()
        tab:StartLogging()
    end)
    
    btn = CreateFrame("Button", "AmrCombatLogEnd", tab, "UIPanelButtonTemplate")
	btn:SetPoint("TOPLEFT", text, "BOTTOMLEFT", 225, -15)
	btn:SetText("Stop Logging")
	btn:SetWidth(120)
	btn:SetHeight(30)
    tab.btnEnd = btn
    
    btn:SetScript("OnClick", function()
        tab:StopLogging()
    end)

	local autoText = CreateText(tab, "GameFontWhite", text, 0, -50, "Automatic:")
	autoText:SetJustifyV("MIDDLE")
    autoText:SetHeight(28)

	local autoChk = newCheckbox(tab,
		"Always log Siege of Orgrimmar",
		"Auto-Log Siege of Orgrimmar",
		"Automatically start logging when you enter SoO and stop when you leave SoO.\n\nNote that you should disable similar features in other addons to avoid conflicts.",
		function(self, value) 
			if value then
				AmrLogData._autoLog[AskMrRobot.instanceIds.SiegeOfOrgrimmar] = "enabled"
			else
				AmrLogData._autoLog[AskMrRobot.instanceIds.SiegeOfOrgrimmar] = "disabled" 
			end

			AmrLogData._lastZone = nil
			AmrLogData._lastDiff = nil
			tab:UpdateAutoLogging()
		end
	)
	autoChk:SetChecked(AmrLogData._autoLog[AskMrRobot.instanceIds.SiegeOfOrgrimmar] == "enabled")
	autoChk:SetPoint("TOPLEFT", text, "BOTTOMLEFT", 75, -50)
    autoChk:SetHeight(30)

	text = CreateText(tab, "GameFontNormalLarge", text, 0, -100, "Character Data")

	btn = CreateFrame("Button", "AmrCombatLogSaveCharData", tab, "UIPanelButtonTemplate")
	btn:SetPoint("TOPLEFT", text, "BOTTOMLEFT", 0, -5)
	btn:SetText("Save Character Data")
	btn:SetWidth(150)
	btn:SetHeight(30)

	btn:SetScript("OnClick", function()
		-- reload the UI will save character data to disk
        ReloadUI()
    end)

    text = CreateText(tab, "GameFontNormalLarge", btn, 0, -30, "INSTRUCTIONS")
    text = CreateText(tab, "GameFontWhite", text, 0, -10, "1. Use the Start/Stop buttons or check 'Always log Siege of Orgrimmar'.")
    text = CreateText(tab, "GameFontWhite", text, 0, -10, "2. When you are ready to upload, press 'Save Character Data'. *")
    text = CreateText(tab, "GameFontWhite", text, 0, -10, "3. Exit World of Warcraft. **")
	text = CreateText(tab, "GameFontWhite", text, 0, -10, "4. Launch the Ask Mr. Robot client and follow the instructions. ***")

	text = CreateText(tab, "GameFontNormalSmall", text, 0, -30, "|c00999999* This will reload your UI to ensure that all collected data is saved to disk.  This step is not necessary if you log out of the game before uploading.|r")
	text = CreateText(tab, "GameFontNormalSmall", text, 0, -10, "|c00999999** Exiting WoW before uploading your combat log is optional, but highly recommended.  This prevents your log file from getting ridiculously large and slowing down your uploads.|r")
	text = CreateText(tab, "GameFontNormalSmall", text, 0, -10, "|c00999999*** You can download the client program at|r |c003333ffhttp://www.askmrrobot.com/wow/combatlog/upload|r|c00999999.|r")
    
	--[[
	btn = CreateFrame("Button", "AmrCombatLogTest", tab, "UIPanelButtonTemplate")
	btn:SetPoint("TOPLEFT", text, "BOTTOMLEFT", 0, -15)
	btn:SetText("Test")
	btn:SetWidth(120)
	btn:SetHeight(30)
    
    btn:SetScript("OnClick", function()
        AskMrRobot.ExportToAddonChat(time())
    end)
	]]

	-- when we start up, ensure that logging is still enabled if it was enabled when they last used the addon
    if (tab:IsLogging()) then
        SetCVar("advancedCombatLogging", 1)
        LoggingCombat(true)
    end
    
	-- if auto-logging is enabled, do a check when the addon is loaded to make sure that state is set correctly
	if AmrLogData._autoLog[AskMrRobot.instanceIds.SiegeOfOrgrimmar] == "enabled" then
		tab:UpdateAutoLogging()
	end

    tab:SetScript("OnShow", function()
        tab:Update()
	end)

    return tab
end

function AskMrRobot.CombatLogTab:IsLogging()
    return AmrLogData._logging == true
end

function AskMrRobot.CombatLogTab:StartLogging()

	-- archive the current logging session so that users don't accidentally blow away data before uploading it
	if AmrLogData._current2 ~= nil then
		if not AmrLogData._history2 then AmrLogData._history2 = {} end

		-- add new entries
		for name, timeList in AskMrRobot.spairs(AmrLogData._current2) do
			if not AmrLogData._history2[name] then AmrLogData._history2[name] = {} end
			for timestamp, dataString in AskMrRobot.spairs(timeList) do
				AmrLogData._history2[name][timestamp] = dataString
			end
		end

		-- delete entries that are more than 10 days old
		local now = time()
		local interval = 60 * 60 * 24 * 10
		for name, timeList in AskMrRobot.spairs(AmrLogData._history2) do
			for timestamp, dataString in AskMrRobot.spairs(timeList) do
				if difftime(now, tonumber(timestamp)) > interval then
					timeList[timestamp] = nil
				end
			end
			
			local count = 0
			for timestamp, dataString in pairs(timeList) do
				count = count + 1
			end
			if count == 0 then
				AmrLogData._history2[name] = nil
			end
		end
	end

	-- clean up old-style logging data from previous versions of the addon
	for k, v in AskMrRobot.spairs(AmrLogData) do
		if k ~= "_logging" and k ~= "_autoLog" and k ~= "_lastZone" and k ~= "_lastDiff" and k ~= "_current2" and k ~= "_history2" then
			AmrLogData[k] = nil
		end
	end

    -- start a new logging session
    AmrLogData._current2 = {}
    AmrLogData._logging = true
    
    -- always enable advanced combat logging via our addon, gathers more detailed data for better analysis
    SetCVar("advancedCombatLogging", 1)
    
    LoggingCombat(true)
    self:Update()
    
    print("You are now logging combat, and Mr. Robot is logging character data for your raid.")
end

function AskMrRobot.CombatLogTab:StopLogging()
    LoggingCombat(false)
    AmrLogData._logging = false
    self:Update()
    
    print("Combat logging has been stopped.")
end

-- update the panel and state
function AskMrRobot.CombatLogTab:Update()
    local isLogging = self:IsLogging()
    
    if isLogging then
        self.btnStart:Disable()
        self.btnEnd:Enable()
    else
        self.btnStart:Enable()
        self.btnEnd:Disable()
    end
end

-- called to update logging state when auto-logging is enabled
function AskMrRobot.CombatLogTab:UpdateAutoLogging()

	-- get the info about the instance
	--local zone, zonetype, difficultyIndex, difficultyName, maxPlayers, dynamicDifficulty, isDynamic, instanceMapID = GetInstanceInfo()
	local zone, _, difficultyIndex, _, _, _, _, instanceMapID = GetInstanceInfo()
	--local difficulty = difficultyIndex
	-- Unless Blizzard fixes scenarios to not return nil, let's hardcode this into returning "scenario" -Znuff
	--if zonetype == nil and difficultyIndex == 1 then
		--zonetype = "scenario"
	--end

	if zone == AmrLogData._lastZone and difficultyIndex == AmrLogData._lastDiff then
	  -- do nothing if the zone hasn't actually changed, otherwise we may override the user's manual enable/disable
		return
	end

	AmrLogData._lastZone = zone
	AmrLogData._lastDiff = difficultyIndex

	if AmrLogData._autoLog[AskMrRobot.instanceIds.SiegeOfOrgrimmar] == "enabled" then
		if tonumber(instanceMapID) == AskMrRobot.instanceIds.SiegeOfOrgrimmar then
			-- if in SoO, make sure logging is on
			if not self:IsLogging() then
				self:StartLogging()
			end
		else
			-- not in SoO, turn logging off
			if self:IsLogging() then
				self:StopLogging()
			end
		end
	end

end

-- read a message sent to the addon channel with a player's info at the time an encounter started
function AskMrRobot.CombatLogTab:ReadAddonMessage(message)

    -- message will be of format: timestamp\nrealm\nname\n[stuff]
    local parts = {}
	for part in string.gmatch(message, "([^\n]+)") do
		tinsert(parts, part)
	end
    
    local timestamp = parts[1]
    local name = parts[2] .. ":" .. parts[3]
    local data = parts[4]
    
    if (data == "done") then
        -- we have finished receiving this message; now process it to reduce the amount of duplicate data
        local setup = AmrLogData._current2[name][timestamp]
        
        if (AmrLogData._previousSetup == nil) then
            AmrLogData._previousSetup = {}
        end
        
        local previousSetup = AmrLogData._previousSetup[name]
        
        if (previousSetup == setup) then
            -- if the last-seen setup for this player is the same as the current one, we don't need this entry
            AmrLogData._current2[name][timestamp] = nil
        else
            -- record the last-seen setup
            AmrLogData._previousSetup[name] = setup
        end
    else
        -- concatenate messages with the same timestamp+name
        if (AmrLogData._current2[name] == nil) then
            AmrLogData._current2[name] = {}
        end
        
        if (AmrLogData._current2[name][timestamp] == nil) then
            AmrLogData._current2[name][timestamp] = data
        else
            AmrLogData._current2[name][timestamp] = AmrLogData._current2[name][timestamp] .. data
        end
    end
end
