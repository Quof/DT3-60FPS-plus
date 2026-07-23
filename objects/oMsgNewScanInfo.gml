#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_alpha=0.8
decayTime=50
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if instance_exists(myTarget)
{
  x=myTarget.x+xOffset
  y=myTarget.y+yOffset

  if image_alpha=0.8 {image_alpha=0.6}
  else {image_alpha=0.8}

  decayTime-=1
  if decayTime<=0 {instance_destroy()}
}
else {instance_destroy()}
