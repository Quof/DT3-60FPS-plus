if global.gamePaused=false
{
  //yVel=scrGravAcc(yVel,0.3,1)
  yVel=scrGravAcc(yVel,0.3-0.05*(room=rDEX),1) //60fps change: Distorted's lighter fall in rDEX (yVel-=0.05 below) is in the same per-tick acceleration

  if room=rDEX  //spsp DDLC
  {
    //yVel-=0.05
    if yVel>4 {yVel=4}
  }

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
