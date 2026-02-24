local addonName, ns = ...

local SHADOW_DANCE_IDS = {185313, 185422}
local SHROUD_IDS = {115834, 114018}

local captured = {}
local hasCaptured = false
local shroudTicker = nil
local shroudActive = false
local lastShroudTime = 0

ns.IsInShadowDance = false
ns.IsRogue = false

local function HasAura(ids)
    if C_UnitAuras then
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

local function BackupState()
    if not hasCaptured then return end
    NightveilSavedState = {originalCVars = captured, isCaptured = true}
end

local function RecoverState()
    if NightveilSavedState and NightveilSavedState.isCaptured then
        captured = NightveilSavedState.originalCVars
        hasCaptured = true
    end
end

local function ClearBackup()
    NightveilSavedState = nil
end

function ns.CaptureOriginal()
    if hasCaptured then return end
    RecoverState()
    if hasCaptured then return end
    captured.findYourselfMode        = GetCVar("findYourselfMode")
    captured.findYourselfModeCircle  = GetCVar("findYourselfModeCircle")
    captured.findYourselfModeOutline = GetCVar("findYourselfModeOutline")
    captured.findYourselfModeIcon    = GetCVar("findYourselfModeIcon")
    captured.findYourselfAnywhere    = GetCVar("findYourselfAnywhere")
    captured.selfHighlight           = GetCVar("selfHighlight")
    hasCaptured = true
    BackupState()
end

function ns.RestoreOriginal()
    if not hasCaptured then return end
    SetCVar("findYourselfMode", 0)
    SetCVar("findYourselfModeCircle", 0)
    SetCVar("findYourselfModeOutline", 0)
    SetCVar("findYourselfModeIcon", 0)
    for cvar, val in pairs(captured) do
        if val then SetCVar(cvar, val) end
    end
    hasCaptured = false
    ClearBackup()
end

function ns.ApplyHighlight()
    local db = ns.db
    if not db then return end
    -- shadow dance takes priority if active
    local sd = ns.IsInShadowDance and db.sdEnabled
    local enableHL = sd and db.sdEnableHighlight
    if not sd then enableHL = db.enableHighlight end
    local hlType = sd and db.sdHighlightType or db.highlightType
    
    if not enableHL then
        SetCVar("findYourselfMode", 0)
        SetCVar("findYourselfModeCircle", 0)
        SetCVar("findYourselfModeOutline", 0)
        SetCVar("findYourselfModeIcon", 0)
        return
    end
    local s = hlType or 2
    SetCVar("findYourselfMode",        s)
    SetCVar("findYourselfModeCircle",  (s==1 or s==4 or s==5 or s==7) and 1 or 0)
    SetCVar("findYourselfModeOutline", (s==2 or s==4 or s==6 or s==7) and 1 or 0)
    SetCVar("findYourselfModeIcon",    (s==3 or s==5 or s==6 or s==7) and 1 or 0)
    SetCVar("findYourselfAnywhere", 1)
    SetCVar("selfHighlight", 1)
end

function ns.StopShroudCountdown(sendEnd)
    if sendEnd and shroudActive and ns.db and ns.db.shroudEndMsg and ns.db.shroudEndMsg:gsub("%s+", "") ~= "" then
        pcall(SendChatMessage, ns.db.shroudEndMsg, ns.db.shroudChannel or "PARTY")
    end
    if shroudTicker then shroudTicker:Cancel() end
    shroudTicker = nil
    shroudActive = false
end

function ns.StartShroudCountdown()
    ns.StopShroudCountdown(false)
    local db = ns.db
    if not db or not db.shroudCountdown then return end

    local channel      = db.shroudChannel or "PARTY"
    local useInterval  = db.shroudInterval

    local function Send(msg)
        if msg and msg:gsub("%s+", "") ~= "" then
            pcall(SendChatMessage, msg, channel)
        end
    end

    local function FormatMsg(timeLeft)
        local template = (db.shroudMessage and db.shroudMessage:gsub("%s+", "") ~= "") and db.shroudMessage or "%t"
        return template:gsub("%%t", tostring(timeLeft))
    end

    local duration = 14
    local expirationTime = GetTime() + duration

    shroudActive = true

    local function Tick()
        if not shroudActive then return end
        local remaining = expirationTime - GetTime()
        local timeLeft  = math.floor(remaining + 0.5)

        if timeLeft <= 0 then
            ns.StopShroudCountdown(true)
            return
        end

        local shouldSend = not useInterval
                        or timeLeft == 14
                        or timeLeft == 9
                        or timeLeft <= 5

        if shouldSend then
            if timeLeft == 14 and db.shroudStartMsg and db.shroudStartMsg:gsub("%s+", "") ~= "" then
                Send(db.shroudStartMsg)
            else
                Send(FormatMsg(timeLeft))
            end
        end
    end

    Tick()
    if not shroudActive then return end

    shroudTicker = C_Timer.NewTicker(1, Tick)
