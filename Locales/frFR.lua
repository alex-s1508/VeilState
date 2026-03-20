local addonName, ns = ...
local locale = GetLocale()
if locale ~= "frFR" then return end

ns.L = {
    -- ========================================================================
    -- [[ SYSTEM / GENERAL UI ]] ----------------------------------------------
    -- ========================================================================
    Enable              = "Activer",
    EnableDesc          = "Active ou désactive cette fonctionnalité.",
    Management          = "Gestion",
    ReleaseNotes        = "Notes de version",

    -- ========================================================================
    -- [[ INTERFACE — Elements & Styles ]] ------------------------------------
    -- ========================================================================
    Color               = "Couleur",
    ColorDesc           = "Définit la couleur utilisée par cet élément.",
    Size                = "Taille",
    SizeDesc            = "Modifie la taille de l'élément.",
    Opacity             = "Opacité",
    OpacityDesc         = "Modifie la transparence.",
    Layer               = "Couche",
    LayerDesc           = "Couche de dessin (une valeur plus élevée apparaît au-dessus).",
    LayerBackground     = "Arrière-plan",
    LayerLow            = "Basse",
    LayerMedium         = "Moyenne",
    LayerHigh           = "Haute",
    LayerDialog         = "Dialogue",
    LayerFullscreen     = "Plein écran",
    Style               = "Style",
    StyleDesc           = "Sélectionne le style de mise en évidence.",

    -- ========================================================================
    -- [[ INTERFACE — Positioning & Anchors ]] --------------------------------
    -- ========================================================================
    OffsetX             = "Décalage X",
    OffsetXDesc         = "Déplace l'élément horizontalement.",
    OffsetY             = "Décalage Y",
    OffsetYDesc         = "Déplace l'élément verticalement.",
    AnchorToText        = "Ancrer au texte",
    AnchorToTextDesc    = "Ancre l'icône à la position du texte.",
    AnchorPoint         = "Point d'ancrage",
    AnchorPointDesc     = "Côté du texte utilisé comme ancre.",
    AnchorTopLeft       = "Haut Gauche",
    AnchorTop           = "Haut",
    AnchorTopRight      = "Haut Droite",
    AnchorLeft          = "Gauche",
    AnchorCenter        = "Centre",
    AnchorRight         = "Droite",
    AnchorBottomLeft    = "Bas Gauche",
    AnchorBottom        = "Bas",
    AnchorBottomRight   = "Bas Droite",

    -- ========================================================================
    -- [[ INTERFACE — Icons & Multimedia ]] -----------------------------------
    -- ========================================================================
    IndicatorIcon       = "Icône d'indicateur",
    EnableIconDesc      = "Affiche un indicateur d'icône.",
    IconTexture         = "Texture d'icône",
    IconTextureDesc     = "Chemin de la texture d'icône personnalisée.",
    Sound               = "Son",
    SoundDesc           = "Joue une alerte sonore lorsqu'elle est activée.",
    SoundKitId          = "ID SoundKit",
    SoundKitIdDesc      = "ID SoundKit à jouer (nombre).",
    TestSound           = "Tester le son",
    TestSoundDesc       = "Joue le son sélectionné maintenant.",

    -- ========================================================================
    -- [[ INTERFACE — Message Customization ]] --------------------------------
    -- ========================================================================
    CustomText          = "Texte personnalisé",
    CustomTextDesc      = "Texte du message personnalisé à afficher.",
    FloatingText        = "Texte flottant",
    Messages            = "Messages",

    -- ========================================================================
    -- [[ INTERFACE — Logic Filters ]] ----------------------------------------
    -- ========================================================================
    OnlyInInstances     = "Uniquement en instance",
    OnlyInInstancesDesc = "S'applique uniquement à l'intérieur des instances (Donjons, Raids, Scénarios).",
    OnlyInCombat        = "Uniquement en combat",
    OnlyInCombatDesc    = "Affiche uniquement les avertissements pendant le combat.",
    DisableInDungeons   = "Désactiver dans les donjons",
    DisableInDungeonsDesc = "Ne s'applique pas à l'intérieur d'une instance de donjon.",
    DisableInRaids      = "Désactiver en raids",
    DisableInRaidsDesc  = "Ne s'applique pas à l'intérieur d'une instance de raid.",
    InstanceFilters     = "Filtres d'instance",
    InstanceFiltersDesc = "Configurez où cette fonctionnalité doit être désactivée.",

    -- ========================================================================
    -- [[ HIGHLIGHTS SYSTEM ]] ------------------------------------------------
    -- ========================================================================
    Highlight              = "Mise en évidence",
    HighlightDesc          = "Met en évidence votre personnage sur l'écran.",
    Highlights             = "Mises en évidence",
    HighlightGlobalDesc    = "|cffffa500Configurez la mise en évidence des personnages de manière dynamique tout au long des événements de jeu.|r",
    HighlightOptNone              = "Aucun",
    HighlightOptCircle            = "Cercle",
    HighlightOptOutline           = "Contour",
    HighlightOptIcon              = "Icône",
    HighlightOptCircleOutline     = "Cercle et Contour",
    HighlightOptCircleIcon        = "Cercle et Icône",
    HighlightOptOutlineIcon       = "Contour et Icône",
    HighlightOptCircleOutlineIcon = "Cercle, Contour et Icône",
    HighlightCombat     = "En combat",
    HighlightCombatDesc = "Surligner en combat actif.",
    HighlightInstance   = "En instance",
    HighlightInstanceDesc = "Surligner dans les donjons, raids ou scénarios.",
    HighlightHidden     = "En état de furtivité",
    HighlightHiddenDesc = "Surligner en état de Furtivité.",
    ScreenColor         = "Couleur de l'écran",
    ScreenColorDesc     = "Colore l'écran lorsqu'il est actif.",
    Vignette            = "Vignette",
    VignetteDesc        = "Ajoute un effet de vignette autour de l'écran.",
    Thickness           = "Épaisseur",
    ThicknessDesc       = "Contrôle l'épaisseur de la vignette.",

    -- ========================================================================
    -- [[ SHARED MODULES ]] ---------------------------------------------------
    -- ========================================================================
    -- [[ Stealth State Module ]] ---------------------------------------------
    StealthStateName        = "État de furtivité",
    StealthStateDesc        = "Configurez les visuels pour quand vous êtes en état de furtivité.",
    StealthStateActiveText  = "ÉTAT FURTIF",
    EnableOnStealthState    = "Activer en état de furtivité",
    EnableOnStealthStateDesc = "Affiche des visuels tant qu'un état de furtivité est actif (utilise la détection d'état de WoW).",

    -- ========================================================================
    -- [[ CLASS MODULES — ROGUE ]] --------------------------------------------
    -- ========================================================================
    -- [[ Stealth Module ]] ---------------------------------------------------
    Stealth             = "Camouflage",
    EnableOnStealth     = "Activer en Camouflage",
    EnableOnStealthDesc = "Affiche les visuels pendant que Camouflage ou Disparition est actif.",
    StealthUseState     = "Utiliser la détection d'état",
    StealthUseStateDesc = "Utilise l'état de furtivité global au lieu d'auras spécifiques. 'Aura' est plus précise pour les compétences de classe, tandis que 'État' s'active sur tout effet similaire à la furtivité.",
    DefaultMessage      = "CAMOUFLÉ",
    StealthActiveText   = "CAMOUFLÉ",

    -- [[ Poison Tracker ]] ---------------------------------------------------
    PoisonTracker          = "Suivi des poisons",
    LethalPoisons          = "Poison mortel",
    LethalPoisonsDesc      = "Affiche des avertissements quand votre poison mortel manque.",
    NonLethalPoisons       = "Poison non-mortel",
    NonLethalPoisonsDesc   = "Affiche des avertissements quand votre poison non-mortel manque.",
    LethalPoisonMissing    = "POISON MORTEL MANQUANT",
    NonLethalPoisonMissing = "POISON NON-MORTEL MANQUANT",
    -- ========================================================================
    -- [[ MACRO SYSTEM (SHARED) ]] --------------------------------------------
    -- ========================================================================


    -- [[ Tricks of the Trade ]] ----------------------------------------------
    TricksOfTheTrade         = "Ficelles du métier",
    MacroTargetHeader =  "Cible",
    MacroTargetSelector =  "Sélecteur de cible",
    MacroTargetSelectorDesc =  "Définit la logique principale pour la sélection automatique de la cible.",
    MacroAutoUpdateWarning =  "|cffffa500Nightveil met à jour cette macro automatiquement.|r",
    TricksEnabledDesc        = "Active le ciblage automatique pour les Ficelles du métier à l'aide d'une macro.",
    MacroMouseoverDesc =  "Active le ciblage par survol.\n\nNote : Ceci a la priorité sur les autres méthodes, sauf le Compagnon de Gouffre.",
    MacroFocusDesc =  "Active le ciblage automatisé via la focalisation.\n\nNote : Ceci a la priorité sur le sélecteur de cible, mais est ignoré par le survol ou le Compagnon de Gouffre.",
    MacroMuteDesc =  "Masque les notifications de chat lorsque la macro change de cible.",
    MacroDelveCompanion =  "Compagnon de Gouffre",
    MacroDelveCompanionDesc =  "Cible automatiquement les compagnons comme Brann Barbe-de-Bronze ou Valeera Sanguinar à l'intérieur des Gouffres.\n\nNote : Ceci prend une priorité exclusive à l'intérieur des Gouffres.",
    TricksTargetLog          = "Cible des Ficelles",
    TricksNormal             = "Normal",
    TricksCustom             = "Personnalisé",
    MacroCustomName =  "Cible personnalisée",
    MacroCustomNameDesc =  "Entrez le nom exact du joueur à cibler.",
    MacroCustomSet =  "Cible personnalisée définie : %s",
    MacroGroupMembers =  "Membres du groupe :",
    MacroInvalidIndex =  "Index de groupe non valide.",
    MacroNoSelf =  "Vous ne pouvez pas vous cibler vous-même.",
    MacroBtnEnable =  "Activer et synchroniser la macro",
    MacroBtnDisable =  "Désactiver et supprimer la macro",
    MacroBtnDisableDesc =  "Désactive le ciblage automatisé et supprime complètement la macro.",
    TricksMsgEnabled         = "Système de Ficelles activé et macro synchronisée.",
    TricksMsgDisabled        = "Système de Ficelles désactivé et macro supprimée.",
    TricksAlreadyEnabled     = "Le système de Ficelles du métier est déjà activé.",
    TricksAlreadyDisabled    = "Le système de Ficelles du métier est déjà désactivé.",
    TricksLogicSet           = "Mode de ciblage défini : %s",
    Mouseover                = "Survol",
    Focus                    = "Focalisation",
    Tank                     = "Tank",
    TargetTarget             = "Cible de la cible",

    -- [[ Shroud of Concealment ]] --------------------------------------------
    ShroudOfConcealment      = "Voile de camouflage",
    EnableShroudCountdown    = "Activer le compte à rebours de chat",
    EnableShroudCountdownDesc = "Envoie des messages de compte à rebours de Voile au chat.",
    ShroudOnlyInstancesDesc  = "Envoie uniquement des messages de Voile à l'intérieur des instances.\n\nNote : certains canaux sont bloqués à l'extérieur des instances par l'anti-spam de Blizzard.",
    ShroudMuteErrors         = "Sourdine aux erreurs",
    ShroudMuteErrorsDesc     = "Désactive les messages d'erreur de Voile dans le chat.",
    ChatChannel              = "Canal de chat",
    ChatChannelDesc          = "Canal de chat principal utilisé pour les messages de Voile.",
    ChatChannelFallbackDesc  = "Canal alternatif utilisé si le principal est indisponible.",
    ShroudMessage            = "Message de compte à rebours",
    ShroudMessageDesc        = "Modèle de message utilisé pendant le compte à rebours.\n\n%time = temps restant.",
    ShroudOnStart            = "Message de début",
    ShroudOnStartDesc        = "Message envoyé au début du Voile.",
    ShroudOnEnd              = "Message de fin",
    ShroudOnEndDesc          = "Message envoyé à la fin du Voile (0s).",
    ShroudInterval           = "Mode intervalle",
    ShroudIntervalDesc       = "Début, milieu et 5 dernières secondes",
    TimeRemainingHint        = "%time = temps restant",
    TestShroud               = "Tester le Voile",
    TestShroudDesc           = "Simule un compte à rebours local de 5 secondes.\n\nNote : Les messages n'apparaissent que pour vous.",
    ShroudAlreadyActive      = "Le compte à rebours de Voile est déjà actif.",
    ShroudDisabled           = "Le compte à rebours de Voile est désactivé dans les paramètres.",
    ChannelSay               = "Dire",
    ChannelParty             = "Groupe",
    ChannelRaid              = "Raid",
    ChannelInstance          = "Instance",
    ChannelYell              = "Crier",

    -- ========================================================================
    
    -- ========================================================================
    -- [[ CLASS MODULES — HUNTER ]] --------------------------------------------
    -- ========================================================================
    -- [[ Camouflage Module ]] -------------------------------------------------
    Camouflage              = "Camouflage",
    EnableOnCamouflage      = "Activer sous Camouflage",
    EnableOnCamouflageDesc  = "Affiche des visuels lorsque Camouflage est actif.",
    CamouflageActiveText    = "CAMOUFLÉ",

    -- [[ Misdirection ]] ------------------------------------------------------
    Misdirection                = "Détournement",
    MisdirEnabledDesc           = "Active le ciblage automatique pour Détournement via une macro.",
    MisdirTargetLog             = "Cible de Détournement",
    MisdirectionNotLearned      = "Vous n'avez pas encore appris Détournement.",
    MisdirectionMsgEnabled      = "Système de Détournement activé et macro synchronisée.",
    MisdirectionMsgDisabled     = "Système de Détournement désactivé et macro supprimée.",
    MisdirectionAlreadyEnabled  = "Le système de Détournement est déjà activé.",
    MisdirectionAlreadyDisabled = "Le système de Détournement est déjà désactivé.",
    MisdirLogicSet              = "Mode de ciblage défini : %s",
    MisdirNotLearned            = "Vous n'avez pas encore appris Détournement.",
    Pet                         = "Familier",

    -- [[ PROFILE MANAGEMENT ]] -----------------------------------------------
    -- ========================================================================
    Profiles              = "Profils",
    ActiveProfile         = "Profil actif",
    ActiveProfileDesc     = "Sélectionnez le profil actif.",
    CreateProfile         = "Créer un profil",
    CreateProfileDesc     = "Crée un nouveau profil avec les paramètres par défaut.",
    DuplicateProfile      = "Dupliquer le profil",
    DuplicateProfileDesc  = "Copie le profil actuel dans un nouveau.",
    DeleteProfile         = "Supprimer le profil",
    DeleteProfileDesc     = "Supprime le profil sélectionné (action irréversible).",
    ExportProfile         = "Exporter le profil",
    ExportProfileDesc     = "Génère une chaîne pour partager ce profil.",
    ImportProfile         = "Importer le profil",
    ImportProfileDesc     = "Importe un profil à partir d'une chaîne exportée.",
    CreateProfilePrompt   = "Entrez um nom pour le nouveau profil :",
    DuplicateProfilePrompt = "Entrez un nom pour le profil dupliqué :",
    FactoryResetBtn       = "Réinitialisation d'usine",
    FactoryResetBtnDesc   = "Supprime toutes les données de l'addon et les macros, restaurant une installation propre. L'interface sera rechargée.",
    FactoryResetConfirm   = "|cffff0000AVERTISSEMENT :|r Cela supprimera |cffff0000TOUTES|r vos configurations et profils Nightveil, et supprimera les macros créées par l'addon.\n\nCette action est |cffff0000IRRÉVERSIBLE|r.\n\nÊtes-vous sûr de vouloir continuer ?",
    DeleteProfileConfirm  = "Supprimer le profil :\n\n|cffff0000%s|r\n\nCela ne peut pas être annulé.",
    ExportProfilePrompt   = "Copiez cette chaîne d'exportation (Ctrl+C) :\n\nProfil : |cff00ff00%s|r",
    ImportProfilePrompt   = "Collez la chaîne d'exportation du profil ci-dessous :",
    ImportProfileNamePrompt = "Entrez un nom pour le profil importé :",
    ErrorDeleteRestricted = "Vous ne pouvez pas supprimer le profil par défaut.",
    DefaultProfileLabel   = "Par défaut",
    Import                = "Importer",
    Share                 = "Partager",

    -- ========================================================================
    -- [[ SYSTEM MESSAGES & WARNINGS ]] ---------------------------------------
    -- ========================================================================
    WarningNotRogue         = "Vous n'êtes pas un Voleur. Cette commande est réservée aux Voleurs.",
    TricksNotLearned        = "Vous n'avez pas encore appris les Ficelles du métier.",
    HardResetWarning        = "Version obsolète ou incompatible détectée.\n\nLes paramètres seront réinitialisés pour assurer la stabilité.",
    WarningOutdatedConfig   = "Configuration plus récente détectée !\n\nLe profil que vous utilisez a été créé dans une version plus récente de Nightveil.",
    WelcomeMessage          = "%s |cffffd100v%s|r chargé. Tapez |cffffd100/veil|r pour ouvrir les paramètres.",
    UpdateMessage           = "%s mis à jour en |cffffd100v%s|r ! Tapez |cffffd100/veil|r pour voir les nouveautés.",
    ErrorNoValidChannel     = "|cffff2020Aucun canal de chat valide disponible.|r",
    ErrorBlizzardAntiSpam   = "|cffff2020Les restrictions anti-spam de Blizzard empêchent l'utilisation du canal|r |cffffcc00%s|r |cffff2020en dehors des instances.|r",
    ErrorNotInGroup         = "|cffff2020Vous n'êtes pas dans un groupe. Canal|r |cffffcc00%s|r |cffff2020indisponible.|r",
    ErrorNotInRaid          = "|cffff2020Vous n'êtes pas dans un raid. Canal|r |cffffcc00%s|r |cffff2020indisponible.|r",
    ErrorFollowersDungeonGroup = "|cffff2020Vous êtes seul ou dans un groupe non valide. Canal|r |cffffcc00%s|r |cffff2020indisponible.|r",
    ErrorShroudOnlyInstances = "|cffff2020Les messages de Voile ne fonctionnent qu'à l'intérieur des instances.",
    ErrorShroudInstanceOnly  = "|cffff2020Vous n'êtes pas à l'intérieur d'une instance. Canal|r |cffffcc00%s|r |cffff2020indisponible.|r",
    CombatBlocked         = "Impossible d'ouvrir les paramètres pendant le combat.",
    MacroLimitReached     = "Limite de macro atteinte.",
    MuteChanges           = "Sourdine aux changements",
    Next                  = "Suivant",

    -- ========================================================================
    -- [[ COMMANDS HELP ]] ----------------------------------------------------
    -- ========================================================================
    HelpSettings          = "Paramètres",
    HelpTricks            = "Cible des Ficelles",
    HelpUTricks           = "Forcer le rafraîchissement de la macro",
    HelpMisdir            = "Cible de Détournement",
    HelpUMisdir           = "Forcer l'actualisation de la macro",
    HelpMisdirPet         = "Mode Familier",
    HelpMisdirNormal      = "Mode Normal",
    HelpMisdirTank        = "Mode Tank",
    HelpMisdirTT          = "Mode Cible de la cible",
    HelpMisdirCustom      = "Mode Personnalisé",
    HelpMisdirList        = "Lister le groupe / par index",
    HelpMisdirSet         = "Définir par nom",
    HelpInfo              = "Infos de diagnostic",
    HelpShroudTest        = "Tester le compte à rebours de voile",
    HelpDebugToggle       = "Basculer le mode débogage",
    HelpTricksList        = "Lister et définir par index",
    HelpTricksNormal      = "Mode normal",
    HelpTricksTank        = "Mode tank",
    HelpTricksTT          = "Mode Cible-de-la-Cible",
    HelpTricksSet         = "Définir par nom",
    HelpTricksCustom      = "Mode personnalisé",
    ErrorUnknownCmd       = "Commande inconnue : |cffffd100%s|r. Utilisez |cffffd100/veil help|r.",
    ErrorUnknownSubCmd    = "Sous-commande inconnue : |cffffd100%s|r. Utilisez |cffffd100/veil help|r.",

    -- ========================================================================
    -- [[ DEBUG INFO ]] -------------------------------------------------------
    -- ========================================================================
    DebugModeActivated   = "Mode débogage ACTIVÉ",
    DebugModeDeactivated = "Mode débogage DÉSACTIVÉ",
    DebugModeRequired    = "Cette commande nécessite le mode débogage. Tapez |cffffd100/veil debug|r pour l'activer.",
    DebugCommands        = "[Commandes de débogage]",
    DebugHeader          = "Diagnostics %s :",
    DebugCombat          = " - Combat : %s",
    DebugStealth         = " - Camouflage/Disparition : %s",
    DebugInstance        = " - Instance : %s (Type : %s)",
    DebugGroup           = " - Groupe : %s (Raid : %s, Total : %d)",
    DebugComposition     = " - Composition : %d Joueurs, %d Mascottes, %d Autres",
    DebugTricksKnown     = " - Ficelles connues : %s",
    DebugTricksTarget    = " - Cible des Ficelles : %s (%s)",
    DebugTricksMacro     = " - Macro des Ficelles : %s",
    DebugInvalidGroup    = " - Groupe non valide : %s",
    DebugPlayer          = "JOUEUR",
    DebugPet             = "MASCOTTE",
    DebugOther           = "AUTRE",
    DebugYes             = "OUI",
    DebugNo              = "NON",
    DebugNone            = "aucun",
    DebugUnknown         = "Inconnu",
    DebugFallback1       = " - Solution de repli 1 : %s (Utilisable : %s)",
    DebugFallback2       = " - Solution de repli 2 : %s (Utilisable : %s)",
    DebugShroudUsage     = "Utilisation : |cffffd100/veil shroud [1-20]|r",
    DebugTricksForcing   = "Forçage de la mise à jour des Ficelles...",
    DebugTricksSuccess   = "Rafraîchissement de la macro RÉUSSI.",
    DebugMacroUpdated    = "Macro mise à jour : %s",
    DebugMacroStatus     = "Macro : %s",
    DebugMacroEdited     = "Contenu de la macro modifié et synchronisé.",
    DebugCombatLock      = "Cette action ne peut pas être utilisée en combat.",

    -- ========================================================================
    -- [[ NPC / GAME TERMS ]] -------------------------------------------------
    -- ========================================================================
    BrannBronzebeard = "Brann Barbe-de-Bronze",
    ValeeraSanguinar = "Valeera Sanguinar",
}
