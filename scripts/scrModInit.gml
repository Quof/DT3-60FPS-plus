/*
mods change (added): finds the mods in the Mods folder (each a folder with a mod.ini in it) and loads the ones that are
turned on (title screen > Mods; kept in DT3Options.dts, section MODS). oInitializeGame calls it once, after the
options are loaded. The files a mod is made of and what it can do: Mods\README.txt. What happened while loading the
mods: Mods\mod_log.txt.
*/
var tF,i,j,tTmp,tIni;
if variable_global_exists("modCount") {exit}
global.modDir=working_directory+"\Mods\"
global.modCount=0
global.modLoadedCount=0
global.modLog=""
global.modSpeedMul=1             //game speed multiplier a mod can set (oGame: room_speed)
global.modHook=ds_map_create()   //hook name: ds_list of code indexes (scrModHook)
global.modRoomInfo=ds_map_create()   //mod room index: ds_list (scrModLoadRoom has the layout)
global.modRoomByName=ds_map_create() //mod room name: index
global.modPatch=ds_map_create()      //room index: ds_list of patch operations (scrModRoomPatch)
global.modMusic=ds_map_create()      //music track number (findMusic): index into global.modMusVar/modMusFile/modMusCredit
global.modMusCount=0
global.modLoc=ds_map_create()        //location number (locationCheck): name
global.modScrSlot=ds_map_create()    //mod script name: slot (scrModCall)
global.modScrCount=0
global.modCodeCache=ds_map_create()  //code text: compiled index, so the same creation code is only compiled once
global.modLegacyMap=ds_map_create()  //object index: 1 for objects run in 30fps mode (scrModRun, scrModLegacyFreeze)
global.modNewObj=ds_map_create()     //object index: for objects a mod added (not the game's own), the mod that made it, +1
global.modLegacyCount=0
global.modMarkObj=-1                 //see scrModLoadAll
global.modTextCount=0                //room, instance and patch code kept as text (scrModTextAdd, scrModRunText)
//the game's scripts a mod can replace with its own version (they start with the line that calls scrModOverride;
//tools\modkit\addoverride.py adds it and keeps this list)
global.modOvrList="abilSetRemove,awardAwesome,characterCreateEvent,characterDrawEvent,characterStepEvent,charSwitcher,checkWeaponHit,enemyDefeat,enemyDrawEvent,enemyStepEvent,equipmentInit,hitPlayer,internetzDrop,locationCheck,makeEnemyActive,menuAbilitySet,menuEquipment,menuMap,menuOptions,menuProgress,menuRecognitions,menuSpendAP,npcTrivia,playerHeartDisplay,playerTechStart,playerTechUse,pMoveAirDash,pMoveDashBack,pMoveDashForward,pMoveDoubleJump,pMoveJump,pMoveWallDash,pSwapAbility,pSwapCharacter,scrFullStatRestore,showMessage,storeStatus,takeDamage,weaponDmgMod"
scrModNameMaps()
if !directory_exists(global.modDir) {exit}

//----- the mod folders -----
tF=file_find_first(global.modDir+"*",fa_directory)
while tF!=""
{
  if tF!="." and tF!=".."
  {
    if file_exists(global.modDir+tF+"\mod.ini")
    {
      global.modFolder[global.modCount]=tF
      global.modCount+=1
    }
  }
  tF=file_find_next()
}
file_find_close()

//----- their mod.ini, and whether each is turned on -----
for(i=0;i<global.modCount;i+=1)
{
  tIni=global.modDir+global.modFolder[i]+"\mod.ini"
  ini_open(tIni)
  global.modName[i]=ini_read_string("mod","name",global.modFolder[i])
  global.modAuthor[i]=ini_read_string("mod","author","")
  global.modVersion[i]=ini_read_string("mod","version","")
  global.modDesc[i]=ini_read_string("mod","description","")
  global.modLegacy[i]=ini_read_real("mod","legacy",0)
  global.modOrder[i]=ini_read_real("mod","order",0)
  global.modFallback[i]=ini_read_string("mod","fallbackRoom","")
  global.modFallbackX[i]=ini_read_real("mod","fallbackX",0)
  global.modFallbackY[i]=ini_read_real("mod","fallbackY",0)
  ini_close()
  global.modLoaded[i]=0
}
if global.modCount=0 {exit}
ini_open(global.saveDir+"DT3Options.dts")
for(i=0;i<global.modCount;i+=1) {global.modEnabled[i]=ini_read_real("MODS",global.modFolder[i],0)}
ini_close()

//----- load order: by the order in mod.ini, then by folder name -----
for(i=1;i<global.modCount;i+=1)
{
  j=i
  while j>0
  {
    if global.modOrder[j-1]>global.modOrder[j] or (global.modOrder[j-1]=global.modOrder[j] and global.modFolder[j-1]>global.modFolder[j])
    {
      scrModSwap(j-1,j)
      j-=1
    }
    else {break}
  }
}

for(i=0;i<global.modCount;i+=1) {if global.modEnabled[i]=1 {scrModLoadAll(); break}}
