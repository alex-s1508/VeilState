local addonName, ns = ...

-- [[ Constants & System Tables ]] --------------------------------------------
local SHROUD_IDS = {115834, 114018}
local DELVE_COMPANIONS = {
    ["210759"] = true,
    ["204418"] = true,
}


-- [[ Internal Variables ]] ---------------------------------------------------
local captured = {}
local hasCaptured = false
local shroudTicker = nil
local shroudActive = false
local shroudTesting = false
local warnedSayRange = false
local channelDenyUntil = {}
local errorDenyUntil = {}
local lastShroudTime = 0
ns.IsRogue = false
ns.KnowsTricks = false
ns.debugMode = false
ns.shroudErrorsDisplayed = {}

-- [[ Branding & Module Branding ]] ------------------------------------------
function ns.GetAddonName()
    return "Night|cffBE89E9v|cffBB86E7e|cffB883E5i|cffB580E3l|r"
end

-- [[ Tricks of the Trade State ]] -------------------------------------------
ns.tricksLastTargetID = nil
ns.tricksLastMacroBody = nil
ns.tricksUpdateQueued = false
ns.tricksLastEventTime = 0

-- [[ Global Color Definitions ]] -------------------------------------------
local CLASS_COLORS = {
    ["DEATHKNIGHT"] = "C41E3A",
    ["DEMONHUNTER"] = "A330C9",
    ["DRUID"]       = "FF7C0A",
    ["EVOKER"]      = "33937F",
    ["HUNTER"]      = "AAD372",
    ["MAGE"]        = "3FC7EB",
    ["MONK"]        = "00FF98",
    ["PALADIN"]     = "F48CBA",
    ["PRIEST"]      = "FFFFFF",
    ["ROGUE"]       = "FFF468",
    ["SHAMAN"]      = "0070DD",
    ["WARLOCK"]     = "8788EE",
    ["WARRIOR"]     = "C69B6D",
}

-- [[ Static Popup Dialogs ]] ------------------------------------------------
StaticPopupDialogs["NIGHTVEIL_HARD_RESET"] = {
    text = ns.GetAddonName() .. "\n\n" .. (ns.L and ns.L.HardResetWarning or "\|cff6a39a2Old or incompatible version detected.|r\n\nSettings will be \|cffffcc00reset|r to ensure stability."),
    button1 = "OK",
    OnAccept = function()
        ReloadUI()
    end,
    timeout = 0,
    whileDead = true,
    hideOnEscape = false,
    preferredIndex = 3,
}

StaticPopupDialogs["NIGHTVEIL_OUTDATED_CONFIG"] = {
    text = ns.GetAddonName() .. "\n\n" .. (ns.L and ns.L.WarningOutdatedConfig or "|cffbe89e9Newer configuration detected!|r\n\nIt is recommended to update the addon or reset the profile."),
    button1 = "OK",
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
    preferredIndex = 3,
}

-- [[ Utility Helper Functions ]] ---------------------------------------------
local function DeepCopy(value)
    if type(value) ~= "table" then return value end
    local copy = {}
    for k, v in pairs(value) do
        copy[k] = DeepCopy(v)
    end
    return copy
end

ns.DeepCopy = DeepCopy

local function GetGroupComposition()
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

-- [[ Message Throttling & Anti-Spam ]] ---------------------------------------
local function CanAnnounceGlobal(key, seconds)
    local now = GetTime()
    local untilTime = errorDenyUntil[key] or 0
    if untilTime > now then return false end
    errorDenyUntil[key] = now + (seconds or 5)
    return true
end

local function GetChannelLabel(channel)
    if ns.L then
        if channel == "SAY" then return ns.L.ChannelSay end
        if channel == "YELL" then return ns.L.ChannelYell end
        if channel == "PARTY" then return ns.L.ChannelParty end
        if channel == "RAID" then return ns.L.ChannelRaid end
        if channel == "INSTANCE_CHAT" then return ns.L.ChannelInstance end
    end
    return channel
end

local function ColorRed(text) return "\|cff6a39a2" .. tostring(text or "") .. "|r" end

-- [[ Chat Channel Validation ]] ---------------------------------------------
local function GetChannelStatus(channel)
    if not channel or channel == "NONE" then return false, "NONE" end

    local now = GetTime()
    local deny = channelDenyUntil[channel] or 0
    if deny > now then
        return false, "TEMP"
    end

    local inInstance = IsInInstance()
    local inGroup = IsInGroup()
    local isRaid = IsInRaid()
    local channelName = GetChannelLabel(channel) or channel

    local players, _, others = GetGroupComposition()

    local function denyChannel(reason, text)
        channelDenyUntil[channel] = now + 8
        return false, reason, text
    end

    if channel == "SAY" or channel == "YELL" then
        if inInstance then return true end
        if channel == "SAY" or channel == "YELL" then
            return denyChannel("ANTISPAM", string.format(ns.L.ErrorBlizzardAntiSpam or (ns.GetAddonName() .. " : " .. ColorRed("Blizzard anti-spam restricts %s channel outside instances.")), channelName))
        end
    end

    if channel == "INSTANCE_CHAT" then
            if not IsInGroup(LE_PARTY_CATEGORY_INSTANCE) then
                return denyChannel("NOT_IN_INSTANCE", string.format(ns.L.ErrorShroudInstanceOnly or (ns.GetAddonName() .. ": \|cff6a39a2You are not inside an instance. Channel |r\|cffffcc00%s|r\|cff6a39a2 is unavailable.|r"), channelName))
            end
            return true
        end

    if channel == "PARTY" then
        if not inGroup or isRaid then
            return denyChannel("NOT_IN_GROUP", string.format(ns.L.ErrorNotInGroup or (ns.GetAddonName() .. ": You are not in a group. Channel %s is unavailable."), channelName))
        end
        if players <= 1 and others > 0 then
            return denyChannel("INVALID_GROUP", string.format(ns.L.ErrorFollowersDungeonGroup or (ns.GetAddonName() .. ": You are alone or in an invalid group. Channel %s is unavailable."), channelName))
        end
        return true
    end

    if channel == "RAID" then
        if not isRaid then
            return denyChannel("NOT_IN_RAID", string.format(ns.L.ErrorNotInRaid or (ns.GetAddonName() .. ": You are not in a raid. Channel %s is unavailable."), channelName))
        end
        if players <= 1 and others > 0 then
            return denyChannel("INVALID_GROUP", string.format(ns.L.ErrorFollowersDungeonGroup or (ns.GetAddonName() .. ": You are alone or in an invalid group. Channel %s is unavailable."), channelName))
        end
        return true
    end

    return false, "NONE"
