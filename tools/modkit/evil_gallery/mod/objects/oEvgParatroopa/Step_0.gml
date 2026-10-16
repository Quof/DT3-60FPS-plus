//Evil Boss Gallery: the Paratroopa flies (always active: the arena is all in view)
if global.gamePaused=false
{
  bActive=true
  if stunnedTime=0 and life>0
  {
    bobT+=1*gDeltaTime
    x+=flySpd*flyDir*gDeltaTime
    y=baseY+4*sin(bobT*0.12)
    image_xscale=flyDir
    if leaving=0
    {
      if flyDir=1 and x>852 {flyDir=-1}
      else if flyDir=-1 and x<588 {flyDir=1}
    }
    else if x<520 or x>920 {instance_destroy()}
  }
  enemyStepEvent()
}
