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

  bottomFrm+=0.2*gDeltaTime
  if bActive=true and life>0
  {
    atkTime+=1*gDeltaTime
    if atkSequence=0 //Set weakness
    {
      if atkTime=10
      {
        var tEffect;
        if currentWeakness=6 //Everything at half
        {
          for(i=0;i<6;i+=1)
          {
            tEffect=instance_create(x-8,y-24,oEffectB)
            tEffect.type=3; tEffect.sprite_index=sPauseM_AtkTypes; tEffect.image_speed=0; tEffect.image_index=i
            tEffect.direction=i*60; tEffect.speed=2; tEffect.friction=0.05; tEffect.fadeSpd=0.04
            tEffect.AccelX=0; tEffect.AccelY=0; tEffect.newBlend=-1; tEffect.followID=-1; tEffect.rotation=0
            resType[i]=2
            if increaseResists=1
              {
                resType[i]=3
                
              }
          }
          if increaseResists=1
          {
            defense += 25
          }
        }
        else //Cycle weaknesses
        {
          for(i=0;i<6;i+=1)
          {
            tEffect=instance_create(x-8,y-24,oEffectB)
            tEffect.type=3; tEffect.sprite_index=sPauseM_AtkTypes; tEffect.image_speed=0; tEffect.image_index=currentWeakness
            tEffect.direction=i*60; tEffect.speed=2; tEffect.friction=0.05; tEffect.fadeSpd=0.04
            tEffect.AccelX=0; tEffect.AccelY=0; tEffect.newBlend=-1; tEffect.followID=-1; tEffect.rotation=0
            resType[i]=1
          }
          resType[currentWeakness]=3
        }
      }
      else if atkTime=30
      {
        if groundBlastTime<groundBlastDelay-5 {groundBlastTime=groundBlastDelay-1}
        if currentWeakness=0 {HPThresA=1300; HPThresB=800}
        else if currentWeakness=1 {HPThresA=1200; HPThresB=600}
        else if currentWeakness=2 {HPThresA=1200; HPThresB=700}
        else if currentWeakness=3 {HPThresA=500; HPThresB=300}
        else if currentWeakness=4 {HPThresA=400; HPThresB=200}
        else if currentWeakness=5 {HPThresA=600; HPThresB=300}
        atkTime=0
        if currentWeakness=6 {atkSequence=10}
        else {atkSequence+=1}
      }
    }
    else if atkSequence=1 //Check for HP drop (Normal)
    {
      if dmgCount>=HPThresA
      {
        if hasArmor = 1
{
    armor=3
    spawnArmorEffect()
}
        var tFlash;
        tFlash=instance_create(0,0,oScreenFlash); tFlash.image_alpha=0.8; tFlash.fadeSpeed=0.2
        if groundBlastTime<groundBlastDelay-5 {groundBlastTime=groundBlastDelay-1}
        atkTime=0; atkSequence+=1
      }
    }
    else if atkSequence=2 //Spawn shield
    {
      if atkTime=1
      {
        var tEffect;
        for(i=0;i<4;i+=1)
        {
          tEffect=instance_create(x,y,oEffect)
          tEffect.sprite_index=sMMchargeComplete; tEffect.image_xscale=1+i; tEffect.image_yscale=1+i
          tEffect.followID=-1; tEffect.xFollow=0; tEffect.yFollow=0; tEffect.image_speed=0.6-(0.1*i)
          tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
        }
      }
      else if atkTime=25
      {
        var tFlash,eShield;
        tFlash=instance_create(0,0,oScreenFlash); tFlash.image_alpha=0.6; tFlash.fadeSpeed=0.2
        eShield=instance_create(x,y,oArmyShield); eShield.shieldDist=80; eShield.atkPower=atkPower
        eShield=instance_create(x,y,oArmyShield); eShield.shieldDist=40; eShield.atkPower=atkPower
        eShield.image_xscale=0.75; eShield.image_yscale=0.75
        dmgCount=0
        atkTime=0; atkSequence+=1
      }
    }
    else if atkSequence=3 //Check for HP drop (Shield)
    {
      if dmgCount>=HPThresB
      {
        if hasArmor = 1
{
    armor=3
    spawnArmorEffect()
}
        var tFlash;
        tFlash=instance_create(0,0,oScreenFlash); tFlash.image_alpha=0.4; tFlash.fadeSpeed=0.2
        for(i=0;i<6;i+=1)
        {
          resType[i]=1
        }
        with oArmyShield {instance_destroy()}
        dmgCount=0
        atkTime=0; atkSequence=0

        sectionClearDelay-=8
        missileSpamDelay-=8
        if currentWeakness=0 {currentWeakness=4}
        else if currentWeakness=4 {currentWeakness=1}
        else if currentWeakness=1 {currentWeakness=5}
        else if currentWeakness=5 {currentWeakness=2}
        else if currentWeakness=2 {currentWeakness=3}
        else if currentWeakness=3 {currentWeakness=6}
      }
    }
    else if atkSequence=10 //Last attack and shield
    {
      if hasArmor = 1
{
    armor=3
    spawnArmorEffect()
}
      var tFlash,eShield;
      tFlash=instance_create(0,0,oScreenFlash); tFlash.image_alpha=0.6; tFlash.fadeSpeed=0.2
      eShield=instance_create(x,y,oArmyShield); eShield.shieldDist=80; eShield.atkPower=atkPower
      eShield=instance_create(x,y,oArmyShield); eShield.shieldDist=40; eShield.atkPower=atkPower
      eShield.image_xscale=0.75; eShield.image_yscale=0.75

      sectionClearDelay-=40
      missileSpamDelay-=40
      atkSequence=11
    }

    //-------------------- ATTACK: GROUND BLAST --------------------
    groundBlastTime+=1*gDeltaTime
    if groundBlastTime>=groundBlastDelay and groundBlastTime<=groundBlastDelay+100
    {
      groundBlastTime=10000
      gbSeq=48; gbStart=52
      if currentWeakness=0 or currentWeakness=4 {gbSeq=46}
      else if currentWeakness=1 or currentWeakness=5 {gbSeq=31}
      else if currentWeakness=2 or currentWeakness=3 {gbSeq=16}
    }
    else if groundBlastTime>=10001 and groundBlastTime mod 4=0
    {
      var tGroundAtk;
      tGroundAtk=instance_create(gbStart,yGround,oAE_GroundBlast)
      tGroundAtk.atkPower=atkPower
      gbStart+=gbSeq

      if gbStart>=428
      {
        groundBlastTime=0
      }
    }

    //-------------------- ATTACK: SECTION CLEAR --------------------
    sectionClearTime+=1*gDeltaTime
    if sectionClearTime>=sectionClearDelay
    {
      var tXStart,tYStart,tTarget,tSecClear;
      if oPlayer1.x<=240 {tXStart=64}
      else {tXStart=256}
      tYStart=80

      for(i=0;i<5;i+=1)
      {
        for(ii=0;ii<7;ii+=1)
        {
          tSecClear=instance_create(tXStart+(i*48),tYStart+(ii*48),oAE_SectionClear)
          tSecClear.atkPower=atkPower*2
        }
      }
      sectionClearTime=0
    }

    //-------------------- ATTACK: MISSILE SPAM --------------------
    missileSpamTime+=1*gDeltaTime
    if missileSpamTime>=missileSpamDelay
    {
      //if gDeltaDoTicks {var tMissile;
      if frac(missileSpamTime)=0 {var tMissile; //60fps change: one missile per 30fps tick counted from when the volley starts (missileSpamTime is whole on those frames), so the first one fires right away like at 30fps; gDeltaDoTicks (the game-wide tick) delayed the whole volley by a random 0-3 frames
      tMissile=instance_create(x,y-16,oEnmityMissile)
      tMissile.atkPower=atkPower; tMissile.targetTime=18
      tMissile._direction=missileDir; tMissile.bulletSpeed=4
      missileDir-=15
      if missileDir<=15
      {
        playSound(global.snd_BombLaunch,0,0.88,1)
        missileDir=165
        missileSpamTime=0
      }}
    }
  }
  enemyStepEvent()
}

