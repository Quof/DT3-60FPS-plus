/*
gm82snd change (added): SuperSound's SS_SetSoundFreq(handle,freq): the rate in Hz the sound's samples play at (its own
rate is normal speed, twice that is double speed and an octave up). As in DirectSound, 0 sets the file's own rate back
and the rest is kept within 100-200000. Kept on the handle for the next plays, and set on the copy playing now.
argument0: handle
argument1: frequency, Hz
*/
var tInst,tFreq;
if !ds_map_exists(global.ssName,argument0) {return 0}
tFreq=argument1
if tFreq<=0 {tFreq=ds_map_find_value(global.ssRate,argument0)}
ds_map_replace(global.ssFreq,argument0,median(100,tFreq,200000))
tInst=ds_map_find_value(global.ssInst,argument0)
if tInst!=0 {sound_pitch(tInst,scrSSPitch(argument0))}
return 1
