local addonName, ns = ...

-- ============================================================================
-- [[ NIGHTVEIL — DEFAULT SETTINGS ]] -----------------------------------------
-- ============================================================================
ns.Defaults = {

    -- ========================================================================
    -- [[ SHARED MODULES ]] ---------------------------------------------------
    -- ========================================================================

    -- [[ Highlight Options ]] ------------------------------------------------
    highlightCombat              = 0,
    highlightInstance            = 0,
    highlightHiddenState         = 2,
    highlightStealth             = 2,
    highlightShroud              = 2,
    highlightCamouflage          = 2,
    highlightProwl               = 2,
    highlightInvisibility        = 2,
    highlightShadowmeld          = 2,
    highlightShadowDance         = 2,
    highlightSubterfuge          = 2,

    -- ========================================================================
    -- [[ GLOBAL MODULES ]] ---------------------------------------------------
    -- ========================================================================

    -- [[ Hidden State Module ]] ----------------------------------------------
    -- Global Settings
    hiddenStateEnabled           = true,
    hiddenStateOnlyInstances     = false,
    hiddenStateDisableInDungeons = false,
    hiddenStateDisableInRaids    = false,
    hiddenStateEnableText        = true,
    hiddenStateCustomText        = ns.L and ns.L.HiddenStateActiveText or "HIDDEN",
    hiddenStateTextColor         = {r = 0.420, g = 0.518, b = 0.647},
    hiddenStateTextAlpha         = 1,
    hiddenStateTextX             = 0,
    hiddenStateTextY             = 185,
    hiddenStateTextSize          = 28,
    hiddenStateEnableIcon        = true,
    hiddenStateIconTexture       = "Interface\\Icons\\Ability_Stealth",
    hiddenStateIconSize          = 36,
    hiddenStateIconAlpha         = 1,
    hiddenStateIconAnchorToText  = true,
    hiddenStateIconAnchorPoint   = "LEFT",
    hiddenStateIconX             = -5,
    hiddenStateIconY             = 0,
    hiddenStateEnableScreenColor = true,
    hiddenStateScreenColor       = {r = 0.420, g = 0.518, b = 0.647},
    hiddenStateScreenAlpha       = 0.1,
    hiddenStateScreenStrata      = "BACKGROUND", -- Drawing Layer
    hiddenStateEnableVignette    = true,
    hiddenStateVignetteSize      = 250,
    hiddenStateVignetteAlpha     = 0.6,
    hiddenStateVignetteStrata    = "BACKGROUND", -- Drawing Layer
    hiddenStateEnableSound       = true,
    hiddenStateSoundKit          = (SOUNDKIT and SOUNDKIT.RAID_WARNING) or 8959,

    -- Rogue
    hiddenStateRogueUseClassAura      = false,
    hiddenStateRogueCustomText        = ns.L and ns.L.StealthActiveText or "STEALTHED",
    hiddenStateRogueVanishText        = ns.L and ns.L.StealthActiveText or "STEALTHED",
    hiddenStateRogueEnableIconStealth = true,
    hiddenStateRogueEnableIconVanish  = true,
    hiddenStateRogueStealthIcon       = "Interface\\Icons\\Ability_Stealth",
    hiddenStateRogueVanishIcon        = "Interface\\Icons\\Ability_Vanish",
    hiddenStateRogueTextColor         = {r = 0.420, g = 0.518, b = 0.647},
    hiddenStateRogueScreenColor       = {r = 0.420, g = 0.518, b = 0.647},

    -- Hunter
    hiddenStateHunterUseClassAura         = false,
    hiddenStateHunterCustomText           = ns.L and ns.L.CamouflageActiveText or "CAMOUFLAGED",
    hiddenStateHunterEnableIconCamouflage = true,
    hiddenStateHunterCamouflageIcon       = "Interface\\Icons\\Ability_Hunter_Camouflage",
    hiddenStateHunterTextColor             = {r = 0.478, g = 0.878, b = 0.267},
    hiddenStateHunterScreenColor           = {r = 0.478, g = 0.878, b = 0.267},

    -- Druid
    hiddenStateDruidUseClassAura      = false,
    hiddenStateDruidCustomText        = ns.L and ns.L.ProwlActiveText or "PROWLED",
    hiddenStateDruidEnableIconProwl   = true,
    hiddenStateDruidProwlIcon          = "Interface\\Icons\\Ability_Druid_Prowl",
    hiddenStateDruidTextColor         = {r = 0.055, g = 0.027, b = 0.749},
    hiddenStateDruidScreenColor       = {r = 0.055, g = 0.027, b = 0.749},

    -- Mage
    hiddenStateMageUseClassAura       = false,
    hiddenStateMageCustomText         = ns.L and ns.L.InvisibilityActiveText or "INVISIBILITY",
    hiddenStateMageEnableIconInvis    = true,
    hiddenStateMageEnableIconGreater  = true,
    hiddenStateMageEnableIconMass     = true,
    hiddenStateMageInvisIcon          = "Interface\\Icons\\Ability_Mage_Invisibility",
    hiddenStateMageGreaterInvisIcon   = "Interface\\Icons\\Ability_Mage_GreaterInvisibility",
    hiddenStateMageMassInvisIcon      = "Interface\\Icons\\Ability_Mage_MassInvisibility",
    hiddenStateMageTextColor          = {r = 0.620, g = 1.0, b = 1.0},
    hiddenStateMageScreenColor        = {r = 0.620, g = 1.0, b = 1.0},

    -- Mage Specific Aura Defaults
    hiddenStateAuraGreaterInvisibilityTextColor   = {r = 0.635, g = 0.725, b = 0.976},
    hiddenStateAuraGreaterInvisibilityScreenColor = {r = 0.635, g = 0.725, b = 0.976},
    hiddenStateAuraMassInvisibilityTextColor      = {r = 0.898, g = 0.722, b = 1.0},
    hiddenStateAuraMassInvisibilityScreenColor    = {r = 0.898, g = 0.722, b = 1.0},

    -- Shadowmeld
    hiddenStateShadowmeldUseClassAura = false,
    hiddenStateShadowmeldCustomText   = ns.L and ns.L.HiddenStateActiveText or "HIDDEN",
    hiddenStateShadowmeldEnableIcon   = true,
    hiddenStateShadowmeldIcon         = "Interface\\Icons\\Ability_Ambush",
    hiddenStateShadowmeldTextColor    = {r = 0.427, g = 0.251, b = 0.616},
    hiddenStateShadowmeldScreenColor  = {r = 0.427, g = 0.251, b = 0.616},

    -- ========================================================================
    -- [[ CLASS MODULES — ROGUE ]] --------------------------------------------
    -- ========================================================================

    -- [[ Rogue: Poison Tracker ]] --------------------------------------------
    -- Lethal Section
    poisonLethalEnabled          = true,
    poisonLethalOnlyCombat       = false,
    poisonLethalOnlyInstances    = false,
    poisonLethalDisableInDungeons = false,
    poisonLethalDisableInRaids   = false,
    poisonLethalEnableText       = true,
    poisonLethalCustomText       = ns.L and ns.L.LethalPoisonMissing or "LETHAL POISON MISSING",
    poisonLethalTextColor        = {r = 1, g = 0.2, b = 0.2},
    poisonLethalTextAlpha        = 1,
    poisonLethalTextX            = -5,
    poisonLethalTextY            = 300,
    poisonLethalTextSize         = 28,
    poisonLethalEnableIcon       = true,
    poisonLethalIconSpellId      = 315584,
    poisonLethalIconTexture      = "Interface\\Icons\\Ability_Poisons",
    poisonLethalIconSize         = 36,
    poisonLethalIconAlpha        = 1,
    poisonLethalIconAnchorToText = true,
    poisonLethalIconAnchorPoint  = "LEFT",
    poisonLethalIconX            = -5,
    poisonLethalIconY            = 0,
    poisonLethalEnableSound      = true,
    poisonLethalSoundKit         = (SOUNDKIT and SOUNDKIT.RAID_WARNING) or 8959,

    -- Non-Lethal Section
    poisonNonLethalEnabled          = true,
    poisonNonLethalOnlyCombat       = false,
    poisonNonLethalOnlyInstances    = false,
    poisonNonLethalDisableInDungeons = false,
    poisonNonLethalDisableInRaids   = false,
    poisonNonLethalEnableText       = true,
    poisonNonLethalCustomText       = ns.L and ns.L.NonLethalPoisonMissing or "NON-LETHAL POISON MISSING",
    poisonNonLethalTextColor        = {r = 1, g = 0.6, b = 0.2},
    poisonNonLethalTextAlpha        = 1,
    poisonNonLethalTextX            = 0,
    poisonNonLethalTextY            = 260,
    poisonNonLethalTextSize         = 28,
    poisonNonLethalEnableIcon       = true,
    poisonNonLethalIconSpellId      = 3408,
    poisonNonLethalIconTexture      = "Interface\\Icons\\Ability_PoisonSting",
    poisonNonLethalIconSize         = 36,
    poisonNonLethalIconAlpha        = 1,
    poisonNonLethalIconAnchorToText = true,
    poisonNonLethalIconAnchorPoint  = "LEFT",
    poisonNonLethalIconX            = -5,
    poisonNonLethalIconY            = 0,
    poisonNonLethalEnableSound      = true,
    poisonNonLethalSoundKit         = (SOUNDKIT and SOUNDKIT.RAID_WARNING) or 8959,

    -- [[ Rogue: Shroud of Concealment ]] -------------------------------------
    shroudCountdown         = false,
    shroudOnlyInstances     = true,
    shroudDisableInDungeons = false,
    shroudDisableInRaids    = false,
    shroudMuteErrors        = false,
    shroudChannel           = "SAY",
    shroudChannelFallback1  = "NONE",
    shroudChannelFallback2  = "NONE",
    shroudMessage           = "%time",
    shroudInterval          = false,
    shroudStartMsg          = "%time",
    shroudEndMsg            = "%time",

    -- [[ Rogue: Tricks of the Trade ]] ---------------------------------------
    tricksEnabled          = false,
    tricksUseMouseover     = false,
    tricksUseFocus         = false,
    tricksLogic            = "TANK",
    tricksCustomName       = "",
    tricksDelveCompanion   = true,
    tricksMute             = false,

    -- ========================================================================
    -- [[ CLASS MODULES — HUNTER ]] -------------------------------------------
    -- ========================================================================

    -- [[ Hunter: Misdirection ]] ----------------------------------------------
    misdirEnabled          = false,
    misdirUseMouseover     = false,
    misdirUseFocus         = false,
    misdirLogic            = "PET",
    misdirCustomName       = "",
    misdirDelveCompanion   = true,
    misdirMute             = false,

    -- ========================================================================
    -- [[ CLASS MODULES — DRUID ]] --------------------------------------------
    -- ========================================================================

}

-- [[ CORE UTILITY FUNCTIONS ]] -----------------------------------------------

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
