-- ============================================================================
-- [[ NIGHTVEIL — STEALTH STATE SETTINGS ]] ----------------------------------
-- ============================================================================
local addonName, ns = ...
local SettingsLib = LibStub("LibEQOLSettingsMode-1.0")
SettingsLib:SetVariablePrefix("Nightveil_")

ns.Modules = ns.Modules or {}
ns.Modules.StealthStateSettings = {}

-- [[ UI BUILDER ]] -----------------------------------------------------------

local G = ns.Modules.Settings and ns.Modules.Settings.Get or function(k, d) return ns.db and ns.db[k] or d end
local GetColor = ns.Modules.Settings and ns.Modules.Settings.GetColor or function(k, dr, dg, db) local c = ns.db and ns.db[k]; if not c then return dr or 0.64, dg or 0.38, db or 0.89 end; return c.r or dr, c.g or dg, c.b or db end

local function AddStealthSettings(cat, prefix)
    local function K(key) return prefix .. key:sub(1,1):upper() .. key:sub(2) end
    local function DefaultFor(key, fallback)
        local v = ns.Defaults and ns.Defaults[key]
        return v ~= nil and v or fallback
    end
    
    local function Refresh()
        if ns.Modules.StealthState and ns.Modules.StealthState.RefreshVisuals then ns.Modules.StealthState.RefreshVisuals(true) end
    end

    local textSection = SettingsLib:CreateExpandableSection(cat, { name = ns.L and ns.L.FloatingText or "Floating Text", expanded = false })
    SettingsLib:CreateCheckbox(cat, {
        key = K("enableText"), name = ns.L and ns.L.Enable or "Enable",
        default = DefaultFor(K("enableText"), true),
        get = function() return G(K("enableText"), DefaultFor(K("enableText"), true)) end,
        set = function(v) ns.db[K("enableText")] = v; Refresh() end,
        parentSection = textSection,
    })
    SettingsLib:CreateInput(cat, {
        key = K("customText"), name = ns.L and ns.L.CustomText or "Custom Text",
        default = DefaultFor(K("customText"), ""),
        get = function() return G(K("customText"), DefaultFor(K("customText"), "")) end,
        set = function(v) ns.db[K("customText")] = v; Refresh() end,
        parentSection = textSection,
    })
    SettingsLib:CreateColorOverrides(cat, {
        entries = { { key = K("textColor"), label = ns.L and ns.L.Color or "Color" } },
        getColor = function(key) local def = ns.Defaults and ns.Defaults[key] or { r = 0.420, g = 0.518, b = 0.647 }; return GetColor(key, def.r, def.g, def.b) end,
        getDefaultColor = function(key) local def = ns.Defaults and ns.Defaults[key] or { r = 0.420, g = 0.518, b = 0.647 }; return def.r, def.g, def.b end,
        setColor = function(key, r, g, b) ns.db[key] = { r = r, g = g, b = b }; Refresh() end,
        parentSection = textSection,
    })
    SettingsLib:CreateSlider(cat, {
        key = K("textAlpha"), name = ns.L and ns.L.Opacity or "Opacity", min = 0, max = 1, step = 0.05,
        default = DefaultFor(K("textAlpha"), 1),
        get = function() return G(K("textAlpha"), DefaultFor(K("textAlpha"), 1)) end,
        set = function(v) ns.db[K("textAlpha")] = v; Refresh() end,
        parentSection = textSection,
    })
    SettingsLib:CreateSlider(cat, {
        key = K("textX"), name = ns.L and ns.L.OffsetX or "Offset X", min = -1200, max = 1200, step = 1,
        default = DefaultFor(K("textX"), 0),
        get = function() return G(K("textX"), DefaultFor(K("textX"), 0)) end,
        set = function(v) ns.db[K("textX")] = v; Refresh() end,
        parentSection = textSection,
    })
    SettingsLib:CreateSlider(cat, {
        key = K("textY"), name = ns.L and ns.L.OffsetY or "Offset Y", min = -600, max = 600, step = 1,
        default = DefaultFor(K("textY"), 185),
        get = function() return G(K("textY"), DefaultFor(K("textY"), 185)) end,
        set = function(v) ns.db[K("textY")] = v; Refresh() end,
        parentSection = textSection,
    })
    SettingsLib:CreateSlider(cat, {
        key = K("textSize"), name = ns.L and ns.L.Size or "Size", min = 10, max = 100, step = 1,
        default = DefaultFor(K("textSize"), 32),
        get = function() return G(K("textSize"), DefaultFor(K("textSize"), 32)) end,
        set = function(v) ns.db[K("textSize")] = v; Refresh() end,
        parentSection = textSection,
    })

    local iconSection = SettingsLib:CreateExpandableSection(cat, { name = ns.L and ns.L.IndicatorIcon or "Indicator Icon", expanded = false })
    SettingsLib:CreateCheckbox(cat, {
        key = K("enableIcon"), name = ns.L and ns.L.Enable or "Enable",
        default = DefaultFor(K("enableIcon"), true),
        get = function() return G(K("enableIcon"), DefaultFor(K("enableIcon"), true)) end,
        set = function(v) ns.db[K("enableIcon")] = v; Refresh() end,
        parentSection = iconSection,
    })
    SettingsLib:CreateInput(cat, {
        key = K("iconTexture"), name = ns.L and ns.L.IconTexture or "Icon Texture",
        default = DefaultFor(K("iconTexture"), "Interface\\Icons\\Ability_Stealth"),
        get = function() return G(K("iconTexture"), DefaultFor(K("iconTexture"), "Interface\\Icons\\Ability_Stealth")) end,
        set = function(v) ns.db[K("iconTexture")] = v; Refresh() end,
        parentSection = iconSection,
    })
    SettingsLib:CreateCheckbox(cat, {
        key = K("iconAnchorToText"), name = ns.L and ns.L.AnchorToText or "Anchor to Text",
        default = DefaultFor(K("iconAnchorToText"), true),
        get = function() return G(K("iconAnchorToText"), DefaultFor(K("iconAnchorToText"), true)) end,
        set = function(v) ns.db[K("iconAnchorToText")] = v; Refresh() end,
        parentSection = iconSection,
    })
    SettingsLib:CreateDropdown(cat, {
        key = K("iconAnchorPoint"), name = ns.L and ns.L.AnchorPoint or "Anchor Point", values = ns.UI_ANCHOR_MAP, order = ns.UI_ANCHOR_ORDER,
        default = DefaultFor(K("iconAnchorPoint"), "LEFT"),
        get = function() return G(K("iconAnchorPoint"), DefaultFor(K("iconAnchorPoint"), "LEFT")) end,
        set = function(v) ns.db[K("iconAnchorPoint")] = v; Refresh() end,
        parentSection = iconSection,
    })
    SettingsLib:CreateSlider(cat, {
        key = K("iconX"), name = ns.L and ns.L.OffsetX or "Offset X", min = -1200, max = 1200, step = 1,
        default = DefaultFor(K("iconX"), -5),
        get = function() return G(K("iconX"), DefaultFor(K("iconX"), -5)) end,
        set = function(v) ns.db[K("iconX")] = v; Refresh() end,
        parentSection = iconSection,
    })
    SettingsLib:CreateSlider(cat, {
        key = K("iconY"), name = ns.L and ns.L.OffsetY or "Offset Y", min = -600, max = 600, step = 1,
        default = DefaultFor(K("iconY"), 0),
        get = function() return G(K("iconY"), DefaultFor(K("iconY"), 0)) end,
        set = function(v) ns.db[K("iconY")] = v; Refresh() end,
        parentSection = iconSection,
    })
    SettingsLib:CreateSlider(cat, {
        key = K("iconSize"), name = ns.L and ns.L.Size or "Size", min = 16, max = 150, step = 1,
        default = DefaultFor(K("iconSize"), 36),
        get = function() return G(K("iconSize"), DefaultFor(K("iconSize"), 36)) end,
        set = function(v) ns.db[K("iconSize")] = v; Refresh() end,
        parentSection = iconSection,
    })
    SettingsLib:CreateSlider(cat, {
        key = K("iconAlpha"), name = ns.L and ns.L.Opacity or "Opacity", min = 0, max = 1, step = 0.05,
        default = DefaultFor(K("iconAlpha"), 1),
        get = function() return G(K("iconAlpha"), DefaultFor(K("iconAlpha"), 1)) end,
        set = function(v) ns.db[K("iconAlpha")] = v; Refresh() end,
        parentSection = iconSection,
    })

    local screenSection = SettingsLib:CreateExpandableSection(cat, { name = ns.L and ns.L.ScreenColor or "Screen Color", expanded = false })
    SettingsLib:CreateCheckbox(cat, {
        key = K("enableScreenColor"), name = ns.L and ns.L.Enable or "Enable",
        default = DefaultFor(K("enableScreenColor"), true),
        get = function() return G(K("enableScreenColor"), DefaultFor(K("enableScreenColor"), true)) end,
        set = function(v) ns.db[K("enableScreenColor")] = v; Refresh() end,
        parentSection = screenSection,
    })
    SettingsLib:CreateColorOverrides(cat, {
        entries = { { key = K("screenColor"), label = ns.L and ns.L.Color or "Color" } },
        getColor = function(key) local def = ns.Defaults and ns.Defaults[key] or { r = 0.420, g = 0.518, b = 0.647 }; return GetColor(key, def.r, def.g, def.b) end,
        getDefaultColor = function(key) local def = ns.Defaults and ns.Defaults[key] or { r = 0.420, g = 0.518, b = 0.647 }; return def.r, def.g, def.b end,
        setColor = function(key, r, g, b) ns.db[key] = { r = r, g = g, b = b }; Refresh() end,
        parentSection = screenSection,
    })
    SettingsLib:CreateSlider(cat, {
        key = K("screenAlpha"), name = ns.L and ns.L.Opacity or "Opacity", min = 0, max = 0.8, step = 0.01,
        default = DefaultFor(K("screenAlpha"), 0.1),
        get = function() return G(K("screenAlpha"), DefaultFor(K("screenAlpha"), 0.1)) end,
        set = function(v) ns.db[K("screenAlpha")] = v; Refresh() end,
        parentSection = screenSection,
    })
    SettingsLib:CreateDropdown(cat, {
        key = K("screenStrata"), name = ns.L and ns.L.Layer or "Layer", values = ns.UI_LAYER_MAP, order = ns.UI_LAYER_ORDER,
        default = DefaultFor(K("screenStrata"), "BACKGROUND"),
        get = function() return G(K("screenStrata"), DefaultFor(K("screenStrata"), "BACKGROUND")) end,
        set = function(v) ns.db[K("screenStrata")] = v; Refresh() end,
        parentSection = screenSection,
    })

    local vigSection = SettingsLib:CreateExpandableSection(cat, { name = ns.L and ns.L.Vignette or "Vignette", expanded = false })
    SettingsLib:CreateCheckbox(cat, {
        key = K("enableVignette"), name = ns.L and ns.L.Enable or "Enable",
        default = DefaultFor(K("enableVignette"), true),
        get = function() return G(K("enableVignette"), DefaultFor(K("enableVignette"), true)) end,
        set = function(v) ns.db[K("enableVignette")] = v; Refresh() end,
        parentSection = vigSection,
    })
    SettingsLib:CreateSlider(cat, {
        key = K("vignetteSize"), name = ns.L and ns.L.Thickness or "Thickness", min = 50, max = 600, step = 1,
        default = DefaultFor(K("vignetteSize"), 250),
        get = function() return G(K("vignetteSize"), DefaultFor(K("vignetteSize"), 250)) end,
        set = function(v) ns.db[K("vignetteSize")] = v; Refresh() end,
        parentSection = vigSection,
    })
    SettingsLib:CreateSlider(cat, {
        key = K("vignetteAlpha"), name = ns.L and ns.L.Opacity or "Opacity", min = 0, max = 1, step = 0.05,
        default = DefaultFor(K("vignetteAlpha"), 0.6),
        get = function() return G(K("vignetteAlpha"), DefaultFor(K("vignetteAlpha"), 0.6)) end,
        set = function(v) ns.db[K("vignetteAlpha")] = v; Refresh() end,
        parentSection = vigSection,
    })
    SettingsLib:CreateDropdown(cat, {
        key = K("vignetteStrata"), name = ns.L and ns.L.Layer or "Layer", values = ns.UI_LAYER_MAP, order = ns.UI_LAYER_ORDER,
        default = DefaultFor(K("vignetteStrata"), "BACKGROUND"),
        get = function() return G(K("vignetteStrata"), DefaultFor(K("vignetteStrata"), "BACKGROUND")) end,
        set = function(v) ns.db[K("vignetteStrata")] = v; Refresh() end,
        parentSection = vigSection,
    })
