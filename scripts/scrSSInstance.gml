/*
gm82snd change (added): the gm82snd instance playing a SuperSound handle's sound (SS_PlaySound/SS_LoopSound), or 0 if
there's none because it finished or was stopped. A paused one still counts, as it did in SuperSound.
argument0: handle (a valid one: SS_IsHandleValid)
*/
var tInst;
tInst=ds_map_find_value(global.ssInst,argument0)
if tInst!=0
{
  if !sound_isplaying(tInst)
  {
    tInst=0
    ds_map_replace(global.ssInst,argument0,0)
    ds_map_replace(global.ssPaused,argument0,0)
  }
}
return tInst
