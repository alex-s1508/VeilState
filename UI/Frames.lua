local addonName, ns = ...

local screenFrame = CreateFrame("Frame", "VS_ScreenFrame", UIParent)
screenFrame:SetAllPoints(UIParent)
screenFrame:Hide()

local screenOverlay = screenFrame:CreateTexture(nil, "BACKGROUND")
screenOverlay:SetAllPoints(UIParent)
screenOverlay:SetTexture("Interface\\Buttons\\WHITE8X8")

local textFrame = CreateFrame("Frame", "VS_TextFrame", UIParent)
textFrame:SetAllPoints(UIParent)
textFrame:Hide()

local floatingText = textFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlightHuge")
floatingText:SetShadowOffset(2, -2)
floatingText:SetShadowColor(0, 0, 0, 0.8)

local iconFrame = CreateFrame("Frame", "VS_IconFrame", UIParent)
iconFrame:SetAllPoints(UIParent)
iconFrame:Hide()

local indicatorIcon = iconFrame:CreateTexture(nil, "OVERLAY")

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
    local xA = math.abs(xV)
    local yA = math.abs(yV)

    if p == "LEFT" then
        icon:SetPoint("RIGHT", text, "LEFT", -xA, yV)
    elseif p == "RIGHT" then
        icon:SetPoint("LEFT", text, "RIGHT", xA, yV)
    elseif p == "TOP" then
        icon:SetPoint("BOTTOM", text, "TOP", xV, yA)
    elseif p == "BOTTOM" then
        icon:SetPoint("TOP", text, "BOTTOM", xV, -yA)
    elseif p == "TOPLEFT" then
        icon:SetPoint("BOTTOMRIGHT", text, "TOPLEFT", -xA, yA)
    elseif p == "TOPRIGHT" then
        icon:SetPoint("BOTTOMLEFT", text, "TOPRIGHT", xA, yA)
    elseif p == "BOTTOMLEFT" then
        icon:SetPoint("TOPRIGHT", text, "BOTTOMLEFT", -xA, -yA)
    elseif p == "BOTTOMRIGHT" then
        icon:SetPoint("TOPLEFT", text, "BOTTOMRIGHT", xA, -yA)
    else
        icon:SetPoint("CENTER", text, "CENTER", xV, yV)
    end
end

