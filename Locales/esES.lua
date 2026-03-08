local addonName, ns = ...
local locale = GetLocale()
if locale ~= "esES" and locale ~= "esMX" then return end
local L = ns.L

-- General
L.Description  = "Utilidades de Pícaro"
L.ReleaseNotes = "Notas de la versión"
L.Management = "Gestión"
L.HardResetWarning = "|cffff2020Versión antigua o incompatible detectada.|r\n\nSe restablecerán las configuraciones para garantizar estabilidad."

-- Habilidades y Hechizos (Features & Spells)
L.Stealth     = "Sigilo"
L.ShadowDance = "Danza de las Sombras"
L.PoisonTracker = "Monitor de venenos"
L.LethalPoisons = "Venenos letales"
L.NonLethalPoisons = "Venenos no letales"
L.ShroudOfConcealment = "Sudario de ocultamiento"

-- Condiciones Globales
L.Enable = "Activar"
L.EnableOnStealth     = "Activar con Sigilo"
L.EnableOnShadowDance = "Activar con Danza de las Sombras"
L.OnlyInCombat        = "Solo en combate"
L.OnlyInInstances     = "Solo en instancias"

-- Visuales y Elementos de IU
L.FloatingText  = "Texto flotante"
L.IndicatorIcon = "Icono indicador"
L.ScreenColor   = "Color de pantalla"
L.Vignette      = "Viñeta"
L.Highlight     = "Resaltado"
L.Messages = "Mensajes"
L.Sound = "Sonido"

-- Opciones de Estilo
L.Color      = "Color"
L.Size       = "Tamaño"
L.Opacity    = "Opacidad"
L.OffsetX    = "Desplazamiento X"
L.OffsetY    = "Deslocamiento Y"
L.Thickness  = "Grosor"
L.CustomText = "Texto personalizado"
L.Style      = "Estilo"

-- Capas (Layers)
L.Layer           = "Capa"
L.LayerBackground = "Fondo"
L.LayerLow        = "Baja"
L.LayerMedium     = "Media"
L.LayerHigh       = "Alta"
L.LayerDialog     = "Diálogo"
L.LayerFullscreen = "Pantalla completa"

-- Animaciones
L.Animation      = "Animación"
L.AnimationSpeed = "Velocidad"
L.AnimNone  = "Ninguna"
L.AnimBlink = "Parpadear"
L.AnimFade  = "Desvanecer"
L.AnimShake = "Sacudir"

-- Puntos de Anclaje (Anchors)
L.AnchorToText = "Anclar al texto"
L.AnchorPoint  = "Punto de anclaje"
L.AnchorTopLeft     = "Superior izquierda"
L.AnchorTop         = "Superior"
L.AnchorTopRight    = "Superior derecha"
L.AnchorLeft        = "Izquierda"
L.AnchorCenter      = "Centro"
L.AnchorRight       = "Derecha"
L.AnchorBottomLeft  = "Inferior izquierda"
L.AnchorBottom      = "Inferior"
L.AnchorBottomRight = "Inferior derecha"

-- Opciones de Iconos y Sonidos
L.TestSound = "Probar sonido"
L.SelectIcon = "Seleccionar icono"
L.IconTexture = "Textura del icono"
L.SoundKitId = "ID de Sound Kit"

-- Opciones de Resaltado
L.HighlightCircle           = "Círculo"
L.HighlightOutline          = "Contorno"
L.HighlightIcon             = "Icono"
L.HighlightCircleOutline    = "Círculo + Contorno"
L.HighlightCircleIcon       = "Círculo + Icono"
L.HighlightOutlineIcon      = "Contorno + Icono"
L.HighlightCircleOutlineIcon = "Círculo + Contorno + Icono"

-- Mensajes Predeterminados
L.DefaultMessage     = "EN SIGILO"
L.ShadowDanceMessage = "DANZA DE LAS SOMBRAS"
L.LethalPoisonMissing = "FALTA VENENO LETAL"
L.NonLethalPoisonMissing = "FALTA VENENO NO LETAL"

-- Específicos de Sudario (Shroud)
L.EnableShroudCountdown = "Activar cuenta atrás en el chat"
L.ChatChannel         = "Canal de chat"
L.ShroudMessage       = "Mensaje de cuenta atrás"
L.ShroudOnStart       = "Mensaje inicial"
L.ShroudOnEnd         = "Mensaje final"
L.ShroudInterval      = "Modo de intervalo"
L.ShroudIntervalDesc  = "Inicio, punto medio y últimos 5 s"
L.TimeRemainingHint   = "%time = tiempo restante"
L.TestShroud          = "Probar mensaje"

-- Canales de Chat
L.ChannelSay      = "Decir"
L.ChannelParty    = "Grupo"
L.ChannelRaid     = "Banda"
L.ChannelInstance = "Instancia"
L.ChannelYell     = "Gritar"

-- Perfiles
L.Profiles = "Perfiles"
L.ActiveProfile = "Perfil activo"
L.ProfileSharing = "Importar / Exportar"
L.CreateProfile = "Crear perfil"
L.DuplicateProfile = "Duplicar perfil"
L.DeleteProfile = "Eliminar perfil"
L.ExportProfile = "Exportar perfil"
L.ImportProfile = "Importar perfil"
L.CreateProfilePrompt = "Escribe un nombre para el nuevo perfil:"
L.DuplicateProfilePrompt = "Escribe un nombre para el perfil duplicado:"
L.DeleteProfileConfirm = "Eliminar perfil:\n\n|cffff0000%s|r\n\nEsto no se puede deshacer."
L.ExportProfilePrompt = "Copia esta cadena (Ctrl+C):\n\nPerfil: |cff00ff00%s|r"
L.ImportProfilePrompt = "Pega abajo la cadena de exportación del perfil:"
L.ImportProfileNamePrompt = "Escribe un nombre para el perfil importado:"
L.Next = "Siguiente"
L.Import = "Importar"

-- Versión
L.WelcomeMessage = "|cffA361E2Nightveil|r |cffffffffv%s cargado. Escribe |r|cffffd100/veil|r |cffffffffpara abrir la ventana de ajustes.|r"
L.UpdateMessage = "|cffA361E2Nightveil|r |cffffffff¡actualizado a |r|cff00ff00v%s|r|cffffffff! Mira las Notas de Versión en os ajustes.|r"