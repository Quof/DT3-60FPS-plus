/*
mods change (added): the creation code of every mod room (scrModLoadRooms sets it). The first time the room is entered,
its contents are read (scrModRoomRead). Adds the room's tiles, then makes its instances in the order the room has them
(scrModInstSetup), then runs their creation code in the same order once they're all made (scrModInstCode: an instance
with creation code gets its create event after it), so creation code that keeps another instance's id (GID(...)) finds
it even when that instance comes later in the room. Then the room's own creation code runs.
*/
var tInfo,tLeg,tMode,tN,i,k,tI,tC,tTiles,tT;
if !ds_map_exists(global.modRoomInfo,room) {exit}
tInfo=ds_map_find_value(global.modRoomInfo,room)
if ds_list_find_value(tInfo,4)<0 {scrModRoomRead(tInfo)}
tLeg=ds_list_find_value(tInfo,1)
if tLeg=1 {tMode=1} else {tMode=0}
//tiles (scrModRoomRead has what each is made of)
tTiles=ds_list_find_value(tInfo,13)
for(i=0;i<ds_list_size(tTiles);i+=11)
{
  tT=tile_add(ds_list_find_value(tTiles,i),ds_list_find_value(tTiles,i+1),ds_list_find_value(tTiles,i+2),ds_list_find_value(tTiles,i+3),
    ds_list_find_value(tTiles,i+4),ds_list_find_value(tTiles,i+5),ds_list_find_value(tTiles,i+6),ds_list_find_value(tTiles,i+7))
  if ds_list_find_value(tTiles,i+8)!=1 or ds_list_find_value(tTiles,i+9)!=1 {tile_set_scale(tT,ds_list_find_value(tTiles,i+8),ds_list_find_value(tTiles,i+9))}
  if ds_list_find_value(tTiles,i+10)!=1 {tile_set_alpha(tT,ds_list_find_value(tTiles,i+10))}
}
tN=ds_list_find_value(tInfo,4)
for(i=0;i<tN;i+=1)
{
  k=14+i*9
  tI[i]=scrModInstSetup(ds_list_find_value(tInfo,k+1),ds_list_find_value(tInfo,k+2),ds_list_find_value(tInfo,k),ds_list_find_value(tInfo,k+3),
    ds_list_find_value(tInfo,k+4),ds_list_find_value(tInfo,k+5),ds_list_find_value(tInfo,k+6),ds_list_find_value(tInfo,k+7),
    ds_list_find_value(tInfo,k+8)>=0)
}
//their creation code
for(i=0;i<tN;i+=1)
{
  k=14+i*9
  tC=ds_list_find_value(tInfo,k+8)
  //if tC>=0 {scrModInstCode(tI[i],ds_list_find_value(tInfo,k),tC,tMode)}
  if tC>=0 {scrModInstCode(tI[i],ds_list_find_value(tInfo,k),tC,tMode,1)} //mods change: the code is kept as text (scrModRoomRead)
}
//backgrounds stretched to fill the room
for(i=0;i<8;i+=1)
{
  if ds_list_find_value(tInfo,5+i)=1 and background_index[i]>=0
  {
    background_xscale[i]=room_width/background_get_width(background_index[i])
    background_yscale[i]=room_height/background_get_height(background_index[i])
  }
}
//scrModRun(ds_list_find_value(tInfo,2),tMode,0,0)
scrModRunText(ds_list_find_value(tInfo,2),tMode) //mods change: kept as text (scrModRoomRead)
