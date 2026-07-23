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
//global.difficulty=2

bClouds=0
if room=rExtGateA_1 or room=rExtGateA_2
{
  bClouds=1
  cloudSpawn=irandom(50)
  lakituSpawn=120
}
else if room=rExtGateA_6
{
  bossCheck=string_char_at(global.eGateProg,1)
  if bossCheck="8" {global.mapTeleport=0}
  else {global.mapTeleport=1}
}
else if room=rExtGateB_5 {rmCheck=0}
else if room=rExtGateB_6
{
  bossCheck=string_char_at(global.eGateProg,2)
  if bossCheck="8" {global.mapTeleport=0}
  else {global.mapTeleport=2}
  bgCol=20
  bgSeq=0
}
else if room=rExtGateC_5
{
  fadeColor=c_black
  bossCheck=string_char_at(global.eGateProg,3)
  if bossCheck="8" {global.mapTeleport=0}
  else {global.mapTeleport=3}
}
else if room=rExtGateD_2 or room=rExtGateD_6
{
  bossCheck=string_char_at(global.eGateProg,4)
  if room=rExtGateD_2
  {
    rmProg=0
    rmTime=0
  }
  else if rExtGateD_6
  {
    if bossCheck="7" and global.bossTrack=0
    {
      npcElpizo=instance_create(448,416,oMisc)
      npcElpizo.sprite_index=sElpizoEngarde; npcElpizo.image_speed=0
      npcElpizo.image_xscale=-1; npcElpizo.type=1
    }
    if bossCheck="8" {global.mapTeleport=0}
    else {global.mapTeleport=4}
  }
}
else if room=rExtGateE_5
{
  bossCheck=string_char_at(global.eGateProg,5)
  if bossCheck="8" {global.mapTeleport=0}
  else {global.mapTeleport=5}
}
else if room=rExtGateF_3 or room=rExtGateF_4
{
  bWallSpawn=0
}
else if room=rExtGateF_6
{
  bossCheck=string_char_at(global.eGateProg,6)
  if bossCheck="8" {global.mapTeleport=0}
  else {global.mapTeleport=6}
}
else if room=rExtGateG_1 or room=rExtGateG_2 or room=rExtGateG_3 or room=rExtGateG_4 or room=rExtGateG_5
{
  backIsleSpawn=0
  for(i=0;i<round(room_width/256);i+=1)
  {
    instance_create(random_range(48,room_width-48),random_range(48,room_height+48),oGG_BackIsle)
  }

  if room=rExtGateG_1
  {
    var tTrap,tDir;
    tDir=0
    for(i=0;i<24;i+=1)
    {
      tTrap=instance_create(4808,208,oMovingTrap)
      tTrap.shiftTime=0; tTrap.shiftMax=60; tTrap.moveSpd=3; tTrap.bShowLine=1
      tTrap.direction=tDir
      tDir+=360/24
    }
  }
  else if room=rExtGateG_2
  {
    mapTime=0
    slimeTime=0
  }
  else if room=rExtGateG_3
  {
    var tTrap,tDir;
    tDir=0
    for(i=0;i<24;i+=1)
    {
      tTrap=instance_create(3584,224,oMovingTrap)
      tTrap.shiftTime=0; tTrap.shiftMax=60; tTrap.moveSpd=3; tTrap.bShowLine=1
      tTrap.direction=tDir
      tDir+=360/24
    }
  }
  else if room=rExtGateG_4
  {
    if global.newMapX>=2800
    {
      with (346602) {instance_destroy()}
      with (346605) {instance_destroy()}
      sceneProgress=1
    }
    if global.newMapX>=3600 {sceneProgress=3}
  }
  else if room=rExtGateG_5
  {
    bossCheck=string_char_at(global.eGateProg,7)
    if bossCheck="8" {global.mapTeleport=0}
    else {global.mapTeleport=7}
  }
}
else if room=rSacredTemple
{
  //-- Check which instrument player is obtaining --
  instrStory=-1
  exitCreate=0
  instrObj=0
  instrNum=0
  for(i=0;i<8;i+=1)
  {
    instrNum+=1
    instrProg[i]=string_char_at(global.eGateProg,i+1)
    if instrProg[i]="8"
    {
      instrObj=instance_create(1024,1176,oInstrument)
      instrObj.instrType=instrNum
      instrStory=0
      break;
    }
  }
  //-- Check the number of instruments the player has --
  if instrStory!=-1
  {
    var tCountInstr;
    tCountInstr=0
    for(i=0;i<8;i+=1)
    {
      tCountInstr=string_char_at(global.eGateProg,i+1)
      if tCountInstr="9"
        instrStory+=1
    }
  }
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if bClouds=1
  {
    cloudSpawn+=1
    if cloudSpawn=250
    {
      instance_create(view_xview[0]+view_wview[0]+4,view_yview[0]+random_range(8,96),oBkgCloud)
      cloudSpawn=irandom(50)
    }
  }

  if room=rExtGateA_1 //Lakitu spawn
  {
    if !instance_exists(oLakitu)
    {
      lakituSpawn+=1
      if lakituSpawn=210
      {
        var tNewEnemy;
        tNewEnemy=instance_create(view_xview[0]-16,48,oLakitu)
        tNewEnemy.bActive=true
        lakituSpawn=0
      }
    }
  }
  else if room=rExtGateD_2 //----- [] Enemy Spawn Event -----
  {
    if rmProg=0 and oPlayer1.x>=688 and oPlayer1.y>=192
    {
      msgCreate(0,0,"Jerry","What is that?",0,1,oMessagePerson,0)
      newMessage.fadingTime=60; rmProg+=1
    }
    else if rmProg=1 {rmTime+=1;if rmTime>=70 {rmProg+=1; rmTime=0}}
    else if rmProg=2
    {
      msgCreate(0,0,"Jeremy","Eh... the Nightmare Effect?",0,1,oMessagePerson,0)
      newMessage.fadingTime=70; rmProg+=1
    }
    else if rmProg=3 {rmTime+=1;if rmTime>=80 {rmProg+=1; rmTime=0}}
    else if rmProg=4
    {
      msgCreate(0,0,"Jerry","It didn't do this.",0,1,oMessagePerson,0)
      newMessage.fadingTime=70; rmProg+=1
    }
    else if rmProg=5 {rmTime+=1;if rmTime>=80 {rmProg+=1; rmTime=0}}
    else if rmProg=6
    {
      msgCreate(0,0,"Jeremy","Don't care, I'm still calling it that.",0,1,oMessagePerson,0)
      newMessage.fadingTime=90; rmProg+=1
    }
    else if rmProg=7 {rmTime+=1;if rmTime>=100 {rmProg+=1; rmTime=0}}

    if sceneProgress=0
    {
      if oPlayer1.x>=2128
      {
        var enemyCounter,eBarrier;
        enemyCounter=instance_create(0,0,oEnemyRemain)
        enemyCounter.enemyCount=5
        eBarrier=instance_create(1984,80,oEnemyBarrier); eBarrier.image_yscale=10
        eBarrier=instance_create(2256,80,oEnemyBarrier); eBarrier.image_yscale=10
        sceneProgress+=1
      }
    }
    else if sceneProgress=1
    {
      sceneDelay+=1
      if sceneDelay=30
      {
        createEnemy(2032,144,oSineFaller,2,0,1)
        createEnemy(2224,144,oSineFaller,2,0,1)
        sceneDelay=0; sceneProgress+=1
      }
    }
    else if sceneProgress=2
    {
      if oEnemyRemain.enemyCount<=3
      {
        createEnemy(2048,160,oSineFaller,2,0,1)
        createEnemy(2208,160,oSineFaller,2,0,1)
        sceneProgress+=1
      }
    }
    else if sceneProgress=3
    {
      if oEnemyRemain.enemyCount<=1
      {
        delaySpawn(2128,240,oMegaTortoise,2,1,1,0.33)
        sceneProgress+=1
      }
    }
    else if sceneProgress=4
    {
      if oEnemyRemain.enemyCount<=0
      {
        with oEnemyRemain {instance_destroy()}
        with oEnemyBarrier {instance_destroy()}
        sceneProgress=10
      }
    }
  }
  else if room=rExtGateG_2 //Map display and slimes spawning in
  {
    if scrController(4) {mapTime+=1}
    else {mapTime=0}

    if instance_number(oPT_Slime)<8 {slimeTime+=1}
    if slimeTime>=300
    {
      global.tempAction[0]=64
      var tRanNum,tXX,tYY;
      tRanNum=choose(0,1,2)
      if tRanNum=0 {tXX=720; tYY=432}
      else if tRanNum=1 {tXX=528; tYY=768}
      else if tRanNum=2 {tXX=1712; tYY=416}
      delaySpawn(240,96,oPT_Slime,0,1,0,0.1)
      slimeTime=0
    }
  }
  else if room=rExtGateG_4
  {
    if oPlayer1.x>=4400 and sceneProgress<3 {sceneProgress=3}

    if sceneProgress=0 //Defeat Slime
    {
      if !instance_exists((346605))
      {
        with (346602) {instance_destroy()}
        sceneProgress+=1
      }
    }
    else if sceneProgress=1 //Check sign (Cookies)
    {
      if (346607).bChecked=1 {sceneProgress+=1}
    }
    else if sceneProgress=2 //Cookies rain down
    {
      sceneDelay+=1
      if sceneDelay>=40
      {
        if sceneDelay mod 5=0
        {
          var tCookie,tEfCreate,tXX,tYY;
          tXX=3480+random(192)
          tYY=1360+random(16)
          tEfCreate=instance_create(tXX,tYY,oEffect)
          tEfCreate.sprite_index=sMMchargeComplete; tEfCreate.image_speed=0.5
          tEfCreate.newBlend=-1; tEfCreate.followID=-1; tEfCreate.decay=-100; tEfCreate.xSpd=0; tEfCreate.ySpd=0
          tCookie=instance_create(tXX,tYY,oHealthPickup)
          tCookie.sprite_index=sGG_Cookie
        }
      }
      if sceneDelay>=180 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=3 //----- [] Enemy Trap Event -----
    {
      if oPlayer1.x>=4832
      {
        var enemyCounter,eBarrier;
        enemyCounter=instance_create(0,0,oEnemyRemain)
        enemyCounter.enemyCount=10
        eBarrier=instance_create(4656,-32,oEnemyBarrier); eBarrier.image_yscale=20
        eBarrier=instance_create(4992,-32,oEnemyBarrier); eBarrier.image_yscale=20
        sceneProgress+=1
      }
    }
    else if sceneProgress=4
    {
      sceneDelay+=1
      if sceneDelay=30
      {
        global.tempAction[0]=64
        delaySpawn(4704,288,oPT_Skeleton,2,1,1,0.33)
        delaySpawn(4960,288,oPT_Skeleton,2,1,1,0.33)
        sceneDelay=0; sceneProgress+=1
      }
    }
    else if sceneProgress=5
    {
      if oEnemyRemain.enemyCount<=8
      {
        delaySpawn(4768,192,oPT_FireEye,2,0,1,0.33)
        delaySpawn(4896,192,oPT_FireEye,2,0,1,0.33)
        sceneProgress+=1
      }
    }
    else if sceneProgress=6
    {
      if oEnemyRemain.enemyCount<=6
      {
        delaySpawn(4704,192,oPT_IceSpirit,2,0,1,0.33)
        delaySpawn(4832,192,oPT_IceSpirit,2,0,1,0.33)
        delaySpawn(4960,192,oPT_IceSpirit,2,0,1,0.33)
        sceneProgress+=1
      }
    }
    else if sceneProgress=7
    {
      if oEnemyRemain.enemyCount<=3
      {
        delaySpawn(4704,288,oPT_SwordArmor,2,0,1,0.33)
        delaySpawn(4960,288,oPT_SwordArmor,2,0,1,0.33)
        sceneProgress+=1
      }
    }
    else if sceneProgress=8
    {
      if oEnemyRemain.enemyCount<=1
      {
        global.tempAction[0]=100
        delaySpawn(4832,288,oPT_SwordArmor,2,0,1,0.2)
        sceneProgress+=1
      }
    }
    else if sceneProgress=9
    {
      if oEnemyRemain.enemyCount<=0
      {
        with oEnemyRemain {instance_destroy()}
        with oEnemyBarrier {instance_destroy()}
        sceneProgress=10
      }
    }
  }
}

if room=rExtGateA_6 //----- [A] Boss Fight: Kamek -----
{
  if global.bossTrack=0 and bossCheck="7"
  {
    if sceneProgress=0 and oPlayer1.x>=176
    {
      sceneDelay+=1
      if sceneDelay=1 {global.gamePaused=true}
      oPlayer1.y+=4
      if oPlayer1.y>=288
      {
        scenePChk(176,288,0,0.1,1)
        stopPlayer()
        sceneDelay=0; sceneProgress+=1
      }
    }
    else if sceneProgress=1
    {
      sceneDelay+=1
      if sceneDelay=1
      {
        viewFix=instance_create(176,176,oMisc)
        viewFix.type=0; viewFix.sprite_index=sNull
        view_object[0]=viewFix
      }
      else if sceneDelay>=21 and sceneDelay<=44 {viewFix.x+=4}
      else if sceneDelay>=60 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=2
    {
      sceneDelay+=1
      if sceneDelay>=21 and sceneDelay<=60
      {
        var tEffect;
        tEffect=instance_create(368+random_range(-18,18),288-random(38),oEffect)
        tEffect.sprite_index=sMMSmokeCloud; tEffect.image_speed=0.1+random(0.2); tEffect.image_alpha=0.9; tEffect.depth=9
        tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=-0.25-random(0.25)
        if sceneDelay=40
        {
          npcKamek=instance_create(368,288,oMisc)
          npcKamek.sprite_index=sKamekNormal; npcKamek.image_speed=0
          npcKamek.image_xscale=-1; npcKamek.type=1
        }
      }
      else if sceneDelay>=90 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=3 and bWaitForInput=false
      msgCreate(0,0,"Jerry","Oh it's just this guy.",0,3,oMessageCutscene,1)
    else if sceneProgress=4
    {
      sceneDelay+=1
      if sceneDelay=20 {npcKamek.image_index=1}
      else if sceneDelay>=360 {sceneDelay=0; sceneProgress+=1} //End intro

      if sceneDelay>=30 and sceneDelay<=75 //Wand sparkles
      {
        var tEffect;
        tEffect=instance_create(npcKamek.x-7,npcKamek.y-47,oEffect)
        tEffect.sprite_index=sEfDiffusionParticle; tEffect.image_speed=0.2+random(0.1); tEffect.depth=9
        tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=random_range(-1.5,1.5); tEffect.ySpd=random_range(-1.5,1.5)
      }
      if sceneDelay>=70 and sceneDelay<=310
      {
        if sceneDelay=80
        {
          npcKamek.sprite_index=sKamekIdle
          npcKamek.image_speed=0.15
        }
        else if sceneDelay=110
        {
          var tempMplay;
          tempMplay=findMusic(818)
          playMusic(tempMplay,0,0)

          kamShadow=instance_create(368,288,oMisc)
          kamShadow.sprite_index=sKamekIdle; kamShadow.image_speed=0; kamShadow.image_alpha=0
          kamShadow.type=1; kamShadow.image_blend=c_black
          kamShadow.image_xscale=-4; kamShadow.image_yscale=6
        }
        else if sceneDelay>=111 and sceneDelay<=299 //Shadow
        {
          if kamShadow.image_alpha<0.6 {kamShadow.image_alpha+=0.02}
          kamShadow.image_xscale+=0.025; kamShadow.image_yscale-=0.04
          if kamShadow.image_yscale<=1
          {
            with kamShadow {instance_destroy()}
            sceneDelay=300
          }
        }
        //Blue fire explosions
        var tEffect;
        tEffect=instance_create(npcKamek.x+random_range(-23,23),npcKamek.y-random(43),oEffect)
        tEffect.sprite_index=sWitchFire; tEffect.image_speed=0.3+random(0.1); tEffect.depth=9
        tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
      }
    }
    else if sceneProgress=5 and bWaitForInput=false
      msgCreate(0,0,"Jerry","Dude...",0,3,oMessageCutscene,1)
    else if sceneProgress=6 and bWaitForInput=false
      msgCreate(0,0,"Claire","That's creepy.",0,3,oMessageCutscene,1)
    else if sceneProgress=7 and bWaitForInput=false
      msgCreate(0,0,"Jerry","Any hints?",0,3,oMessageCutscene,1)
    else if sceneProgress=8 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","You're gonna have to give me some time on that. Just fight it out till I can hack in a bit better.",0,3,oMessageCutscene,1)
    else if sceneProgress=9
    {
      global.gamePaused=false
      var tempMplay;
      tempMplay=findMusic(818)
      playMusic(tempMplay,0,0)
      var tBossTitle,bBarrier;
      bBarrier=instance_create(112,192,oBossBarrier)
      bBarrier=instance_create(416,192,oBossBarrier)
      tBossTitle=instance_create(0,0,oBossNameDisplay)
      tBossTitle.bossName="Kamek"
      tBossTitle.bossTitle="?????"
      global.currentBoss="Kamek"
      with oMisc {instance_destroy()}
      viewFix=instance_create(272,176,oMisc)
      viewFix.type=0
      viewFix.sprite_index=sNull
      view_object[0]=viewFix
      boss=instance_create(368,288,oKamek)
      boss.activateBoss=1
      boss.image_alpha=1
      global.bossTrack=1
      storeStatus(0)
      sceneDelay=0; sceneProgress=0
    }
  }
  else if global.bossTrack=1
  {
    if sceneProgress=1 //End Boss
    {
      awardBossAP(700)
      view_object[0]=oPlayer1
      with (344039) {instance_destroy()}
      with oMisc {instance_destroy()}
      with oBossBarrier {instance_destroy()}
      global.mapTeleport=0
      var tempMplay;
      tempMplay=findMusic(202)
      playMusic(tempMplay,0,0)
      global.currentBoss=""
      var tNewString;
      tNewString=string_delete(global.eGateProg,1,1)
      tNewString=string_insert("8",tNewString,1)
      global.eGateProg=tNewString
      bossCheck="8"
      sceneProgress=0
      global.bossTrack=0
    }
  }
}
else if room=rExtGateB_5 //----- [] Tile attack check -----
{
  if rmCheck=0
  {
    with oZeldaFloorSolid {atkTime=0}
    if oPlayer1.x>=240
    {
      var eBarrier;
      eBarrier=instance_create(144,224,oEnemyBarrier); eBarrier.image_yscale=4
      eBarrier=instance_create(544,224,oEnemyBarrier); eBarrier.image_yscale=4
      rmCheck=1
    }
  }
  else if rmCheck=1
  {
    if !instance_exists(oZeldaFloorSolid) and !instance_exists(oZeldaFloorTile)
    {
      with oEnemyBarrier {instance_destroy()}
      rmCheck=2
    }
  }
}
else if room=rExtGateB_6 //----- [B] Boss Fight: Final Nightmare -----
{
  if global.bossTrack=0 and bossCheck="7"
  {
    if sceneProgress=0 and oPlayer1.x>=560
    {
      sceneDelay+=1
      if sceneDelay=1 {global.gamePaused=true}
      oPlayer1.y+=4
      if oPlayer1.y>=288
      {
        oPlayer1.y=288; oPlayer1.sprite_index=sJerryIdle; oPlayer1.image_xscale=1
        stopPlayer()
        sceneDelay=0; sceneProgress+=1
      }
    }
    else if sceneProgress=1
    {
      sceneDelay+=1
      if sceneDelay=1
      {
        viewFix=instance_create(560,176,oMisc)
        viewFix.type=0; viewFix.sprite_index=sNull
        view_object[0]=viewFix
        boss=instance_create(560,160,oFinalNightmare)
        boss.image_alpha=0
      }
      else if sceneDelay>=21 and sceneDelay<=70
        boss.image_alpha+=0.02
      else if sceneDelay>=90
      {
        sceneDelay=0
        sceneProgress+=1
      }
    }
    else if sceneProgress=2 and bWaitForInput=false
      msgCreate(0,0,"Nightmare","From out of the darkness I rose.#To purge...",8,3,oMessageCutscene,1)
    else if sceneProgress=3 and bWaitForInput=false
      msgCreate(0,0,"Jerry","Nope, don't start. Not in the mood for that ABBA structure.",0,3,oMessageCutscene,1)
    else if sceneProgress=4 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","How did you know it was trying to rhyme?",0,3,oMessageCutscene,1)
    else if sceneProgress=5 and bWaitForInput=false
      msgCreate(0,0,"Jerry","Inside joke with Claire.",0,3,oMessageCutscene,1)
    else if sceneProgress=6 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","Do I want to know?",0,3,oMessageCutscene,1)
    else if sceneProgress=7 and bWaitForInput=false
      msgCreate(0,0,"Claire","No... Jerry, don't bring that up.",0,3,oMessageCutscene,1)
    else if sceneProgress=8 and bWaitForInput=false
      msgCreate(0,0,"Chao",":3",0,3,oMessageCutscene,1)
    else if sceneProgress=9 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","Oh wow...",0,3,oMessageCutscene,1)
    else if sceneProgress=10 and bWaitForInput=false
      msgCreate(0,0,"Jerry","How does Chao know about that, Claire?",0,3,oMessageCutscene,1)
    else if sceneProgress=11 and bWaitForInput=false
      msgCreate(0,0,"Chao","Girl night.",0,3,oMessageCutscene,1)
    else if sceneProgress=12 and bWaitForInput=false
      msgCreate(0,0,"Jerry","Awkward... This fight needs to start NOW!",0,3,oMessageCutscene,1)
    else if sceneProgress=13 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","Quick heads up. This thing has blocked your bomb's early detonation. Remember that if you have to use it, the fuse time is 3 seconds.",0,3,oMessageCutscene,1)
    else if sceneProgress=14
    {
      global.gamePaused=false
      var tempMplay;
      tempMplay=findMusic(808)
      playMusic(tempMplay,0,0)
      var tBossTitle,bBarrier;
      bBarrier=instance_create(368,224,oBossBarrier)
      bBarrier=instance_create(736,224,oBossBarrier)
      tBossTitle=instance_create(0,0,oBossNameDisplay)
      tBossTitle.bossName="Final Nightmare"
      tBossTitle.bossTitle="?????"
      global.currentBoss="Final Nightmare"
      if !instance_exists(oFinalNightmare)
      {
        viewFix=instance_create(560,176,oMisc)
        viewFix.type=0
        viewFix.sprite_index=sNull
        view_object[0]=viewFix
        boss=instance_create(560,160,oFinalNightmare)
      }
      boss.activateBoss=1
      boss.image_alpha=1
      global.bossTrack=1
      storeStatus(0)
      sceneDelay=0; sceneProgress=0
    }
  }
  else if global.bossTrack=1
  {
    if sceneProgress=1 //End Boss
    {
      awardBossAP(1500)
      view_object[0]=oPlayer1
      with (344042) {instance_destroy()}
      with oMisc {instance_destroy()}
      with oBossBarrier {instance_destroy()}
      global.mapTeleport=0
      var tempMplay;
      tempMplay=findMusic(202)
      playMusic(tempMplay,0,0)
      global.currentBoss=""
      var tNewString;
      tNewString=string_delete(global.eGateProg,2,1)
      tNewString=string_insert("8",tNewString,2)
      global.eGateProg=tNewString
      bossCheck="8"
      sceneProgress=0
      global.bossTrack=0
    }
  }
}
else if room=rExtGateC_5 //----- [C] Boss Fight: Blackmoor -----
{
  if global.bossTrack=0 and bossCheck="7"
  {
    if sceneProgress=0 and oPlayer1.x>=400
    {
      sceneDelay+=1
      if sceneDelay=1 {global.gamePaused=true}
      oPlayer1.y+=4
      if oPlayer1.y>=304
      {
        oPlayer1.y=304
        oPlayer1.sprite_index=sClaireIdle
        oPlayer1.image_xscale=1
        stopPlayer()
        sceneDelay=0; sceneProgress+=1
      }
    }
    else if sceneProgress=1
    {
      sceneDelay+=1
      if sceneDelay=1
      {
        viewFix=instance_create(400,176,oMisc)
        viewFix.type=0; viewFix.sprite_index=sNull
        view_object[0]=viewFix
      }
      else if sceneDelay>=21 and sceneDelay<=56 {viewFix.x+=4}
      else if sceneDelay>=70 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=2 and bWaitForInput=false
      msgCreate(0,0,"Jerry","Apparently Claire doesn't get to fight anything. It has to be that attractive personality you have.",0,3,oMessageCutscene,1)
    else if sceneProgress=3 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","Something is definitely here.",0,3,oMessageCutscene,1)
    else if sceneProgress=4 and bWaitForInput=false
      msgCreate(0,0,"Jerry","This should be good.",0,3,oMessageCutscene,1)
    else if sceneProgress=5
    {
      global.gamePaused=false
      var tempMplay;
      tempMplay=findMusic(806)
      playMusic(tempMplay,0,0)
      var tBossTitle,bBarrier;
      bBarrier=instance_create(336,240,oBossBarrier)
      bBarrier=instance_create(736,240,oBossBarrier)
      tBossTitle=instance_create(0,0,oBossNameDisplay)
      tBossTitle.bossName="Blackmore"
      tBossTitle.bossTitle="?????"
      global.currentBoss="Blackmoor"
      viewFix=instance_create(544,176,oMisc)
      viewFix.type=0; viewFix.sprite_index=sNull
      view_object[0]=viewFix
      boss=instance_create(576,256,oBlackmoorMain)
      boss.activateBoss=1
      global.bossTrack=1
      storeStatus(0)
      sceneDelay=0; sceneProgress=0
    }
  }
  else if global.bossTrack=1
  {
    if sceneProgress=1 //End Boss
    {
      awardBossAP(2700)
      view_object[0]=oPlayer1
      with (344043) {instance_destroy()}
      with oMisc {instance_destroy()}
      with oBossBarrier {instance_destroy()}
      global.mapTeleport=0
      var tempMplay;
      tempMplay=findMusic(202)
      playMusic(tempMplay,0,0)
      global.currentBoss=""
      var tNewString;
      tNewString=string_delete(global.eGateProg,3,1)
      tNewString=string_insert("8",tNewString,3)
      global.eGateProg=tNewString
      bossCheck="8"
      sceneProgress=0
      global.bossTrack=0
    }
  }
}
else if room=rExtGateD_5 //----- [] Buggy collision things -----
{
  if sceneProgress=0
  {
    if oPlayer1.x<=256 and oPlayer1.y<=336
    {
      msgCreate(0,0,"Jerry","Those blocks have some wonky things going on when they appear on you.",0,2,oMessagePerson,0)
      newMessage.fadingTime=120
      sceneProgress+=1
    }
  }
  else if sceneProgress=1
  {
    sceneDelay+=1
    if sceneDelay=120
    {
      msgCreate(0,0,"Jeremy","Yay for wonky collision issues!",0,1,oMessagePerson,0)
      newMessage.fadingTime=70
    }
    else if sceneDelay=190
    {
      var tCheckAchieve;
      tCheckAchieve=string_char_at(global.tokenRecognitions,17)
      if tCheckAchieve="0"
      {
        var tAchievement;
        tAchievement=instance_create(0,0,oAchievementNotice)
        tAchievement.myAchievement="Wonky Block"; tAchievement.checkNum=17
      }
    }
  }
}
else if room=rExtGateD_6 //----- [D] Boss Fight: Elpizo -----
{
  if global.bossTrack=0 and bossCheck="7"
  {
    if sceneProgress=0 and oPlayer1.x>=352
    {
      sceneDelay+=1
      if sceneDelay=1 {global.gamePaused=true}
      oPlayer1.y+=4
      if oPlayer1.y>=416
      {
        oPlayer1.x=352; oPlayer1.y=416
        oPlayer1.sprite_index=sJerryIdle; oPlayer1.image_xscale=1
        stopPlayer()
        stopAllMusic()
        sceneDelay=0; sceneProgress+=1
      }
    }
    else if sceneProgress=1
    {
      sceneDelay+=1
      if sceneDelay>=30 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=2 and bWaitForInput=false
      msgCreate(0,0,"Elpizo","That's far enough, Jerry.",8,3,oMessageCutscene,1)
    else if sceneProgress=3 and bWaitForInput=false
      msgCreate(0,0,"Jerry","Whoa, hold up there! You can't be knowing my name!",0,3,oMessageCutscene,1)
    else if sceneProgress=4 and bWaitForInput=false
      msgCreate(0,0,"Elpizo","I've been instructed to keep everyone out of this place.",8,3,oMessageCutscene,1)
    else if sceneProgress=5 and bWaitForInput=false
      msgCreate(0,0,"Jerry","By who? Hex?",0,3,oMessageCutscene,1)
    else if sceneProgress=6
    {
      sceneDelay+=1
      if sceneDelay=10 {npcElpizo.sprite_index=sElpizoSwordDown}
      else if sceneDelay=15 {npcElpizo.image_index=1}
      else if sceneDelay=20 {npcElpizo.sprite_index=sElpizoIdle}
      else if sceneDelay>=30
      {
        var tempMplay;
        tempMplay=findMusic(812)
        playMusic(tempMplay,0,0)
        sceneDelay=0; sceneProgress+=1
      }
    }
    else if sceneProgress=7 and bWaitForInput=false
      msgCreate(0,0,"Elpizo","The soon to be master of this world. We can't have you getting in the way of its masterpiece.",8,3,oMessageCutscene,1)
    else if sceneProgress=8
    {
      global.gamePaused=false
      var tempMplay,tBossTitle,bBarrier;
      tempMplay=findMusic(812)
      playMusic(tempMplay,0,0)
      bBarrier=instance_create(112,320,oBossBarrier)
      bBarrier=instance_create(768,96,oBossBarrier)
      tBossTitle=instance_create(0,0,oBossNameDisplay)
      tBossTitle.bossName="Elpizo"
      tBossTitle.bossTitle="?????"
      global.currentBoss="Elpizo"
      with oMisc {instance_destroy()}
      boss=instance_create(448,416,oElpizo)
      boss.activateBoss=1
      global.bossTrack=1
      storeStatus(0)
      sceneDelay=0; sceneProgress=0
    }
  }
  else if global.bossTrack=1
  {
    if sceneProgress=1 //End Boss
    {
      awardBossAP(4300)
      with (344046) {instance_destroy()}
      with oBossBarrier {instance_destroy()}
      global.mapTeleport=0
      var tempMplay;
      tempMplay=findMusic(904)
      playMusic(tempMplay,0,0)
      global.currentBoss=""
      var tNewString;
      tNewString=string_delete(global.eGateProg,4,1)
      tNewString=string_insert("8",tNewString,4)
      global.eGateProg=tNewString
      bossCheck="8"
      sceneProgress=0
      global.bossTrack=0
    }
  }
}
else if room=rExtGateE_5 //----- [E] Boss Fight: Shadow Form -----
{
  if global.bossTrack=0 and bossCheck="7"
  {
    if sceneProgress=0 and oPlayer1.x>=272
    {
      sceneDelay+=1
      if sceneDelay=1 {global.gamePaused=true}
      oPlayer1.y+=4
      if oPlayer1.y>=304
      {
        scenePChk(272,304,0,0.1,1)
        npcShadow=instance_create(384,304,oMisc)
        npcShadow.sprite_index=sJerryIdle; npcShadow.image_speed=0; npcShadow.image_yscale=0.01
        npcShadow.image_xscale=-1; npcShadow.type=1; npcShadow.image_blend=c_black
        stopPlayer()
        sceneDelay=0; sceneProgress+=1
      }
    }
    else if sceneProgress=1
    {
      sceneDelay+=1
      if sceneDelay=10
      {
        viewFix=instance_create(oPlayer1.x,176,oMisc)
        viewFix.type=0; viewFix.sprite_index=sNull
        view_object[0]=viewFix
      }
      else if sceneDelay>=11 and sceneDelay<=999
      {
        viewFix.x+=1
        if viewFix.x>=328
        {
          viewFix.x=328
          sceneDelay=1000
        }
      }
      else if sceneDelay>=1030
      {
        var tempMplay;
        tempMplay=findMusic(808)
        playMusic(tempMplay,0,0)
        sceneDelay=0; sceneProgress+=1
      }
    }
    else if sceneProgress=2
    {
      var tFFScl,tEffect;
      for (i=0;i<5;i+=1)
      {
        tFFScl=random(0.1)
        tEffect=instance_create(npcShadow.x+random_range(-10,10),npcShadow.y-(random(52)*npcShadow.image_yscale),oEffectB)
        tEffect.type=3; tEffect.sprite_index=sEfFirefly; tEffect.newBlend=-1; tEffect.image_blend=c_black
        tEffect.image_xscale=0.1+tFFScl; tEffect.image_yscale=0.1+tFFScl
        tEffect.direction=random(360); tEffect.speed=random(0.25)+0.25; tEffect.friction=random(0.01)+0.01
        tEffect.AccelX=0; tEffect.AccelY=0; tEffect.followID=-1; tEffect.rotation=0; tEffect.fadeSpd=0.03
      }
      for(i=0;i<2;i+=1)
      {
        tEffect=instance_create(npcShadow.x+random_range(-14,14),npcShadow.y+random_range(-5,5),oEffectB)
        tEffect.type=3; tEffect.sprite_index=sEfFirefly; tEffect.newBlend=-1; tEffect.image_blend=c_black
        tEffect.image_xscale=0.1+tFFScl; tEffect.image_yscale=0.1+tFFScl
        tEffect.direction=random(360); tEffect.speed=random(0.25)+0.25; tEffect.friction=random(0.01)+0.01
        tEffect.AccelX=0; tEffect.AccelY=0; tEffect.followID=-1; tEffect.rotation=0; tEffect.fadeSpd=0.03
      }

      if npcShadow.image_yscale>=1
      {
        npcShadow.image_yscale=1
        sceneProgress+=1
      }
      else {npcShadow.image_yscale+=0.0018}
    }
    else if sceneProgress=3
    {
      sceneDelay+=1
      if sceneDelay>=30 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=4 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","I can't send it away this time.",0,3,oMessageCutscene,1)
    else if sceneProgress=5 and bWaitForInput=false
      msgCreate(0,0,"Jerry","I figured as much.",0,3,oMessageCutscene,1)
    else if sceneProgress=6
    {
      global.gamePaused=false
      var tempMplay,tBossTitle,bBarrier;
      tempMplay=findMusic(808)
      playMusic(tempMplay,0,0)
      bBarrier=instance_create(144,240,oBossBarrier)
      bBarrier=instance_create(496,208,oBossBarrier); bBarrier.image_yscale=1.5
      tBossTitle=instance_create(0,0,oBossNameDisplay)
      tBossTitle.bossName="Shadow Form"
      tBossTitle.bossTitle="?????"
      global.currentBoss="Shadow Form"
      with oMisc {instance_destroy()}
      viewFix=instance_create(328,176,oMisc)
      viewFix.type=0; viewFix.sprite_index=sNull
      view_object[0]=viewFix
      boss=instance_create(384,304,oShadowForm)
      boss.activateBoss=1
      global.bossTrack=1
      storeStatus(0)
      sceneDelay=0; sceneProgress=0
    }
  }
  else if global.bossTrack=1
  {
    if sceneProgress=1 //End Boss
    {
      awardBossAP(5000)
      view_object[0]=oPlayer1
      with (344047) {instance_destroy()}
      with oMisc {instance_destroy()}
      with oBossBarrier {instance_destroy()}
      global.mapTeleport=0
      var tempMplay;
      tempMplay=findMusic(11)
      playMusic(tempMplay,0,0)
      global.currentBoss=""
      var tNewString;
      tNewString=string_delete(global.eGateProg,5,1)
      tNewString=string_insert("8",tNewString,5)
      global.eGateProg=tNewString
      bossCheck="8"
      sceneProgress=0
      global.bossTrack=0
    }
  }
}
else if room=rExtGateF_3 //----- [] Advancing fire wall of doom -----
{
  if oPlayer1.x>=960 and bWallSpawn=0
  {
    var tFlash,tNewWall;
    tFlash=instance_create(0,0,oScreenFlash)
    tFlash.fadeSpeed=0.2
    background_blend[0]=make_color_rgb(210,200,200)
    tNewWall=instance_create(752,0,oAdvancingDeathWall)
    tNewWall.type=1
    tNewWall.xSpd=2
    tNewWall.xThres=16
    bWallSpawn=1
  }
}
else if room=rExtGateF_4 //----- [] Advancing fire wall of doom -----
{
  if oPlayer1.x>=288 and bWallSpawn=0
  {
    var tFlash,tNewWall;
    tFlash=instance_create(0,0,oScreenFlash)
    tFlash.fadeSpeed=0.2
    background_blend[0]=make_color_rgb(210,200,200)
    tNewWall=instance_create(0,0,oAdvancingDeathWall)
    tNewWall.type=1
    tNewWall.xSpd=7
    tNewWall.xThres=16
    bWallSpawn=1
  }
}
else if room=rExtGateF_6 //----- [F] Boss Fight: Nightmare -----
{
  if global.bossTrack=0 and bossCheck="7"
  {
    if sceneProgress=0 and oPlayer1.x>=160
    {
      sceneDelay+=1
      if sceneDelay=1 {global.gamePaused=true}
      oPlayer1.y+=4
      if oPlayer1.y>=432
      {
        scenePChk(160,432,0,0.1,1)
        stopPlayer()
        sceneDelay=0; sceneProgress+=1
      }
    }
    else if sceneProgress=1
    {
      sceneDelay+=1
      if sceneDelay=30 {boss=instance_create(320,576,oMetNightmare)}
      else if sceneDelay>=31
      {
        boss.y-=2
        if boss.y<=336 {sceneDelay=0; sceneProgress+=1}
      }
    }
    else if sceneProgress=2 and bWaitForInput=false
      msgCreate(0,0,"Jerry","Too many things named Nightmare.",0,3,oMessageCutscene,1)
    else if sceneProgress=3
    {
      global.gamePaused=false
      var tempMplay,tBossTitle,bBarrier;
      tempMplay=findMusic(817)
      playMusic(tempMplay,0,0)
      with (344050) {instance_destroy()}
      with oHealingPost {instance_destroy()}
      with oMetNightmare {instance_destroy()}
      with oNightmareParts {instance_destroy()}
      bBarrier=instance_create(48,368,oBossBarrier)
      bBarrier=instance_create(480,368,oBossBarrier)
      tBossTitle=instance_create(0,0,oBossNameDisplay)
      tBossTitle.bossName="Nightmare"
      tBossTitle.bossTitle="?????"
      global.currentBoss="Nightmare"
      boss=instance_create(320,336,oMetNightmare)
      boss.activateBoss=1
      global.bossTrack=1
      storeStatus(0)
      sceneDelay=0; sceneProgress=0
    }
  }
  else if global.bossTrack=1
  {
    if sceneProgress=1 //End Boss
    {
      awardBossAP(8000)
      view_object[0]=oPlayer1
      with oBossBarrier {instance_destroy()}
      oPlayer1.grav=1.2
      oGateF_GravControl.lowGravOn=0
      global.mapTeleport=0
      var tempMplay;
      tempMplay=findMusic(501)
      playMusic(tempMplay,0,0)
      global.currentBoss=""
      var tNewString;
      tNewString=string_delete(global.eGateProg,6,1)
      tNewString=string_insert("8",tNewString,6)
      global.eGateProg=tNewString
      bossCheck="8"
      sceneProgress=0
      global.bossTrack=0
    }
  }
}
else if room=rExtGateG_5 //----- [G] Boss Fight: Sephiroth -----
{
  if global.bossTrack=0 and bossCheck="7"
  {
    if sceneProgress=0 and oPlayer1.x>=320
    {
      sceneDelay+=1
      if sceneDelay=1 {global.gamePaused=true}
      oPlayer1.y+=4
      if oPlayer1.y>=288
      {
        newCamera=instance_create(320,176,oMisc)
        newCamera.type=0; newCamera.sprite_index=sNull
        view_object[0]=newCamera
        scenePChk(320,288,0,0.1,1)
        stopPlayer()
        sceneDelay=0; sceneProgress+=1
      }
    }
    else if sceneProgress=1
    {
      sceneDelay+=1
      if sceneDelay>=21 and sceneDelay<=52 {newCamera.x+=2}
      else if sceneDelay>=60 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=2
    {
      sceneDelay+=1
      if sceneDelay=30
      {
        instance_create(480,128,oSephiroth)
        oSephiroth.image_blend=c_black; oSephiroth.image_alpha=0
      }
      else if sceneDelay>=32 and sceneDelay<=90
      {
        if sceneDelay mod 2=0
        {
          oSephiroth.myDir[oSephiroth.lightRays]=random(360)
          oSephiroth.lightRays+=1
        }
      }
      else if sceneDelay=91
      {
        oSephiroth.image_alpha=1
        sephCol=0
      }
      else if sceneDelay>=92 and sceneDelay<=499
      {
        sephCol+=3
        oSephiroth.image_blend=make_color_rgb(sephCol,sephCol,sephCol)
        if sephCol>=255 {sceneDelay=500}
      }
      else if sceneDelay>=501 and sceneDelay<=520
      {
        oSephiroth.rayAlpha-=0.05
      }
      else if sceneDelay=540
      {
        var tempMplay;
        tempMplay=findMusic(820)
        playMusic(tempMplay,0,0)
      }
      else if sceneDelay>=570
      {
        oSephiroth.y+=1
        if oSephiroth.y>=288 {sceneDelay=0; sceneProgress+=1}
      }
    }
    else if sceneProgress=3
    {
      sceneDelay+=1
      if sceneDelay>=30 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=4 and bWaitForInput=false
      msgCreate(0,0,"Jerry","This isn't going to be a dance off, is it?",0,3,oMessageCutscene,1)
    else if sceneProgress=5
    {
      sceneDelay+=1
      if sceneDelay=20
      {
        oSephiroth.sprite_index=sSeph_FlipOff
        global.recBirdsSeen+=1
      }
      else if sceneDelay=24 {oSephiroth.image_index=1}
      else if sceneDelay>=40 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=6 and bWaitForInput=false
      msgCreate(0,0,"Jerry","I guess not.",0,3,oMessageCutscene,1)
    else if sceneProgress=7
    {
      global.gamePaused=false
      var tempMplay,tBossTitle,bBarrier,viewFix;
      viewFix=instance_create(384,176,oMisc)
      viewFix.type=0; viewFix.sprite_index=sNull
      view_object[0]=viewFix
      tempMplay=findMusic(820)
      playMusic(tempMplay,0,0)
      with oSephiroth {instance_destroy()}
      bBarrier=instance_create(160,-32,oBossBarrier); bBarrier.image_yscale=18
      bBarrier=instance_create(592,-32,oBossBarrier); bBarrier.image_yscale=18
      tBossTitle=instance_create(0,0,oBossNameDisplay)
      tBossTitle.bossName="Sephiroth"
      tBossTitle.bossTitle="?????"
      global.currentBoss="Sephiroth"
      boss=instance_create(480,288,oSephiroth)
      boss.activateBoss=1
      global.bossTrack=1
      storeStatus(0)
      sceneDelay=0; sceneProgress=0
    }
  }
  else if global.bossTrack=1
  {
    if sceneProgress=1 //End Boss
    {
      awardBossAP(13500)
      with (346672) {instance_destroy()}
      with oBossBarrier {instance_destroy()}
      view_object[0]=oPlayer1
      global.mapTeleport=0
      var tempMplay;
      tempMplay=findMusic(905)
      playMusic(tempMplay,0,0)
      global.currentBoss=""
      var tNewString;
      tNewString=string_delete(global.eGateProg,7,1)
      tNewString=string_insert("8",tNewString,7)
      global.eGateProg=tNewString
      bossCheck="8"
      sceneProgress=0
      global.bossTrack=0
    }
  }
}
else if room=rSacredTemple //------------------------------ Exit door spawn ------------------------------
{
  if instrStory=0 //----- [1] First time in the temple -----
  {
    if sceneProgress=0
    {
      sceneDelay+=1
      if sceneDelay=1 {global.gamePaused=true}
      else if sceneDelay>=20 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=1 and bWaitForInput=false
      msgCreate(0,0,"Jerry","What? ... What is this place?",0,3,oMessageCutscene,1)
    else if sceneProgress=2 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","Not sure... Chao?",0,3,oMessageCutscene,1)
    else if sceneProgress=3 and bWaitForInput=false
      msgCreate(0,0,"Chao","I couldn't see or feel it until we came through the door.",0,3,oMessageCutscene,1)
    else if sceneProgress=4 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","Whatever this is, it was really well hidden and encrypted. Whoever built this place didn't want anyone finding it.",0,3,oMessageCutscene,1)
    else if sceneProgress=5 and bWaitForInput=false
      msgCreate(0,0,"Claire","Should we even be here then?",0,3,oMessageCutscene,1)
    else if sceneProgress=6 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","I say look around, who knows what you'll find in here.",0,3,oMessageCutscene,1)
    else if sceneProgress=7 and bWaitForInput=false
      msgCreate(0,0,"Jerry","Is it even safe?",0,3,oMessageCutscene,1)
    else if sceneProgress=8 and bWaitForInput=false
      msgCreate(0,0,"Chao","There are no hostiles in the area. No pitfalls, and no traps. It's completely safe.",0,3,oMessageCutscene,1)
    else if sceneProgress=9 and bWaitForInput=false
      msgCreate(0,0,"Jerry","IMPOSSIBLE!!",0,3,oMessageCutscene,1)
    else if sceneProgress=10
    {
      sceneDelay=0; sceneProgress=0
      instrStory=10
      global.gamePaused=false
    }
  }
  else if instrStory=1 //----- [2] Second time in the temple -----
  {
    if sceneProgress=0
    {
      sceneDelay+=1
      if sceneDelay=1 {global.gamePaused=true}
      else if sceneDelay>=20 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=1 and bWaitForInput=false
      msgCreate(0,0,"Claire","This place again...",0,3,oMessageCutscene,1)
    else if sceneProgress=2 and bWaitForInput=false
      msgCreate(0,0,"Jerry","Still don't have any idea what this place is?",0,3,oMessageCutscene,1)
    else if sceneProgress=3 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","Not a clue. What about you, Chao?",0,3,oMessageCutscene,1)
    else if sceneProgress=4 and bWaitForInput=false
      msgCreate(0,0,"Chao","Just as clueless.",0,3,oMessageCutscene,1)
    else if sceneProgress=5 and bWaitForInput=false
      msgCreate(0,0,"Claire","I wonder if one of those instruments will be here again.",0,3,oMessageCutscene,1)
    else if sceneProgress=6
    {
      sceneDelay=0; sceneProgress=0
      instrStory=10
      global.gamePaused=false
    }
  }
  else if instrStory=2 //----- [3] Third time in the temple -----
  {
    if sceneProgress=0
    {
      sceneDelay+=1
      if sceneDelay=1 {global.gamePaused=true}
      else if sceneDelay>=20 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=1 and bWaitForInput=false
      msgCreate(0,0,"Jerry","Another instrument, another piece of that message.",0,3,oMessageCutscene,1)
    if global.gameProgress>=2550
    {
      if sceneProgress=2 and bWaitForInput=false
        msgCreate(0,0,"Jeremy","Something about a great beast... Very sure it's talking about the Abomination.",0,3,oMessageCutscene,1)
    }
    else
    {
      if sceneProgress=2 and bWaitForInput=false
        msgCreate(0,0,"Jeremy","Something about a great beast... Not sure what that's about though.",0,3,oMessageCutscene,1)
    }
    if sceneProgress=3
    {
      sceneDelay=0; sceneProgress=0
      instrStory=10
      global.gamePaused=false
    }
  }
  else if instrStory=3 //----- [4] Fourth time in the temple -----
  {
    if sceneProgress=0
    {
      sceneDelay+=1
      if sceneDelay=1 {global.gamePaused=true}
      else if sceneDelay>=20 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=1 and bWaitForInput=false
      msgCreate(0,0,"Jerry","I enjoy that this place is so calm, especially after what we have to go through to get here.",0,3,oMessageCutscene,1)
    else if sceneProgress=2 and bWaitForInput=false
      msgCreate(0,0,"Claire","It is nice to get a short break now and then.",0,3,oMessageCutscene,1)
    else if sceneProgress=3
    {
      sceneDelay=0; sceneProgress=0
      instrStory=10
      global.gamePaused=false
    }
  }
  else if instrStory=4 //----- [5] Fifth time in the temple -----
  {
    if sceneProgress=0
    {
      sceneDelay+=1
      if sceneDelay=1 {global.gamePaused=true}
      else if sceneDelay>=20 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=1 and bWaitForInput=false
      msgCreate(0,0,"Claire","Do you think Hex knows about this place?",0,3,oMessageCutscene,1)
    else if sceneProgress=2 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","Would it matter much?",0,3,oMessageCutscene,1)
    else if sceneProgress=3 and bWaitForInput=false
      msgCreate(0,0,"Claire","I guess not, though I wonder if he knows anything about these instruments.",0,3,oMessageCutscene,1)
    else if sceneProgress=4 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","I don't think he does, let's keep it that way. Maybe the instruments will help us.",0,3,oMessageCutscene,1)
    else if sceneProgress=5
    {
      sceneDelay=0; sceneProgress=0
      instrStory=10
      global.gamePaused=false
    }
  }
  else if instrStory=5 //----- [6] Sixth time in the temple -----
  {
    if sceneProgress=0
    {
      sceneDelay+=1
      if sceneDelay=1 {global.gamePaused=true}
      else if sceneDelay>=20 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=1 and bWaitForInput=false
      msgCreate(0,0,"Claire","I wonder if we'll be waking anything up with these instruments.",0,3,oMessageCutscene,1)
    else if sceneProgress=2 and bWaitForInput=false
      msgCreate(0,0,"Jerry","It's weird, I want to say something to counter that statement simply to upset you, but I can't think of anything so... your face.",0,3,oMessageCutscene,1)
    else if sceneProgress=3 and bWaitForInput=false
      msgCreate(0,0,"Claire","no u!",0,3,oMessageCutscene,1)
    else if sceneProgress=4 and bWaitForInput=false
      msgCreate(0,0,"Jerry","How did you do that with the text?",0,3,oMessageCutscene,1)
    else if sceneProgress=5 and bWaitForInput=false
      msgCreate(0,0,"Claire","Stop breaking the 4th wall.",0,3,oMessageCutscene,1)
    else if sceneProgress=6
    {
      sceneDelay=0; sceneProgress=0
      instrStory=10
      global.gamePaused=false
    }
  }
  else if instrStory=6 //----- [7] Seventh time in the temple -----
  {
    if sceneProgress=0
    {
      sceneDelay+=1
      if sceneDelay=1 {global.gamePaused=true}
      else if sceneDelay>=20 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=1 and bWaitForInput=false
      msgCreate(0,0,"Claire","One more instrument after this.",0,3,oMessageCutscene,1)
    else if sceneProgress=2 and bWaitForInput=false
      msgCreate(0,0,"Jerry","Yeah, getting there.",0,3,oMessageCutscene,1)
    else if sceneProgress=3
    {
      sceneDelay=0; sceneProgress=0
      instrStory=10
      global.gamePaused=false
    }
  }
  else if instrStory=7 //----- [8] Eighth (Final) time in the temple -----
  {
    if sceneProgress=0
    {
      sceneDelay+=1
      if sceneDelay=1
      {
        abilSetRemove(0)
        global.bCanForceGO=1
        global.bCanSave=1
        global.charScan[0]=1; global.charScan[1]=1
        if global.optShowHUD>2 {global.optShowHUD-=2}
        global.gamePaused=true
      }
      else if sceneDelay>=40 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=1 and bWaitForInput=false
      msgCreate(0,0,"Claire","Were any of you able to see that?",0,3,oMessageCutscene,1)
    else if sceneProgress=2 and bWaitForInput=false
      msgCreate(0,0,"Jerry","Yeah... Sorry, Claire.",0,3,oMessageCutscene,1)
    else if sceneProgress=3 and bWaitForInput=false
      msgCreate(0,0,"Claire","It's okay, those days are over. And you already knew about most of that.",0,3,oMessageCutscene,1)
    else if sceneProgress=4 and bWaitForInput=false
      msgCreate(0,0,"Jerry","Yeah.",0,3,oMessageCutscene,1)
    else if sceneProgress=5 and bWaitForInput=false
      msgCreate(0,0,"Claire","It's fine. I'm more annoyed right now that the program was able to pull up a memory like that. Let's just get that last Instrument.",0,3,oMessageCutscene,1)
    else if sceneProgress=6 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","Speaking of. Do you know where to bring those?",0,3,oMessageCutscene,1)
    else if sceneProgress=7 and bWaitForInput=false
      msgCreate(0,0,"Jerry","Yeah, it shouldn't be too hard to figure it out at this point.",0,3,oMessageCutscene,1)
    else if sceneProgress=8 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","As far as using them, you just need to bring them over to it and the song should play on its own.",0,3,oMessageCutscene,1)
    else if sceneProgress=9 and bWaitForInput=false
      msgCreate(0,0,"Claire","I have a feeling that thing is part of a back up plan by Hex.",0,3,oMessageCutscene,1)
    else if sceneProgress=10 and bWaitForInput=false
      msgCreate(0,0,"Chao","Been thinking that too.",0,3,oMessageCutscene,1)
    else if sceneProgress=11 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","It's your choice on whether or not you want to do that. Every minute we spend on other things is more time that Warship is in the sky.",0,3,oMessageCutscene,1)
    else if sceneProgress=12
    {
      sceneDelay=0; sceneProgress=0
      instrStory=10
      global.gateHProg=100
      global.gamePaused=false
    }
  }

  //----- Exit creation after instrument is obtained
  if exitCreate=0
  {
    if !instance_exists(instrObj)
    {
      newExit=instance_create(1008,1520,oExit)
      newExit.bShowArrow=true; newExit.image_xscale=2; newExit.exitType=0
      newExit.newArrowPosX=8; newExit.newArrowPosY=-4
      newExit.newMapX=240; newExit.newMapY=416; newExit.toRoom=rMain_19
      exitCreate=1
    }
  }
}

keyWaitForInput()
if oKeyCodes.kCodePressed[11]=1 and global.gamePaused=true //Cutscene skip
{
  if !instance_exists(oPauseMenu)
  {
    if room=rExtGateA_6 //[A]
    {
      if global.bossTrack=0
      {
        bWaitForInput=false
        with oMessageCutscene {instance_destroy()}
        sceneDelay=0; sceneProgress=9
      }
    }
    else if room=rExtGateB_6 //[B]
    {
      if global.bossTrack=0
      {
        bWaitForInput=false
        with oMessageCutscene {instance_destroy()}
        sceneDelay=0; sceneProgress=14
      }
    }
    else if room=rExtGateC_5 //[C]
    {
      if global.bossTrack=0
      {
        bWaitForInput=false
        with oMessageCutscene {instance_destroy()}
        sceneDelay=0; sceneProgress=5
      }
    }
    else if room=rExtGateD_6 //[D]
    {
      if global.bossTrack=0
      {
        bWaitForInput=false
        with oMessageCutscene {instance_destroy()}
        with oMisc {instance_destroy()}
        oPlayer1.x=352; oPlayer1.y=416
        sceneDelay=0; sceneProgress=8
      }
    }
    else if room=rExtGateE_5 //[E]
    {
      if global.bossTrack=0
      {
        bWaitForInput=false
        with oMessageCutscene {instance_destroy()}
        with oMisc {instance_destroy()}
        oPlayer1.x=272; oPlayer1.y=304
        sceneDelay=0; sceneProgress=6
      }
    }
    else if room=rExtGateF_6 //[F]
    {
      if global.bossTrack=0
      {
        bWaitForInput=false
        with oMessageCutscene {instance_destroy()}
        oPlayer1.x=160; oPlayer1.y=432
        sceneDelay=0; sceneProgress=3
      }
    }
    else if room=rExtGateG_4 //[G]
    {
      if global.bossTrack=0
      {
        bWaitForInput=false
        with oMessageCutscene {instance_destroy()}
        oPlayer1.x=288; oPlayer1.y=288
        sceneDelay=0; sceneProgress=6
      }
    }
    else if room=rSacredTemple
    {
      if instrStory=0 //[1]
      {
        bWaitForInput=false
        with oMessageCutscene {instance_destroy()}
        sceneDelay=0; sceneProgress=10
      }
      else if instrStory=1 //[2]
      {
        bWaitForInput=false
        with oMessageCutscene {instance_destroy()}
        sceneDelay=0; sceneProgress=6
      }
      else if instrStory=2 //[3]
      {
        bWaitForInput=false
        with oMessageCutscene {instance_destroy()}
        sceneDelay=0; sceneProgress=3
      }
      else if instrStory=3 //[4]
      {
        bWaitForInput=false
        with oMessageCutscene {instance_destroy()}
        sceneDelay=0; sceneProgress=3
      }
      else if instrStory=4 //[5]
      {
        bWaitForInput=false
        with oMessageCutscene {instance_destroy()}
        sceneDelay=0; sceneProgress=5
      }
      else if instrStory=5 //[6]
      {
        bWaitForInput=false
        with oMessageCutscene {instance_destroy()}
        sceneDelay=0; sceneProgress=6
      }
      else if instrStory=6 //[7]
      {
        bWaitForInput=false
        with oMessageCutscene {instance_destroy()}
        sceneDelay=0; sceneProgress=3
      }
      else if instrStory=7 //[8]
      {
        bWaitForInput=false
        with oMessageCutscene {instance_destroy()}
        sceneDelay=0; sceneProgress=12
      }
    }
  }
}

//Map Events
if room=rExtGateE_1 //Slightly faster Dash Energy recovery
{
  if global.gamePaused=false
  {
    if oPlayer1.dashEnergy<oPlayer1.dashMeterMax-3 {oPlayer1.dashEnergy+=3}
  }
}
else if room=rExtGateB_6 //Subtle background color change
{
  bgSeq+=1
  if bgSeq>=1 and bgSeq<=60 {bgCol+=0.1}
  else if bgSeq>=61 and bgSeq<=120
  {
    bgCol-=0.1
    if bgSeq=120 {bgSeq=0}
  }
  background_color=make_color_rgb(bgCol,bgCol,bgCol)
}
else if room=rExtGateE_3 //Create new platforms and color zones
{
  if sceneProgress=0
  {
    if (258682).bMoving=1
    {
      colorControl=instance_create(0,0,oColorIndControl)
      colorControl.warnDelay=90

      var tTouchPlat;
      tTouchPlat=instance_create(32,240,oPlatformTouch)
      with tTouchPlat
      {
        moveSpeedX=3; moveSpeedY=0; bMoving=1
        drawType=1; platColor=make_color_rgb(170,170,255)
        sprite_index=sScaledCollision; image_xscale=64; image_yscale=8
      }
      tTouchPlat=instance_create(160,240,oPlatformTouch)
      with tTouchPlat
      {
        moveSpeedX=3; moveSpeedY=0; bMoving=1
        drawType=1; platColor=make_color_rgb(170,170,255)
        sprite_index=sScaledCollision; image_xscale=64; image_yscale=8
      }
      tTouchPlat=instance_create(96,304,oPlatformTouch)
      with tTouchPlat
      {
        moveSpeedX=3; moveSpeedY=0; bMoving=1
        drawType=1; platColor=make_color_rgb(170,170,255)
        sprite_index=sScaledCollision; image_xscale=64; image_yscale=8
      }
      oColorZone.visible=1; oColorZone.moveSpd=3; oColorZone.moveDelay=1000000
      sceneProgress=1
    }
  }
}
else if room=rExtGateE_4 //----- Enemy Trap -----
{
  if sceneProgress=0
  {
    if oPlayer1.x>=816
    {
      enemyCounter=instance_create(0,0,oEnemyRemain)
      enemyCounter.enemyCount=4
      enemyBarrier=instance_create(640,48,oEnemyBarrier); enemyBarrier.image_yscale=9
      enemyBarrier=instance_create(976,208,oEnemyBarrier); enemyBarrier.image_yscale=6
      createEnemy(816,112,oUselessData,2,1,1)
      createEnemy(704,256,oUselessData,2,1,1)
      createEnemy(928,256,oUselessData,2,1,1)
      createEnemy(816,272,oUselessData,2,1,1)
      sceneProgress+=1
    }
  }
  else if sceneProgress=1
  {
    if oEnemyRemain.enemyCount<=0
    {
      with oEnemyRemain {instance_destroy()}
      with oEnemyBarrier {instance_destroy()}
      sceneProgress+=1
    }
  }
}
else if room=rExtGateG_1 or room=rExtGateG_2 or room=rExtGateG_3 or room=rExtGateG_4 //----- Background Islands -----
{
  backIsleSpawn-=1
  if backIsleSpawn<=0
  {
    var tSpawnZone;
    if room=rExtGateG_3 {tSpawnZone=view_yview[0]+384}
    else {tSpawnZone=room_height+48}
    instance_create(random_range(view_xview[0]-128,view_xview[0]+view_wview[0]+128),tSpawnZone,oGG_BackIsle)
    backIsleSpawn=40+irandom(30)
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

if room=rExtGateG_2 //Gate G - Map 2 Map
{
  if mapTime>=30
  {
    draw_sprite(sGG_M2Map,0,view_xview[0]+240,view_yview[0]+96)
  }
}
