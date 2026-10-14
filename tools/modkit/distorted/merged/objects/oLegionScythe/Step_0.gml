if global.gamePaused=false
{
  //image_angle+=20+(room=rBelmont3_3F)*15 //spsp ns
  image_angle+=(20+(room=rBelmont3_3F)*15)*gDeltaTime //spsp ns. 60fps change: per frame
  atkProg+=1*gDeltaTime
  //if atkProg>=60 {speed=6+(room=rBelmont3_3F)*5} //spsp ns
  if atkProg>59 {_speed=6+(room=rBelmont3_3F)*5} //spsp ns. 60fps change: DT3+'s _speed; starts on the first frame of tick 60 like at 30fps
}
else
  _speed=0

correctSpeedDirection(self)
