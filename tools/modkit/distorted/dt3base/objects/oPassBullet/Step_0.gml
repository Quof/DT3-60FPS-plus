if global.gamePaused=false
{
  if init=0 {init=1}
  if decayTime!=-100
  {
    decayTime-=1*gDeltaTime
    if decayTime<=0 {instance_destroy()}
  }

  if place_meeting(x,y,oNightmareEffect) {_speed=bulletSpeed/2}
  else {_speed=bulletSpeed}
  image_angle=_direction
}
else {_speed=0}
//correctSpeedDirection(self)
x+=cos(degtorad(_direction))*_speed*gDeltaTime; y-=sin(degtorad(_direction))*_speed*gDeltaTime //60fps change: the same move as
//correctSpeedDirection without the script call (Create sets both): hundreds of these can be out at once (e.g. Shadow Eura's
//blood volleys), and at 60/120fps the call's cost every frame for each of them lagged
