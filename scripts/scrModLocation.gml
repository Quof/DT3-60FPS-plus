/*
mods change (added): locationCheck for the location numbers mods add (mod.ini [locations]), or "".
argument0: location number
*/
if !variable_global_exists("modLoc") {return ""}
if !ds_map_exists(global.modLoc,argument0) {return ""}
return ds_map_find_value(global.modLoc,argument0)
