if global.gamePaused=false
{
  if life>0
  {
    if oEvAbom.instrumentActNum=8 {bCanTakeDamage=1}
    else {bCanTakeDamage=0}

    seqTime+=1*gDeltaTime
    if seqTime=220
    {
      var tAttack,tDir;
      tDir=0
      for(i=0;i<16;i+=1)
      {
        tAttack=instance_create(x,y,oAbomParaShot)
        tAttack._direction=tDir
        tDir+=360/16
      }
      seqTime=0
    }
  }
  enemyStepEvent()

  if life<=0
  {
    deathAnim+=1*gDeltaTime
    if deathAnim=1
    {
      with oEnemyBase {bCanDealDamage=0}
      bCanTakeDamage=0
      oAbominationMain.sequence=16
      oAbominationMain.seqTime=0
      oEvAbom.instrumentProg=3
    }
  }
}
