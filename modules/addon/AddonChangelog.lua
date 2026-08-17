local _, LIB = ...

local AWL = ArcaneWizardLibrary
local L = LIB.Localization
local AddonChangelogData = LIB.AddonChangelogData
local AddonChangelog = LIB.Internal.AddonChangelog
local DEBUG_PREFIX = "Arcane Wizard: Library (Debug): "

---@class ArcaneWizardLibraryChangelogVersion
---@field version string Version label displayed as the section heading.
---@field date? string Optional release or build date.
---@field entries string[] Changelog entries displayed as bullet points.

local changelogWindow
local scrollArea
local changelogRows = {}
local pendingChangelogVersions

-----------------------
--- Local Functions ---
-----------------------

local function CreateChangelogRow()
	local row = CreateFrame("Frame", nil, scrollArea.content)

	local text = row:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
	text:SetJustifyH("LEFT")
	text:SetJustifyV("TOP")
	text:SetSpacing(AddonChangelogData.lineSpacing)
	text:SetWordWrap(true)

	local bullet = row:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
	bullet:SetPoint("TOPLEFT")
	bullet:SetWidth(AddonChangelogData.bulletWidth)
	bullet:SetJustifyH("CENTER")
	bullet:SetJustifyV("TOP")
	bullet:SetText("•")
	bullet:Hide()

	row.text = text
	row.bullet = bullet

	return row
end

local function AddChangelogRow(rowCount, text, isBullet, rowWidth, offset)
	local padding = AddonChangelogData.contentPadding
	local spacing = AddonChangelogData.lineSpacing
	local textInset = isBullet and AddonChangelogData.bulletWidth + AddonChangelogData.bulletSpacing or 0

	rowCount = rowCount + 1

	local row = changelogRows[rowCount]

	if not row then
		row = CreateChangelogRow()
		changelogRows[rowCount] = row
	end

	row:ClearAllPoints()
	row:SetPoint("TOPLEFT", scrollArea.content, "TOPLEFT", padding, -offset)
	row:SetWidth(rowWidth)
	row.bullet:SetShown(isBullet)

	row.text:ClearAllPoints()
	row.text:SetPoint("TOPLEFT", textInset, 0)
	row.text:SetWidth(math.max(1, rowWidth - textInset))
	row.text:SetText(text == "" and " " or text)

	local _, fontHeight = row.text:GetFont()
	local textHeight = row.text:GetStringHeight() or 0
	local rowHeight = math.ceil(math.max(textHeight, fontHeight or 1))

	row:SetHeight(rowHeight)
	row:Show()

	return rowCount, offset + rowHeight + spacing
end

local function RenderChangelog(versions)
	local padding = AddonChangelogData.contentPadding
	local spacing = AddonChangelogData.lineSpacing
	local rowWidth = math.max(1, scrollArea.content:GetWidth() - padding * 2)
	local offset = padding
	local rowCount = 0

	for versionIndex, versionData in ipairs(versions) do
		local heading = "|cffffd200" .. versionData.version

		if versionData.date then
			heading = heading .. " (" .. versionData.date .. ")"
		end

		heading = heading .. "|r"
		rowCount, offset = AddChangelogRow(rowCount, heading, false, rowWidth, offset)
		rowCount, offset = AddChangelogRow(rowCount, "", false, rowWidth, offset)

		for _, entry in ipairs(versionData.entries) do
			rowCount, offset = AddChangelogRow(rowCount, entry, true, rowWidth, offset)
		end

		if versionIndex < #versions then
			rowCount, offset = AddChangelogRow(rowCount, "", false, rowWidth, offset)
		end
	end

	for index = rowCount + 1, #changelogRows do
		changelogRows[index]:Hide()
	end

	scrollArea:SetContentHeight(math.ceil(offset - spacing + padding))
end

local function FinishChangelogLayout(frame)
	frame:SetScript("OnUpdate", nil)

	local versions = pendingChangelogVersions
	pendingChangelogVersions = nil

	if not versions or not frame:IsShown() then
		return
	end

	RenderChangelog(versions)
	scrollArea:ScrollToTop()
end

local function ValidateChangelog(versions, addonName)
	assert(type(versions) == "table" and #versions > 0, DEBUG_PREFIX .. "Changelog versions must be a non-empty table for " .. tostring(addonName) .. ".")

	for versionIndex, versionData in ipairs(versions) do
		local versionPrefix = DEBUG_PREFIX .. "Changelog version " .. versionIndex .. " for " .. tostring(addonName)

		assert(type(versionData) == "table", versionPrefix .. " must be a table.")
		assert(type(versionData.version) == "string" and versionData.version ~= "", versionPrefix .. " must define a non-empty version string.")
		assert(versionData.date == nil or type(versionData.date) == "string" and versionData.date ~= "", versionPrefix .. " date must be a non-empty string or nil.")
		assert(type(versionData.entries) == "table" and #versionData.entries > 0, versionPrefix .. " entries must be a non-empty table.")

		for entryIndex, entry in ipairs(versionData.entries) do
			assert(type(entry) == "string" and entry ~= "", versionPrefix .. " entry " .. entryIndex .. " must be a non-empty string.")
		end
	end
end

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
		windowData.titleTransitionStyle,
		true
	)
	local scrollData = AddonChangelogData.scrollFrame
	local contentWidth = math.max(frame.content:GetWidth() - AddonChangelogData.outerInset * 2, 96)
	local contentHeight = math.max(frame.content:GetHeight() - AddonChangelogData.footerHeight, 72)

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

	changelogWindow = frame

	return frame
end

------------------------
--- Public Functions ---
------------------------

function AddonChangelog:Set(addon, versions)
	ValidateChangelog(versions, addon.name)

	addon.changelog = versions
end

function AddonChangelog:Open(addon)
	ValidateChangelog(addon.changelog, addon.name)

	local frame = changelogWindow or CreateChangelogWindow()
	frame.titleText:SetText(string.format(L["changelog.window.title"], addon.name))
	frame:Show()
	RenderChangelog(addon.changelog)
	scrollArea:ScrollToTop()

	pendingChangelogVersions = addon.changelog
	frame:SetScript("OnUpdate", FinishChangelogLayout)

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
