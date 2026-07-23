#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
vspeed=-3
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if image_xscale=1
{
  hspeed=-1.25
  image_angle+=30
}
else
{
  hspeed=1.25
  image_angle-=30
}

vspeed+=0.3
image_alpha-=0.06
if image_alpha<=0
  instance_destroy()
