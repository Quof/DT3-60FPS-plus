/*
mods change (added): a 30fps mod's draw event (scrModAddEvent sets it up when the event's code starts with a
//tickvars: line, which the mod tools write). The event is drawn every frame, but what it changes in the instance (the
variables named, e.g. animation counters it adds to as it draws) only changes on 30fps ticks: between them they're put
back as they were. So it animates at the speed it did at 30fps.
argument0: the event's compiled code
argument1: the variables it changes, comma separated
*/
var tL,i,tN,tHas,tVal;
if gDeltaDoTicks!=0 {scrModRun(argument0,3,0,0); exit}
tL=scrModSplit(argument1,",")
tN=ds_list_size(tL)
for(i=0;i<tN;i+=1)
{
  tHas[i]=variable_local_exists(ds_list_find_value(tL,i))
  if tHas[i] {tVal[i]=variable_local_get(ds_list_find_value(tL,i))}
}
scrModRun(argument0,3,0,0)
for(i=0;i<tN;i+=1)
{
  if tHas[i] {variable_local_set(ds_list_find_value(tL,i),tVal[i])}
}
ds_list_destroy(tL)
