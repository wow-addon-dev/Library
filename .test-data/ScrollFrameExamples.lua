local AWL = ArcaneWizardLibrary

local frame = AWL.Frames:CreateWindow({
	title = "Scroll Frame Examples",
	width = 620,
	height = 420,
	backgroundStyle = "panel",
	backgroundAlpha = 1,
	titleTransitionStyle = "shadow",
	showPortrait = false,
	showCloseButton = true,
	movable = true
})
frame:ClearAllPoints()
frame:SetPoint("TOPLEFT", UIParent, "TOPLEFT", 672, -252)

local examples = {
	{ label = "Transparent / Borderless", style = "transparent", showBorder = false, left = 8, top = 10 },
	{ label = "Solid / Black / Framed", style = "solid-black", showBorder = true, left = 308, top = 10 },
	{ label = "Solid Dark / Borderless", style = "solid-dark", showBorder = false, left = 8, top = 194 },
	{ label = "Pattern / Framed", style = "pattern", showBorder = true, left = 308, top = 194 }
}

local rowHeight = 22
local rowCount = 10
for _, example in ipairs(examples) do
	local scrollArea = AWL.ScrollFrames:CreateScrollFrame({
		parent = frame.content,
		width = 284,
		height = 166,
		backgroundStyle = example.style,
		backgroundAlpha = 1,
		showBorder = example.showBorder
	})
	scrollArea:SetPoint("TOPLEFT", example.left, -example.top)

	for index = 1, rowCount do
		local label = scrollArea.content:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
		label:SetPoint("TOPLEFT", 8, -((index - 1) * rowHeight + 4))
		label:SetText(index == 1 and example.label or "Scrollable row " .. index)

		local divider = scrollArea.content:CreateTexture(nil, "ARTWORK")
		divider:SetColorTexture(0.35, 0.33, 0.29, 0.55)
		divider:SetHeight(1)
		divider:SetPoint("TOPLEFT", 8, -(index * rowHeight))
		divider:SetPoint("TOPRIGHT", -8, -(index * rowHeight))
	end

	scrollArea:SetContentHeight(rowCount * rowHeight + 1)
end

frame:Show()
