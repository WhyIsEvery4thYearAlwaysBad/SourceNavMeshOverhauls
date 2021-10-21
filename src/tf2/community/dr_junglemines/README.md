# [dr_junglemines](https://gamebanana.com/mods/74545)

## Issues

* Bots are not able to automatically open the gate at RED spawn.

* Bots will run into the corners often.

  * This is caused because a RED flag is actually used in the map (as a coin); to get bots to move to the proper location, remove that flag (with `ent_remove item_teamflag`) and create another RED flag at the location you prefer (with `ent_creaate`).

* RED Bots can see BLU bots, despite the BLU rooms being covered.

  * This issue can be fixed by modifying NAV data; however I have not been able to setup the script to do this yet.

## Changelog

* Initial mesh.
