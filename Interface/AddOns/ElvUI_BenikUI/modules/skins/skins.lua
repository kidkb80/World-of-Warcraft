local E, L, V, P, G, _ = unpack(ElvUI); --Import: Engine, Locales, PrivateDB, ProfileDB, GlobalDB, Localize Underscore
local BUIS = E:NewModule('BuiSkins', "AceHook-3.0", 'AceEvent-3.0');
local BUI = E:GetModule('BenikUI');

local SPACING = (E.PixelMode and 1 or 5)

-----------------------------------------------

local FreeBlizzFrames = {
	AddFriendFrame,
	AudioOptionsFrame,
	BNToastFrame,
	ChatConfigFrame,
	ClassTrainerFrame,
	ConsolidatedBuffsTooltip, -- check
	DressUpFrame,
	DropDownList1,
	DropDownList2,
	ElvUI_StaticPopup1,
	ElvUI_StaticPopup2,
	ElvUI_StaticPopup3,
	FloatingBattlePetTooltip,
	FriendsFrame,
	GameMenuFrame,
	GossipFrame,
	GuildRegistrarFrame,
	InterfaceOptionsFrame,
	ItemRefTooltip,
	ItemTextFrame,
	LFGDungeonReadyPopup,
	LFGDungeonReadyDialog,
	LFGDungeonReadyStatus,
	MailFrame,
	MerchantFrame,
	MinimapRightClickMenu,
	OpenMailFrame,
	PaperDollItemsFrame,
	PetitionFrame, -- check
	PetJournalParent,
	PetPaperDollFrame,
	PetStableFrame,
	QuestLogDetailFrame,
	QuestLogFrame,
	QueueStatusFrame,
	RaidInfoFrame,
	ReadyCheckFrame,
	ReadyCheckListenerFrame,
	ReputationDetailFrame,
	ReputationFrame,
	SpellBookFrame,
	StackSplitFrame,
	StaticPopup1,
	StaticPopup2,
	StaticPopup3,
	TabardFrame,
	TicketStatusFrameButton, -- check
	TokenFrame,
	TokenFramePopup,
	TradeFrame, -- check
	TransmogrifyConfirmationPopup,
	VideoOptionsFrame,
	WorldMapFrame, -- checked not loading on big map
	WorldStateScoreScrollFrame, -- check
}

-------------------------------------
-- the style is smaller by 1-2 pixels
-------------------------------------
local FreeBlizzSmallerFrames = {
	ChannelFrameDaughterFrame,
	HelpFrame,
	HelpFrameHeader,
	PVEFrame,
	QuestFrame,
	QuestNPCModel,
	RaidBrowserFrame,
	TaxiFrame,
}

local BlizzUiFrames = {
	--{"BlizzUIname, "FrameToBeStyled, "ElvUIdisableSkinOption"}
	{"Blizzard_AchievementUI", "AchievementFrame", "achievement"},
	{"Blizzard_ArchaeologyUI", "ArchaeologyFrame", "archaeology"},
	{"Blizzard_AuctionUI", "AuctionFrame", "auctionhouse"},
	{"Blizzard_BarbershopUI", "BarberShopFrame", "barber"},
	{"Blizzard_BattlefieldMinimap", "BattlefieldMinimap", "bgmap"}, -- check
	{"Blizzard_BindingUI", "KeyBindingFrame", "binding"},
	{"Blizzard_BlackMarketUI", "BlackMarketFrame", "bmah"}, -- check
	{"Blizzard_Calendar", "CalendarFrame", "calendar"},
	{"Blizzard_Calendar", "CalendarViewEventFrame", "calendar"},
	{"Blizzard_Calendar", "CalendarViewHolidayFrame", "calendar"},
	{"Blizzard_GuildBankUI", "GuildBankFrame", "gbank"},
	{"Blizzard_GuildUI", "GuildFrame", "guild"}, -- check
	{"Blizzard_GuildControlUI", "GuildControlUI", "guildcontrol"}, -- check
	{"Blizzard_InspectUI", "InspectFrame", "inspect"},
	{"Blizzard_ItemAlterationUI", "TransmogrifyFrame", "transmogrify"},
	{"Blizzard_ItemUpgradeUI", "ItemUpgradeFrame", "itemUpgrade"},
	{"Blizzard_LookingForGuildUI", "LookingForGuildFrame", "lfguild"},
	{"Blizzard_MacroUI", "MacroFrame", "macro"},
	{"Blizzard_PetJournal", "PetJournalParent", "mounts"},
	{"Blizzard_PVPUI", "PVPUIFrame", "pvp"},
	{"Blizzard_ReforgingUI", "ReforgingFrame", "reforge"},
	{"Blizzard_ItemSocketingUI", "ItemSocketingFrame", "socket"},
	{"Blizzard_TalentUI", "PlayerTalentFrame", "talent"},
	--{"Blizzard_TimeManager", "TimeManagerFrame", "timemanager"},
	{"Blizzard_TradeSkillUI", "TradeSkillFrame", "trade"},
	{"Blizzard_TrainerUI", "ClassTrainerFrame", "trainer"},
	{"Blizzard_VoidStorageUI", "VoidStorageFrame", "voidstorage"},
}

