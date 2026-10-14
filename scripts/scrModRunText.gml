/*
mods change (added): runs a piece of a mod's room, instance or patch code kept as text (scrModTextAdd) in the current
instance, the way its mod needs it (scrModRun's modes: 0 as it is; 1, and 2 on 30fps ticks only, with gDeltaTime 1 for
30fps code). The text goes through scrModFixCode (the mod's script calls) the first time it runs.
argument0: the code's number (-1 does nothing)
argument1: mode
*/
var k,tDt;
k=argument0
if k<0 {exit}
if argument1=2 and gDeltaDoTicks=0 {exit}
if global.modTextFixed[k]=0
{
  global.modText[k]=scrModFixCode(global.modText[k])
  global.modTextFixed[k]=1
}
tDt=gDeltaTime
if argument1=1 or argument1=2 {gDeltaTime=1}
execute_string(global.modText[k])
gDeltaTime=tDt
