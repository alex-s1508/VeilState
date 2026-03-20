-- ============================================================================
-- [[ NIGHTVEIL — HUNTER SETTINGS UI ]] --------------------------------------
-- ============================================================================
local addonName, ns = ...
local SettingsLib = LibStub("LibEQOLSettingsMode-1.0")
SettingsLib:SetVariablePrefix("Nightveil_")

ns.Modules = ns.Modules or {}
ns.Modules.HunterSettings = {}

-- [[ UI BUILDERS ]] ----------------------------------------------------------

local G = ns.Modules.Settings and ns.Modules.Settings.Get or function(k, d) return ns.db and ns.db[k] or d end
local GetColor = ns.Modules.Settings and ns.Modules.Settings.GetColor or function(k, dr, dg, db) local c = ns.db and ns.db[k]; if not c then return dr or 0.478, dg or 0.878, db or 0.267 end; return c.r or dr, c.g or dg, c.b or db end

-- [[ CAMOUFLAGE SETTINGS ]] --------------------------------------------------
local function AddCamouflageSettings(cat, prefix)
    local function K(key) return prefix .. key:sub(1,1):upper() .. key:sub(2) end
    local function DefaultFor(key, fallback)
        local v = ns.Defaults and ns.Defaults[key]
        return v ~= nil and v or fallback
    end
    local function Refresh()
        if ns.Modules.Camouflage and ns.Modules.Camouflage.RefreshVisuals then ns.Modules.Camouflage.RefreshVisuals(true) end
    end

    -- Floating Text Section
    local textSection = SettingsLib:CreateExpandableSection(cat, { name = ns.L and ns.L.FloatingText or "Floating Text", expanded = false })
    SettingsLib:CreateCheckbox(cat, {
        key = K("enableText"), name = ns.L and ns.L.Enable or "Enable",
        default = DefaultFor(K("enableText"), false),
        get = function() return G(K("enableText"), DefaultFor(K("enableText"), false)) end,
        set = function(v) ns.db[K("enableText")] = v; Refresh() end,
        parentSection = textSection,
    })
    SettingsLib:CreateInput(cat, {
        key = K("customText"), name = ns.L and ns.L.CustomText or "Custom Text",
        default = DefaultFor(K("customText"), "CAMOUFLAGED"),
        get = function() return G(K("customText"), DefaultFor(K("customText"), "CAMOUFLAGED")) end,
        set = function(v) ns.db[K("customText")] = v; Refresh() end,
        parentSection = textSection,
    })
    SettingsLib:CreateColorOverrides(cat, {
        entries = { { key = K("textColor"), label = ns.L and ns.L.Color or "Color" } },
        getColor = function(key) local def = ns.Defaults and ns.Defaults[key] or { r = 0.478, g = 0.878, b = 0.267 }; return GetColor(key, def.r, def.g, def.b) end,
        getDefaultColor = function(key) local def = ns.Defaults and ns.Defaults[key] or { r = 0.478, g = 0.878, b = 0.267 }; return def.r, def.g, def.b end,
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
        default = DefaultFor(K("enableIcon"), false),
        get = function() return G(K("enableIcon"), DefaultFor(K("enableIcon"), false)) end,
        set = function(v) ns.db[K("enableIcon")] = v; Refresh() end,
        parentSection = iconSection,
    })
    SettingsLib:CreateCheckbox(cat, {
        key = K("iconAnchorToText"), name = ns.L and ns.L.AnchorToText or "Anchor to Text",
        default = DefaultFor(K("iconAnchorToText"), false),
        get = function() return G(K("iconAnchorToText"), DefaultFor(K("iconAnchorToText"), false)) end,
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
        default = DefaultFor(K("enableScreenColor"), false),
        get = function() return G(K("enableScreenColor"), DefaultFor(K("enableScreenColor"), false)) end,
        set = function(v) ns.db[K("enableScreenColor")] = v; Refresh() end,
        parentSection = screenSection,
    })
    SettingsLib:CreateColorOverrides(cat, {
        entries = { { key = K("screenColor"), label = ns.L and ns.L.Color or "Color" } },
        getColor = function(key) local def = ns.Defaults and ns.Defaults[key] or { r = 0.478, g = 0.878, b = 0.267 }; return GetColor(key, def.r, def.g, def.b) end,
        getDefaultColor = function(key) local def = ns.Defaults and ns.Defaults[key] or { r = 0.478, g = 0.878, b = 0.267 }; return def.r, def.g, def.b end,
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
function ns.Modules.HunterSettings.Init(root)
    if not ns.IsHunter then return end

    -- Camouflage Category
    local camouflageCat = SettingsLib:CreateCategory(root, ns.L and ns.L.Camouflage or "Camouflage", false)
    SettingsLib:CreateHeader(camouflageCat, { name = ns.L and ns.L.Management or "Management" })
    SettingsLib:CreateCheckbox(camouflageCat, {
        key = "camouflageEnabled", name = ns.L and ns.L.EnableOnCamouflage or "Enable on Camouflage", default = true,
        get = function() return G("camouflageEnabled", true) end,
        set = function(v) ns.db.camouflageEnabled = v; if ns.UpdateState then ns.UpdateState(true) end end,
    })
    SettingsLib:CreateCheckbox(camouflageCat, {
        -- Global setting shared across all stealth-type modules
        key = "useStateDetection", name = ns.L and ns.L.StealthUseState or "Use State Detection", default = false,
        get = function() return G("useStateDetection", false) end,
        set = function(v) ns.db.useStateDetection = v; if ns.UpdateState then ns.UpdateState(true) end end,
    })
    SettingsLib:CreateCheckbox(camouflageCat, {
        key = "camouflageOnlyInstances", name = ns.L and ns.L.OnlyInInstances or "Only in instances", default = false,
        get = function() return G("camouflageOnlyInstances", false) end,
        set = function(v) ns.db.camouflageOnlyInstances = v; if ns.UpdateState then ns.UpdateState(true) end end,
    })
    local cFilterSection = SettingsLib:CreateExpandableSection(camouflageCat, { name = ns.L and ns.L.InstanceFilters or "Instance Filters", expanded = false })
    SettingsLib:CreateCheckbox(camouflageCat, {
        key = "camouflageDisableInDungeons", name = ns.L and ns.L.DisableInDungeons or "Disable in Dungeons", default = false,
        get = function() return G("camouflageDisableInDungeons", false) end,
        set = function(v) ns.db.camouflageDisableInDungeons = v; if ns.UpdateState then ns.UpdateState(true) end end,
        parentSection = cFilterSection,
    })
    SettingsLib:CreateCheckbox(camouflageCat, {
        key = "camouflageDisableInRaids", name = ns.L and ns.L.DisableInRaids or "Disable in Raids", default = false,
        get = function() return G("camouflageDisableInRaids", false) end,
        set = function(v) ns.db.camouflageDisableInRaids = v; if ns.UpdateState then ns.UpdateState(true) end end,
        parentSection = cFilterSection,
    })
    AddCamouflageSettings(camouflageCat, "camouflage")

    -- Misdirection Category
    local misdirCat = SettingsLib:CreateCategory(root, ns.L and ns.L.Misdirection or "Misdirection", false)
    SettingsLib:CreateHeader(misdirCat, { name = ns.L and ns.L.Management or "Management" })

    SettingsLib:CreateButton(misdirCat, {
        text = ns.L and ns.L.MacroBtnEnable or "Activate & Sync Macro",
        func = function()
            if InCombatLockdown() then
                print(ns.GetAddonName() .. ": " .. (ns.L and ns.L.DebugCombatLock or "This action cannot be used in combat."))
                return
            end
            if ns.db.misdirEnabled then
                print(ns.GetAddonName() .. ": " .. (ns.L and ns.L.MisdirectionAlreadyEnabled or "Misdirection system is already enabled."))
            else
                ns.db.misdirEnabled = true
                print(ns.GetAddonName() .. ": |cff00ff00" .. (ns.L and ns.L.MisdirectionMsgEnabled or "Misdirection system activated and macro synchronized.") .. "|r")
                if ns.Modules.Misdirection and ns.Modules.Misdirection.UpdateMacro then ns.Modules.Misdirection.UpdateMacro(true) end
                if ns.UpdateState then ns.UpdateState(true) end
            end
        end,
    })
    SettingsLib:CreateButton(misdirCat, {
        text = ns.L and ns.L.MacroBtnDisable or "Deactivate & Remove Macro",
        func = function()
            if InCombatLockdown() then
                print(ns.GetAddonName() .. ": " .. (ns.L and ns.L.DebugCombatLock or "This action cannot be used in combat."))
                return
            end
            if not ns.db.misdirEnabled then
                print(ns.GetAddonName() .. ": " .. (ns.L and ns.L.MisdirectionAlreadyDisabled or "Misdirection system is already disabled."))
            else
                print(ns.GetAddonName() .. ": |cffff2020" .. (ns.L and ns.L.MisdirectionMsgDisabled or "Misdirection system deactivated and macro removed.") .. "|r")
                if ns.Modules.Misdirection and ns.Modules.Misdirection.DisableAndRemoveMacro then ns.Modules.Misdirection.DisableAndRemoveMacro() end
                if ns.UpdateState then ns.UpdateState(true) end
            end
        end,
    })
    SettingsLib:CreateText(misdirCat, {
        text = ns.L and ns.L.MacroAutoUpdateWarning or "|cffffa500Nightveil automatically updates this macro.|r",
        small = true,
    })
    SettingsLib:CreateCheckbox(misdirCat, {
        key = "misdirMute", name = ns.L and ns.L.MuteChanges or "Mute Changes", default = false,
        get = function() return G("misdirMute", false) end,
        set = function(v) ns.db.misdirMute = v end,
    })
    SettingsLib:CreateHeader(misdirCat, { name = ns.L and ns.L.MacroTargetHeader or "Target" })
    SettingsLib:CreateCheckbox(misdirCat, {
        key = "misdirUseMouseover", name = ns.L and ns.L.Mouseover or "Mouseover", default = false,
        get = function() return G("misdirUseMouseover", false) end,
        set = function(v) ns.db.misdirUseMouseover = v; if ns.Modules.Misdirection and ns.Modules.Misdirection.UpdateMacro then ns.Modules.Misdirection.UpdateMacro(true) end end,
    })
    SettingsLib:CreateCheckbox(misdirCat, {
        key = "misdirUseFocus", name = ns.L and ns.L.Focus or "Focus", default = false,
        get = function() return G("misdirUseFocus", false) end,
        set = function(v) ns.db.misdirUseFocus = v; if ns.Modules.Misdirection and ns.Modules.Misdirection.UpdateMacro then ns.Modules.Misdirection.UpdateMacro(true) end end,
    })
    SettingsLib:CreateDropdown(misdirCat, {
        key = "misdirLogic", name = ns.L and ns.L.MacroTargetSelector or "Target Selector",
        values = ns.UI_MISDIR_LOGIC_OPTIONS, order = ns.UI_MISDIR_LOGIC_ORDER, default = "PET",
        get = function() return G("misdirLogic", "PET") end,
        set = function(v) ns.db.misdirLogic = v; if ns.Modules.Misdirection and ns.Modules.Misdirection.UpdateMacro then ns.Modules.Misdirection.UpdateMacro(true) end end,
    })
    SettingsLib:CreateInput(misdirCat, {
        key = "misdirCustomName", name = ns.L and ns.L.MacroCustomName or "Custom Target", default = "",
        get = function() return G("misdirCustomName", "") end,
        set = function(v) ns.db.misdirCustomName = v; ns.db.misdirLogic = "CUSTOM"; if ns.Modules.Misdirection and ns.Modules.Misdirection.UpdateMacro then ns.Modules.Misdirection.UpdateMacro(true) end end,
    })
    SettingsLib:CreateCheckbox(misdirCat, {
        key = "misdirDelveCompanion", name = ns.L and ns.L.MacroDelveCompanion or "Delve Companion", default = true,
        get = function() return G("misdirDelveCompanion", true) end,
        set = function(v) ns.db.misdirDelveCompanion = v; if ns.Modules.Misdirection and ns.Modules.Misdirection.UpdateMacro then ns.Modules.Misdirection.UpdateMacro(true) end end,
    })
end
