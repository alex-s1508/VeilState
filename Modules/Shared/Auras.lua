-- ============================================================================
-- [[ NIGHTVEIL — AURA SCANNER ]] --------------------------------------------
-- ============================================================================
local addonName, ns = ...
ns.Shared = ns.Shared or {}

-- Checks if the player has any of the specified aura IDs

function ns.Shared.HasAura(ids)
    if C_UnitAuras and C_UnitAuras.GetPlayerAuraBySpellID then
        for _, id in ipairs(ids) do
            if C_UnitAuras.GetPlayerAuraBySpellID(id) then return true end
        end
    else
        local i = 1
        while true do
            local name, _, _, _, _, _, _, _, _, buffID = UnitBuff("player", i)
            if not name then break end
            for _, id in ipairs(ids) do
                if buffID == id then return true end
            end
            i = i + 1
        end
    end
    return false
end

