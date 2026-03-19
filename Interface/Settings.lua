local addonName, ns = ...
local SettingsLib = LibStub("LibEQOLSettingsMode-1.0")

SettingsLib:SetVariablePrefix("Nightveil_")

-- [[ UI Helper Functions ]] --------------------------------------------------
local function G(key, default)
    local v = ns.db and ns.db[key]
    if v == nil then return default end
    return v
end

local function GetColor(key, dr, dg, db)
    local c = ns.db and ns.db[key]
    if not c then return dr or 0.64, dg or 0.38, db or 0.89 end
    return (c.r or dr or 0.64), (c.g or dg or 0.38), (c.b or db or 0.89)
end

-- [[ UI Enumerations & Data Tables ]] ---------------------------------------
local LAYERS = {
    { value = "BACKGROUND", label = (ns.L and ns.L.LayerBackground) or "Background" },
    { value = "LOW",        label = (ns.L and ns.L.LayerLow) or "Low" },
    { value = "MEDIUM",     label = (ns.L and ns.L.LayerMedium) or "Medium" },
    { value = "HIGH",       label = (ns.L and ns.L.LayerHigh) or "High" },
    { value = "DIALOG",     label = (ns.L and ns.L.LayerDialog) or "Dialog" },
    { value = "FULLSCREEN", label = (ns.L and ns.L.LayerFullscreen) or "Fullscreen" },
}
local LAYER_ORDER = { "BACKGROUND", "LOW", "MEDIUM", "HIGH", "DIALOG", "FULLSCREEN" }

local LAYER_MAP = {}
for _, e in ipairs(LAYERS) do LAYER_MAP[e.value] = e.label end

local HL_MODES = {
    [1] = (ns.L and ns.L.HighlightCircle) or "Circle",
    [2] = (ns.L and ns.L.HighlightOutline) or "Outline",
    [3] = (ns.L and ns.L.HighlightIcon) or "Icon",
    [4] = (ns.L and ns.L.HighlightCircleOutline) or "Circle + Outline",
    [5] = (ns.L and ns.L.HighlightCircleIcon) or "Circle + Icon",
    [6] = (ns.L and ns.L.HighlightOutlineIcon) or "Outline + Icon",
    [7] = (ns.L and ns.L.HighlightCircleOutlineIcon) or "Circle + Outline + Icon",
}
local HL_ORDER = { 1, 2, 3, 4, 5, 6, 7 }

local ANIM_MAP = {
    ["NONE"]  = (ns.L and ns.L.AnimNone)  or "None",
    ["BLINK"] = (ns.L and ns.L.AnimBlink) or "Blink",
    ["FADE"]  = (ns.L and ns.L.AnimFade)  or "Fade",
    ["SHAKE"] = (ns.L and ns.L.AnimShake) or "Shake",
}
local ANIM_ORDER = { "NONE", "BLINK", "FADE", "SHAKE" }

local ANCHOR_ORDER = { "TOPLEFT","TOP","TOPRIGHT","LEFT","CENTER","RIGHT","BOTTOMLEFT","BOTTOM","BOTTOMRIGHT" }

local ANCHOR_MAP = {
    TOPLEFT     = (ns.L and ns.L.AnchorTopLeft) or "Top Left",
    TOP         = (ns.L and ns.L.AnchorTop) or "Top",
    TOPRIGHT    = (ns.L and ns.L.AnchorTopRight) or "Top Right",
    LEFT        = (ns.L and ns.L.AnchorLeft) or "Left",
    CENTER      = (ns.L and ns.L.AnchorCenter) or "Center",
    RIGHT       = (ns.L and ns.L.AnchorRight) or "Right",
    BOTTOMLEFT  = (ns.L and ns.L.AnchorBottomLeft) or "Bottom Left",
    BOTTOM      = (ns.L and ns.L.AnchorBottom) or "Bottom",
    BOTTOMRIGHT = (ns.L and ns.L.AnchorBottomRight) or "Bottom Right",
}

local CHANNELS = {
    ["NONE"]          = (ns.L and ns.L.AnimNone) or "None",
    ["SAY"]           = (ns.L and ns.L.ChannelSay) or "Say",
    ["YELL"]          = (ns.L and ns.L.ChannelYell) or "Yell",
    ["PARTY"]         = (ns.L and ns.L.ChannelParty) or "Party",
    ["RAID"]          = (ns.L and ns.L.ChannelRaid) or "Raid",
    ["INSTANCE_CHAT"] = (ns.L and ns.L.ChannelInstance) or "Instance",
}
local CHANNEL_ORDER = { "NONE", "SAY", "YELL", "PARTY", "RAID", "INSTANCE_CHAT" }

local TRICKS_LOGIC_OPTIONS = {
    ["TANK"]         = ns.L and ns.L.Tank or "Tank",
    ["NORMAL"]       = ns.L and ns.L.TricksNormal or "Normal",
    ["TARGETTARGET"] = ns.L and ns.L.TargetTarget or "Target of Target",
    ["CUSTOM"]       = ns.L and ns.L.TricksCustom or "Custom",
}
local TRICKS_LOGIC_ORDER = { "NORMAL", "TANK", "TARGETTARGET", "CUSTOM" }

