if global.gamePaused=false
{
  if hasGravity = 1
  {
      //yVel+=0.3
      yVel=scrGravAcc(yVel,0.3,1) //60fps change: gravity per 30fps tick, spread over its frames (scrGravAcc), as oSmallJumper
      if isCollisionBottom(1)
        yVel=0
      //moveTo(xVel,yVel)
      moveTo(xVel*gDeltaTime,yVel*gDeltaTime) //60fps change: per frame

      if isCollisionSolid()
        y-=2
      if y>room_height+24
        instance_destroy()
  }
}
