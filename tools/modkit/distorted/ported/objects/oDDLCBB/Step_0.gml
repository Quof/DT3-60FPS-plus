if room=rDEX {tempDir=oDEX.tempDir} //should only do anything in washing machine via "with" code

if global.gamePaused=false
{
  if decay>0
  {
    //decay-=1
    decay-=1*gDeltaTime //60fps change: per frame
  }
  else if decay=0
  {
    instance_destroy()
  }
  if type=0 //Straight - (bulSpd)
  {
    _speed=bulSpd
  }
  else if type=1 //Spiral - (bulSpd,curveAmt,curveTime)
  {
    _speed=bulSpd
    if curveTime>0
    {
      curveTime-=1*gDeltaTime
      _direction+=curveAmt*gDeltaTime
    }
  }
  else if type=2 //Swirve - (bulSpd,curveAmt)
  {
    _speed=bulSpd
    moveWave+=(pi/curveAmt)*gDeltaTime
    _direction+=sin(moveWave)*gDeltaTime
  }
  else if type=3 //Speed Change A - (bulSpd,newSpd,spdTime)
  {
    if bulSpd!=newSpd
    {
      spdTime-=1*gDeltaTime
      if spdTime<=0 {bulSpd=newSpd}
    }
    _speed=bulSpd
  }
  else if type=4 //Speed Change B [2 changes] - (bulSpd,newSpdA,spdTimeA,newSpdB,spdTimeB)
  {
    if bulProg=0
    {
      spdTimeA-=1*gDeltaTime
      if spdTimeA<=0
      {
        bulSpd=newSpdA
        bulProg=1
      }
    }
    else if bulProg=1
    {
      spdTimeB-=1*gDeltaTime
      if spdTimeB<=0
      {
        bulSpd=newSpdB
        bulProg=2
      }
    }
    _speed=bulSpd
  }
  else if type=5 //Orbit around boss - (rotSpd,curDir,distMax)
  {
    if curDist<distMax and gDeltaDoTicks {curDist+=2}
    curDir+=rotSpd*gDeltaTime
    x=oTheExecutive.x+lengthdir_x(curDist,curDir)
    y=oTheExecutive.y+lengthdir_y(curDist,curDir)
  }

  if sprite_index!=sPT_FE_BigFire {image_angle=_direction}
  if type!=5
  {
    //if checkScreenArea(x,y,0)=1 {lifeTime+=1}
    //lifeTime+=1
    lifeTime+=1*gDeltaTime //60fps change: per frame
  }
}
else {_speed=0}

correctSpeedDirection(self)
