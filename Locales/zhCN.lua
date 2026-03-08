local addonName, ns = ...
local locale = GetLocale()
if locale ~= "zhCN" and locale ~= "zhTW" then return end
local L = ns.L
local cn = locale == "zhCN"

-- 常规 (General)
L.Description  = cn and "潜行工具" or "潛行工具"
L.ReleaseNotes = cn and "更新日志" or "更新日誌"
L.Management   = cn and "管理" or "管理"
L.HardResetWarning = cn and "|cffff2020检测到旧版本或不兼容版本。|r\n\n设置将被 |cffffd100重置|r 以确保稳定性。" or "|cffff2020檢測到舊版本或不兼容版本。|r\n\n設置將被 |cffffd100重置|r 以確保穩定性。"

-- 功能与法术 (Features & Spells)
L.Stealth     = cn and "潜行" or "潛行"
L.ShadowDance = cn and "暗影之舞" or "暗影之舞"
L.PoisonTracker = cn and "毒药追踪" or "毒藥追蹤"
L.LethalPoisons = cn and "致命毒药" or "致命毒藥"
L.NonLethalPoisons = cn and "非致命毒药" or "非致命毒藥"
L.ShroudOfConcealment = cn and "潜行帷幕" or "潛行帷幕"

-- 全局条件 (Global Conditions)
L.Enable = cn and "启用" or "啟用"
L.EnableOnStealth     = cn and "潜行时启用" or "潛行時啟用"
L.EnableOnShadowDance = cn and "暗影之舞时启用" or "暗影之舞時啟用"
L.OnlyInCombat        = cn and "仅在战斗中" or "僅在戰鬥中"
L.OnlyInInstances     = cn and "仅在副本中" or "僅在副本中"

-- 视觉与 UI 元素 (Visuals & UI Elements)
L.FloatingText  = cn and "浮动文字" or "浮動文字"
L.IndicatorIcon = cn and "指示图标" or "指示圖示"
L.ScreenColor   = cn and "屏幕颜色" or "螢幕顏色"
L.Vignette      = cn and "渐变效果" or "漸層效果"
L.Highlight     = cn and "高亮" or "高亮"
L.Messages = cn and "消息" or "訊息"
L.Sound = cn and "声音" or "聲音"

-- 样式选项 (Styling Options)
L.Color      = cn and "颜色" or "顏色"
L.Size       = cn and "大小" or "大小"
L.Opacity    = cn and "透明度" or "透明度"
L.OffsetX    = cn and "偏移 X" or "偏移 X"
L.OffsetY    = cn and "偏移 Y" or "偏移 Y"
L.Thickness  = cn and "厚度" or "厚度"
L.CustomText = cn and "自定义文字" or "自訂文字"
L.Style      = cn and "样式" or "樣式"

-- 层级 (Layers)
L.Layer           = cn and "层级" or "層級"
L.LayerBackground = cn and "背景" or "背景"
L.LayerLow        = cn and "低" or "低"
L.LayerMedium     = cn and "中" or "中"
L.LayerHigh       = cn and "高" or "高"
L.LayerDialog     = cn and "对话框" or "對話框"
L.LayerFullscreen = cn and "全屏" or "全螢幕"

-- 动画 (Animations)
L.Animation      = cn and "动画" or "動畫"
L.AnimationSpeed = cn and "速度" or "速度"
L.AnimNone  = cn and "无" or "無"
L.AnimBlink = cn and "闪烁" or "閃爍"
L.AnimFade  = cn and "渐隐" or "漸隱"
L.AnimShake = cn and "抖动" or "抖動"

-- 锚点 (Anchors)
L.AnchorToText = cn and "锚定到文字" or "錨定到文字"
L.AnchorPoint  = cn and "锚点位置" or "錨點位置"
L.AnchorTopLeft     = cn and "左上" or "左上"
L.AnchorTop         = cn and "上方" or "上方"
L.AnchorTopRight    = cn and "右上" or "右上"
L.AnchorLeft        = cn and "左侧" or "左側"
L.AnchorCenter      = cn and "居中" or "置中"
L.AnchorRight       = cn and "右侧" or "右側"
L.AnchorBottomLeft  = cn and "左下" or "左下"
L.AnchorBottom      = cn and "下方" or "下方"
L.AnchorBottomRight = cn and "右下" or "右下"

