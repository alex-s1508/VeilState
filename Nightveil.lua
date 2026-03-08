local addonName, ns = ...

local SHROUD_IDS = {115834, 114018}

local captured = {}
local hasCaptured = false
local shroudTicker = nil
local shroudActive = false
local lastShroudTime = 0

ns.IsRogue = false


StaticPopupDialogs["NIGHTVEIL_HARD_RESET"] = {
    text = "Night|cffA361E2veil|r\n\n" .. (ns.L and ns.L.HardResetWarning or "|cffff2020Old or incompatible version detected.|r\n\nSettings will be |cffffd100reset|r to ensure stability."),
    button1 = "OK",
    OnAccept = function()
        ReloadUI()
    end,
    timeout = 0,
    whileDead = true,
    hideOnEscape = false,
    preferredIndex = 3,
}

local function DeepCopy(value)
    if type(value) ~= "table" then
        return value
    end
    local copy = {}
    for k, v in pairs(value) do
        copy[k] = DeepCopy(v)
    end
    return copy
end

local function IsChannelUsable(channel)
    if not channel or channel == "NONE" then return false end
    
    local numHome = GetNumGroupMembers(LE_PARTY_CATEGORY_HOME) or 0
    local numInstance = GetNumGroupMembers(LE_PARTY_CATEGORY_INSTANCE) or 0

    if channel == "INSTANCE_CHAT" then
        return numInstance > 1
    end
    
    if channel == "RAID" then
        return IsInRaid(LE_PARTY_CATEGORY_HOME) and numHome > 1
    end
    
    if channel == "PARTY" then
        return IsInGroup(LE_PARTY_CATEGORY_HOME) and numHome > 1
    end
    
    return false
end

local function SendChat(channel, msg)
    if not msg or msg:gsub("%s+", "") == "" then
        return false
    end
    
    if not IsChannelUsable(channel) then
        return false
    end
    
    local sendFunc = (C_ChatInfo and C_ChatInfo.SendChatMessage) or SendChatMessage
    local ok = pcall(sendFunc, msg, channel)
    return ok == true
end

local function SendChatOrPrint(msg)
    if not msg or msg == "" then return end
    local db = ns.db
    if not db then return end

    if SendChat(db.shroudChannel, msg) then return end
    if SendChat(db.shroudChannelFallback1, msg) then return end
    if SendChat(db.shroudChannelFallback2, msg) then return end
end

function ns.CheckDatabaseVersion()
    local currentVer = ns.Defaults and ns.Defaults.version or "2.0.1"
    local savedVer = NightveilDB and NightveilDB.version
    local minSupportedVer = "2.0.0"

    local function GetVerScore(v)
        if not v or v == "" then return -1 end
        local score = tostring(v):gsub("%.", "")
        return tonumber(score) or 0
    end

    -- 1. Special case for reload after reset (highest priority)
    if savedVer == "PENDING_RELOAD" then
        NightveilDB.version = currentVer
        return "UPDATED"
    end

    -- 2. If NightveilDB is an empty table, it's a fresh install
    if next(NightveilDB) == nil then
        NightveilDB.version = currentVer
        return "FRESH"
    end

    -- 3. If NightveilDB exists and is not empty, but savedVer is missing or empty, it's an incompatible old version
    if not savedVer or savedVer == "" then
        wipe(NightveilDB)
        NightveilDB.version = "PENDING_RELOAD"
        StaticPopup_Show("NIGHTVEIL_HARD_RESET")
        return "WAITING"
    end

    local currentScore = GetVerScore(currentVer)
    local savedScore = GetVerScore(savedVer)
    local minScore = GetVerScore(minSupportedVer)

    -- 4. If the saved version is too old and incompatible
    if savedScore < minScore then
        wipe(NightveilDB)
        NightveilDB.version = "PENDING_RELOAD"
        StaticPopup_Show("NIGHTVEIL_HARD_RESET")
        return "WAITING"
    end

    -- 5. If the current version is greater than the saved (Update)
    if currentScore > savedScore then
        NightveilDB.version = currentVer
        return "UPDATED"
    end

    -- 6. Already on the correct version
    return "OK"
end

local function GetCharacterKey()
    local name = UnitName and UnitName("player") or "Unknown"
    local realm = GetRealmName and GetRealmName() or ""
    if realm ~= "" then
        return name .. " - " .. realm
    end
    return name
