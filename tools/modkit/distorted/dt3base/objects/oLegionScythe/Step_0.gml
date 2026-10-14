if global.gamePaused=false
{
  image_angle+=20*gDeltaTime
  atkProg+=1*gDeltaTime
  //if atkProg>=60 {_speed=6}
  if atkProg>59 {_speed=6} //60fps change: starts falling on the first frame of tick 60 like at 30fps (with >=60 it started on the last frame and stayed 4.5px behind at 120fps)
}
else
  _speed=0

correctSpeedDirection(self)
