-- One self-contained settings window for the standalone nameplate module.

local Z = zNameplates
local PATH = "Interface\\AddOns\\zNameplates"

local alignments = {
  { "Left", "LEFT" }, { "Center", "CENTER" }, { "Right", "RIGHT" },
}
local positions = {
  { "Top left", "TOPLEFT" }, { "Top", "TOP" }, { "Top right", "TOPRIGHT" },
  { "Left", "LEFT" }, { "Center", "CENTER" }, { "Right", "RIGHT" },
  { "Bottom left", "BOTTOMLEFT" }, { "Bottom", "BOTTOM" }, { "Bottom right", "BOTTOMRIGHT" },
}
local fontStyles = {
  { "None", "" }, { "Outline", "OUTLINE" },
  { "Thick outline", "THICKOUTLINE" }, { "Monochrome", "MONOCHROME" },
}
local healthFormats = {
  { "Current / maximum", "curmaxs" }, { "Current - maximum", "curmax" },
  { "Current / maximum | percent", "curmaxpercs" }, { "Current - maximum | percent", "curmaxperc" },
  { "Current | percent", "curperc" }, { "Current", "cur" },
  { "Deficit", "deficit" }, { "Percent", "percent" },
}
local filters = {
  { "No filter", "none" }, { "Blacklist", "blacklist" }, { "Whitelist", "whitelist" },
}
local textures = {
  { "Smooth", PATH .. "\\Assets\\img\\bar.tga" },
  { "Gradient", PATH .. "\\Assets\\img\\bar_gradient.tga" },
  { "Striped", PATH .. "\\Assets\\img\\bar_striped.tga" },
  { "ElvUI", PATH .. "\\Assets\\img\\bar_elvui.tga" },
  { "TukUI", PATH .. "\\Assets\\img\\bar_tukui.tga" },
}
local fonts = {
  { "Myriad Pro", PATH .. "\\Assets\\fonts\\Myriad-Pro.ttf" },
  { "Big Noodle", PATH .. "\\Assets\\fonts\\BigNoodleTitling.ttf" },
  { "Expressway", PATH .. "\\Assets\\fonts\\Expressway.ttf" },
  { "PT Sans Narrow", PATH .. "\\Assets\\fonts\\PT-Sans-Narrow-Regular.ttf" },
  { "PT Sans Narrow Bold", PATH .. "\\Assets\\fonts\\PT-Sans-Narrow-Bold.ttf" },
  { "Roboto Mono", PATH .. "\\Assets\\fonts\\RobotoMono.ttf" },
  { "Continuum", PATH .. "\\Assets\\fonts\\Continuum.ttf" },
  { "Homespun", PATH .. "\\Assets\\fonts\\Homespun.ttf" },
  { "Hooge", PATH .. "\\Assets\\fonts\\Hooge.ttf" },
  { "Die Die Die", PATH .. "\\Assets\\fonts\\DieDieDie.ttf" },
}

