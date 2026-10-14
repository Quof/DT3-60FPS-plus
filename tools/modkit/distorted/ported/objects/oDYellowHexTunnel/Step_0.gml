if global.gamePaused=false and myGrapplePoint.bGrappled=myType
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
/*myGrapplePoint.x=x
myGrapplePoint.y=y*/
