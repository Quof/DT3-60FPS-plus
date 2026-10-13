if global.gamePaused=false
{
    if room!=rBT_Cousinoer5DeathEX
{
  if oDeath.image_xscale=1
  {
    x=oDeath.x-5
    y=oDeath.y-40
  }
  else
  {
    x=oDeath.x-13
    y=oDeath.y-40
  }
    }
    else
    {
        if oDeathEX.image_xscale=1
          {
            x=oDeathEX.x-5
            y=oDeathEX.y-40
          }
          else
          {
            x=oDeathEX.x-13
            y=oDeathEX.y-40
          }
    }
  enemyStepEvent()
}
