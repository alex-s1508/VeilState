-- ============================================================================
-- [[ NIGHTVEIL — CHAT & ANNOUNCEMENT ENGINE ]] ------------------------------
-- ============================================================================
local addonName, ns = ...
ns.Shared = ns.Shared or {}

-- [[ THROTTLE & RATE LIMITING ]] ---------------------------------------------
local warnedSayRange = false
local channelDenyUntil = {}

function ns.Shared.CanAnnounceGlobal(key, seconds)
    local now = GetTime()
    local untilTime = errorDenyUntil[key] or 0
    if untilTime > now then return false end
    errorDenyUntil[key] = now + (seconds or 5)
    return true
end

function ns.Shared.GetChannelLabel(channel)
    if ns.L then
        if channel == "SAY" then return ns.L.ChannelSay end
        if channel == "YELL" then return ns.L.ChannelYell end
        if channel == "PARTY" then return ns.L.ChannelParty end
        if channel == "RAID" then return ns.L.ChannelRaid end
        if channel == "INSTANCE_CHAT" then return ns.L.ChannelInstance end
    end
    return channel
end

function ns.Shared.ColorRed(text) return "\|cff6a39a2" .. tostring(text or "") .. "|r" end

-- ============================================================================
-- [[ CHANNEL VALIDATION ]] ---------------------------------------------------
-- ============================================================================
function ns.Shared.GetChannelStatus(channel)
    if not channel or channel == "NONE" then return false, "NONE" end

    local now = GetTime()
    local deny = channelDenyUntil[channel] or 0
    if deny > now then
        return false, "TEMP"
    end

    local inInstance = IsInInstance()
    local inGroup = IsInGroup()
    local isRaid = IsInRaid()
    local channelName = ns.Shared.GetChannelLabel(channel) or channel

    local players, _, others = ns.Shared.GetGroupComposition()

    local function denyChannel(reason, text)
        channelDenyUntil[channel] = now + 8
        return false, reason, text
    end

    if channel == "SAY" or channel == "YELL" then
        if inInstance then return true end
        if channel == "SAY" or channel == "YELL" then
            return denyChannel("ANTISPAM", string.format(ns.L and ns.L.ErrorBlizzardAntiSpam or "|cffff2020Blizzard anti-spam restrictions prevent using channel|r |cffffcc00%s|r |cffff2020outside instances.|r", channelName))
        end
    end

    if channel == "INSTANCE_CHAT" then
        if not IsInGroup(LE_PARTY_CATEGORY_INSTANCE) then
            return denyChannel("NOT_IN_INSTANCE", string.format(ns.L and ns.L.ErrorErrorShroudInstanceOnly or "|cffff2020You are not inside an instance. Channel|r |cffffcc00%s|r |cffff2020unavailable.|r", channelName))
        end
        return true
    end

    if channel == "PARTY" then
        if not inGroup or isRaid then
            return denyChannel("NOT_IN_GROUP", string.format(ns.L and ns.L.ErrorNotInGroup or "|cffff2020You are not in a group. Channel|r |cffffcc00%s|r |cffff2020unavailable.|r", channelName))
        end
        if players <= 1 and others > 0 then
            return denyChannel("INVALID_GROUP", string.format(ns.L and ns.L.ErrorFollowersDungeonGroup or "|cffff2020You are alone or in an invalid group. Channel|r |cffffcc00%s|r |cffff2020unavailable.|r", channelName))
        end
        return true
    end

    if channel == "RAID" then
        if not isRaid then
            return denyChannel("NOT_IN_RAID", string.format(ns.L and ns.L.ErrorNotInRaid or "|cffff2020You are not in a raid. Channel|r |cffffcc00%s|r |cffff2020unavailable.|r", channelName))
        end
        if players <= 1 and others > 0 then
            return denyChannel("INVALID_GROUP", string.format(ns.L and ns.L.ErrorFollowersDungeonGroup or "|cffff2020You are alone or in an invalid group. Channel|r |cffffcc00%s|r |cffff2020unavailable.|r", channelName))
        end
        return true
    end

    return false, "NONE"
end

function ns.Shared.IsChannelUsable(channel)
    local ok = ns.Shared.GetChannelStatus(channel)
    return ok == true
end

-- ============================================================================
-- [[ DELIVERY SYSTEMS ]] -----------------------------------------------------
-- ============================================================================
function ns.Shared.SendChat(channel, msg, silent)
    if not msg or msg:gsub("%s+", "") == "" then return false end

    local ok, reason, text = ns.Shared.GetChannelStatus(channel)
    if not ok then
        if not silent and text then
            local prefix = ns.Shared.GetAddonName() .. ": "
            if not text:find(prefix) then text = prefix .. text end
            
            if reason == "ANTISPAM" then
                if not warnedSayRange and (ThrottleError and ThrottleError("ANTISPAM", 8) or ns.Shared.CanAnnounceGlobal("ANTISPAM", 8)) then
                    warnedSayRange = true
                    print(text)
                end
            else
                if (ThrottleError and ThrottleError(reason .. ":" .. tostring(channel), 5) or ns.Shared.CanAnnounceGlobal(reason .. ":" .. tostring(channel), 5)) then
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
        local okPcall = pcall(sendFunc, msg, channel)
        return okPcall == true
    end
end

function ns.Shared.SendChatOrPrint(msg, isSynthetic)
    if not msg or msg == "" then return end
    
    if isSynthetic then
        print(ns.Shared.GetAddonName() .. ": " .. msg)
        return
    end

    local db = ns.db
    if not db then return end

    if db.shroudOnlyInstances and not IsInInstance() then
        if not ns.shroudErrorsDisplayed["INSTANCE_ONLY"] then
            ns.shroudErrorsDisplayed["INSTANCE_ONLY"] = true
            local errorMsg = ns.L and ns.L.ErrorShroudOnlyInstances or "|cffff2020Shroud messages only work inside instances.|r"
            local prefix = ns.Shared.GetAddonName() .. ": "
            if not errorMsg:find(prefix) then errorMsg = prefix .. errorMsg end
            print(errorMsg)
        end
        return
    end

    local muteErrors = db.shroudMuteErrors == true

    if ns.Shared.SendChat(db.shroudChannel, msg, muteErrors) then return end
    if ns.Shared.SendChat(db.shroudChannelFallback1, msg, true) then return end
    if ns.Shared.SendChat(db.shroudChannelFallback2, msg, true) then return end

    if not muteErrors then
        if not ns.shroudErrorsDisplayed["NO_CHANNEL"] then
            ns.shroudErrorsDisplayed["NO_CHANNEL"] = true
            local errorMsg = ns.L and ns.L.ErrorNoValidChannel or "|cffff2020No valid chat channel available.|r"
            local prefix = ns.Shared.GetAddonName() .. ": "
            if not errorMsg:find(prefix) then errorMsg = prefix .. errorMsg end
            print(errorMsg)
        end
    end
end
