if global.gamePaused=false
{
  image_angle=_direction
  dist=point_distance(x,y,xstart,ystart)
  if dist>24 or room=rGame6_CoDB //spsp ns
  {
    if isCollisionTop(1)
      instance_destroy()
    if isCollisionBottom(1)
      instance_destroy()
    if isCollisionLeft(1)
      instance_destroy()
    if isCollisionRight(1)
      instance_destroy()
    if isCollisionSolid()
      instance_destroy()
  }
  yVel=scrGravAcc(yVel,grav,1)
  moveTo(xVel*gDeltaTime,yVel*gDeltaTime)

  if y>room_height+32
    instance_destroy()
}
