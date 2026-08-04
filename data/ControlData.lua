local _, LIB = ...

local texturePath = "Interface\\AddOns\\ArcaneWizardLibrary\\assets\\controls\\"

LIB.ControlData = {
	height = 22,
	minimumWidth = 44,
	iconSize = 18,
	textOffset = 24,
	optionSpacing = 4,
	textColors = {
		normal = { 1, 0.82, 0.15 },
		highlight = { 1, 0.92, 0.35 },
		disabled = { 0.45, 0.44, 0.42 }
	},
	textures = {
		checkbox = {
			normal = texturePath .. "checkbox-normal.tga",
			pushed = texturePath .. "checkbox-pushed.tga",
			disabled = texturePath .. "checkbox-disabled.tga",
			highlight = texturePath .. "checkbox-highlight.tga",
			checked = texturePath .. "checkbox-checked.tga",
			disabledChecked = texturePath .. "checkbox-disabled-checked.tga"
		},
		option = {
			normal = texturePath .. "option-normal.tga",
			pushed = texturePath .. "option-pushed.tga",
			disabled = texturePath .. "option-disabled.tga",
			highlight = texturePath .. "option-highlight.tga",
			checked = texturePath .. "option-checked.tga",
			disabledChecked = texturePath .. "option-disabled-checked.tga"
		}
	}
}
