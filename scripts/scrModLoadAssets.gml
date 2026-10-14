/*
mods change (added): loads a mod's sprites, backgrounds and fonts, and reads its sounds, music tracks and locations
from mod.ini. A sprite or background with the name of one of the game's own replaces it.
argument0: the mod (its place in the mod list)
*/
var m,tDir,tL,i,tName,tFile,tIdx,tOld,tN,tVar,tTrack,k;
m=argument0
tDir=global.modDir+global.modFolder[m]+"\"

//----- sprites: sprites\<name>.png (a strip of its frames, left to right) and sprites\<name>.ini -----
tL=scrModScan(tDir+"sprites\",".png")
for(i=0;i<ds_list_size(tL);i+=1)
{
  scrModProgress("",i/ds_list_size(tL))
  tName=ds_list_find_value(tL,i)
  tFile=tDir+"sprites\"+tName+".png"
  ini_open(tDir+"sprites\"+tName+".ini")
  var tFrames,tXo,tYo,tTr,tSm,tSep,tBb,tLe,tTo,tRi,tBo,tKind,tTol;
  tFrames=ini_read_real("sprite","frames",1); tXo=ini_read_real("sprite","xorig",0); tYo=ini_read_real("sprite","yorig",0)
  tTr=ini_read_real("sprite","transparent",0); tSm=ini_read_real("sprite","smooth",0); tSep=ini_read_real("sprite","sepmasks",0)
  tBb=ini_read_real("sprite","bboxmode",0); tLe=ini_read_real("sprite","left",0); tTo=ini_read_real("sprite","top",0)
  tRi=ini_read_real("sprite","right",0); tBo=ini_read_real("sprite","bottom",0); tKind=ini_read_real("sprite","kind",0)
  tTol=ini_read_real("sprite","tolerance",0)
  ini_close()
  tOld=scrModFind(tName,"spr")
  if tOld>=0
  {
    if sprite_replace(tOld,tFile,tFrames,tTr,tSm,tXo,tYo) {tIdx=tOld; scrModLog("  sprite replaced: "+tName)}
    else {tIdx=-1}
  }
  else
  {
    tIdx=sprite_add(tFile,tFrames,tTr,tSm,tXo,tYo)
    if tIdx>=0 {scrModRegister(tName,tIdx,"spr")}
  }
  if tIdx<0 {scrModLog("  ERROR loading sprite "+tName)}
  else {sprite_collision_mask(tIdx,tSep,tBb,tLe,tTo,tRi,tBo,tKind,tTol)}
}
ds_list_destroy(tL)

//----- backgrounds: backgrounds\<name>.png and backgrounds\<name>.ini -----
tL=scrModScan(tDir+"backgrounds\",".png")
for(i=0;i<ds_list_size(tL);i+=1)
{
  tName=ds_list_find_value(tL,i)
  tFile=tDir+"backgrounds\"+tName+".png"
  ini_open(tDir+"backgrounds\"+tName+".ini")
  tTr=ini_read_real("background","transparent",0); tSm=ini_read_real("background","smooth",0)
  ini_close()
  tOld=scrModFind(tName,"bg")
  if tOld>=0
  {
    if background_replace(tOld,tFile,tTr,tSm) {scrModLog("  background replaced: "+tName)}
    else {scrModLog("  ERROR loading background "+tName)}
  }
  else
  {
    tIdx=background_add(tFile,tTr,tSm)
    if tIdx>=0 {scrModRegister(tName,tIdx,"bg")}
    else {scrModLog("  ERROR loading background "+tName)}
  }
}
ds_list_destroy(tL)

//----- fonts: fonts\<name>.ini (a font installed on the computer) -----
tL=scrModScan(tDir+"fonts\",".ini")
for(i=0;i<ds_list_size(tL);i+=1)
{
  tName=ds_list_find_value(tL,i)
  ini_open(tDir+"fonts\"+tName+".ini")
  tIdx=font_add(ini_read_string("font","face","Arial"),ini_read_real("font","size",8),ini_read_real("font","bold",0),ini_read_real("font","italic",0),ini_read_real("font","first",32),ini_read_real("font","last",127))
  ini_close()
  if tIdx>=0 {scrModRegister(tName,tIdx,"font")}
  else {scrModLog("  ERROR loading font "+tName)}
}
ds_list_destroy(tL)

//----- mod.ini: sounds (loaded into global.<var>), music tracks (findMusic loads them when asked for), locations -----
ini_open(tDir+"mod.ini")
tN=ini_read_real("sounds","count",0)
for(k=0;k<tN;k+=1)
{
  tVar=ini_read_string("sounds","var"+string(k),"")
  tFile=tDir+"sound\"+ini_read_string("sounds","file"+string(k),"")
  if tVar!=""
  {
    if file_exists(tFile) {variable_global_set(tVar,SS_LoadSound(tFile,0))}
    else {variable_global_set(tVar,0); scrModLog("  sound file missing: "+tFile)}
  }
}
tN=ini_read_real("music","count",0)
var tMiss,tMissName; tMiss=0; tMissName="" //mods change (added)
for(k=0;k<tN;k+=1)
{
  tTrack=ini_read_real("music","track"+string(k),0)
  tVar=ini_read_string("music","var"+string(k),"")
  global.modMusVar[global.modMusCount]=tVar
  global.modMusFile[global.modMusCount]=tDir+"music\"+ini_read_string("music","file"+string(k),"")
  global.modMusCredit[global.modMusCount]=ini_read_string("music","credit"+string(k),"")
  global.modMusGain[global.modMusCount]=ini_read_real("music","gain"+string(k),0) //mods change (added): its loudness adjustment in dB (getReplayGain)
  global.modMusHandle[global.modMusCount]=0
  //if !file_exists(global.modMusFile[global.modMusCount]) {scrModLog("  music file missing: "+global.modMusFile[global.modMusCount])}
  global.modMusExists[global.modMusCount]=file_exists(global.modMusFile[global.modMusCount]) //mods change (added): a track number the game has plays the game's track while the file isn't there
  if !global.modMusExists[global.modMusCount] {tMiss+=1; if tMissName="" {tMissName=global.modMusFile[global.modMusCount]}} //mods change: counted, for one line in the log
  if tVar!="" {if !variable_global_exists(tVar) {variable_global_set(tVar,0)}}
  if ds_map_exists(global.modMusic,tTrack) {ds_map_replace(global.modMusic,tTrack,global.modMusCount)}
  else {ds_map_add(global.modMusic,tTrack,global.modMusCount)}
  global.modMusCount+=1
}
if tMiss>0 {scrModLog("  music files missing: "+string(tMiss)+" (the first: "+tMissName+")")} //mods change (added)
tN=ini_read_real("locations","count",0)
for(k=0;k<tN;k+=1)
{
  tTrack=ini_read_real("locations","id"+string(k),0)
  if ds_map_exists(global.modLoc,tTrack) {ds_map_replace(global.modLoc,tTrack,ini_read_string("locations","name"+string(k),""))}
  else {ds_map_add(global.modLoc,tTrack,ini_read_string("locations","name"+string(k),""))}
}
ini_close()