function BUI:StyleBlizzard(parent, ...)
	local frame = CreateFrame('Frame', parent..'Decor', E.UIParent)
	frame:CreateBackdrop('Default', true)
	frame:SetParent(parent)
	frame:Point('TOPLEFT', parent, 'TOPLEFT', SPACING, 4)
	frame:Point('BOTTOMRIGHT', parent, 'TOPRIGHT', -SPACING, 0)
end

function BUIS:BlizzardUI_LOD_Skins(event, addon)
	for i, v in ipairs(BlizzUiFrames) do
		local blizzAddon, blizzFrame, elvoption = unpack( v )
		if (event == "ADDON_LOADED" and addon == blizzAddon) then
			if E.private.skins.blizzard.enable ~= true or E.private.skins.blizzard[elvoption] ~= true then return end
			if blizzFrame then
				BUI:StyleBlizzard(blizzFrame)
				-- Fixes
				if addon == "Blizzard_AchievementUI" then
					if AchievementFrameCloseButton then
						AchievementFrameCloseButton:Point("TOPRIGHT", AchievementFrame, "TOPRIGHT", 4, 5) -- reposition the button a bit
					end
					if AchievementFrameFilterDropDown then
						AchievementFrameFilterDropDown:Point("TOPRIGHT", AchievementFrame, "TOPRIGHT", -44, 2) -- reposition the dropdown a bit
					end
				end
				if addon == "Blizzard_GuildBankUI" then
					for i = 1, 8 do
						local button = _G["GuildBankTab"..i.."Button"]
						local texture = _G["GuildBankTab"..i.."ButtonIconTexture"]
						button:Style('Inside')
						texture:SetTexCoord(unpack(BUI.TexCoords))
					end
				end
				if addon == "Blizzard_TalentUI" then 
					for i = 1, 2 do
						local tab = _G['PlayerSpecTab'..i]
						tab:Style('Inside')
						tab:GetNormalTexture():SetTexCoord(unpack(BUI.TexCoords))
						tab:GetNormalTexture():SetInside()
					end
				end
				if addon == "Blizzard_GuildUI" then
					GuildMemberDetailFrame:Style('Outside')
				end
			end
		end
	end
	
	-- What the fart is wrong with this check?
	--if addon == "Blizzard_TimeManager" then
		if E.private.skins.blizzard.timemanager == true then
			TimeManagerFrame:Style('Outside')
		else return end
	--end
	
	if addon == "Blizzard_EncounterJournal" then
		if E.private.skins.blizzard.enable ~= true or E.private.skins.blizzard.encounterjournal ~= true then return end
		EncounterJournal:Style('Small')
	end
end

