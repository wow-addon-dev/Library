local _, LIB = ...

local WindowData = LIB.WindowData

---@class ArcaneWizardLibraryWindowFrame: Frame
---@field background Texture Configurable window background.
---@field content Frame Content area inside the window frame.
---@field titleBar Frame Integrated title bar and drag handle.
---@field titleBackground Texture Title bar background.
---@field titleTransitionLines Texture[] Lines separating the title bar and window background.
---@field titleShadowLayers Texture[] Fading shadow below the title transition.
---@field titleText FontString Title font string.
---@field portraitFrame? Frame Optional portrait frame.
---@field portraitBackground? Texture Optional opaque portrait background.
---@field portrait? Texture Optional portrait image.
---@field closeButton? Button Optional close button.

---@class ArcaneWizardLibraryPopupFrame: Frame
---@field background Texture Configurable popup background.
---@field content Frame Content area inside the popup frame.
---@field closeButton? Button Optional close button.

-----------------------
--- Local Functions ---
-----------------------

local function ValidateParameters(width, height, showCloseButton, backgroundAlpha, movable, defaults, methodName)
	assert(type(width) == "number" and width >= defaults.minimumWidth, "Arcane Wizard: Library (Debug): " .. methodName .. " width must be at least " .. defaults.minimumWidth .. ".")
	assert(type(height) == "number" and height >= defaults.minimumHeight, "Arcane Wizard: Library (Debug): " .. methodName .. " height must be at least " .. defaults.minimumHeight .. ".")
	assert(type(showCloseButton) == "boolean", "Arcane Wizard: Library (Debug): " .. methodName .. " showCloseButton must be a boolean.")
	assert(type(backgroundAlpha) == "number" and backgroundAlpha >= 0 and backgroundAlpha <= 1, "Arcane Wizard: Library (Debug): " .. methodName .. " backgroundAlpha must be a number between 0 and 1.")
	assert(type(movable) == "boolean", "Arcane Wizard: Library (Debug): " .. methodName .. " movable must be a boolean.")
end

local function CreateTexture(frame, texturePath, coordinates, brightness)
	local texture = frame:CreateTexture(nil, "BACKGROUND")
	texture:SetTexture(texturePath)
	texture:SetTexCoord(unpack(coordinates))
	texture:SetTexelSnappingBias(0)
	texture:SetSnapToPixelGrid(false)
	texture:SetVertexColor(brightness, brightness, brightness)

	return texture
end

local function ApplyNineSlice(frame, textures, data)
	local sliceSize = textures.sliceSize or data.sliceSize
	local frameOutsets = data.frameOutsets or {}
	local rightOutset = frameOutsets.right or 0
	local bottomOutset = frameOutsets.bottom or 0
	local brightness = data.frameBrightness
	local topLeft = CreateTexture(frame, textures.path, textures.coordinates[1], brightness)
	topLeft:SetSize(sliceSize, sliceSize)
	topLeft:SetPoint("TOPLEFT")

	local topRight = CreateTexture(frame, textures.path, textures.coordinates[3], brightness)
	topRight:SetSize(sliceSize, sliceSize)
	topRight:SetPoint("TOPRIGHT", rightOutset, 0)

	local bottomLeft = CreateTexture(frame, textures.path, textures.coordinates[7], brightness)
	bottomLeft:SetSize(sliceSize, sliceSize)
	bottomLeft:SetPoint("BOTTOMLEFT", 0, -bottomOutset)

	local bottomRight = CreateTexture(frame, textures.path, textures.coordinates[9], brightness)
	bottomRight:SetSize(sliceSize, sliceSize)
	bottomRight:SetPoint("BOTTOMRIGHT", rightOutset, -bottomOutset)

	local top = CreateTexture(frame, textures.path, textures.coordinates[2], brightness)
	top:SetPoint("TOPLEFT", topLeft, "TOPRIGHT")
	top:SetPoint("BOTTOMRIGHT", topRight, "BOTTOMLEFT")

	local bottom = CreateTexture(frame, textures.path, textures.coordinates[8], brightness)
	bottom:SetPoint("TOPLEFT", bottomLeft, "TOPRIGHT")
	bottom:SetPoint("BOTTOMRIGHT", bottomRight, "BOTTOMLEFT")

	local left = CreateTexture(frame, textures.path, textures.coordinates[4], brightness)
	left:SetPoint("TOPLEFT", topLeft, "BOTTOMLEFT")
	left:SetPoint("BOTTOMRIGHT", bottomLeft, "TOPRIGHT")

	local right = CreateTexture(frame, textures.path, textures.coordinates[6], brightness)
	right:SetPoint("TOPLEFT", topRight, "BOTTOMLEFT")
	right:SetPoint("BOTTOMRIGHT", bottomRight, "TOPRIGHT")

	local center = CreateTexture(frame, textures.path, textures.coordinates[5], brightness)
	center:SetPoint("TOPLEFT", topLeft, "BOTTOMRIGHT")
	center:SetPoint("BOTTOMRIGHT", bottomRight, "TOPLEFT")
