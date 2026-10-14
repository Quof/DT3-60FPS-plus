if global.gamePaused=false
{
  life=maxLife
  //need check so that move(2) only happens after init(2)
  if sequence<16 {InstrumentMovement(spinPhase)}
  ChaoWarp(spinPhase)
  AbomCamera(spinPhase)
  enemyStepEvent()
  with oHealthPickup {x=oPlayer1.x; y=returnPlayerYCenter()}
  
  if sequence=0 //-------------------- Fade in / start music --------------------
  { 
    if bBattleStart=1
    {
      bkgPartSeq=1
      playSound(global.snd_DemonVoice1,0,1,1)
      sequence=10
      var tempMplay;
      tempMplay=findMusic(822)
      playMusic(tempMplay,0,0)
      //add boss encounter boilerplate, including global.bossTrack=0 and global.currentBoss="Distorted Abomination"
    }
  }
/*
    //backBlend-=1
    backBlend-=1*gDeltaTime //60fps change: per frame
    oBackgroundFollow.image_blend=make_color_rgb(255,backBlend,backBlend)
*/
  else if sequence=10 //-------------------- Player has all instruments (Start instrument song) --------------------
  {
    //seqTime+=1
    seqTime+=1*gDeltaTime //60fps change: per frame
    if seqTime=25
    {
      oBackgroundFollow.image_blend=make_color_rgb(255,125,125)
      formWeakSpotX=200; formWeakSpotY=500; formWeakSpotDir=15; formWeakSpotHeartOffsetX=-8; event_user(0)
      formWeakSpotX=300; formWeakSpotY=500; formWeakSpotDir=165; formWeakSpotHeartOffsetX=40; event_user(0)
      seqTime=0; sequence+=1
    }
  }
  else if sequence=11 //-------------------- Spawn first arms --------------------
  {
    //seqTime+=1
    seqTime+=1*gDeltaTime //60fps change: per frame
    if seqTime=1
    {
      global.levelTimeSecond=0
      oPlayer1.tookHitAmount=0
      global.abomAttempts+=1
      bContinuousAttackA=1; bMinionSpawn=1
    }
    else if seqTime=20 {instance_create(496,280,oAbomFieldSegA); instance_create(776,296,oAbomFieldSegA)}
    else if seqTime=40 {instance_create(496,263,oAbomFieldSegA); instance_create(776,279,oAbomFieldSegA)}
    else if seqTime=60 {instance_create(496,246,oAbomFieldSegA); instance_create(776,262,oAbomFieldSegA)}
    else if seqTime=80 {instance_create(496,229,oAbomFieldSegA); instance_create(776,245,oAbomFieldSegA)}
    else if seqTime=100 {instance_create(496,212,oAbomFieldSegA); instance_create(776,228,oAbomFieldSegA)}
    /*else if seqTime=120
    {
      instance_create(496,195,oAbomFieldSegA); instance_create(776,211,oAbomFieldSegA)
      var tMyFArm;
      tMyFArm=instance_create(496,195,oAbomFieldArmA); tMyFArm.bSway=0
      tMyFArm=instance_create(776,211,oAbomFieldArmA); tMyFArm.bSway=0
    }*/
    else if seqTime>=130 and seqTime<=999 //-- Wait till weak spots are destroyed --
    {
      if seqTime>500 {seqTime=200}
      if !instance_exists(oDAbomHitSpotA) {seqTime=1000}
    }
    else if seqTime=1030
    {
      playSound(global.snd_Slam,0,1,1)
      playSound(global.snd_DemonVoice1,0,1,1)
      var tViewShake;
      tViewShake=instance_create(oPlayer1.x,oPlayer1.y,oVarViewShaker)
      tViewShake.turbulance=2; tViewShake.shakeTime=20
      with oDAbomInstrument {activeTime=1} //neat
      bkgPartSeq=3; bkgPartTime=0
      seqTime=0; sequence+=1
      //spsp ns PHASE TWO
      //spawn new troublemakers, make summons vulnerable
      //don't move on to next phase until summons are dead
      spinPhase+=1 //becomes 1
      InitialiseInstruments(9)
      with oDAbomSFinal {cancer=1}
      conAtkDelayA=175 //prev. 125
      
      //fix hard-coded coordinates :^(
      //orig armX1=496; armY1=195; armX2=776; armY2=211
      armX1=136; armY1=195; armX2=324; armY2=243
      instance_create(armX1,armY1,oAbomFieldSegA); instance_create(armX2,armY2,oAbomFieldSegA)
      var tMyFArm;
      tMyFArm=instance_create(armX1,armY1,oAbomFieldArmA); tMyFArm.bSway=0
      tMyFArm=instance_create(armX2,armY2,oAbomFieldArmA); tMyFArm.bSway=0

    }
  }
  else if sequence=12 //-------------------- Spawn second weak spots and rain from the top --------------------
  {
    //seqTime+=1
    seqTime+=1*gDeltaTime //60fps change: per frame
    if seqTime=35 and !instance_exists(oDAbomSFinal) //spsp ns
    {
      tWarnSign=instance_create(80,448,oEfWarningPopup); tWarnSign.warnMax=35
      tWarnSign.image_xscale=0.5; tWarnSign.image_yscale=0.5
      tWarnSign=instance_create(384,352,oEfWarningPopup); tWarnSign.warnMax=35
      tWarnSign.image_xscale=0.5; tWarnSign.image_yscale=0.5
      bContinuousAttackA=0; bContinuousAttackB=1; bMinionSpawn=0
      InitialiseInstruments(spinPhase)
    }
    else if seqTime=35 and instance_exists(oDAbomSFinal) //spsp ns
    {
      seqTime=5
    }
    else if seqTime=70
    {
      formWeakSpotX=80; formWeakSpotY=448; formWeakSpotDir=290; formWeakSpotHeartOffsetX=4; event_user(0)
      formWeakSpotX=384; formWeakSpotY=352; formWeakSpotDir=250; formWeakSpotHeartOffsetX=-4; event_user(0)
      //scanchange
      jeremyText="The new weak spots are immune to NORMAL type damage."
      chaoText="Brother is busy slowing the abomination down, and I have to try and keep the safety teleports active. I don't think we'll be able to give you guys too much help, sorry. But I know you can do it!"
    }
    else if seqTime>=75 and seqTime<=999 //-- Wait till weak spots are destroyed --
    {
      //reddening
      if backBlend>255-backStep
      {
        //backBlend-=1
        backBlend-=1*gDeltaTime //60fps change: per frame
        background_blend[0]=make_color_rgb(255,backBlend,backBlend)
      }
      if seqTime>500 {seqTime=200}
      if !instance_exists(oDAbomHitSpotA) {seqTime=1000}
    }
    else if seqTime=1030
    {
      playSound(global.snd_Slam,0,1,1)
      playSound(global.snd_DemonVoice1,0,1,1)
      spinPhase+=1 //becomes 2
      InitialiseInstruments(9)
      var tViewShake;
      tViewShake=instance_create(oPlayer1.x,oPlayer1.y,oVarViewShaker)
      tViewShake.turbulance=2; tViewShake.shakeTime=20
      with oDAbomInstrument {activeTime=1}
      bkgPartSeq=5; bkgPartTime=0
      seqTime=0; sequence+=1
    }
  }
  else if sequence=13 //-------------------- Spikes grow on Abomination and third weak spots --------------------
  {
    //seqTime+=1
    seqTime+=1*gDeltaTime //60fps change: per frame
    if seqTime=30
    {
      event_user(2)
      /*with oAbomFieldSegA
      {
        var tEffect,tScale;
        for(i=0;i<8;i+=1)
        {
          tScale=random(0.17)
          tEffect=instance_create(x+random_range(-16,16),y+random_range(-16,16),oEffect)
          tEffect.sprite_index=sAbom_Tentacle; tEffect.image_speed=0.33; tEffect.image_alpha=0.75
          tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=30+(i*2); tEffect.xSpd=random_range(-2,2); tEffect.ySpd=random_range(-2,2)
          tEffect.image_xscale=0.33+tScale; tEffect.image_yscale=0.33+tScale; tEffect.image_angle=random(360)
        }
        instance_destroy()
      }
      with oAbomFieldArmA
      {
        var tEffect,tScale;
        for(i=0;i<8;i+=1)
        {
          tScale=random(0.17)
          tEffect=instance_create(x+random_range(-16,16),y+random_range(-16,16),oEffect)
          tEffect.sprite_index=sAbom_Tentacle; tEffect.image_speed=0.33; tEffect.image_alpha=0.75
          tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=30+(i*2); tEffect.xSpd=random_range(-2,2); tEffect.ySpd=random_range(-2,2)
          tEffect.image_xscale=0.33+tScale; tEffect.image_yscale=0.33+tScale; tEffect.image_angle=random(360)
        }
        instance_destroy()
      }*/
      //spsp ns change text
      msgCreate(32,264,"Jeremy","Oh no, it's regurgiating some desert data. Watch your heat meter. I'll spawn some water blocks whenever I get the chance.",0,3,oMessagePerson,0); newMessage.fadingTime=120
      //make heat again
      heatTrack=instance_create(0,0,oDesertHeat)
    }
    else if false //seqTime=60
    {
      abLeftSpikeBodyB=instance_create(x-368,y+132,oAbomSpikeBody)
      abRightSpikeBodyB=instance_create(x+368,y+132,oAbomSpikeBody)
    }
    else if seqTime>=180 and seqTime<180+backStep
    {
      //reddening
      //backBlend-=1
      backBlend-=1*gDeltaTime //60fps change: per frame
      background_blend[0]=make_color_rgb(255,backBlend,backBlend)
    }
    else if seqTime=320
    {
      //spsp ns third weak spawn
      bContinuousAttackB=0; bContinuousAttackC=1
      //
      bContinuousAttackA=1
      conAtkTimeA=0
      conAtkDelayA=185
      conAtkTimeC=240
      conAtkDelayC=280
      //
      instance_create(256,136,oAbomFieldSegA)
      var tMyFArm;
      tMyFArm=instance_create(256,136,oAbomFieldArmA); tMyFArm.bSway=0
      InitialiseInstruments(spinPhase)
      /*
      tMyFArm=instance_create(480,480,oAbomFieldArmA); tMyFArm.bSway=0
      tMyFArm=instance_create(768,512,oAbomFieldArmA); tMyFArm.bSway=0
      */
      tWarnSign=instance_create(120,8,oEfWarningPopup); tWarnSign.warnMax=35
      tWarnSign.image_xscale=0.5; tWarnSign.image_yscale=0.5
      tWarnSign=instance_create(376,24,oEfWarningPopup); tWarnSign.warnMax=35
      tWarnSign.image_xscale=0.5; tWarnSign.image_yscale=0.5
    }
    else if seqTime=355
    {
      formWeakSpotX=120; formWeakSpotY=8; formWeakSpotDir=290; formWeakSpotHeartOffsetX=0; event_user(0)
      formWeakSpotX=376; formWeakSpotY=24; formWeakSpotDir=220; formWeakSpotHeartOffsetX=0; event_user(0)
      //scanchange
      jeremyText="Those are bomb shields, that's all you need to know."
      chaoText="Looks like those shields will regenerate quickly. Maybe it's good to wait for a quiet moment so you can immediately take advantage of the vulnerability window.#Oh, and these weak spots can be damaged by NORMAL type attacks again."
    }
    else if false //seqTime=345
    {
      tMyFArm=instance_create(512,352,oAbomFieldArmA); tMyFArm.bSway=0
      tMyFArm=instance_create(720,368,oAbomFieldArmA); tMyFArm.bSway=0
    }
    else if seqTime>=360 and seqTime<=999 //-- Wait till weak spots are destroyed --
    {
      if seqTime>500 {seqTime=400}
      if !instance_exists(oDAbomHitSpotA) {seqTime=1000}
    }
    else if seqTime=1030
    {
      playSound(global.snd_Slam,0,1,1)
      playSound(global.snd_DemonVoice1,0,1,1)
      event_user(2)
      var tViewShake;
      tViewShake=instance_create(oPlayer1.x,oPlayer1.y,oVarViewShaker)
      tViewShake.turbulance=2; tViewShake.shakeTime=20
      with oDAbomInstrument {activeTime=1}
      seqTime=0; sequence+=1
      InitialiseInstruments(9)
    }
  }
  else if sequence=14 //-------------------- Pieces fall off --------------------
  {
    //seqTime+=1
    seqTime+=1*gDeltaTime //60fps change: per frame
    if seqTime=1 {bContinuousAttackA=1; bContinuousAttackB=1}
    else if seqTime>=40 and seqTime<=429
    {
      var tTickA; tTickA=(frac(seqTime)=0) //60fps change (added): the trail once per 30fps tick, counted from seqTime
      with oAbomFieldArmA
      {
        var tEffect,tScale;
        if tTickA { //60fps change (added)
        tScale=random(0.17)
        tEffect=instance_create(x+random_range(-16,16),y+random_range(-16,16),oEffect)
        tEffect.sprite_index=sAbom_Tentacle; tEffect.image_speed=0.33; tEffect.image_alpha=0.75
        tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=21; tEffect.xSpd=random_range(-2,2); tEffect.ySpd=random_range(-2,0)
        tEffect.image_xscale=0.33+tScale; tEffect.image_yscale=0.33+tScale; tEffect.image_angle=random(360)
        } //60fps change (added)
        //y+=2
        y+=2*gDeltaTime //60fps change: per frame
      }
    }
    else if seqTime>=430
    {
      with oAbomFieldArmA {instance_destroy()}
      bContinuousAttackA=0; bContinuousAttackB=0; bContinuousAttackC=0; bContinuousAttackD=1
      seqTime=0; sequence+=1
    }
    
    if seqTime=70
    {
      //msgCreate(32,264,"Jeremy","It's trying to burrow, but I'm not letting it!",0,3,oMessagePerson,0); newMessage.fadingTime=100
      //remove heat here; also stop water block spawns
      //with oDesertHeat {instance_destroy()}
      msgCreate(32,264,"Jeremy","Some big moving thing is about to appear. I'll unlock your camera for that and prepare a spawn warning.",0,3,oMessagePerson,0); newMessage.fadingTime=100
    }
    else if seqTime=150
    {
      instance_create(104,-32,oDesertWaterVol)
      instance_create(360,-32,oDesertWaterVol)
    }
    else if seqTime>=210 and seqTime<210+backStep
    {
      //reddening
      //backBlend-=1
      backBlend-=1*gDeltaTime //60fps change: per frame
      background_blend[0]=make_color_rgb(255,backBlend,backBlend)
    }
    else if seqTime=380
    {
      //warning sign
      tWarnSign=instance_create(x,y-16,oEfWarningPopup); tWarnSign.warnMax=60
      tWarnSign.image_xscale=2; tWarnSign.image_yscale=2
    }
  }
  else if sequence=15 //-------------------- Parasite reveals itself --------------------
  {
    //seqTime+=1
    seqTime+=1*gDeltaTime //60fps change: per frame
    if seqTime=10
    {
      playSound(global.snd_Slam,0,1,1)
      playSound(global.snd_DemonVoice1,0,1,1)
      instrumentReq=8
      with oDAbomInstrument {activeTime=1}
      spinPhase+=1 //becomes 3 currently
      InitialiseInstruments(spinPhase)
      var tViewShake,tAbomParasite,tEffect,tScale;
      tViewShake=instance_create(oPlayer1.x,oPlayer1.y,oVarViewShaker)
      tViewShake.turbulance=2; tViewShake.shakeTime=20
      tAbomHead=instance_create(240,416,oAbomParasite)
      tAbomHead.depth=depth-1
      //scanchange
      jeremyText="No time, too busy keeping this thing away from the warship."
      chaoText="Hmm, for some reason the shots from above will explode when they come in contact with water. Maybe because my brother spawned it so it's recognised as an enemy?"
      /*for(i=0;i<32;i+=1)
      {
        tScale=random(0.17)
        tEffect=instance_create(x+random_range(-48,48),y+random_range(-48,48),oEffect)
        tEffect.sprite_index=sAbom_Tentacle; tEffect.image_speed=0.33; tEffect.image_alpha=0.75
        tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=30+i; tEffect.xSpd=random_range(-2,2); tEffect.ySpd=random_range(-2,2)
        tEffect.image_xscale=0.33+tScale; tEffect.image_yscale=0.33+tScale; tEffect.image_angle=random(360)
      }*/
    }
    else if seqTime=50
    {
      msgCreate(32,264,"Jeremy","There it is, that's the thing Hex put in the creature!",0,3,oMessagePerson,0); newMessage.fadingTime=110
    }
  }
  else if sequence=16 //-------------------- Parasite is defeated --------------------
  {
    //seqTime+=1
    seqTime+=1*gDeltaTime //60fps change: per frame
    if seqTime=1
    {
      //background halt
      background_vspeed[0]=0
      with oEProjectileBase {instance_destroy()}
      with oDesertHeat {instance_destroy()}
      InitialiseInstruments(9)
      bContinuousAttackD=0
      var tempMplay,tFlash;
      tempMplay=findMusic(0)
      playMusic(tempMplay,0,0)
      tFlash=instance_create(0,0,oScreenFlash); tFlash.fadeSpeed=0.1; tFlash.image_alpha=0.5
    }
    if seqTime>=1
    {
      if seqTime mod 18=0
      {
        var tFlash,tViewShake;
        tFlash=instance_create(0,0,oScreenFlash); tFlash.fadeSpeed=0.1; tFlash.image_alpha=0.1
        tViewShake=instance_create(oPlayer1.x,oPlayer1.y,oVarViewShaker)
        tViewShake.turbulance=2; tViewShake.shakeTime=10
        playSound(global.snd_Slam,0,1,1)
        playSound(global.snd_Static,0,1,1)
      }
    }
    
    if seqTime=180 //----- Abomination defeated -----
    {
      if global.bBossGallery=1
      {
        bossRoomTally(57)
        global.newMapX=968; global.newMapY=256; room_goto(rBossGallery)
      }
      else
      {
        var tEffect,tScale;
        for(i=0;i<350;i+=1)
        {
          tScale=random(0.5)
          tEffect=instance_create(random_range(240,992),random_range(80,592),oEffect)
          tEffect.sprite_index=sAbom_Tentacle; tEffect.image_speed=0.33
          tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=30; tEffect.xSpd=random_range(-2,2); tEffect.ySpd=random_range(-2,2)
          tEffect.image_xscale=1+tScale; tEffect.image_yscale=1+tScale; tEffect.image_angle=random(360)
        }
        instance_create(oAbomParasite.x,oAbomParasite.y,oAbomParaEscape)
        playSound(global.snd_FadeAway,0,1,1)
        playSound(global.snd_BombExplode,0,1,1)
        playSound(global.snd_EnemyDieZelda,0,1,1)
        //oEvAbom.instrumentProg=4
        /*with myCollisionLegLeft[0] {instance_destroy()}
        with myCollisionLegLeft[1] {instance_destroy()}
        with myCollisionLegRight[0] {instance_destroy()}
        with myCollisionLegRight[1] {instance_destroy()}
        with myColArmA {instance_destroy()}
        with myColArmB {instance_destroy()}
        with myColArmC {instance_destroy()}
        with myColArmD {instance_destroy()}
        with myColArmE {instance_destroy()}
        with myColArmF {instance_destroy()}
        with myColArmG {instance_destroy()}
        with myColArmH {instance_destroy()}
        with myColArmI {instance_destroy()}
        with myColArmJ {instance_destroy()}*/
        //background resume
        background_vspeed[0]=-1
        background_blend[0]=make_color_rgb(255,255,255)
        with oDAbomInstrument {instance_destroy()}
        with oDesertWaterVol {instance_destroy()}
        with oAbomInstrument {instance_destroy()}
        with oAbomSpikeBody {instance_destroy()}
        with oAbomLungeTentacle {instance_destroy()}
        with oBkgAbomSeg {instance_destroy()}
        with oAbomParasite {instance_destroy()}
        with oTempTrap {instance_destroy()}
        lungeATent=0; lungeBTent=0; lungeCTent=0; lungeDTent=0
        global.canPause=0 //spsp ns
        instance_create(0,0,oDEvAbom)
        with oChaoWarpImage {instance_destroy()}
        with oChaoWarpImageSub {instance_destroy()}
        instance_destroy()
      }
    }
  }
  
  //-------------------- Background segments --------------------
  if bkgPartSeq=1
  {
    //bkgPartTime+=1
    bkgPartTime+=1*gDeltaTime //60fps change: per frame
    if bkgPartTime=1 {bkgX=-20; bkgY=612; bkgPartNum=59} //{bkgX=312; bkgY=624; bkgPartNum=59}
    else if bkgPartTime=20
    {
      var tBackSeg;
      tBackSeg=instance_create(bkgX,bkgY,oBkgAbomSeg); tBackSeg.maxScale=0.5
      bkgX+=11; bkgY-=11
      bkgPartNum-=1
      if bkgPartNum>0 {bkgPartTime=10}
      else {bkgPartTime=30}
    }
    else if bkgPartTime=35 {bkgX=300; bkgY=258; bkgPartNum=26} //{bkgX=496; bkgY=288; bkgPartNum=26}
    else if bkgPartTime=50
    {
      var tBackSeg;
      tBackSeg=instance_create(bkgX,bkgY,oBkgAbomSeg); tBackSeg.maxScale=0.55
      bkgX-=12; bkgY+=7
      bkgPartNum-=1
      if bkgPartNum>0 {bkgPartTime=40}
      else {bkgPartTime=70}
    }
    else if bkgPartTime=75 {bkgX=-20; bkgY=368; bkgPartNum=68} //{bkgX=192; bkgY=128; bkgPartNum=68}
    else if bkgPartTime=90
    {
      var tBackSeg;
      tBackSeg=instance_create(bkgX,bkgY,oBkgAbomSeg); tBackSeg.maxScale=0.5
      bkgX+=13; bkgY+=3
      bkgPartNum-=1
      if bkgPartNum>0 {bkgPartTime=80}
      else {bkgPartTime=0; bkgPartSeq+=1}
    }
  }
  else if bkgPartSeq=3
  {
    //bkgPartTime+=1
    bkgPartTime+=1*gDeltaTime //60fps change: per frame
    if bkgPartTime=1 {bkgX=416; bkgY=718; bkgPartNum=35} //{bkgX=624; bkgY=400; bkgPartNum=35}
    else if bkgPartTime=20
    {
      var tBackSeg;
      tBackSeg=instance_create(bkgX,bkgY,oBkgAbomSeg); tBackSeg.maxScale=0.55
      bkgX-=9; bkgY-=12
      bkgPartNum-=1
      if bkgPartNum>0 {bkgPartTime=10}
      else {bkgPartTime=30}
    }
    else if bkgPartTime=35 {bkgX=-4; bkgY=368; bkgPartNum=40} //{bkgX=752; bkgY=336; bkgPartNum=25}
    else if bkgPartTime=50
    {
      var tBackSeg;
      tBackSeg=instance_create(bkgX,bkgY,oBkgAbomSeg); tBackSeg.maxScale=0.65
      bkgX+=13; bkgY+=8
      bkgPartNum-=1
      if bkgPartNum>0 {bkgPartTime=40}
      else {bkgPartTime=0; bkgPartSeq+=1}
    }
  }
  else if bkgPartSeq=5
  {
    //bkgPartTime+=1
    bkgPartTime+=1*gDeltaTime //60fps change: per frame
    if bkgPartTime=1 {bkgX=488; bkgY=470; bkgPartNum=43} //{bkgX=944; bkgY=624; bkgPartNum=43}
    else if bkgPartTime=20
    {
      var tBackSeg;
      tBackSeg=instance_create(bkgX,bkgY,oBkgAbomSeg); tBackSeg.maxScale=0.7
      bkgX-=9; bkgY-=15
      bkgPartNum-=1
      if bkgPartNum>0 {bkgPartTime=10}
      else {bkgPartTime=30}
    }
    else if bkgPartTime=35 {bkgX=-12; bkgY=200; bkgPartNum=65} //{bkgX=192; bkgY=448; bkgPartNum=65}
    else if bkgPartTime=50
    {
      var tBackSeg;
      tBackSeg=instance_create(bkgX,bkgY,oBkgAbomSeg); tBackSeg.maxScale=0.6
      bkgX+=14; bkgY-=5
      bkgPartNum-=1
      if bkgPartNum>0 {bkgPartTime=40}
      else {bkgPartTime=0; bkgPartSeq+=1}
    }
  }
  else if bkgPartSeq=7
  {
    //bkgPartTime+=1
    bkgPartTime+=1*gDeltaTime //60fps change: per frame
    if bkgPartTime=1 {bkgX=377; bkgY=710; bkgPartNum=45} //{bkgX=176; bkgY=304; bkgPartNum=45}
    else if bkgPartTime=20
    {
      var tBackSeg;
      tBackSeg=instance_create(bkgX,bkgY,oBkgAbomSeg); tBackSeg.maxScale=0.7
      bkgX-=9; bkgY-=15
      bkgPartNum-=1
      if bkgPartNum>0 {bkgPartTime=10}
      else {bkgPartTime=0; bkgPartSeq+=1}
    }
  }
  
  if bMinionSpawn=1 //Minion Spawn
  {
    //minionTime+=1
    minionTime+=1*gDeltaTime //60fps change: per frame
    if minionTime=minionDelay-10 {playSound(global.snd_DemonLaugh,0,1,1)}
    else if minionTime>=minionDelay
    {
      var duders;
      duders=instance_create(624,432,oDAbomSFinal); duders.ddd=0
      duders=instance_create(528,560,oDAbomSFinal); duders.ddd=1
      duders=instance_create(736,560,oDAbomSFinal); duders.ddd=2
      minionTime=0
      bMinionSpawn=0 //spsp ns
    }
  }
  
  if bContinuousAttackA=1 //Attack from bottom //spsp ns SIDE LARVAE
  {
    //conAtkTimeA+=1
    conAtkTimeA+=1*gDeltaTime //60fps change: per frame
    if conAtkTimeA>=conAtkDelayA
    {
      var tNewAtk;
      tNewAtk=instance_create(-16,returnPlayerYCenter(),oPassBullet) //here
      tNewAtk.sprite_index=sAbomProjectileA; tNewAtk.atkPower=12; tNewAtk.bulletSpeed=2.75; tNewAtk.depth=-1
      //tNewAtk.decayTime=-100; tNewAtk.image_xscale=2; tNewAtk.image_yscale=2; tNewAtk.direction=0
      tNewAtk.decayTime=-100; tNewAtk.image_xscale=2; tNewAtk.image_yscale=2; tNewAtk._direction=0 //60fps change: DT3+'s oPassBullet moves by its own _direction
      var tNewAtk2;
      tNewAtk2=instance_create(room_width+16,returnPlayerYCenter(),oPassBullet) //here
      tNewAtk2.sprite_index=sAbomProjectileA; tNewAtk2.atkPower=12; tNewAtk2.bulletSpeed=2.75; tNewAtk2.depth=-1
      //tNewAtk2.decayTime=-100; tNewAtk2.image_xscale=2; tNewAtk2.image_yscale=2; tNewAtk2.direction=180
      tNewAtk2.decayTime=-100; tNewAtk2.image_xscale=2; tNewAtk2.image_yscale=2; tNewAtk2._direction=180 //60fps change: DT3+'s oPassBullet moves by its own _direction
      conAtkTimeA=0
    }
  }
  
  if bContinuousAttackB=1 //Rain attack from top (First)
  {
    //conAtkTimeB+=1
    conAtkTimeB+=1*gDeltaTime //60fps change: per frame
    if conAtkTimeB=conAtkDelayB-1 {event_user(1)}
    //if conAtkTimeB>=conAtkDelayB and conAtkTimeB<=conAtkDelayB+60 //Rise up
    if conAtkTimeB>=conAtkDelayB and conAtkTimeB<=conAtkDelayB+60 and frac(conAtkTimeB)=0 //Rise up. 60fps change: one a 30fps tick, counted from conAtkTimeB
    {
      if conAtkTimeB mod 3=0 {playSound(global.snd_BombLaunch,0,0.75,75000)}
      var tRainUp;
      tRainUp=instance_create(x+random_range(-96,96),y+random_range(-8,8),oPassBullet)
      tRainUp.sprite_index=sAbomRainAtkA; tRainUp.atkPower=12; tRainUp.bulletSpeed=9; tRainUp.depth=30; tRainUp.image_speed=0.33; tRainUp.image_blend=c_gray
      //tRainUp.decayTime=-100; tRainUp.image_xscale=0.5; tRainUp.image_yscale=0.5; tRainUp.direction=90+random_range(-7,7); tRainUp.bCanDealDamage=0
      tRainUp.decayTime=-100; tRainUp.image_xscale=0.5; tRainUp.image_yscale=0.5; tRainUp._direction=90+random_range(-7,7); tRainUp.bCanDealDamage=0 //60fps change: DT3+'s oPassBullet moves by its own _direction
    }
    else if conAtkTimeB>=conAtkDelayB+90 //Rain down from top
    {
      var tRainDown,tXDrop;
      if conAtkTimeB mod 6=0
      {
        if conAtkTimeB mod 24=0 {tXDrop=oPlayer1.x}
        else {tXDrop=rainAtkX[rainAInc]+rainOffset}
        
        //spsp ns extra side covers
        tRainDown=instance_create(12+(conAtkTimeB mod 24),0,oPassBullet)
        tRainDown.sprite_index=sAbomRainAtkA; tRainDown.atkPower=12; tRainDown.bulletSpeed=4; tRainDown.image_speed=0.33
        //tRainDown.decayTime=-100; tRainDown.direction=270
        tRainDown.decayTime=-100; tRainDown._direction=270 //60fps change: DT3+'s oPassBullet moves by its own _direction
        tRainDown=instance_create(440+(conAtkTimeB mod 24),0,oPassBullet)
        tRainDown.sprite_index=sAbomRainAtkA; tRainDown.atkPower=12; tRainDown.bulletSpeed=4; tRainDown.image_speed=0.33
        //tRainDown.decayTime=-100; tRainDown.direction=270
        tRainDown.decayTime=-100; tRainDown._direction=270 //60fps change: DT3+'s oPassBullet moves by its own _direction
        
        tRainDown=instance_create(tXDrop,0,oPassBullet)
        tRainDown.sprite_index=sAbomRainAtkA; tRainDown.atkPower=12; tRainDown.bulletSpeed=4; tRainDown.image_speed=0.33
        //tRainDown.decayTime=-100; tRainDown.direction=270
        tRainDown.decayTime=-100; tRainDown._direction=270 //60fps change: DT3+'s oPassBullet moves by its own _direction
        if true      //spsp
        {
            //tRainDown.direction=tRainDown.direction*8/10+point_direction(tRainDown.x,0,oPlayer1.x,returnPlayerYCenter())*2/10
            tRainDown._direction=tRainDown._direction*8/10+point_direction(tRainDown.x,0,oPlayer1.x,returnPlayerYCenter())*2/10 //60fps change: DT3+'s oPassBullet moves by its own _direction
        }
        rainAInc+=1
        if rainAInc=10 {rainOffset+=32; rainAInc=0}
      }
    }
    
    if conAtkTimeB>=conAtkDelayB+180 //End attack
    {
      rainOffset=0
      conAtkTimeB=0
      //conAtkDelayB=210 //spsp ns
    }
  }
  if bContinuousAttackC=1 //Rain attack from top (Second) [Diagonal]
  {
    //conAtkTimeC+=1
    conAtkTimeC+=1*gDeltaTime //60fps change: per frame
    if conAtkTimeC=conAtkDelayC-1 {event_user(1)}
    //if conAtkTimeC>=conAtkDelayC and conAtkTimeC<=conAtkDelayC+60 //Rise up
    if conAtkTimeC>=conAtkDelayC and conAtkTimeC<=conAtkDelayC+60 and frac(conAtkTimeC)=0 //Rise up. 60fps change: one a 30fps tick, counted from conAtkTimeC
    {
      if conAtkTimeC mod 3=0 {playSound(global.snd_BombLaunch,0,0.75,75000)}
      var tRainUp;
      tRainUp=instance_create(x+random_range(-96,96),y+random_range(-8,8),oPassBullet)
      tRainUp.sprite_index=sAbomRainAtkA; tRainUp.atkPower=12; tRainUp.bulletSpeed=9; tRainUp.depth=30; tRainUp.image_speed=0.33; tRainUp.image_blend=c_gray
      //tRainUp.decayTime=-100; tRainUp.image_xscale=0.5; tRainUp.image_yscale=0.5; tRainUp.direction=90+random_range(-45,45); tRainUp.bCanDealDamage=0
      tRainUp.decayTime=-100; tRainUp.image_xscale=0.5; tRainUp.image_yscale=0.5; tRainUp._direction=90+random_range(-45,45); tRainUp.bCanDealDamage=0 //60fps change: DT3+'s oPassBullet moves by its own _direction
    }
    else if conAtkTimeC>=conAtkDelayC+90 //Rain down
    {
      var tRainDown;
      if conAtkTimeC mod 5=0
      {
        tRainDown=instance_create(rainAtkX[rainAInc],0,oPassBullet)
        tRainDown.sprite_index=sAbomRainAtkA; tRainDown.atkPower=12; tRainDown.bulletSpeed=4; tRainDown.image_speed=0.33; tRainDown.decayTime=-100
        //if conAtkTimeC mod 2=0 {tRainDown.direction=310}
        if conAtkTimeC mod 2=0 {tRainDown._direction=310} //60fps change: DT3+'s oPassBullet moves by its own _direction
        //else {tRainDown.direction=230}
        else {tRainDown._direction=230} //60fps change: DT3+'s oPassBullet moves by its own _direction
        if true      //spsp
        {
            //tRainDown.direction=tRainDown.direction*7/10+point_direction(tRainDown.x,0,oPlayer1.x,returnPlayerYCenter())*3/10
            tRainDown._direction=tRainDown._direction*7/10+point_direction(tRainDown.x,0,oPlayer1.x,returnPlayerYCenter())*3/10 //60fps change: DT3+'s oPassBullet moves by its own _direction
        }
        rainAInc+=1
        if rainAInc=10 {rainOffset+=32; rainAInc=0}
      }
    }
    
    if conAtkTimeC>=conAtkDelayC+180 //End attack
    {
      rainOffset=0
      conAtkTimeC=0
    }
  }
  if bContinuousAttackD=1 //Rain attack from top (Third) [Explode]
  {
    //conAtkTimeD+=1
    conAtkTimeD+=1*gDeltaTime //60fps change: per frame
    if conAtkTimeD=1 {event_user(1)}
    
    if conAtkTimeD mod 5=0
    {
      var tRainUp;
      tRainUp=instance_create(x+random_range(-96,96),y+random_range(-8,8),oPassBullet)
      tRainUp.sprite_index=sAbomRainAtkA; tRainUp.atkPower=12; tRainUp.bulletSpeed=9; tRainUp.depth=30; tRainUp.image_speed=0.33; tRainUp.image_blend=c_gray
      //tRainUp.decayTime=-100; tRainUp.image_xscale=0.5; tRainUp.image_yscale=0.5; tRainUp.direction=90+random_range(-45,45); tRainUp.bCanDealDamage=0
      tRainUp.decayTime=-100; tRainUp.image_xscale=0.5; tRainUp.image_yscale=0.5; tRainUp._direction=90+random_range(-45,45); tRainUp.bCanDealDamage=0 //60fps change: DT3+'s oPassBullet moves by its own _direction
    }
    
    if conAtkTimeD>=conAtkDelayD-30 and conAtkTimeD<conAtkDelayD //spsp ns warning sound
    {
      if conAtkTimeD mod 3=0 {playSound(global.snd_BombLaunch,0,0.75,75000)}
    }
    
    if conAtkTimeD>=conAtkDelayD and conAtkTimeD<=conAtkDelayD+60 //Attack
    {
      var tRainDown,tXDrop;
      if conAtkTimeD mod 25=0 {tXDrop=oPlayer1.x; babytrack=1} //orig mod 24
      else {tXDrop=rainAtkX[rainAInc]+rainOffset; babytrack=0}
      if conAtkTimeD mod 5=0
      {
        tRainDown=instance_create(tXDrop,0,oGravBulletAlt)
        tRainDown.atkPower=12; tRainDown.sprite_index=sAbomRainAtkA; tRainDown.damageType="EXPLOSION"; tRainDown.image_speed=0.33
        tRainDown.bExplode=1; tRainDown.yVel=babyVel; tRainDown.xGrav=0; tRainDown.yGrav=babyGrav
        tRainDown.weakTrack=babytrack //spsp ns
        if conAtkTimeD mod 2=0 {tRainDown.xVel=0.5}
        else {tRainDown.xVel=-0.5}
        
        rainAInc+=1
        if rainAInc=10 {rainOffset+=32; rainAInc=0}
      }
    }
    else if conAtkTimeD>=conAtkDelayD+70 //End Attack
    {
      var tXDrop;
      tXDrop=16 //288
      for(i=0;i<11;i+=1)
      {
        tRainDown=instance_create(tXDrop,0,oGravBulletAlt)
        tRainDown.atkPower=12; tRainDown.sprite_index=sAbomRainAtkA; tRainDown.damageType="EXPLOSION"; tRainDown.image_speed=0.33
        tRainDown.bExplode=1; tRainDown.yVel=babyVel; tRainDown.xGrav=0; tRainDown.yGrav=babyGrav
        if i mod 2=0 {tRainDown.xVel=0.5+(i/20)}
        else {tRainDown.xVel=-0.5+(i/20)}
        tXDrop+=64 //44
      }
      conAtkTimeD=0
    }
  }
}
