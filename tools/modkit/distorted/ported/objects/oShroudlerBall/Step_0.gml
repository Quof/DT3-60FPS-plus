if global.gamePaused=false
{
  /*if init=0 {init=1}
  if decayTime!=-100
  {
    decayTime-=1
    if decayTime<=0 {instance_destroy()}
  }*/

  //speed=bulletSpeed
  //image_angle-=8
  //image_xscale+=0.05
  //image_yscale+=0.05
  _speed=bulletSpeed //60fps change: DT3+'s _speed (correctSpeedDirection moves it, below), as DT3+'s bullets
  image_angle-=8*gDeltaTime //60fps change: per frame
  image_xscale+=0.05*gDeltaTime //60fps change: per frame
  image_yscale+=0.05*gDeltaTime //60fps change: per frame
}
//else {speed=0}
else {_speed=0} //60fps change: DT3+'s _speed
correctSpeedDirection(self) //60fps change (added): moves it by _speed/_direction