end

local function ConfigureBackgroundTiling(frame, background, tileSize, insets)
	local horizontalInsets = insets and insets.left + insets.right or 0
	local verticalInsets = insets and insets.top + insets.bottom or 0

	local function UpdateTextureCoordinates(_, width, height)
		background:SetTexCoord(
			0,
			(width - horizontalInsets) / tileSize,
			0,
			(height - verticalInsets) / tileSize
		)
	end

	background:SetHorizTile(true)
	background:SetVertTile(true)
	frame:HookScript("OnSizeChanged", UpdateTextureCoordinates)
	UpdateTextureCoordinates(frame, frame:GetSize())
end

local function CreateInteriorBackground(frame, backgroundStyle, insets, backgroundAlpha)
	local background = frame:CreateTexture(nil, "BACKGROUND", nil, -2)

	if backgroundStyle.color then
		local color = backgroundStyle.color
		background:SetColorTexture(color.red, color.green, color.blue, 1)
	else
		background:SetTexture(backgroundStyle.path, "REPEAT", "REPEAT")
		background:SetTexelSnappingBias(0)
		background:SetSnapToPixelGrid(false)
		ConfigureBackgroundTiling(frame, background, backgroundStyle.tileSize, insets)
	end

	background:SetAlpha(backgroundAlpha)

	if insets then
		background:SetPoint("TOPLEFT", insets.left, -insets.top)
		background:SetPoint("BOTTOMRIGHT", -insets.right, insets.bottom)
	else
		background:SetAllPoints()
	end

	frame.background = background
end

local function RegisterDragHandle(frame, handle)
	handle:RegisterForDrag("LeftButton")
	handle:SetScript("OnDragStart", function()
		frame:StartMoving()
	end)
	handle:SetScript("OnDragStop", function()
		frame:StopMovingOrSizing()
	end)
end

local function ConfigureDragging(frame, movable)
	if not movable then
		return
	end

	frame:SetMovable(true)
	RegisterDragHandle(frame, frame)
end

local function CreateContentFrame(frame, insets)
	local content = CreateFrame("Frame", nil, frame)
	content:SetPoint("TOPLEFT", insets.left, -insets.top)
	content:SetPoint("BOTTOMRIGHT", -insets.right, insets.bottom)

	frame.content = content
end

local function CreateCloseButton(frame, showCloseButton, template, horizontalOffset, verticalOffset)
	if not showCloseButton then
		return
	end

	local closeButton = CreateFrame("Button", nil, frame, template)
	closeButton:SetPoint("TOPRIGHT", -horizontalOffset, -(verticalOffset or horizontalOffset))
	closeButton:SetFrameLevel(frame:GetFrameLevel() + 10)

	frame.closeButton = closeButton
end

local function CreateTitleTransitionLayer(frame, data, topOffset, color)
	local texture = frame:CreateTexture(nil, "BACKGROUND", nil, -1)
	texture:SetColorTexture(color.red, color.green, color.blue, color.alpha)
	texture:SetPoint("TOPLEFT", data.leftInset, -topOffset)
	texture:SetPoint("TOPRIGHT", -data.rightInset, -topOffset)
	texture:SetHeight(1)

	return texture
end

