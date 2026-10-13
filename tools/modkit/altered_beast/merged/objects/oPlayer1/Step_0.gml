ditherCounter+=1
//input bleed change (added): while the game is paused the buttons aren't read, and outside a cutscene characterStepEvent
//doesn't even run (a menu, a shop, dialogue), so it couldn't note that itself; the next step that reads them then locks the
//ones pressed in the meantime (scrButtonLockHeld), e.g. A on a gamepad advancing the last line of dialogue
if global.gamePaused=true {kKeysRead=0}

if global.cutscene=true
{
  if global.activeCharacter=4 {charJeremyStepEvent()}
  else if global.activeCharacter=5 {}
  else {characterStepEvent()}
}
//---------- Health and spirit percent ----------
lifePercent=life/maxLife

//---------- Check max life ----------
if life>maxLife
  life=maxLife

if global.debugAlwaysMaxHP=true
  life=maxLife
//---------- Death ----------
if life<=0
{
  if global.bCanGameOver=1
  {
    if global.BTB_HelmetHead=1 //Helmet Head EX final game over
    {
      if !instance_exists(oHelmetHeadEX_GameOver)
      {
        stopLoopingSounds()
        gameOver=instance_create(0,0,oHelmetHeadEX_GameOver)
      }
    }
    else //Normal game over
    {
      if !instance_exists(oGameOver)
      {
        stopLoopingSounds()
        gameOver=instance_create(0,0,oGameOver)
      }
    }
  }
}

