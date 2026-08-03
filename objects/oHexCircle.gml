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

if room=rWarshipZ_A or room=rWarshipZ_B
{
  atkPower=14
}
bCanTakeDamage=false
bCauseKnockback=true
bShowHealthBar=false
changeTime=0
_speed=0
_direction=0
_speed=0
_direction=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  image_angle+=spinSpd*gDeltaTime
  _speed=moveSpd
  changeTime+=1*gDeltaTime
  if changeTime>=changeDelay
  {
    _direction+=180
    changeTime=0
  }
  x += cos(degtorad(_direction)) * _speed *gDeltaTime
  y -= sin(degtorad(_direction)) * _speed *gDeltaTime
}
else {_speed=0; _speed=0}
correctSpeedDirection(self)
#define Collision_oPlayer1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
redDmgHit(0)
