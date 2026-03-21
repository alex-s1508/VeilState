local addonName, ns = ...
local locale = GetLocale()
if locale ~= "zhCN" then return end

ns.L = {
    -- ========================================================================
    -- [[ SYSTEM / GENERAL UI ]] -----------------------------------------
    -- ========================================================================
    Enable                  = "启用",
    Management              = "管理",
    ReleaseNotes            = "发行说明",
    WelcomeMessage          = "%s |cffffcc00v%s|r 已加载。输入 |cffffcc00/veil|r 打开设置。",
    UpdateMessage           = "%s 已更新至 |cffffcc00v%s|r! 输入 |cffffcc00/veil|r 查看更新内容。",
    FloatingText            = "浮动文本",

    -- ========================================================================
    -- [[ INTERFACE — Elements & Styles ]] -------------------------------
    -- ========================================================================
    Color                   = "颜色",
    Size                    = "尺寸",
    Opacity                 = "透明度",
    Thickness               = "厚度",
    Style                   = "样式",
    Layer                   = "层级",
    LayerBackground         = "背景",
    LayerLow                = "低",
    LayerMedium             = "中",
    LayerHigh               = "高",
    LayerDialog             = "对话框",
    LayerFullscreen         = "全屏",
    ScreenColor             = "屏幕颜色",
    Vignette                = "渐晕",

    -- ========================================================================
    -- [[ INTERFACE — Positioning & Anchors ]] ---------------------------
    -- ========================================================================
    AnchorPoint             = "锚点",
    AnchorToText            = "依附于文本",
    OffsetX                 = "横向偏移",
    OffsetY                 = "纵向偏移",
    AnchorTopLeft           = "左上",
    AnchorTop               = "顶部",
    AnchorTopRight          = "右上",
    AnchorLeft              = "左侧",
    AnchorCenter            = "中心",
    AnchorRight             = "右侧",
    AnchorBottomLeft        = "左下",
    AnchorBottom            = "底部",
    AnchorBottomRight       = "右下",

    -- ========================================================================
    -- [[ INTERFACE — Icons & Multimedia ]] ------------------------------
    -- ========================================================================
    IndicatorIcon           = "指示图标",
    IconTexture             = "图标材质",
    Sound                   = "声音",
    SoundKitId              = "SoundKit ID",
    TestSound               = "测试声音",

    -- ========================================================================
    -- [[ INTERFACE — Logic & Filters ]] ---------------------------------
    -- ========================================================================
    OnlyInInstances         = "仅在副本中",
    OnlyInCombat            = "仅在战斗中",
    DisableInDungeons       = "在地下城中禁用",
    DisableInRaids          = "在团队副本中禁用",
    InstanceFilters         = "副本过滤器",

    -- ========================================================================
    -- [[ INTERFACE — Message Customization ]] ---------------------------
    -- ========================================================================
    CustomText              = "自定义文本",
    Messages                = "信息",

    -- ========================================================================
    -- [[ SHARED MODULES — Highlights ]] ---------------------------------
    -- ========================================================================
    Highlights              = "高亮设置",
    Highlight               = "高亮",
    HighlightGlobalDesc     = "|cffffa500在整个游戏事件中动态配置角色高亮。|r",
    HighlightCombat         = "战斗中",
    HighlightCombatDesc     = "Highlight style when entering combat.",
    HighlightInstance       = "在副本中",
    HighlightInstanceDesc   = "Highlight style when inside a dungeon or raid.",
    HighlightHidden         = "处于隐藏状态",
    HighlightHiddenDesc     = "Highlight style when in a custom stealth state.",
    HighlightStealth        = "In Stealth",
    HighlightStealthDesc    = "Highlight style when stealthed.",
    HighlightShroud         = "In Shroud of Concealment",
    HighlightShroudDesc     = "Highlight style when inside Shroud of Concealment.",
    HighlightCamouflage     = "In Camouflage",
    HighlightCamouflageDesc = "Highlight style when camouflaged.",
    HighlightProwl          = "In Prowl",
    HighlightProwlDesc      = "Highlight style when prowling.",
    HighlightOptNone        = "无",
    HighlightOptCircle      = "圆圈",
    HighlightOptOutline     = "轮廓",
    HighlightOptIcon        = "图标",
    HighlightOptCircleOutline = "圆圈和轮廓",
    HighlightOptCircleIcon  = "圆圈和图标",
    HighlightOptOutlineIcon = "轮廓和图标",
    HighlightOptCircleOutlineIcon = "圆圈、轮廓和图标",

    -- ========================================================================
    -- [[ SHARED MODULES — Stealth State ]] ------------------------------
    -- ========================================================================
    StealthStateName        = "隐藏状态",
    StealthStateActiveText  = "隐藏状态 active",
    EnableOnStealthState    = "隐藏状态时启用",

    -- ========================================================================
    -- [[ SHARED MODULES — Macro System ]] -------------------------------
    -- ========================================================================
    MacroTargetHeader       = "目标",
    MacroTargetSelector     = "目标选择器",
    MacroAutoUpdateWarning  = "|cffffa500Nightveil 会自动更新此宏。|r",
    MacroDelveCompanion     = "地下堡伙伴",
    MacroCustomName         = "自定义目标",
    MacroCustomSet          = "自定义目标已设为: %s",
    MacroGroupMembers       = "小组内成员:",
    MacroInvalidIndex       = "无效的队伍索引。",
    MacroNoSelf             = "你不能以自己为目标。",
    MacroBtnEnable          = "激活并同步宏",
    MacroBtnDisable         = "禁用并移除宏",
    Mouseover               = "鼠标悬停",
    Focus                   = "焦点",
    Tank                    = "坦克",
    TargetTarget            = "目标的目标",
    TargetingModeSet        = "目标设置模式设为: %s",
    Pet                     = "宠物",
    MuteChanges             = "Mute status changes",

    -- ========================================================================
    -- [[ CLASS MODULES — ROGUE ]] ---------------------------------------
    -- ========================================================================

    -- [[ Stealth ]] -------------------------------------------
    Stealth                 = "潜行",
    EnableOnStealth         = "潜行时启用",
    StealthUseState         = "使用状态检测",
    StealthActiveText       = "已潜行",

    -- [[ Poison Tracker ]] ------------------------------------
    PoisonTracker           = "毒药监控",
    LethalPoisons           = "致命毒药",
    NonLethalPoisons        = "非致命毒药",
    LethalPoisonMissing     = "缺失致命毒药",
    NonLethalPoisonMissing  = "缺失非致命毒药",

    -- [[ Tricks of the Trade ]] -------------------------------
    TricksOfTheTrade        = "嫁祸诀窍",
    TricksTargetLog         = "嫁祸目标",
    TricksNormal            = "普通",
    TricksCustom            = "自定义",
    TricksMsgEnabled        = "嫁祸系统已激活，宏已同步。",
    TricksMsgDisabled       = "嫁祸系统已禁用，宏已移除。",
    TricksAlreadyEnabled    = "嫁祸诀窍系统已经启用。",
    TricksAlreadyDisabled   = "嫁祸诀窍系统已经禁用。",

    -- [[ Shroud of Concealment ]] -----------------------------
    ShroudOfConcealment     = "帷幕",
    EnableShroudCountdown   = "启用聊天倒计时",
    ShroudMuteErrors        = "静音错误",
    ChatChannel             = "聊天频道",
    ShroudMessage           = "倒计时消息",
    ShroudOnStart           = "开始消息",
    ShroudOnEnd             = "结束消息",
    ShroudInterval          = "间隔模式",
    TestShroud              = "测试帷幕",
    ShroudAlreadyActive     = "帷幕倒计时已激活。",
    ShroudDisabled          = "设置中已禁用帷幕倒计时。",

    -- ========================================================================
    -- [[ CLASS MODULES — HUNTER ]] --------------------------------------
    -- ========================================================================

    -- [[ Camouflage ]] ----------------------------------------
    Camouflage              = "伪装",
    EnableOnCamouflage      = "伪装时弃用",
    CamouflageActiveText    = "伪装中",

    -- [[ Misdirection ]] --------------------------------------
    Misdirection            = "误导",
    MisdirTargetLog         = "误导目标",
    MisdirectionNotLearned  = "您尚未学会误导。",
    MisdirectionMsgEnabled  = "误导系统已激活并同步宏。",
    MisdirectionMsgDisabled = "误导系统已停用并移除了宏。",
    MisdirectionAlreadyEnabled = "误导系统已启用。",
    MisdirectionAlreadyDisabled = "误导系统已停用。",

    -- ========================================================================
    -- [[ CLASS MODULES — DRUID ]] ---------------------------------------
    -- ========================================================================

    -- [[ Prowl ]] ---------------------------------------------
    Prowl                   = "潜行",
    EnableOnProwl           = "潜行时启用",
    ProwlActiveText         = "潜行中",

    -- ========================================================================
    -- [[ PROFILE MANAGEMENT ]] ------------------------------------------
    -- ========================================================================
    Profiles                = "配置文件",
    ActiveProfile           = "当前配置文件",
    ActiveProfileDesc       = "Select which profile to use for this character.",
    CreateProfile           = "创建配置文件",
    CreateProfileDesc       = "Create a new profile with default settings.",
    DuplicateProfile        = "复制配置文件",
    DuplicateProfileDesc    = "Create a copy of the current profile.",
    DeleteProfile           = "删除配置文件",
    DeleteProfileDesc       = "Remove the selected profile (cannot delete Default).",
    ExportProfile           = "导出配置文件",
    ExportProfileDesc       = "Generate a string to share this profile with others.",
    ImportProfile           = "导入配置文件",
    ImportProfileDesc       = "Import a profile from a shared string.",
    DefaultProfileLabel     = "默认",
    CreateProfilePrompt     = "输入新配置文件的名称:",
    DuplicateProfilePrompt  = "输入复制出的配置文件名称:",
    ExportProfilePrompt     = "复制此导出字符串 (Ctrl+C):\n\n配置文件: |cff00ff00%s|r",
    ImportProfilePrompt     = "在下方粘贴配置文件的导出字符串:",
    ImportProfileNamePrompt = "输入导入配置文件的名称:",
    DeleteProfileConfirm    = "删除配置文件:\n\n|cffff0000%s|r\n\n此操作不可撤销。",
    FactoryResetBtn         = "恢复出厂设置",
    FactoryResetBtnDesc     = "Deletes all addon data and macros, restoring to a clean installation. UI will reload.",
    FactoryResetConfirm     = "|cffff0000警告:|r 这将删除 |cffff0000所有|r Nightveil 设置和项目，并移除插件创建的宏。\n\n此操作 |cffff0000不可逆|r。\n\n你确定要继续吗？",
    ErrorProfileDeleteRestricted = "你不能删除默认配置文件。",
    Import                  = "导入",
    Share                   = "分享",
    Next                    = "Next",

    -- ========================================================================
    -- [[ CHAT CHANNELS ]] -----------------------------------------------
    -- ========================================================================
    ChannelSay              = "说",
    ChannelParty            = "小队",
    ChannelRaid             = "团队",
    ChannelInstance         = "副本",
    ChannelYell             = "大喊",

    -- ========================================================================
    -- [[ SYSTEM NOTIFICATIONS & ERRORS ]] -------------------------------
    -- ========================================================================
    ErrorHardReset          = "|cffff2020检测到旧版本或不兼容版本。|r\n\n设置将被 |cffffcc00重置|r 以确保稳定性。",
    WarningOutdatedConfig   = "|cffffcc00检测到较新的配置！|r\n\n建议 |cffbe89e9更新|r 插件或重置配置文件。",
    ErrorChannelNoValid     = "|cffff2020无可用的聊天频道。|r",
    ErrorChannelAntiSpam    = "|cffff2020由于暴雪反垃圾邮件限制，无法在副本外使用频道|r |cffffcc00%s|r|cffff2020。|r",
    ErrorChannelNoGroup     = "|cffff2020你不在队伍中。频道 |cffffcc00%s|r |cffff2020不可用。|r",
    ErrorChannelNoRaid      = "|cffff2020你不在团队中。频道 |cffffcc00%s|r |cffff2020不可用。|r",
    ErrorChannelInvalidGroup = "|cffff2020你独自一人或处于无效队伍中。频道 |cffffcc00%s|r |cffff2020不可用。|r",
    ErrorChannelInstanceOnly = "|cffff2020Channel|r |cffffcc00%s|r |cffff2020unavailable outside instances.|r",
    ErrorNotRogue           = "你不是潜行者，此命令仅限潜行者使用。",
    ErrorNotHunter          = "You are not a Hunter. This command is Hunter-only.",
    ErrorTricksNotLearned   = "你尚未学会嫁祸诀窍。",
    ErrorMisdirNotLearned   = "You have not learned Misdirection yet.",
    ErrorShroudOnlyInstances = "|cffff2020帷幕消息仅在副本内有效。",
    ErrorCombatBlocked      = "战斗中无法打开设置。",
    ErrorMacroLimitReached  = "宏数量已达上限。",
    ErrorMacroCombatLock    = "This action cannot be used in combat.",
    ErrorUnknownCmd         = "未知命令: |cffffcc00%s|r。使用 |cffffcc00/veil help|r。",
    ErrorUnknownSubCmd      = "未知子命令: |cffffcc00%s|r。使用 |cffffcc00/veil help|r。",
    DebugCombatLock         = "This action cannot be used in combat.",

    -- ========================================================================
    -- [[ COMMANDS HELP ]] -----------------------------------------------
    -- ========================================================================
    HelpSettings            = "设置",
    HelpTricks              = "嫁祸目标",
    HelpMisdir              = "误导目标",
    HelpMisdirPet           = "Pet mode",
    HelpInfo                = "诊断信息",
    HelpShroudTest          = "测试帷幕倒计时",
    HelpDebugToggle         = "切换调试模式",
    HelpForceRefresh        = "强制刷新宏",
    HelpModeNormal          = "普通模式",
    HelpModeTank            = "坦克模式",
    HelpModeTT              = "目标的目标模式",
    HelpModeCustom          = "自定义模式",
    HelpModeList            = "列出并按索引设置",
    HelpModeSet             = "按名称设置",

    -- ========================================================================
    -- [[ DEBUG & DIAGNOSTICS ]] -----------------------------------------
    -- ========================================================================
    DebugModeActivated      = "调试模式已激活",
    DebugModeDeactivated    = "调试模式已停用",
    DebugModeRequired       = "此命令需要调试模式。输入 |cffffcc00/veil debug|r 开启。",
    DebugCommands           = "[调试命令]",
    DebugHeader             = "%s 诊断:",
    DebugCombat             = "- 战斗中: %s",
    DebugStealth            = "- 潜行/消失: %s",
    DebugInstance           = "- 副本: %s (类型: %s)",
    DebugGroup              = "- 队伍: %s (团队: %s, 共 %d 人)",
    DebugComposition        = "- 构成: %d 玩家, %d 宠物, %d 其他",
    DebugTricksKnown        = "- 已学嫁祸: %s",
    DebugTricksTarget       = "- 嫁祸目标: %s (%s)",
    DebugTricksMacro        = "- 嫁祸宏: %s",
    DebugInvalidGroup       = "- 无效队伍: %s",
    DebugPlayer             = "玩家",
    DebugPet                = "宠物",
    DebugOther              = "其他",
    DebugYes                = "是",
    DebugNo                 = "否",
    DebugNone               = "无",
    DebugUnknown            = "未知",
    DebugFallback1          = "- 备选 1: %s (可用: %s)",
    DebugFallback2          = "- 备选 2: %s (可用: %s)",
    DebugShroudUsage        = "用法: |cffffcc00/veil shroud [1-20]|r",
    DebugTricksForcing      = "强制更新嫁祸...",
    DebugMisdirForcing      = "Forcing Misdirection update...",
    DebugMacroSuccess       = "宏刷新成功。",
    DebugMacroUpdated       = "宏已更新: %s",
    DebugMacroStatus        = "宏: %s",
    DebugMacroEdited        = "宏内容已修改并同步。",

    -- ========================================================================
    -- [[ NPC / GAME TERMS ]] --------------------------------------------
    -- ========================================================================
    BrannBronzebeard        = "布兰·铜须",
    ValeeraSanguinar        = "瓦莉拉·萨古纳尔",

}