if global.gamePaused=false and global.bShooter=0
{
  if battleRage>0
  {
    //battleRage-=1
    battleRage-=1*gDeltaTime //60fps change
  }
  if momentumTimer > 0
  {
    //momentumTimer-=1
    momentumTimer-=1*gDeltaTime //60fps change
    if momentumTimer=0
    {
        momentumStacks=0
    }
  }
  //---------- Ability recharge rates ----------
  if global.activeCharacter=0
  {
    if global.activeAbility[0]=1 //Link Set ----------
    {
      playerAbilRecover(2); playerAbilRecover(3); playerAbilRecover(4)
      equipValA=0
      if global.alterEquip=0
      {
      for(i=0;i<3;i+=1)
      {
        if global.equipJerry[i]=20
        {
              equipValA+=20
              //break;
            }
        }
      }

      if global.hudLink_Arrows[0]<global.hudLink_Arrows[1]
      {
        var tArrowPercent;
        tArrowPercent=round(global.hudLink_Arrows[0]/global.hudLink_Arrows[1])*100
        if tArrowPercent>95 {tArrowPercent=95}
        else if tArrowPercent<40 {tArrowPercent=40}
        arrowRecharge+=1*gDeltaTime
        if arrowRecharge>=tArrowPercent+arrowDelay
        {
          arrowRecharge=0
          if arrowDelay>0
          {
            arrowDelay-=5
            if arrowDelay<0 {arrowDelay=0}
          }
          global.hudLink_Arrows[0]+=1
        }
      }

      if global.hudLink_BombEn[0]<120-round(global.skillTree[1]*7.5)-equipValA
        global.hudLink_BombEn[0]+=1*gDeltaTime
      else if global.hudLink_BombEn[0]>120-round(global.skillTree[1]*7.5)-equipValA
        global.hudLink_BombEn[0]=120-round(global.skillTree[1]*7.5)-equipValA
    }
    else if global.activeAbility[0]=2 //Mega Man Set ----------
    {
      playerAbilRecover(1); playerAbilRecover(2); playerAbilRecover(4)
      if global.hudMega_BusterEn[0]<32
      {
        //if oGame.time mod 15-global.skillTree[28]=0
        //  global.hudMega_BusterEn[0]+=1*gDeltaTime
        var tMMRecharge; //60fps change: counts 30fps ticks and adds whole points (it added half/quarter points twice/four times as often at 60/120fps)
        if global.fixMMRecharge=true {tMMRecharge=(oGame.time mod ((15-global.skillTree[28])/gDeltaTime)=0)} //dipswitch: recharge every 15-skill ticks
        else {tMMRecharge=((oGame.time mod (15/gDeltaTime))-(global.skillTree[28]/gDeltaTime)=0)} //vanilla: once per 15 ticks (the skill only shifts the timing)
        if tMMRecharge
          global.hudMega_BusterEn[0]+=1
      }
      if global.hudMega_ShotIceEn[0]<32
      {
        //if oGame.time mod 36-round(global.skillTree[28]*1.67)=0
        //  global.hudMega_ShotIceEn[0]+=1*gDeltaTime
        var tMMRecharge; //60fps change: see above
        if global.fixMMRecharge=true {tMMRecharge=(oGame.time mod ((36-round(global.skillTree[28]*1.67))/gDeltaTime)=0)} //dipswitch
        else {tMMRecharge=((oGame.time mod (36/gDeltaTime))-(round(global.skillTree[28]*1.67)/gDeltaTime)=0)} //vanilla: once per 36 ticks
        if tMMRecharge
          global.hudMega_ShotIceEn[0]+=1
      }
      if global.hudMega_GravityEn[0]<32
      {
        //if oGame.time mod 40-(global.skillTree[28]*2)=0
        //  global.hudMega_GravityEn[0]+=1*gDeltaTime
        var tMMRecharge; //60fps change: see above
        if global.fixMMRecharge=true {tMMRecharge=(oGame.time mod ((40-(global.skillTree[28]*2))/gDeltaTime)=0)} //dipswitch
        else {tMMRecharge=((oGame.time mod (40/gDeltaTime))-((global.skillTree[28]*2)/gDeltaTime)=0)} //vanilla: once per 40 ticks
        if tMMRecharge
          global.hudMega_GravityEn[0]+=1
      }
    }
    else if global.activeAbility[0]=3 //Game Set ----------
    {
      if global.hudGame_WeaponEn[0]<global.hudGame_WeaponEn[1]
      {
        var tWeaponRegen;
        if attackState=ACT_BLOCK {tWeaponRegen=5}
        else if global.stJGame_C[0]<0 {tWeaponRegen=4}
        else {tWeaponRegen=3}
        if oGame.time mod (tWeaponRegen/gDeltaTime)=0 {global.hudGame_WeaponEn[0]+=1}
      }
      else if global.hudGame_WeaponEn[0]>global.hudGame_WeaponEn[1]
        global.hudGame_WeaponEn[0]=global.hudGame_WeaponEn[1]

      lastGuardTime+=1*gDeltaTime
      if global.stJGame_C[0]>2000 //super mode
      {
        global.stJGame_C[0]-=20*gDeltaTime
        if global.stJGame_C[0]<=4000 {global.stJGame_C[0]=1000}
      }
      if attackState!=ACT_BLOCK //shield
      {
        if global.stJGame_C[0]>0 and global.stJGame_C[0]<1000 //normal
        {
          if global.location=76 {global.stJGame_C[0]+=(6+(global.skillTree[9]*0.25))*gDeltaTime}
          else {global.stJGame_C[0]+=(5+(global.skillTree[9]*0.25))*gDeltaTime}
          if global.stJGame_C[0]>1000 {global.stJGame_C[0]=1000}
        }
        else if global.stJGame_C[0]<0{global.stJGame_C[0]+=5.25*gDeltaTime} //broken
      }
      if global.stJGame_C[0]>-200 and global.stJGame_C[0]<=0 //Overload shield
      {
        global.recShieldBroken+=1*gDeltaTime
        global.stJGame_C[0]=-2000
      }
      else if global.stJGame_C[0]>-1000 and global.stJGame_C[0]<-800 {global.stJGame_C[0]=1000} //Recover shield
    }
  }
  else if global.activeCharacter=1
  {
    if global.activeAbility[1]=1 //Belmont Set ----------
    {
      playerAbilRecover(1); playerAbilRecover(3); playerAbilRecover(4)
      if global.hudBelmont_WeaponEn[0]<global.hudBelmont_WeaponEn[1]
      {
        equipValA=0
        if global.alterEquip=0
        {
        for(i=0;i<3;i+=1)
        {
          if global.equipClaire[i]=8
          {
            equipValA=3
            break;
              }
          }
        }
        if global.bNightmareMode=0
        {
          //if oGame.time mod (21-(global.skillTree[2]*3)-equipValA)=0
          //  global.hudBelmont_WeaponEn[0]+=1*gDeltaTime
          if oGame.time mod ((21-(global.skillTree[2]*3)-equipValA)/gDeltaTime)=0 //60fps change: counts 30fps ticks and adds whole points (it added half/quarter points twice/four times as often)
            global.hudBelmont_WeaponEn[0]+=1
        }
        else
        {
          //if oGame.time mod 15=0
          //  global.hudBelmont_WeaponEn[0]+=1*gDeltaTime
          if oGame.time mod (15/gDeltaTime)=0 //60fps change: see above
            global.hudBelmont_WeaponEn[0]+=1
        }
      }
    }
    else if global.activeAbility[1]=2 //Samus Set ----------
    {
      playerAbilRecover(1); playerAbilRecover(2); playerAbilRecover(3)
      if global.hudSamus_CannonEn[0]>0
      {
        var tCannonChargeMod;
        if busterLastShotTime>=0 and busterLastShotTime<=20 {tCannonChargeMod=6}
        else if busterLastShotTime>20 and busterLastShotTime<=50 {tCannonChargeMod=5}
        else if busterLastShotTime>50 and busterLastShotTime<=80 {tCannonChargeMod=4}
        else if busterLastShotTime>80 {tCannonChargeMod=2}

        if oGame.time mod tCannonChargeMod=0 {global.hudSamus_CannonEn[0]-=10*gDeltaTime}
      }

      if global.hudSamus_Missiles[0]<global.hudSamus_Missiles[1]
      {
        var tMissilePercent;
        tMissilePercent=round(global.hudSamus_Missiles[0]/global.hudSamus_Missiles[1])*100
        if tMissilePercent>95 {tMissilePercent=95}
        else if tMissilePercent<40 {tMissilePercent=40}
        missileRecharge+=1*gDeltaTime
        if missileRecharge>=tMissilePercent+missileDelay
        {
          missileRecharge=0
          if missileDelay>0
          {
            missileDelay-=5
            if missileDelay<0 {missileDelay=0}
          }
          global.hudSamus_Missiles[0]+=1
        }
      }
    }
    else if global.activeAbility[1]=3 //Game Set ----------
    {
      if global.hudGame_WeaponEn[0]<global.hudGame_WeaponEn[1]
      {
        var tWeaponRegen;
        if attackState=ACT_BLOCK {tWeaponRegen=5}
        else if global.stJGame_C[0]<0 {tWeaponRegen=4}
        else {tWeaponRegen=3}
        if oGame.time mod (tWeaponRegen/gDeltaTime)=0 {global.hudGame_WeaponEn[0]+=1}
      }
      else if global.hudGame_WeaponEn[0]>global.hudGame_WeaponEn[1]
        global.hudGame_WeaponEn[0]=global.hudGame_WeaponEn[1]

      lastGuardTime+=1*gDeltaTime
      if global.stJGame_C[0]>2000 //super mode
      {
        global.stJGame_C[0]-=62*gDeltaTime
        if global.stJGame_C[0]<=4000 {global.stJGame_C[0]=1000}
      }
      if attackState!=ACT_BLOCK //shield
      {
        if global.stJGame_C[0]>0 and global.stJGame_C[0]<1000 //normal
        {
          if global.location=76 {global.stJGame_C[0]+=(6+(global.skillTree[9]*0.25))*gDeltaTime}
          else {global.stJGame_C[0]+=(5+(global.skillTree[9]*0.25))*gDeltaTime}
          if global.stJGame_C[0]>1000 {global.stJGame_C[0]=1000}
        }
        else if global.stJGame_C[0]<0 {global.stJGame_C[0]+=5.25*gDeltaTime} //broken
      }
      if global.stJGame_C[0]>-200 and global.stJGame_C[0]<=0 //Overload shield
      {
        global.recShieldBroken+=1*gDeltaTime
        global.stJGame_C[0]=-2000
      }
      else if global.stJGame_C[0]>-1000 and global.stJGame_C[0]<-800 {global.stJGame_C[0]=1000} //Recover shield
    }
  }

  if global.activeCharacter=4 {charJeremyStepEvent()}
  else {characterStepEvent()}
  //---------- Find distance moved ----------
  if platformCharacterIs(ON_GROUND)
    global.recDistFoot+=abs(xVel)
  else if platformCharacterIs(IN_AIR)
    global.recDistAir+=abs(xVel)

  //---------- Keep player inside room ----------
  if y>room_height+64
  {
    global.recFallenOffLevel+=1
    life-=maxLife
  }
  else if y<-32 {yVel=4}

  if global.partySplit=0 //No split party
  {
    if bKeepPlayerOnScreen=0 //Can only go off the left side of the screen
    {
      if x<0
      {
        xVel=0
        x=0
      }
      else if x>view_xview[0]+view_wview[0]
      {
        xVel=0
        x=view_xview[0]+view_wview[0]
      }
    }
    else //Can't go off either side of the screen
    {
      if x<view_xview[0]
      {
        xVel=0
        x=view_xview[0]
      }
      else if x>view_xview[0]+view_wview[0]
      {
        xVel=0
        x=view_xview[0]+view_wview[0]
      }
    }
  }
  else //In split party - Keep player inside map
  {
    if x<0
    {
      xVel=0
      x=0
    }
    else if x>room_width
    {
      xVel=0
      x=room_width
    }
  }
  
  //---------- Level time (per map) ----------
  global.levelTimeFrameCount+=1
  if global.levelTimeFrameCount>=30/gDeltaTime
  {
    global.levelTimeSecond+=1
    global.levelTimeFrameCount=0
  }
  
  //---------- Underwater Air Time ----------
  var tBreathHC;
  if state=DUCKING {tBreathHC=-14}
  else if state=RUNNING
  {
    if global.activeCharacter=0 {tBreathHC=-9}
    else {tBreathHC=4}
  }
  else {tBreathHC=4}
  
  if isCollisionWaterTop(tBreathHC) //Head underwater
  {
    //bubbleTime-=1
    bubbleTime-=1*gDeltaTime //60fps change: air bubbles came out 2x/4x as often underwater at 60/120fps
    if bubbleTime<=0
    {
      var newBubble,bubbleCount;
      newBubble=instance_create(x,y-36,oPlayerAirBubble)
      bubbleTime=irandom_range(10,70)
      bubbleCount=instance_number(oPlayerAirBubble)
      if bubbleCount>global.recMaxBubbles {global.recMaxBubbles=bubbleCount}
    }
    
    waterTime+=1*gDeltaTime
    if waterTime>=30 //Water time track
    {
      global.recTimeUnderWater+=1
      waterTime=0
    }
    
    global.pCurrBreath-=1*gDeltaTime
    if global.pCurrBreath<=0
    {
      global.recDrowned+=1
      life-=maxLife
    }
  }
  else
  {
    global.pCurrBreath+=8*gDeltaTime
    if global.pCurrBreath>global.pBreathMax {global.pCurrBreath=global.pBreathMax}
  }
  
  //---------- Starman time ----------
  if starmanTime>0
  {
    if gDeltaDoTicks {image_blend=make_color_rgb(random(255),random(255),random(255))} //60fps change: color and effects once per 30fps tick (per frame was 2x/4x as many at 60/120fps)
    var tEfAI,tEfStar;
    if gDeltaDoTicks //60fps change (added)
    for(i=0;i<4;i+=1)
    {
      tEfStar=instance_create((x-(sprite_width/2))+random(sprite_width),(y-sprite_height+3)+random(sprite_height-6),oEffect)
      if i<=1 {tEfStar.sprite_index=sMMshotgunIceEffect}
      else {tEfStar.sprite_index=sBelmontWepEffect}
      tEfStar.image_speed=0.2+random(0.2)
      tEfStar.image_blend=make_color_rgb(random(200)+55,random(200)+55,random(200)+55)
      tEfStar.image_alpha=0.4+random(0.6); tEfStar.ySpd=-1-random(3)
      tEfStar.newBlend=-1; tEfStar.followID=-1; tEfStar.decay=-100; tEfStar.xSpd=0
    }
    if gDeltaDoTicks { //60fps change (added)
    tEfAI=instance_create(x,y,oPlayerAfterImage)
    tEfAI.imageColor=image_blend
    } //60fps change (added)
    starmanTime-=1*gDeltaTime
    //if starmanTime>=1 and starmanTime<=40
    if starmanTime>=1 and starmanTime<=40 and gDeltaDoTicks //60fps change: ending burst once per 30fps tick
    {
      var tEfStar;
      for(i=0;i<4;i+=1)
      {
        tEfStar=instance_create(x,y-26,oEffect)
        if i<=1 {tEfStar.sprite_index=sMMshotgunIceEffect}
        else {tEfStar.sprite_index=sBelmontWepEffect}
        tEfStar.image_speed=0.1+random(0.1)
        tEfStar.image_blend=make_color_rgb(random(200)+55,random(200)+55,random(200)+55)
        tEfStar.image_alpha=0.8+random(0.2); tEfStar.xSpd=random_range(-8,8); tEfStar.ySpd=random_range(-8,8)
        tEfStar.newBlend=-1; tEfStar.followID=-1; tEfStar.decay=-100
      }
    }
    else if starmanTime=0
    {
      stopAllMusic()
      var tempMplay;
      tempMplay=findMusic(global.currentMusic)
      playMusic(tempMplay,0,0)
      image_blend=c_white
    }
  }
  
  //---------- birb ---------------
  tBirds = 0
    if global.alterEquip=1
    {
        if global.activeCharacter=0
        {
          for(i=0;i<3;i+=1)
            if global.equipJerry[i]=22
              tBirds=1
        }
        else
        {
          for(i=0;i<3;i+=1)
            if global.equipClaire[i]=22
              tBirds=1
        }
    }
  if tBirds=1
  {
    //have bird timer count upwards to a maxBirdtimer, that starts at 20 and goes up in proportion to damage dealt to a max of 90, resets to 20 when bird spawned
    //birdTimer+=1
    birdTimer+=1*gDeltaTime //60fps change
    if (birdTimer >= timeForBird)
    {
        bird=instance_create(x,y,oDiveBird)
        bird.diveIn = true
        birdTimer = 0
        timeForBird=20
    }
    
  }
  //boomer
  if boomerTimer > 0
  {
    //boomerTimer-=1
    boomerTimer-=1*gDeltaTime //60fps change
    if boomerTimer = 0
    {
        boomerLevel = 0
    }
  }
  
  //---------- Dash invulnerability time ----------
  if dashInvulnerabilityTime>0
  {
    tDashMod = 0
    if global.activeCharacter=0
    {
      if global.alterEquip=1
      {
          for(i=0;i<3;i+=1)
          {
            if global.equipJerry[i]=13 {tDashMod=1;}
          }
      }
    }
    if global.activeCharacter=1
    {
      if global.alterEquip=1
      {
          for(i=0;i<3;i+=1)
          {
            if global.equipClaire[i]=13 {tDashMod=1;}
          }
      }
    }
    if tDashMod=0
    {
    //instance_create(x,y,oPlayerAfterImage)
    if gDeltaDoTicks instance_create(x,y,oPlayerAfterImage) //60fps change: as DT3+'s, once per 30fps tick
    }
    else
    {
        //instance_create(x,y,oDamagingPlayerAfterImage)
        if gDeltaDoTicks instance_create(x,y,oDamagingPlayerAfterImage) //60fps change: once per 30fps tick
    }
    //dashInvulnerabilityTime-=1
    dashInvulnerabilityTime-=1*gDeltaTime //60fps change

    if dashInvulnerabilityTime>=40 //Achievement
    {
      var tCheckAchieve;
      tCheckAchieve=string_char_at(global.tokenRecognitions,42)
      if tCheckAchieve="0"
      {
        var tAchievement;
        tAchievement=instance_create(0,0,oAchievementNotice)
        tAchievement.myAchievement="Dash Dance"; tAchievement.checkNum=42
      }
    }
  }
  
  //---------- Dash recovery ----------
  if dashEnergy<dashMeterMax //and walljumpTime=0
  {
    tAlterDash=0
    if global.alterEquip=1
    {
        for(i=0;i<3;i+=1)
        {
          if global.equipJerry[i]=12 {tAlterDash=1}
          if global.equipClaire[i]=12 {tAlterDash=1}
        }
    }
    if dashRecHalt=0 and tAlterDash=0
    {
      if global.challengeRoom>0 {dashEnergy+=round(dashRecovery/2)*gDeltaTime}
      else {dashEnergy+=(dashRecovery+modDashRecharge)*gDeltaTime}
    }
    else {dashRecHalt-=1*gDeltaTime}
    
    if global.optDashWarn=1 and (global.hasShoes[2]=2 or global.hasShoes[3]=2) //Low dash warning
    {
      if dashWarnSound=0 and dashEnergy<2000 //Ready the sound (For low dash warning)
      {
        playSound(global.snd_DashWarn,0,1,1)
        dashWarnSound=1
      }
      
      /*if dashWarnSound>=1 and dashWarnSound<=20 //Repeat sound
      {
        dashWarnSound+=1
        if dashWarnSound=10 {playSound(global.snd_DashWarn,0,1,1)}
        else if dashWarnSound=19 {playSound(global.snd_DashWarn,0,1,1)}
      }*/
      
      if dashWarnSound=1 and dashEnergy>=2000 //Dash ready sound
      {
        playSound(global.snd_DashWarn,0,1,11025)
        dashWarnSound=0
      }
    }
  }
  else {dashEnergy=dashMeterMax}
  
  //---------- X-Buster/Weapon last shot time ----------
  busterLastShotTime+=1*gDeltaTime
  specialLastShotTime+=1*gDeltaTime
  
  //---------- Nightmare mode only ability checks ----------
  if swordWaveCheck>0
  {
    swordWaveCheck-=1*gDeltaTime
    if swordWaveCheck=55 {swordWaveCheck=0}
  }
  if daggerSpamCheck>0
  {
    daggerSpamCheck-=1*gDeltaTime
    if daggerSpamCheck=60 {daggerSpamCheck=0}
  }
  if powerBombCheck>0 {powerBombCheck-=1*gDeltaTime}
  
  //---------- Idle time ----------
  if xVel=0 and yVel=0
  {
    idleTime+=1*gDeltaTime
    if idleTime=9000 and global.location!=108
    {
      var tCheckAchieve;
      tCheckAchieve=string_char_at(global.tokenRecognitions,3)
      if tCheckAchieve="0"
      {
        var tAchievement;
        tAchievement=instance_create(0,0,oAchievementNotice)
        tAchievement.myAchievement="Did You Go Eat"; tAchievement.checkNum=3
      }
    }
    if idleTime>global.recLongestIdle {global.recLongestIdle=idleTime}
  }
  
  if room=rExtGateD_6 //Elpizo boss fight
  {
    if instance_exists(oElpizo)
    {
      if place_meeting(x,y,oNightmareEffect)
      {
        if oElpizo.specTime<oElpizo.specMax
        {
          if oElpizo.timeMod=1 {oElpizo.specTime+=5*gDeltaTime}
          else {oElpizo.specTime+=10*gDeltaTime}
        }
      }
    }
  }
  
  //---------- Death convos ----------
  if deathConvoType>0
  {
    deathConvoTime+=1*gDeltaTime
    if deathConvoType=1 //Map: G4 - Ostrich D
    {
      if deathConvoTime=120
      {
        msgCreate(0,0,"Jeremy","Jerry, if you're going to break the 4th wall, at least do it right.",0,2,oMessagePerson,0)
        newMessage.fadingTime=140
      }
      else if deathConvoTime=260
      {
        msgCreate(0,0,"Jerry","HEY!!... Okay...",0,2,oMessagePerson,0)
        newMessage.fadingTime=90
      }
    }
    else if deathConvoType=2 //Map: Nightmare C3
    {
      if deathConvoTime=100
      {
        msgCreate(0,0,"Jerry","Ugh, Claire. That pun was painful, ESPECIALLY for me.",0,2,oMessagePerson,0)
        newMessage.fadingTime=140
      }
    }
    else if deathConvoType=3 //Map: Nightmare C4
    {
      if deathConvoTime=100
      {
        msgCreate(0,0,"Jerry","... ... ... ... ... ... ... ...",0,1,oMessagePerson,0)
        newMessage.fadingTime=90
      }
    }
  }
  
  //Player trail
  if global.optPlayerTrail=1 and global.location!=108 and global.gameProgress<=5340 {instance_create(x,returnPlayerYCenter(),oEfPlayerTrail)}
  
  if (oKeyCodesHighFPS.kCodePressed[11]=1) //Reset map in Boss Gallery
  {
    if (global.bBossGallery=1 and room!=rBossGallery) or (room=rWarshipZ_E3)
    {
      playSound(global.snd_Retry,0,1,1)
      scrFullStatRestore()
      global.recRetryBossRoom+=1
      global.gamePaused=false; global.gameOver=false
      room_restart()
    }
  }
  
}


