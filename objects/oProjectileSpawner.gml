#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/*
Projectile Spawner
objectUseN - Object to use
spriteUseN - Sprite to use
shootTimeN - Start time
shootDelayN - Shoot delay
atkPowerN - Attack power
dirN - Attack _direction
bulletSpeedN - Bullet speed
*/

objectUse=oTrapProjectile
shootTime=1000
shootDelay=90
atkPower=4
spriteUse=0
dir=0
bulletSpeed=0
alarm[0]=1

_direction=0
_speed=0
_hspeed=0
_vspeed=0
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if variable_local_exists("objectUseN")
  objectUse=objectUseN
if variable_local_exists("spriteUseN")
  spriteUse=spriteUseN
if variable_local_exists("shootTimeN")
  shootTime=shootTimeN
if variable_local_exists("shootDelayN")
  shootDelay=shootDelayN
if variable_local_exists("atkPowerN")
  atkPower=atkPowerN
if variable_local_exists("dirN")
  dir=dirN
if variable_local_exists("bulletSpeedN")
  bulletSpeed=bulletSpeedN

if shootDelay<2
  shootDelay=2

if room=rWarshipZ_A or room=rWarshipZ_B or room=rWarshipZ_C or room=rWarshipZ_D or room=rWarshipZ_F
{
  atkPower=14
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  shootTime+=1*gDeltaTime
  if shootTime>=shootDelay
  {
    newAttack=instance_create(x+8,y+8,objectUse)
    newAttack.sprite_index=spriteUse; newAttack.atkPower=atkPower
    newAttack.bulletSpeed=bulletSpeed; newAttack._direction=dir
    if spriteUse=sSkelefire {newAttack.damageType="ELEMENTAL"}
    shootTime=0
  }
}
correctSpeedDirection(self)
