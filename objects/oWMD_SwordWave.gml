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
moveSpd=8
alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if type=1 {moveSpd=4}
else if type=2 {moveSpd=6}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  _speed=moveSpd
  if type=2
  {
    if room=rWarshipZ_E3 {image_xscale+=0.021*gDeltaTime; image_yscale+=0.021*gDeltaTime} //EX MODE
    else {image_xscale+=0.02*gDeltaTime; image_yscale+=0.02*gDeltaTime}
  }
}
else {_speed=0}

correctSpeedDirection(self)

#define Other_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
instance_destroy()
