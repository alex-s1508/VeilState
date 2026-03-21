-- ============================================================================
-- [[ NIGHTVEIL — DRUID: PROWL MODULE ]] --------------------------------------
-- ============================================================================
local addonName, ns = ...
ns.Modules = ns.Modules or {}
ns.Modules.Prowl = {}

-- [[ VISUAL REFRESH LOGIC ]] -------------------------------------------------

function ns.Modules.Prowl.RefreshVisuals(force)
    if force then ns.UI.StealthFrame._needsForceRefresh = true end
    local db = ns.db
    if not db then return end

    local prowlActive = false

    if db.useStateDetection then
        prowlActive = IsStealthed()
    else
        prowlActive = ns.Shared.HasAura({5215})
    end

    prowlActive = prowlActive and db.prowlEnabled
    if prowlActive then
        local inInstance, instanceType = IsInInstance()
        if db.prowlOnlyInstances and not inInstance then
            prowlActive = false
        elseif inInstance then
            if instanceType == "party" and db.prowlDisableInDungeons then
                prowlActive = false
            elseif instanceType == "raid" and db.prowlDisableInRaids then
                prowlActive = false
            end
        end
    end

    local stealthFrame = ns.UI.StealthFrame
    if stealthFrame._lastState == prowlActive and not stealthFrame._needsForceRefresh then
        return
    end
    stealthFrame._lastState = prowlActive
    stealthFrame._needsForceRefresh = false

    local hasText = db.prowlEnableText
    local hasIcon = db.prowlEnableIcon
    local showMonitor = prowlActive and (hasText or hasIcon)

    if showMonitor then
        stealthFrame:ClearAllPoints()
        stealthFrame:SetPoint("CENTER", UIParent, "CENTER", db.prowlTextX or 0, db.prowlTextY or 185)

        if hasText then
            local text = db.prowlCustomText or (ns.L and ns.L.ProwlActiveText or "PROWLED")
            stealthFrame.Text:SetText(text)
            stealthFrame.Text:SetFont(STANDARD_TEXT_FONT, db.prowlTextSize or 32, "OUTLINE")
            local tc = db.prowlTextColor or {r = 0.055, g = 0.027, b = 0.749}
            stealthFrame.Text:SetTextColor(tc.r, tc.g, tc.b, db.prowlTextAlpha or 1)
            stealthFrame.Text:SetAlpha(db.prowlTextAlpha or 1)
            stealthFrame.Text:Show()
        else
            stealthFrame.Text:Hide()
        end

        if hasIcon then
            local sz = db.prowlIconSize or 64
            stealthFrame.Icon:SetSize(sz, sz)
            stealthFrame.Icon:SetAlpha(db.prowlIconAlpha or 1)
            stealthFrame.Icon:SetTexture("Interface\\Icons\\Ability_Druid_Prol")
            if db.prowlIconAnchorToText and hasText then
                stealthFrame.Icon:ClearAllPoints()
                ns.UI.AnchorIconToText(stealthFrame.Icon, stealthFrame.Text, db.prowlIconAnchorPoint or "LEFT", db.prowlIconX or 5, db.prowlIconY or 0)
            else
                stealthFrame.Icon:ClearAllPoints()
                stealthFrame.Icon:SetPoint("CENTER", stealthFrame, "CENTER", db.prowlIconX or 0, db.prowlIconY or 0)
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

    screenFrame:SetFrameStrata(db.prowlScreenStrata or "BACKGROUND")
    vignetteFrame:SetFrameStrata(db.prowlVignetteStrata or "BACKGROUND")

    local enableScreen = prowlActive and db.prowlEnableScreenColor
    if enableScreen then
        local c = db.prowlScreenColor
        local a = db.prowlScreenAlpha
        if c then screenOverlay:SetVertexColor(c.r, c.g, c.b, a or 0.1) end
        screenOverlay:Show()
    else
        screenOverlay:Hide()
    end

    local enableVignette = prowlActive and db.prowlEnableVignette
    if enableVignette then
        ns.UI.BuildVignettes()
        local alpha = db.prowlVignetteAlpha or 0.6
        local thick = db.prowlVignetteSize or 250
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

    screenFrame:SetShown(prowlActive)
end

-- ============================================================================
-- [[ INITIALIZATION & EXPORTS ]] ---------------------------------------------
-- ============================================================================
ns.Modules.Prowl.Init = function()
end
