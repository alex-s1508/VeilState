-- ============================================================================
-- [[ NIGHTVEIL — ROGUE SETTINGS UI ]] ---------------------------------------
-- ============================================================================
local addonName, ns = ...
local SettingsLib = LibStub("LibEQOLSettingsMode-1.0")
SettingsLib:SetVariablePrefix("Nightveil_")

ns.Modules = ns.Modules or {}
ns.Modules.RogueSettings = {}

-- [[ UI BUILDERS ]] ----------------------------------------------------------

local G = ns.Modules.Settings and ns.Modules.Settings.Get or function(k, d) return ns.db and ns.db[k] or d end
local GetColor = ns.Modules.Settings and ns.Modules.Settings.GetColor or function(k, dr, dg, db) local c = ns.db and ns.db[k]; if not c then return dr or 0.64, dg or 0.38, db or 0.89 end; return c.r or dr, c.g or dg, c.b or db end

-- [[ STEALTH SETTINGS ]] ----------------------------------------------------
local function AddStealthSettings(cat, prefix)
    local function K(key) return prefix .. key:sub(1,1):upper() .. key:sub(2) end
    local function DefaultFor(key, fallback)
        local v = ns.Defaults and ns.Defaults[key]
        return v ~= nil and v or fallback
    end
    local function Refresh()
        if ns.Modules.Stealth and ns.Modules.Stealth.RefreshVisuals then ns.Modules.Stealth.RefreshVisuals(true) end
    end

    -- Floating Text Section
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
        getColor = function(key) local def = ns.Defaults and ns.Defaults[key] or { r = 0.64, g = 0.38, b = 0.89 }; return GetColor(key, def.r, def.g, def.b) end,
        getDefaultColor = function(key) local def = ns.Defaults and ns.Defaults[key] or { r = 0.64, g = 0.38, b = 0.89 }; return def.r, def.g, def.b end,
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
        default = DefaultFor(K("iconX"), 0),
        get = function() return G(K("iconX"), DefaultFor(K("iconX"), 0)) end,
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
        default = DefaultFor(K("iconSize"), 64),
        get = function() return G(K("iconSize"), DefaultFor(K("iconSize"), 64)) end,
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
        getColor = function(key) local def = ns.Defaults and ns.Defaults[key] or { r = 0.64, g = 0.38, b = 0.89 }; return GetColor(key, def.r, def.g, def.b) end,
        getDefaultColor = function(key) local def = ns.Defaults and ns.Defaults[key] or { r = 0.64, g = 0.38, b = 0.89 }; return def.r, def.g, def.b end,
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

