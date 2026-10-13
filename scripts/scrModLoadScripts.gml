/*
mods change (added): compiles a mod's scripts (scripts\<name>.gml) into their slots (scrModCall), and its versions of
the game's scripts, which then replace them (global.modOvr: scrModOverride).
argument0: the mod (its place in the mod list)
*/
var m,tDir,i,tName,tSlot,tIdx,tC;
m=argument0
tDir=global.modDir+global.modFolder[m]+"\"
for(i=0;i<ds_list_size(global.modScrNames[m]);i+=1)
{
  scrModProgress("",i/(ds_list_size(global.modScrNames[m])+ds_list_size(global.modOvrNames[m])))
  tName=ds_list_find_value(global.modScrNames[m],i)
  if !ds_map_exists(global.modScrSlot,tName) {continue}
  tSlot=ds_map_find_value(global.modScrSlot,tName)
  if global.modScrCode[tSlot]>=0 {continue} //another mod's script with that name
  global.modScrCode[tSlot]=scrModCompile(scrModFixCode(scrModReadFile(tDir+"scripts\"+tName+".gml")),"script "+tName)
}
for(i=0;i<ds_list_size(global.modOvrNames[m]);i+=1)
{
  scrModProgress("",(ds_list_size(global.modScrNames[m])+i)/(ds_list_size(global.modScrNames[m])+ds_list_size(global.modOvrNames[m])))
  tName=ds_list_find_value(global.modOvrNames[m],i)
  tIdx=scrModFind(tName,"scr")
  tC=scrModCompile(scrModFixCode(scrModReadFile(tDir+"scripts\"+tName+".gml")),"script "+tName)
  if tC<0 {continue}
  if global.modOvr[tIdx]>=0 {scrModLog("  script "+tName+": replaces another mod's version of it")}
  else {scrModLog("  script "+tName+": the mod's version replaces the game's")}
  global.modOvr[tIdx]=tC
}
