local AWL = ArcaneWizardLibrary

local exampleArea = CreateFrame("Frame", nil, UIParent)
exampleArea:SetSize(940, 260)
exampleArea:SetPoint("CENTER", UIParent, "CENTER", 0, 100)

local function CreatePopupExample(label, backgroundStyle, showBorder, backgroundAlpha, left, top, borderStyle)
	local frame = AWL.Frames:CreatePopup({
		width = 220,
		height = 120,
		backgroundStyle = backgroundStyle,
		backgroundAlpha = backgroundAlpha,
		showBorder = showBorder,
		borderStyle = borderStyle,
		showCloseButton = true,
		movable = true,
		closeOnEscape = false
	})
	frame:ClearAllPoints()
	frame:SetPoint("TOPLEFT", exampleArea, "TOPLEFT", left, -top)

	local contentLabel = frame.content:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	contentLabel:SetPoint("CENTER")
	contentLabel:SetText(label)

	frame:Show()
end

CreatePopupExample("Library / Solid Dark", "solid-dark", true, 1, 0, 0, "library")
CreatePopupExample("Library / Panel", "panel", true, 1, 240, 0, "library")
CreatePopupExample("Silver / Solid Dark", "solid-dark", true, 1, 480, 0, "silver")
CreatePopupExample("Silver / Solid Library", "solid-library", true, 1, 720, 0, "silver")
CreatePopupExample("Gold / Solid Dark", "solid-dark", true, 1, 0, 140, "gold")
CreatePopupExample("Gold / Panel", "panel", true, 1, 240, 140, "gold")
CreatePopupExample("Silver / Solid Black (45%)", "solid-black", true, 0.45, 480, 140, "silver")
CreatePopupExample("Borderless / Solid Dark", "solid-dark", false, 1, 720, 140)
