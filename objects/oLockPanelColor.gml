#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_speed=0
#define Collision_oPlayer1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if oEvKeyControl.keyCheck[image_index]=1
{
  playSound(global.snd_DoorUnlock,0,1,1)
  oEvKeyControl.keyCheck[image_index]=2
  with targetDoor
    instance_destroy()
}
