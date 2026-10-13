/*
mods change (added): findMusic for the track numbers mods add (mod.ini [music]): loads the track (streamed) into its
global variable (or, without one, global.modMusHandle) if it isn't loaded, and returns it. 0 for a number no mod has.
argument0: track number
*/
var k,tVar,tH;
if !variable_global_exists("modMusic") {return 0}
if !ds_map_exists(global.modMusic,argument0) {return 0}
k=ds_map_find_value(global.modMusic,argument0)
tVar=global.modMusVar[k]
if tVar!="" {tH=variable_global_get(tVar)}
else {tH=global.modMusHandle[k]}
if !SS_IsHandleValid(tH)
{
  if !file_exists(global.modMusFile[k]) {return 0}
  tH=SS_LoadSound(global.modMusFile[k],1)
  if tVar!="" {variable_global_set(tVar,tH)}
  else {global.modMusHandle[k]=tH}
}
return tH