local pages = {
  {
    name = "General",
    items = {
      { "check", "Show hostile nameplates", {"nameplates","showhostile"} },
      { "check", "Show friendly nameplates", {"nameplates","showfriendly"} },
      { "check", "Disable hostile plates in friendly zones", {"nameplates","disable_hostile_in_friendly"} },
      { "check", "Disable friendly plates in friendly zones", {"nameplates","disable_friendly_in_friendly"} },
      { "input", "Vertical offset", {"nameplates","vertical_offset"} },
      { "input", "Inactive alpha (0-1)", {"nameplates","notargalpha"} },
      { "check", "Glow around target", {"nameplates","targetglow"} },
      { "color", "Target glow color", {"nameplates","glowcolor"} },
      { "check", "Red names while in combat", {"nameplates","namefightcolor"} },
      { "check", "Zoom target nameplate", {"nameplates","targetzoom"} },
      { "input", "Target zoom factor", {"nameplates","targetzoomval"} },
      { "input", "Nameplate width", {"nameplates","width"} },
      { "check", "Enemy player class colors", {"nameplates","enemyclassc"} },
      { "check", "Friendly player class colors", {"nameplates","friendclassc"} },
      { "check", "Class-color friendly names", {"nameplates","friendclassnamec"} },
      { "check", "Show combo points", {"nameplates","cpdisplay"} },
      { "check", "Click-through nameplates", {"nameplates","clickthrough"} },
      { "check", "Allow enemy nameplate overlap", {"nameplates","overlap_enemy"} },
      { "check", "Allow friendly nameplate overlap", {"nameplates","overlap_friendly"} },
      { "check", "Right-click mouselook/attack", {"nameplates","rightclick"} },
      { "input", "Right-click threshold", {"nameplates","clickthreshold"} },
      { "check", "Replace totems with icons", {"nameplates","totemicons"} },
      { "check", "Show guild/sub-name", {"nameplates","showguildname"} },
    },
  },
  {
    name = "Health",
    items = {
      { "input", "Healthbar vertical offset", {"nameplates","health","offset"} },
      { "input", "Healthbar height", {"nameplates","heighthealth"} },
      { "select", "Healthbar texture", {"nameplates","healthtexture"}, textures },
      { "check", "Show health text", {"nameplates","showhp"} },
      { "select", "Health text alignment", {"nameplates","hptextpos"}, alignments },
      { "select", "Name text alignment", {"nameplates","nametextpos"}, alignments },
      { "select", "Health text format", {"nameplates","hptextformat"}, healthFormats },
      { "check", "Vertical healthbar", {"nameplates","verticalhealth"} },
      { "check", "Hide bar: enemy NPCs", {"nameplates","enemynpc"} },
      { "check", "Hide bar: enemy players", {"nameplates","enemyplayer"} },
      { "check", "Hide bar: neutral NPCs", {"nameplates","neutralnpc"} },
      { "check", "Hide bar: friendly NPCs", {"nameplates","friendlynpc"} },
      { "check", "Hide bar: friendly players", {"nameplates","friendlyplayer"} },
      { "check", "Hide bar: critters", {"nameplates","critters"} },
      { "check", "Hide bar: totems", {"nameplates","totems"} },
      { "check", "Always show if health is missing", {"nameplates","fullhealth"} },
      { "check", "Always show target healthbar", {"nameplates","target"} },
      { "check", "Friendly-player blue outline", {"nameplates","outfriendly"} },
      { "check", "Friendly-NPC green outline", {"nameplates","outfriendlynpc"} },
      { "check", "Neutral yellow outline", {"nameplates","outneutral"} },
      { "check", "Enemy red outline", {"nameplates","outenemy"} },
      { "check", "Highlight target border", {"nameplates","targethighlight"} },
      { "color", "Target border color", {"nameplates","highlightcolor"} },
    },
  },
  {
    name = "Cast & Auras",
    items = {
      { "check", "Enable castbars", {"nameplates","showcastbar"} },
      { "check", "Only show target castbar", {"nameplates","targetcastbar"} },
      { "check", "Show spell name", {"nameplates","spellname"} },
      { "input", "Castbar height", {"nameplates","heightcast"} },
      { "select", "Castbar texture", {"appearance","castbar","texture"}, textures },
      { "color", "Cast color", {"appearance","castbar","castbarcolor"} },
      { "color", "Channel color", {"appearance","castbar","channelcolor"} },
      { "input", "Castbar decimal places", {"unitframes","castbardecimals"} },
      { "check", "Enable debuffs", {"nameplates","showdebuffs"} },
      { "check", "Show debuffs on hostile units", {"nameplates","showdebuffs_hostile"} },
      { "check", "Show debuffs on friendly units", {"nameplates","showdebuffs_friendly"} },
      { "check", "Only show your debuffs", {"nameplates","owndebuffs"} },
      { "select", "Debuff position", {"nameplates","debuffs","position"}, {{"Above","TOP"},{"Below","BOTTOM"}} },
      { "input", "Debuff icon offset", {"nameplates","debuffoffset"} },
      { "input", "Debuff icon size", {"nameplates","debuffsize"} },
      { "check", "Show debuff stacks", {"nameplates","debuffs","showstacks"} },
      { "check", "Enable debuff timers", {"nameplates","debufftimers"} },
      { "check", "Show timer text", {"nameplates","debufftext"} },
      { "check", "Show timer animation", {"nameplates","debuffanim"} },
      { "select", "Debuff filter mode", {"nameplates","debuffs","filter"}, filters },
      { "input", "Blacklist (spell names, separated by #)", {"nameplates","debuffs","blacklist"}, 185 },
      { "input", "Whitelist (spell names, separated by #)", {"nameplates","debuffs","whitelist"}, 185 },
      { "input", "Cooldown text size", {"appearance","cd","font_size"} },
      { "check", "Dynamic cooldown text size", {"appearance","cd","dynamicsize"} },
    },
  },
  {
    name = "Appearance",
    items = {
      { "check", "Use separate unit font", {"nameplates","use_unitfonts"} },
      { "select", "Default font", {"global","font_default"}, fonts },
      { "input", "Default font size", {"global","font_size"} },
      { "select", "Unit font", {"global","font_unit"}, fonts },
      { "input", "Unit font size", {"global","font_unit_size"} },
      { "select", "Font style", {"nameplates","name","fontstyle"}, fontStyles },
      { "select", "Cooldown font", {"appearance","cd","font"}, fonts },
      { "check", "Abbreviate long names", {"unitframes","abbrevname"} },
      { "select", "Number abbreviation", {"unitframes","abbrevnum"}, {{"Off","0"},{"Precise","1"},{"Compact","2"}} },
      { "check", "Use Blizzard raid icons", {"unitframes","blizzard_raidicons"} },
      { "select", "Raid icon position", {"nameplates","raidiconpos"}, positions },
      { "input", "Raid icon X offset", {"nameplates","raidiconoffx"} },
      { "input", "Raid icon Y offset", {"nameplates","raidiconoffy"} },
      { "input", "Raid icon size", {"nameplates","raidiconsize"} },
      { "color", "Border color", {"appearance","border","color"} },
      { "color", "Border background", {"appearance","border","background"} },
      { "input", "Default border size", {"appearance","border","default"} },
      { "input", "Nameplate border size (-1 = default)", {"appearance","border","nameplates"} },
      { "check", "Pixel-perfect borders", {"appearance","border","pixelperfect"} },
      { "check", "HiDPI border correction", {"appearance","border","hidpi"} },
      { "preview", "Nameplate Text Preview" },
    },
  },
  {
    name = "Threat",
    items = {
      { "check", "Combat state colors on border", {"nameplates","outcombatstate"} },
      { "check", "Combat state colors on healthbar", {"nameplates","barcombatstate"} },
      { "check", "State: unit attacking you", {"nameplates","ccombatthreat"} },
      { "color", "Attacking-you color", {"nameplates","combatthreat"} },
      { "check", "State: unit attacking off-tank", {"nameplates","ccombatofftank"} },
      { "color", "Off-tank color", {"nameplates","combatofftank"} },
      { "check", "State: unit attacking others", {"nameplates","ccombatnothreat"} },
      { "color", "Attacking-others color", {"nameplates","combatnothreat"} },
      { "check", "State: unit attacking nobody", {"nameplates","ccombatstun"} },
      { "color", "No-target/stunned color", {"nameplates","combatstun"} },
      { "check", "State: unit casting", {"nameplates","ccombatcasting"} },
      { "color", "Casting color", {"nameplates","combatcasting"} },
      { "input", "Off-tank names (separated by #)", {"nameplates","combatofftanks"}, 185 },
    },
  },
  {
    name = "MSBT & Advanced",
    items = {
      { "check", "Enable MSBT on nameplates", {"nameplates","msbt_enable"} },
      { "input", "MSBT X offset", {"nameplates","msbt_x"} },
      { "input", "MSBT Y offset", {"nameplates","msbt_y"} },
      { "input", "MSBT scroll height", {"nameplates","msbt_height"} },
      { "input", "Seconds before fade", {"nameplates","msbt_fade"} },
      { "select", "MSBT text alignment", {"nameplates","msbt_align"}, alignments },
      { "status", "MSBT status" },
      { "action", "Open MSBT font, color and text settings", nil, "Open MSBT", function()
          if MikSBT and MikSBT.CommandHandler then MikSBT.CommandHandler("")
          else DEFAULT_CHAT_FRAME:AddMessage("zNameplates: MikScrollingBattleText is not loaded.") end
        end },
      { "input", "Normal update rate (updates/sec)", {"throttle","nameplates"} },
      { "input", "Target update rate", {"throttle","nameplates_target"} },
      { "input", "Castbar update rate", {"throttle","nameplates_castbar"} },
      { "input", "Mass-nameplate update rate", {"throttle","nameplates_mass"} },
    },
  },
}

