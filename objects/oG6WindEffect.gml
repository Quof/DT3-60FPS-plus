#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_speed=0
image_xscale=1.5+random(1.5)
image_blend=make_color_rgb(60,255,160)
decayTime=12+irandom(3)
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  x+=xSpd
  y+=ySpd
  decayTime-=1
  if decayTime<=0
  {
    image_alpha-=0.08
    if image_alpha<=0 {instance_destroy()}
  }
}
