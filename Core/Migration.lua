-- ============================================================================
-- [[ LEGACY MIGRATION & VERSION ENGINE ]] ------------------------------------
-- ============================================================================
local addonName, ns = ...
ns.Shared = ns.Shared or {}

-- [[ LEGACY IMPORT KEY MAPPING ]] -------------------------------------------
local LEGACY_IMPORT_KEY_MAP = {
    -- [[ Hidden State Visuals ]] ----------------------------------------------
    enableText              = "stealthEnableText",
    customText              = "stealthEnableText",
    textColor               = "stealthTextColor",
    textAlpha               = "stealthTextAlpha",
    textX                   = "stealthTextX",
    textY                   = "stealthTextY",
    textSize                = "stealthTextSize",
    enableIcon              = "stealthEnableIcon",
    iconSize                = "stealthIconSize",
    iconAlpha               = "stealthIconAlpha",
    iconAnchorToText        = "stealthIconAnchorToText",
    iconAnchorPoint         = "stealthIconAnchorPoint",
    iconX                   = "stealthIconX",
    iconY                   = "stealthIconY",
    enableScreenColor       = "stealthEnableScreenColor",
    screenColor             = "stealthScreenColor",
    screenAlpha             = "stealthScreenAlpha",
    screenStrata            = "hiddenStateScreenStrata", -- Drawing Layer
    enableVignette          = "stealthEnableVignette",
    vignetteSize            = "stealthVignetteSize",
    vignetteAlpha           = "stealthVignetteAlpha",
    vignetteStrata          = "hiddenStateVignetteStrata", -- Drawing Layer
    enableHighlight         = "stealthEnableHighlight",
    highlightType           = "stealthHighlightType",

    -- [[ Text/Message Aliases ]]
    stealthText             = "stealthCustomText",
    stealthMessage          = "stealthCustomText",
    text                    = "stealthCustomText",
    message                 = "stealthCustomText",
    CustomText              = "stealthCustomText",
    Nightveil_CustomText    = "stealthCustomText",
    
    -- [[ Attribute Aliases ]]
    stealthAlpha            = "stealthTextAlpha",
    TextAlpha               = "stealthTextAlpha",
    Nightveil_TextColor     = "stealthTextColor",
    Nightveil_TextAlpha     = "stealthTextAlpha",
}

-- [[ STATIC POPUP DIALOGS ]] ------------------------------------------------
StaticPopupDialogs["NIGHTVEIL_HARD_RESET"] = {
    text = ns.GetAddonName() .. "\n\n" .. (ns.L and ns.L.ErrorHardReset or "|cffff2020Old or incompatible version detected.|r\n\nSettings will be |cffffcc00reset|r to ensure stability."),
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
    text = ns.GetAddonName() .. "\n\n" .. (ns.L and ns.L.WarningOutdatedConfig or "|cffffcc00Newer configuration detected!|r\n\nIt is recommended to |cffbe89e9update|r the addon or reset the profile."),
    button1 = "OK",
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
    preferredIndex = 3,
}

-- [[ VERSION HELPERS ]] ------------------------------------------------------
local function GetVerScore(v)
    if not v or v == "" then return -1 end
    -- Robust parsing of semantic version (supports X, X.Y, X.Y.Z)
    local major, minor, patch = tostring(v):match("^(%d+)%.?(%d*)%.?(%d*)")
    if not major then return 0 end
    return (tonumber(major) * 10000) + (tonumber(minor) or 0) * 100 + (tonumber(patch) or 0)
end

local function GetMajor(v)
    if not v or v == "" then return 0 end
    local major = tostring(v):match("^(%d+)")
    return tonumber(major) or 0
end

