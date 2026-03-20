-- ============================================================================
-- [[ NIGHTVEIL — EVENT SYSTEM ]] --------------------------------------------
-- ============================================================================
local addonName, ns = ...

-- [[ EVENT REGISTRATION & ROUTING ]] -----------------------------------------
ns.frame:RegisterEvent("ADDON_LOADED")
ns.frame:RegisterEvent("PLAYER_ENTERING_WORLD")
ns.frame:RegisterEvent("PLAYER_LEAVING_WORLD")
ns.frame:RegisterEvent("ZONE_CHANGED_NEW_AREA")
ns.frame:RegisterEvent("UNIT_AURA")
ns.frame:RegisterEvent("PLAYER_REGEN_DISABLED")
ns.frame:RegisterEvent("PLAYER_REGEN_ENABLED")
ns.frame:RegisterEvent("GROUP_ROSTER_UPDATE")
ns.frame:RegisterEvent("PLAYER_ROLES_ASSIGNED")
ns.frame:RegisterEvent("PLAYER_FOCUS_CHANGED")
ns.frame:RegisterEvent("PLAYER_TARGET_CHANGED")
ns.frame:RegisterEvent("UNIT_TARGET")
ns.frame:RegisterEvent("SPELLS_CHANGED")

ns.frame:SetScript("OnEvent", function(self, event, arg1, ...)
    if event == "ADDON_LOADED" and arg1 == addonName then
        ns.frame:RegisterEvent("UPDATE_STEALTH")
        local verResult = "OK"
        if ns.Shared.InitProfile then 
            verResult = ns.Shared.InitProfile() 
            if verResult == "WAITING" then return end
        end

        local _, _, classId = UnitClass("player")
        ns.IsRogue  = (classId == 4)
        ns.IsHunter = (classId == 3)

        ns.KnowsTricks = IsPlayerSpell and IsPlayerSpell(57934) or (GetSpellInfo and GetSpellInfo(57934) ~= nil)
        ns.KnowsMisdir = IsPlayerSpell and IsPlayerSpell(34477) or (GetSpellInfo and GetSpellInfo(34477) ~= nil)

        if ns.Modules.Settings and ns.Modules.Settings.Init then
            ns.Modules.Settings.Init()
        end
        if verResult == "FRESH" then
            print(string.format(ns.L and ns.L.WelcomeMessage or "Welcome to %s v%s", ns.Shared.GetAddonName(), ns.Version))
        elseif verResult == "UPDATED" then
            print(string.format(ns.L and ns.L.UpdateMessage or "%s updated to v%s", ns.Shared.GetAddonName(), ns.Version))
        end

        if ns.Shared.RecoverState then ns.Shared.RecoverState() end

        if ns.IsRogue then
            if ns.Modules.Tricks and ns.Modules.Tricks.UpdateMacro then
                ns.Modules.Tricks.UpdateMacro(true)
            end
        elseif ns.IsHunter then
            if ns.Modules.Misdirection and ns.Modules.Misdirection.UpdateMacro then
                ns.Modules.Misdirection.UpdateMacro(true)
            end
        end
    elseif event == "UNIT_AURA" then
        if arg1 == "player" then 
            if ns.Modules.Shroud and ns.Modules.Shroud.Check then ns.Modules.Shroud.Check() end
            ns.UpdateState()
        end
    elseif event == "PLAYER_LEAVING_WORLD" then
        if ns.Shared.RestoreOriginalHighlight then
            ns.Shared.RestoreOriginalHighlight()
        end
        if ns.IsRogue then
            if ns.Modules.Stealth and ns.Modules.Stealth.RefreshVisuals then ns.Modules.Stealth.RefreshVisuals(true) end
        elseif ns.IsHunter then
            if ns.Modules.Camouflage and ns.Modules.Camouflage.RefreshVisuals then ns.Modules.Camouflage.RefreshVisuals(true) end
        else
            if ns.Modules.StealthState and ns.Modules.StealthState.RefreshVisuals then ns.Modules.StealthState.RefreshVisuals(true) end
        end
    elseif event == "PLAYER_ENTERING_WORLD" or event == "ZONE_CHANGED_NEW_AREA" or event == "PLAYER_REGEN_DISABLED" or event == "PLAYER_REGEN_ENABLED" then
        ns.UpdateState()
        if ns.Modules.Shroud and ns.Modules.Shroud.Check then ns.Modules.Shroud.Check() end
        if ns.Modules.Poisons and ns.Modules.Poisons.RefreshVisuals then ns.Modules.Poisons.RefreshVisuals() end

        if ns.IsRogue then
            if ns.tricksUpdateQueued and ns.Modules.Tricks and ns.Modules.Tricks.UpdateMacro then
                ns.Modules.Tricks.UpdateMacro()
            end
        elseif ns.IsHunter then
            if ns.misdirUpdateQueued and ns.Modules.Misdirection and ns.Modules.Misdirection.UpdateMacro then
                ns.Modules.Misdirection.UpdateMacro()
            end
        end
    elseif event == "GROUP_ROSTER_UPDATE" or event == "PLAYER_ROLES_ASSIGNED" or event == "PLAYER_FOCUS_CHANGED" or event == "PLAYER_TARGET_CHANGED" or (event == "UNIT_TARGET" and arg1 and (arg1:find("party") or arg1:find("raid") or arg1 == "focus")) then
        if ns.IsRogue then
            local now = GetTime()
            if now - (ns.tricksLastEventTime or 0) > 0.1 then
                ns.tricksLastEventTime = now
                if ns.Modules.Tricks and ns.Modules.Tricks.UpdateMacro then ns.Modules.Tricks.UpdateMacro() end
            end
        elseif ns.IsHunter then
            local now = GetTime()
            if now - (ns.misdirLastEventTime or 0) > 0.1 then
                ns.misdirLastEventTime = now
                if ns.Modules.Misdirection and ns.Modules.Misdirection.UpdateMacro then ns.Modules.Misdirection.UpdateMacro() end
            end
        end
    elseif event == "UPDATE_STEALTH" or event == "SPELLS_CHANGED" then
        if ns.IsRogue then
            ns.KnowsTricks = IsPlayerSpell and IsPlayerSpell(57934) or (GetSpellInfo and GetSpellInfo(57934) ~= nil)
            if ns.KnowsTricks and ns.Modules.Tricks and ns.Modules.Tricks.UpdateMacro then
                ns.Modules.Tricks.UpdateMacro(true)
            end
        elseif ns.IsHunter then
            ns.KnowsMisdir = IsPlayerSpell and IsPlayerSpell(34477) or (GetSpellInfo and GetSpellInfo(34477) ~= nil)
            if ns.KnowsMisdir and ns.Modules.Misdirection and ns.Modules.Misdirection.UpdateMacro then
                ns.Modules.Misdirection.UpdateMacro(true)
            end
        end
        ns.UpdateState()
    else
        ns.UpdateState()
    end
end)
