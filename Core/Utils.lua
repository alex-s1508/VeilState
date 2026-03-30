-- ============================================================================
-- [[ UTILITY SUITE ]] --------------------------------------------------------
-- ============================================================================
local addonName, ns = ...
ns.Shared = ns.Shared or {}

-- [[ VERSION CONTROL ]] ------------------------------------------------------

-- Version comparison (e.g., 1.10.2 < 2.0.0)
-- Returns 1 if v1 > v2, -1 if v1 < v2, 0 if equal
function ns.CompareVersions(v1, v2)
    local function parse(v)
        local parts = {}
        for part in string.gmatch(v or "", "%d+") do
            table.insert(parts, tonumber(part))
        end
        return parts
    end
    local p1, p2 = parse(v1), parse(v2)
    for i = 1, math.max(#p1, #p2) do
        local n1, n2 = p1[i] or 0, p2[i] or 0
        if n1 > n2 then return 1 end
        if n1 < n2 then return -1 end
    end
    return 0
end

-- [[ SHARED UTILITIES ]] ----------------------------------------------------

function ns.Shared.DeepCopy(t)
    if type(t) ~= "table" then return t end
    local res = {}
    for k, v in pairs(t) do
        res[ns.Shared.DeepCopy(k)] = ns.Shared.DeepCopy(v)
    end
    return res
end


function ns.Shared.GetClassColor(classFilename)
    local hex = ns.Shared.CLASS_COLORS and ns.Shared.CLASS_COLORS[classFilename]
    if hex then return "|cff" .. hex end
    local color = RAID_CLASS_COLORS[classFilename]
    if color then
        return string.format("|cff%02x%02x%02x", color.r * 255, color.g * 255, color.b * 255)
    end
    return "|cffffffff"
end

function ns.Shared.GetClassColoredName(unit)
    if not unit or not UnitExists(unit) then return "" end
    local name = UnitName(unit)
    local _, class = UnitClass(unit)
    if class then
        local hex = ns.Shared.CLASS_COLORS and ns.Shared.CLASS_COLORS[class]
        if hex then
            return "|cff" .. hex .. name .. "|r"
        end
        local color = RAID_CLASS_COLORS[class]
        if color then
            return string.format("|c%s%s|r", color.colorStr, name)
        end
    end
    return name
end

-- ============================================================================
-- [[ DIAGNOSTIC TOOLS ]] -----------------------------------------------------
-- ============================================================================
function ns.Shared.DebugState()
    local inInstance, instanceType = IsInInstance()
    local numMembers = GetNumGroupMembers()
    local inGroup = IsInGroup()
    local isRaid = IsInRaid()
    local combat = UnitAffectingCombat("player")
    local stealthed = IsStealthed()
    
    local players, pets, others = ns.Shared.GetGroupComposition()

    local prefix = isRaid and "raid" or "party"
    local membersInfo = {}
    
    local strPlayer = ns.L and ns.L.DebugPlayer or "PLAYER"
    local strPet = ns.L and ns.L.DebugPet or "PET"
    local strOther = ns.L and ns.L.DebugOther or "OTHER"
    local strUnknown = ns.L and ns.L.DebugUnknown or "Unknown"

    table.insert(membersInfo, string.format(" - [1] %s (YOU) [\|cffbe89e9%s|r]", UnitName("player"), strPlayer))
    if UnitExists("pet") and not isRaid then
        table.insert(membersInfo, string.format(" - [P] %s [\|cff6b5c92%s|r]", UnitName("pet") or strPet, strPet))
    end

    local loopEnd = isRaid and numMembers or (numMembers - 1)
    if numMembers > 0 then
        for i = 1, loopEnd do
            local unit = prefix .. i
            if UnitExists(unit) and not UnitIsUnit(unit, "player") then
                local name = UnitName(unit) or strUnknown
                local isPlayer = UnitIsPlayer(unit)
                local typeStr = isPlayer and ("\|cffbe89e9" .. strPlayer .. "|r") or ("|cffff0000" .. strOther .. "|r")
                
                local _, class = UnitClass(unit)
                local cStr = (class and RAID_CLASS_COLORS[class]) and RAID_CLASS_COLORS[class].colorStr or "ffffffff"
                local nameStr = "|c" .. cStr .. name .. "|r"

                table.insert(membersInfo, string.format(" - [%d] %s [%s]", #membersInfo + 1, nameStr, typeStr))
            end

            local petUnit = (isRaid and ("raidpet" .. i) or ("partypet" .. i))
            if UnitExists(petUnit) then
                table.insert(membersInfo, string.format(" - [P] %s [\|cff6b5c92%s|r]", UnitName(petUnit) or strPet, strPet))
            end
        end
    end
    
    local function GetYesNo(val)
        return val and ("\|cffbe89e9" .. (ns.L and ns.L.DebugYes or "YES") .. "|r") or ("|cffff0000" .. (ns.L and ns.L.DebugNo or "NO") .. "|r")
    end

    print(ns.L and ns.L.DebugHeader and string.format(ns.L.DebugHeader, ns.GetAddonName()) or (ns.GetAddonName() .. " Debug:"))
    print(string.format(ns.L and ns.L.DebugCombat or " - Combat: %s", GetYesNo(combat)))
    print(string.format(ns.L and ns.L.DebugStealth or " - Stealth: %s", GetYesNo(stealthed)))
    print(string.format(ns.L and ns.L.DebugInstance or " - Instance: %s (Type: %s)", GetYesNo(inInstance), instanceType or (ns.L and ns.L.DebugNone or "none")))
    print(string.format(ns.L and ns.L.DebugGroup or " - Group: %s (Raid: %s, Total: %d)", GetYesNo(inGroup), GetYesNo(isRaid), numMembers))
    print(string.format(ns.L and ns.L.DebugComposition or " - Composition: \|cffbe89e9%d Players|r, \|cff6b5c92%d Pets|r, |cffff0000%d Others|r", players, pets, others))
    print(string.format(ns.L and ns.L.DebugInvalidGroup or " - Invalid Group: %s", GetYesNo(inGroup and players <= 1 and others > 0)))
    
    for _, info in ipairs(membersInfo) do
        print(info)
    end
    
    local db = ns.db
    if db then
        local function label(c)
            return (ns.L and ns.L["Channel" .. (c or "NONE")]) or (c or "NONE")
        end
        print(string.format(ns.L and ns.L.DebugFallback1 or " - Fallback 1: |cffffff00%s|r (Usable: %s)", label(db.shroudChannelFallback1), GetYesNo(ns.Shared.IsChannelUsable and ns.Shared.IsChannelUsable(db.shroudChannelFallback1) or false)))
        print(string.format(ns.L and ns.L.DebugFallback2 or " - Fallback 2: |cffffff00%s|r (Usable: %s)", label(db.shroudChannelFallback2), GetYesNo(ns.Shared.IsChannelUsable and ns.Shared.IsChannelUsable(db.shroudChannelFallback2) or false)))
    end

    if ns.IsRogue then
        print(string.format(ns.L and ns.L.DebugTricksKnown or " - Tricks Known: %s", GetYesNo(ns.KnowsTricks)))
        local tankUnit = ns.Modules.Tricks and ns.Modules.Tricks.FindBestTargetID and ns.Modules.Tricks.FindBestTargetID()
        local targetName = tankUnit and ns.Shared.GetClassColoredName and ns.Shared.GetClassColoredName(tankUnit) or (ns.L and ns.L.DebugNone or "none")
        print(string.format(ns.L and ns.L.DebugTricksTarget or " - Tricks Target: %s (%s)", targetName, tankUnit or "nil"))
        local statusStr = ns.tricksLastMacroBody and ("|cffbe89e9" .. (ns.L and ns.L.DebugYes or "OK") .. "|r") or ("|cffff0000" .. (ns.L and ns.L.DebugNo or "Missing") .. "|r")
        print(string.format(ns.L and ns.L.DebugTricksMacro or " - Tricks Macro: %s", statusStr))
    end
end
