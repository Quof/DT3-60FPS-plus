#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//global.gateHProg=100; global.eGateProg="99999999"
viscidTop=1
makeActive()
image_xscale=2; image_yscale=2
bBattleStart=0

sequence=0
seqTime=0
damageTaken=0
backBlend=255

dialogueSeq=0
dialogueTime=0

//Hit spot HP counts
myHitCounter=0
myHitSpotHP[0]=3000
myHitSpotHP[1]=2500
myHitSpotHP[2]=3100
myHitSpotHP[3]=2800
myHitSpotHP[4]=2500
myHitSpotHP[5]=1600

//Spawn minions
bMinionSpawn=0
minionTime=550
minionDelay=580

//Attack from bottom
bContinuousAttackA=0
conAtkTimeA=0
conAtkDelayA=125
//Rain attack from top (First)
bContinuousAttackB=0
conAtkTimeB=240
conAtkDelayB=300
rainAInc=0
rainOffset=0
//Rain attack from top (Second) [Diagonal]
bContinuousAttackC=0
conAtkTimeC=280
conAtkDelayC=320
//Rain attack from top (Third) [Explode]
bContinuousAttackD=0
conAtkTimeD=0
conAtkDelayD=190
//Lunge tentacles
lungeATent=0
lungeAPullCurr=0
lungeAPullMax=32
lungeBTent=0
lungeBPullCurr=0
lungeBPullMax=32
lungeCTent=0
lungeCPullCurr=0
lungeCPullMax=32
lungeDTent=0
lungeDPullCurr=0
lungeDPullMax=32

spikeScale=0

bkgPartSeq=0
bkgPartTime=0
bkgPartNum=0
bkgX=0
bkgY=0

//Hidden ending stuff
leftWeakTimer=0
rightWeakTimer=0
hitHiddenWeakNum=0
hiddenEndFail=0
pullInSequence=0
hiddenTentacles=0