-- [[ Changelog Builder Utilities ]] -----------------------------------------
local function BuildChangelog(cat)
    local notes = ns.ReleaseNotes and ns.ReleaseNotes.notes or {}

    local function parse(v)
        v = tostring(v or ""):gsub("^v", "")
        local num, suffix = v:match("([%d%.]+)(%a*)")
        local parts = {}
        if num then
            for part in num:gmatch("%d+") do parts[#parts + 1] = tonumber(part) or 0 end
        end
        return parts, suffix or ""
    end

    local function newer(a, b)
        local pa, sa = parse(a); local pb, sb = parse(b)
        local maxlen = math.max(#pa, #pb)
        for i = 1, maxlen do
            local na, nb = pa[i] or 0, pb[i] or 0
            if na ~= nb then return na > nb end
        end
        return tostring(a) > tostring(b)
    end

    local versions = {}
    for v in pairs(notes) do table.insert(versions, v) end
    table.sort(versions, newer)

    if #versions == 0 then return end

    SettingsLib:CreateHeader(cat, { name = "|cffffffff" .. (ns.L.ReleaseNotes or "Release Notes") .. "|r" })
    local maxVersions = math.min(#versions, 20)

    for i = 1, maxVersions do
        local v = versions[i]
        SettingsLib:CreateHeader(cat, { name = "|cffFFD700" .. tostring(v) .. "|r" })
        local entries = notes[v] or {}
        for _, entry in ipairs(entries) do
            local line = tostring(entry):gsub("^%s*[•%-–—]+%s*", "")
            SettingsLib:CreateText(cat, { name = "  • " .. line, height = 12, offsetY = -4, basePadding = 0 })
        end
    end
end

-- [[ Stealth Settings Tab Construction ]] ------------------------------------
function ns.AddStealthSettings(cat, prefix)
    local function K(key) return prefix .. key:sub(1,1):upper() .. key:sub(2) end
    local function DefaultFor(key, fallback)
        local v = ns.Defaults and ns.Defaults[key]
        return v ~= nil and v or fallback
    end

    SettingsLib:CreateHeader(cat, { name = ns.L.Customization or "Customization" })
    local textSection = SettingsLib:CreateExpandableSection(cat, { name = ns.L.FloatingText or "Floating Text", expanded = false })
    SettingsLib:CreateCheckbox(cat, {
        key = K("enableText"), name = ns.L.Enable or "Enable",
        default = DefaultFor(K("enableText"), true),
        get = function() return G(K("enableText"), DefaultFor(K("enableText"), true)) end,
        set = function(v) ns.db[K("enableText")] = v; ns.UpdateState(true) end,
        parentSection = textSection,
        desc = ns.L.EnableDesc,
    })
    SettingsLib:CreateInput(cat, {
        key = K("customText"), name = ns.L.CustomText or "Custom Text",
        default = DefaultFor(K("customText"), ""),
        get = function() return G(K("customText"), DefaultFor(K("customText"), "")) end,
        set = function(v) ns.db[K("customText")] = v; ns.UpdateState(true) end,
        parentSection = textSection,
        desc = ns.L.CustomTextDesc,
    })
    SettingsLib:CreateColorOverrides(cat, {
        entries = { { key = K("textColor"), label = ns.L.Color or "Color" } },
        getColor = function(key) local def = ns.Defaults[key] or { r = 0.64, g = 0.38, b = 0.89 }; return GetColor(key, def.r, def.g, def.b) end,
        getDefaultColor = function(key) local def = ns.Defaults[key] or { r = 0.64, g = 0.38, b = 0.89 }; return def.r, def.g, def.b end,
        setColor = function(key, r, g, b) ns.db[key] = { r = r, g = g, b = b }; ns.RefreshVisuals(true) end,
        parentSection = textSection,
        desc = ns.L.ColorDesc,
    })
    SettingsLib:CreateSlider(cat, {
        key = K("textAlpha"), name = ns.L.Opacity or "Opacity", min = 0, max = 1, step = 0.05,
        default = DefaultFor(K("textAlpha"), 1),
        get = function() return G(K("textAlpha"), DefaultFor(K("textAlpha"), 1)) end,
        set = function(v) ns.db[K("textAlpha")] = v; ns.UpdateState(true) end,
        parentSection = textSection,
        desc = ns.L.OpacityDesc,
    })
    SettingsLib:CreateSlider(cat, {
        key = K("textX"), name = ns.L.OffsetX or "Offset X", min = -1200, max = 1200, step = 1,
        default = DefaultFor(K("textX"), 0),
        get = function() return G(K("textX"), DefaultFor(K("textX"), 0)) end,
        set = function(v) ns.db[K("textX")] = v; ns.UpdateState(true) end,
        parentSection = textSection,
        desc = ns.L.OffsetXDesc,
    })
    SettingsLib:CreateSlider(cat, {
        key = K("textY"), name = ns.L.OffsetY or "Offset Y", min = -600, max = 600, step = 1,
        default = DefaultFor(K("textY"), 185),
        get = function() return G(K("textY"), DefaultFor(K("textY"), 185)) end,
        set = function(v) ns.db[K("textY")] = v; ns.UpdateState(true) end,
        parentSection = textSection,
        desc = ns.L.OffsetYDesc,
    })
    SettingsLib:CreateSlider(cat, {
        key = K("textSize"), name = ns.L.Size or "Size", min = 10, max = 100, step = 1,
        default = DefaultFor(K("textSize"), 32),
        get = function() return G(K("textSize"), DefaultFor(K("textSize"), 32)) end,
        set = function(v) ns.db[K("textSize")] = v; ns.UpdateState(true) end,
        parentSection = textSection,
        desc = ns.L.SizeDesc,
    })
    SettingsLib:CreateDropdown(cat, {
        key = K("textAnim"), name = ns.L.Animation or "Animation", values = ANIM_MAP, order = ANIM_ORDER,
        default = DefaultFor(K("textAnim"), "NONE"),
        get = function() return G(K("textAnim"), DefaultFor(K("textAnim"), "NONE")) end,
        set = function(v) ns.db[K("textAnim")] = v; ns.UpdateState(true) end,
        parentSection = textSection,
        desc = ns.L.AnimationDesc,
    })
    SettingsLib:CreateSlider(cat, {
        key = K("textAnimSpeed"), name = ns.L.AnimationSpeed or "Speed", min = 0.2, max = 3, step = 0.1,
        default = DefaultFor(K("textAnimSpeed"), 1),
        get = function() return G(K("textAnimSpeed"), DefaultFor(K("textAnimSpeed"), 1)) end,
        set = function(v) ns.db[K("textAnimSpeed")] = v; ns.UpdateState(true) end,
        parentSection = textSection,
        desc = ns.L.AnimationSpeedDesc,
    })

    local iconSection = SettingsLib:CreateExpandableSection(cat, { name = ns.L.IndicatorIcon or "Indicator Icon", expanded = false })
    SettingsLib:CreateCheckbox(cat, {
        key = K("enableIcon"), name = ns.L.Enable or "Enable",
        default = DefaultFor(K("enableIcon"), true),
        get = function() return G(K("enableIcon"), DefaultFor(K("enableIcon"), true)) end,
        set = function(v) ns.db[K("enableIcon")] = v; ns.UpdateState(true) end,
        parentSection = iconSection,
        desc = ns.L.EnableIconDesc or ns.L.EnableDesc,
    })
    SettingsLib:CreateSlider(cat, {
        key = K("iconX"), name = ns.L.OffsetX or "Offset X", min = -1200, max = 1200, step = 1,
        default = DefaultFor(K("iconX"), 0),
        get = function() return G(K("iconX"), DefaultFor(K("iconX"), 0)) end,
        set = function(v) ns.db[K("iconX")] = v; ns.UpdateState(true) end,
        parentSection = iconSection,
        desc = ns.L.OffsetXDesc,
    })
    SettingsLib:CreateSlider(cat, {
        key = K("iconY"), name = ns.L.OffsetY or "Offset Y", min = -600, max = 600, step = 1,
        default = DefaultFor(K("iconY"), 0),
        get = function() return G(K("iconY"), DefaultFor(K("iconY"), 0)) end,
        set = function(v) ns.db[K("iconY")] = v; ns.UpdateState(true) end,
        parentSection = iconSection,
        desc = ns.L.OffsetYDesc,
    })
    SettingsLib:CreateSlider(cat, {
        key = K("iconSize"), name = ns.L.Size or "Size", min = 16, max = 150, step = 1,
        default = DefaultFor(K("iconSize"), 64),
        get = function() return G(K("iconSize"), DefaultFor(K("iconSize"), 64)) end,
        set = function(v) ns.db[K("iconSize")] = v; ns.UpdateState(true) end,
        parentSection = iconSection,
        desc = ns.L.SizeDesc,
    })
    SettingsLib:CreateSlider(cat, {
        key = K("iconAlpha"), name = ns.L.Opacity or "Opacity", min = 0, max = 1, step = 0.05,
        default = DefaultFor(K("iconAlpha"), 1),
        get = function() return G(K("iconAlpha"), DefaultFor(K("iconAlpha"), 1)) end,
        set = function(v) ns.db[K("iconAlpha")] = v; ns.UpdateState(true) end,
        parentSection = iconSection,
        desc = ns.L.OpacityDesc,
    })
    SettingsLib:CreateCheckbox(cat, {
        key = K("iconAnchorToText"), name = ns.L.AnchorToText or "Anchor to Text",
        default = DefaultFor(K("iconAnchorToText"), true),
        get = function() return G(K("iconAnchorToText"), DefaultFor(K("iconAnchorToText"), true)) end,
        set = function(v) ns.db[K("iconAnchorToText")] = v; ns.UpdateState(true) end,
        parentSection = iconSection,
        desc = ns.L.AnchorToTextDesc,
    })
    SettingsLib:CreateDropdown(cat, {
        key = K("iconAnchorPoint"), name = ns.L.AnchorPoint or "Anchor Point", values = ANCHOR_MAP, order = ANCHOR_ORDER,
        default = DefaultFor(K("iconAnchorPoint"), "LEFT"),
        get = function() return G(K("iconAnchorPoint"), DefaultFor(K("iconAnchorPoint"), "LEFT")) end,
        set = function(v) ns.db[K("iconAnchorPoint")] = v; ns.UpdateState(true) end,
        parentSection = iconSection,
        desc = ns.L.AnchorPointDesc,
    })

    local screenSection = SettingsLib:CreateExpandableSection(cat, { name = ns.L.ScreenColor or "Screen Color", expanded = false })
    SettingsLib:CreateCheckbox(cat, {
        key = K("enableScreenColor"), name = ns.L.Enable or "Enable",
        default = DefaultFor(K("enableScreenColor"), true),
        get = function() return G(K("enableScreenColor"), DefaultFor(K("enableScreenColor"), true)) end,
        set = function(v) ns.db[K("enableScreenColor")] = v; ns.UpdateState(true) end,
        parentSection = screenSection,
        desc = ns.L.ScreenColorDesc or ns.L.EnableDesc,
    })
    SettingsLib:CreateColorOverrides(cat, {
        entries = { { key = K("screenColor"), label = ns.L.Color or "Color" } },
        getColor = function(key) local def = ns.Defaults[key] or { r = 0.64, g = 0.38, b = 0.89 }; return GetColor(key, def.r, def.g, def.b) end,
        getDefaultColor = function(key) local def = ns.Defaults[key] or { r = 0.64, g = 0.38, b = 0.89 }; return def.r, def.g, def.b end,
        setColor = function(key, r, g, b) ns.db[key] = { r = r, g = g, b = b }; ns.RefreshVisuals(true) end,
        parentSection = screenSection,
        desc = ns.L.ColorDesc,
    })
    SettingsLib:CreateSlider(cat, {
        key = K("screenAlpha"), name = ns.L.Opacity or "Opacity", min = 0, max = 0.8, step = 0.01,
        default = DefaultFor(K("screenAlpha"), 0.1),
        get = function() return G(K("screenAlpha"), DefaultFor(K("screenAlpha"), 0.1)) end,
        set = function(v) ns.db[K("screenAlpha")] = v; ns.UpdateState(true) end,
        parentSection = screenSection,
        desc = ns.L.OpacityDesc,
    })
    SettingsLib:CreateDropdown(cat, {
        key = K("screenStrata"), name = ns.L.Layer or "Layer", values = LAYER_MAP, order = LAYER_ORDER,
        default = DefaultFor(K("screenStrata"), "BACKGROUND"),
        get = function() return G(K("screenStrata"), DefaultFor(K("screenStrata"), "BACKGROUND")) end,
        set = function(v) ns.db[K("screenStrata")] = v; ns.UpdateState(true) end,
        parentSection = screenSection,
        desc = ns.L.LayerDesc,
    })

    local vigSection = SettingsLib:CreateExpandableSection(cat, { name = ns.L.Vignette or "Vignette", expanded = false })
    SettingsLib:CreateCheckbox(cat, {
        key = K("enableVignette"), name = ns.L.Enable or "Enable",
        default = DefaultFor(K("enableVignette"), true),
        get = function() return G(K("enableVignette"), DefaultFor(K("enableVignette"), true)) end,
        set = function(v) ns.db[K("enableVignette")] = v; ns.UpdateState(true) end,
        parentSection = vigSection,
        desc = ns.L.VignetteDesc or ns.L.EnableDesc,
    })
    SettingsLib:CreateSlider(cat, {
        key = K("vignetteSize"), name = ns.L.Thickness or "Thickness", min = 50, max = 600, step = 1,
        default = DefaultFor(K("vignetteSize"), 250),
        get = function() return G(K("vignetteSize"), DefaultFor(K("vignetteSize"), 250)) end,
        set = function(v) ns.db[K("vignetteSize")] = v; ns.UpdateState(true) end,
        parentSection = vigSection,
        desc = ns.L.ThicknessDesc,
    })
    SettingsLib:CreateSlider(cat, {
        key = K("vignetteAlpha"), name = ns.L.Opacity or "Opacity", min = 0, max = 1, step = 0.05,
        default = DefaultFor(K("vignetteAlpha"), 0.6),
        get = function() return G(K("vignetteAlpha"), DefaultFor(K("vignetteAlpha"), 0.6)) end,
        set = function(v) ns.db[K("vignetteAlpha")] = v; ns.UpdateState(true) end,
        parentSection = vigSection,
        desc = ns.L.OpacityDesc,
    })
    SettingsLib:CreateDropdown(cat, {
        key = K("vignetteStrata"), name = ns.L.Layer or "Layer", values = LAYER_MAP, order = LAYER_ORDER,
        default = DefaultFor(K("vignetteStrata"), "BACKGROUND"),
        get = function() return G(K("vignetteStrata"), DefaultFor(K("vignetteStrata"), "BACKGROUND")) end,
        set = function(v) ns.db[K("vignetteStrata")] = v; ns.UpdateState(true) end,
        parentSection = vigSection,
        desc = ns.L.LayerDesc,
    })

    local hlSection = SettingsLib:CreateExpandableSection(cat, { name = ns.L.Highlight or "Highlight", expanded = false })
    SettingsLib:CreateCheckbox(cat, {
        key = K("enableHighlight"), name = ns.L.Enable or "Enable",
        default = DefaultFor(K("enableHighlight"), true),
        get = function() return G(K("enableHighlight"), DefaultFor(K("enableHighlight"), true)) end,
        set = function(v) ns.db[K("enableHighlight")] = v; ns.UpdateState(true) end,
        parentSection = hlSection,
        desc = ns.L.HighlightDesc or ns.L.EnableDesc,
    })
    SettingsLib:CreateDropdown(cat, {
        key = K("highlightType"), name = ns.L.Style or "Style", values = HL_MODES, order = HL_ORDER,
        default = DefaultFor(K("highlightType"), 2),
        get = function() return G(K("highlightType"), DefaultFor(K("highlightType"), 2)) end,
        set = function(v) ns.db[K("highlightType")] = v; ns.UpdateState(true) end,
        parentSection = hlSection,
        desc = ns.L.StyleDesc,
    })
end


-- [[ Poison Settings Tab Construction ]] -------------------------------------
function ns.AddPoisonSettings(cat, prefix, title)
    local function K(key) return prefix .. key:sub(1,1):upper() .. key:sub(2) end
    local function DefaultFor(key, fallback)
        local v = ns.Defaults and ns.Defaults[key]
        return v ~= nil and v or fallback
    end

    SettingsLib:CreateHeader(cat, { name = title })

    local textSection = SettingsLib:CreateExpandableSection(cat, { name = ns.L.FloatingText or "Floating Text", expanded = false })
    SettingsLib:CreateCheckbox(cat, {
        key = K("enableText"), name = ns.L.Enable or "Enable",
        default = DefaultFor(K("enableText"), true),
        get = function() return G(K("enableText"), DefaultFor(K("enableText"), true)) end,
        set = function(v) ns.db[K("enableText")] = v; ns.UpdateState(true) end,
        parentSection = textSection,
        desc = ns.L.EnableDesc,
    })
    SettingsLib:CreateInput(cat, {
        key = K("customText"), name = ns.L.CustomText or "Custom Text",
        default = DefaultFor(K("customText"), ""),
        get = function() return G(K("customText"), DefaultFor(K("customText"), "")) end,
        set = function(v) ns.db[K("customText")] = v; ns.UpdateState(true) end,
        parentSection = textSection,
        desc = ns.L.CustomTextDesc,
    })
    SettingsLib:CreateColorOverrides(cat, {
        entries = { { key = K("textColor"), label = ns.L.Color or "Color" } },
        getColor = function(key) local def = ns.Defaults[key] or { r = 1, g = 0.2, b = 0.2 }; return GetColor(key, def.r, def.g, def.b) end,
        getDefaultColor = function(key) local def = ns.Defaults[key] or { r = 1, g = 0.2, b = 0.2 }; return def.r, def.g, def.b end,
        setColor = function(key, r, g, b) ns.db[key] = { r = r, g = g, b = b }; if ns.RefreshPoisonVisuals then ns.RefreshPoisonVisuals(true) end end,
        parentSection = textSection,
        desc = ns.L.ColorDesc,
    })
    SettingsLib:CreateSlider(cat, {
        key = K("textSize"), name = ns.L.Size or "Size", min = 10, max = 100, step = 1,
        default = DefaultFor(K("textSize"), 28),
        get = function() return G(K("textSize"), DefaultFor(K("textSize"), 28)) end,
        set = function(v) ns.db[K("textSize")] = v; ns.UpdateState(true) end,
        parentSection = textSection,
        desc = ns.L.SizeDesc,
    })
    SettingsLib:CreateSlider(cat, {
        key = K("textAlpha"), name = ns.L.Opacity or "Opacity", min = 0, max = 1, step = 0.05,
        default = DefaultFor(K("textAlpha"), 1),
        get = function() return G(K("textAlpha"), DefaultFor(K("textAlpha"), 1)) end,
        set = function(v) ns.db[K("textAlpha")] = v; ns.UpdateState(true) end,
        parentSection = textSection,
        desc = ns.L.OpacityDesc,
    })
    SettingsLib:CreateSlider(cat, {
        key = K("textX"), name = ns.L.OffsetX or "Offset X", min = -1200, max = 1200, step = 1,
        default = DefaultFor(K("textX"), 0),
        get = function() return G(K("textX"), DefaultFor(K("textX"), 0)) end,
        set = function(v) ns.db[K("textX")] = v; ns.UpdateState(true) end,
        parentSection = textSection,
        desc = ns.L.OffsetXDesc,
    })
    SettingsLib:CreateSlider(cat, {
        key = K("textY"), name = ns.L.OffsetY or "Offset Y", min = -600, max = 600, step = 1,
        default = DefaultFor(K("textY"), 185),
        get = function() return G(K("textY"), DefaultFor(K("textY"), 185)) end,
        set = function(v) ns.db[K("textY")] = v; ns.UpdateState(true) end,
        parentSection = textSection,
        desc = ns.L.OffsetYDesc,
    })
    SettingsLib:CreateDropdown(cat, {
        key = K("textAnim"), name = ns.L.Animation or "Animation", values = ANIM_MAP, order = ANIM_ORDER,
        default = DefaultFor(K("textAnim"), "NONE"),
        get = function() return G(K("textAnim"), DefaultFor(K("textAnim"), "NONE")) end,
        set = function(v) ns.db[K("textAnim")] = v; ns.UpdateState(true) end,
        parentSection = textSection,
        desc = ns.L.AnimationDesc,
    })
    SettingsLib:CreateSlider(cat, {
        key = K("textAnimSpeed"), name = ns.L.AnimationSpeed or "Speed", min = 0.2, max = 3, step = 0.1,
        default = DefaultFor(K("textAnimSpeed"), 1),
        get = function() return G(K("textAnimSpeed"), DefaultFor(K("textAnimSpeed"), 1)) end,
        set = function(v) ns.db[K("textAnimSpeed")] = v; ns.UpdateState(true) end,
        parentSection = textSection,
        desc = ns.L.AnimationSpeedDesc,
    })

    local iconSection = SettingsLib:CreateExpandableSection(cat, { name = ns.L.IndicatorIcon or "Indicator Icon", expanded = false })
    SettingsLib:CreateCheckbox(cat, {
        key = K("enableIcon"), name = ns.L.Enable or "Enable",
        default = DefaultFor(K("enableIcon"), true),
        get = function() return G(K("enableIcon"), DefaultFor(K("enableIcon"), true)) end,
        set = function(v) ns.db[K("enableIcon")] = v; ns.UpdateState(true) end,
        parentSection = iconSection,
        desc = ns.L.EnableIconDesc or ns.L.EnableDesc,
    })
    SettingsLib:CreateInput(cat, {
        key = K("iconTexture"), name = ns.L.IconTexture or "Icon Texture",
        default = DefaultFor(K("iconTexture"), ""),
        get = function() return G(K("iconTexture"), DefaultFor(K("iconTexture"), "")) end,
        set = function(v) ns.db[K("iconTexture")] = v; ns.UpdateState(true) end,
        parentSection = iconSection,
        desc = ns.L.IconTextureDesc,
    })
    SettingsLib:CreateCheckbox(cat, {
        key = K("iconAnchorToText"), name = ns.L.AnchorToText or "Anchor to Text",
        default = DefaultFor(K("iconAnchorToText"), true),
        get = function() return G(K("iconAnchorToText"), DefaultFor(K("iconAnchorToText"), true)) end,
        set = function(v) ns.db[K("iconAnchorToText")] = v; ns.UpdateState(true) end,
        parentSection = iconSection,
        desc = ns.L.AnchorToTextDesc,
    })
    SettingsLib:CreateDropdown(cat, {
        key = K("iconAnchorPoint"), name = ns.L.AnchorPoint or "Anchor Point", values = ANCHOR_MAP, order = ANCHOR_ORDER,
        default = DefaultFor(K("iconAnchorPoint"), "LEFT"),
        get = function() return G(K("iconAnchorPoint"), DefaultFor(K("iconAnchorPoint"), "LEFT")) end,
        set = function(v) ns.db[K("iconAnchorPoint")] = v; ns.UpdateState(true) end,
        parentSection = iconSection,
        desc = ns.L.AnchorPointDesc,
    })
    SettingsLib:CreateSlider(cat, {
        key = K("iconSize"), name = ns.L.Size or "Size", min = 16, max = 150, step = 1,
        default = DefaultFor(K("iconSize"), 36),
        get = function() return G(K("iconSize"), DefaultFor(K("iconSize"), 36)) end,
        set = function(v) ns.db[K("iconSize")] = v; ns.UpdateState(true) end,
        parentSection = iconSection,
        desc = ns.L.SizeDesc,
    })
    SettingsLib:CreateSlider(cat, {
        key = K("iconAlpha"), name = ns.L.Opacity or "Opacity", min = 0, max = 1, step = 0.05,
        default = DefaultFor(K("iconAlpha"), 1),
        get = function() return G(K("iconAlpha"), DefaultFor(K("iconAlpha"), 1)) end,
        set = function(v) ns.db[K("iconAlpha")] = v; ns.UpdateState(true) end,
        parentSection = iconSection,
        desc = ns.L.OpacityDesc,
    })
    SettingsLib:CreateSlider(cat, {
        key = K("iconX"), name = ns.L.OffsetX or "Offset X", min = -1200, max = 1200, step = 1,
        default = DefaultFor(K("iconX"), -45),
        get = function() return G(K("iconX"), DefaultFor(K("iconX"), -45)) end,
        set = function(v) ns.db[K("iconX")] = v; ns.UpdateState(true) end,
        parentSection = iconSection,
        desc = ns.L.OffsetXDesc,
    })
    SettingsLib:CreateSlider(cat, {
        key = K("iconY"), name = ns.L.OffsetY or "Offset Y", min = -600, max = 600, step = 1,
        default = DefaultFor(K("iconY"), 0),
        get = function() return G(K("iconY"), DefaultFor(K("iconY"), 0)) end,
        set = function(v) ns.db[K("iconY")] = v; ns.UpdateState(true) end,
        parentSection = iconSection,
        desc = ns.L.OffsetYDesc,
    })

    local soundSection = SettingsLib:CreateExpandableSection(cat, { name = ns.L.Sound or "Sound", expanded = false })
    SettingsLib:CreateCheckbox(cat, {
        key = K("enableSound"), name = ns.L.Enable or "Enable",
        default = DefaultFor(K("enableSound"), true),
        get = function() return G(K("enableSound"), DefaultFor(K("enableSound"), true)) end,
        set = function(v) ns.db[K("enableSound")] = v; ns.UpdateState(true) end,
        parentSection = soundSection,
        desc = ns.L.SoundDesc or ns.L.EnableDesc,
    })
    SettingsLib:CreateInput(cat, {
        key = K("soundKit"), name = ns.L.SoundKitId or "Sound Kit ID",
        default = DefaultFor(K("soundKit"), (SOUNDKIT and SOUNDKIT.RAID_WARNING) or 8959),
        get = function() return G(K("soundKit"), DefaultFor(K("soundKit"), (SOUNDKIT and SOUNDKIT.RAID_WARNING) or 8959)) end,
        set = function(v) ns.db[K("soundKit")] = tonumber(v) or DefaultFor(K("soundKit"), (SOUNDKIT and SOUNDKIT.RAID_WARNING) or 8959); ns.UpdateState(true) end,
        numeric = true,
        parentSection = soundSection,
        desc = ns.L.SoundKitIdDesc,
    })
    SettingsLib:CreateButton(cat, {
        text = ns.L.TestSound or "Test Sound",
        func = function()
            local kit = ns.db[K("soundKit")] or (SOUNDKIT and SOUNDKIT.RAID_WARNING) or 8959
            if kit and PlaySound then PlaySound(kit, "Master") end
        end,
        parentSection = soundSection,
        desc = ns.L.TestSoundDesc,
    })
end

StaticPopupDialogs["NIGHTVEIL_CONFIRM_FACTORY_RESET"] = {
    text = ns.L and ns.L.FactoryResetConfirm or "|cffff0000WARNING:|r This will delete |cffff0000ALL|r your Nightveil settings and profiles. Are you sure?",
    button1 = YES,
    button2 = NO,
    OnAccept = function()
        ns.Tricks_DisableAndRemoveMacro()
        NightveilDB = nil
        NightveilProfiles = nil
        ReloadUI()
    end,
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
    preferredIndex = 3,
}

-- [[ UI Settings Interface Initialization ]] ---------------------------------
function ns.InitSettings()
    local function EnsureProfilePopups()
        if StaticPopupDialogs["NIGHTVEIL_CREATE_PROFILE"] then return end
        ns._pendingExportString = nil; ns._pendingImportString = nil

        StaticPopupDialogs["NIGHTVEIL_DELETE_RESTRICTED"] = {
            text = ns.GetAddonName() .. "\n\n|cffff2020" .. (ns.L and ns.L.ErrorDeleteRestricted or "You cannot delete the Default or Character profiles.") .. "|r",
            button1 = "OK",
            timeout = 0, whileDead = true, hideOnEscape = true, preferredIndex = 3,
        }

        StaticPopupDialogs["NIGHTVEIL_CREATE_PROFILE"] = {
            text = ns.L.CreateProfilePrompt or "Enter a name for the new profile:",
            button1 = ns.L.CreateProfile or "Create", button2 = CANCEL, hasEditBox = true, maxLetters = 32,
            OnAccept = function(self)
                local editBox = self.editBox or (self.GetEditBox and self:GetEditBox())
                local name = editBox and strtrim(editBox:GetText() or "") or ""
                if name ~= "" and ns.CreateProfile(name) then ns.SetActiveProfile(name) end
            end,
            OnShow = function(self)
                local editBox = self.editBox or (self.GetEditBox and self:GetEditBox())
                if editBox then editBox:SetText(""); editBox:SetFocus() end
            end,
            EditBoxOnEnterPressed = function(self) StaticPopup_OnClick(self:GetParent(), 1) end,
            EditBoxOnEscapePressed = function(self) self:GetParent():Hide() end,
            timeout = 0, whileDead = true, hideOnEscape = true, preferredIndex = 3,
        }

        StaticPopupDialogs["NIGHTVEIL_DUPLICATE_PROFILE"] = {
            text = ns.L.DuplicateProfilePrompt or "Enter a name for the duplicated profile:",
            button1 = ns.L.DuplicateProfile or "Duplicate", button2 = CANCEL, hasEditBox = true, maxLetters = 32,
            OnAccept = function(self)
                local editBox = self.editBox or (self.GetEditBox and self:GetEditBox())
                local name = editBox and strtrim(editBox:GetText() or "") or ""
                if name ~= "" and ns.CreateProfile(name, ns.GetActiveProfileName()) then ns.SetActiveProfile(name) end
            end,
            OnShow = function(self)
                local editBox = self.editBox or (self.GetEditBox and self:GetEditBox())
                if editBox then editBox:SetText(""); editBox:SetFocus() end
            end,
            EditBoxOnEnterPressed = function(self) StaticPopup_OnClick(self:GetParent(), 1) end,
            EditBoxOnEscapePressed = function(self) self:GetParent():Hide() end,
            timeout = 0, whileDead = true, hideOnEscape = true, preferredIndex = 3,
        }

        StaticPopupDialogs["NIGHTVEIL_CONFIRM_DELETE_PROFILE"] = {
            text = ns.L.DeleteProfileConfirm or "Delete profile:\n\n|cffff0000%s|r\n\nThis cannot be undone.",
            button1 = DELETE, button2 = CANCEL,
            OnAccept = function(_, name) if type(name) == "string" and name ~= "" then ns.DeleteProfile(name); ns.SetActiveProfile(ns.GetCharacterKey()) end end,
            timeout = 0, whileDead = true, hideOnEscape = true, preferredIndex = 3,
        }

        StaticPopupDialogs["NIGHTVEIL_EXPORT_PROFILE"] = {
            text = ns.L.ExportProfilePrompt or "Copy this export string (Ctrl+C):\n\nProfile: |cff00ff00%s|r",
            button1 = CLOSE, hasEditBox = true, editBoxWidth = 350, maxLetters = 0,
            OnShow = function(self)
                local editBox = self.editBox or (self.GetEditBox and self:GetEditBox())
                if editBox then editBox:SetMaxLetters(0); editBox:SetText(ns._pendingExportString or ""); editBox:SetFocus(); editBox:HighlightText() end
            end,
            EditBoxOnEscapePressed = function(self) self:GetParent():Hide() end,
            timeout = 0, whileDead = true, hideOnEscape = true, preferredIndex = 3,
        }

        StaticPopupDialogs["NIGHTVEIL_IMPORT_PROFILE_STRING"] = {
            text = ns.L.ImportProfilePrompt or "Paste the profile export string below:",
            button1 = ns.L.Next or "Next", button2 = CANCEL, hasEditBox = true, editBoxWidth = 350, maxLetters = 0,
            OnAccept = function(self)
                local editBox = self.editBox or (self.GetEditBox and self:GetEditBox())
                local s = editBox and strtrim(editBox:GetText() or "") or ""
                if s ~= "" then ns._pendingImportString = s; StaticPopup_Show("NIGHTVEIL_IMPORT_PROFILE_NAME") end
            end,
            OnShow = function(self)
                local editBox = self.editBox or (self.GetEditBox and self:GetEditBox())
                if editBox then editBox:SetMaxLetters(0); editBox:SetText(""); editBox:SetFocus() end
            end,
            EditBoxOnEnterPressed = function(self) StaticPopup_OnClick(self:GetParent(), 1) end,
            EditBoxOnEscapePressed = function(self) ns._pendingImportString = nil; self:GetParent():Hide() end,
            timeout = 0, whileDead = true, hideOnEscape = true, preferredIndex = 3,
        }

        StaticPopupDialogs["NIGHTVEIL_IMPORT_PROFILE_NAME"] = {
            text = ns.L.ImportProfileNamePrompt or "Enter a name for the imported profile:",
            button1 = ns.L.Import or "Import", button2 = CANCEL, hasEditBox = true, maxLetters = 32,
            OnAccept = function(self)
                local importString = ns._pendingImportString; ns._pendingImportString = nil
                if not importString then return end
                local editBox = self.editBox or (self.GetEditBox and self:GetEditBox())
                local name = editBox and strtrim(editBox:GetText() or "") or ""
                if name ~= "" then
                    local ok, target = ns.ImportProfileString(importString, name)
                    if ok then ns.SetActiveProfile(target) end
                end
            end,
            OnShow = function(self)
                local editBox = self.editBox or (self.GetEditBox and self:GetEditBox())
                if editBox then editBox:SetText(""); editBox:SetFocus() end
            end,
            OnCancel = function() ns._pendingImportString = nil end,
            EditBoxOnEnterPressed = function(self) StaticPopup_OnClick(self:GetParent(), 1) end,
            EditBoxOnEscapePressed = function(self) ns._pendingImportString = nil; self:GetParent():Hide() end,
            timeout = 0, whileDead = true, hideOnEscape = true, preferredIndex = 3,
        }
    end

    EnsureProfilePopups()
    if ns.settingsInitialized then return end
    ns.settingsInitialized = true

    ns.MainCategory = SettingsLib:CreateRootCategory(ns.GetAddonName(), false)
    local root = ns.MainCategory

    if not ns.IsRogue then
        SettingsLib:CreateHeader(root, { name = "|cffff2020" .. (ns.L and ns.L.WarningNotRogue or "You are not a Rogue. Class-specific features are disabled.") .. "|r" })
    end

    BuildChangelog(root)

    if ns.IsRogue then
        local stealthCat = SettingsLib:CreateCategory(root, ns.L.Stealth or "Stealth", false)
        SettingsLib:CreateHeader(stealthCat, { name = ns.L.Management or "Management" })
        SettingsLib:CreateCheckbox(stealthCat, {
            key = "stealthEnabled", name = ns.L.EnableOnStealth or "Enable on Stealth", default = ns.Defaults.stealthEnabled,
            get = function() return G("stealthEnabled", ns.Defaults.stealthEnabled) end,
            set = function(v) ns.db.stealthEnabled = v; ns.UpdateState(true) end,
            desc = ns.L.EnableOnStealthDesc,
        })
        SettingsLib:CreateCheckbox(stealthCat, {
            key = "stealthOnlyInstances", name = ns.L.OnlyInInstances or "Only in instances", default = ns.Defaults.stealthOnlyInstances,
            get = function() return G("stealthOnlyInstances", ns.Defaults.stealthOnlyInstances) end,
            set = function(v) ns.db.stealthOnlyInstances = v; ns.UpdateState(true) end,
            desc = ns.L.OnlyInInstancesDesc,
        })
        ns.AddStealthSettings(stealthCat, "stealth")
    end

    if ns.IsRogue then
        local poisonCat = SettingsLib:CreateCategory(root, ns.L.PoisonTracker or "Poison Tracker", false)
        SettingsLib:CreateHeader(poisonCat, { name = ns.L.Management or "Management" })
        SettingsLib:CreateCheckbox(poisonCat, {
            key = "poisonLethalEnabled", name = ns.L.LethalPoisons or "Lethal Poison", default = ns.Defaults.poisonLethalEnabled,
            get = function() return G("poisonLethalEnabled", ns.Defaults.poisonLethalEnabled) end,
            set = function(v) ns.db.poisonLethalEnabled = v; ns.UpdateState(true) end,
            desc = ns.L.LethalPoisonsDesc,
        })
        SettingsLib:CreateCheckbox(poisonCat, {
            key = "poisonNonLethalEnabled", name = ns.L.NonLethalPoisons or "Non-Lethal Poison", default = ns.Defaults.poisonNonLethalEnabled,
            get = function() return G("poisonNonLethalEnabled", ns.Defaults.poisonNonLethalEnabled) end,
            set = function(v) ns.db.poisonNonLethalEnabled = v; ns.UpdateState(true) end,
            desc = ns.L.NonLethalPoisonsDesc,
        })
        SettingsLib:CreateCheckbox(poisonCat, {
            key = "poisonOnlyCombat", name = ns.L.OnlyInCombat or "Only in combat", default = ns.Defaults.poisonOnlyCombat,
            get = function() return G("poisonOnlyCombat", ns.Defaults.poisonOnlyCombat) end,
            set = function(v) ns.db.poisonOnlyCombat = v; ns.UpdateState(true) end,
            desc = ns.L.OnlyInCombatDesc,
        })
        SettingsLib:CreateCheckbox(poisonCat, {
            key = "poisonOnlyInstances", name = ns.L.OnlyInInstances or "Only in instances", default = ns.Defaults.poisonOnlyInstances,
            get = function() return G("poisonOnlyInstances", ns.Defaults.poisonOnlyInstances) end,
            set = function(v) ns.db.poisonOnlyInstances = v; ns.UpdateState(true) end,
            desc = ns.L.OnlyInInstancesDesc,
        })
        ns.AddPoisonSettings(poisonCat, "poisonLethal", ns.L.LethalPoisons or "Lethal Poison")
        ns.AddPoisonSettings(poisonCat, "poisonNonLethal", ns.L.NonLethalPoisons or "Non-Lethal Poison")


        -- [[ Shroud of Concealment Section ]] ---------------------------------------
        local shroudCat = SettingsLib:CreateCategory(root, ns.L.ShroudOfConcealment or "Shroud of Concealment", false)
        SettingsLib:CreateHeader(shroudCat, { name = ns.L.Management or "Management" })
        SettingsLib:CreateCheckbox(shroudCat, {
            key = "shroudCountdown", name = ns.L.EnableShroudCountdown or "Countdown in Chat", default = ns.Defaults.shroudCountdown,
            get = function() return G("shroudCountdown", ns.Defaults.shroudCountdown) end,
            set = function(v) ns.db.shroudCountdown = v end,
            desc = ns.L.EnableShroudCountdownDesc,
        })
        SettingsLib:CreateCheckbox(shroudCat, {
            key = "shroudOnlyInstances", name = ns.L.OnlyInInstances or "Only in instances", default = ns.Defaults.shroudOnlyInstances,
            get = function() return G("shroudOnlyInstances", ns.Defaults.shroudOnlyInstances) end,
            set = function(v) ns.db.shroudOnlyInstances = v end,
            desc = ns.L.ShroudOnlyInstancesDesc,
        })
        SettingsLib:CreateCheckbox(shroudCat, {
            key = "shroudMuteErrors", name = ns.L.ShroudMuteErrors or "Mute error messages", default = ns.Defaults.shroudMuteErrors,
            get = function() return G("shroudMuteErrors", ns.Defaults.shroudMuteErrors) end,
            set = function(v) ns.db.shroudMuteErrors = v end,
            desc = ns.L.ShroudMuteErrorsDesc,
        })
        SettingsLib:CreateHeader(shroudCat, { name = ns.L.Messages or "Messages" })
        SettingsLib:CreateDropdown(shroudCat, {
            key = "shroudChannel", name = ns.L.ChatChannel or "Chat Channel", values = CHANNELS, order = CHANNEL_ORDER, default = ns.Defaults.shroudChannel or "SAY",
            get = function() return G("shroudChannel", ns.Defaults.shroudChannel or "SAY") end,
            set = function(v) ns.db.shroudChannel = v end,
            desc = ns.L.ChatChannelDesc,
        })
        SettingsLib:CreateDropdown(shroudCat, {
            key = "shroudChannelFallback1", name = " ", values = CHANNELS, order = CHANNEL_ORDER, default = ns.Defaults.shroudChannelFallback1 or "NONE",
            get = function() return G("shroudChannelFallback1", ns.Defaults.shroudChannelFallback1 or "NONE") end,
            set = function(v) ns.db.shroudChannelFallback1 = v end,
            desc = ns.L.ChatChannelFallbackDesc,
        })
        SettingsLib:CreateDropdown(shroudCat, {
            key = "shroudChannelFallback2", name = " ", values = CHANNELS, order = CHANNEL_ORDER, default = ns.Defaults.shroudChannelFallback2 or "NONE",
            get = function() return G("shroudChannelFallback2", ns.Defaults.shroudChannelFallback2 or "NONE") end,
            set = function(v) ns.db.shroudChannelFallback2 = v end,
            desc = ns.L.ChatChannelFallbackDesc,
        })
        SettingsLib:CreateInput(shroudCat, {
            key = "shroudMessage", name = ns.L.ShroudMessage or "Countdown Message", default = ns.Defaults.shroudMessage or "%time",
            get = function() return G("shroudMessage", ns.Defaults.shroudMessage or "%time") end,
            set = function(v) ns.db.shroudMessage = v end,
            desc = ns.L.ShroudMessageDesc or (ns.L.TimeRemainingHint or "%time = time remaining"),
        })
        SettingsLib:CreateInput(shroudCat, {
            key = "shroudStartMsg", name = ns.L.ShroudOnStart or "Start Message", default = ns.Defaults.shroudStartMsg or "%time",
            get = function() return G("shroudStartMsg", ns.Defaults.shroudStartMsg or "%time") end,
            set = function(v) ns.db.shroudStartMsg = v end,
            desc = ns.L.ShroudOnStartDesc,
        })
        SettingsLib:CreateInput(shroudCat, {
            key = "shroudEndMsg", name = ns.L.ShroudOnEnd or "End Message", default = ns.Defaults.shroudEndMsg or "%time",
            get = function() return G("shroudEndMsg", ns.Defaults.shroudEndMsg or "%time") end,
            set = function(v) ns.db.shroudEndMsg = v end,
            desc = ns.L.ShroudOnEndDesc,
        })
        SettingsLib:CreateCheckbox(shroudCat, {
            key = "shroudInterval", name = ns.L.ShroudInterval or "Interval Mode", default = ns.Defaults.shroudInterval,
            get = function() return G("shroudInterval", ns.Defaults.shroudInterval) end,
            set = function(v) ns.db.shroudInterval = v end,
            desc = ns.L.ShroudIntervalDesc or "Start, middle, and last 5s",
        })
        SettingsLib:CreateButton(shroudCat, {
            text = ns.L.TestShroud or "Test Message",
            func = function() if ns.TestShroudMessage then ns.TestShroudMessage() end end,
            desc = ns.L.TestShroudDesc,
        })

        -- [[ Tricks of the Trade Section ]] -----------------------------------------
        local tricksCat = SettingsLib:CreateCategory(root, ns.L.TricksOfTheTrade or "Tricks of the Trade", false)
        
        SettingsLib:CreateHeader(tricksCat, { name = ns.L.Management or "Management" })
        SettingsLib:CreateButton(tricksCat, {
            text = ns.L.TricksBtnEnable or "Activate & Sync Macro",
            func = function()
                if InCombatLockdown() then
                    print("Night|cffA361E2veil|r: " .. (ns.L and ns.L.DebugCombatLock or "This action cannot be used in combat."))
                    return
                end
                if ns.db.tricksEnabled then
                    print(ns.GetAddonName() .. ": " .. (ns.L and ns.L.TricksAlreadyEnabled or "Tricks of the Trade system is already enabled."))
                else
                    ns.db.tricksEnabled = true
                    print(ns.GetAddonName() .. ": |cff00ff00" .. (ns.L and ns.L.TricksMsgEnabled or "Tricks system activated and macro synchronized.") .. "|r")
                    ns.Tricks_UpdateMacro(true)
                    if ns.UpdateState then ns.UpdateState(true) end
                end
            end,
            desc = ns.L.TricksEnabledDesc,
        })
        SettingsLib:CreateButton(tricksCat, {
            text = ns.L.TricksBtnDisable or "Deactivate & Remove Macro",
            func = function()
                if InCombatLockdown() then
                    print("Night|cffA361E2veil|r: " .. (ns.L and ns.L.DebugCombatLock or "This action cannot be used in combat."))
                    return
                end
                if not ns.db.tricksEnabled then
                    print(ns.GetAddonName() .. ": " .. (ns.L and ns.L.TricksAlreadyDisabled or "Tricks of the Trade system is already disabled."))
                else
                    print(ns.GetAddonName() .. ": |cffff2020" .. (ns.L and ns.L.TricksMsgDisabled or "Tricks system deactivated and macro removed.") .. "|r")
                    ns.Tricks_DisableAndRemoveMacro()
                    if ns.UpdateState then ns.UpdateState(true) end
                end
            end,
            desc = ns.L.TricksBtnDisableDesc,
        })
        
        SettingsLib:CreateText(tricksCat, {
            text = ns.L.TricksMacroAutoUpdate,
            color = "ffffa500",
            small = true,
        })
        
        SettingsLib:CreateCheckbox(tricksCat, {
            key = "tricksMute", name = ns.L.MuteChanges or "Mute Changes", default = ns.Defaults.tricksMute,
            get = function() return G("tricksMute", ns.Defaults.tricksMute) end,
            set = function(v) ns.db.tricksMute = v end,
            desc = ns.L.TricksMuteDesc,
        })

        SettingsLib:CreateHeader(tricksCat, { name = ns.L.TricksTargetHeader or "Target" })
        SettingsLib:CreateCheckbox(tricksCat, {
            key = "tricksUseMouseover", name = ns.L.Mouseover or "Mouseover", default = ns.Defaults.tricksUseMouseover,
            get = function() return G("tricksUseMouseover", ns.Defaults.tricksUseMouseover) end,
            set = function(v) ns.db.tricksUseMouseover = v; ns.Tricks_UpdateMacro(true) end,
            desc = ns.L.TricksMouseoverDesc,
        })
        SettingsLib:CreateCheckbox(tricksCat, {
            key = "tricksUseFocus", name = ns.L.Focus or "Focus", default = ns.Defaults.tricksUseFocus,
            get = function() return G("tricksUseFocus", ns.Defaults.tricksUseFocus) end,
            set = function(v) ns.db.tricksUseFocus = v; ns.Tricks_UpdateMacro(true) end,
            desc = ns.L.TricksFocusDesc,
        })
        SettingsLib:CreateDropdown(tricksCat, {
            key = "tricksLogic", name = ns.L.TricksTargetSelector or "Target Selector", values = TRICKS_LOGIC_OPTIONS, order = TRICKS_LOGIC_ORDER,
            default = ns.Defaults.tricksLogic,
            get = function() return G("tricksLogic", ns.Defaults.tricksLogic) end,
            set = function(v) ns.db.tricksLogic = v; ns.Tricks_UpdateMacro(true) end,
            desc = ns.L.TricksTargetSelectorDesc,
        })
        SettingsLib:CreateInput(tricksCat, {
            key = "tricksCustomName", name = ns.L.TricksCustomName or "Custom Target",
            default = ns.Defaults.tricksCustomName or "",
            get = function() return G("tricksCustomName", ns.Defaults.tricksCustomName or "") end,
            set = function(v)
                ns.db.tricksCustomName = v
                ns.db.tricksLogic = "CUSTOM"
                ns.Tricks_UpdateMacro(true)
            end,
            desc = ns.L.TricksCustomNameDesc,
        })
        SettingsLib:CreateCheckbox(tricksCat, {
            key = "tricksDelveCompanion", name = ns.L.TricksDelveCompanion or "Delve Companion", default = ns.Defaults.tricksDelveCompanion,
            get = function() return G("tricksDelveCompanion", ns.Defaults.tricksDelveCompanion) end,
            set = function(v) ns.db.tricksDelveCompanion = v; ns.Tricks_UpdateMacro(true) end,
            desc = (ns.L.TricksDelveCompanionDesc or ""),
        })

    end


    if ns.IsRogue then
        local profilesCat = SettingsLib:CreateCategory(root, ns.L.Profiles or "Profiles", false)
        SettingsLib:CreateHeader(profilesCat, { name = ns.L.Management or "Management" })
    SettingsLib:CreateScrollDropdown(profilesCat, {
        key = "profileActive", name = ns.L.ActiveProfile or "Active Profile", default = ns.GetActiveProfileName(),
        get = function() return ns.GetActiveProfileName() end,
        set = function(v) ns.SetActiveProfile(v) end,
        optionfunc = function()
            local list = {}
            for _, name in ipairs(ns.GetProfiles()) do table.insert(list, { label = name, value = name }) end
            return list
        end,
        desc = ns.L.ActiveProfileDesc,
    })
    SettingsLib:CreateButton(profilesCat, { text = ns.L.CreateProfile or "Create Profile", func = function() StaticPopup_Show("NIGHTVEIL_CREATE_PROFILE") end, desc = ns.L.CreateProfileDesc })
    SettingsLib:CreateButton(profilesCat, { text = ns.L.DuplicateProfile or "Duplicate Profile", func = function() StaticPopup_Show("NIGHTVEIL_DUPLICATE_PROFILE") end, desc = ns.L.DuplicateProfileDesc })
    SettingsLib:CreateButton(profilesCat, {
        text = ns.L.DeleteProfile or "Delete Profile",
        func = function()
            local active = ns.GetActiveProfileName()
            if active ~= "Default" and active ~= ns.GetCharacterKey() then
                StaticPopup_Show("NIGHTVEIL_CONFIRM_DELETE_PROFILE", active, nil, active)
            else
                StaticPopup_Show("NIGHTVEIL_DELETE_RESTRICTED", active)
            end
        end,
        desc = ns.L.DeleteProfileDesc,
    })
    SettingsLib:CreateButton(profilesCat, {
        text = "|cffff0000" .. (ns.L.FactoryResetBtn or "Factory Reset") .. "|r",
        func = function()
            StaticPopup_Show("NIGHTVEIL_CONFIRM_FACTORY_RESET")
        end,
        desc = ns.L.FactoryResetBtnDesc or "Deletes all addon data and macros, restoring to a clean installation. UI will reload.",
    })
    SettingsLib:CreateHeader(profilesCat, { name = ns.L.Share or "Share" })
    SettingsLib:CreateButton(profilesCat, {
        text = ns.L.ExportProfile or "Export Profile",
        func = function() ns._pendingExportString = ns.ExportProfileString(); StaticPopup_Show("NIGHTVEIL_EXPORT_PROFILE", ns.GetActiveProfileName()) end,
        desc = ns.L.ExportProfileDesc,
    })
        SettingsLib:CreateButton(profilesCat, { text = ns.L.ImportProfile or "Import Profile", func = function() StaticPopup_Show("NIGHTVEIL_IMPORT_PROFILE_STRING") end, desc = ns.L.ImportProfileDesc })
    end
end
