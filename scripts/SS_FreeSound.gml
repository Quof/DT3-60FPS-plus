/*
gm82snd change (added): SuperSound's SS_FreeSound(handle): stops a sound and unloads it. The handle is invalid from then
on (SS_IsHandleValid), and other SS_ calls with it do nothing.
argument0: handle
*/
var tH;
tH=argument0
if !ds_map_exists(global.ssName,tH) {return 0}
sound_delete(ds_map_find_value(global.ssName,tH)) //stops it too
ds_map_delete(global.ssName,tH)
ds_map_delete(global.ssInst,tH)
ds_map_delete(global.ssLoop,tH)
ds_map_delete(global.ssLastLoop,tH)
ds_map_delete(global.ssPaused,tH)
ds_map_delete(global.ssVol,tH)
ds_map_delete(global.ssFreq,tH)
ds_map_delete(global.ssPan,tH)
ds_map_delete(global.ssRate,tH)
ds_map_delete(global.ssBps,tH)
ds_map_delete(global.ssLevel,tH)
return 1
