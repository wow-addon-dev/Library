local addonName, LIB = ...

local L = LIB.Localization

ArcaneWizardLibrary = ArcaneWizardLibrary or {}
ArcaneWizardLibrary.Dialog = {}

ArcaneWizardLibrary.Dialog.copyAdressDialog = nil
ArcaneWizardLibrary.Dialog.deleteDataDialog = nil

function ArcaneWizardLibrary.Dialog:ShowCopyAddressDialog(address)
    if not self.copyAdressDialog then
		local frameName = "WoWAddonDevelopment_SharedDialogs_CopyAdressFrame"

        local frame = CreateFrame("Frame", frameName, UIParent, "TranslucentFrameTemplate")
        frame:SetFrameStrata("DIALOG")
        frame:SetClampedToScreen(true)
        frame:SetSize(400, 100)
        frame:SetPoint("CENTER", 0, 200)
        frame:Hide()

        tinsert(UISpecialFrames, frameName)

        frame.Text = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
        frame.Text:SetJustifyH("CENTER")
        frame.Text:SetSpacing(2)
        frame.Text:SetPoint("TOPLEFT", 20, -20)
        frame.Text:SetPoint("TOPRIGHT", -20, -20)

        frame.EditBox = CreateFrame("EditBox", nil, frame, "InputBoxTemplate")
        frame.EditBox:SetSize(340, 20)
        frame.EditBox:SetAutoFocus(false)
        frame.EditBox:SetPoint("TOP", frame.Text, "BOTTOM", 0, -10)
        frame.EditBox:SetScript("OnEnterPressed", function(self)
            self:ClearFocus()
        end)

        frame.CloseButton = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
        frame.CloseButton:SetSize(100, 22)
        frame.CloseButton:SetPoint("TOP", frame.EditBox, "BOTTOM", 0, -10)
        frame.CloseButton:SetScript("OnClick", function()
            frame:Hide()
        end)

        self.copyAdressDialog = frame
    end

    if self.deleteDataDialog and self.deleteDataDialog:IsShown() then self.deleteDataDialog:Hide() end

    self.copyAdressDialog.Text:SetText(L["dialog.copy-address.text"])
    self.copyAdressDialog.CloseButton:SetText(CLOSE)
    self.copyAdressDialog.EditBox:SetText(address)
    self.copyAdressDialog.EditBox:HighlightText()

    self.copyAdressDialog:SetHeight(self.copyAdressDialog:GetTop() - self.copyAdressDialog.CloseButton:GetBottom() + 20)
    self.copyAdressDialog:Show()
end

function ArcaneWizardLibrary.Dialog:ShowDeleteDataDialog(onConfirmCallback)
    if not self.deleteDataDialog then
        local frameName = "WoWAddonDevelopment_SharedDialogs_DeleteDataFrame"

        local frame = CreateFrame("Frame", frameName, UIParent, "TranslucentFrameTemplate")
        frame:SetFrameStrata("DIALOG")
        frame:SetClampedToScreen(true)
        frame:SetSize(350, 100)
        frame:SetPoint("CENTER", 0, 200)
        frame:Hide()

        tinsert(UISpecialFrames, frameName)

        frame.Text = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
        frame.Text:SetJustifyH("CENTER")
        frame.Text:SetSpacing(2)
        frame.Text:SetPoint("TOPLEFT", 20, -20)
        frame.Text:SetPoint("TOPRIGHT", -20, -20)

        frame.YesButton = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
        frame.YesButton:SetSize(100, 22)
        frame.YesButton:SetPoint("TOP", frame.Text, "BOTTOM", -75, -10)

        frame.NoButton = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
        frame.NoButton:SetSize(100, 22)
        frame.NoButton:SetPoint("TOP", frame.Text, "BOTTOM", 75, -10)
        frame.NoButton:SetScript("OnClick", function()
            frame:Hide()
        end)

        self.resetDialog = frame
    end

    if self.copyAdressDialog and self.copyAdressDialog:IsShown() then self.copyAdressDialog:Hide() end

    self.deleteDataDialog.Text:SetText(L["dialog.delete-data.text"])
    self.deleteDataDialog.YesButton:SetText(YES)
    self.deleteDataDialog.NoButton:SetText(NO)

    self.deleteDataDialog.YesButton:SetScript("OnClick", function()
        if type(onConfirmCallback) == "function" then
            onConfirmCallback()
        end
        self.deleteDataDialog:Hide()
    end)

    self.deleteDataDialog:SetHeight(self.deleteDataDialog:GetTop() - self.deleteDataDialog.NoButton:GetBottom() + 20)
    self.deleteDataDialog:Show()
end