function BUIS:BenikUISkins()
	-- Blizzard Styles
	for _, frame in pairs(FreeBlizzFrames) do
		if frame then
			frame:Style('Outside')
		end
	end

	for _, frame in pairs(FreeBlizzSmallerFrames) do
		if frame then
			frame:Style('Small')
		end
	end
	
	-- SpellBook tabs
	hooksecurefunc("SpellBookFrame_UpdateSkillLineTabs", function()
		for i = 1, MAX_SKILLLINE_TABS do
			local tab = _G["SpellBookSkillLineTab"..i]
			tab:Style('Inside')
			tab:GetNormalTexture():SetTexCoord(unpack(BUI.TexCoords))
		end
	end)
	
	-- SpellBook Core abilities tabs
	local function SkinCoreTabs(index)
		local button = SpellBookCoreAbilitiesFrame.SpecTabs[index]
		button:Style('Inside')
		button:GetNormalTexture():SetTexCoord(unpack(BUI.TexCoords))
	end
	hooksecurefunc('SpellBook_GetCoreAbilitySpecTab', SkinCoreTabs)
	
	-- Style Changes
	DressUpFrame.style:Point('TOPLEFT', DressUpFrame, 'TOPLEFT', 6, 5)
	DressUpFrame.style:Point('BOTTOMRIGHT', DressUpFrame, 'TOPRIGHT', -32, -1)

	MerchantFrame.style:Point('TOPLEFT', MerchantFrame, 'TOPLEFT', 6, 5)
	MerchantFrame.style:Point('BOTTOMRIGHT', MerchantFrame, 'TOPRIGHT', 2, -1)
	
	WorldMapFrame.style:Point('TOPLEFT', WorldMapFrame, 'TOPLEFT', 2, 6)
	WorldMapFrame.style:Point('BOTTOMRIGHT', WorldMapFrame, 'TOPRIGHT', 2, 1)

	-- AddOn Styles
	if IsAddOnLoaded('ElvUI_LocLite') and E.db.elvuiaddons.loclite then
		local framestoskin = {LocationLitePanel, XCoordsLite, YCoordsLite}
		for _, frame in pairs(framestoskin) do
			if frame then
				frame:Style('Outside')
			end
		end
	end
	
	if IsAddOnLoaded('ElvUI_LocPlus') and E.db.elvuiaddons.locplus then
		local framestoskin = {LeftCoordDtPanel, RightCoordDtPanel, LocationPlusPanel, XCoordsPanel, YCoordsPanel}
		for _, frame in pairs(framestoskin) do
			if frame then
				frame:Style('Outside')
			end
		end
	end
	
	if IsAddOnLoaded('ElvUI_SLE') and E.db.elvuiaddons.sle then
		local sleFrames = {BottomBG, LeftBG, RightBG, ActionBG, DP_1, DP_2, Top_Center, DP_3, DP_4, DP_5, Bottom_Panel, DP_6, Main_Flares, Mark_Menu}		
		for _, frame in pairs(sleFrames) do
			if frame then
				frame:Style('Outside')
			end
		end
	end
	
	if IsAddOnLoaded('SquareMinimapButtons') and E.db.elvuiaddons.smb then
		local smbFrame = SquareMinimapButtonBar
		if smbFrame then
			smbFrame:Style('Outside')
		end
	end
end

function BUIS:Initialize()
	self:RegisterEvent('ADDON_LOADED', 'BlizzardUI_LOD_Skins')
	self:RegisterEvent('PLAYER_ENTERING_WORLD', 'BenikUISkins')
end

