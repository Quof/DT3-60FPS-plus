#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
makeActive()
setCollisionBounds(-28,-28,28,28)
yVel=2

//Enemy base statistics
atkPower=12
damageType="ELEMENTAL"
bCanTakeDamage=false
bShowHealthBar=false
moveSpeed=3.5
initDir=0
bTargetFound=false
bDestroy=false
inactiveDist=10000

alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if variable_local_exists("activate")
{
  bActive=1
  bTargetFound=1
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  makeEnemyActive(0)
  if bActive=true and !collision_line(x,y,oPlayer1.x,oPlayer1.y-26,oSolid,1,1)
  {
    bTargetFound=true
  }

  if bTargetFound=true
  {
    yVel+=0.3
    if initDir=1
    {
      if xVel<0
        image_angle+=5
      else
        image_angle-=5
    }
  }
  if isCollisionBottom(1)
  {
    if initDir=0 {initDir=1}
    if yVel>=6
    {
      var tEffect;
      tEffect=instance_create(x,y+(sprite_height/2),oEffect)
      tEffect.sprite_index=sGroundDust; tEffect.image_xscale=1.5; tEffect.image_speed=0.33; tEffect.image_alpha=0.75
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    }
    if yVel>=2
    {
      if oPlayer1.x>=x {xVel=moveSpeed}
      else {xVel=-moveSpeed}
    }
    yVel=0
  }
  if isCollisionLeft(1) and xVel<0
    bDestroy=1
  if isCollisionRight(1) and xVel>0
    bDestroy=1
  moveTo(xVel,yVel)

  if bDestroy=1
  {
    for(i=0;i<16;i+=1)
    {
      efRanDist=random(26)
      efRanDir=random(360)
      efRanScl=random(0.2)
      efRanSpd=random(0.4)
      tEffect=instance_create(x-8+lengthdir_x(efRanDist,efRanDir),y+8+lengthdir_y(efRanDist,efRanDir),oEffect)
      tEffect.sprite_index=sZeldaEnemyDie; tEffect.image_xscale=0.8+efRanScl; tEffect.image_yscale=0.8+efRanScl
      tEffect.image_speed=0.3+efRanSpd; tEffect.image_alpha=0.7
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    }
    instance_destroy()
  }
  if y>room_height+24 {instance_destroy()}
}
