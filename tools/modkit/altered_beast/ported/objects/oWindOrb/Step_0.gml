//(60fps change: ported as DT3+'s oWMD_SeekerOrb, which this is a copy of: atkTime and the speeds change by a frame's
//share of a tick, and it moves by _hspeed/_vspeed)
if global.gamePaused=false
{
  //atkTime+=1
  atkTime+=1*gDeltaTime //60fps change
  //if atkTime>=1 and atkTime<=18
  if atkTime>0 and atkTime<=18 //60fps change: covers every frame of ticks 1-18
  {
    //image_alpha+=0.05
    image_alpha+=0.05*gDeltaTime //60fps change
    if atkTime=18 {bCanDealDamage=1}
  }
  //else if atkTime>=19
  else if atkTime>18 //60fps change
  {
    myDist=player_sprite_center()
    myDist=round(myDist/32)
    if myDist>9 {myDist=9}
    else if myDist<3 {myDist=3}
    maxSpeed=myDist
    if global.activeCharacter!=3
    {
        if x>oPlayer1.x
        {
          //if currHspd>-maxSpeed {currHspd-=0.25}
          if currHspd>-maxSpeed {currHspd-=0.25*gDeltaTime} //60fps change
          else {currHspd=-maxSpeed}
        }
        else if x<oPlayer1.x
        {
          //if currHspd<maxSpeed {currHspd+=0.25}
          if currHspd<maxSpeed {currHspd+=0.25*gDeltaTime} //60fps change
          else {currHspd=maxSpeed}
        }
    }
    else
    {
        if x>oIdentifier.x
        {
          //if currHspd>-maxSpeed {currHspd-=0.25}
          if currHspd>-maxSpeed {currHspd-=0.25*gDeltaTime} //60fps change
          else {currHspd=-maxSpeed}
        }
        else if x<oIdentifier.x
        {
          //if currHspd<maxSpeed {currHspd+=0.25}
          if currHspd<maxSpeed {currHspd+=0.25*gDeltaTime} //60fps change
          else {currHspd=maxSpeed}
        }
    }
    if y>returnPlayerYCenter()
    {
      //if currVspd>-maxSpeed {currVspd-=0.25}
      if currVspd>-maxSpeed {currVspd-=0.25*gDeltaTime} //60fps change
      else {currVspd=-maxSpeed}
    }
    else if y<returnPlayerYCenter()
    {
      //if currVspd<maxSpeed {currVspd+=0.25}
      if currVspd<maxSpeed {currVspd+=0.25*gDeltaTime} //60fps change
      else {currVspd=maxSpeed}
    }
    //hspeed=currHspd; vspeed=currVspd
    _hspeed=currHspd; _vspeed=currVspd //60fps change
  }
}
//else {hspeed=0; vspeed=0}
else {_hspeed=0; _vspeed=0} //60fps change

correctHSpeedVSpeed(self) //60fps change (added)
