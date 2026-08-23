local function PrintStatus()
  DEFAULT_CHAT_FRAME:AddMessage(string.format(
    "|cff33ffcczNameplates|r MSBT: x=%s y=%s height=%s fade=%s align=%s",
    zNameplates_Config.x, zNameplates_Config.y, zNameplates_Config.height,
    zNameplates_Config.fade, zNameplates_Config.align))
end

local function RefreshNameplates()
  if zNameplates and zNameplates.nameplates and zNameplates.nameplates.UpdateConfig then
    zNameplates.nameplates.UpdateConfig()
  end
end

local nameplateKeys = {
  width=true, heighthealth=true, heightcast=true, showhp=true,
  showhostile=true, showfriendly=true, showcastbar=true, spellname=true,
  showdebuffs=true, owndebuffs=true, debuffsize=true, debuffoffset=true,
  targetglow=true, targetzoom=true, targetzoomval=true, notargalpha=true,
  nametextpos=true, hptextpos=true, hptextformat=true, vertical_offset=true,
  overlap=true, clickthrough=true, raidiconsize=true,
}

SLASH_ZNAMEPLATES1 = "/znp"
SlashCmdList["ZNAMEPLATES"] = function(message)
  local command, value = string.match(message or "", "^%s*(%S*)%s*(.-)%s*$")
  command = string.lower(command or "")

  if command == "x" or command == "y" or command == "height" or command == "fade" then
    if tonumber(value) then
      zNameplates_Config[command] = value
      RefreshNameplates()
      PrintStatus()
    else
      DEFAULT_CHAT_FRAME:AddMessage("|cff33ffcczNameplates|r: " .. command .. " requires a number.")
    end
  elseif command == "align" then
    value = string.upper(value or "")
    if value == "LEFT" or value == "CENTER" or value == "RIGHT" then
      zNameplates_Config.align = value
      RefreshNameplates()
      PrintStatus()
    else
      DEFAULT_CHAT_FRAME:AddMessage("|cff33ffcczNameplates|r: align must be LEFT, CENTER, or RIGHT.")
    end
  elseif command == "set" then
    local key, setting = string.match(value or "", "^(%S+)%s+(.+)$")
    key = string.lower(key or "")
    if nameplateKeys[key] and setting and setting ~= "" then
      zNameplates_Config.style.nameplates[key] = setting
      RefreshNameplates()
      DEFAULT_CHAT_FRAME:AddMessage("|cff33ffcczNameplates|r: " .. key .. " = " .. setting)
    else
      DEFAULT_CHAT_FRAME:AddMessage("|cff33ffcczNameplates|r: unsupported setting. See README.md for common keys.")
    end
  elseif command == "status" or command == "" then
    PrintStatus()
    DEFAULT_CHAT_FRAME:AddMessage("|cff33ffcczNameplates|r: /znp x N, y N, height N, fade N, align LEFT|CENTER|RIGHT")
    DEFAULT_CHAT_FRAME:AddMessage("|cff33ffcczNameplates|r: /znp set SETTING VALUE (example: /znp set width 140)")
  else
    DEFAULT_CHAT_FRAME:AddMessage("|cff33ffcczNameplates|r: /znp status for usage.")
  end
end