end

local function IsChannelUsable(channel)
    local ok = GetChannelStatus(channel)
    return ok == true
end

local function SendChat(channel, msg, silent)
    if not msg or msg:gsub("%s+", "") == "" then return false end

    local ok, reason, text = GetChannelStatus(channel)
    if not ok then
        if not silent and text then
            if reason == "ANTISPAM" then
                if not warnedSayRange and ThrottleError("ANTISPAM", 8) then
                    warnedSayRange = true
                    print(text)
                end
            else
                if ThrottleError(reason .. ":" .. tostring(channel), 5) then
                    print(text)
                end
            end
        end
        return false
    end

    if ChatThrottleLib then
        ChatThrottleLib:SendChatMessage("ALERT", "Nightveil", msg, channel)
        return true
    else
        local sendFunc = (C_ChatInfo and C_ChatInfo.SendChatMessage) or SendChatMessage
        local ok = pcall(sendFunc, msg, channel)
        return ok == true
    end
end

local function SendChatOrPrint(msg, isSynthetic)
    if not msg or msg == "" then return end
    
    if isSynthetic then
        print(ns.GetAddonName() .. ": " .. msg)
        return
    end

    local db = ns.db
    if not db then return end

    if db.shroudOnlyInstances and not ns.IsInInstance() then
        if not ns.shroudErrorsDisplayed["INSTANCE_ONLY"] then
            ns.shroudErrorsDisplayed["INSTANCE_ONLY"] = true
            print(string.format(ns.L.ErrorShroudOnlyInstances or (ns.GetAddonName() .. ": " .. ColorRed("Shroud messages only work inside instances.")), ns.GetAddonName()))
        end
        return
    end

    local muteErrors = db.shroudMuteErrors == true

    -- Try primary and fallback channels in sequence
    if SendChat(db.shroudChannel, msg, muteErrors) then return end
    if SendChat(db.shroudChannelFallback1, msg, true) then return end
    if SendChat(db.shroudChannelFallback2, msg, true) then return end

    -- Display error if no valid channel was found
    if not muteErrors then
        if not ns.shroudErrorsDisplayed["NO_CHANNEL"] then
            ns.shroudErrorsDisplayed["NO_CHANNEL"] = true
            print(string.format(ns.L.ErrorNoValidChannel or (ns.GetAddonName() .. ": " .. ColorRed("No valid chat channel available.")), ns.GetAddonName()))
        end
    end
end

local function GetVerScore(v)
    if not v or v == "" then return -1 end
    local major, minor, patch = tostring(v):match("(%d+)%.(%d+)%.(%d+)")
    if not major then return 0 end
    return (tonumber(major) * 10000) + (tonumber(minor) * 100) + tonumber(patch)
end

local function GetMajor(v)
    if not v or v == "" then return 0 end
    local major = tostring(v):match("(%d+)")
    return tonumber(major) or 0
end

-- [[ Profile Normalization & Migration ]] ------------------------------------
local function NormalizeProfile(profile)
    if not profile or type(profile) ~= "table" then return "ERROR" end
    
    local defaults = ns.Defaults or {}
    local currentVer = defaults.version or "2.1.2"
    local profileVer = profile.version or "2.1.2"
    
    local currentScore = GetVerScore(currentVer)
    local profileScore = GetVerScore(profileVer)
    local currentMajor = GetMajor(currentVer)
    local profileMajor = GetMajor(profileVer)

    -- major check
    if profileMajor ~= currentMajor then
        return "INCOMPATIBLE"
    end

    -- Handle legacy Nightveil prefix migration
    for k, v in pairs(profile) do
        if type(k) == "string" and k:sub(1, 10) == "Nightveil_" then
            local stripped = k:sub(11)
            if stripped ~= "" and defaults[stripped] ~= nil then
                if profile[stripped] == nil then profile[stripped] = v end
                profile[k] = nil
            end
        end
    end

    -- Recover settings from legacy uppercase keys
    for key, def in pairs(defaults) do
        if type(key) == "string" then
            local upperKey = key:gsub("^%l", string.upper)
            if upperKey ~= key and profile[upperKey] ~= nil then
                if profile[key] == nil or profile[key] == def then
                    profile[key] = profile[upperKey]
                end
                profile[upperKey] = nil
            end
        end
    end

    for k, v in pairs(defaults) do
        if profile[k] == nil then
            profile[k] = type(v) == "table" and ns.DeepCopy(v) or v
        end
    end

    -- Legacy migration for Tricks logic
    if profile.tricksLogic == "TARGET" then
        profile.tricksLogic = "NORMAL"
    end

    for k in pairs(profile) do
        if k ~= "version" and defaults[k] == nil then
            profile[k] = nil
        end
    end

    -- Warn if the profile version is newer than the addon
    if profileScore > currentScore then
        print(ns.L.WarningOutdatedConfig or "Config is newer than addon.")
    end

    profile.version = currentVer
    return "OK"
end

-- [[ Database Versioning & System Check ]] ----------------------------------
function ns.CheckDatabaseVersion()
    local currentVer = ns.Defaults and ns.Defaults.version or "2.1.2"
    local savedVer = NightveilDB and NightveilDB.version

    -- Handle first-time installation
    if not NightveilDB or not NightveilDB.profiles then
        NightveilDB = NightveilDB or {}
        NightveilDB.version = currentVer
        NightveilDB.profiles = {}
        NightveilDB.profileKeys = {}
        return "FRESH"
    end

    -- Handle state after a factory reset and reload
    if savedVer == "PENDING_RELOAD" then
        NightveilDB.version = currentVer
        return "UPDATED"
    end

    local currentScore = GetVerScore(currentVer)
    local savedScore = GetVerScore(savedVer)
    local currentMajor = GetMajor(currentVer)
    local savedMajor = GetMajor(savedVer)

    -- major check
    if savedMajor ~= currentMajor then
        wipe(NightveilDB)
        NightveilDB.version = "PENDING_RELOAD"
        StaticPopup_Show("NIGHTVEIL_HARD_RESET")
        return "WAITING"
    end

    -- 2. Normalize all profiles
    if NightveilDB.profiles then
        for name, profile in pairs(NightveilDB.profiles) do
            local originalVer = profile.version or "0.0.0"
            local res = NormalizeProfile(profile)
            if res == "OK" and name == ns.GetActiveProfileName() then
                local defaults = ns.Defaults or {}
                local currentScore = GetVerScore(defaults.version)
                local originalScore = GetVerScore(originalVer)
                if originalScore > currentScore then
                    StaticPopup_Show("NIGHTVEIL_OUTDATED_CONFIG")
                end
            end
        end
    end

    -- 3. Update saved version
    if currentScore ~= savedScore then
        NightveilDB.version = currentVer
        return "UPDATED"
    end

    return "OK"
