/*
mods change (added): a value from a map read by scrModReadKV, as a number, or the default if it isn't there.
argument0: the map
argument1: key
argument2: default
*/
if ds_map_exists(argument0,argument1) {return real(ds_map_find_value(argument0,argument1))}
return argument2
