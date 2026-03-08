local addonName, ns = ...
if GetLocale() ~= "frFR" then return end
local L = ns.L

-- Général (General)
L.Description  = "Utilitaires de Voleur"
L.ReleaseNotes = "Notes de mise à jour"
L.Management   = "Gestion"
L.HardResetWarning = "|cffff2020Version ancienne ou incompatible détectée.|r\n\nLes paramètres seront |cffffd100réinitialisés|r pour garantir la stabilité."

-- Fonctionnalités & Sorts (Features & Spells)
L.Stealth     = "Camouflage"
L.ShadowDance = "Danse des ombres"
L.PoisonTracker = "Surveillance des poisons"
L.LethalPoisons = "Poisons mortels"
L.NonLethalPoisons = "Poisons non mortels"
L.ShroudOfConcealment = "Voile d’occultation"

-- Conditions Globales (Global Conditions)
L.Enable = "Activer"
L.EnableOnStealth     = "Activar avec Camouflage"
L.EnableOnShadowDance = "Activer avec Danse des ombres"
L.OnlyInCombat        = "Uniquement en combat"
L.OnlyInInstances     = "Uniquement en instance"

-- Visuels & Éléments d'interface (Visuals & UI Elements)
L.FloatingText  = "Texte flottant"
L.IndicatorIcon = "Icône indicatrice"
L.ScreenColor   = "Couleur de l’écran"
L.Vignette      = "Vignette"
L.Highlight     = "Mise en évidence"
L.Messages = "Messages"
L.Sound = "Son"

-- Options de Style (Styling Options)
L.Color      = "Couleur"
L.Size       = "Taille"
L.Opacity    = "Opacité"
L.OffsetX    = "Décalage X"
L.OffsetY    = "Décalage Y"
L.Thickness  = "Épaisseur"
L.CustomText = "Texte personnalisé"
L.Style      = "Style"

-- Calques (Layers)
L.Layer           = "Calque"
L.LayerBackground = "Arrière-plan"
L.LayerLow        = "Bas"
L.LayerMedium     = "Moyen"
L.LayerHigh       = "Haut"
L.LayerDialog     = "Dialogue"
L.LayerFullscreen = "Plein écran"

-- Animations
L.Animation      = "Animation"
L.AnimationSpeed = "Vitesse"
L.AnimNone  = "Aucun"
L.AnimBlink = "Clignotement"
L.AnimFade  = "Fondu"
L.AnimShake = "Secousse"

-- Points d'ancrage (Anchors)
L.AnchorToText = "Ancrer au texte"
L.AnchorPoint  = "Point d’ancrage"
L.AnchorTopLeft     = "En haut à gauche"
L.AnchorTop         = "En haut"
L.AnchorTopRight    = "En haut à droite"
L.AnchorLeft        = "À gauche"
L.AnchorCenter      = "Centre"
L.AnchorRight       = "À droite"
L.AnchorBottomLeft  = "En bas à gauche"
L.AnchorBottom      = "En bas"
L.AnchorBottomRight = "En bas à droite"

-- Options d'Icônes & Sons (Icons & Sounds Options)
L.TestSound = "Tester le son"
L.SelectIcon = "Sélectionner une icône"
L.IconTexture = "Texture de l’icône"
L.SoundKitId = "ID SoundKit"

-- Options de Mise en évidence (Highlight Options)
L.HighlightCircle           = "Cercle"
L.HighlightOutline          = "Contour"
L.HighlightIcon             = "Icône"
L.HighlightCircleOutline    = "Cercle + Contour"
L.HighlightCircleIcon       = "Cercle + Icône"
L.HighlightOutlineIcon      = "Contour + Icône"
L.HighlightCircleOutlineIcon = "Cercle + Contour + Icône"

-- Messages par défaut (Default Messages)
L.DefaultMessage     = "CAMOUFLÉ"
L.ShadowDanceMessage = "DANSE DES OMBRES"
L.LethalPoisonMissing = "POISON MORTEL MANQUANT"
L.NonLethalPoisonMissing = "POISON NON MORTEL MANQUANT"

-- Détails du Voile (Shroud Specifics)
L.EnableShroudCountdown = "Activer le compte à rebours"
L.ChatChannel         = "Canal de discussion"
L.ShroudMessage       = "Message du compte à rebours"
L.ShroudOnStart       = "Message de début"
L.ShroudOnEnd         = "Message de fin"
L.ShroudInterval      = "Mode intervalle"
L.ShroudIntervalDesc  = "Début, milieu et 5 dernières s"
L.TimeRemainingHint   = "%time = temps restant"
L.TestShroud          = "Tester le message"

-- Canaux de discussion (Chat Channels)
L.ChannelSay      = "Dire"
L.ChannelParty    = "Groupe"
L.ChannelRaid     = "Raid"
L.ChannelInstance = "Instance"
L.ChannelYell     = "Crier"

-- Profils
L.Profiles = "Profils"
L.ActiveProfile = "Profil actif"
L.ProfileSharing = "Importer / Exporter"
L.CreateProfile = "Créer um profil"
L.DuplicateProfile = "Dupliquer le profil"
L.DeleteProfile = "Supprimer le profil"
L.ExportProfile = "Exporter le profil"
L.ImportProfile = "Importer le profil"
L.CreateProfilePrompt = "Entrez un nom pour le nouveau profil :"
L.DuplicateProfilePrompt = "Entrez un nom pour le profil dupliqué :"
L.DeleteProfileConfirm = "Supprimer le profil :\n\n|cffff0000%s|r\n\nCette action é irréversible."
L.ExportProfilePrompt = "Copiez cette chaîne (Ctrl+C) :\n\nProfil : |cff00ff00%s|r"
L.ImportProfilePrompt = "Collez la chaîne d’export du profil ci-dessous :"
L.ImportProfileNamePrompt = "Entrez un nome pour le profil importé :"
L.Next = "Suivant"
L.Import = "Importer"