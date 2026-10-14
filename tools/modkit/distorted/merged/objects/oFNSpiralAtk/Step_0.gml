if global.gamePaused=false
{
  //direction-=2.25*ccwm //spsp ns new factor
  _direction-=2.25*ccwm*gDeltaTime //spsp ns new factor. 60fps change: per frame, DT3+'s _direction
  myDist+=2*gDeltaTime
  x=xstart+lengthdir_x(myDist,dirSeg+_direction)
  y=ystart+lengthdir_y(myDist,dirSeg+_direction)

  decay-=1*gDeltaTime
  if decay=0 {instance_destroy()}
}
correctSpeedDirection(self)
