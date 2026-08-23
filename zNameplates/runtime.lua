-- Minimal standalone runtime for the extracted nameplate module.
-- This deliberately implements only the pfUI services used by zNameplates.

zNameplates = zNameplates or {}
zNameplates_Config = zNameplates_Config or {}

local Z = zNameplates
local addonPath = "Interface\\AddOns\\zNameplates"

if not table.wipe then
  function table.wipe(tbl)
    for key in pairs(tbl) do tbl[key] = nil end
    return tbl
  end
end

local defaults = {
  global = {
    font_default = addonPath .. "\\Assets\\fonts\\Myriad-Pro.ttf",
    font_unit = addonPath .. "\\Assets\\fonts\\BigNoodleTitling.ttf",
    font_size = "12", font_unit_size = "12", font_unit_style = "OUTLINE",
  },
  appearance = {
    border = {
      background = "0,0,0,1", color = "0.2,0.2,0.2,1",
      pixelperfect = "1", hidpi = "1", default = "3", nameplates = "-1",
    },
    castbar = {
      castbarcolor = ".7,.7,.9,.8", channelcolor = ".9,.9,.7,.8",
      texture = addonPath .. "\\Assets\\img\\bar.tga",
    },
  },
  unitframes = {
    abbrevnum = "1", abbrevname = "1", castbardecimals = "2",
    blizzard_raidicons = "1",
  },
  nameplates = {
    showhostile = "1", showfriendly = "0",
    disable_hostile_in_friendly = "0", disable_friendly_in_friendly = "0",
    use_unitfonts = "0", legacy = "0", overlap = "0", verticalhealth = "0",
    vertical_offset = "0", showcastbar = "1", targetcastbar = "0",
    spellname = "0", showdebuffs = "1", selfdebuff = "0",
    showdebuffs_hostile = "1", showdebuffs_friendly = "0", owndebuffs = "0",
    clickthrough = "0", rightclick = "1", clickthreshold = "0.5",
    enemyclassc = "1", friendclassc = "1", friendclassnamec = "0",
    raidiconsize = "16", raidiconpos = "CENTER", raidiconoffx = "0", raidiconoffy = "-5",
    fullhealth = "1", target = "1", namefightcolor = "1",
    enemynpc = "0", enemyplayer = "0", neutralnpc = "0",
    friendlynpc = "0", friendlyplayer = "0", critters = "1", totems = "1",
    totemicons = "0", showguildname = "0",
    outcombatstate = "1", barcombatstate = "1",
    ccombatthreat = "1", ccombatofftank = "1", ccombatnothreat = "1",
    ccombatstun = "1", ccombatcasting = "0",
    combatthreat = ".7,.2,.2,1", combatofftank = ".7,.4,.2,1",
    combatnothreat = ".7,.7,.2,1", combatstun = ".2,.7,.7,1",
    combatcasting = ".7,.2,.7,1", combatofftanks = "",
    outfriendly = "0", outfriendlynpc = "1", outneutral = "1", outenemy = "1",
    targethighlight = "0", highlightcolor = "1,1,1,1",
    showhp = "0", hptextpos = "RIGHT", nametextpos = "CENTER",
    hptextformat = "curmaxs", vpos = "-10", width = "120",
    debuffsize = "14", debuffoffset = "4", heighthealth = "8", heightcast = "8",
    cpdisplay = "0", targetglow = "1", glowcolor = "1,1,1,1",
    targetzoom = "0", targetzoomval = ".40", notargalpha = ".75",
    healthtexture = addonPath .. "\\Assets\\img\\bar.tga",
    name = { fontstyle = "OUTLINE" },
    health = { offset = "-3" },
    debuffs = {
      filter = "none", whitelist = "", blacklist = "",
      showstacks = "0", position = "BOTTOM",
    },
    debufftimers = "1", debufftext = "1", debuffanim = "0",
  },
}

local function CopyTable(source)
  local target = {}
  for key, value in pairs(source or {}) do
    target[key] = type(value) == "table" and CopyTable(value) or value
  end
  return target
end

local function MergeMissing(target, source)
  for key, value in pairs(source or {}) do
    if type(value) == "table" then
      if type(target[key]) ~= "table" then target[key] = {} end
      MergeMissing(target[key], value)
    elseif target[key] == nil then
      target[key] = value
    end
  end
end

local function RebaseMedia(value)
  if type(value) ~= "string" then return value end
  value = string.gsub(value, "Interface\\AddOns\\pfUI\\img\\", addonPath .. "\\Assets\\img\\")
  value = string.gsub(value, "Interface\\AddOns\\pfUI\\fonts\\", addonPath .. "\\Assets\\fonts\\")
  return value
end

local function RebaseTable(tbl)
  for key, value in pairs(tbl) do
    if type(value) == "table" then RebaseTable(value) else tbl[key] = RebaseMedia(value) end
  end
