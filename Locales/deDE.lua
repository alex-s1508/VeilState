local addonName, ns = ...
if GetLocale() ~= "deDE" then return end
local L = ns.L

-- Allgemein (General)
L.Description  = "Schurken-Dienstprogramme"
L.ReleaseNotes = "Versionshinweise"
L.Management = "Verwaltung"
L.HardResetWarning = "|cffff2020Alte oder nicht kompatible Version erkannt.|r\n\nEinstellungen werden |cffffd100zurückgesetzt|r um Stabilität zu gewährleisten."

-- Fähigkeiten & Zauber (Features & Spells)
L.Stealth     = "Verstohlenheit"
L.ShadowDance = "Schattentanz"
L.PoisonTracker = "Giftüberwachung"
L.LethalPoisons = "Tödliche Gifte"
L.NonLethalPoisons = "Nicht-tödliche Gifte"
L.ShroudOfConcealment = "Schleier der Verhüllung"

-- Globale Bedingungen (Global Conditions)
L.Enable = "Aktivieren"
L.EnableOnStealth     = "Bei Verstohlenheit aktivieren"
L.EnableOnShadowDance = "Bei Schattentanz aktivieren"
L.OnlyInCombat        = "Nur im Kampf"
L.OnlyInInstances     = "Nur in Instanzen"

-- Visuelle Elemente & UI (Visuals & UI Elements)
L.FloatingText  = "Schwebender Text"
L.IndicatorIcon = "Indikatorsymbol"
L.ScreenColor   = "Bildschirmfarbe"
L.Vignette      = "Vignette"
L.Highlight     = "Hervorhebung"
L.Messages = "Nachrichten"
L.Sound = "Sound"

-- Stiloptionen (Styling Options)
L.Color      = "Farbe"
L.Size       = "Größe"
L.Opacity    = "Transparenz"
L.OffsetX    = "Versatz X"
L.OffsetY    = "Versatz Y"
L.Thickness  = "Dicke"
L.CustomText = "Benutzerdefinierter Text"
L.Style      = "Stil"

-- Ebenen (Layers)
L.Layer           = "Ebene"
L.LayerBackground = "Hintergrund"
L.LayerLow        = "Niedrig"
L.LayerMedium     = "Mittel"
L.LayerHigh       = "Hoch"
L.LayerDialog     = "Dialog"
L.LayerFullscreen = "Vollbild"

-- Animationen (Animations)
L.Animation      = "Animation"
L.AnimationSpeed = "Geschwindigkeit"
L.AnimNone  = "Keine"
L.AnimBlink = "Blinken"
L.AnimFade  = "Verblassen"
L.AnimShake = "Schütteln"

-- Ankerpunkte (Anchors)
L.AnchorToText = "An Text verankern"
L.AnchorPoint  = "Ankerpunkt"
L.AnchorTopLeft     = "Oben links"
L.AnchorTop         = "Oben"
L.AnchorTopRight    = "Oben rechts"
L.AnchorLeft        = "Links"
L.AnchorCenter      = "Mitte"
L.AnchorRight       = "Rechts"
L.AnchorBottomLeft  = "Unten links"
L.AnchorBottom      = "Unten"
L.AnchorBottomRight = "Unten rechts"

-- Optionen für Symbole & Sounds (Icons & Sounds Options)
L.TestSound = "Sound testen"
L.SelectIcon = "Symbol auswählen"
L.IconTexture = "Symboltextur"
L.SoundKitId = "Sound-Kit-ID"

-- Hervorhebungsoptionen (Highlight Options)
L.HighlightCircle           = "Kreis"
L.HighlightOutline          = "Umriss"
L.HighlightIcon             = "Symbol"
L.HighlightCircleOutline    = "Kreis + Umriss"
L.HighlightCircleIcon       = "Kreis + Symbol"
L.HighlightOutlineIcon      = "Umriss + Symbol"
L.HighlightCircleOutlineIcon = "Kreis + Umriss + Symbol"

-- Standardnachrichten (Default Messages)
L.DefaultMessage     = "VERSTOHLEN"
L.ShadowDanceMessage = "SCHATTENTANZ"
L.LethalPoisonMissing = "TÖDLICHES GIFT FEHLT"
L.NonLethalPoisonMissing = "NICHT-TÖDLICHES GIFT FEHLT"

-- Schleier-Spezifisch (Shroud Specifics)
L.EnableShroudCountdown = "Chat-Countdown aktivieren"
L.ChatChannel         = "Chatkanal"
L.ShroudMessage       = "Countdown-Nachricht"
L.ShroudOnStart       = "Startnachricht"
L.ShroudOnEnd         = "Endnachricht"
L.ShroudInterval      = "Intervallmodus"
L.ShroudIntervalDesc  = "Start, Mittelpunkt und letzte 5 Sekunden"
L.TimeRemainingHint   = "%time = verbleibende Zeit"
L.TestShroud          = "Nachricht testen"

-- Chatkanäle (Chat Channels)
L.ChannelSay      = "Sagen"
L.ChannelParty    = "Gruppe"
L.ChannelRaid     = "Schlachtzug"
L.ChannelInstance = "Instanz"
L.ChannelYell     = "Schreien"

-- Profile (Profiles)
L.Profiles = "Profile"
L.ActiveProfile = "Aktives Profil"
L.ProfileSharing = "Import / Export"
L.CreateProfile = "Profil erstellen"
L.DuplicateProfile = "Profil duplizieren"
L.DeleteProfile = "Profil löschen"
L.ExportProfile = "Profil exportieren"
L.ImportProfile = "Profil importieren"
L.CreateProfilePrompt = "Name für das neue Profil eingeben:"
L.DuplicateProfilePrompt = "Name für das duplizierte Profil eingeben:"
L.DeleteProfileConfirm = "Profil löschen:\n\n|cffff0000%s|r\n\nDies kann nicht rückgängig gemacht werden."
L.ExportProfilePrompt = "Diesen Export-String kopieren (Strg+C):\n\nProfil: |cff00ff00%s|r"
L.ImportProfilePrompt = "Den Profil-Export-String unten einfügen:"
L.ImportProfileNamePrompt = "Name für das importierte Profil eingeben:"
L.Next = "Weiter"
L.Import = "Importieren"

-- Version
L.WelcomeMessage = "|cffA361E2Nightveil|r |cffffffffv%s geladen. Tippe |r|cffffd100/veil|r |cfffffffffür das Einstellungsfenster.|r"
L.UpdateMessage = "|cffA361E2Nightveil|r |cffffffffaktualisiert auf |r|cff00ff00v%s|r|cffffffff! Überprüfe die Release-Notes in den Einstellungen.|r"