end

local function UrlEncode(s)
    s = tostring(s or "")
    return (s:gsub("([^%w%-_%.~])", function(c)
        return string.format("%%%02X", string.byte(c))
    end))
end

local function UrlDecode(s)
    s = tostring(s or "")
    return (s:gsub("%%(%x%x)", function(h)
        return string.char(tonumber(h, 16))
    end))
end

local function GetDefaultKeysSorted()
    local keys = {}
    for k in pairs(ns.Defaults or {}) do
        keys[#keys + 1] = k
    end
    table.sort(keys)
    return keys
end

local function EncodeValue(key, value)
    local def = ns.Defaults and ns.Defaults[key]
    if type(def) == "table" and def.r ~= nil and def.g ~= nil and def.b ~= nil then
        local c = type(value) == "table" and value or def
        local r = tonumber(c.r) or tonumber(def.r) or 0
        local g = tonumber(c.g) or tonumber(def.g) or 0
        local b = tonumber(c.b) or tonumber(def.b) or 0
        return "c" .. string.format("%.3f,%.3f,%.3f", r, g, b)
    end
    if type(def) == "boolean" then
        return value and "b1" or "b0"
    end
    if type(def) == "number" then
        return "n" .. tostring(tonumber(value) or 0)
    end
    return "s" .. UrlEncode(tostring(value or ""))
end

local function DecodeValue(key, token)
    if type(token) ~= "string" or token == "" then
        return nil
    end
    local tag = token:sub(1, 1)
    local body = token:sub(2)
    local def = ns.Defaults and ns.Defaults[key]

    if tag == "b" then
        return body == "1"
    end
    if tag == "n" then
        return tonumber(body)
    end
    if tag == "c" and type(def) == "table" and def.r ~= nil then
        local r, g, b = body:match("^([^,]+),([^,]+),([^,]+)$")
        return {
            r = tonumber(r) or tonumber(def.r) or 0,
            g = tonumber(g) or tonumber(def.g) or 0,
            b = tonumber(b) or tonumber(def.b) or 0,
        }
    end
    if tag == "s" then
        return UrlDecode(body)
    end
    return nil
end

local LEGACY_IMPORT_KEY_MAP = {
    enableText          = "stealthEnableText",
    customText          = "stealthCustomText",
    textColor           = "stealthTextColor",
    textAlpha           = "stealthTextAlpha",
    textX               = "stealthTextX",
    textY               = "stealthTextY",
    textSize            = "stealthTextSize",
    textAnim            = "stealthTextAnim",
    textAnimSpeed       = "stealthTextAnimSpeed",
    enableIcon          = "stealthEnableIcon",
    iconSize            = "stealthIconSize",
    iconAlpha           = "stealthIconAlpha",
    iconAnchorToText    = "stealthIconAnchorToText",
    iconAnchorPoint     = "stealthIconAnchorPoint",
    iconX               = "stealthIconX",
    iconY               = "stealthIconY",
    enableScreenColor   = "stealthEnableScreenColor",
    screenColor         = "stealthScreenColor",
    screenAlpha         = "stealthScreenAlpha",
    screenStrata        = "stealthScreenStrata",
    enableVignette      = "stealthEnableVignette",
    vignetteSize        = "stealthVignetteSize",
    vignetteAlpha       = "stealthVignetteAlpha",
    vignetteStrata      = "stealthVignetteStrata",
    enableHighlight     = "stealthEnableHighlight",
    highlightType       = "stealthHighlightType",

    stealthText         = "stealthCustomText",
    stealthMessage      = "stealthCustomText",
    text                = "stealthCustomText",
    message             = "stealthCustomText",
    CustomText          = "stealthCustomText",
    Nightveil_CustomText = "stealthCustomText",
    Nightveil_TextColor = "stealthTextColor",
    Nightveil_TextAlpha = "stealthTextAlpha",
    stealthAlpha        = "stealthTextAlpha",
    TextAlpha           = "stealthTextAlpha",
}

local function NormalizeProfile(profile)
    if type(profile) ~= "table" then
        return
    end
    local defaults = ns.Defaults or {}

    for k, v in pairs(profile) do
        if type(k) == "string" and k:sub(1, 9) == "Nightveil_" then
            local stripped = k:sub(10)
            if stripped ~= "" and defaults[stripped] ~= nil then
                if profile[stripped] == nil then
                    profile[stripped] = v
                end
                profile[k] = nil
            end
        end
    end

    for key, def in pairs(defaults) do
        if type(key) == "string" then
            local legacyKey = key:gsub("^%l", string.upper)
            if legacyKey ~= key and profile[legacyKey] ~= nil then
                if profile[key] == nil or profile[key] == def then
                    profile[key] = profile[legacyKey]
                end
                profile[legacyKey] = nil
            end
        end
    end
end

function ns.GetCharacterKey()
    return GetCharacterKey()
end

function ns.GetActiveProfileName()
    return ns.activeProfileName or "Default"
end

function ns.GetProfiles()
    local db = NightveilDB
    local profiles = db and db.profiles
    local list = {}
    if type(profiles) == "table" then
        for name in pairs(profiles) do
            list[#list + 1] = name
        end
    end
    table.sort(list, function(a, b)
        if a == "Default" then return true end
        if b == "Default" then return false end
        local charKey = GetCharacterKey()
        if a == charKey then return true end
        if b == charKey then return false end
        return tostring(a):lower() < tostring(b):lower()
    end)
    return list
end

function ns.SetActiveProfile(name)
    if type(name) ~= "string" or name == "" then
        return false
    end
    local db = NightveilDB
    if not (db and db.profiles and db.profiles[name]) then
        return false
    end
    local charKey = GetCharacterKey()
    db.profileKeys = db.profileKeys or {}
    db.profileKeys[charKey] = name
    ns.activeProfileName = name
    ns.db = db.profiles[name]
    NormalizeProfile(ns.db)
    ns.CopyDefaults(ns.Defaults, ns.db)
    if ns.UpdateState then ns.UpdateState() end
    if ns.RefreshVisuals then ns.RefreshVisuals() end
    if ns.IsRogue and ns.RefreshPoisonVisuals then ns.RefreshPoisonVisuals() end
    if Settings and Settings.GetSetting then
        pcall(function()
            local s = Settings.GetSetting("Nightveil_stealthCustomText")
            if s and s.SetValue then
                s:SetValue(ns.db and ns.db.stealthCustomText or "")
            end
        end)
    end
    return true
end

function ns.CreateProfile(name, sourceName)
    name = type(name) == "string" and strtrim(name) or ""
    if name == "" then
        return false, "invalid_name"
    end
    local db = NightveilDB
    if not db then return false, "missing_db" end
    db.profiles = db.profiles or {}
    if db.profiles[name] ~= nil then
        return false, "already_exists"
    end
    local source = (type(sourceName) == "string" and db.profiles[sourceName]) or db.profiles[ns.GetActiveProfileName()] or db.profiles.Default or {}
    db.profiles[name] = DeepCopy(source)
    NormalizeProfile(db.profiles[name])
    ns.CopyDefaults(ns.Defaults, db.profiles[name])
    return true
end

function ns.DeleteProfile(name)
    if name == "Default" or name == GetCharacterKey() then
        return false
    end
    local db = NightveilDB
    if not (db and db.profiles and db.profiles[name]) then
        return false
    end
    db.profiles[name] = nil
    local charKey = GetCharacterKey()
    if db.profileKeys and db.profileKeys[charKey] == name then
        ns.SetActiveProfile(charKey)
    end
    return true
end

function ns.ExportProfileString(profileName)
    local db = NightveilDB
    if not (db and db.profiles) then
        return ""
    end
    local name = profileName or ns.GetActiveProfileName()
    local profile = db.profiles[name]
    if type(profile) ~= "table" then
        return ""
    end
    NormalizeProfile(profile)
    local keys = GetDefaultKeysSorted()
    local parts = {}
    for _, k in ipairs(keys) do
        local v = profile[k]
        if v ~= nil then
            parts[#parts + 1] = k .. "=" .. EncodeValue(k, v)
        end
    end
    return "NV1|" .. UrlEncode(tostring(name)) .. "|" .. table.concat(parts, ";")
end

function ns.ImportProfileString(exportString, targetProfileName)
    if type(exportString) ~= "string" then
        return false, "invalid_string"
    end
    local version, encodedName, payload = exportString:match("^(NV1)|([^|]*)|(.*)$")
    if version ~= "NV1" then
        return false, "invalid_header"
    end

    local db = NightveilDB
    if not db then return false, "missing_db" end
    db.profiles = db.profiles or {}

    local target = type(targetProfileName) == "string" and strtrim(targetProfileName) or ""
    if target == "" then
        target = UrlDecode(encodedName or "")
        target = strtrim(target)
    end
    if target == "" then
        return false, "missing_name"
    end
    if db.profiles[target] == nil then
        db.profiles[target] = {}
    end
    local profile = db.profiles[target]

    for pair in tostring(payload or ""):gmatch("([^;]+)") do
        local k, token = pair:match("^([^=]+)=(.*)$")
        if k and token and ns.Defaults then
            if k:sub(1, 9) == "Nightveil_" then
                k = k:sub(10)
            end
            local mappedKey = (ns.Defaults[k] ~= nil) and k or LEGACY_IMPORT_KEY_MAP[k]
            if mappedKey and ns.Defaults[mappedKey] ~= nil then
                local v = DecodeValue(mappedKey, token)
                if v ~= nil then
                    profile[mappedKey] = v
                end
            end
        end
    end

    if profile.stealthCustomText ~= nil then
        profile.stealthCustomText = tostring(profile.stealthCustomText)
    end

    NormalizeProfile(profile)
    ns.CopyDefaults(ns.Defaults, profile)
    return true, target
end

function ns.HasAura(ids)
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
    local enableHL = db.stealthEnableHighlight
    local hlType = db.stealthHighlightType
    
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
    if not shroudActive then return end
    local db = ns.db
    if sendEnd and db and db.shroudEndMsg and db.shroudEndMsg:gsub("%s+", "") ~= "" then
        local msg = tostring(db.shroudEndMsg or "")
        msg = msg:gsub("%%time", "0")
        msg = msg:gsub("%%t%f[%A]", "0")
        SendChatOrPrint(msg)
    end
    if shroudTicker then shroudTicker:Cancel() end
    shroudTicker = nil
    shroudActive = false
end

local function GetShroudAuraTiming()
    if C_UnitAuras and C_UnitAuras.GetPlayerAuraBySpellID then
        for _, id in ipairs(SHROUD_IDS) do
            local aura = C_UnitAuras.GetPlayerAuraBySpellID(id)
            if aura then
                return aura.expirationTime, aura.duration
            end
        end
        return nil
    end

    local i = 1
    while true do
        local name, _, _, _, duration, expirationTime, _, _, _, spellId = UnitBuff("player", i)
        if not name then break end
        for _, id in ipairs(SHROUD_IDS) do
            if spellId == id then
                return expirationTime, duration
            end
        end
        i = i + 1
    end
    return nil
end

function ns.StartShroudCountdown(expirationTime, duration)
    ns.StopShroudCountdown(false)
    local db = ns.db
    if not db or not db.shroudCountdown then return end

    local useInterval  = db.shroudInterval

    local function FormatMsg(template, timeLeft)
        template = tostring(template or "")
        local t = tostring(timeLeft or 0)
        template = template:gsub("%%time", t)
        template = template:gsub("%%t%f[%A]", t)
        return template
    end

    if not expirationTime then
        expirationTime, duration = GetShroudAuraTiming()
    end
    if not expirationTime then
        return
    end
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
            ns.StopShroudCountdown(true)
            return
        end

        local shouldSend = not useInterval
                        or timeLeft == total
                        or timeLeft == middle
                        or timeLeft <= 5

        if shouldSend then
            if timeLeft == total then
                local startMsg = db.shroudStartMsg
                if startMsg and startMsg:gsub("%s+", "") ~= "" then
                    SendChatOrPrint(FormatMsg(startMsg, total))
                end
            else
                local template = (db.shroudMessage and db.shroudMessage:gsub("%s+", "") ~= "") and db.shroudMessage or "%time"
                SendChatOrPrint(FormatMsg(template, timeLeft))
            end
        end
    end

    Tick()
    if not shroudActive then return end

    shroudTicker = C_Timer.NewTicker(1, Tick)
end

function ns.TestShroudMessage()
    local db = ns.db
    if not db then return end
    local exp, dur = GetShroudAuraTiming()
    local total = math.max(1, math.floor((tonumber(dur) or 14) + 0.5))

    local startMsg = db.shroudStartMsg or "%time"
    startMsg = tostring(startMsg):gsub("%%time", tostring(total)):gsub("%%t%f[%A]", tostring(total))

    local midMsg = db.shroudMessage or "%time"
    midMsg = tostring(midMsg):gsub("%%time", "10"):gsub("%%t%f[%A]", "10")

    local endMsg = db.shroudEndMsg or "%time"
    endMsg = tostring(endMsg):gsub("%%time", "0"):gsub("%%t%f[%A]", "0")

    SendChatOrPrint(startMsg)
    SendChatOrPrint(midMsg)
    SendChatOrPrint(endMsg)
end

local function CheckShroud()
    local db = ns.db
    if not db or not db.shroudCountdown or (db.shroudOnlyInstances and not ns.IsInInstance()) then
        if shroudActive then ns.StopShroudCountdown(false) end
        return
    end
    local exp, dur = GetShroudAuraTiming()
    if exp and not shroudActive then
        if GetTime() - lastShroudTime > 1 then
            lastShroudTime = GetTime()
            ns.StartShroudCountdown(exp, dur)
        end
    elseif not exp and shroudActive then
        ns.StopShroudCountdown(true)
    end
end

function ns.UpdateState()
    local db = ns.db
    if not db then return end

    local stealthActive = IsStealthed() and db.stealthEnabled
    if stealthActive and db.stealthOnlyInstances and not ns.IsInInstance() then
        stealthActive = false
    end
    
    if stealthActive then
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
        local verResult = ns.CheckDatabaseVersion()
        if verResult == "WAITING" then return end

        NightveilDB.profiles = NightveilDB.profiles or {}
        NightveilDB.profileKeys = NightveilDB.profileKeys or {}
        NightveilDB.global = NightveilDB.global or {}
        NightveilDB.profiles.Default = NightveilDB.profiles.Default or {}
        
        NormalizeProfile(NightveilDB.profiles.Default)
        ns.CopyDefaults(ns.Defaults, NightveilDB.profiles.Default)

        local charKey = ns.GetCharacterKey()
        if not NightveilDB.profiles[charKey] then
            NightveilDB.profiles[charKey] = DeepCopy(NightveilDB.profiles.Default)
        end

        local activeProfile = NightveilDB.profileKeys[charKey] or charKey
        if not NightveilDB.profiles[activeProfile] then
            activeProfile = charKey
            NightveilDB.profileKeys[charKey] = activeProfile
        end

        ns.activeProfileName = activeProfile
        ns.db = NightveilDB.profiles[activeProfile]
        
        NormalizeProfile(ns.db)
        ns.CopyDefaults(ns.Defaults, ns.db)

        local _, _, classId = UnitClass("player")
        ns.IsRogue = (classId == 4)
        
        if not NightveilSavedState and VeilStateSavedState then
            NightveilSavedState = VeilStateSavedState
            VeilStateSavedState = nil
        end
        RecoverState()
        
        if ns.InitSettings then
            ns.InitSettings()
        end
        
        ns.RefreshVisuals()
        
        if ns.IsRogue and ns.RefreshPoisonVisuals then
            C_Timer.After(2, function()
                ns.RefreshPoisonVisuals()
            end)
        end
        
        if IsStealthed() then ns.UpdateState() end

        if verResult == "FRESH" then
            print(string.format(ns.L.WelcomeMessage, ns.Defaults.version))
        elseif verResult == "UPDATED" then
            print(string.format(ns.L.UpdateMessage, ns.Defaults.version))
        end
    elseif event == "PLAYER_REGEN_DISABLED" or event == "PLAYER_REGEN_ENABLED" or event == "PLAYER_ENTERING_WORLD" or event == "ZONE_CHANGED_NEW_AREA" then
        ns.UpdateState()
        CheckShroud()
        if ns.RefreshPoisonVisuals then
            ns.RefreshPoisonVisuals()
        end
    elseif event == "UNIT_AURA" then
        if arg1 == "player" then 
            CheckShroud()
            ns.UpdateState()
        end
    else
        ns.UpdateState()
    end
end)

SLASH_NIGHTVEIL1 = "/veil"

_G["Nightveil_OnAddonCompartmentClick"] = function()
    if ns.MainCategory then
        Settings.OpenToCategory(ns.MainCategory:GetID())
    end
end

SlashCmdList["NIGHTVEIL"] = function()
    if ns.MainCategory then
        Settings.OpenToCategory(ns.MainCategory:GetID())
    end
end
