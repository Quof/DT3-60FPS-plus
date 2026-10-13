if global.gamePaused=false
{
  atkTime+=1*gDeltaTime
  //if atkTime>=1 and atkTime<=8
  if atkTime>0 and atkTime<=8 //60fps change: covers every frame of ticks 1-8
  {
    image_alpha+=0.1*gDeltaTime
    if atkTime=8 {bCanDealDamage=1}
  }
  //else if atkTime>=9
  else if atkTime>8 //60fps change: the orb started chasing half a tick late
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
      if currHspd>-maxSpeed {currHspd-=0.25*gDeltaTime}
      else {currHspd=-maxSpeed}
    }
    else if x<oPlayer1.x
    {
      if currHspd<maxSpeed {currHspd+=0.25*gDeltaTime}
      else {currHspd=maxSpeed}
        }
    }
    else
    {
        if x>oIdentifier.x
        {
          //if currHspd>-maxSpeed {currHspd-=0.25}
          if currHspd>-maxSpeed {currHspd-=0.25*gDeltaTime} //60fps change: per frame (as chasing the player above)
          else {currHspd=-maxSpeed}
        }
        else if x<oIdentifier.x
        {
          //if currHspd<maxSpeed {currHspd+=0.25}
          if currHspd<maxSpeed {currHspd+=0.25*gDeltaTime} //60fps change: per frame (as chasing the player above)
          else {currHspd=maxSpeed}
        }
    }
    if y>returnPlayerYCenter()
    {
      if currVspd>-maxSpeed {currVspd-=0.25*gDeltaTime}
      else {currVspd=-maxSpeed}
    }
    else if y<returnPlayerYCenter()
    {
      if currVspd<maxSpeed {currVspd+=0.25*gDeltaTime}
      else {currVspd=maxSpeed}
    }
    _hspeed=currHspd; _vspeed=currVspd

    if room == rWarshipZ_E3 //EX MODE
    {
      //if atkTime>=190
      if atkTime>189 //60fps change: covers every frame of tick 190
      {
        bCanDealDamage=0
        image_alpha-=0.1*gDeltaTime
      }
      if atkTime>=200 {instance_destroy()}
    }
    else
    {
      //if atkTime>=175
      if atkTime>174 //60fps change: covers every frame of tick 175 (it kept dealing damage half a tick longer)
      {
        bCanDealDamage=0
        image_alpha-=0.1*gDeltaTime
      }
      if atkTime>=185 {instance_destroy()}
    }
  }
}
else {_hspeed=0; _vspeed=0}

correctHSpeedVSpeed(self)