end

-- Temporary defaults make helper functions safe while files are loading.
-- The saved table replaces this during ADDON_LOADED, before nameplates start.
Z.config = CopyTable(defaults)

Z.media = setmetatable({}, { __index = function(tab, key)
  local value = RebaseMedia(tostring(key))
  value = string.gsub(value, "img:", addonPath .. "\\Assets\\img\\")
  value = string.gsub(value, "font:", addonPath .. "\\Assets\\fonts\\")
  rawset(tab, key, value)
  return value
end })

local function UpdateFonts()
  local locale = GetLocale()
  if locale == "zhCN" then
    Z.font_default, Z.font_unit = "Fonts\\FZXHLJW.TTF", "Fonts\\FZXHLJW.TTF"
  elseif locale == "zhTW" then
    Z.font_default, Z.font_unit = "Fonts\\FZXHLJW.ttf", "Fonts\\FZXHLJW.ttf"
  elseif locale == "koKR" then
    Z.font_default, Z.font_unit = "Fonts\\2002.TTF", "Fonts\\2002.TTF"
  else
    Z.font_default = Z.media[Z.config.global.font_default]
    Z.font_unit = Z.media[Z.config.global.font_unit]
  end
end

function Z.InitializeConfig()
  zNameplates_Config = zNameplates_Config or {}

  -- On the first standalone run, preserve the current pfUI look when pfUI is
  -- available. Afterwards the saved standalone copy is authoritative.
  if not zNameplates_Config.style then
    zNameplates_Config.style = CopyTable(defaults)
    if pfUI_config then
      for _, group in pairs({ "global", "appearance", "unitframes", "nameplates" }) do
        if type(pfUI_config[group]) == "table" then
          zNameplates_Config.style[group] = CopyTable(pfUI_config[group])
        end
      end
    end
  end

  MergeMissing(zNameplates_Config.style, defaults)
  RebaseTable(zNameplates_Config.style)
  Z.config = zNameplates_Config.style

  local placementDefaults = { x="0", y="8", height="80", fade=".5", align="CENTER" }
  local old = pfUI_config and pfUI_config.nameplates
  for key, value in pairs(placementDefaults) do
    if zNameplates_Config[key] == nil then
      zNameplates_Config[key] = old and old["msbt_" .. key] or value
    end
  end

  UpdateFonts()
end

function Z.StrSplit(delimiter, subject)
  if not subject then return nil end
  local fields = {}
  local pattern = string.format("([^%s]+)", delimiter or ":")
  string.gsub(subject, pattern, function(value) table.insert(fields, value) end)
  return unpack(fields)
end

function Z.GetStringColor(value)
  return Z.StrSplit(",", value or "1,1,1,1")
end

function Z.Round(value, places)
  places = places or 0
  local power = 1
  for i = 1, places do power = power * 10 end
  return math.floor(value * power + .5) / power
end

function Z.Abbreviate(value)
  local mode = Z.config.unitframes.abbrevnum
  if mode == "1" or mode == "2" then
    local sign = value < 0 and -1 or 1
    value = math.abs(value)
    if value > 1000000 then
      return mode == "2" and (math.floor(value / 100000) / 10 * sign) .. "m"
        or Z.Round(value / 1000000 * sign, 2) .. "m"
    elseif value > 1000 then
      return mode == "2" and (math.floor(value / 100) / 10 * sign) .. "k"
        or Z.Round(value / 1000 * sign, 2) .. "k"
    end
  end
  return math.floor(value)
end

local function PerfectPixel()
  local scale = GetCVar("useUiScale") == "1" and tonumber(GetCVar("uiScale")) or 1
  local _, _, height = string.find(GetCVar("gxResolution") or "1024x768", "x(%d+)")
  local pixel = 768 / (tonumber(height) or 768) / (scale or 1)
  if pixel > 1 then pixel = 1 end
  if Z.config.appearance.border.hidpi == "1" and pixel < .5 then pixel = pixel * 2 end
  return pixel
end

function Z.GetBorderSize(kind)
  local setting = Z.config.appearance.border[kind or "default"]
  if not setting or setting == "-1" then setting = Z.config.appearance.border.default end
  local raw = tonumber(setting) or 3
  return raw, raw * PerfectPixel()
end

