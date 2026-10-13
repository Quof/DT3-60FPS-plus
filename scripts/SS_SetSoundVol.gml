/*
gm82snd change (added): SuperSound's SS_SetSoundVol(handle,vol): 0 is silent and 10000 the file's own level, each 100
below it 1dB quieter (scrSSVolume). Kept on the handle for the next plays, and set on the copy playing now.
argument0: handle
argument1: volume, 0-10000
*/
var tInst;
if !ds_map_exists(global.ssName,argument0) {return 0}
ds_map_replace(global.ssVol,argument0,median(0,argument1,10000))
tInst=ds_map_find_value(global.ssInst,argument0)
if tInst!=0 {sound_volume(tInst,scrSSVolume(argument0))}
return 1
