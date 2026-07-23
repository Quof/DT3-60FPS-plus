#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/*Requires: spinSpd,changeDelay,moveSpd
--Defaults
spinSpd=-3
changeDelay=0
moveSpd=0
*/
event_inherited()
bActive=1

//Enemy base statistics
if global.gameProgress>=4930 {atkPower=12}
else {atkPower=10}
bCanTakeDamage=false
bCauseKnockback=true
bShowHealthBar=false
changeTime=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  image_angle+=spinSpd
  speed=moveSpd
  changeTime+=1
  if changeTime>=changeDelay
  {
    direction+=180
    changeTime=0
  }
}
else {speed=0}
#define Collision_oPlayer1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
redDmgHit(0)
