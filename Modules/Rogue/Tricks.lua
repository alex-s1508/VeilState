-- ============================================================================
-- [[ NIGHTVEIL — ROGUE: TRICKS OF THE TRADE ]] -----------------------------
-- ============================================================================
local addonName, ns = ...
ns.Modules = ns.Modules or {}
ns.Modules.Tricks = {}

-- [[ CONSTANTS & STATE ]] ----------------------------------------------------

local DELVE_COMPANIONS = {
    ["210759"] = true, -- Brann Bronzebeard
    ["204418"] = true, -- Valeera Sanguinar
}

ns.tricksLastTargetID = nil
ns.tricksLastMacroBody = nil
ns.tricksUpdateQueued = false
ns.tricksLastEventTime = 0

-- ============================================================================
-- [[ TARGETING LOGIC ]] ------------------------------------------------------
-- ============================================================================

local function IsValidTricksTarget(unit)
    if not unit or not UnitExists(unit) then return false end
    if UnitIsUnit("player", unit) or UnitIsDeadOrGhost(unit) then return false end
    
    local guid = UnitGUID(unit)
    local npcID = guid and select(6, strsplit("-", guid))
    if DELVE_COMPANIONS[npcID] then return true end

    return UnitCanAssist("player", unit)
end

function ns.Modules.Tricks.GetSpellName()
    if C_Spell and C_Spell.GetSpellName then
        return C_Spell.GetSpellName(57934)
    elseif GetSpellInfo then
        local name = GetSpellInfo(57934)
        return name
    end
    return nil
end

function ns.Modules.Tricks.FindDelveCompanionID()
    local count = GetNumGroupMembers()
    if count > 0 then
        for i = 1, count do
            local unit = "party" .. i
            if UnitExists(unit) then
                local name = UnitName(unit)
                if name == (ns.L and ns.L.BrannBronzebeard) or name == (ns.L and ns.L.ValeeraSanguinar) then
                    return unit
                end
                
                -- Fallback to checking hardcoded NPC IDs
                local guid = UnitGUID(unit)
                local npcID = guid and select(6, strsplit("-", guid))
                if npcID == "210759" or npcID == "204418" then return unit end
            end
        end
    end
    return nil
end

function ns.Modules.Tricks.FindBestTargetID()
    -- delve
    if ns.db and ns.db.tricksDelveCompanion then
        local delveUnit = ns.Modules.Tricks.FindDelveCompanionID()
        if delveUnit then return delveUnit end
    end

    -- Choose targeting logic based on profile settings
    local logic = ns.db and ns.db.tricksLogic or "TANK"
    
    if logic == "TANK" then
        local inRaid = IsInRaid()
        local prefix = inRaid and "raid" or "party"
        local count = GetNumGroupMembers()
        
        if inRaid then
            for i = 1, count do
                local unit = "raid" .. i
                if IsValidTricksTarget(unit) and UnitGroupRolesAssigned(unit) == "TANK" then
                    return unit
                end
            end
        else
            for i = 1, count do
                local unit = "party" .. i
                if IsValidTricksTarget(unit) and UnitGroupRolesAssigned(unit) == "TANK" then
                    return unit
                end
            end
        end
    elseif logic == "TARGETTARGET" then
        return "targettarget"
    elseif logic == "CUSTOM" then
        return (ns.db.tricksCustomName ~= "" and ns.db.tricksCustomName) or nil
    end
    
    return nil
end

function ns.Modules.Tricks.DisableAndRemoveMacro()
    if not ns.db then return end
    ns.db.tricksEnabled = false
    
    local macroName = "Nightveil"
    local idx = GetMacroIndexByName(macroName)
    if not InCombatLockdown() then
        if idx > 0 then DeleteMacro(idx) end
        ns.tricksLastTargetID = nil
        ns.tricksLastMacroBody = nil
    else
        print(ns.Shared.GetAddonName() .. ": " .. (ns.L and ns.L.ErrorMacroCombatLock or "This action cannot be used in combat."))
        ns.tricksUpdateQueued = true
    end
end

