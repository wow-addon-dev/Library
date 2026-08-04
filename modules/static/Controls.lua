local _, LIB = ...

local ControlData = LIB.ControlData
local DEBUG_PREFIX = "Arcane Wizard: Library (Debug): "

---@class ArcaneWizardLibrarySelectionControl: CheckButton
---@field Text FontString Control label.
---@field controlStyle "checkbox"|"option" Visual control style.

---@class ArcaneWizardLibraryOptionConfig
---@field label string Displayed option label.
---@field value string|number|boolean Value represented by the option.

---@class ArcaneWizardLibraryOptionGroup: Frame
---@field buttons ArcaneWizardLibrarySelectionControl[] Option buttons in display order.
---@field buttonsByValue table<string|number|boolean, ArcaneWizardLibrarySelectionControl> Option buttons indexed by value.
---@field value string|number|boolean Currently selected value.
---@field enabled boolean Whether the option group is enabled.

ArcaneWizardLibrary_SelectionControlMixin = {}

-----------------------
--- Local Functions ---
-----------------------

local function ConfigureTexture(control, setterName, getterName, texturePath, blendMode)
	control[setterName](control, texturePath)

	local texture = control[getterName](control)
	texture:ClearAllPoints()
	texture:SetSize(ControlData.iconSize, ControlData.iconSize)
	texture:SetPoint("LEFT")
	texture:SetTexelSnappingBias(0)
	texture:SetSnapToPixelGrid(false)

	if blendMode then
		texture:SetBlendMode(blendMode)
	end
end

local function ConfigureTextures(control, controlStyle)
	local textures = ControlData.textures[controlStyle]
	ConfigureTexture(control, "SetNormalTexture", "GetNormalTexture", textures.normal)
	ConfigureTexture(control, "SetPushedTexture", "GetPushedTexture", textures.pushed)
	ConfigureTexture(control, "SetDisabledTexture", "GetDisabledTexture", textures.disabled)
	ConfigureTexture(control, "SetHighlightTexture", "GetHighlightTexture", textures.highlight, "ADD")
	ConfigureTexture(control, "SetCheckedTexture", "GetCheckedTexture", textures.checked)
	ConfigureTexture(control, "SetDisabledCheckedTexture", "GetDisabledCheckedTexture", textures.disabledChecked)
end

local function AssertControlParameters(parent, width, label, onValueChanged, methodName)
	assert(parent ~= nil, DEBUG_PREFIX .. methodName .. " parent is required.")
	assert(type(width) == "number" and width >= ControlData.minimumWidth, DEBUG_PREFIX .. methodName .. " width must be at least " .. ControlData.minimumWidth .. ".")
	assert(type(label) == "string" and label ~= "", DEBUG_PREFIX .. methodName .. " label must be a non-empty string.")
	assert(onValueChanged == nil or type(onValueChanged) == "function", DEBUG_PREFIX .. methodName .. " onValueChanged must be a function or nil.")
end