end

-- [[ Profile Management Utilities ]] -----------------------------------------
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
    if type(token) ~= "string" or token == "" then return nil end
    local tag = token:sub(1, 1)
    local body = token:sub(2)
    local def = ns.Defaults and ns.Defaults[key]

    if tag == "b" then return body == "1" end
    if tag == "n" then return tonumber(body) end
    if tag == "c" and type(def) == "table" and def.r ~= nil then
        local r, g, b = body:match("^([^,]+),([^,]+),([^,]+)$")
        return {
            r = tonumber(r) or tonumber(def.r) or 0,
            g = tonumber(g) or tonumber(def.g) or 0,
            b = tonumber(b) or tonumber(def.b) or 0,
        }
    end
    if tag == "s" then return UrlDecode(body) end
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

function ns.GetCharacterKey() return GetCharacterKey() end
function ns.GetActiveProfileName() return ns.activeProfileName or "Default" end

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
    if type(name) ~= "string" or name == "" then return false end
    local db = NightveilDB
    if not (db and db.profiles and db.profiles[name]) then return false end
    local charKey = GetCharacterKey()
    db.profileKeys = db.profileKeys or {}
    db.profileKeys[charKey] = name
    ns.activeProfileName = name
    ns.db = db.profiles[name]
    NormalizeProfile(ns.db)
    ns.CopyDefaults(ns.Defaults, ns.db)
    if ns.UpdateState then ns.UpdateState() end
    if ns.RefreshVisuals then ns.RefreshVisuals(true) end
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
    if name == "" then return false, "invalid_name" end
    local db = NightveilDB
    if not db then return false, "missing_db" end
    db.profiles = db.profiles or {}
    if db.profiles[name] ~= nil then return false, "already_exists" end
    local source = (type(sourceName) == "string" and db.profiles[sourceName]) or db.profiles[ns.GetActiveProfileName()] or db.profiles.Default or {}
    db.profiles[name] = DeepCopy(source)
    NormalizeProfile(db.profiles[name])
    ns.CopyDefaults(ns.Defaults, db.profiles[name])
    return true
end

function ns.DeleteProfile(name)
    if name == "Default" or name == GetCharacterKey() then return false end
    local db = NightveilDB
    if not (db and db.profiles and db.profiles[name]) then return false end
    db.profiles[name] = nil
    local charKey = GetCharacterKey()
    if db.profileKeys and db.profileKeys[charKey] == name then
        ns.SetActiveProfile(charKey)
    end
    return true
end

function ns.ExportProfileString(profileName)
    local db = NightveilDB
    if not (db and db.profiles) then return "" end
    local name = profileName or ns.GetActiveProfileName()
    local profile = db.profiles[name]
    if type(profile) ~= "table" then return "" end
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
    if type(exportString) ~= "string" then return false, "invalid_string" end
    local version, encodedName, payload = exportString:match("^(NV1)|([^|]*)|(.*)$")
    if version ~= "NV1" then return false, "invalid_header" end

    local db = NightveilDB
    if not db then return false, "missing_db" end
    db.profiles = db.profiles or {}

    local target = type(targetProfileName) == "string" and strtrim(targetProfileName) or ""
    if target == "" then
        target = UrlDecode(encodedName or "")
        target = strtrim(target)
    end
    if target == "" then return false, "missing_name" end
    if db.profiles[target] == nil then db.profiles[target] = {} end
    local profile = db.profiles[target]

    for pair in tostring(payload or ""):gmatch("([^;]+)") do
        local k, token = pair:match("^([^=]+)=(.*)$")
        if k and token and ns.Defaults then
            if k:sub(1, 9) == "Nightveil_" then k = k:sub(10) end
            local mappedKey = (ns.Defaults[k] ~= nil) and k or LEGACY_IMPORT_KEY_MAP[k]
            if mappedKey and ns.Defaults[mappedKey] ~= nil then
                local v = DecodeValue(mappedKey, token)
                if v ~= nil then profile[mappedKey] = v end
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

-- [[ Stealth Management Logic ]] ---------------------------------------------
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

local function ClearBackup() NightveilSavedState = nil end

function ns.CaptureOriginal()
    if hasCaptured then return end
    RecoverState()
    if hasCaptured then return end
    -- Capture clean CVar states before activating highlights
    captured = {}
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
    
    -- Reset highlights to clear current visual state
    SetCVar("findYourselfMode", "0")
    SetCVar("findYourselfModeCircle", "0")
    SetCVar("findYourselfModeOutline", "0")
    SetCVar("findYourselfModeIcon", "0")
    SetCVar("selfHighlight", "0")

    -- Restore original player CVars from capture
    for cvar, val in pairs(captured) do
        if val ~= nil then 
            SetCVar(cvar, tostring(val)) 
        end
    end
    
    hasCaptured = false
    ClearBackup()
end

function ns.ApplyHighlight()
    local db = ns.db
    if not db then return end
    local enableHL = db.stealthEnableHighlight
    local hlType = tonumber(db.stealthHighlightType) or 2
    
    if not enableHL then
        SetCVar("findYourselfMode", 0)
        SetCVar("findYourselfModeCircle", 0)
        SetCVar("findYourselfModeOutline", 0)
        SetCVar("findYourselfModeIcon", 0)
        return
    end
    local s = hlType or 2
    SetCVar("findYourselfMode", tostring(s))
    SetCVar("findYourselfModeCircle", (s==1 or s==4 or s==5 or s==7) and "1" or "0")
    SetCVar("findYourselfModeOutline", (s==2 or s==4 or s==6 or s==7) and "1" or "0")
    SetCVar("findYourselfModeIcon", (s==3 or s==5 or s==6 or s==7) and "1" or "0")
    SetCVar("findYourselfAnywhere", "1")
    SetCVar("selfHighlight", "1")
end

