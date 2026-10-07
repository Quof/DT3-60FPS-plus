#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
image_xscale=3
image_yscale=3

damageType="SHOT"
weaponTag=120
bCanPierce=1
stunTime=1
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  image_alpha-=0.02*gDeltaTime
  //image_index+=0.2
  image_index+=0.2*gDeltaTime //60fps change: the explosion animated and ended 2x/4x too fast at 60/120fps
  if image_index>=4.5
  {
    instance_destroy()
  }
}
