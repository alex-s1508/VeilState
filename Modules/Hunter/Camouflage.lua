-- ============================================================================
-- [[ NIGHTVEIL — HUNTER: CAMOUFLAGE MODULE ]] --------------------------------
-- ============================================================================
local addonName, ns = ...
ns.Modules = ns.Modules or {}
ns.Modules.Camouflage = {}

-- [[ VISUAL REFRESH LOGIC ]] -------------------------------------------------

function ns.Modules.Camouflage.RefreshVisuals(force)
    if force then ns.UI.StealthFrame._needsForceRefresh = true end
    local db = ns.db
    if not db then return end

    local camouflageActive = false

    if db.useStateDetection then
        camouflageActive = IsStealthed()
    else
        camouflageActive = ns.Shared.HasAura({199483})
    end

    camouflageActive = camouflageActive and db.camouflageEnabled
    if camouflageActive then
        local inInstance, instanceType = IsInInstance()
        if db.camouflageOnlyInstances and not inInstance then
            camouflageActive = false
        elseif inInstance then
            if instanceType == "party" and db.camouflageDisableInDungeons then
                camouflageActive = false
            elseif instanceType == "raid" and db.camouflageDisableInRaids then
                camouflageActive = false
            end
        end
    end

    local stealthFrame = ns.UI.StealthFrame
    if stealthFrame._lastState == camouflageActive and not stealthFrame._needsForceRefresh then
        return
    end
    stealthFrame._lastState = camouflageActive
    stealthFrame._needsForceRefresh = false

    local hasText = db.camouflageEnableText
    local hasIcon = db.camouflageEnableIcon
    local showMonitor = camouflageActive and (hasText or hasIcon)

    if showMonitor then
        stealthFrame:ClearAllPoints()
        stealthFrame:SetPoint("CENTER", UIParent, "CENTER", db.camouflageTextX or 0, db.camouflageTextY or 185)

        if hasText then
            local text = db.camouflageCustomText or (ns.L and ns.L.CamouflageActiveText or "CAMOUFLAGED")
            stealthFrame.Text:SetText(text)
            stealthFrame.Text:SetFont(STANDARD_TEXT_FONT, db.camouflageTextSize or 32, "OUTLINE")
            local tc = db.camouflageTextColor or {r = 0.478, g = 0.878, b = 0.267}
            stealthFrame.Text:SetTextColor(tc.r, tc.g, tc.b, db.camouflageTextAlpha or 1)
            stealthFrame.Text:SetAlpha(db.camouflageTextAlpha or 1)
            stealthFrame.Text:Show()
        else
            stealthFrame.Text:Hide()
        end

        if hasIcon then
            local sz = db.camouflageIconSize or 64
            stealthFrame.Icon:SetSize(sz, sz)
            stealthFrame.Icon:SetAlpha(db.camouflageIconAlpha or 1)
            stealthFrame.Icon:SetTexture("Interface\\Icons\\Ability_Hunter_Camouflage")
            if db.camouflageIconAnchorToText and hasText then
                stealthFrame.Icon:ClearAllPoints()
                ns.UI.AnchorIconToText(stealthFrame.Icon, stealthFrame.Text, db.camouflageIconAnchorPoint or "LEFT", db.camouflageIconX or 5, db.camouflageIconY or 0)
            else
                stealthFrame.Icon:ClearAllPoints()
                stealthFrame.Icon:SetPoint("CENTER", stealthFrame, "CENTER", db.camouflageIconX or 0, db.camouflageIconY or 0)
            end
            stealthFrame.Icon:Show()
        else
            stealthFrame.Icon:Hide()
        end

        stealthFrame:Show()
    else
        stealthFrame:Hide()
    end

    local screenFrame   = ns.UI.ScreenFrame
    local vignetteFrame = ns.UI.VignetteFrame
    local screenOverlay = ns.UI.ScreenOverlay
    local vignetteEdges = ns.UI.VignetteEdges

    screenFrame:SetFrameStrata(db.camouflageScreenStrata or "BACKGROUND")
    vignetteFrame:SetFrameStrata(db.camouflageVignetteStrata or "BACKGROUND")

    local enableScreen = camouflageActive and db.camouflageEnableScreenColor
    if enableScreen then
        local c = db.camouflageScreenColor
        local a = db.camouflageScreenAlpha
        if c then screenOverlay:SetVertexColor(c.r, c.g, c.b, a or 0.1) end
        screenOverlay:Show()
    else
        screenOverlay:Hide()
    end

    local enableVignette = camouflageActive and db.camouflageEnableVignette
    if enableVignette then
        ns.UI.BuildVignettes()
        local alpha = db.camouflageVignetteAlpha or 0.6
        local thick = db.camouflageVignetteSize or 250
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

    screenFrame:SetShown(camouflageActive)
end

-- ============================================================================
-- [[ INITIALIZATION & EXPORTS ]] ---------------------------------------------
-- ============================================================================
ns.Modules.Camouflage.Init = function()
end