-- [[ Shroud of Concealment Logic ]] -----------------------------------------
function ns.StopShroudCountdown(sendEnd)
    if not shroudActive then return end
    
    -- Reset testing flag before ending countdown
    local wasTesting = shroudTesting
    shroudTesting = false

    local db = ns.db
    if sendEnd and db and db.shroudEndMsg and db.shroudEndMsg:gsub("%s+", "") ~= "" then
        local msg = tostring(db.shroudEndMsg or "")
        msg = msg:gsub("%%time", "0")
        msg = msg:gsub("%%t%f[%A]", "0")
        
        SendChatOrPrint(msg, wasTesting)
    end
    
    if shroudTicker then shroudTicker:Cancel() end
    shroudTicker = nil
    shroudActive = false
    ns.UpdateState()
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

function ns.StartShroudCountdown(expirationTime, duration)
    ns.StopShroudCountdown(false)

    ns.shroudErrorsDisplayed = {}

    local db = ns.db
    if not db or not db.shroudCountdown then return end

    ns.UpdateState()
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
            ns.StopShroudCountdown(true)
            return
        end

        local shouldSend = not useInterval or timeLeft == total or timeLeft == middle or timeLeft <= 5

        if shouldSend then
            if timeLeft == total then
                local startMsg = db.shroudStartMsg
                if startMsg and startMsg:gsub("%s+", "") ~= "" then
                    SendChatOrPrint(FormatMsg(startMsg, total))
                end
            else
                local template = (db.shroudMessage and db.shroudMessage:gsub("%s+", "") ~= "") and db.shroudMessage or "%time"
                SendChatOrPrint(FormatMsg(template, timeLeft), shroudTesting)
            end
        end
    end

    Tick()
    if not shroudActive then return end
    shroudTicker = C_Timer.NewTicker(1, Tick)
end

function ns.TestShroudMessage()
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
            ns.StopShroudCountdown(true)
            return
        end

        local shouldSend = not useInterval or timeLeft == total or timeLeft == middle or timeLeft <= 5
        if not shouldSend then return end

        local template = (db.shroudMessage and db.shroudMessage:gsub("%s+", "") ~= "") and db.shroudMessage or "%time"
        
        if timeLeft == total then
            local startMsg = db.shroudStartMsg
            if startMsg and startMsg:gsub("%s+", "") ~= "" then
                SendChatOrPrint(FormatMsg(startMsg, total), true)
            else
                SendChatOrPrint(FormatMsg(template, total), true)
            end
        else
            SendChatOrPrint(FormatMsg(template, timeLeft), true)
        end
    end

    Tick()
    if shroudActive then
        shroudTicker = C_Timer.NewTicker(1, Tick)
    end
end

local function CheckShroud()
    if shroudTesting then return end
    local db = ns.db
    if not db or not db.shroudCountdown or (db.shroudOnlyInstances and not ns.IsInInstance()) then
        if shroudActive then ns.StopShroudCountdown(false) end
        return
    end

    local exp, dur = GetShroudAuraTiming()
    if exp and not shroudActive then
        if GetTime() - (lastShroudTime or 0) > 0.5 then
            lastShroudTime = GetTime()
            ns.StartShroudCountdown(exp, dur)
        end
    elseif not exp and shroudActive then
        ns.StopShroudCountdown(true)
    end
end

-- [[ Core Application Loop ]] ------------------------------------------------
ns._lastCvarStealthState = ns._lastCvarStealthState or false

function ns.UpdateState(force)
    local db = ns.db
    if not db then return end

    local stealthActive = IsStealthed() and db.stealthEnabled
    if stealthActive and db.stealthOnlyInstances and not ns.IsInInstance() then
        stealthActive = false
    end
    
    local shouldHaveHighlight = stealthActive or shroudActive
    if shouldHaveHighlight then
        if not ns._lastCvarStealthState then
            -- Capture original state before applying stealth effects
            ns.CaptureOriginal()
            ns.ApplyHighlight()
            ns._lastCvarStealthState = true
        end
    else
        if ns._lastCvarStealthState then
            ns.RestoreOriginal()
            ns._lastCvarStealthState = false
        end
    end
    ns.RefreshVisuals(force)
    if ns.IsRogue then
        if ns.RefreshPoisonVisuals then ns.RefreshPoisonVisuals(force) end
        ns.Tricks_UpdateMacro(force)
    end
end

-- [[ Event Handling System ]] ------------------------------------------------
local eventFrame = CreateFrame("Frame")
eventFrame:RegisterEvent("ADDON_LOADED")
eventFrame:RegisterEvent("UPDATE_STEALTH")
eventFrame:RegisterEvent("UNIT_AURA")
eventFrame:RegisterEvent("PLAYER_REGEN_DISABLED")
eventFrame:RegisterEvent("PLAYER_REGEN_ENABLED")
eventFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
eventFrame:RegisterEvent("ZONE_CHANGED_NEW_AREA")
eventFrame:RegisterEvent("GROUP_ROSTER_UPDATE")
eventFrame:RegisterEvent("PLAYER_ROLES_ASSIGNED")
eventFrame:RegisterEvent("PLAYER_FOCUS_CHANGED")
eventFrame:RegisterEvent("PLAYER_TARGET_CHANGED")
eventFrame:RegisterEvent("UNIT_TARGET")
eventFrame:RegisterEvent("SPELLS_CHANGED")
eventFrame:RegisterEvent("PLAYER_LEAVING_WORLD")

eventFrame:SetScript("OnEvent", function(self, event, arg1)
    if event == "ADDON_LOADED" and arg1 == addonName then
        
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
        ns.KnowsTricks = IsPlayerSpell(57934)
        
        RecoverState()
        
        if ns.InitSettings then ns.InitSettings() end
        ns.RefreshVisuals()
        
        if IsStealthed() then ns.UpdateState() end
        

        if verResult == "FRESH" then
            print(string.format(ns.L.WelcomeMessage, ns.GetAddonName(), ns.Defaults.version))
        elseif verResult == "UPDATED" then
            print(string.format(ns.L.UpdateMessage, ns.GetAddonName(), ns.Defaults.version))
        end

        if ns.IsRogue then
            ns.Tricks_UpdateMacro(true)
        end
    elseif event == "UNIT_AURA" then
        if arg1 == "player" then 
            CheckShroud()
            ns.UpdateState()
        end
    elseif event == "PLAYER_LEAVING_WORLD" then
        -- Cleanup and reset visuals before character logout
        if ns._lastCvarStealthState then
            ns.RestoreOriginal()
            ns._lastCvarStealthState = false
        end
        if ns.RefreshVisuals then ns.RefreshVisuals(true) end
    elseif event == "PLAYER_ENTERING_WORLD" or event == "ZONE_CHANGED_NEW_AREA" or event == "PLAYER_REGEN_DISABLED" or event == "PLAYER_REGEN_ENABLED" then
        ns.UpdateState()
        CheckShroud()
        if ns.RefreshPoisonVisuals then ns.RefreshPoisonVisuals() end
        
        if ns.IsRogue then
            if ns.tricksUpdateQueued then
                ns.Tricks_UpdateMacro()
            end
        end
    elseif event == "GROUP_ROSTER_UPDATE" or event == "PLAYER_ROLES_ASSIGNED" or event == "PLAYER_FOCUS_CHANGED" or event == "PLAYER_TARGET_CHANGED" or (event == "UNIT_TARGET" and arg1 and (arg1:find("party") or arg1:find("raid") or arg1 == "focus")) then
        if ns.IsRogue then
            local now = GetTime()
            if now - ns.tricksLastEventTime > 0.1 then
                ns.tricksLastEventTime = now
                ns.Tricks_UpdateMacro()
            end
        end
    elseif event == "SPELLS_CHANGED" then
        if ns.IsRogue then
            ns.KnowsTricks = IsPlayerSpell(57934)
            if ns.KnowsTricks then
                ns.Tricks_UpdateMacro(true)
            end
        end
    else
        ns.UpdateState()
    end
end)

