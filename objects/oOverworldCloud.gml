#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_alpha=0.5
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if !instance_exists(oZeldaSaveMenu)
{
  x-=1*gDeltaTime
  y+=1*gDeltaTime
  if x<=-48 or y>=room_height+48 {instance_destroy()}
}