local function ValidateOptions(options, selectedValue)
	assert(type(options) == "table" and #options > 0, DEBUG_PREFIX .. "CreateOptionGroup options must be a non-empty table.")

	local values = {}
	local selectedValueExists = false

	for index, option in ipairs(options) do
		assert(type(option) == "table", DEBUG_PREFIX .. "CreateOptionGroup option " .. index .. " must be a table.")
		assert(type(option.label) == "string" and option.label ~= "", DEBUG_PREFIX .. "CreateOptionGroup option " .. index .. " label must be a non-empty string.")

		local valueType = type(option.value)
		assert(valueType == "string" or valueType == "number" or valueType == "boolean", DEBUG_PREFIX .. "CreateOptionGroup option " .. index .. " value must be a string, number, or boolean.")
		assert(not values[option.value], DEBUG_PREFIX .. "CreateOptionGroup option values must be unique.")

		values[option.value] = true

		if option.value == selectedValue then
			selectedValueExists = true
		end
	end

	assert(selectedValueExists, DEBUG_PREFIX .. "CreateOptionGroup selectedValue must match an option value.")
end

---------------------
--- Control Mixin ---
---------------------

function ArcaneWizardLibrary_SelectionControlMixin:UpdateTextColor()
	local text = self:GetFontString()
	if not text then
		return
	end

	local textColor
	if not self:IsEnabled() then
		textColor = ControlData.textColors.disabled
	elseif self.isHighlighted then
		textColor = ControlData.textColors.highlight
	else
		textColor = ControlData.textColors.normal
	end

	text:SetTextColor(unpack(textColor))
end

function ArcaneWizardLibrary_SelectionControlMixin:OnLoad(controlStyle)
	self.controlStyle = controlStyle
	self:SetHeight(ControlData.height)
	self:RegisterForClicks("LeftButtonUp")

	local text = self:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	text:SetPoint("LEFT", ControlData.textOffset, 0)
	text:SetPoint("RIGHT")
	text:SetJustifyH("LEFT")
	self.Text = text
	self:SetFontString(text)

	ConfigureTextures(self, controlStyle)
	self:UpdateTextColor()
end

function ArcaneWizardLibrary_SelectionControlMixin:OnSizeChanged()
	local width = self:GetWidth()
	local height = self:GetHeight()

	if width and width < ControlData.minimumWidth then
		self:SetWidth(ControlData.minimumWidth)
	end

	if height and height ~= ControlData.height then
		self:SetHeight(ControlData.height)
	end
end

function ArcaneWizardLibrary_SelectionControlMixin:OnEnter()
	self.isHighlighted = true
	self:UpdateTextColor()
end

function ArcaneWizardLibrary_SelectionControlMixin:OnLeave()
	self.isHighlighted = false
	self:UpdateTextColor()
end

function ArcaneWizardLibrary_SelectionControlMixin:OnEnable()
	self:UpdateTextColor()
end

function ArcaneWizardLibrary_SelectionControlMixin:OnDisable()
	self.isHighlighted = false
	self:UpdateTextColor()
end

------------------------
--- Public Functions ---
------------------------

--- Creates a consistently styled checkbox.
---
--- @param parent Frame Parent frame for the checkbox.
--- @param width number Checkbox width in pixels.
--- @param label string Displayed checkbox label.
--- @param checked boolean Initial checked state.
--- @param onValueChanged? fun(checked: boolean, checkbox: ArcaneWizardLibrarySelectionControl) Called after a user changes the value.
---
--- @return ArcaneWizardLibrarySelectionControl checkbox The created checkbox.
function ArcaneWizardLibrary.Controls:CreateCheckbox(parent, width, label, checked, onValueChanged)
	AssertControlParameters(parent, width, label, onValueChanged, "CreateCheckbox")
	assert(type(checked) == "boolean", DEBUG_PREFIX .. "CreateCheckbox checked must be a boolean.")

	local checkbox = CreateFrame("CheckButton", nil, parent, "ArcaneWizardLibrary_CheckboxTemplate")
	checkbox:SetWidth(width)
	checkbox:SetText(label)
	checkbox:SetChecked(checked)

	if onValueChanged then
		checkbox:SetScript("OnClick", function(button)
			onValueChanged(not not button:GetChecked(), button)
		end)
	end

	return checkbox
end

--- Creates a group of mutually exclusive options.
---
--- @param parent Frame Parent frame for the option group.
--- @param width number Width of every option in pixels.
--- @param options ArcaneWizardLibraryOptionConfig[] Options in display order.
--- @param selectedValue string|number|boolean Initially selected option value.
--- @param onValueChanged? fun(value: string|number|boolean, option: ArcaneWizardLibrarySelectionControl, group: ArcaneWizardLibraryOptionGroup) Called after a user changes the value.
---
--- @return ArcaneWizardLibraryOptionGroup group The created option group.
function ArcaneWizardLibrary.Controls:CreateOptionGroup(parent, width, options, selectedValue, onValueChanged)
	assert(parent ~= nil, DEBUG_PREFIX .. "CreateOptionGroup parent is required.")
	assert(type(width) == "number" and width >= ControlData.minimumWidth, DEBUG_PREFIX .. "CreateOptionGroup width must be at least " .. ControlData.minimumWidth .. ".")
	assert(onValueChanged == nil or type(onValueChanged) == "function", DEBUG_PREFIX .. "CreateOptionGroup onValueChanged must be a function or nil.")
	ValidateOptions(options, selectedValue)

	local optionCount = #options
	local groupHeight = optionCount * ControlData.height + (optionCount - 1) * ControlData.optionSpacing
	local group = CreateFrame("Frame", nil, parent)
	group:SetSize(width, groupHeight)
	group.buttons = {}
	group.buttonsByValue = {}
	group.enabled = true

	function group:GetValue()
		return self.value
	end

	function group:SetValue(value)
		local selectedButton = self.buttonsByValue[value]
		assert(selectedButton ~= nil, DEBUG_PREFIX .. "OptionGroup SetValue value must match an option value.")

		self.value = value
		for _, button in ipairs(self.buttons) do
			button:SetChecked(button == selectedButton)
		end
	end

	function group:SetEnabled(enabled)
		assert(type(enabled) == "boolean", DEBUG_PREFIX .. "OptionGroup SetEnabled enabled must be a boolean.")

		self.enabled = enabled
		for _, button in ipairs(self.buttons) do
			if enabled then
				button:Enable()
			else
				button:Disable()
			end
		end
	end

	for index, option in ipairs(options) do
		local button = CreateFrame("CheckButton", nil, group, "ArcaneWizardLibrary_OptionButtonTemplate")
		button:SetWidth(width)
		button:SetPoint("TOPLEFT", 0, -(index - 1) * (ControlData.height + ControlData.optionSpacing))
		button:SetText(option.label)
		button.value = option.value
		button:SetScript("OnClick", function(clickedButton)
			if group.value == clickedButton.value then
				clickedButton:SetChecked(true)
				return
			end

			group:SetValue(clickedButton.value)
			if onValueChanged then
				onValueChanged(clickedButton.value, clickedButton, group)
			end
		end)

		group.buttons[index] = button
		group.buttonsByValue[option.value] = button
	end

	group:SetValue(selectedValue)

	return group
end
