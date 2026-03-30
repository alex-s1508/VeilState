-- ============================================================================
-- [[ HUNTER: CAMOUFLAGE MODULE ]] --------------------------------------------
-- ============================================================================
local addonName, ns = ...
ns.Modules = ns.Modules or {}
ns.Modules.Camouflage = {}

ns.HiddenStateMeta = ns.HiddenStateMeta or {}
ns.HiddenStateMeta.Hunter = {
    { key = "Camouflage", name = ns.L and ns.L.SkillCamouflage or "Camouflage", ids = {199483}, text = ns.L and ns.L.CamouflageActiveText or "CAMOUFLAGED", color = {r = 0.478, g = 0.878, b = 0.267}, screenColor = {r = 0.478, g = 0.878, b = 0.267}, icon = "Interface\\Icons\\Ability_Hunter_Camouflage" },
}

ns.Modules.Camouflage.Init = function()
end
