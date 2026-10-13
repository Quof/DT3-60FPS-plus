/*
gm82snd change (added): SuperSound's SS_LoadSound(fname,stream). Loads a WAV or Ogg file and returns its handle for the
other SS_ scripts, or 0 if it can't be loaded (SS_IsHandleValid is false for 0). A streamed sound (the music) is read
from the disk as it plays. Streamed sounds are gm82snd's sound kind 3 and the rest kind 0, which keeps the music and
the effects apart if they're ever given a volume each (sound_kind_volume).
argument0: file name
argument1: 1 to stream it, 0 to load it all at once
*/
var tH,tName,tInst;
if !file_exists(argument0) {return 0}
scrSSFormat(argument0) //before loading it, as a streamed file stays open
tH=global.ssNext
global.ssNext+=1
tName="ss_"+string(tH)
if argument1 {sound_add_ext(argument0,3,1,tName)}
else {sound_add_ext(argument0,0,0,tName)}
if !sound_exists(tName) {return 0}
if global.ssFmtRate<=0 //not a WAV or Ogg Vorbis file: the rate from gm82snd, at 2 bytes a sample
{
  tInst=sound_play_paused(tName)
  global.ssFmtRate=sound_get_frequency(tInst)
  sound_stop(tInst)
  if global.ssFmtRate<=0 {global.ssFmtRate=22050}
  global.ssFmtChannels=1
  global.ssFmtBps=global.ssFmtRate*2
}
ds_map_add(global.ssName,tH,tName)
ds_map_add(global.ssInst,tH,0)
ds_map_add(global.ssLoop,tH,0)
ds_map_add(global.ssLastLoop,tH,0)
ds_map_add(global.ssPaused,tH,0)
ds_map_add(global.ssVol,tH,10000)
ds_map_add(global.ssFreq,tH,global.ssFmtRate)
ds_map_add(global.ssPan,tH,0)
ds_map_add(global.ssRate,tH,global.ssFmtRate)
ds_map_add(global.ssBps,tH,global.ssFmtBps)
if global.ssFmtChannels>=2 {ds_map_add(global.ssLevel,tH,global.ssStereoLevel)}
else {ds_map_add(global.ssLevel,tH,1)}
return tH
