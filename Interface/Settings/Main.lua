-- ============================================================================
-- [[ SETTINGS UI CORE ]] -----------------------------------------------------
-- ============================================================================
local addonName, ns = ...
local SettingsLib = LibStub("LibEQOLSettingsMode-1.0")
SettingsLib:SetVariablePrefix("Nightveil_")

ns.Modules = ns.Modules or {}
ns.Modules.Settings = {}

-- [[ UI HELPERS ]] -----------------------------------------------------------
function ns.Modules.Settings.Get(key, default)
    local v = ns.db and ns.db[key]
    if v == nil then return default end
    return v
end

function ns.Modules.Settings.GetColor(key, dr, dg, db)
    local c = ns.db and ns.db[key]
    if not c then return dr or 0.64, dg or 0.38, db or 0.89 end
    return (c.r or dr or 0.64), (c.g or dg or 0.38), (c.b or db or 0.89)
end

-- [[ DATA TABLES & ENUMERATIONS ]] -------------------------------------------

-- ============================================================================
-- [[ CHANGELOG BUILDER ]] ----------------------------------------------------
-- ============================================================================
local function BuildChangelog(cat)
    local notes = ns.ReleaseNotes and ns.ReleaseNotes.notes or {}

    local function parse(v)
        v = tostring(v or ""):gsub("^v", "")
        local num, suffix = v:match("([%d%.]+)(%a*)")
        local parts = {}
        if num then
            for part in num:gmatch("%d+") do parts[#parts + 1] = tonumber(part) or 0 end
        end
        return parts, suffix or ""
    end

    local function newer(a, b)
        local pa, sa = parse(a); local pb, sb = parse(b)
        local maxlen = math.max(#pa, #pb)
        for i = 1, maxlen do
            local na, nb = pa[i] or 0, pb[i] or 0
            if na ~= nb then return na > nb end
        end
        return tostring(a) > tostring(b)
    end

    local versions = {}
    for v in pairs(notes) do table.insert(versions, v) end
    table.sort(versions, newer)

    if #versions == 0 then return end

    SettingsLib:CreateHeader(cat, { name = "|cffffffff" .. (ns.L and ns.L.ReleaseNotes or "Release Notes") .. "|r" })
    local maxVersions = math.min(#versions, 20)

    for i = 1, maxVersions do
        local v = versions[i]
        SettingsLib:CreateHeader(cat, { name = "|cffFFD700" .. tostring(v) .. "|r" })
        local entries = notes[v] or {}
        for _, entry in ipairs(entries) do
            local line = tostring(entry):gsub("^%s*[•%-–—]+%s*", "")
            SettingsLib:CreateText(cat, { text = "  • " .. line, height = 12, offsetY = -4, basePadding = 0 })
        end
    end
end

StaticPopupDialogs["NIGHTVEIL_CONFIRM_FACTORY_RESET"] = {
    text = ns.L and ns.L.FactoryResetConfirm or "|cffff0000WARNING:|r This will delete |cffff0000ALL|r your Nightveil settings and profiles. Are you sure?",
    button1 = YES,
    button2 = NO,
    OnAccept = function()
        if ns.Modules.Tricks and ns.Modules.Tricks.DisableAndRemoveMacro then ns.Modules.Tricks.DisableAndRemoveMacro() end
        NightveilDB = nil
        NightveilProfiles = nil
        ReloadUI()
    end,
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
    preferredIndex = 3,
}

-- ============================================================================
-- [[ INITIALIZATION & LAYOUT ]] ----------------------------------------------
-- ============================================================================
ns.Modules.Settings.Init = function()
    local function EnsureProfilePopups()
        if StaticPopupDialogs["NIGHTVEIL_CREATE_PROFILE"] then return end
        ns._pendingExportString = nil; ns._pendingImportString = nil

        StaticPopupDialogs["NIGHTVEIL_DELETE_RESTRICTED"] = {
            text = ns.GetAddonName() .. "\n\n|cffff2020" .. (ns.L and ns.L.ErrorProfileDeleteRestricted or "You cannot delete the Default profile.") .. "|r",
            button1 = "OK",
            timeout = 0, whileDead = true, hideOnEscape = true, preferredIndex = 3,
        }

        StaticPopupDialogs["NIGHTVEIL_CREATE_PROFILE"] = {
            text = ns.L and ns.L.CreateProfilePrompt or "Enter a name for the new profile:",
            button1 = ns.L and ns.L.CreateProfile or "Create", button2 = CANCEL, hasEditBox = true, maxLetters = 32,
            OnAccept = function(self)
                local editBox = self.editBox or (self.GetEditBox and self:GetEditBox())
                local name = editBox and strtrim(editBox:GetText() or "") or ""
                if name ~= "" and ns.Shared.CreateProfile(name) then ns.Shared.SetActiveProfile(name) end
            end,
            OnShow = function(self)
                local editBox = self.editBox or (self.GetEditBox and self:GetEditBox())
                if editBox then editBox:SetText(""); editBox:SetFocus() end
            end,
            EditBoxOnEnterPressed = function(self) StaticPopup_OnClick(self:GetParent(), 1) end,
            EditBoxOnEscapePressed = function(self) self:GetParent():Hide() end,
            timeout = 0, whileDead = true, hideOnEscape = true, preferredIndex = 3,
        }

        StaticPopupDialogs["NIGHTVEIL_DUPLICATE_PROFILE"] = {
            text = ns.L and ns.L.DuplicateProfilePrompt or "Enter a name for the duplicated profile:",
            button1 = ns.L and ns.L.DuplicateProfile or "Duplicate", button2 = CANCEL, hasEditBox = true, maxLetters = 32,
            OnAccept = function(self)
                local editBox = self.editBox or (self.GetEditBox and self:GetEditBox())
                local name = editBox and strtrim(editBox:GetText() or "") or ""
                if name ~= "" and ns.Shared.CreateProfile(name, ns.Shared.GetActiveProfileName()) then ns.Shared.SetActiveProfile(name) end
            end,
            OnShow = function(self)
                local editBox = self.editBox or (self.GetEditBox and self:GetEditBox())
                if editBox then editBox:SetText(""); editBox:SetFocus() end
            end,
            EditBoxOnEnterPressed = function(self) StaticPopup_OnClick(self:GetParent(), 1) end,
            EditBoxOnEscapePressed = function(self) self:GetParent():Hide() end,
            timeout = 0, whileDead = true, hideOnEscape = true, preferredIndex = 3,
        }

        StaticPopupDialogs["NIGHTVEIL_CONFIRM_DELETE_PROFILE"] = {
            text = ns.L and ns.L.DeleteProfileConfirm or "Delete profile:\n\n|cffff0000%s|r\n\nThis cannot be undone.",
            button1 = DELETE, button2 = CANCEL,
            OnAccept = function(_, name) if type(name) == "string" and name ~= "" then ns.Shared.DeleteProfile(name) end end,
            timeout = 0, whileDead = true, hideOnEscape = true, preferredIndex = 3,
        }

        StaticPopupDialogs["NIGHTVEIL_EXPORT_PROFILE"] = {
            text = ns.L and ns.L.ExportProfilePrompt or "Copy this export string (Ctrl+C):\n\nProfile: |cff00ff00%s|r",
            button1 = CLOSE, hasEditBox = true, editBoxWidth = 350, maxLetters = 0,
            OnShow = function(self)
                local editBox = self.editBox or (self.GetEditBox and self:GetEditBox())
                if editBox then editBox:SetMaxLetters(0); editBox:SetText(ns._pendingExportString or ""); editBox:SetFocus(); editBox:HighlightText() end
            end,
            EditBoxOnEscapePressed = function(self) self:GetParent():Hide() end,
            timeout = 0, whileDead = true, hideOnEscape = true, preferredIndex = 3,
        }

        StaticPopupDialogs["NIGHTVEIL_IMPORT_PROFILE_STRING"] = {
            text = ns.L and ns.L.ImportProfilePrompt or "Paste the profile export string below:",
            button1 = ns.L and ns.L.Next or "Next", button2 = CANCEL, hasEditBox = true, editBoxWidth = 350, maxLetters = 0,
            OnAccept = function(self)
                local editBox = self.editBox or (self.GetEditBox and self:GetEditBox())
                local s = editBox and strtrim(editBox:GetText() or "") or ""
                if s ~= "" then ns._pendingImportString = s; StaticPopup_Show("NIGHTVEIL_IMPORT_PROFILE_NAME") end
            end,
            OnShow = function(self)
                local editBox = self.editBox or (self.GetEditBox and self:GetEditBox())
                if editBox then editBox:SetMaxLetters(0); editBox:SetText(""); editBox:SetFocus() end
            end,
            EditBoxOnEnterPressed = function(self) StaticPopup_OnClick(self:GetParent(), 1) end,
            EditBoxOnEscapePressed = function(self) ns._pendingImportString = nil; self:GetParent():Hide() end,
            timeout = 0, whileDead = true, hideOnEscape = true, preferredIndex = 3,
        }

        StaticPopupDialogs["NIGHTVEIL_IMPORT_PROFILE_NAME"] = {
            text = ns.L and ns.L.ImportProfileNamePrompt or "Enter a name for the imported profile:",
            button1 = ns.L and ns.L.Import or "Import", button2 = CANCEL, hasEditBox = true, maxLetters = 32,
            OnAccept = function(self)
                local importString = ns._pendingImportString; ns._pendingImportString = nil
                if not importString then return end
                local editBox = self.editBox or (self.GetEditBox and self:GetEditBox())
                local name = editBox and strtrim(editBox:GetText() or "") or ""
                if name ~= "" then
                    local ok, target = ns.Shared.ImportProfileString(importString, name)
                    if ok then ns.Shared.SetActiveProfile(target) end
                end
            end,
            OnShow = function(self)
                local editBox = self.editBox or (self.GetEditBox and self:GetEditBox())
                if editBox then editBox:SetText(""); editBox:SetFocus() end
            end,
            OnCancel = function() ns._pendingImportString = nil end,
            EditBoxOnEnterPressed = function(self) StaticPopup_OnClick(self:GetParent(), 1) end,
            EditBoxOnEscapePressed = function(self) ns._pendingImportString = nil; self:GetParent():Hide() end,
            timeout = 0, whileDead = true, hideOnEscape = true, preferredIndex = 3,
        }
    end

    EnsureProfilePopups()
    if ns.settingsInitialized then return end
    ns.settingsInitialized = true

    ns.MainCategory = SettingsLib:CreateRootCategory(ns.GetAddonName(), false)
    local root = ns.MainCategory

    BuildChangelog(root)

    -- Generic Hidden State tab (for all classes)
    if ns.Modules.HiddenStateSettings and ns.Modules.HiddenStateSettings.Init then
        ns.Modules.HiddenStateSettings.Init(root)
    end

    -- Class-exclusive tabs
    if ns.IsRogue and ns.Modules.RogueSettings and ns.Modules.RogueSettings.Init then
        ns.Modules.RogueSettings.Init(root)
    end
    if ns.IsHunter and ns.Modules.HunterSettings and ns.Modules.HunterSettings.Init then
        ns.Modules.HunterSettings.Init(root)
    end

    -- Highlights tab (Shared for all classes)
    if ns.Modules.HighlightSettings and ns.Modules.HighlightSettings.Init then
        ns.Modules.HighlightSettings.Init(root)
    end

    -- Profiles Management tab (Shared for all classes)
    local profilesCat = SettingsLib:CreateCategory(root, ns.L and ns.L.Profiles or "Profiles", false)
    SettingsLib:CreateHeader(profilesCat, { name = ns.L and ns.L.Management or "Management" })
    SettingsLib:CreateScrollDropdown(profilesCat, {
        key = "profileActive", name = ns.L and ns.L.ActiveProfile or "Active Profile", default = ns.Shared.GetActiveProfileName(),
        get = function() return ns.Shared.GetActiveProfileName() end,
        set = function(v) ns.Shared.SetActiveProfile(v) end,
        optionfunc = function()
            local list = {}
            local versionLabel = ns.Version and ("v" .. ns.Version) or ""
            local defaultLabel = ns.L and ns.L.DefaultProfileLabel or "Default"
            for _, name in ipairs(ns.Shared.GetProfiles()) do 
                local label = (name == "Default") and defaultLabel or name
                table.insert(list, { label = label, value = name }) 
            end
            return list
        end,
        desc = ns.L and ns.L.ActiveProfileDesc or "Select which profile to use for this character.",
    })
    SettingsLib:CreateButton(profilesCat, { text = ns.L and ns.L.CreateProfile or "Create Profile", func = function() StaticPopup_Show("NIGHTVEIL_CREATE_PROFILE") end, desc = ns.L and ns.L.CreateProfileDesc or "Create a new profile with default settings." })
    SettingsLib:CreateButton(profilesCat, { text = ns.L and ns.L.DuplicateProfile or "Duplicate Profile", func = function() StaticPopup_Show("NIGHTVEIL_DUPLICATE_PROFILE") end, desc = ns.L and ns.L.DuplicateProfileDesc or "Create a copy of the current profile." })
    SettingsLib:CreateButton(profilesCat, {
        text = ns.L and ns.L.DeleteProfile or "Delete Profile",
        func = function()
            local active = ns.Shared.GetActiveProfileName()
            if active ~= "Default" then
                StaticPopup_Show("NIGHTVEIL_CONFIRM_DELETE_PROFILE", active, nil, active)
            else
                StaticPopup_Show("NIGHTVEIL_DELETE_RESTRICTED", active)
            end
        end,
        desc = ns.L and ns.L.DeleteProfileDesc or "Remove the selected profile. Cannot delete the Default profile.",
    })
    SettingsLib:CreateButton(profilesCat, {
        text = "|cffff0000" .. (ns.L and ns.L.FactoryResetBtn or "Factory Reset") .. "|r",
        func = function()
            StaticPopup_Show("NIGHTVEIL_CONFIRM_FACTORY_RESET")
        end,
        desc = ns.L and ns.L.FactoryResetBtnDesc or "Deletes all addon data and macros, restoring to a clean installation. UI will reload.",
    })
    SettingsLib:CreateHeader(profilesCat, { name = ns.L and ns.L.Share or "Share" })
    SettingsLib:CreateButton(profilesCat, {
        text = ns.L and ns.L.ExportProfile or "Export Profile",
        func = function() ns._pendingExportString = ns.Shared.ExportProfileString(); StaticPopup_Show("NIGHTVEIL_EXPORT_PROFILE", ns.Shared.GetActiveProfileName()) end,
        desc = ns.L and ns.L.ExportProfileDesc or "Generate a shareable string for this profile.",
    })
    SettingsLib:CreateButton(profilesCat, { text = ns.L and ns.L.ImportProfile or "Import Profile", func = function() StaticPopup_Show("NIGHTVEIL_IMPORT_PROFILE_STRING") end, desc = ns.L and ns.L.ImportProfileDesc or "Import a profile from a shared string." })
end

