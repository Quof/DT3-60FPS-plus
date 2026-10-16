//Evil Boss Gallery: Evil Helmethead's step (see Create). actProg: 0 Helmethead's walking and shooting, 1 the head toss,
//2 the shield charge
if global.gamePaused=false
{
  if activateBoss=1
  {
    oGlobalEvent.enemyCount=1
    bActive=true
    bShowHealthBar=true
    showBossHP=instance_create(0,0,oBossLifeDisplay); showBossHP.bossID=id; showBossHP.type=0
    activateBoss=2
  }

  if bActive=true and life>0
  {
    waterFrm+=0.33*gDeltaTime
    if actProg=0
    {
      //---------- Movement (Helmethead's: 16 ticks of walking toward the player now and then) ----------
      if moveTime<moveThres
      {
        if x<oPlayer1.x {image_xscale=1}
        else {image_xscale=-1}
      }
      moveTime+=1*gDeltaTime
      if moveTime>moveThres-1 and moveTime<=moveThres+15
      {
        image_speed=0.2
        if image_xscale=1 {x+=1*gDeltaTime}
        else {x-=1*gDeltaTime}
      }
      else if moveTime>=moveThres+16
      {
        image_speed=0
        image_index=0
        xVel=0
        moveTime=0
      }

      //---------- Attack: bullet toward the player (three spread from the orbit on) ----------
      atkTime+=1*gDeltaTime
      if atkTime=atkDelay
      {
        var tEffect;
        tEffect=instance_create(x,y-35,oEffect)
        tEffect.sprite_index=sMMchargeComplete
        tEffect.image_xscale=2; tEffect.image_yscale=2; tEffect.image_speed=0.5
        tEffect.followID=id; tEffect.xFollow=0; tEffect.yFollow=-35
        tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
      }
      else if atkTime>=atkDelay+20
      {
        playSound(global.snd_HardHit3,0,1,17000)
        var tFire,tDir,k;
        tDir=point_direction(x,y-35,oPlayer1.x,returnPlayerYCenter())
        for(k=-1;k<=1;k+=1)
        {
          if k=0 or evgPhase>=4
          {
            tFire=instance_create(x,y-35,oPassBullet)
            tFire._direction=tDir+(k*16); tFire.sprite_index=sEvgWolfHeadShot
            tFire.atkPower=atkPower; tFire.bulletSpeed=5; tFire.decayTime=-100
          }
        }
        atkTime=0
      }

      //---------- His moves: between his steps, one every actDelay ticks, the head toss and the charge in turn ----------
      actTime+=1*gDeltaTime
      if actTime>=actDelay and moveTime<moveThres and myBarrier=0
      {
        actTime=0
        actT=0
        actStage=0
        actK+=1
        image_speed=0
        image_index=0
        if (actK mod 2)=1 {actProg=1}
        else {actProg=2}
      }
    }
    else if actProg=1 //---------- Head toss ----------
    {
      actT+=1*gDeltaTime
      if actStage=0 //(the head shakes loose, 15 ticks)
      {
        if x<oPlayer1.x {image_xscale=1}
        else {image_xscale=-1}
        headShake=2*sin(actT*1.6)
        if actT=1 {playSound(global.snd_CreakySwingA,0,0.9,1)}
        if actT>=15
        {
          headShake=0
          playSound(global.snd_OrbThrow,0,0.8,1)
          var tHead;
          tHead=instance_create(x,y-31,oEvgHeadToss)
          tHead.owner=id; tHead.dir=image_xscale; tHead.atkPower=atkPower
          if headNum=0 {tHead.sprite_index=sEvgHelmetHeadA}
          else if headNum=1 {tHead.sprite_index=sEvgHelmetHeadB}
          else {tHead.sprite_index=sEvgHelmetHeadC}
          headOff=1
          //(his neck is open: everything does double)
          resType[0]=4; resType[1]=4; resType[4]=4
          actStage=1
        }
      }
      else if headOff=0 //(the head's back: oEvgHeadToss. Not over the barrier's, if it came up meanwhile)
      {
        if myBarrier=0 {resType[0]=3; resType[1]=2; resType[4]=3}
        atkTime=0
        actProg=0
      }
    }
    else if actProg=2 //---------- Shield charge ----------
    {
      actT+=1*gDeltaTime
      if actStage=0 //(crouched behind the shield, 18 ticks)
      {
        if x<oPlayer1.x {image_xscale=1}
        else {image_xscale=-1}
        if actT=1 {playSound(global.snd_KnightSwordSwing,0,0.8,1)}
        if actT>=18
        {
          chargeDir=image_xscale
          image_speed=0.6
          actStage=1
          actT=0
        }
      }
      else if actStage=1 //(the run, till the arena's end)
      {
        x+=chargeSpd*chargeDir*gDeltaTime
        if gDeltaDoTicks and (floor(actT) mod 4)=0
        {
          var tEffect;
          tEffect=instance_create(x-(10*chargeDir),y-2,oEffect)
          tEffect.sprite_index=sMMSmokeCloud; tEffect.image_speed=0.4
          tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=-0.5
        }
        if (chargeDir=1 and x>=620) or (chargeDir=-1 and x<=260)
        {
          playSound(global.snd_HardHit1,0,0.9,1)
          image_speed=0
          image_index=0
          actStage=2
          actT=0
        }
      }
      else if actT>=30 //(the stagger after it)
      {
        atkTime=0
        moveTime=0
        actProg=0
      }
    }

    //---------- The barrier (his third phase): he can't be hurt till both helmets are broken ----------
    if myBarrier=1
    {
      for(i=0;i<6;i+=1) {resType[i]=1}
      myBarrier=2
    }
    else if myBarrier=2
    {
      var tBroken;
      tBroken=0
      if instance_exists(myHelmetA) {if myHelmetA.broken=1 {tBroken+=1}}
      if instance_exists(myHelmetB) {if myHelmetB.broken=1 {tBroken+=1}}
      if tBroken>=2
      {
        for(i=0;i<6;i+=1) {resType[i]=3}
        resType[1]=2
        playSound(global.snd_PotShatter,0,0.9,1)
        myBarrier=0
      }
    }

    //---------- The helmets' dives (the barrier and the end): in turn, every diveDelay ticks ----------
    if evgPhase=3 or evgPhase>=5
    {
      diveTime+=1*gDeltaTime
      if diveTime>=diveDelay
      {
        diveTime=0
        diveTurn=1-diveTurn
        var tDiver;
        if diveTurn=0 {tDiver=myHelmetA}
        else {tDiver=myHelmetB}
        if instance_exists(tDiver)
        {
          if tDiver.mode=0 and tDiver.moveProg=1
          {
            tDiver.mode=1
            tDiver.diveStage=0
            tDiver.modeT=0
          }
        }
      }
    }

    //---------- Boss Difficulty Curve ----------
    if lifePercent<=0.85 and evgPhase=0 //his first head comes off: a red helmet
    {
      myHelmetA=instance_create(x,y-31,oEvgHelm)
      myHelmetA.owner=id; myHelmetA.type=1; myHelmetA.polarity=0; myHelmetA.sprite_index=sEvgHelmetHeadA
      myHelmetA.moveThres=20; myHelmetA.atkDelay=85; myHelmetA.yGround=160
      headNum=1
      atkDelay-=4
      evgPhase=1
    }
    else if lifePercent<=0.72 and evgPhase=1 //his second: a blue helmet, its polarity swapping half a turn after the first's
    {
      myHelmetB=instance_create(x,y-31,oEvgHelm)
      myHelmetB.owner=id; myHelmetB.type=2; myHelmetB.polarity=1; myHelmetB.sprite_index=sEvgHelmetHeadB
      myHelmetB.moveThres=30; myHelmetB.atkDelay=75; myHelmetB.yGround=176
      myHelmetB.polTime=myHelmetB.polDelay/2
      headNum=2
      atkDelay-=4
      evgPhase=2
    }
    else if lifePercent<=0.6 and evgPhase=2 //the barrier
    {
      myBarrier=1
      with (oEvgHelm) {broken=0; breakDmg=0}
      diveTime=0
      atkDelay-=4
      evgPhase=3
    }
    else if lifePercent<=0.4 and evgPhase=3 and myBarrier=0 //the orbit
    {
      with (oEvgHelm) {mode=4; modeT=0}
      atkDelay=62
      evgPhase=4
    }
    else if lifePercent<=0.2 and evgPhase=4 //the end
    {
      with (oEvgHelm) {mode=0; modeT=0; image_xscale=1; image_yscale=1}
      diveTime=0
      diveDelay=80
      actDelay=95
      atkDelay=58
      evgPhase=5
    }
  }
  else if life<=0 //Defeat animation (Helmethead's), then back to the evil gallery at his door
  {
    deathAnim+=1*gDeltaTime
    if deathAnim=1
    {
      with oEvgHelm {instance_destroy()}
      with oEvgHeadToss {instance_destroy()}
      with oPassBullet {instance_destroy()}
    }
    else if deathAnim>=2 and deathAnim<=55
    {
      if oGame.time mod (5/gDeltaTime)==0
      {
        var tEffect;
        tEffect=instance_create((x-sprite_width/2)+random(sprite_width),y-random(sprite_height),oEffect)
        tEffect.sprite_index=sSamusSMissileHit; tEffect.image_speed=0.5; tEffect.image_xscale=0.5; tEffect.image_yscale=0.5
        tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
      }
    }
    else if deathAnim>=56
    {
      evgTally(4)
      global.newMapX=872; global.newMapY=1376; room_goto(rEvgGallery)
      deathAnim=-10000
    }
  }
  enemyStepEvent()
}
