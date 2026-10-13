/*
mods change (added): applies the mods' patches to the room starting (oGame's room start event, so after the room's own
creation code). An instance is found by its object (not its children) and where it was placed (xstart, ystart). The
operations, in the order patch.txt has them (scrModLoadPatches turns the names in it into indexes, and code files into
compiled code):
  add|object|x|y|original id|code|mode       makes an instance there with that creation code (-1: none), run at this
                                             line, before its create event (scrModInstSetup, scrModInstCode)
  remove|object|x|y                          takes it out (without its destroy event: it was never there); it becomes
                                             an instance of global.modMarkObj, which does nothing
  move|object|x|y|new x|new y                moves it (and its start position, so later lines find it at the new one)
  code|object|x|y|code|mode                  runs code in it (after its own creation code)
  gid|object|x|y|original id                 lets GID(original id) find it
  roomcode|code|mode                         runs code (after the room's own creation code)
  tileadd|background|x|y|left|top|width|height|depth
  tileremove|depth|x|y                       deletes the tile in that layer that has the point x,y on it
The instances to add are all made (and given to GID()) before any line runs, so code that keeps another added
instance's id finds it. A persistent room keeps what was done to it, so it's only patched the first time it starts (a
marker instance, global.modMarkObj, stays in it to tell).
*/
var tL,i,tP,tKind,tObj,tX,tY,tI,tT,tAdd,tC,tM;
if !ds_map_exists(global.modPatch,room) {exit}
if room_persistent
{
  if instance_exists(global.modMarkObj) {exit}
  instance_create(0,0,global.modMarkObj)
}
tL=ds_map_find_value(global.modPatch,room)
for(i=0;i<ds_list_size(tL);i+=1)
{
  tAdd[i]=noone
  tP=scrModSplit(ds_list_find_value(tL,i),"|")
  if ds_list_find_value(tP,0)="add"
  {
    tAdd[i]=scrModInstSetup(real(ds_list_find_value(tP,2)),real(ds_list_find_value(tP,3)),real(ds_list_find_value(tP,1)),
      real(ds_list_find_value(tP,4)),1,1,4294967295,0,real(ds_list_find_value(tP,5))>=0)
  }
  ds_list_destroy(tP)
}
for(i=0;i<ds_list_size(tL);i+=1)
{
  tP=scrModSplit(ds_list_find_value(tL,i),"|")
  tKind=ds_list_find_value(tP,0)
  if tKind="roomcode"
  {
    scrModRun(real(ds_list_find_value(tP,1)),real(ds_list_find_value(tP,2)),0,0)
  }
  else if tKind="tileadd"
  {
    tile_add(real(ds_list_find_value(tP,1)),real(ds_list_find_value(tP,4)),real(ds_list_find_value(tP,5)),real(ds_list_find_value(tP,6)),
      real(ds_list_find_value(tP,7)),real(ds_list_find_value(tP,2)),real(ds_list_find_value(tP,3)),real(ds_list_find_value(tP,8)))
  }
  else if tKind="tileremove"
  {
    tT=tile_layer_find(real(ds_list_find_value(tP,1)),real(ds_list_find_value(tP,2)),real(ds_list_find_value(tP,3)))
    if tT>=0 {tile_delete(tT)}
  }
  else if tKind="add" //(its creation code)
  {
    tC=real(ds_list_find_value(tP,5)); tM=real(ds_list_find_value(tP,6))
    if tC>=0 {scrModInstCode(tAdd[i],real(ds_list_find_value(tP,1)),tC,tM)}
  }
  else
  {
    tObj=real(ds_list_find_value(tP,1)); tX=real(ds_list_find_value(tP,2)); tY=real(ds_list_find_value(tP,3))
    with (tObj)
    {
      if object_index=tObj and xstart=tX and ystart=tY
      {
        //if tKind="remove" {instance_change(global.modMarkObj,false); instance_destroy()}
        if tKind="remove" {instance_change(global.modMarkObj,false)} //(it becomes an instance of an object with no events or sprite, which does nothing)
        else if tKind="move" {x=real(ds_list_find_value(tP,4)); y=real(ds_list_find_value(tP,5)); xstart=x; ystart=y}
        else if tKind="code" {scrModRun(real(ds_list_find_value(tP,4)),real(ds_list_find_value(tP,5)),0,0)}
        else if tKind="gid" {GID_SET(real(ds_list_find_value(tP,4)),id)}
      }
    }
  }
  ds_list_destroy(tP)
}
