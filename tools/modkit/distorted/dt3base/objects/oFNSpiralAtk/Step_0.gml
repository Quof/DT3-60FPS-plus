if global.gamePaused=false
{
  _direction-=2.25*gDeltaTime
  myDist+=2*gDeltaTime
  x=xstart+lengthdir_x(myDist,dirSeg+_direction)
  y=ystart+lengthdir_y(myDist,dirSeg+_direction)

  decay-=1*gDeltaTime
  if decay=0 {instance_destroy()}
}
correctSpeedDirection(self)
