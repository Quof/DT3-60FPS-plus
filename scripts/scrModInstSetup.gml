/*
mods change (added): makes an instance placed in a mod's room or by a room patch (scrModRoomStart, scrModRoomPatch),
with the room editor's scale, colour and angle and its original id (modOrigId, for code that worked something out from
an instance's id; GID() finds it by that id). The callers make all the room's instances this way first, then run their
creation code (scrModInstCode), so creation code that keeps another instance's id (GID(...)) finds it even when that
instance comes later in the room.
  Without creation code, it's made with instance_create (its create event runs).
  With creation code, it's a placeholder for now (global.modMarkObj, with the object's sprite, depth and other settings):
  scrModInstCode runs the creation code in it and then makes it the object, whose create event runs then, so the
  creation code comes first, as in a room made in the editor.
argument0, argument1: x, y
argument2: object
argument3: original id (0: none)
argument4, argument5: xscale, yscale
argument6: colour and alpha, as the room editor keeps them (alpha*16777216 + colour)
argument7: angle
argument8: whether it has creation code
returns the instance
*/
var tObj,tNew;
tObj=argument2
if argument8 {tNew=instance_create(argument0,argument1,global.modMarkObj)}
else {tNew=instance_create(argument0,argument1,tObj)}
with (tNew)
{
  if argument8
  {
    sprite_index=object_get_sprite(tObj); mask_index=object_get_mask(tObj); depth=object_get_depth(tObj)
    visible=object_get_visible(tObj); solid=object_get_solid(tObj); persistent=object_get_persistent(tObj)
  }
  if argument4!=1 {image_xscale=argument4}
  if argument5!=1 {image_yscale=argument5}
  if argument6!=4294967295 {image_blend=argument6 mod 16777216; image_alpha=floor(argument6/16777216)/255}
  if argument7!=0 {image_angle=argument7}
  modOrigId=argument3
}
if argument3>0 {GID_SET(argument3,tNew)}
return tNew
