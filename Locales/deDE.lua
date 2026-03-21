local addonName, ns = ...
local locale = GetLocale()
if locale ~= "deDE" then return end

ns.L = {
    -- ========================================================================
    -- [[ SYSTEM / GENERAL UI ]] -----------------------------------------
    -- ========================================================================
    Enable                  = "Aktivieren",
    Management              = "Verwaltung",
    ReleaseNotes            = "Versionshinweise",
    WelcomeMessage          = "%s |cffffcc00v%s|r geladen. Gib |cffffcc00/veil|r ein, um die Einstellungen zu öffnen.",
    UpdateMessage           = "%s auf |cffffcc00v%s|r aktualisiert! Gib |cffffcc00/veil|r ein, um die Neuerungen zu sehen.",
    FloatingText            = "Schwebender Text",

    -- ========================================================================
    -- [[ INTERFACE — Elements & Styles ]] -------------------------------
    -- ========================================================================
    Color                   = "Farbe",
    Size                    = "Größe",
    Opacity                 = "Deckkraft",
    Thickness               = "Dicke",
    Style                   = "Stil",
    Layer                   = "Ebene",
    LayerBackground         = "Hintergrund",
    LayerLow                = "Niedrig",
    LayerMedium             = "Mittel",
    LayerHigh               = "Hoch",
    LayerDialog             = "Dialog",
    LayerFullscreen         = "Vollbild",
    ScreenColor             = "Bildschirmfarbe",
    Vignette                = "Vignette",

    -- ========================================================================
    -- [[ INTERFACE — Positioning & Anchors ]] ---------------------------
    -- ========================================================================
    AnchorPoint             = "Ankerpunkt",
    AnchorToText            = "Am Text verankern",
    OffsetX                 = "Versatz X",
    OffsetY                 = "Versatz Y",
    AnchorTopLeft           = "Oben Links",
    AnchorTop               = "Oben",
    AnchorTopRight          = "Oben Rechts",
    AnchorLeft              = "Links",
    AnchorCenter            = "Zentriert",
    AnchorRight             = "Rechts",
    AnchorBottomLeft        = "Unten Links",
    AnchorBottom            = "Unten",
    AnchorBottomRight       = "Unten Rechts",

    -- ========================================================================
    -- [[ INTERFACE — Icons & Multimedia ]] ------------------------------
    -- ========================================================================
    IndicatorIcon           = "Indikatorsymbol",
    IconTexture             = "Symboltextur",
    Sound                   = "Sound",
    SoundKitId              = "SoundKit ID",
    TestSound               = "Sound testen",

    -- ========================================================================
    -- [[ INTERFACE — Logic & Filters ]] ---------------------------------
    -- ========================================================================
    OnlyInInstances         = "Nur in Instanzen",
    OnlyInCombat            = "Nur im Kampf",
    DisableInDungeons       = "In Dungeons deaktivieren",
    DisableInRaids          = "In Raids deaktivieren",
    InstanceFilters         = "Instanzfilter",

    -- ========================================================================
    -- [[ INTERFACE — Message Customization ]] ---------------------------
    -- ========================================================================
    CustomText              = "Benutzerdefinierter Text",
    Messages                = "Nachrichten",

    -- ========================================================================
    -- [[ SHARED MODULES — Highlights ]] ---------------------------------
    -- ========================================================================
    Highlights              = "Hervorhebungen",
    Highlight               = "Hervorhebung",
    HighlightGlobalDesc     = "|cffffa500Konfigurieren Sie die Charakterhervorhebung dynamisch während der Spielereignisse.|r",
    HighlightCombat         = "Im Kampf",
    HighlightCombatDesc     = "Highlight style when entering combat.",
    HighlightInstance       = "In Instanz",
    HighlightInstanceDesc   = "Highlight style when inside a dungeon or raid.",
    HighlightHidden         = "Im Tarnungszustand",
    HighlightHiddenDesc     = "Highlight style when in a custom stealth state.",
    HighlightStealth        = "In Stealth",
    HighlightStealthDesc    = "Highlight style when stealthed.",
    HighlightShroud         = "In Shroud of Concealment",
    HighlightShroudDesc     = "Highlight style when inside Shroud of Concealment.",
    HighlightCamouflage     = "In Camouflage",
    HighlightCamouflageDesc = "Highlight style when camouflaged.",
    HighlightProwl          = "In Prowl",
    HighlightProwlDesc      = "Highlight style when prowling.",
    HighlightOptNone        = "Keine",
    HighlightOptCircle      = "Kreis",
    HighlightOptOutline     = "Umriss",
    HighlightOptIcon        = "Symbol",
    HighlightOptCircleOutline = "Kreis und Umriss",
    HighlightOptCircleIcon  = "Kreis und Symbol",
    HighlightOptOutlineIcon = "Umriss und Symbol",
    HighlightOptCircleOutlineIcon = "Kreis, Umriss und Symbol",

    -- ========================================================================
    -- [[ SHARED MODULES — Stealth State ]] ------------------------------
    -- ========================================================================
    StealthStateName        = "Tarnungszustand",
    StealthStateActiveText  = "TARNUNGSZUSTAND",
    EnableOnStealthState    = "Im Tarnungszustand aktivieren",

    -- ========================================================================
    -- [[ SHARED MODULES — Macro System ]] -------------------------------
    -- ========================================================================
    MacroTargetHeader       = "Ziel",
    MacroTargetSelector     = "Ziel-Auswahllogik",
    MacroAutoUpdateWarning  = "|cffffa500Nightveil aktualisiert dieses Makro automatisch.|r",
    MacroDelveCompanion     = "Delve-Gefährte",
    MacroCustomName         = "Eigenes Ziel",
    MacroCustomSet          = "Benutzerdefiniertes Ziel festgelegt: %s",
    MacroGroupMembers       = "Gruppenmitglieder:",
    MacroInvalidIndex       = "Ungültiger Gruppenindex.",
    MacroNoSelf             = "Du kannst dich nicht selbst als Ziel wählen.",
    MacroBtnEnable          = "Makro aktivieren & synchronisieren",
    MacroBtnDisable         = "Makro deaktivieren & entfernen",
    Mouseover               = "Mouseover",
    Focus                   = "Fokus",
    Tank                    = "Tank",
    TargetTarget            = "Ziel des Ziels",
    TargetingModeSet        = "Zielmodus festgelegt: %s",
    Pet                     = "Begleiter",
    MuteChanges             = "Mute status changes",

    -- ========================================================================
    -- [[ CLASS MODULES — ROGUE ]] ---------------------------------------
    -- ========================================================================

    -- [[ Stealth ]] -------------------------------------------
    Stealth                 = "Verstohlenheit",
    EnableOnStealth         = "Bei Verstohlenheit aktivieren",
    StealthUseState         = "Zustandserkennung verwenden",
    StealthActiveText       = "GETARNT",

    -- [[ Poison Tracker ]] ------------------------------------
    PoisonTracker           = "Gift-Tracker",
    LethalPoisons           = "Tödliches Gift",
    NonLethalPoisons        = "Nicht-tödliches Gift",
    LethalPoisonMissing     = "TÖDLICHES GIFT FEHLT",
    NonLethalPoisonMissing  = "NICHTTÖDLICHES GIFT FEHLT",

    -- [[ Tricks of the Trade ]] -------------------------------
    TricksOfTheTrade        = "Schurkenhandel",
    TricksTargetLog         = "Schurkenhandel-Ziel",
    TricksNormal            = "Normal",
    TricksCustom            = "Benutzerdefiniert",
    TricksMsgEnabled        = "Schurkenhandel-System aktiviert und Makro synchronisiert.",
    TricksMsgDisabled       = "Schurkenhandel-System deaktiviert und Makro entfernt.",
    TricksAlreadyEnabled    = "Schurkenhandel-System ist bereits aktiviert.",
    TricksAlreadyDisabled   = "Schurkenhandel-System ist bereits deaktiviert.",

    -- [[ Shroud of Concealment ]] -----------------------------
    ShroudOfConcealment     = "Verhüllender Nebel",
    EnableShroudCountdown   = "Chat-Countdown aktivieren",
    ShroudMuteErrors        = "Fehler stummschalten",
    ChatChannel             = "Chat-Kanal",
    ShroudMessage           = "Countdown-Nachricht",
    ShroudOnStart           = "Start-Nachricht",
    ShroudOnEnd             = "End-Nachricht",
    ShroudInterval          = "Intervall-Modus",
    TestShroud              = "Schleier testen",
    ShroudAlreadyActive     = "Schleier-Countdown ist bereits aktiv.",
    ShroudDisabled          = "Schleier-Countdown ist in den Einstellungen deaktiviert.",

    -- ========================================================================
    -- [[ CLASS MODULES — HUNTER ]] --------------------------------------
    -- ========================================================================

    -- [[ Camouflage ]] ----------------------------------------
    Camouflage              = "Tarnung",
    EnableOnCamouflage      = "Aktivieren Sie bei Tarnung",
    CamouflageActiveText    = "GETARNT",

    -- [[ Misdirection ]] --------------------------------------
    Misdirection            = "Irreführung",
    MisdirTargetLog         = "Irreführung Ziel",
    MisdirectionNotLearned  = "Du hast Irreführung noch nicht erlernt.",
    MisdirectionMsgEnabled  = "Irreführungssystem aktiviert und Makro synchronisiert.",
    MisdirectionMsgDisabled = "Irreführungssystem deaktiviert und Makro entfernt.",
    MisdirectionAlreadyEnabled = "Das Irreführungssystem ist bereits aktiviert.",
    MisdirectionAlreadyDisabled = "Das Irreführungssystem ist bereits deaktiviert.",

    -- ========================================================================
    -- [[ CLASS MODULES — DRUID ]] ---------------------------------------
    -- ========================================================================

    -- [[ Prowl ]] ---------------------------------------------
    Prowl                   = "Schleichen",
    EnableOnProwl           = "Bei Schleichen acvtivieren",
    ProwlActiveText         = "SCHLEICHT",

    -- ========================================================================
    -- [[ PROFILE MANAGEMENT ]] ------------------------------------------
    -- ========================================================================
    Profiles                = "Profile",
    ActiveProfile           = "Aktives Profil",
    ActiveProfileDesc       = "Select which profile to use for this character.",
    CreateProfile           = "Profil erstellen",
    CreateProfileDesc       = "Create a new profile with default settings.",
    DuplicateProfile        = "Profil duplizieren",
    DuplicateProfileDesc    = "Create a copy of the current profile.",
    DeleteProfile           = "Profil löschen",
    DeleteProfileDesc       = "Remove the selected profile (cannot delete Default).",
    ExportProfile           = "Profil exportieren",
    ExportProfileDesc       = "Generate a string to share this profile with others.",
    ImportProfile           = "Profil importieren",
    ImportProfileDesc       = "Import a profile from a shared string.",
    DefaultProfileLabel     = "Standard",
    CreateProfilePrompt     = "Gib einen Namen für das neue Profil ein:",
    DuplicateProfilePrompt  = "Geben Sie einen Namen für das duplizierte Profil ein:",
    ExportProfilePrompt     = "Kopiere diesen Export-Code (Strg+C):\n\nProfil: |cff00ff00%s|r",
    ImportProfilePrompt     = "Füge den Export-Code des Profils unten ein:",
    ImportProfileNamePrompt = "Gib einen Namen für das importierte Profil ein:",
    DeleteProfileConfirm    = "Profil löschen:\n\n|cffff0000%s|r\n\nDies kann nicht rückgängig gemacht werden.",
    FactoryResetBtn         = "Werkseinstellungen",
    FactoryResetBtnDesc     = "Deletes all addon data and macros, restoring to a clean installation. UI will reload.",
    FactoryResetConfirm     = "|cffff0000WARNUNG:|r Dies löscht |cffff0000ALLE|r Ihre Nightveil-Einstellungen und -Profile und entfernt die vom Addon erstellten Makros.\n\nDiese Aktion ist |cffff0000UNUMKEHRBAR|r.\n\nSind Sie sicher, dass Sie fortfahren möchten?",
    ErrorProfileDeleteRestricted = "Du kannst das Standardprofil nicht löschen.",
    Import                  = "Importieren",
    Share                   = "Teilen",
    Next                    = "Next",

    -- ========================================================================
    -- [[ CHAT CHANNELS ]] -----------------------------------------------
    -- ========================================================================
    ChannelSay              = "Sagen",
    ChannelParty            = "Gruppe",
    ChannelRaid             = "Schlachtzug",
    ChannelInstance         = "Instanz",
    ChannelYell             = "Schreien",

    -- ========================================================================
    -- [[ SYSTEM NOTIFICATIONS & ERRORS ]] -------------------------------
    -- ========================================================================
    ErrorHardReset          = "|cffff2020Alte oder inkompatible Version erkannt.|r\n\nDie Einstellungen werden |cffffcc00zurückgesetzt|r, um Stabilität zu gewährleisten.",
    WarningOutdatedConfig   = "|cffffcc00Neuere Konfiguration erkannt!|r\n\nEs wird empfohlen, das Addon zu |cffbe89e9aktualisieren|r oder das Profil zurückzusetzen.",
    ErrorChannelNoValid     = "|cffff2020Kein gültiger Chat-Kanal verfügbar.|r",
    ErrorChannelAntiSpam    = "|cffff2020Blizzard-Spamschutz verhindert die Nutzung von Kanal|r |cffffcc00%s|r |cffff2020außerhalb von Instanzen.|r",
    ErrorChannelNoGroup     = "|cffff2020Du bist in keiner Gruppe. Kanal|r |cffffcc00%s|r |cffff2020nicht verfügbar.|r",
    ErrorChannelNoRaid      = "|cffff2020Du bist in keinem Schlachtzug. Kanal|r |cffffcc00%s|r |cffff2020nicht verfügbar.|r",
    ErrorChannelInvalidGroup = "|cffff2020Du bist allein oder in einer ungültigen Gruppe. Kanal|r |cffffcc00%s|r |cffff2020nicht verfügbar.|r",
    ErrorChannelInstanceOnly = "|cffff2020Channel|r |cffffcc00%s|r |cffff2020unavailable outside instances.|r",
    ErrorNotRogue           = "Du bist kein Schurke. Dieser Befehl ist nur für Schurken.",
    ErrorNotHunter          = "You are not a Hunter. This command is Hunter-only.",
    ErrorTricksNotLearned   = "Du hast Schurkenhandel noch nicht erlernt.",
    ErrorMisdirNotLearned   = "You have not learned Misdirection yet.",
    ErrorShroudOnlyInstances = "|cffff2020Schleier-Nachrichten funktionieren nur innerhalb von Instanzen.",
    ErrorCombatBlocked      = "Einstellungen können während des Kampfes nicht geöffnet werden.",
    ErrorMacroLimitReached  = "Makro-Limit erreicht.",
    ErrorMacroCombatLock    = "This action cannot be used in combat.",
    ErrorUnknownCmd         = "Unbekannter Befehl: |cffffcc00%s|r. Nutze |cffffcc00/veil help|r.",
    ErrorUnknownSubCmd      = "Unbekannter Unterbefehl: |cffffcc00%s|r. Nutze |cffffcc00/veil help|r.",
    DebugCombatLock         = "This action cannot be used in combat.",

    -- ========================================================================
    -- [[ COMMANDS HELP ]] -----------------------------------------------
    -- ========================================================================
    HelpSettings            = "Einstellungen",
    HelpTricks              = "Schurkenhandel-Ziel",
    HelpMisdir              = "Irreführung Ziel",
    HelpMisdirPet           = "Pet mode",
    HelpInfo                = "Diagnose-Infos",
    HelpShroudTest          = "Schleier-Countdown testen",
    HelpDebugToggle         = "Debug-Modus umschalten",
    HelpForceRefresh        = "Makro-Aktualisierung erzwingen",
    HelpModeNormal          = "Normaler Modus",
    HelpModeTank            = "Tank-Modus",
    HelpModeTT              = "Ziel-des-Ziels-Modus",
    HelpModeCustom          = "Benutzerdefinierter Modus",
    HelpModeList            = "Liste und nach Index setzen",
    HelpModeSet             = "Nach Namen setzen",

    -- ========================================================================
    -- [[ DEBUG & DIAGNOSTICS ]] -----------------------------------------
    -- ========================================================================
    DebugModeActivated      = "Debug-Modus AKTIVIERT",
    DebugModeDeactivated    = "Debug-Modus DEAKTIVIERT",
    DebugModeRequired       = "Dieser Befehl erfordert den Debug-Modus. Gib |cffffcc00/veil debug|r ein zum Aktivieren.",
    DebugCommands           = "[Debug-Befehle]",
    DebugHeader             = "%s Diagnose:",
    DebugCombat             = "- Kampf: %s",
    DebugStealth            = "- Verstohlenheit/Verschwinden: %s",
    DebugInstance           = "- Instanz: %s (Type: %s)",
    DebugGroup              = "- Gruppe: %s (Raid: %s, Gesamt: %d)",
    DebugComposition        = "- Zusammensetzung: %d Spieler, %d Begleiter, %d Andere",
    DebugTricksKnown        = "- Schurkenhandel bekannt: %s",
    DebugTricksTarget       = "- Schurkenhandel-Ziel: %s (%s)",
    DebugTricksMacro        = "- Schurkenhandel-Makro: %s",
    DebugInvalidGroup       = "- Ungültige Gruppe: %s",
    DebugPlayer             = "SPIELER",
    DebugPet                = "BEGLEITER",
    DebugOther              = "ANDERE",
    DebugYes                = "JA",
    DebugNo                 = "NEIN",
    DebugNone               = "keines",
    DebugUnknown            = "Unbekannt",
    DebugFallback1          = "- Fallback 1: %s (Nutzbar: %s)",
    DebugFallback2          = "- Fallback 2: %s (Nutzbar: %s)",
    DebugShroudUsage        = "Nutzung: |cffffcc00/veil shroud [1-20]|r",
    DebugTricksForcing      = "Erzwinge Schurkenhandel-Update...",
    DebugMisdirForcing      = "Forcing Misdirection update...",
    DebugMacroSuccess       = "Makro-Aktualisierung ERFOLGREICH.",
    DebugMacroUpdated       = "Makro aktualisiert: %s",
    DebugMacroStatus        = "Makro: %s",
    DebugMacroEdited        = "Makro-Inhalt geändert und synchronisiert.",

    -- ========================================================================
    -- [[ NPC / GAME TERMS ]] --------------------------------------------
    -- ========================================================================
    BrannBronzebeard        = "Brann Bronzebart",
    ValeeraSanguinar        = "Valeera Sanguinar",

}
