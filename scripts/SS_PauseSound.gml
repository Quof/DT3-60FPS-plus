/*
gm82snd change (added): SuperSound's SS_PauseSound(handle): pauses a sound where it is (SS_ResumeSound carries it on).
argument0: handle
*/
var tInst;
if !ds_map_exists(global.ssName,argument0) {return 0}
tInst=scrSSInstance(argument0)
if tInst!=0
{
  sound_pause(tInst)
  ds_map_replace(global.ssPaused,argument0,1)
}
return 1
