local addonName, ns = ...

-- [[ UI Frame Creation & Helper Functions ]] ---------------------------------
local function CreateTrackerFrame(name, label)
    local f = CreateFrame("Frame", name, UIParent)
    f:SetSize(200, 50)
    f:Hide()
    f.editModeName = label
    
    local text = f:CreateFontString(nil, "OVERLAY", "GameFontHighlightHuge")
    text:SetShadowOffset(2, -2)
    text:SetShadowColor(0, 0, 0, 0.8)
    text:SetPoint("CENTER", f, "CENTER")
    f.Text = text
    
    local icon = f:CreateTexture(nil, "OVERLAY")
    icon:SetSize(36, 36)
    f.Icon = icon
    
    return f
end

-- [[ Static UI Element Definitions ]] ---------------------------------------
local stealthFrame = CreateTrackerFrame("NV_StealthFrame", ns.L.Stealth or "Stealth")

local screenFrame = CreateFrame("Frame", "VS_ScreenFrame", UIParent)
screenFrame:SetAllPoints(UIParent)
screenFrame:Hide()

local screenOverlay = screenFrame:CreateTexture(nil, "BACKGROUND")
screenOverlay:SetAllPoints(UIParent)
screenOverlay:SetTexture("Interface\\Buttons\\WHITE8X8")

local vignetteFrame = CreateFrame("Frame", "VS_VignetteFrame", screenFrame)
vignetteFrame:SetAllPoints(UIParent)

local vignetteEdges = {}

local function BuildVignettes()
    if vignetteEdges.top then return end
    local function MakeEdge(anchor)
        local t = vignetteFrame:CreateTexture(nil, "BACKGROUND")
        t:SetTexture("Interface\\Buttons\\WHITE8X8")
        t:SetPoint(anchor)
        return t
    end
    vignetteEdges.top    = MakeEdge("TOPLEFT");    vignetteEdges.top:SetPoint("TOPRIGHT")
    vignetteEdges.bottom = MakeEdge("BOTTOMLEFT"); vignetteEdges.bottom:SetPoint("BOTTOMRIGHT")
    vignetteEdges.left   = MakeEdge("TOPLEFT");    vignetteEdges.left:SetPoint("BOTTOMLEFT")
    vignetteEdges.right  = MakeEdge("TOPRIGHT");   vignetteEdges.right:SetPoint("BOTTOMRIGHT")
end

-- [[ Advanced UI Anchoring & Positioning ]] ---------------------------------
local function AnchorIconToText(icon, text, anchorPoint, x, y)
    if not icon or not text then return end
    local p = anchorPoint or "LEFT"
    local xV = tonumber(x) or 0
    local yV = tonumber(y) or 0

    if p == "LEFT" then
        icon:SetPoint("RIGHT", text, "LEFT", xV, yV)
    elseif p == "RIGHT" then
        icon:SetPoint("LEFT", text, "RIGHT", xV, yV)
    elseif p == "TOP" then
        icon:SetPoint("BOTTOM", text, "TOP", xV, yV)
    elseif p == "BOTTOM" then
        icon:SetPoint("TOP", text, "BOTTOM", xV, yV)
    elseif p == "TOPLEFT" then
        icon:SetPoint("BOTTOMRIGHT", text, "TOPLEFT", xV, yV)
    elseif p == "TOPRIGHT" then
        icon:SetPoint("BOTTOMLEFT", text, "TOPRIGHT", xV, yV)
    elseif p == "BOTTOMLEFT" then
        icon:SetPoint("TOPRIGHT", text, "BOTTOMLEFT", xV, yV)
    elseif p == "BOTTOMRIGHT" then
        icon:SetPoint("TOPLEFT", text, "BOTTOMRIGHT", xV, yV)
    else
        icon:SetPoint("CENTER", text, "CENTER", xV, yV)
    end
end

