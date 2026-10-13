/*
mods change (added): builds a mod's new rooms from their folders (rooms\<name>\, the GameMaker 8.2 project format:
room.txt, instances.txt, layers.txt with a <depth>.txt per tile layer, code.gml, and <instance name>.gml for an
instance's creation code). An instance's name is its id in the game the room came from (GID() finds it by that id).
Only the room's settings (room.txt) are read here; its instances, tiles and creation code are read the first time the
room is entered (scrModRoomRead), so the game doesn't start by reading every room of every mod. The room's creation
code is set to scrModRoomStart(), which makes the tiles and instances (so their creation code can run before their
create event, as in a room made in the editor) and runs the room's own creation code. global.modRoomInfo[room] keeps
what it needs:
  0 mod, 1 30fps mod, 2 room code (compiled, or -1), 3 name, 4 instance count (-1 until the room's contents are read),
  5-12 for each background 0-7 whether it's stretched to fill the room, 13 the tiles (a ds_list, -1 until read: 11
  values a tile, see scrModRoomRead), then for each instance: object, x, y, original id, xscale, yscale, blend, angle,
  creation code (compiled, or -1)
argument0: the mod (its place in the mod list)
*/
var m,tDir,i,k,tName,tRm,tRd,tKV,tInfo,tStretch;
m=argument0
tDir=global.modDir+global.modFolder[m]+"\"
for(i=0;i<ds_list_size(global.modRoomNames[m]);i+=1)
{
  tName=ds_list_find_value(global.modRoomNames[m],i)
  tRm=scrModFind(tName,"room")
  tRd=tDir+"rooms\"+tName+"\"
  //----- settings -----
  tKV=scrModReadKV(tRd+"room.txt")
  room_set_caption(tRm,scrModKVS(tKV,"caption"))
  room_set_width(tRm,scrModKV(tKV,"width",480))
  room_set_height(tRm,scrModKV(tKV,"height",352))
  room_set_persistent(tRm,scrModKV(tKV,"roompersistent",0))
  room_set_background_color(tRm,scrModKV(tKV,"bg_color",0),scrModKV(tKV,"clear_screen",1))
  for(k=0;k<8;k+=1)
  {
    room_set_background(tRm,k,scrModKV(tKV,"bg_visible"+string(k),0),scrModKV(tKV,"bg_is_foreground"+string(k),0),
      scrModFind(scrModKVS(tKV,"bg_source"+string(k)),"bg"),scrModKV(tKV,"bg_xoffset"+string(k),0),scrModKV(tKV,"bg_yoffset"+string(k),0),
      scrModKV(tKV,"bg_tile_h"+string(k),1),scrModKV(tKV,"bg_tile_v"+string(k),1),scrModKV(tKV,"bg_hspeed"+string(k),0),
      scrModKV(tKV,"bg_vspeed"+string(k),0),1)
    tStretch[k]=scrModKV(tKV,"bg_stretch"+string(k),0) //(room_set_background has no setting for it: scrModRoomStart scales it)
  }
  room_set_view_enabled(tRm,scrModKV(tKV,"views_enabled",0))
  for(k=0;k<8;k+=1)
  {
    room_set_view(tRm,k,scrModKV(tKV,"view_visible"+string(k),0),scrModKV(tKV,"view_xview"+string(k),0),scrModKV(tKV,"view_yview"+string(k),0),
      scrModKV(tKV,"view_wview"+string(k),640),scrModKV(tKV,"view_hview"+string(k),480),scrModKV(tKV,"view_xport"+string(k),0),
      scrModKV(tKV,"view_yport"+string(k),0),scrModKV(tKV,"view_wport"+string(k),640),scrModKV(tKV,"view_hport"+string(k),480),
      scrModKV(tKV,"view_fol_hbord"+string(k),32),scrModKV(tKV,"view_fol_vbord"+string(k),32),scrModKV(tKV,"view_fol_hspeed"+string(k),-1),
      scrModKV(tKV,"view_fol_vspeed"+string(k),-1),scrModFind(scrModKVS(tKV,"view_fol_target"+string(k)),"obj"))
  }
  ds_map_destroy(tKV)

  tInfo=ds_list_create()
  ds_list_add(tInfo,m)
  ds_list_add(tInfo,global.modLegacy[m])
  ds_list_add(tInfo,-1)
  ds_list_add(tInfo,tName)
  ds_list_add(tInfo,-1)
  for(k=0;k<8;k+=1) {ds_list_add(tInfo,tStretch[k])}
  ds_list_add(tInfo,-1)
  room_set_code(tRm,"scrModRoomStart()")
  ds_map_add(global.modRoomInfo,tRm,tInfo)
  scrModProgress("",(i+1)/ds_list_size(global.modRoomNames[m]))
}