-- [[ Slash Command Definitions ]] -------------------------------------------
SLASH_NIGHTVEIL1 = "/veil"
function Nightveil_OnAddonCompartmentClick(addonName, button)
    if InCombatLockdown() then
        print(ns.GetAddonName() .. ": |cffffaa00" .. (ns.L and ns.L.CombatBlocked or "Cannot open settings during combat.") .. "|r")
        return
    end
    if ns.MainCategory then 
        Settings.OpenToCategory(ns.MainCategory:GetID()) 
    end
end

local function DebugState()
    local inInstance, instanceType = IsInInstance()
    local numMembers = GetNumGroupMembers()
    local inGroup = IsInGroup()
    local isRaid = IsInRaid()
    local combat = UnitAffectingCombat("player")
    local stealthed = IsStealthed()
    
    local players, pets, others = GetGroupComposition()

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
                
                -- Apply class colors to unit names in the list
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
        print(string.format(ns.L and ns.L.DebugFallback1 or " - Fallback 1: |cffffff00%s|r (Usable: %s)", label(db.shroudChannelFallback1), GetYesNo(IsChannelUsable(db.shroudChannelFallback1))))
        print(string.format(ns.L and ns.L.DebugFallback2 or " - Fallback 2: |cffffff00%s|r (Usable: %s)", label(db.shroudChannelFallback2), GetYesNo(IsChannelUsable(db.shroudChannelFallback2))))
    end

    if ns.IsRogue then
        print(string.format(" - Tricks Known: %s", GetYesNo(ns.KnowsTricks)))
        local tankUnit = ns.Tricks_FindBestTargetID()
        local targetName = tankUnit and ns.GetClassColoredName(tankUnit) or "none"
        print(string.format(" - Tricks Target: %s (%s)", targetName, tankUnit or "nil"))
        print(string.format(" - Tricks Macro: %s", ns.tricksLastMacroBody and "\|cffbe89e9OK|r" or "|cffff0000Missing|r"))
    end
end

local function RunShroudTest(duration)
    if not ns.debugMode then
        print(string.format(ns.L.DebugModeRequired or (ns.GetAddonName() .. ": |cffbe89e9This command requires Debug Mode.|r Type |cffffcc00/veil debug|r to enable."), ns.GetAddonName()))
        return
    end
    if shroudActive then
        print(ns.GetAddonName() .. ": \|cff6a39a2Shroud countdown is already active.|r")
        return
    end

    local db = ns.db
    if not db or not db.shroudCountdown then
        print(ns.GetAddonName() .. ": \|cff6a39a2Shroud countdown is disabled in settings.|r")
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
            ns.StopShroudCountdown(true)
            return
        end

        local shouldSend = not useInterval or timeLeft == total or timeLeft == middle or timeLeft <= 5
        if not shouldSend then return end

        if timeLeft == total then
            local startMsg = db.shroudStartMsg
            if startMsg and startMsg:gsub("%s+", "") ~= "" then
                SendChatOrPrint(FormatMsg(startMsg, total), false)
            else
                local template = (db.shroudMessage and db.shroudMessage:gsub("%s+", "") ~= "") and db.shroudMessage or "%time"
                SendChatOrPrint(FormatMsg(template, total), false)
            end
        else
            local template = (db.shroudMessage and db.shroudMessage:gsub("%s+", "") ~= "") and db.shroudMessage or "%time"
            SendChatOrPrint(FormatMsg(template, timeLeft), false)
        end
    end

    ns.UpdateState()
    Tick()
    if shroudActive then
        shroudTicker = C_Timer.NewTicker(1, Tick)
    end
end

local function PrintDebugHelp()
    print("\n \|cffb894ff[Debug Commands]|r")
    print(" \|cffd4a8ff/veil utricks|r - Force immediate macro refresh")
    print(" \|cffd4a8ff/veil info|r - " .. (ns.L.HelpInfo or "Diagnostic info"))
    print(" \|cffd4a8ff/veil shroud [1-20]|r - " .. (ns.L.HelpShroudTest or "Test shroud countdown"))
end

local function IsValidTricksTarget(unit)
    if not unit or not UnitExists(unit) then return false end
    if UnitIsUnit("player", unit) or UnitIsDeadOrGhost(unit) then return false end
    
    -- Check if the unit is a Delve Companion (Brann or Valeera)
    local guid = UnitGUID(unit)
    local npcID = guid and select(6, strsplit("-", guid))
    if DELVE_COMPANIONS[npcID] then return true end

    
    -- other checks
    return UnitCanAssist("player", unit)
end

function ns.GetClassColoredName(unit)
    if not unit or not UnitExists(unit) then return nil end
    local name = UnitName(unit)
    if not name or name == "Unknown" or name == "Desconhecido" then 
        -- Fallback to unit ID if name retrieval fails
        name = unit
    end
    
    local _, class = UnitClass(unit)
    local color = (class and RAID_CLASS_COLORS[class]) and RAID_CLASS_COLORS[class].colorStr or "ffffffff"
    return "|c" .. color .. name .. "|r"
end

function ns.Tricks_GetSpellName()
    if C_Spell and C_Spell.GetSpellName then
        return C_Spell.GetSpellName(57934)
    elseif GetSpellInfo then
        local name = GetSpellInfo(57934)
        return name
    end
    return nil
