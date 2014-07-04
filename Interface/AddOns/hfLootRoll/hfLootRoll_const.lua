local ADDON_NAME, addon = ...;

addon.const = {}

addon.const.DEBUG_MODE          = false;

addon.const.PLAYER_NAME         = UnitName("player");
addon.const.PLAYER_NAME_FULL    = select(1, UnitName("player")) .. " - " .. (GetRealmName() or addon.L["Unknown realm"]);

addon.const.DEFAULT_TEXTURE     = "Interface\\AddOns\\" .. ADDON_NAME .. "\\textures\\Smoothv2";