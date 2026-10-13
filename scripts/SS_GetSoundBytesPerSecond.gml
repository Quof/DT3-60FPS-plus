/*
gm82snd change (added): SuperSound's SS_GetSoundBytesPerSecond(handle): the file's bytes a second as SuperSound counted
them (scrSSFormat): the sample rate times 2 bytes a sample for each channel (16-bit). playSound halves it for a sound's
normal rate (mono), and scrMusicFreq quarters it for the music's (stereo).
argument0: handle
*/
if !ds_map_exists(global.ssName,argument0) {return 0}
return ds_map_find_value(global.ssBps,argument0)
