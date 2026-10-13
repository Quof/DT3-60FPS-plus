if global.gamePaused=false
{
  if initVars=1
  {
    if type=10 or type=20
    {
      moveTick+=0.5*gDeltaTime
      x+=cos(moveTick/5)*gDeltaTime

      if oKingWorm.life>0 and mySeg>2
      {
        if oKingWorm.bSpraySpikes=1
        {
          sprayTime+=1*gDeltaTime
          if sprayTime>=oKingWorm.sprayDelay
          {
            var tAtk;
            tAtk=instance_create(x,y,oMetBulletGrav)
            tAtk.sprite_index=sKingWormSpike; tAtk.atkPower=atkPower
            if type=10 {tAtk.xVel=2+throwDist[myThrow]} else if type=20 {tAtk.xVel=-2-throwDist[myThrow]}
            tAtk.yVel=-2.5; tAtk.grav=0.2
            myThrow+=1
            if myThrow=12 {myThrow=0}
            sprayTime=0
          }
        }
      }
    }
  }
}
