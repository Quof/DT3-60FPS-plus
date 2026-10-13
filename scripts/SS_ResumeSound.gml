/*
gm82snd change (added): SuperSound's SS_ResumeSound(handle): carries on a paused sound. One that was stopped (or never
played) starts from the beginning, the way it was last played (once or looping), and one that's playing carries on.
argument0: handle
returns 1, or 0 if the handle isn't valid
*/
var tInst;
if !ds_map_exists(global.ssName,argument0) {return 0}
tInst=scrSSInstance(argument0)
if tInst=0 {return scrSSStart(argument0,ds_map_find_value(global.ssLastLoop,argument0))}
if ds_map_find_value(global.ssPaused,argument0)
{
  sound_resume(tInst)
  ds_map_replace(global.ssPaused,argument0,0)
}
return 1
