/*
gm82snd change (added): SuperSound's SS_GetSoundFreq(handle): the frequency last set (SS_SetSoundFreq), the file's own
sample rate if none was.
argument0: handle
*/
if !ds_map_exists(global.ssName,argument0) {return 0}
return ds_map_find_value(global.ssFreq,argument0)
