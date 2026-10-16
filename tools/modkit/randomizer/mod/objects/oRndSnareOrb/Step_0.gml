//Randomizer: the orb's chase (oWMD_SeekerOrb's: faster the farther the player is, 3 to 9 pixels a tick), after it fades
//in (8 ticks, then it hurts), for as long as the Wind Orb Trap lasts (global.rndSnareT[5]); then it fades out and is gone
if global.gamePaused=false
{
  atkTime+=1*gDeltaTime
  if rndOut=0 and global.rndSnareT[5]<=0 {rndOut=1; bCanDealDamage=0}
  if rndOut=1
  {
    image_alpha-=0.1*gDeltaTime
    if image_alpha<=0 {instance_destroy(); exit}
  }
  else if atkTime<=8
  {
    image_alpha=min(1,image_alpha+0.1*gDeltaTime)
    if atkTime>=8 {bCanDealDamage=1}
  }
  if atkTime>8 and instance_exists(oPlayer1)
  {
    myDist=player_sprite_center()
    myDist=round(myDist/32)
    if myDist>9 {myDist=9}
    else if myDist<3 {myDist=3}
    maxSpeed=myDist
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
  }
  else {_hspeed=0; _vspeed=0}
}
else {_hspeed=0; _vspeed=0}
correctHSpeedVSpeed(self)
