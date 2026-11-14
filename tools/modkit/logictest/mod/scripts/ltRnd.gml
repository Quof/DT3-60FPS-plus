//Logic Test: runs one of the Randomizer's scripts (argument0: its name) with no arguments, and returns what it returns
//(0 if the Randomizer isn't on). Named through its slot (scrModCall), so this mod's code compiles without it
if !ds_map_exists(global.modScrSlot,argument0) {return 0}
return scrModCall(ds_map_find_value(global.modScrSlot,argument0))
