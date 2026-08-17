local _, LIB = ...

local InputData = LIB.ControlData.input
local InputTextures = InputData.textures
local ClearButtonData = InputData.clearButton
local ClearButtonTextures = ClearButtonData.textures

---@class ArcaneWizardLibraryInput: EditBox
---@field Left Texture
---@field Center Texture
---@field Right Texture
---@field Placeholder FontString
---@field ClearButton Button
---@field placeholderText string
---@field hasFocus boolean
---@field isClearButtonChange boolean
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
	elseif input.hasFocus then
		return "focused"
	elseif input.isHighlighted then
		return "highlight"
	end

	return "normal"
end

local function UpdateClearButtonVisual(button)
	local state = "normal"
	if button.isPushed then
		state = "pushed"
	elseif button.isHighlighted then
		state = "highlight"
	end

	button.Icon:SetTexture(ClearButtonTextures[state])
end

local function CreateClearButton(input)
	local button = CreateFrame("Button", nil, input)
	button:SetSize(ClearButtonData.size, ClearButtonData.size)
	button:SetPoint("RIGHT", -ClearButtonData.rightInset, 0)
	button:SetFrameLevel(input:GetFrameLevel() + 1)
	button:RegisterForClicks("LeftButtonUp")

	local icon = button:CreateTexture(nil, "ARTWORK")
	icon:SetAllPoints()
	icon:SetTexelSnappingBias(0)
	icon:SetSnapToPixelGrid(false)
	button.Icon = icon

	button:SetScript("OnEnter", function(self)
		self.isHighlighted = true
		UpdateClearButtonVisual(self)
	end)
	button:SetScript("OnLeave", function(self)
		self.isHighlighted = false
		self.isPushed = false
		UpdateClearButtonVisual(self)
	end)
	button:SetScript("OnMouseDown", function(self, mouseButton)
		if mouseButton == "LeftButton" then
			self.isPushed = true
			UpdateClearButtonVisual(self)
		end
	end)
	button:SetScript("OnMouseUp", function(self, mouseButton)
		if mouseButton == "LeftButton" then
			self.isPushed = false
			UpdateClearButtonVisual(self)
		end
	end)
	button:SetScript("OnClick", function()
		input.isClearButtonChange = true
		input:SetText("")
		input.isClearButtonChange = false
		input:SetFocus()
	end)

	UpdateClearButtonVisual(button)
	button:Hide()
	input.ClearButton = button
end

-------------------
--- Input Mixin ---
-------------------

function ArcaneWizardLibrary_InputMixin:UpdatePlaceholder()
	self.Placeholder:SetShown(not self.hasFocus and self:GetText() == "" and self.placeholderText ~= "")
end

function ArcaneWizardLibrary_InputMixin:UpdateClearButton()
	local isShown = self:IsEnabled() and self:GetText() ~= ""

	if not isShown then
		self.ClearButton.isHighlighted = false
		self.ClearButton.isPushed = false
		UpdateClearButtonVisual(self.ClearButton)
	end

	self.ClearButton:SetShown(isShown)
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
	self:UpdateClearButton()
end

function ArcaneWizardLibrary_InputMixin:SetPlaceholder(text)
	assert(type(text) == "string", LIB.CommonData.debugPrefix .. "Input SetPlaceholder text must be a string.")

	self.placeholderText = text
	self.Placeholder:SetText(text)
	self:UpdatePlaceholder()
end

function ArcaneWizardLibrary_InputMixin:GetPlaceholder()
	return self.placeholderText
end

function ArcaneWizardLibrary_InputMixin:OnLoad()
	self.placeholderText = ""
	self.hasFocus = false
	self.isClearButtonChange = false
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
	CreateClearButton(self)

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
	self.hasFocus = true
	self:UpdateVisualState()
end

function ArcaneWizardLibrary_InputMixin:OnEditFocusLost()
	self.hasFocus = false
	self:UpdateVisualState()
end

function ArcaneWizardLibrary_InputMixin:OnTextChanged(userInput)
	local isUserInput = not not (userInput or self.isClearButtonChange)
	self.isClearButtonChange = false
	self:UpdatePlaceholder()
	self:UpdateClearButton()

	if self.onTextChanged then
		self.onTextChanged(self:GetText(), isUserInput, self)
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
	self.hasFocus = false
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
	assert(parent ~= nil, LIB.CommonData.debugPrefix .. "CreateInput parent is required.")
	assert(type(width) == "number" and width >= InputData.minimumWidth, LIB.CommonData.debugPrefix .. "CreateInput width must be at least " .. InputData.minimumWidth .. ".")
	assert(type(text) == "string", LIB.CommonData.debugPrefix .. "CreateInput text must be a string.")
	assert(type(placeholder) == "string", LIB.CommonData.debugPrefix .. "CreateInput placeholder must be a string.")
	assert(maxLetters == nil or type(maxLetters) == "number" and maxLetters >= 0 and maxLetters == math.floor(maxLetters), LIB.CommonData.debugPrefix .. "CreateInput maxLetters must be a non-negative integer or nil.")
	assert(onTextChanged == nil or type(onTextChanged) == "function", LIB.CommonData.debugPrefix .. "CreateInput onTextChanged must be a function or nil.")
	assert(onEnterPressed == nil or type(onEnterPressed) == "function", LIB.CommonData.debugPrefix .. "CreateInput onEnterPressed must be a function or nil.")

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
