-- ============================================================================
-- [[ SHARED: SHADOWMELD META ]] ----------------------------------------------
-- ============================================================================
local addonName, ns = ...

ns.HiddenStateMeta = ns.HiddenStateMeta or {}
ns.HiddenStateMeta.Shadowmeld = {
    { key = "Shadowmeld", name = ns.L and ns.L.SkillShadowmeld or "Shadowmeld", ids = {58984}, text = ns.L and ns.L.HiddenStateActiveText or "HIDDEN", color = {r = 0.427, g = 0.251, b = 0.616}, screenColor = {r = 0.427, g = 0.251, b = 0.616}, icon = "Interface\\Icons\\Ability_Ambush" },
}