local function GetValue(path)
  local value = Z.config
  if not value then return "" end
  for i = 1, table.getn(path) do value = value[path[i]] end
  return value
end

local function SetValue(path, value)
  local target = Z.config
  for i = 1, table.getn(path) - 1 do target = target[path[i]] end
  target[path[table.getn(path)]] = tostring(value)
  Z.Refresh()
end

local frame = CreateFrame("Frame", "zNameplatesOptions", UIParent)
frame:SetWidth(820)
frame:SetHeight(590)
frame:SetPoint("CENTER", UIParent, "CENTER", 0, 20)
frame:SetFrameStrata("DIALOG")
frame:SetMovable(true)
frame:EnableMouse(true)
frame:RegisterForDrag("LeftButton")
frame:SetScript("OnDragStart", function() this:StartMoving() end)
frame:SetScript("OnDragStop", function() this:StopMovingOrSizing() end)
frame:SetBackdrop({ bgFile="Interface\\DialogFrame\\UI-DialogBox-Background", edgeFile="Interface\\DialogFrame\\UI-DialogBox-Border", tile=true, tileSize=32, edgeSize=32, insets={left=11,right=12,top=12,bottom=11} })
frame:Hide()

local title = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
title:SetPoint("TOP", frame, "TOP", 0, -18)
title:SetText("zNameplates")
local subtitle = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
subtitle:SetPoint("TOP", title, "BOTTOM", 0, -5)
subtitle:SetText("Standalone nameplates with embedded MSBT combat text")