local function CreateTitleBar(frame, title, data, transitionStyle)
	local backgroundData = data.background
	local titleBackground = frame:CreateTexture(nil, "BACKGROUND", nil, -1)
	titleBackground:SetTexture(backgroundData.path)
	titleBackground:SetTexelSnappingBias(0)
	titleBackground:SetSnapToPixelGrid(false)
	titleBackground:SetPoint("TOPLEFT", backgroundData.leftInset, -backgroundData.topOffset)
	titleBackground:SetPoint("TOPRIGHT", -backgroundData.rightInset, -backgroundData.topOffset)
	titleBackground:SetHeight(backgroundData.height)

	local transitionData = data.transition
	local titleTransitionLines = {}
	for index, color in ipairs(transitionStyle.lineColors) do
		titleTransitionLines[index] = CreateTitleTransitionLayer(
			frame,
			transitionData,
			transitionStyle.topOffset + index - 1,
			color
		)
	end

	local titleShadowLayers = {}
	for index, color in ipairs(transitionStyle.shadowColors) do
		titleShadowLayers[index] = CreateTitleTransitionLayer(
			frame,
			transitionData,
			transitionStyle.topOffset + #transitionStyle.lineColors + index - 1,
			color
		)
	end

	local titleBar = CreateFrame("Frame", nil, frame)
	titleBar:SetPoint("TOPLEFT", data.horizontalInset, -data.topOffset)
	titleBar:SetPoint("TOPRIGHT", -data.horizontalInset, -data.topOffset)
	titleBar:SetHeight(data.height)
	titleBar:SetFrameLevel(frame:GetFrameLevel() + 5)

	if frame:IsMovable() then
		titleBar:EnableMouse(true)
		RegisterDragHandle(frame, titleBar)
	end

	local titleText = titleBar:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	titleText:SetPoint("LEFT")
	titleText:SetPoint("RIGHT")
	titleText:SetJustifyH("CENTER")
	titleText:SetWordWrap(false)
	titleText:SetText(title)

	frame.titleBar = titleBar
	frame.titleBackground = titleBackground
	frame.titleTransitionLines = titleTransitionLines
	frame.titleShadowLayers = titleShadowLayers
	frame.titleText = titleText
end

local function CreatePortrait(frame, showPortrait)
	if not showPortrait then
		return
	end

	local data = WindowData.portrait
	local portraitFrame = CreateFrame("Frame", nil, frame)
	portraitFrame:SetSize(data.size, data.size)
	portraitFrame:SetPoint("CENTER", frame, "TOPLEFT", data.offsetX, data.offsetY)
	portraitFrame:SetFrameLevel(frame:GetFrameLevel() + 8)

	local backgroundColor = data.backgroundColor
	local portraitBackground = portraitFrame:CreateTexture(nil, "BACKGROUND")
	portraitBackground:SetSize(data.imageSize, data.imageSize)
	portraitBackground:SetPoint("CENTER")
	portraitBackground:SetColorTexture(backgroundColor.red, backgroundColor.green, backgroundColor.blue, 1)

	local backgroundMask = portraitFrame:CreateMaskTexture(nil, "BACKGROUND")
	backgroundMask:SetTexture(data.maskPath)
	backgroundMask:SetAllPoints(portraitBackground)
	portraitBackground:AddMaskTexture(backgroundMask)

	local portrait = portraitFrame:CreateTexture(nil, "ARTWORK")
	portrait:SetSize(data.imageSize, data.imageSize)
	portrait:SetPoint("CENTER")

	local mask = portraitFrame:CreateMaskTexture(nil, "ARTWORK")
	mask:SetTexture(data.maskPath)
	mask:SetAllPoints(portrait)
	portrait:AddMaskTexture(mask)

	local border = portraitFrame:CreateTexture(nil, "OVERLAY")
	border:SetTexture(data.borderPath)
	border:SetAllPoints()

	frame.portraitFrame = portraitFrame
	frame.portraitBackground = portraitBackground
	frame.portrait = portrait
end

local function CreateBaseFrame(width, height, movable)
	local frame = CreateFrame("Frame", nil, UIParent)
	frame:SetSize(width, height)
	frame:SetPoint("CENTER")
	frame:SetFrameStrata("DIALOG")
	frame:SetClampedToScreen(true)
	frame:EnableMouse(true)
	ConfigureDragging(frame, movable)

	return frame
end

------------------------
--- Public Functions ---
------------------------

