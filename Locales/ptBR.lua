local addonName, ns = ...
local locale = GetLocale()
if locale ~= "ptBR" then return end

ns.L = {
    -- ========================================================================
    -- [[ SYSTEM / GENERAL UI ]] ----------------------------------------------
    -- ========================================================================
    Enable              = "Ativar",
    EnableDesc          = "Ativa ou desativa este recurso.",
    Management          = "Gerenciamento",
    ReleaseNotes        = "Notas da Versão",

    -- ========================================================================
    -- [[ INTERFACE — Elements & Styles ]] ------------------------------------
    -- ========================================================================
    Color               = "Cor",
    ColorDesc           = "Define a cor usada por este elemento.",
    Size                = "Tamanho",
    SizeDesc            = "Altera o tamanho do elemento.",
    Opacity             = "Opacidade",
    OpacityDesc         = "Altera a transparência.",
    Layer               = "Camada",
    LayerDesc           = "Camada de desenho (mais alta aparece acima).",
    LayerBackground     = "Fundo",
    LayerLow            = "Baixa",
    LayerMedium         = "Média",
    LayerHigh           = "Alta",
    LayerDialog         = "Diálogo",
    LayerFullscreen     = "Tela Cheia",
    Style               = "Estilo",
    StyleDesc           = "Seleciona o estilo de destaque.",

    -- ========================================================================
    -- [[ INTERFACE — Positioning & Anchors ]] --------------------------------
    -- ========================================================================
    OffsetX             = "Deslocamento X",
    OffsetXDesc         = "Move o elemento horizontalmente.",
    OffsetY             = "Deslocamento Y",
    OffsetYDesc         = "Move o elemento verticalmente.",
    AnchorToText        = "Fixar no Texto",
    AnchorToTextDesc    = "Fixa o ícone na posição do texto.",
    AnchorPoint         = "Ponto de Fixação",
    AnchorPointDesc     = "Lado do texto usado como âncora.",
    AnchorTopLeft       = "Superior Esquerdo",
    AnchorTop           = "Superior",
    AnchorTopRight      = "Superior Direito",
    AnchorLeft          = "Esquerda",
    AnchorCenter        = "Centro",
    AnchorRight         = "Direita",
    AnchorBottomLeft    = "Inferior Esquerdo",
    AnchorBottom        = "Inferior",
    AnchorBottomRight   = "Inferior Direito",

    -- ========================================================================
    -- [[ INTERFACE — Icons & Multimedia ]] -----------------------------------
    -- ========================================================================
    IndicatorIcon       = "Ícone Indicador",
    EnableIconDesc      = "Mostra um indicador de ícone.",
    IconTexture         = "Textura do Ícone",
    IconTextureDesc     = "Caminho da textura do ícone personalizado.",
    Sound               = "Som",
    SoundDesc           = "Toca um alerta sonoro quando ativado.",
    SoundKitId          = "ID do SoundKit",
    SoundKitIdDesc      = "ID do SoundKit para tocar (número).",
    TestSound           = "Testar Som",
    TestSoundDesc       = "Toca o som selecionado agora.",

    -- ========================================================================
    -- [[ INTERFACE — Message Customization ]] --------------------------------
    -- ========================================================================
    CustomText          = "Texto Personalizado",
    CustomTextDesc      = "Texto da mensagem personalizada para exibir.",
    FloatingText        = "Texto Flutuante",
    Messages            = "Mensagens",

    -- ========================================================================
    -- [[ INTERFACE — Logic Filters ]] ----------------------------------------
    -- ========================================================================
    OnlyInInstances     = "Apenas em instâncias",
    OnlyInInstancesDesc = "Apenas ativa dentro de instâncias (Masmorras, Raides, Cenários).",
    OnlyInCombat        = "Apenas em combate",
    OnlyInCombatDesc    = "Apenas mostra avisos enquanto você está em combate.",
    DisableInDungeons   = "Desativar em Masmorras",
    DisableInDungeonsDesc = "Não se aplica quando estiver dentro de uma instância de Masmorra.",
    DisableInRaids      = "Desativar em Raides",
    DisableInRaidsDesc  = "Não se aplica quando estiver dentro de uma instância de Raide.",
    InstanceFilters     = "Filtros de Instância",
    InstanceFiltersDesc = "Configure onde este recurso deve ser desativado.",

    -- ========================================================================
    -- [[ HIGHLIGHTS SYSTEM ]] ------------------------------------------------
    -- ========================================================================
    Highlight              = "Destaque",
    HighlightDesc          = "Destaca seu personagem na tela.",
    Highlights             = "Destaques",
    HighlightGlobalDesc    = "|cffffa500Configura o destaque do personagem dinamicamente durante os eventos do jogo.|r",
    HighlightOptNone              = "Nenhum",
    HighlightOptCircle            = "Círculo",
    HighlightOptOutline           = "Contorno",
    HighlightOptIcon              = "Ícone",
    HighlightOptCircleOutline     = "Círculo e contorno",
    HighlightOptCircleIcon        = "Círculo e ícone",
    HighlightOptOutlineIcon       = "Contorno e ícone",
    HighlightOptCircleOutlineIcon = "Círculo, contorno e ícone",
    Highlights             = "Destaques",
    HighlightGlobalDesc    = "|cffffa500Configura o destaque do personagem dinamicamente durante os eventos do jogo.|r",
    HighlightCombat        = "Em Combate",
    HighlightCombatDesc    = "Destaque usado enquanto estiver em combate.",
    HighlightInstance      = "Em Instância",
    HighlightInstanceDesc  = "Destaque usado enquanto estiver em Masmorras, Raides ou Cenários.",
    HighlightHidden        = "Em Estado de Furtividade",
    HighlightHiddenDesc    = "Destaque usado enquanto estiver em um estado de Furtividade.",
    HighlightStealth       = "Em Furtividade",
    HighlightStealthDesc   = "Destaque usado quando você está em Furtividade.",
    HighlightShroud        = "Em Manto da Ocultação",
    HighlightShroudDesc    = "Destaque usado enquanto o Manto da Ocultação estiver ativo.",
    HighlightCamouflage    = "Em Camuflagem",
    HighlightCamouflageDesc= "Destaque usado enquanto estiver em Camuflagem.",
    ClassExclusive         = "Exclusivo de Classe",
    HighlightClassDesc     = "Estas opções usam as configurações específicas da sua classe.",
    ScreenColor         = "Cor da Tela",
    ScreenColorDesc     = "Colore a tela enquanto está ativo.",
    Vignette            = "Vinheta",
    VignetteDesc        = "Adiciona um efeito de vinheta ao redor da tela.",
    Thickness           = "Espessura",
    ThicknessDesc       = "Controla a espessura da vinheta.",

    -- ========================================================================
    -- [[ SHARED MODULES ]] ---------------------------------------------------
    -- ========================================================================
    -- [[ Stealth State Module ]] ---------------------------------------------
    StealthStateName        = "Estado de Furtividade",
    StealthStateDesc        = "Configure os visuais para quando você estiver em Estado de Furtividade.",
    StealthStateActiveText  = "ESTADO FURTIVO",
    EnableOnStealthState    = "Ativar no Estado de Furtividade",
    EnableOnStealthStateDesc = "Mostra os visuais durante qualquer Estado de Furtividade (usa detecção de estado do WoW).",

    -- ========================================================================
    -- [[ CLASS MODULES — ROGUE ]] --------------------------------------------
    -- ========================================================================
    -- [[ Stealth Module ]] ---------------------------------------------------
    Stealth             = "Furtividade",
    EnableOnStealth     = "Ativar com Furtividade",
    EnableOnStealthDesc = "Mostra os visuais enquanto Furtividade ou Sumir estão ativos.",
    StealthUseState     = "Usar Detecção de Estado",
    StealthUseStateDesc = "Usa o estado global de furtividade em vez de auras específicas. 'Aura' é mais preciso para habilidades de classe, enquanto 'Estado' ativa em qualquer efeito de furtividade.",
    DefaultMessage      = "FURTIVO",
    StealthActiveText   = "FURTIVO",

    -- [[ Poison Tracker ]] ---------------------------------------------------
    PoisonTracker          = "Monitor de Venenos",
    LethalPoisons          = "Veneno Letal",
    LethalPoisonsDesc      = "Mostra avisos quando falta o veneno letal.",
    NonLethalPoisons       = "Veneno Não Letal",
    NonLethalPoisonsDesc   = "Mostra avisos quando falta o veneno não letal.",
    LethalPoisonMissing    = "VENENO LETAL FALTANDO",
    NonLethalPoisonMissing = "VENENO NÃO LETAL FALTANDO",

    -- ========================================================================
    -- [[ MACRO SYSTEM (SHARED) ]] --------------------------------------------
    -- ========================================================================
    MacroTargetHeader       = "Alvo",
    MacroTargetSelector     = "Seletor de Alvo",
    MacroTargetSelectorDesc = "Define a lógica principal para seleção automática de alvos.",
    MacroAutoUpdateWarning  = "|cffffa500O Nightveil atualiza este macro automaticamente.|r",
    MacroMouseoverDesc      = "Ativa o direcionamento via mouseover.\n\nNota: Isso tem prioridade sobre todos os outros métodos, exceto o Companheiro da Imersão.",
    MacroFocusDesc          = "Ativa o direcionamento automatizado via foco.\n\nNota: Isso tem prioridade sobre o seletor de alvo, mas é ignorado pelo mouseover ou pelo Companheiro da Imersão.",
    MacroMuteDesc           = "Oculta notificações no chat quando o macro troca de alvo.",
    MacroDelveCompanion     = "Companheiro de Imersão",
    MacroDelveCompanionDesc = "Alveja automaticamente Brann Barbabronze ou Valeera Sanguinar dentro de Imersões.\n\nNota: Isso tem prioridade exclusiva dentro de Imersões.",
    MacroCustomName         = "Alvo Personalizado",
    MacroCustomNameDesc     = "Digite o nome exato do jogador.",
    MacroCustomSet          = "Alvo personalizado definido: %s",
    MacroGroupMembers       = "Membros do grupo:",
    MacroInvalidIndex       = "Índice de grupo inválido.",
    MacroNoSelf             = "Você não pode ser seu próprio alvo.",
    MacroBtnEnable          = "Ativar e Sincronizar Macro",
    MacroBtnDisable         = "Desativar e Remover Macro",
    MacroBtnDisableDesc     = "Desativa o direcionamento automatizado e remove completamente o macro.",
    Mouseover               = "Mouseover",
    Focus                   = "Foco",
    Tank                    = "Tank",
    TargetTarget            = "Alvo do Alvo",

    -- [[ Tricks of the Trade ]] ----------------------------------------------
    TricksOfTheTrade         = "Truques do Ofício",
    TricksEnabledDesc        = "Ativa o direcionamento automatizado para Truques do Ofício usando um macro.",
    TricksTargetLog          = "Alvo de Truques",
    TricksNormal             = "Normal",
    TricksCustom             = "Personalizado",
    TricksMsgEnabled         = "Sistema de Truques ativado e macro sincronizado.",
    TricksMsgDisabled        = "Sistema de Truques desativado e macro removido.",
    TricksAlreadyEnabled     = "O sistema de Truques do Ofício já está ativado.",
    TricksAlreadyDisabled    = "O sistema de Truques do Ofício já está desativado.",
    TricksLogicSet           = "Modo de alvo definido: %s",

    -- [[ Shroud of Concealment ]] --------------------------------------------
    ShroudOfConcealment      = "Mortalha da Ocultação",
    EnableShroudCountdown    = "Ativar contagem no chat",
    EnableShroudCountdownDesc = "Envia mensagens de contagem regressiva da Mortalha para o chat.",
    ShroudOnlyInstancesDesc  = "Apenas envia mensagens da Mortalha dentro de instâncias.\n\nNota: alguns canais são bloqueados fora de instâncias pelo anti-spam da Blizzard.",
    ShroudMuteErrors         = "Silenciar erros",
    ShroudMuteErrorsDesc     = "Desativa mensagens de erro da Mortalha no chat.",
    ChatChannel              = "Canal de Chat",
    ChatChannelDesc          = "Canal de chat primário usado para mensagens da Mortalha.",
    ChatChannelFallbackDesc  = "Canal alternativo usado se o anterior estiver indisponível.",
    ShroudMessage            = "Mensagem de Contagem",
    ShroudMessageDesc        = "Modelo de mensagem usado durante a contagem.\n\n%time = tempo restante.",
    ShroudOnStart            = "Mensagem de Início",
    ShroudOnStartDesc        = "Mensagem enviada quando a Mortalha começa.",
    ShroudOnEnd              = "Mensagem de Fim",
    ShroudOnEndDesc          = "Mensagem enviada quando a Mortalha termina (0s).",
    ShroudInterval           = "Modo Intervalo",
    ShroudIntervalDesc       = "Início, meio e últimos 5s",
    TimeRemainingHint        = "%time = tempo restante",
    TestShroud               = "Testar Mortalha",
    TestShroudDesc           = "Simula uma contagem regressiva local de 5 segundos.\n\nNota: As mensagens aparecem apenas para você.",
    ShroudAlreadyActive      = "A contagem regressiva da Mortalha já está ativa.",
    ShroudDisabled           = "A contagem da Mortalha está desativada nas configurações.",
    ChannelSay               = "Dizer",
    ChannelParty             = "Grupo",
    ChannelRaid              = "Raid",
    ChannelInstance          = "Instância",
    ChannelYell              = "Gritar",

    -- ========================================================================
    -- [[ CLASS MODULES — HUNTER ]] --------------------------------------------
    -- ========================================================================
    -- [[ Camouflage Module ]] -------------------------------------------------
    Camouflage              = "Camuflagem",
    EnableOnCamouflage      = "Ativar na Camuflagem",
    EnableOnCamouflageDesc  = "Mostra avisos visuais enquanto a Camuflagem está ativa.",
    CamouflageActiveText    = "CAMUFLADO",

    -- [[ Misdirection ]] ------------------------------------------------------
    Misdirection                = "Redirecionar",
    MisdirEnabledDesc           = "Ativa o direcionamento automatizado para Redirecionar usando um macro.",
    MisdirTargetLog             = "Alvo do Redirecionar",
    MisdirectionNotLearned      = "Você ainda não aprendeu Redirecionar.",
    MisdirectionMsgEnabled      = "Sistema de Redirecionar ativado e macro sincronizado.",
    MisdirectionMsgDisabled     = "Sistema de Redirecionar desativado e macro removido.",
    MisdirectionAlreadyEnabled  = "Sistema de Redirecionar já está ativado.",
    MisdirectionAlreadyDisabled = "Sistema de Redirecionar já está desativado.",
    MisdirLogicSet              = "Modo de alvo definido: %s",
    MisdirNotLearned            = "Você ainda não aprendeu Redirecionar.",
    Pet                         = "Mascote",

    -- ========================================================================
    -- [[ PROFILE MANAGEMENT ]] -----------------------------------------------
    -- ========================================================================
    Profiles              = "Perfis",
    ActiveProfile         = "Perfil Ativo",
    ActiveProfileDesc     = "Selecione qual perfil está ativo.",
    CreateProfile         = "Criar Perfil",
    CreateProfileDesc     = "Cria um novo perfil com configurações padrão.",
    DuplicateProfile      = "Duplicar Perfil",
    DuplicateProfileDesc  = "Copia o perfil atual para um novo.",
    DeleteProfile         = "Excluir Perfil",
    DeleteProfileDesc     = "Exclui o perfil selecionado (não pode ser desfeito).",
    ExportProfile         = "Exportar Perfil",
    ExportProfileDesc     = "Gera uma string para compartilhar este perfil.",
    ImportProfile         = "Importar Perfil",
    ImportProfileDesc     = "Importa um perfil de uma string exportada.",
    CreateProfilePrompt   = "Digite um nome para o novo perfil:",
    DuplicateProfilePrompt = "Digite um nome para o perfil duplicado:",
    FactoryResetBtn       = "Restaurar Padrões",
    FactoryResetBtnDesc   = "Deleta todos os dados do addon e macros, restaurando para uma instalação limpa. A UI será recarregada.",
    FactoryResetConfirm   = "|cffff0000AVISO:|r Isso deletará |cffff0000TODAS|r as suas configurações e perfis do Nightveil, e removerá os macros aplicados pelo addon.\n\nEsta ação é |cffff0000IRREVERSÍVEL|r.\n\nTem certeza que deseja prosseguir?",
    DeleteProfileConfirm  = "Excluir perfil:\n\n|cffff0000%s|r\n\nIsso não pode ser desfeito.",
    ExportProfilePrompt   = "Copie esta string de exportação (Ctrl+C):\n\nPerfil: |cff00ff00%s|r",
    ImportProfilePrompt   = "Cole a string de exportação do perfil abaixo:",
    ImportProfileNamePrompt = "Digite um nome para o perfil importado:",
    ErrorDeleteRestricted = "Você não pode excluir o perfil Padrão.",
    DefaultProfileLabel   = "Padrão",
    Import                = "Importar",
    Share                 = "Compartilhar",

    -- ========================================================================
    -- [[ SYSTEM MESSAGES & WARNINGS ]] ---------------------------------------
    -- ========================================================================
    WarningNotRogue         = "Você não é um Ladino. Este comando é exclusivo de Ladinos.",
    TricksNotLearned        = "Você ainda não aprendeu Truques do Ofício.",
    HardResetWarning        = "Versão antiga ou incompatível detectada.\n\nAs configurações serão reiniciadas para garantir a estabilidade.",
    WarningOutdatedConfig   = "Configuração mais recente detectada!\n\nO perfil que você está usando foi criado em uma versão mais recente do Nightveil.",
    WelcomeMessage          = "%s |cffffd100v%s|r carregado. Digite |cffffd100/veil|r para abrir as configurações.",
    UpdateMessage           = "%s atualizado para |cffffd100v%s|r! Digite |cffffd100/veil|r para ver as novidades.",
    ErrorNoValidChannel     = "|cffff2020Nenhum canal de chat válido disponível.|r",
    ErrorBlizzardAntiSpam   = "|cffff2020Restrições de anti-spam da Blizzard impedem o uso do canal|r |cffffcc00%s|r |cffff2020fora de instâncias.|r",
    ErrorNotInGroup         = "|cffff2020Você não está em um grupo. Canal|r |cffffcc00%s|r |cffff2020indisponível.|r",
    ErrorNotInRaid          = "|cffff2020Você não está em uma raid. Canal|r |cffffcc00%s|r |cffff2020indisponível.|r",
    ErrorFollowersDungeonGroup = "|cffff2020Você está sozinho ou em um grupo inválido. Canal|r |cffffcc00%s|r |cffff2020indisponível.|r",
    ErrorShroudOnlyInstances = "|cffff2020Mensagens de Mortalha só funcionam dentro de instâncias.|r",
    ErrorShroudInstanceOnly  = "|cffff2020Você não está dentro de uma instância. Canal|r |cffffcc00%s|r |cffff2020indisponível.|r",
    CombatBlocked         = "Não é possível abrir as configurações durante o combate.",
    MacroLimitReached     = "Limite de macros atingido.",
    MuteChanges           = "Silenciar Mudanças",
    Next                  = "Próximo",

    -- ========================================================================
    -- [[ COMMANDS HELP ]] ----------------------------------------------------
    -- ========================================================================
    HelpSettings          = "Configurações",
    HelpTricks            = "Alvo de Truques",
    HelpUTricks           = "Forçar atualização do macro",
    HelpMisdir            = "Alvo do Redirecionar",
    HelpUMisdir           = "Forçar atualização do macro",
    HelpMisdirPet         = "Modo Mascote",
    HelpMisdirNormal      = "Modo Normal",
    HelpMisdirTank        = "Modo Tank",
    HelpMisdirTT          = "Modo Alvo do Alvo",
    HelpMisdirCustom      = "Modo Personalizado",
    HelpMisdirList        = "Listar e definir por índice",
    HelpMisdirSet         = "Definir por nome",
    HelpInfo              = "Informações de diagnóstico",
    HelpShroudTest        = "Testar contagem da mortalha",
    HelpDebugToggle       = "Alternar modo debug",
    HelpTricksList        = "Listar e definir por índice",
    HelpTricksNormal      = "Modo Normal",
    HelpTricksTank        = "Modo Tank",
    HelpTricksTT          = "Modo Alvo do Alvo",
    HelpTricksSet         = "Definir por nome",
    HelpTricksCustom      = "Modo Personalizado",
    ErrorUnknownCmd       = "Comando desconhecido: |cffffd100%s|r. Use |cffffd100/veil help|r.",
    ErrorUnknownSubCmd    = "Sub-comando desconhecido: |cffffd100%s|r. Use |cffffd100/veil help|r.",

    -- ========================================================================
    -- [[ DEBUG INFO ]] -------------------------------------------------------
    -- ========================================================================
    DebugModeActivated   = "Modo Debug ATIVADO",
    DebugModeDeactivated = "Modo Debug DESATIVADO",
    DebugModeRequired    = "Este comando requer Modo Debug. Digite |cffffd100/veil debug|r para ativar.",
    DebugCommands        = "[Comandos de Debug]",
    DebugHeader          = "%s Diagnósticos:",
    DebugCombat          = " - Combate: %s",
    DebugStealth         = " - Furtividade/Sumir: %s",
    DebugInstance        = " - Instância: %s (Tipo: %s)",
    DebugGroup           = " - Grupo: %s (Raid: %s, Total: %d)",
    DebugComposition     = " - Composição: %d Jogadores, %d Pets, %d Outros",
    DebugTricksKnown     = " - Truques Conhecidos: %s",
    DebugTricksTarget    = " - Truques Alvo: %s (%s)",
    DebugTricksMacro     = " - Truques Macro: %s",
    DebugInvalidGroup    = " - Grupo Inválido: %s",
    DebugPlayer          = "JOGADOR",
    DebugPet             = "PET",
    DebugOther           = "OUTRO",
    DebugYes             = "SIM",
    DebugNo              = "NÃO",
    DebugNone            = "nenhum",
    DebugUnknown         = "Desconhecido",
    DebugFallback1       = " - Fallback 1: %s (Usável: %s)",
    DebugFallback2       = " - Fallback 2: %s (Usable: %s)",
    DebugShroudUsage     = "Uso: |cffffd100/veil shroud [1-20]|r",
    DebugTricksForcing   = "Forçando atualização do Truques...",
    DebugTricksSuccess   = "Atualização do macro concluída com SUCESSO.",
    DebugMacroUpdated    = "Macro atualizado: %s",
    DebugMacroStatus     = "Macro: %s",
    DebugMacroEdited     = "Conteúdo do macro modificado e sincronizado.",
    DebugCombatLock      = "Esta ação não pode ser usada em combate.",

    -- ========================================================================
    -- [[ NPC / GAME TERMS ]] -------------------------------------------------
    -- ========================================================================
    BrannBronzebeard = "Brann Barbabronze",
    ValeeraSanguinar = "Valeera Sanguinar",
}
