if global.gamePaused=false
{
  //image_angle+=spinSpd
  //speed=moveSpd
  //changeTime+=1
  image_angle+=spinSpd*gDeltaTime //60fps change: per frame
  _speed=moveSpd //60fps change: DT3+'s _speed (correctSpeedDirection moves it, below), as DT3+'s oHexCircle
  changeTime+=1*gDeltaTime //60fps change: per frame
  if changeTime>=changeDelay
  {
    //direction+=180
    _direction+=180 //60fps change: DT3+'s _direction
    changeTime=0
  }
  if bFollow=1 and instance_exists(idFollow)
  {
    x=idFollow.x
    y=idFollow.y
  }
  if !instance_exists(idFollow) and x<16 and image_xscale=0.2
  {
    image_xscale=.1
    image_yscale=.1
  }
}
//else {speed=0}
else {_speed=0} //60fps change: DT3+'s _speed
correctSpeedDirection(self) //60fps change (added): moves it by _speed/_direction, as DT3+'s oHexCircle
