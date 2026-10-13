/*
gm82snd change (added): the gm82snd pitch (a multiple of the file's own sample rate) for a handle's SuperSound
frequency (SS_SetSoundFreq: the rate in Hz that DirectSound played the file's samples at).
argument0: handle (a valid one: SS_IsHandleValid)
*/
var tRate;
tRate=ds_map_find_value(global.ssRate,argument0)
if tRate<=0 {return 1}
return ds_map_find_value(global.ssFreq,argument0)/tRate
