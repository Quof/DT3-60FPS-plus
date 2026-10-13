/*
mods change (added): makes a mod's new objects (object_add) and rooms (room_add) and gives its scripts their slots
(scrModCall), so every mod's code can name them before any of it is compiled. An object folder with the name of one of
the game's objects changes that object (its events replace the object's) instead of making a new one, and a script
with the name of one of the game's scripts replaces it (if it's one that can be: global.modOvrList). Rooms can't
replace the game's (use a patch, patches\<room>).
argument0: the mod (its place in the mod list)
*/
var m,tDir,tL,i,tName,tIdx;
m=argument0
tDir=global.modDir+global.modFolder[m]+"\"

global.modObjNames[m]=scrModScan(tDir+"objects\","")
for(i=0;i<ds_list_size(global.modObjNames[m]);i+=1)
{
  tName=ds_list_find_value(global.modObjNames[m],i)
  if scrModFind(tName,"obj")<0
  {
    tIdx=object_add()
    scrModRegister(tName,tIdx,"obj")
    ds_map_add(global.modNewObj,tIdx,m+1) //(the mod that made it, +1)
  }
}

global.modRoomNames[m]=scrModScan(tDir+"rooms\","")
for(i=ds_list_size(global.modRoomNames[m])-1;i>=0;i-=1)
{
  tName=ds_list_find_value(global.modRoomNames[m],i)
  if scrModFind(tName,"room")>=0
  {
    scrModLog("  ERROR: room "+tName+" is already one of the game's rooms (change it with a patch instead)")
    ds_list_delete(global.modRoomNames[m],i)
  }
  else
  {
    tIdx=room_add()
    scrModRegister(tName,tIdx,"room")
    ds_map_add(global.modRoomByName,tName,tIdx)
  }
}

//(a script with the name of one of the game's scripts is the mod's version of it: scrModLoadScripts, scrModOverride)
tL=scrModScan(tDir+"scripts\",".gml")
global.modScrNames[m]=ds_list_create()
global.modOvrNames[m]=ds_list_create()
for(i=0;i<ds_list_size(tL);i+=1)
{
  tName=ds_list_find_value(tL,i)
  if scrModFind(tName,"scr")>=0
  {
    if string_pos(","+tName+",",","+global.modOvrList+",")>0 {ds_list_add(global.modOvrNames[m],tName)}
    else {scrModLog("  ERROR: script "+tName+" is one of the game's, and not one a mod can replace (Mods\README.txt lists them)")}
    continue
  }
  ds_list_add(global.modScrNames[m],tName)
  if ds_map_exists(global.modScrSlot,tName) {scrModLog("  script "+tName+": another mod has one by that name, which is the one used"); continue}
  ds_map_add(global.modScrSlot,tName,global.modScrCount)
  global.modScrName[global.modScrCount]=tName
  global.modScrCode[global.modScrCount]=-1
  global.modScrCount+=1
}
ds_list_destroy(tL)
