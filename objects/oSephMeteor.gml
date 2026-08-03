#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()

//Enemy base statistics
bShowHealthBar=false
bShowDamage=false
bCanTakeDamage=false
damageType="EXPLOSION"
bCanBeBlocked=1
blockCost=350
bParryOpp=1
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  _speed=moveSpd
  if _direction>90 and _direction<270 {image_angle+=5*gDeltaTime}
  else {image_angle-=5*gDeltaTime}
  if y>=room_height+32 {instance_destroy()}
}
else {_speed=0}

correctSpeedDirection(self)
