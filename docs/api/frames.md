# Frames Static API

`ArcaneWizardLibrary.Frames` creates consistently styled addon frames. It provides large windows, compact popups, and window tab groups from the library's scalable textures.

Window and popup methods return standard WoW frames. The frames are centered and hidden after creation, allowing the consuming addon to add controls before calling `Show()`.

Windows and popups are raised with their complete child hierarchy when shown or selected. Overlapping Library frames therefore retain a consistent foreground and background order.

Close buttons use Library's own artwork and therefore look identical across supported game versions. Large windows use the `18 x 18` window variant, while popups use the `14 x 14` popup variant.

## `CreateWindow(title, width, height, showCloseButton, backgroundAlpha, movable, backgroundStyle, showPortrait, titleTransitionStyle, closeOnEscape)`

Creates a large window with a thin Retail-style frame and an integrated title bar.

```lua
local window = ArcaneWizardLibrary.Frames:CreateWindow("My Addon", 700, 480, true, 0.9, true, "solid-dark", true, "line", true)

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
| `titleTransitionStyle` | `string` | Title transition style: `shadow`, `strong-shadow`, or `line`. |
| `closeOnEscape` | `boolean \| nil` | Closes the window with Escape when `true`. Defaults to `false`. |

### Title transition styles

| Style | Description |
| --- | --- |
| `shadow` | One-pixel separator with a soft fourteen-pixel shadow. |
| `strong-shadow` | One-pixel separator with a stronger fourteen-pixel shadow. |
| `line` | One-pixel separator without a shadow. |

### Returned fields

| Field | Type | Description |
| --- | --- | --- |
| `background` | `Texture` | Background layer whose color, texture, and opacity can be changed. |
| `content` | `Frame` | Content area inside the frame and below the title bar. |
| `titleBar` | `Frame` | Integrated title bar and drag handle. |
| `titleBackground` | `Texture` | Title bar background with its integrated separator. |
| `titleShadowLayers` | `Texture[]` | Fading shadow below the title transition. |
| `titleText` | `FontString` | Title font string. |
| `portraitFrame` | `Frame \| nil` | Optional portrait frame. |
| `portraitBackground` | `Texture \| nil` | Opaque background behind transparent portrait images. |
| `portrait` | `Texture \| nil` | Optional masked portrait image. Set its image with `SetTexture()`. |
| `closeButton` | `Button \| nil` | Optional close button. |
| `closeOnEscape` | `boolean` | Whether pressing Escape closes the window. |
| `tabGroup` | `Frame \| nil` | Optional tab group attached with `CreateTabGroup()`. |

## `CreateTabGroup(window)`

Attaches a text-tab group to the bottom of a Library window. Popups are not supported. Only one tab group can be attached to a window.

```lua
local tabs = ArcaneWizardLibrary.Frames:CreateTabGroup(window)

local characterPage = tabs:AddTab("character", "Character")
local accountPage = tabs:AddTab("account", "Account")

local text = characterPage:CreateFontString(nil, "OVERLAY", "GameFontNormal")
text:SetPoint("TOPLEFT")
text:SetText("Character content")

tabs:SelectTab("account")
```

Each call to `AddTab()` returns a page that fills the existing `window.content` area. No additional content inset is added. The first added tab is selected automatically.

### Parameters

| Parameter | Type | Description |
| --- | --- | --- |
| `window` | `ArcaneWizardLibraryWindowFrame` | Window that owns the tab group. |

Tabs start `12` pixels from the left window edge. They are `24` pixels high, use `3` pixels of spacing, and the selected tab grows downward to `26` pixels. Their upper edge begins exactly at the lower window edge, which forms the shared connection.

### Tab group methods

| Method | Description |
| --- | --- |
| `AddTab(id, text)` | Adds a text tab and returns its content page. IDs must be unique. |
| `SelectTab(id)` | Shows the selected page and hides the previously selected page. |
| `GetSelectedTab()` | Returns the selected ID and page. |
| `SetTabEnabled(id, enabled)` | Enables or disables a tab. Disabling the selected tab selects the first available tab. |
| `SetOnTabChanged(callback)` | Sets or clears a callback receiving the selected ID and page. |

## `CreatePopup(width, height, showCloseButton, showBorder, backgroundAlpha, movable, backgroundStyle, closeOnEscape)`

Creates a compact popup with a thinner frame from the same design family.

```lua
local popup = ArcaneWizardLibrary.Frames:CreatePopup(360, 160, true, true, 0.9, true, "solid-dark", true)

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
| `closeOnEscape` | `boolean \| nil` | Closes the popup with Escape when `true`. Defaults to `false`. |

The returned popup exposes `background`, `content`, and the optional `closeButton` fields.

## `OpenChangelog(addonName, versions)`

Opens a movable changelog window for an addon and returns it. The first call for an addon name creates its window; later calls reuse the same window and render the supplied versions again. Different addon names use independent windows.

```lua
ArcaneWizardLibrary.Frames:OpenChangelog("MyAddon", {
  {
    version = "Version 1.1.0",
    date = "2026-08-17",
    entries = {
      "Added: A new feature",
      "Fixed: An important issue"
    }
  }
})
```

`addonName` must be a non-empty string. `versions` must be a non-empty ordered table containing a non-empty `version`, an optional non-empty `date`, and a non-empty ordered `entries` table for every version.

The same data can be passed as the optional third parameter of `Settings:AddAboutSection()` to add a changelog button to an addon's settings page.

## Customizing the background

The border and background use separate layers. Setting the background alpha to `0` therefore keeps the border visible.

Available background styles:

| Style | Appearance |
| --- | --- |
| `"solid-black"` | Solid black background. |
| `"solid-dark"` | Standard dark Library background. |
| `"solid-title"` | Solid background matching the Library title-bar color. |
| `"panel"` | Warm panel texture with soft medium-scale variations. |

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

When `closeOnEscape` is `true`, the frame is registered with Blizzard's standard `UISpecialFrames` handling. Pressing Escape then hides it like other WoW windows.

Dragging changes the frame position for the current session. Persisting that position remains the responsibility of the consuming addon.
