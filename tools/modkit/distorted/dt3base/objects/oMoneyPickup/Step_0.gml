if global.gamePaused=false
{
  yVel=scrGravAcc(yVel,0.3,1)

  if isCollisionBottom(1)
    yVel=0
  if isCollisionSolid()
  {
    if gDeltaTime>=0.5
      y-=2*gDeltaTime
    else if oGame.time mod (0.5/gDeltaTime) = 0
      y-=1
  }
  moveTo(xVel*gDeltaTime,yVel*gDeltaTime)

  if y>room_height+24
    instance_destroy()
}
