-- Initialization bridge for MSBT when its files are loaded by zNameplates.toc.
-- The guards make initialization independent of ADDON_LOADED frame ordering.

zNameplates = zNameplates or {}

local PROFILE_IMPORT_REVISION = "regular-msbt-2026-08-23-022347"

local function CopyProfileTable(source)
  if type(source) ~= "table" then return source end
  local target = {}
  for key, value in pairs(source) do target[key] = CopyProfileTable(value) end
  return target
end

local function ImportRegularProfiles()
  local source = zNameplatesRegularMikSBT_Save
  if type(source) ~= "table" or type(source.Profiles) ~= "table" then return end

  MikSBT_Save = type(MikSBT_Save) == "table" and MikSBT_Save or {}
  if MikSBT_Save.zNameplatesProfileImport == PROFILE_IMPORT_REVISION then return end

  -- Import every named profile (Default and any custom profiles) exactly once.
  -- Subsequent edits made through the embedded options remain authoritative.
  MikSBT_Save.UserDisabled = source.UserDisabled
  MikSBT_Save.CurrentProfile = source.CurrentProfile
  MikSBT_Save.Profiles = CopyProfileTable(source.Profiles)
  MikSBT_Save.zNameplatesProfileImport = PROFILE_IMPORT_REVISION
end

local function NormalizeCurrentProfile()
  if type(MikSBT_Save) ~= "table" or type(MikSBT_Save.Profiles) ~= "table" then return end

  local profiles = MikSBT_Save.Profiles
  if not next(profiles) then
    MikSBT_Save = nil
    return
  end

  if not MikSBT_Save.CurrentProfile or not profiles[MikSBT_Save.CurrentProfile] then
    if profiles.Default then
      MikSBT_Save.CurrentProfile = "Default"
    else
      for profileName in pairs(profiles) do
        MikSBT_Save.CurrentProfile = profileName
        break
      end
    end
  end
end

function zNameplates.EnsureEmbeddedMSBT()
  if not MikSBT then return end

  if not MikSBT.EmbeddedRuntimeInitialized then
    ImportRegularProfiles()
    NormalizeCurrentProfile()
    MikSBT.RegisterEvents()
    MikSBT.Init()
    MikSBT.EmbeddedRuntimeInitialized = true
  end

  if not MikSBT.CurrentProfile and MikSBT_Save and MikSBT_Save.Profiles then
    NormalizeCurrentProfile()
    MikSBT.CurrentProfile = MikSBT_Save.Profiles[MikSBT_Save.CurrentProfile]
  end

  if MikSBT.CurrentProfile and MikSBTOpt and MikSBTOpt.Init and not MikSBTOpt.EmbeddedInitialized then
    MikSBTOpt.Init()
  end
end
