local addonName, ns = ...
local locale = GetLocale()
if locale ~= "koKR" then return end

ns.L = {
    -- ========================================================================
    -- [[ SYSTEM / GENERAL UI ]] ----------------------------------------------
    -- ========================================================================
    Enable              = "활성화",
    EnableDesc          = "이 기능을 켜거나 끕니다.",
    Management          = "관리",
    ReleaseNotes        = "릴리스 노트",

    -- ========================================================================
    -- [[ INTERFACE — Elements & Styles ]] ------------------------------------
    -- ========================================================================
    Color               = "색상",
    ColorDesc           = "이 요소에 사용되는 색상을 설정합니다.",
    Size                = "크기",
    SizeDesc            = "요소의 크기를 변경합니다.",
    Opacity             = "불투명도",
    OpacityDesc         = "투명도를 변경합니다.",
    Layer               = "레이어",
    LayerDesc           = "그리기 레이어 (높을수록 위에 표시됨).",
    LayerBackground     = "배경",
    LayerLow            = "낮음",
    LayerMedium         = "중간",
    LayerHigh           = "높음",
    LayerDialog         = "대화창",
    LayerFullscreen     = "전체 화면",
    Style               = "스타일",
    StyleDesc           = "강조 스타일을 선택합니다.",

    -- ========================================================================
    -- [[ INTERFACE — Positioning & Anchors ]] --------------------------------
    -- ========================================================================
    OffsetX             = "X 오프셋",
    OffsetXDesc         = "요소를 가로로 이동합니다.",
    OffsetY             = "Y 오프셋",
    OffsetYDesc         = "요소를 세로로 이동합니다.",
    AnchorToText        = "텍스트에 고정",
    AnchorToTextDesc    = "아이콘을 텍스트 위치에 고정합니다.",
    AnchorPoint         = "고정 지점",
    AnchorPointDesc     = "고정점으로 사용되는 텍스트의 측면입니다.",
    AnchorTopLeft       = "왼쪽 상단",
    AnchorTop           = "상단",
    AnchorTopRight      = "오른쪽 상단",
    AnchorLeft          = "왼쪽",
    AnchorCenter        = "중앙",
    AnchorRight         = "오른쪽",
    AnchorBottomLeft    = "왼쪽 하단",
    AnchorBottom        = "하단",
    AnchorBottomRight   = "오른쪽 하단",

    -- ========================================================================
    -- [[ INTERFACE — Icons & Multimedia ]] -----------------------------------
    -- ========================================================================
    IndicatorIcon       = "지표 아이콘",
    EnableIconDesc      = "아이콘 지표를 표시합니다.",
    IconTexture         = "아이콘 텍스처",
    IconTextureDesc     = "사용자 정의 아이콘 텍스처 경로입니다.",
    Sound               = "소리",
    SoundDesc           = "활성화될 때 소리 알림을 재생합니다.",
    SoundKitId          = "SoundKit ID",
    SoundKitIdDesc      = "재생할 SoundKit ID (숫자).",
    TestSound           = "소리 테스트",
    TestSoundDesc       = "선택한 소리를 지금 재생합니다.",

    -- ========================================================================
    -- [[ INTERFACE — Message Customization ]] --------------------------------
    -- ========================================================================
    CustomText          = "사용자 정의 텍스트",
    CustomTextDesc      = "표시할 사용자 정의 메시지 텍스트입니다.",
    FloatingText        = "유동적 텍스트",
    Messages            = "메시지",

    -- ========================================================================
    -- [[ INTERFACE — Logic Filters ]] ----------------------------------------
    -- ========================================================================
    OnlyInInstances     = "인스턴스 전용",
    OnlyInInstancesDesc = "인스턴스(던전, 공격대, 시나리오) 내에서만 적용됩니다.",
    OnlyInCombat        = "전투 시에만",
    OnlyInCombatDesc    = "전투 중일 때만 경고를 표시합니다.",
    DisableInDungeons   = "던전에서 비활성화",
    DisableInDungeonsDesc = "던전 인스턴스 내에서는 적용되지 않습니다.",
    DisableInRaids      = "공격대에서 비활성화",
    DisableInRaidsDesc  = "공격대 인스턴스 내에서는 적용되지 않습니다.",
    InstanceFilters     = "인스턴스 필터",
    InstanceFiltersDesc = "이 기능을 비활성화할 장소를 설정합니다.",

    -- ========================================================================
    -- [[ HIGHLIGHTS SYSTEM ]] ------------------------------------------------
    -- ========================================================================
    Highlight              = "강조",
    HighlightDesc          = "화면에서 캐릭터를 강조합니다.",
    Highlights             = "강조 설정",
    HighlightGlobalDesc    = "|cffffa500게임 플레이 이벤트 전반에 걸쳐 캐릭터 강조를 동적으로 설정합니다.|r",
    HighlightOptNone              = "없음",
    HighlightOptCircle            = "원",
    HighlightOptOutline           = "테두리",
    HighlightOptIcon              = "아이콘",
    HighlightOptCircleOutline     = "원 및 테두리",
    HighlightOptCircleIcon        = "원 및 아이콘",
    HighlightOptOutlineIcon       = "테두리 및 아이콘",
    HighlightOptCircleOutlineIcon = "원, 테두리 및 아이콘",
    HighlightCombat     = "전투 중",
    HighlightCombatDesc = "전투 중일 때 사용되는 강조 설정입니다.",
    HighlightInstance   = "인스턴스 중",
    HighlightInstanceDesc = "던전, 공격대, 또는 시나리오 내에서 사용되는 강조 설정입니다.",
    HighlightHidden     = "은신 상태 중",
    HighlightHiddenDesc = "은신 상태일 때 사용되는 강조 설정입니다.",
    ScreenColor         = "화면 색상",
    ScreenColorDesc     = "활성화된 동안 화면에 색을 입힙니다.",
    Vignette            = "비네트",
    VignetteDesc        = "화면 가장자리에 비네트 효과를 추가합니다.",
    Thickness           = "두께",
    ThicknessDesc       = "비네트의 두께를 조절합니다.",

    -- ========================================================================
    -- [[ SHARED MODULES ]] ---------------------------------------------------
    -- ========================================================================
    -- [[ Stealth State Module ]] ---------------------------------------------
    StealthStateName        = "은신 상태",
    StealthStateDesc        = "은신 상태일 때의 시각 효과를 설정합니다.",
    StealthStateActiveText  = "은신 상태",
    EnableOnStealthState    = "은신 상태 시 활성화",
    EnableOnStealthStateDesc = "은신 상태가 활성화된 동안 시각 효과를 표시합니다(WoW 상태 감지 사용).",

    -- ========================================================================
    -- [[ CLASS MODULES — ROGUE ]] --------------------------------------------
    -- ========================================================================
    -- [[ Stealth Module ]] ---------------------------------------------------
    Stealth             = "은신",
    EnableOnStealth     = "은신 시 활성화",
    EnableOnStealthDesc = "은신 또는 소멸이 활성화된 동안 시각 효과를 표시합니다.",
    StealthUseState     = "상태 감지 사용",
    StealthUseStateDesc = "특정 오라 대신 전체 은신 상태를 사용합니다. '오라'는 클래스 기술에 더 정확하며, '상태'는 모든 은신 효과에서 활성화됩니다.",
    DefaultMessage      = "은신 중",
    StealthActiveText   = "은신함",

    -- [[ Poison Tracker ]] ---------------------------------------------------
    PoisonTracker          = "독 추적기",
    LethalPoisons          = "치명적인 독",
    LethalPoisonsDesc      = "치명적인 독이 없을 때 경고를 표시합니다.",
    NonLethalPoisons       = "비치명적인 독",
    NonLethalPoisonsDesc   = "비치명적인 독이 없을 때 경고를 표시합니다.",
    LethalPoisonMissing    = "치명적인 독 없음",
    NonLethalPoisonMissing = "비치명적인 독 없음",
    -- ========================================================================
    -- [[ MACRO SYSTEM (SHARED) ]] --------------------------------------------
    -- ========================================================================


    -- [[ Tricks of the Trade ]] ----------------------------------------------
    TricksOfTheTrade         = "속임수 거래",
    MacroTargetHeader =  "대상",
    MacroTargetSelector =  "대상 선택기",
    MacroTargetSelectorDesc =  "자동 대상 선택을 위한 기본 로직을 정의합니다.",
    MacroAutoUpdateWarning =  "|cffffa500Nightveil이 이 매크로를 자동으로 업데이트합니다.|r",
    TricksEnabledDesc        = "매크로를 사용하여 속임수 거래 대상을 자동으로 지정합니다.",
    MacroMouseoverDesc =  "마우스오버 대상 지정을 활성화합니다.\n\n참고: 구렁 동료를 제외한 다른 모든 방식보다 우선순위가 높습니다.",
    MacroFocusDesc =  "주시 대상을 통한 자동 대상 지정을 활성화합니다.\n\n참고: 대상 선택기보다 우선순위가 높지만, 마우스오버나 구렁 동료에 의해 무시됩니다.",
    MacroMuteDesc =  "매크로가 대상을 변경할 때 대화창 알림을 숨깁니다.",
    MacroDelveCompanion =  "구렁 동료",
    MacroDelveCompanionDesc =  "구렁 내에서 브란 브론즈비어드나 발리라 생귀나르를 자동으로 대상으로 지정합니다.\n\n참고: 구렁 내에서 최우선 순위를 가집니다.",
    TricksTargetLog          = "속임수 거래 대상",
    TricksNormal             = "일반",
    TricksCustom             = "사용자 정의",
    MacroCustomName =  "사용자 정의 대상",
    MacroCustomNameDesc =  "대상으로 지정할 플레이어의 정확한 이름을 입력하세요.",
    MacroCustomSet =  "사용자 정의 대상 설정됨: %s",
    MacroGroupMembers =  "파티원:",
    MacroInvalidIndex =  "잘못된 파티 인덱스입니다.",
    MacroNoSelf =  "자신을 대상으로 지정할 수 없습니다.",
    MacroBtnEnable =  "매크로 활성화 및 동기화",
    MacroBtnDisable =  "매크로 비활성화 및 삭제",
    MacroBtnDisableDesc =  "자동 대상 지정을 비활성화하고 매크로를 완전히 제거합니다.",
    TricksMsgEnabled         = "속임수 거래 시스템 활성화 및 매크로 동기화 완료.",
    TricksMsgDisabled        = "속임수 거래 시스템 비활성화 및 매크로 삭제 완료.",
    TricksAlreadyEnabled     = "속임수 거래 시스템이 이미 활성화되어 있습니다.",
    TricksAlreadyDisabled    = "속임수 거래 시스템이 이미 비활성화되어 있습니다.",
    TricksLogicSet           = "대상 지정 모드 설정됨: %s",
    Mouseover                = "마우스오버",
    Focus                    = "주시 대상",
    Tank                     = "방어 담당",
    TargetTarget             = "대상의 대상",

    -- [[ Shroud of Concealment ]] --------------------------------------------
    ShroudOfConcealment      = "은폐의 장막",
    EnableShroudCountdown    = "대화창 카운트다운 활성화",
    EnableShroudCountdownDesc = "대화창에 장막 카운트다운 메시지를 전송합니다.",
    ShroudOnlyInstancesDesc  = "인스턴스 내에서만 장막 메시지를 전송합니다.\n\n참고: 인스턴스 밖에서는 Blizzard 안티 스팸 기능으로 인해 일부 채널이 차단될 수 있습니다.",
    ShroudMuteErrors         = "오류 숨기기",
    ShroudMuteErrorsDesc     = "대화창에 장막 오류 메시지를 표시하지 않습니다.",
    ChatChannel              = "대화 채널",
    ChatChannelDesc          = "장막 메시지에 사용될 첫 번째 채널입니다.",
    ChatChannelFallbackDesc  = "첫 번째 채널을 사용할 수 없을 때 사용될 대체 채널입니다.",
    ShroudMessage            = "카운트다운 메시지",
    ShroudMessageDesc        = "카운트다운 중에 사용될 메시지 형식입니다.\n\n%time = 남은 시간.",
    ShroudOnStart            = "시작 메시지",
    ShroudOnStartDesc        = "장막이 시작될 때 전송될 메시지입니다.",
    ShroudOnEnd              = "종료 메시지",
    ShroudOnEndDesc          = "장막이 끝날 때(0초) 전송될 메시지입니다.",
    ShroudInterval           = "간격 모드",
    ShroudIntervalDesc       = "시작, 중간, 마지막 5초에 전송",
    TimeRemainingHint        = "%time = 남은 시간",
    TestShroud               = "장막 테스트",
    TestShroudDesc           = "로컬 5초 카운트다운을 시뮬레이션합니다.\n\n참고: 메시지는 본인에게만 보입니다.",
    ShroudAlreadyActive      = "장막 카운트다운이 이미 활성화되어 있습니다.",
    ShroudDisabled           = "설정에서 장막 카운트다운이 비활성화되어 있습니다.",
    ChannelSay               = "일반",
    ChannelParty             = "파티",
    ChannelRaid              = "공격대",
    ChannelInstance          = "인스턴스",
    ChannelYell              = "외치기",

    -- ========================================================================
    
    -- ========================================================================
    -- [[ CLASS MODULES — HUNTER ]] --------------------------------------------
    -- ========================================================================
    -- [[ Camouflage Module ]] -------------------------------------------------
    Camouflage              = "위장",
    EnableOnCamouflage      = "위장 중 활성화",
    EnableOnCamouflageDesc  = "위장이 지속되는 동안 시각 효과를 표시합니다.",
    CamouflageActiveText    = "위장됨",

    -- [[ Misdirection ]] ------------------------------------------------------
    Misdirection                = "눈속임",
    MisdirEnabledDesc           = "매크로를 사용한 눈속임 자동 대상 지정을 활성화합니다.",
    MisdirTargetLog             = "눈속임 대상",
    MisdirectionNotLearned      = "아직 눈속임을 배우지 않았습니다.",
    MisdirectionMsgEnabled      = "눈속임 시스템이 활성화되고 매크로가 동기화되었습니다.",
    MisdirectionMsgDisabled     = "눈속임 시스템이 비활성화되고 매크로가 삭제되었습니다.",
    MisdirectionAlreadyEnabled  = "눈속임 시스템이 이미 활성화되어 있습니다.",
    MisdirectionAlreadyDisabled = "눈속임 시스템이 이미 비활성화되어 있습니다.",
    MisdirLogicSet              = "대상 모드 설정: %s",
    MisdirNotLearned            = "아직 눈속임을 배우지 않았습니다.",
    Pet                         = "소환수",

    -- [[ PROFILE MANAGEMENT ]] -----------------------------------------------
    -- ========================================================================
    Profiles              = "프로필",
    ActiveProfile         = "활성 프로필",
    ActiveProfileDesc     = "활성화할 프로필을 선택합니다.",
    CreateProfile         = "프로필 생성",
    CreateProfileDesc     = "기본 설정으로 새 프로필을 만듭니다.",
    DuplicateProfile      = "프로필 복사",
    DuplicateProfileDesc  = "현재 프로필을 새 프로필로 복사합니다.",
    DeleteProfile         = "프로필 삭제",
    DeleteProfileDesc     = "선택 프로필을 삭제합니다 (실행 취소 불가).",
    ExportProfile         = "프로필 내보내기",
    ExportProfileDesc     = "이 프로필을 공유하기 위한 문자열을 생성합니다.",
    ImportProfile         = "프로필 가져오기",
    ImportProfileDesc     = "내보낸 문자열에서 프로필을 가져옵니다.",
    CreateProfilePrompt   = "새 프로필 이름을 입력하세요:",
    DuplicateProfilePrompt = "복사할 프로필 이름을 입력하세요:",
    FactoryResetBtn       = "공장 초기화",
    FactoryResetBtnDesc   = "모든 애드온 데이터와 매크로를 삭제하여 초기 상태로 복구합니다. UI가 재로드됩니다.",
    FactoryResetConfirm   = "|cffff0000경고:|r 이 작업은 Nightveil의 |cffff0000모든|r 설정과 프로필을 삭제하며, 애드온으로 생성된 매크로도 제거합니다.\n\n이 작업은 |cffff0000복구할 수 없습니다|r.\n\n정말로 계속하시겠습니까?",
    DeleteProfileConfirm  = "프로필 삭제:\n\n|cffff0000%s|r\n\n이 작업은 복구할 수 없습니다.",
    ExportProfilePrompt   = "이 내보내기 문자열을 복사하세요 (Ctrl+C):\n\n프로필: |cff00ff00%s|r",
    ImportProfilePrompt   = "아래에 프로필 내보내기 문자열을 붙여넣으세요:",
    ImportProfileNamePrompt = "가져온 프로필의 이름을 입력하세요:",
    ErrorDeleteRestricted = "기본 프로필은 삭제할 수 없습니다.",
    DefaultProfileLabel   = "기본값",
    Import                = "가져오기",
    Share                 = "공유",

    -- ========================================================================
    -- [[ SYSTEM MESSAGES & WARNINGS ]] ---------------------------------------
    -- ========================================================================
    WarningNotRogue         = "도적 클래스가 아닙니다. 이 명령은 도적 전용입니다.",
    TricksNotLearned        = "아직 속임수 거래를 배우지 않았습니다.",
    HardResetWarning        = "오래되었거나 호환되지 않는 버전이 감지되었습니다.\n\n안정성을 위해 설정이 초기화됩니다.",
    WarningOutdatedConfig   = "최신 설정이 감지되었습니다!\n\n사용 중인 프로필은 더 최신 버전의 Nightveil에서 생성되었습니다.",
    WelcomeMessage          = "%s |cffffd100v%s|r 로드됨. 설정을 열려면 |cffffd100/veil|r을 입력하세요.",
    UpdateMessage           = "%s가 |cffffd100v%s|r로 업데이트되었습니다! 변경 사항을 확인하려면 |cffffd100/veil|r을 입력하세요.",
    ErrorNoValidChannel     = "|cffff2020유효한 대화 채널이 없습니다.|r",
    ErrorBlizzardAntiSpam   = "|cffff2020Blizzard 안티 스팸 제한으로 인해 인스턴스 밖에서 |cffffcc00%s|r 채널을 사용할 수 없습니다.|r",
    ErrorNotInGroup         = "|cffff2020파티에 속해 있지 않습니다. |cffffcc00%s|r 채널을 사용할 수 없습니다.|r",
    ErrorNotInRaid          = "|cffff2020공격대에 속해 있지 않습니다. |cffffcc00%s|r 채널을 사용할 수 없습니다.|r",
    ErrorFollowersDungeonGroup = "|cffff2020혼자 있거나 유효하지 않은 그룹입니다. |cffffcc00%s|r 채널을 사용할 수 없습니다.|r",
    ErrorShroudOnlyInstances = "|cffff2020장막 메시지는 인스턴스 내에서만 작동합니다.|r",
    ErrorShroudInstanceOnly  = "|cffff2020인스턴스 안에 있지 않습니다. |cffffcc00%s|r 채널을 사용할 수 없습니다.|r",
    CombatBlocked         = "전투 중에는 설정을 열 수 없습니다.",
    MacroLimitReached     = "매크로 제한에 도달했습니다.",
    MuteChanges           = "변경 알림 숨기기",
    Next                  = "다음",

    -- ========================================================================
    -- [[ COMMANDS HELP ]] ----------------------------------------------------
    -- ========================================================================
    HelpSettings          = "설정",
    HelpTricks            = "속임수 거래 대상",
    HelpUTricks           = "매크로 강제 새로고침",
    HelpMisdir            = "눈속임 대상",
    HelpUMisdir           = "매크로 새로고침 강제",
    HelpMisdirPet         = "소환수 모드",
    HelpMisdirNormal      = "일반 모드",
    HelpMisdirTank        = "방어 전담 모드",
    HelpMisdirTT          = "대상의 대상 모드",
    HelpMisdirCustom      = "사용자 지정 모드",
    HelpMisdirList        = "파티원 목록 / 색인 설정",
    HelpMisdirSet         = "사용자 이름 설정",
    HelpInfo              = "진단 정보",
    HelpShroudTest        = "장막 카운트다운 테스트",
    HelpDebugToggle       = "디버그 모드 전환",
    HelpTricksList        = "목록 표시 및 인덱스로 설정",
    HelpTricksNormal      = "일반 모드",
    HelpTricksTank        = "방어 모드",
    HelpTricksTT          = "대상의 대상 모드",
    HelpTricksSet         = "이름으로 설정",
    HelpTricksCustom      = "사용자 정의 모드",
    ErrorUnknownCmd       = "알 수 없는 명령: |cffffd100%s|r. |cffffd100/veil help|r를 사용하세요.",
    ErrorUnknownSubCmd    = "알 수 없는 하위 명령: |cffffd100%s|r. |cffffd100/veil help|r를 사용하세요.",

    -- ========================================================================
    -- [[ DEBUG INFO ]] -------------------------------------------------------
    -- ========================================================================
    DebugModeActivated   = "디버그 모드 활성화됨",
    DebugModeDeactivated = "디버그 모드 비활성화됨",
    DebugModeRequired    = "이 명령은 디버그 모드가 필요합니다. 활성화하려면 |cffffd100/veil debug|r를 입력하세요.",
    DebugCommands        = "[디버그 명령]",
    DebugHeader          = "%s 진단 도구:",
    DebugCombat          = " - 전투: %s",
    DebugStealth         = " - 은신/소멸: %s",
    DebugInstance        = " - 인스턴스: %s (유형: %s)",
    DebugGroup           = " - 그룹: %s (공격대: %s, 총원: %d)",
    DebugComposition     = " - 구성: 플레이어 %d명, 소환수 %d마리, 기타 %d분",
    DebugTricksKnown     = " - 속임수 거래 습득 유무: %s",
    DebugTricksTarget    = " - 속임수 거래 대상: %s (%s)",
    DebugTricksMacro     = " - 속임수 거래 매크로: %s",
    DebugInvalidGroup    = " - 유효하지 않은 그룹: %s",
    DebugPlayer          = "플레이어",
    DebugPet             = "소환수",
    DebugOther           = "기타",
    DebugYes             = "네",
    DebugNo              = "아니요",
    DebugNone            = "없음",
    DebugUnknown         = "알 수 없음",
    DebugFallback1       = " - 대체 대상 1: %s (사용 가능: %s)",
    DebugFallback2       = " - 대체 대상 2: %s (사용 가능: %s)",
    DebugShroudUsage     = "사용법: |cffffd100/veil shroud [1-20]|r",
    DebugTricksForcing   = "속임수 거래 업데이트 강제 중...",
    DebugTricksSuccess   = "매크로 새로고침 성공.",
    DebugMacroUpdated    = "매크로 업데이트됨: %s",
    DebugMacroStatus     = "매크로: %s",
    DebugMacroEdited     = "매크로 내용이 수정 및 동기화되었습니다.",
    DebugCombatLock      = "이 작업은 전투 중에 사용할 수 없습니다.",

    -- ========================================================================
    -- [[ NPC / GAME TERMS ]] -------------------------------------------------
    -- ========================================================================
    BrannBronzebeard = "브란 브론즈비어드",
    ValeeraSanguinar = "발리라 생귀나르",
}
