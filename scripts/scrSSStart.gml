/*
gm82snd change (added): SS_PlaySound and SS_LoopSound. Starts a handle's sound from the beginning, once or looping, at
the volume, frequency and pan last set for it. SuperSound had one copy of each sound, so one that's already playing
starts over instead of playing over itself.
argument0: handle
argument1: 1 to loop, 0 to play once
returns 1, or 0 if the handle isn't valid
*/
var tH,tInst,tName,tPan;
tH=argument0
if !ds_map_exists(global.ssName,tH) {return 0}
tInst=ds_map_find_value(global.ssInst,tH)
if tInst!=0 {sound_stop(tInst)}
tName=ds_map_find_value(global.ssName,tH)
tPan=scrSSPan(ds_map_find_value(global.ssPan,tH))
if argument1
{
  if tPan=0 {tInst=sound_loop_ex(tName,scrSSVolume(tH),scrSSPitch(tH))}
  else {tInst=sound_loop_ex(tName,scrSSVolume(tH),scrSSPitch(tH),tPan)}
}
else
{
  if tPan=0 {tInst=sound_play_ex(tName,scrSSVolume(tH),scrSSPitch(tH))}
  else {tInst=sound_play_ex(tName,scrSSVolume(tH),scrSSPitch(tH),tPan)}
}
ds_map_replace(global.ssInst,tH,tInst)
ds_map_replace(global.ssLoop,tH,argument1)
ds_map_replace(global.ssLastLoop,tH,argument1)
ds_map_replace(global.ssPaused,tH,0)
return 1
