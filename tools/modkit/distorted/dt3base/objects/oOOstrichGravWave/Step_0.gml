if global.gamePaused=false
{
  yVel=scrGravAcc(yVel,grav,1)
  if yVel<0 {image_angle=90}
  else if yVel>0 {image_angle=270}

  if isCollisionBottom(1)
    instance_destroy()
  moveTo(xVel*gDeltaTime,yVel*gDeltaTime)

  if y>room_height+32
    instance_destroy()
}
