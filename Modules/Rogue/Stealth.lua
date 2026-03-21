-- ============================================================================
-- [[ NIGHTVEIL — ROGUE: STEALTH MODULE ]] -----------------------------------
-- ============================================================================
local addonName, ns = ...
ns.Modules = ns.Modules or {}
ns.Modules.Stealth = {}

-- [[ VISUAL REFRESH LOGIC ]] -------------------------------------------------

function ns.Modules.Stealth.RefreshVisuals(force)
    if force then ns.UI.StealthFrame._needsForceRefresh = true end
    local db = ns.db
    if not db then return end

    local hasVanish = ns.Shared.HasAura({11327})
    local stealthActive = false

    if db.useStateDetection then
        stealthActive = IsStealthed()
    else
        local hasStealth = ns.Shared.HasAura({1784})
        stealthActive = (hasStealth or hasVanish)
    end

    stealthActive = stealthActive and db.stealthEnabled
    if stealthActive then
        local inInstance, instanceType = IsInInstance()
        if db.stealthOnlyInstances and not inInstance then
            stealthActive = false
        elseif inInstance then
            if instanceType == "party" and db.stealthDisableInDungeons then
                stealthActive = false
            elseif instanceType == "raid" and db.stealthDisableInRaids then
                stealthActive = false
            end
        end
    end

    local stealthFrame = ns.UI.StealthFrame
    if stealthFrame._lastState == stealthActive and stealthFrame._lastVanish == hasVanish and not stealthFrame._needsForceRefresh then
        return
    end
    stealthFrame._lastState = stealthActive
    stealthFrame._lastVanish = hasVanish
    stealthFrame._needsForceRefresh = false

    local hasText = db.stealthEnableText
    local hasIcon = db.stealthEnableIcon
    local showStealthMonitor = stealthActive and (hasText or hasIcon)

    if showStealthMonitor then
        stealthFrame:ClearAllPoints()
        stealthFrame:SetPoint("CENTER", UIParent, "CENTER", db.stealthTextX or 0, db.stealthTextY or 185)

        if hasText then
            local text = db.stealthCustomText or (ns.L and ns.L.StealthActiveText or "STEALTHED")
            stealthFrame.Text:SetText(text)
            stealthFrame.Text:SetFont(STANDARD_TEXT_FONT, db.stealthTextSize or 28, "OUTLINE")
            local tc = db.stealthTextColor or {r=1, g=1, b=1}
            stealthFrame.Text:SetTextColor(tc.r, tc.g, tc.b, db.stealthTextAlpha or 1)
            stealthFrame.Text:SetAlpha(db.stealthTextAlpha or 1)
            stealthFrame.Text:Show()
        else
            stealthFrame.Text:Hide()
        end
        
        if hasIcon then
            local sz = db.stealthIconSize or 36
            stealthFrame.Icon:SetSize(sz, sz)
            stealthFrame.Icon:SetAlpha(db.stealthIconAlpha or 1)
            
            local iconTexture = "Interface\\Icons\\Ability_Stealth"
            if hasVanish then
                iconTexture = "Interface\\Icons\\Ability_Vanish"
            end
            stealthFrame.Icon:SetTexture(iconTexture)
            if db.stealthIconAnchorToText and hasText then
                stealthFrame.Icon:ClearAllPoints()
                ns.UI.AnchorIconToText(stealthFrame.Icon, stealthFrame.Text, db.stealthIconAnchorPoint or "LEFT", db.stealthIconX or 5, db.stealthIconY or 0)
            else
                stealthFrame.Icon:ClearAllPoints()
                stealthFrame.Icon:SetPoint("CENTER", stealthFrame, "CENTER", db.stealthIconX or 5, db.stealthIconY or 0)
            end
            stealthFrame.Icon:Show()
        else
            stealthFrame.Icon:Hide()
        end
        
        stealthFrame:Show()
    else
        stealthFrame:Hide()
    end

    local anyActive = stealthActive
    
    local screenFrame = ns.UI.ScreenFrame
    local vignetteFrame = ns.UI.VignetteFrame
    local screenOverlay = ns.UI.ScreenOverlay
    local vignetteEdges = ns.UI.VignetteEdges
    
    screenFrame:SetFrameStrata(db.stealthScreenStrata or "BACKGROUND")
    vignetteFrame:SetFrameStrata(db.stealthVignetteStrata or "BACKGROUND")

    local enableScreen = stealthActive and db.stealthEnableScreenColor
    if anyActive and enableScreen then
        local c = db.stealthScreenColor
        local a = db.stealthScreenAlpha
        if c then screenOverlay:SetVertexColor(c.r, c.g, c.b, a or 0.3) end
        screenOverlay:Show()
    else
        screenOverlay:Hide()
    end

    local enableVignette = stealthActive and db.stealthEnableVignette
    if anyActive and enableVignette then
        ns.UI.BuildVignettes()
        local alpha = db.stealthVignetteAlpha or 0.5
        local thick = db.stealthVignetteSize or 150
        local solid = CreateColor(0, 0, 0, alpha)
        local clear = CreateColor(0, 0, 0, 0)
        vignetteEdges.top:SetHeight(thick);         vignetteEdges.top:SetGradient("VERTICAL", clear, solid)
        vignetteEdges.bottom:SetHeight(thick);      vignetteEdges.bottom:SetGradient("VERTICAL", solid, clear)
        vignetteEdges.left:SetWidth(thick + 100);   vignetteEdges.left:SetGradient("HORIZONTAL", solid, clear)
        vignetteEdges.right:SetWidth(thick + 100);  vignetteEdges.right:SetGradient("HORIZONTAL", clear, solid)
        for _, edge in pairs(vignetteEdges) do edge:Show() end
    else
        for _, edge in pairs(vignetteEdges) do if edge then edge:Hide() end end
    end

    screenFrame:SetShown(anyActive)

end

-- ============================================================================
-- [[ INITIALIZATION & EXPORTS ]] ---------------------------------------------
-- ============================================================================
ns.Modules.Stealth.Init = function()
end

ns.RefreshVisuals = ns.Modules.Stealth.RefreshVisuals
