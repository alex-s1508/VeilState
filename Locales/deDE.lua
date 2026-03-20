local addonName, ns = ...
local locale = GetLocale()
if locale ~= "deDE" then return end

ns.L = {
    -- ========================================================================
    -- [[ SYSTEM / GENERAL UI ]] ----------------------------------------------
    -- ========================================================================
    Enable              = "Aktivieren",
    EnableDesc          = "Aktiviert oder deaktiviert diese Funktion.",
    Management          = "Verwaltung",
    ReleaseNotes        = "Versionshinweise",

    -- ========================================================================
    -- [[ INTERFACE — Elements & Styles ]] ------------------------------------
    -- ========================================================================
    Color               = "Farbe",
    ColorDesc           = "Legt die Farbe für dieses Element fest.",
    Size                = "Größe",
    SizeDesc            = "Ändert die Größe des Elements.",
    Opacity             = "Deckkraft",
    OpacityDesc         = "Ändert die Transparenz.",
    Layer               = "Ebene",
    LayerDesc           = "Zeichenebene (höhere erscheinen weiter vorne).",
    LayerBackground     = "Hintergrund",
    LayerLow            = "Niedrig",
    LayerMedium         = "Mittel",
    LayerHigh           = "Hoch",
    LayerDialog         = "Dialog",
    LayerFullscreen     = "Vollbild",
    Style               = "Stil",
    StyleDesc           = "Wählt den Hervorhebungsstil.",

    -- ========================================================================
    -- [[ INTERFACE — Positioning & Anchors ]] --------------------------------
    -- ========================================================================
    OffsetX             = "Versatz X",
    OffsetXDesc         = "Verschiebt das Element horizontal.",
    OffsetY             = "Versatz Y",
    OffsetYDesc         = "Verschiebt das Element vertikal.",
    AnchorToText        = "Am Text verankern",
    AnchorToTextDesc    = "Verankert das Symbol an der Textposition.",
    AnchorPoint         = "Ankerpunkt",
    AnchorPointDesc     = "Textseite, die als Anker dient.",
    AnchorTopLeft       = "Oben Links",
    AnchorTop           = "Oben",
    AnchorTopRight      = "Oben Rechts",
    AnchorLeft          = "Links",
    AnchorCenter        = "Zentriert",
    AnchorRight         = "Rechts",
    AnchorBottomLeft    = "Unten Links",
    AnchorBottom        = "Unten",
    AnchorBottomRight   = "Unten Rechts",

    -- ========================================================================
    -- [[ INTERFACE — Icons & Multimedia ]] -----------------------------------
    -- ========================================================================
    IndicatorIcon       = "Indikatorsymbol",
    EnableIconDesc      = "Zeigt eine Symbolanzeige an.",
    IconTexture         = "Symboltextur",
    IconTextureDesc     = "Pfad zur eigenen Symboltextur.",
    Sound               = "Sound",
    SoundDesc           = "Spielt einen Soundalarm ab, wenn aktiviert.",
    SoundKitId          = "SoundKit ID",
    SoundKitIdDesc      = "SoundKit ID zum Abspielen (Nummer).",
    TestSound           = "Sound testen",
    TestSoundDesc       = "Spielt den gewählten Sound jetzt ab.",

    -- ========================================================================
    -- [[ INTERFACE — Message Customization ]] --------------------------------
    -- ========================================================================
    CustomText          = "Benutzerdefinierter Text",
    CustomTextDesc      = "Eigener Nachrichtentext für die Anzeige.",
    FloatingText        = "Schwebender Text",
    Messages            = "Nachrichten",

    -- ========================================================================
    -- [[ INTERFACE — Logic Filters ]] ----------------------------------------
    -- ========================================================================
    OnlyInInstances     = "Nur in Instanzen",
    OnlyInInstancesDesc = "Gilt nur innerhalb von Instanzen (Dungeons, Raids, Szenarien).",
    OnlyInCombat        = "Nur im Kampf",
    OnlyInCombatDesc    = "Zeigt Warnungen nur während des Kampfes an.",
    DisableInDungeons   = "In Dungeons deaktivieren",
    DisableInDungeonsDesc = "Gilt nicht innerhalb von Dungeon-Instanzen.",
    DisableInRaids      = "In Raids deaktivieren",
    DisableInRaidsDesc  = "Gilt nicht innerhalb von Raid-Instanzen.",
    InstanceFilters     = "Instanzfilter",
    InstanceFiltersDesc = "Konfigurieren Sie, wo diese Funktion deaktiviert werden soll.",

    -- ========================================================================
    -- [[ HIGHLIGHTS SYSTEM ]] ------------------------------------------------
    -- ========================================================================
    Highlight              = "Hervorhebung",
    HighlightDesc          = "Hebt deinen Charakter auf dem Bildschirm hervor.",
    Highlights             = "Hervorhebungen",
    HighlightGlobalDesc    = "|cffffa500Konfigurieren Sie die Charakterhervorhebung dynamisch während der Spielereignisse.|r",
    HighlightOptNone              = "Keine",
    HighlightOptCircle            = "Kreis",
    HighlightOptOutline           = "Umriss",
    HighlightOptIcon              = "Symbol",
    HighlightOptCircleOutline     = "Kreis und Umriss",
    HighlightOptCircleIcon        = "Kreis und Symbol",
    HighlightOptOutlineIcon       = "Umriss und Symbol",
    HighlightOptCircleOutlineIcon = "Kreis, Umriss und Symbol",
    HighlightCombat     = "Im Kampf",
    HighlightCombatDesc = "Hervorhebung im aktiven Kampf.",
    HighlightInstance   = "In Instanz",
    HighlightInstanceDesc = "Hervorhebung in Dungeons, Raids oder Szenarien.",
    HighlightHidden     = "Im Tarnungszustand",
    HighlightHiddenDesc = "Hervorhebung im Tarnungszustand.",
    ScreenColor         = "Bildschirmfarbe",
    ScreenColorDesc     = "Färbt den Bildschirm ein, während aktiv.",
    Vignette            = "Vignette",
    VignetteDesc        = "Fügt einen Vignetteneffekt am Bildschirmrand hinzu.",
    Thickness           = "Dicke",
    ThicknessDesc       = "Steuert die Dicke der Vignette.",

    -- ========================================================================
    -- [[ SHARED MODULES ]] ---------------------------------------------------
    -- ========================================================================
    -- [[ Stealth State Module ]] ---------------------------------------------
    StealthStateName        = "Tarnungszustand",
    StealthStateDesc        = "Visuelle Effekte für den Tarnungszustand konfigurieren.",
    StealthStateActiveText  = "TARNUNGSZUSTAND",
    EnableOnStealthState    = "Im Tarnungszustand aktivieren",
    EnableOnStealthStateDesc = "Zeigt visuelle Effekte an, während ein Tarnungszustand aktiv ist (verwendet WoW-Zustandserkennung).",

    -- ========================================================================
    -- [[ CLASS MODULES — ROGUE ]] --------------------------------------------
    -- ========================================================================
    -- [[ Stealth Module ]] ---------------------------------------------------
    Stealth             = "Verstohlenheit",
    EnableOnStealth     = "Bei Verstohlenheit aktivieren",
    EnableOnStealthDesc = "Zeigt visuelle Effekte an, während Verstohlenheit oder Verschwinden aktiv ist.",
    StealthUseState     = "Zustandserkennung verwenden",
    StealthUseStateDesc = "Verwendet die globale Zustandserkennung anstelle spezifischer Auren. 'Aura' ist präziser für Klassenfähigkeiten, während 'Zustand' bei jedem tarnungsähnlichen Effekt aktiviert wird.",
    DefaultMessage      = "VERSTOHLEN",
    StealthActiveText   = "GETARNT",

    -- [[ Poison Tracker ]] ---------------------------------------------------
    PoisonTracker          = "Gift-Tracker",
    LethalPoisons          = "Tödliches Gift",
    LethalPoisonsDesc      = "Zeigt Warnungen an, wenn dein tödliches Gift fehlt.",
    NonLethalPoisons       = "Nicht-tödliches Gift",
    NonLethalPoisonsDesc   = "Zeigt Warnungen an, wenn dein nicht-tödliches Gift fehlt.",
    LethalPoisonMissing    = "TÖDLICHES GIFT FEHLT",
    NonLethalPoisonMissing = "NICHTTÖDLICHES GIFT FEHLT",
    -- ========================================================================
    -- [[ MACRO SYSTEM (SHARED) ]] --------------------------------------------
    -- ========================================================================


    -- [[ Tricks of the Trade ]] ----------------------------------------------
    TricksOfTheTrade         = "Schurkenhandel",
    MacroTargetHeader =  "Ziel",
    MacroTargetSelector =  "Ziel-Auswahllogik",
    MacroTargetSelectorDesc =  "Legt fest, wie das Hauptziel automatisch gewählt wird.",
    MacroAutoUpdateWarning =  "|cffffa500Nightveil aktualisiert dieses Makro automatisch.|r",
    TricksEnabledDesc        = "Aktiviert das automatische Ziel für Schurkenhandel über ein Makro.",
    MacroMouseoverDesc =  "Aktiviert Mouseover-Zielauswahl.\n\nHinweis: Dies hat Vorrang vor anderen Methoden, außer dem Delve-Gefährten.",
    MacroFocusDesc =  "Ermöglicht automatisierte Zielauswahl über das Fokus-Ziel.\n\nHinweis: Das Fokus-Ziel wird vor dem Standard-Zielselektor bevorzugt, jedoch von Mouseover oder dem Delve-Gefährten überschrieben.",
    MacroMuteDesc =  "Blendet Chat-Benachrichtigungen aus, wenn das Makro das Ziel ändert.",
    MacroDelveCompanion =  "Delve-Gefährte",
    MacroDelveCompanionDesc =  "Wählt in Delves automatisch Brann Bronzebart oder Valeera Sanguinar aus.\n\nHinweis: Dies hat innerhalb von Delves exklusive Priorität.",
    TricksTargetLog          = "Schurkenhandel-Ziel",
    TricksNormal             = "Normal",
    TricksCustom             = "Benutzerdefiniert",
    MacroCustomName =  "Eigenes Ziel",
    MacroCustomNameDesc =  "Gib den exakten Namen des Spielers ein.",
    MacroCustomSet =  "Benutzerdefiniertes Ziel festgelegt: %s",
    MacroGroupMembers =  "Gruppenmitglieder:",
    MacroInvalidIndex =  "Ungültiger Gruppenindex.",
    MacroNoSelf =  "Du kannst dich nicht selbst als Ziel wählen.",
    MacroBtnEnable =  "Makro aktivieren & synchronisieren",
    MacroBtnDisable =  "Makro deaktivieren & entfernen",
    MacroBtnDisableDesc =  "Deaktiviert das automatische Zielen und entfernt das Makro vollständig.",
    TricksMsgEnabled         = "Schurkenhandel-System aktiviert und Makro synchronisiert.",
    TricksMsgDisabled        = "Schurkenhandel-System deaktiviert und Makro entfernt.",
    TricksAlreadyEnabled     = "Schurkenhandel-System ist bereits aktiviert.",
    TricksAlreadyDisabled    = "Schurkenhandel-System ist bereits deaktiviert.",
    TricksLogicSet           = "Zielmodus festgelegt: %s",
    Mouseover                = "Mouseover",
    Focus                    = "Fokus",
    Tank                     = "Tank",
    TargetTarget             = "Ziel des Ziels",

    -- [[ Shroud of Concealment ]] --------------------------------------------
    ShroudOfConcealment      = "Verhüllender Nebel",
    EnableShroudCountdown    = "Chat-Countdown aktivieren",
    EnableShroudCountdownDesc = "Sendet Countdown-Nachrichten für den Schleier in den Chat.",
    ShroudOnlyInstancesDesc  = "Sendet Schleier-Nachrichten nur innerhalb von Instanzen.\n\nHinweis: Einige Kanäle sind außerhalb von Instanzen durch den Blizzard-Spamschutz blockiert.",
    ShroudMuteErrors         = "Fehler stummschalten",
    ShroudMuteErrorsDesc     = "Deaktiviert Fehlermeldungen zum Schleier im Chat.",
    ChatChannel              = "Chat-Kanal",
    ChatChannelDesc          = "Primärer Chat-Kanal für Schleier-Nachrichten.",
    ChatChannelFallbackDesc  = "Alternativer Kanal, falls der primäre nicht verfügbar ist.",
    ShroudMessage            = "Countdown-Nachricht",
    ShroudMessageDesc        = "Nachrichtenvorlage für den Countdown.\n\n%time = verbleibende Zeit.",
    ShroudOnStart            = "Start-Nachricht",
    ShroudOnStartDesc        = "Nachricht beim Start des Schleiers.",
    ShroudOnEnd              = "End-Nachricht",
    ShroudOnEndDesc          = "Nachricht am Ende des Schleiers (0s).",
    ShroudInterval           = "Intervall-Modus",
    ShroudIntervalDesc       = "Anfang, Mitte und die letzten 5s",
    TimeRemainingHint        = "%time = verbleibende Zeit",
    TestShroud               = "Schleier testen",
    TestShroudDesc           = "Simuliert einen lokalen 5-Sekunden-Countdown.\n\nHinweis: Nachrichten erscheinen nur für dich.",
    ShroudAlreadyActive      = "Schleier-Countdown ist bereits aktiv.",
    ShroudDisabled           = "Schleier-Countdown ist in den Einstellungen deaktiviert.",
    ChannelSay               = "Sagen",
    ChannelParty             = "Gruppe",
    ChannelRaid              = "Schlachtzug",
    ChannelInstance          = "Instanz",
    ChannelYell              = "Schreien",

    -- ========================================================================
    
    -- ========================================================================
    -- [[ CLASS MODULES — HUNTER ]] --------------------------------------------
    -- ========================================================================
    -- [[ Camouflage Module ]] -------------------------------------------------
    Camouflage              = "Tarnung",
    EnableOnCamouflage      = "Aktivieren Sie bei Tarnung",
    EnableOnCamouflageDesc  = "Zeigt visuelle Hinweise an, während Tarnung aktiv ist.",
    CamouflageActiveText    = "GETARNT",

    -- [[ Misdirection ]] ------------------------------------------------------
    Misdirection                = "Irreführung",
    MisdirEnabledDesc           = "Aktiviert das automatische Zielen für Irreführung über ein Makro.",
    MisdirTargetLog             = "Irreführung Ziel",
    MisdirectionNotLearned      = "Du hast Irreführung noch nicht erlernt.",
    MisdirectionMsgEnabled      = "Irreführungssystem aktiviert und Makro synchronisiert.",
    MisdirectionMsgDisabled     = "Irreführungssystem deaktiviert und Makro entfernt.",
    MisdirectionAlreadyEnabled  = "Das Irreführungssystem ist bereits aktiviert.",
    MisdirectionAlreadyDisabled = "Das Irreführungssystem ist bereits deaktiviert.",
    MisdirLogicSet              = "Zielmodus eingestellt: %s",
    MisdirNotLearned            = "Du hast Irreführung noch nicht erlernt.",
    Pet                         = "Begleiter",

    -- [[ PROFILE MANAGEMENT ]] -----------------------------------------------
    -- ========================================================================
    Profiles              = "Profile",
    ActiveProfile         = "Aktives Profil",
    ActiveProfileDesc     = "Wähle das aktive Profil aus.",
    CreateProfile         = "Profil erstellen",
    CreateProfileDesc     = "Erstellt ein neues Profil mit Standardeinstellungen.",
    DuplicateProfile      = "Profil duplizieren",
    DuplicateProfileDesc  = "Kopiert das aktuelle Profil in ein neues.",
    DeleteProfile         = "Profil löschen",
    DeleteProfileDesc     = "Löscht das gewählte Profil (unwiderruflich).",
    ExportProfile         = "Profil exportieren",
    ExportProfileDesc     = "Erzeugt einen Code zum Teilen dieses Profils.",
    ImportProfile         = "Profil importieren",
    ImportProfileDesc     = "Importiert ein Profil aus einem Export-Code.",
    CreateProfilePrompt   = "Gib einen Namen für das neue Profil ein:",
    DuplicateProfilePrompt = "Geben Sie einen Namen für das duplizierte Profil ein:",
    FactoryResetBtn       = "Werkseinstellungen",
    FactoryResetBtnDesc   = "Löscht alle Addon-Daten und Makros und stellt eine saubere Installation wieder her. Die Benutzeroberfläche wird neu geladen.",
    FactoryResetConfirm   = "|cffff0000WARNUNG:|r Dies löscht |cffff0000ALLE|r Ihre Nightveil-Einstellungen und -Profile und entfernt die vom Addon erstellten Makros.\n\nDiese Aktion ist |cffff0000UNUMKEHRBAR|r.\n\nSind Sie sicher, dass Sie fortfahren möchten?",
    DeleteProfileConfirm  = "Profil löschen:\n\n|cffff0000%s|r\n\nDies kann nicht rückgängig gemacht werden.",
    ExportProfilePrompt   = "Kopiere diesen Export-Code (Strg+C):\n\nProfil: |cff00ff00%s|r",
    ImportProfilePrompt   = "Füge den Export-Code des Profils unten ein:",
    ImportProfileNamePrompt = "Gib einen Namen für das importierte Profil ein:",
    ErrorDeleteRestricted = "Du kannst das Standardprofil nicht löschen.",
    DefaultProfileLabel   = "Standard",
    Import                = "Importieren",
    Share                 = "Teilen",

    -- ========================================================================
    -- [[ SYSTEM MESSAGES & WARNINGS ]] ---------------------------------------
    -- ========================================================================
    WarningNotRogue         = "Du bist kein Schurke. Dieser Befehl ist nur für Schurken.",
    TricksNotLearned        = "Du hast Schurkenhandel noch nicht erlernt.",
    HardResetWarning        = "Alte oder inkompatible Version erkannt.\n\nEinstellungen werden zurückgesetzt, um Stabilität zu gewährleisten.",
    WarningOutdatedConfig   = "Neuere Konfiguration erkannt!\n\nDas verwendete Profil wurde mit einer neueren Version von Nightveil erstellt.",
    WelcomeMessage          = "%s |cffffd100v%s|r geladen. Gib |cffffd100/veil|r ein, um die Einstellungen zu öffnen.",
    UpdateMessage           = "%s auf |cffffd100v%s|r aktualisiert! Gib |cffffd100/veil|r ein, um die Neuerungen zu sehen.",
    ErrorNoValidChannel     = "|cffff2020Kein gültiger Chat-Kanal verfügbar.|r",
    ErrorBlizzardAntiSpam   = "|cffff2020Blizzard-Spamschutz verhindert die Nutzung von Kanal|r |cffffcc00%s|r |cffff2020außerhalb von Instanzen.|r",
    ErrorNotInGroup         = "|cffff2020Du bist in keiner Gruppe. Kanal|r |cffffcc00%s|r |cffff2020nicht verfügbar.|r",
    ErrorNotInRaid          = "|cffff2020Du bist in keinem Schlachtzug. Kanal|r |cffffcc00%s|r |cffff2020nicht verfügbar.|r",
    ErrorFollowersDungeonGroup = "|cffff2020Du bist allein oder in einer ungültigen Gruppe. Kanal|r |cffffcc00%s|r |cffff2020nicht verfügbar.|r",
    ErrorShroudOnlyInstances = "|cffff2020Schleier-Nachrichten funktionieren nur innerhalb von Instanzen.",
    ErrorShroudInstanceOnly  = "|cffff2020Du bist in keiner Instanz. Kanal|r |cffffcc00%s|r |cffff2020nicht verfügbar.|r",
    CombatBlocked         = "Einstellungen können während des Kampfes nicht geöffnet werden.",
    MacroLimitReached     = "Makro-Limit erreicht.",
    MuteChanges           = "Änderungen stumm",
    Next                  = "Weiter",

    -- ========================================================================
    -- [[ COMMANDS HELP ]] ----------------------------------------------------
    -- ========================================================================
    HelpSettings          = "Einstellungen",
    HelpTricks            = "Schurkenhandel-Ziel",
    HelpUTricks           = "Makro-Aktualisierung erzwingen",
    HelpMisdir            = "Irreführung Ziel",
    HelpUMisdir           = "Makro-Aktualisierung erzwingen",
    HelpMisdirPet         = "Begleiter-Modus",
    HelpMisdirNormal      = "Normaler Modus",
    HelpMisdirTank        = "Tank-Modus",
    HelpMisdirTT          = "Ziel-des-Ziels-Modus",
    HelpMisdirCustom      = "Benutzerdefinierter Modus",
    HelpMisdirList        = "Gruppe auflisten / nach Index wählen",
    HelpMisdirSet         = "Benutzerdefinierten Namen setzen",
    HelpInfo              = "Diagnose-Infos",
    HelpShroudTest        = "Schleier-Countdown testen",
    HelpDebugToggle       = "Debug-Modus umschalten",
    HelpTricksList        = "Liste und nach Index setzen",
    HelpTricksNormal      = "Normaler Modus",
    HelpTricksTank        = "Tank-Modus",
    HelpTricksTT          = "Ziel-des-Ziels-Modus",
    HelpTricksSet         = "Nach Namen setzen",
    HelpTricksCustom      = "Benutzerdefinierter Modus",
    ErrorUnknownCmd       = "Unbekannter Befehl: |cffffd100%s|r. Nutze |cffffd100/veil help|r.",
    ErrorUnknownSubCmd    = "Unbekannter Unterbefehl: |cffffd100%s|r. Nutze |cffffd100/veil help|r.",

    -- ========================================================================
    -- [[ DEBUG INFO ]] -------------------------------------------------------
    -- ========================================================================
    DebugModeActivated   = "Debug-Modus AKTIVIERT",
    DebugModeDeactivated = "Debug-Modus DEAKTIVIERT",
    DebugModeRequired    = "Dieser Befehl erfordert den Debug-Modus. Gib |cffffd100/veil debug|r ein zum Aktivieren.",
    DebugCommands        = "[Debug-Befehle]",
    DebugHeader          = "%s Diagnose:",
    DebugCombat          = " - Kampf: %s",
    DebugStealth         = " - Verstohlenheit/Verschwinden: %s",
    DebugInstance        = " - Instanz: %s (Type: %s)",
    DebugGroup           = " - Gruppe: %s (Raid: %s, Gesamt: %d)",
    DebugComposition     = " - Zusammensetzung: %d Spieler, %d Begleiter, %d Andere",
    DebugTricksKnown     = " - Schurkenhandel bekannt: %s",
    DebugTricksTarget    = " - Schurkenhandel-Ziel: %s (%s)",
    DebugTricksMacro     = " - Schurkenhandel-Makro: %s",
    DebugInvalidGroup    = " - Ungültige Gruppe: %s",
    DebugPlayer          = "SPIELER",
    DebugPet             = "BEGLEITER",
    DebugOther           = "ANDERE",
    DebugYes             = "JA",
    DebugNo              = "NEIN",
    DebugNone            = "keines",
    DebugUnknown         = "Unbekannt",
    DebugFallback1       = " - Fallback 1: %s (Nutzbar: %s)",
    DebugFallback2       = " - Fallback 2: %s (Nutzbar: %s)",
    DebugShroudUsage     = "Nutzung: |cffffd100/veil shroud [1-20]|r",
    DebugTricksForcing   = "Erzwinge Schurkenhandel-Update...",
    DebugTricksSuccess   = "Makro-Aktualisierung ERFOLGREICH.",
    DebugMacroUpdated    = "Makro aktualisiert: %s",
    DebugMacroStatus     = "Makro: %s",
    DebugMacroEdited     = "Makro-Inhalt geändert und synchronisiert.",
    DebugCombatLock      = "Diese Aktion ist im Kampf nicht möglich.",

    -- ========================================================================
    -- [[ NPC / GAME TERMS ]] -------------------------------------------------
    -- ========================================================================
    BrannBronzebeard = "Brann Bronzebart",
    ValeeraSanguinar = "Valeera Sanguinar",
}