-- ============================================================================
-- [[ MACRO MANAGEMENT ]] -----------------------------------------------------
-- ============================================================================
function ns.Modules.Tricks.UpdateMacro(force)
    if not ns.db then return false end
    
    if not ns.db.tricksEnabled then return false end
    
    if InCombatLockdown() then
        ns.tricksUpdateQueued = true
        return false
    end

    local spellName = ns.Modules.Tricks.GetSpellName() or (ns.L and ns.L.TricksOfTheTrade or "Tricks of the Trade")
    local learned = false
    if IsSpellKnown(57934) or (IsPlayerSpell and IsPlayerSpell(57934)) then
        learned = true
    end

    local lines = {}
    local tankUnit = nil
    local body = ""

    if not ns.IsRogue or not learned then
        local warningMsg = not ns.IsRogue and (ns.L and ns.L.ErrorNotRogue or "You are not a Rogue.") or (ns.L and ns.L.ErrorTricksNotLearned or "You have not learned Tricks of the Trade yet.")
        local addonPrefix = ns.Shared.GetAddonName()
        local printLine = "/run print(\"" .. addonPrefix .. ": |cffff9933" .. warningMsg .. "|r\")"
        table.insert(lines, printLine)
        body = table.concat(lines, "\n")
    else
        table.insert(lines, "#showtooltip")
        tankUnit = ns.Modules.Tricks.FindBestTargetID()
        local castParts = {}
        table.insert(castParts, "/cast")
        
        local inDelveWithCompanion = false
        if ns.db.tricksDelveCompanion then
            local delveUnit = ns.Modules.Tricks.FindDelveCompanionID()
            if delveUnit then
                table.insert(castParts, "[@" .. delveUnit .. ",help,nodead]")
                inDelveWithCompanion = true
            end
        end

        if not inDelveWithCompanion then
            if ns.db.tricksUseMouseover then
                table.insert(castParts, "[@mouseover,help,nodead]")
            end
            if ns.db.tricksUseFocus then
                table.insert(castParts, "[@focus,help,nodead]")
            end
            if tankUnit and tankUnit ~= "" then
                table.insert(castParts, "[@" .. tankUnit .. ",help,nodead]")
            end
        end
        
        table.insert(castParts, "[] " .. spellName)
        table.insert(lines, table.concat(castParts, " "))
        body = table.concat(lines, "\n")
    end
    
    -- [[ Macro Registration & Management ]] -------------------------------------
    local macroName = "Nightveil"
    local icon = 236283 -- Ability_Rogue_TricksOftheTrade
    
    local index = GetMacroIndexByName(macroName)
    local actualBody = index > 0 and GetMacroBody(index) or ""

    if not force and body == ns.tricksLastMacroBody and tankUnit == ns.tricksLastTargetID and body == actualBody then
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

    local oldTargetID = ns.tricksLastTargetID
    ns.tricksLastTargetID = tankUnit
    ns.tricksLastMacroBody = body
    ns.tricksUpdateQueued = false

    local targetName
    if tankUnit == "targettarget" then
        targetName = "|cff00ffff" .. (ns.L and ns.L.TargetTarget or "Target of Target") .. "|r"
    elseif tankUnit then
        targetName = ns.Shared.GetClassColoredName and ns.Shared.GetClassColoredName(tankUnit) or tankUnit
    else
        targetName = "|cffaaaaaa" .. (ns.L and ns.L.DebugNone or "none") .. "|r"
    end

    if force and ns.debugMode then
        print(string.format(ns.Shared.GetAddonName() .. ": |cffbe89e9[Debug]|r " .. (ns.L and ns.L.DebugMacroUpdated or "Macro updated: %s"), targetName or "nil"))
    end

    if ns.IsRogue and learned and ns.db.tricksEnabled and not ns.db.tricksMute then
        -- Log target changes to chat if they actually exist
        local changed = (tankUnit ~= oldTargetID)
        local exists = tankUnit and (tankUnit == "targettarget" or UnitExists(tankUnit))
        
        if changed and exists then
            print(string.format(ns.Shared.GetAddonName() .. ": |cffbe89e9%s|r → %s", ns.L and ns.L.TricksTargetLog or "Tricks Target", targetName or "unknown"))
        end
    end
    return true
end

-- ============================================================================
-- [[ INITIALIZATION & EXPORTS ]] ---------------------------------------------
-- ============================================================================
ns.Modules.Tricks.Init = function()
end

ns.Tricks_FindDelveCompanionID = ns.Modules.Tricks.FindDelveCompanionID
ns.Tricks_FindBestTargetID = ns.Modules.Tricks.FindBestTargetID
ns.Tricks_DisableAndRemoveMacro = ns.Modules.Tricks.DisableAndRemoveMacro
ns.Tricks_GetSpellName = ns.Modules.Tricks.GetSpellName
ns.Tricks_UpdateMacro = ns.Modules.Tricks.UpdateMacro