end

function ns.Tricks_FindDelveCompanionID()
    local count = GetNumGroupMembers()
    if count > 0 then
        for i = 1, count do
            local unit = "party" .. i
            if UnitExists(unit) then
                local name = UnitName(unit)
                if name == (ns.L and ns.L.BrannBronzebeard) or name == (ns.L and ns.L.ValeeraSanguinar) then
                    return unit
                end
                
                -- Fallback to checking hardcoded NPC IDs
                local guid = UnitGUID(unit)
                local npcID = guid and select(6, strsplit("-", guid))
                if npcID == "210759" or npcID == "204418" then return unit end
            end
        end
    end
    return nil
end

function ns.Tricks_FindBestTargetID()
    -- delve
    if ns.db and ns.db.tricksDelveCompanion then
        local delveUnit = ns.Tricks_FindDelveCompanionID()
        if delveUnit then return delveUnit end
    end

    -- Choose targeting logic based on profile settings
    local logic = ns.db and ns.db.tricksLogic or "TANK"
    
    if logic == "TANK" then
        local inRaid = IsInRaid()
        local prefix = inRaid and "raid" or "party"
        local count = GetNumGroupMembers()
        
        if inRaid then
            for i = 1, count do
                local unit = "raid" .. i
                if IsValidTricksTarget(unit) and UnitGroupRolesAssigned(unit) == "TANK" then
                    return unit
                end
            end
        else
            for i = 1, count do
                local unit = "party" .. i
                if IsValidTricksTarget(unit) and UnitGroupRolesAssigned(unit) == "TANK" then
                    return unit
                end
            end
        end
    elseif logic == "TARGETTARGET" then
        return "targettarget"
    elseif logic == "CUSTOM" then
        return (ns.db.tricksCustomName ~= "" and ns.db.tricksCustomName) or nil
    end
    
    return nil
end

function ns.Tricks_DisableAndRemoveMacro()
    if not ns.db then return end
    ns.db.tricksEnabled = false
    
    local newName = "Nightveil"
    local oldName = "Nightveil - Tricks"
    
    local idxNew = GetMacroIndexByName(newName)
    local idxOld = GetMacroIndexByName(oldName)
    
    if not InCombatLockdown() then
        if idxNew > 0 then DeleteMacro(idxNew) end
        if idxOld > 0 then DeleteMacro(idxOld) end
        ns.tricksLastTargetID = nil
        ns.tricksLastMacroBody = nil
    else
        print(ns.GetAddonName() .. ": " .. (ns.L and ns.L.DebugCombatLock or "This action cannot be used in combat."))
        ns.tricksUpdateQueued = true
    end
end

function ns.Tricks_UpdateMacro(force)
    if not ns.db then return false end
    
    -- check disabled
    if not ns.db.tricksEnabled then return false end
    
    if InCombatLockdown() then
        ns.tricksUpdateQueued = true
        return false
    end

    local spellName = ns.Tricks_GetSpellName() or (ns.L and ns.L.TricksOfTheTrade or "Tricks of the Trade")
    local learned = false
    if IsSpellKnown(57934) or (IsPlayerSpell and IsPlayerSpell(57934)) then
        learned = true
    end

    local lines = {}
    local tankUnit = nil
    local body = ""

    if not ns.IsRogue or not learned then
        -- rogue check
        local warningMsg = not ns.IsRogue and (ns.L and ns.L.WarningNotRogue or "You are not a Rogue.") or (ns.L and ns.L.TricksNotLearned or "You have not learned Tricks of the Trade yet.")
        local addonPrefix = ns.GetAddonName()
        local printLine = "/run print(\"" .. addonPrefix .. ": |cffff9933" .. warningMsg .. "|r\")"
        table.insert(lines, printLine)
        body = table.concat(lines, "\n")
    else
        table.insert(lines, "#showtooltip")
        tankUnit = ns.Tricks_FindBestTargetID()
        local castParts = {}
        table.insert(castParts, "/cast")
        
        -- delve
        local inDelveWithCompanion = false
        if ns.db.tricksDelveCompanion then
            local delveUnit = ns.Tricks_FindDelveCompanionID()
            if delveUnit then
                table.insert(castParts, "[@" .. delveUnit .. ",help,nodead]")
                inDelveWithCompanion = true
            end
        end

        if not inDelveWithCompanion then
            if ns.db.tricksUseMouseover then
                table.insert(castParts, "[@mouseover,help,nodead]")
            end
            if ns.db.tricksUseFocus then
                table.insert(castParts, "[@focus,help,nodead]")
            end
            if tankUnit and tankUnit ~= "" then
                table.insert(castParts, "[@" .. tankUnit .. ",help,nodead]")
            end
        end
        
        table.insert(castParts, "[] " .. spellName)
        table.insert(lines, table.concat(castParts, " "))
        body = table.concat(lines, "\n")
    end
    
    -- [[ Macro Registration & Management ]] -------------------------------------
    local macroName = "Nightveil"
    local oldName = "Nightveil - Tricks"
    local icon = 236283 -- Ability_Rogue_TricksOftheTrade
    
    -- Clean up and rename legacy macros from older versions
    local oldIdx = GetMacroIndexByName(oldName)
    if oldIdx > 0 then
        EditMacro(oldIdx, macroName, icon, body)
    end

    local index = GetMacroIndexByName(macroName)
    local actualBody = index > 0 and GetMacroBody(index) or ""

    if not force and body == ns.tricksLastMacroBody and tankUnit == ns.tricksLastTargetID and body == actualBody then
        return true
    end
    
    if index == 0 then
        local numGlobal, numChar = GetNumMacros()
        if numGlobal < 120 then
            index = CreateMacro(macroName, icon, body, nil)
        elseif numChar < 18 then
            index = CreateMacro(macroName, icon, body, 1)
        else
            if ns.debugMode then print(ns.GetAddonName() .. ": Macro limit reached.") end
            return
        end
    else
        EditMacro(index, macroName, icon, body)
        if ns.debugMode then
            print(ns.GetAddonName() .. ": |cffce9cff[Debug]|r " .. (ns.L and ns.L.DebugMacroEdited or "Macro content modified and synchronized."))
        end
    end

    local oldTargetID = ns.tricksLastTargetID
    ns.tricksLastTargetID = tankUnit
    ns.tricksLastMacroBody = body
    ns.tricksUpdateQueued = false

    local targetName
    if tankUnit == "targettarget" then
        targetName = "|cff00ffff" .. (ns.L and ns.L.TargetTarget or "Target of Target") .. "|r"
    elseif tankUnit then
        targetName = ns.GetClassColoredName(tankUnit)
    else
        targetName = "|cffaaaaaa" .. (ns.L and ns.L.DebugNone or "none") .. "|r"
    end

    if force and ns.debugMode then
        print(string.format(ns.GetAddonName() .. ": |cffbe89e9[Debug]|r " .. (ns.L and ns.L.DebugMacroUpdated or "Macro updated: %s"), targetName or "nil"))
    end

    if ns.IsRogue and learned and ns.db.tricksEnabled and not ns.db.tricksMute then
        -- Log target changes to chat if they actually exist
        local changed = (tankUnit ~= oldTargetID)
        local exists = tankUnit and (tankUnit == "targettarget" or UnitExists(tankUnit))
        
        if changed and exists then
            print(string.format(ns.GetAddonName() .. ": |cffbe89e9%s|r → %s", ns.L and ns.L.TricksTargetLog or "Tricks target", targetName or "unknown"))
        end
    end
    return true
