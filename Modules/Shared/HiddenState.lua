-- ============================================================================
-- [[ SHARED: HIDDEN STATE MODULE ]] ------------------------------------------
-- ============================================================================
local addonName, ns = ...
ns.Modules = ns.Modules or {}
ns.Modules.HiddenState = {}

-- [[ INIT ]] -----------------------------------------------------------------
function ns.Modules.HiddenState.Init()
    ns.HasShadowmeld = IsSpellKnown(58984)
end

-- [[ STATE MEMORY ]] ---------------------------------------------------------
local lastAuraDef = nil
local lastAuraTime = 0

-- [[ REFRESH LOGIC ]] --------------------------------------------------------
function ns.Modules.HiddenState.RefreshVisuals(force)
    if force and ns.UI.HiddenStateFrame then ns.UI.HiddenStateFrame._needsForceRefresh = true end
    local db = ns.db
    if not db then return end

    if not db.hiddenStateEnabled then
        ns.Modules.HiddenState.HideAll()
        return
    end

    local inInstance, instanceType = IsInInstance()
    if db.hiddenStateOnlyInstances and not inInstance then
        ns.Modules.HiddenState.HideAll()
        return
    elseif inInstance then
        if instanceType == "party" and db.hiddenStateDisableInDungeons then
            ns.Modules.HiddenState.HideAll()
            return
        elseif instanceType == "raid" and db.hiddenStateDisableInRaids then
            ns.Modules.HiddenState.HideAll()
            return
        end
    end

    local stealthActive = false
    local currentText = nil
    local currentIcon = nil
    local currentColor = nil
    local currentScreenColor = nil

    local function GetText(val, fallback)
        if type(val) == "string" and val:match("%S") then return val end
        return fallback
    end

    local activeAuraDef = nil
    
    local classPrefix = (ns.IsRogue and "Rogue") or (ns.IsHunter and "Hunter") or (ns.IsDruid and "Druid") or (ns.IsMage and "Mage")
    local allToScan = {}
    if classPrefix and ns.HiddenStateMeta[classPrefix] then
        for _, a in ipairs(ns.HiddenStateMeta[classPrefix]) do
            table.insert(allToScan, a)
        end
    end
    if ns.HasShadowmeld and ns.HiddenStateMeta.Shadowmeld then
        for _, a in ipairs(ns.HiddenStateMeta.Shadowmeld) do
            table.insert(allToScan, a)
        end
    end

    for _, auraDef in ipairs(allToScan) do
        if ns.Shared.HasAura(auraDef.ids) then
            activeAuraDef = auraDef
            break
        end
    end

    -- [[ STICKY AURA LOGIC ]] ------------------------------------------------
    -- Prevents abrupt visual cuts if aura ends but player is still stealthed
    if activeAuraDef then
        lastAuraDef = activeAuraDef
        lastAuraTime = GetTime()
    elseif IsStealthed() and lastAuraDef then
        if (GetTime() - lastAuraTime) < 3.0 then
            activeAuraDef = lastAuraDef
        else
            lastAuraDef = nil
        end
    else
        lastAuraDef = nil
        lastAuraTime = 0
    end

    local text, icon, color, screenColor
    if activeAuraDef then
        local isEnabled = db["hiddenStateAura" .. activeAuraDef.key .. "Enabled"]
        if isEnabled == false then
            stealthActive = false
        else
            stealthActive = true
            text  = GetText(db["hiddenStateAura" .. activeAuraDef.key .. "Text"], activeAuraDef.text)
            icon  = db["hiddenStateAura" .. activeAuraDef.key .. "IconTexture"] or activeAuraDef.icon
            color = db["hiddenStateAura" .. activeAuraDef.key .. "TextColor"] or activeAuraDef.color
            screenColor = db["hiddenStateAura" .. activeAuraDef.key .. "ScreenColor"] or activeAuraDef.screenColor
        end
    else
        if IsStealthed() then
            stealthActive = true
            text  = GetText(db.hiddenStateCustomText, (ns.L and ns.L.HiddenStateActiveText or "HIDDEN"))
            color = db.hiddenStateTextColor or {r = 0.420, g = 0.518, b = 0.647}
            screenColor = db.hiddenStateScreenColor or {r = 0.420, g = 0.518, b = 0.647}
            if db.hiddenStateEnableIcon then
                icon = db.hiddenStateIconTexture or "Interface\\Icons\\Ability_Stealth"
            end
        end
    end

    local stealthFrame = ns.UI.HiddenStateFrame
    if not stealthFrame then return end

    if stealthFrame._lastState == stealthActive and stealthFrame._lastText == text and stealthFrame._lastIcon == icon and not stealthFrame._needsForceRefresh then
        return
    end
    stealthFrame._lastState = stealthActive
    stealthFrame._lastText = text
    stealthFrame._lastIcon = icon
    stealthFrame._needsForceRefresh = false

    local hasText = db.hiddenStateEnableText
    -- Show icon only if the main toggle is active and an icon is defined
    local hasIcon = db.hiddenStateEnableIcon and (icon ~= nil and icon ~= "")

    local showStealthMonitor = stealthActive and (hasText or hasIcon)

    if showStealthMonitor then
        stealthFrame:ClearAllPoints()
        stealthFrame:SetPoint("CENTER", UIParent, "CENTER", db.hiddenStateTextX or 0, db.hiddenStateTextY or 185)

        if hasText then
            stealthFrame.Text:SetText(text)
            stealthFrame.Text:SetFont(STANDARD_TEXT_FONT, db.hiddenStateTextSize or 28, "OUTLINE")
            local tc = color or db.hiddenStateTextColor
            stealthFrame.Text:SetTextColor(tc.r, tc.g, tc.b, db.hiddenStateTextAlpha or 1)
            stealthFrame.Text:SetAlpha(db.hiddenStateTextAlpha or 1)
            stealthFrame.Text:Show()
        else
            stealthFrame.Text:Hide()
        end
        
        if hasIcon then
            local sz = db.hiddenStateIconSize or 36
            stealthFrame.Icon:SetSize(sz, sz)
            stealthFrame.Icon:SetAlpha(db.hiddenStateIconAlpha or 1)
            stealthFrame.Icon:SetTexture(icon)
            
            if db.hiddenStateIconAnchorToText and hasText then
                stealthFrame.Icon:ClearAllPoints()
                ns.UI.AnchorIconToText(stealthFrame.Icon, stealthFrame.Text, db.hiddenStateIconAnchorPoint or "LEFT", db.hiddenStateIconX or -5, db.hiddenStateIconY or 0)
            else
                stealthFrame.Icon:ClearAllPoints()
                stealthFrame.Icon:SetPoint("CENTER", stealthFrame, "CENTER", db.hiddenStateIconX or -5, db.hiddenStateIconY or 0)
            end
            stealthFrame.Icon:Show()
        else
            stealthFrame.Icon:Hide()
        end
        
        stealthFrame:Show()
    else
        stealthFrame:Hide()
    end

    local screenFrame = ns.UI.ScreenFrame
    local vignetteFrame = ns.UI.VignetteFrame
    local screenOverlay = ns.UI.ScreenOverlay
    local vignetteEdges = ns.UI.VignetteEdges
    
    if not screenFrame or not vignetteFrame then return end

    screenFrame:SetFrameStrata(db.hiddenStateScreenStrata or "BACKGROUND") -- Set Layer
    vignetteFrame:SetFrameStrata(db.hiddenStateVignetteStrata or "BACKGROUND") -- Set Layer

    local enableScreen = stealthActive and db.hiddenStateEnableScreenColor
    if enableScreen then
        local c = screenColor or db.hiddenStateScreenColor
        local a = db.hiddenStateScreenAlpha or 0.1
        if c then screenOverlay:SetVertexColor(c.r, c.g, c.b, a) end
        screenOverlay:Show()
    else
        screenOverlay:Hide()
    end

    local enableVignette = stealthActive and db.hiddenStateEnableVignette
    if enableVignette then
        if ns.UI.BuildVignettes then ns.UI.BuildVignettes() end
        local alpha = db.hiddenStateVignetteAlpha or 0.6
        local thick = db.hiddenStateVignetteSize or 250
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

    screenFrame:SetShown(stealthActive)
end

function ns.Modules.HiddenState.HideAll()
    if ns.UI.HiddenStateFrame then
        ns.UI.HiddenStateFrame:Hide()
        ns.UI.HiddenStateFrame._lastState = false
    end
    if ns.UI.ScreenOverlay then ns.UI.ScreenOverlay:Hide() end
    if ns.UI.VignetteEdges then
        for _, edge in pairs(ns.UI.VignetteEdges) do if edge then edge:Hide() end end
    end
    if ns.UI.ScreenFrame then ns.UI.ScreenFrame:Hide() end
end

ns.RefreshVisuals = ns.Modules.HiddenState.RefreshVisuals
