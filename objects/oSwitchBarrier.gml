#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Requires: switchID
image_alpha=0.9
image_blend=c_orange
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if gDeltaDoTicks
{
  if image_alpha=0.9 {image_alpha=0.8}
  else {image_alpha=0.9}
}

//set in the instance creation code
switchInstance = GID(switchCache)
if (switchInstance != noone)
{
  if switchInstance.activated=1 {instance_destroy()}
}