function Z.CreateBackdrop(frame, inset)
  if not frame then return end
  local _, border = Z.GetBorderSize()
  if inset then border = inset end
  local pixel = PerfectPixel()
  local backdrop = {
    bgFile = "Interface\\BUTTONS\\WHITE8X8", tile = false, tileSize = 0,
    edgeFile = "Interface\\BUTTONS\\WHITE8X8", edgeSize = pixel,
    insets = { left = -pixel, right = -pixel, top = -pixel, bottom = -pixel },
  }
  if not frame.backdrop then
    frame.backdrop = CreateFrame("Frame", nil, frame)
    frame.backdrop:SetFrameLevel(math.max(0, frame:GetFrameLevel() - 1))
  end
  frame.backdrop:ClearAllPoints()
  frame.backdrop:SetPoint("TOPLEFT", frame, "TOPLEFT", -border, border)
  frame.backdrop:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", border, -border)
  frame.backdrop:SetBackdrop(backdrop)
  frame.backdrop:SetBackdropColor(Z.GetStringColor(Z.config.appearance.border.background))
  frame.backdrop:SetBackdropBorderColor(Z.GetStringColor(Z.config.appearance.border.color))
end

Z.throttle = {}
local throttleDefaults = {
  nameplates = .1, nameplates_target = .02,
  nameplates_castbar = .01, nameplates_mass = 1 / 7,
}
function Z.throttle:Get(category)
  local value = zNameplates_Config.throttle and tonumber(zNameplates_Config.throttle[category])
  return value or throttleDefaults[category] or .1
end

local function ClassColor(r, g, b)
  return { r = r, g = g, b = b, a = 1, GetRGBA = function(self) return self.r, self.g, self.b, self.a end }
end
Z.classColors = setmetatable({
  WARRIOR=ClassColor(.78,.61,.43), MAGE=ClassColor(.25,.78,.92),
  ROGUE=ClassColor(1,.96,.41), DRUID=ClassColor(1,.49,.04),
  HUNTER=ClassColor(.67,.83,.45), SHAMAN=ClassColor(0,.44,.87),
  PRIEST=ClassColor(1,1,1), WARLOCK=ClassColor(.53,.53,.93),
  PALADIN=ClassColor(.96,.55,.73),
}, { __index = function() return ClassColor(.6,.6,.6) end })

Z.unitInfo = { players = {}, mobs = {} }
local function RememberUnit(unit)
  if not unit or not UnitExists(unit) then return end
  local name = UnitName(unit)
  if not name then return end
  local player = UnitIsPlayer(unit) and true or nil
  local _, classToken = UnitClass(unit)
  local unitLevel = UnitLevel(unit)
  local data = {
    class = UnitClassBase and UnitClassBase(unit) or classToken,
    level = unitLevel and unitLevel > 0 and unitLevel or nil,
    elite = not player and UnitClassification(unit) or nil,
    guild = player and GetGuildInfo(unit) or UnitSubName(unit),
  }
  Z.unitInfo[player and "players" or "mobs"][name] = data
end

function Z.GetUnitInfo(name, active, isPlayer)
  local data, player
  if isPlayer ~= false then
    data = Z.unitInfo.players[name]
    if data then player = true end
  end
  if not data and isPlayer ~= true then data = Z.unitInfo.mobs[name] end
  if not data then return end
  return data.class, data.level, data.elite, player, data.guild
end

local scanner = CreateFrame("Frame", "zNameplatesUnitScanner")
for _, eventName in pairs({
  "PLAYER_ENTERING_WORLD", "PLAYER_TARGET_CHANGED", "UPDATE_MOUSEOVER_UNIT",
  "NAME_PLATE_UNIT_ADDED", "RAID_ROSTER_UPDATE", "PARTY_MEMBERS_CHANGED",
}) do scanner:RegisterEvent(eventName) end
scanner:SetScript("OnEvent", function()
  if event == "NAME_PLATE_UNIT_ADDED" then RememberUnit(arg1)
  elseif event == "PLAYER_TARGET_CHANGED" then RememberUnit("target")
  elseif event == "UPDATE_MOUSEOVER_UNIT" then RememberUnit("mouseover")
  else
    RememberUnit("player")
    for i = 1, GetNumPartyMembers() do RememberUnit("party" .. i) end
    for i = 1, GetNumRaidMembers() do RememberUnit("raid" .. i) end
  end
end)

Z.cooldownFrameType = COOLDOWN_FRAME_TYPE or "Model"
Z.CooldownFrame_OnUpdateModel = CooldownFrame_OnUpdateModel or function()
  if this.stopping == 0 then
    local finished = (GetTime() - this.start) / this.duration
    if finished < 1 then this:SetSequenceTime(0, finished * 1000); return end
    this.stopping = 1; this:SetSequence(1); this:SetSequenceTime(1, 0)
  else
    this:AdvanceTime()
  end
end

Z.NAMEPLATE_OBJECTORDER = { "border", "glow", "name", "level", "levelicon", "raidicon" }

local loader = CreateFrame("Frame", "zNameplatesLoader")
loader:RegisterEvent("ADDON_LOADED")
loader:SetScript("OnEvent", function()
  if arg1 ~= "zNameplates" then return end
  this:UnregisterEvent("ADDON_LOADED")
  Z.InitializeConfig()
  if Z.LoadNameplates then Z.LoadNameplates() end
end)
