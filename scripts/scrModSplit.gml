/*
mods change (added): splits a text at a separator into a new ds_list of its parts (the caller destroys it).
argument0: text
argument1: separator (one character)
*/
var tL,tRest,tP;
tL=ds_list_create()
tRest=argument0
tP=string_pos(argument1,tRest)
while tP>0
{
  ds_list_add(tL,string_copy(tRest,1,tP-1))
  tRest=string_delete(tRest,1,tP)
  tP=string_pos(argument1,tRest)
}
ds_list_add(tL,tRest)
return tL