--- Creates a scalable window with an integrated title bar.
---
--- The returned frame is hidden and centered by default. Add child controls to frame.content.
--- Use frame.titleText:SetText() to change the title after creation.
---
--- @param title string Text displayed in the title bar.
--- @param width number Initial frame width. Minimum 256.
--- @param height number Initial frame height. Minimum 192.
--- @param showCloseButton boolean Creates a close button in the upper-right corner when true.
--- @param backgroundAlpha number Initial background opacity from 0 to 1.
--- @param movable boolean Enables dragging when true.
--- @param backgroundStyle string Background style defined by Arcane Wizard: Library.
--- @param showPortrait boolean Creates a portrait frame in the upper-left corner when true.
--- @param titleTransitionStyle string Title transition style defined by Arcane Wizard: Library.
---
--- @return ArcaneWizardLibraryWindowFrame frame The created window frame.
function ArcaneWizardLibrary.Windows:CreateWindow(title, width, height, showCloseButton, backgroundAlpha, movable, backgroundStyle, showPortrait, titleTransitionStyle)
	local data = WindowData.window
	local background = WindowData.backgroundStyles[backgroundStyle]
	local titleTransition = WindowData.titleTransitionStyles[titleTransitionStyle]

	assert(type(title) == "string", "Arcane Wizard: Library (Debug): CreateWindow title must be a string.")
	assert(type(showPortrait) == "boolean", "Arcane Wizard: Library (Debug): CreateWindow showPortrait must be a boolean.")
	assert(background, "Arcane Wizard: Library (Debug): CreateWindow backgroundStyle is not defined.")
	assert(titleTransition, "Arcane Wizard: Library (Debug): CreateWindow titleTransitionStyle is not defined.")
	ValidateParameters(width, height, showCloseButton, backgroundAlpha, movable, data, "CreateWindow")

	local frame = CreateBaseFrame(width, height, movable)
	ApplyNineSlice(frame, WindowData.frameTextures.window, data)
	CreateInteriorBackground(frame, background, data.backgroundInsets, backgroundAlpha)
	CreateContentFrame(frame, data.contentInsets)
	CreateTitleBar(frame, title, data.title, titleTransition)
	CreatePortrait(frame, showPortrait)
	CreateCloseButton(
		frame,
		showCloseButton,
		data.closeButton.template,
		data.closeButton.horizontalOffset,
		data.closeButton.verticalOffset
	)
	frame:Hide()

	return frame
end

--- Creates a scalable popup with an optional thin frame.
---
--- The returned frame is hidden and centered by default. Add child controls to frame.content.
---
--- @param width number Initial frame width. Minimum 128.
--- @param height number Initial frame height. Minimum 96.
--- @param showCloseButton boolean Creates a close button in the upper-right corner when true.
--- @param showBorder boolean Creates the popup border when true.
--- @param backgroundAlpha number Initial background opacity from 0 to 1.
--- @param movable boolean Enables dragging when true.
--- @param backgroundStyle string Background style defined by Arcane Wizard: Library.
---
--- @return ArcaneWizardLibraryPopupFrame frame The created popup frame.
function ArcaneWizardLibrary.Windows:CreatePopup(width, height, showCloseButton, showBorder, backgroundAlpha, movable, backgroundStyle)
	local data = WindowData.popup
	local background = WindowData.backgroundStyles[backgroundStyle]

	assert(type(showBorder) == "boolean", "Arcane Wizard: Library (Debug): CreatePopup showBorder must be a boolean.")
	assert(background, "Arcane Wizard: Library (Debug): CreatePopup backgroundStyle is not defined.")
	ValidateParameters(width, height, showCloseButton, backgroundAlpha, movable, data, "CreatePopup")

	local frame = CreateBaseFrame(width, height, movable)
	if showBorder then
		ApplyNineSlice(frame, WindowData.frameTextures.popup, data)
	end
	CreateInteriorBackground(
		frame,
		background,
		showBorder and data.backgroundInsets or nil,
		backgroundAlpha
	)
	CreateContentFrame(frame, data.contentInsets)
	local closeButtonPosition = showBorder and data.closeButton.border or data.closeButton.borderless
	CreateCloseButton(
		frame,
		showCloseButton,
		data.closeButton.template,
		closeButtonPosition.horizontalOffset,
		closeButtonPosition.verticalOffset
	)
	frame:Hide()

	return frame
end
