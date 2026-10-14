/*
mods change (added): loads the mods that are turned on, in load order, in passes so each mod's code can use every mod's
resources: assets; then all new objects, rooms and script slots; then the scripts; then the objects' events; then the
rooms; then patches and hooks. The loading screen shows how it's going (scrModProgress). Writes Mods\mod_log.txt (with
how long each pass took), and runs the mods' "init" hooks (initGameVars ran before the mods were loaded).
*/
//var i,tF,tN,j,p,tW,tFrom,tT,tTime,tAll;
var i,tF,tN,j,p,tW,tFrom,tT,tTime,tAll,k; //mods change: k (the title music)
scrModLog("DT3+ mods, loaded "+date_datetime_string(date_current_datetime()))
global.modMarkObj=object_add() //an object with no events: placeholders for placed instances with creation code (scrModInstSetup), a marker in patched persistent rooms, and what an instance a patch removes becomes (scrModRoomPatch)
object_event_add(global.modMarkObj,ev_destroy,0,"modGone=1") //...but a destroy event that says so (a placeholder its creation code destroyed: scrModInstCode)
//(compile errors go in the log instead of stopping the game: scrModCompile, scrModAddEvent)
tN=0
for(i=0;i<global.modCount;i+=1) {if global.modEnabled[i]=1 {tN+=1}}
//the part of the loading bar each pass fills, and in it, each mod an equal share
tW[0]=0.1; tW[1]=0.2; tW[2]=0.55; tW[3]=0.05; tW[4]=0.1
tFrom=0
global.modProgText=""
global.modProgTime=-1000
//(where the objects pass spends its time: scrModLoadObjects, scrModAddEvent)
global.modTimeProp=0; global.modTimeParent=0; global.modTimeClear=0; global.modTimeCompile=0; global.modTimeAdd=0
for(p=0;p<5;p+=1)
{
  tT=current_time
  j=0
  for(i=0;i<global.modCount;i+=1)
  {
    if global.modEnabled[i]!=1 {continue}
    global.modProgFrom=tFrom+tW[p]*j/tN
    global.modProgTo=tFrom+tW[p]*(j+1)/tN
    j+=1
    switch (p)
    {
      case 0:
        scrModLog("["+global.modFolder[i]+"] "+global.modName[i]+" "+global.modVersion[i]+" (assets)")
        scrModProgress(global.modName[i]+": sprites and sounds",0)
        scrModLoadAssets(i)
        scrModDeclare(i)
        break
      case 1:
        scrModLog("["+global.modFolder[i]+"] scripts")
        scrModProgress(global.modName[i]+": scripts",0)
        scrModLoadScripts(i)
        break
      case 2:
        scrModLog("["+global.modFolder[i]+"] objects")
        scrModProgress(global.modName[i]+": objects",0)
        scrModLoadObjects(i)
        break
      case 3:
        scrModLog("["+global.modFolder[i]+"] rooms")
        scrModProgress(global.modName[i]+": rooms",0)
        scrModLoadRooms(i)
        break
      case 4:
        scrModLog("["+global.modFolder[i]+"] patches and hooks")
        scrModProgress(global.modName[i]+": patches",0)
        scrModLoadPatches(i)
        global.modLoaded[i]=1
        global.modLoadedCount+=1
        break
    }
  }
  if p=2 {scrModLegacySetup()}
  tTime[p]=(current_time-tT)/1000
  if p=2
  {
    scrModLog("  objects: "+string(tTime[2])+" s: properties "+string(global.modTimeProp/1000)+", parents "+string(global.modTimeParent/1000)
      +", clearing events "+string(global.modTimeClear/1000)+", compiling "+string(global.modTimeCompile/1000)+", adding events "
      +string(global.modTimeAdd/1000)+" (the rest: reading the files)")
  }
  tFrom+=tW[p]
}
tAll=tTime[0]+tTime[1]+tTime[2]+tTime[3]+tTime[4]
scrModLog("done: "+string(global.modLoadedCount)+" mod(s), in "+string(tAll)+" s (assets "+string(tTime[0])+", scripts "+string(tTime[1])
  +", objects "+string(tTime[2])+", rooms "+string(tTime[3])+", patches and hooks "+string(tTime[4])+")")
//mods change (added): a mod's track 9000 is the title screen music (loadExtFiles loaded the game's; it starts playing
//once the mods are loaded: oInitializeGame)
if ds_map_exists(global.modMusic,9000)
{
  k=ds_map_find_value(global.modMusic,9000)
  if global.modMusExists[k]
  {
    if SS_IsHandleValid(global.msc_TitleMenu) {SS_FreeSound(global.msc_TitleMenu)}
    global.msc_TitleMenu=SS_LoadSound(global.modMusFile[k],1)
    if global.modMusVar[k]="" {global.modMusHandle[k]=global.msc_TitleMenu}
    else {variable_global_set(global.modMusVar[k],global.msc_TitleMenu)}
    scrModLog("title music: "+global.modMusFile[k])
  }
}
tF=file_text_open_write(global.modDir+"mod_log.txt")
file_text_write_string(tF,global.modLog)
file_text_close(tF)
scrModHook("init",0,0)
