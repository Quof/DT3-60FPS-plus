#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_speed=0
animProg=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if animProg=0
{
  image_index+=0.07
  if image_index>=2.5 {animProg=1}
}
else if animProg=1
{
  image_index-=0.07
  if image_index<=0.5 {animProg=0}
}
