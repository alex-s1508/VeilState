local addonName, ns = ...
if GetLocale() ~= "ruRU" then return end
local L = ns.L

-- General (Общее)
L.Description  = "Утилиты разбойника"
L.ReleaseNotes = "Примечания к обновлению"
L.Management   = "Управление"
L.HardResetWarning = "|cffff2020Обнаружена старая или несовместимая версия.|r\n\nНастройки будут |cffffd100сброшены|r для обеспечения стабильности."

-- Features & Spells (Функции и заклинания)
L.Stealth     = "Незаметность"
L.ShadowDance = "Танец теней"
L.PoisonTracker = "Отслеживание ядов"
L.LethalPoisons = "Смертоносный яд"
L.NonLethalPoisons = "Несмертоносный яд"
L.ShroudOfConcealment = "Пелена сокрытия"

-- Global Conditions (Глобальные условия)
L.Enable = "Включить"
L.EnableOnStealth     = "Включать в незаметности"
L.EnableOnShadowDance = "Включать в Танце теней"
L.OnlyInCombat        = "Только в бою"
L.OnlyInInstances     = "Только в подземельях"

-- Visuals & UI Elements (Визуальные эффекты и интерфейс)
L.FloatingText  = "Плавающий текст"
L.IndicatorIcon = "Значок индикатора"
L.ScreenColor   = "Цвет экрана"
L.Vignette      = "Виньетка"
L.Highlight     = "Подсветка"
L.Messages = "Сообщения"
L.Sound = "Звук"

-- Styling Options (Настройка стиля)
L.Color      = "Цвет"
L.Size       = "Размер"
L.Opacity    = "Прозрачность"
L.OffsetX    = "Смещение X"
L.OffsetY    = "Смещение Y"
L.Thickness  = "Толщина"
L.CustomText = "Пользовательский текст"
L.Style      = "Стиль"

-- Layers (Слои)
L.Layer           = "Слой"
L.LayerBackground = "Фон"
L.LayerLow        = "Низкий"
L.LayerMedium     = "Средний"
L.LayerHigh       = "Высокий"
L.LayerDialog     = "Диалог"
L.LayerFullscreen = "Весь экран"

-- Animations (Анимация)
L.Animation      = "Анимация"
L.AnimationSpeed = "Скорость"
L.AnimNone  = "Нет"
L.AnimBlink = "Мигание"
L.AnimFade  = "Затухание"
L.AnimShake = "Тряска"

-- Anchors (Точки привязки)
L.AnchorToText = "Привязать к тексту"
L.AnchorPoint  = "Точка привязки"
L.AnchorTopLeft     = "Сверху слева"
L.AnchorTop         = "Сверху"
L.AnchorTopRight    = "Сверху справа"
L.AnchorLeft        = "Слева"
L.AnchorCenter      = "Центр"
L.AnchorRight       = "Справа"
L.AnchorBottomLeft  = "Снизу слева"
L.AnchorBottom      = "Снизу"
L.AnchorBottomRight = "Снизу справа"

-- Icons & Sounds Options (Иконки и звуки)
L.TestSound = "Проверить звук"
L.SelectIcon = "Выбрать значок"
L.IconTexture = "Текстура значка"
L.SoundKitId = "ID SoundKit"

-- Highlight Options (Настройки подсветки)
L.HighlightCircle           = "Круг"
L.HighlightOutline          = "Контур"
L.HighlightIcon             = "Значок"
L.HighlightCircleOutline    = "Круг + Контур"
L.HighlightCircleIcon       = "Круг + Значок"
L.HighlightOutlineIcon      = "Контур + Значок"
L.HighlightCircleOutlineIcon = "Круг + Контур + Значок"

-- Default Messages (Сообщения по умолчанию)
L.DefaultMessage     = "В НЕЗАМЕТНОСТИ"
L.ShadowDanceMessage = "ТАНЕЦ ТЕНЕЙ"
L.LethalPoisonMissing = "НЕТ СМЕРТОНОСНОГО ЯДА"
L.NonLethalPoisonMissing = "НЕТ НЕСМЕРТОНОСНОГО ЯДА"

-- Shroud Specifics (Специфика Пелены)
L.EnableShroudCountdown = "Включить отсчёт в чате"
L.ChatChannel         = "Канал чата"
L.ShroudMessage       = "Сообщение отсчёта"
L.ShroudOnStart       = "Сообщение начала"
L.ShroudOnEnd         = "Сообщение конца"
L.ShroudInterval      = "Интервальный режим"
L.ShroudIntervalDesc  = "Начало, середина и последние 5 с"
L.TimeRemainingHint   = "%time = оставшееся время"
L.TestShroud          = "Тест сообщения"

-- Chat Channels (Каналы чата)
L.ChannelSay      = "Сказать"
L.ChannelParty    = "Группа"
L.ChannelRaid     = "Рейд"
L.ChannelInstance = "Инстанс"
L.ChannelYell     = "Крик"

-- Profiles (Профили)
L.Profiles = "Профили"
L.ActiveProfile = "Активный профиль"
L.ProfileSharing = "Импорт / Экспорт"
L.CreateProfile = "Создать профиль"
L.DuplicateProfile = "Дублировать профиль"
L.DeleteProfile = "Удалить профиль"
L.ExportProfile = "Экспорт профиля"
L.ImportProfile = "Импорт профиля"
L.CreateProfilePrompt = "Введите имя для нового профиля:"
L.DuplicateProfilePrompt = "Введите имя для дублированного профиля:"
L.DeleteProfileConfirm = "Удалить профиль:\n\n|cffff0000%s|r\n\nЭто действие нельзя отменить."
L.ExportProfilePrompt = "Скопируйте эту строку (Ctrl+C):\n\nПрофиль: |cff00ff00%s|r"
L.ImportProfilePrompt = "Вставьте строку экспорта профиля ниже:"
L.ImportProfileNamePrompt = "Введите имя для импортированного профиля:"
L.Next = "Далее"
L.Import = "Импорт"