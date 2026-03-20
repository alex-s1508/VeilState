-- ============================================================================
-- [[ NIGHTVEIL — CHARACTER HIGHLIGHT ENGINE ]] -----------------------------
-- ============================================================================
local addonName, ns = ...
ns.Modules = ns.Modules or {}
ns.Modules.Highlight = {}

-- [[ STATE STORAGE ]] --------------------------------------------------------

local captured = {}
local DB_OVERRIDE_ACTIVE = false
local isHooked = false

local function CaptureOriginal()
    captured.findYourselfMode        = GetCVar("findYourselfMode")
    captured.findYourselfModeCircle  = GetCVar("findYourselfModeCircle")
    captured.findYourselfModeOutline = GetCVar("findYourselfModeOutline")
    captured.findYourselfModeIcon    = GetCVar("findYourselfModeIcon")
    captured.findYourselfAnywhere    = GetCVar("findYourselfAnywhere")
    captured.selfHighlight           = GetCVar("selfHighlight")
end

-- ============================================================================
-- [[ CVAR MANAGEMENT ]] ------------------------------------------------------
-- ============================================================================

local function ApplyCVarOverrides(s)
    if not s or s == -1 then return end

    if s == 0 then
        SetCVar("findYourselfMode", "0")
        SetCVar("findYourselfModeCircle", "0")
        SetCVar("findYourselfModeOutline", "0")
        SetCVar("findYourselfModeIcon", "0")
        SetCVar("selfHighlight", "0")
    else
        SetCVar("findYourselfMode", tostring(s))
        SetCVar("findYourselfModeCircle", (s==1 or s==4 or s==5 or s==7) and "1" or "0")
        SetCVar("findYourselfModeOutline", (s==2 or s==4 or s==6 or s==7) and "1" or "0")
        SetCVar("findYourselfModeIcon", (s==3 or s==5 or s==6 or s==7) and "1" or "0")
        SetCVar("findYourselfAnywhere", "1")
        SetCVar("selfHighlight", "1")
    end
end

function ns.Modules.Highlight.RestoreOriginal()
    if not DB_OVERRIDE_ACTIVE then return end

    SetCVar("findYourselfMode", "0")
    SetCVar("findYourselfModeCircle", "0")
    SetCVar("findYourselfModeOutline", "0")
    SetCVar("findYourselfModeIcon", "0")
    SetCVar("selfHighlight", "0")

    for cvar, val in pairs(captured) do
        if val ~= nil then
            SetCVar(cvar, tostring(val))
        end
    end

    DB_OVERRIDE_ACTIVE = false
end

-- ============================================================================
-- [[ HIGHLIGHT COORDINATION ]] -----------------------------------------------
-- ============================================================================

function ns.Modules.Highlight.UpdateState()
    local db = ns.db
    if not db then return end

    if not isHooked then
        isHooked = true
        CaptureOriginal()
    end

    local inCombat   = UnitAffectingCombat("player")
    local inInstance = IsInInstance()

    local targetHighlight = -1
    local shouldOverride  = false

    -- Priority 1: Shroud of Concealment (Rogue)
    if ns.IsRogue and ns.Modules.Shroud and ns.Modules.Shroud.HasOwnShroudAura and ns.Modules.Shroud.HasOwnShroudAura() then
        targetHighlight = db.highlightShroud
        shouldOverride  = (targetHighlight ~= -1)
    
    -- Priority 2: Stealth (Rogue)
    elseif ns.IsRogue and ns.UI.StealthFrame and ns.UI.StealthFrame._lastState then
        targetHighlight = db.highlightStealth
        shouldOverride  = (targetHighlight ~= -1)

    -- Priority 3: Camouflage (Hunter)
    elseif ns.IsHunter and ns.UI.StealthFrame and ns.UI.StealthFrame._lastState then
        targetHighlight = db.highlightCamouflage
        shouldOverride  = (targetHighlight ~= -1)

    -- Priority 4: Stealth State (Other Classes)
    elseif not ns.IsRogue and not ns.IsHunter and ns.UI.StealthFrame and ns.UI.StealthFrame._lastState then
        targetHighlight = db.highlightStealthState
        shouldOverride  = (targetHighlight ~= -1)

    -- Priority 5: Combat
    elseif inCombat then
        targetHighlight = db.highlightCombat
        shouldOverride  = (targetHighlight ~= -1)

    -- Priority 6: Instance
    elseif inInstance then
        targetHighlight = db.highlightInstance
        shouldOverride  = (targetHighlight ~= -1)
    end

    if shouldOverride then
        if not DB_OVERRIDE_ACTIVE then
            CaptureOriginal()
        end
        ApplyCVarOverrides(targetHighlight)
        DB_OVERRIDE_ACTIVE = true
    else
        if DB_OVERRIDE_ACTIVE then
            ns.Modules.Highlight.RestoreOriginal()
        end
    end
end

ns.Shared.ApplyHighlight          = ns.Modules.Highlight.UpdateState
ns.Shared.RestoreOriginalHighlight = ns.Modules.Highlight.RestoreOriginal