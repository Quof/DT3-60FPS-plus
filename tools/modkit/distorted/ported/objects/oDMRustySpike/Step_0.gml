if global.gamePaused=false
{
  makeEnemyActive(1)
  if bActive=true
  {
    fallingProgress+=1*gDeltaTime
    if fallingProgress=1
      x+=1
    //else if fallingProgress>=2 and fallingProgress<=30
    else if fallingProgress>=2 and fallingProgress<=30 and gDeltaDoTicks //60fps change: shake once per 30fps tick (per frame it shook 2x/4x as fast at 60/120fps)
    {
      if shakeDir=1
        x-=2
      else
        x+=2
      shakeDir*=-1
    }
    else if fallingProgress=31
      x=xstart
    else if fallingProgress>=32
      y+=fallSpeed*gDeltaTime
  }
  if y>room_height+24
    instance_destroy()
}
