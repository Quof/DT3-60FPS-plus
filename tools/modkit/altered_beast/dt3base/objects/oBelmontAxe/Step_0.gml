event_inherited()
if global.gamePaused=false
{
  _speed=bulletSpeed

  if arcTime>0
  {
    arcTime-=1*gDeltaTime
    if arcTime>20
    {
      if image_xscale=1
        _direction-=3*gDeltaTime
      else
        _direction+=3*gDeltaTime
    }
    else
    {
      if image_xscale=1
        _direction-=6*gDeltaTime
      else
        _direction+=6*gDeltaTime
    }
  }
  if image_xscale=1
    image_angle-=20*gDeltaTime
  else
    image_angle+=20*gDeltaTime

  if isCollisionLeft(1)
    instance_destroy()
  if isCollisionRight(1)
    instance_destroy()
  if isCollisionBottom(1)
    instance_destroy()
  if isCollisionTop(1)
    instance_destroy()
  lifeTime-=1*gDeltaTime
  if lifeTime=0
    instance_destroy()
}
else
  _speed=0
correctSpeedDirection(self)
