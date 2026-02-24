local addonName, ns = ...

local function K(prefix, key)
    if prefix == "" then return key end
    return prefix .. key:sub(1,1):upper() .. key:sub(2)
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

local function HookCheckRefresh(checkbox, fn)
    if not checkbox or not fn then return end
    local orig = checkbox:GetScript("OnClick")
    checkbox:SetScript("OnClick", function(self, button)
        if orig then orig(self, button) end
        fn()
    end)
end

local function AppearanceBlock(ui, prefix)
    local layers = {
        {text="BACKGROUND", value="BACKGROUND"},
        {text="LOW",        value="LOW"},
        {text="MEDIUM",     value="MEDIUM"},
        {text="HIGH",       value="HIGH"},
        {text="DIALOG",     value="DIALOG"},
        {text="FULLSCREEN", value="FULLSCREEN"},
    }
    local modes = {
        {text="Circle",                  value=1},
        {text="Outline",                 value=2},
        {text="Icon",                    value=3},
        {text="Circle + Outline",        value=4},
        {text="Circle + Icon",           value=5},
        {text="Outline + Icon",          value=6},
        {text="Circle + Outline + Icon", value=7},
    }
    local anchors = {
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
    local animations = {
        {text = ns.L.AnimationNone, value = "NONE"},
        {text = ns.L.AnimationBlink, value = "BLINK"},
        {text = ns.L.AnimationFade, value = "FADE"},
        {text = ns.L.AnimationShake, value = "SHAKE"},
    }

    ui:Header(ns.L.FloatingText)
    local textEnable = ui:Check(K(prefix, "enableText"), ns.L.Enable)
    local textControls = {}
    local r1 = ui:GetY()
    local fallbackTXT = prefix == "" and ns.L.DefaultMessage or ns.L.ShadowDanceMessage
    table.insert(textControls, ui:Edit(ns.L.CustomText, K(prefix, "customText"), 0, true, fallbackTXT))
    table.insert(textControls, ui:Color(K(prefix, "textColor"), ns.L.Color, 220, false))
    ui:SetY(r1 - 60)
    local r2 = ui:GetY()
    table.insert(textControls, ui:Slider(K(prefix, "textSize"),  ns.L.Size,    10,   100,  1,    0,  true))
    table.insert(textControls, ui:Slider(K(prefix, "textAlpha"), ns.L.Opacity, 0,    1,    0.05, 220, false))
    ui:SetY(r2 - 60)
    local r3 = ui:GetY()
    table.insert(textControls, ui:Slider(K(prefix, "textX"), ns.L.OffsetX, -500, 500, 1, 0,   true))
    table.insert(textControls, ui:Slider(K(prefix, "textY"), ns.L.OffsetY, -500, 500, 1, 220, false))
    ui:SetY(r3 - 60)
    local r4 = ui:GetY()
    table.insert(textControls, ui:Dropdown(ns.L.Animation, K(prefix, "textAnim"), animations, 0, true))
    table.insert(textControls, ui:Slider(K(prefix, "textAnimSpeed"), ns.L.AnimationSpeed, 0.2, 3, 0.1, 220, false))
    ui:SetY(r4 - 60)

    ui:Space(20)
    ui:Header(ns.L.IndicatorIcon)
    local iconEnable = ui:Check(K(prefix, "enableIcon"), ns.L.Enable)
    local iconControls = {}
    local iconAnchorControls = {}
    table.insert(iconAnchorControls, ui:Check(K(prefix, "iconAnchorToText"), ns.L.AnchorToText))
    table.insert(iconAnchorControls, ui:Dropdown(ns.L.AnchorPoint, K(prefix, "iconAnchorPoint"), anchors))
    for _, c in ipairs(iconAnchorControls) do table.insert(iconControls, c) end
    local i1 = ui:GetY()
    table.insert(iconControls, ui:Slider(K(prefix, "iconSize"),  ns.L.Size,    16,   300,  1,    0,   true))
    table.insert(iconControls, ui:Slider(K(prefix, "iconAlpha"), ns.L.Opacity, 0,    1,    0.05, 220, true))
    ui:SetY(i1 - 50)
    local i2 = ui:GetY()
    table.insert(iconControls, ui:Slider(K(prefix, "iconX"), ns.L.OffsetX, -500, 500, 1, 0,   true))
    table.insert(iconControls, ui:Slider(K(prefix, "iconY"), ns.L.OffsetY, -500, 500, 1, 220, true))
    ui:SetY(i2 - 50)

    ui:Space(20)
    ui:Header(ns.L.ScreenColor)
    local screenEnable = ui:Check(K(prefix, "enableScreenColor"), ns.L.Enable)
    local screenControls = {}
    table.insert(screenControls, ui:Color(K(prefix, "screenColor"),  ns.L.Color))
    table.insert(screenControls, ui:Slider(K(prefix, "screenAlpha"), ns.L.Opacity, 0, 0.8, 0.01))
    table.insert(screenControls, ui:Dropdown(ns.L.Layer, K(prefix, "screenStrata"), layers))

    ui:Space(20)
    ui:Header(ns.L.Vignette)
    local vignetteEnable = ui:Check(K(prefix, "enableVignette"), ns.L.Enable)
    local vignetteControls = {}
    local v1 = ui:GetY()
    table.insert(vignetteControls, ui:Slider(K(prefix, "vignetteSize"),  ns.L.Thickness, 50,  600,  1,    0,   true))
    table.insert(vignetteControls, ui:Slider(K(prefix, "vignetteAlpha"), ns.L.Opacity,   0,   1,    0.05, 220, true))
    ui:SetY(v1 - 50)
    table.insert(vignetteControls, ui:Dropdown(ns.L.Layer, K(prefix, "vignetteStrata"), layers))

    ui:Space(20)
    ui:Header(ns.L.Highlight)
    local highlightEnable = ui:Check(K(prefix, "enableHighlight"), ns.L.Enable)
    local highlightControls = {}
    table.insert(highlightControls, ui:Dropdown(ns.L.Style, K(prefix, "highlightType"), modes))

    local function RefreshEnabled()
        local db = ns.db or {}
        local textOn = db[K(prefix, "enableText")] ~= false
        local iconOn = db[K(prefix, "enableIcon")] ~= false
        for _, c in ipairs(textControls) do SetControlEnabled(c, textOn) end
        for _, c in ipairs(iconControls) do SetControlEnabled(c, iconOn) end
        for _, c in ipairs(iconAnchorControls) do SetControlEnabled(c, iconOn and textOn) end

        local screenOn = db[K(prefix, "enableScreenColor")] ~= false
        for _, c in ipairs(screenControls) do SetControlEnabled(c, screenOn) end

        local vignetteOn = db[K(prefix, "enableVignette")] ~= false
        for _, c in ipairs(vignetteControls) do SetControlEnabled(c, vignetteOn) end

        local highlightOn = db[K(prefix, "enableHighlight")] ~= false
        for _, c in ipairs(highlightControls) do SetControlEnabled(c, highlightOn) end
    end

    HookCheckRefresh(textEnable, RefreshEnabled)
    HookCheckRefresh(iconEnable, RefreshEnabled)
    HookCheckRefresh(screenEnable, RefreshEnabled)
    HookCheckRefresh(vignetteEnable, RefreshEnabled)
    HookCheckRefresh(highlightEnable, RefreshEnabled)
    RefreshEnabled()
end

ns.AppearanceBlock = AppearanceBlock

function ns.InitStealthPanel(category)
    local panel = CreateFrame("Frame", "VS_StealthPanel")
    local content = ns.CreateScrollPanel(panel)
    local ui = ns.CreateUI(content)

    ui:Header(ns.L.Settings)
    local rowY = ui:GetY()
    ui:Check("stealthEnabled", ns.L.EnableOnStealth)
    local afterRowY = ui:GetY()
    ui:SetY(rowY)
    ui:Check("stealthOnlyInstances", ns.L.OnlyInInstances or "Only in instances", 220)
    ui:SetY(afterRowY)
    ui:Space(10)
    AppearanceBlock(ui, "")
    Settings.RegisterCanvasLayoutSubcategory(category, panel, ns.L.Stealth)
end
