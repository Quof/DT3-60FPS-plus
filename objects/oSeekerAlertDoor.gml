#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
sprite_index=sNull
alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//gid order change (added): the creation code looks up the item this door guards (itemID) with GID, but the item can
//come later in the room's order and register itself (GID_SET) after it, so on the room's first visit the door found
//no item and destroyed itself in its first Step. Looked up again here (before that Step), once every instance exists
if variable_local_exists("itemCache") {itemID=GID(itemCache)}
if variable_local_exists("bBlock")
{
  sprite_index=sInvisibleSolidMask
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if !instance_exists(itemID)
{
  instance_destroy()
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if sprite_index=sInvisibleSolidMask
{
  for(i=0;i<image_yscale;i+=1)
  {
    draw_sprite(sSeekerDoor,1,x,y+(16*i))
  }
}
