/*
gm82snd change (added): SuperSound's SS_SetSoundPosition(handle,pos): moves a playing sound to a position, in bytes
(SS_GetSoundBytesPerSecond a second). A sound that isn't playing is left as it is.
argument0: handle
argument1: position, bytes
*/
var tInst,tBps;
if !ds_map_exists(global.ssName,argument0) {return 0}
tInst=scrSSInstance(argument0)
tBps=ds_map_find_value(global.ssBps,argument0)
if tInst!=0 and tBps>0 {sound_set_pos(tInst,max(0,argument1)/tBps,unit_seconds)}
return 1
