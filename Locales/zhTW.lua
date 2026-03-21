local addonName, ns = ...
local locale = GetLocale()
if locale ~= "zhTW" then return end

ns.L = {
    -- ========================================================================
    -- [[ SYSTEM / GENERAL UI ]] -----------------------------------------
    -- ========================================================================
    Enable                  = "啟用",
    Management              = "管理",
    ReleaseNotes            = "版本更新說明",
    WelcomeMessage          = "%s |cffffcc00v%s|r 已加載。輸入 |cffffcc00/veil|r 打開設置。",
    UpdateMessage           = "%s 已更新至 |cffffcc00v%s|r! 輸入 |cffffcc00/veil|r 查看更新內容。",
    FloatingText            = "浮動文字",

    -- ========================================================================
    -- [[ INTERFACE — Elements & Styles ]] -------------------------------
    -- ========================================================================
    Color                   = "顏色",
    Size                    = "尺寸",
    Opacity                 = "透明度",
    Thickness               = "厚度",
    Style                   = "樣式",
    Layer                   = "層級",
    LayerBackground         = "背景",
    LayerLow                = "低",
    LayerMedium             = "中",
    LayerHigh               = "高",
    LayerDialog             = "對話框",
    LayerFullscreen         = "全螢幕",
    ScreenColor             = "螢幕顏色",
    Vignette                = "漸暈",

    -- ========================================================================
    -- [[ INTERFACE — Positioning & Anchors ]] ---------------------------
    -- ========================================================================
    AnchorPoint             = "錨點",
    AnchorToText            = "依附於文字",
    OffsetX                 = "橫向偏移",
    OffsetY                 = "縱向偏移",
    AnchorTopLeft           = "左上",
    AnchorTop               = "頂部",
    AnchorTopRight          = "右上",
    AnchorLeft              = "左側",
    AnchorCenter            = "中心",
    AnchorRight             = "右側",
    AnchorBottomLeft        = "左下",
    AnchorBottom            = "底部",
    AnchorBottomRight       = "右下",

    -- ========================================================================
    -- [[ INTERFACE — Icons & Multimedia ]] ------------------------------
    -- ========================================================================
    IndicatorIcon           = "指示圖示",
    IconTexture             = "圖示材質",
    Sound                   = "音效",
    SoundKitId              = "SoundKit ID",
    TestSound               = "測試音效",

    -- ========================================================================
    -- [[ INTERFACE — Logic & Filters ]] ---------------------------------
    -- ========================================================================
    OnlyInInstances         = "僅在副本中",
    OnlyInCombat            = "僅在戰鬥中",
    DisableInDungeons       = "在地城中停用",
    DisableInRaids          = "在團隊副本中停用",
    InstanceFilters         = "副本過濾器",

    -- ========================================================================
    -- [[ INTERFACE — Message Customization ]] ---------------------------
    -- ========================================================================
    CustomText              = "自定義文字",
    Messages                = "訊息",

    -- ========================================================================
    -- [[ SHARED MODULES — Highlights ]] ---------------------------------
    -- ========================================================================
    Highlights              = "高亮設置",
    Highlight               = "高亮",
    HighlightGlobalDesc     = "|cffffa500在整個遊戲事件中動態配置角色高亮。|r",
    HighlightCombat         = "戰鬥中",
    HighlightCombatDesc     = "Highlight style when entering combat.",
    HighlightInstance       = "在副本中",
    HighlightInstanceDesc   = "Highlight style when inside a dungeon or raid.",
    HighlightHidden         = "處於隱藏狀態",
    HighlightHiddenDesc     = "Highlight style when in a custom stealth state.",
    HighlightStealth        = "In Stealth",
    HighlightStealthDesc    = "Highlight style when stealthed.",
    HighlightShroud         = "In Shroud of Concealment",
    HighlightShroudDesc     = "Highlight style when inside Shroud of Concealment.",
    HighlightCamouflage     = "In Camouflage",
    HighlightCamouflageDesc = "Highlight style when camouflaged.",
    HighlightProwl          = "In Prowl",
    HighlightProwlDesc      = "Highlight style when prowling.",
    HighlightOptNone        = "無",
    HighlightOptCircle      = "圓圈",
    HighlightOptOutline     = "輪廓",
    HighlightOptIcon        = "圖示",
    HighlightOptCircleOutline = "圓圈和輪廓",
    HighlightOptCircleIcon  = "圓圈和圖示",
    HighlightOptOutlineIcon = "輪廓和圖示",
    HighlightOptCircleOutlineIcon = "圓圈、輪廓和圖示",

    -- ========================================================================
    -- [[ SHARED MODULES — Stealth State ]] ------------------------------
    -- ========================================================================
    StealthStateName        = "隱藏狀態",
    StealthStateActiveText  = "隱藏狀態中",
    EnableOnStealthState    = "隱藏狀態時啟用",

    -- ========================================================================
    -- [[ SHARED MODULES — Macro System ]] -------------------------------
    -- ========================================================================
    MacroTargetHeader       = "目標",
    MacroTargetSelector     = "目標選擇器",
    MacroAutoUpdateWarning  = "|cffffa500Nightveil 會自動更新此巨集。|r",
    MacroDelveCompanion     = "探險坑夥伴",
    MacroCustomName         = "自定義目標",
    MacroCustomSet          = "自定義目標已設為: %s",
    MacroGroupMembers       = "小組內成員:",
    MacroInvalidIndex       = "無效的隊伍索引。",
    MacroNoSelf             = "你不能以自己為目標。",
    MacroBtnEnable          = "激活並同步巨集",
    MacroBtnDisable         = "停用並移除巨集",
    Mouseover               = "滑鼠指向",
    Focus                   = "專注目標",
    Tank                    = "坦克",
    TargetTarget            = "目標的目標",
    TargetingModeSet        = "目標設置模式設為: %s",
    Pet                     = "寵物",
    MuteChanges             = "Mute status changes",

    -- ========================================================================
    -- [[ CLASS MODULES — ROGUE ]] ---------------------------------------
    -- ========================================================================

    -- [[ Stealth ]] -------------------------------------------
    Stealth                 = "潛行",
    EnableOnStealth         = "潛行時啟用",
    StealthUseState         = "使用狀態檢測",
    StealthActiveText       = "已潛行",

    -- [[ Poison Tracker ]] ------------------------------------
    PoisonTracker           = "毒藥監控",
    LethalPoisons           = "致命毒藥",
    NonLethalPoisons        = "非致命毒藥",
    LethalPoisonMissing     = "缺失致命毒藥",
    NonLethalPoisonMissing  = "缺失非致命毒藥",

    -- [[ Tricks of the Trade ]] -------------------------------
    TricksOfTheTrade        = "嫁禍訣竅",
    TricksTargetLog         = "嫁禍目標",
    TricksNormal            = "普通",
    TricksCustom            = "自定義",
    TricksMsgEnabled        = "嫁禍系統已激活，巨集已同步。",
    TricksMsgDisabled       = "嫁禍系統已停用，巨集已移除。",
    TricksAlreadyEnabled    = "嫁禍訣竅系統已經啟用。",
    TricksAlreadyDisabled   = "嫁禍訣竅系統已經停用。",

    -- [[ Shroud of Concealment ]] -----------------------------
    ShroudOfConcealment     = "帷幕",
    EnableShroudCountdown   = "啟用聊天倒數",
    ShroudMuteErrors        = "靜音錯誤",
    ChatChannel             = "聊天頻道",
    ShroudMessage           = "倒數訊息",
    ShroudOnStart           = "開始訊息",
    ShroudOnEnd             = "結束訊息",
    ShroudInterval          = "間隔模式",
    TestShroud              = "測試帷幕",
    ShroudAlreadyActive     = "帷幕倒數已激活。",
    ShroudDisabled          = "設置中已停用帷幕倒數。",

    -- ========================================================================
    -- [[ CLASS MODULES — HUNTER ]] --------------------------------------
    -- ========================================================================

    -- [[ Camouflage ]] ----------------------------------------
    Camouflage              = "偽裝",
    EnableOnCamouflage      = "偽裝時啟用",
    CamouflageActiveText    = "偽裝中",

    -- [[ Misdirection ]] --------------------------------------
    Misdirection            = "誤導",
    MisdirTargetLog         = "誤導目標",
    MisdirectionNotLearned  = "您尚未學會誤導。",
    MisdirectionMsgEnabled  = "誤導系統已啟動並同步巨集。",
    MisdirectionMsgDisabled = "誤導系統已停用並移除了巨集。",
    MisdirectionAlreadyEnabled = "誤導系統已啟用。",
    MisdirectionAlreadyDisabled = "誤導系統已停用。",

    -- ========================================================================
    -- [[ CLASS MODULES — DRUID ]] ---------------------------------------
    -- ========================================================================

    -- [[ Prowl ]] ---------------------------------------------
    Prowl                   = "潛行",
    EnableOnProwl           = "潛行時啟用",
    ProwlActiveText         = "潛行中",

    -- ========================================================================
    -- [[ PROFILE MANAGEMENT ]] ------------------------------------------
    -- ========================================================================
    Profiles                = "配置文件",
    ActiveProfile           = "當前配置文件",
    ActiveProfileDesc       = "Select which profile to use for this character.",
    CreateProfile           = "創建配置文件",
    CreateProfileDesc       = "Create a new profile with default settings.",
    DuplicateProfile        = "複製配置文件",
    DuplicateProfileDesc    = "Create a copy of the current profile.",
    DeleteProfile           = "刪除配置文件",
    DeleteProfileDesc       = "Remove the selected profile (cannot delete Default).",
    ExportProfile           = "導出配置文件",
    ExportProfileDesc       = "Generate a string to share this profile with others.",
    ImportProfile           = "導入配置文件",
    ImportProfileDesc       = "Import a profile from a shared string.",
    DefaultProfileLabel     = "默認",
    CreateProfilePrompt     = "輸入新配置文件的名稱:",
    DuplicateProfilePrompt  = "輸入複製出的配置文件名稱:",
    ExportProfilePrompt     = "複製此導出字符串 (Ctrl+C):\n\n配置文件: |cff00ff00%s|r",
    ImportProfilePrompt     = "在下方粘貼配置文件的導出字符串:",
    ImportProfileNamePrompt = "輸入導入配置文件的名稱:",
    DeleteProfileConfirm    = "刪除配置文件:\n\n|cffff0000%s|r\n\n此操作不可撤銷。",
    FactoryResetBtn         = "恢復出厂設置",
    FactoryResetBtnDesc     = "Deletes all addon data and macros, restoring to a clean installation. UI will reload.",
    FactoryResetConfirm     = "|cffff0000警告:|r 這將刪除 |cffff0000所有|r Nightveil 設置和項目，並移除插件創建的巨集。\n\n此操作 |cffff0000不可逆|r。\n\n你確定要繼續嗎？",
    ErrorProfileDeleteRestricted = "你不能刪除默認配置文件。",
    Import                  = "導入",
    Share                   = "分享",
    Next                    = "Next",

    -- ========================================================================
    -- [[ CHAT CHANNELS ]] -----------------------------------------------
    -- ========================================================================
    ChannelSay              = "說",
    ChannelParty            = "小隊",
    ChannelRaid             = "團隊",
    ChannelInstance         = "副本",
    ChannelYell             = "大喊",

    -- ========================================================================
    -- [[ SYSTEM NOTIFICATIONS & ERRORS ]] -------------------------------
    -- ========================================================================
    ErrorHardReset          = "|cffff2020檢測到舊版本或不兼容版本。|r\n\n設置將被 |cffffcc00重置|r 以確保穩定性。",
    WarningOutdatedConfig   = "|cffffcc00檢測到較新的配置！|r\n\n建議 |cffbe89e9更新|r 插件或重置配置文件。",
    ErrorChannelNoValid     = "|cffff2020無可用的聊天頻道。|r",
    ErrorChannelAntiSpam    = "|cffff2020由於暴雪反垃圾郵件限制，無法在副本外使用頻道|r |cffffcc00%s|r|cffff2020。|r",
    ErrorChannelNoGroup     = "|cffff2020你不在隊伍中。頻道 |cffffcc00%s|r |cffff2020不可用。|r",
    ErrorChannelNoRaid      = "|cffff2020你不在團隊中。頻道 |cffffcc00%s|r |cffff2020不可用。|r",
    ErrorChannelInvalidGroup = "|cffff2020你獨自一人或處於無效隊伍中。頻道 |cffffcc00%s|r |cffff2020不可用。|r",
    ErrorChannelInstanceOnly = "|cffff2020Channel|r |cffffcc00%s|r |cffff2020unavailable outside instances.|r",
    ErrorNotRogue           = "你不是潜行者，此命令僅限潜行者使用。",
    ErrorNotHunter          = "You are not a Hunter. This command is Hunter-only.",
    ErrorTricksNotLearned   = "你尚未學會嫁禍訣竅。",
    ErrorMisdirNotLearned   = "You have not learned Misdirection yet.",
    ErrorShroudOnlyInstances = "|cffff2020帷幕訊息僅在副本內有效。",
    ErrorCombatBlocked      = "戰鬥中無法打開設置。",
    ErrorMacroLimitReached  = "巨集數量已達上限。",
    ErrorMacroCombatLock    = "This action cannot be used in combat.",
    ErrorUnknownCmd         = "未知命令: |cffffcc00%s|r。使用 |cffffcc00/veil help|r。",
    ErrorUnknownSubCmd      = "未知子命令: |cffffcc00%s|r。使用 |cffffcc00/veil help|r。",
    DebugCombatLock         = "This action cannot be used in combat.",

    -- ========================================================================
    -- [[ COMMANDS HELP ]] -----------------------------------------------
    -- ========================================================================
    HelpSettings            = "設置",
    HelpTricks              = "嫁禍目標",
    HelpMisdir              = "誤導目標",
    HelpMisdirPet           = "Pet mode",
    HelpInfo                = "診斷信息",
    HelpShroudTest          = "測試帷幕倒數",
    HelpDebugToggle         = "切換調試模式",
    HelpForceRefresh        = "強制刷新巨集",
    HelpModeNormal          = "普通模式",
    HelpModeTank            = "坦克模式",
    HelpModeTT              = "目標的目标模式",
    HelpModeCustom          = "自定義模式",
    HelpModeList            = "列出並按索引設置",
    HelpModeSet             = "按名稱設置",

    -- ========================================================================
    -- [[ DEBUG & DIAGNOSTICS ]] -----------------------------------------
    -- ========================================================================
    DebugModeActivated      = "調試模式已激活",
    DebugModeDeactivated    = "調試模式已停用",
    DebugModeRequired       = "此命令需要調試模式。輸入 |cffffcc00/veil debug|r 開啟。",
    DebugCommands           = "[調試命令]",
    DebugHeader             = "%s 診斷:",
    DebugCombat             = "- 戰鬥中: %s",
    DebugStealth            = "- 潛行/消失: %s",
    DebugInstance           = "- 副本: %s (類型: %s)",
    DebugGroup              = "- 隊伍: %s (團隊: %s, 共 %d 人)",
    DebugComposition        = "- 構成: %d 玩家, %d 寵物, %d 其他",
    DebugTricksKnown        = "- 已學嫁禍: %s",
    DebugTricksTarget       = "- 嫁禍目標: %s (%s)",
    DebugTricksMacro        = "- 嫁禍巨集: %s",
    DebugInvalidGroup       = "- 無效隊伍: %s",
    DebugPlayer             = "玩家",
    DebugPet                = "寵物",
    DebugOther              = "其他",
    DebugYes                = "是",
    DebugNo                 = "否",
    DebugNone               = "無",
    DebugUnknown            = "未知",
    DebugFallback1          = "- 備選 1: %s (可用: %s)",
    DebugFallback2          = "- 备选 2: %s (可用: %s)",
    DebugShroudUsage        = "用法: |cffffcc00/veil shroud [1-20]|r",
    DebugTricksForcing      = "強制更新嫁禍...",
    DebugMisdirForcing      = "Forcing Misdirection update...",
    DebugMacroSuccess       = "巨集刷新成功。",
    DebugMacroUpdated       = "巨集已更新: %s",
    DebugMacroStatus        = "巨集: %s",
    DebugMacroEdited        = "巨集內容已修改並同步。",

    -- ========================================================================
    -- [[ NPC / GAME TERMS ]] --------------------------------------------
    -- ========================================================================
    BrannBronzebeard        = "布蘭·銅鬚",
    ValeeraSanguinar        = "瓦莉拉·薩古納爾",

}
