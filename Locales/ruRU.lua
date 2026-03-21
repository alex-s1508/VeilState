local addonName, ns = ...
local locale = GetLocale()
if locale ~= "ruRU" then return end

ns.L = {
    -- ========================================================================
    -- [[ SYSTEM / GENERAL UI ]] -----------------------------------------
    -- ========================================================================
    Enable                  = "Включить",
    Management              = "Управление",
    ReleaseNotes            = "Заметки к выпуску",
    WelcomeMessage          = "%s |cffffcc00v%s|r загружен. Введите |cffffcc00/veil|r, чтобы открыть настройки.",
    UpdateMessage           = "%s обновлен до |cffffcc00v%s|r! Введите |cffffcc00/veil|r, чтобы узнать, что нового.",
    FloatingText            = "Всплывающий текст",

    -- ========================================================================
    -- [[ INTERFACE — Elements & Styles ]] -------------------------------
    -- ========================================================================
    Color                   = "Цвет",
    Size                    = "Размер",
    Opacity                 = "Непрозрачность",
    Thickness               = "Толщина",
    Style                   = "Стиль",
    Layer                   = "Слой",
    LayerBackground         = "Фон",
    LayerLow                = "Низкий",
    LayerMedium             = "Средний",
    LayerHigh               = "Высокий",
    LayerDialog             = "Диалог",
    LayerFullscreen         = "Весь экран",
    ScreenColor             = "Цвет экрана",
    Vignette                = "Виньетка",

    -- ========================================================================
    -- [[ INTERFACE — Positioning & Anchors ]] ---------------------------
    -- ========================================================================
    AnchorPoint             = "Точка привязки",
    AnchorToText            = "Привязать к тексту",
    OffsetX                 = "Смещение X",
    OffsetY                 = "Смещение Y",
    AnchorTopLeft           = "Сверху слева",
    AnchorTop               = "Сверху",
    AnchorTopRight          = "Сверху справа",
    AnchorLeft              = "Слева",
    AnchorCenter            = "Центр",
    AnchorRight             = "Справа",
    AnchorBottomLeft        = "Снизу слева",
    AnchorBottom            = "Снизу",
    AnchorBottomRight       = "Снизу справа",

    -- ========================================================================
    -- [[ INTERFACE — Icons & Multimedia ]] ------------------------------
    -- ========================================================================
    IndicatorIcon           = "Иконка-индикатор",
    IconTexture             = "Текстура иконки",
    Sound                   = "Звук",
    SoundKitId              = "ID SoundKit",
    TestSound               = "Проверить звук",

    -- ========================================================================
    -- [[ INTERFACE — Logic & Filters ]] ---------------------------------
    -- ========================================================================
    OnlyInInstances         = "Только в подземельях",
    OnlyInCombat            = "Только в бою",
    DisableInDungeons       = "Отключить в подземельях",
    DisableInRaids          = "Отключить в рейдах",
    InstanceFilters         = "Фильтры подземелий",

    -- ========================================================================
    -- [[ INTERFACE — Message Customization ]] ---------------------------
    -- ========================================================================
    CustomText              = "Пользовательский текст",
    Messages                = "Сообщения",

    -- ========================================================================
    -- [[ SHARED MODULES — Highlights ]] ---------------------------------
    -- ========================================================================
    Highlights              = "Подсветки",
    Highlight               = "Подсветка",
    HighlightGlobalDesc     = "|cffffa500Динамическая настройка подсветки персонажа во время игровых событий.|r",
    HighlightCombat         = "В бою",
    HighlightCombatDesc     = "Highlight style when entering combat.",
    HighlightInstance       = "В подземелье",
    HighlightInstanceDesc   = "Highlight style when inside a dungeon or raid.",
    HighlightHidden         = "В состоянии скрытности",
    HighlightHiddenDesc     = "Highlight style when in a custom stealth state.",
    HighlightStealth        = "In Stealth",
    HighlightStealthDesc    = "Highlight style when stealthed.",
    HighlightShroud         = "In Shroud of Concealment",
    HighlightShroudDesc     = "Highlight style when inside Shroud of Concealment.",
    HighlightCamouflage     = "In Camouflage",
    HighlightCamouflageDesc = "Highlight style when camouflaged.",
    HighlightProwl          = "In Prowl",
    HighlightProwlDesc      = "Highlight style when prowling.",
    HighlightOptNone        = "Нет",
    HighlightOptCircle      = "Круг",
    HighlightOptOutline     = "Контур",
    HighlightOptIcon        = "Иконка",
    HighlightOptCircleOutline = "Круг и контур",
    HighlightOptCircleIcon  = "Круг и иконка",
    HighlightOptOutlineIcon = "Контур и иконка",
    HighlightOptCircleOutlineIcon = "Круг, контур и иконка",

    -- ========================================================================
    -- [[ SHARED MODULES — Stealth State ]] ------------------------------
    -- ========================================================================
    StealthStateName        = "Состояние скрытности",
    StealthStateActiveText  = "СКРЫТНОСТЬ",
    EnableOnStealthState    = "Включить в скрытности",

    -- ========================================================================
    -- [[ SHARED MODULES — Macro System ]] -------------------------------
    -- ========================================================================
    MacroTargetHeader       = "Цель",
    MacroTargetSelector     = "Выбор цели",
    MacroAutoUpdateWarning  = "|cffffa500Nightveil автоматически обновляет этот макрос.|r",
    MacroDelveCompanion     = "Спутник вылазок",
    MacroCustomName         = "Своя цель",
    MacroCustomSet          = "Установлена своя цель: %s",
    MacroGroupMembers       = "Участники группы:",
    MacroInvalidIndex       = "Неверный индекс группы.",
    MacroNoSelf             = "Вы не можете выбрать целью самого себя.",
    MacroBtnEnable          = "Активировать и синхр. макрос",
    MacroBtnDisable         = "Деактивировать и удалить макрос",
    Mouseover               = "Мышь",
    Focus                   = "Фокус",
    Tank                    = "Танк",
    TargetTarget            = "Цель цели",
    TargetingModeSet        = "Режим выбора цели: %s",
    Pet                     = "Питомец",
    MuteChanges             = "Mute status changes",

    -- ========================================================================
    -- [[ CLASS MODULES — ROGUE ]] ---------------------------------------
    -- ========================================================================

    -- [[ Stealth ]] -------------------------------------------
    Stealth                 = "Незаметность",
    EnableOnStealth         = "Включить при незаметности",
    StealthUseState         = "Использовать обнаружение состояний",
    StealthActiveText       = "В СКРЫТНОСТИ",

    -- [[ Poison Tracker ]] ------------------------------------
    PoisonTracker           = "Отслеживание ядов",
    LethalPoisons           = "Смертельный яд",
    NonLethalPoisons        = "Смертоносный яд",
    LethalPoisonMissing     = "НЕТ СМЕРТЕЛЬНОГО ЯДА",
    NonLethalPoisonMissing  = "НЕТ СМЕРТОНОСНОГО ЯДА",

    -- [[ Tricks of the Trade ]] -------------------------------
    TricksOfTheTrade        = "Маленькие хитрости",
    TricksTargetLog         = "Цель хитростей",
    TricksNormal            = "Обычный",
    TricksCustom            = "Свой",
    TricksMsgEnabled        = "Система Хитростей активирована, макрос синхронизирован.",
    TricksMsgDisabled       = "Система Хитростей деактивирована, макрос удален.",
    TricksAlreadyEnabled    = "Система Маленьких хитростей уже включена.",
    TricksAlreadyDisabled   = "Система Маленьких хитростей уже выключена.",

    -- [[ Shroud of Concealment ]] -----------------------------
    ShroudOfConcealment     = "Покров незаметности",
    EnableShroudCountdown   = "Включить отсчет в чате",
    ShroudMuteErrors        = "Скрыть ошибки",
    ChatChannel             = "Канал чата",
    ShroudMessage           = "Сообщение отсчета",
    ShroudOnStart           = "Сообщение о начале",
    ShroudOnEnd             = "Сообщение о конце",
    ShroudInterval          = "Интервальный режим",
    TestShroud              = "Тест Покрова",
    ShroudAlreadyActive     = "Отсчет Покрова уже идет.",
    ShroudDisabled          = "Отсчет Покрова отключен в настройках.",

    -- ========================================================================
    -- [[ CLASS MODULES — HUNTER ]] --------------------------------------
    -- ========================================================================

    -- [[ Camouflage ]] ----------------------------------------
    Camouflage              = "Камуфляж",
    EnableOnCamouflage      = "Включить при камуфляже",
    CamouflageActiveText    = "В КАМУФЛЯЖЕ",

    -- [[ Misdirection ]] --------------------------------------
    Misdirection            = "Перенаправление",
    MisdirTargetLog         = "Цель перенаправления",
    MisdirectionNotLearned  = "Вы еще не изучили Перенаправление.",
    MisdirectionMsgEnabled  = "Система перенаправления активирована, макрос синхронизирован.",
    MisdirectionMsgDisabled = "Система перенаправления деактивирована, макрос удален.",
    MisdirectionAlreadyEnabled = "Система перенаправления уже активирована.",
    MisdirectionAlreadyDisabled = "Система перенаправления уже деактивирована.",

    -- ========================================================================
    -- [[ CLASS MODULES — DRUID ]] ---------------------------------------
    -- ========================================================================

    -- [[ Prowl ]] ---------------------------------------------
    Prowl                   = "Крадущийся зверь",
    EnableOnProwl           = "Включить при подкрадывании",
    ProwlActiveText         = "КРАДЕТСЯ",

    -- ========================================================================
    -- [[ PROFILE MANAGEMENT ]] ------------------------------------------
    -- ========================================================================
    Profiles                = "Профили",
    ActiveProfile           = "Активный профиль",
    ActiveProfileDesc       = "Select which profile to use for this character.",
    CreateProfile           = "Создать профиль",
    CreateProfileDesc       = "Create a new profile with default settings.",
    DuplicateProfile        = "Дублировать профиль",
    DuplicateProfileDesc    = "Create a copy of the current profile.",
    DeleteProfile           = "Удалить профиль",
    DeleteProfileDesc       = "Remove the selected profile (cannot delete Default).",
    ExportProfile           = "Экспорт профиля",
    ExportProfileDesc       = "Generate a string to share this profile with others.",
    ImportProfile           = "Импорт профиля",
    ImportProfileDesc       = "Import a profile from a shared string.",
    DefaultProfileLabel     = "По умолчанию",
    CreateProfilePrompt     = "Введите имя для нового профиля:",
    DuplicateProfilePrompt  = "Введите имя для дубликата профиля:",
    ExportProfilePrompt     = "Скопируйте строку экспорта (Ctrl+C):\n\nПрофиль: |cff00ff00%s|r",
    ImportProfilePrompt     = "Вставьте строку экспорта профиля ниже:",
    ImportProfileNamePrompt = "Введите имя для импортированного профиля:",
    DeleteProfileConfirm    = "Удалить профиль:\n\n|cffff0000%s|r\n\nЭто действие нельзя отменить.",
    FactoryResetBtn         = "Сброс настроек",
    FactoryResetBtnDesc     = "Deletes all addon data and macros, restoring to a clean installation. UI will reload.",
    FactoryResetConfirm     = "|cffff0000ВНИМАНИЕ:|r Это удалит |cffff0000ВСЕ|r ваши настройки и профили Nightveil, а также макросы, созданные аддоном.\n\nЭто действие |cffff0000НЕОБРАТИМО|r.\n\nВы уверены, что хотите продолжить?",
    ErrorProfileDeleteRestricted = "Вы не можете удалить стандартный профиль.",
    Import                  = "Импорт",
    Share                   = "Поделиться",
    Next                    = "Next",

    -- ========================================================================
    -- [[ CHAT CHANNELS ]] -----------------------------------------------
    -- ========================================================================
    ChannelSay              = "Сказать",
    ChannelParty            = "Группа",
    ChannelRaid             = "Рейд",
    ChannelInstance         = "Подземелье",
    ChannelYell             = "Крик",

    -- ========================================================================
    -- [[ SYSTEM NOTIFICATIONS & ERRORS ]] -------------------------------
    -- ========================================================================
    ErrorHardReset          = "|cffff2020Обнаружена старая или несовместимая версия.|r\n\nНастройки будут |cffffcc00сброшены|r для обеспечения стабильности.",
    WarningOutdatedConfig   = "|cffffcc00Обнаружена более новая конфигурация!|r\n\nРекомендуется |cffbe89e9обновить|r аддон или сбросить профиль.",
    ErrorChannelNoValid     = "|cffff2020Нет доступного канала чата.|r",
    ErrorChannelAntiSpam    = "|cffff2020Ограничения Blizzard запрещают использование канала|r |cffffcc00%s|r |cffff2020вне подземелий.|r",
    ErrorChannelNoGroup     = "|cffff2020Вы не в группе. Канал|r |cffffcc00%s|r |cffff2020недоступен.|r",
    ErrorChannelNoRaid      = "|cffff2020Вы не в рейде. Канал|r |cffffcc00%s|r |cffff2020недоступен.|r",
    ErrorChannelInvalidGroup = "|cffff2020Вы одни или в неподходящей группе. Канал|r |cffffcc00%s|r |cffff2020недоступен.|r",
    ErrorChannelInstanceOnly = "|cffff2020Channel|r |cffffcc00%s|r |cffff2020unavailable outside instances.|r",
    ErrorNotRogue           = "Вы не Разбойник. Эта команда только для Разбойников.",
    ErrorNotHunter          = "You are not a Hunter. This command is Hunter-only.",
    ErrorTricksNotLearned   = "Вы еще не выучили Маленькие хитрости.",
    ErrorMisdirNotLearned   = "You have not learned Misdirection yet.",
    ErrorShroudOnlyInstances = "|cffff2020Сообщения Покрова работают только внутри подземелий.",
    ErrorCombatBlocked      = "Невозможно открыть настройки во время боя.",
    ErrorMacroLimitReached  = "Достигнут лимит макросов.",
    ErrorMacroCombatLock    = "This action cannot be used in combat.",
    ErrorUnknownCmd         = "Неизвестная команда: |cffffcc00%s|r. Используйте |cffffcc00/veil help|r.",
    ErrorUnknownSubCmd      = "Неизвестная подкоманда: |cffffcc00%s|r. Используйте |cffffcc00/veil help|r.",
    DebugCombatLock         = "This action cannot be used in combat.",

    -- ========================================================================
    -- [[ COMMANDS HELP ]] -----------------------------------------------
    -- ========================================================================
    HelpSettings            = "Настройки",
    HelpTricks              = "Цель хитростей",
    HelpMisdir              = "Цель перенаправления",
    HelpMisdirPet           = "Pet mode",
    HelpInfo                = "Диагностика",
    HelpShroudTest          = "Тест отсчета Покрова",
    HelpDebugToggle         = "Переключить режим отладки",
    HelpForceRefresh        = "Принудительное обновление макроса",
    HelpModeNormal          = "Обычный режим",
    HelpModeTank            = "Режим Танка",
    HelpModeTT              = "Режим Цель-цели",
    HelpModeCustom          = "Свой режим",
    HelpModeList            = "Список и установка по индексу",
    HelpModeSet             = "Установить по имени",

    -- ========================================================================
    -- [[ DEBUG & DIAGNOSTICS ]] -----------------------------------------
    -- ========================================================================
    DebugModeActivated      = "Режим отладки ВКЛЮЧЕН",
    DebugModeDeactivated    = "Режим отладки ВЫКЛЮЧЕН",
    DebugModeRequired       = "Эта команда требует режима отладки. Введите |cffffcc00/veil debug|r для включения.",
    DebugCommands           = "[Команды отладки]",
    DebugHeader             = "Диагностика %s:",
    DebugCombat             = "- Бой: %s",
    DebugStealth            = "- Скрытность/Исчезновение: %s",
    DebugInstance           = "- Подземелье: %s (Тип: %s)",
    DebugGroup              = "- Группа: %s (Рейд: %s, Всего: %d)",
    DebugComposition        = "- Состав: %d Игроков, %d Питомцев, %d Других",
    DebugTricksKnown        = "- Хитрости выучены: %s",
    DebugTricksTarget       = "- Цель хитростей: %s (%s)",
    DebugTricksMacro        = "- Макрос хитростей: %s",
    DebugInvalidGroup       = "- Ошибка группы: %s",
    DebugPlayer             = "ИГРОК",
    DebugPet                = "ПИТОМЕЦ",
    DebugOther              = "ДРУГОЙ",
    DebugYes                = "ДА",
    DebugNo                 = "НЕТ",
    DebugNone               = "нет",
    DebugUnknown            = "Неизвестно",
    DebugFallback1          = "- Запас 1: %s (Доступно: %s)",
    DebugFallback2          = "- Запас 2: %s (Доступно: %s)",
    DebugShroudUsage        = "Использование: |cffffcc00/veil shroud [1-20]|r",
    DebugTricksForcing      = "Принудительное обновление Хитростей...",
    DebugMisdirForcing      = "Forcing Misdirection update...",
    DebugMacroSuccess       = "Обновление макроса УСПЕШНО.",
    DebugMacroUpdated       = "Макрос обновлен: %s",
    DebugMacroStatus        = "Макрос: %s",
    DebugMacroEdited        = "Содержимое макроса изменено и синхронизировано.",

    -- ========================================================================
    -- [[ NPC / GAME TERMS ]] --------------------------------------------
    -- ========================================================================
    BrannBronzebeard        = "Бранн Бронзобород",
    ValeeraSanguinar        = "Валира Сангвинар",

}
