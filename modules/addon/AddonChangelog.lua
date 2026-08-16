local _, LIB = ...

local AWL = ArcaneWizardLibrary
local L = LIB.Localization
local AddonChangelogData = LIB.AddonChangelogData
local AddonChangelog = LIB.Internal.AddonChangelog

local changelogWindow
local changelogText
local scrollArea

-----------------------
--- Local Functions ---
-----------------------

local function CreateChangelogWindow()
	local windowData = AddonChangelogData.window
	local frame = AWL.Frames:CreateWindow(
		"",
		windowData.width,
		windowData.height,
		true,
		windowData.backgroundAlpha,
		true,
		windowData.backgroundStyle,
		false,
		windowData.titleTransitionStyle
	)
	local scrollData = AddonChangelogData.scrollFrame
	local contentWidth = math.max(frame.content:GetWidth(), 96)
	local contentHeight = math.max(frame.content:GetHeight(), 72)

	scrollArea = AWL.ScrollFrames:CreateScrollFrame(
		frame.content,
		contentWidth,
		contentHeight,
		scrollData.showBorder,
		scrollData.backgroundAlpha,
		scrollData.backgroundStyle
	)
	scrollArea:SetPoint("TOPLEFT", AddonChangelogData.outerInset, 0)
	scrollArea:SetPoint("BOTTOMRIGHT", -AddonChangelogData.outerInset, AddonChangelogData.footerHeight)

	local closeButton = AWL.Controls:CreateButton(
		frame.content,
		AddonChangelogData.closeButtonWidth,
		L["changelog.window.close"],
		function()
			frame:Hide()
		end
	)
	closeButton:SetPoint("BOTTOMRIGHT", -AddonChangelogData.outerInset, AddonChangelogData.outerInset)

	local padding = AddonChangelogData.contentPadding
	changelogText = scrollArea.content:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
	changelogText:SetPoint("TOPLEFT", padding, -padding)
	changelogText:SetPoint("TOPRIGHT", -padding, -padding)
	changelogText:SetJustifyH("LEFT")
	changelogText:SetJustifyV("TOP")
	changelogText:SetSpacing(AddonChangelogData.lineSpacing)
	changelogText:SetWordWrap(true)

	changelogWindow = frame

	return frame
end

------------------------
--- Public Functions ---
------------------------

function AddonChangelog:Set(addon, text)
	assert(type(text) == "string" and text ~= "", "Arcane Wizard: Library (Debug): No changelog text defined for " .. tostring(addon.name) .. ".")

	addon.changelog = text
end

function AddonChangelog:Open(addon)
	assert(type(addon.changelog) == "string" and addon.changelog ~= "", "Arcane Wizard: Library (Debug): No changelog text defined for " .. tostring(addon.name) .. ".")

	local frame = changelogWindow or CreateChangelogWindow()
	frame.titleText:SetText(string.format(L["changelog.window.title"], addon.name))
	frame:Show()

	changelogText:SetText(addon.changelog)
	scrollArea:ScrollToTop()

	local textHeight = changelogText:GetStringHeight() or 0
	scrollArea:SetContentHeight(math.ceil(textHeight) + AddonChangelogData.contentPadding * 2)

	return frame
end

function AddonChangelog:AddSettingsButton(addon, layout)
	assert(layout ~= nil, "Arcane Wizard: Library (Debug): No settings layout defined for " .. tostring(addon.name) .. ".")

	return AWL.Settings:AddButton(layout, {
		name = L["settings.changelog.name"],
		buttonText = L["settings.changelog.button"],
		onClick = function()
			AddonChangelog:Open(addon)
		end,
		tooltip = L["settings.changelog.tooltip"]
	})
end
