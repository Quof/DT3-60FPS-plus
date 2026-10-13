if global.gamePaused=false
{
  enemyStepEvent()
  //instead try destroy and create at position maybe?
  if (life < maxLife)
  {
    if current < maxPosition
    {
        current+=1
        x=positionsX[current]
        y=positionsY[current]
    }
    else
    {
        if (looping = true)
        {
            current = 0
            x=positionsX[current]
            y=positionsY[current]
        }
        else
        {
            instance_destroy()
        }
    }
  }
  life=maxLife
}
