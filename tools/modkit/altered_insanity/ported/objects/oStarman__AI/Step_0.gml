if global.gamePaused=false
{
  if messageDelayTime>0 {messageDelayTime-=1}

  moveProg+=1*gDeltaTime
  if moveProg<=32
  {
    y-=0.5*gDeltaTime
    if moveProg=32
    {
      xVel=2.5
      if x>=oPlayer1.x
        xVel=2.5
      else
        xVel=-2.5
    }
  }
  else
  {
    yVel=scrGravAcc(yVel,0.3,1)
    if isCollisionBottom(1)
      yVel=-5
    if isCollisionLeft(1)
      xVel*=-1
    if isCollisionRight(1)
      xVel*=-1
    moveTo(xVel*gDeltaTime,yVel*gDeltaTime)

    if isCollisionSolid()
      y-=2
    if y>room_height+24
      instance_destroy()
  }
}
