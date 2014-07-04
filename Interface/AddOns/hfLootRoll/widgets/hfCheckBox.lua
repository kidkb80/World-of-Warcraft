--[[

	hfCheckBox - World of Warcraft addon that provides opportunities 
	for creating check boxes

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

--[[
	Creates check box, available methods:
	
	hf_Widgets.CheckBox(name, parent, text)
		creates new scrollable list
		
		name: check box name (string)
		parent: check box parent (string or table)
		text: displayed label (string)
		
		returns created check box (table)
		
	checkbox:oldSetChecked(state)
		sets checkbox state without calling set function
		
		state: new checkbox state (boolean)
]]

local WIDGET = "CheckBox";

--@non-debug@
local REV = 12;
--@end-non-debug@
--[===[@debug@
local REV = 99999;
--@end-debug@]===]

if ( hf_Widgets == nil ) then
	hf_Widgets = {}
end

if ( (hf_Widgets[WIDGET] ~= nil)
	and (hf_Widgets[WIDGET].r >= REV) ) then
	return;
end

local function constructor(name, parent, text)
	assert( type(name) == "string"
		, WIDGET .. " constructor: Bad argument #1 (string expected, got " .. type(name) .. ")");
	assert( (type(parent) == "string") 
		or ( type(parent) == "table" 
			and type(parent.IsObjectType) == "function" 
			and parent:IsObjectType("Frame") )
		, WIDGET .. " constructor: Bad argument #2 (string or Frame expected, got " .. type(parent) .. ")");
	assert( type(text) == "string"
		, WIDGET .. " constructor: Bad argument #3 (string expected, got " .. type(text) .. ")");
	
	local checkbox = CreateFrame("CheckButton", name, parent, "InterfaceOptionsCheckButtonTemplate");
	checkbox.text = _G[name .. "Text"];
	checkbox.text:SetText(text);
	
	checkbox.oldSetChecked = checkbox.SetChecked;
	
	function checkbox:SetChecked(state)
		checkbox:oldSetChecked(state);
		InterfaceOptionsPanel_CheckButton_Update(self);
	end
	
	return checkbox;
end

hf_Widgets[WIDGET] = setmetatable({
	c = constructor,
	r = REV,
},
{
	__call = function(t, ...)
		return t.c(...);
	end
});