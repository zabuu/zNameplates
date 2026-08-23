# zNameplates

`zNameplates` is a standalone nameplate addon with the customized Mik's
Scrolling Battle Text core/options embedded inside it.

## Installation

- pfUI is not required. Its required media and small runtime helpers are bundled.
- If pfUI remains installed, disable its `nameplates` module in
  **pfUI > Components > Modules** so two nameplate replacements do not run.
- Disable or remove the separate `MikScrollingBattleText` and
  `MikScrollingBattleTextOptions` addons. Do not enable both copies together.

After making those changes, enable `zNameplates` in the addon list and reload
the UI. The copied pfUI and MSBT source addons are not modified by this bundle.

The existing `MikSBT_Save` saved-variable name is retained, so current MSBT
profiles continue to work after removing the separate addon.

## Commands

- `/msbt` opens the bundled MSBT options.
- `/znp status` shows nameplate text placement.
- `/znp x N`
- `/znp y N`
- `/znp height N` sets the nameplate text travel distance in pixels.
- `/znp fade N` sets the seconds before nameplate text starts fading.
- `/znp align LEFT|CENTER|RIGHT`
- `/znp set SETTING VALUE` changes a common nameplate setting immediately.

Examples: `/znp set width 140`, `/znp set showhp 1`,
`/znp set showfriendly 1`, `/znp set heighthealth 10`, and
`/znp set showdebuffs 0`. Boolean settings use `1` or `0`.

On its first run alongside pfUI, zNameplates copies the existing font,
appearance, and nameplate values into `zNameplates_Config`. After that it no
longer reads pfUI settings, so pfUI can be disabled or removed.

To preserve the exact current pfUI appearance, do one reload with pfUI enabled
and its Nameplates module disabled before removing pfUI. This migration reload
is optional; without it, zNameplates uses its bundled defaults.
