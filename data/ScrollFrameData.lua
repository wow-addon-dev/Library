local _, LIB = ...

local texturePath = "Interface\\AddOns\\ArcaneWizardLibrary\\assets\\scroll-frame\\"
local backgroundTileSize = 256
local solidBackgroundStyles = LIB.BackgroundData.solidStyles

LIB.ScrollFrameData = {
	minimumWidth = 96,
	minimumHeight = 72,
	borderColor = { 0.48, 0.46, 0.42, 1 },
	backgroundStyles = {
		transparent = {
			color = {
				red = 0,
				green = 0,
				blue = 0
			},
			alpha = 0
		},
		["solid-black"] = solidBackgroundStyles["solid-black"],
		["solid-dark"] = solidBackgroundStyles["solid-dark"],
		["solid-title"] = solidBackgroundStyles["solid-title"],
		pattern = {
			path = texturePath .. "background-pattern.tga",
			tileSize = backgroundTileSize
		}
	},
	backgroundInsets = {
		left = 1,
		right = 1,
		top = 1,
		bottom = 1
	},
	contentInsets = {
		left = 8,
		right = 29,
		top = 8,
		bottom = 8
	},
	scrollBar = {
		width = 14,
		rightInset = 5,
		topInset = 5,
		bottomInset = 5,
		buttonSize = 14,
		buttonSpacing = 2,
		trackWidth = 8,
		trackTileSize = 64,
		thumbWidth = 12,
		thumbHeight = 28,
		wheelStep = 24,
		textures = {
			track = texturePath .. "scrollbar-track.tga",
			thumb = {
				normal = texturePath .. "scrollbar-thumb-normal.tga",
				highlight = texturePath .. "scrollbar-thumb-highlight.tga",
				pushed = texturePath .. "scrollbar-thumb-pushed.tga",
				disabled = texturePath .. "scrollbar-thumb-disabled.tga"
			},
			up = {
				normal = texturePath .. "scrollbar-up-normal.tga",
				highlight = texturePath .. "scrollbar-up-highlight.tga",
				pushed = texturePath .. "scrollbar-up-pushed.tga",
				disabled = texturePath .. "scrollbar-up-disabled.tga"
			},
			down = {
				normal = texturePath .. "scrollbar-down-normal.tga",
				highlight = texturePath .. "scrollbar-down-highlight.tga",
				pushed = texturePath .. "scrollbar-down-pushed.tga",
				disabled = texturePath .. "scrollbar-down-disabled.tga"
			}
		}
	}
}
