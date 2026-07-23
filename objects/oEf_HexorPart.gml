#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Requires: partDelay
visible=0
image_alpha=0.75
image_angle=random(360)
spriteScale=0.75+random(0.35)
image_xscale=spriteScale; image_yscale=spriteScale
partProg=0
partTime=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if partProg=0
{
  partTime+=1
  if partTime>=partDelay
  {
    visible=1
    partTime=0
    partProg=1
  }
}
if partProg=1
{
  image_xscale+=0.02; image_xscale+=0.02
  partTime+=1
  if partTime>=10
  {
    partProg=2
  }
}
else if partProg=2
{
  image_xscale-=0.01; image_xscale-=0.01
  image_alpha-=0.3
  if image_alpha<=0 {instance_destroy()}
}
