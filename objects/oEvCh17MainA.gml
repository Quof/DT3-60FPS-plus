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
rmLSpawn=1

if room=rHPF_E {scriptPlat=0}
else if room=rHPF_L {virusTime=0}
else if room=rHPF_N and global.gameProgress=4020
{
  fadeColor=c_black
  fadeAlpha=1
}
else if room=rHPF_R and global.gameProgress=4060
{
  sentrySpawn=1260
}
else if room=rHPF_V
{
  remMenuState=global.optShowHUD
}
else if room=rCCity_NA_S1 and global.gameProgress=4190
{
  fadeColor=c_black
  fadeAlpha=1
}

if global.gameProgress>=4130 and global.gameProgress<=4190 //Escape sequence
{
  with oInjectorVirus {instance_destroy()}
  with oEnemySpawnZone {instance_destroy()}
  rmLSpawn=0
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gameProgress=3930 and room=rHPF_A //----- [1] The facility below -----
{
  if sceneProgress=0
  {
    sceneDelay+=1
    if sceneDelay=1 {global.gamePaused=true}
    if sceneDelay>=20 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=1 and bWaitForInput=false
    msgCreate(0,0,"Jerry","See anything hostile down here?",0,3,oMessageCutscene,1)
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Nothing. How about you, Chao?",0,3,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Chao","It's quiet, and this facility is pretty large. The only thing I'm picking up is the computer system. It's active, but like John said, it's not hostile toward us.",0,3,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Jerry","So something is finally easy for us?",0,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Looks like it, but stay on guard.",0,3,oMessageCutscene,1)
  else if sceneProgress=6
  {
    var tNewChapter;
    tNewChapter=instance_create(0,0,oChapterDisplay)
    tNewChapter.newChapter="Chapter 17#What Lies Beneath"
    sceneDelay=0; sceneProgress=0
    global.gameProgress=3940
    global.gamePaused=false
  }
}
else if global.gameProgress=3950 and room=rHPF_C //----- [] Ceiling block falls -----
{
  if sceneProgress=0
  {
    if oPlayer1.x>=1024
    {
      oRmHPFC_Obj.myProg=1
      sceneProgress=1
    }
  }
}
else if global.gameProgress=3965 and room=rHPF_A //----- [2] Deactivate security door -----
{
  if sceneProgress=0
  {
    if oPlayer1.x<=1552
    {
      global.gamePaused=true
      oPlayer1.y+=4
      if oPlayer1.y>=176
      {
        scenePChk(oPlayer1.x,176,0,0.1,-1)
        stopPlayer()
        sceneProgress+=1
      }
    }
  }
  else if sceneProgress=1 and bWaitForInput=false
    msgCreate(0,0,"Chao","And done.",0,3,oMessageCutscene,1)
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","That quick?",0,3,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Chao","I started the moment it was in sight. Was too easy.",0,3,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Back the way we came... again.",0,3,oMessageCutscene,1)
  else if sceneProgress=5
  {
    sceneDelay=0; sceneProgress=0
    global.gameProgress=3970
    global.gamePaused=false
  }
}
else if global.gameProgress=3970 and room=rHPF_B //----- [] Boss Fight: Antipathy -----
{
  if global.bossTrack=0
  {
    if sceneProgress=0
    {
      if oPlayer1.x>=928
      {
        var myVirusWall;
        myVirusWall=instance_create(48,208,oSolidVirusBlock)
        myVirusWall.image_yscale=4
        msgCreate(0,0,"Claire","What is this?!",0,2,oMessagePerson,0)
        newMessage.fadingTime=45
        sceneProgress+=1
      }
    }
    else if sceneProgress=1
    {
      sceneDelay+=1
      if sceneDelay=45
      {
        msgCreate(0,0,"Jeremy","Back off from that!",0,2,oMessagePerson,0)
        newMessage.fadingTime=50
      }
      else if sceneDelay=95
      {
        msgCreate(0,0,"Claire","But what the hell? I thought the Virus couldn't get in here?!",0,2,oMessagePerson,0)
        newMessage.fadingTime=85
      }
      else if sceneDelay=180
      {
        msgCreate(0,0,"Jeremy","I get it. The Virus figured out how to get under the city. Its defenses only cover the upper perimeter.",0,3,oMessagePerson,0)
        newMessage.fadingTime=150
      }
      else if sceneDelay=330
      {
        msgCreate(0,0,"Claire","What do we do?",0,2,oMessagePerson,0)
        newMessage.fadingTime=40
      }
      else if sceneDelay=370
      {
        msgCreate(0,0,"Jeremy","Back away for a moment, I need to figure this out.",0,2,oMessagePerson,0)
        newMessage.fadingTime=80
      }
      else if sceneDelay=510 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=2 //Boss scene activates
    {
      if oPlayer1.x>=448 and oPlayer1.x<=512 {sceneProgress+=1}
    }
    else if sceneProgress=3
    {
      sceneDelay+=1
      if sceneDelay=1
      {
        var enemyBarrier;
        enemyBarrier=instance_create(304,112,oSolidVirusBlock); enemyBarrier.image_yscale=10
        enemyBarrier=instance_create(640,112,oSolidVirusBlock); enemyBarrier.image_yscale=10
        npcVirusA=instance_create(384,-16,oMisc)
        npcVirusA.sprite_index=sVirusGel; npcVirusA.image_speed=0.3; npcVirusA.type=1
        npcVirusB=instance_create(576,-16,oMisc)
        npcVirusB.sprite_index=sVirusGel; npcVirusB.image_speed=0.3; npcVirusB.type=1
      }
      else if sceneDelay>=2
      {
        npcVirusA.y+=6; npcVirusB.y+=6
        if npcVirusA.y>=248
        {
          with oMisc {instance_destroy()}
          var tEffect,tDir;
          tDir=0
          playSound(global.snd_Infect,0,0.95,22050+random(2205))
          for(i=0;i<16;i+=1)
          {
            tEffect=instance_create(384,248,oEffectB)
            tEffect.type=3; tEffect.sprite_index=sVirusGel; tEffect.image_alpha=0.75; tEffect.image_speed=0.15
            tEffect.direction=tDir+irandom_range(-4,4); tEffect.friction=0.01; tEffect.speed=random(1)+1; tEffect.fadeSpd=0.01
            tEffect.AccelX=0; tEffect.AccelY=0; tEffect.newBlend=-1; tEffect.followID=-1; tEffect.rotation=0
            tEffect=instance_create(576,248,oEffectB)
            tEffect.type=3; tEffect.sprite_index=sVirusGel; tEffect.image_alpha=0.75; tEffect.image_speed=0.15
            tEffect.direction=tDir+irandom_range(-4,4); tEffect.friction=0.01; tEffect.speed=random(1)+1; tEffect.fadeSpd=0.01
            tEffect.AccelX=0; tEffect.AccelY=0; tEffect.newBlend=-1; tEffect.followID=-1; tEffect.rotation=0
            tDir+=360/16
          }
          with oNPC_GeneralA
          {
            baseColor=make_color_rgb(200,255,200)
            image_blend=baseColor
          }
          sceneDelay=0; sceneProgress+=1
        }
      }
    }
    else if sceneProgress=4
    {
      sceneDelay+=1
      if sceneDelay=30 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=5
    {
      global.gamePaused=false
      viewFix=instance_create(480,176,oMisc)
      viewFix.type=0
      viewFix.sprite_index=sNull
      view_object[0]=viewFix
      var tBossTitle,tempMplay;
      tBossTitle=instance_create(0,0,oBossNameDisplay)
      tBossTitle.bossName="Antipathy"
      tBossTitle.bossTitle="Infector Virus"
      tempMplay=findMusic(813)
      playMusic(tempMplay,0,0)
      with oNPC_GeneralA {instance_destroy()}
      boss=instance_create(384,272,oAntiAlpha)
      boss.activateBoss=1
      boss=instance_create(576,272,oAntiBeta)
      boss.activateBoss=1
      global.currentBoss="Antipathy"
      global.bossTrack=1
      storeStatus(0)
      sceneDelay=0; sceneProgress=0
    }
  }
  else if global.bossTrack=1
  {
    if sceneProgress=1 //End Boss
    {
      view_object[0]=oPlayer1
      awardBossAP(8500)
      global.bossTrack=2
      sceneProgress=0
    }
  }
  else if global.bossTrack=2
  {
    if sceneProgress=0
    {
      var tFullHeartDrop,tempMplay;
      tFullHeartDrop=instance_create(480,128,oHealthPickup)
      tFullHeartDrop.sprite_index=sFullHealthPickup
      tempMplay=findMusic(19)
      playMusic(tempMplay,0,0)
      with oSolidVirusBlock {instance_destroy()}
      global.gamePaused=false
      global.currentBoss=""
      global.bossTrack=0
      global.gameProgress=3980
    }
  }
}
else if global.gameProgress=3980 and room=rHPF_C //----- [3] The virus is here -----
{
  if sceneProgress=0
  {
    sceneDelay+=1
    if sceneDelay=1 {global.gamePaused=true}
    if sceneDelay>=20 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=1 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Damn, it looks like the Virus can infect the bots down here. Try and stop the Virus before it reaches the bots.",0,3,oMessageCutscene,1)
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"Jerry","We can do that?",0,3,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Yes, they're vulnerable to your attacks.",0,3,oMessageCutscene,1)
  else if sceneProgress=4
  {
    sceneDelay=0; sceneProgress=0
    global.gameProgress=3990
    global.gamePaused=false
  }
}
else if global.gameProgress=3990 and room=rHPF_G //----- [] Deactivate security door -----
{
  if sceneProgress=0
  {
    if oPlayer1.x>=1856 and oPlayer1.y<=296
    {
      msgCreate(0,0,"Chao","I've opened the security door below. And no worries, the Virus can't close it again.",0,2,oMessagePerson,0)
      newMessage.fadingTime=110
      with (352906) {instance_destroy()}
      sceneDelay=0; sceneProgress=0
      global.gameProgress=4000
    }
  }
}
else if global.gameProgress=4000 and room=rHPF_G //----- [] Virus speaks A -----
{
  if sceneProgress=0
  {
    if oPlayer1.x>=2144 {sceneProgress+=1}
  }
  else if sceneProgress=1
  {
    sceneDelay+=1
    if sceneDelay=1
    {
      var tStatic; tStatic=instance_create(0,0,oQuickStatic); tStatic.staticTime=15; tStatic.image_alpha=0.28
      msgCreate(0,0,"Virus","I know what you are attempting.",5,1,oMessagePerson,0)
      newMessage.fadingTime=90
    }
    else if sceneDelay=15 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=2
  {
    if oPlayer1.x>=2864 {sceneProgress+=1}
  }
  else if sceneProgress=3
  {
    sceneDelay+=1
    if sceneDelay=1
    {
      var tStatic; tStatic=instance_create(0,0,oQuickStatic); tStatic.staticTime=15; tStatic.image_alpha=0.28
      msgCreate(0,0,"Virus","You will not succeed.",5,1,oMessagePerson,0)
      newMessage.fadingTime=90
    }
    else if sceneDelay=15 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=4
  {
    if oPlayer1.x>=3600 {sceneProgress+=1}
  }
  else if sceneProgress=5
  {
    sceneDelay+=1
    if sceneDelay=1
    {
      var tStatic; tStatic=instance_create(0,0,oQuickStatic); tStatic.staticTime=15; tStatic.image_alpha=0.28
      msgCreate(0,0,"Virus","Turn back!",5,1,oMessagePerson,0)
      newMessage.fadingTime=90
    }
    else if sceneDelay=15
    {
      sceneDelay=0; sceneProgress=0
      global.gameProgress=4010
    }
  }
}
else if global.gameProgress=4010 and room=rHPF_L //----- [] Virus speaks B -----
{
  if sceneProgress=0
  {
    if oPlayer1.x>=1424 {sceneProgress+=1}
  }
  else if sceneProgress=1
  {
    sceneDelay+=1
    if sceneDelay=1
    {
      var tStatic; tStatic=instance_create(0,0,oQuickStatic); tStatic.staticTime=15; tStatic.image_alpha=0.28
      msgCreate(0,0,"Virus","I am watching you.",5,1,oMessagePerson,0)
      newMessage.fadingTime=90
    }
    else if sceneDelay=15 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=2
  {
    if oPlayer1.x>=2080 {sceneProgress+=1}
  }
  else if sceneProgress=3
  {
    sceneDelay+=1
    if sceneDelay=1
    {
      var tStatic; tStatic=instance_create(0,0,oQuickStatic); tStatic.staticTime=15; tStatic.image_alpha=0.28
      msgCreate(0,0,"Virus","I see everything. Nothing escapes my sight.",5,1,oMessagePerson,0)
      newMessage.fadingTime=150
    }
    else if sceneDelay=15
    {
      sceneDelay=0; sceneProgress=0
      global.gameProgress=4020
    }
  }
}
else if global.gameProgress=4020 and room=rHPF_M //----- [] Floor breaks -----
{
  if sceneProgress=0
  {
    if oPlayer1.x>=608
    {
      playSound(global.snd_Slam,0,0.9,1)
      playSound(global.snd_BombExplode,0,0.9,1)
      myWall=instance_create(496,224,oSolidVirusBlock)
      myWall.image_yscale=4; myWall.visible=0
      myWall=instance_create(704,224,oSolidVirusBlock)
      myWall.image_yscale=4; myWall.visible=0
      tile_layer_hide(1000002)
      with (357361) {instance_destroy()}
      for(i=0;i<6;i+=1)
      {
        for(ii=0;ii<2;ii+=1)
        {
          tEffect=instance_create(528+(i*32),304+(ii*32),oEffect)
          tEffect.sprite_index=sRobotExplosion; tEffect.image_speed=0.5
          tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
        }
      }
      sceneProgress+=1
    }
  }
}
else if global.gameProgress=4020 and room=rHPF_N //----- [4] Virus attacks -----
{
  if sceneProgress=0
  {
    sceneDelay+=1
    if sceneDelay=1
    {
      global.pLife=global.pMaxLife
      oPlayer1.life=oPlayer1.maxLife
      stopAllMusic()
      scenePChk(224,256,0,0.1,1)
      global.gamePaused=true
    }
    if sceneDelay>=40
    {
      fadeAlpha-=0.01
      if fadeAlpha<=0 {sceneDelay=0; sceneProgress+=1}
    }
  }
  else if sceneProgress=1 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Now where are we? Is this still on the right track?",0,3,oMessageCutscene,1)
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","The main system was up there and now it looks like we're not going to be getting back up from here. There are some paths down here that should lead us back toward the main computer though.",0,3,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
  {
    var tStatic; tStatic=instance_create(0,0,oQuickStatic); tStatic.staticTime=10; tStatic.image_alpha=0.28
    msgCreate(0,0,"Virus","You were warned.",5,3,oMessageCutscene,1)
  }
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Figured it had something to do with the Virus.",0,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Chao","We should ignore it and keep moving. We're so close to removing it.",0,3,oMessageCutscene,1)
  else if sceneProgress=6 and bWaitForInput=false
  {
    var tStatic; tStatic=instance_create(0,0,oQuickStatic); tStatic.staticTime=10; tStatic.image_alpha=0.28
    msgCreate(0,0,"Virus","It won't happen!",5,3,oMessageCutscene,1)
  }
  else if sceneProgress=7 and bWaitForInput=false
  {
    var tStatic; tStatic=instance_create(0,0,oQuickStatic); tStatic.staticTime=10; tStatic.image_alpha=0.28
    msgCreate(0,0,"Virus","I won't let that happen!",5,3,oMessageCutscene,1)
  }
  else if sceneProgress=8 and bWaitForInput=false
  {
    var tStatic; tStatic=instance_create(0,0,oQuickStatic); tStatic.staticTime=10; tStatic.image_alpha=0.28
    msgCreate(0,0,"Virus","I will live on!",5,3,oMessageCutscene,1)
  }
  else if sceneProgress=9 and bWaitForInput=false
  {
    var tStatic; tStatic=instance_create(0,0,oQuickStatic); tStatic.staticTime=10; tStatic.image_alpha=0.28
    msgCreate(0,0,"Virus","You will die!",5,3,oMessageCutscene,1)
  }
  else if sceneProgress=10 and bWaitForInput=false
  {
    var tStatic; tStatic=instance_create(0,0,oQuickStatic); tStatic.staticTime=10; tStatic.image_alpha=0.28
    msgCreate(0,0,"Virus","I will exist!",5,3,oMessageCutscene,1)
  }
  else if sceneProgress=11
  {
    var tStatic; tStatic=instance_create(0,0,oQuickStatic); tStatic.staticTime=15; tStatic.image_alpha=0.28
    msgCreate(0,0,"Virus","And you will die!",5,1,oMessagePerson,0)
    newMessage.fadingTime=90
    fadeAlpha=0
    var tempMplay;
    tempMplay=findMusic(20)
    playMusic(tempMplay,0,0)
    sceneDelay=0; sceneProgress=0
    global.gameProgress=4030
    global.gamePaused=false
  }
}
else if global.gameProgress=4030 and room=rHPF_N //----- [] Red overlay and Blood Virus -----
{
  if sceneProgress=0
  {
    if oPlayer1.y>=320
    {
      instance_create(0,0,oScreenColorOverlay)
      oScreenColorOverlay.image_blend=c_red
      sceneProgress+=1
    }
  }
  else if sceneProgress=1
  {
    sceneDelay+=1
    if sceneDelay>=1 and sceneDelay<=40
    {
      oScreenColorOverlay.image_alpha+=0.0025
    }
    else if sceneDelay>=45 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=2
  {
    if oPlayer1.x>=352 and oPlayer1.y>=672
    {
      var tFlash;
      tFlash=instance_create(0,0,oScreenFlash)
      tFlash.fadeSpeed=0.2
      oPlayer1.x=448; oPlayer1.y=192
      if global.activeCharacter=0
      {
        msgCreate(0,0,"Jerry","What the hell?",0,1,oMessagePerson,0)
        newMessage.fadingTime=90
      }
      else if global.activeCharacter=1
      {
        msgCreate(0,0,"Claire","... What just happened?",0,1,oMessagePerson,0)
        newMessage.fadingTime=90
      }
    }
    if oPlayer1.x>=1680 and oPlayer1.y<=352 {sceneProgress+=1}
  }
  else if sceneProgress=3
  {
    sceneDelay+=1
    if sceneDelay=1
    {
      var enemyBarrier;
      enemyBarrier=instance_create(1328,192,oSolidVirusBlock); enemyBarrier.image_yscale=8
    }
    else if sceneDelay>=2 and sceneDelay<=41
    {
      oScreenColorOverlay.image_alpha+=0.0025
    }
    else if sceneDelay>=45 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=4
  {
    if oPlayer1.x<=1584
    {
      var enemyCounter;
      enemyCounter=instance_create(0,0,oEnemyRemain)
      enemyCounter.enemyCount=2
      createEnemy(1408,160,oBloodVirus,2,1,1)
      createEnemy(1856,160,oBloodVirus,2,1,1)
      sceneProgress+=1
    }
  }
  else if sceneProgress=5
  {
    if oEnemyRemain.enemyCount<=0
    {
      msgCreate(0,0,"Jeremy","The Virus can't block our route down below now.",0,1,oMessagePerson,0)
      newMessage.fadingTime=130
      with oSolidVirusBlock {instance_destroy()}
      with oEnemyRemain {instance_destroy()}
      sceneDelay=0; sceneProgress=0
      global.gameProgress=4040
    }
  }
}
else if global.gameProgress=4040 and room=rHPF_O //----- [] Red overlay -----
{
  if sceneProgress=0
  {
    if oPlayer1.x>=1248 {sceneProgress+=1}
  }
  else if sceneProgress=1
  {
    sceneDelay+=1
    if sceneDelay>=1 and sceneDelay<=40
    {
      oScreenColorOverlay.image_alpha+=0.0025
    }
    else if sceneDelay>=45 {sceneDelay=0; sceneProgress+=1}
  }
}
else if global.gameProgress=4050 and room=rHPF_P //----- [] Virus door -----
{
  if sceneProgress=0
  {
    if oPlayer1.x>=1232
    {
      var myWall;
      myWall=instance_create(1200,128,oSolidVirusBlock)
      myWall.image_yscale=8
      sceneProgress+=1
    }
  }
  else if sceneProgress=1
  {
    sceneDelay+=1
    if sceneDelay>=1 and sceneDelay<=40
    {
      oScreenColorOverlay.image_alpha+=0.0025
    }
    else if sceneDelay>=45 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=2
  {
    if !instance_exists(oBloodVirus)
    {
      with oSolidVirusBlock {instance_destroy()}
      global.gameProgress=4060
    }
  }
}
else if global.gameProgress=4060 and room=rHPF_R //----- [] Blood Virus trap -----
{
  if sceneProgress=0
  {
    if oPlayer1.x>=384
    {
      var myWall;
      myWall=instance_create(128,32,oSolidVirusBlock)
      myWall.image_yscale=16
      myWall=instance_create(768,32,oSolidVirusBlock)
      myWall.image_yscale=12
      sceneProgress+=1
    }
  }
  else if sceneProgress=1
  {
    sceneDelay+=1
    if sceneDelay=30
    {
      var tNewEnemy;
      tNewEnemy=instance_create(448,128,oBloodVirus); tNewEnemy.bActive=1
    }
    else if sceneDelay>=35
    {
      if !instance_exists(oBloodVirus)
      {
        sceneDelay=0; sceneProgress+=1
      }
    }
  }
  else if sceneProgress=2
  {
    sceneDelay+=1
    if sceneDelay=30
    {
      var tNewEnemy;
      tNewEnemy=instance_create(256,128,oBloodVirus); tNewEnemy.bActive=1
      tNewEnemy=instance_create(448,128,oBloodVirus); tNewEnemy.bActive=1
    }
    else if sceneDelay>=35
    {
      if !instance_exists(oBloodVirus)
      {
        sceneDelay=0; sceneProgress+=1
      }
    }
  }
  else if sceneProgress=3
  {
    sceneDelay+=1
    if sceneDelay=30
    {
      var tNewEnemy;
      tNewEnemy=instance_create(448,128,oBloodVirus); tNewEnemy.bActive=1
      tNewEnemy=instance_create(640,128,oBloodVirus); tNewEnemy.bActive=1
    }
    else if sceneDelay>=35
    {
      if !instance_exists(oBloodVirus)
      {
        sceneDelay=0; sceneProgress+=1
        with oSolidVirusBlock {instance_destroy()}
        global.gameProgress=4070
      }
    }
  }

  if sceneProgress>=1
  {
    sentrySpawn+=1
    if sentrySpawn>=1350
    {
      var tNewEnemy;
      tNewEnemy=instance_create(296,272,oFacSentry); tNewEnemy.bActive=1
      tNewEnemy=instance_create(600,272,oFacSentry); tNewEnemy.bActive=1
      tNewEnemy=instance_create(368,128,oInjectorVirus); tNewEnemy.type=0; tNewEnemy.bActive=1
      tNewEnemy=instance_create(528,128,oInjectorVirus); tNewEnemy.type=0; tNewEnemy.bActive=1
      sentrySpawn=0
    }
  }
}
else if global.gameProgress=4070 and room=rHPF_T //----- [5] Almost there -----
{
  if sceneProgress=0
  {
    sceneDelay+=1
    if sceneDelay=1 {global.gamePaused=true}
    if sceneDelay>=20 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=1 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","We're almost there now. This next room holds the main computer. You know the Virus has been here and set something up. It can't infect the system we're using. I know that much, but I don't know about any defenses it may have.",0,3,oMessageCutscene,1)
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"Chao","This place has a defense system set up for the main computer. It uses Sera as a guardian, but... it's not properly used? You'll see what I mean.",0,3,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Jeremy, she beat you on hacking into this place.",0,3,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","She does that.",0,3,oMessageCutscene,1)
  else if sceneProgress=5
  {
    showEmote(oIdentifier,0,-6,sEmLove)
    sceneDelay=0; sceneProgress=0
    global.gameProgress=4080
    global.gamePaused=false
  }
}
else if global.gameProgress=4080 and room=rHPF_U //----- [6] Sera's Intro -----
{
  if sceneProgress=0
  {
    if oPlayer1.x>=320
    {
      global.gamePaused=true
      oPlayer1.y+=4
      if oPlayer1.y>=288
      {
        scenePChk(320,288,0,0.1,1)
        stopPlayer()
        sceneProgress+=1
      }
    }
  }
  else if sceneProgress=1 and bWaitForInput=false
    msgCreate(0,0,"????","Halt!",6,3,oMessageCutscene,1)
  else if sceneProgress=2
  {
    sceneDelay+=1
    if sceneDelay=20
    {
      stopAllMusic(); global.currentMusic=0
      npcSera=instance_create(416,174,oNPC_Sera)
      npcSera.image_xscale=-1; npcSera.image_alpha=0
    }
    else if sceneDelay>=21 and sceneDelay<=70 {npcSera.image_alpha+=0.005}
    else if sceneDelay>=71 and sceneDelay<=120
    {
      npcSera.image_alpha+=0.1
      npcSera.y+=1
    }
    else if sceneDelay>=130 {npcSera.image_alpha=1; sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Jerry","I see what you mean now, Chao.",0,3,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Sera","Why are you here?",6,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","I need to use the system down here to remove the Virus infecting the Program.",0,3,oMessageCutscene,1)
  else if sceneProgress=6 and bWaitForInput=false
    msgCreate(0,0,"Sera","Admirable cause, but how can I know that's why you are here? Use of this system allows access to low level functions, I cannot just let anyone use it.",6,3,oMessageCutscene,1)
  else if sceneProgress=7 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Have you heard of a few humans gathering the resources necessary to remove the Virus?",0,3,oMessageCutscene,1)
  else if sceneProgress=8 and bWaitForInput=false
    msgCreate(0,0,"Sera","Most bots have heard of them, even down here, I have heard news of it. Can you prove you are those humans?",6,3,oMessageCutscene,1)
  else if sceneProgress=9
  {
    sceneDelay+=1
    if sceneDelay=10
    {
      var tFlash;
      tFlash=instance_create(0,0,oScreenFlash)
      tFlash.fadeSpeed=0.2
      for(i=0;i<6;i+=1)
      {
        pChip=instance_create(oPlayer1.x+lengthdir_x(24,i*60),oPlayer1.y-96+lengthdir_y(24,i*60),oMisc)
        pChip.sprite_index=sPauseM_Chips; pChip.image_index=i
        pChip.image_speed=0; pChip.type=1
      }
    }
    else if sceneDelay>=30 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=10 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","These are what's needed. The Program Chips you may have heard of.",0,3,oMessageCutscene,1)
  else if sceneProgress=11 and bWaitForInput=false
    msgCreate(0,0,"Sera","These are the objects needed for the Virus's removal and indeed proves who you are. You may proceed to the next room. However, a warning. You may only use this system to remove the Virus.",6,3,oMessageCutscene,1)
  else if sceneProgress=12
  {
    sceneDelay+=1
    if sceneDelay=10
    {
      var tFlash;
      tFlash=instance_create(0,0,oScreenFlash)
      tFlash.fadeSpeed=0.2
      with oMisc {instance_destroy()}
    }
    else if sceneDelay>=30 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=13 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Yes, you have my word.",0,3,oMessageCutscene,1)
  else if sceneProgress=14
  {
    sceneDelay=0; sceneProgress=0
    with oNPC_Sera {instance_destroy()}
    npcSera=instance_create(416,224,oNPC_Sera)
    npcSera.image_xscale=-1
    global.gameProgress=4090
    global.gamePaused=false
  }
}
else if global.gameProgress=4090 and room=rHPF_U //----- [Unskippable] Boss Fight: Sera -----
{
  if global.gamePaused=false
  {
    if global.bossTrack=0 //Before Virus Infection
    {
      if sceneProgress=0
      {
        if oPlayer1.x>=576
        {
          var enemyBarrier;
          enemyBarrier=instance_create(80,192,oSolidVirusBlock); enemyBarrier.image_yscale=6
          enemyBarrier=instance_create(640,192,oSolidVirusBlock); enemyBarrier.image_yscale=6
          var tStatic; tStatic=instance_create(0,0,oQuickStatic); tStatic.staticTime=10; tStatic.image_alpha=0.28
          msgCreate(0,0,"Virus","You cannot be allowed to go further.",5,1,oMessagePerson,0)
          newMessage.fadingTime=100
          sceneProgress+=1
        }
      }
      else if sceneProgress=1
      {
        sceneDelay+=1
        if sceneDelay=100
        {
          msgCreate(0,0,"Sera","It's trying to infect me.#HUMANS, we join together to keep the Virus away!",6,2,oMessagePerson,0)
          newMessage.fadingTime=140
        }
        else if sceneDelay=240
        {
          msgCreate(0,0,"Jeremy","Alright you guys. Don't let the Virus Infectors get to her. They're weaker than the ones from before, but there will be more this time.",0,3,oMessagePerson,0)
          newMessage.fadingTime=190
        }
        else if sceneDelay=430
        {
          var tempMplay;
          tempMplay=findMusic(813)
          playMusic(tempMplay,0,0)
          global.bossTrack=101
          storeStatus(0)
          sceneDelay=0; sceneProgress=0
        }
      }
    }
    else if global.bossTrack=101 //Defend Sera
    {
      if sceneProgress=0
      {
        oNPC_Sera.eventProg=1
        sceneProgress=1
      }
      else if sceneProgress=2
      {
        sceneDelay+=1
        if sceneDelay mod 3=0
        {
          if oNPC_Sera.image_blend=c_white {oNPC_Sera.image_blend=c_green}
          else {oNPC_Sera.image_blend=c_white}
        }
        
        if sceneDelay=40
        {
          msgCreate(0,0,"Sera","No, it will not infect me! I will fight this!",6,1,oMessagePerson,0)
          newMessage.fadingTime=70
        }
        else if sceneDelay=149 {musicFade=global.optMusic*100}
        else if sceneDelay>=150
        {
          musicFade-=30
          fadeVolume(global.msc_GiantEnemyRobot,30)
          if musicFade<=7000
          {
            stopAllMusic()
            oNPC_Sera.image_blend=c_black
            sceneDelay=0; sceneProgress+=1
          }
        }
      }
      else if sceneProgress=3
      {
        sceneDelay+=1
        if sceneDelay>=1 and sceneDelay<=32 {oNPC_Sera.y+=2}
        else if sceneDelay=33
        {
          playSound(global.snd_Slam,0,0.88,1)
          oNPC_Sera.sprite_index=sSeraIdle; oNPC_Sera.image_xscale=-1
        }
        else if sceneDelay=100
        {
          msgCreate(0,0,"Sera","I told you... You will die!",6,1,oMessagePerson,0)
          newMessage.fadingTime=80
        }
        else if sceneDelay=180
        {
          var tempMplay;
          tempMplay=findMusic(1005)
          playMusic(tempMplay,0,1)
          blendCol=0
        }
        else if sceneDelay>=181 and sceneDelay<=436
        {
          oNPC_Sera.y-=0.25
          if blendCol<255 {blendCol+=1}
          oNPC_Sera.image_blend=make_color_rgb(blendCol,blendCol,blendCol)
        }
        else if sceneDelay=480 {sceneDelay=0; sceneProgress+=1}
      }
      else if sceneProgress=4
      {
        var tBossTitle,tempMplay;
        tBossTitle=instance_create(0,0,oBossNameDisplay)
        tBossTitle.bossName="Sera"
        tBossTitle.bossTitle="Infected Defense Bot"
        tempMplay=findMusic(821)
        playMusic(tempMplay,0,0)
        with oHealthPickup {instance_destroy()}
        with oNPC_Sera {instance_destroy()}
        boss=instance_create(416,224,oSera)
        boss.activateBoss=1
        global.currentBoss="Sera"
        global.bossTrack=1
        oPlayer1.life=oPlayer1.maxLife
        storeStatus(0)
        sceneDelay=0; sceneProgress=0
      }
    }
    else if global.bossTrack=1
    {
      if sceneProgress=1 //End Boss
      {
        awardBossAP(10000)
        global.bossTrack=2
        sceneProgress=0
      }
    }
    else if global.bossTrack=2
    {
      if sceneProgress=0
      {
        var tFullHeartDrop,tempMplay;
        tFullHeartDrop=instance_create(368,128,oHealthPickup)
        tFullHeartDrop.sprite_index=sFullHealthPickup
        tempMplay=findMusic(19)
        playMusic(tempMplay,0,0)
        with oSolidVirusBlock {instance_destroy()}
        global.gamePaused=false
        global.currentBoss=""
        global.bossTrack=0
        global.gameProgress=4100
      }
    }
  }
}
else if global.gameProgress=4100 and room=rHPF_V //----- [7] Shutting down the Virus for good -----
{
  if sceneProgress=0
  {
    if oPlayer1.x>=224
    {
      global.gamePaused=true
      oPlayer1.y+=4
      if oPlayer1.y>=288
      {
        var tFlash;
        tFlash=instance_create(0,0,oScreenFlash)
        tFlash.fadeSpeed=0.2
        scenePChk(224,288,0,0.1,1)
        oPlayer1.visible=0
        charJerry=instance_create(232,288,oMisc)
        charJerry.sprite_index=sJerryIdle; charJerry.image_speed=0.1; charJerry.type=2
        charClaire=instance_create(168,288,oMisc)
        charClaire.sprite_index=sClaireIdle; charClaire.image_speed=0.1; charClaire.type=2
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
    msgCreate(0,0,"Jeremy","This is it you guys. The moment we've been fighting for.",0,3,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Feels good to finally be here.",0,3,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Just give me a second to get into the system.",0,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Sounds good, I bet the Virus can't do anything to stop this now.",0,3,oMessageCutscene,1)
  else if sceneProgress=6 and bWaitForInput=false
    msgCreate(0,0,"Claire","I feel sad for Sera back there. That wasn't fair.",0,3,oMessageCutscene,1)
  else if sceneProgress=7 and bWaitForInput=false
    msgCreate(0,0,"Jerry","...Well... I don't know what to say.",0,3,oMessageCutscene,1)
  else if sceneProgress=8 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","And I'm in!",0,3,oMessageCutscene,1)
  else if sceneProgress=9 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Holy hell, that was fast!",0,3,oMessageCutscene,1)
  else if sceneProgress=10 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","No hacking involved from here. Sera was right, I have access to a lot of low level stuff here.",0,3,oMessageCutscene,1)
  else if sceneProgress=11 and bWaitForInput=false
    msgCreate(0,0,"Claire","You said you wouldn't mess with anything!",0,3,oMessageCutscene,1)
  else if sceneProgress=12 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Chill Claire, I won't. I was just... looking.",0,3,oMessageCutscene,1)
  else if sceneProgress=13 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Do we need to do anything with the Program Chips?",0,3,oMessageCutscene,1)
  else if sceneProgress=14 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","When we had them out earlier, I got what I needed from them. So anyway, we can do this. This will allow the program to completely remove the Virus, but...",0,3,oMessageCutscene,1)
  else if sceneProgress=15 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Buuuuut... what?",0,3,oMessageCutscene,1)
  else if sceneProgress=16 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","We have to restart the program for this to fully take effect. This terminal will allow me to do that.",0,3,oMessageCutscene,1)
  else if sceneProgress=17 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Whoa, hold up! RESTART IT?! Wouldn't that... well... kill everything in it? INCLUDING us?!",0,3,oMessageCutscene,1)
  else if sceneProgress=18 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","No no, I should have specified, the world functions won't go down, they can't. Only certain parts of the program will, and they'll only be down for maybe a second.",0,3,oMessageCutscene,1)
  else if sceneProgress=19 and bWaitForInput=false
    msgCreate(0,0,"Chao","Jeremy's right. We'll be okay if we do this. Once the program fully comes back on again, everything will be right where it was before. Except for the Virus, it'll be gone.",0,3,oMessageCutscene,1)
  else if sceneProgress=20 and bWaitForInput=false
    msgCreate(0,0,"Claire","Will the program be able to speak again, and will it remember us?",0,3,oMessageCutscene,1)
  else if sceneProgress=21 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","I don't know about that yet. There's no reason why its memory of past events would be wiped. I'm almost 100% certain that it could observe everything that's been going on. I'm sure it even tried to communicate in some ways.",0,3,oMessageCutscene,1)
  else if sceneProgress=22 and bWaitForInput=false
    msgCreate(0,0,"Jerry","What do you think, Claire?",0,3,oMessageCutscene,1)
  else if sceneProgress=23 and bWaitForInput=false
    msgCreate(0,0,"Claire","I guess we have to do this. I don't know of any way to remove the Virus.",0,3,oMessageCutscene,1)
  else if sceneProgress=24 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Abilities, shields, just... everything. It all goes down with the restart, but only for roughly a second. It shouldn't have any adverse effects.",0,3,oMessageCutscene,1)
  else if sceneProgress=25 and bWaitForInput=false
    msgCreate(0,0,"Jerry","A 1 second window for Hex to screw with something.",0,3,oMessageCutscene,1)
  else if sceneProgress=26 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","I'm worried about that too, but what choice do we have? And if this goes how it should, the program will remove him after this.",0,3,oMessageCutscene,1)
  else if sceneProgress=27 and bWaitForInput=false
    msgCreate(0,0,"Claire","Just do it, Jeremy.",0,3,oMessageCutscene,1)
  else if sceneProgress=28 and bWaitForInput=false
    msgCreate(0,0,"Jerry","... What Claire said.",0,3,oMessageCutscene,1)
  else if sceneProgress=29 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","You ready, sis?",0,3,oMessageCutscene,1)
  else if sceneProgress=30 and bWaitForInput=false
    msgCreate(0,0,"Chao","Let's do this!",0,3,oMessageCutscene,1)
  else if sceneProgress=31 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Hold onto your butts!",0,3,oMessageCutscene,1)
  else if sceneProgress=32
  {
    sceneDelay+=1
    if sceneDelay=10
    {
      var tFlash;
      tFlash=instance_create(0,0,oScreenFlash)
      tFlash.fadeSpeed=0.2
      chipDir=0
      chipDist=8
      for(i=0;i<6;i+=1)
      {
        pChip[i]=instance_create(oPlayer1.x+lengthdir_x(24,i*60),oPlayer1.y-96+lengthdir_y(24,i*60),oMisc)
        pChip[i].sprite_index=sPauseM_Chips; pChip[i].image_index=i
        pChip[i].image_speed=0; pChip[i].type=1
      }
    }
    else if sceneDelay>=11 and sceneDelay<=80
    {
      for(i=0;i<6;i+=1)
      {
        pChip[i].x=oPlayer1.x+lengthdir_x(chipDist,chipDir+(i*60))
        pChip[i].y=oPlayer1.y-96+lengthdir_y(chipDist,chipDir+(i*60))
      }
      chipDir+=17
      chipDist+=2
    }
    else if sceneDelay=81
    {
      stopAllMusic()
      var tFlash;
      tFlash=instance_create(0,0,oScreenFlash)
      tFlash.fadeSpeed=0.2
      for(i=0;i<6;i+=1)
      {
        with (pChip[i]) {instance_destroy()}
      }
    }
    else if sceneDelay=95
    {
      fadeAlpha=1
      oIdentifier.visible=0
      remMenuState=global.optShowHUD
      global.optShowHUD=0
      playSound(global.snd_Slam,0,1,1)
    }
    else if sceneDelay=98
    {
      fadeColor=c_black
      charJerry.image_xscale=-1
      npcHex=instance_create(400,192,oMisc)
      npcHex.sprite_index=sHex_A_Idle; npcHex.image_xscale=-1; npcHex.image_alpha=0.08 npcHex.type=4; npcHex.moveStep=pi/2
    }
    else if sceneDelay=158
    {
      fadeAlpha=0
      oIdentifier.visible=1
      global.optShowHUD=remMenuState
      playSound(global.snd_HardHit1,0,1,1)
    }
    else if sceneDelay>=180 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=33 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Did uh... did we do it? Did it work?",0,3,oMessageCutscene,1)
  else if sceneProgress=34 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","...",0,3,oMessageCutscene,1)
  else if sceneProgress=35 and bWaitForInput=false
    msgCreate(0,0,"Claire","Jeremy!",0,3,oMessageCutscene,1)
  else if sceneProgress=36 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","It did... IT WORKED! The damn Virus is actually gone!",0,3,oMessageCutscene,1)
  else if sceneProgress=37
  {
    sceneDelay+=1
    if sceneDelay=1
    {
      var tempMplay;
      tempMplay=findMusic(1)
      playMusic(tempMplay,0,0)
    }
    else if sceneDelay>=30 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=38 and bWaitForInput=false
    msgCreate(0,0,"Claire","It's really gone?",0,3,oMessageCutscene,1)
  else if sceneProgress=39 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Hell yeah! IN YOUR FACE, VIRUS!",0,3,oMessageCutscene,1)
  else if sceneProgress=40 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","All the functions that the Virus had blocked should be coming back up in no time.",0,3,oMessageCutscene,1)
  else if sceneProgress=41 and bWaitForInput=false
    msgCreate(0,0,"Chao","Now you two can finally go on that date you've been meaning to ask each other about.",0,3,oMessageCutscene,1)
  else if sceneProgress=42 and bWaitForInput=false
    msgCreate(0,0,"Jerry","I don't ask, Chao. I tell her we are.",0,3,oMessageCutscene,1)
  else if sceneProgress=43 and bWaitForInput=false
    msgCreate(0,0,"Claire","Whatever, Jerry.",0,3,oMessageCutscene,1)
  else if sceneProgress=44 and bWaitForInput=false
    msgCreate(0,0,"Jerry","It sorta worked on you in college.",0,3,oMessageCutscene,1)
  else if sceneProgress=45 and bWaitForInput=false
    msgCreate(0,0,"Claire","Different times...",0,3,oMessageCutscene,1)
  else if sceneProgress=46
  {
    sceneDelay+=1
    if sceneDelay=1 {showEmote(charClaire,0,-56,sEmExcite)}
    else if sceneDelay=5
    {
      stopAllMusic()
      msgCreate(0,0,"Claire","Jerry look out!!",0,2,oMessagePerson,0)
      newMessage.fadingTime=30
    }
    else if sceneDelay=10
    {
      npcHex.image_alpha=1
      hexMeteor=instance_create(npcHex.x,npcHex.y-16,oMisc)
      with hexMeteor
      {
        sprite_index=sDraculaMeteor; type=1
        speed=18; direction=point_direction(x,y,oEvCh17MainA.charJerry.x,oEvCh17MainA.charJerry.y)
      }
    }
    else if sceneDelay>=11 and sceneDelay<=99
    {
      if hexMeteor.y>=272
      {
        playSound(global.snd_Slam,0,0.9,1)
        playSound(global.snd_Fireball,0,1,1)
        playSound(global.snd_BombExplode,0,0.95,1)
        charJerry.sprite_index=sJerrySit; charJerry.x=432
        fadeAlpha=1
        sceneDelay=100
      }
    }
    else if sceneDelay>=141 and sceneDelay<=190 {fadeAlpha-=0.02}
    else if sceneDelay>=210
    {
      var tempMplay;
      tempMplay=findMusic(1001)
      playMusic(tempMplay,0,0)
      sceneDelay=0; sceneProgress+=1
    }
  }
  else if sceneProgress=47 and bWaitForInput=false
    msgCreate(0,0,"Hex","You spoiled my fun, Claire. I was really hoping to get both of you. But what can you do? And that was a really touching moment you all had.",0,3,oMessageCutscene,1)
  else if sceneProgress=48 and bWaitForInput=false
    msgCreate(0,0,"Claire","Jerry! Are you okay?!",0,3,oMessageCutscene,1)
  else if sceneProgress=49
  {
    sceneDelay+=1
    if sceneDelay=1 {charClaire.sprite_index=sClaireWalk; charClaire.image_speed=0.33}
    else if sceneDelay>=2 and sceneDelay<=11 {charClaire.x+=7}
    if sceneDelay=8
    {
      enemyBarrier=instance_create(48,224,oEnemyBarrier); enemyBarrier.image_yscale=4
      enemyBarrier=instance_create(368,96,oEnemyBarrier); enemyBarrier.image_yscale=12
    }
    else if sceneDelay=12 {charClaire.sprite_index=sClaireIdle; charClaire.image_speed=0.1}
    if sceneDelay>=20 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=50 and bWaitForInput=false
    msgCreate(0,0,"Hex","Can't be having that.",0,3,oMessageCutscene,1)
  else if sceneProgress=51 and bWaitForInput=false
    msgCreate(0,0,"Claire","What the hell are you going to do?",0,3,oMessageCutscene,1)
  else if sceneProgress=52 and bWaitForInput=false
    msgCreate(0,0,"Hex","Patience, Claire.",0,3,oMessageCutscene,1)
  else if sceneProgress=53 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","How did you even get in here?",0,3,oMessageCutscene,1)
  else if sceneProgress=54 and bWaitForInput=false
    msgCreate(0,0,"Hex","Oh I've BEEN here! I've waited for you and known about this place for some time. It's just, once again, bots can't interface with the terminal here. Luckily you removed the Virus and got some of those backdoors opened up again with that restart.",0,3,oMessageCutscene,1)
  else if sceneProgress=55 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","That's not even possible for you to have activated all that in only a second's time.",0,3,oMessageCutscene,1)
  else if sceneProgress=56 and bWaitForInput=false
    msgCreate(0,0,"Hex","Let's face it, I'm better than you now, Jeremy. Now that this is all done, I have everything I need. You guys are pointless to keep around now. Let's start with Jerry.",0,3,oMessageCutscene,1)
  else if sceneProgress=57 and bWaitForInput=false
    msgCreate(0,0,"Claire","Don't you dare!",0,3,oMessageCutscene,1)
  else if sceneProgress=58 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","We need to break that barrier down. See what you can do, Claire!",0,3,oMessageCutscene,1)
  else if sceneProgress=59
  {
    if !instance_exists(oEnemyBarrier)
    {
      enemyBarrier=instance_create(48,224,oEnemyBarrier); enemyBarrier.image_yscale=4
      enemyBarrier=instance_create(368,96,oEnemyBarrier); enemyBarrier.image_yscale=12
    }
    fadeAlpha=0
    oIdentifier.visible=1
    global.optShowHUD=remMenuState
    var tempMplay;
    tempMplay=findMusic(1001)
    playMusic(tempMplay,0,0)
    with oMisc {instance_destroy()}
    npcHex=instance_create(400,192,oMisc)
    npcHex.sprite_index=sHex_A_Idle; npcHex.image_xscale=-1; npcHex.type=4; npcHex.moveStep=pi/2
    charJerry=instance_create(432,288,oMisc)
    charJerry.sprite_index=sJerrySit; charJerry.image_speed=0.1; charJerry.type=2; charJerry.image_xscale=-1
    oPlayer1.visible=1
    oPlayer1.x=238
    charSwitcher(1)
    global.canCharSwap=1
    sceneDelay=0; sceneProgress=0
    global.gameProgress=4110
    global.gamePaused=false
  }
}
else if global.gameProgress=4110 and room=rHPF_V //----- [] Jerry is trapped -----
{
  if global.gamePaused=false
  {
    if sceneProgress=0
    {
      sceneDelay+=1
      if sceneDelay=1
      {
        with oMisc {instance_destroy()}
        npcHex=instance_create(400,192,oMisc)
        npcHex.sprite_index=sHex_A_Idle; npcHex.image_xscale=-1; npcHex.type=4; npcHex.moveStep=pi/2
        charJerry=instance_create(432,288,oMisc)
        charJerry.sprite_index=sJerrySit; charJerry.image_speed=0.1; charJerry.type=2; charJerry.image_xscale=-1
      }
      else if sceneDelay=60
      {
        msgCreate(0,0,"Claire","Let him go!!",0,2,oMessagePerson,0)
        newMessage.fadingTime=70
      }
      else if sceneDelay=90 {charJerry.sprite_index=sJerryDamaged}
      else if sceneDelay>=91 and sceneDelay<=218
      {
        charJerry.y-=0.5
        if sceneDelay=160
        {
          msgCreate(0,0,"Hex","Now why would I do something like that?",0,2,oMessagePerson,0)
          newMessage.fadingTime=150
        }
      }
      else if sceneDelay=320
      {
        jerrySoul=instance_create(charJerry.x,charJerry.y-26,oEffectB)
        jerrySoul.type=3; jerrySoul.sprite_index=sEfFirefly; jerrySoul.newBlend=1
        jerrySoul.image_alpha=0.6; jerrySoul.image_xscale=0.2; jerrySoul.image_yscale=0.2
        jerrySoul.fadeSpd=0; jerrySoul.AccelX=0; jerrySoul.AccelY=0; jerrySoul.followID=-1; jerrySoul.rotation=15
      }
      else if sceneDelay>=331 and sceneDelay<=394 {jerrySoul.y-=0.5}
      else if sceneDelay=420
      {
        var tEfJS;
        for(i=0;i<24;i+=1)
        {
          tEfJS=instance_create(jerrySoul.x,jerrySoul.y,oEffectB)
          tEfJS.type=3; tEfJS.sprite_index=sEfFirefly; tEfJS.newBlend=1; tEfJS.image_xscale=0.2; tEfJS.image_yscale=0.2
          tEfJS.fadeSpd=0.1; tEfJS.AccelX=0; tEfJS.AccelY=0; tEfJS.followID=-1; tEfJS.rotation=15
          tEfJS.direction=random(360); tEfJS.speed=2+random(1)
          stopAllMusic(); global.currentMusic=0
          npcHex.image_blend=c_white
        }
        with jerrySoul {instance_destroy()}
      }
      else if sceneDelay=450 {charJerry.sprite_index=sJerryFall; fallSpd=0}
      else if sceneDelay>=451 and sceneDelay<=599
      {
        fallSpd+=0.2
        charJerry.y+=fallSpd
        if charJerry.y>=288
        {
          tEffect=instance_create(charJerry.x,charJerry.y,oEffect)
          tEffect.sprite_index=sGroundDust; tEffect.image_speed=0.33
          tEffect.image_alpha=0.85; tEffect.image_xscale=1.25; tEffect.image_yscale=1.25
          tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
          charJerry.sprite_index=sJerryFallBounce
          fallSpd=-3
          sceneDelay=600
        }
      }
      else if sceneDelay>=601 and sceneDelay<=699
      {
        fallSpd+=0.2
        charJerry.y+=fallSpd
        if charJerry.y>=288
        {
          charJerry.sprite_index=sJerryLayDown
          charJerry.y=288
          sceneDelay=0; sceneProgress+=1
        }
      }
      
      if sceneDelay>=280 and sceneDelay<=419 //Circle effect
      {
        if sceneDelay mod 4=0
        {
          var tEfCir;
          tEfCir=instance_create(npcHex.x,npcHex.y-64,oEfCircleBlast)
          tEfCir.image_alpha=0.75; tEfCir.myRad=8; tEfCir.radScl=4; tEfCir.fadeSpeed=0.15
        }
      }
      if sceneDelay>=300 and sceneDelay<=419 //Flash Hex
      {
        if sceneDelay mod 3=0
        {
          if npcHex.image_blend=c_white {npcHex.image_blend=c_red}
          else {npcHex.image_blend=c_white}
        }
      }
    }
    else if sceneProgress=1
    {
      sceneDelay+=1
      if sceneDelay=1
      {
        msgCreate(0,0,"Claire","JERRY!!",0,1,oMessagePerson,0)
        newMessage.fadingTime=50
      }
      else if sceneDelay=50
      {
        msgCreate(0,0,"Claire","What did you do?!",0,1,oMessagePerson,0)
        newMessage.fadingTime=70
      }
      else if sceneDelay=120
      {
        msgCreate(0,0,"Hex","He won't be waking up any time soon. As in, ever.",0,1,oMessagePerson,0)
        newMessage.fadingTime=100
      }
      else if sceneDelay=220
      {
        msgCreate(0,0,"Hex","And for you, Claire. You won't be leaving this place alive.",0,2,oMessagePerson,0)
        newMessage.fadingTime=130
      }
      else if sceneDelay=350
      {
        var tFlash;
        tFlash=instance_create(0,0,oScreenFlash)
        tFlash.fadeSpeed=0.2
        with npcHex {instance_destroy()}
        with oEnemyBarrier {instance_destroy()}
        enemyBarrier=instance_create(48,224,oEnemyBarrier); enemyBarrier.image_yscale=4
        sceneDelay=0; sceneProgress+=1
      }
    }
    else if sceneProgress=2
    {
      sceneDelay+=1
      if sceneDelay=60
      {
        msgCreate(0,0,"Claire","Is Jerry going to be okay? What did he do?",0,1,oMessagePerson,0)
        newMessage.fadingTime=100
      }
      else if sceneDelay=160
      {
        msgCreate(0,0,"Jeremy","I don't know yet... Whatever he did to Jerry, it's something new.",0,2,oMessagePerson,0)
        newMessage.fadingTime=130
      }
      else if sceneDelay=290
      {
        msgCreate(0,0,"Claire","What can we do?",0,2,oMessagePerson,0)
        newMessage.fadingTime=70
      }
      else if sceneDelay=360
      {
        msgCreate(0,0,"Jeremy","First, you need to get out of here. Hex has unfortunately removed the teleporter from the room back there. I won't say my usual, just... get out of this place.",0,3,oMessagePerson,0)
        newMessage.fadingTime=210
      }
      else if sceneDelay=570
      {
        msgCreate(0,0,"Jeremy","I'll keep Jerry safe.",0,1,oMessagePerson,0)
        newMessage.fadingTime=70
      }
      else if sceneDelay>=531 and sceneDelay<=570
      {
        charJerry.image_alpha-=0.025
      }
      else if sceneDelay=640
      {
        msgCreate(0,0,"Claire","Hex is going to get it when we get out of here!",0,1,oMessagePerson,0)
        newMessage.fadingTime=120
        global.pLife=global.pMaxLife
        oPlayer1.life=oPlayer1.maxLife
        with oEnemyBarrier {instance_destroy()}
        sceneDelay=0; sceneProgress=0
        global.gameProgress=4120
      }
    }
  }
}
else if global.gameProgress=4120 and room=rHPF_U //----- [Unskippable] Enemy Trap (Malignant Ooze) -----
{
  if global.gamePaused=false
  {
    if global.bossTrack=0
    {
      if sceneProgress=0
      {
        if oPlayer1.x<=480
        {
          var enemyBarrier;
          enemyBarrier=instance_create(80,192,oEnemyBarrier); enemyBarrier.image_yscale=6
          enemyBarrier=instance_create(640,192,oEnemyBarrier); enemyBarrier.image_yscale=6
          sceneProgress+=1
        }
      }
      else if sceneProgress=1
      {
        sceneDelay+=1
        if sceneDelay=10
        {
          eImageDrop=instance_create(368,288,oMisc)
          eImageDrop.sprite_index=sMO_Idle; eImageDrop.image_speed=0; eImageDrop.type=1; eImageDrop.image_yscale=0
          var tempMplay;
          tempMplay=findMusic(809)
          playMusic(tempMplay,0,0)
        }
        else if sceneDelay>=11 and sceneDelay<=110
        {
          var tEffect;
          for(i=0;i<2;i+=1)
          {
            tEffect=instance_create(eImageDrop.x+random_range(-9,9),eImageDrop.y-random(72*image_yscale),oEffectGrav)
            tEffect.sprite_index=sPoisonCloud; tEffect.image_speed=0.1; tEffect.rotation=0; tEffect.grav=0.3
            tEffect.fadeSpd=0.05; tEffect.newBlend=-1; tEffect.image_xscale=0.75; tEffect.image_yscale=0.75
            tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=random_range(-2,2); tEffect.ySpd=-5-random(2); tEffect.type=1
          }
          eImageDrop.image_yscale+=0.01
        }
        else if sceneDelay>=120 {sceneDelay=0; sceneProgress+=1}
      }
      else if sceneProgress=2
      {
        sceneDelay+=1
        if sceneDelay=20
          {msgCreate(0,0,"Malignant Ooze","Die, Claire.",5,1,oMessagePerson,0); newMessage.fadingTime=80}
        else if sceneDelay>=110
        {
          with eImageDrop {instance_destroy()}
          createEnemy(368,288,oMalignantOoze,2,0,1)
          global.bossTrack=101
          storeStatus(0)
          sceneDelay=0; sceneProgress=0
        }
      }
    }
    else if global.bossTrack=101
    {
      if sceneProgress=0
      {
        if !instance_exists(oEnemyBase)
        {
          with oEnemyBarrier {instance_destroy()}
          var tempMplay;
          tempMplay=findMusic(19)
          playMusic(tempMplay,0,0)
          msgCreate(0,0,"Claire","...",0,0,oMessagePerson,0); newMessage.fadingTime=130
          global.bossTrack=0
          global.gameProgress=4130
        }
      }
    }
  }
}
else if global.gameProgress=4130 and room=rHPF_I //----- [] Too quiet -----
{
  if sceneProgress=0
  {
    if oPlayer1.x<=1040
    {
      msgCreate(0,0,"Claire","It's too quiet here.",0,0,oMessagePerson,0); newMessage.fadingTime=80
      global.gameProgress=4140
    }
  }
}
else if global.gameProgress=4140 and room=rHPF_G //----- [] Hex enemies -----
{
  if sceneProgress=0
  {
    if oPlayer1.x<=3328
    {
      var tNewEnemy, enemyBarrier;
      tNewEnemy=instance_create(3072,1184,oBloodTyrant)
      enemyBarrier=instance_create(2976,1024,oEnemyBarrier); enemyBarrier.image_yscale=6
      enemyBarrier=instance_create(3360,1056,oEnemyBarrier); enemyBarrier.image_yscale=8
      sceneProgress+=1
    }
  }
  else if sceneProgress=1
  {
    if !instance_exists(oBloodTyrant)
    {
      with oEnemyBarrier {instance_destroy()}
      sceneProgress+=1
    }
  }
  else if sceneProgress=2
  {
    if oPlayer1.x<=2048
    {
      var tNewEnemy, enemyBarrier;
      tNewEnemy=instance_create(1696,672,oMalignantOoze)
      enemyBarrier=instance_create(1152,544,oEnemyBarrier); enemyBarrier.image_yscale=8
      enemyBarrier=instance_create(2160,544,oEnemyBarrier); enemyBarrier.image_yscale=8
      sceneProgress+=1
    }
  }
  else if sceneProgress=3
  {
    if !instance_exists(oMalignantOoze)
    {
      with oEnemyBarrier {instance_destroy()}
      sceneProgress=0
      global.gameProgress=4150
    }
  }
}
else if room=rCCity_NA_S1 and global.gameProgress=4190 //----- [8] Waking up Jerry -----
{
  if sceneProgress=0
  {
    sceneDelay+=1
    if sceneDelay=1
    {
      var tempMplay;
      tempMplay=findMusic(0)
      playMusic(tempMplay,0,0)
      global.gamePaused=true;
      (360811).image_xscale=1
      scenePChk(224,384,0,0.1,1)
      charJerry=instance_create(176,384,oMisc)
      charJerry.sprite_index=sJerryLayDown; charJerry.image_speed=0; charJerry.type=2
    }
    if sceneDelay>=40
    {
      fadeAlpha-=0.025
      if fadeAlpha<=0 {sceneDelay=0; sceneProgress+=1}
    }
  }
  else if sceneProgress=1
  {
    sceneDelay+=1
    if sceneDelay>=20 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","And that's everything that happened.",0,3,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Claire","Is there anything we can do to wake Jerry?",0,3,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"John","I haven't seen this either. Hex is doing something different now.",6,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Bubblun","...",6,3,oMessageCutscene,1)
  else if sceneProgress=6 and bWaitForInput=false
    msgCreate(0,0,"Lovelun","We can wake him.",6,3,oMessageCutscene,1)
  else if sceneProgress=7 and bWaitForInput=false
  {
    oPlayer1.image_xscale=-1
    msgCreate(0,0,"Claire","Really?! You can?!",0,3,oMessageCutscene,1)
  }
  else if sceneProgress=8 and bWaitForInput=false
    msgCreate(0,0,"Lovelun","Bubby and I know how, yes.",6,3,oMessageCutscene,1)
  else if sceneProgress=9 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","How do you know what this is?",0,3,oMessageCutscene,1)
  else if sceneProgress=10 and bWaitForInput=false
    msgCreate(0,0,"Bubblun","We've seen the Warmaster use this technique. It works on both bots and humans. Once it's used, the target will never wake up unless they receive true love's kiss.",6,3,oMessageCutscene,1)
  else if sceneProgress=11 and bWaitForInput=false
    msgCreate(0,0,"Claire","Are you serious?",0,3,oMessageCutscene,1)
  else if sceneProgress=12 and bWaitForInput=false
    msgCreate(0,0,"Bubblun","...No, I'm not. Was a silly joke.",6,3,oMessageCutscene,1)
  else if sceneProgress=13 and bWaitForInput=false
    msgCreate(0,0,"Claire","This is no time to joke around!",0,3,oMessageCutscene,1)
  else if sceneProgress=14 and bWaitForInput=false
    msgCreate(0,0,"Bubblun","Everything will be fine, Claire. Waking someone from this isn't hard and Jerry is in no real danger.",6,3,oMessageCutscene,1)
  else if sceneProgress=15 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","So Hex was just trying to scare us with this...",0,3,oMessageCutscene,1)
  else if sceneProgress=16 and bWaitForInput=false
    msgCreate(0,0,"Bubblun","Ready, Love?",6,3,oMessageCutscene,1)
  else if sceneProgress=17 and bWaitForInput=false
    msgCreate(0,0,"Lovelun","Of course!",6,3,oMessageCutscene,1)
  else if sceneProgress=18
  {
    sceneDelay+=1
    if sceneDelay>=20 and sceneDelay<=90
    {
      var tEfJS,tDir;
      tDir=random(360)
      tEfJS=instance_create(charJerry.x+lengthdir_x(64,tDir),charJerry.y-8+lengthdir_y(64,tDir),oEffectB)
      tEfJS.type=3; tEfJS.sprite_index=sEfFirefly; tEfJS.newBlend=1; tEfJS.image_xscale=0.2; tEfJS.image_yscale=0.2
      tEfJS.fadeSpd=0.05; tEfJS.AccelX=0; tEfJS.AccelY=0; tEfJS.followID=-1; tEfJS.rotation=15
      tEfJS.direction=tDir-180; tEfJS.speed=2.75+random(0.75)
    }
    else if sceneDelay=91
    {
      var tFlash;
      tFlash=instance_create(0,0,oScreenFlash)
      tFlash.fadeSpeed=0.2
    }
    else if sceneDelay=140 {charJerry.sprite_index=sJerryGetUp}
    else if sceneDelay=146 {charJerry.image_index=1}
    else if sceneDelay=152 {charJerry.image_index=2}
    else if sceneDelay=158 {charJerry.image_index=3}
    else if sceneDelay=164 {charJerry.sprite_index=sJerryIdle; charJerry.image_speed=0.1}
    else if sceneDelay>=190 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=19 and bWaitForInput=false
    msgCreate(0,0,"Claire","Are you okay, Jerry?",0,3,oMessageCutscene,1)
  else if sceneProgress=20 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Pretty good, thanks to you guys.",0,3,oMessageCutscene,1)
  else if sceneProgress=21 and bWaitForInput=false
    msgCreate(0,0,"Claire","Could you hear us?",0,3,oMessageCutscene,1)
  else if sceneProgress=22 and bWaitForInput=false
    msgCreate(0,0,"Jerry","I could hear it, but I couldn't see any of it, nor could I do anything.",0,3,oMessageCutscene,1)
  else if sceneProgress=23 and bWaitForInput=false
    msgCreate(0,0,"Chao","We're glad to have you back with us!",0,3,oMessageCutscene,1)
  else if sceneProgress=24 and bWaitForInput=false
    msgCreate(0,0,"John","Huh... So you two have met the Warmaster?",6,3,oMessageCutscene,1)
  else if sceneProgress=25 and bWaitForInput=false
    msgCreate(0,0,"Bubblun","A lot of bots have. He wasn't always as aggressive as he is now.",6,3,oMessageCutscene,1)
  else if sceneProgress=26 and bWaitForInput=false
    msgCreate(0,0,"Jerry","What's our next move anyway? Hex is still out there and he's got something planned, we know that.",0,3,oMessageCutscene,1)
  else if sceneProgress=27 and bWaitForInput=false
    msgCreate(0,0,"John","You said Hex mentioned that certain functions were unlocked?",6,3,oMessageCutscene,1)
  else if sceneProgress=28 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Yeah, has anything changed recently?",0,3,oMessageCutscene,1)
  else if sceneProgress=29 and bWaitForInput=false
    msgCreate(0,0,"John","There's a CHAOS facility up north that's had a lot of activity very recently. CHAOS themselves, only minutes ago, have been invading other places. A lot of places on the mainland are under their control.",6,3,oMessageCutscene,1)
  else if sceneProgress=30 and bWaitForInput=false
    msgCreate(0,0,"Claire","I say we get into that facility and blow it away.",0,3,oMessageCutscene,1)
  else if sceneProgress=31 and bWaitForInput=false
    msgCreate(0,0,"John","Something very important to Hex is there, I know it. He and the Warmaster mentioned something about it when I was locked up in Neo Grime.",6,3,oMessageCutscene,1)
  else if sceneProgress=32 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Yeah, we know what to do then. I'm very certain that Hex knows there's a possibility that you got out, Claire.",0,3,oMessageCutscene,1)
  else if sceneProgress=33 and bWaitForInput=false
    msgCreate(0,0,"John","If you're seen by any CHAOS member, they'll send word to the Warmaster. He's got CHAOS far more organized than I thought.",6,3,oMessageCutscene,1)
  else if sceneProgress=34 and bWaitForInput=false
    msgCreate(0,0,"Bubblun","If you take out the Warmaster, CHAOS will fall apart. He's just not a bot you want to mess around with though.",6,3,oMessageCutscene,1)
  else if sceneProgress=35 and bWaitForInput=false
    msgCreate(0,0,"John","Jeremy, I made more explosives while you were down in the facility. Sending them to you now. Blow that facility apart. Whatever they have there, it's a big part of Hex's plans.",6,3,oMessageCutscene,1)
  else if sceneProgress=36 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","We will. Just a reminder for you guys, we're heading north from the 'Greatest Stretch - North'.",0,3,oMessageCutscene,1)
  else if sceneProgress=37
  {
    var tempMplay;
    tempMplay=findMusic(2)
    playMusic(tempMplay,0,0)
    var tFlash;
    tFlash=instance_create(0,0,oScreenFlash)
    tFlash.fadeSpeed=0.2
    global.CHAOS_Invasion=1
    with oMisc {instance_destroy()}
    global.canCharSwap=2
    sceneDelay=0; sceneProgress=0
    global.gameProgress=4200
    global.gamePaused=false
  }
}

keyWaitForInput()

if oKeyCodes.kCodePressed[11]=1 and global.gamePaused=true and sceneProgress>=1 //Cutscene skip
{
  if !instance_exists(oPauseMenu)
  {
    if global.gameProgress=3930 and room=rHPF_A //[1]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      fadeAlpha=0; sceneDelay=0
      sceneProgress=6
    }
    else if global.gameProgress=3960 and room=rHPF_A //[2]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      fadeAlpha=0; sceneDelay=0
      sceneProgress=5
    }
    else if global.gameProgress=3980 and room=rHPF_C //[3]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      fadeAlpha=0; sceneDelay=0
      sceneProgress=4
    }
    else if global.gameProgress=4020 and room=rHPF_N //[4]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      fadeAlpha=0; sceneDelay=0
      sceneProgress=11
    }
    else if global.gameProgress=4070 and room=rHPF_T //[5]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      fadeAlpha=0; sceneDelay=0
      sceneProgress=5
    }
    else if global.gameProgress=4080 and room=rHPF_U //[6]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      fadeAlpha=0; sceneDelay=0
      sceneProgress=14
    }
    else if global.gameProgress=4100 and room=rHPF_V //[7]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      fadeAlpha=0; sceneDelay=0
      sceneProgress=59
    }
    else if room=rCCity_NA_S1 and global.gameProgress=4190 //[8]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      fadeAlpha=0; sceneDelay=0
      sceneProgress=37
    }
  }
}

//----- Room specific events -----
if global.gamePaused=false
{
  if room=rHPF_E
  {
    if oPlayer1.x>=1704 and oPlayer1.x<=1720
    {
      if scriptPlat=0 {(351421).progCheck=1; scriptPlat=1}
    }
  }
  else if room=rHPF_L //----- Virus's spawn -----
  {
    if rmLSpawn=1
    {
      if virusTime=0
      {
        if oPlayer1.x>=448 and oPlayer1.x<=480 {virusTime=1}
      }
      else if virusTime>=1
      {
        virusTime+=1
        if virusTime=10
        {
          var tNewVirus;
          tNewVirus=instance_create(448,144,oInjectorVirus)
          tNewVirus.type=1
        }
        else if virusTime=50
        {
          var tNewVirus;
          tNewVirus=instance_create(512,176,oInjectorVirus)
          tNewVirus.type=1
        }
        else if virusTime=80
        {
          var tNewVirus;
          tNewVirus=instance_create(608,272,oInjectorVirus)
          tNewVirus.type=1
        }
        else if virusTime=120 {with (356652) {instance_destroy()}}
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