end

SlashCmdList["NIGHTVEIL"] = function(msg)
    local cmd, arg1 = string.split(" ", strtrim(msg or ""):lower())

    if cmd == "debug" then
        ns.debugMode = not ns.debugMode
        if ns.debugMode then
            print(string.format(ns.L.DebugModeActivated or (ns.GetAddonName() .. ": |cffbe89e9Debug Mode ACTIVATED|r"), ns.GetAddonName()))
            PrintDebugHelp()
        else
            print(string.format(ns.L.DebugModeDeactivated or (ns.GetAddonName() .. ": |cff9b7fd4 Debug Mode DEACTIVATED|r"), ns.GetAddonName()))
        end
    elseif cmd == "info" then
        if not ns.IsRogue then
            print(ns.GetAddonName() .. ": |cffff2020" .. (ns.L and ns.L.WarningNotRogue or "You are not a Rogue.") .. "|r")
            return
        end
        if not ns.debugMode then
            print(string.format(ns.L.DebugModeRequired or (ns.GetAddonName() .. ": |cffbe89e9This command requires Debug Mode.|r Type |cffffcc00/veil debug|r to enable."), ns.GetAddonName()))
            return
        end
        DebugState()
    elseif cmd == "shroud" then
        if not ns.IsRogue then
            print(ns.GetAddonName() .. ": |cffff2020" .. (ns.L and ns.L.WarningNotRogue or "You are not a Rogue.") .. "|r")
            return
        end
        if not ns.debugMode then
            print(string.format(ns.L.DebugModeRequired or (ns.GetAddonName() .. ": |cffbe89e9This command requires Debug Mode.|r Type |cffffcc00/veil debug|r to enable."), ns.GetAddonName()))
            return
        end
        local n = tonumber(arg1)
        if arg1 and arg1 ~= "" and (not n or n < 1 or n > 20) then
            print(string.format(ns.L and ns.L.DebugShroudUsage or (ns.GetAddonName() .. ": \|cff6a39a2Usage:|r \|cffffcc00/veil shroud [1-20]|r"), ns.GetAddonName()))
            return
        end
        RunShroudTest(n or 15)
    elseif cmd == "tricks" or cmd == "target" then
        if not ns.IsRogue then
            print(ns.GetAddonName() .. ": \|cffff2020" .. (ns.L and ns.L.WarningNotRogue or "You are not a Rogue.") .. "|r")
            return
        end
        local rawMsg = strtrim(msg or "")
        local _, rest = rawMsg:match("^(%S+)%s*(.*)$")
        
        if rest and rest ~= "" then
            if InCombatLockdown() then
                print(ns.GetAddonName() .. ": " .. (ns.L and ns.L.CombatBlocked or "Cannot open settings during combat."))
                return
            end

            local sub, val = rest:match("^(%S+)%s*(.*)$")
            sub = sub and sub:lower() or ""
            
            if sub == "list" then
                local isRaid = IsInRaid()
                local count = GetNumGroupMembers()
                local prefix = isRaid and "raid" or "party"
                local max = isRaid and count or count - 1
                local idx = tonumber(val)
                
                if idx then
                    local unit = idx == 0 and "player" or prefix .. idx
                    if UnitExists(unit) then
                        if UnitIsUnit(unit, "player") then
                            print(ns.GetAddonName() .. ": \|cff6a39a2" .. (ns.L and ns.L.TricksNoSelf or "You cannot target yourself.") .. "|r")
                            return
                        end
                        local name = UnitName(unit)
                        ns.db.tricksLogic = "CUSTOM"
                        ns.db.tricksCustomName = name
                        local text = ns.L and ns.L.TricksCustomSet or "Custom target set: %s"
                        print(string.format(ns.GetAddonName() .. ": " .. text, ns.GetClassColoredName(unit)))
                        ns.Tricks_UpdateMacro(true)
                    else
                        print(ns.GetAddonName() .. ": \|cff6a39a2" .. (ns.L and ns.L.TricksInvalidIndex or "Invalid group index.") .. "|r")
                    end
                    return
                end
                
                print(ns.GetAddonName() .. ": " .. (ns.L and ns.L.TricksGroupMembers or "Group members:"))
                print(string.format(" \|cffffcc00[0]|r %s (%s)", ns.GetClassColoredName("player"), ns.L and ns.L.DebugPlayer or "PLAYER"))
                for i = 1, max do
                    local unit = prefix .. i
                    local role = UnitGroupRolesAssigned(unit)
                    local colorName = ns.GetClassColoredName(unit)
                    print(string.format(" \|cffffcc00[%d]|r %s (%s)", i, colorName, role))
                end
                return
            elseif sub == "normal" then
                ns.db.tricksLogic = "NORMAL"
                local text = ns.L and ns.L.TricksLogicSet or "Targeting mode set: %s"
                print(string.format(ns.GetAddonName() .. ": " .. text, "\|cffffcc00" .. (ns.L and ns.L.TricksNormal or "Normal") .. "|r"))
                ns.Tricks_UpdateMacro(true)
                return
            elseif sub == "tank" then
                ns.db.tricksLogic = "TANK"
                local text = ns.L and ns.L.TricksLogicSet or "Targeting mode set: %s"
                print(string.format(ns.GetAddonName() .. ": " .. text, "\|cffffcc00" .. (ns.L and ns.L.Tank or "Tank") .. "|r"))
                ns.Tricks_UpdateMacro(true)
                return
            elseif sub == "tt" or sub == "targettarget" then
                ns.db.tricksLogic = "TARGETTARGET"
                local text = ns.L and ns.L.TricksLogicSet or "Targeting mode set: %s"
                print(string.format(ns.GetAddonName() .. ": " .. text, "\|cffffcc00" .. (ns.L and ns.L.TargetTarget or "Target of Target") .. "|r"))
                ns.Tricks_UpdateMacro(true)
                return
            elseif sub == "custom" then
                ns.db.tricksLogic = "CUSTOM"
                local text = ns.L and ns.L.TricksLogicSet or "Targeting mode set: %s"
                print(string.format(ns.GetAddonName() .. ": " .. text, "\|cffbe89e9" .. (ns.L and ns.L.TricksCustom or "Custom") .. "|r"))
                ns.Tricks_UpdateMacro(true)
                return
            elseif sub == "set" and val ~= "" then
                ns.db.tricksLogic = "CUSTOM"
                ns.db.tricksCustomName = val
                local text = ns.L and ns.L.TricksCustomSet or "Custom target set: %s"
                print(string.format(ns.GetAddonName() .. ": " .. text, "\|cffbe89e9" .. val .. "|r"))
                ns.Tricks_UpdateMacro(true)
                return
            else
                local errMsg = ns.L and ns.L.ErrorUnknownSubCmd or (ns.GetAddonName() .. ": |cff6a39a2|cffff2020Unknown sub-command: |cffffcc00%s|r. Use |cffffcc00/veil help|r.")
                print(string.format(errMsg, rest))
                return
            end
        end

        local logic = ns.db.tricksLogic or ns.Defaults.tricksLogic
        local tankUnit = ns.Tricks_FindBestTargetID()
        local targetName = tankUnit and ns.GetClassColoredName(tankUnit) or ("|cffaaaaaa" .. (ns.L and ns.L.DebugNone or "none") .. "|r")
        
        local modeName
        if logic == "TANK" then
            modeName = "|cffffcc00" .. (ns.L and ns.L.Tank or "Tank") .. "|r"
        elseif logic == "TARGETTARGET" then
            modeName = "|cffffcc00" .. (ns.L and ns.L.TargetTarget or "Target of Target") .. "|r"
        elseif logic == "CUSTOM" then
            local cname = (ns.db.tricksCustomName or "") 
            modeName = "|cffbe89e9" .. (ns.L and ns.L.TricksCustom or "Custom") .. "|r" .. (cname ~= "" and (" (" .. cname .. ")") or "")
        else
            modeName = "|cffffcc00" .. (ns.L and ns.L.TricksNormal or "Normal") .. "|r"
        end
        
        print(string.format(ns.GetAddonName() .. ": |cffcccccc%s|r %s → %s",
            ns.L and ns.L.TricksTargetLog or "Tricks target",
            modeName, targetName))
        if ns.debugMode then
            local statusStr = ns.tricksLastMacroBody and ("|cffbe89e9" .. (ns.L and ns.L.DebugYes or "OK") .. "|r") or ("|cffff2020" .. (ns.L and ns.L.DebugNo or "ERR") .. "|r")
            print(string.format(ns.GetAddonName() .. ": |cffb894ff[Debug]|r " .. (ns.L and ns.L.DebugMacroStatus or "Macro: %s"), statusStr))
        end
    elseif cmd == "utricks" then
        if not ns.IsRogue then
            print(ns.GetAddonName() .. ": |cffff9933" .. (ns.L and ns.L.WarningNotRogue or "You are not a Rogue.") .. "|r")
            return
        end
        if ns.debugMode then
            print(ns.GetAddonName() .. ": |cffce9cff[Debug]|r " .. (ns.L and ns.L.DebugTricksForcing or "Forcing Tricks update..."))
        end
        ns.Tricks_UpdateMacro(true)
        if ns.debugMode then
            print(ns.GetAddonName() .. ": |cffce9cff[Debug]|r " .. (ns.L and ns.L.DebugTricksSuccess or "Macro refresh SUCCESS."))
        end
    elseif cmd == "help" then
        print(string.format(ns.GetAddonName() .. " |cffffcc00v%s|r", ns.Defaults.version))
        print(" ")
        print(" |cffbe89e9/veil|r - " .. (ns.L.HelpSettings or "Open settings"))
        
        if ns.IsRogue then
            print(" ")
            print(" |cffbe89e9/veil tricks|r - " .. (ns.L.HelpTricks or "Tricks status"))
            print(" |cffbe89e9/veil tricks normal|r - " .. (ns.L.HelpTricksNormal or "Normal mode"))
            print(" |cffbe89e9/veil tricks tank|r - " .. (ns.L.HelpTricksTank or "Tank mode"))
            print(" |cffbe89e9/veil tricks tt|r - " .. (ns.L.HelpTricksTT or "Target-of-Target mode"))
            print(" |cffbe89e9/veil tricks custom|r - " .. (ns.L.HelpTricksCustom or "Custom mode"))
            print(" |cffbe89e9/veil tricks list [#]|r - " .. (ns.L.HelpTricksList or "List group / pick by index"))
            print(" |cffbe89e9/veil tricks set <name>|r - " .. (ns.L.HelpTricksSet or "Set custom target name"))
        end
        print(" ")
        print(" |cffbe89e9/veil debug|r - " .. (ns.L.HelpDebugToggle or "Toggle debug mode"))

        if ns.debugMode then
            if ns.IsRogue then
                print(" |cffce9cff/veil utricks|r - " .. (ns.L.HelpUTricks or "Force macro refresh"))
            end
            print(" |cffce9cff/veil info|r - " .. (ns.L.HelpInfo or "Diagnostic info"))
            print(" |cffce9cff/veil shroud [1-20]|r - " .. (ns.L.HelpShroudTest or "Test shroud"))
        end
    elseif cmd == "" then
        if InCombatLockdown() then
            print(ns.GetAddonName() .. ": |cff6b5c92" .. (ns.L and ns.L.CombatBlocked or "Cannot open settings during combat.") .. "|r")
            return
        end
        if ns.MainCategory then 
            Settings.OpenToCategory(ns.MainCategory:GetID()) 
        end
    else
        local errMsg = ns.L and ns.L.ErrorUnknownCmd or (ns.GetAddonName() .. ": |cffff6020Unknown command: \|cffffcc00%s|r. Use \|cffffcc00/veil help|r.")
        print(string.format(errMsg, cmd))
    end
end
