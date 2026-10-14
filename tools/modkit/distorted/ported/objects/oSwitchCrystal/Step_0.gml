if global.gamePaused=false
{
  enemyStepEvent()
  life=maxLife
  if hit=1 and htime=-1
  {
    bCanTakeDamage=false
    image_alpha=0.5
    htime=0
  }
  if htime>=0
  {
    //htime+=1
    htime+=1*gDeltaTime //60fps change: per frame
    //if htime>=1 and htime<=rotTime
    if htime>0 and htime<=rotTime //60fps change: from the first frame, so all frames of tick 1 count (the same total turn)
    {
        for(i=0;i<maxTargets;i+=1)
        {
            //if lockon[i] {with targets[i] {image_angle+=other.rotSpd}}
            if lockon[i] {with targets[i] {image_angle+=other.rotSpd*gDeltaTime}} //60fps change: per frame
        }
    }
    else if htime>=resetTime
    {
      hit=0
      htime=-1
      bCanTakeDamage=true
      image_alpha=1
    }
  }
}
