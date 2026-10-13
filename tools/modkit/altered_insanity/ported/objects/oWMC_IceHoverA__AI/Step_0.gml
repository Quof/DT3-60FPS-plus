if global.gamePaused=false
{
  if moveProg=0
  {
    myDist+=2*gDeltaTime
    if myDist>=68 {moveProg=1}
  }
  else if moveProg=1
  {
    moveTime+=1*gDeltaTime
    if moveTime>=165
    {
      bOrbit=0
      moveTime=0; moveProg=2
    }
  }
  else if moveProg=2
  {
    if EX_MODE=0
    {
      if global.activeCharacter!=3
      {
      //direction=point_direction(x,y,oPlayer1.x,returnPlayerYCenter())
      _direction=point_direction(x,y,oPlayer1.x,returnPlayerYCenter()) //60fps change: _direction
      }
      else
      {
        //direction=point_direction(x,y,oIdentifier.x,returnPlayerYCenter())
        _direction=point_direction(x,y,oIdentifier.x,returnPlayerYCenter()) //60fps change: _direction
      }
      //image_angle=direction
      image_angle=_direction //60fps change
      //moveTime+=1
      moveTime+=1*gDeltaTime //60fps change: per frame
      if moveTime>=fireDelay
      {
        var tAtk;
        tAtk=instance_create(x,y,oWMC_IceHoverB)
        tAtk.atkPower=atkPower; tAtk._direction=_direction; tAtk.image_angle=_direction
        instance_destroy()
      }
    }
    else
    {
      if EX_MODE=1
      {
        if global.activeCharacter!=3
        {
        //direction=point_direction(warTarget.x,warTarget.y-26,oPlayer1.x,returnPlayerYCenter())
        _direction=point_direction(warTarget.x,warTarget.y-26,oPlayer1.x,returnPlayerYCenter()) //60fps change: _direction
        }
        else
        {
            //direction=point_direction(warTarget.x,warTarget.y-26,oIdentifier.x,returnPlayerYCenter())
            _direction=point_direction(warTarget.x,warTarget.y-26,oIdentifier.x,returnPlayerYCenter()) //60fps change: _direction
        }
        //image_angle=direction
        image_angle=_direction //60fps change
        EX_MODE=2
      }
      moveTime+=1*gDeltaTime
      if moveTime>=fireDelay
      {
        var tAtk;
        tAtk=instance_create(x,y,oWMC_IceHoverB)
        tAtk.atkPower=atkPower; tAtk._direction=_direction; tAtk.image_angle=_direction
        instance_destroy()
      }
    }
  }

  if bOrbit=1
  {
    myDir+=3*gDeltaTime
    x=warTarget.x+lengthdir_x(myDist,myDir)
    y=warTarget.y-26+lengthdir_y(myDist,myDir)
    image_angle=myDir
  }
}
correctSpeedDirection(self)
