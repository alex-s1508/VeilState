local addonName, ns = ...
local locale = GetLocale()
if locale ~= "frFR" then return end

ns.L = {
    -- ========================================================================
    -- [[ SYSTEM / GENERAL UI ]] -----------------------------------------
    -- ========================================================================
    Enable                  = "Activer",
    Management              = "Gestion",
    ReleaseNotes            = "Notes de version",
    WelcomeMessage          = "%s |cffffcc00v%s|r chargé. Tapez |cffffcc00/veil|r pour ouvrir les paramètres.",
    UpdateMessage           = "%s mis à jour en |cffffcc00v%s|r ! Tapez |cffffcc00/veil|r pour voir les nouveautés.",
    FloatingText            = "Texte flottant",

    -- ========================================================================
    -- [[ INTERFACE — Elements & Styles ]] -------------------------------
    -- ========================================================================
    Color                   = "Couleur",
    Size                    = "Taille",
    Opacity                 = "Opacité",
    Thickness               = "Épaisseur",
    Style                   = "Style",
    Layer                   = "Couche",
    LayerBackground         = "Arrière-plan",
    LayerLow                = "Basse",
    LayerMedium             = "Moyenne",
    LayerHigh               = "Haute",
    LayerDialog             = "Dialogue",
    LayerFullscreen         = "Plein écran",
    ScreenColor             = "Couleur de l'écran",
    Vignette                = "Vignette",

    -- ========================================================================
    -- [[ INTERFACE — Positioning & Anchors ]] ---------------------------
    -- ========================================================================
    AnchorPoint             = "Point d'ancrage",
    AnchorToText            = "Ancrer au texte",
    OffsetX                 = "Décalage X",
    OffsetY                 = "Décalage Y",
    AnchorTopLeft           = "Haut Gauche",
    AnchorTop               = "Haut",
    AnchorTopRight          = "Haut Droite",
    AnchorLeft              = "Gauche",
    AnchorCenter            = "Centre",
    AnchorRight             = "Droite",
    AnchorBottomLeft        = "Bas Gauche",
    AnchorBottom            = "Bas",
    AnchorBottomRight       = "Bas Droite",

    -- ========================================================================
    -- [[ INTERFACE — Icons & Multimedia ]] ------------------------------
    -- ========================================================================
    IndicatorIcon           = "Icône d'indicateur",
    IconTexture             = "Texture d'icône",
    Sound                   = "Son",
    SoundKitId              = "ID SoundKit",
    TestSound               = "Tester le son",

    -- ========================================================================
    -- [[ INTERFACE — Logic & Filters ]] ---------------------------------
    -- ========================================================================
    OnlyInInstances         = "Uniquement en instance",
    OnlyInCombat            = "Uniquement en combat",
    DisableInDungeons       = "Désactiver dans les donjons",
    DisableInRaids          = "Désactiver en raids",
    InstanceFilters         = "Filtres d'instance",

    -- ========================================================================
    -- [[ INTERFACE — Message Customization ]] ---------------------------
    -- ========================================================================
    CustomText              = "Texte personnalisé",
    Messages                = "Messages",

    -- ========================================================================
    -- [[ SHARED MODULES — Highlights ]] ---------------------------------
    -- ========================================================================
    Highlights              = "Mises en évidence",
    Highlight               = "Mise en évidence",
    HighlightGlobalDesc     = "|cffffa500Configurez la mise en évidence des personnages de manière dynamique tout au long des événements de jeu.|r",
    HighlightCombat         = "En combat",
    HighlightCombatDesc     = "Highlight style when entering combat.",
    HighlightInstance       = "En instance",
    HighlightInstanceDesc   = "Highlight style when inside a dungeon or raid.",
    HighlightHidden         = "En état de furtivité",
    HighlightHiddenDesc     = "Highlight style when in a custom stealth state.",
    HighlightStealth        = "In Stealth",
    HighlightStealthDesc    = "Highlight style when stealthed.",
    HighlightShroud         = "In Shroud of Concealment",
    HighlightShroudDesc     = "Highlight style when inside Shroud of Concealment.",
    HighlightCamouflage     = "In Camouflage",
    HighlightCamouflageDesc = "Highlight style when camouflaged.",
    HighlightProwl          = "In Prowl",
    HighlightProwlDesc      = "Highlight style when prowling.",
    HighlightOptNone        = "Aucun",
    HighlightOptCircle      = "Cercle",
    HighlightOptOutline     = "Contour",
    HighlightOptIcon        = "Icône",
    HighlightOptCircleOutline = "Cercle et Contour",
    HighlightOptCircleIcon  = "Cercle et Icône",
    HighlightOptOutlineIcon = "Contour et Icône",
    HighlightOptCircleOutlineIcon = "Cercle, Contour et Icône",

    -- ========================================================================
    -- [[ SHARED MODULES — Stealth State ]] ------------------------------
    -- ========================================================================
    StealthStateName        = "État de furtivité",
    StealthStateActiveText  = "ÉTAT FURTIF",
    EnableOnStealthState    = "Activer en état de furtivité",

    -- ========================================================================
    -- [[ SHARED MODULES — Macro System ]] -------------------------------
    -- ========================================================================
    MacroTargetHeader       = "Cible",
    MacroTargetSelector     = "Sélecteur de cible",
    MacroAutoUpdateWarning  = "|cffffa500Nightveil met à jour cette macro automatiquement.|r",
    MacroDelveCompanion     = "Compagnon de Gouffre",
    MacroCustomName         = "Cible personnalisée",
    MacroCustomSet          = "Cible personnalisée définie : %s",
    MacroGroupMembers       = "Membres du groupe :",
    MacroInvalidIndex       = "Index de groupe non valide.",
    MacroNoSelf             = "Vous ne pouvez pas vous cibler vous-même.",
    MacroBtnEnable          = "Activer et synchroniser la macro",
    MacroBtnDisable         = "Désactiver et supprimer la macro",
    Mouseover               = "Survol",
    Focus                   = "Focalisation",
    Tank                    = "Tank",
    TargetTarget            = "Cible de la cible",
    TargetingModeSet        = "Mode de ciblage défini : %s",
    Pet                     = "Familier",
    MuteChanges             = "Mute status changes",

    -- ========================================================================
    -- [[ CLASS MODULES — ROGUE ]] ---------------------------------------
    -- ========================================================================

    -- [[ Stealth ]] -------------------------------------------
    Stealth                 = "Camouflage",
    EnableOnStealth         = "Activer en Camouflage",
    StealthUseState         = "Utiliser la détection d'état",
    StealthActiveText       = "CAMOUFLÉ",

    -- [[ Poison Tracker ]] ------------------------------------
    PoisonTracker           = "Suivi des poisons",
    LethalPoisons           = "Poison mortel",
    NonLethalPoisons        = "Poison non-mortel",
    LethalPoisonMissing     = "POISON MORTEL MANQUANT",
    NonLethalPoisonMissing  = "POISON NON-MORTEL MANQUANT",

    -- [[ Tricks of the Trade ]] -------------------------------
    TricksOfTheTrade        = "Ficelles du métier",
    TricksTargetLog         = "Cible des Ficelles",
    TricksNormal            = "Normal",
    TricksCustom            = "Personnalisé",
    TricksMsgEnabled        = "Système de Ficelles activé et macro synchronisée.",
    TricksMsgDisabled       = "Système de Ficelles désactivé et macro supprimée.",
    TricksAlreadyEnabled    = "Le système de Ficelles du métier est déjà activé.",
    TricksAlreadyDisabled   = "Le système de Ficelles du métier est déjà désactivé.",

    -- [[ Shroud of Concealment ]] -----------------------------
    ShroudOfConcealment     = "Voile de camouflage",
    EnableShroudCountdown   = "Activer le compte à rebours de chat",
    ShroudMuteErrors        = "Sourdine aux erreurs",
    ChatChannel             = "Canal de chat",
    ShroudMessage           = "Message de compte à rebours",
    ShroudOnStart           = "Message de début",
    ShroudOnEnd             = "Message de fin",
    ShroudInterval          = "Mode intervalle",
    TestShroud              = "Tester le Voile",
    ShroudAlreadyActive     = "Le compte à rebours de Voile est déjà actif.",
    ShroudDisabled          = "Le compte à rebours de Voile est désactivé dans les paramètres.",

    -- ========================================================================
    -- [[ CLASS MODULES — HUNTER ]] --------------------------------------
    -- ========================================================================

    -- [[ Camouflage ]] ----------------------------------------
    Camouflage              = "Camouflage",
    EnableOnCamouflage      = "Activer sous Camouflage",
    CamouflageActiveText    = "CAMOUFLÉ",

    -- [[ Misdirection ]] --------------------------------------
    Misdirection            = "Détournement",
    MisdirTargetLog         = "Cible de Détournement",
    MisdirectionNotLearned  = "Vous n'avez pas encore appris Détournement.",
    MisdirectionMsgEnabled  = "Système de Détournement activé et macro synchronisée.",
    MisdirectionMsgDisabled = "Système de Détournement désactivé et macro supprimée.",
    MisdirectionAlreadyEnabled = "Le système de Détournement est déjà activé.",
    MisdirectionAlreadyDisabled = "Le système de Détournement est déjà désactivé.",

    -- ========================================================================
    -- [[ CLASS MODULES — DRUID ]] ---------------------------------------
    -- ========================================================================

    -- [[ Prowl ]] ---------------------------------------------
    Prowl                   = "Rôder",
    EnableOnProwl           = "Activer en Rôder",
    ProwlActiveText         = "EN RÔDE",

    -- ========================================================================
    -- [[ PROFILE MANAGEMENT ]] ------------------------------------------
    -- ========================================================================
    Profiles                = "Profils",
    ActiveProfile           = "Profil actif",
    ActiveProfileDesc       = "Select which profile to use for this character.",
    CreateProfile           = "Créer un profil",
    CreateProfileDesc       = "Create a new profile with default settings.",
    DuplicateProfile        = "Dupliquer le profil",
    DuplicateProfileDesc    = "Create a copy of the current profile.",
    DeleteProfile           = "Supprimer le profil",
    DeleteProfileDesc       = "Remove the selected profile (cannot delete Default).",
    ExportProfile           = "Exporter le profil",
    ExportProfileDesc       = "Generate a string to share this profile with others.",
    ImportProfile           = "Importer le profil",
    ImportProfileDesc       = "Import a profile from a shared string.",
    DefaultProfileLabel     = "Par défaut",
    CreateProfilePrompt     = "Entrez um nom pour le nouveau profil :",
    DuplicateProfilePrompt  = "Entrez un nom pour le profil dupliqué :",
    ExportProfilePrompt     = "Copiez cette chaîne d'exportation (Ctrl+C) :\n\nProfil : |cff00ff00%s|r",
    ImportProfilePrompt     = "Collez la chaîne d'exportation du profil ci-dessous :",
    ImportProfileNamePrompt = "Entrez un nom pour le profil importé :",
    DeleteProfileConfirm    = "Supprimer le profil :\n\n|cffff0000%s|r\n\nCela ne peut pas être annulé.",
    FactoryResetBtn         = "Réinitialisation d'usine",
    FactoryResetBtnDesc     = "Deletes all addon data and macros, restoring to a clean installation. UI will reload.",
    FactoryResetConfirm     = "|cffff0000AVERTISSEMENT :|r Cela supprimera |cffff0000TOUTES|r vos configurations et profils Nightveil, et supprimera les macros créées par l'addon.\n\nCette action est |cffff0000IRRÉVERSIBLE|r.\n\nÊtes-vous sûr de vouloir continuer ?",
    ErrorProfileDeleteRestricted = "Vous ne pouvez pas supprimer le profil par défaut.",
    Import                  = "Importer",
    Share                   = "Partager",
    Next                    = "Next",

    -- ========================================================================
    -- [[ CHAT CHANNELS ]] -----------------------------------------------
    -- ========================================================================
    ChannelSay              = "Dire",
    ChannelParty            = "Groupe",
    ChannelRaid             = "Raid",
    ChannelInstance         = "Instance",
    ChannelYell             = "Crier",

    -- ========================================================================
    -- [[ SYSTEM NOTIFICATIONS & ERRORS ]] -------------------------------
    -- ========================================================================
    ErrorHardReset          = "|cffff2020Version ancienne ou incompatible détectée.|r\n\nLes paramètres seront |cffffcc00réinitialisés|r pour garantir la stabilité.",
    WarningOutdatedConfig   = "|cffffcc00Configuration plus récente détectée !|r\n\nIl est recommandé de mettre à |cffbe89e9jour|r l'addon ou de réinitialiser le profil.",
    ErrorChannelNoValid     = "|cffff2020Aucun canal de chat valide disponible.|r",
    ErrorChannelAntiSpam    = "|cffff2020Les restrictions anti-spam de Blizzard empêchent l'utilisation du canal|r |cffffcc00%s|r |cffff2020en dehors des instances.|r",
    ErrorChannelNoGroup     = "|cffff2020Vous n'êtes pas dans un groupe. Canal|r |cffffcc00%s|r |cffff2020indisponible.|r",
    ErrorChannelNoRaid      = "|cffff2020Vous n'êtes pas dans un raid. Canal|r |cffffcc00%s|r |cffff2020indisponible.|r",
    ErrorChannelInvalidGroup = "|cffff2020Vous êtes seul ou dans un groupe non valide. Canal|r |cffffcc00%s|r |cffff2020indisponible.|r",
    ErrorChannelInstanceOnly = "|cffff2020Channel|r |cffffcc00%s|r |cffff2020unavailable outside instances.|r",
    ErrorNotRogue           = "Vous n'êtes pas un Voleur. Cette commande est réservée aux Voleurs.",
    ErrorNotHunter          = "You are not a Hunter. This command is Hunter-only.",
    ErrorTricksNotLearned   = "Vous n'avez pas encore appris les Ficelles du métier.",
    ErrorMisdirNotLearned   = "You have not learned Misdirection yet.",
    ErrorShroudOnlyInstances = "|cffff2020Les messages de Voile ne fonctionnent qu'à l'intérieur des instances.",
    ErrorCombatBlocked      = "Impossible d'ouvrir les paramètres pendant le combat.",
    ErrorMacroLimitReached  = "Limite de macro atteinte.",
    ErrorMacroCombatLock    = "This action cannot be used in combat.",
    ErrorUnknownCmd         = "Commande inconnue : |cffffcc00%s|r. Utilisez |cffffcc00/veil help|r.",
    ErrorUnknownSubCmd      = "Sous-commande inconnue : |cffffcc00%s|r. Utilisez |cffffcc00/veil help|r.",
    DebugCombatLock         = "This action cannot be used in combat.",

    -- ========================================================================
    -- [[ COMMANDS HELP ]] -----------------------------------------------
    -- ========================================================================
    HelpSettings            = "Paramètres",
    HelpTricks              = "Cible des Ficelles",
    HelpMisdir              = "Cible de Détournement",
    HelpMisdirPet           = "Pet mode",
    HelpInfo                = "Infos de diagnostic",
    HelpShroudTest          = "Tester le compte à rebours de voile",
    HelpDebugToggle         = "Basculer le mode débogage",
    HelpForceRefresh        = "Forcer le rafraîchissement de la macro",
    HelpModeNormal          = "Mode normal",
    HelpModeTank            = "Mode tank",
    HelpModeTT              = "Mode Cible-de-la-Cible",
    HelpModeCustom          = "Mode personnalisé",
    HelpModeList            = "Lister et définir par index",
    HelpModeSet             = "Définir par nom",

    -- ========================================================================
    -- [[ DEBUG & DIAGNOSTICS ]] -----------------------------------------
    -- ========================================================================
    DebugModeActivated      = "Mode débogage ACTIVÉ",
    DebugModeDeactivated    = "Mode débogage DÉSACTIVÉ",
    DebugModeRequired       = "Cette commande nécessite le mode débogage. Tapez |cffffcc00/veil debug|r pour l'activer.",
    DebugCommands           = "[Commandes de débogage]",
    DebugHeader             = "Diagnostics %s :",
    DebugCombat             = "- Combat : %s",
    DebugStealth            = "- Camouflage/Disparition : %s",
    DebugInstance           = "- Instance : %s (Type : %s)",
    DebugGroup              = "- Groupe : %s (Raid : %s, Total : %d)",
    DebugComposition        = "- Composition : %d Joueurs, %d Mascottes, %d Autres",
    DebugTricksKnown        = "- Ficelles connues : %s",
    DebugTricksTarget       = "- Cible des Ficelles : %s (%s)",
    DebugTricksMacro        = "- Macro des Ficelles : %s",
    DebugInvalidGroup       = "- Groupe non valide : %s",
    DebugPlayer             = "JOUEUR",
    DebugPet                = "MASCOTTE",
    DebugOther              = "AUTRE",
    DebugYes                = "OUI",
    DebugNo                 = "NON",
    DebugNone               = "aucun",
    DebugUnknown            = "Inconnu",
    DebugFallback1          = "- Solution de repli 1 : %s (Utilisable : %s)",
    DebugFallback2          = "- Solution de repli 2 : %s (Utilisable : %s)",
    DebugShroudUsage        = "Utilisation : |cffffcc00/veil shroud [1-20]|r",
    DebugTricksForcing      = "Forçage de la mise à jour des Ficelles...",
    DebugMisdirForcing      = "Forcing Misdirection update...",
    DebugMacroSuccess       = "Rafraîchissement de la macro RÉUSSI.",
    DebugMacroUpdated       = "Macro mise à jour : %s",
    DebugMacroStatus        = "Macro : %s",
    DebugMacroEdited        = "Contenu de la macro modifié et synchronisé.",

    -- ========================================================================
    -- [[ NPC / GAME TERMS ]] --------------------------------------------
    -- ========================================================================
    BrannBronzebeard        = "Brann Barbe-de-Bronze",
    ValeeraSanguinar        = "Valeera Sanguinar",

}
