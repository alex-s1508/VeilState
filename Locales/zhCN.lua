local addonName, ns = ...
local locale = GetLocale()
if locale ~= "zhCN" then return end

ns.L = {
    -- ========================================================================
    -- [[ SYSTEM / GENERAL UI ]] ----------------------------------------------
    -- ========================================================================
    Enable              = "启用",
    EnableDesc          = "启用或禁用此功能。",
    Management          = "管理",
    ReleaseNotes        = "发行说明",

    -- ========================================================================
    -- [[ INTERFACE — Elements & Styles ]] ------------------------------------
    -- ========================================================================
    Color               = "颜色",
    ColorDesc           = "设置此元素使用的颜色。",
    Size                = "尺寸",
    SizeDesc            = "更改元素的尺寸。",
    Opacity             = "透明度",
    OpacityDesc         = "更改透明度。",
    Layer               = "层级",
    LayerDesc           = "绘制层级 (较高者显示在上方)。",
    LayerBackground     = "背景",
    LayerLow            = "低",
    LayerMedium         = "中",
    LayerHigh           = "高",
    LayerDialog         = "对话框",
    LayerFullscreen     = "全屏",
    Style               = "样式",
    StyleDesc           = "选择高亮样式。",

    -- ========================================================================
    -- [[ INTERFACE — Positioning & Anchors ]] --------------------------------
    -- ========================================================================
    OffsetX             = "横向偏移",
    OffsetXDesc         = "水平移动元素。",
    OffsetY             = "纵向偏移",
    OffsetYDesc         = "垂直移动元素。",
    AnchorToText        = "依附于文本",
    AnchorToTextDesc    = "将图标依附到文本位置。",
    AnchorPoint         = "锚点",
    AnchorPointDesc     = "用作锚点的文本侧边。",
    AnchorTopLeft       = "左上",
    AnchorTop           = "顶部",
    AnchorTopRight      = "右上",
    AnchorLeft          = "左侧",
    AnchorCenter        = "中心",
    AnchorRight         = "右侧",
    AnchorBottomLeft    = "左下",
    AnchorBottom        = "底部",
    AnchorBottomRight   = "右下",

    -- ========================================================================
    -- [[ INTERFACE — Icons & Multimedia ]] -----------------------------------
    -- ========================================================================
    IndicatorIcon       = "指示图标",
    EnableIconDesc      = "显示图标指示器。",
    IconTexture         = "图标材质",
    IconTextureDesc     = "自定义图标材质路径。",
    Sound               = "声音",
    SoundDesc           = "激活时播放声音警报。",
    SoundKitId          = "SoundKit ID",
    SoundKitIdDesc      = "播放的 SoundKit ID (数字)。",
    TestSound           = "测试声音",
    TestSoundDesc       = "立即播放选定的声音。",

    -- ========================================================================
    -- [[ INTERFACE — Message Customization ]] --------------------------------
    -- ========================================================================
    CustomText          = "自定义文本",
    CustomTextDesc      = "要显示的自定义消息文本。",
    FloatingText        = "浮动文本",
    Messages            = "信息",

    -- ========================================================================
    -- [[ INTERFACE — Logic Filters ]] ----------------------------------------
    -- ========================================================================
    OnlyInInstances     = "仅在副本中",
    OnlyInInstancesDesc = "仅在副本(地下城、团队副本、场景战役)中生效。",
    OnlyInCombat        = "仅在战斗中",
    OnlyInCombatDesc    = "仅在战斗时显示警告。",
    DisableInDungeons   = "在地下城中禁用",
    DisableInDungeonsDesc = "处于地下城副本时失效。",
    DisableInRaids      = "在团队副本中禁用",
    DisableInRaidsDesc  = "处于团队副本时失效。",
    InstanceFilters     = "副本过滤器",
    InstanceFiltersDesc = "配置应禁用此功能的场景。",

    -- ========================================================================
    -- [[ HIGHLIGHTS SYSTEM ]] ------------------------------------------------
    -- ========================================================================
    Highlight              = "高亮",
    HighlightDesc          = "在屏幕上高亮显示你的角色。",
    Highlights             = "高亮设置",
    HighlightGlobalDesc    = "|cffffa500在整个游戏事件中动态配置角色高亮。|r",
    HighlightOptNone              = "无",
    HighlightOptCircle            = "圆圈",
    HighlightOptOutline           = "轮廓",
    HighlightOptIcon              = "图标",
    HighlightOptCircleOutline     = "圆圈和轮廓",
    HighlightOptCircleIcon        = "圆圈和图标",
    HighlightOptOutlineIcon       = "轮廓和图标",
    HighlightOptCircleOutlineIcon = "圆圈、轮廓和图标",
    HighlightCombat     = "战斗中",
    HighlightCombatDesc = "在活动战斗中使用的高亮设置。",
    HighlightInstance   = "在副本中",
    HighlightInstanceDesc = "在地下城、团队副本或场景战役中使用的高亮设置。",
    HighlightHidden     = "处于隐藏状态",
    HighlightHiddenDesc = "当你处于潜行状态时使用的高亮设置。",
    ScreenColor         = "屏幕颜色",
    ScreenColorDesc     = "激活时为屏幕边缘染色。",
    Vignette            = "渐晕",
    VignetteDesc        = "在屏幕周围添加渐晕效果。",
    Thickness           = "厚度",
    ThicknessDesc       = "控制渐晕厚度。",

    -- ========================================================================
    -- [[ SHARED MODULES ]] ---------------------------------------------------
    -- ========================================================================
    -- [[ Stealth State Module ]] ---------------------------------------------
    StealthStateName        = "隐藏状态",
    StealthStateDesc        = "配置处于隐藏状态时的视觉效果。",
    StealthStateActiveText  = "隐藏状态 active",
    EnableOnStealthState    = "隐藏状态时启用",
    EnableOnStealthStateDesc = "在任何潜行状态激活时显示视觉效果 (使用 WoW 状态检测)。",

    -- ========================================================================
    -- [[ CLASS MODULES — ROGUE ]] --------------------------------------------
    -- ========================================================================
    -- [[ Stealth Module ]] ---------------------------------------------------
    Stealth             = "潜行",
    EnableOnStealth     = "潜行时启用",
    EnableOnStealthDesc = "在潜行或消失激活时显示视觉效果。",
    StealthUseState     = "使用状态检测",
    StealthUseStateDesc = "使用全局潜行状态而非特定光环。“光环”对比职业技能更精确，而“状态”则在任何潜行效果下激活。",
    DefaultMessage      = "潜行中",
    StealthActiveText   = "已潜行",

    -- [[ Poison Tracker ]] ---------------------------------------------------
    PoisonTracker          = "毒药监控",
    LethalPoisons          = "致命毒药",
    LethalPoisonsDesc      = "当缺失致命毒药时显示警告。",
    NonLethalPoisons       = "非致命毒药",
    NonLethalPoisonsDesc   = "当缺失非致命毒药时显示警告。",
    LethalPoisonMissing    = "缺失致命毒药",
    NonLethalPoisonMissing = "缺失非致命毒药",
    -- ========================================================================
    -- [[ MACRO SYSTEM (SHARED) ]] --------------------------------------------
    -- ========================================================================


    -- [[ Tricks of the Trade ]] ----------------------------------------------
    TricksOfTheTrade         = "嫁祸诀窍",
    MacroTargetHeader =  "目标",
    MacroTargetSelector =  "目标选择器",
    MacroTargetSelectorDesc =  "定义自动目标选择的主要逻辑。",
    MacroAutoUpdateWarning =  "|cffffa500Nightveil 会自动更新此宏。|r",
    TricksEnabledDesc        = "使用宏为嫁祸诀窍启用自动对齐目标。",
    MacroMouseoverDesc =  "启用鼠标悬停目标设置。\n\n注意：除地下堡伙伴外，此设置优先级最高。",
    MacroFocusDesc =  "启用通过焦点自动设置目标。\n\n注意：此设置优先级高于目标选择器，但会被鼠标悬停或地下堡伙伴忽略。",
    MacroMuteDesc =  "当宏更换目标时隐藏聊天通知。",
    MacroDelveCompanion =  "地下堡伙伴",
    MacroDelveCompanionDesc =  "在地下堡内自动将目标设为布兰·铜须或瓦莉拉·萨古纳尔。\n\n注意：在地下堡内拥有最高优先级。",
    TricksTargetLog          = "嫁祸目标",
    TricksNormal             = "普通",
    TricksCustom             = "自定义",
    MacroCustomName =  "自定义目标",
    MacroCustomNameDesc =  "输入要设为目标的玩家确切名称。",
    MacroCustomSet =  "自定义目标已设为: %s",
    MacroGroupMembers =  "小组内成员:",
    MacroInvalidIndex =  "无效的队伍索引。",
    MacroNoSelf =  "你不能以自己为目标。",
    MacroBtnEnable =  "激活并同步宏",
    MacroBtnDisable =  "禁用并移除宏",
    MacroBtnDisableDesc =  "禁用自动化目标设置并完全移除宏。",
    TricksMsgEnabled         = "嫁祸系统已激活，宏已同步。",
    TricksMsgDisabled        = "嫁祸系统已禁用，宏已移除。",
    TricksAlreadyEnabled     = "嫁祸诀窍系统已经启用。",
    TricksAlreadyDisabled    = "嫁祸诀窍系统已经禁用。",
    TricksLogicSet           = "目标设置模式设为: %s",
    Mouseover                = "鼠标悬停",
    Focus                    = "焦点",
    Tank                     = "坦克",
    TargetTarget             = "目标的目标",

    -- [[ Shroud of Concealment ]] --------------------------------------------
    ShroudOfConcealment      = "帷幕",
    EnableShroudCountdown    = "启用聊天倒计时",
    EnableShroudCountdownDesc = "向聊天频道发送帷幕倒计时消息。",
    ShroudOnlyInstancesDesc  = "仅在副本内发送帷幕消息。\n\n注意：由于暴雪反垃圾邮件限制，某些频道在副本外被封锁。",
    ShroudMuteErrors         = "静音错误",
    ShroudMuteErrorsDesc     = "禁用聊天中的帷幕错误信息。",
    ChatChannel              = "聊天频道",
    ChatChannelDesc          = "用于帷幕消息的首选聊天频道。",
    ChatChannelFallbackDesc  = "如果首选频道不可用，则使用的备用频道。",
    ShroudMessage            = "倒计时消息",
    ShroudMessageDesc        = "倒计时期间使用的消息模板。\n\n%time = 剩余时间。",
    ShroudOnStart            = "开始消息",
    ShroudOnStartDesc        = "帷幕开始时发送的消息。",
    ShroudOnEnd              = "结束消息",
    ShroudOnEndDesc          = "帷幕结束(0s)时发送的消息。",
    ShroudInterval           = "间隔模式",
    ShroudIntervalDesc       = "开始、中间和最后5秒",
    TimeRemainingHint        = "%time = 剩余时间",
    TestShroud               = "测试帷幕",
    TestShroudDesc           = "模拟本地 5 秒倒计时。\n\n注意：消息仅对你可见。",
    ShroudAlreadyActive      = "帷幕倒计时已激活。",
    ShroudDisabled           = "设置中已禁用帷幕倒计时。",
    ChannelSay               = "说",
    ChannelParty             = "小队",
    ChannelRaid              = "团队",
    ChannelInstance          = "副本",
    ChannelYell              = "大喊",

    -- ========================================================================
    
    -- ========================================================================
    -- [[ CLASS MODULES — HUNTER ]] --------------------------------------------
    -- ========================================================================
    -- [[ Camouflage Module ]] -------------------------------------------------
    Camouflage              = "伪装",
    EnableOnCamouflage      = "伪装时弃用",
    EnableOnCamouflageDesc  = "在伪装处于激活状态时显示主界面提示。",
    CamouflageActiveText    = "伪装中",

    -- [[ Misdirection ]] ------------------------------------------------------
    Misdirection                = "误导",
    MisdirEnabledDesc           = "通过宏启用“误导”的自动目标拾取。",
    MisdirTargetLog             = "误导目标",
    MisdirectionNotLearned      = "您尚未学会误导。",
    MisdirectionMsgEnabled      = "误导系统已激活并同步宏。",
    MisdirectionMsgDisabled     = "误导系统已停用并移除了宏。",
    MisdirectionAlreadyEnabled  = "误导系统已启用。",
    MisdirectionAlreadyDisabled = "误导系统已停用。",
    MisdirLogicSet              = "设置目标模式：%s",
    MisdirNotLearned            = "您尚未学会误导。",
    Pet                         = "宠物",

    -- [[ PROFILE MANAGEMENT ]] -----------------------------------------------
    -- ========================================================================
    Profiles              = "配置文件",
    ActiveProfile         = "当前配置文件",
    ActiveProfileDesc     = "选择当前激活的配置文件。",
    CreateProfile         = "创建配置文件",
    CreateProfileDesc     = "使用默认设置创建新的配置文件。",
    DuplicateProfile      = "复制配置文件",
    DuplicateProfileDesc  = "将当前配置文件复制到新配置文件中。",
    DeleteProfile         = "删除配置文件",
    DeleteProfileDesc     = "删除选定的配置文件 (不可撤销)。",
    ExportProfile         = "导出配置文件",
    ExportProfileDesc     = "生成用于共享此配置文件的字符串。",
    ImportProfile         = "导入配置文件",
    ImportProfileDesc     = "从导出的字符串导入配置文件。",
    CreateProfilePrompt   = "输入新配置文件的名称:",
    DuplicateProfilePrompt = "输入复制出的配置文件名称:",
    FactoryResetBtn       = "恢复出厂设置",
    FactoryResetBtnDesc   = "删除所有插件数据和宏，恢复到全新安装状态。界面将重新加载。",
    FactoryResetConfirm   = "|cffff0000警告:|r 这将删除 |cffff0000所有|r Nightveil 设置和项目，并移除插件创建的宏。\n\n此操作 |cffff0000不可逆|r。\n\n你确定要继续吗？",
    DeleteProfileConfirm  = "删除配置文件:\n\n|cffff0000%s|r\n\n此操作不可撤销。",
    ExportProfilePrompt   = "复制此导出字符串 (Ctrl+C):\n\n配置文件: |cff00ff00%s|r",
    ImportProfilePrompt   = "在下方粘贴配置文件的导出字符串:",
    ImportProfileNamePrompt = "输入导入配置文件的名称:",
    ErrorDeleteRestricted = "你不能删除默认配置文件。",
    DefaultProfileLabel   = "默认",
    Import                = "导入",
    Share                 = "分享",

    -- ========================================================================
    -- [[ SYSTEM MESSAGES & WARNINGS ]] ---------------------------------------
    -- ========================================================================
    WarningNotRogue         = "你不是潜行者，此命令仅限潜行者使用。",
    TricksNotLearned        = "你尚未学会嫁祸诀窍。",
    HardResetWarning        = "检测到旧版或不兼容的版本。\n\n设置将被重置以确保稳定性。",
    WarningOutdatedConfig   = "检测到更新的配置！\n\n你正在使用的配置文件是在较新版本的 Nightveil 中创建的。",
    WelcomeMessage          = "%s |cffffd100v%s|r 已加载。输入 |cffffd100/veil|r 打开设置。",
    UpdateMessage           = "%s 已更新至 |cffffd100v%s|r! 输入 |cffffd100/veil|r 查看更新内容。",
    ErrorNoValidChannel     = "|cffff2020无可用的聊天频道。|r",
    ErrorBlizzardAntiSpam   = "|cffff2020由于暴雪反垃圾邮件限制，无法在副本外使用频道|r |cffffcc00%s|r|cffff2020。|r",
    ErrorNotInGroup         = "|cffff2020你不在队伍中。频道 |cffffcc00%s|r |cffff2020不可用。|r",
    ErrorNotInRaid          = "|cffff2020你不在团队中。频道 |cffffcc00%s|r |cffff2020不可用。|r",
    ErrorFollowersDungeonGroup = "|cffff2020你独自一人或处于无效队伍中。频道 |cffffcc00%s|r |cffff2020不可用。|r",
    ErrorShroudOnlyInstances = "|cffff2020帷幕消息仅在副本内有效。",
    ErrorShroudInstanceOnly  = "|cffff2020你不在副本中。频道 |cffffcc00%s|r |cffff2020不可用。|r",
    CombatBlocked         = "战斗中无法打开设置。",
    MacroLimitReached     = "宏数量已达上限。",
    MuteChanges           = "静音更改",
    Next                  = "下一页",

    -- ========================================================================
    -- [[ COMMANDS HELP ]] ----------------------------------------------------
    -- ========================================================================
    HelpSettings          = "设置",
    HelpTricks            = "嫁祸目标",
    HelpUTricks           = "强制刷新宏",
    HelpMisdir            = "误导目标",
    HelpUMisdir           = "强制刷新宏",
    HelpMisdirPet         = "宠物模式",
    HelpMisdirNormal      = "正常模式",
    HelpMisdirTank        = "坦克模式",
    HelpMisdirTT          = "目标的目标模式",
    HelpMisdirCustom      = "自定义模式",
    HelpMisdirList        = "发送小队列表",
    HelpMisdirSet         = "设置自定义目标",
    HelpInfo              = "诊断信息",
    HelpShroudTest        = "测试帷幕倒计时",
    HelpDebugToggle       = "切换调试模式",
    HelpTricksList        = "列出并按索引设置",
    HelpTricksNormal      = "普通模式",
    HelpTricksTank        = "坦克模式",
    HelpTricksTT          = "目标的目标模式",
    HelpTricksSet         = "按名称设置",
    HelpTricksCustom      = "自定义模式",
    ErrorUnknownCmd       = "未知命令: |cffffd100%s|r。使用 |cffffd100/veil help|r。",
    ErrorUnknownSubCmd    = "未知子命令: |cffffd100%s|r。使用 |cffffd100/veil help|r。",

    -- ========================================================================
    -- [[ DEBUG INFO ]] -------------------------------------------------------
    -- ========================================================================
    DebugModeActivated   = "调试模式已激活",
    DebugModeDeactivated = "调试模式已停用",
    DebugModeRequired    = "此命令需要调试模式。输入 |cffffd100/veil debug|r 开启。",
    DebugCommands        = "[调试命令]",
    DebugHeader          = "%s 诊断:",
    DebugCombat          = " - 战斗中: %s",
    DebugStealth         = " - 潜行/消失: %s",
    DebugInstance        = " - 副本: %s (类型: %s)",
    DebugGroup           = " - 队伍: %s (团队: %s, 共 %d 人)",
    DebugComposition     = " - 构成: %d 玩家, %d 宠物, %d 其他",
    DebugTricksKnown     = " - 已学嫁祸: %s",
    DebugTricksTarget    = " - 嫁祸目标: %s (%s)",
    DebugTricksMacro     = " - 嫁祸宏: %s",
    DebugInvalidGroup    = " - 无效队伍: %s",
    DebugPlayer          = "玩家",
    DebugPet             = "宠物",
    DebugOther           = "其他",
    DebugYes             = "是",
    DebugNo              = "否",
    DebugNone            = "无",
    DebugUnknown         = "未知",
    DebugFallback1       = " - 备选 1: %s (可用: %s)",
    DebugFallback2       = " - 备选 2: %s (可用: %s)",
    DebugShroudUsage     = "用法: |cffffd100/veil shroud [1-20]|r",
    DebugTricksForcing   = "强制更新嫁祸...",
    DebugTricksSuccess   = "宏刷新成功。",
    DebugMacroUpdated    = "宏已更新: %s",
    DebugMacroStatus     = "宏: %s",
    DebugMacroEdited     = "宏内容已修改并同步。",
    DebugCombatLock      = "战斗中无法执行此操作。",

    -- ========================================================================
    -- [[ NPC / GAME TERMS ]] -------------------------------------------------
    -- ========================================================================
    BrannBronzebeard = "布兰·铜须",
    ValeeraSanguinar = "瓦莉拉·萨古纳尔",
}
