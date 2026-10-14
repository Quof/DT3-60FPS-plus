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
}
else {_speed=0; _speed=0}
correctSpeedDirection(self)
if life<2000 {life=maxLife}
enemyStepEvent()
