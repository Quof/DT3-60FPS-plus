/*
gm82snd change (added): SuperSound's SS_StopSound(handle): stops a sound. SS_ResumeSound would start it over.
argument0: handle
*/
var tInst;
if !ds_map_exists(global.ssName,argument0) {return 0}
tInst=ds_map_find_value(global.ssInst,argument0)
if tInst!=0
{
  sound_stop(tInst)
  ds_map_replace(global.ssInst,argument0,0)
  ds_map_replace(global.ssLoop,argument0,0)
  ds_map_replace(global.ssPaused,argument0,0)
}
return 1
