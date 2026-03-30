-- ============================================================================
-- [[ HIGHLIGHT SETTINGS ]] ---------------------------------------------------
-- ============================================================================
local addonName, ns = ...
local SettingsLib = LibStub("LibEQOLSettingsMode-1.0")

ns.Modules = ns.Modules or {}
ns.Modules.HighlightSettings = {}

-- [[ UI DATA & LOOKUPS ]] ----------------------------------------------------

local G = ns.Modules.Settings and ns.Modules.Settings.Get or function(k, d) return ns.db and ns.db[k] or d end
local D = ns.Defaults

local HL_MAP = {
    [0] = (ns.L and ns.L.HighlightOptNone) or "None",
    [1] = (ns.L and ns.L.HighlightOptCircle) or "Circle",
    [2] = (ns.L and ns.L.HighlightOptOutline) or "Outline",
    [3] = (ns.L and ns.L.HighlightOptIcon) or "Icon",
    [4] = (ns.L and ns.L.HighlightOptCircleOutline) or "Circle and Outline",
    [5] = (ns.L and ns.L.HighlightOptCircleIcon) or "Circle and Icon",
    [6] = (ns.L and ns.L.HighlightOptOutlineIcon) or "Outline and Icon",
    [7] = (ns.L and ns.L.HighlightOptCircleOutlineIcon) or "Circle, Outline and Icon",
}
local HL_ORDER = { 1, 2, 3, 4, 5, 6, 7, 0 }

