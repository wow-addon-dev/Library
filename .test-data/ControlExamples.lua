local AWL = ArcaneWizardLibrary

local frame = AWL.Frames:CreateWindow("Control Examples", 560, 440, true, 1, true, "panel", false, "shadow")
frame:ClearAllPoints()
frame:SetPoint("CENTER", UIParent, "CENTER")
frame:Show()

local buttonHeading = frame.content:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
buttonHeading:SetPoint("TOPLEFT", 32, -32)
buttonHeading:SetText("Buttons")

local enabledButton = AWL.Controls:CreateButton(frame.content, 140, "Enabled button")
enabledButton:SetPoint("TOPLEFT", buttonHeading, "BOTTOMLEFT", 0, -16)

local wowButton = CreateFrame("Button", nil, frame.content, "UIPanelButtonTemplate")
wowButton:SetSize(140, 22)
wowButton:SetPoint("LEFT", enabledButton, "RIGHT", 16, 0)
wowButton:SetText("WoW button")

local disabledButton = AWL.Controls:CreateButton(frame.content, 140, "Disabled button")
disabledButton:SetPoint("LEFT", wowButton, "RIGHT", 16, 0)
disabledButton:Disable()

local checkboxHeading = frame.content:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
checkboxHeading:SetPoint("TOPLEFT", 32, -112)
checkboxHeading:SetText("Checkboxes")

local checkedCheckbox = AWL.Controls:CreateCheckbox(frame.content, 180, "Checked checkbox", true)
checkedCheckbox:SetPoint("TOPLEFT", checkboxHeading, "BOTTOMLEFT", 0, -12)

local disabledCheckbox = AWL.Controls:CreateCheckbox(frame.content, 180, "Disabled checkbox", false)
disabledCheckbox:SetPoint("TOPLEFT", checkedCheckbox, "BOTTOMLEFT", 0, -8)
disabledCheckbox:Disable()

local optionGroupHeading = frame.content:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
optionGroupHeading:SetPoint("TOPLEFT", 270, -112)
optionGroupHeading:SetText("Option Group")

local optionGroup = AWL.Controls:CreateOptionGroup(frame.content, 180, {
	{ label = "First option", value = "first" },
	{ label = "Second option", value = "second" },
	{ label = "Third option", value = "third" }
}, "second")
optionGroup:SetPoint("TOPLEFT", optionGroupHeading, "BOTTOMLEFT", 0, -12)

local dropdownHeading = frame.content:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
dropdownHeading:SetPoint("TOPLEFT", 32, -230)
dropdownHeading:SetText("Dropdown Menus")

local dropdown = AWL.Controls:CreateDropdown(frame.content, 200, {
	{ label = "Gold", value = "gold", icon = 237618 },
	{ divider = true },
	{
		label = "Currencies",
		children = {
			{ label = "First currency", value = "first-currency" },
			{ label = "Second currency", value = "second-currency" }
		}
	}
}, "gold")
dropdown:SetPoint("TOPLEFT", dropdownHeading, "BOTTOMLEFT", 0, -12)

local wowDropdownValue = "gold"
local wowDropdown = CreateFrame("DropdownButton", nil, frame.content, "WowStyle1DropdownTemplate")
wowDropdown:SetSize(200, 25)
wowDropdown:SetPoint("LEFT", dropdown, "RIGHT", 16, 0)
wowDropdown:SetupMenu(function(self, root)
	local function IsSelected(value)
		return wowDropdownValue == value
	end

	local function SetSelected(value)
		wowDropdownValue = value
		self:GenerateMenu()
	end

	root:CreateRadio("Gold", IsSelected, SetSelected, "gold")
	root:CreateRadio("Silver", IsSelected, SetSelected, "silver")
end)

local inputHeading = frame.content:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
inputHeading:SetPoint("TOPLEFT", 32, -310)
inputHeading:SetText("Input Fields")

local input = AWL.Controls:CreateInput(frame.content, 200, "", "Library input", 64)
input:SetPoint("TOPLEFT", inputHeading, "BOTTOMLEFT", 0, -12)

local wowInput = CreateFrame("EditBox", nil, frame.content, "InputBoxTemplate")
wowInput:SetSize(200, 25)
wowInput:SetPoint("LEFT", input, "RIGHT", 16, 0)
wowInput:SetAutoFocus(false)
wowInput:SetText("WoW input")
