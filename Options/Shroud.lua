local addonName, ns = ...

local function SetControlEnabled(control, enabled)
    if not control then return end
    if control.SetEnabled then
        control:SetEnabled(enabled)
    elseif enabled and control.Enable then
        control:Enable()
    elseif not enabled and control.Disable then
        control:Disable()
    end

    if UIDropDownMenu_EnableDropDown and UIDropDownMenu_DisableDropDown then
        if control.GetObjectType and control:GetObjectType() == "Frame" and control.initialize then
            if enabled then
                UIDropDownMenu_EnableDropDown(control)
            else
                UIDropDownMenu_DisableDropDown(control)
            end
        end
    end
end

local function HookCheckRefresh(checkbox, fn)
    if not checkbox or not fn then return end
    local orig = checkbox:GetScript("OnClick")
    checkbox:SetScript("OnClick", function(self, button)
        if orig then orig(self, button) end
        fn()
    end)
end

function ns.InitShroudPanel(category)
    local panel = CreateFrame("Frame", "VS_ShroudPanel")
    local content = ns.CreateScrollPanel(panel)
    local ui = ns.CreateUI(content)

    local channels = {
        {text = "Say",      value = "SAY"},
        {text = "Party",    value = "PARTY"},
        {text = "Raid",     value = "RAID"},
        {text = "Instance", value = "INSTANCE_CHAT"},
        {text = "Yell",     value = "YELL"},
    }

    ui:Header(ns.L.Settings)
    local rowY = ui:GetY()
    local enableCheck = ui:Check("shroudCountdown", ns.L.Countdown)
    local afterRowY = ui:GetY()
    ui:SetY(rowY)
    ui:Check("shroudOnlyInstances", ns.L.OnlyInInstances or "Only in instances", 220)
    ui:SetY(afterRowY)
    local channelDrop = ui:Dropdown(ns.L.ChatChannel, "shroudChannel", channels)
    local intervalCheck = ui:Check("shroudInterval", ns.L.ShroudInterval)
    local intervalHint = content:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
    intervalHint:SetPoint("TOPLEFT", 45, ui:GetY() + 4)
    intervalHint:SetText(ns.L.ShroudIntervalDesc)
    intervalHint:SetTextColor(0.7, 0.7, 0.7)

    ui:Space(20)
    ui:Header(ns.L.Messages)
    local msgEdit = ui:Edit(ns.L.ShroudMessage, "shroudMessage", 0, false, "%t")
    local hint = content:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
    hint:SetPoint("TOPLEFT", 20, ui:GetY() + 10)
    hint:SetText("|cffaaaaaa" .. (ns.L.TimeRemainingHint or "%t = time remaining") .. "|r")
    
    ui:Space(16)
    local startEdit = ui:Edit(ns.L.ShroudOnStart, "shroudStartMsg")
    local endEdit = ui:Edit(ns.L.ShroudOnEnd, "shroudEndMsg")

    local function RefreshEnabled()
        local db = ns.db or {}
        local on = db.shroudCountdown ~= false
        SetControlEnabled(channelDrop, on)
        SetControlEnabled(intervalCheck, on)
        SetControlEnabled(msgEdit, on)
        SetControlEnabled(startEdit, on)
        SetControlEnabled(endEdit, on)
    end

    HookCheckRefresh(enableCheck, RefreshEnabled)
    RefreshEnabled()

    Settings.RegisterCanvasLayoutSubcategory(category, panel, ns.L.ShroudOfConcealment)
end
