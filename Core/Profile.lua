-- ============================================================================
-- [[ PROFILE & DATABASE ENGINE ]] -------------------------------------------
-- ============================================================================
local addonName, ns = ...
ns.Shared = ns.Shared or {}

-- [[ PROFILE NORMALIZATION & MIGRATION ]] ------------------------------------
function ns.Shared.NormalizeProfile(profile)
    if ns.Shared.NormalizeProfileMigrated then
        return ns.Shared.NormalizeProfileMigrated(profile)
    end
    -- Fallback/Initial implementation if Migration.lua isn't loaded yet (though it should be)
    -- This is just to satisfy dependencies within this file
    return "OK"
end

-- ============================================================================
-- [[ DATABASE VERSIONING ]] --------------------------------------------------
-- ============================================================================
function ns.Shared.CheckDatabaseVersion()
    if ns.Shared.CheckDatabaseVersionMigrated then
        return ns.Shared.CheckDatabaseVersionMigrated()
    end
    return "OK"
end

-- [[ UTILITY FUNCTIONS ]] ----------------------------------------------------

function ns.Shared.GetCharacterKey()
    local name = UnitName and UnitName("player") or "Unknown"
    local realm = GetRealmName and GetRealmName() or ""
    if realm ~= "" then
        return name .. " - " .. realm
    end
    return name
end

function ns.Shared.UrlEncode(s)
    s = tostring(s or "")
    return (s:gsub("([^%w%-_%.~])", function(c)
        return string.format("%%%02X", string.byte(c))
    end))
end

function ns.Shared.UrlDecode(s)
    s = tostring(s or "")
    return (s:gsub("%%(%x%x)", function(h)
        return string.char(tonumber(h, 16))
    end))
end

function ns.Shared.GetDefaultKeysSorted()
    local keys = {}
    for k in pairs(ns.Defaults or {}) do
        keys[#keys + 1] = k
    end
    table.sort(keys)
    return keys
end

function ns.Shared.EncodeValue(key, value)
    local def = ns.Defaults and ns.Defaults[key]
    if type(def) == "table" and def.r ~= nil and def.g ~= nil and def.b ~= nil then
        local c = type(value) == "table" and value or def
        local r = tonumber(c.r) or tonumber(def.r) or 0
        local g = tonumber(c.g) or tonumber(def.g) or 0
        local b = tonumber(c.b) or tonumber(def.b) or 0
        return "c" .. string.format("%.3f,%.3f,%.3f", r, g, b)
    end
    if type(def) == "table" and def.blink ~= nil and def.fade ~= nil and def.shake ~= nil then
        local a = type(value) == "table" and value or def
        local b_val = a.blink and 1 or 0
        local f_val = a.fade and 1 or 0
        local s_val = a.shake and 1 or 0
        local bSpd = tonumber(a.blinkSpeed) or 1
        local fSpd = tonumber(a.fadeSpeed) or 1
        local sSpd = tonumber(a.shakeSpeed) or 1
        return "a" .. string.format("%d,%d,%d,%.2f,%.2f,%.2f", b_val, f_val, s_val, bSpd, fSpd, sSpd)
    end
    if type(def) == "boolean" then
        return value and "b1" or "b0"
    end
    if type(def) == "number" then
        return "n" .. tostring(tonumber(value) or 0)
    end
    return "s" .. ns.Shared.UrlEncode(tostring(value or ""))
end

function ns.Shared.DecodeValue(key, token)
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
    if tag == "a" and type(def) == "table" and def.blink ~= nil then
        local b_v, f_v, s_v, bSpd, fSpd, sSpd = body:match("^([^,]+),([^,]+),([^,]+),([^,]+),([^,]+),([^,]+)$")
        return {
            blink = (b_v == "1"), blinkSpeed = tonumber(bSpd) or 1,
            fade = (f_v == "1"), fadeSpeed = tonumber(fSpd) or 1,
            shake = (s_v == "1"), shakeSpeed = tonumber(sSpd) or 1,
        }
    end
    if tag == "s" then return ns.Shared.UrlDecode(body) end
    return nil
end

-- ============================================================================
-- [[ PROFILE MANAGEMENT ]] ---------------------------------------------------
-- ============================================================================

function ns.Shared.GetActiveProfileName() return ns.activeProfileName or "Default" end

function ns.Shared.GetProfiles()
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
        local charKey = ns.Shared.GetCharacterKey()
        if a == charKey then return true end
        if b == charKey then return false end
        return tostring(a):lower() < tostring(b):lower()
    end)
    return list
end

function ns.Shared.SetActiveProfile(name)
    if type(name) ~= "string" or name == "" then return false end
    local db = NightveilDB
    if not (db and db.profiles and db.profiles[name]) then return false end
    local charKey = ns.Shared.GetCharacterKey()
    db.profileKeys = db.profileKeys or {}
    db.profileKeys[charKey] = name
    ns.activeProfileName = name
    ns.db = db.profiles[name]
    ns.Shared.NormalizeProfile(ns.db)
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

