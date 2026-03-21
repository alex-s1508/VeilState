local addonName, ns = ...

-- ============================================================================
-- [[ NIGHTVEIL — DEFAULT SETTINGS ]] -----------------------------------------
-- ============================================================================
ns.Defaults = {

    -- ========================================================================
    -- [[ 3. SHARED MODULES (ALL CLASSES) ]] -----------------------------------
    -- ========================================================================

    -- [[ Highlight Options ]] ------------------------------------------------
    highlightCombat              = 0,
    highlightInstance            = 0,
    highlightStealthState        = 2,
    highlightStealth             = 2,
    highlightShroud              = 2,
    highlightCamouflage          = 2,
    highlightProwl               = 2,

    -- [[ Global Stealth Detection ]] -----------------------------------------
    useStateDetection            = false,

    -- [[ Stealth State Module ]] ---------------------------------------------
    stealthStateEnabled          = true,
    stealthStateEnableText       = false,
    stealthStateCustomText       = ns.L and ns.L.StealthStateActiveText or "STEALTH STATE",
    stealthStateTextColor        = {r = 0.420, g = 0.518, b = 0.647},
    stealthStateTextAlpha        = 1,
    stealthStateTextX            = 0,
    stealthStateTextY            = 185,
    stealthStateTextSize         = 28,
    stealthStateEnableIcon       = false,
    stealthStateIconTexture      = "Interface\\Icons\\Ability_Stealth",
    stealthStateIconSize         = 36,
    stealthStateIconAlpha        = 1,
    stealthStateIconAnchorToText = true,
    stealthStateIconAnchorPoint  = "LEFT",
    stealthStateIconX            = -5,
    stealthStateIconY            = 0,
    stealthStateEnableScreenColor = false,
    stealthStateScreenColor      = {r = 0.420, g = 0.518, b = 0.647},
    stealthStateScreenAlpha      = 0.1,
    stealthStateScreenStrata     = "BACKGROUND",
    stealthStateEnableVignette   = true,
    stealthStateVignetteSize     = 250,
    stealthStateVignetteAlpha    = 0.6,
    stealthStateVignetteStrata   = "BACKGROUND",
    stealthStateOnlyInstances    = false,
    stealthStateDisableInDungeons = false,
    stealthStateDisableInRaids    = false,
    stealthStateEnableSound      = true,
    stealthStateSoundKit         = (SOUNDKIT and SOUNDKIT.RAID_WARNING) or 8959,

    -- ========================================================================
    -- [[ 4. CLASS MODULES — ROGUE ]] -----------------------------------------
    -- ========================================================================

    -- [[ Rogue: Stealth Module ]] --------------------------------------------
    stealthEnabled            = true,
    stealthOnlyInstances      = false,
    stealthDisableInDungeons  = false,
    stealthDisableInRaids     = false,
    stealthEnableText         = false,
    stealthCustomText         = ns.L and ns.L.StealthActiveText or "STEALTHED",
    stealthTextColor          = {r = 0.420, g = 0.518, b = 0.647},
    stealthTextAlpha          = 1,
    stealthTextX              = 0,
    stealthTextY              = 185,
    stealthTextSize           = 32,
    stealthEnableIcon         = false,
    stealthIconSize           = 64,
    stealthIconAlpha          = 1,
    stealthIconAnchorToText   = false,
    stealthIconAnchorPoint    = "LEFT",
    stealthIconX              = 0,
    stealthIconY              = 0,
    stealthEnableScreenColor  = false,
    stealthScreenColor        = {r = 0.420, g = 0.518, b = 0.647},
    stealthScreenAlpha        = 0.1,
    stealthScreenStrata       = "BACKGROUND",
    stealthEnableVignette     = true,
    stealthVignetteSize       = 250,
    stealthVignetteAlpha      = 0.6,
    stealthVignetteStrata     = "BACKGROUND",

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
    shroudChannelFallback1  = "PARTY",
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
    -- [[ 5. CLASS MODULES — HUNTER ]] ----------------------------------------
    -- ========================================================================

    -- [[ Hunter: Camouflage Module ]] -----------------------------------------
    camouflageEnabled            = true,
    camouflageOnlyInstances      = false,
    camouflageDisableInDungeons  = false,
    camouflageDisableInRaids     = false,
    camouflageEnableText         = false,
    camouflageCustomText         = ns.L and ns.L.CamouflageActiveText or "CAMOUFLAGED",
    camouflageTextColor          = {r = 0.478, g = 0.878, b = 0.267},
    camouflageTextAlpha          = 1,
    camouflageTextX              = 0,
    camouflageTextY              = 185,
    camouflageTextSize           = 32,
    camouflageEnableIcon         = false,
    camouflageIconSize           = 64,
    camouflageIconAlpha          = 1,
    camouflageIconAnchorToText   = false,
    camouflageIconAnchorPoint    = "LEFT",
    camouflageIconX              = 0,
    camouflageIconY              = 0,
    camouflageEnableScreenColor  = false,
    camouflageScreenColor        = {r = 0.478, g = 0.878, b = 0.267},
    camouflageScreenAlpha        = 0.1,
    camouflageScreenStrata       = "BACKGROUND",
    camouflageEnableVignette     = true,
    camouflageVignetteSize       = 250,
    camouflageVignetteAlpha      = 0.6,
    camouflageVignetteStrata     = "BACKGROUND",

    -- [[ Hunter: Misdirection ]] ----------------------------------------------
    misdirEnabled          = false,
    misdirUseMouseover     = false,
    misdirUseFocus         = false,
    misdirLogic            = "PET",
    misdirCustomName       = "",
    misdirDelveCompanion   = true,
    misdirMute             = false,

    -- ========================================================================
    -- [[ 6. CLASS MODULES — DRUID ]] -----------------------------------------
    -- ========================================================================

    -- [[ Druid: Prowl Module ]] -----------------------------------------------
    prowlEnabled            = true,
    prowlOnlyInstances      = false,
    prowlDisableInDungeons  = false,
    prowlDisableInRaids     = false,
    prowlEnableText         = false,
    prowlCustomText         = ns.L and ns.L.ProwlActiveText or "PROWLED",
    prowlTextColor          = {r = 0.055, g = 0.027, b = 0.749},
    prowlTextAlpha          = 1,
    prowlTextX              = 0,
    prowlTextY              = 185,
    prowlTextSize           = 32,
    prowlEnableIcon         = false,
    prowlIconSize           = 64,
    prowlIconAlpha          = 1,
    prowlIconAnchorToText   = false,
    prowlIconAnchorPoint    = "LEFT",
    prowlIconX              = 0,
    prowlIconY              = 0,
    prowlEnableScreenColor  = false,
    prowlScreenColor        = {r = 0.055, g = 0.027, b = 0.749},
    prowlScreenAlpha        = 0.1,
    prowlScreenStrata       = "BACKGROUND",
    prowlEnableVignette     = true,
    prowlVignetteSize       = 250,
    prowlVignetteAlpha      = 0.6,
    prowlVignetteStrata     = "BACKGROUND",

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
