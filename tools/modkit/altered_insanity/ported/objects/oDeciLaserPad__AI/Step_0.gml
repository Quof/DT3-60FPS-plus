if global.gamePaused=false
{
  if bActive=true and life>0
  {
    if myProg=0
    {
      if image_alpha<1 {image_alpha+=0.05*gDeltaTime}
      if x<oDecimator.x and gDeltaDoTicks {x+=2}
      else if x>oDecimator.x and gDeltaDoTicks  {x-=2}
      progTime+=1*gDeltaTime
      if progTime=32
      {
        var tEffect;
        tEffect=instance_create(x,y,oEffect)
        tEffect.sprite_index=sMMchargeComplete; tEffect.image_xscale=2; tEffect.image_yscale=2
        tEffect.followID=-1; tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
        bCanTakeDamage=true; bCanDealDamage=true
      }
      else if progTime>=40
      {
        oDecimator.bWave=1
        progTime=0; myProg+=1
      }
    }
    else if myProg=1
    {
      followInstance()
      image_index+=turnSpd*gDeltaTime
      if bShotReady=1
      {
        if image_index<1
        {
          playSound(global.snd_CShotA,0,0.9,42000)
          var tNewAttack;
          tNewAttack=instance_create(x+34,y,oPassBullet)
          tNewAttack.sprite_index=sDeci_Laser; tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=9
          tNewAttack.decayTime=-100; tNewAttack._direction=0
          tNewAttack=instance_create(x-34,y,oPassBullet)
          tNewAttack.sprite_index=sDeci_Laser; tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=9
          tNewAttack.decayTime=-100; tNewAttack._direction=180
          bShotReady=0
        }
      }
      else
      {
        if image_index>4 {bShotReady=1}
      }
    }

    if checkHP=0
    {
      if lifePercent<=0.66
      {
        resType[0]=2
        checkHP=1
      }
    }
    else if checkHP=1
    {
      if lifePercent<=0.33
      {
        resType[0]=1
        checkHP=2
      }
    }
  }
  else if life<=0
  {
    deathAnim+=1*gDeltaTime
    image_speed=0
    if deathAnim mod 4=0
    {
      if deathAnim mod 8=0 {playSound(global.snd_HardHit1,0,0.9,1)}
      tEffect=instance_create(x+random_range(-30,30),y+random_range(-18,18),oEffect)
      tEffect.sprite_index=sRobotExplosion; tEffect.image_speed=0.33
      tEffect.image_alpha=0.5+(image_alpha/3)
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    }
    image_alpha-=0.04*gDeltaTime
    if image_alpha<0 {instance_destroy()}
  }
  enemyStepEvent()
}