else if global.bShooter=1
{
  //---------- Flash time after taking damage in Dragoon ----------
  if bCanTakeHit=false
  {
    //damageTime-=1
    //if image_alpha=0.75 {image_alpha=0.25}
    //else {image_alpha=0.75}
    damageTime-=1*gDeltaTime //60fps change: Dragoon invincibility after a hit was half/quarter as long at 60/120fps
    if gDeltaDoTicks {if image_alpha=0.75 {image_alpha=0.25} else {image_alpha=0.75}} //60fps change: flicker once per 30fps tick
    if damageTime<=0
    {
      image_alpha=1
      bCanTakeHit=true
      bTakingDamage=false
    }
  }
}

if global.location=108
{
  if room=rExtGateH_1
  {
    if oPlayer1.x>=1008 and oPlayer1.x<=1264 {setCollisionBounds(-7,-8,7,-1)}
    else {setCollisionBounds(-7,-40,7,-1)}
  }
  else if room=rExtGateH_2
  {
    if oPlayer1.x>=960 and oPlayer1.x<=1184 {setCollisionBounds(-7,-8,7,-1)}
    else {setCollisionBounds(-7,-40,7,-1)}
  }
}

//if extraBulletCheck>0 {extraBulletCheck-=1}
if extraBulletCheck>0 {extraBulletCheck-=1*gDeltaTime} //60fps change: the grace window against a second hit from the same volley (The Executive) was half/quarter as long at 60/120fps

