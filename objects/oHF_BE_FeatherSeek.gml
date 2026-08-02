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
lifeTime=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  image_angle=_direction
  lifeTime+=1*gDeltaTime
  if lifeTime>=15 and lifeTime<=34 {_speed=0}
  else if lifeTime=35 {_direction=point_direction(x,y,oPlayer1.x,returnPlayerYCenter())}

  if lifeTime>=1 and lifeTime<=14 {_speed=6}
  else if lifeTime>=35 {_speed=13}
}
else {_speed=0}

x += cos(degtorad(_direction)) * _speed * gDeltaTime
y -= sin(degtorad(_direction)) * _speed * gDeltaTime
#define Other_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if lifeTime>=50 {instance_destroy()}
