local addonName, ns = ...

SLASH_NIGHTVEIL1 = "/veil"

function Nightveil_OnAddonCompartmentClick()
    if ns.MainCategory then
        Settings.OpenToCategory(ns.MainCategory:GetID())
    end
end

SlashCmdList["NIGHTVEIL"] = function()
    if ns.MainCategory then
        Settings.OpenToCategory(ns.MainCategory:GetID())
    end
end
