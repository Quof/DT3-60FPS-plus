if global.gamePaused=false
{
  if bActive=true
  {
    enemyFollowBorder()
    if bClockWise=0
    {
      if currentDir=0 {sprite_index=sMetGeemerB}
      else if currentDir=1 {sprite_index=sMetGeemerD}
      else if currentDir=2 {sprite_index=sMetGeemerA}
      else if currentDir=3 {sprite_index=sMetGeemerC}
    }
    else
    {
      if currentDir=0 {sprite_index=sMetGeemerD}
      else if currentDir=1 {sprite_index=sMetGeemerB}
      else if currentDir=2 {sprite_index=sMetGeemerC}
      else if currentDir=3 {sprite_index=sMetGeemerA}
    }
    enemyStepEvent()
  }
  else
  {
    makeEnemyActive(0)
  }
}
