/*
gm82snd change (added): the gm82snd volume (an amplitude, 0-1) for a handle's SuperSound volume (SS_SetSoundVol: 0-10000,
where 10000 is the file's own level and each 100 below it is 1dB quieter, as in DirectSound). A stereo file's is
turned down by global.ssStereoLevel (see SS_Init).
argument0: handle (a valid one: SS_IsHandleValid)
*/
var tVol;
tVol=ds_map_find_value(global.ssVol,argument0)
if tVol<=0 {return 0}
return power(10,(min(tVol,10000)-10000)/2000)*ds_map_find_value(global.ssLevel,argument0)
