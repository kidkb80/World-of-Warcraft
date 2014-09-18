local E, L, V, P, G, _ = unpack(ElvUI); --Inport: Engine, Locales, PrivateDB, ProfileDB, GlobalDB, Localize Underscore
local BUI = E:NewModule('BenikUI');

local LSM = LibStub("LibSharedMedia-3.0")
local EP = LibStub("LibElvUIPlugin-1.0")
local addon, ns = ...

local backdropr, backdropg, backdropb, backdropa, borderr, borderg, borderb = 0, 0, 0, 1, 0, 0, 0

BUI.TexCoords = {.08, 0.92, -.12, 0.85}
BUI.Title = "|cff00c0faBenikUI |r"
BUI.Version = GetAddOnMetadata("ElvUI_BenikUI", "Version")
BUI.newsign = "|TInterface\\OptionsFrame\\UI-OptionsFrame-NewFeatureIcon:14:14|t"

function BUI:cOption(name)
	local BUI_COLOR = "|cff00c0fa%s |r"
	return (BUI_COLOR):format(name)
end

function BUI:RegisterBuiMedia()
	--Fonts
	E["media"].buiFont = LSM:Fetch("font", "BUI Prototype")
	E["media"].buiVisitor = LSM:Fetch("font", "Bui Visitor1")
	E["media"].buiVisitor2 = LSM:Fetch("font", "Bui Visitor2")
	E["media"].buiTuk = LSM:Fetch("font", "Bui Tukui")
	
	--Textures
	E["media"].BuiEmpty = LSM:Fetch("statusbar", "BuiEmpty")
	E["media"].BuiFlat = LSM:Fetch("statusbar", "BuiFlat")
	E["media"].BuiMelli = LSM:Fetch("statusbar", "BuiMelli")
	E["media"].BuiMelliDark = LSM:Fetch("statusbar", "BuiMelliDark")
end

E.BuiConfig = {}

-- Like S&L did ;)
function BUI:AddOptions()
	for _, func in pairs(E.BuiConfig) do
		func()
	end	
end

function BUI:InitBUI()
	self:StyleTooltip()
	E:GetModule('DataTexts'):ToggleMailFrame()
end

function BUI:Initialize()
	self:RegisterBuiMedia()
	self:InitBUI()
	if E.private.install_complete == E.version and E.db.bui.installed == nil then E:SetupBui() end
	print(BUI.Title..format("v|cff00c0fa%s|r",BUI.Version)..L[" is loaded. For any issues or suggestions, please visit http://www.tukui.org/forums/topic.php?id=30598"])
	EP:RegisterPlugin(addon, self.AddOptions)
end

E:RegisterModule(BUI:GetName())