-- [[ POISON SETTINGS ]] -----------------------------------------------------
local function AddPoisonSettings(cat, prefix, title)
    local function K(key) return prefix .. key:sub(1,1):upper() .. key:sub(2) end
    local function DefaultFor(key, fallback)
        local v = ns.Defaults and ns.Defaults[key]
        return v ~= nil and v or fallback
    end
    local function Refresh()
        if ns.Modules.Poisons and ns.Modules.Poisons.RefreshVisuals then ns.Modules.Poisons.RefreshVisuals(true) end
    end

    SettingsLib:CreateHeader(cat, { name = title })

    -- Individual Management for each poison type
    SettingsLib:CreateCheckbox(cat, {
        key = K("enabled"), name = ns.L and ns.L.Enable or "Enable",
        default = DefaultFor(K("enabled"), true),
        get = function() return G(K("enabled"), DefaultFor(K("enabled"), true)) end,
        set = function(v) ns.db[K("enabled")] = v; Refresh() end,
    })
    SettingsLib:CreateCheckbox(cat, {
        key = K("onlyCombat"), name = ns.L and ns.L.OnlyInCombat or "Only in combat",
        default = DefaultFor(K("onlyCombat"), false),
        get = function() return G(K("onlyCombat"), DefaultFor(K("onlyCombat"), false)) end,
        set = function(v) ns.db[K("onlyCombat")] = v; Refresh() end,
    })
    SettingsLib:CreateCheckbox(cat, {
        key = K("onlyInstances"), name = ns.L and ns.L.OnlyInInstances or "Only in instances",
        default = DefaultFor(K("onlyInstances"), false),
        get = function() return G(K("onlyInstances"), DefaultFor(K("onlyInstances"), false)) end,
        set = function(v) ns.db[K("onlyInstances")] = v; Refresh() end,
    })

    -- Instance Filter Section (Dungeon/Raid) inside an expandable group
    -- Instance Filter Group
    local iSection = SettingsLib:CreateExpandableSection(cat, { name = ns.L and ns.L.InstanceFilters or "Instance Filters", expanded = false })
    SettingsLib:CreateCheckbox(cat, {
        key = K("disableInDungeons"), name = ns.L and ns.L.DisableInDungeons or "Disable in Dungeons",
        default = DefaultFor(K("disableInDungeons"), false),
        get = function() return G(K("disableInDungeons"), DefaultFor(K("disableInDungeons"), false)) end,
        set = function(v) ns.db[K("disableInDungeons")] = v; Refresh() end,
        parentSection = iSection,
    })
    SettingsLib:CreateCheckbox(cat, {
        key = K("disableInRaids"), name = ns.L and ns.L.DisableInRaids or "Disable in Raids",
        default = DefaultFor(K("disableInRaids"), false),
        get = function() return G(K("disableInRaids"), DefaultFor(K("disableInRaids"), false)) end,
        set = function(v) ns.db[K("disableInRaids")] = v; Refresh() end,
        parentSection = iSection,
    })

    -- Customization sections (Text, Icon, Sound)
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
        getColor = function(key) local def = ns.Defaults and ns.Defaults[key] or { r = 1, g = 0.2, b = 0.2 }; return GetColor(key, def.r, def.g, def.b) end,
        getDefaultColor = function(key) local def = ns.Defaults and ns.Defaults[key] or { r = 1, g = 0.2, b = 0.2 }; return def.r, def.g, def.b end,
        setColor = function(key, r, g, b) ns.db[key] = { r = r, g = g, b = b }; Refresh() end,
        parentSection = textSection,
    })
    SettingsLib:CreateSlider(cat, {
        key = K("textSize"), name = ns.L and ns.L.Size or "Size", min = 10, max = 100, step = 1,
        default = DefaultFor(K("textSize"), 28),
        get = function() return G(K("textSize"), DefaultFor(K("textSize"), 28)) end,
        set = function(v) ns.db[K("textSize")] = v; Refresh() end,
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
        default = DefaultFor(K("iconTexture"), ""),
        get = function() return G(K("iconTexture"), DefaultFor(K("iconTexture"), "")) end,
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
    SettingsLib:CreateSlider(cat, {
        key = K("iconX"), name = ns.L and ns.L.OffsetX or "Offset X", min = -1200, max = 1200, step = 1,
        default = DefaultFor(K("iconX"), -45),
        get = function() return G(K("iconX"), DefaultFor(K("iconX"), -45)) end,
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

    local soundSection = SettingsLib:CreateExpandableSection(cat, { name = ns.L and ns.L.Sound or "Sound", expanded = false })
    SettingsLib:CreateCheckbox(cat, {
        key = K("enableSound"), name = ns.L and ns.L.Enable or "Enable",
        default = DefaultFor(K("enableSound"), true),
        get = function() return G(K("enableSound"), DefaultFor(K("enableSound"), true)) end,
        set = function(v) ns.db[K("enableSound")] = v; Refresh() end,
        parentSection = soundSection,
    })
    SettingsLib:CreateInput(cat, {
        key = K("soundKit"), name = ns.L and ns.L.SoundKitId or "Sound Kit ID",
        default = DefaultFor(K("soundKit"), 8959),
        get = function() return G(K("soundKit"), DefaultFor(K("soundKit"), 8959)) end,
        set = function(v) ns.db[K("soundKit")] = tonumber(v) or 8959; Refresh() end,
        numeric = true,
        parentSection = soundSection,
    })
    SettingsLib:CreateButton(cat, {
        text = ns.L and ns.L.TestSound or "Test Sound",
        func = function()
            local kit = ns.db[K("soundKit")] or 8959
            if kit and PlaySound then PlaySound(kit, "Master") end
        end,
        parentSection = soundSection,
    })
end

-- ============================================================================
-- [[ INITIALIZATION ]] -------------------------------------------------------
-- ============================================================================
function ns.Modules.RogueSettings.Init(root)
    if not ns.IsRogue then return end

    local stealthCat = SettingsLib:CreateCategory(root, ns.L and ns.L.Stealth or "Stealth", false)
    SettingsLib:CreateHeader(stealthCat, { name = ns.L and ns.L.Management or "Management" })
    SettingsLib:CreateCheckbox(stealthCat, {
        key = "stealthEnabled", name = ns.L and ns.L.EnableOnStealth or "Enable on Stealth", default = true,
        get = function() return G("stealthEnabled", true) end,
        set = function(v) ns.db.stealthEnabled = v; if ns.UpdateState then ns.UpdateState(true) end end,
    })
    SettingsLib:CreateCheckbox(stealthCat, {
        key = "stealthUseStateDetection", name = ns.L and ns.L.StealthUseState or "Use State Detection", default = false,
        get = function() return G("stealthUseStateDetection", false) end,
        set = function(v) ns.db.stealthUseStateDetection = v; if ns.UpdateState then ns.UpdateState(true) end end,
    })
    
    -- Filter Trio: Instance on TOP, others in section
    SettingsLib:CreateCheckbox(stealthCat, {
        key = "stealthOnlyInstances", name = ns.L and ns.L.OnlyInInstances or "Only in instances", default = false,
        get = function() return G("stealthOnlyInstances", false) end,
        set = function(v) ns.db.stealthOnlyInstances = v; if ns.UpdateState then ns.UpdateState(true) end end,
    })
    local sFilterSection = SettingsLib:CreateExpandableSection(stealthCat, { name = ns.L and ns.L.InstanceFilters or "Instance Filters", expanded = false })
    SettingsLib:CreateCheckbox(stealthCat, {
        key = "stealthDisableInDungeons", name = ns.L and ns.L.DisableInDungeons or "Disable in Dungeons", default = false,
        get = function() return G("stealthDisableInDungeons", false) end,
        set = function(v) ns.db.stealthDisableInDungeons = v; if ns.UpdateState then ns.UpdateState(true) end end,
        parentSection = sFilterSection,
    })
    SettingsLib:CreateCheckbox(stealthCat, {
        key = "stealthDisableInRaids", name = ns.L and ns.L.DisableInRaids or "Disable in Raids", default = false,
        get = function() return G("stealthDisableInRaids", false) end,
        set = function(v) ns.db.stealthDisableInRaids = v; if ns.UpdateState then ns.UpdateState(true) end end,
        parentSection = sFilterSection,
    })
    AddStealthSettings(stealthCat, "stealth")

    local poisonCat = SettingsLib:CreateCategory(root, ns.L and ns.L.PoisonTracker or "Poison Tracker", false)
    AddPoisonSettings(poisonCat, "poisonLethal", ns.L and ns.L.LethalPoisons or "Lethal Poison")
    AddPoisonSettings(poisonCat, "poisonNonLethal", ns.L and ns.L.NonLethalPoisons or "Non-Lethal Poison")

    -- Shroud of Concealment
    local shroudCat = SettingsLib:CreateCategory(root, ns.L and ns.L.ShroudOfConcealment or "Shroud of Concealment", false)
    SettingsLib:CreateHeader(shroudCat, { name = ns.L and ns.L.Management or "Management" })
    SettingsLib:CreateCheckbox(shroudCat, {
        key = "shroudCountdown", name = ns.L and ns.L.EnableShroudCountdown or "Countdown in Chat", default = false,
        get = function() return G("shroudCountdown", false) end,
        set = function(v) ns.db.shroudCountdown = v end,
    })
    SettingsLib:CreateCheckbox(shroudCat, {
        key = "shroudOnlyInstances", name = ns.L and ns.L.OnlyInInstances or "Only in instances", default = true,
        get = function() return G("shroudOnlyInstances", true) end,
        set = function(v) ns.db.shroudOnlyInstances = v end,
    })
    local shrFilterSection = SettingsLib:CreateExpandableSection(shroudCat, { name = ns.L and ns.L.InstanceFilters or "Instance Filters", expanded = false })
    SettingsLib:CreateCheckbox(shroudCat, {
        key = "shroudDisableInDungeons", name = ns.L and ns.L.DisableInDungeons or "Disable in Dungeons", default = false,
        get = function() return G("shroudDisableInDungeons", false) end,
        set = function(v) ns.db.shroudDisableInDungeons = v end,
        parentSection = shrFilterSection,
    })
    SettingsLib:CreateCheckbox(shroudCat, {
        key = "shroudDisableInRaids", name = ns.L and ns.L.DisableInRaids or "Disable in Raids", default = false,
        get = function() return G("shroudDisableInRaids", false) end,
        set = function(v) ns.db.shroudDisableInRaids = v end,
        parentSection = shrFilterSection,
    })

    -- Shroud Messages
    SettingsLib:CreateHeader(shroudCat, { name = ns.L and ns.L.Messages or "Messages" })
    SettingsLib:CreateDropdown(shroudCat, {
        key = "shroudChannel", name = ns.L and ns.L.ChatChannel or "Chat Channel", values = ns.UI_CHANNELS, order = ns.UI_CHANNEL_ORDER, default = "SAY",
        get = function() return G("shroudChannel", "SAY") end,
        set = function(v) ns.db.shroudChannel = v end,
    })
    SettingsLib:CreateDropdown(shroudCat, {
        key = "shroudChannelFallback1", name = " ", values = ns.UI_CHANNELS, order = ns.UI_CHANNEL_ORDER, default = "PARTY",
        get = function() return G("shroudChannelFallback1", "PARTY") end,
        set = function(v) ns.db.shroudChannelFallback1 = v end,
    })
    SettingsLib:CreateDropdown(shroudCat, {
        key = "shroudChannelFallback2", name = " ", values = ns.UI_CHANNELS, order = ns.UI_CHANNEL_ORDER, default = "NONE",
        get = function() return G("shroudChannelFallback2", "NONE") end,
        set = function(v) ns.db.shroudChannelFallback2 = v end,
    })
    SettingsLib:CreateInput(shroudCat, {
        key = "shroudMessage", name = ns.L and ns.L.ShroudMessage or "Countdown Message", default = "%time",
        get = function() return G("shroudMessage", "%time") end,
        set = function(v) ns.db.shroudMessage = v end,
    })
    SettingsLib:CreateInput(shroudCat, {
        key = "shroudStartMsg", name = ns.L and ns.L.ShroudOnStart or "Start Message", default = "%time",
        get = function() return G("shroudStartMsg", "%time") end,
        set = function(v) ns.db.shroudStartMsg = v end,
    })
    SettingsLib:CreateInput(shroudCat, {
        key = "shroudEndMsg", name = ns.L and ns.L.ShroudOnEnd or "End Message", default = "%time",
        get = function() return G("shroudEndMsg", "%time") end,
        set = function(v) ns.db.shroudEndMsg = v end,
    })
    SettingsLib:CreateCheckbox(shroudCat, {
        key = "shroudInterval", name = ns.L and ns.L.ShroudInterval or "Interval Mode", default = false,
        get = function() return G("shroudInterval", false) end,
        set = function(v) ns.db.shroudInterval = v end,
    })
    SettingsLib:CreateCheckbox(shroudCat, {
        key = "shroudMuteErrors", name = ns.L and ns.L.ShroudMuteErrors or "Mute error messages", default = false,
        get = function() return G("shroudMuteErrors", false) end,
        set = function(v) ns.db.shroudMuteErrors = v end,
    })
    SettingsLib:CreateButton(shroudCat, {
        text = ns.L and ns.L.TestShroud or "Test Message",
        func = function() if ns.Modules.Shroud and ns.Modules.Shroud.TestMessage then ns.Modules.Shroud.TestMessage() end end,
    })

    -- Tricks of the Trade
    local tricksCat = SettingsLib:CreateCategory(root, ns.L and ns.L.TricksOfTheTrade or "Tricks of the Trade", false)
    SettingsLib:CreateHeader(tricksCat, { name = ns.L and ns.L.Management or "Management" })
    
    SettingsLib:CreateButton(tricksCat, {
        text = ns.L and ns.L.MacroBtnEnable or "Activate & Sync Macro",
        func = function()
            if InCombatLockdown() then
                print(ns.GetAddonName() .. ": " .. (ns.L and ns.L.DebugCombatLock or "This action cannot be used in combat."))
                return
            end
            if ns.db.tricksEnabled then
                print(ns.GetAddonName() .. ": " .. (ns.L and ns.L.TricksAlreadyEnabled or "Tricks of the Trade system is already enabled."))
            else
                ns.db.tricksEnabled = true
                print(ns.GetAddonName() .. ": |cff00ff00" .. (ns.L and ns.L.TricksMsgEnabled or "Tricks system activated and macro synchronized.") .. "|r")
                if ns.Modules.Tricks and ns.Modules.Tricks.UpdateMacro then ns.Modules.Tricks.UpdateMacro(true) end
                if ns.UpdateState then ns.UpdateState(true) end
            end
        end,
    })
    SettingsLib:CreateButton(tricksCat, {
        text = ns.L and ns.L.MacroBtnDisable or "Deactivate & Remove Macro",
        func = function()
            if InCombatLockdown() then
                print(ns.GetAddonName() .. ": " .. (ns.L and ns.L.DebugCombatLock or "This action cannot be used in combat."))
                return
            end
            if not ns.db.tricksEnabled then
                print(ns.GetAddonName() .. ": " .. (ns.L and ns.L.TricksAlreadyDisabled or "Tricks of the Trade system is already disabled."))
            else
                print(ns.GetAddonName() .. ": |cffff2020" .. (ns.L and ns.L.TricksMsgDisabled or "Tricks system deactivated and macro removed.") .. "|r")
                if ns.Modules.Tricks and ns.Modules.Tricks.DisableAndRemoveMacro then ns.Modules.Tricks.DisableAndRemoveMacro() end
                if ns.UpdateState then ns.UpdateState(true) end
            end
        end,
    })
    SettingsLib:CreateText(tricksCat, {
        text = (ns.L and ns.L.MacroAutoUpdateWarning) or "|cffffa500Nightveil automatically updates this macro.|r",
        small = true,
    })
    SettingsLib:CreateCheckbox(tricksCat, {
        key = "tricksMute", name = ns.L and ns.L.MuteChanges or "Mute Changes", default = false,
        get = function() return G("tricksMute", false) end,
        set = function(v) ns.db.tricksMute = v end,
    })
    SettingsLib:CreateHeader(tricksCat, { name = ns.L and ns.L.MacroTargetHeader or "Target" })
    SettingsLib:CreateCheckbox(tricksCat, {
        key = "tricksUseMouseover", name = ns.L and ns.L.Mouseover or "Mouseover", default = false,
        get = function() return G("tricksUseMouseover", false) end,
        set = function(v) ns.db.tricksUseMouseover = v; if ns.Modules.Tricks and ns.Modules.Tricks.UpdateMacro then ns.Modules.Tricks.UpdateMacro(true) end end,
    })
    SettingsLib:CreateCheckbox(tricksCat, {
        key = "tricksUseFocus", name = ns.L and ns.L.Focus or "Focus", default = false,
        get = function() return G("tricksUseFocus", false) end,
        set = function(v) ns.db.tricksUseFocus = v; if ns.Modules.Tricks and ns.Modules.Tricks.UpdateMacro then ns.Modules.Tricks.UpdateMacro(true) end end,
    })
    SettingsLib:CreateDropdown(tricksCat, {
        key = "tricksLogic", name = ns.L and ns.L.MacroTargetSelector or "Target Selector", values = ns.UI_TRICKS_LOGIC_OPTIONS, order = ns.UI_TRICKS_LOGIC_ORDER, default = "TANK",
        get = function() return G("tricksLogic", "TANK") end,
        set = function(v) ns.db.tricksLogic = v; if ns.Modules.Tricks and ns.Modules.Tricks.UpdateMacro then ns.Modules.Tricks.UpdateMacro(true) end end,
    })
    SettingsLib:CreateInput(tricksCat, {
        key = "tricksCustomName", name = ns.L and ns.L.MacroCustomName or "Custom Target", default = "",
        get = function() return G("tricksCustomName", "") end,
        set = function(v) ns.db.tricksCustomName = v; ns.db.tricksLogic = "CUSTOM"; if ns.Modules.Tricks and ns.Modules.Tricks.UpdateMacro then ns.Modules.Tricks.UpdateMacro(true) end end,
    })
    SettingsLib:CreateCheckbox(tricksCat, {
        key = "tricksDelveCompanion", name = ns.L and ns.L.MacroDelveCompanion or "Delve Companion", default = true,
        get = function() return G("tricksDelveCompanion", true) end,
        set = function(v) ns.db.tricksDelveCompanion = v; if ns.Modules.Tricks and ns.Modules.Tricks.UpdateMacro then ns.Modules.Tricks.UpdateMacro(true) end end,
    })
end
