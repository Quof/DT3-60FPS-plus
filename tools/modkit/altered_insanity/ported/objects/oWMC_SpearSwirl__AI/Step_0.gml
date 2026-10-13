if global.gamePaused=false
{
  image_angle+=30*gDeltaTime
  if atkProg=0
  {
    x=warTarget.x
    y=warTarget.y-27
  }
  else if atkProg=1
  {
    atkTime+=1*gDeltaTime
    //if atkTime=1
    if atkTime=gDeltaTime //60fps change: aims on the first frame of tick 1
    {
      if global.activeCharacter!=3
      {
    _direction=point_direction(x,y,oPlayer1.x,returnPlayerYCenter())
      }
      else
      {
      //direction=point_direction(x,y,oIdentifier.x,returnPlayerYCenter())
      _direction=point_direction(x,y,oIdentifier.x,returnPlayerYCenter()) //60fps change: _direction (correctSpeedDirection)
      }  
    }
    //else {_speed=5}
    if atkTime>1 {_speed=5} //60fps change: starts moving on tick 2 like 30fps (the first frame used to move it 2.5/1.25px to the right, before it aimed)
  }
}
else {_speed=0}

correctSpeedDirection(self)
