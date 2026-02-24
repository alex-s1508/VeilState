local addonName, ns = ...

local function K(prefix, key)
    return prefix .. key:sub(1, 1):upper() .. key:sub(2)
end

local function GetAnchorOptions()
    return {
        {text = ns.L.TopLeft, value = "TOPLEFT"},
        {text = ns.L.Top, value = "TOP"},
        {text = ns.L.TopRight, value = "TOPRIGHT"},
        {text = ns.L.Left, value = "LEFT"},
        {text = ns.L.Center, value = "CENTER"},
        {text = ns.L.Right, value = "RIGHT"},
        {text = ns.L.BottomLeft, value = "BOTTOMLEFT"},
        {text = ns.L.Bottom, value = "BOTTOM"},
        {text = ns.L.BottomRight, value = "BOTTOMRIGHT"},
    }
end

local function GetAnimationOptions()
    return {
        {text = ns.L.AnimationNone, value = "NONE"},
        {text = ns.L.AnimationBlink, value = "BLINK"},
        {text = ns.L.AnimationFade, value = "FADE"},
        {text = ns.L.AnimationShake, value = "SHAKE"},
    }
end

local function PlayConfiguredSound(soundKitId)
    if not PlaySound then return end
    if type(soundKitId) ~= "number" then return end
    PlaySound(soundKitId, "Master")
end

local function SetControlEnabled(control, enabled)
    if not control then return end
    if control.SetEnabled then
        control:SetEnabled(enabled)
    elseif enabled and control.Enable then
        control:Enable()
    elseif not enabled and control.Disable then
        control:Disable()
    end

    if UIDropDownMenu_EnableDropDown and UIDropDownMenu_DisableDropDown then
        if control.GetObjectType and control:GetObjectType() == "Frame" and control.initialize then
            if enabled then
                UIDropDownMenu_EnableDropDown(control)
            else
                UIDropDownMenu_DisableDropDown(control)
            end
        end
    end
end

local function Add(list, control)
    if not list then return end
    if control then table.insert(list, control) end
end

local function HookCheckRefresh(checkbox, fn)
    if not checkbox or not fn then return end
    local orig = checkbox:GetScript("OnClick")
    checkbox:SetScript("OnClick", function(self, button)
        if orig then orig(self, button) end
        fn()
    end)
end

local function PoisonBlock(ui, prefix, controls)
    local testKey = K(prefix, "soundKit")
    local short = prefix == "poisonLethal" and (ns.L.LethalShort or "Lethal") or (ns.L.NonLethalShort or "Non-Lethal")

    ui:Header(short .. " - " .. (ns.L.FloatingText or "Floating Text"))
    local textEnable = ui:Check(K(prefix, "enableText"), ns.L.Enable)
    Add(controls, textEnable)
    local textControls = {}
    local r1 = ui:GetY()
    local fallbackTXT = prefix == "poisonLethal" and ns.L.LethalPoisonMissing or ns.L.NonLethalPoisonMissing
    Add(textControls, ui:Edit(ns.L.CustomText, K(prefix, "customText"), 0, true, fallbackTXT))
    Add(textControls, ui:Color(K(prefix, "textColor"), ns.L.Color, 220, false))
    ui:SetY(r1 - 60)
    local r2 = ui:GetY()
    Add(textControls, ui:Slider(K(prefix, "textSize"), ns.L.Size, 10, 100, 1, 0, true))
    Add(textControls, ui:Slider(K(prefix, "textAlpha"), ns.L.Opacity, 0, 1, 0.05, 220, false))
    ui:SetY(r2 - 60)
    local r3 = ui:GetY()
    Add(textControls, ui:Slider(K(prefix, "textX"), ns.L.OffsetX, -500, 500, 1, 0, true))
    Add(textControls, ui:Slider(K(prefix, "textY"), ns.L.OffsetY, -500, 500, 1, 220, false))
    ui:SetY(r3 - 60)
    local r4 = ui:GetY()
    Add(textControls, ui:Dropdown(ns.L.Animation, K(prefix, "textAnim"), GetAnimationOptions(), 0, true))
    Add(textControls, ui:Slider(K(prefix, "textAnimSpeed"), ns.L.AnimationSpeed, 0.2, 3, 0.1, 220, false))
    ui:SetY(r4 - 60)
    for _, c in ipairs(textControls) do Add(controls, c) end

    ui:Space(20)
    ui:Header(short .. " - " .. (ns.L.IndicatorIcon or "Indicator Icon"))
    local iconEnable = ui:Check(K(prefix, "enableIcon"), ns.L.Enable)
    Add(controls, iconEnable)
    local iconControls = {}
    local iconAnchorControls = {}
    Add(iconAnchorControls, ui:Check(K(prefix, "iconAnchorToText"), ns.L.AnchorToText))
    Add(iconAnchorControls, ui:Dropdown(ns.L.AnchorPoint, K(prefix, "iconAnchorPoint"), GetAnchorOptions()))
    for _, c in ipairs(iconAnchorControls) do Add(iconControls, c) end
    local i1 = ui:GetY()
    Add(iconControls, ui:Slider(K(prefix, "iconSize"), ns.L.Size, 16, 150, 1, 0, true))
    Add(iconControls, ui:Slider(K(prefix, "iconAlpha"), ns.L.Opacity, 0, 1, 0.05, 220, false))
    ui:SetY(i1 - 60)
    local i2 = ui:GetY()
    Add(iconControls, ui:Slider(K(prefix, "iconX"), ns.L.OffsetX, -500, 500, 1, 0, true))
    Add(iconControls, ui:Slider(K(prefix, "iconY"), ns.L.OffsetY, -500, 500, 1, 220, false))
    ui:SetY(i2 - 60)
    for _, c in ipairs(iconControls) do Add(controls, c) end

    ui:Space(20)
    ui:Header(short .. " - " .. (ns.L.Sound or "Sound"))
    local soundEnable = ui:Check(K(prefix, "enableSound"), ns.L.Enable)
    Add(controls, soundEnable)
    local soundControls = {}
    Add(soundControls, ui:Button(ns.L.TestSound, function()
        PlayConfiguredSound(ns.db[testKey])
    end))
    for _, c in ipairs(soundControls) do Add(controls, c) end

    local function RefreshSubEnabled()
        local db = ns.db or {}
        local onText = db[K(prefix, "enableText")] ~= false
        local onIcon = db[K(prefix, "enableIcon")] ~= false
        local onSound = db[K(prefix, "enableSound")] ~= false
        for _, c in ipairs(textControls) do SetControlEnabled(c, onText) end
        for _, c in ipairs(iconControls) do SetControlEnabled(c, onIcon) end
        for _, c in ipairs(iconAnchorControls) do SetControlEnabled(c, onIcon and onText) end
        for _, c in ipairs(soundControls) do SetControlEnabled(c, onSound) end
    end

    HookCheckRefresh(textEnable, RefreshSubEnabled)
    HookCheckRefresh(iconEnable, RefreshSubEnabled)
    HookCheckRefresh(soundEnable, RefreshSubEnabled)
    RefreshSubEnabled()
