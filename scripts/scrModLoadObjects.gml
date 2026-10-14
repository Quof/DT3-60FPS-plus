/*
mods change (added): sets up a mod's objects (objects\<name>\object.ini and an .gml file per event, named as in the
project: Create_0, Step_0, Collision_oPlayer1...). For one of the game's own objects, only the properties object.ini
has are changed, and each event the mod has replaces the object's (or is added to it, with events=append). The game's
events in global.modEvList are replaced without clearing them (scrModEvRegister), and a clear or parent change that
takes long is named in the log (mods change).
object.ini, section [object]: sprite, solid, visible, depth, persistent, parent, mask, and also
  inherit: the object event_inherited() runs the event of, if not the parent (a 30fps mod's code only)
  block: events (comma separated) the object must not get from its parent; they run inherit's instead
  events: replace (default) or append, for the game's own objects
  append: for the game's own objects, events (comma separated) that are added after the object's own; the others the
          mod has replace them (unless events=append)
  legacy: 1 for an object written for 30fps, 0 for one written for DT3+ (default: the mod's own legacy setting)
argument0: the mod (its place in the mod list)
*/
//var m,tDir,tL,i,j,tName,tObj,tNew,tIni,tPar,tInh,tEvs,tEv,tLeg,tBlock,tBl,tAppend,tCode,tLegObj,tRedef,tT,tKV;
var m,tDir,tL,i,j,tName,tObj,tNew,tIni,tPar,tInh,tEvs,tEv,tLeg,tBlock,tBl,tAppend,tCode,tLegObj,tRedef,tT,tKV,tAppList; //mods change: tAppList (object.ini append)
m=argument0
tDir=global.modDir+global.modFolder[m]+"\"
tLeg=global.modLegacy[m]
for(i=0;i<ds_list_size(global.modObjNames[m]);i+=1)
{
  scrModProgress("",i/ds_list_size(global.modObjNames[m]))
  tName=ds_list_find_value(global.modObjNames[m],i)
  tObj=scrModFind(tName,"obj")
  if tObj<0 {continue}
  tNew=ds_map_exists(global.modNewObj,tObj)
  //a new object another mod made too (both have it): this later mod's version of it is the one used, so its events
  //replace the other mod's instead of being added to them
  tRedef=0
  if tNew {tRedef=(ds_map_find_value(global.modNewObj,tObj)!=m+1)}
  if tRedef {scrModLog("  object "+tName+": another mod has one by that name; this mod's version replaces its events")}
  tT=current_time
  tIni=tDir+"objects\"+tName+"\object.ini"
  //(read as key=value lines, as ini_close would write the file back each time the game starts)
  tKV=scrModReadKV(tIni)
  if tNew or ds_map_exists(tKV,"sprite") {object_set_sprite(tObj,scrModFind(scrModKVS(tKV,"sprite"),"spr"))}
  if tNew or ds_map_exists(tKV,"solid") {object_set_solid(tObj,scrModKV(tKV,"solid",0))}
  if tNew or ds_map_exists(tKV,"visible") {object_set_visible(tObj,scrModKV(tKV,"visible",1))}
  if tNew or ds_map_exists(tKV,"depth") {object_set_depth(tObj,scrModKV(tKV,"depth",0))}
  if tNew or ds_map_exists(tKV,"persistent") {object_set_persistent(tObj,scrModKV(tKV,"persistent",0))}
  if tNew or ds_map_exists(tKV,"mask") {object_set_mask(tObj,scrModFind(scrModKVS(tKV,"mask"),"spr"))}
  tPar=object_get_parent(tObj)
  global.modTimeProp+=current_time-tT
  if tNew or ds_map_exists(tKV,"parent")
  {
    tT=current_time
    tPar=scrModFind(scrModKVS(tKV,"parent"),"obj")
    //object_set_parent(tObj,tPar)
    if tPar!=object_get_parent(tObj) {object_set_parent(tObj,tPar)} //mods change: only when it changes (object_set_parent is slow: see the parents time in mod_log.txt)
    //global.modTimeParent+=current_time-tT
    tT=current_time-tT //mods change: one that takes long is named in the log
    global.modTimeParent+=tT
    if tT>=100 {scrModLog("  slow: setting the parent of "+tName+" took "+string(tT)+" ms")} //mods change (added)
  }
  tInh=tPar
  if ds_map_exists(tKV,"inherit") {tInh=scrModFind(scrModKVS(tKV,"inherit"),"obj")}
  tBlock=scrModKVS(tKV,"block")
  tAppend=(scrModKVS(tKV,"events")="append")
  tAppList=","+string_replace_all(scrModKVS(tKV,"append")," ","")+"," //mods change (added): events added after the object's own (object.ini append)
  tLegObj=scrModKV(tKV,"legacy",tLeg)
  ds_map_destroy(tKV)
  if tLegObj=1 and tNew and !tRedef //(the game's own objects a 30fps mod changes keep running as they do; only the mod's events are 30fps)
  {
    //(scrModLegacySetup finishes this once every mod's objects have their parents)
    global.modLegacyObj[global.modLegacyCount]=tObj
    global.modLegacyMotion[global.modLegacyCount]=1
    global.modLegacyCount+=1
  }
  //events
  tEvs=scrModScan(tDir+"objects\"+tName+"\",".gml")
  for(j=0;j<ds_list_size(tEvs);j+=1)
  {
    tEv=ds_list_find_value(tEvs,j)
    if !scrModEvent(tEv) {scrModLog("  ERROR: "+tName+": not an event: "+tEv); continue}
    //mods change (added): one of the game's events that run a mod's version in place of theirs (global.modEvList) isn't
    //cleared, which takes long for an object many others inherit from: scrModEvRegister sets the mod's version up
    if !tNew and !tAppend and string_pos(","+tEv+",",tAppList)=0
    {
      if scrModEvRegister(tName,tEv,scrModReadFile(tDir+"objects\"+tName+"\"+tEv+".gml"),tLegObj,tInh) {continue}
    }
    tT=current_time
    //if (!tNew or tRedef) and !tAppend {object_event_clear(tObj,global.modEvType,global.modEvNum)}
    if (!tNew or tRedef) and !tAppend and string_pos(","+tEv+",",tAppList)=0 {object_event_clear(tObj,global.modEvType,global.modEvNum)} //mods change: not an event object.ini's append names
    //global.modTimeClear+=current_time-tT
    tT=current_time-tT //mods change: a clear that takes long is named in the log
    global.modTimeClear+=tT
    if tT>=100 {scrModLog("  slow: clearing "+tName+" "+tEv+" took "+string(tT)+" ms")} //mods change (added)
    scrModAddEvent(tObj,global.modEvType,global.modEvNum,scrModReadFile(tDir+"objects\"+tName+"\"+tEv+".gml"),tLegObj,tInh,tName+" "+tEv)
  }
  //events it must not get from its parent: they run the inherit object's (or nothing)
  if tBlock!=""
  {
    tBl=scrModSplit(tBlock,",")
    for(j=0;j<ds_list_size(tBl);j+=1)
    {
      tEv=ds_list_find_value(tBl,j)
      if ds_list_find_index(tEvs,tEv)>=0 {continue}
      if !scrModEvent(tEv) {continue}
      if tInh>=0 {tCode="event_perform_object("+string(tInh)+","+string(global.modEvType)+","+string(global.modEvNum)+")"}
      else {tCode=""}
      object_event_add(tObj,global.modEvType,global.modEvNum,tCode)
    }
    ds_list_destroy(tBl)
  }
  ds_list_destroy(tEvs)
}
