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
  speed=moveSpd
  if direction>90 and direction<270 {image_angle+=5}
  else {image_angle-=5}
  if y>=room_height+32 {instance_destroy()}
}
else {speed=0}
