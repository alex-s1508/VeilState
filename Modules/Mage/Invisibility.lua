-- ============================================================================
-- [[ MAGE: INVISIBILITY MODULE ]] -------------------------------------------
-- ============================================================================
local addonName, ns = ...

ns.HiddenStateMeta = ns.HiddenStateMeta or {}
ns.HiddenStateMeta.Mage = {
    { key = "Invisibility", name = ns.L and ns.L.SkillInvisibility or "Invisibility", ids = {66, 32612}, text = ns.L and ns.L.InvisibilityActiveText or "INVISIBLE", color = {r = 0.620, g = 1.0, b = 1.0}, screenColor = {r = 0.620, g = 1.0, b = 1.0}, icon = "Interface\\Icons\\Ability_Mage_Invisibility" },
    { key = "GreaterInvisibility", name = ns.L and ns.L.SkillGreaterInvis or "Greater Invisibility", ids = {110960}, text = ns.L and ns.L.InvisibilityActiveText or "INVISIBLE", color = {r = 0.635, g = 0.725, b = 0.976}, screenColor = {r = 0.635, g = 0.725, b = 0.976}, icon = "Interface\\Icons\\Ability_Mage_GreaterInvisibility" },
    { key = "MassInvisibility", name = ns.L and ns.L.SkillMassInvis or "Mass Invisibility", ids = {414664}, text = ns.L and ns.L.InvisibilityActiveText or "INVISIBLE", color = {r = 0.898, g = 0.722, b = 1.0}, screenColor = {r = 0.898, g = 0.722, b = 1.0}, icon = "Interface\\Icons\\Ability_Mage_MassInvisibility" },
}
