#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
frameCount=0
maxFrame=image_number+1
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  image_angle+=10*image_xscale*gDeltaTime
  image_index+=1*gDeltaTime
  frameCount+=1*gDeltaTime
  if frameCount>=maxFrame {instance_destroy()}
}
