#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
image_xscale=room_width
image_yscale=4

//Enemy base statistics
bShowHealthBar=false
bShowDamage=false
bCanTakeDamage=false
size=2
init=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  //image_blend=make_color_rgb(155+random(100),155+random(100),155+random(100))
  if gDeltaDoTicks {image_blend=make_color_rgb(155+random(100),155+random(100),155+random(100))} //60fps change: new random tint once per 30fps tick, not every frame (flickered 4x as fast at 120fps)
  image_angle=oMenaceMain.bHead.image_angle+235
}