end

-- ============================================================================
-- [[ INITIALIZATION ]] -------------------------------------------------------
-- ============================================================================
function ns.Modules.StealthStateSettings.Init(root)
    local stealthCat = SettingsLib:CreateCategory(root, ns.L and ns.L.StealthStateName or "Stealth State", false)
    SettingsLib:CreateHeader(stealthCat, { name = ns.L and ns.L.Management or "Management" })
    
    SettingsLib:CreateCheckbox(stealthCat, {
        key = "stealthStateEnabled", name = ns.L and ns.L.EnableOnStealthState or "Enable on Stealth State", default = true,
        get = function() return G("stealthStateEnabled", true) end,
        set = function(v) ns.db.stealthStateEnabled = v; if ns.UpdateState then ns.UpdateState(true) end end,
    })
    
    SettingsLib:CreateCheckbox(stealthCat, {
        key = "stealthStateOnlyInstances", name = ns.L and ns.L.OnlyInInstances or "Only in instances", default = false,
        get = function() return G("stealthStateOnlyInstances", false) end,
        set = function(v) ns.db.stealthStateOnlyInstances = v; if ns.UpdateState then ns.UpdateState(true) end end,
    })

    local sFilterSection = SettingsLib:CreateExpandableSection(stealthCat, { name = ns.L and ns.L.InstanceFilters or "Instance Filters", expanded = false })
    SettingsLib:CreateCheckbox(stealthCat, {
        key = "stealthStateDisableInDungeons", name = ns.L and ns.L.DisableInDungeons or "Disable in Dungeons", default = false,
        get = function() return G("stealthStateDisableInDungeons", false) end,
        set = function(v) ns.db.stealthStateDisableInDungeons = v; if ns.UpdateState then ns.UpdateState(true) end end,
        parentSection = sFilterSection,
    })
    SettingsLib:CreateCheckbox(stealthCat, {
        key = "stealthStateDisableInRaids", name = ns.L and ns.L.DisableInRaids or "Disable in Raids", default = false,
        get = function() return G("stealthStateDisableInRaids", false) end,
        set = function(v) ns.db.stealthStateDisableInRaids = v; if ns.UpdateState then ns.UpdateState(true) end end,
        parentSection = sFilterSection,
    })

    AddStealthSettings(stealthCat, "stealthState")
end
