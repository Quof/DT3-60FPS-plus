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
    if atkSequence=0 //--------------- Rise up from the ground ---------------
    {
      atkTime+=1*gDeltaTime
      if atkTime=1
      {
        if oPlayer1.x<=240
        {
          x=oPlayer1.x+96
          image_xscale=-1
        }
        else
        {
          x=oPlayer1.x-96
          image_xscale=1
        }
        y=yGround+abs(sprite_height)
        visible=1

        if oPlayer1.y<=232 and bPoeActive=0 //Player is too high
        {
          atkTime=0
          atkSequence=1
        }
        else
        {
            if hasArmor = 1
            {
                armor=3
                spawnArmorEffect()
            }
        }
      }
      else if atkTime>=30
      {
        if atkTime=31 {playSound(global.snd_Earthquake,0,1,44100)}
        var tEffect,tXspd;
        if gDeltaDoTicks //60fps change (added): dust once per 30fps tick (was every frame)
        {
          tEffect=instance_create(x-8+random_range(-15,15),yGround+random_range(-3,15),oEffect)
          tEffect.sprite_index=sZeldaEnemyDie; tEffect.image_speed=0.25; tEffect.image_blend=c_gray
          tEffect.followID=-1; tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
        }
        if oGame.time mod (2/gDeltaTime)=0
        {
          tXspd=random_range(-2,2)
          tEffect=instance_create(x+random_range(-13,13),yGround+random_range(-2,3),oEffectGrav)
          tEffect.sprite_index=sSmallBoulder; tEffect.image_xscale=0.2; tEffect.image_yscale=0.2
          tEffect.followID=-1; tEffect.newBlend=-1; tEffect.xSpd=tXspd; tEffect.ySpd=-2-random(4); tEffect.grav=0.4
          tEffect.rotation=tXspd; tEffect.type=2; tEffect.fadeSpd=0.075
        }

        y-=0.33*gDeltaTime
        if y<=yGround
        {
          bCanDealDamage=true
          bCanTakeDamage=true
          y=yGround
          atkTime=0
          atkSequence=2
        }
      }
    }
    else if atkSequence=1 //--------------- Jump up because player was up too high ---------------
    {
      atkTime+=1*gDeltaTime
      if atkTime=1
      {
        playSound(global.snd_Earthquake,0,1,88200)
        x=oPlayer1.x
        if hasArmor = 1
        {
            armor=3
            spawnArmorEffect()
        }
        sprite_index=sDeadHand_Jump
        image_speed=0.33
        if bPoeActive=0 {resType[0]=4}
        var tEffect,tXspd;
        for(i=0;i<8;i+=1)
        {
          tEffect=instance_create(x-8+random_range(-15,15),yGround+random_range(-3,15),oEffect)
          tEffect.sprite_index=sZeldaEnemyDie; tEffect.image_speed=0.25; tEffect.image_blend=c_gray
          tEffect.followID=-1; tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0

          tXspd=random_range(-2,2)
          tEffect=instance_create(x+random_range(-13,13),yGround+random_range(-2,3),oEffectGrav)
          tEffect.sprite_index=sSmallBoulder; tEffect.image_xscale=0.2; tEffect.image_yscale=0.2
          tEffect.followID=-1; tEffect.newBlend=-1; tEffect.xSpd=tXspd; tEffect.ySpd=-2-random(4); tEffect.grav=0.4
          tEffect.rotation=tXspd; tEffect.type=2; tEffect.fadeSpd=0.075
        }
        ySpd=-8
        bCanDealDamage=true
        bCanTakeDamage=true
      }
      else if atkTime>=2
      {
        if ySpd<-2 {ySpd=scrGravAcc(ySpd,0.2,-1)}
        else if ySpd>=-2 and ySpd<8 {ySpd=scrGravAcc(ySpd,0.4,-1)} //moves then accelerates: second half after the move, original line kept for 30fps (see scrGravAcc)
        {y+=ySpd*gDeltaTime}
        if gDeltaTime==1 {if ySpd<-2 {ySpd+=0.2} else if ySpd>=-2 and ySpd<8 {ySpd+=0.4}}
        if y>=yGround and ySpd>0
        {
          sprite_index=sDeadHand_Idle
          image_speed=0; image_index=0
          if bPoeActive=0 {resType[0]=3}
          y=yGround
          atkTime=0
          atkSequence=2
        }
      }
    }
    else if atkSequence=2 //--------------- Move toward player ---------------
    {
      if x<oPlayer1.x
      {
        image_xscale=1
        x+=xSpd*gDeltaTime
      }
      else
      {
        image_xscale=-1
        x-=xSpd*gDeltaTime
      }

      if oGame.time mod (3/gDeltaTime)=0
      {
        if bump=0 {y+=1; bump=1}
        else {y-=1; bump=0}
      }

      atkTime+=1*gDeltaTime
      if atkTime>=atkDuration
      {
        atkTime=0
        if bossProgress>=3 {atkSequence=3}
        else {atkSequence=4}
      }
    }
    else if atkSequence=3 //--------------- Fire at player ---------------
    {
      if bPoeActive=0
      {
        atkTime+=1*gDeltaTime
        if atkTime=1
        {
          image_index=1
          if x<oPlayer1.x {image_xscale=1}
          else {image_xscale=-1}
        }
        else if atkTime>=30
        {
          if atkTime mod fireRate=0
          {
            playSound(global.snd_HardHit3,0,0.975,22000)
            var tFire;
            tFire=instance_create(x+(20*image_xscale),y-14,oPassBullet)
            tFire._direction=point_direction(x+(20*image_xscale),y-14,oPlayer1.x,oPlayer1.y-26); tFire.sprite_index=sWolfHeadShot
            tFire.atkPower=atkPower; tFire.bulletSpeed=5; tFire.decayTime=-100
          }
        }
        if atkTime>=80
        {
          image_index=0
          atkTime=0; atkSequence=4
        }
      }
      else
      {
        image_index=0
        atkTime=0; atkSequence=4
      }
    }
    else if atkSequence=4 //--------------- Sink in ground ---------------
    {
      bCanDealDamage=false; bCanTakeDamage=false
      var tEffect,tXspd;
      if gDeltaDoTicks //60fps change (added): dust once per 30fps tick (was every frame)
      {
        tEffect=instance_create(x-8+random_range(-15,15),yGround+random_range(-3,15),oEffect)
        tEffect.sprite_index=sZeldaEnemyDie; tEffect.image_speed=0.25; tEffect.image_blend=c_gray
        tEffect.followID=-1; tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
      }
      if oGame.time mod (2/gDeltaTime)=0
      {
        tXspd=random_range(-2,2)
        tEffect=instance_create(x+random_range(-13,13),yGround+random_range(-2,3),oEffectGrav)
        tEffect.sprite_index=sSmallBoulder; tEffect.image_xscale=0.2; tEffect.image_yscale=0.2
        tEffect.followID=-1; tEffect.newBlend=-1; tEffect.xSpd=tXspd; tEffect.ySpd=-2-random(4); tEffect.grav=0.4
        tEffect.rotation=tXspd; tEffect.type=2; tEffect.fadeSpd=0.075
      }
      y+=0.5*gDeltaTime
      if y>=yGround+sprite_height
      {
        visible=0
        atkSequence=5
      }
    }
    else if atkSequence=5 //--------------- Slight wait ---------------
    {
      atkTime+=1*gDeltaTime
      if atkTime>=45
      {
        atkTime=0
        atkCycle+=1
        if atkCycle=3
        {
          atkCycle=0
          atkSequence=6
        }
        else {atkSequence=0}
      }
    }
    else if atkSequence=6 //--------------- Come from ceiling ---------------
    {
      atkTime+=1*gDeltaTime
      if atkTime=1
      {
        visible=1
        image_index=1
        image_yscale=-1
        x=xCenter
        y=yCeiling-abs(sprite_height)
        if bPoeActive=0 {resType[1]=5}
        bBigHands=1
        bigHandScl=0
        if hasArmor = 1
            {
                armor=3
                spawnArmorEffect()
            }
      }
      else if atkTime>=2
      {
        if atkTime=2 {playSound(global.snd_OrbThrow,0,0.975,14000)}
        if bigHandScl<5 {bigHandScl+=0.2*gDeltaTime}

        var tEffect,tXspd;
        if gDeltaDoTicks //60fps change (added): dust once per 30fps tick (was every frame)
        {
          tEffect=instance_create(x-8+random_range(-15,15),yCeiling+random_range(-3,15),oEffect)
          tEffect.sprite_index=sZeldaEnemyDie; tEffect.image_speed=0.25; tEffect.image_blend=c_gray
          tEffect.followID=-1; tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
        }
        if oGame.time mod (2/gDeltaTime)=0
        {
          tXspd=random_range(-0.25,0.25)
          tEffect=instance_create(x+random_range(-13,13),yCeiling+random_range(-2,3),oEffectGrav)
          tEffect.sprite_index=sSmallBoulder; tEffect.image_xscale=0.2; tEffect.image_yscale=0.2
          tEffect.followID=-1; tEffect.newBlend=-1; tEffect.xSpd=tXspd; tEffect.ySpd=random(1); tEffect.grav=0.4
          tEffect.rotation=tXspd; tEffect.type=2; tEffect.fadeSpd=0.075
        }
        y+=0.5*gDeltaTime
        if y>=yCeiling
        {
          bCanDealDamage=true; bCanTakeDamage=true
          y=yCeiling
          atkTime=0; atkSequence=7
        }
      }
    }
    else if atkSequence=7 //--------------- Attack from ceiling ---------------
    {
      atkTime+=1*gDeltaTime
      if bPoeActive=0 {atkMod=20}
      else {atkMod=50}
      if atkTime mod atkMod=0
      {
        playSound(global.snd_HardHit3,0,0.95,28000)
        var tFire;
        tFire=instance_create(x+(20*image_xscale),y+14,oPassBullet)
        tFire._direction=point_direction(x+(20*image_xscale),y+14,oPlayer1.x,oPlayer1.y-26); tFire.sprite_index=sWolfHeadShot
        tFire.atkPower=atkPower; tFire.bulletSpeed=5; tFire.decayTime=-100
      }
      if atkTime mod 50=0 and bPoeActive=0
      {
        var tFire,tXOff;
        tXOff=-80
        for(i=0;i<3;i+=1)
        {
          tFire=instance_create(xCenter+tXOff,0,oPassBullet)
          tFire._direction=270; tFire.sprite_index=sWolfHeadShot
          tFire.atkPower=atkPower; tFire.bulletSpeed=6; tFire.decayTime=-100
          tXOff+=80
        }
      }
      if atkTime>=105
      {
        bCanDealDamage=false
        bCanTakeDamage=false
        atkTime=0
        atkSequence=8
      }
    }
    else if atkSequence=8 //--------------- Rise back into ceiling ---------------
    {
      if bigHandScl>0 {bigHandScl-=0.2*gDeltaTime}

      var tEffect,tXspd;
      if gDeltaDoTicks //60fps change (added): dust once per 30fps tick (was every frame)
      {
        tEffect=instance_create(x-8+random_range(-15,15),yCeiling+random_range(-3,15),oEffect)
        tEffect.sprite_index=sZeldaEnemyDie; tEffect.image_speed=0.25; tEffect.image_blend=c_gray
        tEffect.followID=-1; tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
      }
      if oGame.time mod (2/gDeltaTime)=0
      {
        tXspd=random_range(-0.25,0.25)
        tEffect=instance_create(x+random_range(-13,13),yCeiling+random_range(-2,3),oEffectGrav)
        tEffect.sprite_index=sSmallBoulder; tEffect.image_xscale=0.2; tEffect.image_yscale=0.2
        tEffect.followID=-1; tEffect.newBlend=-1; tEffect.xSpd=tXspd; tEffect.ySpd=random(1); tEffect.grav=0.4
        tEffect.rotation=tXspd; tEffect.type=2; tEffect.fadeSpd=0.075
      }
      y-=0.5*gDeltaTime
      if y<=yCeiling-abs(sprite_height)
      {
        image_yscale=1
        image_index=0
        if bPoeActive=0 {resType[1]=3}
        bBigHands=0
        atkTime=0; atkSequence=9
      }
    }
    else if atkSequence=9 //--------------- Very slight wait ---------------
    {
      atkTime+=1*gDeltaTime
      if atkTime>=15 {atkTime=0; atkSequence=0}
    }

    if bPoeActive=1 //Dylan is beaten
    {
      if !instance_exists(oDylanThePoe)
      {
        for(i=0;i<6;i+=1)
        {
          resType[i]=3
        }
        if sprite_index=sDeadHand_Jump {resType[0]=4}
        if atkSequence>=6 and atkSequence<=8 {resType[1]=5}
        bPoeActive=0
        baseRate=80
      }
    }

    if bCanSummonHands=1 //Summon Hands
    {
      if oPlayer1.y>=232 {handRate=baseRate}
      else {handRate=round(baseRate*0.7)}

      handTime+=1*gDeltaTime
      if handTime>=handRate and instance_number(oGrabbingHand)<maxHands
      {
        var tHand;
        tHand=instance_create(handSpawnX,yGround+25,oGrabbingHand)
        tHand.timeout=handTimeout
        handSpawnX+=24
        if handSpawnX>=xCenter+roomSpan-24 {handSpawnX=xCenter-roomSpan+24}
        handTime=0
      }
    }

    //---------- Boss Difficulty Curve ----------
    if lifePercent<=0.92 and lifePercent>=0.76 and bossProgress=0
    {
      bCanSummonHands=1
      atkDuration-=5
      bossProgress+=1
    }
    else if lifePercent<=0.75 and lifePercent>=0.56 and bossProgress=1
    {
      atkDuration-=15
      baseRate-=7
      handTimeout-=5
      maxHands+=1
      bossProgress+=1
    }
    else if lifePercent<=0.55 and lifePercent>=0.31 and bossProgress=2
    {
      atkDuration-=15
      baseRate-=7
      handTimeout-=5
      maxHands+=1
      bossProgress+=1
    }
    else if lifePercent<=0.3 and lifePercent>=0 and bossProgress=3
    {
      baseRate=230
      atkDuration-=5
      handTimeout-=5
      fireRate-=1
      bPoeActive=1
      instance_create(352,160,oDylanThePoe)
      for(i=0;i<6;i+=1)
      {
        resType[i]=1
      }
      bossProgress+=1
    }
  }
  else if life<=0 //Defeat animation
  {
    deathAnim+=1*gDeltaTime
    if deathAnim=1
    {
      with oGrabbingHand {instance_destroy()}
    }
    else if deathAnim>=2 and deathAnim<=55
    {
      if oGame.time mod (5/gDeltaTime)=0
      {
        var tEffect;
        tEffect=instance_create((x-sprite_width/2)+random(sprite_width),y-random(sprite_height),oEffect)
        tEffect.sprite_index=sSamusSMissileHit; tEffect.image_speed=0.5; tEffect.image_xscale=0.5; tEffect.image_yscale=0.5
        tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
      }
    }
    else if deathAnim>=56
    {
      if global.bBossGallery=1
      {
        bossRoomTally(4)
        global.newMapX=1016; global.newMapY=1376; room_goto(rBossGallery)
      }
      else
      {
        oEvCh4MainA.sceneProgress=1
        instance_destroy()
      }
    }
  }
  enemyStepEvent()
}
