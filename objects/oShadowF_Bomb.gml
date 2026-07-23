#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
makeActive()
setCollisionBounds(-4,-4,4,4)
image_blend=c_black
lifeTime=90
atkPower=oShadowForm.atkPower
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
if global.gamePaused=false
{
  yVel+=0.2
  if xVel>2
    xVel-=0.025
  else if xVel<-2
    xVel+=0.025

  if isCollisionLeft(1)
    xVel*=-1
  if isCollisionRight(1)
    xVel*=-1
  if isCollisionBottom(1)
  {
    yVel=0
    if xVel>0
      xVel-=0.4
    else if xVel<0
      xVel+=0.4

    if (xVel<0.5 and xVel>0) or (xVel>-0.5 and xVel<0)
      xVel=0
  }
  if isCollisionTop(1)
    yVel=1
  if isCollisionSolid()
    y-=2

  moveTo(xVel,yVel)

  lifeTime-=1
  if lifeTime<30 and lifeTime>0 //Flash red
  {
    if oGame.time mod 6=0
    {
      if image_blend=c_black
        image_blend=c_red
      else
        image_blend=c_black
    }
  }
  else if lifeTime=0 //Explode
  {
    if checkScreenArea(x,y,64)=1 {playSound(global.snd_BombExplode,0,0.92,1)}
    newAttack=instance_create(x,y,oDamageExplosion)
    newAttack.atkPower=atkPower; newAttack.sprite_index=sBombExplosion; newAttack.decayTime=-100
    newAttack.image_blend=c_black
    instance_destroy()
  }
}
