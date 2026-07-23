#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//----- Gate 2: Hyrule -----
event_inherited()
enemyCount=-1
fadeColor=c_white
if global.gameProgress=1150
  fadeAlpha=1
else
  fadeAlpha=0

if global.gameProgress=1270 and room=rBelmont3_3D
{
  bWallSpawn=0
}

if room=rBelmont3_4F //Achievement
{
  if global.newMapX=48 {myAchProg=0}
  else {myAchProg=100}
}

if room=rBelmont3_4E or room=rBelmont3_4G or room=rBelmont3_4H or room=rBelmont3_6E
{
  gameProgCheck=string_char_at(global.gameGate3Prog,1)
  if room=rBelmont3_6E
  {
    if gameProgCheck="0" or gameProgCheck="1" or gameProgCheck="2"
    {
      gameProgCheck="3"
      var tNewString;
      tNewString=string_delete(global.gameGate3Prog,1,1)
      tNewString=string_insert("3",tNewString,1)
      global.gameGate3Prog=tNewString
    }
  }
}
if room=rBelmont3_4C or room=rBelmont3_4I or room=rBelmont3_6A or room=rBelmont3_6F
{
  gameProgCheck=string_char_at(global.gameGate3Prog,2)
  if room=rBelmont3_6A or room=rBelmont3_6F
  {
    if gameProgCheck="0" or gameProgCheck="1"
    {
      gameProgCheck="2"
      var tNewString;
      tNewString=string_delete(global.gameGate3Prog,2,1)
      tNewString=string_insert("2",tNewString,2)
      global.gameGate3Prog=tNewString
    }
  }

  if room=rBelmont3_6A
  {
    if gameProgCheck="3"
    {
      gameProgCheck="4"
      var tNewString;
      tNewString=string_delete(global.gameGate3Prog,2,1)
      tNewString=string_insert("4",tNewString,2)
      global.gameGate3Prog=tNewString
    }
  }
  else if room=rBelmont3_6F
  {
    var i;
    for(i=182816;i<182826;i+=1)
    {
      (i).y-=1024
    }
  }
}

backGBlend=0
if global.bossTrack=1 and room=rBelmont3_6C //Menace background
{
  backFol=instance_create(0,0,oBackgroundFollow)
  backFol.type=0
  backFol.backSet=backCV_Menace
  backFol.wSize=480
  backFol.hSize=352
  backCChg=255
  backCTime=0
  backGBlend=1
}