function ns.Modules.HighlightSettings.Init(root)
    local cat = SettingsLib:CreateCategory(root, ns.L and ns.L.Highlights or "Highlights", false)
    
    SettingsLib:CreateHeader(cat, { name = ns.L and ns.L.Management or "Management" })
    SettingsLib:CreateText(cat, {
        text = "|cffffa500" .. (ns.L and ns.L.HighlightGlobalDesc or "Configure character highlighting dynamically throughout gameplay events.") .. "|r",
        small = true,
    })
    
    local function Refresh()
        if ns.Shared and ns.Shared.ApplyHighlight then ns.Shared.ApplyHighlight() end
    end

    SettingsLib:CreateDropdown(cat, {
        key = "highlightCombat", name = ns.L and ns.L.HighlightCombat or "Combat", values = HL_MAP, order = HL_ORDER, default = D and D.highlightCombat or 0,
        get = function() return G("highlightCombat", D and D.highlightCombat or 0) end,
        set = function(v) ns.db.highlightCombat = v; Refresh() end,
        desc = ns.L and ns.L.HighlightCombatDesc or "Highlight style applied when entering combat.",
    })
    SettingsLib:CreateDropdown(cat, {
        key = "highlightInstance", name = ns.L and ns.L.HighlightInstance or "Instance", values = HL_MAP, order = HL_ORDER, default = D and D.highlightInstance or 0,
        get = function() return G("highlightInstance", D and D.highlightInstance or 0) end,
        set = function(v) ns.db.highlightInstance = v; Refresh() end,
        desc = ns.L and ns.L.HighlightInstanceDesc or "Highlight style applied when inside a dungeon or raid.",
    })

    SettingsLib:CreateDropdown(cat, {
        key = "highlightHiddenState", name = ns.L and ns.L.HighlightHiddenState or "In Hidden State", values = HL_MAP, order = HL_ORDER, default = D and D.highlightHiddenState or 2,
        get = function() return G("highlightHiddenState", D and D.highlightHiddenState or 2) end,
        set = function(v) ns.db.highlightHiddenState = v; Refresh() end,
        desc = ns.L and ns.L.HighlightHiddenStateDesc or "Highlight style applied when any generic stealth or invisibility is active.",
    })

    if ns.IsRogue then
        SettingsLib:CreateDropdown(cat, {
            key = "highlightStealth", name = ns.L and ns.L.HighlightStealth or "In Stealth", values = HL_MAP, order = HL_ORDER, default = D and D.highlightStealth or 2,
            get = function() return G("highlightStealth", D and D.highlightStealth or 2) end,
            set = function(v) ns.db.highlightStealth = v; Refresh() end,
            desc = ns.L and ns.L.HighlightStealthDesc or "Highlight style when Stealth is active (Rogue only).",
        })
        SettingsLib:CreateDropdown(cat, {
            key = "highlightShadowDance", name = ns.L and ns.L.HighlightShadowDance or "In Shadow Dance", values = HL_MAP, order = HL_ORDER, default = D and D.highlightShadowDance or 2,
            get = function() return G("highlightShadowDance", D and D.highlightShadowDance or 2) end,
            set = function(v) ns.db.highlightShadowDance = v; Refresh() end,
            desc = ns.L and ns.L.HighlightShadowDanceDesc or "Highlight style when Shadow Dance is active (Rogue only).",
        })
        SettingsLib:CreateDropdown(cat, {
            key = "highlightSubterfuge", name = ns.L and ns.L.HighlightSubterfuge or "In Subterfuge", values = HL_MAP, order = HL_ORDER, default = D and D.highlightSubterfuge or 2,
            get = function() return G("highlightSubterfuge", D and D.highlightSubterfuge or 2) end,
            set = function(v) ns.db.highlightSubterfuge = v; Refresh() end,
            desc = ns.L and ns.L.HighlightSubterfugeDesc or "Highlight style when Subterfuge is active (Rogue only).",
        })
        SettingsLib:CreateDropdown(cat, {
            key = "highlightShroud", name = ns.L and ns.L.HighlightShroud or "In Shroud of Concealment", values = HL_MAP, order = HL_ORDER, default = D and D.highlightShroud or 2,
            get = function() return G("highlightShroud", D and D.highlightShroud or 2) end,
            set = function(v) ns.db.highlightShroud = v; Refresh() end,
            desc = ns.L and ns.L.HighlightShroudDesc or "Highlight style when inside Shroud of Concealment (Rogue only).",
        })
    end
    if ns.IsHunter then
        SettingsLib:CreateDropdown(cat, {
            key = "highlightCamouflage", name = ns.L and ns.L.HighlightCamouflage or "In Camouflage", values = HL_MAP, order = HL_ORDER, default = D and D.highlightCamouflage or 2,
            get = function() return G("highlightCamouflage", D and D.highlightCamouflage or 2) end,
            set = function(v) ns.db.highlightCamouflage = v; Refresh() end,
            desc = ns.L and ns.L.HighlightCamouflageDesc or "Highlight style when Camouflage is active (Hunter only).",
        })
    end
    if ns.IsDruid then
        SettingsLib:CreateDropdown(cat, {
            key = "highlightProwl", name = ns.L and ns.L.HighlightProwl or "In Prowl", values = HL_MAP, order = HL_ORDER, default = D and D.highlightProwl or 2,
            get = function() return G("highlightProwl", D and D.highlightProwl or 2) end,
            set = function(v) ns.db.highlightProwl = v; Refresh() end,
            desc = ns.L and ns.L.HighlightProwlDesc or "Highlight style when Prowl is active (Druid only).",
        })
    end
    if ns.IsMage then
        SettingsLib:CreateDropdown(cat, {
            key = "highlightInvisibility", name = ns.L and ns.L.HighlightInvisibility or "In Invisibility", values = HL_MAP, order = HL_ORDER, default = D and D.highlightInvisibility or 2,
            get = function() return G("highlightInvisibility", D and D.highlightInvisibility or 2) end,
            set = function(v) ns.db.highlightInvisibility = v; Refresh() end,
            desc = ns.L and ns.L.HighlightInvisibilityDesc or "Highlight style when Mage invisibility is active.",
        })
    end
    if ns.HasShadowmeld then
        SettingsLib:CreateDropdown(cat, {
            key = "highlightShadowmeld", name = ns.L and ns.L.HighlightShadowmeld or "In Shadowmeld", values = HL_MAP, order = HL_ORDER, default = D and D.highlightShadowmeld or 2,
            get = function() return G("highlightShadowmeld", D and D.highlightShadowmeld or 2) end,
            set = function(v) ns.db.highlightShadowmeld = v; Refresh() end,
            desc = ns.L and ns.L.HighlightShadowmeldDesc or "Highlight style when Shadowmeld is active (Night Elf only).",
        })
    end
end