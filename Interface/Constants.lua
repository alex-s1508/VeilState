local addonName, ns = ...

ns.Defaults = {
    version = "1.0.2",

    stealthEnabled = true,
    stealthOnlyInstances = false,
    stealthEnableText = true,
    stealthCustomText = ns.L.DefaultMessage,
    stealthTextColor = {r = 0.64, g = 0.38, b = 0.89},
    stealthTextAlpha = 1,
    stealthTextX = 0,
    stealthTextY = 185,
    stealthTextSize = 32,
    stealthTextAnim = "NONE",
    stealthTextAnimSpeed = 1,
    stealthEnableIcon = false,
    stealthIconSize = 64,
    stealthIconAlpha = 1,
    stealthIconAnchorToText = false,
    stealthIconAnchorPoint = "LEFT",
    stealthIconX = 0,
    stealthIconY = 0,
    stealthEnableScreenColor = true,
    stealthScreenColor = {r = 0.64, g = 0.38, b = 0.89},
    stealthScreenAlpha = 0.1,
    stealthScreenStrata = "BACKGROUND",
    stealthEnableVignette = true,
    stealthVignetteSize = 250,
    stealthVignetteAlpha = 0.6,
    stealthVignetteStrata = "BACKGROUND",
    stealthEnableHighlight = true,
    stealthHighlightType = 2,

    shroudCountdown = false,
    shroudOnlyInstances = true,
    shroudChannel = "PARTY",
    shroudChannelFallback1 = "INSTANCE_CHAT",
    shroudChannelFallback2 = "NONE",
    shroudMessage = "%time",
    shroudInterval = false,
    shroudStartMsg = "%time",
    shroudEndMsg = "%time",

    poisonOnlyCombat = false,
    poisonOnlyInstances = false,

    poisonLethalEnabled = true,
    poisonLethalEnableText = true,
    poisonLethalCustomText = ns.L.LethalPoisonMissing,
    poisonLethalTextColor = {r = 1, g = 0.2, b = 0.2},
    poisonLethalTextAlpha = 1,
    poisonLethalTextX = 0,
    poisonLethalTextY = 300,
    poisonLethalTextSize = 28,
    poisonLethalTextAnim = "NONE",
    poisonLethalTextAnimSpeed = 1,
    poisonLethalEnableIcon = true,
    poisonLethalIconSpellId = 315584,
    poisonLethalIconTexture = "Interface\\Icons\\Ability_Poisons",
    poisonLethalIconSize = 36,
    poisonLethalIconAlpha = 1,
    poisonLethalIconAnchorToText = true,
    poisonLethalIconAnchorPoint = "LEFT",
    poisonLethalIconX = -5,
    poisonLethalIconY = 0,
    poisonLethalEnableSound = true,
    poisonLethalSoundKit = (SOUNDKIT and SOUNDKIT.RAID_WARNING) or 8959,

    poisonNonLethalEnabled = true,
    poisonNonLethalEnableText = true,
    poisonNonLethalCustomText = ns.L.NonLethalPoisonMissing,
    poisonNonLethalTextColor = {r = 1, g = 0.6, b = 0.2},
    poisonNonLethalTextAlpha = 1,
    poisonNonLethalTextX = 0,
    poisonNonLethalTextY = 260,
    poisonNonLethalTextSize = 28,
    poisonNonLethalTextAnim = "NONE",
    poisonNonLethalTextAnimSpeed = 1,
    poisonNonLethalEnableIcon = true,
    poisonNonLethalIconSpellId = 3408,
    poisonNonLethalIconTexture = "Interface\\Icons\\Ability_PoisonSting",
    poisonNonLethalIconSize = 36,
    poisonNonLethalIconAlpha = 1,
    poisonNonLethalIconAnchorToText = true,
    poisonNonLethalIconAnchorPoint = "LEFT",
    poisonNonLethalIconX = -5,
    poisonNonLethalIconY = 0,
    poisonNonLethalEnableSound = true,
    poisonNonLethalSoundKit = (SOUNDKIT and SOUNDKIT.RAID_WARNING) or 8959,
}

function ns.CopyDefaults(src, dst)
    for k, v in pairs(src) do
        if type(v) == "table" then
            dst[k] = dst[k] or {}
            ns.CopyDefaults(v, dst[k])
        elseif dst[k] == nil then
            dst[k] = v
        end
    end
end

function ns.IsInInstance()
    local inInstance, instanceType = IsInInstance()
    return inInstance and (instanceType == "party" or instanceType == "raid" or instanceType == "scenario")
end
