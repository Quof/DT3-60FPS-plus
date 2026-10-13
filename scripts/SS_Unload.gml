/*
gm82snd change (added): SuperSound's SS_Unload(): stops and frees every sound loaded with SS_LoadSound (the game calls it
when it closes). The handle tables stay, so SS_ calls after it do nothing instead of failing.
*/
var tList,tKey,i;
if !variable_global_exists("ssName") {exit}
tList=ds_list_create()
tKey=ds_map_find_first(global.ssName)
repeat (ds_map_size(global.ssName))
{
  ds_list_add(tList,tKey)
  tKey=ds_map_find_next(global.ssName,tKey)
}
for(i=0;i<ds_list_size(tList);i+=1) {SS_FreeSound(ds_list_find_value(tList,i))}
ds_list_destroy(tList)
