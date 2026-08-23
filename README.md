# zNameplates

Standalone extraction of the pfUI nameplate module for OctoWoW with an embedded
MikScrollingBattleText runtime and options panel. It does not load, skin, or
replace any unrelated part of the interface.

## Setup

1. Enable `zNameplates` in the addon list. To import your current pfUI values,
   leave pfUI enabled for this first login but turn off its nameplate module.
2. After that first login, disable pfUI if it is not otherwise needed. Only one
   addon should own Blizzard nameplates at a time.
3. Disable or remove the separate `MikScrollingBattleText` and
   `MikScrollingBattleTextOptions` addons. Their runtime and options are loaded
   internally by zNameplates; enabling both copies will create conflicts.
4. Open the unified settings window with `/znp` or `/znameplates`.

The first time zNameplates loads, it imports only relevant nameplate,
appearance, font, cooldown, and throttle values from an available pfUI saved
configuration. Later changes are stored independently in `zNameplatesDB`.

The `MSBT & Advanced` tab controls placement and fade behavior for combat text
attached to each visible nameplate. The **Open MSBT** button (and `/msbt`) opens
the embedded MSBT font, color, text, event, and animation options.

The nested `MikScrollingBattleText` and `MikScrollingBattleTextOptions`
directories are loaded explicitly by `zNameplates.toc`. Their fonts, sounds,
and artwork are resolved from inside zNameplates.

`MSBTProfiles.lua` contains a migration snapshot of all profiles from the
regular account-wide MSBT save. On first load, zNameplates imports `Default`
and every custom profile, including the selected profile, then stores future
changes in its own `MikSBT_Save` without overwriting them on later logins.

The extracted nameplate implementation is based on pfUI and retains its MIT
license in `LICENSE-pfUI`.
