local addonName, ns = ...
local locale = GetLocale()
if locale ~= "koKR" then return end

ns.L = {
    -- ========================================================================
    -- [[ SYSTEM / GENERAL UI ]] -----------------------------------------
    -- ========================================================================
    Enable                  = "활성화",
    Management              = "관리",
    ReleaseNotes            = "릴리스 노트",
    WelcomeMessage          = "%s |cffffcc00v%s|r 로드됨. 설정을 열려면 |cffffcc00/veil|r을 입력하세요.",
    UpdateMessage           = "%s가 |cffffcc00v%s|r로 업데이트되었습니다! 변경 사항을 확인하려면 |cffffcc00/veil|r을 입력하세요.",
    FloatingText            = "유동적 텍스트",

    -- ========================================================================
    -- [[ INTERFACE — Elements & Styles ]] -------------------------------
    -- ========================================================================
    Color                   = "색상",
    Size                    = "크기",
    Opacity                 = "불투명도",
    Thickness               = "두께",
    Style                   = "스타일",
    Layer                   = "레이어",
    LayerBackground         = "배경",
    LayerLow                = "낮음",
    LayerMedium             = "중간",
    LayerHigh               = "높음",
    LayerDialog             = "대화창",
    LayerFullscreen         = "전체 화면",
    ScreenColor             = "화면 색상",
    Vignette                = "비네트",

    -- ========================================================================
    -- [[ INTERFACE — Positioning & Anchors ]] ---------------------------
    -- ========================================================================
    AnchorPoint             = "고정 지점",
    AnchorToText            = "텍스트에 고정",
    OffsetX                 = "X 오프셋",
    OffsetY                 = "Y 오프셋",
    AnchorTopLeft           = "왼쪽 상단",
    AnchorTop               = "상단",
    AnchorTopRight          = "오른쪽 상단",
    AnchorLeft              = "왼쪽",
    AnchorCenter            = "중앙",
    AnchorRight             = "오른쪽",
    AnchorBottomLeft        = "왼쪽 하단",
    AnchorBottom            = "하단",
    AnchorBottomRight       = "오른쪽 하단",

    -- ========================================================================
    -- [[ INTERFACE — Icons & Multimedia ]] ------------------------------
    -- ========================================================================
    IndicatorIcon           = "지표 아이콘",
    IconTexture             = "아이콘 텍스처",
    Sound                   = "소리",
    SoundKitId              = "SoundKit ID",
    TestSound               = "소리 테스트",

    -- ========================================================================
    -- [[ INTERFACE — Logic & Filters ]] ---------------------------------
    -- ========================================================================
    OnlyInInstances         = "인스턴스 전용",
    OnlyInCombat            = "전투 시에만",
    DisableInDungeons       = "던전에서 비활성화",
    DisableInRaids          = "공격대에서 비활성화",
    InstanceFilters         = "인스턴스 필터",

    -- ========================================================================
    -- [[ INTERFACE — Message Customization ]] ---------------------------
    -- ========================================================================
    CustomText              = "사용자 정의 텍스트",
    Messages                = "메시지",

    -- ========================================================================
    -- [[ SHARED MODULES — Highlights ]] ---------------------------------
    -- ========================================================================
    Highlights              = "강조 설정",
    Highlight               = "강조",
    HighlightGlobalDesc     = "|cffffa500게임 플레이 이벤트 전반에 걸쳐 캐릭터 강조를 동적으로 설정합니다.|r",
    HighlightCombat         = "전투 중",
    HighlightCombatDesc     = "Highlight style when entering combat.",
    HighlightInstance       = "인스턴스 중",
    HighlightInstanceDesc   = "Highlight style when inside a dungeon or raid.",
    HighlightHidden         = "은신 상태 중",
    HighlightHiddenDesc     = "Highlight style when in a custom stealth state.",
    HighlightStealth        = "In Stealth",
    HighlightStealthDesc    = "Highlight style when stealthed.",
    HighlightShroud         = "In Shroud of Concealment",
    HighlightShroudDesc     = "Highlight style when inside Shroud of Concealment.",
    HighlightCamouflage     = "In Camouflage",
    HighlightCamouflageDesc = "Highlight style when camouflaged.",
    HighlightProwl          = "In Prowl",
    HighlightProwlDesc      = "Highlight style when prowling.",
    HighlightOptNone        = "없음",
    HighlightOptCircle      = "원",
    HighlightOptOutline     = "테두리",
    HighlightOptIcon        = "아이콘",
    HighlightOptCircleOutline = "원 및 테두리",
    HighlightOptCircleIcon  = "원 및 아이콘",
    HighlightOptOutlineIcon = "테두리 및 아이콘",
    HighlightOptCircleOutlineIcon = "원, 테두리 및 아이콘",

    -- ========================================================================
    -- [[ SHARED MODULES — Stealth State ]] ------------------------------
    -- ========================================================================
    StealthStateName        = "은신 상태",
    StealthStateActiveText  = "은신 상태",
    EnableOnStealthState    = "은신 상태 시 활성화",

    -- ========================================================================
    -- [[ SHARED MODULES — Macro System ]] -------------------------------
    -- ========================================================================
    MacroTargetHeader       = "대상",
    MacroTargetSelector     = "대상 선택기",
    MacroAutoUpdateWarning  = "|cffffa500Nightveil이 이 매크로를 자동으로 업데이트합니다.|r",
    MacroDelveCompanion     = "구렁 동료",
    MacroCustomName         = "사용자 정의 대상",
    MacroCustomSet          = "사용자 정의 대상 설정됨: %s",
    MacroGroupMembers       = "파티원:",
    MacroInvalidIndex       = "잘못된 파티 인덱스입니다.",
    MacroNoSelf             = "자신을 대상으로 지정할 수 없습니다.",
    MacroBtnEnable          = "매크로 활성화 및 동기화",
    MacroBtnDisable         = "매크로 비활성화 및 삭제",
    Mouseover               = "마우스오버",
    Focus                   = "주시 대상",
    Tank                    = "방어 담당",
    TargetTarget            = "대상의 대상",
    TargetingModeSet        = "대상 지정 모드 설정됨: %s",
    Pet                     = "소환수",
    MuteChanges             = "Mute status changes",

    -- ========================================================================
    -- [[ CLASS MODULES — ROGUE ]] ---------------------------------------
    -- ========================================================================

    -- [[ Stealth ]] -------------------------------------------
    Stealth                 = "은신",
    EnableOnStealth         = "은신 시 활성화",
    StealthUseState         = "상태 감지 사용",
    StealthActiveText       = "은신함",

    -- [[ Poison Tracker ]] ------------------------------------
    PoisonTracker           = "독 추적기",
    LethalPoisons           = "치명적인 독",
    NonLethalPoisons        = "비치명적인 독",
    LethalPoisonMissing     = "치명적인 독 없음",
    NonLethalPoisonMissing  = "비치명적인 독 없음",

    -- [[ Tricks of the Trade ]] -------------------------------
    TricksOfTheTrade        = "속임수 거래",
    TricksTargetLog         = "속임수 거래 대상",
    TricksNormal            = "일반",
    TricksCustom            = "사용자 정의",
    TricksMsgEnabled        = "속임수 거래 시스템 활성화 및 매크로 동기화 완료.",
    TricksMsgDisabled       = "속임수 거래 시스템 비활성화 및 매크로 삭제 완료.",
    TricksAlreadyEnabled    = "속임수 거래 시스템이 이미 활성화되어 있습니다.",
    TricksAlreadyDisabled   = "속임수 거래 시스템이 이미 비활성화되어 있습니다.",

    -- [[ Shroud of Concealment ]] -----------------------------
    ShroudOfConcealment     = "은폐의 장막",
    EnableShroudCountdown   = "대화창 카운트다운 활성화",
    ShroudMuteErrors        = "오류 숨기기",
    ChatChannel             = "대화 채널",
    ShroudMessage           = "카운트다운 메시지",
    ShroudOnStart           = "시작 메시지",
    ShroudOnEnd             = "종료 메시지",
    ShroudInterval          = "간격 모드",
    TestShroud              = "장막 테스트",
    ShroudAlreadyActive     = "장막 카운트다운이 이미 활성화되어 있습니다.",
    ShroudDisabled          = "설정에서 장막 카운트다운이 비활성화되어 있습니다.",

    -- ========================================================================
    -- [[ CLASS MODULES — HUNTER ]] --------------------------------------
    -- ========================================================================

    -- [[ Camouflage ]] ----------------------------------------
    Camouflage              = "위장",
    EnableOnCamouflage      = "위장 중 활성화",
    CamouflageActiveText    = "위장됨",

    -- [[ Misdirection ]] --------------------------------------
    Misdirection            = "눈속임",
    MisdirTargetLog         = "눈속임 대상",
    MisdirectionNotLearned  = "아직 눈속임을 배우지 않았습니다.",
    MisdirectionMsgEnabled  = "눈속임 시스템이 활성화되고 매크로가 동기화되었습니다.",
    MisdirectionMsgDisabled = "눈속임 시스템이 비활성화되고 매크로가 삭제되었습니다.",
    MisdirectionAlreadyEnabled = "눈속임 시스템이 이미 활성화되어 있습니다.",
    MisdirectionAlreadyDisabled = "눈속임 시스템이 이미 비활성화되어 있습니다.",

    -- ========================================================================
    -- [[ CLASS MODULES — DRUID ]] ---------------------------------------
    -- ========================================================================

    -- [[ Prowl ]] ---------------------------------------------
    Prowl                   = "숨기",
    EnableOnProwl           = "숨기 시 활성화",
    ProwlActiveText         = "숨음",

    -- ========================================================================
    -- [[ PROFILE MANAGEMENT ]] ------------------------------------------
    -- ========================================================================
    Profiles                = "프로필",
    ActiveProfile           = "활성 프로필",
    ActiveProfileDesc       = "Select which profile to use for this character.",
    CreateProfile           = "프로필 생성",
    CreateProfileDesc       = "Create a new profile with default settings.",
    DuplicateProfile        = "프로필 복사",
    DuplicateProfileDesc    = "Create a copy of the current profile.",
    DeleteProfile           = "프로필 삭제",
    DeleteProfileDesc       = "Remove the selected profile (cannot delete Default).",
    ExportProfile           = "프로필 내보내기",
    ExportProfileDesc       = "Generate a string to share this profile with others.",
    ImportProfile           = "프로필 가져오기",
    ImportProfileDesc       = "Import a profile from a shared string.",
    DefaultProfileLabel     = "기본값",
    CreateProfilePrompt     = "새 프로필 이름을 입력하세요:",
    DuplicateProfilePrompt  = "복사할 프로필 이름을 입력하세요:",
    ExportProfilePrompt     = "이 내보내기 문자열을 복사하세요 (Ctrl+C):\n\n프로필: |cff00ff00%s|r",
    ImportProfilePrompt     = "아래에 프로필 내보내기 문자열을 붙여넣으세요:",
    ImportProfileNamePrompt = "가져온 프로필의 이름을 입력하세요:",
    DeleteProfileConfirm    = "프로필 삭제:\n\n|cffff0000%s|r\n\n이 작업은 복구할 수 없습니다.",
    FactoryResetBtn         = "공장 초기화",
    FactoryResetBtnDesc     = "Deletes all addon data and macros, restoring to a clean installation. UI will reload.",
    FactoryResetConfirm     = "|cffff0000경고:|r 이 작업은 Nightveil의 |cffff0000모든|r 설정과 프로필을 삭제하며, 애드온으로 생성된 매크로도 제거합니다.\n\n이 작업은 |cffff0000복구할 수 없습니다|r.\n\n정말로 계속하시겠습니까?",
    ErrorProfileDeleteRestricted = "기본 프로필은 삭제할 수 없습니다.",
    Import                  = "가져오기",
    Share                   = "공유",
    Next                    = "Next",

    -- ========================================================================
    -- [[ CHAT CHANNELS ]] -----------------------------------------------
    -- ========================================================================
    ChannelSay              = "일반",
    ChannelParty            = "파티",
    ChannelRaid             = "공격대",
    ChannelInstance         = "인스턴스",
    ChannelYell             = "외치기",

    -- ========================================================================
    -- [[ SYSTEM NOTIFICATIONS & ERRORS ]] -------------------------------
    -- ========================================================================
    ErrorHardReset          = "|cffff2020오래되거나 호환되지 않는 버전이 감지되었습니다.|r\n\n안정성을 위해 설정이 |cffffcc00초기화|r됩니다.",
    WarningOutdatedConfig   = "|cffffcc00최신 설정이 감지되었습니다!|r\n\n애드온을 |cffbe89e9업데이트|r하거나 프로필을 초기화하는 것을 권장합니다.",
    ErrorChannelNoValid     = "|cffff2020유효한 대화 채널이 없습니다.|r",
    ErrorChannelAntiSpam    = "|cffff2020Blizzard 안티 스팸 제한으로 인해 인스턴스 밖에서 |cffffcc00%s|r 채널을 사용할 수 없습니다.|r",
    ErrorChannelNoGroup     = "|cffff2020파티에 속해 있지 않습니다. |cffffcc00%s|r 채널을 사용할 수 없습니다.|r",
    ErrorChannelNoRaid      = "|cffff2020공격대에 속해 있지 않습니다. |cffffcc00%s|r 채널을 사용할 수 없습니다.|r",
    ErrorChannelInvalidGroup = "|cffff2020혼자 있거나 유효하지 않은 그룹입니다. |cffffcc00%s|r 채널을 사용할 수 없습니다.|r",
    ErrorChannelInstanceOnly = "|cffff2020Channel|r |cffffcc00%s|r |cffff2020unavailable outside instances.|r",
    ErrorNotRogue           = "도적 클래스가 아닙니다. 이 명령은 도적 전용입니다.",
    ErrorNotHunter          = "You are not a Hunter. This command is Hunter-only.",
    ErrorTricksNotLearned   = "아직 속임수 거래를 배우지 않았습니다.",
    ErrorMisdirNotLearned   = "You have not learned Misdirection yet.",
    ErrorShroudOnlyInstances = "|cffff2020장막 메시지는 인스턴스 내에서만 작동합니다.|r",
    ErrorCombatBlocked      = "전투 중에는 설정을 열 수 없습니다.",
    ErrorMacroLimitReached  = "매크로 제한에 도달했습니다.",
    ErrorMacroCombatLock    = "This action cannot be used in combat.",
    ErrorUnknownCmd         = "알 수 없는 명령: |cffffcc00%s|r. |cffffcc00/veil help|r를 사용하세요.",
    ErrorUnknownSubCmd      = "알 수 없는 하위 명령: |cffffcc00%s|r. |cffffcc00/veil help|r를 사용하세요.",
    DebugCombatLock         = "This action cannot be used in combat.",

    -- ========================================================================
    -- [[ COMMANDS HELP ]] -----------------------------------------------
    -- ========================================================================
    HelpSettings            = "설정",
    HelpTricks              = "속임수 거래 대상",
    HelpMisdir              = "눈속임 대상",
    HelpMisdirPet           = "Pet mode",
    HelpInfo                = "진단 정보",
    HelpShroudTest          = "장막 카운트다운 테스트",
    HelpDebugToggle         = "디버그 모드 전환",
    HelpForceRefresh        = "매크로 강제 새로고침",
    HelpModeNormal          = "일반 모드",
    HelpModeTank            = "방어 모드",
    HelpModeTT              = "대상의 대상 모드",
    HelpModeCustom          = "사용자 정의 모드",
    HelpModeList            = "목록 표시 및 인덱스로 설정",
    HelpModeSet             = "이름으로 설정",

    -- ========================================================================
    -- [[ DEBUG & DIAGNOSTICS ]] -----------------------------------------
    -- ========================================================================
    DebugModeActivated      = "디버그 모드 활성화됨",
    DebugModeDeactivated    = "디버그 모드 비활성화됨",
    DebugModeRequired       = "이 명령은 디버그 모드가 필요합니다. 활성화하려면 |cffffcc00/veil debug|r를 입력하세요.",
    DebugCommands           = "[디버그 명령]",
    DebugHeader             = "%s 진단 도구:",
    DebugCombat             = "- 전투: %s",
    DebugStealth            = "- 은신/소멸: %s",
    DebugInstance           = "- 인스턴스: %s (유형: %s)",
    DebugGroup              = "- 그룹: %s (공격대: %s, 총원: %d)",
    DebugComposition        = "- 구성: 플레이어 %d명, 소환수 %d마리, 기타 %d분",
    DebugTricksKnown        = "- 속임수 거래 습득 유무: %s",
    DebugTricksTarget       = "- 속임수 거래 대상: %s (%s)",
    DebugTricksMacro        = "- 속임수 거래 매크로: %s",
    DebugInvalidGroup       = "- 유효하지 않은 그룹: %s",
    DebugPlayer             = "플레이어",
    DebugPet                = "소환수",
    DebugOther              = "기타",
    DebugYes                = "네",
    DebugNo                 = "아니요",
    DebugNone               = "없음",
    DebugUnknown            = "알 수 없음",
    DebugFallback1          = "- 대체 대상 1: %s (사용 가능: %s)",
    DebugFallback2          = "- 대체 대상 2: %s (사용 가능: %s)",
    DebugShroudUsage        = "사용법: |cffffcc00/veil shroud [1-20]|r",
    DebugTricksForcing      = "속임수 거래 업데이트 강제 중...",
    DebugMisdirForcing      = "Forcing Misdirection update...",
    DebugMacroSuccess       = "매크로 새로고침 성공.",
    DebugMacroUpdated       = "매크로 업데이트됨: %s",
    DebugMacroStatus        = "매크로: %s",
    DebugMacroEdited        = "매크로 내용이 수정 및 동기화되었습니다.",

    -- ========================================================================
    -- [[ NPC / GAME TERMS ]] --------------------------------------------
    -- ========================================================================
    BrannBronzebeard        = "브란 브론즈비어드",
    ValeeraSanguinar        = "발리라 생귀나르",

}
