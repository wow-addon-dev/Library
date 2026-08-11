local AWL = ArcaneWizardLibrary

local portraitPath = "Interface\\AddOns\\ArcaneWizardLibrary\\assets\\icon.blp"
local exampleArea = CreateFrame("Frame", nil, UIParent)
exampleArea:SetSize(1280, 680)
exampleArea:SetPoint("CENTER", UIParent, "CENTER", 0, 80)

local function AddExampleLabel(content, text, lightBackground)
	local label = content:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	label:SetPoint("CENTER")
	label:SetText(text)

	if lightBackground then
		label:SetTextColor(0.08, 0.08, 0.08)
	end

	return label
end

local function PositionFrame(frame, left, top)
	frame:ClearAllPoints()
	frame:SetPoint("TOPLEFT", exampleArea, "TOPLEFT", left, -top)
	frame:Show()
end

local function CreateWindowExample(title, label, backgroundStyle, titleTransitionStyle, showPortrait, lightBackground, left, top)
	local frame = AWL.Frames:CreateWindow(title, 300, 200, true, 1, true, backgroundStyle, showPortrait, titleTransitionStyle)
	if showPortrait then
		frame.portrait:SetTexture(portraitPath)
	end
	local contentLabel = AddExampleLabel(frame.content, label, lightBackground)
	PositionFrame(frame, left, top)

	return frame, contentLabel
end

local function CreatePopupExample(label, backgroundStyle, lightBackground, showBorder, backgroundAlpha, left, top)
	local frame = AWL.Frames:CreatePopup(220, 120, true, showBorder, backgroundAlpha, true, backgroundStyle)
	AddExampleLabel(frame.content, label, lightBackground)
	PositionFrame(frame, left, top)

	return frame
end

CreateWindowExample("Window - Solid Dark (Line)", "Window - Solid Dark (Line)", "solid-dark", "line", true, false, 10, 0)

CreateWindowExample("Window - Solid Title (Strong Shadow)", "Window - Solid Title (Strong Shadow)", "solid-title", "strong-shadow", false, false, 330, 0)

local transparentWindow = CreateWindowExample("Window - Solid Black (45%, Line)", "Window - Solid Black (45%, Line)", "solid-black", "line", false, false, 650, 0)
transparentWindow.background:SetAlpha(0.45)

CreateWindowExample("Window - Panel (Shadow)", "Window - Panel (Shadow)", "panel", "shadow", false, false, 970, 0)

local tabbedWindow = AWL.Frames:CreateWindow("Window - Solid Dark with Tabs (Strong Shadow)", 620, 420, true, 1, true, "solid-dark", true, "strong-shadow")
tabbedWindow.portrait:SetTexture(portraitPath)
PositionFrame(tabbedWindow, 570, 220)

local bottomTabs = AWL.Frames:CreateTabGroup(tabbedWindow)
local characterPage = bottomTabs:AddTab("character", "Character")
local accountPage = bottomTabs:AddTab("account", "Account")
local warbandPage = bottomTabs:AddTab("warband", "Warband")
AddExampleLabel(characterPage, "Bottom tabs / Character", false)
AddExampleLabel(accountPage, "Bottom tabs / Account", false)
AddExampleLabel(warbandPage, "Bottom tabs / Warband", false)

CreatePopupExample("Popup - Solid Dark", "solid-dark", false, true, 1, 90, 220)
CreatePopupExample("Popup - Panel", "panel", false, true, 1, 330, 220)

CreatePopupExample("Popup - Solid Black (45%)", "solid-black", false, true, 0.45, 90, 360)

CreatePopupExample("Popup - Solid Dark (Borderless)", "solid-dark", false, false, 1, 330, 360)