function ns.Shared.CreateProfile(name, sourceName)
    name = type(name) == "string" and strtrim(name) or ""
    if name == "" then return false, "invalid_name" end
    local db = NightveilDB
    if not db then return false, "missing_db" end
    db.profiles = db.profiles or {}
    if db.profiles[name] ~= nil then return false, "already_exists" end
    local source = (type(sourceName) == "string" and db.profiles[sourceName]) or db.profiles[ns.Shared.GetActiveProfileName()] or db.profiles.Default or {}
    db.profiles[name] = ns.Shared.DeepCopy(source)
    ns.Shared.NormalizeProfile(db.profiles[name])
    ns.CopyDefaults(ns.Defaults, db.profiles[name])
    return true
end

function ns.Shared.DeleteProfile(name)
    if name == "Default" then return false end
    local db = NightveilDB
    if not (db and db.profiles and db.profiles[name]) then return false end
    db.profiles[name] = nil
    local charKey = ns.Shared.GetCharacterKey()
    if db.profileKeys and db.profileKeys[charKey] == name then
        local fallback = db.profiles[charKey] and charKey or "Default"
        ns.Shared.SetActiveProfile(fallback)
    end
    return true
end

function ns.Shared.ExportProfileString(profileName)
    local db = NightveilDB
    if not (db and db.profiles) then return "" end
    local name = profileName or ns.Shared.GetActiveProfileName()
    local profile = db.profiles[name]
    if type(profile) ~= "table" then return "" end
    ns.Shared.NormalizeProfile(profile)
    local keys = ns.Shared.GetDefaultKeysSorted()
    local parts = {}
    for _, k in ipairs(keys) do
        local v = profile[k]
        if v ~= nil then
            parts[#parts + 1] = k .. "=" .. ns.Shared.EncodeValue(k, v)
        end
    end
    return "NV1|" .. ns.Shared.UrlEncode(tostring(name)) .. "|" .. table.concat(parts, ";")
end

function ns.Shared.ImportProfileString(exportString, targetProfileName)
    if type(exportString) ~= "string" then return false, "invalid_string" end
    local version, encodedName, payload = exportString:match("^(NV1)|([^|]*)|(.*)$")
    if version ~= "NV1" then return false, "invalid_header" end

    local db = NightveilDB
    if not db then return false, "missing_db" end
    db.profiles = db.profiles or {}

    local target = type(targetProfileName) == "string" and strtrim(targetProfileName) or ""
    if target == "" then
        target = ns.Shared.UrlDecode(encodedName or "")
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
                local v = ns.Shared.DecodeValue(mappedKey, token)
                if v ~= nil then profile[mappedKey] = v end
            end
        end
    end

    if profile.stealthCustomText ~= nil then
        profile.stealthCustomText = tostring(profile.stealthCustomText)
    end

    ns.Shared.NormalizeProfile(profile)
    ns.CopyDefaults(ns.Defaults, profile)
    return true, target
end

-- ============================================================================
-- [[ INITIALIZATION & EXPORTS ]] ---------------------------------------------
-- ============================================================================

ns.CheckDatabaseVersion = ns.Shared.CheckDatabaseVersion
ns.GetCharacterKey      = ns.Shared.GetCharacterKey
ns.GetActiveProfileName = ns.Shared.GetActiveProfileName
ns.GetProfiles          = ns.Shared.GetProfiles
ns.SetActiveProfile     = ns.Shared.SetActiveProfile
ns.CreateProfile        = ns.Shared.CreateProfile
ns.DeleteProfile        = ns.Shared.DeleteProfile
ns.ExportProfileString  = ns.Shared.ExportProfileString
ns.ImportProfileString  = ns.Shared.ImportProfileString

function ns.Shared.InitProfile()
    NightveilDB = NightveilDB or {}
    local verResult = ns.Shared.CheckDatabaseVersion()
    if verResult == "WAITING" then return "WAITING" end

    NightveilDB.profiles    = NightveilDB.profiles or {}
    NightveilDB.profileKeys = NightveilDB.profileKeys or {}
    NightveilDB.global      = NightveilDB.global or {}
    NightveilDB.profiles.Default = NightveilDB.profiles.Default or {}

    ns.Shared.NormalizeProfile(NightveilDB.profiles.Default)
    if ns.CopyDefaults then ns.CopyDefaults(ns.Defaults, NightveilDB.profiles.Default) end

    local charKey = ns.Shared.GetCharacterKey()
    if not NightveilDB.profiles[charKey] then
        NightveilDB.profiles[charKey] = ns.Shared.DeepCopy(NightveilDB.profiles.Default)
    end

    local activeProfile = NightveilDB.profileKeys[charKey] or charKey
    if not NightveilDB.profiles[activeProfile] then
        activeProfile = charKey
        NightveilDB.profileKeys[charKey] = activeProfile
    end

    ns.activeProfileName = activeProfile
    ns.db = NightveilDB.profiles[activeProfile]

    ns.Shared.NormalizeProfile(ns.db)
    if ns.CopyDefaults then ns.CopyDefaults(ns.Defaults, ns.db) end

    return verResult
end
