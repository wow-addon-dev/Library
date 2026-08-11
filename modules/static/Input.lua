local _, LIB = ...

local InputData = LIB.ControlData.input
local InputTextures = InputData.textures
local DEBUG_PREFIX = "Arcane Wizard: Library (Debug): "

---@class ArcaneWizardLibraryInput: EditBox
---@field Left Texture
---@field Center Texture
---@field Right Texture
---@field Placeholder FontString
---@field placeholderText string
---@field onTextChanged? fun(text: string, userInput: boolean, input: ArcaneWizardLibraryInput)
---@field onEnterPressed? fun(text: string, input: ArcaneWizardLibraryInput)

ArcaneWizardLibrary_InputMixin = {}

-----------------------
--- Local Functions ---
-----------------------

local function CreateTexture(parent, texturePath)
	local texture = parent:CreateTexture(nil, "BACKGROUND")
	texture:SetTexture(texturePath)
	texture:SetTexelSnappingBias(0)
	texture:SetSnapToPixelGrid(false)

	return texture
end

local function CreateBackground(input)
	local left = CreateTexture(input, InputTextures.normal)
	left:SetPoint("TOPLEFT")
	left:SetPoint("BOTTOMLEFT")
	left:SetWidth(InputData.capWidth)
	left:SetTexCoord(0, 0.25, 0, 1)

	local center = CreateTexture(input, InputTextures.normal)
	center:SetPoint("TOPLEFT", left, "TOPRIGHT")
	center:SetPoint("BOTTOMRIGHT", input, "BOTTOMRIGHT", -InputData.capWidth, 0)
	center:SetTexCoord(0.25, 0.75, 0, 1)

	local right = CreateTexture(input, InputTextures.normal)
	right:SetPoint("TOPRIGHT")
	right:SetPoint("BOTTOMRIGHT")
	right:SetWidth(InputData.capWidth)
	right:SetTexCoord(0.75, 1, 0, 1)

	input.Left = left
	input.Center = center
	input.Right = right
end

local function GetVisualState(input)
	if not input:IsEnabled() then
		return "disabled"
	elseif input:HasFocus() then
		return "focused"
	elseif input.isHighlighted then
		return "highlight"
	end

	return "normal"
end

-------------------
--- Input Mixin ---
-------------------

function ArcaneWizardLibrary_InputMixin:UpdatePlaceholder()
	self.Placeholder:SetShown(not self:HasFocus() and self:GetText() == "" and self.placeholderText ~= "")
end

function ArcaneWizardLibrary_InputMixin:UpdateVisualState()
	local state = GetVisualState(self)
	local texturePath = InputTextures[state]
	local textColor = InputData.textColors[state]

	self.Left:SetTexture(texturePath)
	self.Center:SetTexture(texturePath)
	self.Right:SetTexture(texturePath)
	self:SetTextColor(unpack(textColor))
	self:UpdatePlaceholder()
end

function ArcaneWizardLibrary_InputMixin:SetPlaceholder(text)
	assert(type(text) == "string", DEBUG_PREFIX .. "Input SetPlaceholder text must be a string.")

	self.placeholderText = text
	self.Placeholder:SetText(text)
	self:UpdatePlaceholder()
end

function ArcaneWizardLibrary_InputMixin:GetPlaceholder()
	return self.placeholderText
end

function ArcaneWizardLibrary_InputMixin:OnLoad()
	self.placeholderText = ""
	self:SetHeight(InputData.height)
	self:SetAutoFocus(false)
	self:SetFontObject(GameFontHighlight)
	self:SetJustifyH("LEFT")
	self:SetTextInsets(InputData.textLeftInset, InputData.textRightInset, 0, 0)

	CreateBackground(self)

	local placeholder = self:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
	placeholder:SetPoint("LEFT", InputData.textLeftInset, 0)
	placeholder:SetPoint("RIGHT", -InputData.textRightInset, 0)
	placeholder:SetJustifyH("LEFT")
	placeholder:SetWordWrap(false)
	placeholder:SetTextColor(unpack(InputData.textColors.placeholder))
	self.Placeholder = placeholder

	self:UpdateVisualState()