-- [[ Stealth Visual Update Controller ]] -------------------------------------
function ns.RefreshVisuals(force)
    if force then stealthFrame._needsForceRefresh = true end
    local db = ns.db
    if not db then return end

    local hasStealth = ns.HasAura({1784})
    local hasVanish = ns.HasAura({11327})
    local stealthActive = (hasStealth or hasVanish) and db.stealthEnabled
    if stealthActive and db.stealthOnlyInstances and not ns.IsInInstance() then
        stealthActive = false
    end

    if stealthFrame._lastState == stealthActive and not stealthFrame._needsForceRefresh then
        return
    end
    stealthFrame._lastState = stealthActive
    stealthFrame._needsForceRefresh = false

    local hasText = db.stealthEnableText
    local hasIcon = db.stealthEnableIcon
    local showStealthMonitor = stealthActive and (hasText or hasIcon)

    if showStealthMonitor then
        stealthFrame:ClearAllPoints()
        stealthFrame:SetPoint("CENTER", UIParent, "CENTER", db.stealthTextX or 0, db.stealthTextY or 185)

        if hasText then
            local text = db.stealthCustomText or ns.L.DefaultMessage
            stealthFrame.Text:SetText(text)
            stealthFrame.Text:SetFont(STANDARD_TEXT_FONT, db.stealthTextSize or 28, "OUTLINE")
            local tc = db.stealthTextColor or {r=1, g=1, b=1}
            stealthFrame.Text:SetTextColor(tc.r, tc.g, tc.b, db.stealthTextAlpha or 1)
            stealthFrame.Text:SetAlpha(db.stealthTextAlpha or 1)
            ns.ApplyTextAnimation(stealthFrame.Text, db.stealthTextAnim, db.stealthTextAnimSpeed)
            stealthFrame.Text:Show()
        else
            ns.ApplyTextAnimation(stealthFrame.Text, "NONE", 1)
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
                AnchorIconToText(stealthFrame.Icon, stealthFrame.Text, db.stealthIconAnchorPoint or "LEFT", db.stealthIconX or 5, db.stealthIconY or 0)
                ns.ApplyTextAnimation(stealthFrame.Icon, db.stealthTextAnim, db.stealthTextAnimSpeed)
            else
                stealthFrame.Icon:ClearAllPoints()
                stealthFrame.Icon:SetPoint("CENTER", stealthFrame, "CENTER", db.stealthIconX or 5, db.stealthIconY or 0)
                ns.ApplyTextAnimation(stealthFrame.Icon, "NONE", 1)
            end
            stealthFrame.Icon:Show()
        else
            ns.ApplyTextAnimation(stealthFrame.Icon, "NONE", 1)
            stealthFrame.Icon:Hide()
        end
        
        stealthFrame:Show()
    else
        ns.ApplyTextAnimation(stealthFrame.Text, "NONE", 1)
        ns.ApplyTextAnimation(stealthFrame.Icon, "NONE", 1)
        stealthFrame:Hide()
    end

    local anyActive = stealthActive
    
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
        BuildVignettes()
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

    if anyActive then ns.ApplyHighlight() end
    screenFrame:SetShown(anyActive)

    if ns.IsRogue and ns.RefreshPoisonVisuals then
        ns.RefreshPoisonVisuals(force)
    end
end

-- [[ Poison Tracker Logic & Constants ]] -------------------------------------
local DRAGON_TEMPERED_BLADES_SPELL_ID = 381801
local LETHAL_POISONS = { [2823] = true, [315584] = true, [8679] = true, [381664] = true }
local NON_LETHAL_POISONS = { [3408] = true, [5761] = true, [381637] = true }

local function CountActivePoisons(set)
    local count = 0
    if C_UnitAuras and C_UnitAuras.GetPlayerAuraBySpellID then
        for spellId in pairs(set) do
            if C_UnitAuras.GetPlayerAuraBySpellID(spellId) then count = count + 1 end
        end
        return count
    end

    local i = 1
    while true do
        local name, _, _, _, _, _, _, _, _, buffID = UnitBuff("player", i)
        if not name then break end
        if buffID and set[buffID] then count = count + 1 end
        i = i + 1
    end
    return count
end

local poisonUI = nil
local function GetPoisonFrames()
    if poisonUI then return poisonUI end
    poisonUI = { lethal = {}, nonLethal = {} }
    local function Build(kind, namePrefix, label, frameName)
        local frame = CreateTrackerFrame(namePrefix, label)
        frame.name = frameName
        poisonUI[kind] = { frame = frame, textFrame = frame, text = frame.Text, iconFrame = frame, icon = frame.Icon }
    end
    -- Specific tracker builds
    Build("lethal", "NV_PoisonLethal", ns.L.LethalPoisons or "Lethal Poison", ns.L.LethalPoisons or "Lethal Poison")
    Build("nonLethal", "NV_PoisonNonLethal", ns.L.NonLethalPoisons or "Non-Lethal Poison", ns.L.NonLethalPoisons or "Non-Lethal Poison")
    return poisonUI
end

-- [[ UI Frame Animation & Loop Logic ]] -------------------------------------
local function StopAllTextAnimations(fs)
    if not fs then return end
    if fs._nvAnimGroups then
        for _, g in pairs(fs._nvAnimGroups) do
            if g and g.Stop then g:Stop() end
        end
    end
    fs:SetScale(1)
    if fs._nvBaseAlpha then fs:SetAlpha(fs._nvBaseAlpha) end
