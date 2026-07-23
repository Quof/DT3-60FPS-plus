#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
makeActive()
setCollisionBounds(-7,-22,7,-1)
image_speed=0.2

initDir=0
weight=100
runAcc=1.2
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if initDir=false
  {
    xVel=runAcc
    if x>oPlayer1.x
      xVel*=-1
    initDir=true
  }
  yVel+=0.3
  if isCollisionBottom(1)
    yVel=-6
  if isCollisionLeft(1)
    xVel*=-1
  if isCollisionRight(1)
    xVel*=-1
  if isCollisionTop(1)
    yVel=0.1

  if xVel>runAcc
    xVel=runAcc
  if xVel<-runAcc
    xVel=-runAcc
  if xVel>0
    image_xscale=1
  else
    image_xscale=-1
  moveTo(xVel,yVel)
  if isCollisionSolid()
    y-=2
}
