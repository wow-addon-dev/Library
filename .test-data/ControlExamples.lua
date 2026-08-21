local AWL = ArcaneWizardLibrary

local frame = AWL.Frames:CreateWindow({
	title = "Control Examples",
	width = 560,
	height = 440,
	backgroundStyle = "panel",
	backgroundAlpha = 1,
	titleTransitionStyle = "shadow",
	showPortrait = false,
	showCloseButton = true,
	movable = true
})
frame:ClearAllPoints()
frame:SetPoint("CENTER", UIParent, "CENTER")
frame:Show()

local buttonHeading = frame.content:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
buttonHeading:SetPoint("TOPLEFT", 32, -32)
buttonHeading:SetText("Buttons")

local enabledButton = AWL.Controls:CreateButton({
	parent = frame.content,
	width = 120,
	label = "Classic button"
})
enabledButton:SetPoint("TOPLEFT", buttonHeading, "BOTTOMLEFT", 0, -16)

local disabledButton = AWL.Controls:CreateButton({
	parent = frame.content,
	width = 120,
	label = "Classic disabled"
})
disabledButton:SetPoint("LEFT", enabledButton, "RIGHT", 8, 0)
disabledButton:Disable()

local redButton = AWL.Controls:CreateButton({
	parent = frame.content,
	width = 120,
	label = "Red button",
	buttonStyle = "red"
})
redButton:SetPoint("LEFT", disabledButton, "RIGHT", 8, 0)

local disabledRedButton = AWL.Controls:CreateButton({
	parent = frame.content,
	width = 120,
	label = "Red disabled",
	buttonStyle = "red"
})
disabledRedButton:SetPoint("LEFT", redButton, "RIGHT", 8, 0)
disabledRedButton:Disable()

local checkboxHeading = frame.content:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
checkboxHeading:SetPoint("TOPLEFT", 32, -112)
checkboxHeading:SetText("Checkboxes")

local checkedCheckbox = AWL.Controls:CreateCheckbox({
	parent = frame.content,
	width = 180,
	label = "Checked checkbox",
	checked = true
})
checkedCheckbox:SetPoint("TOPLEFT", checkboxHeading, "BOTTOMLEFT", 0, -12)

local disabledCheckbox = AWL.Controls:CreateCheckbox({
	parent = frame.content,
	width = 180,
	label = "Disabled checkbox",
	checked = false
})
disabledCheckbox:SetPoint("TOPLEFT", checkedCheckbox, "BOTTOMLEFT", 0, -8)
disabledCheckbox:Disable()

local optionGroupHeading = frame.content:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
optionGroupHeading:SetPoint("TOPLEFT", 270, -112)
optionGroupHeading:SetText("Option Group")

local optionGroup = AWL.Controls:CreateOptionGroup({
	parent = frame.content,
	width = 180,
	options = {
		{ label = "First option", value = "first" },
		{ label = "Second option", value = "second" },
		{ label = "Third option", value = "third" }
	},
	selectedValue = "second"
})
optionGroup:SetPoint("TOPLEFT", optionGroupHeading, "BOTTOMLEFT", 0, -12)

local dropdownHeading = frame.content:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
dropdownHeading:SetPoint("TOPLEFT", 32, -230)
dropdownHeading:SetText("Dropdown Menus")

local dropdown = AWL.Controls:CreateDropdown({
	parent = frame.content,
	width = 200,
	options = {
		{ label = "Gold", value = "gold", icon = 237618 },
		{ divider = true },
		{
			label = "Currencies",
			children = {
				{ label = "First currency", value = "first-currency" },
				{ label = "Second currency", value = "second-currency" }
			}
		}
	},
	selectedValue = "gold"
})
dropdown:SetPoint("TOPLEFT", dropdownHeading, "BOTTOMLEFT", 0, -12)

local inputHeading = frame.content:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
inputHeading:SetPoint("TOPLEFT", 32, -310)
inputHeading:SetText("Input Fields")

local input = AWL.Controls:CreateInput({
	parent = frame.content,
	width = 200,
	text = "",
	placeholder = "Library input",
	maxLetters = 64
})
input:SetPoint("TOPLEFT", inputHeading, "BOTTOMLEFT", 0, -12)