if life<=0 //Defeat animation
{
  deathAnim+=1*gDeltaTime
  if deathAnim=1
  {
    if global.bBossGallery=1
    {
      bossRoomTally(26)
      global.newMapX=600; global.newMapY=1088; room_goto(rBossGallery)
    }
    else
    {
      with oEProjectileBase {instance_destroy()}
      with oAttackBase {instance_destroy()}

      global.gamePaused=true
      var tFlash;
      tFlash=instance_create(0,0,oScreenFlash)
      tFlash.fadeSpeed=0.2
      oPlayer1.visible=0; oPlayer1.x=272; oPlayer1.y=yGround
      oPlayerIdle.visible=0; oPlayerIdle.x=208; oPlayerIdle.y=yGround; oPlayerShieldBubble.visible=0

      mashingButtons=instance_create(0,0,oMashButtons)
      mashingButtons.xCenter=240; mashingButtons.yCenter=192
      mashingButtons.startJerryX=400; mashingButtons.startJerryY=272
      mashingButtons.startClaireX=80; mashingButtons.startClaireY=272
    }
  }
  else if deathAnim=15
  {
    msgCreate(0,0,"Jerry","Time to discontinue this series of robot!",0,1,oMessagePerson,0)
    newMessage.fadingTime=70
  }
  else if deathAnim=90
  {
    msgCreate(0,0,"Claire","Lame line, Jerry.",0,0,oMessagePerson,0)
    newMessage.fadingTime=50
  }
  else if deathAnim=145
  {
    mashingButtons.bCanHit=1
  }
  else if deathAnim>=155 and deathAnim<=165
  {
    if deathAnim=160 {deathAnim=155}

    if mashingButtons.timeToStop<=0
    {
      global.gamePaused=false
      mashingButtons.bCanHit=2
      var tFlash;
      tFlash=instance_create(0,0,oScreenFlash); tFlash.fadeSpeed=0.2
      oPlayer1.visible=1; oPlayerIdle.visible=1; oPlayerShieldBubble.visible=1
      deathAnim=175
    }
  }
  //else if deathAnim>=176 and deathAnim<=235
  else if deathAnim>175 and deathAnim<=235 //60fps change: includes every frame of tick 176, not just its last one
  {
    if deathAnim mod 3=0 {playSound(global.snd_BombExplode,0,0.92,1)}
    if oGame.time mod (2/gDeltaTime)=0
    {
      var tEffect;
      tEffect=instance_create((x-sprite_width/2)+random(sprite_width),(y-sprite_height/2)+random(sprite_height),oEffect)
      tEffect.sprite_index=sSamusSMissileHit; tEffect.image_speed=0.5; tEffect.image_xscale=0.5; tEffect.image_yscale=0.5
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    }
  }
  else if deathAnim>=236
  {
    instance_destroy()
  }
}
