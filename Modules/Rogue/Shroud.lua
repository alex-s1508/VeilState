-- ============================================================================
-- [[ NIGHTVEIL — ROGUE: SHROUD COUNTDOWN ]] ---------------------------------
-- ============================================================================
local addonName, ns = ...
ns.Modules = ns.Modules or {}
ns.Modules.Shroud = {}

-- [[ CONSTANTS & STATE ]] ----------------------------------------------------

local SHROUD_IDS = {115834, 114018}
local shroudTicker = nil
local shroudActive = false
local shroudTesting = false
local lastShroudTime = 0

-- ============================================================================
-- [[ COUNTDOWN CONTROL ]] ----------------------------------------------------
-- ============================================================================
function ns.Modules.Shroud.StopCountdown(sendEnd)
    if not shroudActive then return end
    
    local wasTesting = shroudTesting
    shroudTesting = false

    local db = ns.db
    if sendEnd and db and db.shroudEndMsg and db.shroudEndMsg:gsub("%s+", "") ~= "" then
        local msg = tostring(db.shroudEndMsg or "")
        msg = msg:gsub("%%time", "0")
        msg = msg:gsub("%%t%f[%A]", "0")
        
        ns.Shared.SendChatOrPrint(msg, wasTesting)
    end
    
    if shroudTicker then shroudTicker:Cancel() end
    shroudTicker = nil
    shroudActive = false

    if ns.UpdateState then ns.UpdateState() end
end

local function GetShroudAuraTiming()
    if C_UnitAuras and C_UnitAuras.GetPlayerAuraBySpellID then
        for _, id in ipairs(SHROUD_IDS) do
            local aura = C_UnitAuras.GetPlayerAuraBySpellID(id)
            if aura then return aura.expirationTime, aura.duration end
        end
        return nil
    end

    local i = 1
    while true do
        local name, _, _, _, duration, expirationTime, _, _, _, spellId = UnitBuff("player", i)
        if not name then break end
        for _, id in ipairs(SHROUD_IDS) do
            if spellId == id then return expirationTime, duration end
        end
        i = i + 1
    end
    return nil
end

function ns.Modules.Shroud.StartCountdown(expirationTime, duration)
    ns.Modules.Shroud.StopCountdown(false)

    ns.shroudErrorsDisplayed = {}

    local db = ns.db
    if not db or not db.shroudCountdown then return end

    if ns.UpdateState then ns.UpdateState() end
    local useInterval  = db.shroudInterval

    local function FormatMsg(template, timeLeft)
        template = tostring(template or "")
        local t = tostring(timeLeft or 0)
        template = template:gsub("%%time", t)
        template = template:gsub("%%t%f[%A]", t)
        return template
    end

    if not expirationTime then expirationTime, duration = GetShroudAuraTiming() end
    if not expirationTime then return end
    
    duration = tonumber(duration) or math.max(0, expirationTime - GetTime())
    local total = math.max(1, math.floor(duration + 0.5))
    local middle = math.floor((total + 5) / 2)

    shroudActive = true

    local function Tick()
        if not shroudActive then return end

        local auraExp, auraDur = GetShroudAuraTiming()
        if auraExp and auraExp > expirationTime then
            expirationTime = auraExp
            duration = tonumber(auraDur) or duration
            total = math.max(1, math.floor((tonumber(duration) or (expirationTime - GetTime())) + 0.5))
            middle = math.floor((total + 5) / 2)
        end

        local remaining = expirationTime - GetTime()
        local timeLeft  = math.floor(remaining + 0.5)

        if timeLeft <= 0 then
            ns.Modules.Shroud.StopCountdown(true)
            return
        end

        local shouldSend = not useInterval or timeLeft == total or timeLeft == middle or timeLeft <= 5

        if shouldSend then
            if timeLeft == total then
                local startMsg = db.shroudStartMsg
                if startMsg and startMsg:gsub("%s+", "") ~= "" then
                    ns.Shared.SendChatOrPrint(FormatMsg(startMsg, total))
                end
            else
                local template = (db.shroudMessage and db.shroudMessage:gsub("%s+", "") ~= "") and db.shroudMessage or "%time"
                ns.Shared.SendChatOrPrint(FormatMsg(template, timeLeft), shroudTesting)
            end
        end
    end

    Tick()
    if not shroudActive then return end
    shroudTicker = C_Timer.NewTicker(1, Tick)
end

function ns.Modules.Shroud.TestMessage()
    local db = ns.db
    if not db or shroudActive then return end

    ns.shroudErrorsDisplayed = {}
    local duration = 5
    local exp = GetTime() + duration
    shroudActive = true
    shroudTesting = true
    
    local function FormatMsg(template, timeLeft)
        template = tostring(template or "")
        local t = tostring(timeLeft or 0)
        template = template:gsub("%%time", t)
        template = template:gsub("%%t%f[%A]", t)
        return template
    end

    local useInterval = db.shroudInterval
    local total = duration
    local middle = math.floor((total + 5) / 2)

    local function Tick()
        if not shroudActive or not shroudTesting then return end
        local remaining = exp - GetTime()
        local timeLeft = math.floor(remaining + 0.5)

        if timeLeft <= 0 then
            ns.Modules.Shroud.StopCountdown(true)
            return
        end

        local shouldSend = not useInterval or timeLeft == total or timeLeft == middle or timeLeft <= 5
        if not shouldSend then return end

        local template = (db.shroudMessage and db.shroudMessage:gsub("%s+", "") ~= "") and db.shroudMessage or "%time"
        
        if timeLeft == total then
            local startMsg = db.shroudStartMsg
            if startMsg and startMsg:gsub("%s+", "") ~= "" then
                ns.Shared.SendChatOrPrint(FormatMsg(startMsg, total), true)
            else
                ns.Shared.SendChatOrPrint(FormatMsg(template, total), true)
            end
        else
            ns.Shared.SendChatOrPrint(FormatMsg(template, timeLeft), true)
        end
    end

    Tick()
    if shroudActive then
        shroudTicker = C_Timer.NewTicker(1, Tick)
    end