end

local function EnsureAnimGroup(fs, key, builder)
    fs._nvAnimGroups = fs._nvAnimGroups or {}
    local g = fs._nvAnimGroups[key]
    if not g then
        g = fs:CreateAnimationGroup()
        g:SetLooping("REPEAT")
        fs._nvAnimGroups[key] = g
        if builder then builder(g) end
    end
    return g
end

local function ConfigureAndPlay(fs, key, cfgFn, builder)
    local g = EnsureAnimGroup(fs, key, builder)
    g:Stop()
    cfgFn(g)
    g:Play()
end

function ns.ApplyTextAnimation(fs, mode, speed)
    if not fs then return end
    fs._nvBaseAlpha = fs:GetAlpha() or 1
    if not mode or mode == "NONE" then
        StopAllTextAnimations(fs)
        return
    end

    local s = tonumber(speed) or 1
    if s <= 0 then s = 1 end
    fs:SetScale(1)
    fs:SetAlpha(fs._nvBaseAlpha)

    if mode ~= "BLINK" and mode ~= "FADE" and mode ~= "SHAKE" then
        StopAllTextAnimations(fs)
        return
    end

    local function BuildBlink(g)
        g._a1 = g:CreateAnimation("Alpha"); g._a1:SetOrder(1)
        g._a2 = g:CreateAnimation("Alpha"); g._a2:SetOrder(2)
    end
    local function BuildFade(g)
        g._a1 = g:CreateAnimation("Alpha"); g._a1:SetOrder(1)
        g._a2 = g:CreateAnimation("Alpha"); g._a2:SetOrder(2)
    end
    local function BuildShake(g)
        g._t1 = g:CreateAnimation("Translation"); g._t1:SetOrder(1)
        g._t2 = g:CreateAnimation("Translation"); g._t2:SetOrder(2)
    end

    if mode == "BLINK" then
        ConfigureAndPlay(fs, "BLINK", function(g)
            g._a1:SetFromAlpha(fs._nvBaseAlpha); g._a1:SetToAlpha(0); g._a1:SetDuration(0.25 / s)
            g._a2:SetFromAlpha(0); g._a2:SetToAlpha(fs._nvBaseAlpha); g._a2:SetDuration(0.25 / s)
        end, BuildBlink)
    elseif mode == "FADE" then
        ConfigureAndPlay(fs, "FADE", function(g)
            g._a1:SetFromAlpha(fs._nvBaseAlpha); g._a1:SetToAlpha(fs._nvBaseAlpha * 0.2); g._a1:SetDuration(0.8 / s)
            g._a2:SetFromAlpha(fs._nvBaseAlpha * 0.2); g._a2:SetToAlpha(fs._nvBaseAlpha); g._a2:SetDuration(0.8 / s)
        end, BuildFade)
    elseif mode == "SHAKE" then
        ConfigureAndPlay(fs, "SHAKE", function(g)
            g._t1:SetOffset(-6, 0); g._t1:SetDuration(0.06 / s)
            g._t2:SetOffset(6, 0); g._t2:SetDuration(0.06 / s)
        end, BuildShake)
    end
end

-- [[ Poison Visual Update Controller ]] --------------------------------------
ns._poisonState = ns._poisonState or {
    lethalMissing = false,
    nonLethalMissing = false,
    lastSoundTime = {lethal = 0, nonLethal = 0},
}

