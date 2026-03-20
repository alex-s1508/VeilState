-- ============================================================================
-- [[ NIGHTVEIL — COMMAND INTERFACE ]] ---------------------------------------
-- ============================================================================
local addonName, ns = ...

-- [[ SLASH COMMANDS ]] -------------------------------------------------------
SLASH_NIGHTVEIL1 = "/veil"
SlashCmdList["NIGHTVEIL"] = function(msg)
    local cmd, arg1 = string.split(" ", strtrim(msg or ""):lower())

    if cmd == "debug" then
        ns.debugMode = not ns.debugMode
        if ns.debugMode then
            print(string.format(ns.L and ns.L.DebugModeActivated or (ns.Shared.GetAddonName() .. ": |cffbe89e9Debug Mode ACTIVATED|r"), ns.Shared.GetAddonName()))
            print("\n \|cffb894ff" .. (ns.L and ns.L.DebugCommands or "[Debug Commands]") .. "|r")
            if ns.IsRogue then
                print(" \|cffd4a8ff/veil utricks|r - " .. (ns.L and ns.L.HelpUTricks or "Force macro refresh"))
            elseif ns.IsHunter then
                print(" \|cffd4a8ff/veil umisdir|r - " .. (ns.L and ns.L.HelpUMisdir or "Force macro refresh"))
            end
            print(" \|cffd4a8ff/veil info|r - " .. (ns.L and ns.L.HelpInfo or "Diagnostic info"))
            if ns.IsRogue then
                print(" \|cffd4a8ff/veil shroud [1-20]|r - " .. (ns.L and ns.L.HelpShroudTest or "Test shroud countdown"))
            end
        else
            print(string.format(ns.L and ns.L.DebugModeDeactivated or (ns.Shared.GetAddonName() .. ": |cff9b7fd4 Debug Mode DEACTIVATED|r"), ns.Shared.GetAddonName()))
        end
    elseif cmd == "info" then
        if not ns.IsRogue then
            print(ns.Shared.GetAddonName() .. ": |cffff2020" .. (ns.L and ns.L.WarningNotRogue or "You are not a Rogue.") .. "|r")
            return
        end
        if not ns.debugMode then
            print(string.format(ns.L and ns.L.DebugModeRequired or (ns.Shared.GetAddonName() .. ": |cffbe89e9This command requires Debug Mode.|r Type |cffffcc00/veil debug|r to enable."), ns.Shared.GetAddonName()))
            return
        end
        ns.Shared.DebugState()
    elseif cmd == "shroud" then
        if not ns.IsRogue then
            print(ns.Shared.GetAddonName() .. ": |cffff2020" .. (ns.L and ns.L.WarningNotRogue or "You are not a Rogue.") .. "|r")
            return
        end
        if not ns.debugMode then
            print(string.format(ns.L and ns.L.DebugModeRequired or (ns.Shared.GetAddonName() .. ": |cffbe89e9This command requires Debug Mode.|r Type |cffffcc00/veil debug|r to enable."), ns.Shared.GetAddonName()))
            return
        end
        local n = tonumber(arg1)
        if arg1 and arg1 ~= "" and (not n or n < 1 or n > 20) then
            print(string.format(ns.L and ns.L.DebugShroudUsage or (ns.Shared.GetAddonName() .. ": \|cff6a39a2Usage:|r \|cffffcc00/veil shroud [1-20]|r"), ns.Shared.GetAddonName()))
            return
        end
        if ns.Modules.Shroud and ns.Modules.Shroud.RunTest then
            ns.Modules.Shroud.RunTest(n or 15)
        else
            if ns.RunShroudTest then ns.RunShroudTest(n or 15) end
        end

    -- ======================================================================
    -- [[ TRICKS OF THE TRADE — ROGUE ONLY ]] ---------------------------------
    -- ======================================================================
    elseif cmd == "tricks" or cmd == "target" then
        if not ns.IsRogue then
            print(ns.Shared.GetAddonName() .. ": \|cffff2020" .. (ns.L and ns.L.WarningNotRogue or "You are not a Rogue.") .. "|r")
            return
        end
        local rawMsg = strtrim(msg or "")
        local _, rest = rawMsg:match("^(%S+)%s*(.*)$")
        
        if rest and rest ~= "" then
            if InCombatLockdown() then
                print(ns.Shared.GetAddonName() .. ": " .. (ns.L and ns.L.CombatBlocked or "Cannot open settings during combat."))
                return
            end

            local sub, val = rest:match("^(%S+)%s*(.*)$")
            sub = sub and sub:lower() or ""
            
            if sub == "list" then
                local isRaid = IsInRaid()
                local count = GetNumGroupMembers()
                local prefix = isRaid and "raid" or "party"
                local max = isRaid and count or count - 1
                local idx = tonumber(val)
                
                if idx then
                    local unit = idx == 0 and "player" or prefix .. idx
                    if UnitExists(unit) then
                        if UnitIsUnit(unit, "player") then
                            print(ns.Shared.GetAddonName() .. ": \|cff6a39a2" .. (ns.L and ns.L.TricksNoSelf or "You cannot target yourself.") .. "|r")
                            return
                        end
                        local name = UnitName(unit)
                        ns.db.tricksLogic = "CUSTOM"
                        ns.db.tricksCustomName = name
                        local text = ns.L and ns.L.TricksCustomSet or "Custom target set: %s"
                        print(string.format(ns.Shared.GetAddonName() .. ": " .. text, ns.Shared.GetClassColoredName and ns.Shared.GetClassColoredName(unit) or name))
                        if ns.Modules.Tricks and ns.Modules.Tricks.UpdateMacro then ns.Modules.Tricks.UpdateMacro(true) end
                    else
                        print(ns.Shared.GetAddonName() .. ": \|cff6a39a2" .. (ns.L and ns.L.TricksInvalidIndex or "Invalid group index.") .. "|r")
                    end
                    return
                end
                
                print(ns.Shared.GetAddonName() .. ": " .. (ns.L and ns.L.TricksGroupMembers or "Group members:"))
                print(string.format(" \|cffffcc00[0]|r %s (%s)", ns.Shared.GetClassColoredName and ns.Shared.GetClassColoredName("player") or "Player", ns.L and ns.L.DebugPlayer or "PLAYER"))
                for i = 1, max do
                    local unit = prefix .. i
                    local role = UnitGroupRolesAssigned(unit)
                    local colorName = ns.Shared.GetClassColoredName and ns.Shared.GetClassColoredName(unit) or UnitName(unit)
                    print(string.format(" \|cffffcc00[%d]|r %s (%s)", i, colorName, role))
                end
                return
            elseif sub == "normal" then
                ns.db.tricksLogic = "NORMAL"
                local text = ns.L and ns.L.TricksLogicSet or "Targeting mode set: %s"
                print(string.format(ns.Shared.GetAddonName() .. ": " .. text, "\|cffffcc00" .. (ns.L and ns.L.TricksNormal or "Normal") .. "|r"))
                if ns.Modules.Tricks and ns.Modules.Tricks.UpdateMacro then ns.Modules.Tricks.UpdateMacro(true) end
                return
            elseif sub == "tank" then
                ns.db.tricksLogic = "TANK"
                local text = ns.L and ns.L.TricksLogicSet or "Targeting mode set: %s"
                print(string.format(ns.Shared.GetAddonName() .. ": " .. text, "\|cffffcc00" .. (ns.L and ns.L.Tank or "Tank") .. "|r"))
                if ns.Modules.Tricks and ns.Modules.Tricks.UpdateMacro then ns.Modules.Tricks.UpdateMacro(true) end
                return
            elseif sub == "tt" or sub == "targettarget" then
                ns.db.tricksLogic = "TARGETTARGET"
                local text = ns.L and ns.L.TricksLogicSet or "Targeting mode set: %s"
                print(string.format(ns.Shared.GetAddonName() .. ": " .. text, "\|cffffcc00" .. (ns.L and ns.L.TargetTarget or "Target of Target") .. "|r"))
                if ns.Modules.Tricks and ns.Modules.Tricks.UpdateMacro then ns.Modules.Tricks.UpdateMacro(true) end
                return
            elseif sub == "custom" then
                ns.db.tricksLogic = "CUSTOM"
                local text = ns.L and ns.L.TricksLogicSet or "Targeting mode set: %s"
                print(string.format(ns.Shared.GetAddonName() .. ": " .. text, "\|cffbe89e9" .. (ns.L and ns.L.TricksCustom or "Custom") .. "|r"))
                if ns.Modules.Tricks and ns.Modules.Tricks.UpdateMacro then ns.Modules.Tricks.UpdateMacro(true) end
                return
            elseif sub == "set" and val ~= "" then
                ns.db.tricksLogic = "CUSTOM"
                ns.db.tricksCustomName = val
                local text = ns.L and ns.L.TricksCustomSet or "Custom target set: %s"
                print(string.format(ns.Shared.GetAddonName() .. ": " .. text, "\|cffbe89e9" .. val .. "|r"))
                if ns.Modules.Tricks and ns.Modules.Tricks.UpdateMacro then ns.Modules.Tricks.UpdateMacro(true) end
                return
            else
                local errMsg = ns.L and ns.L.ErrorUnknownSubCmd or (ns.Shared.GetAddonName() .. ": |cff6a39a2|cffff2020Unknown sub-command: |cffffcc00%s|r. Use |cffffcc00/veil help|r.")
                print(string.format(errMsg, rest))
                return
            end
        end

        local logic = ns.db.tricksLogic or ns.Defaults.tricksLogic
        local tankUnit = ns.Modules.Tricks and ns.Modules.Tricks.FindBestTargetID and ns.Modules.Tricks.FindBestTargetID()
        local targetName = tankUnit and (ns.Shared.GetClassColoredName and ns.Shared.GetClassColoredName(tankUnit) or tankUnit) or ("|cffaaaaaa" .. (ns.L and ns.L.DebugNone or "none") .. "|r")
        
        local modeName
        if logic == "TANK" then
            modeName = "|cffffcc00" .. (ns.L and ns.L.Tank or "Tank") .. "|r"
        elseif logic == "TARGETTARGET" then
            modeName = "|cffffcc00" .. (ns.L and ns.L.TargetTarget or "Target of Target") .. "|r"
        elseif logic == "CUSTOM" then
            local cname = (ns.db.tricksCustomName or "") 
            modeName = "|cffbe89e9" .. (ns.L and ns.L.TricksCustom or "Custom") .. "|r" .. (cname ~= "" and (" (" .. cname .. ")") or "")
        else
            modeName = "|cffffcc00" .. (ns.L and ns.L.TricksNormal or "Normal") .. "|r"
        end
        
        print(string.format(ns.Shared.GetAddonName() .. ": |cffcccccc%s|r %s → %s",
            ns.L and ns.L.TricksTargetLog or "Tricks target",
            modeName, targetName))
        if ns.debugMode then
            local statusStr = ns.tricksLastMacroBody and ("|cffbe89e9" .. (ns.L and ns.L.DebugYes or "OK") .. "|r") or ("|cffff2020" .. (ns.L and ns.L.DebugNo or "ERR") .. "|r")
            print(string.format(ns.Shared.GetAddonName() .. ": |cffb894ff[Debug]|r " .. (ns.L and ns.L.DebugMacroStatus or "Macro: %s"), statusStr))
        end
    elseif cmd == "utricks" then
        if not ns.IsRogue then
            print(ns.Shared.GetAddonName() .. ": |cffff9933" .. (ns.L and ns.L.WarningNotRogue or "You are not a Rogue.") .. "|r")
            return
        end
        if ns.debugMode then
            print(ns.Shared.GetAddonName() .. ": |cffce9cff[Debug]|r " .. (ns.L and ns.L.DebugTricksForcing or "Forcing Tricks update..."))
        end
        if ns.Modules.Tricks and ns.Modules.Tricks.UpdateMacro then ns.Modules.Tricks.UpdateMacro(true) end
        if ns.debugMode then
            print(ns.Shared.GetAddonName() .. ": |cffce9cff[Debug]|r " .. (ns.L and ns.L.DebugTricksSuccess or "Macro refresh SUCCESS."))
        end

    -- ======================================================================
    -- [[ MISDIRECTION — HUNTER ONLY ]] ----------------------------------------
    -- ======================================================================
    elseif cmd == "misdir" then
        if not ns.IsHunter then
            print(ns.Shared.GetAddonName() .. ": \|cffff2020" .. (ns.L and ns.L.WarningNotHunter or "You are not a Hunter.") .. "|r")
            return
        end
        local rawMsg = strtrim(msg or "")
        local _, rest = rawMsg:match("^(%S+)%s*(.*)$")

        if rest and rest ~= "" then
            if InCombatLockdown() then
                print(ns.Shared.GetAddonName() .. ": " .. (ns.L and ns.L.CombatBlocked or "Cannot open settings during combat."))
                return
            end

            local sub, val = rest:match("^(%S+)%s*(.*)$")
            sub = sub and sub:lower() or ""

            if sub == "list" then
                local isRaid = IsInRaid()
                local count = GetNumGroupMembers()
                local prefix = isRaid and "raid" or "party"
                local max = isRaid and count or count - 1
                local idx = tonumber(val)

                if idx then
                    local unit = idx == 0 and "player" or prefix .. idx
                    if UnitExists(unit) then
                        if UnitIsUnit(unit, "player") then
                            print(ns.Shared.GetAddonName() .. ": \|cff6a39a2" .. (ns.L and ns.L.MisdirNoSelf or "You cannot target yourself.") .. "|r")
                            return
                        end
                        local name = UnitName(unit)
                        ns.db.misdirLogic = "CUSTOM"
                        ns.db.misdirCustomName = name
                        local text = ns.L and ns.L.MisdirCustomSet or "Custom target set: %s"
                        print(string.format(ns.Shared.GetAddonName() .. ": " .. text, ns.Shared.GetClassColoredName and ns.Shared.GetClassColoredName(unit) or name))
                        if ns.Modules.Misdirection and ns.Modules.Misdirection.UpdateMacro then ns.Modules.Misdirection.UpdateMacro(true) end
                    else
                        print(ns.Shared.GetAddonName() .. ": \|cff6a39a2" .. (ns.L and ns.L.MisdirInvalidIndex or "Invalid group index.") .. "|r")
                    end
                    return
                end

                print(ns.Shared.GetAddonName() .. ": " .. (ns.L and ns.L.MisdirGroupMembers or "Group members:"))
                print(string.format(" \|cffffcc00[0]|r %s (%s)", ns.Shared.GetClassColoredName and ns.Shared.GetClassColoredName("player") or "Player", ns.L and ns.L.DebugPlayer or "PLAYER"))
                for i = 1, max do
                    local unit = prefix .. i
                    local role = UnitGroupRolesAssigned(unit)
                    local colorName = ns.Shared.GetClassColoredName and ns.Shared.GetClassColoredName(unit) or UnitName(unit)
                    print(string.format(" \|cffffcc00[%d]|r %s (%s)", i, colorName, role))
                end
                return
            elseif sub == "pet" then
                ns.db.misdirLogic = "PET"
                local text = ns.L and ns.L.MisdirLogicSet or "Targeting mode set: %s"
                print(string.format(ns.Shared.GetAddonName() .. ": " .. text, "\|cffaad372" .. (ns.L and ns.L.Pet or "Pet") .. "|r"))
                if ns.Modules.Misdirection and ns.Modules.Misdirection.UpdateMacro then ns.Modules.Misdirection.UpdateMacro(true) end
                return
            elseif sub == "normal" then
                ns.db.misdirLogic = "NORMAL"
                local text = ns.L and ns.L.MisdirLogicSet or "Targeting mode set: %s"
                print(string.format(ns.Shared.GetAddonName() .. ": " .. text, "\|cffffcc00" .. (ns.L and ns.L.TricksNormal or "Normal") .. "|r"))
                if ns.Modules.Misdirection and ns.Modules.Misdirection.UpdateMacro then ns.Modules.Misdirection.UpdateMacro(true) end
                return
            elseif sub == "tank" then
                ns.db.misdirLogic = "TANK"
                local text = ns.L and ns.L.MisdirLogicSet or "Targeting mode set: %s"
                print(string.format(ns.Shared.GetAddonName() .. ": " .. text, "\|cffffcc00" .. (ns.L and ns.L.Tank or "Tank") .. "|r"))
                if ns.Modules.Misdirection and ns.Modules.Misdirection.UpdateMacro then ns.Modules.Misdirection.UpdateMacro(true) end
                return
            elseif sub == "tt" or sub == "targettarget" then
                ns.db.misdirLogic = "TARGETTARGET"
                local text = ns.L and ns.L.MisdirLogicSet or "Targeting mode set: %s"
                print(string.format(ns.Shared.GetAddonName() .. ": " .. text, "\|cffffcc00" .. (ns.L and ns.L.TargetTarget or "Target of Target") .. "|r"))
                if ns.Modules.Misdirection and ns.Modules.Misdirection.UpdateMacro then ns.Modules.Misdirection.UpdateMacro(true) end
                return
            elseif sub == "custom" then
                ns.db.misdirLogic = "CUSTOM"
                local text = ns.L and ns.L.MisdirLogicSet or "Targeting mode set: %s"
                print(string.format(ns.Shared.GetAddonName() .. ": " .. text, "\|cffbe89e9" .. (ns.L and ns.L.TricksCustom or "Custom") .. "|r"))
                if ns.Modules.Misdirection and ns.Modules.Misdirection.UpdateMacro then ns.Modules.Misdirection.UpdateMacro(true) end
                return
            elseif sub == "set" and val ~= "" then
                ns.db.misdirLogic = "CUSTOM"
                ns.db.misdirCustomName = val
                local text = ns.L and ns.L.MisdirCustomSet or "Custom target set: %s"
                print(string.format(ns.Shared.GetAddonName() .. ": " .. text, "\|cffbe89e9" .. val .. "|r"))
                if ns.Modules.Misdirection and ns.Modules.Misdirection.UpdateMacro then ns.Modules.Misdirection.UpdateMacro(true) end
                return
            else
                local errMsg = ns.L and ns.L.ErrorUnknownSubCmd or (ns.Shared.GetAddonName() .. ": |cff6a39a2|cffff2020Unknown sub-command: |cffffcc00%s|r. Use |cffffcc00/veil help|r.")
                print(string.format(errMsg, rest))
                return
            end
        end

        local logic = ns.db.misdirLogic or ns.Defaults.misdirLogic
        local targetUnit = ns.Modules.Misdirection and ns.Modules.Misdirection.FindBestTargetID and ns.Modules.Misdirection.FindBestTargetID()
        local targetName
        if targetUnit == "pet" then
            targetName = "|cffaad372" .. (ns.L and ns.L.Pet or "Pet") .. "|r"
        elseif targetUnit == "targettarget" then
            targetName = "|cff00ffff" .. (ns.L and ns.L.TargetTarget or "Target of Target") .. "|r"
        elseif targetUnit then
            targetName = ns.Shared.GetClassColoredName and ns.Shared.GetClassColoredName(targetUnit) or targetUnit
        else
            targetName = "|cffaaaaaa" .. (ns.L and ns.L.DebugNone or "none") .. "|r"
        end

        local modeName
        if logic == "PET" then
            modeName = "|cffaad372" .. (ns.L and ns.L.Pet or "Pet") .. "|r"
        elseif logic == "TANK" then
            modeName = "|cffffcc00" .. (ns.L and ns.L.Tank or "Tank") .. "|r"
        elseif logic == "TARGETTARGET" then
            modeName = "|cffffcc00" .. (ns.L and ns.L.TargetTarget or "Target of Target") .. "|r"
        elseif logic == "CUSTOM" then
            local cname = ns.db.misdirCustomName or ""
            modeName = "|cffbe89e9" .. (ns.L and ns.L.TricksCustom or "Custom") .. "|r" .. (cname ~= "" and (" (" .. cname .. ")") or "")
        else
            modeName = "|cffffcc00" .. (ns.L and ns.L.TricksNormal or "Normal") .. "|r"
        end

        print(string.format(ns.Shared.GetAddonName() .. ": |cffaad372%s|r %s → %s",
            ns.L and ns.L.MisdirTargetLog or "Misdirection target",
            modeName, targetName))
        if ns.debugMode then
            local statusStr = ns.misdirLastMacroBody and ("|cffbe89e9" .. (ns.L and ns.L.DebugYes or "OK") .. "|r") or ("|cffff2020" .. (ns.L and ns.L.DebugNo or "ERR") .. "|r")
            print(string.format(ns.Shared.GetAddonName() .. ": |cffb894ff[Debug]|r " .. (ns.L and ns.L.DebugMacroStatus or "Macro: %s"), statusStr))
        end
    elseif cmd == "umisdir" then
        if not ns.IsHunter then
            print(ns.Shared.GetAddonName() .. ": |cffff9933" .. (ns.L and ns.L.WarningNotHunter or "You are not a Hunter.") .. "|r")
            return
        end
        if ns.debugMode then
            print(ns.Shared.GetAddonName() .. ": |cffce9cff[Debug]|r " .. (ns.L and ns.L.DebugMisdirForcing or "Forcing Misdirection update..."))
        end
        if ns.Modules.Misdirection and ns.Modules.Misdirection.UpdateMacro then ns.Modules.Misdirection.UpdateMacro(true) end
        if ns.debugMode then
            print(ns.Shared.GetAddonName() .. ": |cffce9cff[Debug]|r " .. (ns.L and ns.L.DebugMisdirSuccess or "Macro refresh SUCCESS."))
        end

    -- ======================================================================
    -- [[ HELP ]] -------------------------------------------------------------
    -- ======================================================================
    elseif cmd == "help" then
        print(string.format(ns.Shared.GetAddonName() .. " |cffffcc00v%s|r", ns.Version))
        print(" ")
        print(" |cffbe89e9/veil|r - " .. (ns.L and ns.L.HelpSettings or "Open settings"))

        if ns.IsRogue then
            print(" ")
            print(" |cfffff569/veil tricks|r - " .. (ns.L and ns.L.HelpTricks or "Tricks status"))
            print(" |cfffff569/veil tricks normal|r - " .. (ns.L and ns.L.HelpTricksNormal or "Normal mode"))
            print(" |cfffff569/veil tricks tank|r - " .. (ns.L and ns.L.HelpTricksTank or "Tank mode"))
            print(" |cfffff569/veil tricks tt|r - " .. (ns.L and ns.L.HelpTricksTT or "Target-of-Target mode"))
            print(" |cfffff569/veil tricks custom|r - " .. (ns.L and ns.L.HelpTricksCustom or "Custom mode"))
            print(" |cfffff569/veil tricks list [#]|r - " .. (ns.L and ns.L.HelpTricksList or "List group / pick by index"))
            print(" |cfffff569/veil tricks set <name>|r - " .. (ns.L and ns.L.HelpTricksSet or "Set custom target name"))
        elseif ns.IsHunter then
            print(" ")
            print(" |cffaad372/veil misdir|r - " .. (ns.L and ns.L.HelpMisdir or "Misdirection status"))
            print(" |cffaad372/veil misdir pet|r - " .. (ns.L and ns.L.HelpMisdirPet or "Pet mode"))
            print(" |cffaad372/veil misdir normal|r - " .. (ns.L and ns.L.HelpMisdirNormal or "Normal mode"))
            print(" |cffaad372/veil misdir tank|r - " .. (ns.L and ns.L.HelpMisdirTank or "Tank mode"))
            print(" |cffaad372/veil misdir tt|r - " .. (ns.L and ns.L.HelpMisdirTT or "Target-of-Target mode"))
            print(" |cffaad372/veil misdir custom|r - " .. (ns.L and ns.L.HelpMisdirCustom or "Custom mode"))
            print(" |cffaad372/veil misdir list [#]|r - " .. (ns.L and ns.L.HelpMisdirList or "List group / pick by index"))
            print(" |cffaad372/veil misdir set <name>|r - " .. (ns.L and ns.L.HelpMisdirSet or "Set custom target name"))
        end
        print(" ")
        print(" |cffbe89e9/veil debug|r - " .. (ns.L and ns.L.HelpDebugToggle or "Toggle debug mode"))

        if ns.debugMode then
            if ns.IsRogue then
                print(" |cffce9cff/veil utricks|r - " .. (ns.L and ns.L.HelpUTricks or "Force macro refresh"))
            elseif ns.IsHunter then
                print(" |cffce9cff/veil umisdir|r - " .. (ns.L and ns.L.HelpUMisdir or "Force macro refresh"))
            end
            print(" |cffce9cff/veil info|r - " .. (ns.L and ns.L.HelpInfo or "Diagnostic info"))
            if ns.IsRogue then
                print(" |cffce9cff/veil shroud [1-20]|r - " .. (ns.L and ns.L.HelpShroudTest or "Test shroud"))
            end
        end
    elseif cmd == "" then
        if ns.MainCategory then
            Settings.OpenToCategory(ns.MainCategory:GetID())
        end
    end
end

-- [[ ADDON COMPARTMENT ]] ----------------------------------------------------
function Nightveil_OnAddonCompartmentClick()
    if InCombatLockdown() then
        print(ns.Shared.GetAddonName() .. ": |cffffaa00" .. (ns.L and ns.L.CombatBlocked or "Cannot open settings during combat.") .. "|r")
        return
    end
    if ns.MainCategory then 
        Settings.OpenToCategory(ns.MainCategory:GetID()) 
    end
end
