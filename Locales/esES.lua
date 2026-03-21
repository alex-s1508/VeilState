local addonName, ns = ...
local locale = GetLocale()
if locale ~= "esES" then return end

ns.L = {
    -- ========================================================================
    -- [[ SYSTEM / GENERAL UI ]] -----------------------------------------
    -- ========================================================================
    Enable                  = "Activar",
    Management              = "Gestión",
    ReleaseNotes            = "Notas de la versión",
    WelcomeMessage          = "%s |cffffcc00v%s|r cargado. Escribe |cffffcc00/veil|r para abrir los ajustes.",
    UpdateMessage           = "¡%s actualizado a |cffffcc00v%s|r! Escribe |cffffcc00/veil|r para ver las novedades.",
    FloatingText            = "Texto flotante",

    -- ========================================================================
    -- [[ INTERFACE — Elements & Styles ]] -------------------------------
    -- ========================================================================
    Color                   = "Color",
    Size                    = "Tamaño",
    Opacity                 = "Opacidad",
    Thickness               = "Grosor",
    Style                   = "Estilo",
    Layer                   = "Capa",
    LayerBackground         = "Fundo",
    LayerLow                = "Baja",
    LayerMedium             = "Media",
    LayerHigh               = "Alta",
    LayerDialog             = "Diálogo",
    LayerFullscreen         = "Pantalla completa",
    ScreenColor             = "Color de pantalla",
    Vignette                = "Viñeta",

    -- ========================================================================
    -- [[ INTERFACE — Positioning & Anchors ]] ---------------------------
    -- ========================================================================
    AnchorPoint             = "Punto de anclaje",
    AnchorToText            = "Anclar al texto",
    OffsetX                 = "Desplazamiento X",
    OffsetY                 = "Desplazamiento Y",
    AnchorTopLeft           = "Superior izquierda",
    AnchorTop               = "Superior",
    AnchorTopRight          = "Superior derecha",
    AnchorLeft              = "Izquierda",
    AnchorCenter            = "Centro",
    AnchorRight             = "Derecha",
    AnchorBottomLeft        = "Inferior izquierda",
    AnchorBottom            = "Inferior",
    AnchorBottomRight       = "Inferior derecha",

    -- ========================================================================
    -- [[ INTERFACE — Icons & Multimedia ]] ------------------------------
    -- ========================================================================
    IndicatorIcon           = "Icono indicador",
    IconTexture             = "Textura de icono",
    Sound                   = "Sonido",
    SoundKitId              = "ID de SoundKit",
    TestSound               = "Probar sonido",

    -- ========================================================================
    -- [[ INTERFACE — Logic & Filters ]] ---------------------------------
    -- ========================================================================
    OnlyInInstances         = "Solo en estancias",
    OnlyInCombat            = "Solo en combate",
    DisableInDungeons       = "Desactivar en Masmorras",
    DisableInRaids          = "Desactivar en Bandas",
    InstanceFilters         = "Filtros de estancia",

    -- ========================================================================
    -- [[ INTERFACE — Message Customization ]] ---------------------------
    -- ========================================================================
    CustomText              = "Texto personalizado",
    Messages                = "Mensagens",

    -- ========================================================================
    -- [[ SHARED MODULES — Highlights ]] ---------------------------------
    -- ========================================================================
    Highlights              = "Resaltados",
    Highlight               = "Resaltado",
    HighlightGlobalDesc     = "|cffffa500Configura el resaltado del personaje dinámicamente durante los eventos del juego.|r",
    HighlightCombat         = "En combate",
    HighlightCombatDesc     = "Highlight style when entering combat.",
    HighlightInstance       = "En estancia",
    HighlightInstanceDesc   = "Highlight style when inside a dungeon or raid.",
    HighlightHidden         = "En estado de sigilo",
    HighlightHiddenDesc     = "Highlight style when in a custom stealth state.",
    HighlightStealth        = "In Stealth",
    HighlightStealthDesc    = "Highlight style when stealthed.",
    HighlightShroud         = "In Shroud of Concealment",
    HighlightShroudDesc     = "Highlight style when inside Shroud of Concealment.",
    HighlightCamouflage     = "In Camouflage",
    HighlightCamouflageDesc = "Highlight style when camouflaged.",
    HighlightProwl          = "In Prowl",
    HighlightProwlDesc      = "Highlight style when prowling.",
    HighlightOptNone        = "Ninguno",
    HighlightOptCircle      = "Círculo",
    HighlightOptOutline     = "Contorno",
    HighlightOptIcon        = "Icono",
    HighlightOptCircleOutline = "Círculo y contorno",
    HighlightOptCircleIcon  = "Círculo e icono",
    HighlightOptOutlineIcon = "Contorno e icono",
    HighlightOptCircleOutlineIcon = "Círculo, contorno e icono",

    -- ========================================================================
    -- [[ SHARED MODULES — Stealth State ]] ------------------------------
    -- ========================================================================
    StealthStateName        = "Estado de sigilo",
    StealthStateActiveText  = "ESTADO DE SIGILO",
    EnableOnStealthState    = "Activar en estado de sigilo",

    -- ========================================================================
    -- [[ SHARED MODULES — Macro System ]] -------------------------------
    -- ========================================================================
    MacroTargetHeader       = "Objetivo",
    MacroTargetSelector     = "Selector de objetivo",
    MacroAutoUpdateWarning  = "|cffffa500Nightveil actualiza este macro automáticamente.|r",
    MacroDelveCompanion     = "Compañero de inmersión",
    MacroCustomName         = "Objetivo personalizado",
    MacroCustomSet          = "Objetivo personalizado establecido: %s",
    MacroGroupMembers       = "Miembros del grupo:",
    MacroInvalidIndex       = "Índice de grupo no válido.",
    MacroNoSelf             = "No puedes seleccionarte a ti mismo.",
    MacroBtnEnable          = "Activar y sincronizar macro",
    MacroBtnDisable         = "Desactivar y eliminar macro",
    Mouseover               = "Pasar ratón",
    Focus                   = "Foco",
    Tank                    = "Tanque",
    TargetTarget            = "Objetivo del objetivo",
    TargetingModeSet        = "Modo de objetivo establecido: %s",
    Pet                     = "Mascota",
    MuteChanges             = "Mute status changes",

    -- ========================================================================
    -- [[ CLASS MODULES — ROGUE ]] ---------------------------------------
    -- ========================================================================

    -- [[ Stealth ]] -------------------------------------------
    Stealth                 = "Sigilo",
    EnableOnStealth         = "Activar con Sigilo",
    StealthUseState         = "Usar detección de estado",
    StealthActiveText       = "SIGILO",

    -- [[ Poison Tracker ]] ------------------------------------
    PoisonTracker           = "Monitor de Venenos",
    LethalPoisons           = "Veneno letal",
    NonLethalPoisons        = "Veneno no letal",
    LethalPoisonMissing     = "FALTA VENENO LETAL",
    NonLethalPoisonMissing  = "FALTA VENENO NO LETAL",

    -- [[ Tricks of the Trade ]] -------------------------------
    TricksOfTheTrade        = "Secretos del oficio",
    TricksTargetLog         = "Objetivo de Secretos",
    TricksNormal            = "Normal",
    TricksCustom            = "Personalizado",
    TricksMsgEnabled        = "Sistema de Secretos activado y macro sincronizado.",
    TricksMsgDisabled       = "Sistema de Secretos desactivado y macro eliminado.",
    TricksAlreadyEnabled    = "El sistema de Secretos del oficio ya está activado.",
    TricksAlreadyDisabled   = "El sistema de Secretos del oficio ya está desactivado.",

    -- [[ Shroud of Concealment ]] -----------------------------
    ShroudOfConcealment     = "Embozo de encubrimiento",
    EnableShroudCountdown   = "Activar cuenta en el chat",
    ShroudMuteErrors        = "Silenciar errores",
    ChatChannel             = "Canal de chat",
    ShroudMessage           = "Mensaje de cuenta atrás",
    ShroudOnStart           = "Mensaje de inicio",
    ShroudOnEnd             = "Mensaje de fin",
    ShroudInterval          = "Modo de intervalo",
    TestShroud              = "Probar Embozo",
    ShroudAlreadyActive     = "La cuenta atrás de Embozo ya está activa.",
    ShroudDisabled          = "La cuenta de Embozo está desactivada en los ajustes.",

    -- ========================================================================
    -- [[ CLASS MODULES — HUNTER ]] --------------------------------------
    -- ========================================================================

    -- [[ Camouflage ]] ----------------------------------------
    Camouflage              = "Camuflaje",
    EnableOnCamouflage      = "Activar en Camuflaje",
    CamouflageActiveText    = "CAMUFLADO",

    -- [[ Misdirection ]] --------------------------------------
    Misdirection            = "Redirección",
    MisdirTargetLog         = "Objetivo de Redirección",
    MisdirectionNotLearned  = "Aún no has aprendido Redirección.",
    MisdirectionMsgEnabled  = "Sistema de Redirección activado y macro sincronizado.",
    MisdirectionMsgDisabled = "Sistema de Redirección desactivado y macro eliminado.",
    MisdirectionAlreadyEnabled = "El sistema de Redirección ya está activado.",
    MisdirectionAlreadyDisabled = "El sistema de Redirección ya está desactivado.",

    -- ========================================================================
    -- [[ CLASS MODULES — DRUID ]] ---------------------------------------
    -- ========================================================================

    -- [[ Prowl ]] ---------------------------------------------
    Prowl                   = "Acechar",
    EnableOnProwl           = "Activar al Acechar",
    ProwlActiveText         = "ACECHANDO",

    -- ========================================================================
    -- [[ PROFILE MANAGEMENT ]] ------------------------------------------
    -- ========================================================================
    Profiles                = "Perfiles",
    ActiveProfile           = "Perfil activo",
    ActiveProfileDesc       = "Select which profile to use for this character.",
    CreateProfile           = "Crear perfil",
    CreateProfileDesc       = "Create a new profile with default settings.",
    DuplicateProfile        = "Duplicar perfil",
    DuplicateProfileDesc    = "Create a copy of the current profile.",
    DeleteProfile           = "Eliminar perfil",
    DeleteProfileDesc       = "Remove the selected profile (cannot delete Default).",
    ExportProfile           = "Exportar perfil",
    ExportProfileDesc       = "Generate a string to share this profile with others.",
    ImportProfile           = "Importar perfil",
    ImportProfileDesc       = "Import a profile from a shared string.",
    DefaultProfileLabel     = "Predeterminado",
    CreateProfilePrompt     = "Introduce un nombre para the nuevo perfil:",
    DuplicateProfilePrompt  = "Introduce un nombre para el perfil duplicado:",
    ExportProfilePrompt     = "Copia esta cadena de exportación (Ctrl+C):\n\nPerfil: |cff00ff00%s|r",
    ImportProfilePrompt     = "Pega la cadena de exportación del perfil a continuación:",
    ImportProfileNamePrompt = "Introduce un nombre para o perfil importado:",
    DeleteProfileConfirm    = "Eliminar perfil:\n\n|cffff0000%s|r\n\nEsto no se puede deshacer.",
    FactoryResetBtn         = "Restablecimiento de fábrica",
    FactoryResetBtnDesc     = "Deletes all addon data and macros, restoring to a clean installation. UI will reload.",
    FactoryResetConfirm     = "|cffff0000ADVERTENCIA:|r Esto eliminará |cffff0000TODAS|r tus configuraciones y perfiles de Nightveil, además de borrar los macros creados por el complemento.\n\nEsta acción es |cffff0000IRREVERSIBLE|r.\n\n¿Estás seguro de que deseas continuar?",
    ErrorProfileDeleteRestricted = "No puedes eliminar o perfil Predeterminado.",
    Import                  = "Importar",
    Share                   = "Compartir",
    Next                    = "Next",

    -- ========================================================================
    -- [[ CHAT CHANNELS ]] -----------------------------------------------
    -- ========================================================================
    ChannelSay              = "Decir",
    ChannelParty            = "Grupo",
    ChannelRaid             = "Banda",
    ChannelInstance         = "Estancia",
    ChannelYell             = "Gritar",

    -- ========================================================================
    -- [[ SYSTEM NOTIFICATIONS & ERRORS ]] -------------------------------
    -- ========================================================================
    ErrorHardReset          = "|cffff2020Se ha detectado una versión antigua o incompatible.|r\n\nLos ajustes se |cffffcc00reiniciarán|r para garantizar la estabilidad.",
    WarningOutdatedConfig   = "|cffffcc00¡Se ha detectado una configuración más reciente!|r\n\nSe recomienda |cffbe89e9actualizar|r el addon o reiniciar el perfil.",
    ErrorChannelNoValid     = "|cffff2020No hay ningún canal de chat válido disponible.|r",
    ErrorChannelAntiSpam    = "|cffff2020Las restricciones anti-spam de Blizzard impiden el uso del canal|r |cffffcc00%s|r |cffff2020fuera de estancias.|r",
    ErrorChannelNoGroup     = "|cffff2020No estás en un grupo. Canal|r |cffffcc00%s|r |cffff2020no disponible.|r",
    ErrorChannelNoRaid      = "|cffff2020No estás en una banda. Canal|r |cffffcc00%s|r |cffff2020no disponible.|r",
    ErrorChannelInvalidGroup = "|cffff2020Estás solo o en un grupo no válido. Canal|r |cffffcc00%s|r |cffff2020no disponible.|r",
    ErrorChannelInstanceOnly = "|cffff2020Channel|r |cffffcc00%s|r |cffff2020unavailable outside instances.|r",
    ErrorNotRogue           = "No eres un Pícaro. Este comando es exclusivo de Pícaros.",
    ErrorNotHunter          = "You are not a Hunter. This command is Hunter-only.",
    ErrorTricksNotLearned   = "Aún no has aprendido Secretos del oficio.",
    ErrorMisdirNotLearned   = "You have not learned Misdirection yet.",
    ErrorShroudOnlyInstances = "|cffff2020Los mensajes de Embozo solo funcionan dentro de estancias.",
    ErrorCombatBlocked      = "No se pueden abrir los ajustes durante el combate.",
    ErrorMacroLimitReached  = "Límite de macros alcanzado.",
    ErrorMacroCombatLock    = "This action cannot be used in combat.",
    ErrorUnknownCmd         = "Comando desconocido: |cffffcc00%s|r. Usa |cffffcc00/veil help|r.",
    ErrorUnknownSubCmd      = "Sub-comando desconocido: |cffffcc00%s|r. Usa |cffffcc00/veil help|r.",
    DebugCombatLock         = "This action cannot be used in combat.",

    -- ========================================================================
    -- [[ COMMANDS HELP ]] -----------------------------------------------
    -- ========================================================================
    HelpSettings            = "Ajustes",
    HelpTricks              = "Objetivo de Secretos",
    HelpMisdir              = "Objetivo de Redirección",
    HelpMisdirPet           = "Pet mode",
    HelpInfo                = "Info de diagnóstico",
    HelpShroudTest          = "Probar cuenta de Embozo",
    HelpDebugToggle         = "Alternar modo depuración",
    HelpForceRefresh        = "Forzar actualización de macro",
    HelpModeNormal          = "Modo normal",
    HelpModeTank            = "Modo tanque",
    HelpModeTT              = "Modo objetivo del objetivo",
    HelpModeCustom          = "Modo personalizado",
    HelpModeList            = "Lista y establecer por índice",
    HelpModeSet             = "Establecer por nombre",

    -- ========================================================================
    -- [[ DEBUG & DIAGNOSTICS ]] -----------------------------------------
    -- ========================================================================
    DebugModeActivated      = "Modo depuración ACTIVADO",
    DebugModeDeactivated    = "Modo depuración DESACTIVADO",
    DebugModeRequired       = "Este comando requiere el modo depuración. Escribe |cffffcc00/veil debug|r para activarlo.",
    DebugCommands           = "[Comandos de depuración]",
    DebugHeader             = "Diagnóstico %s:",
    DebugCombat             = "- Combate: %s",
    DebugStealth            = "- Sigilo/Esfumar: %s",
    DebugInstance           = "- Estancia: %s (Tipo: %s)",
    DebugGroup              = "- Grupo: %s (Banda: %s, Total: %d)",
    DebugComposition        = "- Composición: %d Jugadores, %d Mascotas, %d Otros",
    DebugTricksKnown        = "- Secretos conocidos: %s",
    DebugTricksTarget       = "- Objetivo de Secretos: %s (%s)",
    DebugTricksMacro        = "- Macro de Secretos: %s",
    DebugInvalidGroup       = "- Grupo no válido: %s",
    DebugPlayer             = "JOGADOR",
    DebugPet                = "MASCOTA",
    DebugOther              = "OTRO",
    DebugYes                = "SÍ",
    DebugNo                 = "NO",
    DebugNone               = "ninguno",
    DebugUnknown            = "Desconocido",
    DebugFallback1          = "- Fallback 1: %s (Utilizable: %s)",
    DebugFallback2          = "- Fallback 2: %s (Utilizable: %s)",
    DebugShroudUsage        = "Uso: |cffffcc00/veil shroud [1-20]|r",
    DebugTricksForcing      = "Forzando actualización de Secretos...",
    DebugMisdirForcing      = "Forcing Misdirection update...",
    DebugMacroSuccess       = "Actualización de macro completada con ÉXITO.",
    DebugMacroUpdated       = "Macro actualizado: %s",
    DebugMacroStatus        = "Macro: %s",
    DebugMacroEdited        = "Contenido de macro modificado y sincronizado.",

    -- ========================================================================
    -- [[ NPC / GAME TERMS ]] --------------------------------------------
    -- ========================================================================
    BrannBronzebeard        = "Brann Barbabronze",
    ValeeraSanguinar        = "Valeera Sanguinar",

}