end

-- ============================================================================
-- [[ AUTOMATION & TRIGGERS ]] ------------------------------------------------
-- ============================================================================
function ns.Modules.Shroud.Check()
    if shroudTesting then return end
    local db = ns.db
    if not db or not db.shroudCountdown then
        if shroudActive then ns.Modules.Shroud.StopCountdown(false) end
        return
    end

    local inInstance, instanceType = IsInInstance()

    if db.shroudOnlyInstances and not inInstance then
        if shroudActive then ns.Modules.Shroud.StopCountdown(false) end
        return
    end

    if db.shroudDisableInDungeons and inInstance and instanceType == "party" then
        if shroudActive then ns.Modules.Shroud.StopCountdown(false) end
        return
    end

    if db.shroudDisableInRaids and (IsInRaid() or (inInstance and instanceType == "raid")) then
        if shroudActive then ns.Modules.Shroud.StopCountdown(false) end
        return
    end

    local exp, dur = GetShroudAuraTiming()
    if exp and not shroudActive then
        if GetTime() - (lastShroudTime or 0) > 0.5 then
            lastShroudTime = GetTime()
            ns.Modules.Shroud.StartCountdown(exp, dur)
        end
    elseif not exp and shroudActive then
        ns.Modules.Shroud.StopCountdown(true)
    end
end

function ns.Modules.Shroud.RunTest(duration)
    if not ns.debugMode then
        print(string.format(ns.L and ns.L.DebugModeRequired or (ns.Shared.GetAddonName() .. ": |cffbe89e9This command requires Debug Mode.|r Type |cffffcc00/veil debug|r to enable."), ns.Shared.GetAddonName()))
        return
    end
    if shroudActive then
        print(ns.Shared.GetAddonName() .. ": \|cff6a39a2" .. (ns.L and ns.L.ShroudAlreadyActive or "Shroud countdown is already active.") .. "|r")
        return
    end

    local db = ns.db
    if not db or not db.shroudCountdown then
        print(ns.Shared.GetAddonName() .. ": \|cff6a39a2" .. (ns.L and ns.L.ShroudDisabled or "Shroud countdown is disabled in settings.") .. "|r")
        return
    end

    duration = math.max(1, math.min(20, math.floor(tonumber(duration) or 15)))

    ns.shroudErrorsDisplayed = {}
    local expirationTime = GetTime() + duration
    local total = duration
    local middle = math.floor((total + 5) / 2)
    local useInterval = db.shroudInterval

    shroudActive = true
    shroudTesting = false  -- reset state

    local function FormatMsg(template, timeLeft)
        template = tostring(template or "")
        local t = tostring(timeLeft or 0)
        template = template:gsub("%%time", t)
        template = template:gsub("%%t%f[%A]", t)
        return template
    end

    local function Tick()
        if not shroudActive or shroudTesting then return end

        local remaining = expirationTime - GetTime()
        local timeLeft = math.floor(remaining + 0.5)

        if timeLeft <= 0 then
            ns.Modules.Shroud.StopCountdown(true)
            return
        end

        local shouldSend = not useInterval or timeLeft == total or timeLeft == middle or timeLeft <= 5
        if not shouldSend then return end

        if timeLeft == total then
            local startMsg = db.shroudStartMsg
            if startMsg and startMsg:gsub("%s+", "") ~= "" then
                ns.Shared.SendChatOrPrint(FormatMsg(startMsg, total), false)
            else
                local template = (db.shroudMessage and db.shroudMessage:gsub("%s+", "") ~= "") and db.shroudMessage or "%time"
                ns.Shared.SendChatOrPrint(FormatMsg(template, total), false)
            end
        else
            local template = (db.shroudMessage and db.shroudMessage:gsub("%s+", "") ~= "") and db.shroudMessage or "%time"
            ns.Shared.SendChatOrPrint(FormatMsg(template, timeLeft), false)
        end
    end

    if ns.UpdateState then ns.UpdateState() end
    Tick()
    if shroudActive then
        shroudTicker = C_Timer.NewTicker(1, Tick)
    end
end

function ns.Modules.Shroud.IsActive()
    return shroudActive
end

-- ============================================================================
-- [[ INITIALIZATION & EXPORTS ]] ---------------------------------------------
-- ============================================================================
ns.Modules.Shroud.Init = function()
end

ns.StopShroudCountdown = ns.Modules.Shroud.StopCountdown
ns.StartShroudCountdown = ns.Modules.Shroud.StartCountdown
ns.TestShroudMessage = ns.Modules.Shroud.TestMessage
ns.CheckShroud = ns.Modules.Shroud.Check
ns.RunShroudTest = ns.Modules.Shroud.RunTest
