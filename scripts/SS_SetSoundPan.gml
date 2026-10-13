/*
gm82snd change (added): SuperSound's SS_SetSoundPan(handle,pan): -10000 is the left side only, 10000 the right only and
0 the middle (scrSSPan). Kept on the handle for the next plays, and set on the copy playing now.
argument0: handle
argument1: pan, -10000 to 10000
*/
var tInst;
if !ds_map_exists(global.ssName,argument0) {return 0}
ds_map_replace(global.ssPan,argument0,median(-10000,argument1,10000))
tInst=ds_map_find_value(global.ssInst,argument0)
if tInst!=0 {sound_pan(tInst,scrSSPan(ds_map_find_value(global.ssPan,argument0)))}
return 1
