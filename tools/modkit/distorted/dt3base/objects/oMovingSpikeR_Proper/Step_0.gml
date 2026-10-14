if global.gamePaused=false
{
  x+=moveSpd*cos(degtorad(_direction))*gDeltaTime
  y+=-moveSpd*sin(degtorad(_direction))*gDeltaTime
  if shiftTime>=shiftMax
  {
    shiftTime=0
    _direction+=180
  }
  else {shiftTime+=1*gDeltaTime}
}
correctSpeedDirection(self)
