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

runeProg=0
if room=rDCS_G
{
  if global.newMapX>=512 {spiderTrap=100}
  else {spiderTrap=0}
}
else if room=rDCS_H
{
  runeCheck=string_char_at(global.gameDCS_Prog,1)
}
else if room=rDCS_N
{
  runeCheck=string_char_at(global.gameDCS_Prog,3)
}
else if room=rDCS_O
{
  runeCheck=string_char_at(global.gameDCS_Prog,4)
}
else if room=rDCS_Q
{
  runeCheck=string_char_at(global.gameDCS_Prog,4)
}
else if room=rDCS_S
{
  if global.newMapX>=512
  {
    with oTempleGhost {instance_destroy()}
    with oEventBarrier {instance_destroy()}
    ghostDoors=100
  }
  else {ghostDoors=0}
}
else if room=rDCS_U
{
  hexFlash=0
  hexTime=0
  hexX=0; hexY=0
  roomShake=0
}
else if room=rDCS_V
{
  portalWave=0
  pullIn=0
  pullSpeed=0
  effectTime=0
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if room=rDCS_A
{
  if global.gameProgress=4720 //----- [1] Intro to Construction Site -----
  {
    if sceneProgress=0
    {
      sceneDelay+=1
      if sceneDelay=1 {global.gamePaused=true}
      if sceneDelay>=20 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=1 and bWaitForInput=false
      msgCreate(0,0,"Jerry","Didn't Bubblun say this was more like... well you know, not this?",0,3,oMessageCutscene,1)
    else if sceneProgress=2 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","It probably was at some point, but CHAOS has been here. They've been here for awhile.",0,3,oMessageCutscene,1)
    else if sceneProgress=3 and bWaitForInput=false
      msgCreate(0,0,"Jerry","What do we do then? Are they still around?",0,3,oMessageCutscene,1)
    else if sceneProgress=4 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","CHAOS is still here, and they haven't dug up the entire temple. I say we stick to the plan and find that piece. I'm sure there's an entrance here somewhere.",0,3,oMessageCutscene,1)
    else if sceneProgress=5
    {
      sceneDelay=0; sceneProgress=0
      global.gameProgress=4730
      global.gamePaused=false
    }
  }
  else if global.gameProgress=4730 //Checkpoint
  {
    if oPlayer1.x>=2976
    {
      instance_create(0,0,oCheckpointNotice)
      writeToPlayerGlobals()
      global.newMapX=2976; global.newMapY=112
      global.gameProgress=4740
    }
  }
  else if global.gameProgress=4740 //Defeat 2 CHAOS Snipers
  {
    if !instance_exists(oCHAOS_Sniper)
    {
      msgCreate(0,0,"Jeremy","And there you go, they're around!",0,1,oMessagePerson,0)
      newMessage.fadingTime=80
      global.gameProgress=4750
    }
  }
}
else if room=rDCS_B //Introduce CHAOS Healer
{
  if global.gameProgress=4750
  {
    if sceneProgress=0
    {
      if oPlayer1.x>=2640
      {
        with oEnemyBase
        {
          life=0
        }
        var tNewEnemy,enemyBarrier;
        enemyBarrier=instance_create(2160,0,oEnemyBarrier); enemyBarrier.image_yscale=24
        tNewEnemy=instance_create(2464,384,oCHAOS_ShockUnit); tNewEnemy.bActive=1
        tNewEnemy=instance_create(2816,384,oCHAOS_ShockUnit); tNewEnemy.bActive=1
        tNewEnemy=instance_create(2640,208,oCHAOS_Healer); tNewEnemy.bActive=1
        sceneProgress+=1
      }
    }
    else if sceneProgress=1
    {
      sceneDelay+=1
      if sceneDelay>=50 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=2
    {
      if !instance_exists(oEnemyBase)
      {
        global.gameProgress=4760
        sceneProgress=10
      }
    }
  }
  else if global.gameProgress=4760
  {
    if sceneProgress=10
    {
      sceneDelay+=1
      if sceneDelay=20
      {
        msgCreate(0,0,"Jeremy","What the heck was up with that...?",0,1,oMessagePerson,0)
        newMessage.fadingTime=70
      }
      else if sceneDelay=90
      {
        msgCreate(0,0,"Jerry","They have a healing bot, Jeremy! A HEALING BOT, why is that a thing?!",0,1,oMessagePerson,0)
        newMessage.fadingTime=130
      }
      else if sceneDelay=220
      {
        msgCreate(0,0,"Jeremy","I uh, don't know? I don't have an uplink to some CHAOS database or anything.",0,2,oMessagePerson,0)
        newMessage.fadingTime=140
      }
      else if sceneDelay=360
      {
        msgCreate(0,0,"Jerry","I hate everything about that thing, I just want to get that out there.",0,1,oMessagePerson,0)
        newMessage.fadingTime=140
      }
    }
  }
}
else if room=rDCS_D and global.gameProgress=4760 //----- [2] Cramped places -----
{
  if sceneProgress=0
  {
    sceneDelay+=1
    if sceneDelay=1 {global.gamePaused=true}
    if sceneDelay>=20 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=1 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Oooh man, I don't like this... Small cramped places...",0,3,oMessageCutscene,1)
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","CHAOS is also all over the place here.",0,3,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Claire","Any idea why they are here? You don't think they're looking for the Dragoon piece, do you?",0,3,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","I doubt it. That establishment back up at the surface shows they've been here for awhile. I'm sure they're using this place for another bot building facility since no other bots came out here often.",0,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Chao","I don't think they've gone too far down here though. Maybe these ruins aren't too kind to other bots.",0,3,oMessageCutscene,1)
  else if sceneProgress=6 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Hmm, if it isn't, maybe we can use that to our advantage.",0,3,oMessageCutscene,1)
  else if sceneProgress=7 and bWaitForInput=false
    msgCreate(0,0,"Claire","Any idea where the piece is?",0,3,oMessageCutscene,1)
  else if sceneProgress=8 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Knowing your luck, probably as far down as this place goes, behind the worst traps imaginable.",0,3,oMessageCutscene,1)
  else if sceneProgress=9 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Yeah, let's just get that piece as quick as we can and leave.",0,3,oMessageCutscene,1)
  else if sceneProgress=10
  {
    sceneDelay=0; sceneProgress=0
    global.gameProgress=4770
    global.gamePaused=false
  }
}
else if room=rDCS_Ghost and global.gameProgress=4770 //----- [] Introduce Temple Ghost -----
{
  if sceneProgress=0
  {
    if oPlayer1.x>=224
    {
      var enemyBarrier;
      enemyBarrier=instance_create(144,192,oEnemyBarrier); enemyBarrier.image_yscale=6
      enemyBarrier=instance_create(864,192,oEnemyBarrier); enemyBarrier.image_yscale=6
      sceneProgress+=1
    }
  }
  else if sceneProgress=1
  {
    if oPlayer1.x>=512
    {
      var tNewEnemy;
      tNewEnemy=instance_create(288,160,oTempleGhost); tNewEnemy.bActive=1; tNewEnemy.xTrack=104; tNewEnemy.yTrack=72
      tNewEnemy=instance_create(736,128,oTempleGhost); tNewEnemy.bActive=1; tNewEnemy.xTrack=52; tNewEnemy.yTrack=104
      sceneProgress+=1
    }
  }
  else if sceneProgress=2
  {
    if !instance_exists(oEnemyBase)
    {
      with oEnemyBarrier {instance_destroy()}
      sceneProgress=0
      global.gameProgress=4775
    }
  }
}
else if room=rDCS_E and global.gameProgress=4775 //----- [3] Perplexing moment with the Warmaster -----
{
  if sceneProgress=0
  {
    if oPlayer1.x>=272
    {
      global.gamePaused=true
      oPlayer1.y+=4
      if oPlayer1.y>=400
      {
        scenePChk(oPlayer1.x,400,0,0.1,1)
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
    msgCreate(0,0,"Warmaster","Well, I didn't expect to run into you again. Not here of all places.",6,3,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Jerry","What are you even doing here?",0,3,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Warmaster","I could ask you the same.",6,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Forget it! I'm gonna kick your ass for what happened to Kirby!",0,3,oMessageCutscene,1)
  else if sceneProgress=6 and bWaitForInput=false
    msgCreate(0,0,"Warmaster","What happened there was not my intention. I simply wanted to keep him out of all this.",6,3,oMessageCutscene,1)
  else if sceneProgress=7 and bWaitForInput=false
    msgCreate(0,0,"Jerry","You did a really crap job there.",0,3,oMessageCutscene,1)
  else if sceneProgress=8 and bWaitForInput=false
    msgCreate(0,0,"Warmaster","As I understand it, it was your task to keep any harm from coming to him. The failure is yours to keep.",6,3,oMessageCutscene,1)
  else if sceneProgress=9 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Screw this, let's go! Right here!",0,3,oMessageCutscene,1)
  else if sceneProgress=10 and bWaitForInput=false
    msgCreate(0,0,"Warmaster","I'd like that. However, my army needs me elsewhere. These ruins are not safe for anyone. I don't know why you're here, but you will stay out of my way.",6,3,oMessageCutscene,1)
  else if sceneProgress=11 and bWaitForInput=false
    msgCreate(0,0,"Jerry","You're actually going to just let us waltz about?",0,3,oMessageCutscene,1)
  else if sceneProgress=12 and bWaitForInput=false
    msgCreate(0,0,"Warmaster","With the warship operational, crushing you is easy. I'd simply like to do it without too much collateral damage.",6,3,oMessageCutscene,1)
  else if sceneProgress=13
  {
    sceneDelay+=1
    if sceneDelay=20 {(404466).image_xscale=1.25; (404466).sprite_index=sWarmasterA_Run; (404466).image_speed=0.33}
    else if sceneDelay>=21 and sceneDelay<=32
    {
      (404466).x+=6
      if sceneDelay=32 {(404466).sprite_index=sWarmasterA_JumpUp}
    }
    else if sceneDelay>=33 and sceneDelay<=60 {(404466).x+=6; (404466).y-=8}
    else if sceneDelay>=80 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=14 and bWaitForInput=false
    msgCreate(0,0,"Chao","Hmm...",0,3,oMessageCutscene,1)
  else if sceneProgress=15 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Any change of plans now?",0,3,oMessageCutscene,1)
  else if sceneProgress=16 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","No, he doesn't know why we're here and let's keep it that way.",0,3,oMessageCutscene,1)
  else if sceneProgress=17
  {
    with (404466) {instance_destroy()}
    sceneDelay=0; sceneProgress=0
    global.gameProgress=4780
    global.gamePaused=false
  }
}

//----- The 4 runes -----
if room=rDCS_H //----- First Rune -----
{
  if runeCheck="0"
  {
    if runeProg=0
    {
      if oPlayer1.x>=528
      {
        var tNewEnemy,enemyBarrier;
        enemyBarrier=instance_create(304,128,oEnemyBarrier); enemyBarrier.image_yscale=8
        enemyBarrier=instance_create(768,192,oEnemyBarrier); enemyBarrier.image_yscale=4
        tNewEnemy=instance_create(304,304,oTempleGhost); tNewEnemy.bActive=1; tNewEnemy.xTrack=92; tNewEnemy.yTrack=112
        tNewEnemy=instance_create(800,304,oTempleGhost); tNewEnemy.bActive=1; tNewEnemy.xTrack=56; tNewEnemy.yTrack=80
        runeProg=1
      }
    }
    else if runeProg=1
    {
      if !instance_exists(oEnemyBase)
      {
        with oEnemyBarrier {instance_destroy()}
        runeProg=2
      }
    }
  }
}
else if room=rDCS_N //----- Third Rune -----
{
  if runeCheck="0"
  {
    if runeProg=0
    {
      if oPlayer1.x>=288
      {
        var tNewEnemy,enemyBarrier;
        enemyBarrier=instance_create(48,224,oEnemyBarrier); enemyBarrier.image_yscale=4
        enemyBarrier=instance_create(512,224,oEnemyBarrier); enemyBarrier.image_yscale=4
        tNewEnemy=instance_create(64,48,oTempleGhost); tNewEnemy.bActive=1; tNewEnemy.xTrack=104; tNewEnemy.yTrack=64
        tNewEnemy=instance_create(576,48,oTempleGhost); tNewEnemy.bActive=1; tNewEnemy.xTrack=24; tNewEnemy.yTrack=120
        runeProg=1
      }
    }
    else if runeProg=1
    {
      if !instance_exists(oEnemyBase)
      {
        with oEnemyBarrier {instance_destroy()}
        runeProg=2
      }
    }
  }
}
else if room=rDCS_O //----- Upper area toward Fourth Rune -----
{
  if runeCheck="0" //Spider Drone
  {
    if runeProg=0
    {
      if oPlayer1.x>=1280
      {
        var tNewEnemy,enemyBarrier;
        enemyBarrier=instance_create(1136,0,oEnemyBarrier); enemyBarrier.image_yscale=24
        enemyBarrier=instance_create(1536,0,oEnemyBarrier); enemyBarrier.image_yscale=24
        tNewEnemy=instance_create(1408,384,oCHAOS_SpiderDrone); tNewEnemy.bActive=1
        runeProg=1
      }
    }
    else if runeProg=1
    {
      if oCHAOS_SpiderDrone.y<=-64
      {
        with oCHAOS_SpiderDrone {instance_destroy()}
        if global.activeCharacter=0 {msgCreate(0,0,"Jerry","Oh uh... okay then!",0,2,oMessagePerson,0)}
        else {msgCreate(0,0,"Claire","So we won then?",0,2,oMessagePerson,0)}
        newMessage.fadingTime=140
      }
      if !instance_exists(oEnemyBase)
      {
        with oEnemyBarrier {instance_destroy()}
        runeProg=2
      }
    }
    else if runeProg=2
    {
      var tNewString;
      tNewString=string_delete(global.gameDCS_Prog,4,1)
      tNewString=string_insert("1",tNewString,4)
      global.gameDCS_Prog=tNewString
    }
  }
  else if runeCheck="5" //Rocketeers and Healer
  {
    if runeProg=0
    {
      if oPlayer1.x<=1280
      {
        var tNewEnemy,enemyBarrier;
        enemyBarrier=instance_create(1136,0,oEnemyBarrier); enemyBarrier.image_yscale=24
        enemyBarrier=instance_create(1536,0,oEnemyBarrier); enemyBarrier.image_yscale=24
        tNewEnemy=instance_create(1104,32,oCHAOS_Rocketeer); tNewEnemy.bActive=1
        tNewEnemy=instance_create(1504,32,oCHAOS_Rocketeer); tNewEnemy.bActive=1
        tNewEnemy=instance_create(1328,96,oCHAOS_Healer); tNewEnemy.bActive=1
        runeProg=1
      }
    }
    else if runeProg=1
    {
      if !instance_exists(oEnemyBase)
      {
        with oEnemyBarrier {instance_destroy()}
        runeProg=2
      }
    }
    else if runeProg=2
    {
      var tNewString;
      tNewString=string_delete(global.gameDCS_Prog,4,1)
      tNewString=string_insert("9",tNewString,4)
      global.gameDCS_Prog=tNewString
    }
  }
}
else if room=rDCS_Q //----- Ghost run to Fourth Rune -----
{
  if runeCheck="1"
  {
    if runeProg=0
    {
      if oPlayer1.x>=320
      {
        var tNewEnemy,enemyBarrier;
        enemyBarrier=instance_create(3872,224,oEnemyBarrier); enemyBarrier.image_yscale=4
        tNewEnemy=instance_create(592,48,oTempleGhost); tNewEnemy.bActive=1; tNewEnemy.xTrack=112; tNewEnemy.yTrack=80
        runeProg=1
      }
    }
    else if runeProg=1
    {
      if !instance_exists(oEnemyBase)
      {
        with oEnemyBarrier {instance_destroy()}
        runeProg=2
      }
    }
  }
}
else if room=rDCS_U and global.gameProgress=4780 //----- [] Boss Fight: Shadow Eura -----
{
  if global.bossTrack=0
  {
    if sceneProgress=0
    {
      if oPlayer1.x>=352
      {
        var viewFix,tViewShake,enemyBarrier,boss;
        viewFix=instance_create(352,176,oMisc)
        viewFix.type=0; viewFix.sprite_index=sNull
        view_object[0]=viewFix
        enemyBarrier=instance_create(144,224,oEnemyBarrier); enemyBarrier.image_yscale=4
        enemyBarrier=instance_create(544,224,oEnemyBarrier); enemyBarrier.image_yscale=4
        sceneProgress+=1
      }
    }
    else if sceneProgress=1
    {
      sceneDelay+=1
      if sceneDelay=50
      {
        with oMisc {instance_destroy()}
        var tempMplay,tViewShake;
        tempMplay=findMusic(827)
        playMusic(tempMplay,0,0)
        tViewShake=instance_create(352,0,oStaticViewShaker)
        tViewShake.shakeAmt=1
        roomShake=1
      }
      else if sceneDelay>=60 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=2
    {
      sceneDelay+=1
      if sceneDelay=130 {hexFlash=1; hexX=352; hexY=160}
      else if sceneDelay>=180 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=3
    {
      sceneDelay+=1
      if sceneDelay=50
      {
        myRockA=instance_create(256,-36,oSE_Rock); myRockA.type=2; myRockA.atkTime=-1000000; myRockA.bCanTakeDamage=0
        myRockB=instance_create(352,-36,oSE_Rock); myRockB.type=2; myRockB.atkTime=-1000000; myRockB.bCanTakeDamage=0
        myRockC=instance_create(448,-36,oSE_Rock); myRockC.type=2; myRockC.atkTime=-1000000; myRockC.bCanTakeDamage=0
      }
      else if sceneDelay>=51 and sceneDelay<=999
      {
        var tEffect;
        for(i=0;i<3;i+=1)
        {
          for(ii=0;ii<8;ii+=1)
          {
            tEffect=instance_create(224+(i*96)+random(64),myRockA.y-32+random(64),oEffectB)
            tEffect.type=3; tEffect.sprite_index=sMMSmokeCloud; tEffect.newBlend=-1; tEffect.depth=23
            tEffect.image_speed=0.2; tEffect.fadeSpd=0.075; tEffect.image_xscale=1.25; tEffect.image_yscale=1.25
            tEffect.AccelX=0; tEffect.AccelY=0; tEffect.followID=-1; tEffect.rotation=0
          }
        }
        myRockA.y+=0.25; myRockB.y+=0.25; myRockC.y+=0.25
        if myRockA.y>=76 {sceneDelay=1000}
      }
      else if sceneDelay=1040
      {
        roomShake=0
        var viewFix;
        viewFix=instance_create(352,176,oMisc)
        viewFix.type=0; viewFix.sprite_index=sNull
        view_object[0]=viewFix
        with oStaticViewShaker {instance_destroy()}
      }
      else if sceneDelay>=1120 {sceneDelay=0; sceneProgress+=1}

      if sceneDelay=10
      {
        msgCreate(0,0,"Jerry","Hex isn't really here, is he?",0,1,oMessagePerson,0)
        newMessage.fadingTime=80
      }
      else if sceneDelay=100
      {
        msgCreate(0,0,"Jeremy","He is definitely not here, but he was at some point.",0,1,oMessagePerson,0)
        newMessage.fadingTime=100
      }
      else if sceneDelay=250
      {
        with oMisc {instance_destroy()}
        hexFlash=0
      }
    }
    else if sceneProgress=4 //Start boss fight
    {
      with oSE_Rock {instance_destroy()}
      var tBossTitle,tempMplay,boss,myRock;
      tBossTitle=instance_create(0,0,oBossNameDisplay)
      tBossTitle.bossName="Shadow Eura"
      tBossTitle.bossTitle="Corrupted Ruin Trap"
      tempMplay=findMusic(827)
      playMusic(tempMplay,0,0)
      global.currentBoss="Shadow Eura"
      global.bossTrack=1
      boss=instance_create(352,76,oShadowEura)
      boss.activateBoss=1
      storeStatus(0)
      sceneDelay=0; sceneProgress=0
    }

    if roomShake=1
    {
      var tEffect;
      tEffect=instance_create(160+random(384),random(64),oEffectB)
      tEffect.type=3; tEffect.sprite_index=sMMSmokeCloud; tEffect.newBlend=-1; tEffect.depth=23
      tEffect.image_speed=0.2; tEffect.fadeSpd=0.075; tEffect.image_xscale=1.25; tEffect.image_yscale=1.25
      tEffect.AccelX=0; tEffect.AccelY=0; tEffect.followID=-1; tEffect.rotation=0

      tEffect=instance_create(160+random(384),random(64),oEffectGrav)
      tEffect.type=2; tEffect.sprite_index=sSE_RockFall; tEffect.newBlend=-1; tEffect.depth=23
      tEffect.fadeSpd=0.04; tEffect.image_xscale=0.25+random(0.4); tEffect.image_yscale=0.25+random(0.4)
      tEffect.xSpd=0; tEffect.ySpd=1+random(3); tEffect.followID=-1; tEffect.rotation=0; tEffect.grav=0.2
    }
    if hexFlash=1
    {
      if hexTime mod 28=0
      {
        var tEfCir;
        tEfCir=instance_create(hexX,hexY,oEfCircleSoftFade)
        tEfCir.image_alpha=0.5; tEfCir.myRad=36; tEfCir.radScl=1.5; tEfCir.fadeSpeed=0.0125
      }
      hexTime+=1
      if hexTime=1
      {
        myHex=instance_create(hexX,hexY,oMisc)
        myHex.type=0; myHex.sprite_index=sHex_A_Hang; myHex.image_speed=0
        myHex.image_xscale=2; myHex.image_yscale=2; myHex.image_alpha=0.5
      }
    }
  }
  else if global.bossTrack=1
  {
    if sceneProgress=1 //End Boss
    {
      stopPlayer()
      with oEProjectileBase {instance_destroy()}
      global.gamePaused=true
      awardBossAP(12000)
      global.bossTrack=2
      sceneProgress=0
    }
  }
  else if global.bossTrack=2
  {
    if sceneProgress=0
    {
      var tFullHeartDrop,tempMplay;
      tFullHeartDrop=instance_create(352,128,oHealthPickup)
      tFullHeartDrop.sprite_index=sFullHealthPickup
      tempMplay=findMusic(6)
      playMusic(tempMplay,0,0)
      view_object[0]=oPlayer1
      with oEnemyBarrier {instance_destroy()}
      with oMisc {instance_destroy()}
      global.gamePaused=false
      global.currentBoss=""
      global.bossTrack=0
      global.gameProgress=4790
    }
  }
}
else if room=rDCS_V and global.gameProgress=4790 //----- [] The second Dragoon piece and the portal -----
{
  if sceneProgress=0
  {
    if !instance_exists(oStoryObject)
    {
      sceneDelay+=1
      if sceneDelay=1 {global.gamePaused=true}
      else if sceneDelay>=2
      {
        oPlayer1.y+=4
        if oPlayer1.y>=288
        {
          scenePChk(oPlayer1.x,288,0,0.1,1)
          stopPlayer()
          sceneDelay=0; sceneProgress+=1
        }
      }
    }
  }
  else if sceneProgress=1
  {
    sceneDelay+=1
    if sceneDelay>=80 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Just to make sure, everyone else is creeped out by the portal thingie in the background?",0,3,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Nah, I'm feeling pretty okay from where I am, but I would advise you guys to leave. It has some properties of... something? I just don't know what. Probably Hex being Hex again.",0,3,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Alright, let's do this then.",0,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Warmaster","You're not going anywhere.",6,3,oMessageCutscene,1)
  else if sceneProgress=6
  {
    sceneDelay+=1
    if sceneDelay=15 {oPlayer1.image_xscale=-1}
    else if sceneDelay=30
    {
      myNPC=instance_create(0,288,oMisc)
      myNPC.type=0; myNPC.sprite_index=sWarmasterA_Run
      myNPC.image_xscale=1.25; myNPC.image_yscale=1.25; myNPC.image_speed=0.33
    }
    else if sceneDelay>=31 and sceneDelay<=99
    {
      myNPC.x+=6
      if myNPC.x>=208
      {
        myNPC.sprite_index=sWarmasterA_Idle; myNPC.image_speed=0.15
        sceneDelay=100
      }
    }
    else if sceneDelay>=130 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=7 and bWaitForInput=false
    msgCreate(0,0,"Warmaster","I was wondering why you were in here... I didn't realize the Dragoon was still around.",6,3,oMessageCutscene,1)
  else if sceneProgress=8 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Yep.",0,3,oMessageCutscene,1)
  else if sceneProgress=9 and bWaitForInput=false
    msgCreate(0,0,"Warmaster","I know what you're going to attempt, and you won't make it.",6,3,oMessageCutscene,1)
  else if sceneProgress=10 and bWaitForInput=false
    msgCreate(0,0,"Claire","We're still going to try.",0,3,oMessageCutscene,1)
  else if sceneProgress=11 and bWaitForInput=false
    msgCreate(0,0,"Warmaster","I was afraid you would say that. You've brought this upon yourselves. I don't agree with Hex's decision had you taken this route, but I won't stop him.",6,3,oMessageCutscene,1)
  else if sceneProgress=12 and bWaitForInput=false
    msgCreate(0,0,"Jerry","What's that mean?",0,3,oMessageCutscene,1)
  else if sceneProgress=13 and bWaitForInput=false
    msgCreate(0,0,"Warmaster","For their sake, I will...",6,3,oMessageCutscene,1)
  else if sceneProgress=14 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Eh?",0,3,oMessageCutscene,1)
  else if sceneProgress=15 and bWaitForInput=false
    msgCreate(0,0,"Warmaster","That portal is active!",6,3,oMessageCutscene,1)
  else if sceneProgress=16 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Wait what? That thing is functional?!",0,3,oMessageCutscene,1)
  else if sceneProgress=17
  {
    sceneDelay+=1
    if sceneDelay=10
    {
      var tFlash;
      tFlash=instance_create(0,0,oScreenFlash)
      tFlash.image_alpha=0.7; tFlash.fadeSpeed=0.1
    }
    else if sceneDelay>=15
    {
      var enemyBarrier;
      enemyBarrier=instance_create(144,224,oEnemyBarrier); enemyBarrier.image_yscale=4
      pullIn=1
      sceneDelay=0; sceneProgress+=1
      global.gamePaused=false
    }
  }
  else if sceneProgress=18
  {
    sceneDelay+=1
    if sceneDelay=30 {myNPC.sprite_index=sWarmasterA_Kneel; pullSpeed=1}
    else if sceneDelay=70 {pullSpeed=2}
    else if sceneDelay=110 {pullSpeed=3}
    else if sceneDelay=150 {pullSpeed=4}
    else if sceneDelay=190 {pullSpeed=5}
    else if sceneDelay=220
    {
      pullSpeed=8; myNPC.sprite_index=sWarmasterA_Hit
      myExit=instance_create(312,168,oExit)
      myExit.bShowArrow=false; myExit.exitType=1
      myExit.newMapX=144; myExit.newMapY=608; myExit.toRoom=rSF_A
    }
    else if sceneDelay=220 {pullSpeed=12}

    //Pull Warmaster
    if sceneDelay>=140 and sceneDelay<=200 {myNPC.x+=0.5}
    else if sceneDelay>=201 and sceneDelay<=220 {myNPC.x+=1}
    if sceneDelay>=221 and sceneDelay<=299
    {
      myNPC.x+=2; myNPC.y-=2
      if myNPC.x>=320 {sceneDelay=300}
    }
    else if sceneDelay>=301 and sceneDelay<=320 {myNPC.image_alpha-=0.05}

    if pullSpeed>0 //Pull player
    {
      if oPlayer1.x<320 {oPlayer1.xVel+=pullSpeed}
      else {oPlayer1.xVel-=pullSpeed}

      if sceneDelay>=231
      {
        if oPlayer1.y<176 {oPlayer1.yVel+=pullSpeed/2}
        else {oPlayer1.yVel-=pullSpeed/2}
      }
    }
  }

  if sceneProgress>=10 //Portal red flash
  {
    portalWave+=1
    if portalWave=1 {(410850).image_blend=c_red}
    else if portalWave=8 {(410851).image_blend=c_red}
    else if portalWave=15 {(410852).image_blend=c_red}
    else if portalWave=22 {(410853).image_blend=c_red}
    else if portalWave=29 {(410854).image_blend=c_red}

    if portalWave=16 {(410850).image_blend=c_white}
    else if portalWave=23 {(410851).image_blend=c_white}
    else if portalWave=30 {(410852).image_blend=c_white}
    else if portalWave=37 {(410853).image_blend=c_white}
    else if portalWave=44 {(410854).image_blend=c_white}
    else if portalWave>=45 {portalWave=0}
  }
}

keyWaitForInput()

if oKeyCodes.kCodePressed[11]=1 and global.gamePaused=true //Cutscene skip
{
  if !instance_exists(oPauseMenu)
  {
    if global.gameProgress=4720 and room=rDCS_A //[1]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      fadeAlpha=0; sceneDelay=0
      sceneProgress=5
    }
    else if global.gameProgress=4760 and room=rDCS_D //[2]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      fadeAlpha=0; sceneDelay=0
      sceneProgress=10
    }
    else if global.gameProgress=4770 and room=rDCS_E //[3]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      fadeAlpha=0; sceneDelay=0
      sceneProgress=17
    }
  }
}

//----- Room specific events -----
if global.gamePaused=false
{
  if room=rDCS_G
  {
    if spiderTrap=0
    {
      if oPlayer1.x>=912
      {
        var tNewEnemy,enemyBarrier;
        enemyBarrier=instance_create(624,96,oEnemyBarrier); enemyBarrier.image_yscale=10
        enemyBarrier=instance_create(1088,128,oEnemyBarrier); enemyBarrier.image_yscale=8
        tNewEnemy=instance_create(784,256,oCHAOS_SpiderDrone); tNewEnemy.bActive=1
        spiderTrap=1
      }
    }
    else if spiderTrap=1
    {
      if !instance_exists(oEnemyBase)
      {
        with oEnemyBarrier {instance_destroy()}
        spiderTrap=2
      }
    }
  }
  else if room=rDCS_S
  {
    if ghostDoors=0
    {
      if !instance_exists(410054)
      {
        with (410676) {instance_destroy()}
        ghostDoors=1
      }
    }
    else if ghostDoors=1
    {
      if !instance_exists(410086)
      {
        with (410677) {instance_destroy()}
        ghostDoors=100
      }
    }
  }
  else if room=rDCS_V
  {
    if pullIn=1
    {
      var tEffect,tDir;
      for(i=0;i<2;i+=1)
      {
        tDir=random(360)
        tEffect=instance_create(320+lengthdir_x(312,tDir),176+lengthdir_y(312,tDir),oEffectB)
        tEffect.type=3; tEffect.sprite_index=sEfDiffusionParticle; tEffect.newBlend=-1; tEffect.speed=7
        tEffect.image_speed=0.2; tEffect.fadeSpd=0.025; tEffect.image_xscale=1+random(0.5); tEffect.image_yscale=1+random(0.5)
        tEffect.AccelX=0; tEffect.AccelY=0; tEffect.followID=-1; tEffect.rotation=0; tEffect.direction=tDir+180
      }
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
