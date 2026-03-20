-- ============================================================================
-- [[ NIGHTVEIL — SHARED: STEALTH STATE MODULE ]] ----------------------------
-- ============================================================================
local addonName, ns = ...
ns.Modules = ns.Modules or {}
ns.Modules.StealthState = {}

-- [[ REFRESH LOGIC ]] --------------------------------------------------------

function ns.Modules.StealthState.RefreshVisuals(force)
    if force then ns.UI.StealthFrame._needsForceRefresh = true end
    local db = ns.db
    if not db then return end

    local stealthActive = IsStealthed()

    stealthActive = stealthActive and db.stealthStateEnabled
    if stealthActive then
        local inInstance, instanceType = IsInInstance()
        if db.stealthStateOnlyInstances and not inInstance then
            stealthActive = false
        elseif inInstance then
            if instanceType == "party" and db.stealthStateDisableInDungeons then
                stealthActive = false
            elseif instanceType == "raid" and db.stealthStateDisableInRaids then
                stealthActive = false
            end
        end
    end

    local stealthFrame = ns.UI.StealthFrame
    if not stealthFrame then return end

    if stealthFrame._lastState == stealthActive and not stealthFrame._needsForceRefresh then
        return
    end
    stealthFrame._lastState = stealthActive
    stealthFrame._needsForceRefresh = false

    local hasText = db.stealthStateEnableText
    local hasIcon = db.stealthStateEnableIcon
    local showStealthMonitor = stealthActive and (hasText or hasIcon)

    if showStealthMonitor then
        stealthFrame:ClearAllPoints()
        stealthFrame:SetPoint("CENTER", UIParent, "CENTER", db.stealthStateTextX or 0, db.stealthStateTextY or 185)

        if hasText then
            local text = db.stealthStateCustomText or (ns.L and ns.L.StealthStateActiveText or "STEALTH STATE")
            stealthFrame.Text:SetText(text)
            stealthFrame.Text:SetFont(STANDARD_TEXT_FONT, db.stealthStateTextSize or 28, "OUTLINE")
            local tc = db.stealthStateTextColor or {r=0.420, g=0.518, b=0.647}
            stealthFrame.Text:SetTextColor(tc.r, tc.g, tc.b, db.stealthStateTextAlpha or 1)
            stealthFrame.Text:SetAlpha(db.stealthStateTextAlpha or 1)
            stealthFrame.Text:Show()
        else
            stealthFrame.Text:Hide()
        end
        
        if hasIcon then
            local sz = db.stealthStateIconSize or 36
            stealthFrame.Icon:SetSize(sz, sz)
            stealthFrame.Icon:SetAlpha(db.stealthStateIconAlpha or 1)
            
            local iconTexture = db.stealthStateIconTexture or "Interface\\Icons\\Ability_Stealth"
            stealthFrame.Icon:SetTexture(iconTexture)
            
            if db.stealthStateIconAnchorToText and hasText then
                stealthFrame.Icon:ClearAllPoints()
                ns.UI.AnchorIconToText(stealthFrame.Icon, stealthFrame.Text, db.stealthStateIconAnchorPoint or "LEFT", db.stealthStateIconX or -5, db.stealthStateIconY or 0)
            else
                stealthFrame.Icon:ClearAllPoints()
                stealthFrame.Icon:SetPoint("CENTER", stealthFrame, "CENTER", db.stealthStateIconX or -5, db.stealthStateIconY or 0)
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
    
    if not screenFrame or not vignetteFrame then return end

    screenFrame:SetFrameStrata(db.stealthStateScreenStrata or "BACKGROUND")
    vignetteFrame:SetFrameStrata(db.stealthStateVignetteStrata or "BACKGROUND")

    local enableScreen = stealthActive and db.stealthStateEnableScreenColor
    if anyActive and enableScreen then
        local c = db.stealthStateScreenColor or {r=0.420, g=0.518, b=0.647}
        local a = db.stealthStateScreenAlpha or 0.1
        if c then screenOverlay:SetVertexColor(c.r, c.g, c.b, a) end
        screenOverlay:Show()
    else
        screenOverlay:Hide()
    end

    local enableVignette = stealthActive and db.stealthStateEnableVignette
    if anyActive and enableVignette then
        if ns.UI.BuildVignettes then ns.UI.BuildVignettes() end
        local alpha = db.stealthStateVignetteAlpha or 0.6
        local thick = db.stealthStateVignetteSize or 250
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
-- [[ INITIALIZATION ]] -------------------------------------------------------
-- ============================================================================
ns.Modules.StealthState.Init = function()
end
