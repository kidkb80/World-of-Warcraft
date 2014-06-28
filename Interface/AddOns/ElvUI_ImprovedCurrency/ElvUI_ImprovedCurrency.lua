-----------------------------------------------------------------------------------
-- ElvUI - Improved Currency Datatext
--
-- Written by: Mirach (US-Mal'Ganis)
-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------
-- TUKUI GLOBALS
-----------------------------------------------------------------------------------
local INTERFACE
local UI = nil
if ElvUI then
    UI=ElvUI
    INTERFACE = "elvui"
else
    UI=Tukui
    INTERFACE = "tukui"
end

local E, C, L, DB = unpack(UI)

-----------------------------------------------------------------------------------
-- DEBUG 
-----------------------------------------------------------------------------------
_EIIC_DEBUG = 0

-----------------------------------------------------------------------------------
-- CONSTANTS
-----------------------------------------------------------------------------------
EIIC_DISPLAY_SIMPLE = 0
EIIC_DISPLAY_NORMAL = 1
EIIC_DISPLAY_VERBOSE = 2
EIIC_SPACER = "       "
EIIC_VERBOSE_LEFT_COLOR1 = {r=0.5, g=0.5, b=0.85}
EIIC_VERBOSE_RIGHT_COLOR1 = {r=0.5, g=0.5, b=0.85}
EIIC_VERBOSE_LEFT_COLOR2 = {r=0.5, g=0.5, b=0.6}
EIIC_VERBOSE_RIGHT_COLOR2 = {r=0.5, g=0.5, b=0.6}

-----------------------------------------------------------------------------------
-- GLOBALS
-----------------------------------------------------------------------------------
-- These are the valid currency itemIDs in 4.2 (modify this list as necessary)
EIICCurrencyID = {241, 402, 483, 484, 390, 81, 61, 398, 384, 393, 392, 361, 395, 416, 400, 394, 397, 391, 401, 385, 396, 399}
EIICPvPCurrency = {483, 484, 390, 392}
-- The overlay frame
EIICFrame = nil
EIICCurrDict = nil

-----------------------------------------------------------------------------------
-- DEFAULTS
-----------------------------------------------------------------------------------
EIIC_DEFAULT_SHOW_UNUSED = false
EIIC_DEFAULT_SHOW_ICONS = true
EIIC_DEFAULT_DISPLAY = EIIC_DISPLAY_VERBOSE

-----------------------------------------------------------------------------------
-- EVENT HANDLERS
-----------------------------------------------------------------------------------
function EIICHandleCmd(msg, editbox)
    local lcmsg = string.lower(msg)
    
    ----------------------------------
    -- /euic simple
    ----------------------------------
    if (string.find(lcmsg,"simple") ~= nil) then
        EIICSettings.DisplayLevel = EIIC_DISPLAY_SIMPLE
        DEFAULT_CHAT_FRAME:AddMessage("ElvUI Improved Currency: Tooltip set to simple mode.")
    ----------------------------------
    -- /euic  normal
    ----------------------------------
    elseif (string.find(lcmsg,"normal") ~= nil) then
        EIICSettings.DisplayLevel = EIIC_DISPLAY_NORMAL
        DEFAULT_CHAT_FRAME:AddMessage("ElvUI Improved Currency: Tooltip set to normal mode.")
    ----------------------------------
    -- /euic  verbose
    ----------------------------------
    elseif (string.find(lcmsg,"verbose") ~= nil) then
        EIICSettings.DisplayLevel = EIIC_DISPLAY_VERBOSE
        DEFAULT_CHAT_FRAME:AddMessage("ElvUI Improved Currency: Tooltip set to verbose mode.")
    ----------------------------------
    -- /euic  icons
    ----------------------------------
    elseif (string.find(lcmsg,"icons") ~= nil) then
        if (EIICSettings.ShowIcons == true) then
            EIIC_SPACER = ""
            EIICSettings.ShowIcons = false
            DEFAULT_CHAT_FRAME:AddMessage("ElvUI Improved Currency: Hiding tooltip icons.")
        else
            EIIC_SPACER = "       "
            EIICSettings.ShowIcons = true
            DEFAULT_CHAT_FRAME:AddMessage("ElvUI Improved Currency: Showing tooltip icons.")
        end
    ----------------------------------
    -- /euic  unused
    ----------------------------------
    elseif (string.find(lcmsg,"unused") ~= nil) then
        if (EIICSettings.ShowUnused == true) then
            EIICSettings.ShowUnused = false
            DEFAULT_CHAT_FRAME:AddMessage("ElvUI Improved Currency: Hiding unused currencies.")
        else
            EIICSettings.ShowUnused = true
            DEFAULT_CHAT_FRAME:AddMessage("ElvUI Improved Currency: Showing unused currencies.")
        end
    else
        DEFAULT_CHAT_FRAME:AddMessage("ElvUI Improved Currency: ")
        DEFAULT_CHAT_FRAME:AddMessage("Simple tooltip mode: /euic simple")
        DEFAULT_CHAT_FRAME:AddMessage("Normal tooltip mode: /euic normal")
        DEFAULT_CHAT_FRAME:AddMessage("Verbose tooltip mode: /euic verbose")
        DEFAULT_CHAT_FRAME:AddMessage("Toggle display of tooltip icons: /euic icons")
        DEFAULT_CHAT_FRAME:AddMessage("Toggle display of tooltip unused items: /euic unused")
    end
end

function EIICOnLoad(self)
    EIICDebug("EIICOnLoad: Checking currency datatext...")
    if not C["datatext"].currency or C["datatext"].currency == 0 then return end
    
    self.TimeSinceLastUpdate = 0
    
    self:RegisterEvent("ADDON_LOADED")
    
    SLASH_ELVUIIMPROVEDCURRENCYDATATEXT1 = "/euic"
    
    SlashCmdList["ELVUIIMPROVEDCURRENCYDATATEXT"] = EIICHandleCmd 
end

function EIICOnEvent(self, event, ...)
    local arg1, arg2, arg3, arg4, _, arg6 = ...
    
    if (event == "ADDON_LOADED" and arg1 == "ElvUI_ImprovedCurrency") then
        EIICAddonLoaded()
    end
end

function EIICAddonLoaded()
    EIICLoadSettings()
    
    EIICDebug("EIICAddonLoaded: Called...")
    EIICFrame = CreateFrame("Frame","EIICFrame",UIParent)
    
    -- Create an invidible frame
    EIICFrame:EnableMouse(true)
    EIICFrame:SetMovable(false)
    EIICFrame:SetBackdrop(EIICFrameCreateBackdrop())
    EIICFrame:SetScript("OnEnter",EIICOnEnter)
    EIICFrame:SetScript("OnLeave", function() GameTooltip:Hide() end)
    EIICFrame:SetScript("OnMouseDown", function() ToggleCharacter("TokenFrame") end)
    EIICFrame:SetAlpha(0)
    
    --EIICPrintTable(C["datatext"])
    
    -- p is the position 1-8 in ElvUI
    local p = C["datatext"].currency
    EIICDebug("EIICAddonLoaded: Currency datatext is set to position "..p)
    -- This attches the frame over the correct position
    EIICSetPoint(EIICFrame, p)

	RequestPVPRewards()
end

function EIICOnEnter(self)
    GameTooltip:SetOwner(self.ttOwner, self.ttAnchor, self.ttOffsetX, self.ttOffsetY)
    GameTooltip:ClearLines()
    
    local unused = {}
    
    for i=1, GetCurrencyListSize() do
        local cli = {}
        cli["name"], cli["isHeader"], cli["isExpanded"], cli["isUnused"], cli["isWatched"], cli["count"], cli["texture"], cli["max"], cli["weeklyLimit"], cli["currentWeeklyAmt"] = GetCurrencyListInfo(i)
        
        if (EIICSettings.ShowUnused == true) then
            cli["isUnused"] = false
        end
        
        if (cli["isHeader"] == true and cli["isUnused"] == false) then
            if (i > 1) then GameTooltip:AddLine(" ") end
            GameTooltip:AddLine(cli["name"])
        elseif (cli["isUnused"] == false) then
            local lines = EIICFormatCurrency(cli)
            for k,v in ipairs(lines) do
	    	GameTooltip:AddDoubleLine(v["left"], v["right"], v["lr"], v["lg"], v["lb"], v["rr"], v["rg"], v["rb"])
	    	
	    	if (v["addTex"] and EIICSettings.ShowIcons == true) then
	    	    GameTooltip:AddTexture(cli["texture"])
	    	end
	    end
        end
    end
    
    GameTooltip:Show()
end

-----------------------------------------------------------------------------------
-- HELPERS
-----------------------------------------------------------------------------------
function EIICLoadSettings()
    if (EIICSettings == nil) then
        EIICSettings = {}
    end
    
    -- Version 0.1
    if (EIICSettings.ShowUnused == nil) then EIICSettings.ShowUnused = EIIC_DEFAULT_SHOW_UNUSED end
    -- end 0.1
    
    -- Defaults for v0.2
    if (EIICSettings.DisplayLevel == nil) then EIICSettings.DisplayLevel = EIIC_DEFAULT_DISPLAY end
    if (EIICSettings.ShowIcons == nil) then EIICSettings.ShowIcons = EIIC_DEFAULT_SHOW_ICONS end
    
    if (EIICSettings.ShowIcons == false) then
        EIIC_SPACER = ""
    end
    -- End 0.2
    
    EIICSettings.Version = GetAddOnMetadata("ElvUI_ImprovedCurrency", "Version")
end

function EIICFormatCurrency(cli)
    local lines = {}
    
    local line1 = {}
    
    --------- SIMPLE ------------------
    line1["left"] = "|cffFFFFFF"..cli["name"]
    line1["right"] = cli["count"]
    line1["addTex"] = true
    tinsert(lines, line1)
	    
    if (EIICSettings.DisplayLevel == EIIC_DISPLAY_SIMPLE) then
	EIICDebug("EIICFormatCurrency: Simple display "..cli["name"])
        return lines
    end
    
    if (not EIICCurrDict) then
        -- Create the currency dictionary
        EIICCreateCurrencyDictionary()
    end
    
    EIICDebug("EIICFormatCurrency: Fetching "..cli["name"])
    local curr = EIICCurrDict[cli["name"]]

    if (not curr) then
        EIICDebug("EIICFormatCurrency: curr is nil")
        return lines
    end
    
    --------- NORMAL ------------------
    if (EIICSettings.DisplayLevel == EIIC_DISPLAY_NORMAL) then
        EIICDebug("EIICFormatCurrency: Normal display "..cli["name"])
        if (curr["weeklyMax"] and curr["weeklyMax"] > 0) then
            line1["right"] = line1["right"].." |cff777777("..tostring(cli["currentWeeklyAmt"]).."/"..tostring(curr["weeklyMax"])..")"
        elseif (curr["totalMax"] and curr["totalMax"] > 0) then
            line1["right"] = tostring(cli["count"]).."/"..tostring(curr["totalMax"])
        end
        
        return lines
    end
    
    --------- VERBOSE ------------------
    if (EIICIsPvPCurrency(curr) == true) then
    	EIICDebug("EIICFormatCurrency: PvP Currency - "..cli["name"])
    	EIICFormatPvP(cli, curr, lines)
    else
    	EIICDebug("EIICFormatCurrency: General Currency - "..cli["name"])
    	EIICFormatGeneral(cli, curr, lines)
    end
    
    return lines
end

function EIICIsPvPCurrency(curr)
    for k,v in pairs(EIICPvPCurrency) do
        if (v == curr["id"]) then
            return true
        end
    end	
    
    return false
end

function EIICFormatPvP(cli, curr, lines)
    RequestPVPRewards()
    
	local lcolorR, lcolorG, lcolorB = EIIC_VERBOSE_LEFT_COLOR1.r, EIIC_VERBOSE_LEFT_COLOR1.g, EIIC_VERBOSE_LEFT_COLOR1.b
    local rcolorR, rcolorG, rcolorB = EIIC_VERBOSE_RIGHT_COLOR1.r, EIIC_VERBOSE_RIGHT_COLOR1.g, EIIC_VERBOSE_RIGHT_COLOR1.b
        
    local lcolorR2, lcolorG2, lcolorB2 = EIIC_VERBOSE_LEFT_COLOR2.r, EIIC_VERBOSE_LEFT_COLOR2.g, EIIC_VERBOSE_LEFT_COLOR2.b
    local rcolorR2, rcolorG2, rcolorB2 = EIIC_VERBOSE_RIGHT_COLOR2.r, EIIC_VERBOSE_RIGHT_COLOR2.g, EIIC_VERBOSE_RIGHT_COLOR2.b
        
        
    if (curr["id"] == 392) then  -- Honor point
        local line2 = {}
        line2["left"] = EIIC_SPACER..FROM_ALL_SOURCES
        line2["right"] =  tostring(cli["count"]).."/"..tostring(curr["totalMax"])
        line2["lr"],line2["lg"],line2["lb"] = lcolorR, lcolorG, lcolorB
        line2["rr"],line2["rg"],line2["rb"] = rcolorR, rcolorG, rcolorB
        tinsert(lines, line2)
        return
    end
        
    local capbar = {}
	
	capbar["pointsThisWeek"], capbar["maxPointsThisWeek"], capbar["tier2Quantity"], capbar["tier2Limit"], capbar["tier1Quantity"], capbar["tier1Limit"] = GetPVPRewards()
	
	if (not capbar["maxPointsThisWeek"]) then return end
        
        --EIICPrintTable(capbar)
	--EIICDebug(" ")
	
	local line2 = {}
	line2["left"] = EIIC_SPACER..FROM_ALL_SOURCES
	line2["right"] =  format(CURRENCY_WEEKLY_CAP_FRACTION, capbar["pointsThisWeek"], capbar["maxPointsThisWeek"])
        line2["lr"],line2["lg"],line2["lb"] = lcolorR, lcolorG, lcolorB
        line2["rr"],line2["rg"],line2["rb"] = rcolorR, rcolorG, rcolorB
	tinsert(lines, line2)

	local line3 = {}
	line3["left"] = EIIC_SPACER.." -"..FROM_RATEDBG
	line3["right"] = format(CURRENCY_WEEKLY_CAP_FRACTION, capbar["tier2Quantity"], capbar["tier2Limit"])
        line3["lr"],line3["lg"],line3["lb"] = lcolorR2, lcolorG2, lcolorB2
        line3["rr"],line3["rg"],line3["rb"] = rcolorR2, rcolorG2, rcolorB2
	tinsert(lines, line3)

	local line4 = {}
	line4["left"] = EIIC_SPACER.." -"..FROM_ARENA
	line4["right"] = format(CURRENCY_WEEKLY_CAP_FRACTION, capbar["tier1Quantity"], capbar["tier1Limit"])
        line4["lr"],line4["lg"],line4["lb"] = lcolorR, lcolorG, lcolorB
        line4["rr"],line4["rg"],line4["rb"] = rcolorR, rcolorG, rcolorB
	tinsert(lines, line4)
end

function EIICFormatGeneral(cli, curr, lines)
    local lcolorR, lcolorG, lcolorB = EIIC_VERBOSE_LEFT_COLOR1.r, EIIC_VERBOSE_LEFT_COLOR1.g, EIIC_VERBOSE_LEFT_COLOR1.b
    local rcolorR, rcolorG, rcolorB = EIIC_VERBOSE_RIGHT_COLOR1.r, EIIC_VERBOSE_RIGHT_COLOR1.g, EIIC_VERBOSE_RIGHT_COLOR1.b
    
    local lcolorR2, lcolorG2, lcolorB2 = EIIC_VERBOSE_LEFT_COLOR2.r, EIIC_VERBOSE_LEFT_COLOR2.g, EIIC_VERBOSE_LEFT_COLOR2.b
    local rcolorR2, rcolorG2, rcolorB2 = EIIC_VERBOSE_RIGHT_COLOR2.r, EIIC_VERBOSE_RIGHT_COLOR2.g, EIIC_VERBOSE_RIGHT_COLOR2.b
        
    if (curr["id"] == 395) then  -- Justice point
        local line2 = {}
        line2["left"] = EIIC_SPACER..FROM_ALL_SOURCES
        line2["right"] =  tostring(cli["count"]).."/"..tostring(curr["totalMax"])
        line2["lr"],line2["lg"],line2["lb"] = lcolorR, lcolorG, lcolorB
        line2["rr"],line2["rg"],line2["rb"] = rcolorR, rcolorG, rcolorB
        tinsert(lines, line2)
        return
    end
        
    if (not curr["lfdID"]) then return end
        
        -- Get the point info
	local capbar = {}
        
    EIICDebug("EIICFormatGeneral:  Calling GetLFGDungeonRewardCapBarInfo("..curr["lfdID"]..") - "..curr["name"])
    capbar["currencyID"], capbar["tier1DungeonID"], capbar["tier1Quantity"], capbar["tier1Limit"], capbar["overallQuantity"], capbar["overallLimit"], capbar["periodPurseQuantity"], capbar["periodPurseLimit"] = GetLFGDungeonRewardCapBarInfo(curr["lfdID"]);
	
    if (not capbar["currencyID"]) then return end
        
	--EIICPrintTable(capbar)
	--EIICDebug(" ")
	
	EIICDebug("EIICFormatGeneral:  Calling GetLFGDungeonInfo...")
    local tier1Name = GetLFGDungeonInfo(capbar["tier1DungeonID"])

    local line2 = {}
    line2["left"] = EIIC_SPACER..FROM_ALL_SOURCES
    line2["right"] =  format(CURRENCY_WEEKLY_CAP_FRACTION, capbar["periodPurseQuantity"], capbar["periodPurseLimit"])
    line2["lr"],line2["lg"],line2["lb"] = lcolorR, lcolorG, lcolorB
    line2["rr"],line2["rg"],line2["rb"] = rcolorR, rcolorG, rcolorB
    tinsert(lines, line2)

    local line3 = {}
    line3["left"] = EIIC_SPACER.." -"..FROM_RAID
    line3["right"] = format(CURRENCY_WEEKLY_CAP_FRACTION, capbar["periodPurseQuantity"] - capbar["overallQuantity"], capbar["periodPurseLimit"])
    line3["lr"],line3["lg"],line3["lb"] = lcolorR2, lcolorG2, lcolorB2
    line3["rr"],line3["rg"],line3["rb"] = rcolorR2, rcolorG2, rcolorB2
    tinsert(lines, line3)

    local line4 = {}
    line4["left"] = EIIC_SPACER.." -"..FROM_DUNGEON_FINDER_SOURCES
    line4["right"] = format(CURRENCY_WEEKLY_CAP_FRACTION, capbar["overallQuantity"], capbar["overallLimit"])
    line4["lr"],line4["lg"],line4["lb"] = lcolorR, lcolorG, lcolorB
    line4["rr"],line4["rg"],line4["rb"] = rcolorR, rcolorG, rcolorB
    tinsert(lines, line4)

    local line5 = {}
    line5["left"] = EIIC_SPACER.."   -"..FROM_TROLLPOCALYPSE
    line5["right"] = format(CURRENCY_WEEKLY_CAP_FRACTION, capbar["overallQuantity"] - capbar["tier1Quantity"], capbar["overallLimit"])
    line5["lr"],line5["lg"],line5["lb"] = lcolorR2, lcolorG2, lcolorB2
    line5["rr"],line5["rg"],line5["rb"] = rcolorR2, rcolorG2, rcolorB2
    tinsert(lines, line5)

    local line6 = {}
    line6["left"] = EIIC_SPACER.."   -"..format(FROM_A_DUNGEON, tier1Name)
    line6["right"] = format(CURRENCY_WEEKLY_CAP_FRACTION, capbar["tier1Quantity"], capbar["tier1Limit"])
    line6["lr"],line6["lg"],line6["lb"] = lcolorR, lcolorG, lcolorB
    line6["rr"],line6["rg"],line6["rb"] = rcolorR, rcolorG, rcolorB
    tinsert(lines, line6)
end

function EIICCreateCurrencyDictionary()
    EIICCurrDict = {}
    
    EIICDebug("EIICCreateCurrencyDictionary: Called ")
    
    for k,v in pairs(EIICCurrencyID) do
        curr = {}
        curr["name"], curr["count"], curr["texture"], curr["4"], curr["weeklyMax"], curr["totalMax"], curr["7"] = GetCurrencyInfo(v)
        
        if (curr["weeklyMax"] and curr["weeklyMax"] >= 10000) then 
            curr["weeklyMax"] = curr["weeklyMax"] / 100
        end
        
        if (curr["totalMax"] and curr["totalMax"] >= 10000) then 
            curr["totalMax"] = curr["totalMax"] / 100
        end
        
        curr["id"] = v
        
        if (v == 396) then -- valor pt
            curr["lfdID"] = 301
        end
     
        
        --EIICDebug("EIICCreateCurrencyDictionary: Added "..curr["name"])
        EIICCurrDict[curr["name"]] = curr
    end
    
    EIICDebug("EIICCreateCurrencyDictionary: Create.  Size is "..#(EIICCurrDict))
    --EIICPrintTable(EIICCurrDict)
end

function EIICSetFrameProps(self, width, height, selfAnchorPoint, parentFrame, parentAnchorPoint, xOffset, yOffset, backdrop)
    local sxOffset, syOffset
    
    sxOffset = xOffset
    syOffset = yOffset
    
    if (width ~= nil) then self:SetWidth(width) end
    if (height ~= nil) then self:SetHeight(height) end
    
    if (type(backdrop) == "table") then -- dont use nil here since it is a valid value
        self:SetBackdrop(backdrop)
    end

    
    -- SetPoint logic
    if (xOffset ~= nil and yOffset ~= nil) then
        if (selfAnchorPoint ~= nil and parentFrame ~= nil and parentAnchorPoint ~= nil) then
            self:SetPoint(selfAnchorPoint, parentFrame, parentAnchorPoint, sxOffset, syOffset)
        elseif (selfAnchorPoint ~= nil and parentFrame ~= nil) then
            self:SetPoint(selfAnchorPoint, parentFrame, sxOffset, syOffset)
        elseif (selfAnchorPoint ~= nil) then
            self:SetPoint(selfAnchorPoint, sxOffset, syOffset)
        end
    end
end

function EIICFrameCreateBackdrop()
    return      {
                    bgFile = "Interface/DialogFrame/UI-DialogBox-Background", 
                    tile = true, tileSize = 16,
                    insets = { left = 0, right = 0, top = 0, bottom = 0 }
                }
end

function EIICSetPoint(obj, p)
    EIICSetFrameProps(obj, 0, 0, "CENTER", UIParent, "CENTER", 0, 0, EIICFrameCreateBackdrop())
    obj:SetFrameStrata("DIALOG")
    obj:Raise()
    
    local left, right, mapleft, mapright, minimap
    
    if (INTERFACE == "elvui") then
        left = ElvuiInfoLeft
        right = ElvuiInfoRight
        mapleft = ElvuiMinimapStatsLeft
        mapright = ElvuiMinimapStatsRight
        minimap = ElvuiMinimap
    else
        left = TukuiInfoLeft
        right = TukuiInfoRight
        mapleft = TukuiMinimapStatsLeft
        mapright = TukuiMinimapStatsRight
        minimap = TukuiMinimap
    end
      
    
    local x, bottom, bottomleft, bottomright
    local xOffset = 0
    
    if ElvUILowerStatPanel then
        bottom = ElvUILowerStatPanel
        bottomleft = ElvUILowerStatPanelLeft
        bottomright = ElvUILowerStatPanelRight
        x = ElvuiActionBarBackground:GetWidth()/3
    end
    
    if (p == 1 or p ==2 or p == 3) then
        xOffset = left:GetWidth()/3
        --obj:SetParent(left)
        obj:SetHeight(left:GetHeight())
        obj:SetWidth(xOffset)
        obj.ttOwner = left
        obj.ttAnchor = "ANCHOR_TOPLEFT"
        obj.ttOffsetX = E.Scale(-17)
        obj.ttOffsetY = E.Scale(4)
    elseif (p == 4 or p == 5 or p == 6) then
        xOffset = right:GetWidth()/3
        obj:SetHeight(right:GetHeight())
        obj:SetWidth(xOffset)
        obj.ttOwner = right
        obj.ttAnchor = "ANCHOR_TOPRIGHT"
        obj.ttOffsetX = E.Scale(17)
        obj.ttOffsetY = E.Scale(4)
    elseif (p == 7 or p == 8) then
        obj.ttOwner = mapright
        obj.ttAnchor = "ANCHOR_BOTTOMLEFT"
        obj.ttOffsetX = mapright:GetWidth()
        obj.ttOffsetY = E.Scale(-4)
    end
    
    if p == 1 then
        obj:SetPoint("CENTER",left,"CENTER",-xOffset,0)
    elseif p == 2 then
        obj:SetPoint("CENTER",left,"CENTER",0,0)
    elseif p == 3 then
        obj:SetPoint("CENTER",left,"CENTER",xOffset,0)
    elseif p == 4 then
        obj:SetPoint("CENTER",right,"CENTER",-xOffset,0)
    elseif p == 5 then
        obj:SetPoint("CENTER",right,"CENTER",0,0)
    elseif p == 6 then
        obj:SetPoint("CENTER",right,"CENTER",xOffset,0)
    end
    
    if minimap then
        if p == 7 then
            obj:SetHeight(mapleft:GetHeight())
            obj:SetWidth(mapleft:GetWidth())
            obj:SetPoint("CENTER", mapleft, 0, 0)
        elseif p == 8 then
            obj:SetHeight(mapright:GetHeight())
            obj:SetWidth(mapright:GetWidth())
            obj:SetPoint("CENTER", mapright, 0, 0)
        end
    end
    
    if (INTERFACE == "tukui") then
        return
    end
    
    -- Extended panels
    if C["general"].upperpanel == true and C["general"].lowerpanel == true then
        if p == 9 then
            obj.ttOwner = ElvuiStat9Block
            obj.ttAnchor = "ANCHOR_BOTTOM"
            obj.ttOffsetX = 0
            obj.ttOffsetY = E.Scale(-4)
            
            obj:SetHeight(ElvuiStat9Block:GetHeight())
            obj:SetWidth(ElvuiStat9Block:GetWidth())
            obj:SetPoint("CENTER", ElvuiStat9Block, 0, 0)
        elseif p == 10 then
            obj.ttOwner = ElvuiStat10Block
            obj.ttAnchor = "ANCHOR_BOTTOM"
            obj.ttOffsetX = 0
            obj.ttOffsetY = E.Scale(-4)
            
            obj:SetHeight(ElvuiStat10Block:GetHeight())
            obj:SetWidth(ElvuiStat10Block:GetWidth())
            obj:SetPoint("CENTER", ElvuiStat10Block, 0, 0)
        elseif p == 11 then
            obj.ttOwner = bottomleft
            obj.ttAnchor = "ANCHOR_TOP"
            obj.ttOffsetX = 0
            obj.ttOffsetY = E.Scale(4)
            
            obj:SetHeight(bottomleft:GetHeight())
            obj:SetWidth(bottomleft:GetWidth())
            obj:SetPoint("CENTER", bottomleft, 0, 0)
        elseif p == 12 then
            obj.ttOwner = bottom
            obj.ttAnchor = "ANCHOR_TOP"
            obj.ttOffsetX = E.Scale(0)
            obj.ttOffsetY = E.Scale(4)
            
            xOffset = bottom:GetWidth()/2
            obj:SetHeight(bottom:GetHeight())
            obj:SetWidth(xOffset)
            obj:SetPoint("BOTTOMLEFT",bottom,"BOTTOMLEFT",0,0)
        elseif p == 13 then
            obj.ttOwner = bottom
            obj.ttAnchor = "ANCHOR_TOP"
            obj.ttOffsetX = E.Scale(0)
            obj.ttOffsetY = E.Scale(4)
            
            xOffset = bottom:GetWidth()/2
            obj:SetHeight(bottom:GetHeight())
            obj:SetWidth(xOffset)
            obj:SetPoint("BOTTOMRIGHT",bottom,"BOTTOMRIGHT",0,0)
        elseif p == 14 then
            obj.ttOwner = bottomright
            obj.ttAnchor = "ANCHOR_TOP"
            obj.ttOffsetX = 0
            obj.ttOffsetY = E.Scale(4)
            
            obj:SetHeight(bottomright:GetHeight())
            obj:SetWidth(bottomright:GetWidth())
            obj:SetPoint("CENTER", bottomright, 0, 0)
        end		
    end
	
    if C["general"].lowerpanel == true and C["general"].upperpanel ~= true then
        if p == 9 then
            obj.ttOwner = bottomleft
            obj.ttAnchor = "ANCHOR_TOP"
            obj.ttOffsetX = 0
            obj.ttOffsetY = E.Scale(4)
            
            obj:SetHeight(bottomleft:GetHeight())
            obj:SetWidth(bottomleft:GetWidth())
            obj:SetPoint("CENTER", bottomleft, 0, 0)
        elseif p == 10 then
            obj.ttOwner = bottom
            obj.ttAnchor = "ANCHOR_TOP"
            obj.ttOffsetX = 0
            obj.ttOffsetY = E.Scale(4)
            
            xOffset = bottom:GetWidth()/2
            obj:SetHeight(bottom:GetHeight())
            obj:SetWidth(xOffset)
            obj:SetPoint("BOTTOMLEFT",bottom,"BOTTOMLEFT",0,0)
        elseif p == 11 then
            obj.ttOwner = bottom
            obj.ttAnchor = "ANCHOR_TOP"
            obj.ttOffsetX = 0
            obj.ttOffsetY = E.Scale(4)
            
            xOffset = bottom:GetWidth()/2
            obj:SetHeight(bottom:GetHeight())
            obj:SetWidth(xOffset)
            obj:SetPoint("BOTTOMRIGHT",bottom,"BOTTOMRIGHT",0,0)
        elseif p == 12 then
            obj.ttOwner = bottomright
            obj.ttAnchor = "ANCHOR_TOP"
            obj.ttOffsetX = 0
            obj.ttOffsetY = E.Scale(4)
            
            obj:SetHeight(bottomright:GetHeight())
            obj:SetWidth(bottomright:GetWidth())
            obj:SetPoint("CENTER", bottomright, 0, 0)
        end		
    end	
	
    if C["general"].lowerpanel ~= true and C["general"].upperpanel == true then
        if p == 9 then
            obj.ttOwner = ElvuiStat9Block
            obj.ttAnchor = "ANCHOR_BOTTOM"
            obj.ttOffsetX = 0
            obj.ttOffsetY = E.Scale(-4)
            
            obj:SetHeight(ElvuiStat9Block:GetHeight())
            obj:SetWidth(ElvuiStat9Block:GetWidth())
            obj:SetPoint("CENTER", ElvuiStat9Block, 0, 0)
        elseif p == 10 then
            obj.ttOwner = ElvuiStat10Block
            obj.ttAnchor = "ANCHOR_BOTTOM"
            obj.ttOffsetX = 0
            obj.ttOffsetY = E.Scale(-4)
            
            obj:SetHeight(ElvuiStat10Block:GetHeight())
            obj:SetWidth(ElvuiStat10Block:GetWidth())
            obj:SetPoint("CENTER", ElvuiStat10Block, 0, 0)
        end
    end		
end
-----------------------------------------------------------------------------------
-- DEBUG
-----------------------------------------------------------------------------------
function EIICPrintTable(t)
    for k,v in pairs(t) do
        if (type(v) == "table") then
            DEFAULT_CHAT_FRAME:AddMessage(k .. ":")
            EIICPrintTable(v)
        else
            DEFAULT_CHAT_FRAME:AddMessage(k .. "(" .. type(v) ..") = " .. tostring(v))
        end
    end
end

function EIICDebug(txt,stack)
    if (_EIIC_DEBUG == 1) then
        DEFAULT_CHAT_FRAME:AddMessage("|cffFF0000"..tostring(txt))
        
        if (stack ~= nil) then
            DEFAULT_CHAT_FRAME:AddMessage("|cffAA0000-- MGM START STACK TRACE --\n"..debugstack().."\n-- MGM END STACK TRACE --")
        end
    end
end