function ns.RefreshVisuals()
    local db = ns.db
    if not db then return end

    local function InAllowedInstance()
        local inInstance, instanceType = IsInInstance and IsInInstance()
        return inInstance and (instanceType == "party" or instanceType == "raid" or instanceType == "scenario")
    end
    local function IsAllowed(onlyCombatKey, onlyInstancesKey)
        if db[onlyCombatKey] then
            local inCombat = UnitAffectingCombat and UnitAffectingCombat("player")
            if not inCombat then return false end
        end
        if db[onlyInstancesKey] then
            if not InAllowedInstance() then return false end
        end
        return true
    end

    local sd = ns.IsInShadowDance and db.sdEnabled and IsAllowed("sdOnlyCombat", "sdOnlyInstances")
    local stealthed = IsStealthed()
    local stealthActive = stealthed and not sd and db.stealthEnabled and IsAllowed(nil, "stealthOnlyInstances")
    local active = sd or stealthActive

    local function v(sdKey, sKey) 
        if sd then return db[sdKey] else return db[sKey] end 
    end

    local customText = v("sdCustomText", "customText") or ""
    local defaultMsg = sd and ns.L.ShadowDanceMessage or ns.L.DefaultMessage
    local displayText = customText:gsub("%s", "") ~= "" and customText or defaultMsg

    screenFrame:SetFrameStrata(v("sdScreenStrata", "screenStrata") or "BACKGROUND")
    vignetteFrame:SetFrameStrata(v("sdVignetteStrata", "vignetteStrata") or "BACKGROUND")

    if active and v("sdEnableScreenColor", "enableScreenColor") then
        local c = v("sdScreenColor", "screenColor")
        screenOverlay:SetVertexColor(c.r, c.g, c.b, v("sdScreenAlpha", "screenAlpha"))
        screenOverlay:Show()
    else
        screenOverlay:Hide()
    end

    if active and v("sdEnableText", "enableText") then
        floatingText:SetText(displayText)
        floatingText:SetFont(STANDARD_TEXT_FONT, v("sdTextSize", "textSize"), "OUTLINE")
        local c = v("sdTextColor", "textColor")
        floatingText:SetTextColor(c.r, c.g, c.b, v("sdTextAlpha", "textAlpha"))
        floatingText._nvBaseAlpha = v("sdTextAlpha", "textAlpha")
        floatingText:ClearAllPoints()
        floatingText:SetPoint("CENTER", UIParent, "CENTER", v("sdTextX", "textX"), v("sdTextY", "textY"))
        ns.ApplyTextAnimation(floatingText, v("sdTextAnim", "textAnim"), v("sdTextAnimSpeed", "textAnimSpeed"))
        floatingText:Show()
    else
        ns.ApplyTextAnimation(floatingText, "NONE", 1)
        floatingText:Hide()
    end

    if active and v("sdEnableIcon", "enableIcon") then
        local sz = v("sdIconSize", "iconSize")
        indicatorIcon:SetSize(sz, sz)
        indicatorIcon:SetAlpha(v("sdIconAlpha", "iconAlpha"))
        indicatorIcon:ClearAllPoints()
        local point = v("sdIconAnchorPoint", "iconAnchorPoint") or "LEFT"
        local anchorToText = v("sdIconAnchorToText", "iconAnchorToText")
        if anchorToText and active and v("sdEnableText", "enableText") then
            AnchorIconToText(indicatorIcon, floatingText, point, v("sdIconX", "iconX"), v("sdIconY", "iconY"))
        else
            indicatorIcon:SetPoint("CENTER", UIParent, "CENTER", v("sdIconX", "iconX"), v("sdIconY", "iconY"))
        end
        if sd then
            indicatorIcon:SetTexture("Interface\\Icons\\Ability_Rogue_ShadowDance")
        else
            indicatorIcon:SetTexture("Interface\\Icons\\Ability_Stealth")
        end
        if anchorToText and active and v("sdEnableText", "enableText") then
            ns.ApplyTextAnimation(indicatorIcon, v("sdTextAnim", "textAnim"), v("sdTextAnimSpeed", "textAnimSpeed"))
        else
            ns.ApplyTextAnimation(indicatorIcon, "NONE", 1)
        end
        indicatorIcon:Show()
    else
        ns.ApplyTextAnimation(indicatorIcon, "NONE", 1)
        indicatorIcon:Hide()
    end

    if active and v("sdEnableVignette", "enableVignette") then
        BuildVignettes()
        local solid = CreateColor(0, 0, 0, v("sdVignetteAlpha", "vignetteAlpha"))
        local clear = CreateColor(0, 0, 0, 0)
        local thick = v("sdVignetteSize", "vignetteSize")
        vignetteEdges.top:SetHeight(thick);         vignetteEdges.top:SetGradient("VERTICAL", clear, solid)
        vignetteEdges.bottom:SetHeight(thick);      vignetteEdges.bottom:SetGradient("VERTICAL", solid, clear)
        vignetteEdges.left:SetWidth(thick + 100);   vignetteEdges.left:SetGradient("HORIZONTAL", solid, clear)
        vignetteEdges.right:SetWidth(thick + 100);  vignetteEdges.right:SetGradient("HORIZONTAL", clear, solid)
        for _, edge in pairs(vignetteEdges) do edge:Show() end
    else
        for _, edge in pairs(vignetteEdges) do if edge then edge:Hide() end end
    end

    if active then ns.ApplyHighlight() end
    screenFrame:SetShown(active)
    textFrame:SetShown(active)
    iconFrame:SetShown(active)

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

    local function Build(kind, namePrefix)
        local textFrame = CreateFrame("Frame", namePrefix .. "_TextFrame", UIParent)
        textFrame:SetAllPoints(UIParent)
        textFrame:Hide()

        local text = textFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlightHuge")
        text:SetShadowOffset(2, -2)
        text:SetShadowColor(0, 0, 0, 0.8)

        local iconFrame = CreateFrame("Frame", namePrefix .. "_IconFrame", UIParent)
        iconFrame:SetAllPoints(UIParent)
        iconFrame:Hide()

        local icon = iconFrame:CreateTexture(nil, "OVERLAY")

        poisonUI[kind].textFrame = textFrame
        poisonUI[kind].text = text
        poisonUI[kind].iconFrame = iconFrame
        poisonUI[kind].icon = icon
    end

    Build("lethal", "NV_PoisonLethal")
    Build("nonLethal", "NV_PoisonNonLethal")

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
    if not mode or mode == "NONE" then
        StopAllTextAnimations(fs)
        return
    end

    local s = tonumber(speed) or 1
    if s <= 0 then s = 1 end

    fs._nvBaseAlpha = fs._nvBaseAlpha or fs:GetAlpha() or 1
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
    local trackerEnabled = db and db.poisonTrackerEnabled
    local lethalEnabled = db and db.poisonLethalEnabled
    local nonLethalEnabled = db and db.poisonNonLethalEnabled
    if not db or not trackerEnabled or (not lethalEnabled and not nonLethalEnabled) then
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

    if db.poisonOnlyInstances then
        local inInstance, instanceType = IsInInstance and IsInInstance()
        local ok = inInstance and (instanceType == "party" or instanceType == "raid" or instanceType == "scenario")
        if not ok then
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

    if InCombatLockdown and InCombatLockdown() then
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

    if showLethal and db.poisonLethalEnableText then
        local template = NormalizeTextTemplate(db.poisonLethalCustomText, ns.L.LethalPoisonMissing)
        frames.lethal.text:SetText(ApplyTextTokens(template, missingLethal, required))
        frames.lethal.text:SetFont(STANDARD_TEXT_FONT, db.poisonLethalTextSize or 28, "OUTLINE")
        local c = db.poisonLethalTextColor or {r = 1, g = 0.2, b = 0.2}
        frames.lethal.text:SetTextColor(c.r, c.g, c.b, db.poisonLethalTextAlpha or 1)
        frames.lethal.text._nvBaseAlpha = db.poisonLethalTextAlpha or 1
        frames.lethal.text:ClearAllPoints()
        frames.lethal.text:SetPoint("CENTER", UIParent, "CENTER", db.poisonLethalTextX or 0, db.poisonLethalTextY or 120)
        ns.ApplyTextAnimation(frames.lethal.text, db.poisonLethalTextAnim, db.poisonLethalTextAnimSpeed)
        frames.lethal.text:Show()
        frames.lethal.textFrame:Show()
    else
        StopTextAnimation(frames.lethal.text)
        frames.lethal.textFrame:Hide()
    end

    if showLethal and db.poisonLethalEnableIcon then
        local spellId = db.poisonLethalIconSpellId or 315584
        local texture = db.poisonLethalIconTexture or (GetSpellTexture and GetSpellTexture(spellId))
        if not texture then texture = "Interface\\Icons\\INV_Misc_QuestionMark" end
        local sz = db.poisonLethalIconSize or 36
        frames.lethal.icon:SetSize(sz, sz)
        frames.lethal.icon:SetAlpha(db.poisonLethalIconAlpha or 1)
        frames.lethal.icon:ClearAllPoints()
        local point = db.poisonLethalIconAnchorPoint or "LEFT"
        local anchorToText = db.poisonLethalIconAnchorToText
        if anchorToText and showLethal and db.poisonLethalEnableText then
            AnchorIconToText(frames.lethal.icon, frames.lethal.text, point, db.poisonLethalIconX or -45, db.poisonLethalIconY or 0)
            ns.ApplyTextAnimation(frames.lethal.icon, db.poisonLethalTextAnim, db.poisonLethalTextAnimSpeed)
        else
            frames.lethal.icon:SetPoint("CENTER", UIParent, "CENTER", db.poisonLethalIconX or -45, db.poisonLethalIconY or 0)
            ns.ApplyTextAnimation(frames.lethal.icon, "NONE", 1)
        end
        frames.lethal.icon:SetTexture(texture)
        frames.lethal.icon:Show()
        frames.lethal.iconFrame:Show()
    else
        ns.ApplyTextAnimation(frames.lethal.icon, "NONE", 1)
        frames.lethal.iconFrame:Hide()
    end

    if showNonLethal and db.poisonNonLethalEnableText then
        local template = NormalizeTextTemplate(db.poisonNonLethalCustomText, ns.L.NonLethalPoisonMissing)
        frames.nonLethal.text:SetText(ApplyTextTokens(template, missingNonLethal, required))
        frames.nonLethal.text:SetFont(STANDARD_TEXT_FONT, db.poisonNonLethalTextSize or 28, "OUTLINE")
        local c = db.poisonNonLethalTextColor or {r = 1, g = 0.6, b = 0.2}
        frames.nonLethal.text:SetTextColor(c.r, c.g, c.b, db.poisonNonLethalTextAlpha or 1)
        frames.nonLethal.text._nvBaseAlpha = db.poisonNonLethalTextAlpha or 1
        frames.nonLethal.text:ClearAllPoints()
        frames.nonLethal.text:SetPoint("CENTER", UIParent, "CENTER", db.poisonNonLethalTextX or 0, db.poisonNonLethalTextY or 90)
        ns.ApplyTextAnimation(frames.nonLethal.text, db.poisonNonLethalTextAnim, db.poisonNonLethalTextAnimSpeed)
        frames.nonLethal.text:Show()
        frames.nonLethal.textFrame:Show()
    else
        StopTextAnimation(frames.nonLethal.text)
        frames.nonLethal.textFrame:Hide()
    end

    if showNonLethal and db.poisonNonLethalEnableIcon then
        local spellId = db.poisonNonLethalIconSpellId or 3408
        local texture = db.poisonNonLethalIconTexture or (GetSpellTexture and GetSpellTexture(spellId))
        if not texture then texture = "Interface\\Icons\\INV_Misc_QuestionMark" end
        local sz = db.poisonNonLethalIconSize or 36
        frames.nonLethal.icon:SetSize(sz, sz)
        frames.nonLethal.icon:SetAlpha(db.poisonNonLethalIconAlpha or 1)
        frames.nonLethal.icon:ClearAllPoints()
        local point = db.poisonNonLethalIconAnchorPoint or "LEFT"
        local anchorToText = db.poisonNonLethalIconAnchorToText
        if anchorToText and showNonLethal and db.poisonNonLethalEnableText then
            AnchorIconToText(frames.nonLethal.icon, frames.nonLethal.text, point, db.poisonNonLethalIconX or -45, db.poisonNonLethalIconY or 0)
            ns.ApplyTextAnimation(frames.nonLethal.icon, db.poisonNonLethalTextAnim, db.poisonNonLethalTextAnimSpeed)
        else
            frames.nonLethal.icon:SetPoint("CENTER", UIParent, "CENTER", db.poisonNonLethalIconX or -45, db.poisonNonLethalIconY or 0)
            ns.ApplyTextAnimation(frames.nonLethal.icon, "NONE", 1)
        end
        frames.nonLethal.icon:SetTexture(texture)
        frames.nonLethal.icon:Show()
        frames.nonLethal.iconFrame:Show()
    else
        ns.ApplyTextAnimation(frames.nonLethal.icon, "NONE", 1)
        frames.nonLethal.iconFrame:Hide()
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

