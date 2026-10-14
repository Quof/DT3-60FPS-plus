if global.gamePaused=false
{
  makeEnemyActive(0)
  if bActive=true and stunnedTime=0
  {
    if room=rMC_K_Secret
    {
      inactiveDist=10000
      x+=4*gDeltaTime
    }
    else
    {
      if x<oPlayer1.x {image_xscale=1}
      else {image_xscale=-1}
    }
  }
  enemyStepEvent()
}
