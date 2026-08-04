local _, LIB = ...

local texturePath = "Interface\\AddOns\\ArcaneWizardLibrary\\assets\\window\\"
local backgroundTileSize = 256
local nineSliceCoordinates = {
	{ 0, 0.25, 0, 0.25 },
	{ 0.25, 0.75, 0, 0.25 },
	{ 0.75, 1, 0, 0.25 },
	{ 0, 0.25, 0.25, 0.75 },
	{ 0.25, 0.75, 0.25, 0.75 },
	{ 0.75, 1, 0.25, 0.75 },
	{ 0, 0.25, 0.75, 1 },
	{ 0.25, 0.75, 0.75, 1 },
	{ 0.75, 1, 0.75, 1 }
}

LIB.WindowData = {
	window = {
		minimumWidth = 256,
		minimumHeight = 192,
		sliceSize = 22,
		frameBrightness = 1,
		frameOutsets = {
			right = 1,
			bottom = 1
		},
		backgroundInsets = {
			left = 1,
			right = 1,
			top = 23,
			bottom = 1
		},
		contentInsets = {
			left = 8,
			right = 8,
			top = 35,
			bottom = 8
		},
		title = {
			height = 21,
			horizontalInset = 24,
			topOffset = 2,
			background = {
				path = texturePath .. "title-bar.tga",
				height = 19,
				leftInset = 3,
				rightInset = 2,
				topOffset = 3
			},
			transition = {
				leftInset = 3,
				rightInset = 2
			}
		},
		closeButton = {
			template = "ArcaneWizardLibrary_WindowCloseButtonTemplate",
			horizontalOffset = 3,
			verticalOffset = 3
		}
	},
	titleTransitionStyles = {
		shadow = {
			topOffset = 22,
			lineColors = {
				{ red = 0.329, green = 0.318, blue = 0.298, alpha = 1 }
			},
			shadowColors = {
				{ red = 0, green = 0, blue = 0, alpha = 0.28 },
				{ red = 0, green = 0, blue = 0, alpha = 0.24 },
				{ red = 0, green = 0, blue = 0, alpha = 0.21 },
				{ red = 0, green = 0, blue = 0, alpha = 0.18 },
				{ red = 0, green = 0, blue = 0, alpha = 0.15 },
				{ red = 0, green = 0, blue = 0, alpha = 0.12 },
				{ red = 0, green = 0, blue = 0, alpha = 0.1 },
				{ red = 0, green = 0, blue = 0, alpha = 0.08 },
				{ red = 0, green = 0, blue = 0, alpha = 0.06 },
				{ red = 0, green = 0, blue = 0, alpha = 0.04 },
				{ red = 0, green = 0, blue = 0, alpha = 0.025 },
				{ red = 0, green = 0, blue = 0, alpha = 0.01 }
			}
		},
		groove = {
			topOffset = 21,
			lineColors = {
				{ red = 0.467, green = 0.451, blue = 0.42, alpha = 0.45 },
				{ red = 0.09, green = 0.09, blue = 0.082, alpha = 0.9 }
			},
			shadowColors = {
				{ red = 0, green = 0, blue = 0, alpha = 0.5 },
				{ red = 0, green = 0, blue = 0, alpha = 0.43 },
				{ red = 0, green = 0, blue = 0, alpha = 0.37 },
				{ red = 0, green = 0, blue = 0, alpha = 0.31 },
				{ red = 0, green = 0, blue = 0, alpha = 0.26 },
				{ red = 0, green = 0, blue = 0, alpha = 0.21 },
				{ red = 0, green = 0, blue = 0, alpha = 0.17 },
				{ red = 0, green = 0, blue = 0, alpha = 0.13 },
				{ red = 0, green = 0, blue = 0, alpha = 0.1 },
				{ red = 0, green = 0, blue = 0, alpha = 0.07 },
				{ red = 0, green = 0, blue = 0, alpha = 0.04 },
				{ red = 0, green = 0, blue = 0, alpha = 0.02 }
			}
		},
		line = {
			topOffset = 21,
			lineColors = {
				{ red = 0.467, green = 0.451, blue = 0.42, alpha = 0.45 },
				{ red = 0.09, green = 0.09, blue = 0.082, alpha = 0.9 }
			},
			shadowColors = {}
		}
	},
	popup = {
		minimumWidth = 128,
		minimumHeight = 96,
		sliceSize = 22,
		frameBrightness = 1,
		frameOutsets = {
			right = 1,
			bottom = 1
		},
		backgroundInsets = {
			left = 1,
			right = 1,
			top = 1,
			bottom = 1
		},
		contentInsets = {
			left = 10,
			right = 10,
			top = 10,
			bottom = 10
		},
		closeButton = {
			template = "ArcaneWizardLibrary_PopupCloseButtonTemplate",
			border = {
				horizontalOffset = 3,
				verticalOffset = 4
			},
			borderless = {
				horizontalOffset = -4,
				verticalOffset = -4
			}
		}
	},
	portrait = {
		size = 64,
		imageSize = 50,
		offsetX = 20,
		offsetY = -20,
		maskPath = texturePath .. "portrait-mask.tga",
		borderPath = texturePath .. "portrait-border.tga",
		backgroundColor = {
			red = 0.035,
			green = 0.035,
			blue = 0.035
		}
	},
	backgroundStyles = {
		solid = {
			color = {
				red = 0.078,
				green = 0.078,
				blue = 0.074
			}
		},
		["slate-dark"] = {
			path = texturePath .. "background-slate-dark.tga",
			tileSize = backgroundTileSize
		},
		["slate-light"] = {
			path = texturePath .. "background-slate-light.tga",
			tileSize = backgroundTileSize
		},
		["leather-dark"] = {
			path = texturePath .. "background-leather-dark.tga",
			tileSize = backgroundTileSize
		},
		["leather-light"] = {
			path = texturePath .. "background-leather-light.tga",
			tileSize = backgroundTileSize
		},
		["panel-dark"] = {
			path = texturePath .. "background-panel-dark.tga",
			tileSize = backgroundTileSize
		}
	},
	frameTextures = {
		window = {
			path = texturePath .. "window-border.tga",
			coordinates = nineSliceCoordinates
		},
		popup = {
			path = texturePath .. "popup-border.tga",
			coordinates = nineSliceCoordinates
		}
	}
}
