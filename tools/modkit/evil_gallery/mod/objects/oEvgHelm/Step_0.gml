//Evil Boss Gallery: the helmet's step (see Create)
if global.gamePaused=false
{
  waterFrm+=0.33*gDeltaTime
  //---------- Polarity: swapped every polDelay ticks, flashing white for the last 30 (not while dazed) ----------
  if mode!=2
  {
    polTime+=1*gDeltaTime
    polFlash=(polTime>=polDelay-30)
    if polTime>=polDelay
    {
      polTime=0
      polFlash=0
      polarity=1-polarity
      playSound(global.snd_ColorPulseA,0,0.9,1)
    }
  }

  if mode=0 //---------- Drifting (Helmethead's helmet: up to its height, then the sine wave) and shooting ----------
  {
    bCanDealDamage=0
    if moveProg=0
    {
      x+=xSpd*gDeltaTime
      if xSpd>0 {xSpd-=0.1*gDeltaTime}
      y-=2*gDeltaTime
      if y<=yGround {moveProg=1}
    }
    else
    {
      y+=sin(oGame.time*gDeltaTime/2.5)*gDeltaTime
      if moveTime<moveThres
      {
        if x<oPlayer1.x {image_xscale=1}
        else {image_xscale=-1}
      }
      moveTime+=1*gDeltaTime
      if moveTime>moveThres-1 and moveTime<=moveThres+15
      {
        if image_xscale=1 {x+=1.5*gDeltaTime}
        else {x-=1.5*gDeltaTime}
      }
      else if moveTime>=moveThres+16
      {
        moveTime=0
      }
    }

    atkTime+=1*gDeltaTime
    if atkTime=atkDelay
    {
      var tEffect;
      tEffect=instance_create(x,y-4,oEffect)
      tEffect.sprite_index=sMMchargeComplete; tEffect.image_speed=0.5
      tEffect.followID=id; tEffect.xFollow=0; tEffect.yFollow=-4
      tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    }
    else if atkTime>=atkDelay+15
    {
      playSound(global.snd_HardHit3,0,0.97,27000)
      var tFire;
      tFire=instance_create(x,y-4,oPassBullet)
      tFire._direction=point_direction(x,y-4,oPlayer1.x,returnPlayerYCenter()); tFire.sprite_index=sEvgWolfHeadShot
      tFire.atkPower=atkPower; tFire.bulletSpeed=5; tFire.decayTime=-100
      atkTime=0
    }
  }
  else if mode=1 //---------- Diving at the player ----------
  {
    modeT+=1*gDeltaTime
    if diveStage=0 //(up above them, 20 ticks)
    {
      bCanDealDamage=0
      x+=median(-5*gDeltaTime,median(256,oPlayer1.x,624)-x,5*gDeltaTime)
      y+=median(-4*gDeltaTime,150-y,4*gDeltaTime)
      if modeT>=20
      {
        playSound(global.snd_DashWarn,0,1,1)
        diveStage=1
        modeT=0
      }
    }
    else if diveStage=1 //(the warning line, 30 ticks: following them for the first 15)
    {
      if modeT<15 {x+=median(-4*gDeltaTime,oPlayer1.x-x,4*gDeltaTime)}
      if modeT>=30
      {
        bCanDealDamage=1
        diveStage=2
        modeT=0
      }
    }
    else if diveStage=2 //(straight down)
    {
      y+=9*gDeltaTime
      if y>=300
      {
        y=300
        playSound(global.snd_HardHit2,0,0.9,1)
        var tEffect;
        tEffect=instance_create(x,y,oEffect)
        tEffect.sprite_index=sMMSmokeCloud; tEffect.image_speed=0.4
        tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=-0.5
        diveStage=3
        modeT=0
      }
    }
    else //(back up to its height)
    {
      bCanDealDamage=0
      y-=3*gDeltaTime
      if y<=yGround
      {
        y=yGround
        moveTime=0
        atkTime=0
        moveProg=1
        mode=0
      }
    }
  }
  else if mode=2 //---------- Dazed on the floor, 75 ticks ----------
  {
    modeT+=1*gDeltaTime
    bCanDealDamage=0
    if y<300 {y=min(300,y+6*gDeltaTime)}
    if gDeltaDoTicks and (floor(modeT) mod 8)=0
    {
      var tEffect;
      tEffect=instance_create(x-6+random(12),y-14,oEffect)
      tEffect.sprite_index=sMMchargeComplete; tEffect.image_xscale=0.3; tEffect.image_yscale=0.3; tEffect.image_speed=0.5
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=-0.5
    }
    if modeT>=75
    {
      moveProg=0
      xSpd=0
      moveTime=0
      atkTime=0
      mode=0
    }
  }
  else if mode=4 //---------- Circling Helmethead, big ----------
  {
    if type=2 {orbitAng-=4*gDeltaTime}
    else {orbitAng+=4*gDeltaTime}
    if instance_exists(owner)
    {
      x=owner.x+lengthdir_x(46,orbitAng+(type=2)*180)
      y=owner.y-20+lengthdir_y(46,orbitAng+(type=2)*180)
    }
    image_xscale=2
    image_yscale=2
    bCanDealDamage=1
  }

  //---------- What hurts it: dazed, everything double; in Helmethead's barrier (till broken), its weakness ----------
  for(i=0;i<6;i+=1) {resType[i]=1}
  if mode=2
  {
    for(i=0;i<6;i+=1) {resType[i]=4}
  }
  else if mode!=4 and broken=0
  {
    if instance_exists(owner)
    {
      if owner.myBarrier>=1
      {
        if polarity=0 {resType[1]=4}
        else {resType[0]=4}
      }
    }
  }
  enemyStepEvent()
}
