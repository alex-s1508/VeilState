local addonName, ns = ...
if GetLocale() ~= "koKR" then return end
local L = ns.L

-- 일반 (General)
L.Description  = "도적 유틸리티"
L.ReleaseNotes = "업데이트 노트"
L.Management   = "관리"
L.HardResetWarning = "|cffff2020이전 버전 또는 호환되지 않는 버전이 감지되었습니다.|r\n\n설정이 |cffffd100초기화|r됩니다."

-- 기능 및 주문 (Features & Spells)
L.Stealth     = "은신"
L.ShadowDance = "어둠의 춤"
L.PoisonTracker = "독 추적기"
L.LethalPoisons = "치명적인 독"
L.NonLethalPoisons = "비치명적인 독"
L.ShroudOfConcealment = "은폐의 장막"

-- 전역 조건 (Global Conditions)
L.Enable = "활성화"
L.EnableOnStealth     = "은신 시 활성화"
L.EnableOnShadowDance = "어둠의 춤 시 활성화"
L.OnlyInCombat        = "전투 중에만"
L.OnlyInInstances     = "인스턴스에서만"

-- 시각 효과 및 UI 요소 (Visuals & UI Elements)
L.FloatingText  = "플로팅 텍스트"
L.IndicatorIcon = "표시 아이콘"
L.ScreenColor   = "화면 색상"
L.Vignette      = "비네트"
L.Highlight     = "강조"
L.Messages = "메시지"
L.Sound = "소리"

-- 스타일 옵션 (Styling Options)
L.Color      = "색상"
L.Size       = "크기"
L.Opacity    = "투명도"
L.OffsetX    = "오프셋 X"
L.OffsetY    = "오프셋 Y"
L.Thickness  = "두께"
L.CustomText = "사용자 지정 텍스트"
L.Style      = "스타일"

-- 레이어 (Layers)
L.Layer           = "레이어"
L.LayerBackground = "배경"
L.LayerLow        = "낮음"
L.LayerMedium     = "중간"
L.LayerHigh       = "높음"
L.LayerDialog     = "대화 상자"
L.LayerFullscreen = "전체 화면"

-- 애니메이션 (Animations)
L.Animation      = "애니메이션"
L.AnimationSpeed = "속도"
L.AnimNone  = "없음"
L.AnimBlink = "깜빡임"
L.AnimFade  = "페이드"
L.AnimShake = "흔들기"

-- 고정 위치 (Anchors)
L.AnchorToText = "텍스트에 고정"
L.AnchorPoint  = "고정 위치"
L.AnchorTopLeft     = "왼쪽 위"
L.AnchorTop         = "위"
L.AnchorTopRight    = "오른쪽 위"
L.AnchorLeft        = "왼쪽"
L.AnchorCenter      = "중앙"
L.AnchorRight       = "오른쪽"
L.AnchorBottomLeft  = "왼쪽 아래"
L.AnchorBottom      = "아래"
L.AnchorBottomRight = "오른쪽 아래"

-- 아이콘 및 소리 옵션 (Icons & Sounds Options)
L.TestSound = "소리 테스트"
L.SelectIcon = "아이콘 선택"
L.IconTexture = "아이콘 텍스처"
L.SoundKitId = "사운드 키트 ID"

-- 강조 옵션 (Highlight Options)
L.HighlightCircle           = "원"
L.HighlightOutline          = "윤곽선"
L.HighlightIcon             = "아이콘"
L.HighlightCircleOutline    = "원 + 윤곽선"
L.HighlightCircleIcon       = "원 + 아이콘"
L.HighlightOutlineIcon      = "윤곽선 + 아이콘"
L.HighlightCircleOutlineIcon = "원 + 윤곽선 + 아이콘"

-- 기본 메시지 (Default Messages)
L.DefaultMessage     = "은신 중"
L.ShadowDanceMessage = "어둠의 춤"
L.LethalPoisonMissing = "치명적인 독 없음"
L.NonLethalPoisonMissing = "비치명적인 독 없음"

-- 은폐의 장막 설정 (Shroud Specifics)
L.EnableShroudCountdown = "채팅 카운트다운 활성화"
L.ChatChannel         = "채팅 채널"
L.ShroudMessage       = "카운트다운 메시지"
L.ShroudOnStart       = "시작 메시지"
L.ShroudOnEnd         = "종료 메시지"
L.ShroudInterval      = "간격 모드"
L.ShroudIntervalDesc  = "시작, 중간 지점, 마지막 5초"
L.TimeRemainingHint   = "%time = 남은 시간"
L.TestShroud          = "메시지 테스트"

-- 채팅 채널 (Chat Channels)
L.ChannelSay      = "말하기"
L.ChannelParty    = "파티"
L.ChannelRaid     = "공격대"
L.ChannelInstance = "인스턴스"
L.ChannelYell     = "외치기"

-- 프로필 (Profiles)
L.Profiles = "프로필"
L.ActiveProfile = "활성 프로필"
L.ProfileSharing = "가져오기 / 내보내기"
L.CreateProfile = "프로필 생성"
L.DuplicateProfile = "프로필 복제"
L.DeleteProfile = "프로필 삭제"
L.ExportProfile = "프로필 내보내기"
L.ImportProfile = "프로필 가져오기"
L.CreateProfilePrompt = "새 프로필 이름을 입력하세요:"
L.DuplicateProfilePrompt = "복제할 프로필 이름을 입력하세요:"
L.DeleteProfileConfirm = "프로필 삭제:\n\n|cffff0000%s|r\n\n되돌릴 수 없습니다."
L.ExportProfilePrompt = "이 문자열을 복사하세요 (Ctrl+C):\n\n프로필: |cff00ff00%s|r"
L.ImportProfilePrompt = "프로필 내보내기 문자열을 아래에 붙여넣으세요:"
L.ImportProfileNamePrompt = "가져올 프로필 이름을 입력하세요:"
L.Next = "다음"
L.Import = "가져오기"