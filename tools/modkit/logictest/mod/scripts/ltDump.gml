//Logic Test: every instance in the room now, to Mods\LogicTest\dumps\<argument0>.txt (dump NAME), for comparing the
//room logic's view of a room with the game's (..\roomdump.py). Tab-separated lines: first R room frame newMapX newMapY
//and the player's place; then an I line an instance: id object x y xstart ystart xscale yscale angle sprite mask
//bbox_left bbox_top bbox_right bbox_bottom solid visible depth, then name=value for the exits' and places' variables
//it has, and its parent object's name (parent=); last a G line for each GID the room's instances set (GID_SET): G gid id
var tF,t,tab,k;
tab=chr(9)
if !directory_exists(global.ltDir+"dumps") {directory_create(global.ltDir+"dumps")}
tF=file_text_open_write(global.ltDir+"dumps\"+argument0+".txt")
file_text_write_string(tF,"R"+tab+room_get_name(room)+tab+string(global.ltFrame)+tab+string(global.newMapX)+tab+string(global.newMapY)+tab+ltPos())
file_text_writeln(tF)
with (all)
{
  t="I"+tab+string(id)+tab+object_get_name(object_index)+tab+string(x)+tab+string(y)+tab+string(xstart)+tab+string(ystart)
  t+=tab+string(image_xscale)+tab+string(image_yscale)+tab+string(image_angle)
  if sprite_index>=0 {t+=tab+sprite_get_name(sprite_index)} else {t+=tab+"-"}
  if mask_index>=0 {t+=tab+sprite_get_name(mask_index)} else {t+=tab+"-"}
  t+=tab+string(bbox_left)+tab+string(bbox_top)+tab+string(bbox_right)+tab+string(bbox_bottom)+tab+string(solid)+tab+string(visible)+tab+string(depth)
  if variable_local_exists("toRoom")
  {
    if is_real(toRoom) {if room_exists(toRoom) {t+=tab+"toRoom="+room_get_name(toRoom)} else {t+=tab+"toRoom="+string(toRoom)}}
    else {t+=tab+"toRoom="+string(toRoom)}
  }
  if variable_local_exists("newMapX") {t+=tab+"newMapX="+string(newMapX)}
  if variable_local_exists("newMapY") {t+=tab+"newMapY="+string(newMapY)}
  if variable_local_exists("exitType") {t+=tab+"exitType="+string(exitType)}
  if variable_local_exists("objectNum") {t+=tab+"objectNum="+string(objectNum)}
  if variable_local_exists("newX") {t+=tab+"newX="+string(newX)}
  if variable_local_exists("newY") {t+=tab+"newY="+string(newY)}
  //(the object's parent: a mod's own objects are named __newobject... in the game, their parents say what they are)
  if object_get_parent(object_index)>=0 {t+=tab+"parent="+object_get_name(object_get_parent(object_index))}
  file_text_write_string(tF,t)
  file_text_writeln(tF)
}
if variable_global_exists("objectIDMap")
{
  k=ds_map_find_first(global.objectIDMap)
  repeat (ds_map_size(global.objectIDMap))
  {
    file_text_write_string(tF,"G"+tab+string(k)+tab+string(ds_map_find_value(global.objectIDMap,k)))
    file_text_writeln(tF)
    k=ds_map_find_next(global.objectIDMap,k)
  }
}
file_text_close(tF)
