local _, addon = ...;

local L = {};
addon.L = L;

setmetatable(L, {
	__index = function(self, key) 
		--[===[@debug@
		print("hfLootDebug: untranslated phrase: " .. key);
		--@end-debug@]===] 
		return key;
	end,
	
	__call = function(self, key)
		return self[key];
	end
});



L["ALL_PASSED"] = "All passed" -- Needs review
L["APPEARANCE"] = "Appearance" -- Needs review
L["AUTOCONFIRM"] = "Automatically confirm loot roll" -- Needs review
L["AVAILABLE_PRESETS"] = "Available presets list" -- Needs review
L["BACKGROUND"] = "Background" -- Needs review
L["BAR_COLORS"] = "Bar colors" -- Needs review
L["BAR_OPACITY"] = "Bar opacity" -- Needs review
L["BAR_TEXTURE"] = "Bar texture" -- Needs review
L["BAR_TIMER"] = "Display timebar" -- Needs review
L["BEHAVIOR"] = "Behavior" -- Needs review
L["BINDING_HEADER"] = "hfLootRoll"
L["BINDING_OPTIONS"] = "Open settings"
L["BINDING_TOGGLE"] = "Toggle anchor"
L["BORDER_COLOR"] = "Border color"
L["BORDER_COLOR_BY_QUALITY"] = "Color by quality"
L["BORDER_OFFSET"] = "Border offset"
L["BORDER_SIZE"] = "Border size"
L["BORDER_TEXTURE"] = "Border texture"
L["BUTTONS_SCALE"] = "Buttons scale" -- Needs review
L["BUTTON_4"] = "Button 4" -- Needs review
L["BUTTON_5"] = "Button 5" -- Needs review
L["BUTTON_LEFT"] = "Left button" -- Needs review
L["BUTTON_MIDDLE"] = "Middle button" -- Needs review
L["BUTTON_NA"] = "n/a" -- Needs review
L["BUTTON_RIGHT"] = "Right button" -- Needs review
L["CLOSE_MOUSE_BUTTON"] = "Close roll frame button" -- Needs review
L["CLOSE_MOUSE_BUTTON_MODIFIER"] = "Modifier" -- Needs review
L["COLORS_RESET"] = "Default colors" -- Needs review
L["COLOR_NAMES_BY_CLASS"] = "Color names by class" -- Needs review
L["COMPARISON_TOOLTIP"] = "Automatically show comparison tooltip" -- Needs review
L["CONFIG_MODE"] = "Configuration mode"
L["CONFIRM_RESET_SETTINGS"] = "Do you want to reset all addon settings to their defaults?"
L["DESCRIPTION"] = "hfLootRoll is a replacement for standard group loot frames. The latest version can be found at |cff6699ffhttp://www.curse.com|r." -- Needs review
L["DIR_DOWN"] = "Down" -- Needs review
L["DIR_UP"] = "Up" -- Needs review
L["DISAPPEAR_AFTER_ROLL"] = "Disappear after roll finished" -- Needs review
L["DISAPPEAR_AFTER_SELECT"] = "Disappear after roll selection made" -- Needs review
L["DISAPPEAR_DELAY"] = "Disappear delay" -- Needs review
L["DISAPPEAR_DELAY_TIME"] = "Delay (in seconds)" -- Needs review
L["DISAPPEAR_MANUALLY"] = "Close frames manually" -- Needs review
L["FONT"] = "Font" -- Needs review
L["FONT_SIZE"] = "Font size" -- Needs review
L["GROWTH_DIRECTION"] = "Growth direction" -- Needs review
L["HEIGHT"] = "Height" -- Needs review
L["ICON_SCALE"] = "Icon scale" -- Needs review
L["INCOMBAT_CLICKTHROUGH"] = "Allow clicking through roll frames while in combat" -- Needs review
L["INCOMBAT_INTERACTION_MODIFIER"] = "Force interactive mode modifier" -- Needs review
L["INCOMBAT_OPACITY"] = "In combat opacity" -- Needs review
L["ITEM_NAME"] = "Item name" -- Needs review
L["ITEM_NAME_COLOR"] = "Item name color" -- Needs review
L["ITEM_NAME_COLOR_BY_QUALITY"] = "Color by quality" -- Needs review
L["JUSTIFY_BOTTOM"] = "Bottom" -- Needs review
L["JUSTIFY_CENTER"] = "Center" -- Needs review
L["JUSTIFY_HORIZONTAL"] = "Justify horiz." -- Needs review
L["JUSTIFY_LEFT"] = "Left" -- Needs review
L["JUSTIFY_MIDDLE"] = "Middle" -- Needs review
L["JUSTIFY_RIGHT"] = "Right" -- Needs review
L["JUSTIFY_TOP"] = "Top" -- Needs review
L["JUSTIFY_VERTICAL"] = "Justify vert." -- Needs review
L["LOCK_FRAMES"] = "Lock frames" -- Needs review
L["LOOT_SPAM_WARNING"] = "If you disable it, hfLootRoll will not count rolls." -- Needs review
L["MAX_FRAMES"] = "Max displayed loot frames" -- Needs review
L["OFFSET"] = "Offset" -- Needs review
L["OFFSET_X"] = "Offset x" -- Needs review
L["OFFSET_Y"] = "Offset y" -- Needs review
L["OPEN_SETTINGS"] = "Open settings" -- Needs review
L["OPTIONS_TAB_BORDER"] = "Border"
L["OPTIONS_TAB_COLORS"] = "Colors"
L["OPTIONS_TAB_GENERAL"] = "General"
L["OPTIONS_TAB_ITEMNAME"] = "Item name"
L["OPTIONS_TAB_POSITION"] = "Position"
L["OPTIONS_TAB_TOOLTIPS"] = "Tooltips"
L["OPTIONS_TAB_WINNERNAME"] = "Winner name"
L["POSITION"] = "Position" -- Needs review
L["POSITION_RESET"] = "Reset position" -- Needs review
L["PRESETS"] = "Presets" -- Needs review
L["PRESET_DELETE"] = "Delete" -- Needs review
L["PRESET_DELETE_POPUP"] = "Are you sure you want to delete character settings? (all settings for %s will be lost)" -- Needs review
L["PRESET_LOAD"] = "Load" -- Needs review
L["PRESET_NEW"] = "New preset" -- Needs review
L["PRESET_NEW_POPUP"] = "Enter name for a new preset (settings will be copied from the current one)" -- Needs review
L["PRESET_SHARE"] = "Save current settings for all characters" -- Needs review
L["PRESET_SHARE_POPUP"] = "All characters settings will be overridden, continue?" -- Needs review
L["RESIZER_HINT"] = "Drag me to resize" -- Needs review
L["SHOW_BOP"] = "Display BoP indicator" -- Needs review
L["SHOW_ILVL_ICON"] = "iLvl comparison icon"
L["SHOW_ITEM_NAME"] = "Show item name" -- Needs review
L["SHOW_WHO"] = "Display list of those, who rolled on item" -- Needs review
L["SHOW_WINNER_NAME"] = "Show winner name" -- Needs review
L["SLASH_AVAILABLE_COMMANDS"] = "available commands" -- Needs review
L["SLASH_LOCK_FRAMES"] = "lock frames" -- Needs review
L["SLASH_OPEN_SETTINGS"] = "open settings window" -- Needs review
L["SLASH_TOGGLE_FRAMES"] = "toggle anchor"
L["SLASH_UNLOCK_FRAMES"] = "unlock frames" -- Needs review
L["SPARK_OPACITY"] = "Spark opacity" -- Needs review
L["TOOLTIPS"] = "Tooltips" -- Needs review
L["TOOLTIP_ON_ICON"] = "Show an item tooltip only when hovering icon" -- Needs review
L["VERSION"] = "Version" -- Needs review
L["WIDTH"] = "Width" -- Needs review
L["WINNER_NAME"] = "Winner name" -- Needs review
L["WINNER_NAME_COLOR"] = "Name color" -- Needs review
L["WINNER_NAME_COLOR_BY_CLASS"] = "Color by class" -- Needs review
L["LootFrameHolder/CLOSE_INFO"] = "%s to close this frame"
