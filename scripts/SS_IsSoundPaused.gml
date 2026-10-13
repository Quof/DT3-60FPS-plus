/*
gm82snd change (added): SuperSound's SS_IsSoundPaused(handle): 1 while a sound is paused (SS_PauseSound).
argument0: handle
*/
if !ds_map_exists(global.ssName,argument0) {return 0}
if scrSSInstance(argument0)=0 {return 0}
return ds_map_find_value(global.ssPaused,argument0)
