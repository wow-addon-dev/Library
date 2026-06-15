# Dialogs API

`ArcaneWizardLibrary.Dialogs` exposes reusable popup helpers.

## `ShowLinkDialog(address)`

Shows a popup dialog with a copyable text field.

```lua
ArcaneWizardLibrary.Dialogs:ShowLinkDialog("https://github.com/wow-addon-dev/Library")
```

The text is selected automatically when the dialog opens.

## `ShowConfirmDialog(text, onConfirmCallback, onCancelCallback)`

Shows a confirmation dialog with Yes and No buttons.

```lua
ArcaneWizardLibrary.Dialogs:ShowConfirmDialog(
  "Switch profile mode?",
  function()
    SwitchProfileMode()
  end
)
```

`onCancelCallback` is optional.
