ArcaneWizardLibrary_ButtonMixin = {}

local BUTTON_HEIGHT = 22
local MINIMUM_BUTTON_WIDTH = 44
local buttonTexturePath = "Interface\\AddOns\\ArcaneWizardLibrary\\assets\\buttons\\"
local buttonStates = {
	normal = {
		texture = buttonTexturePath .. "button-normal.tga",
		text = { 1, 0.82, 0.15 }
	},
	highlight = {
		texture = buttonTexturePath .. "button-highlight.tga",
		text = { 1, 0.92, 0.35 }
	},
	pushed = {
		texture = buttonTexturePath .. "button-pushed.tga",
		text = { 0.95, 0.72, 0.12 }
	},
	disabled = {
		texture = buttonTexturePath .. "button-disabled.tga",
		text = { 0.45, 0.44, 0.42 }
	}
}

local function GetButtonState(button)
	if not button:IsEnabled() then
		return buttonStates.disabled
	elseif button.isPushed then
		return buttonStates.pushed
	elseif button.isHighlighted then
		return buttonStates.highlight
	end

	return buttonStates.normal
end

local function UpdateAfterClick(button)
	button.isPushed = false
	button.isHighlighted = true
	button:UpdateVisualState()
end

function ArcaneWizardLibrary_ButtonMixin:UpdateVisualState()
	local state = GetButtonState(self)
	self.Left:SetTexture(state.texture)
	self.Center:SetTexture(state.texture)
	self.Right:SetTexture(state.texture)

	local textColor = state.text
	local text = self:GetFontString()
	text:SetTextColor(unpack(textColor))
end

function ArcaneWizardLibrary_ButtonMixin:OnLoad()
	self:SetHeight(BUTTON_HEIGHT)
	self:SetPushedTextOffset(0, -1)
	self:RegisterForClicks("LeftButtonUp")
	self:HookScript("OnClick", UpdateAfterClick)
	self:UpdateVisualState()
end

function ArcaneWizardLibrary_ButtonMixin:OnSizeChanged()
	local width = self:GetWidth()
	local height = self:GetHeight()

	if width and width < MINIMUM_BUTTON_WIDTH then
		self:SetWidth(MINIMUM_BUTTON_WIDTH)
	end

	if height and height ~= BUTTON_HEIGHT then
		self:SetHeight(BUTTON_HEIGHT)
	end
end

function ArcaneWizardLibrary_ButtonMixin:OnEnter()
	self.isHighlighted = true
	self:UpdateVisualState()
end

function ArcaneWizardLibrary_ButtonMixin:OnLeave()
	self.isHighlighted = false
	self.isPushed = false
	self:UpdateVisualState()
end

function ArcaneWizardLibrary_ButtonMixin:OnMouseDown(button)
	if button == "LeftButton" and self:IsEnabled() then
		self.isPushed = true
		self:UpdateVisualState()
	end
end

function ArcaneWizardLibrary_ButtonMixin:OnMouseUp(button)
	if button == "LeftButton" then
		self.isPushed = false
		self.isHighlighted = self:IsMouseOver()
		self:UpdateVisualState()
	end
end

function ArcaneWizardLibrary_ButtonMixin:OnEnable()
	self:UpdateVisualState()
end

function ArcaneWizardLibrary_ButtonMixin:OnDisable()
	self.isPushed = false
	self:UpdateVisualState()
end
