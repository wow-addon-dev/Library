ArcaneWizardLibrary_SettingsPanelTextMixin = {}

function ArcaneWizardLibrary_SettingsPanelTextMixin:Init(initializer)
	local data = initializer:GetData()
	self.LeftText:SetTextToFit(data.leftText)
	self.RightText:SetTextToFit(data.rightText)
end

ArcaneWizardLibrary_SettingsExpandMixin = CreateFromMixins(SettingsExpandableSectionMixin)

function ArcaneWizardLibrary_SettingsExpandMixin:Init(initializer)
	SettingsExpandableSectionMixin.Init(self, initializer)
	self.data = initializer.data
end

function ArcaneWizardLibrary_SettingsExpandMixin:CalculateHeight()
	return 30
end

function ArcaneWizardLibrary_SettingsExpandMixin:OnExpandedChanged(expanded)
	if self.data then
		self.data.expanded = expanded
	end

	self:EvaluateVisibility(expanded)
	SettingsInbound.RepairDisplay()
end

function ArcaneWizardLibrary_SettingsExpandMixin:EvaluateVisibility(expanded)
	if expanded then
		self.Button.Right:SetAtlas("Options_ListExpand_Right_Expanded", TextureKitConstants.UseAtlasSize)
	else
		self.Button.Right:SetAtlas("Options_ListExpand_Right", TextureKitConstants.UseAtlasSize)
	end
end
