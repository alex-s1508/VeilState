-- ============================================================================
-- [[ HUNTER SETTINGS UI ]] ---------------------------------------------------
-- ============================================================================
local addonName, ns = ...
local SettingsLib = LibStub("LibEQOLSettingsMode-1.0")
SettingsLib:SetVariablePrefix("Nightveil_")

ns.Modules = ns.Modules or {}
ns.Modules.HunterSettings = {}

-- [[ UI BUILDERS ]] ----------------------------------------------------------

local G = ns.Modules.Settings and ns.Modules.Settings.Get or function(k, d) return ns.db and ns.db[k] or d end
local GetColor = ns.Modules.Settings and ns.Modules.Settings.GetColor or function(k, dr, dg, db) local c = ns.db and ns.db[k]; if not c then return dr or 0.478, dg or 0.878, db or 0.267 end; return c.r or dr, c.g or dg, c.b or db end

-- ============================================================================
-- [[ INITIALIZATION ]] -------------------------------------------------------
-- ============================================================================
function ns.Modules.HunterSettings.Init(root)
    if not ns.IsHunter then return end

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
        desc = ns.L and ns.L.MacroBtnEnableDesc or "Activates automatic targeting and creates the macro.\n\n|cffbe89e9Note:|r Nightveil automatically updates this macro. Manual edits may be overwritten.",
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
        desc = ns.L and ns.L.MacroBtnDisableDesc or "Disables automatic targeting and completely removes the macro.",
    })

    SettingsLib:CreateCheckbox(misdirCat, {
        key = "misdirMute", name = ns.L and ns.L.MuteChanges or "Mute Changes", default = false,
        get = function() return G("misdirMute", false) end,
        set = function(v) ns.db.misdirMute = v end,
        desc = ns.L and ns.L.MuteChangesDesc or "Hides chat notifications when the macro changes targets.",
    })
    SettingsLib:CreateHeader(misdirCat, { name = ns.L and ns.L.MacroTargetHeader or "Target" })
    SettingsLib:CreateCheckbox(misdirCat, {
        key = "misdirUseMouseover", name = ns.L and ns.L.Mouseover or "Mouseover", default = false,
        get = function() return G("misdirUseMouseover", false) end,
        set = function(v) ns.db.misdirUseMouseover = v; if ns.Modules.Misdirection and ns.Modules.Misdirection.UpdateMacro then ns.Modules.Misdirection.UpdateMacro(true) end end,
        desc = ns.L and ns.L.MouseoverDesc or "Activates targeting of the unit under the mouse cursor.",
    })
    SettingsLib:CreateCheckbox(misdirCat, {
        key = "misdirUseFocus", name = ns.L and ns.L.Focus or "Focus", default = false,
        get = function() return G("misdirUseFocus", false) end,
        set = function(v) ns.db.misdirUseFocus = v; if ns.Modules.Misdirection and ns.Modules.Misdirection.UpdateMacro then ns.Modules.Misdirection.UpdateMacro(true) end end,
        desc = ns.L and ns.L.FocusDesc or "Activates automatic targeting via the focus target.",
    })
    SettingsLib:CreateDropdown(misdirCat, {
        key = "misdirLogic", name = ns.L and ns.L.MacroTargetSelector or "Target Selector",
        values = ns.UI_MISDIR_LOGIC_OPTIONS, order = ns.UI_MISDIR_LOGIC_ORDER, default = "PET",
        get = function() return G("misdirLogic", "PET") end,
        set = function(v) ns.db.misdirLogic = v; if ns.Modules.Misdirection and ns.Modules.Misdirection.UpdateMacro then ns.Modules.Misdirection.UpdateMacro(true) end end,
        desc = ns.L and ns.L.TricksTargetSelectorDesc or "Defines the primary logic for automatic target selection.",
    })
    SettingsLib:CreateInput(misdirCat, {
        key = "misdirCustomName", name = ns.L and ns.L.MacroCustomName or "Custom Target", default = "",
        get = function() return G("misdirCustomName", "") end,
        set = function(v) ns.db.misdirCustomName = v; ns.db.misdirLogic = "CUSTOM"; if ns.Modules.Misdirection and ns.Modules.Misdirection.UpdateMacro then ns.Modules.Misdirection.UpdateMacro(true) end end,
        desc = ns.L and ns.L.TricksCustomNameDesc or "Enter the exact name of the player to target.",
    })
    SettingsLib:CreateCheckbox(misdirCat, {
        key = "misdirDelveCompanion", name = ns.L and ns.L.MacroDelveCompanion or "Delve Companion", default = true,
        get = function() return G("misdirDelveCompanion", true) end,
        set = function(v) ns.db.misdirDelveCompanion = v; if ns.Modules.Misdirection and ns.Modules.Misdirection.UpdateMacro then ns.Modules.Misdirection.UpdateMacro(true) end end,
        desc = ns.L and ns.L.TricksDelveCompanionDesc or "Automatically targets companions like |cffaad372Brann Bronzebeard|r or |cffaad372Valeera Sanguinar|r inside |cffffcc00Delves|r.\n\n|cffbe89e9Note:|r This takes exclusive priority inside |cffffcc00Delves|r.",
    })
end
