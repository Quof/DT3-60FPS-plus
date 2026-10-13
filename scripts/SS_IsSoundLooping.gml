/*
gm82snd change (added): SuperSound's SS_IsSoundLooping(handle): 1 while a sound loops (SS_LoopSound), until it's stopped.
argument0: handle
*/
if !ds_map_exists(global.ssName,argument0) {return 0}
if scrSSInstance(argument0)=0 {return 0}
return ds_map_find_value(global.ssLoop,argument0)
