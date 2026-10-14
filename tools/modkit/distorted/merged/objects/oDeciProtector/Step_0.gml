if global.gamePaused=false
{
  if bActive=true and life>0
  {
    if myProg=0
    {
      if image_alpha<1 {image_alpha+=0.05*gDeltaTime}
      progTime+=1*gDeltaTime
      if progTime=25
      {
        var tEffect;
        tEffect=instance_create(x,y,oEffect)
        tEffect.sprite_index=sMMchargeComplete; tEffect.followID=-1; tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
        bCanTakeDamage=true; bCanDealDamage=true
      }
      else if progTime>=30
      {
        oDecimator.bWave=1
        progTime=0; myProg+=1
      }
    }
    else if myProg=1
    {
      spin+=2*gDeltaTime
      shotTime+=1*gDeltaTime
      if shotTime>=shotDelay and shotTime<=shotDelay+100
      {
        var tEffect;
        tEffect=instance_create(x,y,oEffect)
        tEffect.sprite_index=sMMchargeComplete; tEffect.followID=-1; tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
        if baseColor=c_fuchsia {shotTime=1000}
        else if baseColor=c_orange {shotTime=2000}
        else if baseColor=c_blue {shotTime=3000}
        else if baseColor=c_green {shotTime=4000}
      }
      else if shotTime=1030 //Fuchsia
      {
        var tMissile;
        for(i=0;i<4;i+=1)
        {
          tMissile=instance_create(x,y-16,oHomingMissile)
          tMissile.atkPower=atkPower; tMissile.targetTime=20; tMissile.sprite_index=sDeci_Missile
          tMissile.bulletSpeed=4; tMissile.seekThres=15; tMissile.minSpd=3; tMissile.maxSpd=7
          tMissile.turnSpd=4; tMissile.accel=0.2; tMissile._direction=45+(i*90)
        }
        shotTime=0
      }
      //else if shotTime>=2031 and shotTime<=2100 and gDeltaDoTicks //Orange
      else if shotTime>2030 and shotTime<=2100 and frac(shotTime)=0 //Orange. 60fps change: one flame pair per 30fps tick counted from shotTime itself (40 pairs, like at 30fps); gDeltaDoTicks gave 39 or 40
      {
        var tNewAttack;
        for(i=0;i<2;i+=1)
        {
          tNewAttack=instance_create(x,y,oPassBullet)
          tNewAttack.sprite_index=sMMFlamerFlame; tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=10; tNewAttack.image_alpha=0.75
          tNewAttack.decayTime=17; tNewAttack._direction=point_direction(x,y,oPlayer1.x,returnPlayerYCenter())+random_range(-5,5)
          tNewAttack.damageType="ELEMENTAL"
        }
        if shotTime>=2070 {shotTime=0}
      }
      else if shotTime=3030 //Blue
      {
        var tNewAttack,tDir;
        tDir=0
        for(i=0;i<12;i+=1)
        {
          tNewAttack=instance_create(x,y,oPassBullet)
          tNewAttack.sprite_index=sDeci_SmallLaser; tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=5
          tNewAttack.decayTime=-100; tNewAttack._direction=tDir
          tDir+=360/12
        }
        shotTime=0
      }
      else if shotTime>=4030 //Green
      {
        var tNewAttack;
        if shotTime mod 10=0
        {
          tNewAttack=instance_create(x,y,oPassBullet)
          tNewAttack.sprite_index=sDeci_SmallLaser; tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=7; tNewAttack.image_blend=make_color_rgb(150,255,150)
          tNewAttack.decayTime=-100; tNewAttack._direction=point_direction(x,y,oPlayer1.x,returnPlayerYCenter())
        }
        if shotTime>=4070 {shotTime=0}
      }
    }

    x=oDecimator.x+lengthdir_x(oDecimator.protectorDist,myDir+spin)
    y=oDecimator.y+lengthdir_y(oDecimator.protectorDist,myDir+spin)

    if checkHP=0
    {
      if lifePercent<=0.75
      {
        resType[0]=1//2
        checkHP=1
      }
    }
  }
  else if life<=0
  {
    //deathAnim+=1
    deathAnim+=1*gDeltaTime //60fps change: was never scaled (the death explosions, every 4 ticks, came 4x as often at 120fps)
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
