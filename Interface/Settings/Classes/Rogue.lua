-- ============================================================================
-- [[ ROGUE SETTINGS UI ]] ----------------------------------------------------
-- ============================================================================
local addonName, ns = ...
local SettingsLib = LibStub("LibEQOLSettingsMode-1.0")
SettingsLib:SetVariablePrefix("Nightveil_")

ns.Modules = ns.Modules or {}
ns.Modules.RogueSettings = {}

-- [[ UI BUILDERS ]] ----------------------------------------------------------

local G = ns.Modules.Settings and ns.Modules.Settings.Get or function(k, d) return ns.db and ns.db[k] or d end
local GetColor = ns.Modules.Settings and ns.Modules.Settings.GetColor or function(k, dr, dg, db) local c = ns.db and ns.db[k]; if not c then return dr or 0.64, dg or 0.38, db or 0.89 end; return c.r or dr, c.g or dg, c.b or db end

-- [[ POISON SETTINGS ]] -----------------------------------------------------
local function AddPoisonSettings(cat, prefix, title, desc)
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
        desc = desc,
    })
    SettingsLib:CreateCheckbox(cat, {
        key = K("onlyCombat"), name = ns.L and ns.L.OnlyInCombat or "Only in combat",
        default = DefaultFor(K("onlyCombat"), false),
        get = function() return G(K("onlyCombat"), DefaultFor(K("onlyCombat"), false)) end,
        set = function(v) ns.db[K("onlyCombat")] = v; Refresh() end,
        desc = ns.L and ns.L.OnlyInCombatDesc or "Only shows warnings while you are in combat.",
    })
    local iSection = SettingsLib:CreateExpandableSection(cat, { name = ns.L and ns.L.InstanceFilters or "Instance Filters", expanded = false })
    SettingsLib:CreateCheckbox(cat, {
        key = K("onlyInstances"), name = ns.L and ns.L.OnlyInInstances or "Only in instances",
        default = DefaultFor(K("onlyInstances"), false),
        get = function() return G(K("onlyInstances"), DefaultFor(K("onlyInstances"), false)) end,
        set = function(v) ns.db[K("onlyInstances")] = v; Refresh() end,
        desc = ns.L and ns.L.OnlyInInstancesDesc or "Only shows warnings inside instances.",
        parentSection = iSection,
    })
    SettingsLib:CreateCheckbox(cat, {
        key = K("disableInDungeons"), name = ns.L and ns.L.DisableInDungeons or "Disable in Dungeons",
        default = DefaultFor(K("disableInDungeons"), false),
        get = function() return G(K("disableInDungeons"), DefaultFor(K("disableInDungeons"), false)) end,
        set = function(v) ns.db[K("disableInDungeons")] = v; Refresh() end,
        desc = ns.L and ns.L.DisableInDungeonsDesc or "Deactivates the feature inside dungeons.",
        parentSection = iSection,
    })
    SettingsLib:CreateCheckbox(cat, {
        key = K("disableInRaids"), name = ns.L and ns.L.DisableInRaids or "Disable in Raids",
        default = DefaultFor(K("disableInRaids"), false),
        get = function() return G(K("disableInRaids"), DefaultFor(K("disableInRaids"), false)) end,
        set = function(v) ns.db[K("disableInRaids")] = v; Refresh() end,
        desc = ns.L and ns.L.DisableInRaidsDesc or "Deactivates the feature inside raids.",
        parentSection = iSection,
    })

    -- Customization sections (Text, Icon, Sound)
    local textSection = SettingsLib:CreateExpandableSection(cat, { name = ns.L and ns.L.FloatingText or "Floating Text", expanded = false })
    SettingsLib:CreateCheckbox(cat, {
        key = K("enableText"), name = ns.L and ns.L.Enable or "Enable",
        default = DefaultFor(K("enableText"), true),
        get = function() return G(K("enableText"), DefaultFor(K("enableText"), true)) end,
        set = function(v) ns.db[K("enableText")] = v; Refresh() end,
        desc = ns.L and ns.L.EnableDesc or "Enables or disables this feature.",
        parentSection = textSection,
    })
    SettingsLib:CreateInput(cat, {
        key = K("customText"), name = ns.L and ns.L.CustomText or "Custom Text",
        default = DefaultFor(K("customText"), ""),
        get = function() return G(K("customText"), DefaultFor(K("customText"), "")) end,
        set = function(v) ns.db[K("customText")] = v; Refresh() end,
        desc = ns.L and ns.L.CustomTextDesc or "Custom message text to display.",
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
        desc = ns.L and ns.L.SizeDesc or "Changes the size of the element.",
        parentSection = textSection,
    })
    SettingsLib:CreateSlider(cat, {
        key = K("textAlpha"), name = ns.L and ns.L.Opacity or "Opacity", min = 0, max = 1, step = 0.05,
        default = DefaultFor(K("textAlpha"), 1),
        get = function() return G(K("textAlpha"), DefaultFor(K("textAlpha"), 1)) end,
        set = function(v) ns.db[K("textAlpha")] = v; Refresh() end,
        desc = ns.L and ns.L.OpacityDesc or "Changes the transparency level.",
        parentSection = textSection,
    })
    SettingsLib:CreateSlider(cat, {
        key = K("textX"), name = ns.L and ns.L.OffsetX or "Offset X", min = -1200, max = 1200, step = 1,
        default = DefaultFor(K("textX"), 0),
        get = function() return G(K("textX"), DefaultFor(K("textX"), 0)) end,
        set = function(v) ns.db[K("textX")] = v; Refresh() end,
        desc = ns.L and ns.L.OffsetXDesc or "Moves the element horizontally.",
        parentSection = textSection,
    })
    SettingsLib:CreateSlider(cat, {
        key = K("textY"), name = ns.L and ns.L.OffsetY or "Offset Y", min = -600, max = 600, step = 1,
        default = DefaultFor(K("textY"), 185),
        get = function() return G(K("textY"), DefaultFor(K("textY"), 185)) end,
        set = function(v) ns.db[K("textY")] = v; Refresh() end,
        desc = ns.L and ns.L.OffsetYDesc or "Moves the element vertically.",
        parentSection = textSection,
    })

    local iconSection = SettingsLib:CreateExpandableSection(cat, { name = ns.L and ns.L.IndicatorIcon or "Indicator Icon", expanded = false })
    SettingsLib:CreateCheckbox(cat, {
        key = K("enableIcon"), name = ns.L and ns.L.Enable or "Enable",
        default = DefaultFor(K("enableIcon"), true),
        get = function() return G(K("enableIcon"), DefaultFor(K("enableIcon"), true)) end,
        set = function(v) ns.db[K("enableIcon")] = v; Refresh() end,
        desc = ns.L and ns.L.EnableIconDesc or "Shows an icon indicator next to the text.",
        parentSection = iconSection,
    })
    SettingsLib:CreateInput(cat, {
        key = K("iconTexture"), name = ns.L and ns.L.IconTexture or "Icon Texture",
        default = DefaultFor(K("iconTexture"), ""),
        get = function() return G(K("iconTexture"), DefaultFor(K("iconTexture"), "")) end,
        set = function(v) ns.db[K("iconTexture")] = v; Refresh() end,
        desc = ns.L and ns.L.IconTextureDesc or "Custom icon texture path or FileID.",
        parentSection = iconSection,
    })
    SettingsLib:CreateCheckbox(cat, {
        key = K("iconAnchorToText"), name = ns.L and ns.L.AnchorToText or "Anchor to Text",
        default = DefaultFor(K("iconAnchorToText"), true),
        get = function() return G(K("iconAnchorToText"), DefaultFor(K("iconAnchorToText"), true)) end,
        set = function(v) ns.db[K("iconAnchorToText")] = v; Refresh() end,
        desc = ns.L and ns.L.AnchorToTextDesc or "Anchors the icon to the text element position.",
        parentSection = iconSection,
    })
    SettingsLib:CreateDropdown(cat, {
        key = K("iconAnchorPoint"), name = ns.L and ns.L.AnchorPoint or "Anchor Point", values = ns.UI_ANCHOR_MAP, order = ns.UI_ANCHOR_ORDER,
        default = DefaultFor(K("iconAnchorPoint"), "LEFT"),
        get = function() return G(K("iconAnchorPoint"), DefaultFor(K("iconAnchorPoint"), "LEFT")) end,
        set = function(v) ns.db[K("iconAnchorPoint")] = v; Refresh() end,
        desc = ns.L and ns.L.AnchorPointDesc or "Side of the text used as the anchor reference.",
        parentSection = iconSection,
    })
    SettingsLib:CreateSlider(cat, {
        key = K("iconSize"), name = ns.L and ns.L.Size or "Size", min = 16, max = 150, step = 1,
        default = DefaultFor(K("iconSize"), 36),
        get = function() return G(K("iconSize"), DefaultFor(K("iconSize"), 36)) end,
        set = function(v) ns.db[K("iconSize")] = v; Refresh() end,
        desc = ns.L and ns.L.SizeDesc or "Changes the size of the element.",
        parentSection = iconSection,
    })
    SettingsLib:CreateSlider(cat, {
        key = K("iconAlpha"), name = ns.L and ns.L.Opacity or "Opacity", min = 0, max = 1, step = 0.05,
        default = DefaultFor(K("iconAlpha"), 1),
        get = function() return G(K("iconAlpha"), DefaultFor(K("iconAlpha"), 1)) end,
        set = function(v) ns.db[K("iconAlpha")] = v; Refresh() end,
        desc = ns.L and ns.L.OpacityDesc or "Changes the transparency level.",
        parentSection = iconSection,
    })
    SettingsLib:CreateSlider(cat, {
        key = K("iconX"), name = ns.L and ns.L.OffsetX or "Offset X", min = -1200, max = 1200, step = 1,
        default = DefaultFor(K("iconX"), -45),
        get = function() return G(K("iconX"), DefaultFor(K("iconX"), -45)) end,
        set = function(v) ns.db[K("iconX")] = v; Refresh() end,
        desc = ns.L and ns.L.OffsetXDesc or "Moves the element horizontally.",
        parentSection = iconSection,
    })
    SettingsLib:CreateSlider(cat, {
        key = K("iconY"), name = ns.L and ns.L.OffsetY or "Offset Y", min = -600, max = 600, step = 1,
        default = DefaultFor(K("iconY"), 0),
        get = function() return G(K("iconY"), DefaultFor(K("iconY"), 0)) end,
        set = function(v) ns.db[K("iconY")] = v; Refresh() end,
        desc = ns.L and ns.L.OffsetYDesc or "Moves the element vertically.",
        parentSection = iconSection,
    })

    local soundSection = SettingsLib:CreateExpandableSection(cat, { name = ns.L and ns.L.Sound or "Sound", expanded = false })
    SettingsLib:CreateCheckbox(cat, {
        key = K("enableSound"), name = ns.L and ns.L.Enable or "Enable",
        default = DefaultFor(K("enableSound"), true),
        get = function() return G(K("enableSound"), DefaultFor(K("enableSound"), true)) end,
        set = function(v) ns.db[K("enableSound")] = v; Refresh() end,
        desc = ns.L and ns.L.SoundDesc or "Plays a sound alert when activated.",
        parentSection = soundSection,
    })
    SettingsLib:CreateInput(cat, {
        key = K("soundKit"), name = ns.L and ns.L.SoundKitId or "Sound Kit ID",
        default = DefaultFor(K("soundKit"), 8959),
        get = function() return G(K("soundKit"), DefaultFor(K("soundKit"), 8959)) end,
        set = function(v) ns.db[K("soundKit")] = tonumber(v) or 8959; Refresh() end,
        desc = ns.L and ns.L.SoundKitIdDesc or "SoundKit ID to play (number).",
        numeric = true,
        parentSection = soundSection,
    })
    SettingsLib:CreateButton(cat, {
        text = ns.L and ns.L.TestSound or "Test Sound",
        func = function()
            local kit = ns.db[K("soundKit")] or 8959
            if kit and PlaySound then PlaySound(kit, "Master") end
        end,
        desc = ns.L and ns.L.TestSoundDesc or "Plays the selected sound immediately.",
        parentSection = soundSection,
    })
