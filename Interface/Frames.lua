local addonName, ns = ...

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

local stealthFrame = CreateTrackerFrame("NV_StealthFrame", ns.L.StealthMonitor)

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

function ns.RefreshVisuals()
    local db = ns.db
    if not db then return end

    local stealthed = IsStealthed()
    local stealthActive = stealthed and db.stealthEnabled
    if stealthActive and db.stealthOnlyInstances and not ns.IsInInstance() then
        stealthActive = false
    end

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
            stealthFrame.Icon:SetTexture("Interface\\Icons\\Ability_Stealth")
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
        ns.RefreshPoisonVisuals()
    end
end

local DRAGON_TEMPERED_BLADES_SPELL_ID = 381801

local LETHAL_POISONS = {
    [2823] = true,
    [315584] = true,
    [8679] = true,
    [381664] = true,
}

local NON_LETHAL_POISONS = {
    [3408] = true,
    [5761] = true,
    [381637] = true,
}

local function CountActivePoisons(set)
    local count = 0
    if C_UnitAuras and C_UnitAuras.GetPlayerAuraBySpellID then
        for spellId in pairs(set) do
            if C_UnitAuras.GetPlayerAuraBySpellID(spellId) then
                count = count + 1
            end
        end
        return count
    end

    local i = 1
    while true do
        local name, _, _, _, _, _, _, _, _, buffID = UnitBuff("player", i)
        if not name then break end
        if buffID and set[buffID] then
            count = count + 1
        end
        i = i + 1
    end
    return count
end

local poisonUI = nil

local function GetPoisonFrames()
    if poisonUI then return poisonUI end

    poisonUI = {
        lethal = {},
        nonLethal = {},
    }

    local function Build(kind, namePrefix, label)
        local frame = CreateTrackerFrame(namePrefix, label)
        poisonUI[kind] = {
            frame = frame,
            textFrame = frame,
            text = frame.Text,
            iconFrame = frame,
            icon = frame.Icon,
        }
    end

    Build("lethal", "NV_PoisonLethal", ns.L.PoisonLethalMonitor)
    Build("nonLethal", "NV_PoisonNonLethal", ns.L.PoisonNonLethalMonitor)

    return poisonUI
end

local function NormalizeTextTemplate(text, fallback)
    if not text or text:gsub("%s", "") == "" then return fallback end
    return text
end

local function ApplyTextTokens(text, missing, required)
    return (text:gsub("%%m", tostring(missing)):gsub("%%r", tostring(required)))
end

local function GetSoundKitValue(v)
    if type(v) == "number" then return v end
    return nil
end

local function StopAllTextAnimations(fs)
    if not fs then return end
    if fs._nvAnimGroups then
        for _, g in pairs(fs._nvAnimGroups) do
            if g and g.Stop then g:Stop() end
        end
    end
    fs:SetScale(1)
    if fs._nvBaseAlpha then
        fs:SetAlpha(fs._nvBaseAlpha)
    end
end

local function StopTextAnimation(fs)
    StopAllTextAnimations(fs)
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

    if fs._nvAnimGroups then
        for _, g in pairs(fs._nvAnimGroups) do
            if g and g.Stop then g:Stop() end
        end
    end

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

    local function PlayTextMode(m)
        if m == "BLINK" then
            ConfigureAndPlay(fs, "BLINK", function(g)
                g._a1:SetFromAlpha(fs._nvBaseAlpha)
                g._a1:SetToAlpha(0)
                g._a1:SetDuration(0.25 / s)
                g._a2:SetFromAlpha(0)
                g._a2:SetToAlpha(fs._nvBaseAlpha)
                g._a2:SetDuration(0.25 / s)
            end, BuildBlink)
        elseif m == "FADE" then
            ConfigureAndPlay(fs, "FADE", function(g)
                g._a1:SetFromAlpha(fs._nvBaseAlpha)
                g._a1:SetToAlpha(fs._nvBaseAlpha * 0.2)
                g._a1:SetDuration(0.8 / s)
                g._a2:SetFromAlpha(fs._nvBaseAlpha * 0.2)
                g._a2:SetToAlpha(fs._nvBaseAlpha)
                g._a2:SetDuration(0.8 / s)
            end, BuildFade)
        elseif m == "SHAKE" then
            ConfigureAndPlay(fs, "SHAKE", function(g)
                g._t1:SetOffset(-6, 0)
                g._t1:SetDuration(0.06 / s)
                g._t2:SetOffset(6, 0)
                g._t2:SetDuration(0.06 / s)
            end, BuildShake)
        else
            return false
        end
        return true
    end

    local ok = PlayTextMode(mode)
    if not ok then
        StopAllTextAnimations(fs)
        return
    end
end

ns._poisonState = ns._poisonState or {
    lethalMissing = false,
    nonLethalMissing = false,
    lastSoundTime = {lethal = 0, nonLethal = 0},
}

