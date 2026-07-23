#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
image_xscale=0.01
image_yscale=0.01
image_alpha=0.4

//Enemy base statistics
bShowHealthBar=false
bShowDamage=false
bCanTakeDamage=false
bCauseKnockback=false

atkProg=0
x=oSigmaB.sigParts[2].x-148
y=oSigmaB.sigParts[2].y-34
image_angle=oSigmaB.sigParts[2].image_angle-180
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  //x=oSigmaB.sigParts[2].x-148
  //y=oSigmaB.sigParts[2].y-34
  x=oSigmaB.sigParts[2].x-lengthdir_x(148,image_angle-180)
  y=oSigmaB.sigParts[2].y-34-lengthdir_y(148,image_angle-180)
  image_angle=oSigmaB.sigParts[2].image_angle-180
  if atkProg=0 //Grow x scale
  {
    image_xscale+=0.2
    if image_xscale>=2
    {
      image_xscale=2
      atkProg=1
    }
  }
  else if atkProg=1 //Grow y scale
  {
    image_yscale+=0.2
    if image_yscale>=2
    {
      image_yscale=2
      atkProg=2
    }
  }
  else if atkProg=3 //Shrink down
  {
    image_xscale-=0.2
    image_yscale-=0.2
    if image_xscale<=0.2 {instance_destroy()}
  }
}
#define Collision_oPlayer1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if oGame.time mod 5=0 {redDmgHit(0)}
