-- ============================================================================
-- [[ ROGUE: STEALTH MODULE ]] ------------------------------------------------
-- ============================================================================
local addonName, ns = ...
ns.Modules = ns.Modules or {}
ns.Modules.Stealth = {}

ns.HiddenStateMeta = ns.HiddenStateMeta or {}
ns.HiddenStateMeta.Rogue = {
    { key = "Stealth",     name = ns.L and ns.L.SkillStealth or "Stealth",           ids = {1784},   text = ns.L and ns.L.StealthActiveText or "STEALTHED", color = {r=0.420, g=0.518, b=0.647}, screenColor = {r=0.420, g=0.518, b=0.647}, icon = "Interface\\Icons\\Ability_Stealth" },
    { key = "Subterfuge",  name = ns.L and ns.L.SkillSubterfuge or "Subterfuge",     ids = {115192, 115191, 108208}, text = ns.L and ns.L.StealthActiveText or "STEALTHED", color = {r=0.270, g=0.352, b=0.505}, screenColor = {r=0.270, g=0.352, b=0.505}, icon = "Interface\\Icons\\Rogue_Subterfuge" },
    { key = "Vanish",      name = ns.L and ns.L.SkillVanish or "Vanish",             ids = {11327},  text = ns.L and ns.L.StealthActiveText or "STEALTHED", color = {r=0.420, g=0.518, b=0.647}, screenColor = {r=0.420, g=0.518, b=0.647}, icon = "Interface\\Icons\\Ability_Vanish" },
    { key = "ShadowDance", name = ns.L and ns.L.SkillShadowDance or "Shadow Dance", ids = {185422, 185313, 212283}, text = (ns.L and ns.L.SkillShadowDance and string.upper(ns.L.SkillShadowDance)) or "SHADOW DANCE", color = {r=0.560, g=0.105, b=0.192}, screenColor = {r=0.560, g=0.105, b=0.192}, icon = "Interface\\Icons\\Ability_Rogue_ShadowDance" },
}

ns.Modules.Stealth.Init = function()
end
