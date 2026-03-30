-- ============================================================================
-- [[ GROUP SCANNER ]] --------------------------------------------------------
-- ============================================================================
local addonName, ns = ...
ns.Shared = ns.Shared or {}


function ns.Shared.GetGroupComposition()
    local inGroup = IsInGroup()
    local isRaid = IsInRaid()
    local numMembers = GetNumGroupMembers()

    local players = 1
    local others = 0
    local pets = 0

    if isRaid then
        players = 0
        for i = 1, numMembers do
            local unit = "raid" .. i
            if UnitExists(unit) then
                if UnitIsPlayer(unit) then
                    players = players + 1
                else
                    others = others + 1
                end
            end
            local petUnit = "raidpet" .. i
            if UnitExists(petUnit) then
                pets = pets + 1
            end
        end
    elseif inGroup then
        if UnitExists("pet") then
            pets = pets + 1
        end
        for i = 1, math.max(0, numMembers - 1) do
            local unit = "party" .. i
            if UnitExists(unit) then
                if UnitIsPlayer(unit) then
                    players = players + 1
                else
                    others = others + 1
                end
            end
            local petUnit = "partypet" .. i
            if UnitExists(petUnit) then
                pets = pets + 1
            end
        end
    else
        if UnitExists("pet") then
            pets = pets + 1
        end
    end

    return players, pets, others, inGroup, isRaid
end
