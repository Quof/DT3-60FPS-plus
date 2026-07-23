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
shootDelayN - Shoot delay
atkPowerN - Attack power
dirN - Attack direction
bulletSpeedN - Bullet speed
*/

objectUse=oTrapProjectile
shootTime=1000
shootDelay=90
atkPower=4
spriteUse=0
dir=0
bulletSpeed=0
linkFrm=0
alarm[0]=1
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
if variable_local_exists("bulletSpeedN")
  bulletSpeed=bulletSpeedN

if shootDelay<2
  shootDelay=2

if direction=0
{
  offsetX=8; offsetY=0
}
else if direction=90
{
  offsetX=0; offsetY=-8
}
else if direction=180
{
  offsetX=-8; offsetY=0
}
else if direction=270
{
  offsetX=0; offsetY=8
}
image_angle=direction
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  shootTime+=1
  if shootTime>=shootDelay
  {
    newAttack=instance_create(x+offsetX,y+offsetY,objectUse)
    newAttack.sprite_index=spriteUse; newAttack.atkPower=atkPower
    newAttack.bulletSpeed=bulletSpeed; newAttack.direction=direction
    shootTime=0
  }

  if !instance_exists(objLink)
  {
    playSound(global.snd_BombExplode,0,0.92,1)
    tEffect=instance_create(x+offsetX,y+offsetY,oEffect)
    tEffect.sprite_index=sRobotExplosion
    tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    instance_destroy()
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)

if instance_exists(objLink)
{
  linkFrm+=0.33
  myDir=point_direction(x,y,objLink.bbox_left+(objLink.sprite_width/2),objLink.bbox_top+(objLink.sprite_height/2))
  myDist=point_distance(x,y,objLink.bbox_left+(objLink.sprite_width/2),objLink.bbox_top+(objLink.sprite_height/2))
  draw_sprite_ext(sZapTrap,linkFrm,x,y,myDist/32,0.5,myDir,c_green,0.4)
}
