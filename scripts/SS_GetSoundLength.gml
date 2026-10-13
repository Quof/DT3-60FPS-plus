/*
gm82snd change (added): SuperSound's SS_GetSoundLength(handle): the sound's length in bytes (SS_GetSoundBytesPerSecond
a second).
argument0: handle
*/
if !ds_map_exists(global.ssName,argument0) {return 0}
return floor(sound_get_length(ds_map_find_value(global.ssName,argument0))*ds_map_find_value(global.ssBps,argument0))
