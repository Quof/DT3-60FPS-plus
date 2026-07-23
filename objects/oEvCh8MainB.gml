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
beamDownProg=0
readyText=0
readyWidth=0
if global.tempAction[0]=4 {playerSpotY=592}
else if global.tempAction[0]=5 {playerSpotY=640}
else if global.tempAction[0]=6 {playerSpotY=304}

if room=rMega4_SigmaA5
{
  if global.gameProgress=1890
  {
    fadeColor=c_black
    if global.bossTrack=0 {fadeAlpha=1}
  }
}
if room=rMega4_SigmaC3
{
  wallCheck=0
}
if room=rMega4_SigmaC5
{
  circleRad=0
  bubbleTime=0
  bubbleDelay=irandom(35)+5
  if global.gameProgress=1980
  {
    fadeColor=c_black
    if global.bossTrack=0 {fadeAlpha=1}
  }
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if room=rMega4_SigmaA1 and global.gameProgress=1850 and global.tempAction[0]=0 //----- [1] Getting into the fortress -----
{
  if sceneProgress=0
  {
    sceneDelay+=1
    if sceneDelay=1
    {
      global.gamePaused=true
      oPlayer1.sprite_index=sJerryIdle
      stopPlayer()
    }
    else if sceneDelay>=30 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=1 and bWaitForInput=false
    msgCreate(0,0,"Jerry","This isn't quite IN the fortress.",0,3,oMessageCutscene,1)
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Yeah... I know. As I said, I have no place inside that I can teleport you straight in. The fortress itself is pretty far off so I'll see what I can do to help you out. I don't see any bridge or platforms leading up to the place like in MMX1.",0,3,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Jerry","How would I get in then? Wall jumping is out of the question I'm sure.",0,3,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","I'll have something for you down this path. You'll know when you see it.",0,3,oMessageCutscene,1)
  else if sceneProgress=5
  {
    sceneDelay=0; sceneProgress=0
    global.gameProgress=1860
    global.gamePaused=false
  }
}
else if global.gameProgress=1860 and room=rMega4_SigmaA1 //----- [] Tutorial: Strike Chain / Update progress -----
{
  if sceneProgress=0
  {
    if oPlayer1.x>=1648
    {
      var tNewTutorial;
      tNewTutorial=instance_create(0,0,oTutorialPanel)
      tNewTutorial.tutorialTitle="Strike Chain"
      tNewTutorial.tutorialInfo="Press [Up] + [Action A] to fire the Strike Chain toward a grapple point. Press [Jump] to jump off. Hold [Down] and press [Jump] to drop down."
      tNewTutorial.scrAreaY=1; tNewTutorial.xChange=104
      sceneProgress+=1
    }
  }

  if oPlayer1.x>=2960 {global.gameProgress=1870}
}
else if global.gameProgress=1870 and room=rMega4_SigmaA2 //----- [Unskippable] Enemy Trap -----
{
  if global.gamePaused=false
  {
    if sceneProgress=0
    {
      if oPlayer1.x>=1132
      {
        var enemyCounter,enemyBarrier;
        enemyCounter=instance_create(0,0,oEnemyRemain)
        enemyCounter.enemyCount=4
        enemyBarrier=instance_create(896,160,oEnemyBarrier); enemyBarrier.image_yscale=4
        enemyBarrier=instance_create(1360,64,oEnemyBarrier); enemyBarrier.image_yscale=4
        enemyTrap[0]=instance_create(920,64,oZapTrap)
        enemyTrap[1]=instance_create(1344,64,oZapTrap)
        enemyTrap[2]=instance_create(920,176,oZapTrap)
        enemyTrap[3]=instance_create(1344,176,oZapTrap)
        for(i=0;i<4;i+=1)
        {
          enemyTrap[i].image_xscale=3.5
          enemyTrap[i].image_angle=270
        }
        sceneProgress+=1
      }
    }
    else if sceneProgress=1
    {
      sceneDelay+=1
      if sceneDelay=30
      {
        createEnemy(944,128,oSineFaller,2,0,1)
        createEnemy(1328,224,oSineFaller,2,0,1)
        sceneDelay=0; sceneProgress+=1
      }
    }
    else if sceneProgress=2
    {
      if oEnemyRemain.enemyCount<=2
      {
        createEnemy(944,224,oSineFaller,2,0,1)
        createEnemy(1328,128,oSineFaller,2,0,1)
        sceneProgress+=1
      }
    }
    else if sceneProgress=3
    {
      if oEnemyRemain.enemyCount<=0
      {
        for(i=0;i<4;i+=1)
        {
          with enemyTrap[i] {instance_destroy()}
        }
        with oEnemyRemain {instance_destroy()}
        with oEnemyBarrier {instance_destroy()}
        sceneProgress=0
        global.gameProgress=1880
      }
    }
  }
}
else if global.gameProgress=1880 and room=rMega4_SigmaA4 //----- [Unskippable] Enemy Trap -----
{
  if global.gamePaused=false
  {
    if sceneProgress=0
    {
      if oPlayer1.x>=3168
      {
        var enemyCounter,enemyBarrier;
        enemyCounter=instance_create(0,0,oEnemyRemain)
        enemyCounter.enemyCount=6
        enemyBarrier=instance_create(2880,96,oEnemyBarrier); enemyBarrier.image_yscale=8
        enemyBarrier=instance_create(3440,128,oEnemyBarrier); enemyBarrier.image_yscale=6
        sceneProgress+=1
      }
    }
    else if sceneProgress=1
    {
      sceneDelay+=1
      if sceneDelay=30
      {
        createEnemy(2960,128,oSineFaller,2,0,1)
        createEnemy(3376,128,oSineFaller,2,0,1)
        sceneDelay=0; sceneProgress+=1
      }
    }
    else if sceneProgress=2
    {
      if oEnemyRemain.enemyCount<=4
      {
        delaySpawn(3008,224,oMegaTortoise,2,1,1,0.15)
        createEnemy(3376,128,oSineFaller,2,0,1)
        sceneProgress+=1
      }
    }
    else if sceneProgress=3
    {
      if oEnemyRemain.enemyCount<=2
      {
        delaySpawn(3328,224,oMegaTortoise,2,1,1,0.33)
        createEnemy(2960,128,oSineFaller,2,0,1)
        sceneProgress+=1
      }
    }
    else if sceneProgress=4
    {
      if oEnemyRemain.enemyCount<=0
      {
        with oEnemyRemain {instance_destroy()}
        with oEnemyBarrier {instance_destroy()}
        sceneProgress=0
        global.gameProgress=1890
      }
    }
  }
}
else if global.gameProgress=1890 and room=rMega4_SigmaA5 //----- [Unskippable] Boss Fight: Bospider -----
{
  if global.bossTrack=0
  {
    if sceneProgress=0
    {
      sceneDelay+=1
      if sceneDelay=1
      {
        global.gamePaused=true
        oPlayer1.sprite_index=sJerryIdle
        stopPlayer()
        stopAllMusic()
      }
      else if sceneDelay>=30
      {
        fadeAlpha-=0.02
        if fadeAlpha<=0 {sceneDelay=0; sceneProgress+=1}
      }
    }
    else if sceneProgress=1
    {
      sceneDelay+=1
      if sceneDelay=10
      {
        tempMplay=findMusic(402)
        playMusic(tempMplay,0,0)
      }
      else if sceneDelay=70
      {
        boss=instance_create(264,-44,oBospider)
      }
      else if sceneDelay>=71
      {
        boss.y+=8
        if boss.y>=12 {sceneDelay=0; sceneProgress+=1}
      }
    }
    else if sceneProgress=2
    {
      sceneDelay+=1
      if sceneDelay>=20 and sceneDelay<=45 {boss.legFrm+=0.33}
      if sceneDelay>=70 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=3
    {
      sceneDelay+=1
      if sceneDelay=30
      {
        showBossHP=instance_create(0,0,oBossLifeDisplay)
        showBossHP.bossID=oBospider; showBossHP.type=1; showBossHP.lifeFill=0
      }
      else if sceneDelay>=31 and sceneDelay<=300
      {
        if sceneDelay mod 2=0
        {
          playSound(global.snd_MMLifeBlip,0,1,1)
          showBossHP.healthTrack+=2
        }
        if showBossHP.healthTrack=50 {sceneDelay=500}
      }
      else if sceneDelay>=505
      {
        boss.y-=8
        if boss.y<=-44 {sceneDelay=0; sceneProgress+=1}
      }
    }
    else if sceneProgress=4
    {
      with showBossHP {instance_destroy()}
      global.gamePaused=false
      var tBossTitle,tempMplay;
      tBossTitle=instance_create(0,0,oBossNameDisplay)
      tBossTitle.bossName="Bospider"
      tBossTitle.bossTitle="Mechanical Arachnid"
      tempMplay=findMusic(810)
      playMusic(tempMplay,0,0)
      boss.activateBoss=1
      global.currentBoss="Bospider"
      global.bossTrack=1
      storeStatus(0)
      sceneDelay=0; sceneProgress=0
    }
  }
  else if global.bossTrack=1
  {
    if !instance_exists(oBospider) and sceneProgress=0 //End Boss
    {
      global.gamePaused=true
      awardBossAP(2400)
      stopAllMusic()
      global.bossTrack=2
    }
  }
  else if global.bossTrack=2
  {
    if sceneProgress=0
    {
      if fadeAlpha<1 {fadeAlpha+=0.05}
      else if fadeAlpha>=1 {sceneProgress+=1}
    }
    else if sceneProgress=1
    {
      sceneDelay+=1
      if sceneDelay=1
      {
        endBoss()
        scenePChk(240,256,0,0.1,1)
      }
      if sceneDelay>=60 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=2
    {
      if fadeAlpha>0 {fadeAlpha-=0.05}
      else if fadeAlpha<=0 {sceneProgress+=1}
    }
    else if sceneProgress=3
    {
      sceneDelay+=1
      if sceneDelay>=25 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=4 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","All right, I got you an access point in the room ahead. I'll beam you out and let you decide what you want to do next.",0,3,oMessageCutscene,1)
    else if sceneProgress=5 and bWaitForInput=false
      msgCreate(0,0,"Jerry","Awesome, this place was ridiculous.",0,3,oMessageCutscene,1)
    else if sceneProgress=6
    {
      sceneDelay+=1
      if sceneDelay=30
      {
        var tempMplay;
        tempMplay=findMusic(403)
        playMusic(tempMplay,0,1)
      }
      else if sceneDelay=215
      {
        playSound(global.snd_MMVictoryShine,0,1,1)
        oPlayer1.sprite_index=sJerryCasted; oPlayer1.image_index=0; oPlayer1.image_speed=0
        tEffect=instance_create(oPlayer1.x+18,oPlayer1.y-33,oEffect)
        tEffect.sprite_index=sMMX_Win; tEffect.image_speed=0.5
        tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
      }
      else if sceneDelay=240
      {
        playSound(global.snd_MMBeamUp,0,1,1)
        oPlayer1.sprite_index=sPlayerDiscombobulate; oPlayer1.image_index=1
      }
      else if sceneDelay=243 {oPlayer1.image_index=0}
      else if sceneDelay>=244
      {
        oPlayer1.y-=16
        if oPlayer1.y<=-16 {sceneDelay=0; sceneProgress+=1}
      }
    }
    else if sceneProgress=7
    {
      sceneDelay+=1
      if sceneDelay>=30 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=8
    {
      global.gamePaused=false
      global.currentBoss=""
      global.bossTrack=0
      global.gameProgress=1900
      room_goto(rMega4_Map)
    }
  }
}
else if global.gameProgress=1900 and room=rMega4_SigmaB2 //----- [Unskippable] Enemy Trap -----
{
  if global.gamePaused=false
  {
    if sceneProgress=0
    {
      if oPlayer1.x>=1248
      {
        var enemyCounter,enemyBarrier;
        enemyCounter=instance_create(0,0,oEnemyRemain)
        enemyCounter.enemyCount=4
        enemyBarrier=instance_create(1072,64,oEnemyBarrier); enemyBarrier.image_yscale=12
        enemyBarrier=instance_create(1408,64,oEnemyBarrier); enemyBarrier.image_yscale=12
        sceneProgress+=1
      }
    }
    else if sceneProgress=1
    {
      sceneDelay+=1
      if sceneDelay=30
      {
        delaySpawn(1120,288,oHammaHammaMain,2,1,1,0.33)
        createEnemy(1344,160,oSineFaller,2,0,1)
        sceneDelay=0; sceneProgress+=1
      }
    }
    else if sceneProgress=2
    {
      if oEnemyRemain.enemyCount<=2
      {
        createEnemy(1152,160,oSineFaller,2,0,1)
        delaySpawn(1376,288,oHammaHammaMain,2,1,1,0.33)
        sceneProgress+=1
      }
    }
    else if sceneProgress=3
    {
      if oEnemyRemain.enemyCount<=0
      {
        with oEnemyRemain {instance_destroy()}
        with oEnemyBarrier {instance_destroy()}
        sceneProgress=0
        global.gameProgress=1910
      }
    }
  }
}
else if room=rMega4_SigmaB3 and global.gameProgress=1910 //----- [Unskippable] Boss Fight: Bit -----
{
  if global.bossTrack=0
  {
    if sceneProgress=0 and oPlayer1.x>=128
    {
      sceneDelay+=1
      if sceneDelay=1 {global.gamePaused=true}
      oPlayer1.y+=4
      if oPlayer1.y>=288
      {
        scenePChk(128,288,0,0.1,1)
        stopPlayer()
        sceneDelay=0; sceneProgress+=1
      }
    }
    else if sceneProgress=1
    {
      sceneDelay+=1
      if sceneDelay=25
      {
        stopAllMusic()
        npcBitA=instance_create(364,288,oMisc)
        npcBitA.sprite_index=sBit_ArmUp; npcBitA.image_speed=0; npcBitA.type=1; npcBitA.image_alpha=0; npcBitA.image_xscale=-1
        npcBitB=instance_create(404,288,oMisc)
        npcBitB.sprite_index=sBit_ArmUp; npcBitB.image_speed=0; npcBitB.type=1; npcBitB.image_alpha=0; npcBitB.image_xscale=-1
      }
      else if sceneDelay>=26 and sceneDelay<=45
      {
        npcBitA.x+=1; npcBitA.image_alpha+=0.05
        npcBitB.x-=1; npcBitB.image_alpha+=0.05
      }
      else if sceneDelay>=70
      {
        boss=instance_create(384,288,oMMBit)
        boss.image_xscale=-1
        with npcBitA {instance_destroy()}
        with npcBitB {instance_destroy()}
        sceneDelay=0; sceneProgress+=1
      }
    }
    else if sceneProgress=2
    {
      sceneDelay+=1
      if sceneDelay>=30 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=3 and bWaitForInput=false
      msgCreate(0,0,"Jerry","Done breaking bridges?",0,3,oMessageCutscene,1)
    else if sceneProgress=4 and bWaitForInput=false
      msgCreate(0,0,"Bit","Sigma is nearly ready. It is my job to keep you from him until the time is right.",8,3,oMessageCutscene,1)
    else if sceneProgress=5 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","What is he trying to do? Did he have a hand in changing the Virus?",0,3,oMessageCutscene,1)
    else if sceneProgress=6 and bWaitForInput=false
      msgCreate(0,0,"Bit","Ah, you. He informed Sigma about you. And Sigma has prepared just the thing for you.",8,3,oMessageCutscene,1)
    else if sceneProgress=7 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","What?",0,3,oMessageCutscene,1)
    else if sceneProgress=8
    {
      sceneDelay+=1
      if sceneDelay=1 {flashAmt=0}
      else if sceneDelay=15 {boss.image_index=1}
      else if sceneDelay=19 {boss.image_index=2}
      else if sceneDelay=23 {boss.image_index=3}
      else if sceneDelay=35
      {
        var tFlash;
        tFlash=instance_create(0,0,oScreenFlash)
        tFlash.fadeSpeed=0.05; tFlash.image_alpha=0.3
        tFlash.image_blend=make_color_rgb(random(255),random(255),random(255))
        flashAmt+=1
        if flashAmt<=7 {sceneDelay=30}
        else {sceneDelay=50}
      }
      else if sceneDelay=65 {boss.image_index=2}
      else if sceneDelay=69 {boss.image_index=1}
      else if sceneDelay=73 {boss.image_index=0}
      else if sceneDelay>=100 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=9 and bWaitForInput=false
      msgCreate(0,0,"Jerry","Seizure lights are annoying, we get it.",0,3,oMessageCutscene,1)
    else if sceneProgress=10 and bWaitForInput=false
      msgCreate(0,0,"Bit","Merely a visual side effect of 'his' gift.",8,3,oMessageCutscene,1)
    else if sceneProgress=11 and bWaitForInput=false
      msgCreate(0,0,"Jerry","You'll need to be more specific than that.",0,3,oMessageCutscene,1)
    else if sceneProgress=12 and bWaitForInput=false
      msgCreate(0,0,"Bit","Your friend, Jeremy, is a nuisance. We needed to get rid of him in this place.",8,3,oMessageCutscene,1)
    else if sceneProgress=13 and bWaitForInput=false
      msgCreate(0,0,"Jerry","You can't really do that. Jeremy can get through anything you guys do to block him.",0,3,oMessageCutscene,1)
    else if sceneProgress=14 and bWaitForInput=false
      msgCreate(0,0,"Bit","You'll see for yourself. For now, I'll slow you down.",8,3,oMessageCutscene,1)
    else if sceneProgress=15 and bWaitForInput=false
      msgCreate(0,0,"Jerry","Unless you've been modified, you're really easy... no offense.",0,3,oMessageCutscene,1)
    else if sceneProgress=16
    {
      sceneDelay+=1
      if sceneDelay=30
      {
        showBossHP=instance_create(0,0,oBossLifeDisplay)
        showBossHP.bossID=oMMBit; showBossHP.type=1; showBossHP.lifeFill=0
      }
      else if sceneDelay>=31 and sceneDelay<=300
      {
        if sceneDelay mod 2=0
        {
          playSound(global.snd_MMLifeBlip,0,1,1)
          showBossHP.healthTrack+=2
        }
        if showBossHP.healthTrack=50 {sceneDelay=500}
      }
      else if sceneDelay>=505 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=17
    {
      with showBossHP {instance_destroy()}
      global.gamePaused=false
      var tBossTitle,tempMplay,bBarrier;
      bBarrier=instance_create(48,224,oBossBarrier)
      tBossTitle=instance_create(0,0,oBossNameDisplay)
      tBossTitle.bossName="Bit"
      tBossTitle.bossTitle="Agile X Hunter"
      tempMplay=findMusic(810)
      playMusic(tempMplay,0,0)
      boss.activateBoss=1
      global.currentBoss="Bit"
      global.bossTrack=1
      storeStatus(0)
      global.charScan[0]=0
      sceneDelay=0
      sceneProgress=0
    }
  }
  else if global.bossTrack=1
  {
    if oMMBit.life<=500 and sceneProgress=0 //End Boss
    {
      tile_layer_hide(999999)
      with (231410) {instance_destroy()}
      var newExit;
      newExit=instance_create(464,256,oExit)
      newExit.bShowArrow=true; newExit.exitType=1
      newExit.newMapX=48; newExit.newMapY=3008; newExit.toRoom=rMega4_SigmaB4

      var tFlash,tempMplay;
      tFlash=instance_create(0,0,oScreenFlash)
      tFlash.fadeSpeed=0.2
      tempMplay=findMusic(411)
      playMusic(tempMplay,0,0)
      with oBossBarrier {instance_destroy()}
      with oMMBit {instance_destroy()}
      with oEProjectileBase {instance_destroy()}

      msgCreate(0,0,"Bit","We shall settle this at a later time.",8,2,oMessagePerson,0)
      newMessage.fadingTime=80
      global.bossTrack=0
      global.currentBoss=""
      global.gameProgress=1920
    }
  }
}
else if room=rMega4_SigmaB4 and global.gameProgress=1920 //----- [2] Is Jeremy really gone? -----
{
  if sceneProgress=0
  {
    sceneDelay+=1
    if sceneDelay=1
    {
      global.gamePaused=true
      oPlayer1.sprite_index=sJerryIdle
      stopPlayer()
    }
    else if sceneDelay>=30 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=1 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Is Jeremy really blocked out?",0,3,oMessageCutscene,1)
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"Chao","Yes, I can't send or receive anything from him. The entire Gate has this weird block over it. What's even weirder is the whole method is Jeremy's style. As if... he designed it.",0,3,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Jeremy wouldn't be messing around at a time like this. He's been far more eager than all of us to confront Sigma about the Virus. Do you know where this interference is coming from?",0,3,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Chao","It's from within this Gate, but that's all I know. It could be from Sigma or the Virus, I can't tell which.",0,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Then it couldn't be who I'm thinking of...#Claire, can you reach him at all? You're not blocked either, are you?",0,3,oMessageCutscene,1)
  else if sceneProgress=6 and bWaitForInput=false
    msgCreate(0,0,"Claire","No, I can still see you flailing about.",0,3,oMessageCutscene,1)
  else if sceneProgress=7 and bWaitForInput=false
    msgCreate(0,0,"Jerry","There was hope at least.",0,3,oMessageCutscene,1)
  else if sceneProgress=8
  {
    sceneDelay=0; sceneProgress=0
    global.gameProgress=1930
    global.gamePaused=false
  }
}
else if room=rMega4_SigmaB5 and global.gameProgress=1930 //----- [Unskippable] Boss Fight: Byte -----
{
  if global.bossTrack=0
  {
    if sceneProgress=0 and oPlayer1.x>=128
    {
      sceneDelay+=1
      if sceneDelay=1 {global.gamePaused=true}
      oPlayer1.y+=4
      if oPlayer1.y>=288
      {
        scenePChk(128,288,0,0.1,1)
        stopPlayer()
        sceneDelay=0; sceneProgress+=1
      }
    }
    else if sceneProgress=1
    {
      sceneDelay+=1
      if sceneDelay=25
      {
        stopAllMusic()
        npcByteA=instance_create(364,288,oMisc)
        npcByteA.sprite_index=sByte_Idle; npcByteA.image_speed=0; npcByteA.type=1; npcByteA.image_alpha=0; npcByteA.image_xscale=-1
        npcByteB=instance_create(404,288,oMisc)
        npcByteB.sprite_index=sByte_Idle; npcByteB.image_speed=0; npcByteB.type=1; npcByteB.image_alpha=0; npcByteB.image_xscale=-1
      }
      else if sceneDelay>=26 and sceneDelay<=45
      {
        npcByteA.x+=1; npcByteA.image_alpha+=0.05
        npcByteB.x-=1; npcByteB.image_alpha+=0.05
      }
      else if sceneDelay>=70
      {
        boss=instance_create(384,288,oMMByte)
        boss.image_xscale=-1
        with npcByteA {instance_destroy()}
        with npcByteB {instance_destroy()}
        sceneDelay=0; sceneProgress+=1
      }
    }
    else if sceneProgress=2
    {
      sceneDelay+=1
      if sceneDelay>=30 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=3 and bWaitForInput=false
      msgCreate(0,0,"Jerry","Oh man, you were even easier.",0,3,oMessageCutscene,1)
    else if sceneProgress=4 and bWaitForInput=false
      msgCreate(0,0,"Byte","I'm here to do what Bit could not.",8,3,oMessageCutscene,1)
    else if sceneProgress=5 and bWaitForInput=false
      msgCreate(0,0,"Jerry","BUT YOU'RE EVEN EASIER THAN HE WAS!",0,3,oMessageCutscene,1)
    else if sceneProgress=6
    {
      sceneDelay+=1
      if sceneDelay=30
      {
        showBossHP=instance_create(0,0,oBossLifeDisplay)
        showBossHP.bossID=oMMByte; showBossHP.type=1; showBossHP.lifeFill=0
      }
      else if sceneDelay>=31 and sceneDelay<=300
      {
        if sceneDelay mod 2=0
        {
          playSound(global.snd_MMLifeBlip,0,1,1)
          showBossHP.healthTrack+=2
        }
        if showBossHP.healthTrack=50 {sceneDelay=500}
      }
      else if sceneDelay>=505 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=7
    {
      with showBossHP {instance_destroy()}
      global.gamePaused=false
      var tBossTitle,tempMplay,bBarrier;
      bBarrier=instance_create(48,224,oBossBarrier)
      tBossTitle=instance_create(0,0,oBossNameDisplay)
      tBossTitle.bossName="Byte"
      tBossTitle.bossTitle="Brute X Hunter"
      tempMplay=findMusic(810)
      playMusic(tempMplay,0,0)
      boss.activateBoss=1
      global.currentBoss="Byte"
      global.bossTrack=1
      storeStatus(0)
      global.charScan[0]=0
      sceneDelay=0; sceneProgress=0
    }
  }
  else if global.bossTrack=1
  {
    if oMMByte.life<=500 and sceneProgress=0 //End Boss
    {
      tile_layer_hide(999999)
      with (231410) {instance_destroy()}
      var newExit;
      newExit=instance_create(464,256,oExit)
      newExit.bShowArrow=true; newExit.exitType=1
      newExit.newMapX=48; newExit.newMapY=448; newExit.toRoom=rMega4_SigmaB6

      var tFlash,tempMplay;
      tFlash=instance_create(0,0,oScreenFlash)
      tFlash.fadeSpeed=0.2
      tempMplay=findMusic(411)
      playMusic(tempMplay,0,0)
      with oBossBarrier {instance_destroy()}
      with oMMByte {instance_destroy()}
      with oEProjectileBase {instance_destroy()}

      msgCreate(0,0,"Byte","I WILL crush you!",8,2,oMessagePerson,0)
      newMessage.fadingTime=80
      global.bossTrack=0
      global.currentBoss=""
      global.gameProgress=1940
    }
  }
}
else if global.gameProgress=1940 and room=rMega4_SigmaB8 //----- [Unskippable] Boss Fight: Bit & Byte -----
{
  if global.bossTrack=0
  {
    if sceneProgress=0 and oPlayer1.x>=240
    {
      sceneDelay+=1
      if sceneDelay=1 {global.gamePaused=true}
      oPlayer1.y+=4
      if oPlayer1.y>=288
      {
        scenePChk(240,288,0,0.1,1)
        stopPlayer()
        sceneDelay=0; sceneProgress+=1
      }
    }
    else if sceneProgress=1
    {
      sceneDelay+=1
      if sceneDelay=1
      {
        tempMplay=findMusic(402)
        playMusic(tempMplay,0,0)
      }
      else if sceneDelay=25
      {
        npcBitA=instance_create(360,288,oMisc)
        npcBitA.sprite_index=sBit_ArmUp; npcBitA.image_speed=0; npcBitA.type=1; npcBitA.image_alpha=0; npcBitA.image_xscale=-1
        npcBitB=instance_create(400,288,oMisc)
        npcBitB.sprite_index=sBit_ArmUp; npcBitB.image_speed=0; npcBitB.type=1; npcBitB.image_alpha=0; npcBitB.image_xscale=-1

        npcByteA=instance_create(80,288,oMisc)
        npcByteA.sprite_index=sByte_Idle; npcByteA.image_speed=0; npcByteA.type=1; npcByteA.image_alpha=0
        npcByteB=instance_create(120,288,oMisc)
        npcByteB.sprite_index=sByte_Idle; npcByteB.image_speed=0; npcByteB.type=1; npcByteB.image_alpha=0
      }
      else if sceneDelay>=26 and sceneDelay<=45
      {
        npcBitA.x+=1; npcBitA.image_alpha+=0.05
        npcBitB.x-=1; npcBitB.image_alpha+=0.05

        npcByteA.x+=1; npcByteA.image_alpha+=0.05
        npcByteB.x-=1; npcByteB.image_alpha+=0.05
      }
      else if sceneDelay>=70
      {
        bossA=instance_create(380,288,oMMBit)
        bossA.image_xscale=-1
        bossB=instance_create(100,288,oMMByte)
        with npcBitA {instance_destroy()}
        with npcBitB {instance_destroy()}

        with npcByteA {instance_destroy()}
        with npcByteB {instance_destroy()}
        sceneDelay=0; sceneProgress+=1
      }
    }
    else if sceneProgress=2
    {
      sceneDelay+=1
      if sceneDelay>=30 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=3 and bWaitForInput=false
      msgCreate(0,0,"Chao","They're both there this time.",0,3,oMessageCutscene,1)
    else if sceneProgress=4 and bWaitForInput=false
      msgCreate(0,0,"Jerry","Figures.",0,3,oMessageCutscene,1)
    else if sceneProgress=5 and bWaitForInput=false
      msgCreate(0,0,"Bit","You were right. Neither of us can defeat you single handedly, but together...",8,3,oMessageCutscene,1)
    else if sceneProgress=6 and bWaitForInput=false
    {
      oPlayer1.sprite_index=sJerryPose1
      msgCreate(0,0,"Jerry","Bring it! I've taken on the Shrouds! I think I can handle the two of you!",0,3,oMessageCutscene,1)
    }
    else if sceneProgress=7 and bWaitForInput=false
      msgCreate(0,0,"Bit","We shall see.",8,3,oMessageCutscene,1)
    else if sceneProgress=8
    {
      sceneDelay+=1
      if sceneDelay=30
      {
        showBossHPA=instance_create(0,0,oBossLifeDisplay)
        showBossHPA.bossID=oMMBit; showBossHPA.type=1; showBossHPA.lifeFill=0
        showBossHPB=instance_create(0,0,oBossLifeDisplay)
        showBossHPB.bossID=oMMBit; showBossHPB.type=1; showBossHPB.lifeFill=0; showBossHPB.newOffsetX=433
      }
      else if sceneDelay>=31 and sceneDelay<=300
      {
        if sceneDelay mod 2=0
        {
          playSound(global.snd_MMLifeBlip,0,1,1)
          showBossHPA.healthTrack+=2
          showBossHPB.healthTrack+=2
        }
        if showBossHPA.healthTrack=50 {sceneDelay=500}
      }
      else if sceneDelay>=505 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=9
    {
      with showBossHPA {instance_destroy()}
      with showBossHPB {instance_destroy()}
      global.gamePaused=false
      var tBossTitle,tempMplay,bBarrier;
      tBossTitle=instance_create(0,0,oBossNameDisplay)
      tBossTitle.bossName="Bit & Byte"
      tBossTitle.bossTitle="X Hunter Duo"
      bBarrier=instance_create(48,224,oBossBarrier)
      tempMplay=findMusic(810)
      playMusic(tempMplay,0,0)
      bossA.activateBoss=1
      bossB.activateBoss=1
      global.currentBoss="Bit & Byte"
      global.bossTrack=1
      storeStatus(0)
      sceneDelay=0; sceneProgress=0
    }
  }
  else if global.bossTrack=1
  {
    if !instance_exists(oMMBit) and !instance_exists(oMMByte) and sceneProgress=0 //End Boss
    {
      global.gamePaused=true
      awardBossAP(2400)
      stopAllMusic()
      global.bossTrack=2
    }
  }
  else if global.bossTrack=2
  {
    if sceneProgress=0
    {
      if fadeAlpha<1 {fadeAlpha+=0.05}
      else if fadeAlpha>=1 {sceneProgress+=1}
    }
    else if sceneProgress=1
    {
      sceneDelay+=1
      if sceneDelay=1
      {
        endBoss()
        scenePChk(240,288,0,0.1,1)
      }
      if sceneDelay>=60 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=2
    {
      if fadeAlpha>0 {fadeAlpha-=0.05}
      else if fadeAlpha<=0 {sceneProgress+=1}
    }
    else if sceneProgress=3
    {
      sceneDelay+=1
      if sceneDelay>=25 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=4 and bWaitForInput=false
      msgCreate(0,0,"Jerry","Is Jeremy still blocked?",0,3,oMessageCutscene,1)
    else if sceneProgress=5 and bWaitForInput=false
      msgCreate(0,0,"Chao","Yes... I wish I knew how to get him back.",0,3,oMessageCutscene,1)
    else if sceneProgress=6 and bWaitForInput=false
      msgCreate(0,0,"Jerry","We'll just have to continue on without his help. We can't stop when we're so close to Sigma. Can you set those destination points that Jeremy had been setting?",0,3,oMessageCutscene,1)
    else if sceneProgress=7 and bWaitForInput=false
      msgCreate(0,0,"Chao","I've been assisting him with that. I'll send you back to the map and set up a drop point for the top floor.",0,3,oMessageCutscene,1)
    else if sceneProgress=8
    {
      sceneDelay+=1
      if sceneDelay=30
      {
        var tempMplay;
        tempMplay=findMusic(403)
        playMusic(tempMplay,0,1)
      }
      else if sceneDelay=215
      {
        playSound(global.snd_MMVictoryShine,0,1,1)
        oPlayer1.sprite_index=sJerryCasted; oPlayer1.image_index=0; oPlayer1.image_speed=0
        tEffect=instance_create(oPlayer1.x+18,oPlayer1.y-33,oEffect)
        tEffect.sprite_index=sMMX_Win; tEffect.image_speed=0.5
        tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
      }
      else if sceneDelay=240
      {
        playSound(global.snd_MMBeamUp,0,1,1)
        oPlayer1.sprite_index=sPlayerDiscombobulate; oPlayer1.image_index=1
      }
      else if sceneDelay=243 {oPlayer1.image_index=0}
      else if sceneDelay>=244
      {
        oPlayer1.y-=16
        if oPlayer1.y<=-16 {sceneDelay=0; sceneProgress+=1}
      }
    }
    else if sceneProgress=9
    {
      sceneDelay+=1
      if sceneDelay>=30 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=10
    {
      global.gamePaused=false
      global.currentBoss=""
      global.bossTrack=0
      global.gameProgress=1950
      room_goto(rMega4_Map)
    }
  }
}
if room=rMega4_SigmaC1 and global.gameProgress=1950 and global.tempAction[0]=0 //----- [3] Sigma is here -----
{
  if sceneProgress=0
  {
    sceneDelay+=1
    if sceneDelay=1
    {
      global.gamePaused=true
      oPlayer1.sprite_index=sJerryIdle
      stopPlayer()
    }
    else if sceneDelay>=30 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=1 and bWaitForInput=false
    msgCreate(0,0,"Claire","Any idea what form Sigma would take?",0,3,oMessageCutscene,1)
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"Jerry","You know as much as I do. I'm really nervous without Jeremy backing us up here.",0,3,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Chao","I still can't reach him. I'm sure he's trying to send messages.",0,3,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Jerry","I wonder if he can still see into this place.",0,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Chao","I think he can. When he was getting blocked in Gate 2, he was still able to see everything you could.",0,3,oMessageCutscene,1)
  else if sceneProgress=6 and bWaitForInput=false
    msgCreate(0,0,"Jerry","I'll hope for that at least.",0,3,oMessageCutscene,1)
  else if sceneProgress=7 and bWaitForInput=false
    msgCreate(0,0,"Chao","And I'll do the best that I can to support you here.",0,3,oMessageCutscene,1)
  else if sceneProgress=8
  {
    sceneDelay=0; sceneProgress=0
    global.gameProgress=1960
    global.gamePaused=false
  }
}
else if global.gameProgress=1960 and room=rMega4_SigmaC3 //----- [Unskippable] Enemy Trap -----
{
  if global.gamePaused=false
  {
    if sceneProgress=0
    {
      if oPlayer1.y<=832
      {
        var enemyCounter,enemyBarrier;
        enemyCounter=instance_create(0,0,oEnemyRemain)
        enemyCounter.enemyCount=3
        enemyBarrier=instance_create(48,912,oEnemyBarrier); enemyBarrier.image_yscale=5; enemyBarrier.image_angle=90
        enemyBarrier=instance_create(144,512,oEnemyBarrier); enemyBarrier.image_yscale=12; enemyBarrier.image_angle=90
        sceneProgress+=1
      }
    }
    else if sceneProgress=1
    {
      sceneDelay+=1
      if sceneDelay=5
      {
        delaySpawn(240,896,oMegaTortoise,2,1,1,0.33)
        createEnemy(192,704,oSineFaller,2,0,1)
        createEnemy(288,704,oSineFaller,2,0,1)
        sceneDelay=0; sceneProgress+=1
      }
    }
    else if sceneProgress=2
    {
      if oEnemyRemain.enemyCount<=0
      {
        with oEnemyRemain {instance_destroy()}
        with oEnemyBarrier {instance_destroy()}
        sceneProgress+=1
      }
    }
    else if sceneProgress=3
    {
      if oPlayer1.y<=496
      {
        sceneProgress=0
        global.gameProgress=1970
      }
    }
  }
}
else if global.gameProgress=1970 and room=rMega4_SigmaC4 //----- [Unskippable] Enemy Trap -----
{
  if global.gamePaused=false
  {
    if sceneProgress=0
    {
      if oPlayer1.x>=512
      {
        var enemyCounter,enemyBarrier;
        enemyCounter=instance_create(0,0,oEnemyRemain)
        enemyCounter.enemyCount=6
        enemyBarrier=instance_create(208,-64,oEnemyBarrier); enemyBarrier.image_yscale=30
        enemyBarrier=instance_create(800,-64,oEnemyBarrier); enemyBarrier.image_yscale=30

        enemyTrap[0]=instance_create(224,0,oZapTrap)
        enemyTrap[1]=instance_create(792,0,oZapTrap)
        enemyTrap[2]=instance_create(224,176,oZapTrap)
        enemyTrap[3]=instance_create(792,176,oZapTrap)
        for(i=0;i<4;i+=1)
        {
          enemyTrap[i].image_xscale=5.5
          enemyTrap[i].image_angle=270
        }
        sceneProgress+=1
      }
    }
    else if sceneProgress=1
    {
      sceneDelay+=1
      if sceneDelay=5
      {
        var tNewEnemy;
        tNewEnemy=instance_create(288,176,oBarrierAttacker)
        tNewEnemy.bActive=1; tNewEnemy.questType=2
        tNewEnemy.xMove=3; tNewEnemy.moveMax=42
        tNewEnemy=instance_create(736,176,oBarrierAttacker)
        tNewEnemy.bActive=1; tNewEnemy.questType=2
        tNewEnemy.xMove=-3; tNewEnemy.moveMax=42
        tNewEnemy=instance_create(304,144,oBarrierAttacker)
        tNewEnemy.bActive=1; tNewEnemy.questType=2
        tNewEnemy.xMove=6; tNewEnemy.moveMax=69
        createEnemy(512,64,oSineFaller,2,0,1)
        sceneDelay=0
        sceneProgress+=1
      }
    }
    else if sceneProgress=2
    {
      if oEnemyRemain.enemyCount<=4
      {
        createEnemy(336,96,oSineFaller,2,0,1)
        createEnemy(688,96,oSineFaller,2,0,1)
        sceneProgress+=1
      }
    }
    else if sceneProgress=3
    {
      if oEnemyRemain.enemyCount<=0
      {
        with oEnemyRemain {instance_destroy()}
        with oEnemyBarrier {instance_destroy()}
        for(i=0;i<4;i+=1)
        {
          with enemyTrap[i] {instance_destroy()}
        }
        global.gameProgress=1975
      }
    }
  }
}
else if global.gameProgress=1980 and room=rMega4_SigmaC5 //----- [Unskippable] Boss Fight: Sigma -----
{
  if global.bossTrack=0
  {
    if sceneProgress=0
    {
      sceneDelay+=1
      if sceneDelay=1
      {
        global.gamePaused=true
        oPlayer1.sprite_index=sJerryIdle
        stopPlayer()
        boss=instance_create(352,288,oSigmaA)
      }
      else if sceneDelay>=35
      {
        fadeAlpha-=0.01
        if fadeAlpha<=0 {sceneDelay=0; sceneProgress+=1}
      }
    }
    else if sceneProgress=1
    {
      sceneDelay+=1
      if sceneDelay>=30 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=2 and bWaitForInput=false
      msgCreate(0,0,"Jerry","What the... Sigma wasn't given a complete body...",0,3,oMessageCutscene,1)
    else if sceneProgress=3 and bWaitForInput=false
      msgCreate(0,0,"Sigma","Yes, he who resides in the dark void was unable to provide me with a proper body.",8,3,oMessageCutscene,1)
    else if sceneProgress=4 and bWaitForInput=false
      msgCreate(0,0,"Jerry","Dark void?",0,3,oMessageCutscene,1)
    else if sceneProgress=5 and bWaitForInput=false
      msgCreate(0,0,"Sigma","A place that can no longer withstand his might. When he is free, this world will be his, and what follows will destroy it.",8,3,oMessageCutscene,1)
    else if sceneProgress=6 and bWaitForInput=false
      msgCreate(0,0,"Jerry","What are you even talking about? What's going to destroy everything? The Virus is already free and eating away at the system.",0,3,oMessageCutscene,1)
    else if sceneProgress=7 and bWaitForInput=false
      msgCreate(0,0,"Chao","He means the Vault. Whatever is in there set Sigma free, but is still stuck inside.",0,3,oMessageCutscene,1)
    else if sceneProgress=8 and bWaitForInput=false
      msgCreate(0,0,"Sigma","Ah, Jeremy's sister is still not blocked. What an interesting development this is.",8,3,oMessageCutscene,1)
    else if sceneProgress=9 and bWaitForInput=false
      msgCreate(0,0,"Jerry","The wha... why are you being so cryptic? What the hell did you do to Jeremy?!",0,3,oMessageCutscene,1)
    else if sceneProgress=10 and bWaitForInput=false
      msgCreate(0,0,"Sigma","Your friend disrupts our plans. It was only right that we shut him out. The one in the void knows him well.",8,3,oMessageCutscene,1)
    else if sceneProgress=11 and bWaitForInput=false
      msgCreate(0,0,"Jerry","What do you mean by that?... There's no way.",0,3,oMessageCutscene,1)
    else if sceneProgress=12 and bWaitForInput=false
      msgCreate(0,0,"Sigma","Have you not seen the signs of his escape? I must have underestimated you.",8,3,oMessageCutscene,1)
    else if sceneProgress=13 and bWaitForInput=false
      msgCreate(0,0,"Jerry","That's impossible... Jeremy deleted him.",0,3,oMessageCutscene,1)
    else if sceneProgress=14 and bWaitForInput=false
      msgCreate(0,0,"Sigma","Did he? Perhaps your friend has not spoken the truth.",8,3,oMessageCutscene,1)
    else if sceneProgress=15 and bWaitForInput=false
    {
      msgCreate(0,0,"Jerry","You're lying! That's all bull!",0,3,oMessageCutscene,1)
      oPlayer1.sprite_index=sJerryBusterStand
    }
    else if sceneProgress=16 and bWaitForInput=false
      msgCreate(0,0,"Sigma","I doubt you truly believe that. Not that any of that matters. The preparations are complete and he will break out of that place soon. Your friend is blocked and I have cut off your escape.",8,3,oMessageCutscene,1)
    else if sceneProgress=17 and bWaitForInput=false
      msgCreate(0,0,"Jerry","The hell?",0,3,oMessageCutscene,1)
    else if sceneProgress=18 and bWaitForInput=false
      msgCreate(0,0,"Sigma","While you're stuck in here with me, he is inching ever closer to his escape from the voided world.",8,3,oMessageCutscene,1)
    else if sceneProgress=19 and bWaitForInput=false
      msgCreate(0,0,"Jerry","Then I'll blast you out of my way!",0,3,oMessageCutscene,1)
    else if sceneProgress=20 and bWaitForInput=false
      msgCreate(0,0,"Sigma","That's what I want to hear. I may not have a complete body, but he has still provided me with the means to defeat you.",8,3,oMessageCutscene,1)
    else if sceneProgress=21 and bWaitForInput=false
    {
      msgCreate(0,0,"Jerry","Bring it! I beat every incarnation you had.",0,3,oMessageCutscene,1)
      oPlayer1.sprite_index=sJerryPose1
    }
    else if sceneProgress=22
    {
      sceneDelay+=1
      if sceneDelay=30
      {
        showBossHP=instance_create(0,0,oBossLifeDisplay)
        showBossHP.bossID=oSigmaA; showBossHP.type=1; showBossHP.lifeFill=0
      }
      else if sceneDelay>=31 and sceneDelay<=300
      {
        if sceneDelay mod 2=0
        {
          playSound(global.snd_MMLifeBlip,0,1,1)
          showBossHP.healthTrack+=2
        }
        if showBossHP.healthTrack=50 {sceneDelay=500}
      }
      else if sceneDelay>=505 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=23
    {
      with showBossHP {instance_destroy()}
      global.gamePaused=false
      var tBossTitle;
      tBossTitle=instance_create(0,0,oBossNameDisplay)
      tBossTitle.bossName="Sigma"
      tBossTitle.bossTitle="Maverick Leader"
      boss.activateBoss=1
      global.currentBoss="Sigma"
      global.bossTrack=1
      storeStatus(0)
      sceneDelay=0; sceneProgress=0
    }
  }
  else if global.bossTrack=1
  {
    if !instance_exists(oSigmaA) and sceneProgress=0 //End Boss
    {
      global.gamePaused=true
      stopAllMusic()
      global.bossTrack=2
    }
  }
  else if global.bossTrack=2
  {
    if sceneProgress=0
    {
      sceneDelay+=1
      if sceneDelay=1
      {
        endBoss()
        scenePChk(128,288,0,0.1,1)
        boss=instance_create(358,208,oSigmaB)
      }
      else if sceneDelay=2 {boss.sigParts[2].image_angle=0}
      if sceneDelay>=60 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=1
    {
      if fadeAlpha>0 {fadeAlpha-=0.02}
      else if fadeAlpha<=0 {sceneProgress+=1}
    }
    else if sceneProgress=2
    {
      sceneDelay+=1
      if sceneDelay>=21 and sceneDelay<=40 {boss.sigParts[2].image_angle+=1}
      if sceneDelay>=60
      {
        var tempMplay;
        tempMplay=findMusic(812)
        playMusic(tempMplay,0,0)
        sceneDelay=0; sceneProgress+=1
      }
    }
    else if sceneProgress=3 and bWaitForInput=false
      msgCreate(0,0,"Sigma","Hex has provided me with the greatest battle armor!",8,3,oMessageCutscene,1)
    else if sceneProgress=4 and bWaitForInput=false
      msgCreate(0,0,"Jerry","I played that one too, Sigma!",0,3,oMessageCutscene,1)
    else if sceneProgress=5 and bWaitForInput=false
      msgCreate(0,0,"Sigma","I am well aware of this. Modifications have been made to accommodate that fact.",8,3,oMessageCutscene,1)
    else if sceneProgress=6 and bWaitForInput=false
    {
      oPlayer1.sprite_index=sJerryPose1
      msgCreate(0,0,"Jerry","I will stop you! Through the magic of cheesy lines and friendship!",0,3,oMessageCutscene,1)
    }
    else if sceneProgress=7 and bWaitForInput=false
      msgCreate(0,0,"Claire","You know Jeremy hates that.",0,3,oMessageCutscene,1)
    else if sceneProgress=8 and bWaitForInput=false
      msgCreate(0,0,"Jerry","I know, but he can't reply.",0,3,oMessageCutscene,1)
    else if sceneProgress=9
    {
      sceneDelay+=1
      if sceneDelay=15
      {
        playSound(global.snd_HealthPickup,0,1,1)
        var tEffect;
        tEffect=instance_create(oPlayer1.x,oPlayer1.y-(oPlayer1.sprite_height/2),oEffect)
        tEffect.sprite_index=sHeal
        tEffect.followID=oPlayer1.id; tEffect.xFollow=0; tEffect.yFollow=-(oPlayer1.sprite_height/2)
        tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
        oPlayer1.life=oPlayer1.maxLife
        global.hudMega_BusterEn[0]=32
        global.hudMega_ShotIceEn[0]=32
        global.hudMega_GravityEn[0]=32
      }
      else if sceneDelay>=30 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=10 and bWaitForInput=false
      msgCreate(0,0,"","Jerry's cheesy words fully restored his energy.",6,3,oMessageCutscene,1)
    else if sceneProgress=11
    {
      global.gamePaused=false
      instance_create(0,0,oCheckpointNotice)
      boss.activateBoss=1
      global.currentBoss="Sigma Epsilon"
      global.bossTrack=3
      storeStatus(0)
      sceneDelay=0; sceneProgress=0
    }
  }
  else if global.bossTrack=3
  {
    if !instance_exists(oSigmaB) and sceneProgress=0 //End Boss
    {
      global.gamePaused=true
      awardBossAP(2700)
      stopAllMusic()
      global.bossTrack=4
    }
  }
  else if global.bossTrack=4
  {
    if sceneProgress=0
    {
      if fadeAlpha<1 {fadeAlpha+=0.05}
      else if fadeAlpha>=1 {sceneProgress+=1}
    }
    else if sceneProgress=1
    {
      sceneDelay+=1
      if sceneDelay=1
      {
        endBoss()
        scenePChk(176,288,0,0.1,1)
      }
      if sceneDelay>=60 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=2
    {
      if fadeAlpha>0 {fadeAlpha-=0.05}
      else if fadeAlpha<=0 {sceneProgress+=1}
    }
    else if sceneProgress=3
    {
      sceneDelay+=1
      if sceneDelay>=25 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=4 and bWaitForInput=false
      msgCreate(0,0,"Claire","That was intense looking, and incredible when you finally won!",0,3,oMessageCutscene,1)
    else if sceneProgress=5 and bWaitForInput=false
      msgCreate(0,0,"Jerry","Thanks. I couldn't have done it without X's help.",0,3,oMessageCutscene,1)
    else if sceneProgress=6 and bWaitForInput=false
      msgCreate(0,0,"Claire","Yeah...",0,3,oMessageCutscene,1)
    else if sceneProgress=7 and bWaitForInput=false
      msgCreate(0,0,"Jerry","Eh... So Chao, any signs of Jeremy?",0,3,oMessageCutscene,1)
    else if sceneProgress=8 and bWaitForInput=false
      msgCreate(0,0,"Chao","Once Sigma was beaten, a faint signal could be seen. It looks like Sigma was the main source of the interferance.",0,3,oMessageCutscene,1)
    else if sceneProgress=9 and bWaitForInput=false
      msgCreate(0,0,"Jerry","Main source? So there IS something else... Sigma wasn't lying.",0,3,oMessageCutscene,1)
    else if sceneProgress=10 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","...",0,3,oMessageCutscene,1)
    else if sceneProgress=11 and bWaitForInput=false
      msgCreate(0,0,"Chao","JEREMY!! Are you finally able to get through?!",0,3,oMessageCutscene,1)
    else if sceneProgress=12 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","Yes, took a moment for me to figure out how to unblock myself, even after Sigma was defeated.",0,3,oMessageCutscene,1)
    else if sceneProgress=13 and bWaitForInput=false
      msgCreate(0,0,"Jerry","Jeremy...",0,3,oMessageCutscene,1)
    else if sceneProgress=14 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","If you're pissed at me, I understand.",0,3,oMessageCutscene,1)
    else if sceneProgress=15 and bWaitForInput=false
      msgCreate(0,0,"Jerry","No, I'm not upset, but is what Sigma said, true? Is it really Hexor in the Vault?",0,3,oMessageCutscene,1)
    else if sceneProgress=16 and bWaitForInput=false
      msgCreate(0,0,"Chao","Who is Hexor?",0,3,oMessageCutscene,1)
    else if sceneProgress=17 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","When Jerry and I were battling The Darkness, it created a way to combat me, to keep me from figuring out that I was able to access and modify the system.",0,3,oMessageCutscene,1)
    else if sceneProgress=18 and bWaitForInput=false
      msgCreate(0,0,"Chao","How did it do that, and how does this Hexor fit into all of this?",0,3,oMessageCutscene,1)
    else if sceneProgress=19 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","The program created a copy of me, or at least as close as it could come to one. Hexor is that copy.",0,3,oMessageCutscene,1)
    else if sceneProgress=20 and bWaitForInput=false
    {
      showEmote(oIdentifier,0,-6,sEmThinking)
      msgCreate(0,0,"Chao","Shouldn't he be on our side?",0,3,oMessageCutscene,1)
    }
    else if sceneProgress=21 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","No, I thought he was trying to help the program, but like all entities in this, it created its own persona, so to say. After we came to peaceful terms with the program, Hexor tried to help shut it down with The Artist, who I'm sure you've heard about.",0,3,oMessageCutscene,1)
    else if sceneProgress=22 and bWaitForInput=false
      msgCreate(0,0,"Chao","A malicious version of you...",0,3,oMessageCutscene,1)
    else if sceneProgress=23 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","Yes. I never could figure out what his motives really were though.",0,3,oMessageCutscene,1)
    else if sceneProgress=24 and bWaitForInput=false
      msgCreate(0,0,"Jerry","So Jeremy, is it really him, or was Sigma lying?",0,3,oMessageCutscene,1)
    else if sceneProgress=25 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","It has to be. I can't think of anyone else who knows enough to block me out like that.",0,3,oMessageCutscene,1)
    else if sceneProgress=26 and bWaitForInput=false
      msgCreate(0,0,"Jerry","I thought you deleted him though.",0,3,oMessageCutscene,1)
    else if sceneProgress=27 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","I couldn't, and I never said I deleted him. I needed a quick fix to the problem and knew of the Vault where the program stored all the malicious entities. Normally, nothing should have been able to get out.",0,3,oMessageCutscene,1)
    else if sceneProgress=28 and bWaitForInput=false
      msgCreate(0,0,"Jerry","Then we need to find a way to close up the Vault. If Sigma was speaking the truth, he'll escape soon.",0,3,oMessageCutscene,1)
    else if sceneProgress=29 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","The only problem is the area around the Vault entrance is jumbled, so we're not able to get close.",0,3,oMessageCutscene,1)
    else if sceneProgress=30 and bWaitForInput=false
      msgCreate(0,0,"Jerry","I don't really know how that makes sense, but I don't understand most of this anyway. So what do we do?",0,3,oMessageCutscene,1)
    else if sceneProgress=31 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","Syrus said he was working on something to unscramble the data there. He should have it finished by now.",0,3,oMessageCutscene,1)
    else if sceneProgress=32 and bWaitForInput=false
      msgCreate(0,0,"Jerry","Then we have our next destination.",0,3,oMessageCutscene,1)
    else if sceneProgress=33 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","That we d... oh man...",0,3,oMessageCutscene,1)
    else if sceneProgress=34 and bWaitForInput=false
      msgCreate(0,0,"Jerry","What? Is something wrong?",0,3,oMessageCutscene,1)
    else if sceneProgress=35 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","You deleted Sigma before finding out if he altered the Virus!",0,3,oMessageCutscene,1)
    else if sceneProgress=36 and bWaitForInput=false
      msgCreate(0,0,"Jerry","Oh man... whoops.",0,3,oMessageCutscene,1)
    else if sceneProgress=37 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","Whatever, let's just go.",0,3,oMessageCutscene,1)
    else if sceneProgress=38 and bWaitForInput=false
      msgCreate(0,0,"Jerry","There's uh... something else we're forgetting.",0,3,oMessageCutscene,1)
    else if sceneProgress=39 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","Getting information from Sigma and then kicking ass. Well one of those was borked. Can't think of anything else.",0,3,oMessageCutscene,1)
    else if sceneProgress=40 and bWaitForInput=false
      msgCreate(0,0,"Jerry","The Program Chip dude, where is it?",0,3,oMessageCutscene,1)
    else if sceneProgress=41
    {
      sceneDelay+=1
      if sceneDelay=20
      {
        pChip=instance_create(176,182,oProgramChip)
        pChip.chipType=3; pChip.visible=0
      }
      else if sceneDelay>=21 and sceneDelay<=35
      {
        circleRad+=2
        if sceneDelay=25 {pChip.visible=1}
      }
      else if sceneDelay>=36 and sceneDelay<=50
        circleRad-=2
      else if sceneDelay>=75 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=42
    {
      sceneDelay+=1
      if sceneDelay>=21 and sceneDelay<=100 {pChip.y+=1}
      else if sceneDelay=130
      {
        var tEffect;
        for(i=0;i<20;i+=1)
        {
          tEffect=instance_create(oProgramChip.x,oProgramChip.y,oKillEffect)
          tEffect.speed=5; tEffect.direction=random(360); tEffect.friction=0.1+random(0.3)
          tEffect.fadeAlpha=0.04+random(0.02); tEffect.imageRot=random_range(-5,5)
        }
        with oProgramChip {instance_destroy()}
      }
      else if sceneDelay=160 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=43 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","Right there.",0,3,oMessageCutscene,1)
    else if sceneProgress=44 and bWaitForInput=false
      msgCreate(0,0,"","Jerry can now use X's abilities outside of this Gate.",6,3,oMessageCutscene,1)
    else if sceneProgress=45
    {
      var newExit;
      newExit=instance_create(352,288,oExit)
      newExit.sprite_index=sWarpGateStand
      newExit.bShowArrow=false; newExit.exitType=0
      newExit.newMapX=0; newExit.newMapY=0; newExit.toRoom=rMega4_Map
      var tHeartContainer;
      tHeartContainer=instance_create(240,280,oHeartContainer)
      tHeartContainer.objectNum=4
      var tempMplay;
      tempMplay=findMusic(412)
      playMusic(tempMplay,0,0)
      abilSetRemove(0)
      global.charScan[0]=1
      global.programChips=4
      global.gamePaused=false
      global.currentBoss=""
      global.bossTrack=0
      global.gameProgress=1990
    }
  }
}

keyWaitForInput()

if oKeyCodes.kCodePressed[11]=1 and global.gamePaused=true and sceneProgress>=1 //Cutscene skip
{
  if !instance_exists(oPauseMenu)
  {
    if room=rMega4_SigmaA1 and global.gameProgress=1850 and global.tempAction[0]=0 //[1]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      sceneDelay=0
      sceneProgress=5
    }
    else if room=rMega4_SigmaB4 and global.gameProgress=1920 //[2]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      sceneDelay=0
      sceneProgress=8
    }
    else if room=rMega4_SigmaC1 and global.gameProgress=1950 and global.tempAction[0]=0 //[3]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      sceneDelay=0
      sceneProgress=8
    }
  }
}

//----- Room specific events -----
if room=rMega4_SigmaC3 //Start crush walls
{
  if oPlayer1.y<=1776 and wallCheck=0
  {
    (233988).moveSeq=1; (233989).moveSeq=1
    (233990).moveSeq=1; (233991).moveSeq=1
    wallCheck+=1
  }
  else if oPlayer1.y<=1392 and wallCheck=1
  {
    (233992).moveSeq=1
    (233993).moveSeq=1
    wallCheck+=1
  }
  else if oPlayer1.y<=1184 and wallCheck=2
  {
    (233996).moveSeq=1
    wallCheck+=1
  }
  else if oPlayer1.y<=832 and wallCheck=3
  {
    (234134).moveSeq=1; (234135).moveSeq=1; (234136).moveSeq=1
    (234137).moveSeq=1; (234138).moveSeq=1; (234139).moveSeq=1
    wallCheck+=1
  }
}
else if room=rMega4_SigmaC5
{
  bubbleTime+=1
  if bubbleTime>=bubbleDelay
  {
    var tSigmaBubble;
    tSigmaBubble=instance_create(242+random(16),250+random(2),oEffect)
    tSigmaBubble.sprite_index=sAirBubble; tSigmaBubble.depth=999999
    tSigmaBubble.image_blend=c_teal; tSigmaBubble.image_alpha=0.5; tSigmaBubble.image_speed=0
    tSigmaBubble.decay=40; tSigmaBubble.ySpd=-0.75-random(1)
    tSigmaBubble.newBlend=-1; tSigmaBubble.followID=-1; tSigmaBubble.xSpd=0
    bubbleTime=0; bubbleDelay=irandom(35)+5
  }
}

//Beam down at the start of stages
if global.tempAction[0]>=1
{
  beamDownProg+=1
  if beamDownProg=1
  {
    viewFix=instance_create(oPlayer1.x,playerSpotY,oMisc)
    viewFix.type=0
    viewFix.sprite_index=sNull
    view_object[0]=viewFix
    if global.tempAction[0]=4 {oPlayer1.y=340}
    else if global.tempAction[0]=5 {oPlayer1.y=340}
    else if global.tempAction[0]=6 {oPlayer1.y=-8}
    oPlayer1.sprite_index=sPlayerDiscombobulate; oPlayer1.image_speed=0
  }
  else if beamDownProg=30 {readyText=1}
  else if beamDownProg>=31 and beamDownProg<=69 {readyWidth+=1}
  else if beamDownProg>=80 and beamDownProg<=119
  {
    if beamDownProg mod 8=0
    {
      if readyText=0 {readyText=1}
      else {readyText=0}
    }
  }
  else if beamDownProg=120 {readyText=0}
  else if beamDownProg=135 {playSound(global.snd_MMBeamDown,0,1,1)}
  else if beamDownProg>=136 and beamDownProg<=199
  {
    oPlayer1.y+=16
    if oPlayer1.y>=playerSpotY {oPlayer1.y=playerSpotY; oPlayer1.image_index=1; beamDownProg=200}
  }
  else if beamDownProg>=203
  {
    view_object[0]=oPlayer1
    with viewFix {instance_destroy()}
    oPlayer1.sprite_index=sJerryIdle; oPlayer1.image_speed=0.1
    global.tempAction[0]=0
    global.gamePaused=false
  }
}

if room=rMega4_SigmaB8 and global.bBossGallery=1 //----- [] Boss Fight: Bit & Byte (Boss Gallery) -----
{
  if !instance_exists(oMMBit) and !instance_exists(oMMByte)
  {
    bossRoomTally(22)
    global.newMapX=1288; global.newMapY=1056; room_goto(rBossGallery)
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

if readyText=1 {draw_sprite_part(sMMReadyText,-1,0,0,readyWidth,13,view_xview[0]+221,view_yview[0]+170)}

if room=rMega4_SigmaC5
{
  if circleRad>0
  {
    draw_set_color(c_white)
    draw_set_blend_mode_ext(bm_inv_dest_color,bm_zero)
    draw_circle(oProgramChip.x,oProgramChip.y,circleRad,0)
    draw_set_blend_mode(bm_normal)
  }
}
