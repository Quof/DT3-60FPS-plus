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
atkTimeMod=0

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
  _speed=bulletSpd
  image_angle-=15*gDeltaTime
  atkTimeMod+=1
  if atkTimeMod mod 9=0
  {
    var tAtk;
    tAtk=instance_create(x,y,oPassBullet)
    tAtk.sprite_index=sHexShieldConnector; tAtk._direction=270; tAtk.atkPower=atkPower
    tAtk.bulletSpeed=6; tAtk.decayTime=-100; tAtk.image_speed=0.33
  }
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
instance_destroy()