-- 图标与声音选项 (Icons & Sounds Options)
L.TestSound = cn and "测试声音" or "測試聲音"
L.SelectIcon = cn and "选择图标" or "選擇圖示"
L.IconTexture = cn and "图标材质" or "圖示材質"
L.SoundKitId = cn and "声音套件 ID" or "聲音套件 ID"

-- 高亮选项 (Highlight Options)
L.HighlightCircle           = cn and "圆圈" or "圓圈"
L.HighlightOutline          = cn and "轮廓" or "輪廓"
L.HighlightIcon             = cn and "图标" or "圖示"
L.HighlightCircleOutline    = cn and "圆圈 + 轮廓" or "圓圈 + 輪廓"
L.HighlightCircleIcon       = cn and "圆圈 + 图标" or "圓圈 + 圖示"
L.HighlightOutlineIcon      = cn and "轮廓 + 图标" or "輪廓 + 圖示"
L.HighlightCircleOutlineIcon = cn and "圆圈 + 轮廓 + 图标" or "圓圈 + 輪廓 + 圖示"

-- 默认消息 (Default Messages)
L.DefaultMessage     = cn and "已潜行" or "已潛行"
L.ShadowDanceMessage = cn and "暗影之舞" or "暗影之舞"
L.LethalPoisonMissing = cn and "缺少致命毒药" or "缺少致命毒藥"
L.NonLethalPoisonMissing = cn and "缺少非致命毒药" or "缺少非致命毒藥"

-- 帷幕细节 (Shroud Specifics)
L.EnableShroudCountdown = cn and "启用聊天倒计时" or "啟用聊天倒數計時"
L.ChatChannel         = cn and "聊天频道" or "聊天頻道"
L.ShroudMessage       = cn and "倒计时消息" or "倒數計時訊息"
L.ShroudOnStart       = cn and "开始消息" or "開始訊息"
L.ShroudOnEnd         = cn and "结束消息" or "結束訊息"
L.ShroudInterval      = cn and "间隔模式" or "間隔模式"
L.ShroudIntervalDesc  = cn and "开始、中段和最后5秒" or "開始、中段和最後5秒"
L.TimeRemainingHint   = cn and "%time = 剩余时间" or "%time = 剩餘時間"
L.TestShroud          = cn and "测试消息" or "測試訊息"

-- 聊天频道 (Chat Channels)
L.ChannelSay      = cn and "说" or "說"
L.ChannelParty    = cn and "小队" or "隊伍"
L.ChannelRaid     = cn and "团队" or "團隊"
L.ChannelInstance = cn and "副本" or "副本"
L.ChannelYell     = cn and "大喊" or "大喊"

-- 配置文件 (Profiles)
L.Profiles = cn and "配置文件" or "設定檔"
L.ActiveProfile = cn and "当前配置" or "目前設定"
L.ProfileSharing = cn and "导入 / 导出" or "匯入 / 匯出"
L.CreateProfile = cn and "新建配置" or "新增設定"
L.DuplicateProfile = cn and "复制配置" or "複製設定"
L.DeleteProfile = cn and "删除配置" or "刪除設定"
L.ExportProfile = cn and "导出配置" or "匯出設定"
L.ImportProfile = cn and "导入配置" or "匯入設定"
L.CreateProfilePrompt = cn and "请输入新配置名称：" or "請輸入新設定名稱："
L.DuplicateProfilePrompt = cn and "请输入复制后配置名称：" or "請輸入複製後設定名稱："
L.DeleteProfileConfirm = cn and "删除配置：\n\n|cffff0000%s|r\n\n无法撤销。" or "刪除設定：\n\n|cffff0000%s|r\n\n無法復原。"
L.ExportProfilePrompt = cn and "复制此字符串 (Ctrl+C)：\n\n配置：|cff00ff00%s|r" or "複製此字串 (Ctrl+C)：\n\n設定：|cff00ff00%s|r"
L.ImportProfilePrompt = cn and "请在下方粘贴配置导出字符串：" or "請在下方貼上設定匯出字串："
L.ImportProfileNamePrompt = cn and "请输入导入后配置名称：" or "請輸入匯入後設定名稱："
L.Next = cn and "下一步" or "下一步"
L.Import = cn and "导入" or "匯入"

-- 版本
L.WelcomeMessage = "|cffA361E2Nightveil|r |cffffffffv%s 已加载. 输入 |r|cffffd100/veil|r |cffffffff打开设置窗口.|r"
L.UpdateMessage = "|cffA361E2Nightveil|r |cffffffff已更新至 |r|cff00ff00v%s|r|cffffffff! 请在设置中查看更新日志.|r"