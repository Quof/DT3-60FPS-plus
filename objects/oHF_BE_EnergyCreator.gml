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
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  speed=bulletSpd
  image_angle-=15
  atkTimeMod+=1
  if atkTimeMod mod 9=0
  {
    var tAtk;
    tAtk=instance_create(x,y,oPassBullet)
    tAtk.sprite_index=sHexShieldConnector; tAtk.direction=270; tAtk.atkPower=atkPower
    tAtk.bulletSpeed=6; tAtk.decayTime=-100; tAtk.image_speed=0.33
  }
}
else {speed=0}
#define Other_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
instance_destroy()
