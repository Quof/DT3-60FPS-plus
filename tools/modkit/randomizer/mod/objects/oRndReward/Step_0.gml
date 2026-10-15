//(falls like oDoorKey)
if global.gamePaused=false
{
  yVel=scrGravAcc(yVel,0.3,1)
  moveTo(xVel*gDeltaTime,yVel*gDeltaTime)
  if isCollisionSolid() {y-=2}
  if y>room_height+24 {instance_destroy()}
}
