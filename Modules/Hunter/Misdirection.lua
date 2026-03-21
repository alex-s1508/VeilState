-- ============================================================================
-- [[ NIGHTVEIL — HUNTER: MISDIRECTION ]] -------------------------------------
-- ============================================================================
local addonName, ns = ...
ns.Modules = ns.Modules or {}
ns.Modules.Misdirection = {}

-- [[ CONSTANTS & STATE ]] ----------------------------------------------------

local DELVE_COMPANIONS = {
    ["210759"] = true, -- Brann Bronzebeard
    ["204418"] = true, -- Valeera Sanguinar
}

ns.misdirLastTargetID   = nil
ns.misdirLastMacroBody  = nil
ns.misdirUpdateQueued   = false
ns.misdirLastEventTime  = 0

-- ============================================================================
-- [[ TARGETING LOGIC ]] -------------------------------------------------------
-- ============================================================================

local function IsValidMisdirTarget(unit)
    if not unit or not UnitExists(unit) then return false end
    if UnitIsUnit("player", unit) or UnitIsDeadOrGhost(unit) then return false end

    local guid = UnitGUID(unit)
    local npcID = guid and select(6, strsplit("-", guid))
    if DELVE_COMPANIONS[npcID] then return true end

    return UnitCanAssist("player", unit)
end

function ns.Modules.Misdirection.GetSpellName()
    if C_Spell and C_Spell.GetSpellName then
        return C_Spell.GetSpellName(34477)
    elseif GetSpellInfo then
        local name = GetSpellInfo(34477)
        return name
    end
    return nil
end

function ns.Modules.Misdirection.FindDelveCompanionID()
    local count = GetNumGroupMembers()
    if count > 0 then
        for i = 1, count do
            local unit = "party" .. i
            if UnitExists(unit) then
                local name = UnitName(unit)
                if name == (ns.L and ns.L.BrannBronzebeard) or name == (ns.L and ns.L.ValeeraSanguinar) then
                    return unit
                end
                local guid = UnitGUID(unit)
                local npcID = guid and select(6, strsplit("-", guid))
                if npcID == "210759" or npcID == "204418" then return unit end
            end
        end
    end
    return nil
end

function ns.Modules.Misdirection.FindBestTargetID()
    -- Delve companion priority
    if ns.db and ns.db.misdirDelveCompanion then
        local delveUnit = ns.Modules.Misdirection.FindDelveCompanionID()
        if delveUnit then return delveUnit end
    end

    local logic = ns.db and ns.db.misdirLogic or "PET"

    if logic == "PET" then
        return "pet"
    elseif logic == "TANK" then
        local inRaid = IsInRaid()
        local count = GetNumGroupMembers()
        if inRaid then
            for i = 1, count do
                local unit = "raid" .. i
                if IsValidMisdirTarget(unit) and UnitGroupRolesAssigned(unit) == "TANK" then
                    return unit
                end
            end
        else
            for i = 1, count do
                local unit = "party" .. i
                if IsValidMisdirTarget(unit) and UnitGroupRolesAssigned(unit) == "TANK" then
                    return unit
                end
            end
        end
    elseif logic == "TARGETTARGET" then
        return "targettarget"
    elseif logic == "CUSTOM" then
        return (ns.db.misdirCustomName ~= "" and ns.db.misdirCustomName) or nil
    end

    return nil
end

function ns.Modules.Misdirection.DisableAndRemoveMacro()
    if not ns.db then return end
    ns.db.misdirEnabled = false

    local macroName = "Nightveil"
    local idx = GetMacroIndexByName(macroName)

    if not InCombatLockdown() then
        if idx > 0 then DeleteMacro(idx) end
        ns.misdirLastTargetID = nil
        ns.misdirLastMacroBody = nil
    else
        print(ns.Shared.GetAddonName() .. ": " .. (ns.L and ns.L.ErrorMacroCombatLock or "This action cannot be used in combat."))
        ns.misdirUpdateQueued = true
    end
end