if IsAddOnLoaded("AddOnSkins") then
	local AS = unpack(AddOnSkins)

	local function SkadaDecor()
		if not E.db.addonskins.skada then return end
		hooksecurefunc(Skada.displays['bar'], 'ApplySettings', function(self, win)
			local skada = win.bargroup
			skada.backdrop:Style('Outside')
			if win.db.enabletitle then
				skada.button:StripTextures()
			end
			if not skada.backdrop.ishooked then
				hooksecurefunc(AS, 'Embed_Check', function(self, message)
					if E.private.addonskins.EmbedSystem and E.private.addonskins.EmbedSkada then
						skada.backdrop.style:Hide()
					else
						skada.backdrop.style:Show()
					end
				end)
				skada.backdrop.ishooked = true
			end
		end)
	end
	
	local function StyleRecount(name, parent, ...)
		local recountdecor = CreateFrame('Frame', name, E.UIParent)
		recountdecor:SetTemplate('Default', true)
		recountdecor:SetParent(parent)
		recountdecor:Point('TOPLEFT', parent, 'TOPLEFT', 0, -2)
		recountdecor:Point('BOTTOMRIGHT', parent, 'TOPRIGHT', 0, -7)

		return recountdecor
	end

	local function RecountDecor()
		if not E.db.addonskins.recount then return end
		StyleRecount('recountMain', Recount_MainWindow)
		Recount_MainWindow.TitleBackground:StripTextures()
		Recount_ConfigWindow.TitleBackground:StripTextures()
		Recount_DetailWindow.TitleBackground:StripTextures()
		StyleRecount(nil, Recount_DetailWindow)
		StyleRecount(nil, Recount_ConfigWindow)
		hooksecurefunc(Recount, 'ShowReport', function(self)
			if Recount_ReportWindow.TitleBackground then
				Recount_ReportWindow.TitleBackground:StripTextures()
				StyleRecount(nil, Recount_ReportWindow)
			end
		end)

		hooksecurefunc(AS, 'Embed_Check', function(self, message)
			if E.private.addonskins.EmbedSystem and E.private.addonskins.EmbedMain == "Recount" then
				recountMain:Hide()
			else
				recountMain:Show()
			end
		end)
	end
	
	local function TinyDPSDecor()
		if not E.db.addonskins.tinydps then return end
		if tdpsFrame then
			tdpsFrame:Style('Outside')
		end
	end
	
	local function AtlasLootDecor()
		if not E.db.addonskins.atlasloot then return end
		if AtlasLootDefaultFrame then
			AtlasLootDefaultFrame:Style('Outside', 'ALDecor')
			AtlasLootDefaultFrame:HookScript('OnShow', function(self) ALDecor:Show(); end)
			AtlasLootDefaultFrame:HookScript('OnHide', function(self) ALDecor:Hide(); end)
		end
		if AtlasLootTooltipTEMP then
			AtlasLootTooltipTEMP:Style('Outside', 'ALTooltipDecor')
			AtlasLootTooltipTEMP:HookScript('OnShow', function(self) ALTooltipDecor:Show(); end)
			AtlasLootTooltipTEMP:HookScript('OnHide', function(self) ALTooltipDecor:Hide(); end)
			ALTooltipDecor:SetClampedToScreen(true)
		end
	end
	
	local function AltoholicDecor()
		if not E.db.addonskins.altoholic then return end
		if AltoholicFrame then
			AltoholicFrame:Style('Outside')
		end
	end
	
	local function ZygorDecor()
		if not E.db.addonskins.zg then return end
		local zgFrames = {ZygorGuidesViewerFrame_Border, ZygorGuidesViewer_CreatureViewer}
		for _, frame in pairs(zgFrames) do
			frame:Style('Outside', frame:GetName()..'Decor')
		end
	end
	
	local function RareCoordDecor()
		if not E.db.addonskins.rc then return end
		local rcFrames = {RC, RC.opt, RCnotify, RCminimized}
		for _, frame in pairs(rcFrames) do
			frame:Style('Outside')
		end	
	end
	
	local function BenikUISkins(self, event, addon)
		if event == 'ADDON_LOADED' then
			BUIS:BlizzardUI_LOD_Skins(event, addon)
		else
			BUIS:BenikUISkins()
		end
	end

	if AS:CheckAddOn('Skada') then AS:RegisterSkin('SkadaSkin', SkadaDecor, 2) end
	if AS:CheckAddOn('Recount') then AS:RegisterSkin('RecountSkin', RecountDecor, 2) end
	if AS:CheckAddOn('TinyDPS') then AS:RegisterSkin('TinyDPSSkin', TinyDPSDecor, 2) end
	if AS:CheckAddOn('AtlasLoot') then AS:RegisterSkin('AtlasLootSkin', AtlasLootDecor, 2) end
	if AS:CheckAddOn('Altoholic') then AS:RegisterSkin('AltoholicSkin', AltoholicDecor, 2) end
	if AS:CheckAddOn('RareCoordinator') then AS:RegisterSkin('RareCoordinatorSkin', RareCoordDecor, 2) end
	if AS:CheckAddOn('ZygorGuidesViewer') then AS:RegisterSkin('ZygorSkin', ZygorDecor, 2) end
end

E:RegisterModule(BUIS:GetName())
