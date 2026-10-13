/*
mods change (added): a value from a map read by scrModReadKV, as text, or "" if it isn't there.
argument0: the map
argument1: key
*/
if ds_map_exists(argument0,argument1) {return ds_map_find_value(argument0,argument1)}
return ""
