local addonName, ns = ...
local locale = GetLocale()
if locale ~= "enUS" and locale ~= "enGB" then return end

ns.L = {
    -- ========================================================================
    -- [[ SYSTEM / GENERAL UI ]] -----------------------------------------
    -- ========================================================================
    Enable                  = "Enable",
    Management              = "Management",
    ReleaseNotes            = "Release Notes",
    WelcomeMessage          = "%s |cffffcc00v%s|r loaded. Type |cffffcc00/veil|r for settings.",
    UpdateMessage           = "%s updated to |cffffcc00v%s|r! Type |cffffcc00/veil|r to see what's new.",
    FloatingText            = "Floating Text",

    -- ========================================================================
    -- [[ INTERFACE — Elements & Styles ]] -------------------------------
    -- ========================================================================
    Color                   = "Color",
    Size                    = "Size",
    Opacity                 = "Opacity",
    Thickness               = "Thickness",
    Style                   = "Style",
    Layer                   = "Layer",
    LayerBackground         = "Background",
    LayerLow                = "Low",
    LayerMedium             = "Medium",
    LayerHigh               = "High",
    LayerDialog             = "Dialog",
    LayerFullscreen         = "Fullscreen",
    ScreenColor             = "Screen Color",
    Vignette                = "Vignette",

    -- ========================================================================
    -- [[ INTERFACE — Positioning & Anchors ]] ---------------------------
    -- ========================================================================
    AnchorPoint             = "Anchor Point",
    AnchorToText            = "Anchor to Text",
    OffsetX                 = "Offset X",
    OffsetY                 = "Offset Y",
    AnchorTopLeft           = "Top Left",
    AnchorTop               = "Top",
    AnchorTopRight          = "Top Right",
    AnchorLeft              = "Left",
    AnchorCenter            = "Center",
    AnchorRight             = "Right",
    AnchorBottomLeft        = "Bottom Left",
    AnchorBottom            = "Bottom",
    AnchorBottomRight       = "Bottom Right",

    -- ========================================================================
    -- [[ INTERFACE — Icons & Multimedia ]] ------------------------------
    -- ========================================================================
    IndicatorIcon           = "Indicator Icon",
    IconTexture             = "Icon Texture",
    Sound                   = "Sound",
    SoundKitId              = "SoundKit ID",
    TestSound               = "Test Sound",

    -- ========================================================================
    -- [[ INTERFACE — Logic & Filters ]] ---------------------------------
    -- ========================================================================
    OnlyInInstances         = "Only in instances",
    OnlyInCombat            = "Only in combat",
    DisableInDungeons       = "Disable in Dungeons",
    DisableInRaids          = "Disable in Raids",
    InstanceFilters         = "Instance Filters",

    -- ========================================================================
    -- [[ INTERFACE — Message Customization ]] ---------------------------
    -- ========================================================================
    CustomText              = "Custom Text",
    Messages                = "Messages",

    -- ========================================================================
    -- [[ SHARED MODULES — Highlights ]] ---------------------------------
    -- ========================================================================
    Highlights              = "Highlights",
    Highlight               = "Highlight",
    HighlightGlobalDesc     = "|cffffa500Configures character highlighting dynamically during gameplay events.|r",
    HighlightCombat         = "In Combat",
    HighlightCombatDesc     = "Highlight style when entering combat.",
    HighlightInstance       = "In Instance",
    HighlightInstanceDesc   = "Highlight style when inside a dungeon or raid.",
    HighlightHidden         = "In Stealth State",
    HighlightHiddenDesc     = "Highlight style when in a custom stealth state.",
    HighlightStealth        = "In Stealth",
    HighlightStealthDesc    = "Highlight style when stealthed.",
    HighlightShroud         = "In Shroud of Concealment",
    HighlightShroudDesc     = "Highlight style when inside Shroud of Concealment.",
    HighlightCamouflage     = "In Camouflage",
    HighlightCamouflageDesc = "Highlight style when camouflaged.",
    HighlightProwl          = "In Prowl",
    HighlightProwlDesc      = "Highlight style when prowling.",
    HighlightOptNone        = "None",
    HighlightOptCircle      = "Circle",
    HighlightOptOutline     = "Outline",
    HighlightOptIcon        = "Icon",
    HighlightOptCircleOutline = "Circle and Outline",
    HighlightOptCircleIcon  = "Circle and Icon",
    HighlightOptOutlineIcon = "Outline and Icon",
    HighlightOptCircleOutlineIcon = "Circle, Outline and Icon",

    -- ========================================================================
    -- [[ SHARED MODULES — Stealth State ]] ------------------------------
    -- ========================================================================
    StealthStateName        = "Stealth State",
    StealthStateActiveText  = "STEALTH STATE",
    EnableOnStealthState    = "Enable on Stealth State",

    -- ========================================================================
    -- [[ SHARED MODULES — Macro System ]] -------------------------------
    -- ========================================================================
    MacroTargetHeader       = "Target",
    MacroTargetSelector     = "Target Selector",
    MacroAutoUpdateWarning  = "|cffffa500Nightveil automatically updates this macro.|r",
    MacroDelveCompanion     = "Delve Companion",
    MacroCustomName         = "Custom Target",
    MacroCustomSet          = "Custom target set: %s",
    MacroGroupMembers       = "Group members:",
    MacroInvalidIndex       = "Invalid group index.",
    MacroNoSelf             = "You cannot target yourself.",
    MacroBtnEnable          = "Activate & Sync Macro",
    MacroBtnDisable         = "Deactivate & Remove Macro",
    Mouseover               = "Mouseover",
    Focus                   = "Focus",
    Tank                    = "Tank",
    TargetTarget            = "Target's Target",
    TargetingModeSet        = "Targeting mode set: %s",
    Pet                     = "Pet",
    MuteChanges             = "Mute status changes",

    -- ========================================================================
    -- [[ CLASS MODULES — ROGUE ]] ---------------------------------------
    -- ========================================================================

    -- [[ Stealth ]] -------------------------------------------
    Stealth                 = "Stealth",
    EnableOnStealth         = "Enable on Stealth",
    StealthUseState         = "Use State Detection",
    StealthActiveText       = "STEALTHED",

    -- [[ Poison Tracker ]] ------------------------------------
    PoisonTracker           = "Poison Tracker",
    LethalPoisons           = "Lethal Poison",
    NonLethalPoisons        = "Non-Lethal Poison",
    LethalPoisonMissing     = "LETHAL POISON MISSING",
    NonLethalPoisonMissing  = "NON-LETHAL POISON MISSING",

    -- [[ Tricks of the Trade ]] -------------------------------
    TricksOfTheTrade        = "Tricks of the Trade",
    TricksTargetLog         = "Tricks Target",
    TricksNormal            = "Normal",
    TricksCustom            = "Custom",
    TricksMsgEnabled        = "Tricks system activated and macro synchronized.",
    TricksMsgDisabled       = "Tricks system deactivated and macro removed.",
    TricksAlreadyEnabled    = "Tricks of the Trade system is already enabled.",
    TricksAlreadyDisabled   = "Tricks of the Trade system is already disabled.",

    -- [[ Shroud of Concealment ]] -----------------------------
    ShroudOfConcealment     = "Shroud of Concealment",
    EnableShroudCountdown   = "Enable chat countdown",
    ShroudMuteErrors        = "Mute errors",
    ChatChannel             = "Chat Channel",
    ShroudMessage           = "Countdown Message",
    ShroudOnStart           = "Start Message",
    ShroudOnEnd             = "End Message",
    ShroudInterval          = "Interval Mode",
    TestShroud              = "Test Shroud",
    ShroudAlreadyActive     = "Shroud countdown is already active.",
    ShroudDisabled          = "Shroud countdown is disabled in settings.",

    -- ========================================================================
    -- [[ CLASS MODULES — HUNTER ]] --------------------------------------
    -- ========================================================================

    -- [[ Camouflage ]] ----------------------------------------
    Camouflage              = "Camouflage",
    EnableOnCamouflage      = "Enable on Camouflage",
    CamouflageActiveText    = "CAMOUFLAGED",

    -- [[ Misdirection ]] --------------------------------------
    Misdirection            = "Misdirection",
    MisdirTargetLog         = "Misdirection Target",
    MisdirectionNotLearned  = "You have not learned Misdirection yet.",
    MisdirectionMsgEnabled  = "Misdirection system activated and macro synchronized.",
    MisdirectionMsgDisabled = "Misdirection system deactivated and macro removed.",
    MisdirectionAlreadyEnabled = "Misdirection system is already enabled.",
    MisdirectionAlreadyDisabled = "Misdirection system is already disabled.",

    -- ========================================================================
    -- [[ CLASS MODULES — DRUID ]] ---------------------------------------
    -- ========================================================================

    -- [[ Prowl ]] ---------------------------------------------
    Prowl                   = "Prowl",
    EnableOnProwl           = "Enable on Prowl",
    ProwlActiveText         = "PROWLED",

    -- ========================================================================
    -- [[ PROFILE MANAGEMENT ]] ------------------------------------------
    -- ========================================================================
    Profiles                = "Profiles",
    ActiveProfile           = "Active Profile",
    ActiveProfileDesc       = "Select which profile to use for this character.",
    CreateProfile           = "Create Profile",
    CreateProfileDesc       = "Create a new profile with default settings.",
    DuplicateProfile        = "Duplicate Profile",
    DuplicateProfileDesc    = "Create a copy of the current profile.",
    DeleteProfile           = "Delete Profile",
    DeleteProfileDesc       = "Remove the selected profile (cannot delete Default).",
    ExportProfile           = "Export Profile",
    ExportProfileDesc       = "Generate a string to share this profile with others.",
    ImportProfile           = "Import Profile",
    ImportProfileDesc       = "Import a profile from a shared string.",
    DefaultProfileLabel     = "Default",
    CreateProfilePrompt     = "Enter a name for the new profile:",
    DuplicateProfilePrompt  = "Enter a name for the duplicated profile:",
    ExportProfilePrompt     = "Copy this export string (Ctrl+C):\n\nProfile: |cff00ff00%s|r",
    ImportProfilePrompt     = "Paste the profile export string below:",
    ImportProfileNamePrompt = "Enter a name for the imported profile:",
    DeleteProfileConfirm    = "Delete profile:\n\n|cffff0000%s|r\n\nThis cannot be undone.",
    FactoryResetBtn         = "Factory Reset",
    FactoryResetBtnDesc     = "Deletes all addon data and macros, restoring to a clean installation. UI will reload.",
    FactoryResetConfirm     = "|cffff0000WARNING:|r This will delete |cffff0000ALL|r your settings and profiles.\n\nThis action is |cffff0000IRREVERSIBLE|r. Are you sure?",
    ErrorProfileDeleteRestricted = "You cannot delete the Default profile.",
    Import                  = "Import",
    Share                   = "Share",
    Next                    = "Next",

    -- ========================================================================
    -- [[ CHAT CHANNELS ]] -----------------------------------------------
    -- ========================================================================
    ChannelSay              = "Say",
    ChannelParty            = "Party",
    ChannelRaid             = "Raid",
    ChannelInstance         = "Instance",
    ChannelYell             = "Yell",

    -- ========================================================================
    -- [[ SYSTEM NOTIFICATIONS & ERRORS ]] -------------------------------
    -- ========================================================================
    ErrorHardReset          = "|cffff2020Old or incompatible version detected.|r\n\nSettings will be |cffffcc00reset|r to ensure stability.",
    WarningOutdatedConfig   = "|cffffcc00Newer configuration detected!|r\n\nIt is recommended to |cffbe89e9update|r the addon or reset the profile.",
    ErrorChannelNoValid     = "|cffff2020No valid chat channel available.|r",
    ErrorChannelAntiSpam    = "|cffff2020Blizzard anti-spam restrictions prevent using channel|r |cffffcc00%s|r |cffff2020outside instances.|r",
    ErrorChannelNoGroup     = "|cffff2020You are not in a group. Channel|r |cffffcc00%s|r |cffff2020unavailable.|r",
    ErrorChannelNoRaid      = "|cffff2020You are not in a raid. Channel|r |cffffcc00%s|r |cffff2020unavailable.|r",
    ErrorChannelInvalidGroup = "|cffff2020You are in an invalid group. Channel|r |cffffcc00%s|r |cffff2020unavailable.|r",
    ErrorChannelInstanceOnly = "|cffff2020Channel|r |cffffcc00%s|r |cffff2020unavailable outside instances.|r",
    ErrorNotRogue           = "You are not a Rogue. This command is Rogue-only.",
    ErrorNotHunter          = "You are not a Hunter. This command is Hunter-only.",
    ErrorTricksNotLearned   = "You haven't learned Tricks of the Trade yet.",
    ErrorMisdirNotLearned   = "You have not learned Misdirection yet.",
    ErrorShroudOnlyInstances = "|cffff2020Shroud messages only work inside instances.|r",
    ErrorCombatBlocked      = "Cannot open settings during combat.",
    ErrorMacroLimitReached  = "Macro limit reached.",
    ErrorMacroCombatLock    = "This action cannot be used in combat.",
    ErrorUnknownCmd         = "Unknown command: |cffffcc00%s|r. Use |cffffcc00/veil help|r.",
    ErrorUnknownSubCmd      = "Unknown sub-command: |cffffcc00%s|r. Use |cffffcc00/veil help|r.",
    DebugCombatLock         = "This action cannot be used in combat.",

    -- ========================================================================
    -- [[ COMMANDS HELP ]] -----------------------------------------------
    -- ========================================================================
    HelpSettings            = "Open settings",
    HelpTricks              = "Tricks status",
    HelpMisdir              = "Misdirection status",
    HelpMisdirPet           = "Pet mode",
    HelpInfo                = "Diagnostic info",
    HelpShroudTest          = "Test shroud countdown",
    HelpDebugToggle         = "Toggle debug mode",
    HelpForceRefresh        = "Force macro refresh",
    HelpModeNormal          = "Normal mode",
    HelpModeTank            = "Tank mode",
    HelpModeTT              = "Target-of-Target mode",
    HelpModeCustom          = "Custom mode",
    HelpModeList            = "List and set by index",
    HelpModeSet             = "Set by name",

    -- ========================================================================
    -- [[ DEBUG & DIAGNOSTICS ]] -----------------------------------------
    -- ========================================================================
    DebugModeActivated      = "Debug Mode ACTIVATED",
    DebugModeDeactivated    = "Debug Mode DEACTIVATED",
    DebugModeRequired       = "This command requires Debug Mode. Type |cffffcc00/veil debug|r to enable.",
    DebugCommands           = "[Debug Commands]",
    DebugHeader             = "%s Diagnostics:",
    DebugCombat             = "- Combat: %s",
    DebugStealth            = "- Stealth/Vanish: %s",
    DebugInstance           = "- Instance: %s (Type: %s)",
    DebugGroup              = "- Group: %s (Raid: %s, Total: %d)",
    DebugComposition        = "- Composition: %d Players, %d Pets, %d Others",
    DebugTricksKnown        = "- Tricks Known: %s",
    DebugTricksTarget       = "- Tricks Target: %s (%s)",
    DebugTricksMacro        = "- Tricks Macro: %s",
    DebugInvalidGroup       = "- Invalid Group: %s",
    DebugPlayer             = "PLAYER",
    DebugPet                = "PET",
    DebugOther              = "OTHER",
    DebugYes                = "YES",
    DebugNo                 = "NO",
    DebugNone               = "none",
    DebugUnknown            = "Unknown",
    DebugFallback1          = "- Fallback 1: %s (Usable: %s)",
    DebugFallback2          = "- Fallback 2: %s (Usable: %s)",
    DebugShroudUsage        = "Usage: |cffffcc00/veil shroud [1-20]|r",
    DebugTricksForcing      = "Forcing Tricks update...",
    DebugMisdirForcing      = "Forcing Misdirection update...",
    DebugMacroSuccess       = "Macro refresh SUCCESS.",
    DebugMacroUpdated       = "Macro updated: %s",
    DebugMacroStatus        = "Macro: %s",
    DebugMacroEdited        = "Macro content modified and synchronized.",

    -- ========================================================================
    -- [[ NPC / GAME TERMS ]] --------------------------------------------
    -- ========================================================================
    BrannBronzebeard        = "Brann Bronzebeard",
    ValeeraSanguinar        = "Valeera Sanguinar",

}
