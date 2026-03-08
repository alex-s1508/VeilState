local addonName, ns = ...
if GetLocale() ~= "itIT" then return end
local L = ns.L

-- Generale (General)
L.Description  = "Utilità Ladro"
L.ReleaseNotes = "Note di rilascio"
L.Management   = "Gestione"
L.HardResetWarning = "|cffff2020Versione precedente o incompatibile rilevata.|r\n\nLe impostazioni verranno |cffffd100reimpostate|r per garantire la stabilità."

-- Funzionalità e Incantesimi (Features & Spells)
L.Stealth     = "Furtività"
L.ShadowDance = "Danza delle Ombre"
L.PoisonTracker = "Monitor Veleni"
L.LethalPoisons = "Veleno Letale"
L.NonLethalPoisons = "Veleno Non Letale"
L.ShroudOfConcealment = "Velo dell'Occultamento"

-- Condizioni Globali (Global Conditions)
L.Enable = "Abilita"
L.EnableOnStealth     = "Attiva con Furtività"
L.EnableOnShadowDance = "Attiva con Danza delle Ombre"
L.OnlyInCombat        = "Solo in combattimento"
L.OnlyInInstances     = "Solo nelle istanze"

-- Visuali ed Elementi IU (Visuals & UI Elements)
L.FloatingText  = "Testo Fluttuante"
L.IndicatorIcon = "Icona Indicatore"
L.ScreenColor   = "Colore Schermo"
L.Vignette      = "Vignettatura"
L.Highlight     = "Evidenzia"
L.Messages = "Messaggi"
L.Sound = "Suono"

-- Opzioni di Stile (Styling Options)
L.Color      = "Colore"
L.Size       = "Dimensione"
L.Opacity    = "Opacità"
L.OffsetX    = "Offset X"
L.OffsetY    = "Offset Y"
L.Thickness  = "Spessore"
L.CustomText = "Testo Personalizzato"
L.Style      = "Stile"

-- Livelli (Layers)
L.Layer           = "Livello"
L.LayerBackground = "Sfondo"
L.LayerLow        = "Basso"
L.LayerMedium     = "Medio"
L.LayerHigh       = "Alto"
L.LayerDialog     = "Dialogo"
L.LayerFullscreen = "Schermo Intero"

-- Animazioni (Animations)
L.Animation      = "Animazione"
L.AnimationSpeed = "Velocità"
L.AnimNone  = "Nessuna"
L.AnimBlink = "Lampeggio"
L.AnimFade  = "Dissolvenza"
L.AnimShake = "Scossa"

-- Punti di Ancoraggio (Anchors)
L.AnchorToText = "Ancora al Testo"
L.AnchorPoint  = "Punto di Ancoraggio"
L.AnchorTopLeft     = "In alto a sinistra"
L.AnchorTop         = "In alto"
L.AnchorTopRight    = "In alto a destra"
L.AnchorLeft        = "A sinistra"
L.AnchorCenter      = "Centro"
L.AnchorRight       = "A destra"
L.AnchorBottomLeft  = "In basso a sinistra"
L.AnchorBottom      = "In basso"
L.AnchorBottomRight = "In basso a destra"

-- Opzioni Icone e Suoni (Icons & Sounds Options)
L.TestSound = "Test suono"
L.SelectIcon = "Seleziona icona"
L.IconTexture = "Texture Icona"
L.SoundKitId = "ID Pacchetto Suono"

-- Opzioni di Evidenziazione (Highlight Options)
L.HighlightCircle           = "Cerchio"
L.HighlightOutline          = "Contorno"
L.HighlightIcon             = "Icona"
L.HighlightCircleOutline    = "Cerchio + Contorno"
L.HighlightCircleIcon       = "Cerchio + Icona"
L.HighlightOutlineIcon      = "Contorno + Icona"
L.HighlightCircleOutlineIcon = "Cerchio + Contorno + Icona"

-- Messaggi Predefiniti (Default Messages)
L.DefaultMessage     = "IN FURTIVITÀ"
L.ShadowDanceMessage = "DANZA DELLE OMBRE"
L.LethalPoisonMissing = "VELENO LETALE MANCANTE"
L.NonLethalPoisonMissing = "VELENO NON LETALE MANCANTE"

-- Specifiche del Velo (Shroud Specifics)
L.EnableShroudCountdown = "Attiva conto alla rovescia chat"
L.ChatChannel         = "Canale chat"
L.ShroudMessage       = "Messaggio conto alla rovescia"
L.ShroudOnStart       = "Messaggio iniziale"
L.ShroudOnEnd         = "Messaggio finale"
L.ShroudInterval      = "Modalità intervallo"
L.ShroudIntervalDesc  = "Inizio, punto medio e ultimi 5 s"
L.TimeRemainingHint   = "%time = tempo rimanente"
L.TestShroud          = "Testa messaggio"

-- Canali Chat (Chat Channels)
L.ChannelSay      = "Di'"
L.ChannelParty    = "Gruppo"
L.ChannelRaid     = "Incursione"
L.ChannelInstance = "Istanza"
L.ChannelYell     = "Urla"

-- Profili (Profiles)
L.Profiles = "Profili"
L.ActiveProfile = "Profilo attivo"
L.ProfileSharing = "Importa / Esporta"
L.CreateProfile = "Crea profilo"
L.DuplicateProfile = "Duplica profilo"
L.DeleteProfile = "Elimina profilo"
L.ExportProfile = "Esporta profilo"
L.ImportProfile = "Importa profilo"
L.CreateProfilePrompt = "Inserisci un nome per il nuovo profilo:"
L.DuplicateProfilePrompt = "Inserisci un nome per il profilo duplicato:"
L.DeleteProfileConfirm = "Eliminare profilo:\n\n|cffff0000%s|r\n\nOperazione irreversibile."
L.ExportProfilePrompt = "Copia questa stringa (Ctrl+C):\n\nProfilo: |cff00ff00%s|r"
L.ImportProfilePrompt = "Incolla qui sotto la stringa di esportazione del profilo:"
L.ImportProfileNamePrompt = "Inserisci un nome per il profilo importato:"
L.Next = "Avanti"
L.Import = "Importa"

-- Versione
L.WelcomeMessage = "|cffA361E2Nightveil|r |cffffffffv%s caricato. Digita |r|cffffd100/veil|r |cffffffffper aprire la finestra delle impostazioni.|r"
L.UpdateMessage = "|cffA361E2Nightveil|r |cffffffffaggiornato a |r|cff00ff00v%s|r|cffffffff! Controlla le note di rilascio nelle impostazioni.|r"