end

function ArcaneWizardLibrary_InputMixin:OnSizeChanged()
	local width = self:GetWidth()
	local height = self:GetHeight()

	if width and width < InputData.minimumWidth then
		self:SetWidth(InputData.minimumWidth)
	end

	if height and height ~= InputData.height then
		self:SetHeight(InputData.height)
	end
end

function ArcaneWizardLibrary_InputMixin:OnEnter()
	self.isHighlighted = true
	self:UpdateVisualState()
end

function ArcaneWizardLibrary_InputMixin:OnLeave()
	self.isHighlighted = false
	self:UpdateVisualState()
end

function ArcaneWizardLibrary_InputMixin:OnEditFocusGained()
	self:UpdateVisualState()
end

function ArcaneWizardLibrary_InputMixin:OnEditFocusLost()
	self:UpdateVisualState()
end

function ArcaneWizardLibrary_InputMixin:OnTextChanged(userInput)
	self:UpdatePlaceholder()

	if self.onTextChanged then
		self.onTextChanged(self:GetText(), not not userInput, self)
	end
end

function ArcaneWizardLibrary_InputMixin:OnEnterPressed()
	if self.onEnterPressed then
		self.onEnterPressed(self:GetText(), self)
	end

	self:ClearFocus()
end

function ArcaneWizardLibrary_InputMixin:OnEscapePressed()
	self:ClearFocus()
end

function ArcaneWizardLibrary_InputMixin:OnEnable()
	self:UpdateVisualState()
end

function ArcaneWizardLibrary_InputMixin:OnDisable()
	self.isHighlighted = false
	self:ClearFocus()
	self:UpdateVisualState()
end

------------------------
--- Public Functions ---
------------------------

--- Creates a consistently styled single-line input field.
---
--- @param parent Frame Parent frame for the input field.
--- @param width number Input width in pixels.
--- @param text string Initial input text.
--- @param placeholder string Text displayed while the unfocused input is empty.
--- @param maxLetters? number Maximum number of characters. Nil or zero allows the game default.
--- @param onTextChanged? fun(text: string, userInput: boolean, input: ArcaneWizardLibraryInput) Called after the text changes.
--- @param onEnterPressed? fun(text: string, input: ArcaneWizardLibraryInput) Called before Enter clears focus.
---
--- @return ArcaneWizardLibraryInput input The created input field.
function ArcaneWizardLibrary.Controls:CreateInput(parent, width, text, placeholder, maxLetters, onTextChanged, onEnterPressed)
	assert(parent ~= nil, DEBUG_PREFIX .. "CreateInput parent is required.")
	assert(type(width) == "number" and width >= InputData.minimumWidth, DEBUG_PREFIX .. "CreateInput width must be at least " .. InputData.minimumWidth .. ".")
	assert(type(text) == "string", DEBUG_PREFIX .. "CreateInput text must be a string.")
	assert(type(placeholder) == "string", DEBUG_PREFIX .. "CreateInput placeholder must be a string.")
	assert(maxLetters == nil or type(maxLetters) == "number" and maxLetters >= 0 and maxLetters == math.floor(maxLetters), DEBUG_PREFIX .. "CreateInput maxLetters must be a non-negative integer or nil.")
	assert(onTextChanged == nil or type(onTextChanged) == "function", DEBUG_PREFIX .. "CreateInput onTextChanged must be a function or nil.")
	assert(onEnterPressed == nil or type(onEnterPressed) == "function", DEBUG_PREFIX .. "CreateInput onEnterPressed must be a function or nil.")

	local input = CreateFrame("EditBox", nil, parent, "ArcaneWizardLibrary_InputTemplate")
	input:SetWidth(width)
	input:SetPlaceholder(placeholder)
	if maxLetters then
		input:SetMaxLetters(maxLetters)
	end
	input:SetText(text)
	input.onTextChanged = onTextChanged
	input.onEnterPressed = onEnterPressed

	return input
end