-- ============================================================================
-- [[ MACRO MANAGEMENT ]] -----------------------------------------------------
-- ============================================================================
function ns.Modules.Misdirection.UpdateMacro(force)
    if not ns.db then return false end
    if not ns.db.misdirEnabled then return false end

    if InCombatLockdown() then
        ns.misdirUpdateQueued = true
        return false
    end

    local spellName = ns.Modules.Misdirection.GetSpellName() or (ns.L and ns.L.Misdirection or "Misdirection")
    local learned = false
    if IsSpellKnown(34477) or (IsPlayerSpell and IsPlayerSpell(34477)) then
        learned = true
    end

    local lines = {}
    local tankUnit = nil
    local body = ""

    if not ns.IsHunter or not learned then
        local warningMsg = not ns.IsHunter
            and (ns.L and ns.L.ErrorNotHunter or "You are not a Hunter.")
            or  (ns.L and ns.L.ErrorMisdirNotLearned  or "You have not learned Misdirection yet.")
        local addonPrefix = ns.Shared.GetAddonName()
        local printLine = "/run print(\"" .. addonPrefix .. ": |cffff9933" .. warningMsg .. "|r\")"
        table.insert(lines, printLine)
        body = table.concat(lines, "\n")
    else
        table.insert(lines, "#showtooltip")
        tankUnit = ns.Modules.Misdirection.FindBestTargetID()
        local castParts = {}
        table.insert(castParts, "/cast")

        local inDelveWithCompanion = false
        if ns.db.misdirDelveCompanion then
            local delveUnit = ns.Modules.Misdirection.FindDelveCompanionID()
            if delveUnit then
                table.insert(castParts, "[@" .. delveUnit .. ",help,nodead]")
                inDelveWithCompanion = true
            end
        end

        if not inDelveWithCompanion then
            if ns.db.misdirUseMouseover then
                table.insert(castParts, "[@mouseover,help,nodead]")
            end
            if ns.db.misdirUseFocus then
                table.insert(castParts, "[@focus,help,nodead]")
            end
            -- Pet option
            if tankUnit == "pet" then
                table.insert(castParts, "[@pet,nodead]")
            elseif tankUnit and tankUnit ~= "" then
                table.insert(castParts, "[@" .. tankUnit .. ",help,nodead]")
            end
        end

        table.insert(castParts, "[] " .. spellName)
        table.insert(lines, table.concat(castParts, " "))
        body = table.concat(lines, "\n")
    end

    -- [[ Macro Registration & Management ]] ------------------------------------
    local macroName = "Nightveil"
    local icon = 132180 -- Ability_Hunter_Misdirection

    local index = GetMacroIndexByName(macroName)
    local actualBody = index > 0 and GetMacroBody(index) or ""

    if not force and body == ns.misdirLastMacroBody and tankUnit == ns.misdirLastTargetID and body == actualBody then
        return true
    end

    if index == 0 then
        local numGlobal, numChar = GetNumMacros()
        if numGlobal < 120 then
            index = CreateMacro(macroName, icon, body, nil)
        elseif numChar < 18 then
            index = CreateMacro(macroName, icon, body, 1)
        else
            if ns.debugMode then print(ns.Shared.GetAddonName() .. ": " .. (ns.L and ns.L.ErrorMacroLimitReached or "Macro limit reached.")) end
            return
        end
    else
        EditMacro(index, macroName, icon, body)
        if ns.debugMode then
            print(ns.Shared.GetAddonName() .. ": |cffce9cff[Debug]|r " .. (ns.L and ns.L.DebugMacroEdited or "Macro content modified and synchronized."))
        end
    end

    local oldTargetID = ns.misdirLastTargetID
    ns.misdirLastTargetID  = tankUnit
    ns.misdirLastMacroBody = body
    ns.misdirUpdateQueued  = false

    local targetName
    if tankUnit == "targettarget" then
        targetName = "|cff00ffff" .. (ns.L and ns.L.TargetTarget or "Target of Target") .. "|r"
    elseif tankUnit == "pet" then
        targetName = "|cffaad372" .. (ns.L and ns.L.Pet or "Pet") .. "|r"
    elseif tankUnit then
        targetName = ns.Shared.GetClassColoredName and ns.Shared.GetClassColoredName(tankUnit) or tankUnit
    else
        targetName = "|cffaaaaaa" .. (ns.L and ns.L.DebugNone or "none") .. "|r"
    end

    if force and ns.debugMode then
        print(string.format(ns.Shared.GetAddonName() .. ": |cffbe89e9[Debug]|r " .. (ns.L and ns.L.DebugMacroUpdated or "Macro updated: %s"), targetName or "nil"))
    end

    if ns.IsHunter and learned and ns.db.misdirEnabled and not ns.db.misdirMute then
        local changed = (tankUnit ~= oldTargetID)
        local exists = tankUnit and (tankUnit == "targettarget" or tankUnit == "pet" or UnitExists(tankUnit))

        if changed and exists then
            print(string.format(ns.Shared.GetAddonName() .. ": |cffbe89e9%s|r → %s",
                ns.L and ns.L.MisdirTargetLog or "Misdirection Target", targetName or "unknown"))
        end
    end
    return true
end

-- ============================================================================
-- [[ INITIALIZATION & EXPORTS ]] ---------------------------------------------
-- ============================================================================
ns.Modules.Misdirection.Init = function()
end

ns.Misdir_FindDelveCompanionID = ns.Modules.Misdirection.FindDelveCompanionID
ns.Misdir_FindBestTargetID     = ns.Modules.Misdirection.FindBestTargetID
ns.Misdir_DisableAndRemoveMacro = ns.Modules.Misdirection.DisableAndRemoveMacro
ns.Misdir_GetSpellName         = ns.Modules.Misdirection.GetSpellName
ns.Misdir_UpdateMacro          = ns.Modules.Misdirection.UpdateMacro