formWeakSpotX=0; formWeakSpotY=0; formWeakSpotDir=0; formWeakSpotHeartOffsetX=0
if global.gateHProg<200 or global.bBossGallery=1 or room=rCh21_Main_76
{
  //---------- If player goes into this map before conversation in previous map is complete ----------
  var tNewString;
  tNewString=string_delete(global.extraFlags,4,1)
  tNewString=string_insert("1",tNewString,4)
  global.extraFlags=tNewString
  //--------------------------------------------------------------------------------------------------
  instance_create(0,0,oEvAbom)
}
else
{
  instance_destroy()
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if sequence=0 //-------------------- Fade in / start music --------------------
  {
    if dialogueSeq=0
    {
      if oPlayer1.x>=248
      {
        if global.gateHProg=101 or global.bBossGallery=1 or room=rCh21_Main_76 {dialogueTime=1000}
        dialogueSeq+=1
      }
    }
    else if dialogueSeq=1
    {
      dialogueTime+=1
      if dialogueTime=1 {
        msgCreate(0,0,"Jeremy","There it is!",0,3,oMessagePerson,0); newMessage.fadingTime=60
      }
      else if dialogueTime=60 {
        msgCreate(0,0,"Jerry","It's not doing anything.",0,3,oMessagePerson,0); newMessage.fadingTime=70
      }
      else if dialogueTime=130 {
        msgCreate(0,0,"Jeremy","It'll probably remain dormant until someone bothers it.",0,3,oMessagePerson,0); newMessage.fadingTime=90
      }
      else if dialogueTime=220 {
        msgCreate(0,0,"Jerry","Sooo we probably shouldn't be here? Didn't you say that we weren't actually damaging it in the Vault?",0,3,oMessagePerson,0); newMessage.fadingTime=140
      }
      else if dialogueTime=360 {
        msgCreate(0,0,"Jeremy","Yeah, let's go ahead and leave it. I don't think it's a good idea to wake this thing up.",0,3,oMessagePerson,0); newMessage.fadingTime=130
      }
    }

    if bBattleStart=1
    {
      bkgPartSeq=1
      playSound(global.snd_DemonVoice1,0,1,1)
      var tempMplay;
      tempMplay=findMusic(822)
      playMusic(tempMplay,0,0)
      oEvAbom.spawnWalls=1
      abLeftSpikeBodyA=instance_create(x-80,y,oAbomSpikeBody); abLeftSpikeBodyA.image_angle=45
      abRightSpikeBodyA=instance_create(x+80,y,oAbomSpikeBody); abRightSpikeBodyA.image_angle=315
      for(i=0;i<4;i+=1)
      {
        bossBarrierL[i]=instance_create(168,164-(i*16),oAbomSideBarriers); bossBarrierL[i].waveOffset=i*0.41
        bossBarrierR[i]=instance_create(1080,164-(i*16),oAbomSideBarriers); bossBarrierR[i].waveOffset=i*0.41
      }

      if global.gateHProg<100 //Player does not have all 8 instruments
      {
        with oMessagePerson {instance_destroy()}
        msgCreate(0,0,"Jeremy","Yes you guys, just piss off the big invincible creature! That wasn't the smartest of ideas.",0,2,oMessagePerson,0); newMessage.fadingTime=130
      }
      sequence+=1
    }
  }
  else if sequence=1 //-------------------- Turn background red --------------------
  {
    seqTime+=1
    if room=rMain_76 and global.abomAttempts>0 //Player has lost at least once
    {
      seqTime=0
      sequence=10
    }
    else
    {
      if seqTime<=64
      {
        for(i=0;i<4;i+=1)
        {
          bossBarrierL[i].y-=0.25+(i*0.5)
          bossBarrierR[i].y-=0.25+(i*0.5)
        }
      }
      backBlend-=1
      oBackgroundFollow.image_blend=make_color_rgb(255,backBlend,backBlend)
      if backBlend<=125
      {
        seqTime=0
        if global.gateHProg=101 or global.bBossGallery=1 or room=rCh21_Main_76 //-- Instrument check --
        {
          sequence=10
        }
        else
        {
          sequence+=1
        }
      }
    }
  }
  else if sequence=2 //-------------------- Player does not have the instruments (Unbeatable sequence) --------------------
  {
    seqTime+=1
    if seqTime=1 {bContinuousAttackA=1}
    else if seqTime=20 {instance_create(504,264,oAbomFieldSegA); instance_create(760,280,oAbomFieldSegA)}
    else if seqTime=40 {instance_create(504,244,oAbomFieldSegA); instance_create(760,260,oAbomFieldSegA)}
    else if seqTime=60 {instance_create(504,224,oAbomFieldSegA); instance_create(760,240,oAbomFieldSegA)}
    else if seqTime=80
    {
      instance_create(504,204,oAbomFieldSegA); instance_create(760,220,oAbomFieldSegA)
      var tMyFArm;
      tMyFArm=instance_create(504,204,oAbomFieldArmA); tMyFArm.bSway=1
      tMyFArm=instance_create(760,220,oAbomFieldArmA); tMyFArm.bSway=1
    }

    if seqTime=90
    {
      var tMyFArm;
      tMyFArm=instance_create(bossBarrierL[0].x,bossBarrierL[0].y,oAbomFieldArmA); tMyFArm.bSway=1
      tMyFArm=instance_create(bossBarrierR[0].x,bossBarrierR[0].y,oAbomFieldArmA); tMyFArm.bSway=1
    }
    else if seqTime=120
    {
      var tMyFArm;
      tMyFArm=instance_create(bossBarrierL[1].x,bossBarrierL[1].y,oAbomFieldArmA); tMyFArm.bSway=1
      tMyFArm=instance_create(bossBarrierR[1].x,bossBarrierR[1].y,oAbomFieldArmA); tMyFArm.bSway=1
    }
    else if seqTime=150
    {
      var tMyFArm;
      tMyFArm=instance_create(bossBarrierL[2].x,bossBarrierL[2].y,oAbomFieldArmA); tMyFArm.bSway=1
      tMyFArm=instance_create(bossBarrierR[2].x,bossBarrierR[2].y,oAbomFieldArmA); tMyFArm.bSway=1
    }
    else if seqTime=180
    {
      var tMyFArm;
      tMyFArm=instance_create(bossBarrierL[3].x,bossBarrierL[3].y,oAbomFieldArmA); tMyFArm.bSway=1
      tMyFArm=instance_create(bossBarrierR[3].x,bossBarrierR[3].y,oAbomFieldArmA); tMyFArm.bSway=1
    }

    if seqTime=30
    {
      var tMyFArm;
      tMyFArm=instance_create(x-160,624,oAbomFieldArmA); tMyFArm.bSway=0
      tMyFArm=instance_create(x+160,624,oAbomFieldArmA); tMyFArm.bSway=0
    }
    else if seqTime=50
    {
      var tMyFArm;
      tMyFArm=instance_create(x-128,624,oAbomFieldArmA); tMyFArm.bSway=0
      tMyFArm=instance_create(x+128,624,oAbomFieldArmA); tMyFArm.bSway=0
    }
    else if seqTime=70
    {
      var tMyFArm;
      tMyFArm=instance_create(x-96,624,oAbomFieldArmA); tMyFArm.bSway=0
      tMyFArm=instance_create(x+96,624,oAbomFieldArmA); tMyFArm.bSway=0
    }
    else if seqTime=90
    {
      var tMyFArm;
      tMyFArm=instance_create(x-64,624,oAbomFieldArmA); tMyFArm.bSway=0
      tMyFArm=instance_create(x+64,624,oAbomFieldArmA); tMyFArm.bSway=0
    }
    else if seqTime=110
    {
      var tMyFArm;
      tMyFArm=instance_create(x-32,624,oAbomFieldArmA); tMyFArm.bSway=0
      tMyFArm=instance_create(x+32,624,oAbomFieldArmA); tMyFArm.bSway=0
    }
    else if seqTime=130
    {
      var tMyFArm;
      tMyFArm=instance_create(x,624,oAbomFieldArmA); tMyFArm.bSway=0
    }
  }
  else if sequence=10 //-------------------- Player has all instruments (Start instrument song) --------------------
  {
    seqTime+=1
    if seqTime=25
    {
      oEvAbom.instrumentProg=1
      if room=rMain_76 and global.abomAttempts>0 //Skip opening 10 seconds if player has attempted Abomination at least once
      {
        if global.abomAttempts=1
        {
          msgCreate(0,0,"Jeremy","Gonna skip that first bit for you. Imagine having to redo that first 16 seconds of nothing every time you lose... Oof.",0,3,oMessagePerson,0); newMessage.fadingTime=180
        }

        for(i=0;i<4;i+=1)
        {
          bossBarrierL[i].y-=(0.25+(i*0.5))*64
          bossBarrierR[i].y-=(0.25+(i*0.5))*64
        }
        oBackgroundFollow.image_blend=make_color_rgb(255,125,125)

        var tempMplay;
        tempMplay=findMusic(0)
        playMusic(tempMplay,0,0)
        var tempMplay;
        tempMplay=findMusic(1019)
        playMusic(tempMplay,0,0)
        formWeakSpotX=400; formWeakSpotY=608; formWeakSpotDir=15; formWeakSpotHeartOffsetX=-8; event_user(0)
        formWeakSpotX=848; formWeakSpotY=608; formWeakSpotDir=165; formWeakSpotHeartOffsetX=40; event_user(0)
        seqTime=0; sequence+=1
      }
    }
    else if seqTime=100
    {
      var tempMplay;
      tempMplay=findMusic(0)
      playMusic(tempMplay,0,0)
    }
    else if seqTime=160
    {
      var tempMplay;
      tempMplay=findMusic(1019)
      playMusic(tempMplay,0,0)
    }
    else if seqTime=220
    {
      if room=rCh21_Main_76
      {
        msgCreate(0,0,"Jeremy","Remember, quickly plant a morph bomb in the places shown by the instruments.",0,3,oMessagePerson,0); newMessage.fadingTime=130
      }
      else
      {
        msgCreate(0,0,"Jeremy","It's working! I'm not sure how, but it's working. It has weak spots forming!",0,3,oMessagePerson,0); newMessage.fadingTime=120
      }
    }
    else if seqTime=300
    {
      formWeakSpotX=400; formWeakSpotY=608; formWeakSpotDir=15; formWeakSpotHeartOffsetX=-8; event_user(0)
      formWeakSpotX=848; formWeakSpotY=608; formWeakSpotDir=165; formWeakSpotHeartOffsetX=40; event_user(0)
      seqTime=0; sequence+=1
    }
  }
  else if sequence=11 //-------------------- Spawn first arms --------------------
  {
    seqTime+=1
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
    else if seqTime=120
    {
      instance_create(496,195,oAbomFieldSegA); instance_create(776,211,oAbomFieldSegA)
      var tMyFArm;
      tMyFArm=instance_create(496,195,oAbomFieldArmA); tMyFArm.bSway=0
      tMyFArm=instance_create(776,211,oAbomFieldArmA); tMyFArm.bSway=0
    }
    else if seqTime>=130 and seqTime<=999 //-- Wait till weak spots are destroyed --
    {
      if seqTime>500 {seqTime=200}
      if !instance_exists(oAbomHitSpotA) {seqTime=1000}
    }
    else if seqTime=1030
    {
      with oAbomHiddenWeaknesses {instance_destroy()}
      playSound(global.snd_Slam,0,1,1)
      playSound(global.snd_DemonVoice1,0,1,1)
      instance_create(192,368,oZeldaBreakPot); instance_create(208,368,oZeldaBreakPot)
      instance_create(1024,368,oZeldaBreakPot); instance_create(1040,368,oZeldaBreakPot)
      var tViewShake;
      tViewShake=instance_create(oPlayer1.x,oPlayer1.y,oVarViewShaker)
      tViewShake.turbulance=2; tViewShake.shakeTime=20
      with oAbomInstrument {activeTime=1}
      bkgPartSeq=3; bkgPartTime=0
      seqTime=0; sequence+=1
    }
  }
  else if sequence=12 //-------------------- Spawn second weak spots and rain from the top --------------------
  {
    seqTime+=1
    if seqTime=35
    {
      formWeakSpotX=528; formWeakSpotY=400; formWeakSpotDir=290; formWeakSpotHeartOffsetX=4; event_user(0)
      formWeakSpotX=720; formWeakSpotY=400; formWeakSpotDir=250; formWeakSpotHeartOffsetX=-4; event_user(0)
      bContinuousAttackA=0; bContinuousAttackB=1; bMinionSpawn=0
      if room=rCh21_Main_76
      {
        msgCreate(0,0,"Jeremy","Guys! What the hell are you doing?! This is not the way!",0,3,oMessagePerson,0); newMessage.fadingTime=130
        hiddenEndFail=1
      }
    }
    else if seqTime>=40 and seqTime<=999 //-- Wait till weak spots are destroyed --
    {
      if seqTime>500 {seqTime=200}
      if !instance_exists(oAbomHitSpotA) {seqTime=1000}
    }
    else if seqTime=1030
    {
      playSound(global.snd_Slam,0,1,1)
      playSound(global.snd_DemonVoice1,0,1,1)
      instance_create(192,288,oZeldaBreakPot); instance_create(208,288,oZeldaBreakPot)
      instance_create(1024,288,oZeldaBreakPot); instance_create(1040,288,oZeldaBreakPot)
      var tViewShake;
      tViewShake=instance_create(oPlayer1.x,oPlayer1.y,oVarViewShaker)
      tViewShake.turbulance=2; tViewShake.shakeTime=20
      with oAbomInstrument {activeTime=1}
      bkgPartSeq=5; bkgPartTime=0
      seqTime=0; sequence+=1
    }
  }
  else if sequence=13 //-------------------- Spikes grow on Abomination and third weak spots --------------------
  {
    seqTime+=1
    if seqTime=30
    {
      with oAbomFieldSegA
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
      }
      msgCreate(32,264,"Jeremy","Get off that thing you guys! Quickly!",0,3,oMessagePerson,0); newMessage.fadingTime=120
    }
    else if seqTime=60
    {
      abLeftSpikeBodyB=instance_create(x-368,y+132,oAbomSpikeBody)
      abRightSpikeBodyB=instance_create(x+368,y+132,oAbomSpikeBody)
    }
    else if seqTime=180
    {
      for(i=0;i<3;i+=1)
      {
        myDmgBox[i]=instance_create(x-28+(i*28),y,oTempTrap)
        myDmgBox[i].sprite_index=sprite_index; myDmgBox[i].visible=0; myDmgBox[i].atkPower=12
        myDmgBox[i].image_xscale=2.05; myDmgBox[i].image_yscale=2.05
      }
      spikeScale=0.1
    }
    else if seqTime=260
    {
      myCollisionLegLeft[0]=instance_create(512,288,oInvisibleSolid); myCollisionLegLeft[0].sprite_index=sAbomLegThing; myCollisionLegLeft[0].visible=1
      myCollisionLegLeft[0].image_angle=120; myCollisionLegLeft[0].image_xscale=0; myCollisionLegLeft[0].image_yscale=0
      myCollisionLegRight[0]=instance_create(752,288,oInvisibleSolid); myCollisionLegRight[0].sprite_index=sAbomLegThing; myCollisionLegRight[0].visible=1
      myCollisionLegRight[0].image_angle=60; myCollisionLegRight[0].image_xscale=0; myCollisionLegRight[0].image_yscale=0
    }
    else if seqTime>=261 and seqTime<=280
    {
      myCollisionLegLeft[0].image_xscale+=0.05; myCollisionLegLeft[0].image_yscale+=0.05
      myCollisionLegRight[0].image_xscale+=0.05; myCollisionLegRight[0].image_yscale+=0.05
    }
    else if seqTime=290
    {
      myCollisionLegLeft[1]=instance_create(479,242,oInvisibleSolid); myCollisionLegLeft[1].sprite_index=sAbomLegThing; myCollisionLegLeft[1].visible=1
      myCollisionLegLeft[1].image_angle=30; myCollisionLegLeft[1].image_xscale=0; myCollisionLegLeft[1].image_yscale=0
      myCollisionLegRight[1]=instance_create(777,236,oInvisibleSolid); myCollisionLegRight[1].sprite_index=sAbomLegThing; myCollisionLegRight[1].visible=1
      myCollisionLegRight[1].image_angle=140; myCollisionLegRight[1].image_xscale=0; myCollisionLegRight[1].image_yscale=0
    }
    else if seqTime>=291 and seqTime<=310
    {
      myCollisionLegLeft[1].image_xscale+=0.05; myCollisionLegLeft[1].image_yscale+=0.05
      myCollisionLegRight[1].image_xscale+=0.05; myCollisionLegRight[1].image_yscale+=0.05
    }
    else if seqTime=320
    {
      bContinuousAttackB=0; bContinuousAttackC=1
      var tMyFArm;
      tMyFArm=instance_create(480,480,oAbomFieldArmA); tMyFArm.bSway=0
      tMyFArm=instance_create(768,512,oAbomFieldArmA); tMyFArm.bSway=0
      formWeakSpotX=464; formWeakSpotY=352; formWeakSpotDir=290; formWeakSpotHeartOffsetX=0; event_user(0)
      formWeakSpotX=848; formWeakSpotY=412; formWeakSpotDir=220; formWeakSpotHeartOffsetX=0; event_user(0)
    }
    else if seqTime=345
    {
      tMyFArm=instance_create(512,352,oAbomFieldArmA); tMyFArm.bSway=0
      tMyFArm=instance_create(720,368,oAbomFieldArmA); tMyFArm.bSway=0
    }
    else if seqTime>=350 and seqTime<=999 //-- Wait till weak spots are destroyed --
    {
      if seqTime>500 {seqTime=400}
      if !instance_exists(oAbomHitSpotA) {seqTime=1000}
    }
    else if seqTime=1030
    {
      playSound(global.snd_Slam,0,1,1)
      playSound(global.snd_DemonVoice1,0,1,1)
      var tViewShake;
      tViewShake=instance_create(oPlayer1.x,oPlayer1.y,oVarViewShaker)
      tViewShake.turbulance=2; tViewShake.shakeTime=20
      instance_create(192,208,oZeldaBreakPot); instance_create(208,208,oZeldaBreakPot)
      instance_create(1024,208,oZeldaBreakPot); instance_create(1040,208,oZeldaBreakPot)
      with oAbomInstrument {activeTime=1}
      seqTime=0; sequence+=1
    }
  }
  else if sequence=14 //-------------------- Pieces fall off --------------------
  {
    seqTime+=1
    if seqTime=1 {bContinuousAttackA=1; bContinuousAttackB=1}
    else if seqTime>=40 and seqTime<=429
    {
      with oAbomFieldArmA
      {
        var tEffect,tScale;
        tScale=random(0.17)
        tEffect=instance_create(x+random_range(-16,16),y+random_range(-16,16),oEffect)
        tEffect.sprite_index=sAbom_Tentacle; tEffect.image_speed=0.33; tEffect.image_alpha=0.75
        tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=21; tEffect.xSpd=random_range(-2,2); tEffect.ySpd=random_range(-2,0)
        tEffect.image_xscale=0.33+tScale; tEffect.image_yscale=0.33+tScale; tEffect.image_angle=random(360)
        y+=2
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
      msgCreate(32,264,"Jeremy","It's trying to burrow, but I'm not letting it!",0,3,oMessagePerson,0); newMessage.fadingTime=100
    }
  }
  else if sequence=15 //-------------------- Parasite reveals itself --------------------
  {
    seqTime+=1
    if seqTime=10
    {
      playSound(global.snd_Slam,0,1,1)
      playSound(global.snd_DemonVoice1,0,1,1)
      oEvAbom.instrumentReq=8
      with oAbomInstrument {activeTime=1}
      var tViewShake,tAbomParasite,tEffect,tScale;
      tViewShake=instance_create(oPlayer1.x,oPlayer1.y,oVarViewShaker)
      tViewShake.turbulance=2; tViewShake.shakeTime=20
      tAbomHead=instance_create(632,352,oAbomParasite)
      for(i=0;i<32;i+=1)
      {
        tScale=random(0.17)
        tEffect=instance_create(x+random_range(-48,48),y+random_range(-48,48),oEffect)
        tEffect.sprite_index=sAbom_Tentacle; tEffect.image_speed=0.33; tEffect.image_alpha=0.75
        tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=30+i; tEffect.xSpd=random_range(-2,2); tEffect.ySpd=random_range(-2,2)
        tEffect.image_xscale=0.33+tScale; tEffect.image_yscale=0.33+tScale; tEffect.image_angle=random(360)
      }
    }
    else if seqTime=50
    {
      msgCreate(32,264,"Jeremy","There it is, that's the thing Hex put in the creature!",0,3,oMessagePerson,0); newMessage.fadingTime=110
    }
    else if seqTime=80 //Wait until player is high enough
    {
      if oPlayer1.y<=288
      {
        myColArmA=instance_create(192,320,oInvisibleSolid); myColArmA.sprite_index=sAbomLegThing; myColArmA.visible=1; myColArmA.image_angle=10
        myColArmB=instance_create(256,312,oInvisibleSolid); myColArmB.sprite_index=sAbomLegThing; myColArmB.visible=1; myColArmB.image_angle=0
        myColArmC=instance_create(320,320,oInvisibleSolid); myColArmC.sprite_index=sAbomLegThing; myColArmC.visible=1; myColArmC.image_angle=350
        myColArmD=instance_create(384,312,oInvisibleSolid); myColArmD.sprite_index=sAbomLegThing; myColArmD.visible=1; myColArmD.image_angle=10
        myColArmE=instance_create(448,320,oInvisibleSolid); myColArmE.sprite_index=sAbomLegThing; myColArmE.visible=1; myColArmE.image_angle=0

        myColArmF=instance_create(752,312,oInvisibleSolid); myColArmF.sprite_index=sAbomLegThing; myColArmF.visible=1; myColArmF.image_angle=10
        myColArmG=instance_create(816,320,oInvisibleSolid); myColArmG.sprite_index=sAbomLegThing; myColArmG.visible=1; myColArmG.image_angle=0
        myColArmH=instance_create(880,312,oInvisibleSolid); myColArmH.sprite_index=sAbomLegThing; myColArmH.visible=1; myColArmH.image_angle=350
        myColArmI=instance_create(944,320,oInvisibleSolid); myColArmI.sprite_index=sAbomLegThing; myColArmI.visible=1; myColArmI.image_angle=10
        myColArmJ=instance_create(1008,312,oInvisibleSolid); myColArmJ.sprite_index=sAbomLegThing; myColArmJ.visible=1; myColArmJ.image_angle=0
      }
      else {seqTime=75}
    }
    else if seqTime=90 {lungeATent=1}
    else if seqTime=115 {lungeBTent=1}
    else if seqTime=140 {lungeCTent=1}
    else if seqTime=165 {lungeDTent=1}
  }
  else if sequence=16 //-------------------- Parasite is defeated --------------------
  {
    seqTime+=1
    if seqTime=1
    {
      with oEProjectileBase {instance_destroy()}
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
        oEvAbom.instrumentProg=4
        with myCollisionLegLeft[0] {instance_destroy()}
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
        with myColArmJ {instance_destroy()}
        with oAbomInstrument {instance_destroy()}
        with oAbomSpikeBody {instance_destroy()}
        with oAbomLungeTentacle {instance_destroy()}
        with oBkgAbomSeg {instance_destroy()}
        with oAbomParasite {instance_destroy()}
        with oTempTrap {instance_destroy()}
        lungeATent=0; lungeBTent=0; lungeCTent=0; lungeDTent=0
        instance_destroy()
      }
    }
  }

  //-------------------- Background segments --------------------
  if bkgPartSeq=1
  {
    bkgPartTime+=1
    if bkgPartTime=1 {bkgX=312; bkgY=624; bkgPartNum=59}
    else if bkgPartTime=20
    {
      var tBackSeg;
      tBackSeg=instance_create(bkgX,bkgY,oBkgAbomSeg); tBackSeg.maxScale=0.5
      bkgX+=11; bkgY-=11
      bkgPartNum-=1
      if bkgPartNum>0 {bkgPartTime=10}
      else {bkgPartTime=30}
    }
    else if bkgPartTime=35 {bkgX=496; bkgY=288; bkgPartNum=26}
    else if bkgPartTime=50
    {
      var tBackSeg;
      tBackSeg=instance_create(bkgX,bkgY,oBkgAbomSeg); tBackSeg.maxScale=0.55
      bkgX-=12; bkgY+=7
      bkgPartNum-=1
      if bkgPartNum>0 {bkgPartTime=40}
      else {bkgPartTime=70}
    }
    else if bkgPartTime=75 {bkgX=192; bkgY=128; bkgPartNum=68}
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
    bkgPartTime+=1
    if bkgPartTime=1 {bkgX=624; bkgY=400; bkgPartNum=35}
    else if bkgPartTime=20
    {
      var tBackSeg;
      tBackSeg=instance_create(bkgX,bkgY,oBkgAbomSeg); tBackSeg.maxScale=0.55
      bkgX-=9; bkgY-=12
      bkgPartNum-=1
      if bkgPartNum>0 {bkgPartTime=10}
      else {bkgPartTime=30}
    }
    else if bkgPartTime=35 {bkgX=752; bkgY=336; bkgPartNum=25}
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
    bkgPartTime+=1
    if bkgPartTime=1 {bkgX=944; bkgY=624; bkgPartNum=43}
    else if bkgPartTime=20
    {
      var tBackSeg;
      tBackSeg=instance_create(bkgX,bkgY,oBkgAbomSeg); tBackSeg.maxScale=0.7
      bkgX-=9; bkgY-=15
      bkgPartNum-=1
      if bkgPartNum>0 {bkgPartTime=10}
      else {bkgPartTime=30}
    }
    else if bkgPartTime=35 {bkgX=192; bkgY=448; bkgPartNum=65}
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
    bkgPartTime+=1
    if bkgPartTime=1 {bkgX=176; bkgY=304; bkgPartNum=45}
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
    minionTime+=1
    if minionTime=minionDelay-10 {playSound(global.snd_DemonLaugh,0,1,1)}
    else if minionTime>=minionDelay
    {
      instance_create(624,432,oAbomSFinal)
      instance_create(528,560,oAbomSFinal)
      instance_create(736,560,oAbomSFinal)
      minionTime=0
    }
  }

  if bContinuousAttackA=1 //Attack from bottom
  {
    conAtkTimeA+=1
    if conAtkTimeA>=conAtkDelayA
    {
      var tNewAttack;
      tNewAtk=instance_create(oPlayer1.x,room_height+16,oPassBullet)
      tNewAtk.sprite_index=sAbomProjectileA; tNewAtk.atkPower=12; tNewAtk.bulletSpeed=2.75; tNewAtk.depth=-1
      tNewAtk.decayTime=-100; tNewAtk.image_xscale=2; tNewAtk.image_yscale=2; tNewAtk.direction=90
      conAtkTimeA=0
    }
  }

  if bContinuousAttackB=1 //Rain attack from top (First)
  {
    conAtkTimeB+=1
    if conAtkTimeB=conAtkDelayB-1 {event_user(1)}
    if conAtkTimeB>=conAtkDelayB and conAtkTimeB<=conAtkDelayB+60 //Rise up
    {
      if conAtkTimeB mod 3=0 {playSound(global.snd_BombLaunch,0,0.75,75000)}
      var tRainUp;
      tRainUp=instance_create(x+random_range(-96,96),y+random_range(-8,8),oPassBullet)
      tRainUp.sprite_index=sAbomRainAtkA; tRainUp.atkPower=12; tRainUp.bulletSpeed=9; tRainUp.depth=30; tRainUp.image_speed=0.33; tRainUp.image_blend=c_gray
      tRainUp.decayTime=-100; tRainUp.image_xscale=0.5; tRainUp.image_yscale=0.5; tRainUp.direction=90+random_range(-7,7); tRainUp.bCanDealDamage=0
    }
    else if conAtkTimeB>=conAtkDelayB+90 //Rain down from top
    {
      var tRainDown,tXDrop;
      if conAtkTimeB mod 6=0
      {
        if conAtkTimeB mod 24=0 {tXDrop=oPlayer1.x}
        else {tXDrop=rainAtkX[rainAInc]+rainOffset}
        tRainDown=instance_create(tXDrop,0,oPassBullet)
        tRainDown.sprite_index=sAbomRainAtkA; tRainDown.atkPower=12; tRainDown.bulletSpeed=4; tRainDown.image_speed=0.33
        tRainDown.decayTime=-100; tRainDown.direction=270
        rainAInc+=1
        if rainAInc=10 {rainOffset+=32; rainAInc=0}
      }
    }

    if conAtkTimeB>=conAtkDelayB+180 //End attack
    {
      rainOffset=0
      conAtkTimeB=0
    }
  }
  if bContinuousAttackC=1 //Rain attack from top (Second) [Diagonal]
  {
    conAtkTimeC+=1
    if conAtkTimeC=conAtkDelayC-1 {event_user(1)}
    if conAtkTimeC>=conAtkDelayC and conAtkTimeC<=conAtkDelayC+60 //Rise up
    {
      if conAtkTimeC mod 3=0 {playSound(global.snd_BombLaunch,0,0.75,75000)}
      var tRainUp;
      tRainUp=instance_create(x+random_range(-96,96),y+random_range(-8,8),oPassBullet)
      tRainUp.sprite_index=sAbomRainAtkA; tRainUp.atkPower=12; tRainUp.bulletSpeed=9; tRainUp.depth=30; tRainUp.image_speed=0.33; tRainUp.image_blend=c_gray
      tRainUp.decayTime=-100; tRainUp.image_xscale=0.5; tRainUp.image_yscale=0.5; tRainUp.direction=90+random_range(-45,45); tRainUp.bCanDealDamage=0
    }
    else if conAtkTimeC>=conAtkDelayC+90 //Rain down
    {
      var tRainDown;
      if conAtkTimeC mod 5=0
      {
        tRainDown=instance_create(rainAtkX[rainAInc],0,oPassBullet)
        tRainDown.sprite_index=sAbomRainAtkA; tRainDown.atkPower=12; tRainDown.bulletSpeed=4; tRainDown.image_speed=0.33; tRainDown.decayTime=-100
        if conAtkTimeC mod 2=0 {tRainDown.direction=310}
        else {tRainDown.direction=230}
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
    conAtkTimeD+=1
    if conAtkTimeD=1 {event_user(1)}

    if conAtkTimeD mod 5=0
    {
      var tRainUp;
      tRainUp=instance_create(x+random_range(-96,96),y+random_range(-8,8),oPassBullet)
      tRainUp.sprite_index=sAbomRainAtkA; tRainUp.atkPower=12; tRainUp.bulletSpeed=9; tRainUp.depth=30; tRainUp.image_speed=0.33; tRainUp.image_blend=c_gray
      tRainUp.decayTime=-100; tRainUp.image_xscale=0.5; tRainUp.image_yscale=0.5; tRainUp.direction=90+random_range(-45,45); tRainUp.bCanDealDamage=0
    }

    if conAtkTimeD>=conAtkDelayD and conAtkTimeD<=conAtkDelayD+60 //Attack
    {
      var tRainDown,tXDrop;
      if conAtkTimeD mod 24=0 {tXDrop=oPlayer1.x}
      else {tXDrop=rainAtkX[rainAInc]+rainOffset}
      if conAtkTimeD mod 5=0
      {
        tRainDown=instance_create(tXDrop,0,oGravBulletAlt)
        tRainDown.atkPower=12; tRainDown.sprite_index=sAbomRainAtkA; tRainDown.damageType="EXPLOSION"; tRainDown.image_speed=0.33
        tRainDown.bExplode=1; tRainDown.yVel=2; tRainDown.xGrav=0; tRainDown.yGrav=0.1
        if conAtkTimeD mod 2=0 {tRainDown.xVel=0.5}
        else {tRainDown.xVel=-0.5}

        rainAInc+=1
        if rainAInc=10 {rainOffset+=32; rainAInc=0}
      }
    }
    else if conAtkTimeD>=conAtkDelayD+70 //End Attack
    {
      var tXDrop;
      tXDrop=288
      for(i=0;i<16;i+=1)
      {
        tRainDown=instance_create(tXDrop,0,oGravBulletAlt)
        tRainDown.atkPower=12; tRainDown.sprite_index=sAbomRainAtkA; tRainDown.damageType="EXPLOSION"; tRainDown.image_speed=0.33
        tRainDown.bExplode=1; tRainDown.yVel=2; tRainDown.xGrav=0; tRainDown.yGrav=0.1
        if i mod 2=0 {tRainDown.xVel=0.5+(i/20)}
        else {tRainDown.xVel=-0.5+(i/20)}
        tXDrop+=44
      }
      conAtkTimeD=0
    }
  }

  //Lunge Tentacles
  if lungeATent>=1
  {
    lungeATent+=1
    if lungeATent=2
    {
      for(i=0;i<5;i+=1)
      {
        myTentacleA[i]=instance_create(464,320-(i*16),oAbomLungeTentacle); myTentacleA[i].pieceNum=i+1; myTentacleA[i].delayTime=i*20
      }
    }
    else if lungeATent>=90
    {
      if myTentacleA[0].x-16>oPlayer1.x //Player on left
      {
        if lungeAPullCurr>-lungeAPullMax
        {
          for(i=0;i<5;i+=1)
          {
            myTentacleA[i].x-=0.25*i
          }
          lungeAPullCurr-=1
        }
      }
      else if myTentacleA[0].x+16<oPlayer1.x //Player on right
      {
        if lungeAPullCurr<lungeAPullMax
        {
          for(i=0;i<5;i+=1)
          {
            myTentacleA[i].x+=0.25*i
          }
          lungeAPullCurr+=1
        }
      }
    }
  }

  if lungeBTent>=1
  {
    lungeBTent+=1
    if lungeBTent=2
    {
      for(i=0;i<5;i+=1)
      {
        myTentacleB[i]=instance_create(784,320-(i*16),oAbomLungeTentacle); myTentacleB[i].pieceNum=i+1; myTentacleB[i].delayTime=i*20
      }
    }
    else if lungeBTent>=90
    {
      if myTentacleB[0].x-16>oPlayer1.x //Player on left
      {
        if lungeBPullCurr>-lungeBPullMax
        {
          for(i=0;i<5;i+=1)
          {
            myTentacleB[i].x-=0.25*i
          }
          lungeBPullCurr-=1
        }
      }
      else if myTentacleB[0].x+16<oPlayer1.x //Player on right
      {
        if lungeBPullCurr<lungeBPullMax
        {
          for(i=0;i<5;i+=1)
          {
            myTentacleB[i].x+=0.25*i
          }
          lungeBPullCurr+=1
        }
      }
    }
  }
  if lungeCTent>=1
  {
    lungeCTent+=1
    if lungeCTent=2
    {
      for(i=0;i<5;i+=1)
      {
        myTentacleC[i]=instance_create(336,320-(i*16),oAbomLungeTentacle); myTentacleC[i].pieceNum=i+1; myTentacleC[i].delayTime=i*20
      }
    }
    else if lungeCTent>=90
    {
      if myTentacleC[0].x-16>oPlayer1.x //Player on left
      {
        if lungeCPullCurr>-lungeCPullMax
        {
          for(i=0;i<5;i+=1)
          {
            myTentacleC[i].x-=0.25*i
          }
          lungeCPullCurr-=1
        }
      }
      else if myTentacleC[0].x+16<oPlayer1.x //Player on right
      {
        if lungeCPullCurr<lungeCPullMax
        {
          for(i=0;i<5;i+=1)
          {
            myTentacleC[i].x+=0.25*i
          }
          lungeCPullCurr+=1
        }
      }
    }
  }
  if lungeDTent>=1
  {
    lungeDTent+=1
    if lungeDTent=2
    {
      for(i=0;i<5;i+=1)
      {
        myTentacleD[i]=instance_create(928,320-(i*16),oAbomLungeTentacle); myTentacleD[i].pieceNum=i+1; myTentacleD[i].delayTime=i*20
      }
    }
    else if lungeDTent>=90
    {
      if myTentacleD[0].x-16>oPlayer1.x //Player on left
      {
        if lungeDPullCurr>-lungeDPullMax
        {
          for(i=0;i<5;i+=1)
          {
            myTentacleD[i].x-=0.25*i
          }
          lungeDPullCurr-=1
        }
      }
      else if myTentacleD[0].x+16<oPlayer1.x //Player on right
      {
        if lungeDPullCurr<lungeDPullMax
        {
          for(i=0;i<5;i+=1)
          {
            myTentacleD[i].x+=0.25*i
          }
          lungeDPullCurr+=1
        }
      }
    }
  }

  //Hidden end checks
  if leftWeakTimer>0 {leftWeakTimer-=1}
  if rightWeakTimer>0 {rightWeakTimer-=1}
  if leftWeakTimer>0 and rightWeakTimer>0
  {
    leftWeakTimer=0; rightWeakTimer=0
    hitHiddenWeakNum+=1
    if hitHiddenWeakNum>=3 and pullInSequence=0
    {
      playSound(global.snd_Secret,0,1,1)
      var tFlash;
      tFlash=instance_create(0,0,oScreenFlash); tFlash.fadeSpeed=0.2
      with oAbomInstrument
      {
        activeTime=1
        y=-512
      }
      particleKiller=instance_create(632,352,oAbomHiddenWeaknesses)
      particleKiller.type=3; particleKiller.image_xscale=2.5; particleKiller.image_yscale=2.5
      pullInSequence=1
    }
  }

  //Start pull in sequence
  if pullInSequence>=1
  {
    pullInSequence+=1
    if pullInSequence>=2
    {
      var tNewObj,tSize,tDir;
      tSize=1+random(0.4)
      tDir=random(360)
      tNewObj=instance_create(632+lengthdir_x(160+random(64),tDir-180),352+lengthdir_y(160+random(64),tDir-180),oMisc)
      tNewObj.sprite_index=sBelmontWepEffect; tNewObj.turnSpd=0; tNewObj.direction=tDir; tNewObj.speed=2+random(1)
      tNewObj.type=3; tNewObj.image_xscale=tSize; tNewObj.image_yscale=tSize; tNewObj.image_alpha=0.5+random(0.3)
    }
    if pullInSequence>=120
    {
      if hiddenTentacles=0 {hiddenTentacles=16}
      if hiddenTentacles<112 {hiddenTentacles+=0.5}
    }
    if pullInSequence>=220
    {
      oPlayer1.bCanTakeDamage=0
      oEvAbom.fadeAlpha+=0.02
      if oEvAbom.fadeAlpha>=1 //Warp inside Abom
      {
        if global.gateHProg<100 //Before finishing Instrument quest
        {
          global.newMapX=128; global.newMapY=48
          room_goto(rAbomPreInstr)
        }
        else
        {
          global.newMapX=128; global.newMapY=48
          room_goto(rAbomA)
        }
      }
    }
  }

  //Hidden end fail
  if hiddenEndFail>=1 and hiddenEndFail<=999
  {
    hiddenEndFail+=1
    if hiddenEndFail>=120
    {
      newGameOver=instance_create(0,0,oSituationalGO_Message); newGameOver.type=2
      oPlayer1.life-=oPlayer1.maxLife
      hiddenEndFail=1000
    }
  }
}
#define Collision_oAttackBase
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if bBattleStart=0
{
  if oPlayer1.x>=224 and oPlayer1.x<=1024
  {
    myLeftWeak=instance_create(544,408,oAbomHiddenWeaknesses); myLeftWeak.type=1
    myRightWeak=instance_create(696,408,oAbomHiddenWeaknesses); myRightWeak.type=2
    bBattleStart=1
  }
}
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///Form weak spot
var myWeakSpot;
myWeakSpot=instance_create(formWeakSpotX,formWeakSpotY,oAbomHitSpotA)
myWeakSpot.direction=formWeakSpotDir
myWeakSpot.heartOffsetX=formWeakSpotHeartOffsetX
myWeakSpot.HPSet=myHitSpotHP[myHitCounter]
myHitCounter+=1
#define Other_11
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///Rain atk sequence
//Get the order for the rain attack sequence
rainAInc=0
rainAtkX[0]=448
rainAtkX[1]=704
rainAtkX[2]=528
rainAtkX[3]=848
rainAtkX[4]=656
rainAtkX[5]=464
rainAtkX[6]=768
rainAtkX[7]=416
rainAtkX[8]=608
rainAtkX[9]=560
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if hiddenTentacles>0
{
  for(i=0;i<40;i+=1)
  {
    draw_sprite_ext(sAbom_Tentacle,random(2),x+lengthdir_x(hiddenTentacles,40+(i*2.5)),y-54+lengthdir_y(hiddenTentacles,40+(i*2.5)),2,2,40+(i*2.5),image_blend,image_alpha)
  }
}

draw_self()

if spikeScale>0
{
  if spikeScale<2 {spikeScale+=0.05}
  draw_sprite_ext(sAbom_Spike,0,x-156,y-54,spikeScale,spikeScale,image_angle+155,image_blend,image_alpha)
  draw_sprite_ext(sAbom_Spike,0,x-144,y-139,spikeScale,spikeScale,image_angle+135,image_blend,image_alpha)
  draw_sprite_ext(sAbom_Spike,0,x-142,y-214,spikeScale,spikeScale,image_angle+130,image_blend,image_alpha)
  draw_sprite_ext(sAbom_Spike,0,x-131,y-282,spikeScale,spikeScale,image_angle+125,image_blend,image_alpha)
  draw_sprite_ext(sAbom_Spike,0,x-114,y-308,spikeScale,spikeScale,image_angle+65,image_blend,image_alpha)
  draw_sprite_ext(sAbom_Spike,0,x-115,y-253,spikeScale,spikeScale,image_angle+40,image_blend,image_alpha)
  draw_sprite_ext(sAbom_Spike,0,x-87,y-195,spikeScale,spikeScale,image_angle+75,image_blend,image_alpha)
  draw_sprite_ext(sAbom_Spike,0,x-30,y-194,spikeScale,spikeScale,image_angle+100,image_blend,image_alpha)
  draw_sprite_ext(sAbom_Spike,0,x-20,y-213,spikeScale,spikeScale,image_angle+70,image_blend,image_alpha)
  draw_sprite_ext(sAbom_Spike,0,x+29,y-192,spikeScale,spikeScale,image_angle+85,image_blend,image_alpha)
  draw_sprite_ext(sAbom_Spike,0,x+87,y-184,spikeScale,spikeScale,image_angle+115,image_blend,image_alpha)
  draw_sprite_ext(sAbom_Spike,0,x+117,y-229,spikeScale,spikeScale,image_angle+125,image_blend,image_alpha)
  draw_sprite_ext(sAbom_Spike,0,x+117,y-270,spikeScale,spikeScale,image_angle+90,image_blend,image_alpha)
  draw_sprite_ext(sAbom_Spike,0,x+142,y-267,spikeScale,spikeScale,image_angle+65,image_blend,image_alpha)
  draw_sprite_ext(sAbom_Spike,0,x+138,y-204,spikeScale,spikeScale,image_angle+50,image_blend,image_alpha)
  draw_sprite_ext(sAbom_Spike,0,x+141,y-91,spikeScale,spikeScale,image_angle+30,image_blend,image_alpha)
}
