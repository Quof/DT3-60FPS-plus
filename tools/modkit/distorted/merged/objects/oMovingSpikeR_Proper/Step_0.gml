if global.gamePaused=false
{
  //speed=moveSpd
  //shiftTime+=1
  _speed=moveSpd //60fps change: DT3+'s _speed (correctSpeedDirection moves it, below)
  shiftTime+=1*gDeltaTime //60fps change: per frame
  if shiftTime>=shiftMax
  {
    shiftTime=0
    _direction+=180
  }
}
//else {speed=0}
else {_speed=0} //60fps change: DT3+'s _speed
correctSpeedDirection(self)
