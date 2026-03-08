local addonName, ns = ...
if GetLocale() ~= "ptBR" then return end
local L = ns.L

-- Geral
L.Description  = "Utilitários de Ladino"
L.ReleaseNotes = "Notas de Atualização"
L.Management = "Gerenciamento"
L.HardResetWarning = "|cffff2020Versão antiga ou incompatível detectada.|r\n\nConfigurações serão |cffffd100resetadas|r para garantir estabilidade."

-- Habilidades
L.Stealth     = "Furtividade"
L.ShadowDance = "Dança das Sombras"
L.PoisonTracker = "Monitor de Venenos"
L.LethalPoisons = "Venenos Letais"
L.NonLethalPoisons = "Venenos Não Letais"
L.ShroudOfConcealment = "Mortalha da Ocultação"

-- Condições Globais
L.Enable = "Ativar"
L.EnableOnStealth     = "Ativar com Furtividade"
L.EnableOnShadowDance = "Ativar com Dança das Sombras"
L.OnlyInCombat        = "Apenas em Combate"
L.OnlyInInstances     = "Apenas em Instâncias"

-- Elementos Visuais e UI
L.FloatingText  = "Texto Flutuante"
L.IndicatorIcon = "Ícone Indicador"
L.ScreenColor   = "Cor da Tela"
L.Vignette       = "Vinheta"
L.Highlight     = "Destaque"
L.Messages = "Mensagens"
L.Sound = "Som"

-- Opções de Estilo
L.Color      = "Cor"
L.Size       = "Tamanho"
L.Opacity    = "Opacidade"
L.OffsetX    = "Deslocamento X"
L.OffsetY    = "Deslocamento Y"
L.Thickness  = "Espessura"
L.CustomText = "Texto Personalizado"
L.Style      = "Estilo"

-- Camadas (Layers)
L.Layer           = "Camada"
L.LayerBackground = "Fundo"
L.LayerLow        = "Baixa"
L.LayerMedium     = "Média"
L.LayerHigh       = "Alta"
L.LayerDialog     = "Diálogo"
L.LayerFullscreen = "Tela Cheia"

-- Animações
L.Animation      = "Animação"
L.AnimationSpeed = "Velocidade"
L.AnimNone  = "Nenhum"
L.AnimBlink = "Piscar"
L.AnimFade  = "Esmaecer"
L.AnimShake = "Tremer"

-- Âncoras
L.AnchorToText = "Ancorar ao Texto"
L.AnchorPoint  = "Ponto de Ancoragem"
L.AnchorTopLeft     = "Superior Esquerdo"
L.AnchorTop         = "Superior"
L.AnchorTopRight    = "Superior Direito"
L.AnchorLeft        = "Esquerda"
L.AnchorCenter      = "Centro"
L.AnchorRight       = "Direita"
L.AnchorBottomLeft  = "Inferior Esquerdo"
L.AnchorBottom      = "Inferior"
L.AnchorBottomRight = "Inferior Direito"

-- Opções de Ícones e Sons
L.TestSound = "Testar Som"
L.SelectIcon = "Selecionar Ícone"
L.IconTexture = "Textura do Ícone"
L.SoundKitId = "ID do SoundKit"

-- Opções de Destaque
L.HighlightCircle           = "Círculo"
L.HighlightOutline          = "Contorno"
L.HighlightIcon             = "Ícone"
L.HighlightCircleOutline    = "Círculo e contorno"
L.HighlightCircleIcon       = "Círculo e ícone"
L.HighlightOutlineIcon      = "Contorno e ícone"
L.HighlightCircleOutlineIcon = "Círculo, contorno e ícone"

-- Mensagens Padrão
L.DefaultMessage     = "FURTIVO"
L.ShadowDanceMessage = "DANÇA DAS SOMBRAS"
L.LethalPoisonMissing = "VENENO LETAL AUSENTE"
L.NonLethalPoisonMissing = "VENENO NÃO LETAL AUSENTE"

-- Específicos da Mortalha (Shroud)
L.EnableShroudCountdown = "Ativar contagem no chat"
L.ChatChannel         = "Canal do Chat"
L.ShroudMessage       = "Mensagem da Contagem"
L.ShroudOnStart       = "Mensagem Inicial"
L.ShroudOnEnd         = "Mensagem Final"
L.ShroudInterval      = "Modo de Intervalo"
L.ShroudIntervalDesc  = "Início, ponto médio e últimos 5s"
L.TimeRemainingHint   = "%time = tempo restante"
L.TestShroud          = "Testar Mensagem"

-- Canais de Chat
L.ChannelSay      = "Dizer"
L.ChannelParty    = "Grupo"
L.ChannelRaid     = "Raide"
L.ChannelInstance = "Instância"
L.ChannelYell     = "Gritar"

-- Perfis
L.Profiles = "Perfis"
L.ActiveProfile = "Perfil Ativo"
L.ProfileSharing = "Importar / Exportar"
L.CreateProfile = "Criar Perfil"
L.DuplicateProfile = "Duplicar Perfil"
L.DeleteProfile = "Excluir Perfil"
L.ExportProfile = "Exportar Perfil"
L.ImportProfile = "Importar Perfil"
L.CreateProfilePrompt = "Digite um nome para o novo perfil:"
L.DuplicateProfilePrompt = "Digite um nome para o perfil duplicado:"
L.DeleteProfileConfirm = "Excluir perfil:\n\n|cffff0000%s|r\n\nIsso não pode ser desfeito."
L.ExportProfilePrompt = "Copie esta string (Ctrl+C):\n\nPerfil: |cff00ff00%s|r"
L.ImportProfilePrompt = "Cole a string de exportação do perfil abaixo:"
L.ImportProfileNamePrompt = "Digite um nome para o perfil importado:"
L.Next = "Próximo"
L.Import = "Importar"