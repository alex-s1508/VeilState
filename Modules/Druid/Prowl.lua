-- ============================================================================
-- [[ DRUID: PROWL MODULE ]] --------------------------------------------------
-- ============================================================================
local addonName, ns = ...
ns.Modules = ns.Modules or {}
ns.Modules.Prowl = {}

ns.HiddenStateMeta = ns.HiddenStateMeta or {}
ns.HiddenStateMeta.Druid = {
    { key = "Prowl", name = ns.L and ns.L.SkillProwl or "Prowl", ids = {5215}, text = ns.L and ns.L.ProwlActiveText or "PROWLED", color = {r = 0.055, g = 0.027, b = 0.749}, screenColor = {r = 0.055, g = 0.027, b = 0.749}, icon = "Interface\\Icons\\Ability_Druid_Prowl" },
}

ns.Modules.Prowl.Init = function()
end