local closeX = CreateFrame("Button", nil, frame, "UIPanelCloseButton")
closeX:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -4, -4)

local tabFrames = {}
local tabButtons = {}
local widgets = {}
local activeTab = 1

local function Label(parent, text, x, y)
  local label = parent:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
  label:SetPoint("TOPLEFT", parent, "TOPLEFT", x, y)
  label:SetWidth(230)
  label:SetJustifyH("LEFT")
  label:SetText(text)
  return label
end

local function ApplyColor(path, oldValue)
  local r, g, b = ColorPickerFrame:GetColorRGB()
  local a = 1 - (ColorPickerFrame.opacity or 0)
  if oldValue and not r then SetValue(path, oldValue) else SetValue(path, r .. "," .. g .. "," .. b .. "," .. a) end
end

local function CreateWidget(parent, item, index)
  local col = math.floor((index - 1) / 12)
  local row = math.mod(index - 1, 12)
  local x = 22 + col * 390
  local y = -18 - row * 34
  local kind, text, path = item[1], item[2], item[3]
  local widget = { kind=kind, path=path }

  if kind == "check" then
    local check = CreateFrame("CheckButton", nil, parent, "UICheckButtonTemplate")
    check:SetPoint("TOPLEFT", parent, "TOPLEFT", x, y + 5)
    check:SetWidth(24); check:SetHeight(24)
    local label = Label(parent, text, x + 27, y)
    label:SetWidth(300)
    check:SetScript("OnClick", function() SetValue(path, this:GetChecked() and "1" or "0") end)
    widget.control = check
  elseif kind == "input" then
    Label(parent, text, x, y)
    local input = CreateFrame("EditBox", nil, parent, "InputBoxTemplate")
    input:SetPoint("TOPRIGHT", parent, "TOPLEFT", x + 350, y + 5)
    input:SetWidth(item[4] or 105); input:SetHeight(24)
    input:SetAutoFocus(false)
    local function Commit() SetValue(path, input:GetText()) end
    input:SetScript("OnEditFocusGained", function() this.zNameplatesEditing = true end)
    input:SetScript("OnEnterPressed", function() Commit(); this:ClearFocus() end)
    input:SetScript("OnEscapePressed", function() this:SetText(GetValue(path)); this:ClearFocus() end)
    input:SetScript("OnEditFocusLost", function()
      this.zNameplatesEditing = nil
      Commit()
    end)
    widget.control = input
  elseif kind == "select" then
    Label(parent, text, x, y)
    local button = CreateFrame("Button", nil, parent, "UIPanelButtonTemplate")
    button:SetPoint("TOPRIGHT", parent, "TOPLEFT", x + 350, y + 3)
    button:SetWidth(150); button:SetHeight(23)
    button:SetScript("OnClick", function()
      local values = item[4]
      local current, found = GetValue(path), 1
      for i = 1, table.getn(values) do if values[i][2] == current then found = i end end
      found = IsShiftKeyDown() and found - 1 or found + 1
      if found < 1 then found = table.getn(values) elseif found > table.getn(values) then found = 1 end
      SetValue(path, values[found][2])
    end)
    widget.values = item[4]
    widget.control = button
  elseif kind == "color" then
    Label(parent, text, x, y)
    local button = CreateFrame("Button", nil, parent, "UIPanelButtonTemplate")
    button:SetPoint("TOPRIGHT", parent, "TOPLEFT", x + 350, y + 3)
    button:SetWidth(105); button:SetHeight(23)
    button:SetText("Choose")
    local swatch = button:CreateTexture(nil, "ARTWORK")
    swatch:SetPoint("LEFT", button, "LEFT", 7, 0); swatch:SetWidth(13); swatch:SetHeight(13)
    swatch:SetTexture("Interface\\BUTTONS\\WHITE8X8")
    button:SetScript("OnClick", function()
      local oldValue = GetValue(path)
      local r, g, b, a = Z.GetStringColor(oldValue)
      ColorPickerFrame.func = function() ApplyColor(path) end
      ColorPickerFrame.opacityFunc = function() ApplyColor(path) end
      ColorPickerFrame.cancelFunc = function() SetValue(path, oldValue) end
      ColorPickerFrame.hasOpacity = true
      ColorPickerFrame.opacity = 1 - (tonumber(a) or 1)
      ColorPickerFrame:SetColorRGB(tonumber(r) or 1, tonumber(g) or 1, tonumber(b) or 1)
      ColorPickerFrame:Show()
    end)
    widget.control = button
    widget.swatch = swatch
  elseif kind == "preview" then
    local preview = parent:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    preview:SetPoint("TOPLEFT", parent, "TOPLEFT", x, y - 3)
    preview:SetWidth(350); preview:SetHeight(28)
    preview:SetJustifyH("CENTER")
    preview:SetText(text)
    widget.control = preview
  elseif kind == "status" then
    local status = Label(parent, text, x, y)
    status:SetWidth(350)
    widget.control = status
  elseif kind == "action" then
    widget.path = nil
    Label(parent, text, x, y)
    local button = CreateFrame("Button", nil, parent, "UIPanelButtonTemplate")
    button:SetPoint("TOPRIGHT", parent, "TOPLEFT", x + 350, y + 3)
    button:SetWidth(105); button:SetHeight(23); button:SetText(tostring(item[4] or ""))
    button:SetScript("OnClick", item[5])
    widget.control = button
  end
  table.insert(widgets, widget)
