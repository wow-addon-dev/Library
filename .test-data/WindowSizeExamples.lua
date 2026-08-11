local AWL = ArcaneWizardLibrary

local exampleArea = CreateFrame("Frame", nil, UIParent)
exampleArea:SetSize(1380, 440)
exampleArea:SetPoint("CENTER")

local examples = {
	{ title = "Small - Panel (Shadow)", width = 280, height = 200, left = 0 },
	{ title = "Medium - Panel (Shadow)", width = 440, height = 320, left = 300 },
	{ title = "Large - Panel (Shadow)", width = 620, height = 440, left = 760 }
}

for _, example in ipairs(examples) do
	local frame = AWL.Frames:CreateWindow(example.title, example.width, example.height, true, 1, true, "panel", false, "shadow")
	frame:ClearAllPoints()
	frame:SetPoint("TOPLEFT", exampleArea, "TOPLEFT", example.left, 0)

	local label = frame.content:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	label:SetPoint("CENTER")
	label:SetText(example.width .. " x " .. example.height)

	frame:Show()
end
