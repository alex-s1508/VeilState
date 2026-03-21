local addonName, ns = ...
local locale = GetLocale()
if locale ~= "ptBR" then return end

ns.L = {
    -- ========================================================================
    -- [[ SYSTEM / GENERAL UI ]] -----------------------------------------
    -- ========================================================================
    Enable                  = "Ativar",
    Management              = "Gerenciamento",
    ReleaseNotes            = "Notas da Versão",
    WelcomeMessage          = "%s |cffffcc00v%s|r carregado. Digite |cffffcc00/veil|r para abrir as configurações.",
    UpdateMessage           = "%s atualizado para |cffffcc00v%s|r! Digite |cffffcc00/veil|r para ver as novidades.",
    FloatingText            = "Texto Flutuante",

    -- ========================================================================
    -- [[ INTERFACE — Elements & Styles ]] -------------------------------
    -- ========================================================================
    Color                   = "Cor",
    Size                    = "Tamanho",
    Opacity                 = "Opacidade",
    Thickness               = "Espessura",
    Style                   = "Estilo",
    Layer                   = "Camada",
    LayerBackground         = "Fundo",
    LayerLow                = "Baixa",
    LayerMedium             = "Média",
    LayerHigh               = "Alta",
    LayerDialog             = "Diálogo",
    LayerFullscreen         = "Tela Cheia",
    ScreenColor             = "Cor da Tela",
    Vignette                = "Vinheta",

    -- ========================================================================
    -- [[ INTERFACE — Positioning & Anchors ]] ---------------------------
    -- ========================================================================
    AnchorPoint             = "Ponto de Fixação",
    AnchorToText            = "Fixar no Texto",
    OffsetX                 = "Deslocamento X",
    OffsetY                 = "Deslocamento Y",
    AnchorTopLeft           = "Superior Esquerdo",
    AnchorTop               = "Superior",
    AnchorTopRight          = "Superior Direito",
    AnchorLeft              = "Esquerda",
    AnchorCenter            = "Centro",
    AnchorRight             = "Direita",
    AnchorBottomLeft        = "Inferior Esquerdo",
    AnchorBottom            = "Inferior",
    AnchorBottomRight       = "Inferior Direito",

    -- ========================================================================
    -- [[ INTERFACE — Icons & Multimedia ]] ------------------------------
    -- ========================================================================
    IndicatorIcon           = "Ícone Indicador",
    IconTexture             = "Textura do Ícone",
    Sound                   = "Som",
    SoundKitId              = "ID do SoundKit",
    TestSound               = "Testar Som",

    -- ========================================================================
    -- [[ INTERFACE — Logic & Filters ]] ---------------------------------
    -- ========================================================================
    OnlyInInstances         = "Apenas em instâncias",
    OnlyInCombat            = "Apenas em combate",
    DisableInDungeons       = "Desativar em Masmorras",
    DisableInRaids          = "Desativar em Raides",
    InstanceFilters         = "Filtros de Instância",

    -- ========================================================================
    -- [[ INTERFACE — Message Customization ]] ---------------------------
    -- ========================================================================
    CustomText              = "Texto Personalizado",
    Messages                = "Mensagens",

    -- ========================================================================
    -- [[ SHARED MODULES — Highlights ]] ---------------------------------
    -- ========================================================================
    Highlights              = "Destaques",
    Highlight               = "Destaque",
    HighlightGlobalDesc     = "|cffffa500Configura o destaque do personagem dinamicamente durante os eventos do jogo.|r",
    HighlightCombat         = "Em Combate",
    HighlightCombatDesc     = "Highlight style when entering combat.",
    HighlightInstance       = "Em Instância",
    HighlightInstanceDesc   = "Highlight style when inside a dungeon or raid.",
    HighlightHidden         = "Em Estado de Furtividade",
    HighlightHiddenDesc     = "Highlight style when in a custom stealth state.",
    HighlightStealth        = "Em Furtividade",
    HighlightStealthDesc    = "Highlight style when stealthed.",
    HighlightShroud         = "Em Manto da Ocultação",
    HighlightShroudDesc     = "Highlight style when inside Shroud of Concealment.",
    HighlightCamouflage     = "Em Camuflagem",
    HighlightCamouflageDesc = "Highlight style when camouflaged.",
    HighlightProwl          = "In Prowl",
    HighlightProwlDesc      = "Highlight style when prowling.",
    HighlightOptNone        = "Nenhum",
    HighlightOptCircle      = "Círculo",
    HighlightOptOutline     = "Contorno",
    HighlightOptIcon        = "Ícone",
    HighlightOptCircleOutline = "Círculo e contorno",
    HighlightOptCircleIcon  = "Círculo e ícone",
    HighlightOptOutlineIcon = "Contorno e ícone",
    HighlightOptCircleOutlineIcon = "Círculo, contorno e ícone",

    -- ========================================================================
    -- [[ SHARED MODULES — Stealth State ]] ------------------------------
    -- ========================================================================
    StealthStateName        = "Estado de Furtividade",
    StealthStateActiveText  = "ESTADO FURTIVO",
    EnableOnStealthState    = "Ativar no Estado de Furtividade",

    -- ========================================================================
    -- [[ SHARED MODULES — Macro System ]] -------------------------------
    -- ========================================================================
    MacroTargetHeader       = "Alvo",
    MacroTargetSelector     = "Seletor de Alvo",
    MacroAutoUpdateWarning  = "|cffffa500O Nightveil atualiza este macro automaticamente.|r",
    MacroDelveCompanion     = "Companheiro de Imersão",
    MacroCustomName         = "Alvo Personalizado",
    MacroCustomSet          = "Alvo personalizado definido: %s",
    MacroGroupMembers       = "Membros do grupo:",
    MacroInvalidIndex       = "Índice de grupo inválido.",
    MacroNoSelf             = "Você não pode ser seu próprio alvo.",
    MacroBtnEnable          = "Ativar e Sincronizar Macro",
    MacroBtnDisable         = "Desativar e Remover Macro",
    Mouseover               = "Mouseover",
    Focus                   = "Foco",
    Tank                    = "Tank",
    TargetTarget            = "Alvo do Alvo",
    TargetingModeSet        = "Modo de alvo definido: %s",
    Pet                     = "Mascote",
    MuteChanges             = "Mute status changes",

    -- ========================================================================
    -- [[ CLASS MODULES — ROGUE ]] ---------------------------------------
    -- ========================================================================

    -- [[ Stealth ]] -------------------------------------------
    Stealth                 = "Furtividade",
    EnableOnStealth         = "Ativar com Furtividade",
    StealthUseState         = "Usar Detecção de Estado",
    StealthActiveText       = "FURTIVO",

    -- [[ Poison Tracker ]] ------------------------------------
    PoisonTracker           = "Monitor de Venenos",
    LethalPoisons           = "Veneno Letal",
    NonLethalPoisons        = "Veneno Não Letal",
    LethalPoisonMissing     = "VENENO LETAL FALTANDO",
    NonLethalPoisonMissing  = "VENENO NÃO LETAL FALTANDO",

    -- [[ Tricks of the Trade ]] -------------------------------
    TricksOfTheTrade        = "Truques do Ofício",
    TricksTargetLog         = "Alvo de Truques",
    TricksNormal            = "Normal",
    TricksCustom            = "Personalizado",
    TricksMsgEnabled        = "Sistema de Truques ativado e macro sincronizado.",
    TricksMsgDisabled       = "Sistema de Truques desativado e macro removido.",
    TricksAlreadyEnabled    = "O sistema de Truques do Ofício já está ativado.",
    TricksAlreadyDisabled   = "O sistema de Truques do Ofício já está desativado.",

    -- [[ Shroud of Concealment ]] -----------------------------
    ShroudOfConcealment     = "Mortalha da Ocultação",
    EnableShroudCountdown   = "Ativar contagem no chat",
    ShroudMuteErrors        = "Silenciar erros",
    ChatChannel             = "Canal de Chat",
    ShroudMessage           = "Mensagem de Contagem",
    ShroudOnStart           = "Mensagem de Início",
    ShroudOnEnd             = "Mensagem de Fim",
    ShroudInterval          = "Modo Intervalo",
    TestShroud              = "Testar Mortalha",
    ShroudAlreadyActive     = "A contagem regressiva da Mortalha já está ativa.",
    ShroudDisabled          = "A contagem da Mortalha está desativada nas configurações.",

    -- ========================================================================
    -- [[ CLASS MODULES — HUNTER ]] --------------------------------------
    -- ========================================================================

    -- [[ Camouflage ]] ----------------------------------------
    Camouflage              = "Camuflagem",
    EnableOnCamouflage      = "Ativar na Camuflagem",
    CamouflageActiveText    = "CAMUFLADO",

    -- [[ Misdirection ]] --------------------------------------
    Misdirection            = "Redirecionar",
    MisdirTargetLog         = "Alvo do Redirecionar",
    MisdirectionNotLearned  = "Você ainda não aprendeu Redirecionar.",
    MisdirectionMsgEnabled  = "Sistema de Redirecionar ativado e macro sincronizado.",
    MisdirectionMsgDisabled = "Sistema de Redirecionar desativado e macro removido.",
    MisdirectionAlreadyEnabled = "Sistema de Redirecionar já está ativado.",
    MisdirectionAlreadyDisabled = "Sistema de Redirecionar já está desativado.",

    -- ========================================================================
    -- [[ CLASS MODULES — DRUID ]] ---------------------------------------
    -- ========================================================================

    -- [[ Prowl ]] ---------------------------------------------
    Prowl                   = "Espreitar",
    EnableOnProwl           = "Ativar ao Espreitar",
    ProwlActiveText         = "ESPREITANDO",

    -- ========================================================================
    -- [[ PROFILE MANAGEMENT ]] ------------------------------------------
    -- ========================================================================
    Profiles                = "Perfis",
    ActiveProfile           = "Perfil Ativo",
    ActiveProfileDesc       = "Select which profile to use for this character.",
    CreateProfile           = "Criar Perfil",
    CreateProfileDesc       = "Create a new profile with default settings.",
    DuplicateProfile        = "Duplicar Perfil",
    DuplicateProfileDesc    = "Create a copy of the current profile.",
    DeleteProfile           = "Excluir Perfil",
    DeleteProfileDesc       = "Remove the selected profile (cannot delete Default).",
    ExportProfile           = "Exportar Perfil",
    ExportProfileDesc       = "Generate a string to share this profile with others.",
    ImportProfile           = "Importar Perfil",
    ImportProfileDesc       = "Import a profile from a shared string.",
    DefaultProfileLabel     = "Padrão",
    CreateProfilePrompt     = "Digite um nome para o novo perfil:",
    DuplicateProfilePrompt  = "Digite um nome para o perfil duplicado:",
    ExportProfilePrompt     = "Copie esta string de exportação (Ctrl+C):\n\nPerfil: |cff00ff00%s|r",
    ImportProfilePrompt     = "Cole a string de exportação do perfil abaixo:",
    ImportProfileNamePrompt = "Digite um nome para o perfil importado:",
    DeleteProfileConfirm    = "Excluir perfil:\n\n|cffff0000%s|r\n\nIsso não pode ser desfeito.",
    FactoryResetBtn         = "Restaurar Padrões",
    FactoryResetBtnDesc     = "Deletes all addon data and macros, restoring to a clean installation. UI will reload.",
    FactoryResetConfirm     = "|cffff0000AVISO:|r Isso deletará |cffff0000TODAS|r as suas configurações e perfis do Nightveil, e removerá os macros aplicados pelo addon.\n\nEsta ação é |cffff0000IRREVERSÍVEL|r.\n\nTem certeza que deseja prosseguir?",
    ErrorProfileDeleteRestricted = "Você não pode excluir o perfil Padrão.",
    Import                  = "Importar",
    Share                   = "Compartilhar",
    Next                    = "Next",

    -- ========================================================================
    -- [[ CHAT CHANNELS ]] -----------------------------------------------
    -- ========================================================================
    ChannelSay              = "Dizer",
    ChannelParty            = "Grupo",
    ChannelRaid             = "Raid",
    ChannelInstance         = "Instância",
    ChannelYell             = "Gritar",

    -- ========================================================================
    -- [[ SYSTEM NOTIFICATIONS & ERRORS ]] -------------------------------
    -- ========================================================================
    ErrorHardReset          = "|cffff2020Versão antiga ou incompatível detectada.|r\n\nAs configurações serão |cffffcc00reiniciadas|r para garantir a estabilidade.",
    WarningOutdatedConfig   = "|cffffcc00Configuração mais recente detectada!|r\n\nRecomenda-se |cffbe89e9atualizar|r o addon ou resetar o perfil.",
    ErrorChannelNoValid     = "|cffff2020Nenhum canal de chat válido disponível.|r",
    ErrorChannelAntiSpam    = "|cffff2020Restrições de anti-spam da Blizzard impedem o uso do canal|r |cffffcc00%s|r |cffff2020fora de instâncias.|r",
    ErrorChannelNoGroup     = "|cffff2020Você não está em um grupo. Canal|r |cffffcc00%s|r |cffff2020indisponível.|r",
    ErrorChannelNoRaid      = "|cffff2020Você não está em uma raid. Canal|r |cffffcc00%s|r |cffff2020indisponível.|r",
    ErrorChannelInvalidGroup = "|cffff2020Você está sozinho ou em um grupo inválido. Canal|r |cffffcc00%s|r |cffff2020indisponível.|r",
    ErrorChannelInstanceOnly = "|cffff2020Canal|r |cffffcc00%s|r |cffff2020indisponível fora de instâncias.|r",
    ErrorNotRogue           = "Você não é um Ladino. Este comando é exclusivo de Ladinos.",
    ErrorNotHunter          = "Você não é um Caçador. Este comando é exclusivo de Caçadores.",
    ErrorTricksNotLearned   = "Você ainda não aprendeu Truques do Ofício.",
    ErrorMisdirNotLearned   = "Você ainda não aprendeu Redirecionar.",
    ErrorShroudOnlyInstances = "|cffff2020Mensagens de Mortalha só funcionam dentro de instâncias.|r",
    ErrorCombatBlocked      = "Não é possível abrir as configurações durante o combate.",
    ErrorMacroLimitReached  = "Limite de macros atingido.",
    ErrorMacroCombatLock    = "Esta ação não pode ser usada em combate.",
    ErrorUnknownCmd         = "Comando desconhecido: |cffffcc00%s|r. Use |cffffcc00/veil help|r.",
    ErrorUnknownSubCmd      = "Sub-comando desconhecido: |cffffcc00%s|r. Use |cffffcc00/veil help|r.",
    DebugCombatLock         = "This action cannot be used in combat.",

    -- ========================================================================
    -- [[ COMMANDS HELP ]] -----------------------------------------------
    -- ========================================================================
    HelpSettings            = "Configurações",
    HelpTricks              = "Alvo de Truques",
    HelpMisdir              = "Alvo do Redirecionar",
    HelpMisdirPet           = "Pet mode",
    HelpInfo                = "Informações de diagnóstico",
    HelpShroudTest          = "Testar contagem da mortalha",
    HelpDebugToggle         = "Alternar modo debug",
    HelpForceRefresh        = "Forçar atualização do macro",
    HelpModeNormal          = "Modo Normal",
    HelpModeTank            = "Modo Tank",
    HelpModeTT              = "Modo Alvo do Alvo",
    HelpModeCustom          = "Modo Personalizado",
    HelpModeList            = "Listar e definir por índice",
    HelpModeSet             = "Definir por nome",

    -- ========================================================================
    -- [[ DEBUG & DIAGNOSTICS ]] -----------------------------------------
    -- ========================================================================
    DebugModeActivated      = "Modo Debug ATIVADO",
    DebugModeDeactivated    = "Modo Debug DESATIVADO",
    DebugModeRequired       = "Este comando requer Modo Debug. Digite |cffffcc00/veil debug|r para ativar.",
    DebugCommands           = "[Comandos de Debug]",
    DebugHeader             = "%s Diagnósticos:",
    DebugCombat             = "- Combate: %s",
    DebugStealth            = "- Furtividade/Sumir: %s",
    DebugInstance           = "- Instância: %s (Tipo: %s)",
    DebugGroup              = "- Grupo: %s (Raid: %s, Total: %d)",
    DebugComposition        = "- Composição: %d Jogadores, %d Pets, %d Outros",
    DebugTricksKnown        = "- Truques Conhecidos: %s",
    DebugTricksTarget       = "- Truques Alvo: %s (%s)",
    DebugTricksMacro        = "- Truques Macro: %s",
    DebugInvalidGroup       = "- Grupo Inválido: %s",
    DebugPlayer             = "JOGADOR",
    DebugPet                = "PET",
    DebugOther              = "OUTRO",
    DebugYes                = "SIM",
    DebugNo                 = "NÃO",
    DebugNone               = "nenhum",
    DebugUnknown            = "Desconhecido",
    DebugFallback1          = "- Fallback 1: %s (Usável: %s)",
    DebugFallback2          = "- Fallback 2: %s (Usable: %s)",
    DebugShroudUsage        = "Uso: |cffffcc00/veil shroud [1-20]|r",
    DebugTricksForcing      = "Forçando atualização do Truques...",
    DebugMisdirForcing      = "Forcing Misdirection update...",
    DebugMacroSuccess       = "Atualização do macro concluída com SUCESSO.",
    DebugMacroUpdated       = "Macro atualizado: %s",
    DebugMacroStatus        = "Macro: %s",
    DebugMacroEdited        = "Conteúdo do macro modificado e sincronizado.",

    -- ========================================================================
    -- [[ NPC / GAME TERMS ]] --------------------------------------------
    -- ========================================================================
    BrannBronzebeard        = "Brann Barbabronze",
    ValeeraSanguinar        = "Valeera Sanguinar",

}
