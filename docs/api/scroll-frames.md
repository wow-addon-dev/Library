# Scroll Frames Static API

`ArcaneWizardLibrary.ScrollFrames` creates a scroll area with dedicated transparent, solid, or patterned backgrounds, an optional border, a fully styled vertical scrollbar, and mouse-wheel support across supported Retail and Classic clients.

## `CreateScrollFrame(parent, width, height, showBorder, backgroundAlpha, backgroundStyle)`

Creates the outer frame, background, optional border, native scroll frame, content frame, and vertical scrollbar. The scrollbar uses Library-owned artwork for its arrow buttons, track, and thumb.

| Parameter | Type | Description |
| --- | --- | --- |
| `parent` | `Frame` | Parent frame for the scroll area. |
| `width` | `number` | Initial width. Must be at least `96` pixels. |
| `height` | `number` | Initial height. Must be at least `72` pixels. |
| `showBorder` | `boolean` | Creates the outer border when `true`. |
| `backgroundAlpha` | `number` | Background opacity from `0` to `1`. The `transparent` style always remains fully transparent. |
| `backgroundStyle` | `string` | `transparent`, `solid-black`, `solid-dark`, `solid-title`, or `pattern`. |

```lua
local scrollArea = ArcaneWizardLibrary.ScrollFrames:CreateScrollFrame(
  window.content,
  320,
  280,
  true,
  1,
  "pattern"
)
scrollArea:SetPoint("TOPLEFT", 16, -16)

local label = scrollArea.content:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
label:SetPoint("TOPLEFT", 8, -8)
label:SetText("Scrollable content")

scrollArea:SetContentHeight(600)
```

Add child elements to `scrollArea.content`. After laying out the content, call `SetContentHeight` with its complete height so the slider range can be calculated.

## Background Styles

| Style | Description |
| --- | --- |
| `transparent` | No interior fill. The optional border and scrollbar remain visible. |
| `solid-black` | Solid black background using `backgroundAlpha`. |
| `solid-dark` | Standard dark Library background. |
| `solid-title` | Solid background matching the Library title-bar color. |
| `pattern` | Seamlessly tiled pattern with subtle stains and wear. |

## Fields

| Field | Type | Description |
| --- | --- | --- |
| `background` | `Texture` | Configurable solid or tiled interior background. |
| `scrollFrame` | `ScrollFrame` | Native WoW scroll frame. |
| `content` | `Frame` | Parent for all scrollable child elements. |
| `scrollBar` | `Slider` | Styled vertical slider with its own track and thumb artwork. |
| `scrollUpButton` | `Button` | Upper scrollbar arrow button. |
| `scrollDownButton` | `Button` | Lower scrollbar arrow button. |

## Methods

| Method | Description |
| --- | --- |
| `SetContentHeight(height)` | Updates the content height and scroll range. |
| `SetScrollStep(step)` | Changes the number of pixels scrolled per mouse-wheel step. |
| `SetVerticalScroll(value)` | Scrolls to a clamped vertical pixel offset. |
| `GetVerticalScroll()` | Returns the current vertical pixel offset. |
| `ScrollToTop()` | Scrolls to the beginning. |
| `ScrollToBottom()` | Scrolls to the end. |

The arrow buttons are disabled automatically at the beginning or end of the content. The outer frame can be resized normally; tiled backgrounds, content width, scrollbar track, and scroll range are updated automatically.