end

local function CheckShroud()
    local db = ns.db
    if not db or not db.shroudCountdown then
        if shroudActive then ns.StopShroudCountdown() end
        return
    end
    if db.shroudOnlyInstances and IsInInstance then
        local inInstance, instanceType = IsInInstance()
        local ok = inInstance and (instanceType == "party" or instanceType == "raid" or instanceType == "scenario")
        if not ok then
            if shroudActive then ns.StopShroudCountdown() end
            return
        end
    end
    if HasAura(SHROUD_IDS) and not shroudActive then
        if GetTime() - lastShroudTime > 14 then
            lastShroudTime = GetTime()
            ns.StartShroudCountdown()
        end
    elseif not HasAura(SHROUD_IDS) and shroudActive then
        ns.StopShroudCountdown(true)
    end
end

function ns.UpdateState()
    ns.IsInShadowDance = HasAura(SHADOW_DANCE_IDS)
    local db = ns.db
    local function InAllowedInstance()
        if not IsInInstance then return false end
        local inInstance, instanceType = IsInInstance()
        return inInstance and (instanceType == "party" or instanceType == "raid" or instanceType == "scenario")
    end
    local function IsAllowed(onlyCombatKey, onlyInstancesKey)
        if db[onlyCombatKey] and UnitAffectingCombat and not UnitAffectingCombat("player") then
            return false
        end
        if db[onlyInstancesKey] and not InAllowedInstance() then
            return false
        end
        return true
    end

    local sd = ns.IsInShadowDance and db.sdEnabled and IsAllowed("sdOnlyCombat", "sdOnlyInstances")
    local stealthActive = IsStealthed() and db.stealthEnabled and IsAllowed(nil, "stealthOnlyInstances")
    local active = sd or stealthActive
    if active then
        ns.CaptureOriginal()
    else
        ns.RestoreOriginal()
    end
    ns.RefreshVisuals()
end

local eventFrame = CreateFrame("Frame")
eventFrame:RegisterEvent("ADDON_LOADED")
eventFrame:RegisterEvent("UPDATE_STEALTH")
eventFrame:RegisterEvent("UNIT_AURA")
eventFrame:RegisterEvent("PLAYER_REGEN_DISABLED")
eventFrame:RegisterEvent("PLAYER_REGEN_ENABLED")
eventFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
eventFrame:RegisterEvent("ZONE_CHANGED_NEW_AREA")

eventFrame:SetScript("OnEvent", function(self, event, arg1)
    if event == "ADDON_LOADED" and arg1 == addonName then
        if not NightveilDB and VeilStateDB then
            NightveilDB = VeilStateDB
            VeilStateDB = nil
        end
        NightveilDB = NightveilDB or {}
        ns.CopyDefaults(ns.Defaults, NightveilDB)
        ns.db = NightveilDB

        local _, _, classId = UnitClass("player")
        ns.IsRogue = (classId == 4)
        
        if not NightveilSavedState and VeilStateSavedState then
            NightveilSavedState = VeilStateSavedState
            VeilStateSavedState = nil
        end
        RecoverState()
        -- Settings order
        local category = ns.InitMainPanel()
        ns.InitStealthPanel(category)
        ns.InitShadowDancePanel(category)
        if ns.IsRogue and ns.InitPoisonTrackerPanel then
            ns.InitPoisonTrackerPanel(category)
        end
        ns.InitShroudPanel(category)
        ns.RefreshVisuals()
        if ns.IsRogue and ns.RefreshPoisonVisuals then
            C_Timer.After(2, function()
                ns.RefreshPoisonVisuals()
            end)
        end
        if IsStealthed() then ns.UpdateState() end
    elseif event == "UNIT_AURA" and arg1 == "player" then
        local wasSD = ns.IsInShadowDance
        ns.IsInShadowDance = HasAura(SHADOW_DANCE_IDS)
        if ns.IsInShadowDance ~= wasSD then ns.UpdateState() end
        CheckShroud()
        if ns.RefreshPoisonVisuals then
            ns.RefreshPoisonVisuals()
        end
    elseif event == "PLAYER_REGEN_DISABLED" or event == "PLAYER_REGEN_ENABLED" or event == "PLAYER_ENTERING_WORLD" or event == "ZONE_CHANGED_NEW_AREA" then
        ns.UpdateState()
        CheckShroud()
        if ns.RefreshPoisonVisuals then
            ns.RefreshPoisonVisuals()
        end
    else
        ns.UpdateState()
    end
end)
