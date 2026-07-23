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
  image_angle=direction
  lifeTime+=1
  if lifeTime>=15 and lifeTime<=34 {speed=0}
  else if lifeTime=35 {direction=point_direction(x,y,oPlayer1.x,returnPlayerYCenter())}

  if lifeTime>=1 and lifeTime<=14 {speed=6}
  else if lifeTime>=35 {speed=13}
}
else {speed=0}
#define Other_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if lifeTime>=50 {instance_destroy()}
