/*
mods change (added): for scrModLoadSavedRoom, with the save file open: the index of a mod room saved by name, or -1 if
no mod that's on has it. With "", the fallback room the save names (or Central City if it names none, or that room
doesn't exist now), with the player's position in it in global.modFbX and global.modFbY.
argument0: the room's name, or ""
*/
var tFb,tRm;
if argument0!=""
{
  if variable_global_exists("modRoomByName") {if ds_map_exists(global.modRoomByName,argument0) {return ds_map_find_value(global.modRoomByName,argument0)}}
  return -1
}
tFb=ini_read_string("ALPHA","130modfb","")
tRm=-1
if tFb!="" and variable_global_exists("modNameRoom") {tRm=scrModFind(tFb,"room")}
if tRm>=0
{
  global.modFbX=ini_read_real("ALPHA","130modfbx",0)
  global.modFbY=ini_read_real("ALPHA","130modfby",0)
  return tRm
}
global.modFbX=640
global.modFbY=320
return rCCity_NorthA
