/*
mods change (added): scrMusicCredit for the mods' music tracks (mod.ini [music] credit), or "" (also for a track whose
file the mod doesn't have: the game's own track plays, with its own credit).
argument0: track number
*/
var k;
if !variable_global_exists("modMusic") {return ""}
if !ds_map_exists(global.modMusic,argument0) {return ""}
//return global.modMusCredit[ds_map_find_value(global.modMusic,argument0)]
k=ds_map_find_value(global.modMusic,argument0)
if !global.modMusExists[k] {return ""} //mods change (added)
return global.modMusCredit[k]
