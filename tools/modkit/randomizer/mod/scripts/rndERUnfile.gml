//Randomizer: a row instance's "one more is all" entries taken back off global.rndRSingle (argument0: the row,
//argument1: the state)
var inst,str,p,ix;
inst=argument0*global.rndEGsN+argument1
if !ds_map_exists(global.rndRSing,inst) {exit}
str=ds_map_find_value(global.rndRSing,inst)
while str!=""
{
  p=string_pos(",",str)
  ix=real(string_copy(str,1,p-1))
  global.rndRSingle[ix]-=1
  str=string_delete(str,1,p)
}
ds_map_delete(global.rndRSing,inst)