function ns.CreateScrollPanel(panel)
    local scroll = CreateFrame("ScrollFrame", panel:GetName() .. "Scroll", panel, "UIPanelScrollFrameTemplate")
    scroll:SetPoint("TOPLEFT", 8, -8)
    scroll:SetPoint("BOTTOMRIGHT", -28, 8)
    local content = CreateFrame("Frame", nil, scroll)
    content:SetSize(600, 1600)
    scroll:SetScrollChild(content)
    return content
end

function ns.CreateUI(content)
    local ui = {}
    local y = -16
    local pad = 16

    function ui:Header(text)
        local h = content:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
        h:SetPoint("TOPLEFT", pad, y)
        h:SetText(text)
        h:SetTextColor(0.64, 0.38, 0.89)
        local line = content:CreateTexture(nil, "OVERLAY")
        line:SetSize(580, 1)
        line:SetPoint("TOPLEFT", h, "BOTTOMLEFT", 0, -4)
        line:SetColorTexture(0.5, 0.5, 0.5, 0.3)
        y = y - 40
    end

    function ui:Title(text, subtext)
        local t = content:CreateFontString(nil, "ARTWORK", "GameFontNormalHuge")
        t:SetPoint("TOPLEFT", pad, y)
        t:SetText(text)
        y = y - 30
        if subtext then
            local s = content:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
            s:SetPoint("TOPLEFT", t, "BOTTOMLEFT", 0, -4)
            s:SetText(subtext)
            y = y - 20
        end
        y = y - 10
    end

    function ui:Check(dbKey, label, xOff)
        local x = pad + (xOff or 0)
        local cb = CreateFrame("CheckButton", "VS_Check_" .. dbKey, content, "InterfaceOptionsCheckButtonTemplate")
        cb:SetPoint("TOPLEFT", x, y)
        _G[cb:GetName() .. "Text"]:SetText(label or ns.L.Enable)
        cb:SetChecked(ns.db[dbKey])
        cb:SetScript("OnClick", function(self)
            ns.db[dbKey] = self:GetChecked()
            ns.UpdateState()
        end)
        if not xOff then y = y - 32 end
        return cb
    end

    function ui:Slider(dbKey, label, min, max, step, xOff, hold)
        local x = pad + (xOff or 0)
        local sl = CreateFrame("Slider", "VS_Slider_" .. dbKey, content, "OptionsSliderTemplate")
        sl:SetPoint("TOPLEFT", x + 4, y - 10)
        sl:SetMinMaxValues(min, max)
        sl:SetValueStep(step)
        sl:SetValue(ns.db[dbKey] or min)
        sl:SetWidth(180)
        sl:SetObeyStepOnDrag(true)
        _G[sl:GetName() .. "Text"]:SetText(label)
        _G[sl:GetName() .. "Low"]:SetText(tostring(min))
        _G[sl:GetName() .. "High"]:SetText(tostring(max))
        local vt = content:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
        vt:SetPoint("TOP", sl, "BOTTOM", 0, -2)
        local function Format(v2)
            if step and step < 1 then
                if step >= 0.1 then
                    return string.format("%.1f", v2)
                elseif step >= 0.01 then
                    return string.format("%.2f", v2)
                else
                    return string.format("%.3f", v2)
                end
            end
            return string.format("%.0f", v2)
        end
        vt:SetText(Format(ns.db[dbKey] or min))
        sl:SetScript("OnValueChanged", function(self, v2)
            local r = math.floor(v2 / step + 0.5) * step
            ns.db[dbKey] = r
            vt:SetText(Format(r))
            ns.UpdateState()
        end)
        if not hold then y = y - 50 end
        return sl
    end

    function ui:Color(dbKey, label, xOff, hold)
        local x = pad + (xOff or 0)
        local btn = CreateFrame("Button", nil, content, "UIPanelButtonTemplate")
        btn:SetSize(24, 24)
        btn:SetPoint("TOPLEFT", x + 4, y)
        local swatch = btn:CreateTexture(nil, "OVERLAY")
        swatch:SetSize(18, 18)
        swatch:SetPoint("CENTER")
        swatch:SetTexture("Interface\\Buttons\\WHITE8X8")
        local function UpdateSwatch()
            local c = ns.db[dbKey] or {r=1, g=1, b=1}
            swatch:SetVertexColor(c.r, c.g, c.b)
        end
        UpdateSwatch()
        local lbl = content:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
        lbl:SetPoint("LEFT", btn, "RIGHT", 8, 0)
        lbl:SetText(label or ns.L.Color)
        btn:SetScript("OnClick", function()
            local c = ns.db[dbKey] or {r=1, g=1, b=1}
            ColorPickerFrame:SetupColorPickerAndShow({
                r = c.r, g = c.g, b = c.b,
                swatchFunc = function()
                    local r, g, b = ColorPickerFrame:GetColorRGB()
                    ns.db[dbKey] = {r=r, g=g, b=b}
                    UpdateSwatch(); ns.UpdateState()
                end,
                cancelFunc = function()
                    ns.db[dbKey] = c; UpdateSwatch(); ns.UpdateState()
                end
            })
        end)
        if not hold then y = y - 32 end
        return btn
    end

    function ui:Edit(label, dbKey, xOff, hold, fallback, transform)
        local x = pad + (xOff or 0)
        local lbl = content:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
        lbl:SetPoint("TOPLEFT", x, y)
        lbl:SetText(label)
        local eb = CreateFrame("EditBox", nil, content, "InputBoxTemplate")
        eb:SetSize(180, 32)
        eb:SetPoint("TOPLEFT", x + 4, y - 15)
        eb:SetAutoFocus(false)
        local val = ns.db[dbKey]
        if fallback then
            if val == nil then
                val = fallback
            elseif type(val) == "string" and val:gsub("%s", "") == "" then
                val = fallback
            end
        end
        eb:SetText(val ~= nil and tostring(val) or "")
        local function Save()
            local text = eb:GetText()
            local v2 = transform and transform(text) or text
            if v2 == nil then v2 = text end
            ns.db[dbKey] = v2
            ns.UpdateState()
        end
        eb:SetScript("OnEnterPressed", function(self)
            Save()
            self:ClearFocus()
        end)
        eb:SetScript("OnEditFocusLost", function(self)
            Save()
        end)
        if not hold then y = y - 60 end
        return eb
    end

    function ui:Dropdown(label, dbKey, options, xOff, hold)
        local x = pad + (xOff or 0)
        local dd = CreateFrame("Frame", "VS_DD_" .. dbKey, content, "UIDropDownMenuTemplate")
        dd:SetPoint("TOPLEFT", x - 16, y - 15)
        local lbl = content:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
        lbl:SetPoint("BOTTOMLEFT", dd, "TOPLEFT", 20, 0)
        lbl:SetText(label)
        UIDropDownMenu_SetWidth(dd, 150)
        local function OnSelect(self)
            ns.db[dbKey] = self.value
            UIDropDownMenu_SetText(dd, self:GetText())
            ns.UpdateState()
            CloseDropDownMenus()
        end
        UIDropDownMenu_Initialize(dd, function()
            local info = UIDropDownMenu_CreateInfo()
            for _, opt in ipairs(options or {}) do
                info.text = opt.text; info.value = opt.value; info.func = OnSelect
                info.icon = opt.icon
                info.iconWidth = opt.icon and 16 or nil
                info.iconHeight = opt.icon and 16 or nil
                info.checked = (ns.db[dbKey] == opt.value)
                UIDropDownMenu_AddButton(info)
            end
        end)
        for _, opt in ipairs(options or {}) do
            if opt.value == ns.db[dbKey] then UIDropDownMenu_SetText(dd, opt.text) end
        end
        if not hold then y = y - 60 end
        return dd
    end

    function ui:Button(text, onClick, xOff, hold, width)
        local x = pad + (xOff or 0)
        local btn = CreateFrame("Button", nil, content, "UIPanelButtonTemplate")
        btn:SetSize(width or 140, 24)
        btn:SetPoint("TOPLEFT", x, y)
        btn:SetText(text)
        btn:SetScript("OnClick", onClick)
        if not hold then y = y - 32 end
        return btn
    end

    function ui:Space(h) y = y - (h or 20) end
    function ui:GetY() return y end
    function ui:SetY(v2) y = v2 end

    return ui
end
