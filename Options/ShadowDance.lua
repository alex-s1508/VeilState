local addonName, ns = ...

function ns.InitShadowDancePanel(category)
    local panel = CreateFrame("Frame", "VS_ShadowDancePanel")
    local content = ns.CreateScrollPanel(panel)
    local ui = ns.CreateUI(content)

    ui:Header(ns.L.Settings)
    local rowY = ui:GetY()
    ui:Check("sdEnabled", ns.L.EnableOnShadowDance)
    local afterRowY = ui:GetY()
    ui:SetY(rowY)
    ui:Check("sdOnlyCombat", ns.L.OnlyInCombat or "Only in combat", 220)
    ui:Check("sdOnlyInstances", ns.L.OnlyInInstances or "Only in instances", 440)
    ui:SetY(afterRowY)
    ui:Space(10)
    ns.AppearanceBlock(ui, "sd")
    Settings.RegisterCanvasLayoutSubcategory(category, panel, ns.L.ShadowDance)
end
