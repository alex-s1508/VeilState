-- ============================================================================
-- [[ INTERFACE & FRAMES CORE ]] ----------------------------------------------
-- ============================================================================
local addonName, ns = ...
ns.UI = ns.UI or {}

-- [[ FRAME FACTORY ]] --------------------------------------------------------

function ns.UI.CreateTrackerFrame(name, label)
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

-- ============================================================================
-- [[ STATIC FRAME REGISTRATION ]] -------------------------------------------
-- ============================================================================
ns.UI.HiddenStateFrame = ns.UI.CreateTrackerFrame("NV_HiddenStateFrame", ns.L and ns.L.HiddenStateActiveText or "HIDDEN")

ns.UI.ScreenFrame = CreateFrame("Frame", "VS_ScreenFrame", UIParent)
ns.UI.ScreenFrame:SetAllPoints(UIParent)
ns.UI.ScreenFrame:Hide()

ns.UI.ScreenOverlay = ns.UI.ScreenFrame:CreateTexture(nil, "BACKGROUND")
ns.UI.ScreenOverlay:SetAllPoints(UIParent)
ns.UI.ScreenOverlay:SetTexture("Interface\\Buttons\\WHITE8X8")

ns.UI.VignetteFrame = CreateFrame("Frame", "VS_VignetteFrame", ns.UI.ScreenFrame)
ns.UI.VignetteFrame:SetAllPoints(UIParent)

ns.UI.VignetteEdges = {}

function ns.UI.BuildVignettes()
    if ns.UI.VignetteEdges.top then return end
    local function MakeEdge(anchor)
        local t = ns.UI.VignetteFrame:CreateTexture(nil, "BACKGROUND")
        t:SetTexture("Interface\\Buttons\\WHITE8X8")
        t:SetPoint(anchor)
        return t
    end
    ns.UI.VignetteEdges.top    = MakeEdge("TOPLEFT");    ns.UI.VignetteEdges.top:SetPoint("TOPRIGHT")
    ns.UI.VignetteEdges.bottom = MakeEdge("BOTTOMLEFT"); ns.UI.VignetteEdges.bottom:SetPoint("BOTTOMRIGHT")
    ns.UI.VignetteEdges.left   = MakeEdge("TOPLEFT");    ns.UI.VignetteEdges.left:SetPoint("BOTTOMLEFT")
    ns.UI.VignetteEdges.right  = MakeEdge("TOPRIGHT");   ns.UI.VignetteEdges.right:SetPoint("BOTTOMRIGHT")
end

-- ============================================================================
-- [[ ANCHORING UTILITIES ]] --------------------------------------------------
-- ============================================================================
function ns.UI.AnchorIconToText(icon, text, anchorPoint, x, y)
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

