if global.gamePaused=false
{
  //----- Movement -----
  if bCanMove=1
  {
    shiftTime+=1*gDeltaTime
    if shiftTime>=shiftTimeMax
    {
      shiftTime=0
      xVel*=-1
      yVel*=-1
    }
    x+=xVel*gDeltaTime; y+=yVel*gDeltaTime
  }

  //----- Retract animation -----
  if retractTime>0 {retractTime-=1*gDeltaTime}
  if retractTime>=1 and retractTime<=10 {poleExtendDist-=1*gDeltaTime}

  //----- Grapple reuse time -----
  if reuseTime>=1 and reuseTime<=5 {poleExtendDist+=2*gDeltaTime} //Starting time is 20

  if reuseTime>0
  {
    reuseTime-=1*gDeltaTime
    if reuseTime=0 {poleExtendDist=5; bGrappled=0}
  }
}
