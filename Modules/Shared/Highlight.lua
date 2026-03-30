-- ============================================================================
-- [[ CHARACTER HIGHLIGHT ENGINE ]] -------------------------------------------
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
    
    -- Priority 2: Specific Class/Race Auras
    else
                local hasClassAura = false
        local classPrefix = (ns.IsRogue and "Rogue") or (ns.IsHunter and "Hunter") or (ns.IsDruid and "Druid") or (ns.IsMage and "Mage")
        if classPrefix and ns.HiddenStateMeta[classPrefix] then
            for _, auraDef in ipairs(ns.HiddenStateMeta[classPrefix]) do
                if ns.Shared.HasAura(auraDef.ids) then
                    hasClassAura = true
                    break
                end
            end
        end

        if hasClassAura then
            if ns.IsRogue then 
                -- Sub-priority for Rogue-specific states
                if ns.Shared.HasAura({185422, 185313, 212283}) then -- Shadow Dance
                    targetHighlight = db.highlightShadowDance
                elseif ns.Shared.HasAura({115192, 115191, 108208}) then -- Subterfuge
                    targetHighlight = db.highlightSubterfuge
                else
                    targetHighlight = db.highlightStealth
                end
            elseif ns.IsHunter then targetHighlight = db.highlightCamouflage
            elseif ns.IsDruid then targetHighlight = db.highlightProwl
            elseif ns.IsMage then targetHighlight = db.highlightInvisibility
            end
            shouldOverride = (targetHighlight ~= -1)
        end
        
        if not shouldOverride and ns.HasShadowmeld and ns.HiddenStateMeta.Shadowmeld then
            for _, auraDef in ipairs(ns.HiddenStateMeta.Shadowmeld) do
                if ns.Shared.HasAura(auraDef.ids) then
                    targetHighlight = db.highlightShadowmeld
                    shouldOverride = (targetHighlight ~= -1)
                    break
                end
            end
        end

        -- Priority 3: Generic Hidden State (IsStealthed fallback)
        if not shouldOverride and IsStealthed() then
            targetHighlight = db.highlightHiddenState
            shouldOverride = (targetHighlight ~= -1)
        end
    end

    -- Priority 4: Combat
    if not shouldOverride and inCombat then
        targetHighlight = db.highlightCombat
        shouldOverride  = (targetHighlight ~= -1)
    end

    -- Priority 5: Instance
    if not shouldOverride and inInstance then
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