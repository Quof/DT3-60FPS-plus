if global.gamePaused=false
{
  image_angle+=spinSpd*gDeltaTime
  _speed=moveSpd
  changeTime+=1*gDeltaTime
  if changeTime>=changeDelay
  {
    _direction+=180
    changeTime=0
  }
  if bFollow=1 and instance_exists(idFollow)
  {
    x=idFollow.x
    y=idFollow.y
  }
  /*if !instance_exists(idFollow) and x<16 and image_xscale=0.2
  {
    image_xscale=.1
    image_yscale=.1
  }*/
}
else {_speed=0; _speed=0}
correctSpeedDirection(self)
