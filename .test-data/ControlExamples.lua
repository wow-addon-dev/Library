local AWL = ArcaneWizardLibrary

local frame = AWL.Frames:CreateWindow("Control Examples (Line)", 500, 400, true, 1, true, "solid-dark", false, "line")
frame:ClearAllPoints()
frame:SetPoint("TOPLEFT", UIParent, "TOPLEFT", 992, -692)
frame:Show()

local buttonHeading = frame.content:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
buttonHeading:SetPoint("TOPLEFT", 32, -32)
buttonHeading:SetText("Buttons")

local enabledButton = AWL.Controls:CreateButton(frame.content, 140, "Enabled button")
enabledButton:SetPoint("TOPLEFT", buttonHeading, "BOTTOMLEFT", 0, -16)

local disabledButton = AWL.Controls:CreateButton(frame.content, 140, "Disabled button")
disabledButton:SetPoint("LEFT", enabledButton, "RIGHT", 20, 0)
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
dropdownHeading:SetText("Dropdown Menu")

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
