--[[

	hfSlider - World of Warcraft addon that provides opportunities 
	for creating options sliders

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
	Creates slider, available methods:
	
	hf_Widgets.Slider(name, parent, label, min, max, step, manual[, decentered, range, position])
		creates new slider
		
		name: slider frame name (string)
		parent: slider frame parent (string or Frame)
		label: text (string)
		min: minimal value, in decentered mode can be nil (number|nil)
		max: maximal value, in decentered mode can be nil (number|nil)
		step: slider movement step, 1 by default (number|nil)
		manual: if set, there will be a text field next ot the slider (boolean|nil)
		decentered: if set, slider will allow to set any value multiple of step (boolean)
		range: if decentered mode enabled, defines the values range available without value scrolling (number)
		position: if decentered mode enabled, this argument defines initial slider position (number)
		
		returns created slider (table)
	
	slider:SetDigits(num)
		sets number of digits after point
		
		num: number of digits after point (number)
]]

local WIDGET = "Slider";

--@non-debug@
local REV = 31;
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
	
local function recalcMinMax(slider, _priv, position)	
	if ( not _priv.decentered ) then
		return;
	end

	local relMin, relMax;
	
	local amp = _priv.range / 2;
	
	if ( ((_priv.max ~= nil) and (_priv.min ~= nil))
		and (_priv.max - _priv.min) < _priv.range ) then
		relMin = _priv.min;
		relMax = _priv.max;
	elseif ( (_priv.min ~= nil)
		and (position - amp < _priv.min) ) then
		relMin = _priv.min;
		relMax = _priv.min + _priv.range;
	elseif ( (_priv.max ~= nil) 
		and (position + amp > _priv.max) ) then
		relMin = _priv.max - _priv.range;
		relMax = _priv.max;
	else
		relMin = position - amp;
		relMax = position + amp;
	end
	
	slider:SetMinMaxValues(relMin, relMax);
	slider:SetValue(position);
	
	_G[_priv.name .. "Low"]:SetText(format("%." .. _priv.decdigits .. "f", relMin));
	_G[_priv.name .. "High"]:SetText(format("%." .. _priv.decdigits .. "f", relMax));
end

local function sliderOnValueChanged(self, _priv, value)	
	self.text:SetText(format("%." .. _priv.decdigits .. "f", value));
	
	if ( not _priv.dragging ) then
		recalcMinMax(self, _priv, value);
	end
	
	if ( _priv.manual and (not _priv.userInput) ) then
		self.input:SetText(format("%." .. _priv.decdigits .. "f", value));
	end
	
	_priv.lastChange = value - _priv.value;
	_priv.value = value;
end

local methods = {};
	
methods.SetDigits = function(self, _priv, num)
	assert( type(num) == "number"
		, WIDGET .. ":SetDigits() Bad argument #1 (number expected, got " .. type(num) .. ")");
	
	_priv.decdigits = num;
	
	recalcMinMax(self, _priv, self:GetValue());
end

methods.SetScript = function(self, _priv, handler, func)
	self:originalSetScript(handler, func);
	if ( handler == "OnValueChanged" ) then
		self:HookScript(handler, function(self, value)
			sliderOnValueChanged(self, _priv, value);
		end);
	end
end