if room=rBelmont3_7C
{
  if global.gameProgress<=1490
  {
    (184752).y-=1024
  }
}
if room=rBelmont3_7G
{
  transWidth=0
  transAlpha=0.5
  musicCheck=0
  circleRad=0
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gameProgress=1150 and room=rBelmont3_Gate //----- [1] Intro to Transylvania - Ch.6 -----
{
  if sceneProgress=0
  {
    sceneDelay+=1
    if sceneDelay=1
    {
      charSwitcher(1)
      scenePChk(192,160,1,0.1,1)
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
    if sceneDelay=35
    {
      efCharge=instance_create(oPlayer1.x,oPlayer1.y-26,oMisc)
      efCharge.sprite_index=sMMcharging; efCharge.image_speed=0.5; efCharge.depth=15
      efCharge.type=1; efCharge.image_xscale=4; efCharge.image_yscale=4

      for(i=0;i<4;i+=1)
      {
        efStars[i]=instance_create(oPlayer1.x,oPlayer1.y-26,oMisc)
        efStars[i].sprite_index=sMMcharging; efStars[i].image_speed=0.5
        efStars[i].depth=15; efStars[i].type=1
        efStars[i].image_alpha=0.4-(0.075*i); efStars[i].image_xscale=1+i; efStars[i].image_yscale=1+i
      }
    }
    else if sceneDelay>=41 and sceneDelay<=79
    {
      for(i=0;i<4;i+=1)
      {
        if i mod 2=0 {efStars[i].image_angle+=2*(i*2)}
        else {efStars[i].image_angle-=2*(i*2)}
      }
      efCharge.image_xscale-=0.1; efCharge.image_yscale-=0.1
    }
    else if sceneDelay=80
    {
      with efCharge {instance_destroy()}
    }
    else if sceneDelay=95
    {
      abilNotice=instance_create(oPlayer1.x,oPlayer1.y-26,oMisc)
      abilNotice.sprite_index=sAN_Simon; abilNotice.depth=15; abilNotice.type=1
      abilNotice.image_xscale=4; abilNotice.image_yscale=4; abilNotice.image_alpha=0.75
    }
    else if sceneDelay>=96 and sceneDelay<134
    {
      abilNotice.image_xscale-=0.1; abilNotice.image_yscale-=0.1
    }
    else if sceneDelay=135
    {
      with abilNotice {instance_destroy()}
    }
    else if sceneDelay=140
    {
      var tEffect;
      tEffect=instance_create(oPlayer1.x,oPlayer1.y-26,oEffect)
      tEffect.sprite_index=sMMchargeComplete; tEffect.image_xscale=3; tEffect.image_yscale=3
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
      with oMisc {instance_destroy()}
      sceneDelay=0
      sceneProgress+=1
    }
    else if sceneDelay=150 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=2 and bWaitForInput=false
  {
    playSound(global.snd_NewAbilitySet,0,1,1)
    msgCreate(112,128,"","Claire gained the Belmont Ability Set!#She can now wield some of the Belmont abilities.",6,2,oMessageCutscene,1)
  }
  else if sceneProgress=3
  {
    sceneDelay+=1
    if sceneDelay>=20 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Claire","I finally get to do something.",0,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Aside from complain?",0,3,oMessageCutscene,1)
  else if sceneProgress=6 and bWaitForInput=false
    msgCreate(0,0,"Claire","I have NOT!",0,3,oMessageCutscene,1)
  else if sceneProgress=7 and bWaitForInput=false
    msgCreate(0,0,"Jerry","You sure about that?",0,3,oMessageCutscene,1)
  else if sceneProgress=8 and bWaitForInput=false
    msgCreate(0,0,"Claire","Okay, I've complained a little bit.",0,3,oMessageCutscene,1)
  else if sceneProgress=9 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Every step of the way.",0,3,oMessageCutscene,1)
  else if sceneProgress=10 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","This is going to happen every time isn't it?",0,3,oMessageCutscene,1)
  else if sceneProgress=11 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Probably.",0,3,oMessageCutscene,1)
  else if sceneProgress=12 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Well the objective this time is much more straight forward than the last Gate.",0,3,oMessageCutscene,1)
  else if sceneProgress=13 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Good, Claire can't handle anything more complicated than reading a recipe.",0,3,oMessageCutscene,1)
  else if sceneProgress=14 and bWaitForInput=false
    msgCreate(0,0,"Claire","Says the guy who can't follow simple baking instructions.",0,3,oMessageCutscene,1)
  else if sceneProgress=15 and bWaitForInput=false
    msgCreate(0,0,"Chao","Ouch.",0,3,oMessageCutscene,1)
  else if sceneProgress=16 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Alrighty, all you gotta do is get through Dracula's castle and defeat him. That's all I can see that is locking this place down anyway.",0,3,oMessageCutscene,1)
  else if sceneProgress=17 and bWaitForInput=false
    msgCreate(0,0,"Claire","I see early Castlevania tiles, it's anything but simple.",0,3,oMessageCutscene,1)
  else if sceneProgress=18 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Well good luck.",0,3,oMessageCutscene,1)
  else if sceneProgress=19 and bWaitForInput=false
    msgCreate(0,0,"Chao","You can do it Claire.",0,3,oMessageCutscene,1)
  else if sceneProgress=20
  {
    sceneDelay=0; sceneProgress=0
    var tNewChapter;
    tNewChapter=instance_create(0,0,oChapterDisplay)
    tNewChapter.newChapter="Chapter 6#Clairvoyance"
    global.canCharSwap=1
    global.hasAbilToken[2]=2
    global.activeAbility[1]=1
    global.gameProgress=1160
    global.gamePaused=false
  }
}
else if global.gameProgress=1170 and room=rBelmont3_1B //----- [Unskippable] Enemy Trap -----
{
  if global.gamePaused=false
  {
    if sceneProgress=0
    {
      if oPlayer1.x>=1328
      {
        var enemyCounter,enemyBarrier;
        enemyCounter=instance_create(0,0,oEnemyRemain)
        enemyCounter.enemyCount=2

        enemyBarrier=instance_create(1168,-16,oEnemyBarrier); enemyBarrier.image_yscale=16
        enemyBarrier=instance_create(1472,-16,oEnemyBarrier); enemyBarrier.image_yscale=16
        sceneProgress+=1
      }
    }
    else if sceneProgress=1
    {
      sceneDelay+=1
      if sceneDelay=30
      {
        delaySpawn(1200,304,oCV_BonePillar,2,1,1,0.33)
        delaySpawn(1456,304,oCV_BonePillar,2,1,1,0.33)
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
        global.gameProgress=1180
      }
    }
  }
}
else if global.gameProgress=1180 and room=rBelmont3_1C //----- [Unskippable] Boss Fight: Large Vampire Bat -----
{
  if global.bossTrack=0
  {
    if sceneProgress=0 and oPlayer1.x>=1808
    {
      viewFix=instance_create(1808,176,oMisc)
      viewFix.type=0
      viewFix.sprite_index=sNull
      view_object[0]=viewFix
      sceneProgress+=1
    }
    else if sceneProgress=1
    {
      var bBarrier,tBossTitle,tempMplay;
      bBarrier=instance_create(1552,0,oBossBarrier)
      bBarrier.image_yscale=5.5
      bBarrier=instance_create(1984,176,oBossBarrier)
      boss=instance_create(1876,144,oLargeVampireBat)
      boss.activateBoss=1
      tBossTitle=instance_create(0,0,oBossNameDisplay)
      tBossTitle.bossName="Large Vampire Bat"
      tBossTitle.bossTitle="Vampire Bat That Is Large"
      global.currentBoss="Vampire Bat"
      global.bossTrack=1
      storeStatus(0)
      tempMplay=findMusic(824)
      playMusic(tempMplay,0,0)
      sceneProgress=0
    }
  }
  else if global.bossTrack=1
  {
    if sceneProgress=1 //End Boss
    {
      view_object[0]=oPlayer1
      with oMisc {instance_destroy()}
      var tFullHeartDrop;
      tFullHeartDrop=instance_create(1744,112,oHealthPickup)
      tFullHeartDrop.sprite_index=sFullHealthPickup
      awardBossAP(1100)
      var tempMplay;
      tempMplay=findMusic(301)
      playMusic(tempMplay,0,0)
      with oBossBarrier {instance_destroy()}
      sceneProgress=0
      global.currentBoss=""
      global.bossTrack=0
      global.gameProgress=1190
    }
  }
}
else if global.gameProgress=1200 and room=rBelmont3_2B //----- [2] After grabbing Dagger -----
{
  if sceneProgress=0 and !instance_exists(oStoryObject)
  {
    sceneDelay+=1
    if sceneDelay=1 {global.gamePaused=true}
    else if sceneDelay>=2
    {
      oPlayer1.y+=4
      if oPlayer1.y>=288
      {
        scenePChk(oPlayer1.x,288,0,0.1,1)
        sceneDelay=0; sceneProgress+=1
      }
    }
  }
  else if sceneProgress=1
  {
    sceneDelay+=1
    if sceneDelay>=60 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","This will definitely come in handy here. To use that, press 'Action Button B.'",0,3,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Claire","Finally got a ranged weapon. I'm gonna put this to good use.",0,3,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","The big benefit of that is the damage is actually pretty good. While it doesn't have the arc advantage of Jerry's arrows, it deals more damage and the projectile velocity is super fast.",0,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Claire","Works for me!",0,3,oMessageCutscene,1)
  else if sceneProgress=6
  {
    var tNewTutorial;
    tNewTutorial=instance_create(0,0,oTutorialPanel)
    tNewTutorial.tutorialTitle="Heart Points"
    tNewTutorial.tutorialInfo="When using a special weapon in the Belmont Ability Set, it consumes Heart Points, which recover automatically."
    tNewTutorial.scrAreaY=0
    sceneDelay=0; sceneProgress=0
    global.hasAbilToken[2]=3
    global.gameProgress=1210
    global.gamePaused=false
  }
}
else if global.gameProgress=1210 and room=rBelmont3_2D //----- [Unskippable] Enemy Trap -----
{
  if global.gamePaused=false
  {
    if sceneProgress=0
    {
      if oPlayer1.x>=2128
      {
        var enemyCounter,enemyBarrier;
        enemyCounter=instance_create(0,0,oEnemyRemain)
        enemyCounter.enemyCount=2

        enemyBarrier=instance_create(1904,0,oEnemyBarrier); enemyBarrier.image_yscale=22
        enemyBarrier=instance_create(2336,0,oEnemyBarrier); enemyBarrier.image_yscale=22
        createEnemy(1984,288,oCV_AxeKnight,2,1,1)
        createEnemy(2276,288,oCV_AxeKnight,2,1,1)
        sceneProgress+=1
      }
    }
    else if sceneProgress=1
    {
      if oEnemyRemain.enemyCount<=0
      {
        with oEnemyRemain {instance_destroy()}
        with oEnemyBarrier {instance_destroy()}
        sceneProgress=0
        global.gameProgress=1220
      }
    }
  }
}
else if global.gameProgress=1220 and room=rBelmont3_2D //----- [3] Meet Death - first time -----
{
  if sceneProgress=0 and oPlayer1.x>=2704
  {
    sceneDelay+=1
    if sceneDelay=1
    {
      with oCV_MedusaHead {instance_destroy()}
      global.gamePaused=true
    }
    else if sceneDelay>=2
    {
      oPlayer1.y+=4
      if oPlayer1.y>=224
      {
        scenePChk(oPlayer1.x,224,0,0.1,1)
        sceneDelay=0; sceneProgress+=1
      }
    }
  }
  else if sceneProgress=1
  {
    sceneDelay+=1
    if sceneDelay>=60 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"?????","Trying to cause us problems I see.",8,3,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Claire","Who's there?",0,3,oMessageCutscene,1)
  else if sceneProgress=4
  {
    sceneDelay+=1
    if sceneDelay=20
    {
      var tFlash;
      tFlash=instance_create(0,0,oScreenFlash)
      tFlash.fadeSpeed=0.2
      npcDeath=instance_create(2800,192,oMisc)
      npcDeath.sprite_index=sDeathIdle; npcDeath.image_speed=0.15
      npcDeath.image_blend=c_black; npcDeath.type=2
      tColor=0
    }
    else if sceneDelay>=65 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Chao","I have a really bad feeling about this.",0,3,oMessageCutscene,1)
  else if sceneProgress=6 and bWaitForInput=false
    msgCreate(0,0,"?????","That you should...",8,3,oMessageCutscene,1)
  else if sceneProgress=7
  {
    sceneDelay+=1
    if sceneDelay>=11 and sceneDelay<=61
    {
      tColor+=5
      npcDeath.image_blend=make_color_rgb(tColor,tColor,tColor)
    }
    else if sceneDelay>=90 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=8 and bWaitForInput=false
    msgCreate(0,0,"Death","For you look upon Death itself.",8,3,oMessageCutscene,1)
  else if sceneProgress=9 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Oh have fun with this guy Claire, there won't be any stun locking with Holy Water this time.",0,3,oMessageCutscene,1)
  else if sceneProgress=10 and bWaitForInput=false
    msgCreate(0,0,"Claire","Jerry, that was YOU that used that method.",0,3,oMessageCutscene,1)
  else if sceneProgress=11 and bWaitForInput=false
    msgCreate(0,0,"Jerry","...",0,3,oMessageCutscene,1)
  else if sceneProgress=12 and bWaitForInput=false
    msgCreate(0,0,"Death","Turn back and maybe we can let you exist.",8,3,oMessageCutscene,1)
  else if sceneProgress=13 and bWaitForInput=false
    msgCreate(0,0,"Claire","I just need through here, I don't want any trouble.",0,3,oMessageCutscene,1)
  else if sceneProgress=14 and bWaitForInput=false
    msgCreate(0,0,"Death","I can not allow that. Your safe passage will hinder our continued existence and our plans.",8,3,oMessageCutscene,1)
  else if sceneProgress=15 and bWaitForInput=false
    msgCreate(0,0,"Claire","I don't understand.",0,3,oMessageCutscene,1)
  else if sceneProgress=16 and bWaitForInput=false
    msgCreate(0,0,"Death","Of course you know we escaped from the program's Vault. Your continued venture would put us back and we can not allow that.",8,3,oMessageCutscene,1)
  else if sceneProgress=17 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","We?",0,3,oMessageCutscene,1)
  else if sceneProgress=18 and bWaitForInput=false
    msgCreate(0,0,"Death","The program sealed many bots in its Vault after creating them. These bots were made from the loose data it was fed of existing lands.",8,3,oMessageCutscene,1)
  else if sceneProgress=19 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","That's right! The creators of the program used other games to test its ability to accept and adapt to new data.",0,3,oMessageCutscene,1)
  else if sceneProgress=20 and bWaitForInput=false
    msgCreate(0,0,"Death","They tested it on many of the old worlds. I am one of the bots created from these tests, then I was stuffed away into that accursed Vault.",8,3,oMessageCutscene,1)
  else if sceneProgress=21 and bWaitForInput=false
    msgCreate(0,0,"Claire","Why did that happen?",0,3,oMessageCutscene,1)
  else if sceneProgress=22 and bWaitForInput=false
    msgCreate(0,0,"Death","That does not matter. Now that I am out of that place, I shall reign terror upon the world.",8,3,oMessageCutscene,1)
  else if sceneProgress=23 and bWaitForInput=false
    msgCreate(0,0,"Claire","Why? You seem to be aware of what this all is.",0,3,oMessageCutscene,1)
  else if sceneProgress=24 and bWaitForInput=false
    msgCreate(0,0,"Death","My awareness of the situation has no governance on my actions. It matters not. Our priorities conflict, therefore you must be stopped.",8,3,oMessageCutscene,1)
  else if sceneProgress=25 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Claire, I'm getting some really bad vibes from this guy. I don't think this is going to be anything like the original Death. Be careful.",0,3,oMessageCutscene,1)
  else if sceneProgress=26 and bWaitForInput=false
    msgCreate(0,0,"Death","I will not be your opponent today. No, I have something else in store for you. Your fate lies ahead. Enjoy your last moments.",8,3,oMessageCutscene,1)
  else if sceneProgress=27
  {
    sceneDelay+=1
    if sceneDelay>=11 and sceneDelay<=30
    {
      if tColor>0 {tColor-=15}
      npcDeath.image_blend=make_color_rgb(tColor,tColor,tColor)
      npcDeath.image_xscale+=0.1; npcDeath.image_yscale+=0.1; npcDeath.image_alpha-=0.05
    }
    else if sceneDelay=31
    {
      with npcDeath {instance_destroy()}
    }
    else if sceneDelay>=60 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=28 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Well that was... interesting.",0,3,oMessageCutscene,1)
  else if sceneProgress=29 and bWaitForInput=false
    msgCreate(0,0,"Chao","He said he escaped from the Vault.",0,3,oMessageCutscene,1)
  else if sceneProgress=30 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Yeah, I'm willing to bet that others, such as Cackletta, also escaped from the Vault somehow. We need to get rid of the Virus as quick as we can. Who knows what else is in there.",0,3,oMessageCutscene,1)
  else if sceneProgress=31 and bWaitForInput=false
    msgCreate(0,0,"Claire","He creeps me out.",0,3,oMessageCutscene,1)
  else if sceneProgress=32
  {
    sceneDelay=0; sceneProgress=0
    global.gameProgress=1230
    global.gamePaused=false
  }
}
else if global.gameProgress=1240 and room=rBelmont3_3A //----- [4] The inner castle -----
{
  if sceneProgress=0
  {
    sceneDelay+=1
    if sceneDelay=1 {global.gamePaused=true}
    else if sceneDelay>=20 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=1 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","You're in the inner part of the castle. I don't know what's going on with Death, but Dracula should be close by. If you can reach him, you can end all this.",0,3,oMessageCutscene,1)
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"Claire","This castle sure was small...",0,3,oMessageCutscene,1)
  else if sceneProgress=3
  {
    sceneDelay=0; sceneProgress=0
    global.gameProgress=1250
    global.gamePaused=false
  }
}
else if global.gameProgress=1250 and room=rBelmont3_3B //----- [5] After grabbing Holy Water -----
{
  if sceneProgress=0 and !instance_exists(oStoryObject)
  {
    sceneDelay+=1
    if sceneDelay=1 {global.gamePaused=true}
    else if sceneDelay>=2
    {
      oPlayer1.y+=4
      if oPlayer1.y>=1408
      {
        scenePChk(oPlayer1.x,1408,0,0.1,1)
        sceneDelay=0; sceneProgress+=1
      }
    }
  }
  else if sceneProgress=1
  {
    sceneDelay+=1
    if sceneDelay>=60 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Just a reminder. To use this, press 'Action Button C.'",0,3,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Claire","Jeremy, don't be like some games...#We get it.",0,3,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","I was just trying to be helpful.",0,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Claire","There's a point when games become TOO helpful, don't cross the line.",0,3,oMessageCutscene,1)
  else if sceneProgress=6
  {
    sceneDelay=0; sceneProgress=0
    global.hasAbilToken[2]=4
    global.gameProgress=1260
    global.gamePaused=false
  }
}
else if global.gameProgress=1270 and room=rBelmont3_3D //----- [Unskippable] Advancing spike wall of doom -----
{
  if oPlayer1.x>=144 and bWallSpawn=0
  {
    var tNewWall;
    tNewWall=instance_create(-32,0,oAdvancingDeathWall)
    tNewWall.type=0; tNewWall.xSpd=2.6; tNewWall.xThres=32
    bWallSpawn=1
  }
}
else if global.gameProgress=1280 and room=rBelmont3_3F //----- [6] Boss Fight: Dracula -----
{
  if global.bossTrack=0
  {
    if sceneProgress=0 and oPlayer1.x>=256
    {
      sceneDelay+=1
      if sceneDelay=1 {global.gamePaused=true}
      oPlayer1.y+=4
      if oPlayer1.y>=288
      {
        oPlayer1.y=288
        oPlayer1.sprite_index=sClaireIdle
        stopPlayer()
        sceneDelay=0; sceneProgress+=1
      }
    }
    else if sceneProgress=1
    {
      sceneDelay+=1
      if sceneDelay>=20 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=2 and bWaitForInput=false
      msgCreate(0,0,"Dracula","You have arrived, just as Death said.",8,3,oMessageCutscene,1)
    else if sceneProgress=3 and bWaitForInput=false
      msgCreate(0,0,"Claire","Did he also mention that we're taking the Chip?",0,3,oMessageCutscene,1)
    else if sceneProgress=4 and bWaitForInput=false
      msgCreate(0,0,"Dracula","He alluded to that, but you will not have it.",8,3,oMessageCutscene,1)
    else if sceneProgress=5 and bWaitForInput=false
      msgCreate(0,0,"Jerry","I was really hoping Claire would have been awesome and said, 'Die monster. You don't belong in this world!'",0,3,oMessageCutscene,1)
    else if sceneProgress=6 and bWaitForInput=false
      msgCreate(0,0,"Claire","Oh you would Jerry.",0,3,oMessageCutscene,1)
    else if sceneProgress=7 and bWaitForInput=false
      msgCreate(0,0,"Jerry","Hopefully he would give the proper response. Plus, he's totally not wanted in this world either. According to Jeremy, he should be in The Vault. I mean seriously, that whole sequence could be reenacted here and it would still make sense.",0,3,oMessageCutscene,1)
    else if sceneProgress=8 and bWaitForInput=false
      msgCreate(0,0,"Claire","Wow you're right. It WOULD make some sense!",0,3,oMessageCutscene,1)
    else if sceneProgress=9 and bWaitForInput=false
      msgCreate(0,0,"Jerry","Wow you're kinda hot when you're not being... yeah.",0,3,oMessageCutscene,1)
    else if sceneProgress=10 and bWaitForInput=false
      msgCreate(0,0,"Claire","You had the sense to cut yourself off this time.",0,3,oMessageCutscene,1)
    else if sceneProgress=11 and bWaitForInput=false
      msgCreate(0,0,"Jerry","I know my limits... sometimes.#Hey, now that I think about it, it wouldn't have the same impact without the bad voice acting.",0,3,oMessageCutscene,1)
    else if sceneProgress=12 and bWaitForInput=false
      msgCreate(0,0,"Claire","He also doesn't have his wine glass. I'm a bit disappointed.",0,3,oMessageCutscene,1)
    else if sceneProgress=13 and bWaitForInput=false
      msgCreate(0,0,"Jerry","And where's our line about how humans are miserable piles of...",0,3,oMessageCutscene,1)
    else if sceneProgress=14 and bWaitForInput=false
      msgCreate(0,0,"Dracula","Enough talk!#Have at you!",8,3,oMessageCutscene,1)
    else if sceneProgress=15 and bWaitForInput=false
      msgCreate(0,0,"Jerry","Yes! One line made it back!",0,3,oMessageCutscene,1)
    else if sceneProgress=16
    {
      global.gamePaused=false
      var bossBarr;
      bossBarr=instance_create(16,224,oBossBarrier)
      bossBarr=instance_create(688,224,oBossBarrier)
      var tBossTitle,tempMplay;
      tBossTitle=instance_create(0,0,oBossNameDisplay)
      tBossTitle.bossName="Dracula"
      tBossTitle.bossTitle="Lord of Darkness aka Danmacula"
      global.currentBoss="Dracula"
      tempMplay=findMusic(804)
      playMusic(tempMplay,0,0)
      oDracula.activateBoss=1
      global.bossTrack=1
      storeStatus(0)
      sceneDelay=0; sceneProgress=0
    }
  }
  else if global.bossTrack=1
  {
    if !instance_exists(oDracula) and sceneProgress=0 //End Boss
    {
      global.gamePaused=true
      awardBossAP(1500)
      with oBossBarrier {instance_destroy()}
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
        scenePChk(360,288,0,0.1,1)
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
      msgCreate(0,0,"Jerry","You kicked a lot of ass there.",0,3,oMessageCutscene,1)
    else if sceneProgress=5 and bWaitForInput=false
      msgCreate(0,0,"Claire","Naturally.",0,3,oMessageCutscene,1)
    else if sceneProgress=6 and bWaitForInput=false
      msgCreate(0,0,"Jerry","Hey now, there's only enough room for my ego in here.",0,3,oMessageCutscene,1)
    else if sceneProgress=7 and bWaitForInput=false
      msgCreate(0,0,"Claire","Whatever Jerry.",0,3,oMessageCutscene,1)
    else if sceneProgress=8 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","Where's the Chip anyway?",0,3,oMessageCutscene,1)
    else if sceneProgress=9 and bWaitForInput=false
      msgCreate(0,0,"Jerry","Shouldn't you be the one that knows?",0,3,oMessageCutscene,1)
    else if sceneProgress=10 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","I don't see it here. Chao, can you see it?",0,3,oMessageCutscene,1)
    else if sceneProgress=11 and bWaitForInput=false
      msgCreate(0,0,"Chao","No, I'm not sure where it is now.",0,3,oMessageCutscene,1)
    else if sceneProgress=12 and bWaitForInput=false
      msgCreate(0,0,"Claire","Well then, what the hell?",0,3,oMessageCutscene,1)
    else if sceneProgress=13
    {
      sceneDelay+=1
      if sceneDelay=10
      {
        npcDeath=instance_create(432,208,oMisc)
        npcDeath.sprite_index=sDeathIdle; npcDeath.image_speed=0.15
        npcDeath.image_alpha=0; npcDeath.type=2
      }
      else if sceneDelay>=11 and sceneDelay<=30
      {
        npcDeath.image_alpha+=0.05
      }
      else if sceneDelay>=65 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=14 and bWaitForInput=false
      msgCreate(0,0,"Death","You performed better than expected, but a nuisance you still remain.",8,3,oMessageCutscene,1)
    else if sceneProgress=15 and bWaitForInput=false
      msgCreate(0,0,"Claire","Ready to fight yet?",0,3,oMessageCutscene,1)
    else if sceneProgress=16 and bWaitForInput=false
      msgCreate(0,0,"Death","I am far too busy...#If you want the Chip, come to my castle, but I doubt you will make it to me.",8,3,oMessageCutscene,1)
    else if sceneProgress=17
    {
      sceneDelay+=1
      if sceneDelay>=11 and sceneDelay<=30
      {
        npcDeath.image_xscale+=0.05; npcDeath.image_yscale+=0.05
        npcDeath.image_alpha-=0.05
      }
      else if sceneDelay=31
      {
        with npcDeath {instance_destroy()}
      }
      else if sceneDelay>=60 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=18 and bWaitForInput=false
      msgCreate(0,0,"Claire","Why do villains ALWAYS do this?!",0,3,oMessageCutscene,1)
    else if sceneProgress=19 and bWaitForInput=false
      msgCreate(0,0,"Jerry","Great, now we have to watch Claire go through even more of this.",0,3,oMessageCutscene,1)
    else if sceneProgress=20 and bWaitForInput=false
      msgCreate(0,0,"Claire","Like you didn't see this coming Jerry. There's a pattern.",0,3,oMessageCutscene,1)
    else if sceneProgress=21
    {
      var tFullHeartDrop;
      tFullHeartDrop=instance_create(360,96,oHealthPickup)
      tFullHeartDrop.sprite_index=sFullHealthPickup
      var tempMplay;
      tempMplay=findMusic(303)
      playMusic(tempMplay,0,0)

      global.gamePaused=false
      global.currentBoss=""
      global.bossTrack=0
      global.gameProgress=1290
    }
  }
}
else if global.gameProgress=1300 and room=rBelmont3_4A //----- [7] Oh great, there really is more -----
{
  if sceneProgress=0
  {
    sceneDelay+=1
    if sceneDelay=1 {global.gamePaused=true}
    else if sceneDelay>=20 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=1 and bWaitForInput=false
    msgCreate(0,0,"Jerry","What were you saying about this place being small earlier?",0,3,oMessageCutscene,1)
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"Claire","Did you not see my ellipsis? I was pretty sure that wasn't all of it!",0,3,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Fair enough, I have no counter to that... yet.",0,3,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Chao","This next place seems to be more akin to the newer Castlevania games.",0,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Claire","Anything special I need to know?",0,3,oMessageCutscene,1)
  else if sceneProgress=6 and bWaitForInput=false
    msgCreate(0,0,"Chao","I don't think there's a silver and gold ring to collect.",0,3,oMessageCutscene,1)
  else if sceneProgress=7 and bWaitForInput=false
    msgCreate(0,0,"Jerry","I'm just gonna say it. Symphony of the Night was an easy game, but that fight with Richter actually kicked my ass a few times.",0,3,oMessageCutscene,1)
  else if sceneProgress=8 and bWaitForInput=false
    msgCreate(0,0,"Claire","Do you think Death has any actual plans?",0,3,oMessageCutscene,1)
  else if sceneProgress=9 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","To be honest... no.",0,3,oMessageCutscene,1)
  else if sceneProgress=10 and bWaitForInput=false
    msgCreate(0,0,"Claire","Are those high hopes?",0,3,oMessageCutscene,1)
  else if sceneProgress=11 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","He's giving me the standard villain vibe this time around.",0,3,oMessageCutscene,1)
  else if sceneProgress=12 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Wow, no snarky comment about me sucking at a game.",0,3,oMessageCutscene,1)
  else if sceneProgress=13 and bWaitForInput=false
    msgCreate(0,0,"Claire","I leave the cheap shots to you Jerry.",0,3,oMessageCutscene,1)
  else if sceneProgress=14
  {
    sceneDelay=0; sceneProgress=0
    global.gameProgress=1310
    global.gamePaused=false
  }
}
else if room=rBelmont3_4E //----- [Unskippable] Enemy Trap -----
{
  if gameProgCheck="0"
  {
    if global.gamePaused=false
    {
      if sceneProgress=0
      {
        if oPlayer1.x>=1408
        {
          var enemyCounter,enemyBarrier;
          enemyCounter=instance_create(0,0,oEnemyRemain)
          enemyCounter.enemyCount=3
          enemyBarrier=instance_create(1344,224,oEnemyBarrier); enemyBarrier.image_yscale=4
          enemyBarrier=instance_create(1648,224,oEnemyBarrier); enemyBarrier.image_yscale=4
          sceneProgress+=1
        }
      }
      else if sceneProgress=1
      {
        sceneDelay+=1
        if sceneDelay=10
        {
          delaySpawn(1600,288,oCV_SwordKnight,2,1,1,0.33)
          sceneDelay=0; sceneProgress+=1
        }
      }
      else if sceneProgress=2
      {
        if oEnemyRemain.enemyCount<=2 {sceneProgress+=1}
      }
      else if sceneProgress=3
      {
        sceneDelay+=1
        if sceneDelay=10
        {
          delaySpawn(1408,288,oCV_SwordKnight,2,1,1,0.33)
          delaySpawn(1600,288,oCV_SwordKnight,2,1,1,0.33)
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

          gameProgCheck="1"
          var tNewString;
          tNewString=string_delete(global.gameGate3Prog,1,1)
          tNewString=string_insert("1",tNewString,1)
          global.gameGate3Prog=tNewString
        }
      }
    }
  }
}
else if room=rBelmont3_4G //----- [] Spawn enemy / story item -----
{
  if gameProgCheck="1" //Spawn enemy
  {
    if sceneProgress=0
    {
      instance_create(336,208,oCV_SalemWitch)
      sceneProgress+=1
    }
    else if sceneProgress=1
    {
      if !instance_exists(oCV_SalemWitch)
      {
        var tNewStoryItem;
        tNewStoryItem=instance_create(336,272,oStoryObject)
        tNewStoryItem.sprite_index=sCV_Gems; tNewStoryItem.image_speed=0
        tNewStoryItem.soundToPlay=global.snd_HeartPiece
        tNewStoryItem.stringToShow="You found the [Blue Gem]."
        tNewStoryItem.fadingTime=60; tNewStoryItem.boxSize=0
        instance_create(256,320,oHealingPost)
        gameProgCheck="2"
        var tNewString;
        tNewString=string_delete(global.gameGate3Prog,1,1)
        tNewString=string_insert("2",tNewString,1)
        global.gameGate3Prog=tNewString
      }
    }
  }
  if gameProgCheck="2" //Check for story item obtained
  {
    if sceneProgress=0
    {
      var tNewStoryItem;
      tNewStoryItem=instance_create(336,272,oStoryObject)
      tNewStoryItem.sprite_index=sCV_Gems; tNewStoryItem.image_speed=0
      tNewStoryItem.soundToPlay=global.snd_HeartPiece
      tNewStoryItem.stringToShow="You found the [Blue Gem]."
      tNewStoryItem.fadingTime=60; tNewStoryItem.boxSize=0
      sceneProgress+=1
    }
    else if sceneProgress=1
    {
      if !instance_exists(oStoryObject)
      {
        gameProgCheck="3"
        var tNewString;
        tNewString=string_delete(global.gameGate3Prog,1,1)
        tNewString=string_insert("3",tNewString,1)
        global.gameGate3Prog=tNewString
        sceneProgress+=1
      }
    }
  }
}
else if room=rBelmont3_4I //----- [Unskippable] Enemy Trap -----
{
  if gameProgCheck="0"
  {
    if global.gamePaused=false
    {
      if sceneProgress=0
      {
        if oPlayer1.x>=496
        {
          var enemyCounter,enemyBarrier;
          enemyCounter=instance_create(0,0,oEnemyRemain)
          enemyCounter.enemyCount=4
          enemyBarrier=instance_create(368,192,oEnemyBarrier); enemyBarrier.image_yscale=6
          enemyBarrier=instance_create(608,192,oEnemyBarrier); enemyBarrier.image_yscale=6
          sceneProgress+=1
        }
      }
      else if sceneProgress=1
      {
        sceneDelay+=1
        if sceneDelay=10
        {
          delaySpawn(576,288,oCV_SwordKnight,2,1,1,0.33)
          sceneDelay=0; sceneProgress+=1
        }
      }
      else if sceneProgress=2
      {
        if oEnemyRemain.enemyCount<=3 {sceneProgress+=1}
      }
      else if sceneProgress=3
      {
        sceneDelay+=1
        if sceneDelay=10
        {
          delaySpawn(416,288,oCV_SwordKnight,2,1,1,0.33)
          sceneDelay=0; sceneProgress+=1
        }
      }
      else if sceneProgress=4
      {
        if oEnemyRemain.enemyCount<=2 {sceneProgress+=1}
      }
      else if sceneProgress=5
      {
        sceneDelay+=1
        if sceneDelay=10
        {
          delaySpawn(416,288,oCV_AxeKnight,2,1,1,0.33)
          delaySpawn(576,288,oCV_SwordKnight,2,1,1,0.33)
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

          gameProgCheck="1"
          var tNewString;
          tNewString=string_delete(global.gameGate3Prog,2,1)
          tNewString=string_insert("1",tNewString,2)
          global.gameGate3Prog=tNewString
        }
      }
    }
  }
}
else if global.gameProgress=1330 and room=rBelmont3_5A //----- [8] Continue on -----
{
  if sceneProgress=0
  {
    sceneDelay+=1
    if sceneDelay=1 {global.gamePaused=true}
    else if sceneDelay>=20 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=1 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Aren't there still things you need to do back there?",0,3,oMessageCutscene,1)
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"Claire","I'm doing things my way, Jerry.",0,3,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Okay then, well... I will back away.",0,3,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Chao","Looks like you need something from this place anyway. Moving forward might not be a bad idea.",0,3,oMessageCutscene,1)
  else if sceneProgress=5
  {
    sceneDelay=0; sceneProgress=0
    global.gameProgress=1340
    global.gamePaused=false
  }
}
else if room=rBelmont3_4C //----- [] Hit switch -----
{
  if gameProgCheck="1"
  {
    if (176524).activated=1
    {
      var tFlash;
      tFlash=instance_create(0,0,oScreenFlash)
      tFlash.fadeSpeed=0.2
      tile_layer_show(999999)
      var newCollision;
      newCollision=instance_create(400,208,oInvisibleSolid)
      newCollision.image_xscale=4; newCollision.image_yscale=4
      gameProgCheck="2"
      var tNewString;
      tNewString=string_delete(global.gameGate3Prog,2,1)
      tNewString=string_insert("2",tNewString,2)
      global.gameGate3Prog=tNewString
    }
  }
}
else if global.gameProgress=1350 and room=rBelmont3_5F //----- [] Story item -----
{
  if !instance_exists(oStoryObject) {global.gameProgress=1360}
}
else if global.gameProgress=1360 and room=rBelmont3_4H //----- [] Break barrier door -----
{
  if sceneProgress=0
  {
    var gameProgCheckA;
    gameProgCheckA=string_char_at(global.gameGate3Prog,1)
    if gameProgCheckA="3" {sceneProgress+=1}
  }
  else if sceneProgress=1
  {
    sceneDelay+=1
    if sceneDelay>=30
    {
      sceneDelay=0; sceneProgress=0
      var tFlash;
      tFlash=instance_create(0,0,oScreenFlash)
      tFlash.fadeSpeed=0.2
      global.gameProgress=1370
    }
  }
}
else if global.gameProgress=1370 and room=rBelmont3_4H //----- [9] After grabbing Dash Boots -----
{
  if sceneProgress=0 and !instance_exists(oStoryObject)
  {
    sceneDelay+=1
    if sceneDelay=1 {global.gamePaused=true}
    else if sceneDelay>=2
    {
      oPlayer1.y+=4
      if oPlayer1.y>=240
      {
        oPlayer1.y=240
        oPlayer1.sprite_index=sClaireIdle
        oPlayer1.image_speed=0.1
        sceneDelay=0; sceneProgress+=1
      }
    }
  }
  else if sceneProgress=1
  {
    sceneDelay+=1
    if sceneDelay>=60 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Whoa, wait a minute. Will that really reenable what I think it will?",0,3,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Yes, this will activate your dash function again.",0,3,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Of course Claire gets to try all the good stuff first.",0,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Claire","If I remember right, I was stuck for awhile and then YOU got to have a unique set of abilities first! Let's not go into who gets to do what first.",0,3,oMessageCutscene,1)
  else if sceneProgress=6 and bWaitForInput=false
    msgCreate(0,0,"Chao","Once again Jerry, you've been beat.",0,3,oMessageCutscene,1)
  else if sceneProgress=7 and bWaitForInput=false
    msgCreate(0,0,"Jerry","I admit defeat...",0,3,oMessageCutscene,1)
  else if sceneProgress=8 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Just in case you don't remember the dashing mechanics, it allows you to make yourself completely invulnerable during its duration. It's also useful for giving yourself a forward or backward burst of speed quickly.",0,3,oMessageCutscene,1)
  else if sceneProgress=9 and bWaitForInput=false
    msgCreate(0,0,"Claire","So where to now?",0,3,oMessageCutscene,1)
  else if sceneProgress=10 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","I'm sure there was somewhere you couldn't go before in the Castle Courtyard area. Oh and one other thing... This ability is not tied to the Gate, you can leave and you'll still have it.",0,3,oMessageCutscene,1)
  else if sceneProgress=11 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","There's a few things I want to note about the dash. The first is that there are two different dashes.#To dash forward, press [Jump] while holding [Up].#To dash back, press [Jump] while holding [Down].",0,3,oMessageCutscene,1)
  else if sceneProgress=12 and bWaitForInput=false
    msgCreate(0,0,"Jeremy",string("You can also dash by simply pressing [") +string(global.ctrlDashRight) +string("] or [") +string(global.ctrlDashLeft) +string("]. In the Options submenu, there is an entry titled 'Right is Forward'. When this is on, which it is by default, [") +string(global.ctrlDashRight) +string("] will always dash forward, regardless of facing direction, and [") +string(global.ctrlDashLeft) +string("] is always back."),0,3,oMessageCutscene,1)
  else if sceneProgress=13 and bWaitForInput=false
    msgCreate(0,0,"Jeremy",string("When it is off, [") +string(global.ctrlDashRight) +string("] always dashes you right, while [") +string(global.ctrlDashLeft) +string("] always dashes your left. Play whichever way you're more comfortable with. You can also turn off Up/Down from executing the dash by turning off 'D-Pad Dash'."),0,3,oMessageCutscene,1)
  else if sceneProgress=14 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Just try it all for yourself in this room, you'll see how it works. You have infinite dash energy in this room for some reason.",0,3,oMessageCutscene,1)
  else if sceneProgress=15
  {
    var tNewTutorial;
    tNewTutorial=instance_create(0,0,oTutorialPanel)
    tNewTutorial.tutorialTitle="Dashing 1"
    tNewTutorial.tutorialInfo="Performing a dash uses up 1 Dash Point. These will slowly recover over time."
    tNewTutorial.scrAreaY=0
    sceneDelay=0; sceneProgress=0
    global.hasShoes[2]=2
    global.gameProgress=1380
    global.gamePaused=false
  }
}
else if global.gameProgress=1380 and room=rBelmont3_5B //----- [] Dashing tutorial - Momentum cancel -----
{
  if sceneProgress=0
  {
    if oPlayer1.x>=448 and oPlayer1.y<=240
    {
      var tNewTutorial;
      tNewTutorial=instance_create(0,0,oTutorialPanel)
      tNewTutorial.tutorialTitle="Dashing 2"
      tNewTutorial.tutorialInfo="Pressing forward or back during a dash will cancel the momentum boost."
      tNewTutorial.scrAreaY=0
      sceneProgress+=1
    }
  }
}
else if global.gameProgress=1390 and room=rBelmont3_5G //----- [] Dashing tutorial - Invulnerability -----
{
  if sceneProgress=0
  {
    if oPlayer1.x>=320
    {
      var tNewTutorial;
      tNewTutorial=instance_create(0,0,oTutorialPanel)
      tNewTutorial.tutorialTitle="Dashing 3"
      tNewTutorial.tutorialInfo="During the duration of a dash, you are completely invulnerable to damage. This includes traps such as this one here."
      tNewTutorial.scrAreaY=1
      sceneProgress+=1
    }
  }
}
else if global.gameProgress=1400 and room=rBelmont3_5H //----- [] Dashing tutorial - Antidash Fields -----
{
  if sceneProgress=0
  {
    if oPlayer1.x>=128
    {
      var tNewTutorial;
      tNewTutorial=instance_create(0,0,oTutorialPanel)
      tNewTutorial.tutorialTitle="Dashing 4"
      tNewTutorial.tutorialInfo="This is an anti-dashing field. One step inside will drain all of your dash energy."
      tNewTutorial.scrAreaY=1
      sceneProgress+=1
    }
  }
}
else if global.gameProgress=1410 and room=rBelmont3_6A //----- [10] Death's Sky Castle -----
{
  if sceneProgress=0
  {
    sceneDelay+=1
    if sceneDelay=1 {global.gamePaused=true}
    else if sceneDelay>=20 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=1 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Wow, I wasn't expecting that bridge to lead to this. What is this place?",0,3,oMessageCutscene,1)
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","I'm guessing this is Death's Sky Castle.",0,3,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Claire","Another castle?",0,3,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","When isn't there more than one castle these days? Whether they're upside down or not.",0,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Claire","Well, guess I better start this.",0,3,oMessageCutscene,1)
  else if sceneProgress=6 and bWaitForInput=false
    msgCreate(0,0,"Chao","And there's also more arbitrary item collecting here.",0,3,oMessageCutscene,1)
  else if sceneProgress=7 and bWaitForInput=false
    msgCreate(0,0,"Claire","More?!",0,3,oMessageCutscene,1)
  else if sceneProgress=8 and bWaitForInput=false
    msgCreate(0,0,"Chao","It's actually not so bad from what I can see. There's 3 items you need and this place is actually pretty small.",0,3,oMessageCutscene,1)
  else if sceneProgress=9 and bWaitForInput=false
    msgCreate(0,0,"Claire","I guess that's not so bad.",0,3,oMessageCutscene,1)
  else if sceneProgress=10
  {
    sceneDelay=0; sceneProgress=0
    global.gameProgress=1420
    global.gamePaused=false
  }
}
else if global.gameProgress=1430 and room=rBelmont3_6C //----- [] Boss Fight: Menace -----
{
  if global.bossTrack=0
  {
    if global.gamePaused=false
    {
      if sceneProgress=0
      {
        if oPlayer1.x>=480
        {
          var bBarrier;
          bBarrier=instance_create(272,448,oBossBarrier)
          colStopper=instance_create(640,0,oInvisibleSolid)
          colStopper.image_yscale=35
          fadeColor=c_black
          sceneProgress+=1
        }
      }
      else if sceneProgress=1
      {
        sceneDelay+=1
        if sceneDelay>=1 and sceneDelay<=50 {fadeAlpha+=0.02}
        else if sceneDelay=90 {boss=instance_create(848,200,oMenaceMain)}
        else if sceneDelay=91
        {
          npcDeath=instance_create(704,160,oMisc)
          npcDeath.sprite_index=sDeathIdle; npcDeath.image_speed=0.15; npcDeath.type=2
          backFol=instance_create(0,0,oBackgroundFollow)
          backFol.type=0; backFol.backSet=backCV_Menace
          backFol.wSize=480; backFol.hSize=352
          backCChg=255; backCTime=0
          backGBlend=1
          with oEnemyBase {image_blend=c_black}
        }
        else if sceneDelay>=101 and sceneDelay<=200 {fadeAlpha-=0.005}
        else if sceneDelay>=201 and sceneDelay<=250 {fadeAlpha-=0.01}
        else if sceneDelay=260
        {
          fadeInCol=0
          with colStopper {instance_destroy()}
          var tBossTitle,tempMplay;
          tBossTitle=instance_create(0,0,oBossNameDisplay)
          tBossTitle.bossName="Menace"
          tBossTitle.bossTitle="Amalgamation of Evil Spirits"
          tempMplay=findMusic(805)
          playMusic(tempMplay,0,0)
        }
        else if sceneDelay>=261 and sceneDelay<=400
        {
          npcDeath.image_alpha-=0.02
          fadeInCol+=3
          with oEnemyBase
            image_blend=make_color_rgb(oEvCh6MainA.fadeInCol,oEvCh6MainA.fadeInCol,oEvCh6MainA.fadeInCol)
          if fadeInCol=255 {sceneDelay=500}
        }
        else if sceneDelay=510
        {
          with npcDeath {instance_destroy()}
          global.currentBoss="Menace"
          boss.activateBoss=1
          global.bossTrack=1
          storeStatus(0)
          sceneDelay=0; sceneProgress=0
        }
      }
    }
  }
  else if global.bossTrack=1
  {
    if !instance_exists(oMenaceMain) and sceneProgress=0 //End Boss
    {
      awardBossAP(1600)
      stopAllMusic()
      global.bossTrack=3
    }
  }
  else if global.bossTrack=3
  {
    if sceneProgress=0
    {
      sceneDelay+=1
      if sceneDelay>=31 and sceneDelay<=130
        backFol.image_alpha-=0.01
      else if sceneDelay>=150
      {
        msgCreate(0,0,"Chao","Something appeared on the right side of the room.",0,1,oMessagePerson,0); newMessage.fadingTime=110
        var tempMplay;
        tempMplay=findMusic(306)
        playMusic(tempMplay,0,0)
        with oBossBarrier {instance_destroy()}
        sceneDelay=0
        sceneProgress=0
        global.currentBoss=""
        global.bossTrack=0
        global.gameProgress=1440
      }
    }
  }
}
else if global.gameProgress=1440 and room=rBelmont3_6C //----- [] Get Death's Rib -----
{
  if sceneProgress=0
  {
    var tNewStoryItem;
    tNewStoryItem=instance_create(896,496,oStoryObject)
    tNewStoryItem.sprite_index=sCV_DeathParts; tNewStoryItem.image_speed=0; tNewStoryItem.image_index=1
    tNewStoryItem.soundToPlay=global.snd_HeartPiece
    tNewStoryItem.stringToShow="You now prossess [Death's Rib]."
    tNewStoryItem.fadingTime=80
    tNewStoryItem.boxSize=1
    sceneProgress+=1
  }
  else if sceneProgress=1
  {
    if !instance_exists(oStoryObject)
      global.gameProgress=1450
  }
}
else if room=rBelmont3_6E //----- [] Get Death's Heart -----
{
  if gameProgCheck="3" //Check for story item obtained
  {
    if sceneProgress=0
    {
      if (181462).activated=1 and (181463).activated=1
      {
        instance_create(1360,112,oCV_SalemWitch)
        instance_create(1552,112,oCV_SalemWitch)
        sceneProgress+=1
      }
    }
    else if sceneProgress=1
    {
      if !instance_exists(oStoryObject)
      {
        gameProgCheck="4"
        var tNewString;
        tNewString=string_delete(global.gameGate3Prog,1,1)
        tNewString=string_insert("4",tNewString,1)
        global.gameGate3Prog=tNewString
        sceneProgress+=1
      }
    }
  }
}
else if room=rBelmont3_6F //----- [] Get Death's Eye -----
{
  if gameProgCheck="2" //Check for story item obtained
  {
    if sceneProgress=0
    {
      if !instance_exists(oStoryObject)
      {
        gameProgCheck="3"
        var tNewString;
        tNewString=string_delete(global.gameGate3Prog,2,1)
        tNewString=string_insert("3",tNewString,2)
        global.gameGate3Prog=tNewString
        global.newMapX=624
        global.newMapY=368
        instance_create(0,0,oCheckpointNotice)
      }
    }
  }
  else if gameProgCheck="3" //Spawn extra enemies/traps
  {
    if sceneProgress=0
    {
      var i;
      for(i=182816;i<182826;i+=1)
      {
        (i).y+=1024
      }
      sceneProgress+=1
    }
  }
}
else if room=rBelmont3_6G //----- [] Break barrier door -----
{
  tintBackR=255-(oPlayer1.y/5) //1136
  background_blend[0]=make_color_rgb(255,tintBackR,tintBackR)
  
  if global.gameProgress=1450 //Top door
  {
    if sceneProgress=0 and oPlayer1.x>=208
    {
      var gameProgCheckA,gameProgCheckB;
      gameProgCheckA=string_char_at(global.gameGate3Prog,1)
      gameProgCheckB=string_char_at(global.gameGate3Prog,2)
      if gameProgCheckA="4" and gameProgCheckB="4" {sceneProgress+=1}
    }
    else if sceneProgress=1
    {
      sceneDelay+=1
      if sceneDelay>=30
      {
        sceneDelay=0; sceneProgress=0
        var tFlash;
        tFlash=instance_create(0,0,oScreenFlash)
        tFlash.fadeSpeed=0.2
        global.gameProgress=1460
      }
    }
  }
  else if global.gameProgress=1460 //Bottom door
  {
    if sceneProgress=0 and oPlayer1.x>=448
    {
      musVolC=global.optMusic*100
      musFileP=findMusic(306)
      sceneProgress+=1
    }
    else if sceneProgress=1
    {
      if musVolC>6000
      {
        musVolC-=40
        SS_SetSoundVol(musFileP,musVolC)
      }
      else if musVolC>1000 and musVolC<=6000
      {
        musVolC-=100
        SS_SetSoundVol(musFileP,musVolC)
      }
      else if musVolC<=1000
      {
        musFileP=findMusic(0)
        sceneProgress+=1
      }
    }
    else if sceneProgress=2
    {
      if oPlayer1.x>=1360 {sceneProgress+=1}
    }
    else if sceneProgress=3
    {
      if global.gamePaused=false
      {
        if oGame.time mod 2=0
        {
          var tEffect,tRanSize;
          tRanSize=random_range(0.75,1)
          tEffect=instance_create(1536+random(16),863+random(2),oEffect)
          tEffect.sprite_index=sMMSmokeCloud; tEffect.image_xscale=tRanSize; tEffect.image_yscale=tRanSize
          tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
        }
        (183139).y-=1
        if (183139).y<=704 {global.gameProgress=1470}
      }
    }
  }
}
else if global.gameProgress=1470 and room=rBelmont3_7A //----- [11] The final stretch -----
{
  if sceneProgress=0
  {
    sceneDelay+=1
    if sceneDelay=1 {global.gamePaused=true}
    else if sceneDelay>=20 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=1 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","This is the end, Death is just down these corridors.",0,3,oMessageCutscene,1)
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"Chao","Death probably has this place littered with traps, so be careful.",0,3,oMessageCutscene,1)
  else if sceneProgress=3
  {
    sceneDelay=0; sceneProgress=0
    global.gameProgress=1480
    global.gamePaused=false
  }
}
else if room=rBelmont3_7D //----- [] Hit switch / Enemy trap event -----
{
  if global.gameProgress=1480 //Check switch
  {
    if (184746).activated=1
    {
      instance_create(0,0,oCheckpointNotice)
      global.newMapX=736
      global.newMapY=240
      global.gameProgress=1490
    }
  }
  else if global.gameProgress=1490 //Enemy trap
  {
    if sceneProgress=0
    {
      sceneDelay+=1
      if sceneDelay=1
      {
        var enemyCounter,enemyBarrier;
        enemyCounter=instance_create(0,0,oEnemyRemain)
        enemyCounter.enemyCount=2
        enemyBarrier=instance_create(592,144,oEnemyBarrier); enemyBarrier.image_yscale=7
      }
      else if sceneDelay=20
      {
        delaySpawn(592,64,oCV_PeepingEye,2,1,1,0.33)
        delaySpawn(880,64,oCV_PeepingEye,2,1,1,0.33)
        sceneDelay=0
        sceneProgress+=1
      }
    }
    else if sceneProgress=1
    {
      if oEnemyRemain.enemyCount<=0
      {
        with oEnemyRemain {instance_destroy()}
        with oEnemyBarrier {instance_destroy()}
        sceneProgress=0
        global.gameProgress=1500
      }
    }
  }
}
else if global.gameProgress=1500 and room=rBelmont3_7F //----- [Unskippable] Enemy Trap -----
{
  if global.gamePaused=false
  {
    if sceneProgress=0
    {
      if oPlayer1.x>=640
      {
        var enemyCounter,enemyBarrier;
        enemyCounter=instance_create(0,0,oEnemyRemain)
        enemyCounter.enemyCount=3
        enemyBarrier=instance_create(480,128,oEnemyBarrier); enemyBarrier.image_yscale=9
        enemyBarrier=instance_create(784,128,oEnemyBarrier); enemyBarrier.image_yscale=9
        sceneProgress+=1
      }
    }
    else if sceneProgress=1
    {
      sceneDelay+=1
      if sceneDelay=30
      {
        delaySpawn(448,176,oCV_PeepingEye,2,1,1,0.33)
        delaySpawn(832,176,oCV_PeepingEye,2,1,1,0.33)
      }
      else if sceneDelay=240
      {
        delaySpawn(640,64,oCV_PeepingEye,2,1,1,0.33)
        sceneDelay=0
        sceneProgress+=1
      }
    }
    else if sceneProgress=2
    {
      if oEnemyRemain.enemyCount<=0
      {
        with oEnemyRemain {instance_destroy()}
        with oEnemyBarrier {instance_destroy()}
        sceneProgress=0
        global.gameProgress=1510
      }
    }
  }
}
else if global.gameProgress=1510 and room=rBelmont3_7G //----- [12] Boss Fight: Death -----
{
  if global.bossTrack=0
  {
    if sceneProgress=0 and oPlayer1.x>=224
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
        npcDeath=instance_create(352,240,oMisc)
        npcDeath.sprite_index=sDeathIdle
        npcDeath.image_alpha=0
        npcDeath.image_speed=0.15
        npcDeath.type=2
      }
      else if sceneDelay>=21 and sceneDelay<=70
        npcDeath.image_alpha+=0.02
      else if sceneDelay>=90 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=2 and bWaitForInput=false
      msgCreate(0,0,"Claire","Ready to give us the Chip?",0,3,oMessageCutscene,1)
    else if sceneProgress=3 and bWaitForInput=false
      msgCreate(0,0,"Death","I will not go back into the Vault.",8,3,oMessageCutscene,1)
    else if sceneProgress=4 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","Then we're just gonna have to take it from you.",0,3,oMessageCutscene,1)
    else if sceneProgress=5 and bWaitForInput=false
      msgCreate(0,0,"Death","You can't be serious.",8,3,oMessageCutscene,1)
    else if sceneProgress=6 and bWaitForInput=false
      msgCreate(0,0,"Claire","...",0,3,oMessageCutscene,1)
    else if sceneProgress=7 and bWaitForInput=false
      msgCreate(0,0,"Death","So be it.",8,3,oMessageCutscene,1)
    else if sceneProgress=8
    {
      sceneDelay+=1
      if sceneDelay=10
      {
        npcDeath.sprite_index=sDeathTransform
        npcDeath.image_speed=0.4
      }
      else if sceneDelay>=31 and sceneDelay<=55
      {
        transWidth+=1.5
        transAlpha+=0.02
      }
      else if sceneDelay=120
      {
        npcDeath.sprite_index=sDeathWalk
        npcDeath.y=304
        npcDeath.image_index=0
        npcDeath.image_speed=0
        npcDeath.image_xscale=-1
      }
      else if sceneDelay>=121 and sceneDelay<=145
      {
        transWidth-=1.5
        transAlpha-=0.02
      }
      else if sceneDelay=170
      {
        var tempMplay;
        tempMplay=findMusic(806)
        playMusic(tempMplay,0,0)
        musicCheck=1
      }
      else if sceneDelay>=200
      {
        sceneDelay=0
        sceneProgress+=1
      }
    }
    else if sceneProgress=9 and bWaitForInput=false
      msgCreate(0,0,"Death","After I remove you from existence, I will turn my armies on that precious city of yours.",8,3,oMessageCutscene,1)
    else if sceneProgress=10 and bWaitForInput=false
      msgCreate(0,0,"Jerry","Careful Claire. I don't like the vibes I'm getting from this guy.",0,3,oMessageCutscene,1)
    else if sceneProgress=11 and bWaitForInput=false
      msgCreate(0,0,"Claire","I can handle him.",0,3,oMessageCutscene,1)
    else if sceneProgress=12 and bWaitForInput=false
      msgCreate(0,0,"Jerry","I know you can, but that malevolent vibe I'm getting from him creeps me out.",0,3,oMessageCutscene,1)
    else if sceneProgress=13
    {
      global.gamePaused=false
      if musicCheck=0
      {
        var tempMplay;
        tempMplay=findMusic(806)
        playMusic(tempMplay,0,0)
      }
      var tBossTitle;
      tBossTitle=instance_create(0,0,oBossNameDisplay)
      tBossTitle.bossName="Death"
      tBossTitle.bossTitle="Keeper of Souls"
      global.currentBoss="Death"
      if variable_local_exists("npcDeath")
      {
        with npcDeath
          instance_destroy()
      }
      boss=instance_create(352,304,oDeath)
      boss.activateBoss=1
      global.bossTrack=1
      storeStatus(0)
      sceneDelay=0; sceneProgress=0
    }
  }
  else if global.bossTrack=1 or global.bossTrack=2
  {
    if sceneProgress=0
    {
      with oExit {instance_destroy()}
      sceneProgress=1
    }
    else if sceneProgress=1
    {
      if !instance_exists(oDeath) and !instance_exists(oLegion) //End Boss
      {
        global.gamePaused=true
        awardBossAP(2000)
        with oBossBarrier {instance_destroy()}
        stopAllMusic()
        sceneProgress=0
        global.bossTrack=3
      }
    }
  }
  else if global.bossTrack=3
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
        scenePChk(304,240,0,0.1,1)
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
    else if sceneProgress=4
    {
      sceneDelay+=1
      if sceneDelay=20
      {
        pChip=instance_create(304,134,oProgramChip)
        pChip.chipType=2; pChip.visible=0
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
    else if sceneProgress=5
    {
      sceneDelay+=1
      if sceneDelay>=21 and sceneDelay<=100
        pChip.y+=1
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
    else if sceneProgress=6 and bWaitForInput=false
      msgCreate(0,0,"Jerry","Wow, that was really impressive.",0,3,oMessageCutscene,1)
    else if sceneProgress=7 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","And you got the Chip right away too.",0,3,oMessageCutscene,1)
    else if sceneProgress=8 and bWaitForInput=false
      msgCreate(0,0,"Claire","Thanks... That wasn't anything like what you had to face, Jerry.",0,3,oMessageCutscene,1)
    else if sceneProgress=9 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","It seems everything from the Vault is as bad as we would imagine them to be.",0,3,oMessageCutscene,1)
    else if sceneProgress=10 and bWaitForInput=false
      msgCreate(0,0,"Jerry","Yeah yeah. Just glad you're okay.",0,3,oMessageCutscene,1)
    else if sceneProgress=11 and bWaitForInput=false
      msgCreate(0,0,"Claire","... So what now? We stopped the problems here and got the Chip.",0,3,oMessageCutscene,1)
    else if sceneProgress=12 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","Check back with Central City. See if we can find another Gate from there. I also want to make sure the city is still safe. We can't assume that Death was bluffing about an army.",0,3,oMessageCutscene,1)
    else if sceneProgress=13 and bWaitForInput=false
      msgCreate(0,0,"Claire","Right.",0,3,oMessageCutscene,1)
    else if sceneProgress=14 and bWaitForInput=false
      msgCreate(0,0,"Jerry","Well that's boring.",0,3,oMessageCutscene,1)
    else if sceneProgress=15 and bWaitForInput=false
      msgCreate(0,0,"Claire","What are you saying now, Jerry?",0,3,oMessageCutscene,1)
    else if sceneProgress=16 and bWaitForInput=false
      msgCreate(0,0,"Jerry","Straight to the point and just overall boring.",0,3,oMessageCutscene,1)
    else if sceneProgress=17 and bWaitForInput=false
      msgCreate(0,0,"Claire","We can't have illogical banter all the time, Jerry.",0,3,oMessageCutscene,1)
    else if sceneProgress=18 and bWaitForInput=false
      msgCreate(0,0,"Chao","You certainly wouldn't be opposed to it though.",0,3,oMessageCutscene,1)
    else if sceneProgress=19 and bWaitForInput=false
      msgCreate(0,0,"Claire","CHAO!",0,3,oMessageCutscene,1)
    else if sceneProgress=20
    {
      showEmote(oIdentifier,0,-6,sEmLove)
      with oProgramChip {instance_destroy()}
      
      var newExit;
      newExit=instance_create(0,272,oExit)
      newExit.bShowArrow=true; newExit.exitType=1
      newExit.newMapX=3888; newExit.newMapY=272; newExit.toRoom=rBelmont3_7F
      
      var tHeartContainer;
      tHeartContainer=instance_create(448,232,oHeartContainer)
      tHeartContainer.objectNum=3
      var newExit;
      newExit=instance_create(560,304,oExit)
      newExit.sprite_index=sWarpGateStand; newExit.bShowArrow=false; newExit.exitType=0
      newExit.newMapX=368; newExit.newMapY=288; newExit.toRoom=rBelmont3_Gate
      
      var tempMplay;
      tempMplay=findMusic(307)
      playMusic(tempMplay,0,0)
      
      global.canCharSwap=2
      global.hasAbilToken[1]=4
      global.programChips=3
      global.gamePaused=false
      global.currentBoss=""
      global.bossTrack=0
      global.gameProgress=1520
    }
  }
}

keyWaitForInput()

if oKeyCodes.kCodePressed[11]=1 and global.gamePaused=true and sceneProgress>=1 //Cutscene skip
{
  if !instance_exists(oPauseMenu)
  {
    if global.gameProgress=1150 and room=rBelmont3_Gate //[1]
    {
      bWaitForInput=false
      with oEffect {instance_destroy()}
      with oMisc {instance_destroy()}
      with oMessageCutscene {instance_destroy()}
      fadeAlpha=0
      sceneDelay=0
      sceneProgress=20
    }
    else if global.gameProgress=1200 and room=rBelmont3_2B //[2]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      sceneDelay=0
      sceneProgress=6
    }
    else if global.gameProgress=1220 and room=rBelmont3_2D //[3]
    {
      bWaitForInput=false
      with oMisc  {instance_destroy()}
      with oMessageCutscene {instance_destroy()}
      sceneDelay=0
      sceneProgress=32
    }
    else if global.gameProgress=1240 and room=rBelmont3_3A //[4]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      sceneDelay=0
      sceneProgress=3
    }
    else if global.gameProgress=1250 and room=rBelmont3_3B //[5]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      sceneDelay=0
      sceneProgress=6
    }
    else if global.gameProgress=1280 and room=rBelmont3_3F //[6]
    {
      if global.bossTrack=0
      {
        bWaitForInput=false
        with oMessageCutscene {instance_destroy()}
        with oScreenText {instance_destroy()}
        sceneDelay=0
        sceneProgress=16
      }
      else if global.bossTrack=2 and sceneProgress>=2
      {
        fadeAlpha=0
        bWaitForInput=false
        with oMessageCutscene {instance_destroy()}
        with oMisc {instance_destroy()}
        sceneDelay=0
        sceneProgress=21
      }
    }
    else if global.gameProgress=1300 and room=rBelmont3_4A //[7]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      sceneDelay=0
      sceneProgress=14
    }
    else if global.gameProgress=1330 and room=rBelmont3_5A //[8]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      sceneDelay=0
      sceneProgress=5
    }
    else if global.gameProgress=1370 and room=rBelmont3_4H //[9]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      sceneDelay=0
      sceneProgress=15
    }
    else if global.gameProgress=1410 and room=rBelmont3_6A //[10]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      sceneDelay=0
      sceneProgress=10
    }
    else if global.gameProgress=1470 and room=rBelmont3_7A //[11]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      sceneDelay=0
      sceneProgress=3
    }
    else if global.gameProgress=1510 and room=rBelmont3_7G //[12]
    {
      if global.bossTrack=0
      {
        transWidth=0
        bWaitForInput=false
        with oMessageCutscene {instance_destroy()}
        with oScreenText {instance_destroy()}
        sceneDelay=0
        sceneProgress=13
      }
      else if global.bossTrack=3 and sceneProgress>=2
      {
        fadeAlpha=0
        circleRad=0
        bWaitForInput=false
        with oMessageCutscene {instance_destroy()}
        sceneDelay=0
        sceneProgress=20
      }
    }
  }
}

if backGBlend=1
{
  backCTime+=1
  if backCTime>=1 and backCTime<=150
    backCChg-=1.25
  else if backCTime>=151 and backCTime<=300
  {
    backCChg+=1.25
    if backCTime=300
      backCTime=0
  }
  backFol.image_blend=make_color_rgb(255,backCChg,backCChg)
}

if room=rBelmont3_4F //Achievement
{
  if myAchProg=0
  {
    if oPlayer1.x>=room_width-128 and global.hitsTaken=0 and oPlayer1.dashNumThisMap=0
    {
      var tCheckAchieve;
      tCheckAchieve=string_char_at(global.tokenRecognitions,26)
      if tCheckAchieve="0"
      {
        var tAchievement;
        tAchievement=instance_create(0,0,oAchievementNotice)
        tAchievement.myAchievement="No Head"; tAchievement.checkNum=26
      }
      myAchProg=100
    }
  }
}
else if room=rBelmont3_4H
{
  oPlayer1.dashEnergy=oPlayer1.dashMeterMax
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

if room=rBelmont3_7G
{
  if transWidth>0
  {
    draw_set_alpha(transAlpha)
    draw_set_color(c_white)
    draw_rectangle(352-transWidth,-1,352+transWidth,room_height+1,0)
  }

  if circleRad>0
  {
    draw_set_color(c_white)
    draw_set_blend_mode_ext(bm_inv_dest_color,bm_zero)
    draw_circle(oProgramChip.x,oProgramChip.y,circleRad,0)
    draw_set_blend_mode(bm_normal)
  }
}
