#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
makeActive()
setCollisionBounds(-15,-15,15,15)
bActive=true

//Enemy base statistics
atkPower=8
bCanTakeDamage=false
bShowHealthBar=false
initDir=0
bDestroy=false
bounceHeight=8

if oPlayer1.x>=x
  xVel=0.1
else
  xVel=-0.1
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  yVel+=0.3
  if yVel>12 {yVel=12}

  if xVel<0
    image_angle+=5
  else
    image_angle-=5

  if isCollisionBottom(1)
  {
    if initDir=0
    {
      if oPlayer1.x>=x
        xVel=moveSpeed
      else
        xVel=-moveSpeed
      initDir=1
    }
    if yVel>=6
    {
      var tEffect;
      tEffect=instance_create(x,y+(sprite_height/2),oEffect)
      tEffect.sprite_index=sGroundDust; tEffect.image_xscale=1.5
      tEffect.image_speed=0.33; tEffect.image_alpha=0.75
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    }
    yVel=-bounceHeight
  }
  if isCollisionLeft(1) and xVel<0
    bDestroy=1
  if isCollisionRight(1) and xVel>0
    bDestroy=1
  moveTo(xVel,yVel)

  if bDestroy=1
  {
    for(i=0;i<8;i+=1)
    {
      efRanDist=random(15)
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
  if y>room_height+24
    instance_destroy()
}
