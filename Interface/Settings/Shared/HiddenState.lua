-- ============================================================================
-- [[ HIDDEN STATE SETTINGS ]] ------------------------------------------------
-- ============================================================================
local addonName, ns = ...
local SettingsLib = LibStub("LibEQOLSettingsMode-1.0")
SettingsLib:SetVariablePrefix("Nightveil_")

ns.Modules = ns.Modules or {}
ns.Modules.HiddenStateSettings = {}

local G = ns.Modules.Settings and ns.Modules.Settings.Get or function(k, d) return ns.db and ns.db[k] or d end
local GetColor = ns.Modules.Settings and ns.Modules.Settings.GetColor or function(k, dr, dg, db) local c = ns.db and ns.db[k]; if not c then return dr or 0.64, dg or 0.38, db or 0.89 end; return c.r or dr, c.g or dg, c.b or db end

local function Refresh()
    if ns.Modules.HiddenState and ns.Modules.HiddenState.RefreshVisuals then ns.Modules.HiddenState.RefreshVisuals(true) end
end

local function DefaultFor(key, fallback)
    local v = ns.Defaults and ns.Defaults[key]
    return v ~= nil and v or fallback
end

function ns.Modules.HiddenStateSettings.Init(root)
    local stealthCat = SettingsLib:CreateCategory(root, ns.L and ns.L.HiddenStateName or "Hidden State", false)
    
    SettingsLib:CreateHeader(stealthCat, { name = ns.L and ns.L.Management or "Management" })
    SettingsLib:CreateCheckbox(stealthCat, {
        key = "hiddenStateEnabled", name = ns.L and ns.L.EnableOnHiddenState or "Enable on Hidden State", default = true,
        get = function() return G("hiddenStateEnabled", true) end,
        set = function(v) ns.db.hiddenStateEnabled = v; if ns.UpdateState then ns.UpdateState(true) end end,
        desc = ns.L and ns.L.EnableOnHiddenStateDesc or "Enables or disables visual alerts for most invisibility and stealth states.",
    })

    local classPrefix = (ns.IsRogue and "Rogue") or (ns.IsHunter and "Hunter") or (ns.IsDruid and "Druid") or (ns.IsMage and "Mage")
    local aurasToBuild = {}
    if classPrefix and ns.HiddenStateMeta[classPrefix] then
        for _, a in ipairs(ns.HiddenStateMeta[classPrefix]) do table.insert(aurasToBuild, a) end
    end
    if ns.HasShadowmeld and ns.HiddenStateMeta.Shadowmeld then
        for _, a in ipairs(ns.HiddenStateMeta.Shadowmeld) do table.insert(aurasToBuild, a) end
    end

    if #aurasToBuild > 0 then
        local auraSection = SettingsLib:CreateExpandableSection(stealthCat, { name = ns.L and ns.L.AuraDetections or "Aura Detections", expanded = true })
        for _, auraDef in ipairs(aurasToBuild) do
            SettingsLib:CreateCheckbox(stealthCat, {
                key = "hiddenStateAura" .. auraDef.key .. "Enabled", name = auraDef.name, default = true,
                get = function() return G("hiddenStateAura" .. auraDef.key .. "Enabled", true) end,
                set = function(v) ns.db["hiddenStateAura" .. auraDef.key .. "Enabled"] = v; Refresh() end,
                desc = string.format(ns.L and ns.L.HiddenStateAuraTrackDesc or "Detects and tracks specifically the aura of %s.", auraDef.name),
                parentSection = auraSection,
            })
        end
    end

    local sFilterSection = SettingsLib:CreateExpandableSection(stealthCat, { name = ns.L and ns.L.InstanceFilters or "Instance Filters", expanded = false })
    SettingsLib:CreateCheckbox(stealthCat, {
        key = "hiddenStateOnlyInstances", name = ns.L and ns.L.OnlyInInstances or "Only in instances", default = false,
        get = function() return G("hiddenStateOnlyInstances", false) end,
        set = function(v) ns.db.hiddenStateOnlyInstances = v; if ns.UpdateState then ns.UpdateState(true) end end,
        desc = ns.L and ns.L.OnlyInInstancesDesc or "Displays alerts only inside instances like Dungeons or Raids.",
        parentSection = sFilterSection,
    })
    SettingsLib:CreateCheckbox(stealthCat, {
        key = "hiddenStateDisableInDungeons", name = ns.L and ns.L.DisableInDungeons or "Disable in Dungeons", default = false,
        get = function() return G("hiddenStateDisableInDungeons", false) end,
        set = function(v) ns.db.hiddenStateDisableInDungeons = v; if ns.UpdateState then ns.UpdateState(true) end end,
        desc = ns.L and ns.L.HiddenStateDisableInDungeonsDesc or "Do not show visual tracking when inside Dungeons.",
        parentSection = sFilterSection,
    })
    SettingsLib:CreateCheckbox(stealthCat, {
        key = "hiddenStateDisableInRaids", name = ns.L and ns.L.DisableInRaids or "Disable in Raids", default = false,
        get = function() return G("hiddenStateDisableInRaids", false) end,
        set = function(v) ns.db.hiddenStateDisableInRaids = v; if ns.UpdateState then ns.UpdateState(true) end end,
        desc = ns.L and ns.L.HiddenStateDisableInRaidsDesc or "Do not show visual tracking when inside Raids.",
        parentSection = sFilterSection,
    })

    -- [[ DISTRIBUTION GROUPS ]] ----------------------------------------------
    
    -- Generic Text & Auras Text
    local textSection = SettingsLib:CreateExpandableSection(stealthCat, { name = ns.L and ns.L.FloatingText or "Floating Text", expanded = false })
    SettingsLib:CreateCheckbox(stealthCat, {
        key = "hiddenStateEnableText", name = ns.L and ns.L.Enable or "Enable",
        default = DefaultFor("hiddenStateEnableText", false),
        get = function() return G("hiddenStateEnableText", false) end,
        set = function(v) ns.db.hiddenStateEnableText = v; Refresh() end,
        desc = ns.L and ns.L.HiddenStateEnableTextDesc or "Displays an animated text element when hidden state triggers.",
        parentSection = textSection,
    })
    SettingsLib:CreateInput(stealthCat, {
        key = "hiddenStateCustomText", name = ns.L and ns.L.CustomText or "Custom Text",
        default = DefaultFor("hiddenStateCustomText", ""),
        get = function() return G("hiddenStateCustomText", "") end,
        set = function(v) ns.db.hiddenStateCustomText = v; Refresh() end,
        desc = ns.L and ns.L.HiddenStateCustomTextDesc or "Fallback text displayed if no specific aura overrides it.",
        parentSection = textSection,
    })
    
    local textColors = { { key = "hiddenStateTextColor", label = ns.L and ns.L.Color or "Color" } }
    
    if #aurasToBuild > 0 then
        for _, auraDef in ipairs(aurasToBuild) do
            SettingsLib:CreateInput(stealthCat, {
                key = "hiddenStateAura" .. auraDef.key .. "Text", name = string.format(ns.L and ns.L.TextOfSkill or "%s Text", auraDef.name), default = auraDef.text,
                get = function() return G("hiddenStateAura" .. auraDef.key .. "Text", auraDef.text) end,
                set = function(v) ns.db["hiddenStateAura" .. auraDef.key .. "Text"] = v; Refresh() end,
                desc = string.format(ns.L and ns.L.HiddenStateAuraTextDesc or "Specific text displayed when %s is active. Leave empty to ignore.", auraDef.name),
                parentSection = textSection,
            })
            table.insert(textColors, { key = "hiddenStateAura" .. auraDef.key .. "TextColor", label = string.format(ns.L and ns.L.ColorOfSkill or "%s Color", auraDef.name) })
        end
    end

    SettingsLib:CreateColorOverrides(stealthCat, {
        entries = textColors,
        getColor = function(key) 
            local def = { r = 0.420, g = 0.518, b = 0.647 }
            if key ~= "hiddenStateTextColor" then
                for _, a in ipairs(aurasToBuild) do
                    if key == ("hiddenStateAura" .. a.key .. "TextColor") and a.color then
                        def = a.color
                        break
                    end
                end
            else
                def = ns.Defaults and ns.Defaults[key] or def
            end
            return GetColor(key, def.r, def.g, def.b) 
        end,
        getDefaultColor = function(key) 
            local def = { r = 0.420, g = 0.518, b = 0.647 }
            if key ~= "hiddenStateTextColor" then
                for _, a in ipairs(aurasToBuild) do
                    if key == ("hiddenStateAura" .. a.key .. "TextColor") and a.color then
                        def = a.color
                        break
                    end
                end
            else
                def = ns.Defaults and ns.Defaults[key] or def
            end
            return def.r, def.g, def.b 
        end,
        setColor = function(key, r, g, b) ns.db[key] = { r = r, g = g, b = b }; Refresh() end,
        parentSection = textSection,
    })
    
    SettingsLib:CreateSlider(stealthCat, {
        key = "hiddenStateTextAlpha", name = ns.L and ns.L.Opacity or "Opacity", min = 0, max = 1, step = 0.05,
        default = DefaultFor("hiddenStateTextAlpha", 1),
        get = function() return G("hiddenStateTextAlpha", 1) end,
        set = function(v) ns.db.hiddenStateTextAlpha = v; Refresh() end,
        desc = ns.L and ns.L.HiddenStateTextAlphaDesc or "Controls the transparency of the floating text.",
        parentSection = textSection,
    })
    SettingsLib:CreateSlider(stealthCat, {
        key = "hiddenStateTextX", name = ns.L and ns.L.OffsetX or "Offset X", min = -1200, max = 1200, step = 1,
        default = DefaultFor("hiddenStateTextX", 0),
        get = function() return G("hiddenStateTextX", 0) end,
        set = function(v) ns.db.hiddenStateTextX = v; Refresh() end,
        desc = ns.L and ns.L.HiddenStateTextXDesc or "Controls the horizontal position of the text.",
        parentSection = textSection,
    })
    SettingsLib:CreateSlider(stealthCat, {
        key = "hiddenStateTextY", name = ns.L and ns.L.OffsetY or "Offset Y", min = -600, max = 600, step = 1,
        default = DefaultFor("hiddenStateTextY", 185),
        get = function() return G("hiddenStateTextY", 185) end,
        set = function(v) ns.db.hiddenStateTextY = v; Refresh() end,
        desc = ns.L and ns.L.HiddenStateTextYDesc or "Controls the vertical position of the text.",
        parentSection = textSection,
    })
    SettingsLib:CreateSlider(stealthCat, {
        key = "hiddenStateTextSize", name = ns.L and ns.L.Size or "Size", min = 10, max = 100, step = 1,
        default = DefaultFor("hiddenStateTextSize", 28),
        get = function() return G("hiddenStateTextSize", 28) end,
        set = function(v) ns.db.hiddenStateTextSize = v; Refresh() end,
        desc = ns.L and ns.L.HiddenStateTextSizeDesc or "Adjusts the scale/font size of the text.",
        parentSection = textSection,
    })

    -- Generic Icon & Auras Icon
    local iconSection = SettingsLib:CreateExpandableSection(stealthCat, { name = ns.L and ns.L.IndicatorIcon or "Indicator Icon", expanded = false })
    SettingsLib:CreateCheckbox(stealthCat, {
        key = "hiddenStateEnableIcon", name = ns.L and ns.L.Enable or "Enable",
        default = DefaultFor("hiddenStateEnableIcon", false),
        get = function() return G("hiddenStateEnableIcon", false) end,
        set = function(v) ns.db.hiddenStateEnableIcon = v; Refresh() end,
        desc = ns.L and ns.L.HiddenStateEnableIconDesc or "Shows a texture icon alongside the text.",
        parentSection = iconSection,
    })
    SettingsLib:CreateInput(stealthCat, {
        key = "hiddenStateIconTexture", name = ns.L and ns.L.IconTexture or "Icon Texture",
        default = DefaultFor("hiddenStateIconTexture", "Interface\\Icons\\Ability_Stealth"),
        get = function() return G("hiddenStateIconTexture", "Interface\\Icons\\Ability_Stealth") end,
        set = function(v) ns.db.hiddenStateIconTexture = v; Refresh() end,
        desc = ns.L and ns.L.HiddenStateIconTextureDesc or "Generic fallback icon path.",
        parentSection = iconSection,
    })
    
    if #aurasToBuild > 0 then
        for _, auraDef in ipairs(aurasToBuild) do
            SettingsLib:CreateInput(stealthCat, {
                key = "hiddenStateAura" .. auraDef.key .. "IconTexture", name = string.format(ns.L and ns.L.IconOfSkill or "%s Icon", auraDef.name), default = auraDef.icon,
                get = function() return G("hiddenStateAura" .. auraDef.key .. "IconTexture", auraDef.icon) end,
                set = function(v) ns.db["hiddenStateAura" .. auraDef.key .. "IconTexture"] = v; Refresh() end,
                desc = string.format(ns.L and ns.L.HiddenStateAuraIconDesc or "Texture path to use for %s.", auraDef.name),
                parentSection = iconSection,
            })
        end
    end

    SettingsLib:CreateCheckbox(stealthCat, {
        key = "hiddenStateIconAnchorToText", name = ns.L and ns.L.AnchorToText or "Anchor to Text",
        default = DefaultFor("hiddenStateIconAnchorToText", true),
        get = function() return G("hiddenStateIconAnchorToText", true) end,
        set = function(v) ns.db.hiddenStateIconAnchorToText = v; Refresh() end,
        desc = ns.L and ns.L.HiddenStateIconAnchorDesc or "Automatically attaches the icon to the floating text.",
        parentSection = iconSection,
    })
    SettingsLib:CreateDropdown(stealthCat, {
        key = "hiddenStateIconAnchorPoint", name = ns.L and ns.L.AnchorPoint or "Anchor Point", values = ns.UI_ANCHOR_MAP, order = ns.UI_ANCHOR_ORDER,
        default = DefaultFor("hiddenStateIconAnchorPoint", "LEFT"),
        get = function() return G("hiddenStateIconAnchorPoint", "LEFT") end,
        set = function(v) ns.db.hiddenStateIconAnchorPoint = v; Refresh() end,
        desc = ns.L and ns.L.HiddenStateIconAnchorPointDesc or "Positional anchor for the icon element.",
        parentSection = iconSection,
    })
    SettingsLib:CreateSlider(stealthCat, {
        key = "hiddenStateIconX", name = ns.L and ns.L.OffsetX or "Offset X", min = -1200, max = 1200, step = 1,
        default = DefaultFor("hiddenStateIconX", -5),
        get = function() return G("hiddenStateIconX", -5) end,
        set = function(v) ns.db.hiddenStateIconX = v; Refresh() end,
        desc = ns.L and ns.L.HiddenStateIconXDesc or "Horizontal spacing offset for the icon.",
        parentSection = iconSection,
    })
    SettingsLib:CreateSlider(stealthCat, {
        key = "hiddenStateIconY", name = ns.L and ns.L.OffsetY or "Offset Y", min = -600, max = 600, step = 1,
        default = DefaultFor("hiddenStateIconY", 0),
        get = function() return G("hiddenStateIconY", 0) end,
        set = function(v) ns.db.hiddenStateIconY = v; Refresh() end,
        desc = ns.L and ns.L.HiddenStateIconYDesc or "Vertical spacing offset for the icon.",
        parentSection = iconSection,
    })
    SettingsLib:CreateSlider(stealthCat, {
        key = "hiddenStateIconSize", name = ns.L and ns.L.Size or "Size", min = 16, max = 150, step = 1,
        default = DefaultFor("hiddenStateIconSize", 36),
        get = function() return G("hiddenStateIconSize", 36) end,
        set = function(v) ns.db.hiddenStateIconSize = v; Refresh() end,
        desc = ns.L and ns.L.HiddenStateIconSizeDesc or "Scale thickness of the indicator icon.",
        parentSection = iconSection,
    })
    SettingsLib:CreateSlider(stealthCat, {
        key = "hiddenStateIconAlpha", name = ns.L and ns.L.Opacity or "Opacity", min = 0, max = 1, step = 0.05,
        default = DefaultFor("hiddenStateIconAlpha", 1),
        get = function() return G("hiddenStateIconAlpha", 1) end,
        set = function(v) ns.db.hiddenStateIconAlpha = v; Refresh() end,
        desc = ns.L and ns.L.HiddenStateIconAlphaDesc or "Transparency of the indicator icon.",
        parentSection = iconSection,
    })

    -- Generic Screen Color & Auras Screen Color
    local screenSection = SettingsLib:CreateExpandableSection(stealthCat, { name = ns.L and ns.L.ScreenColor or "Screen Color", expanded = false })
    SettingsLib:CreateCheckbox(stealthCat, {
        key = "hiddenStateEnableScreenColor", name = ns.L and ns.L.Enable or "Enable",
        default = DefaultFor("hiddenStateEnableScreenColor", true),
        get = function() return G("hiddenStateEnableScreenColor", true) end,
        set = function(v) ns.db.hiddenStateEnableScreenColor = v; Refresh() end,
        desc = ns.L and ns.L.HiddenStateScreenEnableDesc or "Applies a full-screen color tint when stealth state is active.",
        parentSection = screenSection,
    })
    
    local screenColors = { { key = "hiddenStateScreenColor", label = ns.L and ns.L.Color or "Color" } }
    
    if #aurasToBuild > 0 then
        for _, auraDef in ipairs(aurasToBuild) do
            table.insert(screenColors, { key = "hiddenStateAura" .. auraDef.key .. "ScreenColor", label = string.format(ns.L and ns.L.ScreenColorOfSkill or "%s Screen Color", auraDef.name) })
        end
    end

    SettingsLib:CreateColorOverrides(stealthCat, {
        entries = screenColors,
        getColor = function(key) 
            local def = { r = 0.420, g = 0.518, b = 0.647 }
            if key ~= "hiddenStateScreenColor" then
                for _, a in ipairs(aurasToBuild) do
                    if key == ("hiddenStateAura" .. a.key .. "ScreenColor") and a.screenColor then
                        def = a.screenColor
                        break
                    end
                end
            else
                def = ns.Defaults and ns.Defaults[key] or def
            end
            return GetColor(key, def.r, def.g, def.b) 
        end,
        getDefaultColor = function(key) 
            local def = { r = 0.420, g = 0.518, b = 0.647 }
            if key ~= "hiddenStateScreenColor" then
                for _, a in ipairs(aurasToBuild) do
                    if key == ("hiddenStateAura" .. a.key .. "ScreenColor") and a.screenColor then
                        def = a.screenColor
                        break
                    end
                end
            else
                def = ns.Defaults and ns.Defaults[key] or def
            end
            return def.r, def.g, def.b 
        end,
        setColor = function(key, r, g, b) ns.db[key] = { r = r, g = g, b = b }; Refresh() end,
        parentSection = screenSection,
    })
    SettingsLib:CreateSlider(stealthCat, {
        key = "hiddenStateScreenAlpha", name = ns.L and ns.L.Opacity or "Opacity", min = 0, max = 1, step = 0.05,
        default = DefaultFor("hiddenStateScreenAlpha", 0.1),
        get = function() return G("hiddenStateScreenAlpha", 0.1) end,
        set = function(v) ns.db.hiddenStateScreenAlpha = v; Refresh() end,
        desc = ns.L and ns.L.HiddenStateScreenAlphaDesc or "Maximum transparency tint intensity of the screen color.",
        parentSection = screenSection,
    })
    SettingsLib:CreateDropdown(stealthCat, {
        key = "hiddenStateScreenStrata", name = ns.L and ns.L.Layer or "Layer", values = ns.UI_LAYER_MAP, order = ns.UI_LAYER_ORDER,
        default = DefaultFor("hiddenStateScreenStrata", "BACKGROUND"),
        get = function() return G("hiddenStateScreenStrata", "BACKGROUND") end,
        set = function(v) ns.db.hiddenStateScreenStrata = v; Refresh() end,
        desc = ns.L and ns.L.LayerDesc or "Drawing layer (higher values appear above).",
        parentSection = screenSection,
    })

    -- Generic Vignette
    local vigSection = SettingsLib:CreateExpandableSection(stealthCat, { name = ns.L and ns.L.Vignette or "Vignette", expanded = false })
    SettingsLib:CreateCheckbox(stealthCat, {
        key = "hiddenStateEnableVignette", name = ns.L and ns.L.Enable or "Enable",
        default = DefaultFor("hiddenStateEnableVignette", false),
        get = function() return G("hiddenStateEnableVignette", false) end,
        set = function(v) ns.db.hiddenStateEnableVignette = v; Refresh() end,
        desc = ns.L and ns.L.HiddenStateVignetteEnableDesc or "Displays an immersive dark edge shadow (vignette).",
        parentSection = vigSection,
    })
    SettingsLib:CreateSlider(stealthCat, {
        key = "hiddenStateVignetteSize", name = ns.L and ns.L.Thickness or "Thickness", min = 50, max = 500, step = 5,
        default = DefaultFor("hiddenStateVignetteSize", 200),
        get = function() return G("hiddenStateVignetteSize", 200) end,
        set = function(v) ns.db.hiddenStateVignetteSize = v; Refresh() end,
        desc = ns.L and ns.L.HiddenStateVignetteSizeDesc or "Width/Inward span length of the screen vignette border.",
        parentSection = vigSection,
    })
    SettingsLib:CreateSlider(stealthCat, {
        key = "hiddenStateVignetteAlpha", name = ns.L and ns.L.Opacity or "Opacity", min = 0, max = 1, step = 0.05,
        default = DefaultFor("hiddenStateVignetteAlpha", 0.8),
        get = function() return G("hiddenStateVignetteAlpha", 0.8) end,
        set = function(v) ns.db.hiddenStateVignetteAlpha = v; Refresh() end,
        desc = ns.L and ns.L.HiddenStateVignetteAlphaDesc or "Maximum transparency intensity of the vignette overlay.",
        parentSection = vigSection,
    })
    SettingsLib:CreateDropdown(stealthCat, {
        key = "hiddenStateVignetteStrata", name = ns.L and ns.L.Layer or "Layer", values = ns.UI_LAYER_MAP, order = ns.UI_LAYER_ORDER,
        default = DefaultFor("hiddenStateVignetteStrata", "BACKGROUND"),
        get = function() return G("hiddenStateVignetteStrata", "BACKGROUND") end,
        set = function(v) ns.db.hiddenStateVignetteStrata = v; Refresh() end,
        desc = ns.L and ns.L.LayerDesc or "Drawing layer (higher values appear above).",
        parentSection = vigSection,
    })

end
