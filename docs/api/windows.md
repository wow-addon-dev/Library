# Windows Static API

`ArcaneWizardLibrary.Windows` creates consistently styled addon windows from the library's scalable textures.

Both methods return standard WoW frames. The frames are centered and hidden after creation, allowing the consuming addon to add controls before calling `Show()`.

Close buttons use Library's own artwork and therefore look identical across supported game versions. Large windows use the `18 x 18` window variant, while popups use the `14 x 14` popup variant.

## `CreateWindow(title, width, height, showCloseButton, backgroundAlpha, movable, backgroundStyle, showPortrait, titleTransitionStyle)`

Creates a large window with a thin Retail-style frame and an integrated title bar.

```lua
local window = ArcaneWizardLibrary.Windows:CreateWindow("My Addon", 700, 480, true, 0.9, true, "solid", true, "line")

window.portrait:SetTexture("Interface\\AddOns\\MyAddon\\assets\\icon.blp")
window.portraitBackground:SetColorTexture(0.035, 0.035, 0.035, 1)

local text = window.content:CreateFontString(nil, "OVERLAY", "GameFontNormal")
text:SetPoint("TOPLEFT")
text:SetText("Window content")

window:Show()
```

The title remains centered when the window is resized. Change its text after creation with `window.titleText:SetText(text)`.

### Parameters

| Parameter | Type | Description |
| --- | --- | --- |
| `title` | `string` | Text displayed in the integrated title bar. |
| `width` | `number` | Initial width. Must be at least `256`. |
| `height` | `number` | Initial height. Must be at least `192`. |
| `showCloseButton` | `boolean` | Creates an X button in the upper-right corner when `true`. |
| `backgroundAlpha` | `number` | Initial background opacity from `0` to `1`. |
| `movable` | `boolean` | Allows the window and its title bar to be dragged when `true`. |
| `backgroundStyle` | `string` | Background style provided by the library. See the available styles below. |
| `showPortrait` | `boolean` | Creates a thin gold portrait frame in the upper-left corner when `true`. |
| `titleTransitionStyle` | `string` | Title transition style: `shadow`, `groove`, or `line`. |

### Title transition styles

| Style | Description |
| --- | --- |
| `shadow` | One-pixel separator with a soft twelve-pixel shadow. |
| `groove` | Inset light and dark separator with a twelve-pixel shadow. |
| `line` | Inset light and dark separator without a shadow. |

### Returned fields

| Field | Type | Description |
| --- | --- | --- |
| `background` | `Texture` | Background layer whose color, texture, and opacity can be changed. |
| `content` | `Frame` | Content area inside the frame and below the title bar. |
| `titleBar` | `Frame` | Integrated title bar and drag handle. |
| `titleBackground` | `Texture` | Separate title bar background. |
| `titleTransitionLines` | `Texture[]` | Lines separating the title bar and window background. |
| `titleShadowLayers` | `Texture[]` | Fading shadow below the title transition. |
| `titleText` | `FontString` | Title font string. |
| `portraitFrame` | `Frame \| nil` | Optional portrait frame. |
| `portraitBackground` | `Texture \| nil` | Opaque background behind transparent portrait images. |
| `portrait` | `Texture \| nil` | Optional masked portrait image. Set its image with `SetTexture()`. |
| `closeButton` | `Button \| nil` | Optional close button. |

## `CreatePopup(width, height, showCloseButton, showBorder, backgroundAlpha, movable, backgroundStyle)`

Creates a compact popup with a thinner frame from the same design family.

```lua
local popup = ArcaneWizardLibrary.Windows:CreatePopup(360, 160, true, true, 0.9, true, "solid")

popup:Show()
```

### Parameters

| Parameter | Type | Description |
| --- | --- | --- |
| `width` | `number` | Initial width. Must be at least `128`. |
| `height` | `number` | Initial height. Must be at least `96`. |
| `showCloseButton` | `boolean` | Creates an X button in the upper-right corner when `true`. |
| `showBorder` | `boolean` | Creates the popup border when `true`. Without a border, the background fills the complete frame. |
| `backgroundAlpha` | `number` | Initial background opacity from `0` to `1`. |
| `movable` | `boolean` | Allows the popup to be dragged when `true`. |
| `backgroundStyle` | `string` | Background style provided by the library. See the available styles below. |
The returned popup exposes `background`, `content`, and the optional `closeButton` fields.

## Customizing the background

The border and background use separate layers. Setting the background alpha to `0` therefore keeps the border visible.

Available background styles:

| Style | Appearance |
| --- | --- |
| `"solid"` | Single dark background color. |
| `"panel-dark"` | Warm dark panel with soft medium-scale variations. |
| `"slate-dark"` / `"slate-light"` | Layered slate texture. |
| `"leather-dark"` / `"leather-light"` | Fine aged leather texture. |

```lua
window.background:SetColorTexture(0.02, 0.025, 0.03, 1)
window.background:SetAlpha(0.85)
```

Changing the background does not affect controls added to `window.content`.

Texture backgrounds use `256 x 256` source images and repeat at a fixed size of `256` UI pixels instead of being stretched. Their texture coordinates are updated automatically whenever the window or popup is resized.

## Showing, closing, and resizing

The returned objects are standard WoW frames. Use their existing frame methods:

```lua
window:Show()
window:Hide()
window:SetSize(800, 600)
```

`Hide()` closes the window without destroying it, so it can be shown again later. The optional X button also calls `Hide()`.

Dragging changes the frame position for the current session. Persisting that position remains the responsibility of the consuming addon.