-- [[ PROFILE NORMALIZATION & MIGRATION ]] ------------------------------------
function ns.Shared.NormalizeProfileMigrated(profile)
    if not profile or type(profile) ~= "table" then return "ERROR" end
    
    local defaults = ns.Defaults or {}
    local currentVer = ns.Version or "0.0.0"
    local minVer = ns.MinVersion or "0.0.0"
    local profileVer = profile.version or "0.0.0"
    
    local profileScore = GetVerScore(profileVer)
    local minScore = GetVerScore(minVer)

    if profileScore < minScore then
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

    -- Hidden State Unified Migration
    local hiddenStateMigrationMap = {
        stealthStateEnabled = "hiddenStateEnabled",
        stealthOnlyInstances = "hiddenStateOnlyInstances",
        stealthDisableInDungeons = "hiddenStateDisableInDungeons",
        stealthDisableInRaids = "hiddenStateDisableInRaids",
        stealthStateEnableText = "hiddenStateEnableText",
        stealthStateCustomText = "hiddenStateCustomText",
        stealthStateTextColor = "hiddenStateTextColor",
        stealthStateTextAlpha = "hiddenStateTextAlpha",
        stealthStateTextX = "hiddenStateTextX",
        stealthStateTextY = "hiddenStateTextY",
        stealthStateTextSize = "hiddenStateTextSize",
        stealthStateEnableIcon = "hiddenStateEnableIcon",
        stealthStateIconTexture = "hiddenStateIconTexture",
        stealthStateIconSize = "hiddenStateIconSize",
        stealthStateIconAlpha = "hiddenStateIconAlpha",
        stealthStateIconAnchorToText = "hiddenStateIconAnchorToText",
        stealthStateIconAnchorPoint = "hiddenStateIconAnchorPoint",
        stealthStateIconX = "hiddenStateIconX",
        stealthStateIconY = "hiddenStateIconY",
        stealthStateEnableScreenColor = "hiddenStateEnableScreenColor",
        stealthStateScreenColor = "hiddenStateScreenColor",
        stealthStateScreenAlpha = "hiddenStateScreenAlpha",
        stealthStateScreenStrata = "hiddenStateScreenStrata", -- Drawing Layer
        stealthStateEnableVignette = "hiddenStateEnableVignette",
        stealthStateVignetteSize = "hiddenStateVignetteSize",
        stealthStateVignetteAlpha = "hiddenStateVignetteAlpha",
        stealthStateVignetteStrata = "hiddenStateVignetteStrata", -- Drawing Layer
        
        highlightStealthState = "highlightHiddenState",
        
        stealthCustomText = "hiddenStateRogueCustomText",
        stealthEnableIcon = "hiddenStateRogueEnableIconStealth",
        camouflageCustomText = "hiddenStateHunterCustomText",
        camouflageEnableIcon = "hiddenStateHunterEnableIconCamouflage",
        prowlCustomText = "hiddenStateDruidCustomText",
        prowlEnableIcon = "hiddenStateDruidEnableIconProwl",
    }
    
    for oldKey, newKey in pairs(hiddenStateMigrationMap) do
        if profile[oldKey] ~= nil then
            if profile[newKey] == nil then
                profile[newKey] = type(profile[oldKey]) == "table" and ns.Shared.DeepCopy(profile[oldKey]) or profile[oldKey]
            end
            profile[oldKey] = nil
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

    -- Fill missing defaults
    for k, v in pairs(defaults) do
        if profile[k] == nil then
            profile[k] = type(v) == "table" and ns.Shared.DeepCopy(v) or v
        elseif type(v) == "table" and type(profile[k]) == "string" and k:match("Anim$") then
            -- Legacy animation string migration
            local oldStr = profile[k]
            local spd = tonumber(profile[k.."Speed"]) or 1
            profile[k] = {
                blink = (oldStr == "BLINK"), blinkSpeed = spd,
                fade  = (oldStr == "FADE"),  fadeSpeed  = spd,
                shake = (oldStr == "SHAKE"), shakeSpeed = spd,
            }
        end
    end

    -- Legacy migration for Tricks logic
    if profile.tricksLogic == "TARGET" then
        profile.tricksLogic = "NORMAL"
    end

    -- Clean up orphaned settings
    for k in pairs(profile) do
        if k ~= "version" and defaults[k] == nil and k:sub(1, 15) ~= "hiddenStateAura" then
            profile[k] = nil
        end
    end

    -- Strict final version enforcement (removes legacy casing/prefixes)
    profile.version = currentVer
    profile.Version = nil
    profile.Nightveil_version = nil

    return "OK"
end

-- [[ DATABASE VERSIONING ]] --------------------------------------------------
function ns.Shared.CheckDatabaseVersionMigrated()
    local currentVer = ns.Version or "0.0.0"
    local minVer = ns.MinVersion or "0.0.0"
    local savedVer = NightveilDB and NightveilDB.version

    if not NightveilDB or not NightveilDB.profiles then
        NightveilDB = NightveilDB or {}
        NightveilDB.version = currentVer
        NightveilDB.profiles = {}
        NightveilDB.profileKeys = {}
        return "FRESH"
    end

    if savedVer == "PENDING_RELOAD" then
        NightveilDB.version = currentVer
        return "UPDATED"
    end

    local addonScore = GetVerScore(currentVer)
    local dbScore = GetVerScore(savedVer)
    local minScore = GetVerScore(minVer)

    -- Incompatible version check (Hard Reset)
    if dbScore < minScore then
        wipe(NightveilDB)
        NightveilDB.version = "PENDING_RELOAD"
        StaticPopup_Show("NIGHTVEIL_HARD_RESET")
        return "WAITING"
    end

    -- Update detection
    if addonScore > dbScore then
        NightveilDB.version = currentVer
        return "UPDATED"
    end

    -- Newer version detection (Outdated Addon vs Config)
    if dbScore > addonScore then
        StaticPopup_Show("NIGHTVEIL_OUTDATED_CONFIG")
        -- Update version to current addon version to avoid seeing this popup every reload
        NightveilDB.version = currentVer
    end
end

-- [[ MACRO MIGRATION ]] ------------------------------------------------------
function ns.Shared.MigrateLegacyMacros()
    if InCombatLockdown() then return end
    
    local oldName = "Nightveil - Tricks"
    local macroName = "Nightveil"
    
    local oldIdx = GetMacroIndexByName(oldName)
    if oldIdx > 0 then
        local body = GetMacroBody(oldIdx)
        -- Only attempt to rename if the new name doesn't exist yet
        local newIdx = GetMacroIndexByName(macroName)
        if newIdx == 0 then
            local icon = 236283 -- Ability_Rogue_TricksOftheTrade
            EditMacro(oldIdx, macroName, icon, body)
            if ns.debugMode then
                print(string.format(ns.L and ns.L.DebugMacroStatus or "%s: Legacy macro migrated: %s", ns.GetAddonName(), macroName))
            end
        else
            -- If new macro exists, just delete the old one
            DeleteMacro(oldIdx)
        end
    end
end

ns.Shared.LEGACY_IMPORT_KEY_MAP = LEGACY_IMPORT_KEY_MAP
