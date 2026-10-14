//shift logic runs on 30fps ticks so trips are exactly as long as at 30fps; gameStepEvent spreads the movement across frames
if global.gamePaused=false and gDeltaDoTicks != 0
{
  if bCanMove=true
  {
    if shiftTime>=shiftTimeMax
    {
      if shiftSeq=0
      {
        if bPauseOnEnd=1
        {
          xVel=0
          yVel=0
          shiftSeq=1
        }
        else
          shiftSeq=1000
      }
      else if shiftSeq>=1 and shiftSeq<=20
        shiftSeq+=1
      else if shiftSeq>=21
      {
        shiftTime=0
        shiftSeq=0
        xVel=xDir
        yVel=yDir
        xVel*=-1
        yVel*=-1
        xDir=xVel
        yDir=yVel
      }
    }
    else
    {
      //if place_meeting(x,y,oNightmareEffect) {xVel=xDir/2; yVel=yDir/2}
      //else {xVel=xDir; yVel=yDir}
      if prevX!=mstLX or prevY!=mstLY //mstLX/mstLY: this tick's finished position (same as x/y at 30fps)
      {
        prevX=mstLX
        prevY=mstLY
        shiftTime+=1
      }
    }
  }
  if variable_local_exists("decay") //spsp ns
  {
    decay-=1
    if decay=0 {instance_destroy()}
    //scrPlatformCrush()
    //60fps change: scrPlatformCrush moved below, out of this once-per-tick block (it runs every frame, as in DT3+'s oMovingCrushPlat)
  }
}
if global.gamePaused=false and variable_local_exists("decay") {scrPlatformCrush()} //60fps change (added): see above
