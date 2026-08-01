#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Sword Projectile Wave
event_inherited()
image_speed=0
image_yscale=1.5

//Enemy base statistics
bShowHealthBar=false
bShowDamage=false
bCanTakeDamage=false
size=2
_speed=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  _speed=moveSpd
  if warTarget.DIFFICULTY=1 {moveSpd-=0.1*gDeltaTime}
  else {moveSpd-=0.2*gDeltaTime}
  image_alpha-=0.075*gDeltaTime
  if image_alpha<=0.3 {bCanDealDamage=0}
  if image_alpha<=0 {instance_destroy()}
}
else {_speed=0}

x += cos(degtorad(_direction)) * _speed * gDeltaTime
y -= sin(degtorad(_direction)) * _speed * gDeltaTime
