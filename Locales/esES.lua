local addonName, ns = ...
local locale = GetLocale()
if locale ~= "esES" and locale ~= "esMX" then return end

ns.L = {
    -- ========================================================================
    -- [[ SYSTEM / GENERAL UI ]] ----------------------------------------------
    -- ========================================================================
    Enable              = "Activar",
    EnableDesc          = "Activa o desactiva esta función.",
    Management          = "Gestión",
    ReleaseNotes        = "Notas de la versión",

    -- ========================================================================
    -- [[ INTERFACE — Elements & Styles ]] ------------------------------------
    -- ========================================================================
    Color               = "Color",
    ColorDesc           = "Establece el color utilizado por este elemento.",
    Size                = "Tamaño",
    SizeDesc            = "Cambia el tamaño del elemento.",
    Opacity             = "Opacidad",
    OpacityDesc         = "Cambia la transparencia.",
    Layer               = "Capa",
    LayerDesc           = "Capa de dibujo (más alta aparece arriba).",
    LayerBackground     = "Fundo",
    LayerLow            = "Baja",
    LayerMedium         = "Media",
    LayerHigh           = "Alta",
    LayerDialog         = "Diálogo",
    LayerFullscreen     = "Pantalla completa",
    Style               = "Estilo",
    StyleDesc           = "Selecciona el estilo de resaltado.",

    -- ========================================================================
    -- [[ INTERFACE — Positioning & Anchors ]] --------------------------------
    -- ========================================================================
    OffsetX             = "Desplazamiento X",
    OffsetXDesc         = "Mueve el elemento horizontalmente.",
    OffsetY             = "Desplazamiento Y",
    OffsetYDesc         = "Mueve el elemento verticalmente.",
    AnchorToText        = "Anclar al texto",
    AnchorToTextDesc    = "Ancla el icono a la posición del texto.",
    AnchorPoint         = "Punto de anclaje",
    AnchorPointDesc     = "Lado del texto utilizado como ancla.",
    AnchorTopLeft       = "Superior izquierda",
    AnchorTop           = "Superior",
    AnchorTopRight      = "Superior derecha",
    AnchorLeft          = "Izquierda",
    AnchorCenter        = "Centro",
    AnchorRight         = "Derecha",
    AnchorBottomLeft    = "Inferior izquierda",
    AnchorBottom        = "Inferior",
    AnchorBottomRight   = "Inferior derecha",

    -- ========================================================================
    -- [[ INTERFACE — Icons & Multimedia ]] -----------------------------------
    -- ========================================================================
    IndicatorIcon       = "Icono indicador",
    EnableIconDesc      = "Muestra un indicador de icono.",
    IconTexture         = "Textura de icono",
    IconTextureDesc     = "Ruta de textura de icono personalizada.",
    Sound               = "Sonido",
    SoundDesc           = "Reproduce una alerta de sonido cuando se activa.",
    SoundKitId          = "ID de SoundKit",
    SoundKitIdDesc      = "ID de SoundKit para reproducir (número).",
    TestSound           = "Probar sonido",
    TestSoundDesc       = "Reproduce el sonido seleccionado ahora.",

    -- ========================================================================
    -- [[ INTERFACE — Message Customization ]] --------------------------------
    -- ========================================================================
    CustomText          = "Texto personalizado",
    CustomTextDesc      = "Texto de mensaje personalizado para mostrar.",
    FloatingText        = "Texto flotante",
    Messages            = "Mensagens",

    -- ========================================================================
    -- [[ INTERFACE — Logic Filters ]] ----------------------------------------
    -- ========================================================================
    OnlyInInstances     = "Solo en estancias",
    OnlyInInstancesDesc = "Solo se aplica dentro de estancias (Masmorras, Bandas, Gestas).",
    OnlyInCombat        = "Solo en combate",
    OnlyInCombatDesc    = "Solo muestra avisos mientras estás en combate.",
    DisableInDungeons   = "Desactivar en Masmorras",
    DisableInDungeonsDesc = "No se aplica cuando estás dentro de una Masmorra.",
    DisableInRaids      = "Desactivar en Bandas",
    DisableInRaidsDesc  = "No se aplica cuando estás dentro de una Banda.",
    InstanceFilters     = "Filtros de estancia",
    InstanceFiltersDesc = "Configura dónde debe desactivarse esta función.",

    -- ========================================================================
    -- [[ HIGHLIGHTS SYSTEM ]] ------------------------------------------------
    -- ========================================================================
    Highlight              = "Resaltado",
    HighlightDesc          = "Resalta tu personaje en la pantalla.",
    Highlights             = "Resaltados",
    HighlightGlobalDesc    = "|cffffa500Configura el resaltado del personaje dinámicamente durante los eventos del juego.|r",
    HighlightOptNone              = "Ninguno",
    HighlightOptCircle            = "Círculo",
    HighlightOptOutline           = "Contorno",
    HighlightOptIcon              = "Icono",
    HighlightOptCircleOutline     = "Círculo y contorno",
    HighlightOptCircleIcon        = "Círculo e icono",
    HighlightOptOutlineIcon       = "Contorno e icono",
    HighlightOptCircleOutlineIcon = "Círculo, contorno e icono",
    HighlightCombat     = "En combate",
    HighlightCombatDesc = "Resaltado utilizado durante el combate activo.",
    HighlightInstance   = "En estancia",
    HighlightInstanceDesc = "Resaltado utilizado dentro de Masmorras, Bandas o Gestas.",
    HighlightHidden     = "En estado de sigilo",
    HighlightHiddenDesc = "Resaltado utilizado cuando estás en estado de sigilo.",
    ScreenColor         = "Color de pantalla",
    ScreenColorDesc     = "Colorea la pantalla mientras está activo.",
    Vignette            = "Viñeta",
    VignetteDesc        = "Añade un efecto de viñeta alrededor de la pantalla.",
    Thickness           = "Grosor",
    ThicknessDesc       = "Controla el grosor de la viñeta.",

    -- ========================================================================
    -- [[ SHARED MODULES ]] ---------------------------------------------------
    -- ========================================================================
    -- [[ Stealth State Module ]] ---------------------------------------------
    StealthStateName        = "Estado de sigilo",
    StealthStateDesc        = "Configura efectos visuales para cuando estés en estado de sigilo.",
    StealthStateActiveText  = "ESTADO DE SIGILO",
    EnableOnStealthState    = "Activar en estado de sigilo",
    EnableOnStealthStateDesc = "Muestra efectos visuales durante cualquier estado de sigilo (usa la detección de estado de WoW).",

    -- ========================================================================
    -- [[ CLASS MODULES — ROGUE ]] --------------------------------------------
    -- ========================================================================
    -- [[ Stealth Module ]] ---------------------------------------------------
    Stealth             = "Sigilo",
    EnableOnStealth     = "Activar con Sigilo",
    EnableOnStealthDesc = "Muestra efectos visuales mientras Sigilo o Esfumar están activos.",
    StealthUseState     = "Usar detección de estado",
    StealthUseStateDesc = "Usa el estado global de sigilo en lugar de auras específicas. 'Aura' es más preciso para habilidades de clase, mientras que 'Estado' se activa en cualquier efecto similar al sigilo.",
    DefaultMessage      = "EN SIGILO",
    StealthActiveText   = "SIGILO",

    -- [[ Poison Tracker ]] ---------------------------------------------------
    PoisonTracker          = "Monitor de Venenos",
    LethalPoisons          = "Veneno letal",
    LethalPoisonsDesc      = "Muestra avisos cuando falta tu veneno letal.",
    NonLethalPoisons       = "Veneno no letal",
    NonLethalPoisonsDesc   = "Muestra avisos cuando falta tu veneno no letal.",
    LethalPoisonMissing    = "FALTA VENENO LETAL",
    NonLethalPoisonMissing = "FALTA VENENO NO LETAL",
    -- ========================================================================
    -- [[ MACRO SYSTEM (SHARED) ]] --------------------------------------------
    -- ========================================================================


    -- [[ Tricks of the Trade ]] ----------------------------------------------
    TricksOfTheTrade         = "Secretos del oficio",
    MacroTargetHeader =  "Objetivo",
    MacroTargetSelector =  "Selector de objetivo",
    MacroTargetSelectorDesc =  "Define la lógica principal para la selección automática de objetivos.",
    MacroAutoUpdateWarning =  "|cffffa500Nightveil actualiza este macro automáticamente.|r",
    TricksEnabledDesc        = "Activa el direccionamiento automatizado para Secretos del oficio usando un macro.",
    MacroMouseoverDesc =  "Activa el direccionamiento vía mouseover.\n\nNota: Esto tiene prioridad sobre todos los otros métodos, excepto el compañero de inmersión.",
    MacroFocusDesc =  "Permite el direccionamiento automatizado a través del foco.\n\nNota: Esto tiene prioridad sobre el selector de objetivos, pero es ignorado por el mouseover o el compañero de inmersión.",
    MacroMuteDesc =  "Oculta notificaciones de chat cuando el macro cambia de objetivo.",
    MacroDelveCompanion =  "Compañero de inmersión",
    MacroDelveCompanionDesc =  "Selecciona automáticamente a Brann Barbabronce o Valeera Sanguinar dentro de las inmersiones.\n\nNota: Esto tiene prioridad exclusiva dentro de las inmersiones.",
    TricksTargetLog          = "Objetivo de Secretos",
    TricksNormal             = "Normal",
    TricksCustom             = "Personalizado",
    MacroCustomName =  "Objetivo personalizado",
    MacroCustomNameDesc =  "Introduce el nombre exacto del jugador.",
    MacroCustomSet =  "Objetivo personalizado establecido: %s",
    MacroGroupMembers =  "Miembros del grupo:",
    MacroInvalidIndex =  "Índice de grupo no válido.",
    MacroNoSelf =  "No puedes seleccionarte a ti mismo.",
    MacroBtnEnable =  "Activar y sincronizar macro",
    MacroBtnDisable =  "Desactivar y eliminar macro",
    MacroBtnDisableDesc =  "Desactiva el direccionamiento automatizado y devuelve el macro a su estado anterior.",
    TricksMsgEnabled         = "Sistema de Secretos activado y macro sincronizado.",
    TricksMsgDisabled        = "Sistema de Secretos desactivado y macro eliminado.",
    TricksAlreadyEnabled     = "El sistema de Secretos del oficio ya está activado.",
    TricksAlreadyDisabled    = "El sistema de Secretos del oficio ya está desactivado.",
    TricksLogicSet           = "Modo de objetivo establecido: %s",
    Mouseover                = "Pasar ratón",
    Focus                    = "Foco",
    Tank                     = "Tanque",
    TargetTarget             = "Objetivo del objetivo",

    -- [[ Shroud of Concealment ]] --------------------------------------------
    ShroudOfConcealment      = "Embozo de encubrimiento",
    EnableShroudCountdown    = "Activar cuenta en el chat",
    EnableShroudCountdownDesc = "Envía mensajes de cuenta atrás de Embozo al chat.",
    ShroudOnlyInstancesDesc  = "Solo envía mensajes de Embozo dentro de estancias.\n\nNota: algunos canales están bloqueados fuera de estancias por el anti-spam de Blizzard.",
    ShroudMuteErrors         = "Silenciar errores",
    ShroudMuteErrorsDesc     = "Desactiva los mensajes de error de Embozo en el chat.",
    ChatChannel              = "Canal de chat",
    ChatChannelDesc          = "Canal de chat principal utilizado para los mensajes de Embozo.",
    ChatChannelFallbackDesc  = "Canal alternativo utilizado si el principal no está disponible.",
    ShroudMessage            = "Mensaje de cuenta atrás",
    ShroudMessageDesc        = "Plantilla de mensaje utilizada durante la cuenta atrás.\n\n%time = tiempo restante.",
    ShroudOnStart            = "Mensaje de inicio",
    ShroudOnStartDesc        = "Mensaje enviado cuando comienza Embozo.",
    ShroudOnEnd              = "Mensaje de fin",
    ShroudOnEndDesc          = "Mensaje enviado cuando termina Embozo (0s).",
    ShroudInterval           = "Modo de intervalo",
    ShroudIntervalDesc       = "Inicio, intermedio y últimos 5s",
    TimeRemainingHint        = "%time = tiempo restante",
    TestShroud               = "Probar Embozo",
    TestShroudDesc           = "Simula una cuenta atrás local de 5 segundos.\n\nNota: Los mensajes aparecen solo para ti.",
    ShroudAlreadyActive      = "La cuenta atrás de Embozo ya está activa.",
    ShroudDisabled           = "La cuenta de Embozo está desactivada en los ajustes.",
    ChannelSay               = "Decir",
    ChannelParty             = "Grupo",
    ChannelRaid              = "Banda",
    ChannelInstance          = "Estancia",
    ChannelYell              = "Gritar",

    -- ========================================================================
    
    -- ========================================================================
    -- [[ CLASS MODULES — HUNTER ]] --------------------------------------------
    -- ========================================================================
    -- [[ Camouflage Module ]] -------------------------------------------------
    Camouflage              = "Camuflaje",
    EnableOnCamouflage      = "Activar en Camuflaje",
    EnableOnCamouflageDesc  = "Muestra indicaciones visuales mientras Camuflaje está activo.",
    CamouflageActiveText    = "CAMUFLADO",

    -- [[ Misdirection ]] ------------------------------------------------------
    Misdirection                = "Redirección",
    MisdirEnabledDesc           = "Activa el direccionamiento automático para Redirección mediante un macro.",
    MisdirTargetLog             = "Objetivo de Redirección",
    MisdirectionNotLearned      = "Aún no has aprendido Redirección.",
    MisdirectionMsgEnabled      = "Sistema de Redirección activado y macro sincronizado.",
    MisdirectionMsgDisabled     = "Sistema de Redirección desactivado y macro eliminado.",
    MisdirectionAlreadyEnabled  = "El sistema de Redirección ya está activado.",
    MisdirectionAlreadyDisabled = "El sistema de Redirección ya está desactivado.",
    MisdirLogicSet              = "Modo de objetivo establecido: %s",
    MisdirNotLearned            = "Aún no has aprendido Redirección.",
    Pet                         = "Mascota",

    -- [[ PROFILE MANAGEMENT ]] -----------------------------------------------
    -- ========================================================================
    Profiles              = "Perfiles",
    ActiveProfile         = "Perfil activo",
    ActiveProfileDesc     = "Selecciona qué perfil está activo.",
    CreateProfile         = "Crear perfil",
    CreateProfileDesc     = "Crea un nuevo perfil con la configuración predeterminada.",
    DuplicateProfile      = "Duplicar perfil",
    DuplicateProfileDesc  = "Copia el perfil actual a uno nuevo.",
    DeleteProfile         = "Eliminar perfil",
    DeleteProfileDesc     = "Elimina el perfil seleccionado (no se puede deshacer).",
    ExportProfile         = "Exportar perfil",
    ExportProfileDesc     = "Genera una cadena para compartir este perfil.",
    ImportProfile         = "Importar perfil",
    ImportProfileDesc     = "Importa un perfil desde una cadena exportada.",
    CreateProfilePrompt   = "Introduce un nombre para the nuevo perfil:",
    DuplicateProfilePrompt = "Introduce un nombre para el perfil duplicado:",
    FactoryResetBtn       = "Restablecimiento de fábrica",
    FactoryResetBtnDesc   = "Elimina todos los datos del complemento y macros, restaurando una instalación limpia. La interfaz se recargará.",
    FactoryResetConfirm   = "|cffff0000ADVERTENCIA:|r Esto eliminará |cffff0000TODAS|r tus configuraciones y perfiles de Nightveil, además de borrar los macros creados por el complemento.\n\nEsta acción es |cffff0000IRREVERSIBLE|r.\n\n¿Estás seguro de que deseas continuar?",
    DeleteProfileConfirm  = "Eliminar perfil:\n\n|cffff0000%s|r\n\nEsto no se puede deshacer.",
    ExportProfilePrompt   = "Copia esta cadena de exportación (Ctrl+C):\n\nPerfil: |cff00ff00%s|r",
    ImportProfilePrompt   = "Pega la cadena de exportación del perfil a continuación:",
    ImportProfileNamePrompt = "Introduce un nombre para o perfil importado:",
    ErrorDeleteRestricted = "No puedes eliminar o perfil Predeterminado.",
    DefaultProfileLabel   = "Predeterminado",
    Import                = "Importar",
    Share                 = "Compartir",

    -- ========================================================================
    -- [[ SYSTEM MESSAGES & WARNINGS ]] ---------------------------------------
    -- ========================================================================
    WarningNotRogue         = "No eres un Pícaro. Este comando es exclusivo de Pícaros.",
    TricksNotLearned        = "Aún no has aprendido Secretos del oficio.",
    HardResetWarning        = "Versión antigua o incompatible detectada.\n\nLa configuración se restablecerá para garantizar la estabilidad.",
    WarningOutdatedConfig   = "¡Configuración más reciente detectada!\n\nEl perfil que estás usando fue creado en una versión más reciente de Nightveil.",
    WelcomeMessage          = "%s |cffffd100v%s|r cargado. Escribe |cffffd100/veil|r para abrir los ajustes.",
    UpdateMessage           = "¡%s actualizado a |cffffd100v%s|r! Escribe |cffffd100/veil|r para ver las novedades.",
    ErrorNoValidChannel     = "|cffff2020No hay ningún canal de chat válido disponible.|r",
    ErrorBlizzardAntiSpam   = "|cffff2020Las restricciones anti-spam de Blizzard impiden el uso del canal|r |cffffcc00%s|r |cffff2020fuera de estancias.|r",
    ErrorNotInGroup         = "|cffff2020No estás en un grupo. Canal|r |cffffcc00%s|r |cffff2020no disponible.|r",
    ErrorNotInRaid          = "|cffff2020No estás en una banda. Canal|r |cffffcc00%s|r |cffff2020no disponible.|r",
    ErrorFollowersDungeonGroup = "|cffff2020Estás solo o en un grupo no válido. Canal|r |cffffcc00%s|r |cffff2020no disponible.|r",
    ErrorShroudOnlyInstances = "|cffff2020Los mensajes de Embozo solo funcionan dentro de estancias.",
    ErrorShroudInstanceOnly  = "|cffff2020No estás dentro de una estancia. Canal|r |cffffcc00%s|r |cffff2020no disponible.|r",
    CombatBlocked         = "No se pueden abrir los ajustes durante el combate.",
    MacroLimitReached     = "Límite de macros alcanzado.",
    MuteChanges           = "Silenciar cambios",
    Next                  = "Siguiente",

    -- ========================================================================
    -- [[ COMMANDS HELP ]] ----------------------------------------------------
    -- ========================================================================
    HelpSettings          = "Ajustes",
    HelpTricks            = "Objetivo de Secretos",
    HelpUTricks           = "Forzar actualización de macro",
    HelpMisdir            = "Objetivo de Redirección",
    HelpUMisdir           = "Forzar actualización de macro",
    HelpMisdirPet         = "Modo Mascota",
    HelpMisdirNormal      = "Modo Normal",
    HelpMisdirTank        = "Modo Tanque",
    HelpMisdirTT          = "Modo Objetivo del objetivo",
    HelpMisdirCustom      = "Modo Personalizado",
    HelpMisdirList        = "Listar grupo / establecer por índice",
    HelpMisdirSet         = "Establecer por nombre",
    HelpInfo              = "Info de diagnóstico",
    HelpShroudTest        = "Probar cuenta de Embozo",
    HelpDebugToggle       = "Alternar modo depuración",
    HelpTricksList        = "Lista y establecer por índice",
    HelpTricksNormal      = "Modo normal",
    HelpTricksTank        = "Modo tanque",
    HelpTricksTT          = "Modo objetivo del objetivo",
    HelpTricksSet         = "Establecer por nombre",
    HelpTricksCustom      = "Modo personalizado",
    ErrorUnknownCmd       = "Comando desconocido: |cffffd100%s|r. Usa |cffffd100/veil help|r.",
    ErrorUnknownSubCmd    = "Sub-comando desconocido: |cffffd100%s|r. Usa |cffffd100/veil help|r.",

    -- ========================================================================
    -- [[ DEBUG INFO ]] -------------------------------------------------------
    -- ========================================================================
    DebugModeActivated   = "Modo depuración ACTIVADO",
    DebugModeDeactivated = "Modo depuración DESACTIVADO",
    DebugModeRequired    = "Este comando requiere el modo depuración. Escribe |cffffd100/veil debug|r para activarlo.",
    DebugCommands        = "[Comandos de depuración]",
    DebugHeader          = "Diagnóstico %s:",
    DebugCombat          = " - Combate: %s",
    DebugStealth         = " - Sigilo/Esfumar: %s",
    DebugInstance        = " - Estancia: %s (Tipo: %s)",
    DebugGroup           = " - Grupo: %s (Banda: %s, Total: %d)",
    DebugComposition     = " - Composición: %d Jugadores, %d Mascotas, %d Otros",
    DebugTricksKnown     = " - Secretos conocidos: %s",
    DebugTricksTarget    = " - Objetivo de Secretos: %s (%s)",
    DebugTricksMacro     = " - Macro de Secretos: %s",
    DebugInvalidGroup    = " - Grupo no válido: %s",
    DebugPlayer          = "JOGADOR",
    DebugPet             = "MASCOTA",
    DebugOther           = "OTRO",
    DebugYes             = "SÍ",
    DebugNo              = "NO",
    DebugNone            = "ninguno",
    DebugUnknown         = "Desconocido",
    DebugFallback1       = " - Fallback 1: %s (Utilizable: %s)",
    DebugFallback2       = " - Fallback 2: %s (Utilizable: %s)",
    DebugShroudUsage     = "Uso: |cffffd100/veil shroud [1-20]|r",
    DebugTricksForcing   = "Forzando actualización de Secretos...",
    DebugTricksSuccess   = "Actualización de macro completada con ÉXITO.",
    DebugMacroUpdated    = "Macro actualizado: %s",
    DebugMacroStatus     = "Macro: %s",
    DebugMacroEdited     = "Contenido de macro modificado y sincronizado.",
    DebugCombatLock      = "Esta acción no se puede usar en combate.",

    -- ========================================================================
    -- [[ NPC / GAME TERMS ]] -------------------------------------------------
    -- ========================================================================
    BrannBronzebeard = "Brann Barbabronze",
    ValeeraSanguinar = "Valeera Sanguinar",
}

if locale == "esMX" then
    ns.L.OnlyInInstances          = "Solo en estancias"
    ns.L.OnlyInInstancesDesc      = "Solo se activa dentro de estancias (Masmorras, Bandas, Gestas)."
    ns.L.ChannelInstance          = "Estancia"
    ns.L.ShroudOnlyInstancesDesc  = "Solo envía mensajes de Embozo dentro de estancias."
    ns.L.ErrorShroudOnlyInstances = "|cffff2020Los mensajes de Embozo solo funcionan dentro de estancias.|r"
    ns.L.ErrorShroudInstanceOnly  = "|cffff2020No estás dentro de una estancia. Canal|r |cffffcc00%s|r |cffff2020no disponible.|r"
end
