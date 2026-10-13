/*
mods change (added): scrMusicCredit for the mods' music tracks (mod.ini [music] credit), or "".
argument0: track number
*/
if !variable_global_exists("modMusic") {return ""}
if !ds_map_exists(global.modMusic,argument0) {return ""}
return global.modMusCredit[ds_map_find_value(global.modMusic,argument0)]
