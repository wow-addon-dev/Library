local _, LIB = ...

local AddonLauncher = LIB.Internal.AddonLauncher

-----------------------
--- Local Functions ---
-----------------------

local function AddTooltipLines(tooltip, tooltipConfig)
	if type(tooltipConfig) == "table" then
		for _, line in ipairs(tooltipConfig) do
			GameTooltip_AddHighlightLine(tooltip, line)
		end
	elseif tooltipConfig and tooltipConfig ~= "" then
		GameTooltip_AddHighlightLine(tooltip, tooltipConfig)
	end
end

local function ShowTooltip(addon, config, tooltip)
	GameTooltip_SetTitle(tooltip, addon.name)
	GameTooltip_AddNormalLine(tooltip, tostring(addon.version or "") .. " (" .. tostring(addon.buildDate or "") .. ")")
	GameTooltip_AddBlankLineToTooltip(tooltip)
	AddTooltipLines(tooltip, config.tooltip)
end

local function HandleClick(addon, config, button)
	if button == "LeftButton" and config.onLeftClick then
		config.onLeftClick()
	elseif button == "RightButton" then
		addon:OpenCategory()
	end
end

--------------------------
--- Internal Functions ---
--------------------------

function AddonLauncher:RegisterMinimapButton(addon, config)
	config = config or {}

	local iconFileName = config.iconFileName or "icon-round.blp"

	local LDB = LibStub("LibDataBroker-1.1"):NewDataObject(addon.name, {
		type = "launcher",
		text = addon.name,
		icon = addon:GetMediaPath(iconFileName),
		OnClick = function(_, button)
			HandleClick(addon, config, button)
		end,
		OnTooltipShow = function(tooltip)
			ShowTooltip(addon, config, tooltip)
		end,
	})

	local minimapButton = LibStub("LibDBIcon-1.0")
	minimapButton:Register(addon.name, LDB, config.db)

	return minimapButton
end

function AddonLauncher:CreateCompartmentHandlers(addon, config)
	config = config or {}

	return {
		OnEnter = function(_, button)
			GameTooltip:ClearAllPoints()
			GameTooltip:SetOwner(button, "ANCHOR_LEFT")
			ShowTooltip(addon, config, GameTooltip)
			GameTooltip:Show()
		end,
		OnLeave = function()
			GameTooltip:Hide()
		end,
		OnClick = function(_, button)
			HandleClick(addon, config, button)
		end
	}
end
