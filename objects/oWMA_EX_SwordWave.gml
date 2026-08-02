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
moveSpd=16

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
  _speed=moveSpd
  moveSpd-=0.175

  if image_alpha<=0.3 {image_alpha-=0.075*gDeltaTime}
  else {image_alpha-=0.04*gDeltaTime}

  if image_alpha<=0.3 {bCanDealDamage=0}
  if image_alpha<=0 {instance_destroy()}
}
else {_speed=0}

x += cos(degtorad(_direction)) * _speed * gDeltaTime
y -= sin(degtorad(_direction)) * _speed * gDeltaTime
