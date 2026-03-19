local addonName, ns = ...

-- [[ Core Addon Defaults & Configuration ]] ----------------------------------
ns.Defaults = {
    version = "2.1.2",

    -- Stealth Module Defaults
    stealthEnabled = true,
    stealthOnlyInstances = false,
    stealthEnableText = true,
    stealthCustomText = ns.L.StealthActiveText,
    stealthTextColor = {r = 0.420, g = 0.518, b = 0.647},
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
    stealthScreenColor = {r = 0.420, g = 0.518, b = 0.647},
    stealthScreenAlpha = 0.1,
    stealthScreenStrata = "BACKGROUND",
    stealthEnableVignette = true,
    stealthVignetteSize = 250,
    stealthVignetteAlpha = 0.6,
    stealthVignetteStrata = "BACKGROUND",
    stealthEnableHighlight = true,
    stealthHighlightType = 2,

    -- Shroud of Concealment Module Defaults
    shroudCountdown = false,
    shroudOnlyInstances = true,
    shroudMuteErrors = false,
    shroudChannel = "SAY",
    shroudChannelFallback1 = "PARTY",
    shroudChannelFallback2 = "INSTANCE_CHAT",
    shroudMessage = "%time",
    shroudInterval = false,
    shroudStartMsg = "%time",
    shroudEndMsg = "%time",

    -- Tricks of the Trade Module Defaults
    tricksEnabled = false,
    tricksUseMouseover = false,
    tricksUseFocus = false,
    tricksLogic = "TANK",
    tricksCustomName = "",
    tricksDelveCompanion = true,
    tricksMute = false,

    -- Global Poison Tracker Settings
    poisonOnlyCombat = false,
    poisonOnlyInstances = false,

    -- Lethal Poison Configuration
    poisonLethalEnabled = true,
    poisonLethalEnableText = true,
    poisonLethalCustomText = ns.L.LethalPoisonMissing,
    poisonLethalTextColor = {r = 1, g = 0.2, b = 0.2},
    poisonLethalTextAlpha = 1,
    poisonLethalTextX = -5,
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

    -- Non-Lethal Poison Configuration
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

-- [[ Core Utility Functions ]] ------------------------------------------------
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