end

local function ShowTab(index)
  activeTab = index
  for i = 1, table.getn(tabFrames) do
    if i == index then tabFrames[i]:Show(); tabButtons[i]:Disable()
    else tabFrames[i]:Hide(); tabButtons[i]:Enable() end
  end
  frame:Refresh()
end

for pageIndex = 1, table.getn(pages) do
  local tabIndex = pageIndex
  local pageData = pages[pageIndex]
  local button = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
  button:SetPoint("TOPLEFT", frame, "TOPLEFT", 20 + (pageIndex - 1) * 130, -68)
  button:SetWidth(125); button:SetHeight(24); button:SetText(pageData.name)
  button:SetScript("OnClick", function() ShowTab(tabIndex) end)
  tabButtons[pageIndex] = button

  local page = CreateFrame("Frame", nil, frame)
  page:SetPoint("TOPLEFT", frame, "TOPLEFT", 20, -103)
  page:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -20, 75)
  tabFrames[pageIndex] = page
  for itemIndex = 1, table.getn(pageData.items) do CreateWidget(page, pageData.items[itemIndex], itemIndex) end
end

local reset = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
reset:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", 25, 25)
reset:SetWidth(120); reset:SetHeight(25); reset:SetText("Reset defaults")
reset:SetScript("OnClick", function() Z.Reset() end)

