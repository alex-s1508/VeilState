-- ============================================================================
-- [[ NIGHTVEIL — CORE COORDINATOR ]] ----------------------------------------
-- ============================================================================
local addonName, ns = ...

-- [[ NAMESPACE INHERITANCE ]] ------------------------------------------------
ns.Shared    = ns.Shared or {}
ns.Classes   = ns.Classes or {}
ns.Modules   = ns.Modules or {}
ns.UI        = ns.UI or {}
ns.frame     = CreateFrame("Frame")
ns.debugMode = false
ns.tricksLastEventTime = 0

-- [[ STATE COORDINATION ]] ---------------------------------------------------

-- Refresh all active visual modules based on current player state
function ns.UpdateState(forceVisualRefresh)
    if ns.IsRogue then
        if ns.Modules.Stealth and ns.Modules.Stealth.RefreshVisuals then
            ns.Modules.Stealth.RefreshVisuals(forceVisualRefresh)
        end
    elseif ns.IsHunter then
        if ns.Modules.Camouflage and ns.Modules.Camouflage.RefreshVisuals then
            ns.Modules.Camouflage.RefreshVisuals(forceVisualRefresh)
        end
    else
        if ns.Modules.StealthState and ns.Modules.StealthState.RefreshVisuals then
            ns.Modules.StealthState.RefreshVisuals(forceVisualRefresh)
        end
    end
    
    if ns.Modules.Poisons and ns.Modules.Poisons.RefreshVisuals then
        ns.Modules.Poisons.RefreshVisuals(forceVisualRefresh)
    end
    
    if ns.Shared.ApplyHighlight then
        ns.Shared.ApplyHighlight()
    end
end