if swapCheck=1 //wait 1 frame before moving objects around in split party maps
{
  var tPrevX,tPrevY;
  tPrevX=x; tPrevY=y
  x=oPlayerIdle.x; y=oPlayerIdle.y
  oPlayerIdle.x=tPrevX; oPlayerIdle.y=tPrevY
  swapCheck=0
}

//Jeremy Mech tracking
if mechFireRate>0 {mechFireRate-=1*gDeltaTime} //Reset Jeremy's Mech firerate
if mechShieldUses<2
{
  mechShieldRecover+=1*gDeltaTime
  if mechShieldRecover>=160
  {
    mechShieldUses+=1
    mechShieldRecover=0
  }
}
if mechMissileUses<2
{
  mechMissileRecover+=1*gDeltaTime
  if mechMissileRecover>=80
  {
    mechMissileUses+=1
    mechMissileRecover=0
  }
}
if mechLaserEnergy<mechLaserMax {mechLaserEnergy+=1*gDeltaTime}



//if (oKeyCodesHighFPS.kCode[9]=1 and oKeyCodesHighFPS.kCodePressed[14]=1 and global.gamePaused=true) or (oKeyCodesHighFPS.kCodePressed[10]=1 and oKeyCodesHighFPS.kCode[14]=1 and global.gamePaused=true)  //DT4 style reset, don't sue me
//    {
//    if global.currentBoss=""
//          {
//          if global.bossTrack>=101 and global.bossTrack<=999
//            {
//            event_user(3)
//            }
//            else
//            {
//            event_user(4)
//            }
//          }
//          else
//          {
//          event_user(3)
//          }
//    }
//quick restart change: Quick Restart (DT4 style reset), U + I on the keyboard / L1 + R1 on a gamepad, fixed
//(scrQuickRestartInput). It worked whenever the game was paused (cutscenes, shops, the game over screen, the CONTROLS
//list while keys were being typed in) with Swap Character/Ability Set + Dash Right; now only from the pause menu's main
//screen, and only where the pause menu's Retry is allowed (global.bCanForceGO). It restarts the way the game over's
//first option would (Retry Boss in a boss fight or encounter, Retry Map elsewhere) and counts as a death like a game over
//does (the death counter, the map's deaths for the restart messages, no map header after it), and also resets what the
//game over resets for the next try: the map's hit count, the kill streak, breath and looping sounds.
if global.qrPressed=1 and instance_exists(oPauseMenu)
{
  if oPauseMenu.titleMode=0 and oPauseMenu.subMenu=0
  {
    if global.bCanForceGO=true
    {
      global.rmDeaths+=1
      global.recDeathCount+=1
      global.recInterLostDeath+=moneyEarnedOnMap
      global.checkForDeath=1
      //U/I and L1/R1 are read as let go until they're let go (scrKeyboardCheck, scrGamepadCheck): the player made after
      //the restart starts with nothing held, so it would take them as just pressed (dashing, swapping)
      global.qrLockU=1; global.qrLockI=1; global.qrLockL1=1; global.qrLockR1=1
      stopLoopingSounds()
      global.hitsTaken=0
      global.killStreak=0
      global.pCurrBreath=global.pBreathMax
      if global.currentBoss=""
      {
        if global.bossTrack>=101 and global.bossTrack<=999 {event_user(3)}
        else {event_user(4)}
      }
      else {event_user(3)}
    }
    else {playSound(global.snd_Error,0,1,1)}
  }
}