local reload = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
reload:SetPoint("LEFT", reset, "RIGHT", 8, 0)
reload:SetWidth(120); reload:SetHeight(25); reload:SetText("Reload UI")
reload:SetScript("OnClick", ReloadUI)

local close = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
close:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -25, 25)
close:SetWidth(120); close:SetHeight(25); close:SetText("Close")
close:SetScript("OnClick", function() frame:Hide() end)

function frame:Refresh()
  if not Z.config then return end
  for i = 1, table.getn(widgets) do
    local widget = widgets[i]
    if widget.path then
      local value = GetValue(widget.path)
      if widget.kind == "check" then widget.control:SetChecked(value == "1")
      elseif widget.kind == "input" and not widget.control.zNameplatesEditing then widget.control:SetText(value or "")
      elseif widget.kind == "select" then
        local label = tostring(value or "")
        for j = 1, table.getn(widget.values) do if widget.values[j][2] == value then label = widget.values[j][1] end end
        widget.control:SetText(label)
      elseif widget.kind == "color" then
        local r, g, b = Z.GetStringColor(value)
        widget.swatch:SetVertexColor(tonumber(r) or 1, tonumber(g) or 1, tonumber(b) or 1)
      end
    elseif widget.kind == "preview" then
      local useUnit = Z.config.nameplates.use_unitfonts == "1"
      local font = useUnit and Z.font_unit or Z.font_default
      local size = tonumber(useUnit and Z.config.global.font_unit_size or Z.config.global.font_size) or 12
      local style = Z.config.nameplates.name.fontstyle or ""
      widget.control:SetFont(font, math.max(12, size + 3), style)
    elseif widget.kind == "status" then
      if MikSBT and MikSBT.CurrentProfile then
        widget.control:SetText("MSBT status: |cff55ff55loaded and connected|r")
      else
        widget.control:SetText("MSBT status: |cffff5555embedded runtime failed to initialize|r")
      end
    end
  end
end

frame:SetScript("OnShow", function() frame:Refresh() end)
ShowTab(activeTab)
Z.options = frame

SLASH_ZNAMEPLATES1 = "/znp"
SLASH_ZNAMEPLATES2 = "/znameplates"
SlashCmdList["ZNAMEPLATES"] = function() if frame:IsShown() then frame:Hide() else frame:Show() end end
