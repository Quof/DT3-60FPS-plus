/*
mods change (added): runs the mods' code for a hook, the points in the game's own code where mods can add to it (a
mod's hooks folder, one file per hook: Mods\README.txt lists them). Each runs in the instance calling the hook.
argument0: hook name
argument1, argument2: what the hook passes (argument0/argument1 in the hook's code)
returns the last number other than 0 a hook's code returned, or 0
*/
var tL,i,tC,tR,tLast;
tLast=0
if !variable_global_exists("modHook") {return 0}
if !ds_map_exists(global.modHook,argument0) {return 0}
tL=ds_map_find_value(global.modHook,argument0)
for(i=0;i<ds_list_size(tL);i+=1)
{
  tC=ds_list_find_value(tL,i)
  tR=scrModRun(tC,global.modCodeMode[tC],argument1,argument2)
  if is_real(tR) {if tR!=0 {tLast=tR}}
}
return tLast
