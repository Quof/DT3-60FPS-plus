/*
mods change (added): loadSaveData, with the save file open: for a save made in a mod's room (scrModSaveRoom), the room
to go to (roomToPlace) is that room as the mods are loaded now, or, if its mod isn't on, the fallback room the save
names (or Central City if there's none). The same for the checkpoint room at location 49 (global.metCheckpoint).
*/
var tName,tNameRm,tUse,tRm;
tName=ini_read_string("ALPHA","130mod","")
tNameRm=ini_read_string("ALPHA","130rmmod","")
if tName="" and tNameRm="" {exit}
//the checkpoint (loadSaveData set it to the saved index, which belongs to the mods loaded when it was saved)
if global.location=49 and tName!=""
{
  tRm=scrModSavedRoom(tName)
  if tRm>=0 {global.metCheckpoint[0]=tRm}
  else {global.metCheckpoint[0]=scrModSavedRoom("")}
}
//the room the game starts in: loadSaveData took it from 130, or 130rm at location 49 with a boss going on
if global.location=49 and global.bossTrack!=0 {tUse=tNameRm}
else {tUse=tName}
if tUse="" {exit}
tRm=scrModSavedRoom(tUse)
if tRm>=0 {roomToPlace=tRm; exit}
roomToPlace=scrModSavedRoom("")
global.newMapX=global.modFbX
global.newMapY=global.modFbY
