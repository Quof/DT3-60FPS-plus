/*
gm82snd change (added): SuperSound's SS_GetSoundPan(handle): the pan last set (SS_SetSoundPan), 0 if none was.
argument0: handle
*/
if !ds_map_exists(global.ssName,argument0) {return 0}
return ds_map_find_value(global.ssPan,argument0)
