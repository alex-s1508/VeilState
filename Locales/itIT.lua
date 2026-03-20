local addonName, ns = ...
local locale = GetLocale()
if locale ~= "itIT" then return end

ns.L = {
    -- ========================================================================
    -- [[ SYSTEM / GENERAL UI ]] ----------------------------------------------
    -- ========================================================================
    Enable              = "Abilita",
    EnableDesc          = "Abilita o disabilita questa funzione.",
    Management          = "Gestione",
    ReleaseNotes        = "Note di rilascio",

    -- ========================================================================
    -- [[ INTERFACE — Elements & Styles ]] ------------------------------------
    -- ========================================================================
    Color               = "Colore",
    ColorDesc           = "Imposta il colore utilizzato da questo elemento.",
    Size                = "Dimensione",
    SizeDesc            = "Cambia la dimensione dell'elemento.",
    Opacity             = "Opacità",
    OpacityDesc         = "Cambia la trasparenza.",
    Layer               = "Livello",
    LayerDesc           = "Livello di disegno (un valore più alto apparirà sopra).",
    LayerBackground     = "Sfondo",
    LayerLow            = "Basso",
    LayerMedium         = "Medio",
    LayerHigh           = "Alto",
    LayerDialog         = "Dialogo",
    LayerFullscreen     = "Schermo intero",
    Style               = "Stile",
    StyleDesc           = "Seleziona lo stile di evidenziazione.",

    -- ========================================================================
    -- [[ INTERFACE — Positioning & Anchors ]] --------------------------------
    -- ========================================================================
    OffsetX             = "Offset X",
    OffsetXDesc         = "Sposta l'elemento orizzontalmente.",
    OffsetY             = "Offset Y",
    OffsetYDesc         = "Sposta l'elemento verticalmente.",
    AnchorToText        = "Ancora al testo",
    AnchorToTextDesc    = "Ancora l'icona alla posizione del testo.",
    AnchorPoint         = "Punto di ancoraggio",
    AnchorPointDesc     = "Lato del testo utilizzato come ancora.",
    AnchorTopLeft       = "In alto a sinistra",
    AnchorTop           = "In alto",
    AnchorTopRight      = "In alto a destra",
    AnchorLeft          = "Sinistra",
    AnchorCenter        = "Centro",
    AnchorRight         = "Destra",
    AnchorBottomLeft    = "In basso a sinistra",
    AnchorBottom        = "In basso",
    AnchorBottomRight   = "In basso a destra",

    -- ========================================================================
    -- [[ INTERFACE — Icons & Multimedia ]] -----------------------------------
    -- ========================================================================
    IndicatorIcon       = "Icona indicatore",
    EnableIconDesc      = "Mostra un indicatore icona.",
    IconTexture         = "Texture icona",
    IconTextureDesc     = "Percorso personalizzato della texture dell'icona.",
    Sound               = "Suono",
    SoundDesc           = "Riproduce un avviso sonoro quando attivato.",
    SoundKitId          = "ID SoundKit",
    SoundKitIdDesc      = "ID SoundKit da riprodurre (numero).",
    TestSound           = "Testa suono",
    TestSoundDesc       = "Riproduce ora il suono selezionato.",

    -- ========================================================================
    -- [[ INTERFACE — Message Customization ]] --------------------------------
    -- ========================================================================
    CustomText          = "Testo personalizzato",
    CustomTextDesc      = "Testo del messaggio personalizzato da visualizzare.",
    FloatingText        = "Testo mobile",
    Messages            = "Messaggi",

    -- ========================================================================
    -- [[ INTERFACE — Logic Filters ]] ----------------------------------------
    -- ========================================================================
    OnlyInInstances     = "Solo in istanza",
    OnlyInInstancesDesc = "Si applica solo all'interno delle istanze (Spedizioni, Incursioni, Scenari).",
    OnlyInCombat        = "Solo in combattimento",
    OnlyInCombatDesc    = "Mostra solo avvisi mentre sei in combattimento.",
    DisableInDungeons   = "Disabilita nelle Spedizioni",
    DisableInDungeonsDesc = "Non si applica all'interno di una Spedizione.",
    DisableInRaids      = "Disabilita nelle Incursioni",
    DisableInRaidsDesc  = "Non si applica all'interno di un'Incursione.",
    InstanceFilters     = "Filtri istanza",
    InstanceFiltersDesc = "Configura dove questa funzione deve essere disabilitata.",

    -- ========================================================================
    -- [[ HIGHLIGHTS SYSTEM ]] ------------------------------------------------
    -- ========================================================================
    Highlight              = "Evidenziatore",
    HighlightDesc          = "Evidenzia il tuo personaggio sullo schermo.",
    Highlights             = "Evidenziatori",
    HighlightGlobalDesc    = "|cffffa500Configura l'evidenziazione del personaggio dinamicamente tra gli eventi di gioco.|r",
    HighlightOptNone              = "Nessuno",
    HighlightOptCircle            = "Cerchio",
    HighlightOptOutline           = "Contorno",
    HighlightOptIcon              = "Icona",
    HighlightOptCircleOutline     = "Cerchio e Contorno",
    HighlightOptCircleIcon        = "Cerchio e Icona",
    HighlightOptOutlineIcon       = "Contorno e Icona",
    HighlightOptCircleOutlineIcon = "Cerchio, Contorno e Icona",
    HighlightCombat     = "In combattimento",
    HighlightCombatDesc = "Evidenziazione usata in combattimento attivo.",
    HighlightInstance   = "In istanza",
    HighlightInstanceDesc = "Evidenziazione usata in spedizioni, incursioni o scenari.",
    HighlightHidden     = "In stato furtivo",
    HighlightHiddenDesc = "Evidenziazione usata in stato di Furtività.",
    ScreenColor         = "Colore schermo",
    ScreenColorDesc     = "Colora lo schermo quando attivo.",
    Vignette            = "Vignetta",
    VignetteDesc        = "Aggiunge un effetto vignetta ai bordi dello schermo.",
    Thickness           = "Spessore",
    ThicknessDesc       = "Controlla lo spessore della vignetta.",

    -- ========================================================================
    -- [[ SHARED MODULES ]] ---------------------------------------------------
    -- ========================================================================
    -- [[ Stealth State Module ]] ---------------------------------------------
    StealthStateName        = "Stato furtivo",
    StealthStateDesc        = "Configura gli effetti visivi per quando sei in stato furtivo.",
    StealthStateActiveText  = "STATO FURTIVO",
    EnableOnStealthState    = "Abilita in stato furtivo",
    EnableOnStealthStateDesc = "Mostra effetti visivi mentre è attivo un qualsiasi stato furtivo (usa il rilevamento stati di WoW).",

    -- ========================================================================
    -- [[ CLASS MODULES — ROGUE ]] --------------------------------------------
    -- ========================================================================
    -- [[ Stealth Module ]] ---------------------------------------------------
    Stealth             = "Furtività",
    EnableOnStealth     = "Abilita con Furtività",
    EnableOnStealthDesc = "Mostra effetti visivi mentre Furtività o Sparizione sono attivi.",
    StealthUseState     = "Usa rilevamento stati",
    StealthUseStateDesc = "Usa lo stato furtivo globale invece di aure specifiche. 'Aura' è più accurata per le abilità di classe, mentre 'Stato' si attiva su qualsiasi effetto simile alla furtività.",
    DefaultMessage      = "FURTIVO",
    StealthActiveText   = "FURTIVO",

    -- [[ Poison Tracker ]] ---------------------------------------------------
    PoisonTracker          = "Tracciatore veleni",
    LethalPoisons          = "Veleno letale",
    LethalPoisonsDesc      = "Mostra avvisi quando manca il veleno letale.",
    NonLethalPoisons       = "Veleno non letale",
    NonLethalPoisonsDesc   = "Mostra avvisi quando manca il veleno non letale.",
    LethalPoisonMissing    = "VELENO LETALE MANCANTE",
    NonLethalPoisonMissing = "VELENO NON LETALE MANCANTE",
    -- ========================================================================
    -- [[ MACRO SYSTEM (SHARED) ]] --------------------------------------------
    -- ========================================================================


    -- [[ Tricks of the Trade ]] ----------------------------------------------
    TricksOfTheTrade         = "Segreti del mestiere",
    MacroTargetHeader =  "Bersaglio",
    MacroTargetSelector =  "Selettore bersaglio",
    MacroTargetSelectorDesc =  "Definisce la logica principale per la selezione automatica del bersaglio.",
    MacroAutoUpdateWarning =  "|cffffa500Nightveil aggiorna questa macro automaticamente.|r",
    TricksEnabledDesc        = "Abilita il bersagliamento automatico per Segreti del mestiere tramite una macro.",
    MacroMouseoverDesc =  "Abilita il bersagliamento tramite mouseover.\n\nNota: Questo ha la priorità su tutti gli altri metodi, eccetto il Compagno d'Incursione.",
    MacroFocusDesc =  "Abilita il bersagliamento automatizzato tramite il focus.\n\nNota: Questo ha la priorità sul selettore bersagli, ma viene ignorato dal mouseover o dal Compagno d'Incursione.",
    MacroMuteDesc =  "Nasconde le notifiche in chat quando la macro cambia bersaglio.",
    MacroDelveCompanion =  "Compagno d'Incursione",
    MacroDelveCompanionDesc =  "Bersaglia automaticamente i compagni come Brann Barbabronzea o Valeera Sanguinar all'interno delle Incursioni.\n\nNota: Questo ha la priorità esclusiva all'interno delle Incursioni.",
    TricksTargetLog          = "Bersaglio dei Segreti",
    TricksNormal             = "Normale",
    TricksCustom             = "Personalizzato",
    MacroCustomName =  "Bersaglio personalizzato",
    MacroCustomNameDesc =  "Inserisci il nome esatto del giocatore da bersagliare.",
    MacroCustomSet =  "Bersaglio personalizzato impostato: %s",
    MacroGroupMembers =  "Membri del gruppo:",
    MacroInvalidIndex =  "Indice del gruppo non valido.",
    MacroNoSelf =  "Non puoi bersagliare te stesso.",
    MacroBtnEnable =  "Attiva e Sincronizza Macro",
    MacroBtnDisable =  "Disattiva e Rimuovi Macro",
    MacroBtnDisableDesc =  "Disabilita il bersagliamento automatizzato e rimuove completamente la macro.",
    TricksMsgEnabled         = "Sistema di Segreti attivato e macro sincronizzata.",
    TricksMsgDisabled        = "Sistema di Segreti disattivato e macro rimossa.",
    TricksAlreadyEnabled     = "Il sistema Segreti del mestiere è già abilitato.",
    TricksAlreadyDisabled    = "Il sistema Segreti del mestiere è già disabilitato.",
    TricksLogicSet           = "Modalità bersaglio impostata: %s",
    Mouseover                = "Mouseover",
    Focus                    = "Focus",
    Tank                     = "Tank",
    TargetTarget             = "Bersaglio del bersaglio",

    -- [[ Shroud of Concealment ]] --------------------------------------------
    ShroudOfConcealment      = "Manto di occultamento",
    EnableShroudCountdown    = "Abilita conto alla rovescia chat",
    EnableShroudCountdownDesc = "Invia messaggi di conto alla rovescia del Manto in chat.",
    ShroudOnlyInstancesDesc  = "Invia i messaggi del Manto solo all'interno delle istanze.\n\nNota: alcuni canali sono bloccati fuori dalle istanze dall'anti-spam di Blizzard.",
    ShroudMuteErrors         = "Silenziamento errori",
    ShroudMuteErrorsDesc     = "Disabilita i messaggi d'errore del Manto in chat.",
    ChatChannel              = "Canale di chat",
    ChatChannelDesc          = "Canale di chat principale usato per i messaggi del Manto.",
    ChatChannelFallbackDesc  = "Canale alternativo usato se quello principale non è disponibile.",
    ShroudMessage            = "Messaggio conto alla rovescia",
    ShroudMessageDesc        = "Modello di messaggio usato durante il conto alla rovescia.\n\n%time = tempo rimanente.",
    ShroudOnStart            = "Messaggio d'inizio",
    ShroudOnStartDesc        = "Messaggio inviato all'inizio del Manto.",
    ShroudOnEnd              = "Messaggio di fine",
    ShroudOnEndDesc          = "Messaggio inviato alla fine del Manto (0s).",
    ShroudInterval           = "Modalità intervallo",
    ShroudIntervalDesc       = "Inizio, metà e ultimi 5 secondi.",
    TimeRemainingHint        = "%time = tempo rimanente",
    TestShroud               = "Testa Manto",
    TestShroudDesc           = "Simula un conto alla rovescia locale di 5 secondi.\n\nNota: I messaggi compaiono solo a te.",
    ShroudAlreadyActive      = "Il conto alla rovescia del Manto è già attivo.",
    ShroudDisabled           = "Il conto alla rovescia del Manto è disabilitato nelle impostazioni.",
    ChannelSay               = "Dici",
    ChannelParty             = "Gruppo",
    ChannelRaid              = "Incursione",
    ChannelInstance          = "Istanza",
    ChannelYell              = "Grida",

    -- ========================================================================
    
    -- ========================================================================
    -- [[ CLASS MODULES — HUNTER ]] --------------------------------------------
    -- ========================================================================
    -- [[ Camouflage Module ]] -------------------------------------------------
    Camouflage              = "Camuffamento",
    EnableOnCamouflage      = "Attiva con Camuffamento",
    EnableOnCamouflageDesc  = "Mostra effetti visivi mentre Camuffamento è attivo.",
    CamouflageActiveText    = "MIMETIZZATO",

    -- [[ Misdirection ]] ------------------------------------------------------
    Misdirection                = "Depistaggio",
    MisdirEnabledDesc           = "Abilita il puntamento automatico per Depistaggio tramite macro.",
    MisdirTargetLog             = "Bersaglio Depistaggio",
    MisdirectionNotLearned      = "Non hai ancora imparato Depistaggio.",
    MisdirectionMsgEnabled      = "Sistema Depistaggio attivato e macro sincronizzata.",
    MisdirectionMsgDisabled     = "Sistema Depistaggio disattivato e macro rimossa.",
    MisdirectionAlreadyEnabled  = "Il sistema Depistaggio è già attivato.",
    MisdirectionAlreadyDisabled = "Il sistema Depistaggio è già disattivato.",
    MisdirLogicSet              = "Modalità bersaglio impostata: %s",
    MisdirNotLearned            = "Non hai ancora imparato Depistaggio.",
    Pet                         = "Famiglio",

    -- [[ PROFILE MANAGEMENT ]] -----------------------------------------------
    -- ========================================================================
    Profiles              = "Profili",
    ActiveProfile         = "Profilo attivo",
    ActiveProfileDesc     = "Seleziona quale profilo è attivo.",
    CreateProfile         = "Crea profilo",
    CreateProfileDesc     = "Crea un nuovo profilo con le impostazioni predefinite.",
    DuplicateProfile      = "Duplica profilo",
    DuplicateProfileDesc  = "Copia il profilo corrente in uno nuovo.",
    DeleteProfile         = "Elimina profilo",
    DeleteProfileDesc     = "Elimina il profilo selezionato (azione irreversibile).",
    ExportProfile         = "Esporta profilo",
    ExportProfileDesc     = "Genera una stringa per condividere questo profilo.",
    ImportProfile         = "Importa profilo",
    ImportProfileDesc     = "Importa un profilo da una stringa esportata.",
    CreateProfilePrompt   = "Inserisci un nome per il nuovo profilo:",
    DuplicateProfilePrompt = "Inserisci un nome per il profilo duplicato:",
    FactoryResetBtn       = "Ripristino di fabbrica",
    FactoryResetBtnDesc   = "Elimina tutti i dati dell'addon e le macro, ripristinando un'installazione pulita. L'interfaccia verrà ricaricata.",
    FactoryResetConfirm   = "|cffff0000ATTENZIONE:|r Questo eliminerà |cffff0000TUTTE|r le tue impostazioni e i tuoi profili di Nightveil, e rimuoverà le macro create dall'addon.\n\nQuesta azione è |cffff0000IRREVERSIBILE|r.\n\nSei sicuro di voler procedere?",
    DeleteProfileConfirm  = "Elimina profilo:\n\n|cffff0000%s|r\n\nL'azione non può essere annullata.",
    ExportProfilePrompt   = "Copia questa stringa di esportazione (Ctrl+C):\n\nProfilo: |cff00ff00%s|r",
    ImportProfilePrompt   = "Incolla la stringa di esportazione del profilo qui sotto:",
    ImportProfileNamePrompt = "Inserisci un nome per il profilo importato:",
    ErrorDeleteRestricted = "Non puoi eliminare il profilo predefinito.",
    DefaultProfileLabel   = "Predefinito",
    Import                = "Importa",
    Share                 = "Condividi",

    -- ========================================================================
    -- [[ SYSTEM MESSAGES & WARNINGS ]] ---------------------------------------
    -- ========================================================================
    WarningNotRogue         = "Non sei un Ladro. Questo comando è riservato ai Ladri.",
    TricksNotLearned        = "Non hai ancora imparato Segreti del mestiere.",
    HardResetWarning        = "Rilevata versione vecchia o incompatibile.\n\nLe impostazioni verranno ripristinate per garantire la stabilità.",
    WarningOutdatedConfig   = "Rilevata configurazione più recente!\n\nIl profilo che stai usando è stato creato in una versione più recente di Nightveil.",
    WelcomeMessage          = "%s |cffffd100v%s|r caricato. Digita |cffffd100/veil|r per aprire le impostazioni.",
    UpdateMessage           = "%s aggiornato alla |cffffd100v%s|r! Digita |cffffd100/veil|r per vedere le novità.",
    ErrorNoValidChannel     = "|cffff2020Nessun canale di chat valido disponibile.|r",
    ErrorBlizzardAntiSpam   = "|cffff2020Le restrizioni anti-spam di Blizzard impediscono di usare il canale|r |cffffcc00%s|r |cffff2020fuori dalle istanze.|r",
    ErrorNotInGroup         = "|cffff2020Non sei in un gruppo. Canale|r |cffffcc00%s|r |cffff2020non disponibile.|r",
    ErrorNotInRaid          = "|cffff2020Non sei in un'incursione. Canale|r |cffffcc00%s|r |cffff2020non disponibile.|r",
    ErrorFollowersDungeonGroup = "|cffff2020Sei solo o in un gruppo non valido. Canale|r |cffffcc00%s|r |cffff2020non disponibile.|r",
    ErrorShroudOnlyInstances = "|cffff2020I messaggi del Manto funzionano solo all'interno delle istanze.",
    ErrorShroudInstanceOnly  = "|cffff2020Non sei all'interno di un'istanza. Canale|r |cffffcc00%s|r |cffff2020non disponibile.|r",
    CombatBlocked         = "Impossibile aprire le impostazioni durante il combattimento.",
    MacroLimitReached     = "Limite macro raggiunto.",
    MuteChanges           = "Silenziamento Modifiche",
    Next                  = "Successivo",

    -- ========================================================================
    -- [[ COMMANDS HELP ]] ----------------------------------------------------
    -- ========================================================================
    HelpSettings          = "Impostazioni",
    HelpTricks            = "Bersaglio dei Segreti",
    HelpUTricks           = "Forza aggiornamento macro",
    HelpMisdir            = "Bersaglio Depistaggio",
    HelpUMisdir           = "Forza l'aggiornamento della macro",
    HelpMisdirPet         = "Modalità Famiglio",
    HelpMisdirNormal      = "Modalità Normale",
    HelpMisdirTank        = "Modalità Difensore",
    HelpMisdirTT          = "Modalità Bersaglio del Bersaglio",
    HelpMisdirCustom      = "Modalità Personalizzata",
    HelpMisdirList        = "Elenca gruppo / per indice",
    HelpMisdirSet         = "Imposta nome personalizzato",
    HelpInfo              = "Info diagnostiche",
    HelpShroudTest        = "Testa conto alla rovescia manto",
    HelpDebugToggle       = "Attiva/Disattiva modalità debug",
    HelpTricksList        = "Elenca e imposta per indice",
    HelpTricksNormal      = "Modalità Normale",
    HelpTricksTank        = "Modalità Tank",
    HelpTricksTT          = "Modalità Bersaglio-del-Bersaglio",
    HelpTricksSet         = "Imposta per nome",
    HelpTricksCustom      = "Modalità Personalizzata",
    ErrorUnknownCmd       = "Comando sconosciuto: |cffffd100%s|r. Usa |cffffd100/veil help|r.",
    ErrorUnknownSubCmd    = "Sottocomando sconosciuto: |cffffd100%s|r. Usa |cffffd100/veil help|r.",

    -- ========================================================================
    -- [[ DEBUG INFO ]] -------------------------------------------------------
    -- ========================================================================
    DebugModeActivated   = "Modalità Debug ATTIVATA",
    DebugModeDeactivated = "Modalità Debug DISATTIVATA",
    DebugModeRequired    = "Questo comando richiede la modalità Debug. Digita |cffffd100/veil debug|r per attivarla.",
    DebugCommands        = "[Comandi di Debug]",
    DebugHeader          = "Diagnostica %s:",
    DebugCombat          = " - Combattimento: %s",
    DebugStealth         = " - Furtività/Sparizione: %s",
    DebugInstance        = " - Istanza: %s (Tipo: %s)",
    DebugGroup           = " - Gruppo: %s (Incursione: %s, Totale: %d)",
    DebugComposition     = " - Composizione: %d Giocatori, %d Mascotta, %d Altri",
    DebugTricksKnown     = " - Segreti conosciuti: %s",
    DebugTricksTarget    = " - Bersaglio dei Segreti: %s (%s)",
    DebugTricksMacro     = " - Macro dei Segreti: %s",
    DebugInvalidGroup    = " - Gruppo non valido: %s",
    DebugPlayer          = "GIOCATORE",
    DebugPet             = "MASCOTTA",
    DebugOther           = "ALTRO",
    DebugYes             = "SÌ",
    DebugNo              = "NO",
    DebugNone            = "nessuno",
    DebugUnknown         = "Sconosciuto",
    DebugFallback1       = " - Fallback 1: %s (Utilizzabile: %s)",
    DebugFallback2       = " - Fallback 2: %s (Utilizzabile: %s)",
    DebugShroudUsage     = "Utilizzo: |cffffd100/veil shroud [1-20]|r",
    DebugTricksForcing   = "Forzatura aggiornamento Segreti...",
    DebugTricksSuccess   = "Aggiornamento macro RIUSCITO.",
    DebugMacroUpdated    = "Macro aggiornata: %s",
    DebugMacroStatus     = "Macro: %s",
    DebugMacroEdited     = "Contenuto della macro modificato e sincronizzato.",
    DebugCombatLock      = "Questa azione non può essere usata in combattimento.",

    -- ========================================================================
    -- [[ NPC / GAME TERMS ]] -------------------------------------------------
    -- ========================================================================
    BrannBronzebeard = "Brann Barbabronzea",
    ValeeraSanguinar = "Valeera Sanguinar",
}
