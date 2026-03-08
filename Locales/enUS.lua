local addonName, ns = ...

ns.L = {
    -- General
    Description  = "Rogue utilities",
    ReleaseNotes = "Release Notes",
    Management = "Management",
    HardResetWarning = "|cffff2020Old or incompatible version detected.|r\n\nSettings will be |cffffd100reset|r to ensure stability.",

    -- Features & Spells
    Stealth     = "Stealth",
    ShadowDance = "Shadow Dance",
    PoisonTracker = "Poison Tracker",
    LethalPoisons = "Lethal Poison",
    NonLethalPoisons = "Non-Lethal Poison",
    ShroudOfConcealment = "Shroud of Concealment",

    -- Global Conditions
    Enable = "Enable",
    EnableOnStealth     = "Enable on Stealth",
    EnableOnShadowDance = "Enable on Shadow Dance",
    OnlyInCombat        = "Only in combat",
    OnlyInInstances     = "Only in instances",

    -- Visuals & UI Elements
    FloatingText  = "Floating Text",
    IndicatorIcon = "Indicator Icon",
    ScreenColor   = "Screen Color",
    Vignette       = "Vignette",
    Highlight     = "Highlight",
    Messages = "Messages",
    Sound = "Sound",

    -- Styling Options
    Color      = "Color",
    Size       = "Size",
    Opacity    = "Opacity",
    OffsetX    = "Offset X",
    OffsetY    = "Offset Y",
    Thickness  = "Thickness",
    CustomText = "Custom Text",
    Style      = "Style",
    
    -- Layers
    Layer           = "Layer",
    LayerBackground = "Background",
    LayerLow        = "Low",
    LayerMedium     = "Medium",
    LayerHigh       = "High",
    LayerDialog     = "Dialog",
    LayerFullscreen = "Fullscreen",

    -- Animations
    Animation      = "Animation",
    AnimationSpeed = "Speed",
    AnimNone  = "None",
    AnimBlink = "Blink",
    AnimFade  = "Fade",
    AnimShake = "Shake",

    -- Anchors
    AnchorToText = "Anchor to Text",
    AnchorPoint  = "Anchor Point",
    AnchorTopLeft     = "Top Left",
    AnchorTop         = "Top",
    AnchorTopRight    = "Top Right",
    AnchorLeft        = "Left",
    AnchorCenter      = "Center",
    AnchorRight       = "Right",
    AnchorBottomLeft  = "Bottom Left",
    AnchorBottom      = "Bottom",
    AnchorBottomRight = "Bottom Right",

    -- Icons & Sounds Options
    TestSound = "Test Sound",
    SelectIcon = "Select Icon",
    IconTexture = "Icon Texture",
    SoundKitId = "Sound Kit ID",

    -- Highlight Options
    HighlightCircle           = "Circle",
    HighlightOutline          = "Outline",
    HighlightIcon             = "Icon",
    HighlightCircleOutline    = "Circle + Outline",
    HighlightCircleIcon       = "Circle + Icon",
    HighlightOutlineIcon      = "Outline + Icon",
    HighlightCircleOutlineIcon = "Circle + Outline + Icon",

    -- Default Messages
    DefaultMessage     = "STEALTHED",
    ShadowDanceMessage = "SHADOW DANCE",
    LethalPoisonMissing = "LETHAL POISON MISSING",
    NonLethalPoisonMissing = "NON-LETHAL POISON MISSING",

    -- Shroud Specifics
    EnableShroudCountdown = "Enable chat countdown",
    ChatChannel         = "Chat Channel",
    ShroudMessage       = "Countdown Message",
    ShroudOnStart       = "Start Message",
    ShroudOnEnd         = "End Message",
    ShroudInterval      = "Interval Mode",
    ShroudIntervalDesc  = "Start, midpoint, and last 5s",
    TimeRemainingHint   = "%time = time remaining",
    TestShroud          = "Test Message",

    -- Chat Channels
    ChannelSay      = "Say",
    ChannelParty    = "Party",
    ChannelRaid     = "Raid",
    ChannelInstance = "Instance",
    ChannelYell     = "Yell",

    -- Profiles
    Profiles = "Profiles",
    ActiveProfile = "Active Profile",
    ProfileSharing = "Import / Export",
    CreateProfile = "Create Profile",
    DuplicateProfile = "Duplicate Profile",
    DeleteProfile = "Delete Profile",
    ExportProfile = "Export Profile",
    ImportProfile = "Import Profile",
    CreateProfilePrompt = "Enter a name for the new profile:",
    DuplicateProfilePrompt = "Enter a name for the duplicated profile:",
    DeleteProfileConfirm = "Delete profile:\n\n|cffff0000%s|r\n\nThis cannot be undone.",
    ExportProfilePrompt = "Copy this export string (Ctrl+C):\n\nProfile: |cff00ff00%s|r",
    ImportProfilePrompt = "Paste the profile export string below:",
    ImportProfileNamePrompt = "Enter a name for the imported profile:",
    Next = "Next",
    Import = "Import",
}