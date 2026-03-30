-- ============================================================================
-- [[ CORE COORDINATOR ]] -----------------------------------------------------
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
ns.misdirLastEventTime = 0

-- [[ STATE COORDINATION ]] ---------------------------------------------------

-- Refresh all active visual modules based on current player state
function ns.UpdateState(forceVisualRefresh)
    if ns.Modules.HiddenState and ns.Modules.HiddenState.RefreshVisuals then
        ns.Modules.HiddenState.RefreshVisuals(forceVisualRefresh)
    end
    
    if ns.Modules.Poisons and ns.Modules.Poisons.RefreshVisuals then
        ns.Modules.Poisons.RefreshVisuals(forceVisualRefresh)
    end
    
    if ns.Shared.ApplyHighlight then
        ns.Shared.ApplyHighlight()
    end
end
