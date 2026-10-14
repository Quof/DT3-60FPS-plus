if global.gamePaused=false
{
  makeEnemyActive(0)
  if room=rHPF_H {bActive=true} //spsp ns
  if bActive=true and stunnedTime=0
  {
    if turnTime>=64
    {
      image_xscale*=-1
      turnTime=0
    }

    if shotTime<=shotDelay
    {
      //turnTime+=1
      turnTime+=1*gDeltaTime //60fps change: counted per frame while the move is per tick, so it patrolled only half/a quarter as far before turning at 60/120fps
      x+=runAcc*image_xscale*gDeltaTime
    }

    if bInfected=1
    {
      shotTime+=1*gDeltaTime
      if shotTime>=shotDelay {lineW+=0.33*gDeltaTime}
      if shotTime>=shotDelay+30
      {
        if !collision_line(x,y,oPlayer1.x,oPlayer1.y-26,oSolid,true,true)
        {
          playSound(global.snd_Shock,0,0.82,17000)
          with oPlayer1 {hitPlayer(other)}
        }
        lineW=1
        shotTime=0
      }
    }
  }
  else if bActive=false {shotTime=20}
  enemyStepEvent()
}
