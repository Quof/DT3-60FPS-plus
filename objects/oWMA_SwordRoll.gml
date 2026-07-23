#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Sword Roll
event_inherited()
image_speed=0
image_xscale=1.25
image_yscale=1.25

//Enemy base statistics
bShowHealthBar=false
bShowDamage=false
bCanTakeDamage=false
size=2
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  x=warTarget.x
  y=warTarget.y
  image_angle-=45*warTarget.scaleForFacing
}
