local addonName, ns = ...
local locale = GetLocale()
if locale ~= "itIT" then return end

ns.L = {
    -- ========================================================================
    -- [[ SYSTEM / GENERAL UI ]] -----------------------------------------
    -- ========================================================================
    Enable                  = "Abilita",
    Management              = "Gestione",
    ReleaseNotes            = "Note di rilascio",
    WelcomeMessage          = "%s |cffffcc00v%s|r caricato. Digita |cffffcc00/veil|r per aprire le impostazioni.",
    UpdateMessage           = "%s aggiornato alla |cffffcc00v%s|r! Digita |cffffcc00/veil|r per vedere le novità.",
    FloatingText            = "Testo mobile",

    -- ========================================================================
    -- [[ INTERFACE — Elements & Styles ]] -------------------------------
    -- ========================================================================
    Color                   = "Colore",
    Size                    = "Dimensione",
    Opacity                 = "Opacità",
    Thickness               = "Spessore",
    Style                   = "Stile",
    Layer                   = "Livello",
    LayerBackground         = "Sfondo",
    LayerLow                = "Basso",
    LayerMedium             = "Medio",
    LayerHigh               = "Alto",
    LayerDialog             = "Dialogo",
    LayerFullscreen         = "Schermo intero",
    ScreenColor             = "Colore schermo",
    Vignette                = "Vignetta",

    -- ========================================================================
    -- [[ INTERFACE — Positioning & Anchors ]] ---------------------------
    -- ========================================================================
    AnchorPoint             = "Punto di ancoraggio",
    AnchorToText            = "Ancora al testo",
    OffsetX                 = "Offset X",
    OffsetY                 = "Offset Y",
    AnchorTopLeft           = "In alto a sinistra",
    AnchorTop               = "In alto",
    AnchorTopRight          = "In alto a destra",
    AnchorLeft              = "Sinistra",
    AnchorCenter            = "Centro",
    AnchorRight             = "Destra",
    AnchorBottomLeft        = "In basso a sinistra",
    AnchorBottom            = "In basso",
    AnchorBottomRight       = "In basso a destra",

    -- ========================================================================
    -- [[ INTERFACE — Icons & Multimedia ]] ------------------------------
    -- ========================================================================
    IndicatorIcon           = "Icona indicatore",
    IconTexture             = "Texture icona",
    Sound                   = "Suono",
    SoundKitId              = "ID SoundKit",
    TestSound               = "Testa suono",

    -- ========================================================================
    -- [[ INTERFACE — Logic & Filters ]] ---------------------------------
    -- ========================================================================
    OnlyInInstances         = "Solo in istanza",
    OnlyInCombat            = "Solo in combattimento",
    DisableInDungeons       = "Disabilita nelle Spedizioni",
    DisableInRaids          = "Disabilita nelle Incursioni",
    InstanceFilters         = "Filtri istanza",

    -- ========================================================================
    -- [[ INTERFACE — Message Customization ]] ---------------------------
    -- ========================================================================
    CustomText              = "Testo personalizzato",
    Messages                = "Messaggi",

    -- ========================================================================
    -- [[ SHARED MODULES — Highlights ]] ---------------------------------
    -- ========================================================================
    Highlights              = "Evidenziatori",
    Highlight               = "Evidenziatore",
    HighlightGlobalDesc     = "|cffffa500Configura l'evidenziazione del personaggio dinamicamente tra gli eventi di gioco.|r",
    HighlightCombat         = "In combattimento",
    HighlightCombatDesc     = "Highlight style when entering combat.",
    HighlightInstance       = "In istanza",
    HighlightInstanceDesc   = "Highlight style when inside a dungeon or raid.",
    HighlightHidden         = "In stato furtivo",
    HighlightHiddenDesc     = "Highlight style when in a custom stealth state.",
    HighlightStealth        = "In Stealth",
    HighlightStealthDesc    = "Highlight style when stealthed.",
    HighlightShroud         = "In Shroud of Concealment",
    HighlightShroudDesc     = "Highlight style when inside Shroud of Concealment.",
    HighlightCamouflage     = "In Camouflage",
    HighlightCamouflageDesc = "Highlight style when camouflaged.",
    HighlightProwl          = "In Prowl",
    HighlightProwlDesc      = "Highlight style when prowling.",
    HighlightOptNone        = "Nessuno",
    HighlightOptCircle      = "Cerchio",
    HighlightOptOutline     = "Contorno",
    HighlightOptIcon        = "Icona",
    HighlightOptCircleOutline = "Cerchio e Contorno",
    HighlightOptCircleIcon  = "Cerchio e Icona",
    HighlightOptOutlineIcon = "Contorno e Icona",
    HighlightOptCircleOutlineIcon = "Cerchio, Contorno e Icona",

    -- ========================================================================
    -- [[ SHARED MODULES — Stealth State ]] ------------------------------
    -- ========================================================================
    StealthStateName        = "Stato furtivo",
    StealthStateActiveText  = "STATO FURTIVO",
    EnableOnStealthState    = "Abilita in stato furtivo",

    -- ========================================================================
    -- [[ SHARED MODULES — Macro System ]] -------------------------------
    -- ========================================================================
    MacroTargetHeader       = "Bersaglio",
    MacroTargetSelector     = "Selettore bersaglio",
    MacroAutoUpdateWarning  = "|cffffa500Nightveil aggiorna questa macro automaticamente.|r",
    MacroDelveCompanion     = "Compagno d'Incursione",
    MacroCustomName         = "Bersaglio personalizzato",
    MacroCustomSet          = "Bersaglio personalizzato impostato: %s",
    MacroGroupMembers       = "Membri del gruppo:",
    MacroInvalidIndex       = "Indice del gruppo non valido.",
    MacroNoSelf             = "Non puoi bersagliare te stesso.",
    MacroBtnEnable          = "Attiva e Sincronizza Macro",
    MacroBtnDisable         = "Disattiva e Rimuovi Macro",
    Mouseover               = "Mouseover",
    Focus                   = "Focus",
    Tank                    = "Tank",
    TargetTarget            = "Bersaglio del bersaglio",
    TargetingModeSet        = "Modalità bersaglio impostata: %s",
    Pet                     = "Famiglio",
    MuteChanges             = "Mute status changes",

    -- ========================================================================
    -- [[ CLASS MODULES — ROGUE ]] ---------------------------------------
    -- ========================================================================

    -- [[ Stealth ]] -------------------------------------------
    Stealth                 = "Furtività",
    EnableOnStealth         = "Abilita con Furtività",
    StealthUseState         = "Usa rilevamento stati",
    StealthActiveText       = "FURTIVO",

    -- [[ Poison Tracker ]] ------------------------------------
    PoisonTracker           = "Tracciatore veleni",
    LethalPoisons           = "Veleno letale",
    NonLethalPoisons        = "Veleno non letale",
    LethalPoisonMissing     = "VELENO LETALE MANCANTE",
    NonLethalPoisonMissing  = "VELENO NON LETALE MANCANTE",

    -- [[ Tricks of the Trade ]] -------------------------------
    TricksOfTheTrade        = "Segreti del mestiere",
    TricksTargetLog         = "Bersaglio dei Segreti",
    TricksNormal            = "Normale",
    TricksCustom            = "Personalizzato",
    TricksMsgEnabled        = "Sistema di Segreti attivato e macro sincronizzata.",
    TricksMsgDisabled       = "Sistema di Segreti disattivato e macro rimossa.",
    TricksAlreadyEnabled    = "Il sistema Segreti del mestiere è già abilitato.",
    TricksAlreadyDisabled   = "Il sistema Segreti del mestiere è già disabilitato.",

    -- [[ Shroud of Concealment ]] -----------------------------
    ShroudOfConcealment     = "Manto di occultamento",
    EnableShroudCountdown   = "Abilita conto alla rovescia chat",
    ShroudMuteErrors        = "Silenziamento errori",
    ChatChannel             = "Canale di chat",
    ShroudMessage           = "Messaggio conto alla rovescia",
    ShroudOnStart           = "Messaggio d'inizio",
    ShroudOnEnd             = "Messaggio di fine",
    ShroudInterval          = "Modalità intervallo",
    TestShroud              = "Testa Manto",
    ShroudAlreadyActive     = "Il conto alla rovescia del Manto è già attivo.",
    ShroudDisabled          = "Il conto alla rovescia del Manto è disabilitato nelle impostazioni.",

    -- ========================================================================
    -- [[ CLASS MODULES — HUNTER ]] --------------------------------------
    -- ========================================================================

    -- [[ Camouflage ]] ----------------------------------------
    Camouflage              = "Camuffamento",
    EnableOnCamouflage      = "Attiva con Camuffamento",
    CamouflageActiveText    = "MIMETIZZATO",

    -- [[ Misdirection ]] --------------------------------------
    Misdirection            = "Depistaggio",
    MisdirTargetLog         = "Bersaglio Depistaggio",
    MisdirectionNotLearned  = "Non hai ancora imparato Depistaggio.",
    MisdirectionMsgEnabled  = "Sistema Depistaggio attivato e macro sincronizzata.",
    MisdirectionMsgDisabled = "Sistema Depistaggio disattivato e macro rimossa.",
    MisdirectionAlreadyEnabled = "Il sistema Depistaggio è già attivato.",
    MisdirectionAlreadyDisabled = "Il sistema Depistaggio è già disattivato.",

    -- ========================================================================
    -- [[ CLASS MODULES — DRUID ]] ---------------------------------------
    -- ========================================================================

    -- [[ Prowl ]] ---------------------------------------------
    Prowl                   = "Movimento Furtivo",
    EnableOnProwl           = "Attiva con Movimento Furtivo",
    ProwlActiveText         = "NASCORTO",

    -- ========================================================================
    -- [[ PROFILE MANAGEMENT ]] ------------------------------------------
    -- ========================================================================
    Profiles                = "Profili",
    ActiveProfile           = "Profilo attivo",
    ActiveProfileDesc       = "Select which profile to use for this character.",
    CreateProfile           = "Crea profilo",
    CreateProfileDesc       = "Create a new profile with default settings.",
    DuplicateProfile        = "Duplica profilo",
    DuplicateProfileDesc    = "Create a copy of the current profile.",
    DeleteProfile           = "Elimina profilo",
    DeleteProfileDesc       = "Remove the selected profile (cannot delete Default).",
    ExportProfile           = "Esporta profilo",
    ExportProfileDesc       = "Generate a string to share this profile with others.",
    ImportProfile           = "Importa profilo",
    ImportProfileDesc       = "Import a profile from a shared string.",
    DefaultProfileLabel     = "Predefinito",
    CreateProfilePrompt     = "Inserisci un nome per il nuovo profilo:",
    DuplicateProfilePrompt  = "Inserisci un nome per il profilo duplicato:",
    ExportProfilePrompt     = "Copia questa stringa di esportazione (Ctrl+C):\n\nProfilo: |cff00ff00%s|r",
    ImportProfilePrompt     = "Incolla la stringa di esportazione del profilo qui sotto:",
    ImportProfileNamePrompt = "Inserisci un nome per il profilo importato:",
    DeleteProfileConfirm    = "Elimina profilo:\n\n|cffff0000%s|r\n\nL'azione non può essere annullata.",
    FactoryResetBtn         = "Ripristino di fabbrica",
    FactoryResetBtnDesc     = "Deletes all addon data and macros, restoring to a clean installation. UI will reload.",
    FactoryResetConfirm     = "|cffff0000ATTENZIONE:|r Questo eliminerà |cffff0000TUTTE|r le tue impostazioni e i tuoi profili di Nightveil, e rimuoverà le macro create dall'addon.\n\nQuesta azione è |cffff0000IRREVERSIBILE|r.\n\nSei sicuro di voler procedere?",
    ErrorProfileDeleteRestricted = "Non puoi eliminare il profilo predefinito.",
    Import                  = "Importa",
    Share                   = "Condividi",
    Next                    = "Next",

    -- ========================================================================
    -- [[ CHAT CHANNELS ]] -----------------------------------------------
    -- ========================================================================
    ChannelSay              = "Dici",
    ChannelParty            = "Gruppo",
    ChannelRaid             = "Incursione",
    ChannelInstance         = "Istanza",
    ChannelYell             = "Grida",

    -- ========================================================================
    -- [[ SYSTEM NOTIFICATIONS & ERRORS ]] -------------------------------
    -- ========================================================================
    ErrorHardReset          = "|cffff2020Rilevata versione vecchia o incompatibile.|r\n\nLe impostazioni saranno |cffffcc00reimpostate|r per garantire la stabilità.",
    WarningOutdatedConfig   = "|cffffcc00Rilevata configurazione più recente!|r\n\nSi consiglia di |cffbe89e9aggiornare|r l'addon o reimpostare il profilo.",
    ErrorChannelNoValid     = "|cffff2020Nessun canale di chat valido disponibile.|r",
    ErrorChannelAntiSpam    = "|cffff2020Le restrizioni anti-spam di Blizzard impediscono di usare il canale|r |cffffcc00%s|r |cffff2020fuori dalle istanze.|r",
    ErrorChannelNoGroup     = "|cffff2020Non sei in un gruppo. Canale|r |cffffcc00%s|r |cffff2020non disponibile.|r",
    ErrorChannelNoRaid      = "|cffff2020Non sei in un'incursione. Canale|r |cffffcc00%s|r |cffff2020non disponibile.|r",
    ErrorChannelInvalidGroup = "|cffff2020Sei solo o in un gruppo non valido. Canale|r |cffffcc00%s|r |cffff2020non disponibile.|r",
    ErrorChannelInstanceOnly = "|cffff2020Channel|r |cffffcc00%s|r |cffff2020unavailable outside instances.|r",
    ErrorNotRogue           = "Non sei un Ladro. Questo comando è riservato ai Ladri.",
    ErrorNotHunter          = "You are not a Hunter. This command is Hunter-only.",
    ErrorTricksNotLearned   = "Non hai ancora imparato Segreti del mestiere.",
    ErrorMisdirNotLearned   = "You have not learned Misdirection yet.",
    ErrorShroudOnlyInstances = "|cffff2020I messaggi del Manto funzionano solo all'interno delle istanze.",
    ErrorCombatBlocked      = "Impossibile aprire le impostazioni durante il combattimento.",
    ErrorMacroLimitReached  = "Limite macro raggiunto.",
    ErrorMacroCombatLock    = "This action cannot be used in combat.",
    ErrorUnknownCmd         = "Comando sconosciuto: |cffffcc00%s|r. Usa |cffffcc00/veil help|r.",
    ErrorUnknownSubCmd      = "Sottocomando sconosciuto: |cffffcc00%s|r. Usa |cffffcc00/veil help|r.",
    DebugCombatLock         = "This action cannot be used in combat.",

    -- ========================================================================
    -- [[ COMMANDS HELP ]] -----------------------------------------------
    -- ========================================================================
    HelpSettings            = "Impostazioni",
    HelpTricks              = "Bersaglio dei Segreti",
    HelpMisdir              = "Bersaglio Depistaggio",
    HelpMisdirPet           = "Pet mode",
    HelpInfo                = "Info diagnostiche",
    HelpShroudTest          = "Testa conto alla rovescia manto",
    HelpDebugToggle         = "Attiva/Disattiva modalità debug",
    HelpForceRefresh        = "Forza aggiornamento macro",
    HelpModeNormal          = "Modalità Normale",
    HelpModeTank            = "Modalità Tank",
    HelpModeTT              = "Modalità Bersaglio-del-Bersaglio",
    HelpModeCustom          = "Modalità Personalizzata",
    HelpModeList            = "Elenca e imposta per indice",
    HelpModeSet             = "Imposta per nome",

    -- ========================================================================
    -- [[ DEBUG & DIAGNOSTICS ]] -----------------------------------------
    -- ========================================================================
    DebugModeActivated      = "Modalità Debug ATTIVATA",
    DebugModeDeactivated    = "Modalità Debug DISATTIVATA",
    DebugModeRequired       = "Questo comando richiede la modalità Debug. Digita |cffffcc00/veil debug|r per attivarla.",
    DebugCommands           = "[Comandi di Debug]",
    DebugHeader             = "Diagnostica %s:",
    DebugCombat             = "- Combattimento: %s",
    DebugStealth            = "- Furtività/Sparizione: %s",
    DebugInstance           = "- Istanza: %s (Tipo: %s)",
    DebugGroup              = "- Gruppo: %s (Incursione: %s, Totale: %d)",
    DebugComposition        = "- Composizione: %d Giocatori, %d Mascotta, %d Altri",
    DebugTricksKnown        = "- Segreti conosciuti: %s",
    DebugTricksTarget       = "- Bersaglio dei Segreti: %s (%s)",
    DebugTricksMacro        = "- Macro dei Segreti: %s",
    DebugInvalidGroup       = "- Gruppo non valido: %s",
    DebugPlayer             = "GIOCATORE",
    DebugPet                = "MASCOTTA",
    DebugOther              = "ALTRO",
    DebugYes                = "SÌ",
    DebugNo                 = "NO",
    DebugNone               = "nessuno",
    DebugUnknown            = "Sconosciuto",
    DebugFallback1          = "- Fallback 1: %s (Utilizzabile: %s)",
    DebugFallback2          = "- Fallback 2: %s (Utilizzabile: %s)",
    DebugShroudUsage        = "Utilizzo: |cffffcc00/veil shroud [1-20]|r",
    DebugTricksForcing      = "Forzatura aggiornamento Segreti...",
    DebugMisdirForcing      = "Forcing Misdirection update...",
    DebugMacroSuccess       = "Aggiornamento macro RIUSCITO.",
    DebugMacroUpdated       = "Macro aggiornata: %s",
    DebugMacroStatus        = "Macro: %s",
    DebugMacroEdited        = "Contenuto della macro modificato e sincronizzato.",

    -- ========================================================================
    -- [[ NPC / GAME TERMS ]] --------------------------------------------
    -- ========================================================================
    BrannBronzebeard        = "Brann Barbabronzea",
    ValeeraSanguinar        = "Valeera Sanguinar",

}
