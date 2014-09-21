local AceLocale = LibStub:GetLibrary("AceLocale-3.0") 
local L = AceLocale:NewLocale("PitBull4_BurningEmbersBar", "enUS", true) 
if not L then return end 

L["Burning Embers bar"] = true
L["Show a bar indicating the unit's Burning Embers count."] = true
L["Show Ember Tenths"] = true
L["Update the Burning Embers bar in tenth of an Ember increments."] = true
L["Only Show Current Ember"] = true
L["Only show the currently building Ember. You must have 'Show Ember Tenths' checked."] = true
