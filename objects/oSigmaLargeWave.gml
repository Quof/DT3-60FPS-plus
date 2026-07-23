#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
image_yscale=0.5

//Enemy base statistics
bShowHealthBar=false
bShowDamage=false
bCanTakeDamage=false
atkProg=0
moveSpd=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if atkProg=0 //Go up
  {
    y-=6
    if y<=yAtk {atkProg=1}
  }
  else if atkProg=1 //Grow
  {
    image_yscale+=0.1
    if image_yscale>=1.7 {atkProg=2}
  }
  else if atkProg=2 //Fire
  {
    x+=moveSpd
    if image_xscale=1 and moveSpd<7 {moveSpd+=0.2}
    if image_xscale=-1 and moveSpd>-7 {moveSpd-=0.2}
  }
}
#define Collision_oPlayer1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
redDmgHit(0)
#define Other_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
instance_destroy()
