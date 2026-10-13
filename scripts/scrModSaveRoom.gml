/*
mods change (added): saveData, with the save file open: a mod room's index changes with the mods that are on, so the
rooms the save keeps (130, and 130rm at location 49) are also saved by name when they're mod rooms (130mod, 130rmmod),
with where to go instead if the mod isn't on when the save is loaded (its fallback room and position: 130modfb,
130modfbx, 130modfby). scrModLoadSavedRoom reads them.
*/
var tR,tRm,tInfo,m;
if !variable_global_exists("modRoomInfo") {exit}
if global.location=49 {tR=global.metCheckpoint[0]; tRm=room}
else {tR=room; tRm=-1}
ini_write_string("ALPHA","130mod","")
ini_write_string("ALPHA","130rmmod","")
if ds_map_exists(global.modRoomInfo,tR)
{
  tInfo=ds_map_find_value(global.modRoomInfo,tR)
  ini_write_string("ALPHA","130mod",ds_list_find_value(tInfo,3))
}
if ds_map_exists(global.modRoomInfo,tRm)
{
  tInfo=ds_map_find_value(global.modRoomInfo,tRm)
  ini_write_string("ALPHA","130rmmod",ds_list_find_value(tInfo,3))
}
if ds_map_exists(global.modRoomInfo,room) {tInfo=ds_map_find_value(global.modRoomInfo,room)}
else if ds_map_exists(global.modRoomInfo,tR) {tInfo=ds_map_find_value(global.modRoomInfo,tR)}
else {exit}
m=ds_list_find_value(tInfo,0)
ini_write_string("ALPHA","130modfb",global.modFallback[m])
ini_write_real("ALPHA","130modfbx",global.modFallbackX[m])
ini_write_real("ALPHA","130modfby",global.modFallbackY[m])
