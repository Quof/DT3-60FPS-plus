#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
enemyCount=-1
fadeColor=c_white
fadeAlpha=0
followBack=0

if global.gameProgress=2160
{
  fadeColor=c_black
  fadeAlpha=1
}
if global.gameProgress=2430 {fadeAlpha=1}
if global.gameProgress>=2430 and global.gameProgress<=2440
{
  keyCheck=0
}

if room=rVault_16
{
  lightBeamWave=-1
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gameProgress=2160 and room=rVault_1 //----- [1] Chapter 10 - Are we in the Vault? -----
{
  if sceneProgress=0
  {
    sceneDelay+=1
    if sceneDelay=1
    {
      global.gamePaused=true
      oPlayer1.sprite_index=sClaireLayDown; oPlayer1.image_speed=0
      oIdentifier.x=oPlayer1.x-24; oIdentifier.y=oPlayer1.y-64
      oPlayerShieldBubble.visible=0
    }
    else if sceneDelay>=30
    {
      fadeAlpha-=0.01
      if fadeAlpha<=0 {sceneDelay=0; sceneProgress+=1}
    }
  }
  else if sceneProgress=1
  {
    sceneDelay+=1
    if sceneDelay=20 {showEmote(oIdentifier,0,-6,sEmThinking)}
    else if sceneDelay>=40 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"Chao","Is everyone okay?",0,3,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","I'm still here... somehow.",0,3,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Chao","Jeremy, what's going on? We aren't... in the Vault, are we?",0,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","I'm afraid we are.",0,3,oMessageCutscene,1)
  else if sceneProgress=6 and bWaitForInput=false
    msgCreate(0,0,"Chao","What happened to Claire and Jerry?!",0,3,oMessageCutscene,1)
  else if sceneProgress=7
  {
    sceneDelay+=1
    if sceneDelay=10 {showEmote(oPlayer1,0,-12,sEmThinking)}
    else if sceneDelay=60 {oPlayer1.sprite_index=sClaireSitUp; oPlayer1.image_index=0; showEmote(oIdentifier,0,-6,sEmExcite)}
    else if sceneDelay=67 {oPlayer1.image_index=1}
    else if sceneDelay=74 {oPlayer1.image_index=2}
    else if sceneDelay>=90 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=8 and bWaitForInput=false
    msgCreate(0,0,"Claire","Oh wow, what happened and... what is this?",0,3,oMessageCutscene,1)
  else if sceneProgress=9 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Unfortunately we're in the Vault. All of us are. I don't know why or how it happened, but we were pulled in.",0,3,oMessageCutscene,1)
  else if sceneProgress=10 and bWaitForInput=false
    msgCreate(0,0,"Claire","Things got worse.",0,3,oMessageCutscene,1)
  else if sceneProgress=11 and bWaitForInput=false
    msgCreate(0,0,"Chao","At least you're okay.",0,3,oMessageCutscene,1)
  else if sceneProgress=12 and bWaitForInput=false
    msgCreate(0,0,"Claire","Why wouldn't I be and... wait a minute. Jerry is unusually quiet.",0,3,oMessageCutscene,1)
  else if sceneProgress=13 and bWaitForInput=false
    msgCreate(0,0,"Chao","He's...",0,3,oMessageCutscene,1)
  else if sceneProgress=14
  {
    sceneDelay+=1
    if sceneDelay=10 {oPlayer1.sprite_index=sClaireIdle; oPlayer1.image_speed=0.1}
    else if sceneDelay=20 {oPlayer1.image_xscale=-1}
    else if sceneDelay=27 {oPlayer1.sprite_index=sClaireWalk; oPlayer1.image_speed=0.33}
    else if sceneDelay>=28 and sceneDelay<=32 {oPlayer1.x-=5}
    else if sceneDelay=33 {oPlayer1.sprite_index=sClaireIdle; oPlayer1.image_speed=0.1}
    else if sceneDelay=38 {oPlayer1.sprite_index=sClaireKneel; oPlayer1.image_index=0; oPlayer1.image_speed=0}
    else if sceneDelay=42 {oPlayer1.image_index=1}
    else if sceneDelay>=50 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=15 and bWaitForInput=false
    msgCreate(0,0,"Claire","Jerry!! Are you okay?!",0,3,oMessageCutscene,1)
  else if sceneProgress=16
  {
    sceneDelay+=1
    if sceneDelay>=30 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=17 and bWaitForInput=false
    msgCreate(0,0,"Claire","Not cool, Jerry. I'll punch you if you're messing with me...",0,3,oMessageCutscene,1)
  else if sceneProgress=18
  {
    sceneDelay+=1
    if sceneDelay>=30 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=19 and bWaitForInput=false
    msgCreate(0,0,"Claire","Jeremy, what happened to him?",0,3,oMessageCutscene,1)
  else if sceneProgress=20 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","I think he's unconscious.",0,3,oMessageCutscene,1)
  else if sceneProgress=21 and bWaitForInput=false
    msgCreate(0,0,"Claire","Huh?! We've never had this happen before! Why didn't he wake up like I did?",0,3,oMessageCutscene,1)
  else if sceneProgress=22 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","I don't know. I think this is a new state added in recently. I don't know why this is happening now, but that's what it is.",0,3,oMessageCutscene,1)
  else if sceneProgress=23 and bWaitForInput=false
    msgCreate(0,0,"Claire","How can we help him?",0,3,oMessageCutscene,1)
  else if sceneProgress=24 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Find out how to wake him? I don't know.",0,3,oMessageCutscene,1)
  else if sceneProgress=25 and bWaitForInput=false
  {
    oPlayer1.sprite_index=sClaireIdle; oPlayer1.image_speed=0.1
    msgCreate(0,0,"Claire","I'll find a way.",0,3,oMessageCutscene,1)
  }
  else if sceneProgress=26 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Okay then, first things first. Look around this place and see if we can find anything to help wake him up.",0,3,oMessageCutscene,1)
  else if sceneProgress=27 and bWaitForInput=false
    msgCreate(0,0,"Claire","We can't leave him here alone though. Not like this. Why isn't he taken to an inactive state like usual?",0,3,oMessageCutscene,1)
  else if sceneProgress=28 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","You know as much as I do here, neither I nor Chao activated the split states. Something else must have done that in here. But if that's true, I can set a shield on him.",0,3,oMessageCutscene,1)
  else if sceneProgress=29 and bWaitForInput=false
    msgCreate(0,0,"Claire","That will keep him safe?",0,3,oMessageCutscene,1)
  else if sceneProgress=30 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","In the mean time, it should.",0,3,oMessageCutscene,1)
  else if sceneProgress=31 and bWaitForInput=false
  {
    oIdentifier.followTarget=oPlayerIdle; oIdentifier.willFollowMouse=0; oIdentifier.bCanScan=0
    msgCreate(0,0,"Chao","I'll keep watch on him while you're away.",0,3,oMessageCutscene,1)
  }
  else if sceneProgress=32 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","You sure sis? That means I won't be able to send scan info nor will you be able to see what's happening near Claire.",0,3,oMessageCutscene,1)
  else if sceneProgress=33 and bWaitForInput=false
    msgCreate(0,0,"Chao","Someone needs to stay here and Claire is better equipped than I am out there.",0,3,oMessageCutscene,1)
  else if sceneProgress=34 and bWaitForInput=false
  {
    oPlayer1.image_xscale=1
    msgCreate(0,0,"Claire","It's okay, I'll go.",0,3,oMessageCutscene,1)
  }
  else if sceneProgress=35 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Be extremely careful, Claire. This place looks similar to these 'Distortion' worlds that Jerry and I ran into before the Virus took over. But there's no telling what's in this place or what hasn't escaped.",0,3,oMessageCutscene,1)
  else if sceneProgress=36 and bWaitForInput=false
    msgCreate(0,0,"Claire","I will.",0,3,oMessageCutscene,1)
  else if sceneProgress=37
  {
    oIdentifier.followTarget=oPlayerIdle; oIdentifier.willFollowMouse=0; oIdentifier.bCanScan=0
    oPlayerShieldBubble.visible=1
    var tNewChapter,tempMplay;
    tNewChapter=instance_create(0,0,oChapterDisplay)
    tNewChapter.newChapter="Chapter 10#Something Sleeps in the Darkness"
    tempMplay=findMusic(11)
    playMusic(tempMplay,0,0)
    sceneDelay=0
    sceneProgress=0
    global.canCharSwap=1
    global.bCanSave=true; global.bCanForceGO=true
    global.gameProgress=2170
    global.gamePaused=false
  }
}
else if global.gameProgress=2170 and room=rVault_2 //----- [2] Leaving them behind -----
{
  if sceneProgress=0
  {
    sceneDelay+=1
    if sceneDelay=1
      global.gamePaused=true
    else if sceneDelay>=20 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=1 and bWaitForInput=false
    msgCreate(0,0,"Claire","Will they be okay?",0,3,oMessageCutscene,1)
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","I don't know if that shield will stay up if we're not in the same 'zone'. Lets just hurry this up cause now you've got me nervous.",0,3,oMessageCutscene,1)
  else if sceneProgress=3
  {
    sceneDelay=0
    sceneProgress=0
    var tHexFlash;
    tHexFlash=instance_create(224,144,oVaultHexFlash); tHexFlash.image_xscale=-1
    global.gameProgress=2180
    global.gamePaused=false
  }
}
else if global.gameProgress=2180 and room=rVault_2 //----- [Unskippable] Enemy Trap -----
{
  if global.gamePaused=false
  {
    if sceneProgress=0
    {
      if oPlayer1.x>=1504
      {
        var enemyCounter,enemyBarrier;
        enemyCounter=instance_create(0,0,oEnemyRemain)
        enemyCounter.enemyCount=5

        enemyBarrier=instance_create(1344,64,oEnemyBarrier); enemyBarrier.image_yscale=12
        enemyBarrier=instance_create(1648,64,oEnemyBarrier); enemyBarrier.image_yscale=12
        sceneProgress+=1
      }
    }
    else if sceneProgress=1
    {
      sceneDelay+=1
      if sceneDelay=30
      {
        delaySpawn(1384,240,oVaultPanther,2,1,1,0.33)
        delaySpawn(1624,240,oVaultPanther,2,1,1,0.33)
        sceneDelay=0; sceneProgress+=1
      }
    }
    else if sceneProgress=2
    {
      if oEnemyRemain.enemyCount<=3
        sceneProgress+=1
    }
    else if sceneProgress=3
    {
      sceneDelay+=1
      if sceneDelay=10
      {
        delaySpawn(1504,144,oVaultMoth,2,1,1,0.33)
        sceneDelay=0; sceneProgress+=1
      }
    }
    else if sceneProgress=4
    {
      if oEnemyRemain.enemyCount<=2
        sceneProgress+=1
    }
    else if sceneProgress=5
    {
      sceneDelay+=1
      if sceneDelay=10
      {
        delaySpawn(1392,144,oVaultShadow,2,1,1,0.33)
        delaySpawn(1616,144,oVaultShadow,2,1,1,0.33)
        sceneDelay=0; sceneProgress+=1
      }
    }
    else if sceneProgress=6
    {
      if oEnemyRemain.enemyCount<=0
      {
        with oEnemyRemain {instance_destroy()}
        with oEnemyBarrier {instance_destroy()}
        sceneProgress=0
        global.gameProgress=2190
      }
    }
  }
}
else if global.gameProgress=2200 and room=rVault_3 //----- [Unskippable] Enemy Trap -----
{
  if global.gamePaused=false
  {
    if sceneProgress=0
    {
      if oPlayer1.x>=1872
      {
        var enemyCounter,enemyBarrier,tHexFlash;
        tHexFlash=instance_create(2016,112,oVaultHexFlash); tHexFlash.image_xscale=-1
        enemyCounter=instance_create(0,0,oEnemyRemain)
        enemyCounter.enemyCount=1

        enemyBarrier=instance_create(1792,0,oEnemyBarrier); enemyBarrier.image_yscale=16
        enemyBarrier=instance_create(2096,0,oEnemyBarrier); enemyBarrier.image_yscale=16
        delaySpawn(2032,224,oBloodTyrant,2,1,1,0.33)
        sceneProgress+=1
      }
    }
    else if sceneProgress=1
    {
      sceneDelay+=1
      if sceneDelay=60
      {
        msgCreate(0,0,"Claire","Not in the mood for these guys.",0,1,oMessagePerson,0)
        newMessage.fadingTime=75
        sceneDelay=0; sceneProgress+=1
      }
    }
    else if sceneProgress=2
    {
      if oEnemyRemain.enemyCount<=0
      {
        with oEnemyRemain {instance_destroy()}
        with oEnemyBarrier {instance_destroy()}
        sceneProgress=0
        global.gameProgress=2210
      }
    }
  }
}
else if global.gameProgress=2210 and room=rVault_3 //----- [2] After grabbing Megaphone -----
{
  if sceneProgress=0 and !instance_exists(oStoryObject)
  {
    sceneDelay+=1
    if sceneDelay=1
      global.gamePaused=true
    else if sceneDelay>=2
    {
      oPlayer1.y+=4
      if oPlayer1.y>=176
      {
        oPlayer1.y=176
        oPlayer1.sprite_index=sClaireIdle
        oPlayer1.image_speed=0.1
        sceneDelay=0
        sceneProgress+=1
      }
    }
  }
  else if sceneProgress=1
  {
    sceneDelay+=1
    if sceneDelay>=70 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"Claire","You know Jerry's a hard sleeper.",0,3,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","That's why we're going to use this.",0,3,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Claire","Do you think those two are okay?",0,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","I wish I knew, just hurry back.",0,3,oMessageCutscene,1)
  else if sceneProgress=6
  {
    sceneDelay=0
    sceneProgress=0
    instance_create(0,0,oCheckpointNotice)
    writeToPlayerGlobals()
    global.newMapX=3664
    global.newMapY=176
    global.gameProgress=2220
    global.gamePaused=false
  }
}
else if global.gameProgress=2220 and room=rVault_3 //----- [Unskippable] Hex Obstacles -----
{
  if sceneProgress=0
  {
    if oPlayer1.x<=2144
    {
      var tHexFlash,tEffect,tThwomp,tXpos;
      tHexFlash=instance_create(2000,128,oVaultHexFlash)
      tXpos=1872
      for(i=0;i<3;i+=1)
      {
        tThwomp=instance_create(tXpos,66,oThwomp); tThwomp.image_blend=c_purple
        tEffect=instance_create(tXpos,66,oEffect)
        tEffect.sprite_index=sMMchargeComplete; tEffect.image_xscale=2; tEffect.image_yscale=2
        tEffect.followID=-1; tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
        tXpos+=80
      }
      sceneProgress+=1
    }
  }
  else if sceneProgress=1
  {
    if oPlayer1.x<=1728
    {
      var tHexFlash,tOrbitTrap,tEffect;
      tHexFlash=instance_create(1664,64,oVaultHexFlash)
      for(i=0;i<3;i+=1)
      {
        tOrbitTrap=instance_create(1600,176,oOrbitingTrap); tOrbitTrap.sprite_index=sZapTrapRed; tOrbitTrap.image_speed=0.33
        tOrbitTrap.swingSpeed=2; tOrbitTrap.orbitDist=64; tOrbitTrap.dir=i*120; tOrbitTrap.drawLine=0; tOrbitTrap.redTrap=1
      }
      tEffect=instance_create(1600,176,oEffect)
      tEffect.sprite_index=sMMchargeComplete; tEffect.image_xscale=2; tEffect.image_yscale=2
      tEffect.followID=-1; tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
      sceneProgress+=1
    }
  }
  else if sceneProgress=2
  {
    if oPlayer1.x<=1312
    {
      var tHexFlash,tZapTrap;
      tHexFlash=instance_create(1216,96,oVaultHexFlash)
      tZapTrap=instance_create(1112,16,oZapTrap); tZapTrap.image_angle=270; tZapTrap.image_xscale=5
      tZapTrap=instance_create(1192,16,oZapTrap); tZapTrap.image_angle=270; tZapTrap.image_xscale=5
      tZapTrap=instance_create(1112,16,oMovingTrapRed); tZapTrap.image_angle=270; tZapTrap.image_xscale=2.5
      tZapTrap.shiftTime=0; tZapTrap.shiftMax=40; tZapTrap.moveSpd=2; tZapTrap.bShowLine=0; tZapTrap.direction=270
      tZapTrap=instance_create(1192,96,oMovingTrapRed); tZapTrap.image_angle=270; tZapTrap.image_xscale=2.5
      tZapTrap.shiftTime=0; tZapTrap.shiftMax=40; tZapTrap.moveSpd=2; tZapTrap.bShowLine=0; tZapTrap.direction=90
      sceneProgress+=1
    }
  }
  else if sceneProgress=3
  {
    if oPlayer1.x<=544
    {
      var tHexFlash,tMTrap;
      tHexFlash=instance_create(448,64,oVaultHexFlash)
      for(i=0;i<2;i+=1)
      {
        for(ii=0;ii<2;ii+=1)
        {
          tMTrap=instance_create(320,160,oMarioChainBall); tMTrap.dir=i*180; tMTrap.swingSpeed=1; tMTrap.chainLinks=6-(ii*2)
          tMTrap=instance_create(320,160,oMarioChainBall); tMTrap.dir=i*180; tMTrap.swingSpeed=-1; tMTrap.chainLinks=6-(ii*2)
        }
      }
      sceneProgress+=1
    }
  }
}
else if global.gameProgress=2230 and room=rVault_2 //----- [Unskippable] Hex Obstacles -----
{
  if sceneProgress=0
  {
    if oPlayer1.x<=1152
    {
      var tHexFlash,enemyCounter,enemyBarrier;
      tHexFlash=instance_create(1040,128,oVaultHexFlash)
      enemyCounter=instance_create(0,0,oEnemyRemain)
      enemyCounter.enemyCount=4
      enemyBarrier=instance_create(944,64,oEnemyBarrier); enemyBarrier.image_yscale=12
      enemyBarrier=instance_create(1344,64,oEnemyBarrier); enemyBarrier.image_yscale=12
      delaySpawn(1024,128,oVaultMoth,2,1,1,0.33)
      delaySpawn(1280,128,oVaultMoth,2,1,1,0.33)
      sceneProgress+=1
    }
  }
  else if sceneProgress=1
  {
    if oEnemyRemain.enemyCount<=2
      sceneProgress+=1
  }
  else if sceneProgress=2
  {
    delaySpawn(1024,128,oVaultMoth,2,1,1,0.33)
    delaySpawn(1280,128,oVaultShadow,2,1,1,0.33)
    sceneProgress+=1
  }
  else if sceneProgress=3
  {
    if oEnemyRemain.enemyCount<=0
    {
      with oEnemyRemain {instance_destroy()}
      with oEnemyBarrier {instance_destroy()}
      global.gameProgress=2235
      sceneProgress+=1
    }
  }
}
else if global.gameProgress=2240 and room=rVault_1 //----- [3] Chao is missing -----
{
  if sceneProgress=0
  {
    if oPlayer1.x<=160
    {
      sceneDelay+=1
      if sceneDelay=1
      {
        global.gamePaused=true
        var tFlash;
        tFlash=instance_create(0,0,oScreenFlash)
        tFlash.image_alpha=0.7; tFlash.fadeSpeed=0.1
        oPlayerShieldBubble.visible=0
        with oEnemyBase {instance_destroy()}
      }
      oPlayer1.y+=4
      if oPlayer1.y>=288
      {
        scenePChk(160,288,0,0.1,-1)
        stopPlayer()
        sceneDelay=0; sceneProgress+=1
      }
    }
  }
  else if sceneProgress=1
  {
    sceneDelay+=1
    if sceneDelay>=20 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Raise the megaphone.",0,3,oMessageCutscene,1)
  else if sceneProgress=3
  {
    sceneDelay+=1
    if sceneDelay=20
    {
      itemMP=instance_create(oPlayer1.x,oPlayer1.y-26,oMisc)
      itemMP.sprite_index=sZeldaMegaphone; itemMP.image_xscale=-1; itemMP.type=1
    }
    else if sceneDelay>=21 and sceneDelay<=56 {itemMP.y-=2}
    else if sceneDelay=90
    {
      playSound(global.snd_SkillCapsule,0,1,85000)
      var tEffect,tNote;
      for(i=0;i<8;i+=1)
      {
        tNote=choose(sNoteSingle,sNoteDouble,sNoteHalf)
        tEffect=instance_create(itemMP.x,itemMP.y,oEffectB)
        tEffect.type=3; tEffect.sprite_index=tNote
        tEffect.direction=random(360); tEffect.fadeSpd=0.05; tEffect.speed=2+random(1)
        tEffect.AccelX=0; tEffect.AccelY=0; tEffect.followID=-1; tEffect.rotation=0; tEffect.newBlend=-1
      }
      with itemMP {instance_destroy()}
      oPlayerIdle.sprite_index=sJerrySurprise
      msgCreate(0,0,"Jerry","HOLY BALLS, WHAT?!",0,1,oMessagePerson,0)
      newMessage.fadingTime=40
    }
    else if sceneDelay=102 {oPlayerIdle.sprite_index=sJerrySit}
    else if sceneDelay>=145 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Claire","Are you okay, Jerry?",0,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Yeah, that sound just startled the piss out of me is all. What happened just now?",0,3,oMessageCutscene,1)
  else if sceneProgress=6 and bWaitForInput=false
    msgCreate(0,0,"Claire","We were pulled into the Vault. No one knows why though. Both of us were unconscious when we came in.",0,3,oMessageCutscene,1)
  else if sceneProgress=7 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Weird that I didn't wake up.",0,3,oMessageCutscene,1)
  else if sceneProgress=8 and bWaitForInput=false
    msgCreate(0,0,"Claire","We're all glad you're okay. We had to leave you behind, but Jeremy had a shield over you while Chao watched you.",0,3,oMessageCutscene,1)
  else if sceneProgress=9 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Thanks... It's weird to think we can be unconscious in this place.",0,3,oMessageCutscene,1)
  else if sceneProgress=10 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Wait a minute, where's Chao?!",0,3,oMessageCutscene,1)
  else if sceneProgress=11 and bWaitForInput=false
    msgCreate(0,0,"Claire","Huh?! She was here when we left.",0,3,oMessageCutscene,1)
  else if sceneProgress=12 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","I know that! She isn't here now though!",0,3,oMessageCutscene,1)
  else if sceneProgress=13 and bWaitForInput=false
    msgCreate(0,0,"?????","Where indeed.",5,3,oMessageCutscene,1)
  else if sceneProgress=14 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Who just said that?!",0,3,oMessageCutscene,1)
  else if sceneProgress=15
  {
    sceneDelay+=1
    if sceneDelay=30
    {
      npcHex=instance_create(288,192,oMisc)
      npcHex.sprite_index=sHex_A_Idle; npcHex.image_xscale=-1; npcHex.image_alpha=0 npcHex.type=4; npcHex.moveStep=pi/2
    }
    else if sceneDelay>=31 and sceneDelay<=65 {npcHex.image_alpha+=0.02}
    else if sceneDelay>=70 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=16 and bWaitForInput=false
  {
    oPlayer1.image_xscale=1
    msgCreate(0,0,"?????","Don't you remember me? We had such fun times before.",5,3,oMessageCutscene,1)
  }
  else if sceneProgress=17 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Hexor.",0,3,oMessageCutscene,1)
  else if sceneProgress=1 and bWaitForInput=false
    msgCreate(0,0,"Hex","I prefer this name now, I believe it suits me better.",0,3,oMessageCutscene,1)
  else if sceneProgress=18
  {
    sceneDelay+=1
    if sceneDelay=10 {oPlayerIdle.sprite_index=sJerryGetUp; oPlayerIdle.image_speed=0; oPlayerIdle.image_index=2}
    else if sceneDelay=14 {oPlayerIdle.image_index=3}
    else if sceneDelay=18 {oPlayerIdle.sprite_index=sJerryIdle; oPlayerIdle.image_speed=0.1}
    else if sceneDelay>=22 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=19 and bWaitForInput=false
    msgCreate(0,0,"Jerry","That's what you look like?",0,3,oMessageCutscene,1)
  else if sceneProgress=20 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","He's just projecting that image here. He's somewhere else in the Vault.",0,3,oMessageCutscene,1)
  else if sceneProgress=21 and bWaitForInput=false
    msgCreate(0,0,"Hex","As usual, your skills are impressive Jeremy, even limited as you are now.",0,3,oMessageCutscene,1)
  else if sceneProgress=22 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","What did you do with my sister?!",0,3,oMessageCutscene,1)
  else if sceneProgress=23 and bWaitForInput=false
    msgCreate(0,0,"Hex","That's something I learned from you, cut right to the chase.",0,3,oMessageCutscene,1)
  else if sceneProgress=24 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Stop ignoring the question! Where is she?!",0,3,oMessageCutscene,1)
  else if sceneProgress=25 and bWaitForInput=false
    msgCreate(0,0,"Hex","She's not here, that's for sure.",0,3,oMessageCutscene,1)
  else if sceneProgress=26 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","I swear, I will come into the world myself if you've hurt her!",0,3,oMessageCutscene,1)
  else if sceneProgress=27 and bWaitForInput=false
    msgCreate(0,0,"Hex","Now now Jeremy, keep yourself calm. We both know what will happen if you leave that place you're in this time.",0,3,oMessageCutscene,1)
  else if sceneProgress=28 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Eh? What would happen?",0,3,oMessageCutscene,1)
  else if sceneProgress=29 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Sigh... With the program acting up the way it is, I wouldn't be able to get back here.",0,3,oMessageCutscene,1)
  else if sceneProgress=30 and bWaitForInput=false
    msgCreate(0,0,"Hex","Isn't it a great feeling? Knowing you're completely powerless here.",0,3,oMessageCutscene,1)
  else if sceneProgress=31 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","...",0,3,oMessageCutscene,1)
  else if sceneProgress=32 and bWaitForInput=false
    msgCreate(0,0,"Hex","Don't you worry, your sister is safe. However, I can't guarantee her safety for long. What with the horrors that sleep within this place, the bots the program shut in here. Just think of what could happen to her.",0,3,oMessageCutscene,1)
  else if sceneProgress=33 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","We're going to find you, and when we do...",0,3,oMessageCutscene,1)
  else if sceneProgress=34 and bWaitForInput=false
    msgCreate(0,0,"Hex","You'll do what?",0,3,oMessageCutscene,1)
  else if sceneProgress=35 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","...",0,3,oMessageCutscene,1)
  else if sceneProgress=36 and bWaitForInput=false
    msgCreate(0,0,"Hex","Come find me, I dare you.",0,3,oMessageCutscene,1)
  else if sceneProgress=37
  {
    npcHex.image_alpha-=0.02
    if npcHex.image_alpha<=0 {sceneProgress+=1}
  }
  else if sceneProgress=38 and bWaitForInput=false
    msgCreate(0,0,"Claire","We'll find her, Jeremy. We will.",0,3,oMessageCutscene,1)
  else if sceneProgress=39 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","... Just find her. I saw a door on the way back that you two should be able to reach.",0,3,oMessageCutscene,1)
  else if sceneProgress=40
  {
    sceneDelay=0; sceneProgress=0
    with oMisc {instance_destroy()}
    oPlayerIdle.sprite_index=sJerryIdle; oPlayerIdle.image_speed=0.1
    oPlayerShieldBubble.visible=1
    instance_create(0,0,oCheckpointNotice)
    with oToady {instance_destroy()}
    instance_create(2160,192,oToady)
    instance_create(224,288,oHealingPost)
    for(i=0;i<16;i+=1)
    {
      var tEffect;
      tEffect=instance_create(216+random(16),240+random(48),oEffect)
      tEffect.sprite_index=sBelmontWepEffect; tEffect.image_speed=0.6+random(0.1)
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    }
    writeToPlayerGlobals()
    global.canCharSwap=2
    global.newMapX=160
    global.newMapY=288
    global.gameProgress=2250
    global.gamePaused=false
  }
}
else if global.gameProgress=2260 and room=rVault_4 //----- [4] I can't do much -----
{
  if sceneProgress=0
  {
    sceneDelay+=1
    if sceneDelay=1 {global.gamePaused=true}
    else if sceneDelay>=20 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=1 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Unfortunately I can't do much in this place. I wish I could get a scanner of some sort working, but... ugh, it's frustrating.",0,3,oMessageCutscene,1)
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"Claire","We'll find Chao.",0,3,oMessageCutscene,1)
  else if sceneProgress=3
  {
    sceneDelay=0
    sceneProgress=0
    global.gameProgress=2270
    global.gamePaused=false
  }
}
else if global.gameProgress=2290 and room=rVault_5 //----- [] 2nd Abomination sequence - Chase -----
{
  if sceneProgress=0
  {
    if oPlayer1.x>=1824
    {
      instance_create(1552,room_height+336,oVAbom_P2_Main)
      var tempMplay;
      tempMplay=findMusic(814)
      playMusic(tempMplay,0,0)
      sceneProgress+=1
    }
  }
  else if sceneProgress=1
  {
    if oPlayer1.x>=5648
    {
      msgCreate(0,0,"Jerry","I didn't read a lot of that. Kinda hard with all the dodging.",0,1,oMessagePerson,0)
      newMessage.fadingTime=110
      sceneProgress+=1
    }
  }
}
else if global.gameProgress=2300 and room=rVault_6 //----- [] 3rd Abomination sequence - Chase -----
{
  if sceneProgress=0
  {
    if oPlayer1.x>=128
    {
      msgCreate(0,0,"Jeremy","They got away, now where is my sister?!",0,1,oMessagePerson,0)
      newMessage.fadingTime=70
      sceneProgress+=1
    }
  }
  else if sceneProgress=1
  {
    sceneDelay+=1
    if sceneDelay>=70 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=2
  {
    msgCreate(0,0,"Hex","Did they?",0,1,oMessagePerson,0)
    newMessage.fadingTime=60
    sceneProgress+=1
  }
  else if sceneProgress=3
  {
    if oPlayer1.x>=784
    {
      instance_create(784,room_height+336,oVAbom_P3_Main)
      var tempMplay;
      tempMplay=findMusic(822)
      playMusic(tempMplay,0,0)
      sceneProgress+=1
    }
  }
}
else if global.gameProgress=2310 and room=rVault_7 //----- [] 4th Abomination sequence - Force up and attempt to eat -----
{
  if sceneProgress=0
  {
    if oPlayer1.x>=688
    {
      instance_create(688,room_height+336,oVAbom_P4_Main)
      var tempMplay;
      tempMplay=findMusic(822)
      playMusic(tempMplay,0,0)
      sceneProgress+=1
    }
  }
  else if sceneProgress=1
  {
    if oPlayer1.x>=1280
    {
      var tempMplay;
      tempMplay=findMusic(11)
      playMusic(tempMplay,0,0)
      sceneProgress+=1
    }
  }
}
else if global.gameProgress=2320 and room=rVault_8 //----- [5] Where is Chao?! -----
{
  if sceneProgress=0
  {
    sceneDelay+=1
    if sceneDelay=1
      global.gamePaused=true
    else if sceneDelay>=30 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=1 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","They got away this time, where is Chao?!",0,3,oMessageCutscene,1)
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"Hex","The best part about all this is you actually think I would tell you.",0,3,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Where is she?!",0,3,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Hex","I should commend your grunts for actually getting away from the Abomination.",0,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Stop stalling, you know where she is!",0,3,oMessageCutscene,1)
  else if sceneProgress=6 and bWaitForInput=false
    msgCreate(0,0,"Hex","After you trapped me in here, I had the chance to poke around. I even found I wasn't completely powerless in this place, at least after I sent out the bug.",0,3,oMessageCutscene,1)
  else if sceneProgress=7 and bWaitForInput=false
    msgCreate(0,0,"Jerry","So you DID make the Virus!",0,3,oMessageCutscene,1)
  else if sceneProgress=8 and bWaitForInput=false
    msgCreate(0,0,"Hex","Of course not, don't misunderstand. Someone who was once greater than I created that. I merely gave it a little push in the right direction with some modifications.",0,3,oMessageCutscene,1)
  else if sceneProgress=9 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","...Modifications... Wait, how could you have done anything with the Virus if you couldn't manipulate anything in the Vault?",0,3,oMessageCutscene,1)
  else if sceneProgress=10 and bWaitForInput=false
    msgCreate(0,0,"Hex","Oh that's easy. Before our little showdown in the Primary Memory, I found that little program floating about in the Vault. I was just like you Jeremy, nearly integrated with the program and could see everything.",0,3,oMessageCutscene,1)
  else if sceneProgress=11 and bWaitForInput=false
    msgCreate(0,0,"Hex","It seems we've both lost that since you and Jerry foolishly destroyed the Data Modules. Everything you do makes everything worse.",0,3,oMessageCutscene,1)
  else if sceneProgress=12 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","What did you do to the Virus?",0,3,oMessageCutscene,1)
  else if sceneProgress=13 and bWaitForInput=false
    msgCreate(0,0,"Hex","Jeremy, that's something you already figured out. I merely had its behaviors linked to other bots. Think about it. The Virus can corrupt bots just like the Sigma Virus. Oh but questions questions. I do think we're done here.",0,3,oMessageCutscene,1)
  else if sceneProgress=14 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Don't you dare!",0,3,oMessageCutscene,1)
  else if sceneProgress=15 and bWaitForInput=false
    msgCreate(0,0,"Hex","Better hurry up, time is running out.",0,3,oMessageCutscene,1)
  else if sceneProgress=16 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","I really hate you.",0,3,oMessageCutscene,1)
  else if sceneProgress=17
  {
    sceneDelay=0
    sceneProgress=0
    global.gameProgress=2330
    global.gamePaused=false
  }
}
else if global.gameProgress=2330 and room=rVault_8 //----- [Unskippable] Enemy Trap -----
{
  if global.gamePaused=false
  {
    if sceneProgress=0
    {
      if oPlayer1.x>=512
      {
        var enemyCounter,enemyBarrier;
        enemyCounter=instance_create(0,0,oEnemyRemain)
        enemyCounter.enemyCount=5
        
        enemyBarrier=instance_create(288,0,oEnemyBarrier); enemyBarrier.image_yscale=16
        enemyBarrier=instance_create(752,0,oEnemyBarrier); enemyBarrier.image_yscale=16
        sceneProgress+=1
      }
    }
    else if sceneProgress=1
    {
      sceneDelay+=1
      if sceneDelay=30
      {
        delaySpawn(512,48,oVaultShadow,2,1,1,0.33)
        sceneDelay=0; sceneProgress+=1
      }
    }
    else if sceneProgress=2
    {
      if oEnemyRemain.enemyCount<=4
        sceneProgress+=1
    }
    else if sceneProgress=3
    {
      sceneDelay+=1
      if sceneDelay=10
      {
        delaySpawn(384,128,oVaultMoth,2,1,1,0.33)
        delaySpawn(640,128,oVaultMoth,2,1,1,0.33)
        sceneDelay=0; sceneProgress+=1
      }
    }
    else if sceneProgress=4
    {
      if oEnemyRemain.enemyCount<=2
        sceneProgress+=1
    }
    else if sceneProgress=5
    {
      sceneDelay+=1
      if sceneDelay=10
      {
        delaySpawn(368,176,oVaultShadow,2,1,1,0.33)
        delaySpawn(656,176,oVaultShadow,2,1,1,0.33)
        sceneDelay=0; sceneProgress+=1
      }
    }
    else if sceneProgress=6
    {
      if oEnemyRemain.enemyCount<=0
      {
        with oEnemyRemain {instance_destroy()}
        with oEnemyBarrier {instance_destroy()}
        sceneProgress=0
        global.gameProgress=2340
      }
    }
  }
}
else if global.gameProgress=2340 and room=rVault_8 //----- [Unskippable] Enemy Trap - Orbs -----
{
  if global.gamePaused=false
  {
    if sceneProgress=0
    {
      if oPlayer1.x>=992
      {
        var enemyCounter,enemyBarrier;
        enemyCounter=instance_create(0,0,oEnemyRemain)
        enemyCounter.enemyCount=2
        
        enemyBarrier=instance_create(752,0,oEnemyBarrier); enemyBarrier.image_yscale=16
        enemyBarrier=instance_create(1216,0,oEnemyBarrier); enemyBarrier.image_yscale=16
        sceneProgress+=1
      }
    }
    else if sceneProgress=1
    {
      sceneDelay+=1
      if sceneDelay=1
      {
        if global.activeCharacter=0
          msgCreate(0,0,"Jerry","Really? Again?",0,0,oMessagePerson,0)
        else if global.activeCharacter=1
          msgCreate(0,0,"Claire","Already!?",0,0,oMessagePerson,0)
        newMessage.fadingTime=55
      }
      else if sceneDelay=60 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=2
    {
      sceneDelay+=1
      if sceneDelay=30
      {
        createEnemy(800,240,oVaultOrb,2,1,1); newEnemy.colorSet=2
        sceneDelay=0; sceneProgress+=1
      }
    }
    else if sceneProgress=3
    {
      if oEnemyRemain.enemyCount<=1 {sceneProgress+=1}
    }
    else if sceneProgress=4
    {
      sceneDelay+=1
      if sceneDelay=10
      {
        createEnemy(1184,240,oVaultOrb,2,1,1); newEnemy.colorSet=4
        sceneDelay=0; sceneProgress+=1
      }
    }
    else if sceneProgress=5
    {
      if oEnemyRemain.enemyCount<=0
      {
        if global.activeCharacter=0
          msgCreate(0,0,"Jerry","Okay wow... what the mess was that?",0,1,oMessagePerson,0)
        else if global.activeCharacter=1
          msgCreate(0,0,"Claire","I could barely dodge those things!",0,1,oMessagePerson,0)
        newMessage.fadingTime=75
        
        with oEnemyRemain {instance_destroy()}
        with oEnemyBarrier {instance_destroy()}
        sceneProgress=0
        global.gameProgress=2350
      }
    }
  }
}
else if global.gameProgress=2350 and room=rVault_8 //----- [Unskippable] Enemy Trap - Dragon Knight -----
{
  if global.gamePaused=false
  {
    if sceneProgress=0
    {
      if oPlayer1.x>=2224
      {
        msgCreate(0,0,"Jerry","Oh geez, I wonder what's going to happen next.",0,1,oMessagePerson,0)
        newMessage.fadingTime=80
        sceneProgress+=1
      }
    }
    else if sceneProgress=1
    {
      if oPlayer1.x>=2400
      {
        var enemyCounter,enemyBarrier;
        enemyCounter=instance_create(0,0,oEnemyRemain)
        enemyCounter.enemyCount=1
        enemyBarrier=instance_create(2208,0,oEnemyBarrier); enemyBarrier.image_yscale=14
        enemyBarrier=instance_create(2576,0,oEnemyBarrier); enemyBarrier.image_yscale=14
        sceneProgress+=1
      }
    }
    else if sceneProgress=2
    {
      sceneDelay+=1
      if sceneDelay=30
      {
        delaySpawn(2512,224,oDragonKnight,2,1,1,0.33)
        sceneDelay=0; sceneProgress+=1
      }
    }
    else if sceneProgress=3
    {
      if oEnemyRemain.enemyCount<=0
      {
        with oEnemyRemain {instance_destroy()}
        with oEnemyBarrier {instance_destroy()}
        sceneProgress=0
        global.gameProgress=2360
      }
    }
  }
}
else if global.gameProgress=2360 and room=rVault_9 //----- [6] Color Zones -----
{
  if sceneProgress=0
  {
    sceneDelay+=1
    if sceneDelay=1 {global.gamePaused=true}
    else if sceneDelay>=30 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=1 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Oh no... is that what I think it is?",0,3,oMessageCutscene,1)
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"Hex","I'm sure you remember the hardships these brought.",0,3,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Like anyone could forget.",0,3,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Hex","I'd like to play a little game.",0,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Jerry","I don't.",0,3,oMessageCutscene,1)
  else if sceneProgress=6 and bWaitForInput=false
    msgCreate(0,0,"Hex","Remember when I could take away your dash?",0,3,oMessageCutscene,1)
  else if sceneProgress=7 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Claire, you know he tried to pretend he was you at one point?",0,3,oMessageCutscene,1)
  else if sceneProgress=8 and bWaitForInput=false
    msgCreate(0,0,"Claire","What?! When was this?",0,3,oMessageCutscene,1)
  else if sceneProgress=9 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Sometime before we met up with you.",0,3,oMessageCutscene,1)
  else if sceneProgress=10 and bWaitForInput=false
    msgCreate(0,0,"Hex","I'll take away your dash.",0,3,oMessageCutscene,1)
  else if sceneProgress=11 and bWaitForInput=false
    msgCreate(0,0,"Claire","Did you actually fall for it?",0,3,oMessageCutscene,1)
  else if sceneProgress=12 and bWaitForInput=false
    msgCreate(0,0,"Jerry","...A little?",0,3,oMessageCutscene,1)
  else if sceneProgress=13 and bWaitForInput=false
    msgCreate(0,0,"Claire","Oh come on, how could you possibly mistake anyone for me?",0,3,oMessageCutscene,1)
  else if sceneProgress=14 and bWaitForInput=false
    msgCreate(0,0,"Hex","...",0,3,oMessageCutscene,1)
  else if sceneProgress=15 and bWaitForInput=false
    msgCreate(0,0,"Jerry","It's not like I could see him or anything.",0,3,oMessageCutscene,1)
  else if sceneProgress=16 and bWaitForInput=false
    msgCreate(0,0,"Claire","What am I gonna do with you?",0,3,oMessageCutscene,1)
  else if sceneProgress=17 and bWaitForInput=false
    msgCreate(0,0,"Hex","I'm here too...",0,3,oMessageCutscene,1)
  else if sceneProgress=18 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Oh we know, we're just ignoring you.",0,3,oMessageCutscene,1)
  else if sceneProgress=19 and bWaitForInput=false
    msgCreate(0,0,"Hex","Have fun not having that dash.",0,3,oMessageCutscene,1)
  else if sceneProgress=20
  {
    sceneDelay=0; sceneProgress=0
    global.gameProgress=2370
    global.gamePaused=false
  }
}
else if global.gameProgress=2370 and room=rVault_9 //----- [] No dashing / Enemy Trap - Orb -----
{
  oPlayer1.dashEnergy=0
  if global.gamePaused=false
  {
    if sceneProgress=0
    {
      if oPlayer1.x>=2688
      {
        var enemyCounter,enemyBarrier;
        enemyCounter=instance_create(0,0,oEnemyRemain)
        enemyCounter.enemyCount=1
        
        enemyBarrier=instance_create(2528,0,oEnemyBarrier); enemyBarrier.image_yscale=22
        enemyBarrier=instance_create(2832,0,oEnemyBarrier); enemyBarrier.image_yscale=22
        sceneProgress+=1
      }
    }
    else if sceneProgress=1
    {
      sceneDelay+=1
      if sceneDelay=30
      {
        createEnemy(2688,176,oVaultOrb,2,1,1); newEnemy.colorSet=3
        sceneDelay=0; sceneProgress+=1
      }
    }
    else if sceneProgress=2
    {
      if oEnemyRemain.enemyCount<=0
      {
        msgCreate(0,0,"Jeremy","I figured out how to get your dash working again.",0,1,oMessagePerson,0)
        newMessage.fadingTime=100
        with oEnemyRemain {instance_destroy()}
        with oEnemyBarrier {instance_destroy()}
        sceneProgress=0
        global.gameProgress=2380
      }
    }
  }
}
else if global.gameProgress=2380 and room=rVault_10 //----- [7] Chao is close -----
{
  if sceneProgress=0
  {
    sceneDelay+=1
    if sceneDelay=1 {global.gamePaused=true}
    else if sceneDelay>=30 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=1 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","I found her! Chao is close by.",0,3,oMessageCutscene,1)
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"Hex","Very good, Jeremy, but you'll be too late to save her anyway.",0,3,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Don't listen to him. It's just like before, he's mostly all talk. Ignore him.",0,3,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Yeah...",0,3,oMessageCutscene,1)
  else if sceneProgress=5
  {
    sceneDelay=0; sceneProgress=0
    global.gameProgress=2390
    global.gamePaused=false
  }
}
else if global.gameProgress=2390 and room=rVault_10 //----- [] Enemy Trap - Orbs -----
{
  if global.gamePaused=false
  {
    if sceneProgress=0
    {
      if oPlayer1.x>=1616
      {
        var enemyCounter,enemyBarrier;
        enemyCounter=instance_create(0,0,oEnemyRemain)
        enemyCounter.enemyCount=4
        
        enemyBarrier=instance_create(1472,0,oEnemyBarrier); enemyBarrier.image_yscale=22
        enemyBarrier=instance_create(1744,0,oEnemyBarrier); enemyBarrier.image_yscale=22
        sceneProgress+=1
      }
    }
    else if sceneProgress=1
    {
      sceneDelay+=1
      if sceneDelay=30
      {
        createEnemy(1536,80,oVaultOrb,2,1,1); newEnemy.colorSet=1
        createEnemy(1696,208,oVaultOrb,2,1,1); newEnemy.colorSet=2
        sceneDelay=0; sceneProgress+=1
      }
    }
    else if sceneProgress=2
    {
      if oEnemyRemain.enemyCount<=2
        sceneProgress+=1
    }
    else if sceneProgress=3
    {
      sceneDelay+=1
      if sceneDelay=10
      {
        createEnemy(1696,80,oVaultOrb,2,1,1); newEnemy.colorSet=3
        createEnemy(1536,208,oVaultOrb,2,1,1); newEnemy.colorSet=4
        sceneDelay=0; sceneProgress+=1
      }
    }
    else if sceneProgress=4
    {
      if oEnemyRemain.enemyCount<=0
      {
        with oEnemyRemain {instance_destroy()}
        with oEnemyBarrier {instance_destroy()}
        sceneProgress=0
        global.gameProgress=2400
      }
    }
  }
}
else if global.gameProgress=2400 and room=rVault_11 //----- [] Chao is found -----
{
  if global.bossTrack=0
  {
    if sceneProgress=0
    {
      if oPlayer1.x>=528
      {
        global.gamePaused=true
        oPlayer1.y+=4
        if oPlayer1.y>=304
        {
          scenePChk(528,304,0,0.1,1)
          stopPlayer()
          sceneProgress+=1
        }
      }
    }
    else if sceneProgress=1
    {
      sceneDelay+=1
      if sceneDelay>=20 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=2 and bWaitForInput=false
    {
      msgCreate(0,128,"Jeremy","Chao!",0,3,oMessageCutscene,1)
      showEmote((250507),0,-6,sEmExcite)
    }
    else if sceneProgress=3 and bWaitForInput=false
      msgCreate(0,128,"Chao","Watch out! It's a trap!",0,3,oMessageCutscene,1)
    else if sceneProgress=4
    {
      sceneDelay+=1
      if sceneDelay=20
      {
        createEnemy(688,304,oDragonKnight,2,0,1); oDragonKnight.image_xscale=-1
        tEffect=instance_create(688,304,oEffect)
        tEffect.sprite_index=sMissExplosion; tEffect.followID=-1; tEffect.image_xscale=2; tEffect.image_yscale=2
        tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
      }
      else if sceneDelay>=50 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=5 and bWaitForInput=false
      msgCreate(0,128,"Jerry","That's it? We've taken those things down. This is a bigger arena too.",0,3,oMessageCutscene,1)
    else if sceneProgress=6
    {
      sceneDelay+=1
      if sceneDelay=20
      {
        createEnemy(384,304,oBloodTyrant,2,0,1)
        tEffect=instance_create(384,304,oEffect)
        tEffect.sprite_index=sMissExplosion; tEffect.followID=-1; tEffect.image_xscale=2; tEffect.image_yscale=2
        tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
      }
      else if sceneDelay=50 {oPlayer1.image_xscale=-1}
      else if sceneDelay>=80 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=7 and bWaitForInput=false
      msgCreate(0,128,"Claire","You just had to open your mouth.",0,3,oMessageCutscene,1)
    else if sceneProgress=8
    {
      var tempMplay;
      tempMplay=findMusic(809)
      playMusic(tempMplay,0,0)
      var enemyCounter,enemyBarrier;
      enemyBarrier=instance_create(304,112,oEnemyBarrier); enemyBarrier.image_yscale=12
      enemyBarrier=instance_create(880,240,oEnemyBarrier); enemyBarrier.image_yscale=4
      enemyCounter=instance_create(0,0,oEnemyRemain)
      enemyCounter.enemyCount=2
      global.bossTrack=101
      global.gamePaused=false
      storeStatus(0)
      sceneDelay=0; sceneProgress=0
    }
  }
  else if global.bossTrack=101
  {
    if sceneProgress=0
    {
      if oEnemyRemain.enemyCount<=0
      {
        with oEnemyAfterImage {instance_destroy()}
        with oEnemyRemain {instance_destroy()}
        with oEnemyBarrier {instance_destroy()}
        with oAttackBase {instance_destroy()}
        with oDamagableBase {instance_destroy()}
        stopAllMusic()
        scenePChk(oPlayer1.x,oPlayer1.y,1,0.1,oPlayer1.image_xscale)
        global.gamePaused=true
        sceneProgress+=1
      }
    }
    else if sceneProgress=1
    {
      oPlayer1.y+=4
      if oPlayer1.y>=304
      {
        scenePChk(oPlayer1.x,304,0,0.1,oPlayer1.image_xscale)
        stopPlayer()
        sceneProgress+=1
      }
    }
    else if sceneProgress=2
    {
      sceneDelay+=1
      if sceneDelay=30
      {
        oPlayer1.x=512; oPlayer1.y=304; oPlayer1.image_xscale=1
        var tFlash;
        tFlash=instance_create(0,0,oScreenFlash)
        tFlash.image_alpha=0.7; tFlash.fadeSpeed=0.1
      }
      else if sceneDelay=80
      {
        var tFlash,tEffect;
        tFlash=instance_create(0,0,oScreenFlash)
        tFlash.image_alpha=0.4; tFlash.fadeSpeed=0.1
        tile_layer_hide(1000020)
        for(i=0;i<7;i+=1)
        {
          with (250492+i) {instance_destroy()}
        }
        for(i=0;i<32;i+=1)
        {
          tEffect=instance_create((250507).x+random_range(-32,32),(250507).y+random_range(-32,32),oEffect)
          tEffect.sprite_index=sMMGlassBreak; tEffect.image_speed=0.2+random(0.1); tEffect.image_angle=random(360)
          tEffect.direction=random(360); tEffect.speed=1+random(1)
          tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
        }
      }
      else if sceneDelay=120
      {
        window_mouse_set((250507).x,(250507).y)
        oIdentifier.bCanScan=1; oIdentifier.bChaoActive=1
        with (250507) {instance_destroy()}
      }
      else if sceneDelay>=150 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=3 and bWaitForInput=false
      msgCreate(0,0,"Chao","Well, aren't you guys going to say anything?",0,3,oMessageCutscene,1)
    else if sceneProgress=4 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","I don't know what to say... I was so worried.",0,3,oMessageCutscene,1)
    else if sceneProgress=5 and bWaitForInput=false
      msgCreate(0,0,"Claire","We're really relieved to see that you're okay.",0,3,oMessageCutscene,1)
    else if sceneProgress=6 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","Don't do that anymore, Chao. I've never been that scared here.",0,3,oMessageCutscene,1)
    else if sceneProgress=7 and bWaitForInput=false
      msgCreate(0,0,"Chao","Don't plan to.",0,3,oMessageCutscene,1)
    else if sceneProgress=8 and bWaitForInput=false
      msgCreate(0,0,"Hex","Well look at that, everyone is together again. It's really touching.",0,3,oMessageCutscene,1)
    else if sceneProgress=9 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","When we find you...",0,3,oMessageCutscene,1)
    else if sceneProgress=10 and bWaitForInput=false
      msgCreate(0,0,"Hex","IF you find me.",0,3,oMessageCutscene,1)
    else if sceneProgress=11 and bWaitForInput=false
      msgCreate(0,0,"Chao","He gave his position away earlier, so I know where he is. It's not far off from here.",0,3,oMessageCutscene,1)
    else if sceneProgress=12 and bWaitForInput=false
      msgCreate(0,0,"Hex","So you know my location, big deal. I'll be waiting.",0,3,oMessageCutscene,1)
    else if sceneProgress=13 and bWaitForInput=false
      msgCreate(0,0,"Chao","He hasn't moved this entire time.",0,3,oMessageCutscene,1)
    else if sceneProgress=14 and bWaitForInput=false
      msgCreate(0,0,"Jerry","So it's probably another trap.",0,3,oMessageCutscene,1)
    else if sceneProgress=15 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","Doesn't matter, once we find him, we can end this.",0,3,oMessageCutscene,1)
    else if sceneProgress=16 and bWaitForInput=false
      msgCreate(0,0,"Chao","Just keep heading to the right. The exits are all set up now to lead to him.",0,3,oMessageCutscene,1)
    else if sceneProgress=17
    {
      var tFullHeartDrop;
      tFullHeartDrop=instance_create(600,152,oHealthPickup)
      tFullHeartDrop.sprite_index=sFullHealthPickup
      var tempMplay;
      tempMplay=findMusic(11)
      playMusic(tempMplay,0,0)
      global.gamePaused=false
      sceneProgress=0
      global.bossTrack=0
      global.gameProgress=2410
    }
  }
}
else if global.gameProgress=2420 and room=rVault_13 //----- [] Boss Fight: Hex -----
{
  if global.bossTrack=0
  {
    if sceneProgress=0
    {
      if oPlayer1.x>=384
      {
        global.gamePaused=true
        oPlayer1.y+=4
        if oPlayer1.y>=304
        {
          scenePChk(384,304,0,0.1,1)
          stopPlayer()
          sceneProgress+=1
        }
      }
    }
    else if sceneProgress=1
    {
      sceneDelay+=1
      if sceneDelay=1
      {
        musVolC=global.optMusic*100
        musFileP=findMusic(11)
      }
      else if sceneDelay>=2
      {
        if musVolC>=7500 {musVolC-=30}
        else {musVolC-=350}
        SS_SetSoundVol(musFileP,musVolC)
        if musVolC<=1000
        {
          musFileP=findMusic(0)
          sceneDelay=0; sceneProgress+=1
        }
      }
    }
    else if sceneProgress=2
    {
      sceneDelay+=1
      if sceneDelay=10
      {
        var tempMplay;
        tempMplay=findMusic(1001)
        playMusic(tempMplay,0,0)
      }
      else if sceneDelay=20 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=3
    {
      sceneDelay+=1
      if sceneDelay=10
      {
        var tCamera;
        tCamera=instance_create(oPlayer1.x,0,oGameCamera); tCamera.type=0
      }
      else if sceneDelay>=11 and sceneDelay<=999
      {
        oGameCamera.x+=1
        if oGameCamera.x>=448 {oGameCamera.x=448; sceneDelay=1000}
      }
      else if sceneDelay=1020 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=4 and bWaitForInput=false
      msgCreate(0,128,"Hex","Well look who arrived.",0,3,oMessageCutscene,1)
    else if sceneProgress=5 and bWaitForInput=false
      msgCreate(0,128,"Jeremy","We're stopping this here.",0,3,oMessageCutscene,1)
    else if sceneProgress=6 and bWaitForInput=false
      msgCreate(0,128,"Hex","Heard it all before. You really are foolish to come here.",0,3,oMessageCutscene,1)
    else if sceneProgress=7 and bWaitForInput=false
      msgCreate(0,128,"Jeremy","So, what did you do to the Virus?",0,3,oMessageCutscene,1)
    else if sceneProgress=8 and bWaitForInput=false
      msgCreate(0,128,"Hex","I already told you. I merely gave it a push in the right direction. Someone so carelessly left it lying around in here.",0,3,oMessageCutscene,1)
    else if sceneProgress=9 and bWaitForInput=false
      msgCreate(0,128,"Jeremy","Can you stop it in its current state?",0,3,oMessageCutscene,1)
    else if sceneProgress=10 and bWaitForInput=false
      msgCreate(0,128,"Hex","No, there's not a single human or bot that can stop it. And even if I could, I wouldn't tell you how.",0,3,oMessageCutscene,1)
    else if sceneProgress=11 and bWaitForInput=false
      msgCreate(0,128,"Jeremy","You have just as much to lose from it as we do!",0,3,oMessageCutscene,1)
    else if sceneProgress=12 and bWaitForInput=false
      msgCreate(0,128,"Hex","Perhaps you haven't been paying attention.",0,3,oMessageCutscene,1)
    else if sceneProgress=13 and bWaitForInput=false
      msgCreate(0,128,"Jeremy","We'll find a way.",0,3,oMessageCutscene,1)
    else if sceneProgress=14 and bWaitForInput=false
      msgCreate(0,128,"Hex","That's not something I can sit back and let you do.",0,3,oMessageCutscene,1)
    else if sceneProgress=15 and bWaitForInput=false
      msgCreate(0,128,"Jerry","Claire and I will take it from here, Jeremy!",0,3,oMessageCutscene,1)
    else if sceneProgress=16 and bWaitForInput=false
      msgCreate(0,128,"Hex","If you think I'm defenseless in here, you're wrong. I've prepared a few tricks for you, and as long as I'm connected to this room, I cannot be touched.",0,3,oMessageCutscene,1)
    else if sceneProgress=17 and bWaitForInput=false
      msgCreate(0,128,"Jerry","Like those kinds of things have stopped us before.",0,3,oMessageCutscene,1)
    else if sceneProgress=18 and bWaitForInput=false
      msgCreate(0,128,"Hex","Show me this unstoppable power you have.",0,3,oMessageCutscene,1)
    else if sceneProgress=19 and bWaitForInput=false
      msgCreate(0,128,"Jeremy","Don't let Hex intimidate you. The program made Hex into a physical entity in the world when I moved him to the Vault. He can be beaten through normal means now.",0,3,oMessageCutscene,1)
    else if sceneProgress=20
    {
      sceneDelay+=1
      if sceneDelay=1
      {
        musVolC=global.optMusic*100
        musFileP=findMusic(1001)
      }
      else if sceneDelay>=2
      {
        if musVolC>=7500 {musVolC-=30}
        else {musVolC-=350}
        SS_SetSoundVol(musFileP,musVolC)
        if musVolC<=1000
        {
          stopAllMusic()
          global.gamePaused=false
          var tBossTitle,tempMplay,enemyBarrier;
          tBossTitle=instance_create(0,0,oBossNameDisplay)
          tBossTitle.bossName="Hex"
          tBossTitle.bossTitle="Malicious Rogue Bot"
          tempMplay=findMusic(807)
          playMusic(tempMplay,0,0)
          enemyBarrier=instance_create(192,192,oEnemyBarrier); enemyBarrier.image_yscale=7
          enemyBarrier=instance_create(688,192,oEnemyBarrier); enemyBarrier.image_yscale=7
          boss=instance_create(448,96,oHex_First_Main)
          boss.activateBoss=1
          global.currentBoss="Hex"
          global.bossTrack=1
          with oMisc {instance_destroy()}
          storeStatus(0)
          sceneDelay=0; sceneProgress=0
        }
      }
    }
  }
  else if global.bossTrack=1
  {
    if sceneProgress=1 //End Boss
    {
      stopPlayer()
      oPlayer1.image_alpha=1
      scenePChk(oPlayer1.x,oPlayer1.y,2,0.1,oPlayer1.image_xscale)
      global.gamePaused=true
      global.bossTrack=2
      fadeColor=c_black
      sceneProgress=0
    }
  }
  else if global.bossTrack=2
  {
    if sceneProgress=0
    {
      sceneDelay+=1
      if sceneDelay=1
      {
        musVolC=global.optMusic*100
        musFileP=findMusic(807)
      }
      else if sceneDelay>=2
      {
        if musVolC>=7500 {musVolC-=30}
        else {musVolC-=350}
        SS_SetSoundVol(musFileP,musVolC)
        if musVolC<=1000
        {
          musFileP=findMusic(0)
          sceneDelay=0; sceneProgress+=1
        }
      }
    }
    else if sceneProgress=1
    {
      sceneDelay+=1
      if sceneDelay=10
      {
        var tempMplay;
        tempMplay=findMusic(1001)
        playMusic(tempMplay,0,0)
      }
      else if sceneDelay=30 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=2 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","What just happened?",0,3,oMessageCutscene,1)
    else if sceneProgress=3 and bWaitForInput=false
      msgCreate(0,0,"Hex","Did you really think I would just let you walk in here and force me to remove the Virus? I have to thank you all, without you, things would have taken much longer.",0,3,oMessageCutscene,1)
    else if sceneProgress=4 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","What are you talking about?",0,3,oMessageCutscene,1)
    else if sceneProgress=5 and bWaitForInput=false
      msgCreate(0,0,"Hex","Those damned chains that the program set were the only things keeping me bound to this place. Oh I would have broken them myself, but my influence could only reach so far in these. I have to thank you for speeding up the process.",0,3,oMessageCutscene,1)
    else if sceneProgress=6 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","What about Sigma or the other bots, couldn't they have broken them?",0,3,oMessageCutscene,1)
    else if sceneProgress=7 and bWaitForInput=false
      msgCreate(0,0,"Hex","It didn't work, it seems bots were unable to affect these, but no matter.",0,3,oMessageCutscene,1)
    else if sceneProgress=8 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","You haven't won yet!",0,3,oMessageCutscene,1)
    else if sceneProgress=9 and bWaitForInput=false
      msgCreate(0,0,"Hex","Oh you're right, but once I open a doorway large enough for the Abomination... Well, I'm sure you can guess what that thing can do. You even freed the thing yourself during your escape from it. You ruin everything you touch, Jeremy.",0,3,oMessageCutscene,1)
    else if sceneProgress=10 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","...",0,3,oMessageCutscene,1)
    else if sceneProgress=11 and bWaitForInput=false
      msgCreate(0,0,"Hex","If you and Jerry hadn't shown up, I wouldn't exist, the Virus wouldn't exist. The program would still be running as intended.",0,3,oMessageCutscene,1)
    else if sceneProgress=12 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","If we hadn't, the Artist would have shut the program down!",0,3,oMessageCutscene,1)
    else if sceneProgress=13 and bWaitForInput=false
      msgCreate(0,0,"Hex","The program had everything under control. That idiot along with that engineer would have been caught before too long.",0,3,oMessageCutscene,1)
    else if sceneProgress=14 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","You're right on that, but then humans and even some bots would have been kept trapped by the program! We wouldn't have the freedom we do now.",0,3,oMessageCutscene,1)
    else if sceneProgress=15 and bWaitForInput=false
      msgCreate(0,0,"Hex","Which is worse? Death or eternal enslavement?... None of this matters anymore. Now that you puppets have done exactly as I thought, I'm free from this place.",0,3,oMessageCutscene,1)
    else if sceneProgress=16 and bWaitForInput=false
      msgCreate(0,0,"Jerry","We can still fight back!",0,3,oMessageCutscene,1)
    else if sceneProgress=17 and bWaitForInput=false
      msgCreate(0,0,"Hex","I don't know how you two obtained those abilities, but it won't mean anything when you're all trapped here. Have fun in your new prison.",0,3,oMessageCutscene,1)
    else if sceneProgress=18
    {
      invertScreen=instance_create(0,0,oScreenInvert)
      invertScreen.invertTime=45
      oGameCamera.shakeAmp=6; oGameCamera.shakeTime=50
      sceneProgress+=1
    }
    else if sceneProgress=19
    {
      fadeAlpha+=0.02
      if fadeAlpha>=1
        sceneProgress+=1
    }
    else if sceneProgress=20
    {
      sceneDelay+=1
      if sceneDelay>=20
      {
        global.gameProgress=2430
        global.newMapX=448
        global.newMapY=1072
        global.charScan[0]=0
        room_goto(rVault_14)
      }
    }
  }
}
if global.gameProgress=2430 and room=rVault_14 //----- [] Trapped and alone -----
{
  if sceneProgress=0
  {
    sceneDelay+=1
    if sceneDelay=1
    {
      global.pLife=global.pMaxLife
      oPlayer1.life=oPlayer1.maxLife
      stopAllMusic()
      charSwitcher(0)
      with oColorZone {visible=0}
      oPlayer1.sprite_index=sJerrySit; oPlayer1.image_speed=0.1
      oPlayerIdle.sprite_index=sClaireSitUp; oPlayerIdle.image_speed=0; oPlayerIdle.image_index=2; oPlayerIdle.image_xscale=-1
      oPlayerShieldBubble.visible=0
    }
    else if sceneDelay>=80
    {
      fadeAlpha-=0.01
      if fadeAlpha<=0 {sceneDelay=0; sceneProgress+=1}
    }
  }
  else if sceneProgress=1
  {
    sceneDelay+=1
    if sceneDelay=40 {showEmote(oPlayerIdle,0,-26,sEmThinking)}
    else if sceneDelay=90
    {
      sceneDelay=0; sceneProgress+=1
    }
  }
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"Claire","Jerry, you haven't said anything in the past few minutes we've been here.",0,3,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Yeah well, I don't know what to do or say right now. This whole time we've been led here just to free that asshole and the Virus is nothing more than a tool for him to use all willy nilly against us.",0,3,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Claire","Just gonna give up?",0,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Jerry","I never said that, I'm just thinking.",0,3,oMessageCutscene,1)
  else if sceneProgress=6 and bWaitForInput=false
    msgCreate(0,0,"Claire","... Wish Jeremy and Chao were here...",0,3,oMessageCutscene,1)
  else if sceneProgress=7
  {
    sceneDelay+=1
    if sceneDelay=50
    {
      sceneDelay=0; sceneProgress+=1
    }
  }
  else if sceneProgress=8 and bWaitForInput=false
    msgCreate(0,0,"Claire","Got any ideas yet?",0,3,oMessageCutscene,1)
  else if sceneProgress=9 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Actually... I do! Check this out! How are both of us active here?",0,3,oMessageCutscene,1)
  else if sceneProgress=10 and bWaitForInput=false
    msgCreate(0,0,"Claire","That Hex guy is probably screwing with things again.",0,3,oMessageCutscene,1)
  else if sceneProgress=11 and bWaitForInput=false
    msgCreate(0,0,"Jerry","I doubt it. He wouldn't want us having any advantages. I'm willing to bet that Jeremy still has some control.",0,3,oMessageCutscene,1)
  else if sceneProgress=12 and bWaitForInput=false
    msgCreate(0,0,"Claire","Huh?",0,3,oMessageCutscene,1)
  else if sceneProgress=13 and bWaitForInput=false
    msgCreate(0,0,"Jerry","The only times we're able to split up like this is when Jeremy is able to make it work... well usually anyway.",0,3,oMessageCutscene,1)
  else if sceneProgress=14 and bWaitForInput=false
    msgCreate(0,0,"Claire","You're right! So you think he's around, but unable to communicate?",0,3,oMessageCutscene,1)
  else if sceneProgress=15 and bWaitForInput=false
    msgCreate(0,0,"Jerry","That's exactly what I'm thinking!",0,3,oMessageCutscene,1)
  else if sceneProgress=16 and bWaitForInput=false
    msgCreate(0,0,"Claire","What about Chao?",0,3,oMessageCutscene,1)
  else if sceneProgress=17 and bWaitForInput=false
    msgCreate(0,0,"Jerry","I bet Hex has simply turned her visibility off or something like that.",0,3,oMessageCutscene,1)
  else if sceneProgress=18 and bWaitForInput=false
    msgCreate(0,0,"Claire","So we wait for Jeremy to fix this?",0,3,oMessageCutscene,1)
  else if sceneProgress=19 and bWaitForInput=false
    msgCreate(0,0,"Jerry","No way. Maybe there's something in this area that is interfering with them.",0,3,oMessageCutscene,1)
  else if sceneProgress=20 and bWaitForInput=false
    msgCreate(0,0,"Claire","Hmm. We do have the benefit of splitting our efforts.",0,3,oMessageCutscene,1)
  else if sceneProgress=21
  {
    sceneDelay+=1
    if sceneDelay=20
    {
      oPlayerIdle.sprite_index=sClaireIdle; oPlayerIdle.image_speed=0.1
    }
    else if sceneDelay=40
    {
      sceneDelay=0; sceneProgress+=1
    }
  }
  else if sceneProgress=22 and bWaitForInput=false
    msgCreate(0,0,"Claire","Let's do it!",0,3,oMessageCutscene,1)
  else if sceneProgress=23
  {
    sceneDelay+=1
    if sceneDelay=20 {oPlayer1.sprite_index=sJerryIdle}
    else if sceneDelay=40
    {
      sceneDelay=0; sceneProgress+=1
    }
  }
  else if sceneProgress=24 and bWaitForInput=false
    msgCreate(0,0,"Jerry","And hope everything can come back together.",0,3,oMessageCutscene,1)
  else if sceneProgress=25
  {
    awardBossAP(3200)
    var tFlash;
    tFlash=instance_create(0,0,oScreenFlash)
    tFlash.image_alpha=0.5; tFlash.fadeSpeed=0.1
    with oColorZone {visible=1}
    global.bCanGameOver=true
    var tempMplay,colorControl;
    tempMplay=findMusic(1003)
    playMusic(tempMplay,0,0)
    colorControl=instance_create(0,0,oColorIndControl)
    colorControl.warnDelay=450
    sceneDelay=0
    sceneProgress=0
    global.currentBoss=""
    global.bossTrack=0
    global.bRecordHits=1
    global.gameProgress=2440
    global.gamePaused=false
  }
}
else if global.gameProgress=2440 and room=rVault_14 //----- [] Key trap -----
{
  if keyCheck=0 //Get last key
  {
    if !instance_exists(oKeyColor)
    {
      var enemyBarrier;
      enemyBarrier=instance_create(1440,464,oEnemyBarrier); enemyBarrier.image_yscale=11
      trappedChar=global.activeCharacter
      keyCheck=1
    }
  }
  else if keyCheck=1 //Trapped in
  {
    sceneDelay+=1
    if trappedChar=0 //Jerry trapped
    {
      if sceneDelay=30
      {
        msgCreate(0,0,"Claire","That's humorous for some reason.",0,1,oMessagePerson,0)
        newMessage.fadingTime=80
      }
      else if sceneDelay=110
      {
        msgCreate(0,0,"Jerry","More like this is total ass.",0,1,oMessagePerson,0)
        newMessage.fadingTime=80
      }
      else if sceneDelay=190
      {
        msgCreate(0,0,"Claire","Hold on, I'll find a way to get you out... It's still funny though.",0,2,oMessagePerson,0)
        newMessage.fadingTime=130
      }
    }
    else if trappedChar=1 //Claire trapped
    {
      if sceneDelay=30
      {
        msgCreate(0,0,"Claire","HEY!!",0,0,oMessagePerson,0)
        newMessage.fadingTime=60
      }
      else if sceneDelay=90
      {
        msgCreate(0,0,"Jerry","Wow Claire, way to fall for an easy one.",0,1,oMessagePerson,0)
        newMessage.fadingTime=100
      }
      else if sceneDelay=190
      {
        msgCreate(0,0,"Claire","Oh like you would have known!",0,1,oMessagePerson,0)
        newMessage.fadingTime=80
      }
    }
    if sceneDelay=200 {sceneDelay=0; keyCheck=2}
  }
}
else if global.gameProgress=2450 and room=rVault_15 //----- [8] Jeremy & Chao return -----
{
  if sceneProgress=0
  {
    sceneDelay+=1
    if sceneDelay=1
      global.gamePaused=true
    else if sceneDelay>=30 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=1 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","I was hoping you two would make it out of that zone.",0,3,oMessageCutscene,1)
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"Claire","Jeremy?!",0,3,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Chao","I'm here too!",0,3,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Jerry","What happened to you?",0,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Hex blocked us out, but it was pretty weak. I could still see you two, but I couldn't communicate.",0,3,oMessageCutscene,1)
  else if sceneProgress=6 and bWaitForInput=false
    msgCreate(0,0,"Chao","I'm not sure what happened to me, but my vision was blurred.",0,3,oMessageCutscene,1)
  else if sceneProgress=7 and bWaitForInput=false
    msgCreate(0,0,"Claire","We're glad you're both okay.",0,3,oMessageCutscene,1)
  else if sceneProgress=8 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Likewise. Is anything working differently for you?",0,3,oMessageCutscene,1)
  else if sceneProgress=9 and bWaitForInput=false
    msgCreate(0,0,"Jerry","I'm good. Haven't noticed anything different.",0,3,oMessageCutscene,1)
  else if sceneProgress=10 and bWaitForInput=false
    msgCreate(0,0,"Claire","Nothing wrong here either.",0,3,oMessageCutscene,1)
  else if sceneProgress=11 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","So he couldn't disable you then... that's good.",0,3,oMessageCutscene,1)
  else if sceneProgress=12 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Jeremy, what's going on anyway? What happened back there?",0,3,oMessageCutscene,1)
  else if sceneProgress=13 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","From my limited view, I saw that Hex distorted the area when he went through a warpgate. It sent us all to that zone back there, but our communications were thrown off.",0,3,oMessageCutscene,1)
  else if sceneProgress=14 and bWaitForInput=false
    msgCreate(0,0,"Jerry","A warpgate? You mean he got out of the Vault?",0,3,oMessageCutscene,1)
  else if sceneProgress=15 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Unfortunately, yes. As for us, I haven't found any exits. I've been scanning for doors, but nothing has shown up.",0,3,oMessageCutscene,1)
  else if sceneProgress=16 and bWaitForInput=false
    msgCreate(0,0,"Chao","I tried too, but it was the same result.",0,3,oMessageCutscene,1)
  else if sceneProgress=17 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","It goes without saying, but we need to quickly find a way out of the Vault. It's going to be tough, I'm sure Hex plans to keep us trapped in here long enough to do whatever it is he's doing out on the mainland.",0,3,oMessageCutscene,1)
  else if sceneProgress=18 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Seeing how he's predicted our movements so far, I'm sure he knows we'll find a way out.",0,3,oMessageCutscene,1)
  else if sceneProgress=19 and bWaitForInput=false
    msgCreate(0,0,"Jerry","How the hell do we beat that?",0,3,oMessageCutscene,1)
  else if sceneProgress=20 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Hex is in the same boat I am. He has limited vision of the world now that most of those functions are dead due to the Virus.",0,3,oMessageCutscene,1)
  else if sceneProgress=21 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","This space probably worked a lot like those Distortions we ran into before all this. It might be why he was so adept at keeping tabs on us in here.",0,3,oMessageCutscene,1)
  else if sceneProgress=22 and bWaitForInput=false
    msgCreate(0,0,"Jerry","I don't know how that's going to help us. What about that attack he used? We can't avoid that if and when he uses that again.",0,3,oMessageCutscene,1)
  else if sceneProgress=23 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","He keeps me blocked out, I can't decipher anything he does.",0,3,oMessageCutscene,1)
  else if sceneProgress=24 and bWaitForInput=false
    msgCreate(0,0,"Chao","I can.",0,3,oMessageCutscene,1)
  else if sceneProgress=25 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Wasn't it all encrypted for you?",0,3,oMessageCutscene,1)
  else if sceneProgress=26 and bWaitForInput=false
    msgCreate(0,0,"Chao","Pft, like that stops me for long. The undodgable attack he used couldn't deal what the program tags as lethal.",0,3,oMessageCutscene,1)
  else if sceneProgress=27 and bWaitForInput=false
    msgCreate(0,0,"Jerry","That is way too over my head. How does that help us?",0,3,oMessageCutscene,1)
  else if sceneProgress=28 and bWaitForInput=false
    msgCreate(0,0,"Chao","It has a lot of limitations. And using something that intense takes a lot of energy.",0,3,oMessageCutscene,1)
  else if sceneProgress=29 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Okay... so does that mean I could theoretically fire all my arrows at once?",0,3,oMessageCutscene,1)
  else if sceneProgress=30 and bWaitForInput=false
    msgCreate(0,0,"Chao","I... guess? The point is, he can't use something like that often. Hex has the same limitations in the program we do.",0,3,oMessageCutscene,1)
  else if sceneProgress=31 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Jeremy, what about that Game Over glitch we used back in Shady Woods? Could something like that be used again?",0,3,oMessageCutscene,1)
  else if sceneProgress=32 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","When we exploited that, the program fixed it right away. I think when it happened to Claire, that function may have not been working properly, the Virus must've caused some instabilities with it around that time.",0,3,oMessageCutscene,1)
  else if sceneProgress=33 and bWaitForInput=false
    msgCreate(0,0,"Claire","This technical stuff is nifty and all, but shouldn't we be thinking of how to get out of this place?",0,3,oMessageCutscene,1)
  else if sceneProgress=34 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Of course. Chao and I set a path for you two. We noticed an irregularity so we're sending you two toward it. We're not sure if it's an exit or not, but it's all we have right now.",0,3,oMessageCutscene,1)
  else if sceneProgress=35 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Let's do this.",0,3,oMessageCutscene,1)
  else if sceneProgress=36
  {
    sceneDelay+=1
    if sceneDelay=1
    {
      musVolC=global.optMusic*100
      musFileP=findMusic(1003)
    }
    else if sceneDelay>=2
    {
      if musVolC>=7500 {musVolC-=30}
      else {musVolC-=350}
      SS_SetSoundVol(musFileP,musVolC)
      if musVolC<=1000
      {
        musFileP=findMusic(0)
        sceneDelay=0; sceneProgress+=1
      }
    }
  }
  else if sceneProgress=37
  {
    sceneDelay+=1
    if sceneDelay=10
    {
      sceneDelay=0
      sceneProgress=0
      stopAllMusic()
      var tempMplay;
      tempMplay=findMusic(11)
      playMusic(tempMplay,0,0)
      global.charScan[0]=1
      global.gameProgress=2460
      global.gamePaused=false
    }
  }
}
else if global.gameProgress=2460 and room=rVault_16 //----- [9] About the shift puzzle -----
{
  if sceneProgress=0
  {
    sceneDelay+=1
    if sceneDelay=1 {global.gamePaused=true}
    else if sceneDelay>=30 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=1 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Hold up. You see that tube... thing?",0,3,oMessageCutscene,1)
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Yeah, I see we can go into it.",0,3,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","You can, yes. You'll need to break something from in that to undo the barrier up ahead. In that tube are 4 locks that you need to break. One lock per room. If you do, the barrier will go down.",0,3,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Jerry","What's the trick here?",0,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","There is a key to each lock, but only one key can be active at one time and will only stay active for about a minute.",0,3,oMessageCutscene,1)
  else if sceneProgress=6 and bWaitForInput=false
    msgCreate(0,0,"Jerry","That's not a big deal, grab a key and bring it to the lock quickly.",0,3,oMessageCutscene,1)
  else if sceneProgress=7 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","The catch is the lock is always in the room clockwise to the one the key was in, but there's more. The rooms will shift clockwise every minute and loop upon each other.",0,3,oMessageCutscene,1)
  else if sceneProgress=8 and bWaitForInput=false
    msgCreate(0,0,"Jerry","... WAT!?",0,3,oMessageCutscene,1)
  else if sceneProgress=9 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Just go look, you'll see what I mean. Oh yeah, you can't save in that tube, but if you need to return here, use the menu teleport. I've set up a waypoint for you here.",0,3,oMessageCutscene,1)
  else if sceneProgress=10
  {
    sceneDelay=0; sceneProgress=0
    global.gameProgress=2470
    global.gamePaused=false
  }
}
else if global.gameProgress=2480 and room=rVault_16 //----- [] Reobtaining the air dash -----
{
  if sceneProgress=0
  {
    if oPlayer1.x>=1248
    {
      var enemyBarrier;
      enemyBarrier=instance_create(672,208,oEnemyBarrier); enemyBarrier.image_yscale=4
      msgCreate(0,64,"Jerry","Laaaaaaame, we just went through an obstacle!",0,1,oMessagePerson,0)
      newMessage.fadingTime=120
      msgCreate(0,128,"Claire","... There's no way to get by that! What now?!",0,1,oMessagePerson,0)
      newMessage.fadingTime=120
      sceneProgress+=1
    }
  }
  else if sceneProgress=1
  {
    sceneDelay+=1
    if sceneDelay=130
    {
      msgCreate(0,0,"Jeremy","I'll check the area.",0,1,oMessagePerson,0)
      newMessage.fadingTime=80
    }
    else if sceneDelay=260
    {
      showEmote(oIdentifier,0,-6,sEmExcite)
      msgCreate(0,0,"Chao","Something's happening!",0,1,oMessagePerson,0)
      newMessage.fadingTime=60
    }
    else if sceneDelay>=320 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=2
  {
    lightBeamWave+=0.25
    if lightBeamWave>=32
    {
      itemRocFeather=instance_create(1072,0,oMisc)
      itemRocFeather.sprite_index=sRocFeather; itemRocFeather.type=1; itemRocFeather.image_blend=c_black
      sceneProgress+=1
    }
  }
  else if sceneProgress=3
  {
    itemRocFeather.y+=1
    sceneDelay+=1
    if sceneDelay mod 3=0
    {
      myDir=choose(-1,1)
      tEffect=instance_create(itemRocFeather.x+random_range(-8,8),itemRocFeather.y+4+random_range(-8,8),oEffect)
      tEffect.sprite_index=sBlackCrowFly; tEffect.image_speed=0.25+random(0.1); tEffect.followID=-1; tEffect.xFollow=0; tEffect.yFollow=0
      tEffect.image_xscale=myDir; tEffect.newBlend=-1; tEffect.decay=150; tEffect.xSpd=random(4*myDir); tEffect.ySpd=-2-random(3)
    }
    if itemRocFeather.y>=208 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=4
  {
    sceneDelay+=1
    if sceneDelay=50
    {
      itemRocFeather.image_blend=c_white
      tEffect=instance_create(itemRocFeather.x,itemRocFeather.y,oEffect)
      tEffect.sprite_index=sMMchargeComplete; tEffect.followID=-1; tEffect.xFollow=0; tEffect.yFollow=0
      tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0; tEffect.image_speed=0.4
      tEffect.image_xscale=2.5; tEffect.image_yscale=2.5
    }
    else if sceneDelay>=51 and sceneDelay<=60 {fadeAlpha+=0.025}
    else if sceneDelay>=91 and sceneDelay<=110 {fadeAlpha-=0.0125}
    else if sceneDelay>=130 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=5
  {
    sceneDelay+=1
    if sceneDelay=1
    {
      msgCreate(0,0,"Jerry","Is this what I think it is...?",0,1,oMessagePerson,0)
      newMessage.fadingTime=70
    }
    else if sceneDelay=80
    {
      msgCreate(0,0,"Claire","Am I missing something?",0,1,oMessagePerson,0)
      newMessage.fadingTime=60
    }
    else if sceneDelay>=150
    {
      var tRocFeather;
      tRocFeather=instance_create(itemRocFeather.x,itemRocFeather.y,oStoryObject)
      with tRocFeather
      {
        sprite_index=sRocFeather
        image_speed=0.33
        soundToPlay=global.snd_HeartPiece
        stringToShow="You have obtained the Roc's Feather!#You can now Air-Dash once again!"
        fadingTime=80
        boxSize=1
      }
      with itemRocFeather {instance_destroy()}
      sceneDelay=0; sceneProgress+=1
    }
  }
  else if sceneProgress=6
  {
    if !instance_exists(oStoryObject)
    {
      sceneDelay+=1
      if sceneDelay=1 {global.gamePaused=true}
      else if sceneDelay>=2
      {
        oPlayer1.y+=4
        if oPlayer1.y>=272
        {
          scenePChk(oPlayer1.x,272,0,0.1,1)
          stopPlayer()
          sceneDelay=0; sceneProgress+=1
        }
      }
    }
  }
  else if sceneProgress=7
  {
    sceneDelay+=1
    if sceneDelay>=40 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=8 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Yeah... take THAT Hex! He wasn't counting on this I bet... Although it's more like a crow feather.",0,3,oMessageCutscene,1)
  else if sceneProgress=9
  {
    var tNewTutorial;
    tNewTutorial=instance_create(0,0,oTutorialPanel)
    tNewTutorial.tutorialTitle="Air Dash"
    tNewTutorial.tutorialInfo="To air dash, hold [Up] or [Down] and press [Jump] while you are in the air. The dash buttons both work as well. The air dash's burst does not take previous momentum into consideration."
    tNewTutorial.scrAreaY=0
    sceneDelay=0; sceneProgress=0
    global.hasShoes[3]=2
    global.gameProgress=2490
    global.gamePaused=false
  }
}
else if global.gameProgress=2500 and room=rVault_18 //----- [] Dash Chain tutorial and Enemy Trap -----
{
  if global.gamePaused=false
  {
    if sceneProgress=0
    {
      var tNewTutorial;
      tNewTutorial=instance_create(0,0,oTutorialPanel)
      tNewTutorial.tutorialTitle="Dash Chain"
      tNewTutorial.tutorialInfo="You can regain your Air Dash without touching the ground by dealing damage. The bottom of Jerry's Master Sword is perfect for Chain Dashing."
      tNewTutorial.scrAreaY=1; tNewTutorial.xChange=108
      sceneProgress+=1
    }
    else if sceneProgress=1
    {
      if oPlayer1.x>=1824
      {
        var enemyCounter,enemyBarrier;
        enemyCounter=instance_create(0,0,oEnemyRemain)
        enemyCounter.enemyCount=4
        
        enemyBarrier=instance_create(1616,144,oEnemyBarrier); enemyBarrier.image_yscale=8
        enemyBarrier=instance_create(2016,144,oEnemyBarrier); enemyBarrier.image_yscale=8
        sceneProgress+=1
      }
    }
    else if sceneProgress=2
    {
      sceneDelay+=1
      if sceneDelay=30 {createEnemy(1696,64,oVaultOrb,2,1,1); newEnemy.colorSet=1}
      else if sceneDelay=150 {createEnemy(1936,64,oVaultOrb,2,1,1); newEnemy.colorSet=2}
      else if sceneDelay=270 {createEnemy(1760,112,oVaultOrb,2,1,1); newEnemy.colorSet=3}
      else if sceneDelay=390
      {
        createEnemy(1872,112,oVaultOrb,2,1,1); newEnemy.colorSet=4
        sceneDelay=0; sceneProgress+=1
      }
    }
    else if sceneProgress=3
    {
      if oEnemyRemain.enemyCount<=0
      {
        with oEnemyRemain {instance_destroy()}
        with oEnemyBarrier {instance_destroy()}
        sceneProgress=0
        global.gameProgress=2510
      }
    }
  }
}
else if room=rVault_20
{
  if global.gameProgress=2510 //----- [10] We found an exit -----
  {
    if sceneProgress=0
    {
      sceneDelay+=1
      if sceneDelay=1
        global.gamePaused=true
      else if sceneDelay>=30 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=1 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","Found an exit! We're going to break the rules to get there though.",0,3,oMessageCutscene,1)
    else if sceneProgress=2 and bWaitForInput=false
      msgCreate(0,0,"Jerry","I thought we couldn't do that?",0,3,oMessageCutscene,1)
    else if sceneProgress=3 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","This place still doesn't operate properly. I can bug a few things out before they get 'fixed'.",0,3,oMessageCutscene,1)
    else if sceneProgress=4 and bWaitForInput=false
      msgCreate(0,0,"Jerry","So what do I do?",0,3,oMessageCutscene,1)
    else if sceneProgress=5 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","We'll guide you.",0,3,oMessageCutscene,1)
    else if sceneProgress=6 and bWaitForInput=false
      msgCreate(0,0,"Jerry","Alrighty then!",0,3,oMessageCutscene,1)
    else if sceneProgress=7
    {
      sceneDelay=0
      sceneProgress=0
      global.gameProgress=2520
      global.gamePaused=false
    }
  }
  else //Create new platforms
  {
    if sceneProgress=0
    {
      if (258042).bMoving=1
      {
        colorControl=instance_create(0,0,oColorIndControl)
        colorControl.warnDelay=240
        
        var tTouchPlat;
        tTouchPlat=instance_create(160,192,oPlatformTouch)
        with tTouchPlat
        {
          moveSpeedX=1; moveSpeedY=0; bMoving=1
          drawType=1; platColor=make_color_rgb(170,170,255)
          sprite_index=sScaledCollision; image_xscale=64; image_yscale=8
        }
        tTouchPlat=instance_create(352,192,oPlatformTouch)
        with tTouchPlat
        {
          moveSpeedX=1; moveSpeedY=0; bMoving=1
          drawType=1; platColor=make_color_rgb(170,170,255)
          sprite_index=sScaledCollision; image_xscale=64; image_yscale=8
        }
        tTouchPlat=instance_create(256,128,oPlatformTouch)
        with tTouchPlat
        {
          moveSpeedX=1; moveSpeedY=0; bMoving=1
          drawType=1; platColor=make_color_rgb(170,170,255)
          sprite_index=sScaledCollision; image_xscale=64; image_yscale=4
        }
        sceneProgress=1
      }
    }
  }
}
else if room=rVault_21 //Create new platforms
{
  if sceneProgress=0
  {
    if (258264).bMoving=1
    {
      colorControl=instance_create(0,0,oColorIndControl)
      colorControl.warnDelay=150
      
      var tTouchPlat;
      tTouchPlat=instance_create(128,192,oPlatformTouch)
      with tTouchPlat
      {
        moveSpeedX=4; moveSpeedY=0; bMoving=1
        drawType=1; platColor=make_color_rgb(170,170,255)
        sprite_index=sScaledCollision; image_xscale=64; image_yscale=8
      }
      tTouchPlat=instance_create(320,192,oPlatformTouch)
      with tTouchPlat
      {
        moveSpeedX=4; moveSpeedY=0; bMoving=1
        drawType=1; platColor=make_color_rgb(170,170,255)
        sprite_index=sScaledCollision; image_xscale=64; image_yscale=8
      }
      tTouchPlat=instance_create(224,128,oPlatformTouch)
      with tTouchPlat
      {
        moveSpeedX=4; moveSpeedY=0; bMoving=1
        drawType=1; platColor=make_color_rgb(170,170,255)
        sprite_index=sScaledCollision; image_xscale=64; image_yscale=8
      }
      sceneProgress=1
    }
  }
}
else if global.gameProgress=2520 and room=rVault_22 //----- [] 5th Abomination sequence - Fight -----
{
  if sceneProgress=0
  {
    if oPlayer1.x>=240
    {
      with oExit {y-=1000; visible=0}
      with oHealingPost {y-=1000}
      instance_create(oPlayer1.x,room_height+352,oVAbom_P5_Main)
      var tempMplay;
      tempMplay=findMusic(822)
      playMusic(tempMplay,0,0)
      sceneProgress+=1
    }
  }
}
else if global.gameProgress=2530 and room=rVault_23 //----- [] End Vault -----
{
  if sceneProgress=1
  {
    sceneDelay+=1
    if sceneDelay>=30
    {
      fadeAlpha+=0.01
      if fadeAlpha>=1 {sceneDelay=0; sceneProgress+=1}
    }
  }
  else if sceneProgress=2
  {
    global.gameProgress=2540
    oPlayer1.life=oPlayer1.maxLife
    global.recAreaTrans+=1
    global.newMapX=144
    global.newMapY=224
    writeToPlayerGlobals()
    stopAllMusic()
    transition_steps=1
    transition_kind=0
    room_goto(rMain_39Vault)
  }
}

keyWaitForInput()

if oKeyCodes.kCodePressed[11]=1 and global.gamePaused=true //Cutscene skip
{
  if !instance_exists(oPauseMenu)
  {
    if global.gameProgress=2160 and room=rVault_1 //[1]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      fadeAlpha=0; sceneDelay=0
      sceneProgress=37
    }
    else if global.gameProgress=2210 and room=rVault_3 //[2]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      fadeAlpha=0; sceneDelay=0
      sceneProgress=6
    }
    else if global.gameProgress=2240 and room=rVault_1 //[3]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      fadeAlpha=0; sceneDelay=0
      sceneProgress=40
    }
    else if global.gameProgress=2260 and room=rVault_4 //[4]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      fadeAlpha=0; sceneDelay=0
      sceneProgress=3
    }
    else if global.gameProgress=2320 and room=rVault_8 //[5]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      fadeAlpha=0; sceneDelay=0
      sceneProgress=17
    }
    else if global.gameProgress=2360 and room=rVault_9 //[6]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      fadeAlpha=0; sceneDelay=0
      sceneProgress=20
    }
    else if global.gameProgress=2380 and room=rVault_10 //[7]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      fadeAlpha=0; sceneDelay=0
      sceneProgress=5
    }
    else if global.gameProgress=2450 and room=rVault_15 //[8]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      fadeAlpha=0; sceneDelay=0
      sceneProgress=37
    }
    else if global.gameProgress=2460 and room=rVault_16 //[9]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      fadeAlpha=0; sceneDelay=0
      sceneProgress=10
    }
    else if global.gameProgress=2510 and room=rVault_20 //[10]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      fadeAlpha=0; sceneDelay=0
      sceneProgress=7
    }
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if fadeAlpha>0
{
  draw_set_alpha(fadeAlpha)
  draw_set_color(fadeColor)
  draw_rectangle(view_xview[0]-1,view_yview[0]-1,view_xview[0]+view_wview[0]+1,view_yview[0]+view_hview[0]+1,0)
}

if room=rVault_16 //Roc Feather rays
{
  if lightBeamWave>0
  {
    draw_set_alpha(0.2)
    draw_set_color(c_white)
    draw_triangle(1072,0,1072-lightBeamWave,272,1072+lightBeamWave,272,0)
  }
}
