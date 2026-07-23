#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
makeActive()
setCollisionBounds(-15,-15,15,15)

//Enemy base statistics
atkPower=10
damageType="ELEMENTAL"
bCanTakeDamage=false
bShowHealthBar=false
moveSpeed=3.5
bTargetFound=false

decayTime=210
maxSlope=6
maxDownSlope=5
y-=1

alarm[0]=1
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if bActive=0 {makeEnemyActive(0)}
  if bActive=true
  {
    if bTargetFound=false
    {
      if x>oPlayer1.x {xVel=-moveSpeed}
      else {xVel=moveSpeed}
      bTargetFound=true
    }
    image_xscale+=0.025; image_yscale+=0.025

    setCollisionBounds(-15*image_xscale,-15*image_yscale,15*image_xscale,15*image_yscale)

    if yVel<3 {yVel+=0.2}
    if xVel<0
      image_angle+=5
    else
      image_angle-=5

    decayTime-=1
    if decayTime<=0
    {
      for(i=0;i<20;i+=1)
      {
        tRanScl=1+random(0.5)
        tEffect=instance_create(x+random_range(-15*image_xscale,15*image_xscale),y+random_range(-15*image_yscale,15*image_yscale),oEffect)
        tEffect.sprite_index=sEfSnowballBreak; tEffect.image_xscale=tRanScl; tEffect.image_yscale=tRanScl
        tEffect.image_speed=0.2+random(0.1); tEffect.xSpd=random_range(-3,3); tEffect.ySpd=random_range(-3,3)
        tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0
      }
      instance_destroy()
    }

    if isCollisionBottom(1)
      yVel=0
    if isCollisionSolid()
      y-=6

    //moveTo(xVel,yVel)
    enemySlopeMovement()

    if y>room_height+24
      instance_destroy()
  }
}