local function constructor(name, parent, label, min, max, step, manual, decentered, range, position)
	assert( type(name) == "string"
		, WIDGET .. " constructor: Bad argument #1 (string expected, got " .. type(name) .. ")");
	assert( (type(parent) == "string") 
		or ( type(parent) == "table" 
			and type(parent.IsObjectType) == "function" 
			and parent:IsObjectType("Frame") )
		, WIDGET .. " constructor: Bad argument #2 (string or Frame expected, got " .. type(parent) .. ")");
	assert( (type(label) == "string") 
		, WIDGET .. " constructor: Bad argument #3 (string expected, got " .. type(label) .. ")");
	assert( (type(min) == "number") or (decentered and (min == nil))
		, WIDGET .. " constructor: Bad argument #4 (number expected, got " .. type(min) .. ")");
	assert( (type(max) == "number") or (decentered and (max == nil)) 
		, WIDGET .. " constructor: Bad argument #5 (number expected, got " .. type(max) .. ")");
	assert( (type(step) == "number") or (step == nil)
		, WIDGET .. " constructor: Bad argument #6 (number expected, got " .. type(step) .. ")");
	assert( (type(manual) == "boolean") or (manual == nil)
		, WIDGET .. " constructor: Bad argument #7 (boolean expected, got " .. type(manual) .. ")");
	assert( (type(decentered) == "boolean") or (decentered == nil)
		, WIDGET .. " constructor: Bad argument #8 (boolean expected, got " .. type(decentered) .. ")");
	assert( (type(range) == "number") or ((decentered == nil) and (range == nil))
		, WIDGET .. " constructor: Bad argument #9 (number expected, got " .. type(range) .. ")");
	assert( (type(position) == "number") or ((decentered == nil) and (position == nil))
		, WIDGET .. " constructor: Bad argument #10 (number expected, got " .. type(position) .. ")");
		
	local slider = CreateFrame("Slider", name, parent, "OptionsSliderTemplate");
	
	local _priv = {};
	
	_priv.decentered = decentered;
	_priv.min = min;
	_priv.max = max;
	_priv.range = range;
	_priv.name = name;
	_priv.manual = manual;
	_priv.decdigits = 0;
	_priv.userInput = false;
	_priv.dragging  = false;
	_priv.value     = 0;
	_priv.lastChange = 0;
	
	slider:SetWidth(100);
	slider:SetHeight(15);
	slider:SetOrientation("HORIZONTAL");
	
	slider.label = parent:CreateFontString(name .. "Label", nil, "GameFontNormal");
	slider.label:SetPoint("BOTTOMLEFT", slider, "TOPLEFT", 0, 0);
	slider.label:SetText(label);
	
	slider.text = _G[name .. "Text"];
	slider.text:SetText('');
	slider.text:ClearAllPoints();
	slider.text:SetPoint("TOP", slider, "BOTTOM");
	
	slider.originalSetScript = slider.SetScript;
	
	if ( not decentered ) then
		slider:SetMinMaxValues(min, max);
		_G[name .. "Low"]:SetText(tostring(min));
		_G[name .. "High"]:SetText(tostring(max)); 
	else
		recalcMinMax(slider, _priv, position);
	
		slider:HookScript("OnMouseUp", function(self, button)
			recalcMinMax(self, _priv, self:GetValue());
		end);
		
		local oldSetValue = slider.SetValue;
		slider.SetValue = function(self, value)
			local min, max = self:GetMinMaxValues();
			if ( (value > max) or (value < min) ) then
				recalcMinMax(self, _priv, value);
			end
			oldSetValue(self, value);
		end
	end
	
	if ( step ~= nil ) then
		slider:SetValueStep(step);
	end
	
	if ( manual ) then
		local function onLeaveBox(self)
			self:ClearFocus();
			self:SetText(format("%." .. _priv.decdigits .. "f", self:GetParent():GetValue()));
		end
		
		slider.input = CreateFrame("EditBox", name .. "Input", slider, "InputBoxTemplate");
		slider.input:SetHeight(16);
		slider.input:SetWidth(30);
		slider.input:SetMaxLetters(6);
		slider.input:SetMultiLine(false);
		slider.input:SetNumeric(false);
		slider.input:SetAutoFocus(false);
		slider.input:SetScript("OnEscapePressed", onLeaveBox);
		slider.input:SetScript("OnEnterPressed", onLeaveBox);
		slider.input:SetScript("OnTabPressed", onLeaveBox);
		slider.input:SetPoint("LEFT", slider, "RIGHT", 11, 0);
		
		slider.input:SetScript("OnTextChanged", function(self, byUser)
			if ( byUser ) then
				_priv.userInput = true;
				local value = tonumber(self:GetText());
				if ( value ) then
				
					-- check if value is out of bounds
					if ( ((_priv.max ~= nil) and (value > _priv.max) )
						or ((_priv.min ~= nil) and (value < _priv.min)) ) then
						return;
					end
					
					slider:SetValue(value);
	
					recalcMinMax(slider, _priv, value);
				end
				_priv.userInput = false;
			else
				self:SetCursorPosition(0);
			end
		end);
	end
	
	slider:HookScript("OnValueChanged", function(self, value)
		sliderOnValueChanged(self, _priv, value);
	end);
	
	slider:HookScript("OnMouseDown", function(self, button)
	
		-- as this script called after changing value - value changes twice, so we need to cancel last change
		self:SetValue(_priv.value - _priv.lastChange);
		
		_priv.dragging = true;
	end);
	
	slider:HookScript("OnMouseUp", function(self, button)
		_priv.dragging = false;
	end);
	
	-- registering methods
	for methodName, method in pairs(methods) do
		slider[methodName] = function(self, ...)
			return method(self, _priv, ...);
		end
	end
	
	return slider;
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