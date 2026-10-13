/*
gm82snd change (added): SuperSound's SS_GetSoundVol(handle): the volume last set (SS_SetSoundVol), 10000 if none was.
argument0: handle
*/
if !ds_map_exists(global.ssName,argument0) {return 0}
return ds_map_find_value(global.ssVol,argument0)
