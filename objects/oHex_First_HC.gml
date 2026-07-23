#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
bActive=1

//Enemy base statistics
bCanTakeDamage=false
bCauseKnockback=true
bShowHealthBar=false
startScale=4
image_xscale=startScale
image_yscale=startScale
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  image_angle+=spinSpd

  image_xscale-=0.025
  image_yscale-=0.025
  if image_xscale<=0
  {
    if bDestroyOnSize=1 {instance_destroy()}
    if image_xscale<=-startScale {instance_destroy()}
  }
}
#define Collision_oPlayer1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
redDmgHit(0)
