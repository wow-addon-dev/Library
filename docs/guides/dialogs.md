# Dialogs

Dialog helpers wrap common `StaticPopupDialogs` patterns.

## Link dialog

Use a link dialog when the user needs to copy a URL or other text value:

```lua
ArcaneWizardLibrary.Dialogs:ShowLinkDialog("https://github.com/wow-addon-dev/Library")
```

The dialog automatically selects the edit box text so the user can copy it directly.

## Confirmation dialog

Use confirmation dialogs for destructive or important actions:

```lua
ArcaneWizardLibrary.Dialogs:ShowConfirmDialog(
  "Delete all character profiles?",
  function()
    DeleteCharacterProfiles()
  end,
  function()
    print("Cancelled.")
  end
)
```

The cancel callback is optional.
