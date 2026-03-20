local addonName, ns = ...
local locale = GetLocale()
if locale ~= "enUS" and locale ~= "enGB" then return end

ns.L = {
    -- ========================================================================
    -- [[ SYSTEM / GENERAL UI ]] ----------------------------------------------
    -- ========================================================================
    Enable              = "Enable",
    EnableDesc          = "Enables or disables this feature.",
    Management          = "Management",
    ReleaseNotes        = "Release Notes",

    -- ========================================================================
    -- [[ INTERFACE — Elements & Styles ]] ------------------------------------
    -- ========================================================================
    Color               = "Color",
    ColorDesc           = "Sets the color used by this element.",
    Size                = "Size",
    SizeDesc            = "Changes the size of the element.",
    Opacity             = "Opacity",
    OpacityDesc         = "Changes the transparency.",
    Layer               = "Layer",
    LayerDesc           = "Drawing layer (higher appears above).",
    LayerBackground     = "Background",
    LayerLow            = "Low",
    LayerMedium         = "Medium",
    LayerHigh           = "High",
    LayerDialog         = "Dialog",
    LayerFullscreen     = "Fullscreen",
    Style               = "Style",
    StyleDesc           = "Selects the highlight style.",

    -- ========================================================================
    -- [[ INTERFACE — Positioning & Anchors ]] --------------------------------
    -- ========================================================================
    OffsetX             = "Offset X",
    OffsetXDesc         = "Moves the element horizontally.",
    OffsetY             = "Offset Y",
    OffsetYDesc         = "Moves the element vertically.",
    AnchorToText        = "Anchor to Text",
    AnchorToTextDesc    = "Anchors the icon to the text position.",
    AnchorPoint         = "Anchor Point",
    AnchorPointDesc     = "Side of the text used as anchor.",
    AnchorTopLeft       = "Top Left",
    AnchorTop           = "Top",
    AnchorTopRight      = "Top Right",
    AnchorLeft          = "Left",
    AnchorCenter        = "Center",
    AnchorRight         = "Right",
    AnchorBottomLeft    = "Bottom Left",
    AnchorBottom        = "Bottom",
    AnchorBottomRight   = "Bottom Right",

    -- ========================================================================
    -- [[ INTERFACE — Icons & Multimedia ]] -----------------------------------
    -- ========================================================================
    IndicatorIcon       = "Indicator Icon",
    EnableIconDesc      = "Shows an icon indicator.",
    IconTexture         = "Icon Texture",
    IconTextureDesc     = "Custom icon texture path.",
    Sound               = "Sound",
    SoundDesc           = "Plays a sound alert when activated.",
    SoundKitId          = "SoundKit ID",
    SoundKitIdDesc      = "SoundKit ID to play (number).",
    TestSound           = "Test Sound",
    TestSoundDesc       = "Plays the selected sound now.",

    -- ========================================================================
    -- [[ INTERFACE — Message Customization ]] --------------------------------
    -- ========================================================================
    CustomText          = "Custom Text",
    CustomTextDesc      = "Custom message text to display.",
    FloatingText        = "Floating Text",
    Messages            = "Messages",

    -- ========================================================================
    -- [[ INTERFACE — Logic Filters ]] ----------------------------------------
    -- ========================================================================
    OnlyInInstances     = "Only in instances",
    OnlyInInstancesDesc = "Only applies inside instances (Dungeons, Raids, Scenarios).",
    OnlyInCombat        = "Only in combat",
    OnlyInCombatDesc    = "Only shows warnings while you are in combat.",
    DisableInDungeons   = "Disable in Dungeons",
    DisableInDungeonsDesc = "Does not apply when inside a Dungeon instance.",
    DisableInRaids      = "Disable in Raids",
    DisableInRaidsDesc  = "Does not apply when inside a Raid instance.",
    InstanceFilters     = "Instance Filters",
    InstanceFiltersDesc = "Configure where this feature should be disabled.",

    -- ========================================================================
    -- [[ HIGHLIGHTS SYSTEM ]] ------------------------------------------------
    -- ========================================================================
    Highlight              = "Highlight",
    HighlightDesc          = "Highlights your character on the screen.",
    Highlights             = "Highlights",
    HighlightGlobalDesc    = "|cffffa500Configures the character highlighting dynamically during gameplay events.|r",
    HighlightOptNone              = "None",
    HighlightOptCircle            = "Circle",
    HighlightOptOutline           = "Outline",
    HighlightOptIcon              = "Icon",
    HighlightOptCircleOutline     = "Circle and Outline",
    HighlightOptCircleIcon        = "Circle and Icon",
    HighlightOptOutlineIcon       = "Outline and Icon",
    HighlightOptCircleOutlineIcon = "Circle, Outline and Icon",
    HighlightCombat     = "In Combat",
    HighlightCombatDesc = "Highlight to apply while in combat.",
    HighlightInstance   = "In Instance",
    HighlightInstanceDesc = "Highlight to apply while inside any instance (dungeon, raid, arena, etc).",
    HighlightHidden     = "In Stealth State",
    HighlightHiddenDesc = "Highlight to apply while hidden, stealthed, or invisible.",
    HighlightStealth         = "In Stealth",
    HighlightStealthDesc     = "Highlight to apply while stealthed.",
    HighlightShroud          = "In Shroud of Concealment",
    HighlightShroudDesc      = "Highlight to apply while Shroud of Concealment is active.",
    HighlightCamouflage      = "In Camouflage",
    HighlightCamouflageDesc  = "Highlight to apply while Camouflaged.",
    ClassExclusive           = "Class Exclusive",
    HighlightClass      = "These highlighting options dynamically reflect your class-specific configuration.",
    ScreenColor         = "Screen Color",
    ScreenColorDesc     = "Colors the screen while active.",
    Vignette            = "Vignette",
    VignetteDesc        = "Adds a vignette effect around the screen.",
    Thickness           = "Thickness",
    ThicknessDesc       = "Controls the vignette thickness.",

    -- ========================================================================
    -- [[ SHARED MODULES ]] ---------------------------------------------------
    -- ========================================================================
    -- [[ Stealth State Module ]] ---------------------------------------------
    StealthStateName        = "Stealth State",
    StealthStateDesc        = "Configure visuals for when you are in a Stealth State.",
    StealthStateActiveText  = "STEALTH STATE",
    EnableOnStealthState    = "Enable on Stealth State",
    EnableOnStealthStateDesc = "Shows visuals while any Stealth State is active (uses WoW state detection).",

    -- ========================================================================
    -- [[ CLASS MODULES — ROGUE ]] --------------------------------------------
    -- ========================================================================
    -- [[ Stealth Module ]] ---------------------------------------------------
    Stealth             = "Stealth",
    EnableOnStealth     = "Enable on Stealth",
    EnableOnStealthDesc = "Shows visuals while Stealth or Vanish is active.",
    StealthUseState     = "Use State Detection",
    StealthUseStateDesc = "Uses the global stealth state instead of specific auras. 'Aura' is more precise for class skills, while 'State' activates on any stealth-like effect.",
    DefaultMessage      = "STEALTHED",
    StealthActiveText   = "STEALTHED",

    -- [[ Poison Tracker ]] ---------------------------------------------------
    PoisonTracker          = "Poison Tracker",
    LethalPoisons          = "Lethal Poison",
    LethalPoisonsDesc      = "Shows warnings when your Lethal poison is missing.",
    NonLethalPoisons       = "Non-Lethal Poison",
    NonLethalPoisonsDesc   = "Shows warnings when your Non-Lethal poison is missing.",
    LethalPoisonMissing    = "LETHAL POISON MISSING",
    NonLethalPoisonMissing = "NON-LETHAL POISON MISSING",

    -- ========================================================================
    -- [[ MACRO SYSTEM (SHARED) ]] --------------------------------------------
    -- ========================================================================
    MacroTargetHeader       = "Target",
    MacroTargetSelector     = "Target Selector",
    MacroTargetSelectorDesc = "Defines the primary logic for automatic target selection.",
    MacroAutoUpdateWarning  = "|cffffa500Nightveil automatically updates this macro.|r",
    MacroMouseoverDesc      = "Enable mouseover targeting.\n\nNote: This has priority over other methods except the Delve Companion.",
    MacroFocusDesc          = "Enables automated targeting via focus.\n\nNote: This has priority over the target selector, but is ignored by mouseover or Delve Companion.",
    MacroMuteDesc           = "Hides chat notifications when the macro changes targets.",
    MacroDelveCompanion     = "Delve Companion",
    MacroDelveCompanionDesc = "Automatically targets companions like Brann Bronzebeard or Valeera Sanguinar inside Delves.\n\nNote: This takes exclusive priority inside Delves.",
    MacroCustomName         = "Custom Target",
    MacroCustomNameDesc     = "Enter the exact name of the player to target.",
    MacroCustomSet          = "Custom target set: %s",
    MacroGroupMembers       = "Group members:",
    MacroInvalidIndex       = "Invalid group index.",
    MacroNoSelf             = "You cannot target yourself.",
    MacroBtnEnable          = "Activate & Sync Macro",
    MacroBtnDisable         = "Deactivate & Remove Macro",
    MacroBtnDisableDesc     = "Disables the automated targeting and completely removes the macro.",
    Mouseover               = "Mouseover",
    Focus                   = "Focus",
    Tank                    = "Tank",
    TargetTarget            = "Target's Target",

    -- [[ Tricks of the Trade ]] ----------------------------------------------
    TricksOfTheTrade         = "Tricks of the Trade",
    TricksEnabledDesc        = "Enables automatic targeting for Tricks of the Trade using a macro.",
    TricksTargetLog          = "Tricks Target",
    TricksNormal             = "Normal",
    TricksCustom             = "Custom",
    TricksMsgEnabled         = "Tricks system activated and macro synchronized.",
    TricksMsgDisabled        = "Tricks system deactivated and macro removed.",
    TricksAlreadyEnabled     = "Tricks of the Trade system is already enabled.",
    TricksAlreadyDisabled    = "Tricks of the Trade system is already disabled.",
    TricksLogicSet           = "Targeting mode set: %s",

    -- [[ Shroud of Concealment ]] --------------------------------------------
    ShroudOfConcealment      = "Shroud of Concealment",
    EnableShroudCountdown    = "Enable chat countdown",
    EnableShroudCountdownDesc = "Sends Shroud countdown messages to chat.",
    ShroudOnlyInstancesDesc  = "Only sends Shroud messages inside instances.\n\nNote: some channels are blocked outside instances by Blizzard anti-spam.",
    ShroudMuteErrors         = "Mute errors",
    ShroudMuteErrorsDesc     = "Disables Shroud error messages in chat.",
    ChatChannel              = "Chat Channel",
    ChatChannelDesc          = "Primary chat channel used for Shroud messages.",
    ChatChannelFallbackDesc  = "Alternative channel used if the primary is unavailable.",
    ShroudMessage            = "Countdown Message",
    ShroudMessageDesc        = "Message template used during countdown.\n\n%time = remaining time.",
    ShroudOnStart            = "Start Message",
    ShroudOnStartDesc        = "Message sent when Shroud starts.",
    ShroudOnEnd              = "End Message",
    ShroudOnEndDesc          = "Message sent when Shroud ends (0s).",
    ShroudInterval           = "Interval Mode",
    ShroudIntervalDesc       = "Start, middle, and last 5s",
    TimeRemainingHint        = "%time = time remaining",
    TestShroud               = "Test Shroud",
    TestShroudDesc           = "Simulates a local 5-second countdown.\n\nNote: Messages appear only to you.",
    ShroudAlreadyActive      = "Shroud countdown is already active.",
    ShroudDisabled           = "Shroud countdown is disabled in settings.",
    ChannelSay               = "Say",
    ChannelParty             = "Party",
    ChannelRaid              = "Raid",
    ChannelInstance          = "Instance",
    ChannelYell              = "Yell",

    -- ========================================================================
    -- [[ PROFILE MANAGEMENT ]] -----------------------------------------------
    -- ========================================================================
    Profiles              = "Profiles",
    ActiveProfile         = "Active Profile",
    ActiveProfileDesc     = "Select which profile is active.",
    CreateProfile         = "Create Profile",
    CreateProfileDesc     = "Creates a new profile with default settings.",
    DuplicateProfile      = "Duplicate Profile",
    DuplicateProfileDesc  = "Copies the current profile to a new one.",
    DeleteProfile         = "Delete Profile",
    DeleteProfileDesc     = "Deletes the selected profile (cannot be undone).",
    ExportProfile         = "Export Profile",
    ExportProfileDesc     = "Generates a string to share this profile.",
    ImportProfile         = "Import Profile",
    ImportProfileDesc     = "Imports a profile from an exported string.",
    CreateProfilePrompt   = "Enter a name for the new profile:",
    DuplicateProfilePrompt = "Enter a name for the duplicated profile:",
    FactoryResetBtn       = "Factory Reset",
    FactoryResetBtnDesc   = "Deletes all addon data and macros, restoring to a clean installation. UI will reload.",
    FactoryResetConfirm   = "|cffff0000WARNING:|r This will delete |cffff0000ALL|r your Nightveil settings and profiles, and remove the macros created by the addon.\n\nThis action is |cffff0000IRREVERSIBLE|r.\n\nAre you sure you want to proceed?",
    DeleteProfileConfirm  = "Delete profile:\n\n|cffff0000%s|r\n\nThis cannot be undone.",
    ExportProfilePrompt   = "Copy this export string (Ctrl+C):\n\nProfile: |cff00ff00%s|r",
    ImportProfilePrompt   = "Paste the profile export string below:",
    ImportProfileNamePrompt = "Enter a name for the imported profile:",
    ErrorDeleteRestricted = "You cannot delete the Default profile.",
    DefaultProfileLabel   = "Default",
    Import              = "Import",
    Share               = "Share",

    -- ========================================================================
    -- [[ CLASS MODULES — HUNTER ]] --------------------------------------------
    -- ========================================================================
    -- [[ Camouflage Module ]] -------------------------------------------------
    Camouflage              = "Camouflage",
    EnableOnCamouflage      = "Enable on Camouflage",
    EnableOnCamouflageDesc  = "Shows visuals while Camouflage is active.",
    CamouflageActiveText    = "CAMOUFLAGED",

    -- [[ Misdirection ]] ------------------------------------------------------
    Misdirection                = "Misdirection",
    MisdirEnabledDesc           = "Enables automatic targeting for Misdirection using a macro.",
    MisdirTargetLog             = "Misdirection Target",
    MisdirectionNotLearned      = "You have not learned Misdirection yet.",
    MisdirectionMsgEnabled      = "Misdirection system activated and macro synchronized.",
    MisdirectionMsgDisabled     = "Misdirection system deactivated and macro removed.",
    MisdirectionAlreadyEnabled  = "Misdirection system is already enabled.",
    MisdirectionAlreadyDisabled = "Misdirection system is already disabled.",
    MisdirLogicSet              = "Targeting mode set: %s",
    MisdirNotLearned            = "You haven't learned Misdirection yet.",
    Pet                         = "Pet",

    -- ========================================================================
    -- [[ SYSTEM MESSAGES & WARNINGS ]] ---------------------------------------
    -- ========================================================================
    WarningNotRogue         = "You are not a Rogue. This command is Rogue-only.",
    WarningNotHunter        = "You are not a Hunter. This command is Hunter-only.",
    TricksNotLearned        = "You haven't learned Tricks of the Trade yet.",
    HardResetWarning        = "Old or incompatible version detected.\n\nSettings will be reset to ensure stability.",
    WarningOutdatedConfig   = "Newer configuration detected!\n\nThe profile you are using was created in a newer version of Nightveil.",
    WelcomeMessage          = "%s |cffffd100v%s|r loaded. Type |cffffd100/veil|r to open settings.",
    UpdateMessage           = "%s updated to |cffffd100v%s|r! Type |cffffd100/veil|r to see what's new.",
    ErrorNoValidChannel     = "|cffff2020No valid chat channel available.|r",
    ErrorBlizzardAntiSpam   = "|cffff2020Blizzard anti-spam restrictions prevent using channel|r |cffffcc00%s|r |cffff2020outside instances.|r",
    ErrorNotInGroup         = "|cffff2020You are not in a group. Channel|r |cffffcc00%s|r |cffff2020unavailable.|r",
    ErrorNotInRaid          = "|cffff2020You are not in a raid. Channel|r |cffffcc00%s|r |cffff2020unavailable.|r",
    ErrorFollowersDungeonGroup = "|cffff2020You are alone or in an invalid group. Channel|r |cffffcc00%s|r |cffff2020unavailable.|r",
    ErrorShroudOnlyInstances = "|cffff2020Shroud messages only work inside instances.|r",
    ErrorShroudInstanceOnly  = "|cffff2020You are not inside an instance. Channel|r |cffffcc00%s|r |cffff2020unavailable.|r",
    CombatBlocked         = "Cannot open settings during combat.",
    MacroLimitReached     = "Macro limit reached.",
    MuteChanges         = "Mute Changes",
    Next                = "Next",

    -- ========================================================================
    -- [[ COMMANDS HELP ]] ----------------------------------------------------
    -- ========================================================================
    HelpSettings          = "Settings",
    HelpTricks            = "Tricks target",
    HelpUTricks           = "Force macro refresh",
    HelpMisdir            = "Misdirection target",
    HelpUMisdir           = "Force macro refresh",
    HelpMisdirPet         = "Pet mode",
    HelpMisdirNormal      = "Normal mode",
    HelpMisdirTank        = "Tank mode",
    HelpMisdirTT          = "Target-of-Target mode",
    HelpMisdirCustom      = "Custom mode",
    HelpMisdirList        = "List and set by index",
    HelpMisdirSet         = "Set by name",
    HelpInfo              = "Diagnostic info",
    HelpShroudTest        = "Test shroud countdown",
    HelpDebugToggle       = "Toggle debug mode",
    HelpTricksList        = "List and set by index",
    HelpTricksNormal      = "Normal mode",
    HelpTricksTank        = "Tank mode",
    HelpTricksTT          = "Target-of-Target mode",
    HelpTricksSet         = "Set by name",
    HelpTricksCustom      = "Custom mode",
    ErrorUnknownCmd       = "Unknown command: |cffffd100%s|r. Use |cffffd100/veil help|r.",
    ErrorUnknownSubCmd    = "Unknown sub-command: |cffffd100%s|r. Use |cffffd100/veil help|r.",

    -- ========================================================================
    -- [[ DEBUG INFO ]] -------------------------------------------------------
    -- ========================================================================
    DebugModeActivated   = "Debug Mode ACTIVATED",
    DebugModeDeactivated = "Debug Mode DEACTIVATED",
    DebugModeRequired    = "This command requires Debug Mode. Type |cffffd100/veil debug|r to enable.",
    DebugCommands        = "[Debug Commands]",
    DebugHeader          = "%s Diagnostics:",
    DebugCombat          = " - Combat: %s",
    DebugStealth         = " - Stealth/Vanish: %s",
    DebugInstance        = " - Instance: %s (Type: %s)",
    DebugGroup           = " - Group: %s (Raid: %s, Total: %d)",
    DebugComposition     = " - Composition: %d Players, %d Pets, %d Others",
    DebugTricksKnown     = " - Tricks Known: %s",
    DebugTricksTarget    = " - Tricks Target: %s (%s)",
    DebugTricksMacro     = " - Tricks Macro: %s",
    DebugInvalidGroup    = " - Invalid Group: %s",
    DebugPlayer          = "PLAYER",
    DebugPet             = "PET",
    DebugOther           = "OTHER",
    DebugYes             = "YES",
    DebugNo              = "NO",
    DebugNone            = "none",
    DebugUnknown         = "Unknown",
    DebugFallback1       = " - Fallback 1: %s (Usable: %s)",
    DebugFallback2       = " - Fallback 2: %s (Usable: %s)",
    DebugShroudUsage     = "Usage: |cffffd100/veil shroud [1-20]|r",
    DebugTricksForcing   = "Forcing Tricks update...",
    DebugTricksSuccess   = "Macro refresh SUCCESS.",
    DebugMisdirForcing   = "Forcing Misdirection update...",
    DebugMisdirSuccess   = "Macro refresh SUCCESS.",
    DebugMacroUpdated    = "Macro updated: %s",
    DebugMacroStatus     = "Macro: %s",
    DebugMacroEdited     = "Macro content modified and synchronized.",
    DebugCombatLock      = "This action cannot be used in combat.",

    -- ========================================================================
    -- [[ NPC / GAME TERMS ]] -------------------------------------------------
    -- ========================================================================
    BrannBronzebeard = "Brann Bronzebeard",
    ValeeraSanguinar = "Valeera Sanguinar",
}
