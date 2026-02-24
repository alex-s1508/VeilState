local addonName, ns = ...

function ns.InitMainPanel()
    local panel = CreateFrame("Frame", "VS_MainPanel")
    local cat, layout = Settings.RegisterCanvasLayoutCategory(panel, "Night|cffA361E2veil|r")

    if layout and layout.AddAnchorPoint then
        layout:AddAnchorPoint("TOPLEFT", 0, 0)
        layout:AddAnchorPoint("BOTTOMRIGHT", 0, 0)
    end

    local targetCategory = cat or (layout and layout.GetCategory and layout:GetCategory())
    if targetCategory then
        ns.MainCategory = targetCategory
        Settings.RegisterAddOnCategory(targetCategory)
    end

    local content = ns.CreateScrollPanel(panel)
    local ui = ns.CreateUI(content)

    local title = content:CreateFontString(nil, "ARTWORK", "GameFontNormalHuge")
    title:SetPoint("TOPLEFT", 16, -16)
    title:SetText("Night|cffA361E2veil|r")

    local desc = content:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
    desc:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -4)
    desc:SetText(ns.L.Description)

    local resetBtn = CreateFrame("Button", nil, content, "UIPanelButtonTemplate")
    resetBtn:SetSize(140, 24)
    resetBtn:SetPoint("TOPRIGHT", content, "TOPRIGHT", -16, -20)
    resetBtn:SetText(ns.L.Reset)
    local function DoReset()
        NightveilDB = NightveilDB or {}
        wipe(NightveilDB)
        ns.CopyDefaults(ns.Defaults, NightveilDB)
        ReloadUI()
    end
    resetBtn:SetScript("OnClick", function()
        if StaticPopup_Show and StaticPopupDialogs then
            StaticPopupDialogs.NIGHTVEIL_RESET_CONFIRM = StaticPopupDialogs.NIGHTVEIL_RESET_CONFIRM or {
                text = ns.L.ResetConfirm or "Reset settings to defaults?",
                button1 = YES,
                button2 = NO,
                OnAccept = DoReset,
                timeout = 0,
                whileDead = true,
                hideOnEscape = true,
                preferredIndex = 3,
            }
            StaticPopup_Show("NIGHTVEIL_RESET_CONFIRM")
        else
            DoReset()
        end
    end)

    ui:Space(60)
    ui:Header(ns.L.ReleaseNotes)

    local versions = {}
    for v, _ in pairs(ns.ReleaseNotes.notes) do
        table.insert(versions, v)
    end

    local function parse_version(v)
        v = v:gsub("^v", "")
        local num, suffix = v:match("([%d%.]+)(%a*)")
        local parts = {}
        if num then
            for part in num:gmatch("%d+") do
                table.insert(parts, tonumber(part))
            end
        end
        suffix = suffix or ""
        return parts, suffix
    end

    local function compare_versions(a, b)
        local pa, sa = parse_version(a)
        local pb, sb = parse_version(b)
        local maxlen = #pa > #pb and #pa or #pb
        for i = 1, maxlen do
            local na = pa[i] or 0
            local nb = pb[i] or 0
            if na ~= nb then
                return na > nb
            end
        end

        if sa ~= sb then
            if sa == "" then return false end
            if sb == "" then return true end
            return sa > sb
        end
        return false
    end

    table.sort(versions, compare_versions)

    for _, v in ipairs(versions) do
        local notes = ns.ReleaseNotes.notes[v]

        local vL = content:CreateFontString(nil, "ARTWORK", "GameFontNormal")
        vL:SetPoint("TOPLEFT", 16, ui:GetY())
        vL:SetText(v)
        vL:SetTextColor(1, 0.8, 0)

        ui:Space(16)

        local nL = content:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
        nL:SetPoint("TOPLEFT", 16, ui:GetY())
        nL:SetJustifyH("LEFT")
        nL:SetText(table.concat(notes, "\n"))

        ui:Space(#notes * 12 + 12)
    end

    return targetCategory
end
