if global.gamePaused=false
{
  if bActive=0 {makeEnemyActive(0)}
  if bActive=true and stunnedTime=0
  {
    if initDir=false
    {
      if x>oPlayer1.x {runAcc*=-1}
      initDir=true
    }

    if runAcc>0 {image_xscale=1}
    else {image_xscale=-1}

    x+=runAcc*gDeltaTime
  }
  enemyStepEvent()
}
