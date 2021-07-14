# SourceNavMeshOverhauls

A compilation of Source Engine navigation meshes that are improvements over the Source Engine's automatically generated nav meshes and default nav meshes made by Valve.

To convert the nav meshes into VPKs, use the `build_vpk` script. Run the script with no launch options to get the help display.

## Contributing

You are free to merge additional navigation meshes for other maps. However the nav mesh must be at the path `<root>/src/<game>/<map name without version suffix>/<nav mesh file>`, or `<repo>/src/<game>/community/<map name without version suffix>/<nav mesh file>` if the map is not in the game by default.

* A version suffix is a string that indicates the version of the map. It's typically at the end of the map name. (e.g koth\_spillway*_rc3a* or pl\_abandoned\_upward*_finalfix*)

e.g

* `koth_spillway_rc3a.nav` -> `<root>/src/tf2/community/koth_spillway/koth_spillway_rc3a.nav`
* `pl_badwater.nav` -> `<root>/src/tf2/pl_badwater/pl_badwater.nav`
* `de_mirage.nav` -> `<root>/src/csgo/de_mirage/de_mirage.nav`

The map folder should also have a README that links the nav mesh to the map's main page it is for.

Finally if a map's nav mesh does not need changes, then don't change it's nav mesh.

## Testing

As of now I own Team Fortress 2 and Counter-Strike: Global Offensive, so I am able to test navigation meshes made in those games. However I cannot test nav meshes made in other Source games, so it is up to you to ensure they are reliable.