function ns.RefreshPoisonVisuals(force)
    if not ns.IsRogue then return end
    local db = ns.db
    if not db then return end

    local lethalEnabled = db.poisonLethalEnabled
    local nonLethalEnabled = db.poisonNonLethalEnabled
    
    local function HideAll()
        if poisonUI then
            poisonUI.lethal.frame:Hide(); poisonUI.nonLethal.frame:Hide()
        end
        ns._poisonState.lethalMissing = false; ns._poisonState.nonLethalMissing = false
    end

    if not lethalEnabled and not nonLethalEnabled then return HideAll() end
    if db.poisonOnlyCombat and not UnitAffectingCombat("player") then return HideAll() end
    if db.poisonOnlyInstances and not ns.IsInInstance() then return HideAll() end

    ns._poisonLastState = ns._poisonLastState or { lethal = -1, nonLethal = -1 }

    local required = IsPlayerSpell(DRAGON_TEMPERED_BLADES_SPELL_ID) and 2 or 1
    local missingLethal = math.max(0, required - CountActivePoisons(LETHAL_POISONS))
    local missingNonLethal = math.max(0, required - CountActivePoisons(NON_LETHAL_POISONS))

    local showLethal = lethalEnabled and missingLethal > 0
    local showNonLethal = nonLethalEnabled and missingNonLethal > 0

    if ns._poisonLastState.lethal == missingLethal and ns._poisonLastState.nonLethal == missingNonLethal and not force then
        return
    end

    ns._poisonLastState.lethal = missingLethal
    ns._poisonLastState.nonLethal = missingNonLethal

    local frames = GetPoisonFrames()

    local function UpdatePoisonFrame(kind, show, missing, customText, fallbackText, x, y, anim, speed, iconTexture, iconSpell, iconSize, iconAlpha, anchorToText, anchorPoint, iconX, iconY, color)
        local f = frames[kind]
        if show then
            local text = (customText and customText:gsub("%s", "") ~= "") and customText or fallbackText
            text = text:gsub("%%m", tostring(missing)):gsub("%%r", tostring(required))
            f.text:SetText(text)
            f.text:SetFont(STANDARD_TEXT_FONT, 28, "OUTLINE")
            
            if color then
                f.text:SetTextColor(color.r or 1, color.g or 1, color.b or 1, color.a or 1)
            end

            f.text:ClearAllPoints()
            f.text:SetPoint("CENTER", UIParent, "CENTER", x or 0, y or 0)
            f.text:Show()
            ns.ApplyTextAnimation(f.text, anim, speed)

            if iconTexture == "" then iconTexture = GetSpellTexture(iconSpell) end
            f.icon:SetTexture(iconTexture or "Interface\\Icons\\INV_Misc_QuestionMark")
            f.icon:SetSize(iconSize or 36, iconSize or 36)
            f.icon:SetAlpha(iconAlpha or 1)
            f.icon:ClearAllPoints()
            if anchorToText then
                AnchorIconToText(f.icon, f.text, anchorPoint or "LEFT", iconX or 5, iconY or 0)
                ns.ApplyTextAnimation(f.icon, anim, speed)
            else
                f.icon:SetPoint("CENTER", UIParent, "CENTER", iconX or 5, iconY or 0)
                ns.ApplyTextAnimation(f.icon, "NONE", 1)
            end
            f.icon:Show()
            f.frame:Show()
        else
            StopAllTextAnimations(f.text); ns.ApplyTextAnimation(f.icon, "NONE", 1); f.frame:Hide()
        end
    end

    UpdatePoisonFrame("lethal", showLethal, missingLethal, db.poisonLethalCustomText, ns.L.LethalPoisonMissing, db.poisonLethalTextX, db.poisonLethalTextY, db.poisonLethalTextAnim, db.poisonLethalTextAnimSpeed, db.poisonLethalIconTexture, db.poisonLethalIconSpellId, db.poisonLethalIconSize, db.poisonLethalIconAlpha, db.poisonLethalIconAnchorToText, db.poisonLethalIconAnchorPoint, db.poisonLethalIconX, db.poisonLethalIconY, db.poisonLethalTextColor)
    UpdatePoisonFrame("nonLethal", showNonLethal, missingNonLethal, db.poisonNonLethalCustomText, ns.L.NonLethalPoisonMissing, db.poisonNonLethalTextX, db.poisonNonLethalTextY, db.poisonNonLethalTextAnim, db.poisonNonLethalTextAnimSpeed, db.poisonNonLethalIconTexture, db.poisonNonLethalIconSpellId, db.poisonNonLethalIconSize, db.poisonNonLethalIconAlpha, db.poisonNonLethalIconAnchorToText, db.poisonNonLethalIconAnchorPoint, db.poisonNonLethalIconX, db.poisonNonLethalIconY, db.poisonNonLethalTextColor)

    local function PlayPoisonSound(kind, isMissing, wasMissing, enabled, soundKit)
        if isMissing and not wasMissing and enabled then
            local now = GetTime()
            if now - (ns._poisonState.lastSoundTime[kind] or 0) > 5 then
                PlaySound(soundKit or 8959, "Master")
                ns._poisonState.lastSoundTime[kind] = now
            end
        end
    end

    PlayPoisonSound("lethal", showLethal, ns._poisonState.lethalMissing, db.poisonLethalEnableSound, db.poisonLethalSoundKit)
    PlayPoisonSound("nonLethal", showNonLethal, ns._poisonState.nonLethalMissing, db.poisonNonLethalEnableSound, db.poisonNonLethalSoundKit)

    ns._poisonState.lethalMissing = showLethal
    ns._poisonState.nonLethalMissing = showNonLethal
end
