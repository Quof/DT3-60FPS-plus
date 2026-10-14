if global.gamePaused=false
{
  makeEnemyActive(0)
  if bActive=true and stunnedTime=0
  {
    if x>oPlayer1.x
      image_xscale=-1
    else
      image_xscale=1

    myDist=point_distance(x,y,oPlayer1.x,returnPlayerYCenter())
    myDist=round(myDist/32)
    if myDist>9
      myDist=9
    else if myDist<3
      myDist=3
    maxSpeed=myDist

    if x>oPlayer1.x
    {
      if currHspd>-maxSpeed
        currHspd-=0.1*gDeltaTime
      else
        currHspd=-maxSpeed
    }
    else if x<oPlayer1.x
    {
      if currHspd<maxSpeed
        currHspd+=0.1*gDeltaTime
      else
        currHspd=maxSpeed
    }
    if y>oPlayer1.y-26
    {
      if currVspd>-maxSpeed
        currVspd-=0.1*gDeltaTime
      else
        currVspd=-maxSpeed
    }
    else if y<oPlayer1.y-26
    {
      if currVspd<maxSpeed
        currVspd+=0.1*gDeltaTime
      else
        currVspd=maxSpeed
    }
    _hspeed=currHspd
    _vspeed=currVspd
  }
  else
  {
    _hspeed=0
    _vspeed=0
  }
  enemyStepEvent()

  lifeTime-=1*gDeltaTime
  if lifeTime=90 and true       //spsp
  {
    instance_create(x,y,oMenaceSpawn)
  }
  if lifeTime=45 and true       //spsp
  {
    instance_create(x,y,oMenaceSpawn)
  }
  if lifeTime=0
  {
    var tExplode;
    tExplode=instance_create(x,y,oM_PoisonBreath)
    tExplode.atkPower=atkPower; tExplode.bulletSpeed=0; tExplode.animSpeed=0.25
    instance_destroy()
  }
}
else
{
    _hspeed=0
    _vspeed=0
}
correctHSpeedVSpeed(self)
