local addonName, ns = ...
local locale = GetLocale()
if locale ~= "zhTW" then return end

ns.L = {
    -- ========================================================================
    -- [[ SYSTEM / GENERAL UI ]] ----------------------------------------------
    -- ========================================================================
    Enable              = "啟用",
    EnableDesc          = "啟用或停用此功能。",
    Management          = "管理",
    ReleaseNotes        = "版本更新說明",

    -- ========================================================================
    -- [[ INTERFACE — Elements & Styles ]] ------------------------------------
    -- ========================================================================
    Color               = "顏色",
    ColorDesc           = "設置此元素使用的顏色。",
    Size                = "尺寸",
    SizeDesc            = "更改元素的尺寸。",
    Opacity             = "透明度",
    OpacityDesc         = "更改透明度。",
    Layer               = "層級",
    LayerDesc           = "繪製層級 (較高者顯示在上方)。",
    LayerBackground     = "背景",
    LayerLow            = "低",
    LayerMedium         = "中",
    LayerHigh           = "高",
    LayerDialog         = "對話框",
    LayerFullscreen     = "全螢幕",
    Style               = "樣式",
    StyleDesc           = "選擇高亮樣式。",

    -- ========================================================================
    -- [[ INTERFACE — Positioning & Anchors ]] --------------------------------
    -- ========================================================================
    OffsetX             = "橫向偏移",
    OffsetXDesc         = "水平移動元素。",
    OffsetY             = "縱向偏移",
    OffsetYDesc         = "垂直移動元素。",
    AnchorToText        = "依附於文字",
    AnchorToTextDesc    = "將圖示依附到文字位置。",
    AnchorPoint         = "錨點",
    AnchorPointDesc     = "用作錨點 apex 的文字側邊。",
    AnchorTopLeft       = "左上",
    AnchorTop           = "頂部",
    AnchorTopRight      = "右上",
    AnchorLeft          = "左側",
    AnchorCenter        = "中心",
    AnchorRight         = "右側",
    AnchorBottomLeft    = "左下",
    AnchorBottom        = "底部",
    AnchorBottomRight   = "右下",

    -- ========================================================================
    -- [[ INTERFACE — Icons & Multimedia ]] -----------------------------------
    -- ========================================================================
    IndicatorIcon       = "指示圖示",
    EnableIconDesc      = "顯示圖示指示器。",
    IconTexture         = "圖示材質",
    IconTextureDesc     = "自定義圖示材質路徑。",
    Sound               = "音效",
    SoundDesc           = "激活時播放聲音警報。",
    SoundKitId          = "SoundKit ID",
    SoundKitIdDesc      = "播放的 SoundKit ID (數字)。",
    TestSound           = "測試音效",
    TestSoundDesc       = "立即播放選定的音效。",

    -- ========================================================================
    -- [[ INTERFACE — Message Customization ]] --------------------------------
    -- ========================================================================
    CustomText          = "自定義文字",
    CustomTextDesc      = "要顯示的自定義消息文字。",
    FloatingText        = "浮動文字",
    Messages            = "訊息",

    -- ========================================================================
    -- [[ INTERFACE — Logic Filters ]] ----------------------------------------
    -- ========================================================================
    OnlyInInstances     = "僅在副本中",
    OnlyInInstancesDesc = "僅在副本(地城、團隊副本、情境戰役)中生效。",
    OnlyInCombat        = "僅在戰鬥中",
    OnlyInCombatDesc    = "僅在戰鬥時顯示警告。",
    DisableInDungeons   = "在地城中停用",
    DisableInDungeonsDesc = "處於地城副本時失效。",
    DisableInRaids      = "在團隊副本中停用",
    DisableInRaidsDesc  = "處於團隊副本時失效。",
    InstanceFilters     = "副本過濾器",
    InstanceFiltersDesc = "配置應停用此功能的場景。",

    -- ========================================================================
    -- [[ HIGHLIGHTS SYSTEM ]] ------------------------------------------------
    -- ========================================================================
    Highlight              = "高亮",
    HighlightDesc          = "在螢幕上高亮顯示你的角色。",
    Highlights             = "高亮設置",
    HighlightGlobalDesc    = "|cffffa500在整個遊戲事件中動態配置角色高亮。|r",
    HighlightOptNone              = "無",
    HighlightOptCircle            = "圓圈",
    HighlightOptOutline           = "輪廓",
    HighlightOptIcon              = "圖示",
    HighlightOptCircleOutline     = "圓圈和輪廓",
    HighlightOptCircleIcon        = "圓圈和圖示",
    HighlightOptOutlineIcon       = "輪廓和圖示",
    HighlightOptCircleOutlineIcon = "圓圈、輪廓和圖示",
    HighlightCombat     = "戰鬥中",
    HighlightCombatDesc = "在活動戰鬥中使用的高亮設置。",
    HighlightInstance   = "在副本中",
    HighlightInstanceDesc = "在地城、團隊副本或情境戰役中使用的高亮設置。",
    HighlightHidden     = "處於隱藏狀態",
    HighlightHiddenDesc = "當你處於潛行狀態時使用的高亮設置。",
    ScreenColor         = "螢幕顏色",
    ScreenColorDesc     = "激活時為螢幕邊緣染色。",
    Vignette            = "漸暈",
    VignetteDesc        = "在螢幕周圍添加漸暈效果。",
    Thickness           = "厚度",
    ThicknessDesc       = "控制漸暈厚度。",

    -- ========================================================================
    -- [[ SHARED MODULES ]] ---------------------------------------------------
    -- ========================================================================
    -- [[ Stealth State Module ]] ---------------------------------------------
    StealthStateName        = "隱藏狀態",
    StealthStateDesc        = "配置處於隱藏狀態時的視覺效果。",
    StealthStateActiveText  = "隱藏狀態中",
    EnableOnStealthState    = "隱藏狀態時啟用",
    EnableOnStealthStateDesc = "在任何潛行狀態激活時顯示視覺效果 (使用 WoW 狀態檢測)。",

    -- ========================================================================
    -- [[ CLASS MODULES — ROGUE ]] --------------------------------------------
    -- ========================================================================
    -- [[ Stealth Module ]] ---------------------------------------------------
    Stealth             = "潛行",
    EnableOnStealth     = "潛行時啟用",
    EnableOnStealthDesc = "在潛行或消失激活時顯示視覺效果。",
    StealthUseState     = "使用狀態檢測",
    StealthUseStateDesc = "使用全局潛行狀態而非特定光環。“光環”對比職業技能更精確，而“狀態”則在任何潛行效果下激活。",
    DefaultMessage      = "潛行中",
    StealthActiveText   = "已潛行",

    -- [[ Poison Tracker ]] ---------------------------------------------------
    PoisonTracker          = "毒藥監控",
    LethalPoisons          = "致命毒藥",
    LethalPoisonsDesc      = "當缺失致命毒藥時顯示警告。",
    NonLethalPoisons       = "非致命毒藥",
    NonLethalPoisonsDesc   = "當缺失非致命毒藥時顯示警告。",
    LethalPoisonMissing    = "缺失致命毒藥",
    NonLethalPoisonMissing = "缺失非致命毒藥",
    -- ========================================================================
    -- [[ MACRO SYSTEM (SHARED) ]] --------------------------------------------
    -- ========================================================================


    -- [[ Tricks of the Trade ]] ----------------------------------------------
    TricksOfTheTrade         = "嫁禍訣竅",
    MacroTargetHeader =  "目標",
    MacroTargetSelector =  "目標選擇器",
    MacroTargetSelectorDesc =  "定義自動目標選擇的主要邏輯。",
    MacroAutoUpdateWarning =  "|cffffa500Nightveil 會自動更新此巨集。|r",
    TricksEnabledDesc        = "使用巨集為嫁禍訣竅啟用自動對齊目標。",
    MacroMouseoverDesc =  "啟用滑鼠指向目標設置。\n\n注意：除探險坑夥伴外，此設置優先級最高。",
    MacroFocusDesc =  "啟用通過專注目標自動設置目標。\n\n注意：此設置優先級高於目標選擇器，但會被滑鼠指向或探險坑夥伴忽略。",
    MacroMuteDesc =  "當巨集更換目標時隱藏聊天通知。",
    MacroDelveCompanion =  "探險坑夥伴",
    MacroDelveCompanionDesc =  "在探險坑內自動將目標設為布蘭·銅鬚或瓦莉拉·薩古納爾。\n\n注意：在探險坑內擁有最高優先級。",
    TricksTargetLog          = "嫁禍目標",
    TricksNormal             = "普通",
    TricksCustom             = "自定義",
    MacroCustomName =  "自定義目標",
    MacroCustomNameDesc =  "輸入要設為目標的玩家確切名稱。",
    MacroCustomSet =  "自定義目標已設為: %s",
    MacroGroupMembers =  "小組內成員:",
    MacroInvalidIndex =  "無效的隊伍索引。",
    MacroNoSelf =  "你不能以自己為目標。",
    MacroBtnEnable =  "激活並同步巨集",
    MacroBtnDisable =  "停用並移除巨集",
    MacroBtnDisableDesc =  "停用自動化目標設置並完全移除巨集。",
    TricksMsgEnabled         = "嫁禍系統已激活，巨集已同步。",
    TricksMsgDisabled        = "嫁禍系統已停用，巨集已移除。",
    TricksAlreadyEnabled     = "嫁禍訣竅系統已經啟用。",
    TricksAlreadyDisabled    = "嫁禍訣竅系統已經停用。",
    TricksLogicSet           = "目標設置模式設為: %s",
    Mouseover                = "滑鼠指向",
    Focus                    = "專注目標",
    Tank                     = "坦克",
    TargetTarget             = "目標的目標",

    -- [[ Shroud of Concealment ]] --------------------------------------------
    ShroudOfConcealment      = "帷幕",
    EnableShroudCountdown    = "啟用聊天倒數",
    EnableShroudCountdownDesc = "向聊天頻道發送帷幕倒數訊息。",
    ShroudOnlyInstancesDesc  = "僅在副本內發送帷幕訊息。\n\n注意：由於暴雪反垃圾郵件限制，某些頻道在副本外被封鎖。",
    ShroudMuteErrors         = "靜音錯誤",
    ShroudMuteErrorsDesc     = "停用聊天中的帷幕錯誤訊息。",
    ChatChannel              = "聊天頻道",
    ChatChannelDesc          = "用於帷幕訊息的首選聊天頻道。",
    ChatChannelFallbackDesc  = "如果首選頻道不可用，則使用的備用頻道。",
    ShroudMessage            = "倒數訊息",
    ShroudMessageDesc        = "倒數期間使用的訊息模板。\n\n%time = 剩餘時間。",
    ShroudOnStart            = "開始訊息",
    ShroudOnStartDesc        = "帷幕開始時發送的訊息。",
    ShroudOnEnd              = "結束訊息",
    ShroudOnEndDesc          = "帷幕結束(0s)時發送的訊息。",
    ShroudInterval           = "間隔模式",
    ShroudIntervalDesc       = "開始、中間和最後5秒",
    TimeRemainingHint        = "%time = 剩餘時間",
    TestShroud               = "測試帷幕",
    TestShroudDesc           = "模擬本地 5 秒倒數。\n\n注意：訊息僅對你可見。",
    ShroudAlreadyActive      = "帷幕倒數已激活。",
    ShroudDisabled           = "設置中已停用帷幕倒數。",
    ChannelSay               = "說",
    ChannelParty             = "小隊",
    ChannelRaid              = "團隊",
    ChannelInstance          = "副本",
    ChannelYell              = "大喊",

    -- ========================================================================
    
    -- ========================================================================
    -- [[ CLASS MODULES — HUNTER ]] --------------------------------------------
    -- ========================================================================
    -- [[ Camouflage Module ]] -------------------------------------------------
    Camouflage              = "偽裝",
    EnableOnCamouflage      = "偽裝時啟用",
    EnableOnCamouflageDesc  = "當偽裝處於啟動狀態時顯示主要介面提示。",
    CamouflageActiveText    = "偽裝中",

    -- [[ Misdirection ]] ------------------------------------------------------
    Misdirection                = "誤導",
    MisdirEnabledDesc           = "透過巨集啟用「誤導」的自動目標拾取。",
    MisdirTargetLog             = "誤導目標",
    MisdirectionNotLearned      = "您尚未學會誤導。",
    MisdirectionMsgEnabled      = "誤導系統已啟動並同步巨集。",
    MisdirectionMsgDisabled     = "誤導系統已停用並移除了巨集。",
    MisdirectionAlreadyEnabled  = "誤導系統已啟用。",
    MisdirectionAlreadyDisabled = "誤導系統已停用。",
    MisdirLogicSet              = "設定目標模式：%s",
    MisdirNotLearned            = "您尚未學會誤導。",
    Pet                         = "寵物",

    -- [[ PROFILE MANAGEMENT ]] -----------------------------------------------
    -- ========================================================================
    Profiles              = "配置文件",
    ActiveProfile         = "當前配置文件",
    ActiveProfileDesc     = "選擇當前激活的配置文件。",
    CreateProfile         = "創建配置文件",
    CreateProfileDesc     = "使用默認設置創建新的配置文件。",
    DuplicateProfile      = "複製配置文件",
    DuplicateProfileDesc  = "將當前配置文件複製到新配置文件中。",
    DeleteProfile         = "刪除配置文件",
    DeleteProfileDesc     = "刪除選定的配置文件 (不可撤銷)。",
    ExportProfile         = "導出配置文件",
    ExportProfileDesc     = "生成用於共享此配置文件的字符串。",
    ImportProfile         = "導入配置文件",
    ImportProfileDesc     = "從導出的字符串導入配置文件。",
    CreateProfilePrompt   = "輸入新配置文件的名稱:",
    DuplicateProfilePrompt = "輸入複製出的配置文件名稱:",
    FactoryResetBtn       = "恢復出厂設置",
    FactoryResetBtnDesc   = "刪除所有插件數據和巨集，恢復到全新安裝狀態。介面將重新加載。",
    FactoryResetConfirm   = "|cffff0000警告:|r 這將刪除 |cffff0000所有|r Nightveil 設置和項目，並移除插件創建的巨集。\n\n此操作 |cffff0000不可逆|r。\n\n你確定要繼續嗎？",
    DeleteProfileConfirm  = "刪除配置文件:\n\n|cffff0000%s|r\n\n此操作不可撤銷。",
    ExportProfilePrompt   = "複製此導出字符串 (Ctrl+C):\n\n配置文件: |cff00ff00%s|r",
    ImportProfilePrompt   = "在下方粘貼配置文件的導出字符串:",
    ImportProfileNamePrompt = "輸入導入配置文件的名稱:",
    ErrorDeleteRestricted = "你不能刪除默認配置文件。",
    DefaultProfileLabel   = "默認",
    Import                = "導入",
    Share                 = "分享",

    -- ========================================================================
    -- [[ SYSTEM MESSAGES & WARNINGS ]] ---------------------------------------
    -- ========================================================================
    WarningNotRogue         = "你不是潜行者，此命令僅限潜行者使用。",
    TricksNotLearned        = "你尚未學會嫁禍訣竅。",
    HardResetWarning        = "檢測到舊版或不兼容的版本。\n\n設置將被重置以確保穩定性。",
    WarningOutdatedConfig   = "檢測到更新的配置！\n\n你正在使用的配置文件是在較新版本的 Nightveil 中創建的。",
    WelcomeMessage          = "%s |cffffd100v%s|r 已加載。輸入 |cffffd100/veil|r 打開設置。",
    UpdateMessage           = "%s 已更新至 |cffffd100v%s|r! 輸入 |cffffd100/veil|r 查看更新內容。",
    ErrorNoValidChannel     = "|cffff2020無可用的聊天頻道。|r",
    ErrorBlizzardAntiSpam   = "|cffff2020由於暴雪反垃圾郵件限制，無法在副本外使用頻道|r |cffffcc00%s|r|cffff2020。|r",
    ErrorNotInGroup         = "|cffff2020你不在隊伍中。頻道 |cffffcc00%s|r |cffff2020不可用。|r",
    ErrorNotInRaid          = "|cffff2020你不在團隊中。頻道 |cffffcc00%s|r |cffff2020不可用。|r",
    ErrorFollowersDungeonGroup = "|cffff2020你獨自一人或處於無效隊伍中。頻道 |cffffcc00%s|r |cffff2020不可用。|r",
    ErrorShroudOnlyInstances = "|cffff2020帷幕訊息僅在副本內有效。",
    ErrorShroudInstanceOnly  = "|cffff2020你不在副本中。頻道 |cffffcc00%s|r |cffff2020不可用。|r",
    CombatBlocked         = "戰鬥中無法打開設置。",
    MacroLimitReached     = "巨集數量已達上限。",
    MuteChanges           = "靜音更改",
    Next                  = "下一頁",

    -- ========================================================================
    -- [[ COMMANDS HELP ]] ----------------------------------------------------
    -- ========================================================================
    HelpSettings          = "設置",
    HelpTricks            = "嫁禍目標",
    HelpUTricks           = "強制刷新巨集",
    HelpMisdir            = "誤導目標",
    HelpUMisdir           = "強制刷新巨集",
    HelpMisdirPet         = "寵物模式",
    HelpMisdirNormal      = "正常模式",
    HelpMisdirTank        = "坦克模式",
    HelpMisdirTT          = "目標的目標模式",
    HelpMisdirCustom      = "自訂模式",
    HelpMisdirList        = "發送隊伍列表",
    HelpMisdirSet         = "設定自訂目標",
    HelpInfo              = "診斷信息",
    HelpShroudTest        = "測試帷幕倒數",
    HelpDebugToggle       = "切換調試模式",
    HelpTricksList        = "列出並按索引設置",
    HelpTricksNormal      = "普通模式",
    HelpTricksTank        = "坦克模式",
    HelpTricksTT          = "目標的目标模式",
    HelpTricksSet         = "按名稱設置",
    HelpTricksCustom      = "自定義模式",
    ErrorUnknownCmd       = "未知命令: |cffffd100%s|r。使用 |cffffd100/veil help|r。",
    ErrorUnknownSubCmd    = "未知子命令: |cffffd100%s|r。使用 |cffffd100/veil help|r。",

    -- ========================================================================
    -- [[ DEBUG INFO ]] -------------------------------------------------------
    -- ========================================================================
    DebugModeActivated   = "調試模式已激活",
    DebugModeDeactivated = "調試模式已停用",
    DebugModeRequired    = "此命令需要調試模式。輸入 |cffffd100/veil debug|r 開啟。",
    DebugCommands        = "[調試命令]",
    DebugHeader          = "%s 診斷:",
    DebugCombat          = " - 戰鬥中: %s",
    DebugStealth         = " - 潛行/消失: %s",
    DebugInstance        = " - 副本: %s (類型: %s)",
    DebugGroup           = " - 隊伍: %s (團隊: %s, 共 %d 人)",
    DebugComposition     = " - 構成: %d 玩家, %d 寵物, %d 其他",
    DebugTricksKnown     = " - 已學嫁禍: %s",
    DebugTricksTarget    = " - 嫁禍目標: %s (%s)",
    DebugTricksMacro     = " - 嫁禍巨集: %s",
    DebugInvalidGroup    = " - 無效隊伍: %s",
    DebugPlayer          = "玩家",
    DebugPet             = "寵物",
    DebugOther           = "其他",
    DebugYes             = "是",
    DebugNo              = "否",
    DebugNone            = "無",
    DebugUnknown         = "未知",
    DebugFallback1       = " - 備選 1: %s (可用: %s)",
    DebugFallback2       = " - 备选 2: %s (可用: %s)",
    DebugShroudUsage     = "用法: |cffffd100/veil shroud [1-20]|r",
    DebugTricksForcing   = "強制更新嫁禍...",
    DebugTricksSuccess   = "巨集刷新成功。",
    DebugMacroUpdated    = "巨集已更新: %s",
    DebugMacroStatus     = "巨集: %s",
    DebugMacroEdited     = "巨集內容已修改並同步。",
    DebugCombatLock      = "戰鬥中無法執行此操作。",

    -- ========================================================================
    -- [[ NPC / GAME TERMS ]] -------------------------------------------------
    -- ========================================================================
    BrannBronzebeard = "布蘭·銅鬚",
    ValeeraSanguinar = "瓦莉拉·薩古納爾",
}
