/*
mods change (added): stopAllMusic for the mods' music tracks.
*/
var k;
if !variable_global_exists("modMusCount") {exit}
for(k=0;k<global.modMusCount;k+=1)
{
  if global.modMusVar[k]!="" {SS_StopSound(variable_global_get(global.modMusVar[k]))}
  else {SS_StopSound(global.modMusHandle[k])}
}
