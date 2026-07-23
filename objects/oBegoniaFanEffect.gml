#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_speed=0
image_xscale=1.5+random(1.5)
image_blend=make_color_rgb(50,190,255)
decayTime=29+irandom(3)
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
    image_alpha-=0.065
    if image_alpha<=0 {instance_destroy()}
  }
}
#define Collision_oSolid
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
instance_destroy()
