-- ============================================================================
-- [[ NAMESPACE & CONSTANTS SETUP ]] ------------------------------------------
-- ============================================================================
local addonName, ns = ...
ns.Shared = ns.Shared or {}

-- [[ ADDON METADATA ]] -------------------------------------------------------
ns.Version    = C_AddOns and C_AddOns.GetAddOnMetadata(addonName, "Version") or GetAddOnMetadata(addonName, "Version") or "2.2.0"
ns.MinVersion = "2.0.0"

-- [[ CLASS BRANDING COLORS ]] ------------------------------------------------
-- Custom curated colors for class-specific UI elements
ns.Shared.CLASS_COLORS = {
    ["DEATHKNIGHT"] = "C41E3A",
    ["DEMONHUNTER"] = "A330C9",
    ["DRUID"]       = "FF7C0A",
    ["EVOKER"]      = "33937F",
    ["HUNTER"]      = "AAD372",
    ["MAGE"]        = "3FC7EB",
    ["MONK"]        = "00FF98",
    ["PALADIN"]     = "F48CBA",
    ["PRIEST"]      = "FFFFFF",
    ["ROGUE"]       = "FFF468",
    ["SHAMAN"]      = "0070DD",
    ["WARLOCK"]     = "8788EE",
    ["WARRIOR"]     = "C69B6D",
}

-- [[ UI & LAYOUT CONSTANTS ]] ------------------------------------------------

-- Frame Strata
ns.UI_LAYERS = {
    { value = "BACKGROUND", label = (ns.L and ns.L.LayerBackground) or "Background" },
    { value = "LOW",        label = (ns.L and ns.L.LayerLow) or "Low" },
    { value = "MEDIUM",     label = (ns.L and ns.L.LayerMedium) or "Medium" },
    { value = "HIGH",       label = (ns.L and ns.L.LayerHigh) or "High" },
    { value = "DIALOG",     label = (ns.L and ns.L.LayerDialog) or "Dialog" },
    { value = "FULLSCREEN", label = (ns.L and ns.L.LayerFullscreen) or "Fullscreen" },
}
ns.UI_LAYER_ORDER = { "BACKGROUND", "LOW", "MEDIUM", "HIGH", "DIALOG", "FULLSCREEN" }
ns.UI_LAYER_MAP = {}
for _, e in ipairs(ns.UI_LAYERS) do ns.UI_LAYER_MAP[e.value] = e.label end

-- Anchor Points
ns.UI_ANCHOR_ORDER = { "TOPLEFT","TOP","TOPRIGHT","LEFT","CENTER","RIGHT","BOTTOMLEFT","BOTTOM","BOTTOMRIGHT" }
ns.UI_ANCHOR_MAP = {
    TOPLEFT     = (ns.L and ns.L.AnchorTopLeft) or "Top Left",
    TOP         = (ns.L and ns.L.AnchorTop) or "Top",
    TOPRIGHT    = (ns.L and ns.L.AnchorTopRight) or "Top Right",
    LEFT        = (ns.L and ns.L.AnchorLeft) or "Left",
    CENTER      = (ns.L and ns.L.AnchorCenter) or "Center",
    RIGHT       = (ns.L and ns.L.AnchorRight) or "Right",
    BOTTOMLEFT  = (ns.L and ns.L.AnchorBottomLeft) or "Bottom Left",
    BOTTOM      = (ns.L and ns.L.AnchorBottom) or "Bottom",
    BOTTOMRIGHT = (ns.L and ns.L.AnchorBottomRight) or "Bottom Right",
}

-- [[ SYSTEM & MODULE CONSTANTS ]] --------------------------------------------

-- Chat Channels
ns.UI_CHANNELS = {
    ["NONE"]          = (ns.L and ns.L.DebugNone) or "none",
    ["SAY"]           = (ns.L and ns.L.ChannelSay) or "Say",
    ["YELL"]          = (ns.L and ns.L.ChannelYell) or "Yell",
    ["PARTY"]         = (ns.L and ns.L.ChannelParty) or "Party",
    ["RAID"]          = (ns.L and ns.L.ChannelRaid) or "Raid",
    ["INSTANCE_CHAT"] = (ns.L and ns.L.ChannelInstance) or "Instance",
}
ns.UI_CHANNEL_ORDER = { "NONE", "SAY", "YELL", "PARTY", "RAID", "INSTANCE_CHAT" }

-- Tricks of the Trade Target Logic (Rogue)
ns.UI_TRICKS_LOGIC_OPTIONS = {
    ["TANK"]         = ns.L and ns.L.Tank or "Tank",
    ["NORMAL"]       = ns.L and ns.L.TricksNormal or "Normal",
    ["TARGETTARGET"] = ns.L and ns.L.TargetTarget or "Target of Target",
    ["CUSTOM"]       = ns.L and ns.L.TricksCustom or "Custom",
}
ns.UI_TRICKS_LOGIC_ORDER = { "NORMAL", "TANK", "TARGETTARGET", "CUSTOM" }

-- Misdirection Target Logic (Hunter)
ns.UI_MISDIR_LOGIC_OPTIONS = {
    ["PET"]          = ns.L and ns.L.Pet or "Pet",
    ["TANK"]         = ns.L and ns.L.Tank or "Tank",
    ["NORMAL"]       = ns.L and ns.L.TricksNormal or "Normal",
    ["TARGETTARGET"] = ns.L and ns.L.TargetTarget or "Target of Target",
    ["CUSTOM"]       = ns.L and ns.L.TricksCustom or "Custom",
}
ns.UI_MISDIR_LOGIC_ORDER = { "PET", "NORMAL", "TANK", "TARGETTARGET", "CUSTOM" }