function ns.RefreshPoisonVisuals()
    if not ns.IsRogue then return end

    local db = ns.db
    local lethalEnabled = db and db.poisonLethalEnabled
    local nonLethalEnabled = db and db.poisonNonLethalEnabled
    if not db or (not lethalEnabled and not nonLethalEnabled) then
        if poisonUI then
            poisonUI.lethal.textFrame:Hide()
            poisonUI.lethal.iconFrame:Hide()
            poisonUI.nonLethal.textFrame:Hide()
            poisonUI.nonLethal.iconFrame:Hide()
        end
        ns._poisonState.lethalMissing = false
        ns._poisonState.nonLethalMissing = false
        return
    end

    if db.poisonOnlyCombat then
        local inCombat = UnitAffectingCombat and UnitAffectingCombat("player")
        if not inCombat then
            if poisonUI then
                poisonUI.lethal.textFrame:Hide()
                poisonUI.lethal.iconFrame:Hide()
                poisonUI.nonLethal.textFrame:Hide()
                poisonUI.nonLethal.iconFrame:Hide()
            end
            ns._poisonState.lethalMissing = false
            ns._poisonState.nonLethalMissing = false
            return
        end
    end

    if db.poisonOnlyInstances and not ns.IsInInstance() then
        if poisonUI then
            poisonUI.lethal.textFrame:Hide()
            poisonUI.lethal.iconFrame:Hide()
            poisonUI.nonLethal.textFrame:Hide()
            poisonUI.nonLethal.iconFrame:Hide()
        end
        ns._poisonState.lethalMissing = false
        ns._poisonState.nonLethalMissing = false
        return
    end

    local hasDTB = IsPlayerSpell and IsPlayerSpell(DRAGON_TEMPERED_BLADES_SPELL_ID)
    local required = hasDTB and 2 or 1

    local lethalCount = CountActivePoisons(LETHAL_POISONS)
    local nonLethalCount = CountActivePoisons(NON_LETHAL_POISONS)

    local missingLethal = required - lethalCount
    local missingNonLethal = required - nonLethalCount
    if missingLethal < 0 then missingLethal = 0 end
    if missingNonLethal < 0 then missingNonLethal = 0 end

    local showLethal = lethalEnabled and missingLethal > 0
    local showNonLethal = nonLethalEnabled and missingNonLethal > 0

    local frames = GetPoisonFrames()

    if showLethal then
        local hasText = db.poisonLethalEnableText
        local hasIcon = db.poisonLethalEnableIcon
        
        if hasText then
            local template = NormalizeTextTemplate(db.poisonLethalCustomText, ns.L.LethalPoisonMissing)
            frames.lethal.text:SetText(ApplyTextTokens(template, missingLethal, required))
            frames.lethal.text:SetFont(STANDARD_TEXT_FONT, db.poisonLethalTextSize or 28, "OUTLINE")
            local c = db.poisonLethalTextColor or {r = 1, g = 0.2, b = 0.2}
            frames.lethal.text:SetTextColor(c.r, c.g, c.b, db.poisonLethalTextAlpha or 1)
            frames.lethal.text:SetAlpha(db.poisonLethalTextAlpha or 1)
            frames.lethal.text:ClearAllPoints()
            frames.lethal.text:SetPoint("CENTER", UIParent, "CENTER", db.poisonLethalTextX or 0, db.poisonLethalTextY or 300)
            ns.ApplyTextAnimation(frames.lethal.text, db.poisonLethalTextAnim, db.poisonLethalTextAnimSpeed)
            frames.lethal.text:Show()
        else
            StopTextAnimation(frames.lethal.text)
            frames.lethal.text:Hide()
        end

        if hasIcon then
            local texture = db.poisonLethalIconTexture or ""
            if texture == "" then
                local spellId = db.poisonLethalIconSpellId or 315584
                texture = GetSpellTexture and GetSpellTexture(spellId)
            end
            if not texture or texture == "" then texture = "Interface\\Icons\\INV_Misc_QuestionMark" end
            
            local sz = db.poisonLethalIconSize or 36
            frames.lethal.icon:SetSize(sz, sz)
            frames.lethal.icon:SetAlpha(db.poisonLethalIconAlpha or 1)
            frames.lethal.icon:ClearAllPoints()
            local point = db.poisonLethalIconAnchorPoint or "LEFT"
            local anchorToText = db.poisonLethalIconAnchorToText
            if anchorToText and hasText then
                AnchorIconToText(frames.lethal.icon, frames.lethal.text, point, db.poisonLethalIconX or 5, db.poisonLethalIconY or 0)
                ns.ApplyTextAnimation(frames.lethal.icon, db.poisonLethalTextAnim, db.poisonLethalTextAnimSpeed)
            else
                frames.lethal.icon:SetPoint("CENTER", UIParent, "CENTER", db.poisonLethalIconX or 5, db.poisonLethalIconY or 0)
                ns.ApplyTextAnimation(frames.lethal.icon, "NONE", 1)
            end
            frames.lethal.icon:SetTexture(texture)
            frames.lethal.icon:Show()
        else
            ns.ApplyTextAnimation(frames.lethal.icon, "NONE", 1)
            frames.lethal.icon:Hide()
        end
        
        if hasText or hasIcon then
            frames.lethal.frame:Show()
        else
            frames.lethal.frame:Hide()
        end
    else
        StopTextAnimation(frames.lethal.text)
        ns.ApplyTextAnimation(frames.lethal.icon, "NONE", 1)
        frames.lethal.frame:Hide()
    end

    if showNonLethal then
        local hasText = db.poisonNonLethalEnableText
        local hasIcon = db.poisonNonLethalEnableIcon
        
        if hasText then
            local template = NormalizeTextTemplate(db.poisonNonLethalCustomText, ns.L.NonLethalPoisonMissing)
            frames.nonLethal.text:SetText(ApplyTextTokens(template, missingNonLethal, required))
            frames.nonLethal.text:SetFont(STANDARD_TEXT_FONT, db.poisonNonLethalTextSize or 28, "OUTLINE")
            local c = db.poisonNonLethalTextColor or {r = 1, g = 0.6, b = 0.2}
            frames.nonLethal.text:SetTextColor(c.r, c.g, c.b, db.poisonNonLethalTextAlpha or 1)
            frames.nonLethal.text:SetAlpha(db.poisonNonLethalTextAlpha or 1)
            frames.nonLethal.text:ClearAllPoints()
            frames.nonLethal.text:SetPoint("CENTER", UIParent, "CENTER", db.poisonNonLethalTextX or 0, db.poisonNonLethalTextY or 260)
            ns.ApplyTextAnimation(frames.nonLethal.text, db.poisonNonLethalTextAnim, db.poisonNonLethalTextAnimSpeed)
            frames.nonLethal.text:Show()
        else
            StopTextAnimation(frames.nonLethal.text)
            frames.nonLethal.text:Hide()
        end

        if hasIcon then
            local texture = db.poisonNonLethalIconTexture or ""
            if texture == "" then
                local spellId = db.poisonNonLethalIconSpellId or 3408
                texture = GetSpellTexture and GetSpellTexture(spellId)
            end
            if not texture or texture == "" then texture = "Interface\\Icons\\INV_Misc_QuestionMark" end

            local sz = db.poisonNonLethalIconSize or 36
            frames.nonLethal.icon:SetSize(sz, sz)
            frames.nonLethal.icon:SetAlpha(db.poisonNonLethalIconAlpha or 1)
            frames.nonLethal.icon:ClearAllPoints()
            local point = db.poisonNonLethalIconAnchorPoint or "LEFT"
            local anchorToText = db.poisonNonLethalIconAnchorToText
            if anchorToText and hasText then
                AnchorIconToText(frames.nonLethal.icon, frames.nonLethal.text, point, db.poisonNonLethalIconX or 5, db.poisonNonLethalIconY or 0)
                ns.ApplyTextAnimation(frames.nonLethal.icon, db.poisonNonLethalTextAnim, db.poisonNonLethalTextAnimSpeed)
            else
                frames.nonLethal.icon:SetPoint("CENTER", UIParent, "CENTER", db.poisonNonLethalIconX or 5, db.poisonNonLethalIconY or 0)
                ns.ApplyTextAnimation(frames.nonLethal.icon, "NONE", 1)
            end
            frames.nonLethal.icon:SetTexture(texture)
            frames.nonLethal.icon:Show()
        else
            ns.ApplyTextAnimation(frames.nonLethal.icon, "NONE", 1)
            frames.nonLethal.icon:Hide()
        end
        
        if hasText or hasIcon then
            frames.nonLethal.frame:Show()
        else
            frames.nonLethal.frame:Hide()
        end
    else
        StopTextAnimation(frames.nonLethal.text)
        ns.ApplyTextAnimation(frames.nonLethal.icon, "NONE", 1)
        frames.nonLethal.frame:Hide()
    end

    local function MaybePlay(kind, isMissing, wasMissing, enabled, soundKitId)
        if not isMissing or wasMissing or not enabled then return end
        local now = GetTime and GetTime() or 0
        local last = ns._poisonState.lastSoundTime[kind] or 0
        if now - last < 5 then return end
        local kit = GetSoundKitValue(soundKitId) or (SOUNDKIT and SOUNDKIT.RAID_WARNING)
        if kit and PlaySound then
            ns._poisonState.lastSoundTime[kind] = now
            PlaySound(kit, "Master")
        end
    end

    MaybePlay("lethal", showLethal, ns._poisonState.lethalMissing, db.poisonLethalEnableSound, db.poisonLethalSoundKit)
    MaybePlay("nonLethal", showNonLethal, ns._poisonState.nonLethalMissing, db.poisonNonLethalEnableSound, db.poisonNonLethalSoundKit)

    ns._poisonState.lethalMissing = showLethal
    ns._poisonState.nonLethalMissing = showNonLethal
end