end

function ns.InitPoisonTrackerPanel(category)
    local panel = CreateFrame("Frame", "VS_PoisonTrackerPanel")
    local content = ns.CreateScrollPanel(panel)
    local ui = ns.CreateUI(content)

    ui:Header(ns.L.Settings)
    local rowY = ui:GetY()
    local trackerCheck = ui:Check("poisonTrackerEnabled", ns.L.EnablePoisonTracker)
    local afterRowY = ui:GetY()
    ui:SetY(rowY)
    local onlyCombatCheck = ui:Check("poisonOnlyCombat", ns.L.OnlyInCombat or "Only in combat", 220)
    local onlyInstancesCheck = ui:Check("poisonOnlyInstances", ns.L.OnlyInInstances or "Only in instances", 440)
    ui:SetY(afterRowY)
    ui:Space(14)

    ui:Header(ns.L.LethalPoisons)
    local lethalCheck = ui:Check("poisonLethalEnabled", ns.L.Enable)
    ui:Space(10)
    local lethalControls = {}
    PoisonBlock(ui, "poisonLethal", lethalControls)

    ui:Space(20)
    ui:Header(ns.L.NonLethalPoisons)
    local nonLethalCheck = ui:Check("poisonNonLethalEnabled", ns.L.Enable)
    ui:Space(10)
    local nonLethalControls = {}
    PoisonBlock(ui, "poisonNonLethal", nonLethalControls)

    local function RefreshEnabled()
        local db = ns.db or {}
        local trackerOn = db.poisonTrackerEnabled ~= false
        local lethalOn = trackerOn and db.poisonLethalEnabled ~= false
        local nonLethalOn = trackerOn and db.poisonNonLethalEnabled ~= false
        for _, c in ipairs(lethalControls) do SetControlEnabled(c, lethalOn) end
        for _, c in ipairs(nonLethalControls) do SetControlEnabled(c, nonLethalOn) end
        SetControlEnabled(onlyCombatCheck, trackerOn)
        SetControlEnabled(onlyInstancesCheck, trackerOn)
        SetControlEnabled(lethalCheck, trackerOn)
        SetControlEnabled(nonLethalCheck, trackerOn)
    end

    HookCheckRefresh(trackerCheck, RefreshEnabled)
    HookCheckRefresh(lethalCheck, RefreshEnabled)
    HookCheckRefresh(nonLethalCheck, RefreshEnabled)
    RefreshEnabled()

    Settings.RegisterCanvasLayoutSubcategory(category, panel, ns.L.PoisonTracker)
end
