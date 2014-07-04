--[[

	hfLootframesHolder - World of Warcraft addon that provides opportunities 
	for creating loot frames manager

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
	Creates loot roll frame holder, available methods:
	
	hf_Widgets.LootFrameHolder_v2(name, parent)
		creates new loot frame holder
		
		name:   frame name (string)
		parent: frame parent (string|Frame)
		
		returns created frame holder (table)
	
	lootFrameHolder:ExtendPool()
		creates new lootFrame and adds it into pool

	lootFrameHolder:RefreshFramesPositions()
		updates frames positions

	lootFrameHolder:StartRoll(rollId, rollTime, disableInteraction[, owicon, owquality, owbop, owname])
		opens roll
		
		rollId: rollID to handle (number)
		rollTime: roll time in ms (number)
		disableInteraction: flag used to open demo rolls (boolean)
		owicon: item icon to use, by default uses GetLootRollItemInfo (string)
		owquality: item quality, by default uses GetLootRollItemInfo (number)
		owbop: true if item is BoP, by default uses GetLootRollItemInfo (boolean)
		owname: item name, by default uses GetLootRollItemInfo (string)

	lootFrameHolder:UpdateRoll(rollId, roll)
		updates info about people's selections
		
		rollId: rollID to update (number)
		roll: table with subtables 'needers', 'greeders', 'disers' and 'passers' 
			that contains lists of those who selected this option on this item (table)

	lootFrameHolder:SetWinner(rollId, name)
		sets roll winner
		
		rollId: rollID to update (number)
		name: winner's name (string)

	lootFrameHolder:FreeRoll(rollId)
		makes roll frame able to be closed, use it if you are sure that player can't make selection
		
		rollId: rollID to free (number)

	lootFrameHolder:LockRoll(rollId)
		locks roll buttons and highlights selection
		
		rollId: rollID to lock (number)

	lootFrameHolder:CloseRoll(rollId, mode[, force])
		closes frame if mode allows to do it
		
		rollId: rollID to close (number)
		mode: close mode: 'force', 'manual', 'onselect' or 'onfinish' (string)
		force: if it's true, frame will be closed independently of mode (boolean)

	lootFrameHolder:CheckSelection(rollId)
		checks, which selection was made on roll by player

		rollId: rollID to check (number)

		returns selection number or nil if nothing selected

	lootFrameHolder:SetInCombat(inCombat[, interactionOnly])
		sets incobat status
		
		inCombat: flag, true if in combat (boolean)
		interactionOnly: flag, true to change interaction mode only (boolean)

	lootFrameHolder:SetOption(option, ...)
		sets frame holder option
		
		option: option to change (string)
		...: new value(s) (list)
]]

local WIDGET = "LootFrameHolder_v2";

--@non-debug@
local REV = 60;
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

local L = {};

L["CLOSE_INFO"] = "%s to close this frame"

if ( GetLocale() == "ruRU" ) then
	
	L["CLOSE_INFO"] = "Нажмите %s чтобы закрыть этот фрейм"

end

local FRAMES_NUM_HARDCAP = 35;
local UPDATE_INTERVAL = 0.02;
local REL_MOVEMENT_SPEED  = 5 * UPDATE_INTERVAL;
local ACCEL_ABRUPTNESS = 1.8;

local min = 0.2;
local pmin = math.pow(min, 1 / ACCEL_ABRUPTNESS);
local p1 = pmin / (1-pmin);
local p2 = min / math.pow(p1, ACCEL_ABRUPTNESS);
local SPEED_MULT = function(x)
	return math.pow(x + p1, ACCEL_ABRUPTNESS)*p2;
end

local methods = {};

local function updateFramePositionTo(self, _priv, frame, posTo)
	if ( not posTo ) then
		posTo = 0;
	end
	local anchoringPoint1 = (_priv.dirMult == 1) and "BOTTOM" or "TOP";
	local anchoringPoint2 = (_priv.dirMult == 1) and "TOP" or "BOTTOM";
	local yPos = math.floor(_priv.dirMult * posTo * (_priv.opt.Height + _priv.opt.offset) + 0.5);
	frame:ClearAllPoints();
	frame:SetPoint(anchoringPoint1, _priv.parent, anchoringPoint2, 0, yPos);
	_priv.currentFramePositions[frame] = posTo;
end

