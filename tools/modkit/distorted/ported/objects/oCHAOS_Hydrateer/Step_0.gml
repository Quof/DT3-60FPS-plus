if global.gamePaused=false
{
  if bActive=0 {makeEnemyActive(0)}
  if bActive=true and stunnedTime=0 and life>0
  {
    if x<oPlayer1.x {image_xscale=1}
    else {image_xscale=-1}
    if y<=oPlayer1.y-82 {image_index=0}
    else if y>=oPlayer1.y-81 and y<=oPlayer1.y-34 {image_index=1}
    else if y>=oPlayer1.y+34 and y<=oPlayer1.y+81 {image_index=3}
    else if y>=oPlayer1.y+82 {image_index=4}
    else {image_index=2}

    event_user(0)
    //Movement
    xPoint=oPlayer1.x+(88*atkSide)
    yPoint=oPlayer1.y-128

    if x>xPoint
    {
      if currHspd>-maxSpeed {currHspd-=0.5*gDeltaTime}
      else {currHspd+=0.5*gDeltaTime}
    }
    else if x<xPoint
    {
      if currHspd<maxSpeed {currHspd+=0.5*gDeltaTime}
      else {currHspd-=0.5*gDeltaTime}
    }
    if y>yPoint
    {
      if currVspd>-maxSpeed {currVspd-=0.5*gDeltaTime}
      else {currVspd+=0.5*gDeltaTime}
    }
    else if y<yPoint
    {
      if currVspd<maxSpeed {currVspd+=0.5*gDeltaTime}
      else {currVspd-=0.5*gDeltaTime}
    }
    _hspeed=currHspd; _vspeed=currVspd

    //Smoke
    if gDeltaDoTicks { //60fps change (added): one smoke puff per 30fps tick (was 2x/4x as many at 60/120fps)
    var tEffect;
    tEffect=instance_create(x-(17*image_xscale),y-2,oEffectB)
    tEffect.type=3; tEffect.sprite_index=sMMSmokeCloud; tEffect.newBlend=-1; tEffect.depth=26
    tEffect.speed=random(1)+1; tEffect.friction=random(0.0125)+0.0125; tEffect.image_speed=0.2
    tEffect.fadeSpd=0.05; tEffect.image_blend=make_color_rgb(140+random(20),140+random(20),140+random(20))
    tEffect.AccelX=0; tEffect.AccelY=0; tEffect.followID=-1; tEffect.rotation=0
    if image_xscale=1 {tEffect.direction=random_range(255,265)}
    else {tEffect.direction=random_range(275,285)}
    } //60fps change (added)

    shotTime+=1*gDeltaTime
    if shotType=0 //Point explosion missile
    {
      if shotTime=shotDelay-5
      {
        var tEffect;
        tEffect=instance_create(x+(xOffset*image_xscale),y+yOffset,oEffect)
        tEffect.sprite_index=sMMchargeComplete; tEffect.followID=-1; tEffect.xFollow=0; tEffect.yFollow=0
        tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0; tEffect.image_alpha=0.9
        tEffect.image_xscale=0.875; tEffect.image_yscale=0.875
      }
      else if shotTime>=shotDelay+10
      {
        playSound(global.snd_CShotB,0,0.95,1)
        var tNewAttack;
        tNewAttack=instance_create(x+(xOffset*image_xscale),y+yOffset,oPointExpBullet)
        tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=8
        tNewAttack._direction=point_direction(x+(xOffset*image_xscale),y+yOffset,oPlayer1.x,returnPlayerYCenter())
        shotType=1
        shotTime=0
      }
    }
    else if shotType=1 //Laser
    {
      if shotTime=shotDelay {bLaser=1; circleRad=2; circleCol=c_white}
      if shotTime>=shotDelay and shotTime<=shotDelay+14 {laserDir=point_direction(x+(xOffset*image_xscale),y+yOffset,oPlayer1.x,returnPlayerYCenter())}
      else if shotTime=shotDelay+15 {circleRad=3; circleCol=c_red}
      else if shotTime=shotDelay+30
      {
        bLaser=0
        playSound(global.snd_CShotA,0,0.95,1)
        var tEffect,myLaser;
        tEffect=instance_create(x+(xOffset*image_xscale),y+yOffset,oEffect)
        tEffect.sprite_index=sEfPowerWave; tEffect.image_alpha=0.4; tEffect.xSpd=0; tEffect.ySpd=0
        tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=3; tEffect.image_angle=90+laserDir
        tEffect.image_xscale=0.8; tEffect.image_yscale=0.8

        myLaser=instance_create(x+(xOffset*image_xscale),y+yOffset,oC_RocketLaser)
        myLaser.image_angle=laserDir; myLaser.atkPower=atkPower
      }
      else if shotTime>=shotDelay+31
      {
        if atkSide=1 {atkSide=-1}
        else {atkSide=1}
        shotType=0
        shotTime=0
      }
    }
  }
  else if life<=0
  {
    if deathAnim==0 {deathAnim=1-gDeltaTime}
    deathAnim+=1*gDeltaTime
    if deathAnim mod 2=0
    {
      if deathAnim mod 4=0 {playSound(global.snd_BombExplode,0,0.85,1)}
      tEffect=instance_create(x+random_range(-7,7),y+1+random(30),oEffect)
      tEffect.sprite_index=sRobotExplosion; tEffect.image_alpha=0.5+(image_alpha/3)
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    }
    image_alpha-=0.05*gDeltaTime
    if image_alpha<0.5
    {
      playSound(global.snd_BombExplode,0,0.92,1)
      for(i=0;i<7;i+=1)
      {
        tDir=random_range(-3.5,3.5)
        tEffect=instance_create(x+random_range(-7,7),y+1+random(30),oEffectGrav)
        tEffect.image_speed=0; tEffect.type=2; tEffect.image_index=i
        tEffect.xSpd=tDir; tEffect.ySpd=-2.5-random(2); tEffect.fadeSpd=0.03; tEffect.rotation=choose(-tDir,tDir)
        tEffect.grav=0.2; tEffect.newBlend=-1; tEffect.decay=-100; tEffect.followID=-1
        if global.CHAOS_Upgrade=0 {tEffect.sprite_index=sSabotagePartsA}
        else {tEffect.sprite_index=sSabotagePartsB}
      }
      instance_destroy()
    }
  }
  enemyStepEvent()
  if lifeTrack>life
  {
    var newHead;
    newHead=instance_create(x,y,oCHAOS_Hydrateer)
    newHead.lifeTrack=life
    newHead.life=life
    lifeTrack=life
  }
}
else {_hspeed=0; _vspeed=0}

correctHSpeedVSpeed(self)
