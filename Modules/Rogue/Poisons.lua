-- ============================================================================
-- [[ ROGUE: POISON TRACKER ]] ------------------------------------------------
-- ============================================================================
local addonName, ns = ...
ns.Modules = ns.Modules or {}
ns.Modules.Poisons = {}

-- [[ CONSTANTS & DATABASE ]] -------------------------------------------------

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

-- ============================================================================
-- [[ INTERFACE BUILDER ]] ----------------------------------------------------
-- ============================================================================
local poisonUI = nil
local function GetPoisonFrames()
    if poisonUI then return poisonUI end
    poisonUI = { lethal = {}, nonLethal = {} }
    local function Build(kind, namePrefix, label, frameName)
        local frame = ns.UI.CreateTrackerFrame(namePrefix, label)
        frame.name = frameName
        poisonUI[kind] = { frame = frame, textFrame = frame, text = frame.Text, iconFrame = frame, icon = frame.Icon }
    end
    -- Specific tracker builds
    Build("lethal", "NV_PoisonLethal", ns.L and ns.L.LethalPoisons or "Lethal Poison", ns.L and ns.L.LethalPoisons or "Lethal Poison")
    Build("nonLethal", "NV_PoisonNonLethal", ns.L and ns.L.NonLethalPoisons or "Non-Lethal Poison", ns.L and ns.L.NonLethalPoisons or "Non-Lethal Poison")
    return poisonUI
end

ns._poisonState = ns._poisonState or {
    lethalMissing = false,
    nonLethalMissing = false,
    lastSoundTime = {lethal = 0, nonLethal = 0},
}

-- ============================================================================
-- [[ REFRESH LOGIC ]] --------------------------------------------------------
-- ============================================================================
function ns.Modules.Poisons.RefreshVisuals(force)
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
        if ns._poisonLastState then
            ns._poisonLastState.lethal = -1
            ns._poisonLastState.nonLethal = -1
        end
    end

    ns._poisonLastState = ns._poisonLastState or { lethal = -1, nonLethal = -1 }

    local required = (IsPlayerSpell and IsPlayerSpell(DRAGON_TEMPERED_BLADES_SPELL_ID)) and 2 or 1
    local missingLethal = math.max(0, required - CountActivePoisons(LETHAL_POISONS))
    local missingNonLethal = math.max(0, required - CountActivePoisons(NON_LETHAL_POISONS))

    local function IsHidden(kind)
        local onlyCombat = db["poison" .. kind .. "OnlyCombat"]
        local onlyInstances = db["poison" .. kind .. "OnlyInstances"]
        local disableDungeons = db["poison" .. kind .. "DisableInDungeons"]
        local disableRaids = db["poison" .. kind .. "DisableInRaids"]

        if onlyCombat and not UnitAffectingCombat("player") then return true end
        
        local inInstance, instanceType = IsInInstance()
        if onlyInstances and not inInstance then return true end

        if disableDungeons and inInstance and instanceType == "party" then return true end
        if disableRaids and (IsInRaid() or (inInstance and instanceType == "raid")) then return true end

        return false
    end

    local showLethal = lethalEnabled and missingLethal > 0 and not IsHidden("Lethal")
    local showNonLethal = nonLethalEnabled and missingNonLethal > 0 and not IsHidden("NonLethal")

    if ns._poisonLastState.lethal == missingLethal and ns._poisonLastState.nonLethal == missingNonLethal and not force then
        return
    end

    ns._poisonLastState.lethal = missingLethal
    ns._poisonLastState.nonLethal = missingNonLethal

    local frames = GetPoisonFrames()

    local function UpdatePoisonFrame(kind, show, missing, enableText, customText, fallbackText, textSize, textAlpha, x, y, enableIcon, iconTexture, iconSpell, iconSize, iconAlpha, anchorToText, anchorPoint, iconX, iconY, color)
        local f = frames[kind]
        if show then
            if enableText then
                local text = (customText and customText:gsub("%s", "") ~= "") and customText or fallbackText
                text = text:gsub("%%m", tostring(missing)):gsub("%%r", tostring(required))
                f.text:SetText(text)
                f.text:SetFont(STANDARD_TEXT_FONT, textSize or 28, "OUTLINE")
                
                if color then
                    f.text:SetTextColor(color.r or 1, color.g or 1, color.b or 1, textAlpha or 1)
                else
                    f.text:SetAlpha(textAlpha or 1)
                end

                f.text:ClearAllPoints()
                f.text:SetPoint("CENTER", UIParent, "CENTER", x or 0, y or 0)
                f.text:Show()
            else
                f.text:Hide()
            end

            if enableIcon then
                if not iconTexture or iconTexture == "" then iconTexture = GetSpellTexture(iconSpell) end
                f.icon:SetTexture(iconTexture or "Interface\\Icons\\INV_Misc_QuestionMark")
                f.icon:SetSize(iconSize or 36, iconSize or 36)
                f.icon:SetAlpha(iconAlpha or 1)
                f.icon:ClearAllPoints()
                if anchorToText and enableText then
                    ns.UI.AnchorIconToText(f.icon, f.text, anchorPoint or "LEFT", iconX or 5, iconY or 0)
                else
                    f.icon:SetPoint("CENTER", UIParent, "CENTER", iconX or 5, iconY or 0)
                end
                f.icon:Show()
            else
                f.icon:Hide()
            end

            f.frame:Show()
        else
            f.frame:Hide()
        end
    end

    UpdatePoisonFrame("lethal", showLethal, missingLethal, db.poisonLethalEnableText, db.poisonLethalCustomText, ns.L and ns.L.LethalPoisonMissing or "LETHAL POISON MISSING", db.poisonLethalTextSize, db.poisonLethalTextAlpha, db.poisonLethalTextX, db.poisonLethalTextY, db.poisonLethalEnableIcon, db.poisonLethalIconTexture, db.poisonLethalIconSpellId, db.poisonLethalIconSize, db.poisonLethalIconAlpha, db.poisonLethalIconAnchorToText, db.poisonLethalIconAnchorPoint, db.poisonLethalIconX, db.poisonLethalIconY, db.poisonLethalTextColor)
    UpdatePoisonFrame("nonLethal", showNonLethal, missingNonLethal, db.poisonNonLethalEnableText, db.poisonNonLethalCustomText, ns.L and ns.L.NonLethalPoisonMissing or "NON-LETHAL POISON MISSING", db.poisonNonLethalTextSize, db.poisonNonLethalTextAlpha, db.poisonNonLethalTextX, db.poisonNonLethalTextY, db.poisonNonLethalEnableIcon, db.poisonNonLethalIconTexture, db.poisonNonLethalIconSpellId, db.poisonNonLethalIconSize, db.poisonNonLethalIconAlpha, db.poisonNonLethalIconAnchorToText, db.poisonNonLethalIconAnchorPoint, db.poisonNonLethalIconX, db.poisonNonLethalIconY, db.poisonNonLethalTextColor)

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

-- ============================================================================
-- [[ INITIALIZATION & EXPORTS ]] ---------------------------------------------
-- ============================================================================
ns.Modules.Poisons.Init = function()
end

ns.RefreshPoisonVisuals = ns.Modules.Poisons.RefreshVisuals