local function moveFrameTo(self, _priv, frame, posTo)

	frame:DisableInteraction(2);
	
	_priv.frameIsMoving[frame] = true;
	
	_priv.targetPositions[frame] = posTo;
	
end

local function addCloseButtonInfo(self, _priv, lootFrame)
	if ( _priv.opt.closeButton ~= "n/a" ) then
		local buttons = "";
		if ( _priv.opt.closeModifier ~= "n/a" ) then
			buttons = _priv.opt.closeModifier .. "+";
		end
		buttons = buttons .. _priv.opt.closeButton;
		
		lootFrame.tooltipExtra = string.format("|cffff5555<" .. L["CLOSE_INFO"] .. ">|r", buttons);
	end
end

methods.ExtendPool = function(self, _priv)
	local newFrame;
	
	newFrame = hf_Widgets.LootFrame_v2(_priv.name .. _priv.totalFrames, self);
	newFrame:SetFrameStrata("MEDIUM");
	
	for opt, val in pairs(_priv.opt) do
		newFrame:SetOption(opt, val);
	end
	
	for color, val in pairs(_priv.opt.colors) do
		newFrame:SetOption("Color", color, val.r, val.g, val.b, val.a);
	end
	
	local mode = _priv.opt.delayMode;
	local delay;
	if ( mode == "onselect" ) then
		delay = _priv.opt.onselectDelay;
	elseif ( mode == "onfinish" ) then
		delay = _priv.opt.onfinishDelay;
	elseif ( mode == "manual" ) then
		delay = -1;
	end
	newFrame:SetOption("CloseDelay", delay);
	
	if ( _priv.inCombat and _priv.opt.clickThroughInCombat ) then
		newFrame:DisableInteraction(3);
	else
		newFrame:EnableInteraction(3);
	end
	
	newFrame:UpdateSizes();
	
	newFrame:Hide();
	
	tinsert(_priv.lootFramesPool, newFrame);
	_priv.totalFrames = _priv.totalFrames + 1;
end

methods.RefreshFramesPositions = function(self, _priv)
	for _, frame in ipairs(self.frames) do
		updateFramePositionTo(self, _priv, frame, _priv.currentFramePositions[frame]);
	end
end

