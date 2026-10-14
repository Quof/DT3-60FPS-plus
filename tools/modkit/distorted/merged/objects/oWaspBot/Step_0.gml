if global.gamePaused=false
{
  if bActive=0 {makeEnemyActive(0)}
  
  if room=rMega4_SigmaC1 {bActive=true} //spsp ns

  if life>0
  {
    if bActive=true and stunnedTime=0
    {
      //----- Movement -----
      if x>oPlayer1.x
      {
        if currHspd>-maxHspd
          currHspd-=0.075*gDeltaTime
        else
          currHspd=-maxHspd
      }
      else if x<oPlayer1.x
      {
        if currHspd<maxHspd
          currHspd+=0.075*gDeltaTime
        else
          currHspd=maxHspd
      }
      if y+45>oPlayer1.y-26-yDist
      {
        if currVspd>-maxVspd
          currVspd-=0.05*gDeltaTime
        else
          currVspd=-maxVspd
      }
      else if y+25<oPlayer1.y-26-yDist
      {
        if currVspd<maxVspd
          currVspd+=0.05*gDeltaTime
        else
          currVspd=maxVspd
      }
      _hspeed=currHspd
      _vspeed=currVspd
      if _hspeed>0 {image_xscale=1}
      else {image_xscale=-1}

      //----- Attack: Homing Missile -----
      missileTime+=1*gDeltaTime
      //if missileTime>=missileDelay and missileTime<=missileDelay+15
      if missileTime>=missileDelay and missileTime<=missileDelay+15 and gDeltaDoTicks //60fps change: one smoke puff per 30fps tick (was 2x/4x the puffs at 60/120fps)
      {
        var tFFScl,tEffect;
        tFFScl=random(0.2)
        tEffect=instance_create(x-(37*image_xscale),y+52,oEffectB)
        tEffect.type=3; tEffect.sprite_index=sMMSmokeCloud
        tEffect.image_alpha=0.8; tEffect.image_xscale=0.8+tFFScl; tEffect.image_yscale=0.8+tFFScl
        tEffect.direction=90; tEffect.speed=random(0.5)+1; tEffect.fadeSpd=0.04
        tEffect.AccelX=0; tEffect.AccelY=0; tEffect.newBlend=-1; tEffect.followID=-1; tEffect.rotation=0
      }
      if missileType=0
      {
        if missileTime>=missileDelay+16
        {
          var tMissile;
          tMissile=instance_create(x,y+2,oEnmityMissile)
          tMissile.atkPower=atkPower; tMissile.targetTime=20
          tMissile._direction=90
          missileAmt+=1
          if missileAmt=5 {missileType=1; missileAmt=0; missileTime=0}
          else {missileTime=missileDelay+8}
        }
      }
      else if missileType=1
      {
        if missileTime>=missileDelay+16
        {
          var tNewAttack;
          tNewAttack=instance_create(x,y+2,oGravBulletAlt)
          tNewAttack.sprite_index=sEnmityMissile; tNewAttack.atkPower=atkPower
          tNewAttack.xVel=random_range(-4,4); tNewAttack.xGrav=0; tNewAttack.bExplode=0
          if y+45<oPlayer1.y-26
          {
            tNewAttack.yVel=-3-random(2)
            tNewAttack.yGrav=0.2
          }
          else
          {
            tNewAttack.yVel=+3+random(2)
            tNewAttack.yGrav=-0.2
          }
          missileAmt+=1
          if missileAmt=10 {missileType=0; missileAmt=0; missileTime=0}
          else {missileTime=missileDelay+13}
        }
      }

      //-- Effects --
      if oGame.time mod (7/gDeltaTime)=0
      {
        var tFFScl,tEffect;
        tFFScl=random(0.2)
        tEffect=instance_create(x-(37*image_xscale),y+52,oEffectB)
        tEffect.type=3; tEffect.sprite_index=sMMSmokeCloud
        tEffect.image_alpha=0.8; tEffect.image_xscale=0.8+tFFScl; tEffect.image_yscale=0.8+tFFScl
        tEffect.direction=90; tEffect.speed=random(0.5)+1; tEffect.fadeSpd=0.02
        tEffect.AccelX=0; tEffect.AccelY=0; tEffect.newBlend=-1; tEffect.followID=-1; tEffect.rotation=0
      }
    }
    else
    {
      _hspeed=0
      _vspeed=0
    }
  }
  else if life<=0
  {
    playSound(global.snd_EnemyDieMM,0,1,1)
    tEffect=instance_create(x,y+38,oEffect)
    tEffect.sprite_index=sMMExplosion
    tEffect.image_xscale=1.5; tEffect.image_yscale=1.5
    tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0

    tDir=random_range(-1.5,1.5)
    tEffect=instance_create(x-(29*image_xscale),y+64,oEffectGrav); tEffect.sprite_index=sWaspBPartA
    tEffect.type=2; tEffect.xSpd=tDir; tEffect.ySpd=-2-random(0.5); tEffect.fadeSpd=0.03; tEffect.rotation=choose(-tDir,tDir)
    tEffect.grav=0.2; tEffect.newBlend=-1; tEffect.decay=-100; tEffect.followID=-1
    tDir=random_range(-3,3)
    tEffect=instance_create(x+(39*image_xscale),y+32,oEffectGrav); tEffect.sprite_index=sWaspBPartB
    tEffect.type=2; tEffect.xSpd=tDir; tEffect.ySpd=-3-random(1); tEffect.fadeSpd=0.03; tEffect.rotation=choose(-tDir,tDir)
    tEffect.grav=0.2; tEffect.newBlend=-1; tEffect.decay=-100; tEffect.followID=-1
    tDir=random_range(-3,3)
    tEffect=instance_create(x-(36*image_xscale),y+23,oEffectGrav); tEffect.sprite_index=sWaspBPartC
    tEffect.type=2; tEffect.xSpd=tDir; tEffect.ySpd=-4-random(1); tEffect.fadeSpd=0.03; tEffect.rotation=choose(-tDir,tDir)
    tEffect.grav=0.2; tEffect.newBlend=-1; tEffect.decay=-100; tEffect.followID=-1
    tDir=random_range(-2.5,2.5)
    tEffect=instance_create(x+(7*image_xscale),y+17,oEffectGrav); tEffect.sprite_index=sWaspBPartD
    tEffect.type=2; tEffect.xSpd=tDir; tEffect.ySpd=-4-random(1); tEffect.fadeSpd=0.03; tEffect.rotation=choose(-tDir,tDir)
    tEffect.grav=0.2; tEffect.newBlend=-1; tEffect.decay=-100; tEffect.followID=-1
    for(i=0;i<3;i+=1)
    {
      tDir=random_range(-4,4)
      tEffect=instance_create(x+((i*8)*image_xscale),y+56-(i*6),oEffectGrav); tEffect.sprite_index=sWaspBPartE
      tEffect.type=2; tEffect.xSpd=tDir; tEffect.ySpd=-3-random(2.25); tEffect.fadeSpd=0.03; tEffect.rotation=-tDir
      tEffect.grav=0.2; tEffect.newBlend=-1; tEffect.decay=-100; tEffect.followID=-1
    }
    instance_destroy()
  }
  enemyStepEvent()
}
else
{
  _hspeed=0
  _vspeed=0
}
correctHSpeedVSpeed(self)