end

-- ============================================================================
-- [[ INITIALIZATION ]] -------------------------------------------------------
-- ============================================================================
function ns.Modules.RogueSettings.Init(root)
    if not ns.IsRogue then return end

    local poisonCat = SettingsLib:CreateCategory(root, ns.L and ns.L.PoisonTracker or "Poison Tracker", false)
    AddPoisonSettings(poisonCat, "poisonLethal", ns.L and ns.L.LethalPoisons or "Lethal Poison", ns.L and ns.L.LethalPoisonsDesc or "Shows warnings when your Lethal poison is missing.")
    AddPoisonSettings(poisonCat, "poisonNonLethal", ns.L and ns.L.NonLethalPoisons or "Non-Lethal Poison", ns.L and ns.L.NonLethalPoisonsDesc or "Shows warnings when your Non-Lethal poison is missing.")

    -- Shroud of Concealment
    local shroudCat = SettingsLib:CreateCategory(root, ns.L and ns.L.ShroudOfConcealment or "Shroud of Concealment", false)
    SettingsLib:CreateHeader(shroudCat, { name = ns.L and ns.L.Management or "Management" })
    SettingsLib:CreateCheckbox(shroudCat, {
        key = "shroudCountdown", name = ns.L and ns.L.EnableShroudCountdown or "Countdown in Chat", default = false,
        get = function() return G("shroudCountdown", false) end,
        set = function(v) ns.db.shroudCountdown = v end,
        desc = ns.L and ns.L.EnableShroudCountdownDesc or "Sends Shroud of Concealment countdown messages to chat.",
    })
    local shrFilterSection = SettingsLib:CreateExpandableSection(shroudCat, { name = ns.L and ns.L.InstanceFilters or "Instance Filters", expanded = false })
    SettingsLib:CreateCheckbox(shroudCat, {
        key = "shroudOnlyInstances", name = ns.L and ns.L.OnlyInInstances or "Only in instances", default = true,
        get = function() return G("shroudOnlyInstances", true) end,
        set = function(v) ns.db.shroudOnlyInstances = v end,
        desc = ns.L and ns.L.ShroudOnlyInstancesDesc or "Only sends Shroud messages inside instances.\n\n|cffbe89e9Note:|r some channels are blocked outside instances by Blizzard anti-spam.",
        parentSection = shrFilterSection,
    })
    SettingsLib:CreateCheckbox(shroudCat, {
        key = "shroudDisableInDungeons", name = ns.L and ns.L.DisableInDungeons or "Disable in Dungeons", default = false,
        get = function() return G("shroudDisableInDungeons", false) end,
        set = function(v) ns.db.shroudDisableInDungeons = v end,
        desc = ns.L and ns.L.DisableInDungeonsDesc or "Deactivates the feature inside dungeons.",
        parentSection = shrFilterSection,
    })
    SettingsLib:CreateCheckbox(shroudCat, {
        key = "shroudDisableInRaids", name = ns.L and ns.L.DisableInRaids or "Disable in Raids", default = false,
        get = function() return G("shroudDisableInRaids", false) end,
        set = function(v) ns.db.shroudDisableInRaids = v end,
        desc = ns.L and ns.L.DisableInRaidsDesc or "Deactivates the feature inside raids.",
        parentSection = shrFilterSection,
    })

    -- Shroud Messages
    SettingsLib:CreateHeader(shroudCat, { name = ns.L and ns.L.Messages or "Messages" })
    SettingsLib:CreateDropdown(shroudCat, {
        key = "shroudChannel", name = (ns.L and ns.L.ChatChannel or "Chat Channel") .. " 1", values = ns.UI_CHANNELS, order = ns.UI_CHANNEL_ORDER, default = "SAY",
        get = function() return G("shroudChannel", "SAY") end,
        set = function(v) ns.db.shroudChannel = v end,
        desc = ns.L and ns.L.ChatChannelDesc or "Primary chat channel used for Shroud messages.",
    })
    SettingsLib:CreateDropdown(shroudCat, {
        key = "shroudChannelFallback1", name = (ns.L and ns.L.ChatChannel or "Chat Channel") .. " 2", values = ns.UI_CHANNELS, order = ns.UI_CHANNEL_ORDER, default = "NONE",
        get = function() return G("shroudChannelFallback1", "NONE") end,
        set = function(v) ns.db.shroudChannelFallback1 = v end,
        desc = ns.L and ns.L.ChatChannelFallbackDesc or "Alternative channel used if the primary is unavailable.",
    })
    SettingsLib:CreateDropdown(shroudCat, {
        key = "shroudChannelFallback2", name = (ns.L and ns.L.ChatChannel or "Chat Channel") .. " 3", values = ns.UI_CHANNELS, order = ns.UI_CHANNEL_ORDER, default = "NONE",
        get = function() return G("shroudChannelFallback2", "NONE") end,
        set = function(v) ns.db.shroudChannelFallback2 = v end,
        desc = ns.L and ns.L.ChatChannelFallbackDesc or "Alternative channel used if the primary is unavailable.",
    })
    SettingsLib:CreateInput(shroudCat, {
        key = "shroudMessage", name = ns.L and ns.L.ShroudMessage or "Countdown Message", default = "%time",
        get = function() return G("shroudMessage", "%time") end,
        set = function(v) ns.db.shroudMessage = v end,
        desc = ns.L and ns.L.ShroudMessageDesc or "Message template used during countdown.\n\n|cffffcc00%time|r = remaining time.",
    })
    SettingsLib:CreateInput(shroudCat, {
        key = "shroudStartMsg", name = ns.L and ns.L.ShroudOnStart or "Start Message", default = "%time",
        get = function() return G("shroudStartMsg", "%time") end,
        set = function(v) ns.db.shroudStartMsg = v end,
        desc = ns.L and ns.L.ShroudOnStartDesc or "Message sent when Shroud of Concealment begins.",
    })
    SettingsLib:CreateInput(shroudCat, {
        key = "shroudEndMsg", name = ns.L and ns.L.ShroudOnEnd or "End Message", default = "%time",
        get = function() return G("shroudEndMsg", "%time") end,
        set = function(v) ns.db.shroudEndMsg = v end,
        desc = ns.L and ns.L.ShroudOnEndDesc or "Message sent when Shroud of Concealment ends (0s).",
    })
    SettingsLib:CreateCheckbox(shroudCat, {
        key = "shroudInterval", name = ns.L and ns.L.ShroudInterval or "Interval Mode", default = false,
        get = function() return G("shroudInterval", false) end,
        set = function(v) ns.db.shroudInterval = v end,
        desc = ns.L and ns.L.ShroudIntervalDesc or "Sends countdown at the start, middle, and during the last 5 seconds only.",
    })
    SettingsLib:CreateCheckbox(shroudCat, {
        key = "shroudMuteErrors", name = ns.L and ns.L.ShroudMuteErrors or "Mute error messages", default = false,
        get = function() return G("shroudMuteErrors", false) end,
        set = function(v) ns.db.shroudMuteErrors = v end,
        desc = ns.L and ns.L.ShroudMuteErrorsDesc or "Disables Shroud error messages in chat.",
    })
    SettingsLib:CreateButton(shroudCat, {
        text = ns.L and ns.L.TestShroud or "Test Message",
        func = function() if ns.Modules.Shroud and ns.Modules.Shroud.TestMessage then ns.Modules.Shroud.TestMessage() end end,
        desc = ns.L and ns.L.TestShroudDesc or "Simulates a local 5-second countdown.\n\n|cffbe89e9Note:|r Messages appear only to you.",
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
        desc = ns.L and ns.L.MacroBtnEnableDesc or "Activates automatic targeting and creates the macro.\n\n|cffbe89e9Note:|r Nightveil automatically updates this macro. Manual edits may be overwritten.",
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
        desc = ns.L and ns.L.MacroBtnDisableDesc or "Disables automatic targeting and completely removes the macro.",
    })

    SettingsLib:CreateCheckbox(tricksCat, {
        key = "tricksMute", name = ns.L and ns.L.MuteChanges or "Mute Changes", default = false,
        get = function() return G("tricksMute", false) end,
        set = function(v) ns.db.tricksMute = v end,
        desc = ns.L and ns.L.TricksMuteDesc or "Hides chat notifications when the macro changes targets.",
    })
    SettingsLib:CreateHeader(tricksCat, { name = ns.L and ns.L.MacroTargetHeader or "Target" })
    SettingsLib:CreateCheckbox(tricksCat, {
        key = "tricksUseMouseover", name = ns.L and ns.L.Mouseover or "Mouseover", default = false,
        get = function() return G("tricksUseMouseover", false) end,
        set = function(v) ns.db.tricksUseMouseover = v; if ns.Modules.Tricks and ns.Modules.Tricks.UpdateMacro then ns.Modules.Tricks.UpdateMacro(true) end end,
        desc = ns.L and ns.L.TricksMouseoverDesc or "Enable mouseover targeting.\n\n|cffbe89e9Note:|r This has priority over other methods except the |cffffcc00Delve Companion|r.",
    })
    SettingsLib:CreateCheckbox(tricksCat, {
        key = "tricksUseFocus", name = ns.L and ns.L.Focus or "Focus", default = false,
        get = function() return G("tricksUseFocus", false) end,
        set = function(v) ns.db.tricksUseFocus = v; if ns.Modules.Tricks and ns.Modules.Tricks.UpdateMacro then ns.Modules.Tricks.UpdateMacro(true) end end,
        desc = ns.L and ns.L.TricksFocusDesc or "Enables automated targeting via focus.\n\n|cffbe89e9Note:|r This has priority over the target selector, but is ignored by mouseover or |cffffcc00Delve Companion|r.",
    })
    SettingsLib:CreateDropdown(tricksCat, {
        key = "tricksLogic", name = ns.L and ns.L.MacroTargetSelector or "Target Selector", values = ns.UI_TRICKS_LOGIC_OPTIONS, order = ns.UI_TRICKS_LOGIC_ORDER, default = "TANK",
        get = function() return G("tricksLogic", "TANK") end,
        set = function(v) ns.db.tricksLogic = v; if ns.Modules.Tricks and ns.Modules.Tricks.UpdateMacro then ns.Modules.Tricks.UpdateMacro(true) end end,
        desc = ns.L and ns.L.TricksTargetSelectorDesc or "Defines the primary logic for automatic target selection.",
    })
    SettingsLib:CreateInput(tricksCat, {
        key = "tricksCustomName", name = ns.L and ns.L.MacroCustomName or "Custom Target", default = "",
        get = function() return G("tricksCustomName", "") end,
        set = function(v) ns.db.tricksCustomName = v; ns.db.tricksLogic = "CUSTOM"; if ns.Modules.Tricks and ns.Modules.Tricks.UpdateMacro then ns.Modules.Tricks.UpdateMacro(true) end end,
        desc = ns.L and ns.L.TricksCustomNameDesc or "Enter the exact name of the player to target.",
    })
    SettingsLib:CreateCheckbox(tricksCat, {
        key = "tricksDelveCompanion", name = ns.L and ns.L.MacroDelveCompanion or "Delve Companion", default = true,
        get = function() return G("tricksDelveCompanion", true) end,
        set = function(v) ns.db.tricksDelveCompanion = v; if ns.Modules.Tricks and ns.Modules.Tricks.UpdateMacro then ns.Modules.Tricks.UpdateMacro(true) end end,
        desc = ns.L and ns.L.TricksDelveCompanionDesc or "Automatically targets companions like |cffaad372Brann Bronzebeard|r or |cffaad372Valeera Sanguinar|r inside |cffffcc00Delves|r.\n\n|cffbe89e9Note:|r This takes exclusive priority inside |cffffcc00Delves|r.",
    })
end