methods.StartRoll = function(self, _priv, rollId, rollTime, disableInteraction, owicon, owquality, owbop, owname
							, owilvl, owequipSlot)
	local icon, itemName, count, quality, bop, equipSlot, ilvl;
	local canNeed, canGreed, canDisenchant = true, true, true;
	local reasonNeed, reasonGreed, reasonDisenchant, deSkillRequired;
	
	-- if maxPanels exceed - hiding not busy panels
	if ( #self.frames >= _priv.opt.maxPanels  ) then
		local i = #self.frames;
		local removedPanels = 0;
		while ( (i >= 1) and (#self.frames - removedPanels >= _priv.opt.maxPanels) ) do
			local lootFrame = self.frames[i];
			if ( not lootFrame.busy ) then
				lootFrame:Disappear(true);
			end
			removedPanels = removedPanels + 1;
			i = i - 1;
		end
	end
	
	-- extend pool if necessary
	while ( #_priv.lootFramesPool == 0 ) do
		if ( _priv.totalFrames >= FRAMES_NUM_HARDCAP ) then
			for i, frame in ipairs(self.frames) do
				if ( frame.busy == false ) then
					frame:Disable();
					break;
				end
			end
		else
			self:ExtendPool();
		end
	end
	
	-- move frame to active storage
	local lootFrame = tremove(_priv.lootFramesPool);
	tinsert(self.frames, 1, lootFrame);
	
	-- setup frame
	
	if ( rollId >= 0 ) then
		icon, itemName, count, quality, bop, canNeed, canGreed, canDisenchant
		, reasonNeed, reasonGreed, reasonDisenchant, deSkillRequired = GetLootRollItemInfo(rollId);
	end
	
	icon     = owicon or icon;
	quality  = owquality or quality;
	bop      = (type(owbop) == "boolean") and owbop or bop;
	itemName = owname or itemName;
	equipSlot = owequipSlot;
	ilvl     = owilvl;
		
	if ( canNeed ) then
		lootFrame.Need:SetEnabled(true, nil);
	else
		lootFrame.Need:SetEnabled(false, _G["LOOT_ROLL_INELIGIBLE_REASON" .. reasonNeed]);
	end
	
	if ( canGreed ) then
		lootFrame.Greed:SetEnabled(true, nil);
	else
		lootFrame.Greed:SetEnabled(false, _G["LOOT_ROLL_INELIGIBLE_REASON" .. reasonGreed]);
	end
	
	if ( canDisenchant ) then
		lootFrame.Disenchant:SetEnabled(true, nil);
	else
		lootFrame.Disenchant:SetEnabled(false
			, format(_G["LOOT_ROLL_INELIGIBLE_REASON" .. reasonDisenchant], deSkillRequired));
	end
	
	lootFrame.Pass:SetEnabled(true, nil);
	
	lootFrame:SetRollID(rollId);
	lootFrame:SetIcon(icon);
	lootFrame:SetName(itemName);
	lootFrame:SetBoP(bop);
	lootFrame:SetQuality(quality);
	lootFrame:SetTime(rollTime);
	lootFrame:ResetCounters();
	if ( disableInteraction ) then
		lootFrame:DisableInteraction(1);
		lootFrame.itemLink = nil;
	else
		lootFrame:EnableInteraction(1);
		lootFrame.itemLink = GetLootRollItemLink(rollId);
		local _, _, _, _ilvl, _, _, _, _, _equipSlot = GetItemInfo(lootFrame.itemLink);
		ilvl = _ilvl;
		equipSlot = _equipSlot;
	end
	lootFrame:SetILvl(ilvl, equipSlot);
	lootFrame:EnableInteraction(2);
	
	-- frames with disabledInteraction have lesser priority
	lootFrame.busy = not disableInteraction;
	
	lootFrame:Appear();	
	
	updateFramePositionTo(self, _priv, lootFrame, 0);
	self:RefreshFramesPositions();

	lootFrame.onDisable = _priv.onDisableCB;
	lootFrame.onClick   = _priv.onClickCB;
	lootFrame.onTimeOut = _priv.onTimeOutCB;

	-- shift other frames
	for i = 2, #self.frames do
		moveFrameTo(self, _priv, self.frames[i], i-1);
	end
	
	if ( disableInteraction ) then
		self:FreeRoll(rollId);
	end
end

methods.UpdateRoll = function(self, _priv, rollId, roll)
	for i, lootFrame in ipairs(self.frames) do
		if ( rollId == lootFrame.rollID ) then
			lootFrame.Need.counter:SetText(#roll.needers);
			lootFrame.Need.characterList = roll.needers;
			lootFrame.Greed.counter:SetText(#roll.greeders);
			lootFrame.Greed.characterList = roll.greeders;
			lootFrame.Disenchant.counter:SetText(#roll.disers);
			lootFrame.Disenchant.characterList = roll.disers;
			lootFrame.Pass.counter:SetText(#roll.passers);
			lootFrame.Pass.characterList = roll.passers;
		end
	end
end

methods.SetWinner = function(self, _priv, rollId, name)
	for i, lootFrame in ipairs(self.frames) do
		if ( rollId == lootFrame.rollID ) then
			lootFrame:ShowWinner(name);
		end
	end
end

methods.FreeRoll = function(self, _priv, rollId)
	for i, lootFrame in ipairs(self.frames) do
		if ( rollId == lootFrame.rollID ) then
			lootFrame.busy = false;
			addCloseButtonInfo(self, _priv, lootFrame);
		end
	end
end

methods.LockRoll = function(self, _priv, rollId)
	for i, lootFrame in ipairs(self.frames) do
		if ( rollId == lootFrame.rollID ) then				
			local sel = lootFrame:GetSelection();
			
			if ( sel ~= "need" ) then
				lootFrame.Need:SetEnabled(false, "");
			else
				lootFrame.Need:SetHighlight(true);
			end
			
			if ( sel ~= "greed" ) then
				lootFrame.Greed:SetEnabled(false, "");
			else
				lootFrame.Greed:SetHighlight(true);
			end
			
			if ( sel ~= "disenchant" ) then
				lootFrame.Disenchant:SetEnabled(false, "");
			else
				lootFrame.Disenchant:SetHighlight(true);
			end
			
			if ( sel ~= "pass" ) then
				lootFrame.Pass:SetEnabled(false, "");
			else
				lootFrame.Pass:SetHighlight(true);
			end
		end
	end
end

methods.CloseRoll = function(self, _priv, rollId, mode, force)
	local frame;
	local i = #self.frames;
	while ( (i >= 1) and not frame ) do
		if ( self.frames[i].rollID == rollId ) then
			frame = self.frames[i];
		end
		i = i - 1;
	end

	if ( not frame ) then
		return;
	end
		
	-- it's ugly, must be rewritten
	frame.Timer:SetText();
	if ( self.onTimeOut ) then
		self:onTimeOut();
	end

	if ( (mode == "force") or (mode == "manual") ) then
		frame.busy = false;
		frame:Disappear();
		
	elseif ( mode == _priv.opt.delayMode ) then
		
		-- don't close frame onfinish/onselect if selection wasn't performed yet
		if ( (not force) and (not frame:GetSelection()) ) then
			return;
		end
		
		frame.busy = false;
		if ( mode == "onselect" ) then
			_priv.closeTimers[frame] = _priv.opt.onselectDelay;
		elseif ( mode == "onfinish" ) then
			_priv.closeTimers[frame] = _priv.opt.onfinishDelay;
		end
	end
end

methods.CheckSelection = function(self, _priv, rollId)
	for _, frame in ipairs(self.frames) do
		if ( frame.rollID == rollId ) then
			return frame:GetSelection();
		end
	end

	return nil;
end

methods.SetInCombat = function(self, _priv, inCombat, interactionOnly)	
	if ( not interactionOnly ) then
		if ( inCombat ) then
			self:SetAlpha(_priv.opt.inCombatOpacity);
		else
			self:SetAlpha(1);
		end
	end
	
	for _, frame in _priv.framesIter() do
		if ( inCombat and _priv.opt.clickThroughInCombat ) then
			frame:DisableInteraction(3);
		else
			frame:EnableInteraction(3);
		end
	end
end

methods.SetOption = function(self, _priv, option, ...)

	if ( option == "Direction" ) then
		local direction = ...;
		
		_priv.opt.direction = direction;
		if ( direction == "UP" ) then
			_priv.dirMult = 1;
		elseif ( direction == "DOWN" ) then
			_priv.dirMult = -1;
		end
		
		self:RefreshFramesPositions();
	
	elseif ( option == "Color" ) then
		local colorType, r, g, b, a = ...;
		
		_priv.opt.colors[colorType].r = r;
		_priv.opt.colors[colorType].g = g;
		_priv.opt.colors[colorType].b = b;
		_priv.opt.colors[colorType].a = a;
		
		for _, lootFrame in _priv.framesIter() do
			lootFrame:SetOption("Color", colorType, r, g, b, a);
		end
	
	elseif ( option == "Offset" ) then
		_priv.opt.offset = ...;
		self:RefreshFramesPositions();
	
	elseif ( option == "DelayMode" ) then
		local mode = ...;
		
		local delay;
		if ( mode == "onselect" ) then
			delay = _priv.opt.onselectDelay;
		elseif ( mode == "onfinish" ) then
			delay = _priv.opt.onfinishDelay;
		elseif ( mode == "manual" ) then
			delay = -1;
		else
			return;
		end
		
		_priv.opt.delayMode = mode;
		for _, lootFrame in _priv.framesIter() do
			lootFrame:SetOption("CloseDelay", delay);
		end
	
	elseif ( option == "DelayAfterSelect" ) then
		local delay = ...;
		_priv.opt.onselectDelay = delay;
		self:SetOption("DelayMode", _priv.opt.delayMode);
	
	elseif ( option == "DelayAfterFinish" ) then
		local delay = ...;
		_priv.opt.onfinishDelay = delay;
		self:SetOption("DelayMode", _priv.opt.delayMode);
	
	elseif ( option == "CloseButton" ) then
		_priv.opt.closeButton = ...;
		for _, lootFrame in _priv.framesIter() do
			if ( not lootFrame.busy ) then
				addCloseButtonInfo(self, _priv, lootFrame);
			end
		end
	
	elseif ( option == "CloseButtonModifier" ) then
		_priv.opt.closeModifier = ...;
		for _, lootFrame in _priv.framesIter() do
			if ( not lootFrame.busy ) then
				addCloseButtonInfo(self, _priv, lootFrame);
			end
		end
	
	elseif ( option == "ClickthroughInCombat" ) then
		_priv.opt.clickThroughInCombat = ...;
		self:SetInCombat(_priv.inCombat);
	
	elseif ( option == "InCombatInteractionModifier" ) then
		_priv.opt.inCombatInteractModifier = ...;
	
	elseif ( option == "CombatOpacity" ) then
		_priv.opt.inCombatOpacity = ...;
		self:SetInCombat(_priv.inCombat);
	
	elseif ( option == "MaxPanels" ) then
		local maxPanels = ...;
		_priv.opt.maxPanels = maxPanels;
		if ( #self.frames >= maxPanels  ) then
			local i = #self.frames;
			local curPanels = #self.frames;
			while ( (i >= 1) and (curPanels >= maxPanels) ) do
				local lootFrame = self.frames[i];
				if ( not lootFrame.busy ) then
					lootFrame:Disappear(true);
					curPanels = curPanels - 1;
				end
				i = i - 1;
			end
		end
	
	else
		_priv.opt[option] = ...;
	
		for _, lootFrame in _priv.framesIter() do
			lootFrame:SetOption(option, ...);
			if ( (option == "Scale") or (option == "IconScale") ) then
				lootFrame:UpdateSizes();
			end
		end
		
		if ( option == "Height" ) then
			self:RefreshFramesPositions();
		end
	end
	
end

local function constructor(name, parent)
	assert( type(name) == "string"
		, WIDGET .. " constructor: Bad argument #1 (string expected, got " .. type(name) .. ")");
	assert( (type(parent) == "string") 
		or ( type(parent) == "table" 
			and type(parent.IsObjectType) == "function" 
			and parent:IsObjectType("Frame") )
		, WIDGET .. " constructor: Bad argument #2 (string or Frame expected, got " .. type(parent) .. ")");

	local framesHolder = CreateFrame("Frame", nil, UIParent);
	framesHolder:Show();
	framesHolder.frames = {};
	
	local _priv = {};
	
	_priv.parent         = parent;
	_priv.name           = name;
	_priv.lootFramesPool = {};
	_priv.totalFrames    = 0;
	
	_priv.opt = {};
	
	_priv.opt.colors = {
		['Uncommon'] = {},
		['Rare']   = {},
		['Epic']   = {},
		['Bg']     = {},
		['Winner'] = {},
		['Item']   = {},
		['Border']   = {},
	};
	
	_priv.dirMult = -1;
	
	_priv.opt.delayMode = "onfinish";
	_priv.opt.onselectDelay = 0;
	_priv.opt.onfinishDelay = 0;
	
	_priv.opt.offset = 0;
	_priv.opt.inCombatInteractModifier = "";
	
	_priv.closeTimers = {};
	
	_priv.maxPanels = 20; 
	
	-- hash: frame - y position index from 0 (may ne non-integer)
	_priv.currentFramePositions = {};
	
	-- hash: frame - target y position index from 0
	_priv.targetPositions = {};
	
	_priv.frameIsMoving = {};
	
	_priv.inCombat = false;
	
	_priv.elapsedTime = 0;
	
	-- frame watching incombat status and blocking loot frames interaction
	_priv.combatStatusTracker = CreateFrame("Frame");
	_priv.combatStatusTracker:RegisterEvent("PLAYER_REGEN_DISABLED");
	_priv.combatStatusTracker:RegisterEvent("PLAYER_REGEN_ENABLED");
	_priv.combatStatusTracker:RegisterEvent("MODIFIER_STATE_CHANGED");
	_priv.combatStatusTracker:SetScript("OnEvent", function(self, event, ...)
		if ( event == "PLAYER_REGEN_DISABLED" ) then
			_priv.inCombat = true;
			
			if ( _priv.opt.clickThroughInCombat ) then
				framesHolder:SetInCombat(true);
			end
			
		elseif ( event == "PLAYER_REGEN_ENABLED" ) then
			_priv.inCombat = false;
			
			if ( _priv.opt.clickThroughInCombat ) then
				framesHolder:SetInCombat(false);
			end
			
		elseif ( event == "MODIFIER_STATE_CHANGED" ) then
			if ( not (_priv.inCombat and _priv.opt.clickThroughInCombat) ) then
				return;
			end
			
			local modifier, state = ...;
			if ( strfind(modifier, _priv.opt.inCombatInteractModifier, 1, true) ~= nil ) then
				if ( state == 1 ) then
					framesHolder:SetInCombat(false, true);
				else
					framesHolder:SetInCombat(true, true);
				end
			end
		end
	end);
	
	_priv.framesIter = function()
		local num = #framesHolder.frames;
		local sum = num + #_priv.lootFramesPool;
		return function(s, i)
			local index = i + 1;
			if ( index <= num ) then
				return index, framesHolder.frames[index];
			elseif ( index <= sum ) then
				return index, _priv.lootFramesPool[index-num];
			else
				return nil;
			end
		end, nil, 0
	end
	
	-- function that makes frame to return to pool after hiding
	_priv.onDisableCB = function(self)
		self:EnableInteraction(2);
		
		_priv.targetPositions[self] = nil;
		_priv.currentFramePositions[self] = nil;
		_priv.frameIsMoving[self] = nil;
		_priv.closeTimers[self] = nil;
		
		local shift = false
		local i = 1;
		while ( i <= #framesHolder.frames ) do
			local frame = framesHolder.frames[i];
			if ( frame == self ) then
				tremove(framesHolder.frames, i);
				tinsert(_priv.lootFramesPool, frame);
				shift = true;
				i = i - 1;
			elseif ( shift ) then
				moveFrameTo(self, _priv, frame, i-1);
			end
			i = i + 1;
		end
		framesHolder:RefreshFramesPositions();
		
		self.onClick   = nil;
		self.onTimeOut = nil;
		self.onDisable = nil;
		
		self.tooltipExtra = nil;
	end

	-- onclick callback used for manual frame close
	_priv.modifiers = {};
	_priv.onClickCB = function(self, button)
		if ( (button == _priv.opt.closeButton) and (not self.busy) ) then
			_priv.modifiers["CTRL"]  = IsControlKeyDown();
			_priv.modifiers["SHIFT"] = IsShiftKeyDown();
			_priv.modifiers["ALT"]   = IsAltKeyDown();
			if ( (_priv.opt.closeModifier == "n/a") or _priv.modifiers[_priv.opt.closeModifier] ) then
				framesHolder:CloseRoll(self.rollID, "manual");
			end
		end
	end

	_priv.onTimeOutCB = function(self)
		framesHolder:LockRoll(self.rollID);
	end

	framesHolder:SetScript("OnUpdate", function(self, elapsed)
		_priv.elapsedTime = _priv.elapsedTime + elapsed;
		if ( _priv.elapsedTime > UPDATE_INTERVAL ) then
			for _, frame in ipairs(self.frames) do
				if ( _priv.frameIsMoving[frame] 
					and _priv.targetPositions[frame] 
					and _priv.currentFramePositions[frame] ) then
					
					local sign = ((_priv.targetPositions[frame] - _priv.currentFramePositions[frame]) >= 0)
						and 1 or -1;
					
					local relDist = math.abs(_priv.currentFramePositions[frame] - _priv.targetPositions[frame]);
					
					local speedMult = SPEED_MULT(relDist);
					
					local relStep = speedMult * REL_MOVEMENT_SPEED;
					
					if ( relDist < relStep ) then
						updateFramePositionTo(self, _priv, frame, _priv.targetPositions[frame]);
						_priv.frameIsMoving[frame] = nil;
						_priv.targetPositions[frame] = nil
						frame:EnableInteraction(2);
					else
						updateFramePositionTo(self, _priv, frame, _priv.currentFramePositions[frame] + sign * relStep);
					end
				elseif ( not frame:IsInteractionEnabled(2) ) then
					frame:EnableInteraction(2);
				end
				
				if ( _priv.closeTimers[frame] ) then
					_priv.closeTimers[frame] = _priv.closeTimers[frame] - _priv.elapsedTime;
					
					if ( _priv.closeTimers[frame] <= 0 ) then
					
						-- frame closing can be forced, because necessary checks are performed before setting closeTimers
						self:CloseRoll(frame.rollID, "force");
						_priv.closeTimers[frame] = nil;
					end
				end
			end
			
			_priv.elapsedTime = 0;
		end
	end);
	
	-- registering methods
	for methodName, method in pairs(methods) do
		framesHolder[methodName] = function(self, ...)
			return method(self, _priv, ...);
		end
	end
	
	return framesHolder;
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
