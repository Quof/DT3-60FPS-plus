#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//----- Gate 1: Mario World -----
event_inherited()
enemyCount=-1
fadeColor=c_white
if global.gameProgress=150
  fadeAlpha=1
else
  fadeAlpha=0

if room=rMario1_CCc
{
  xScrollSpd=2
  autoScroll=instance_create(240,176,oMisc)
  autoScroll.type=0
  autoScroll.sprite_index=sNull
  view_object[0]=autoScroll
}
else if room=rMario1_CCBoss
  circleRad=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gameProgress=150 and room=rMario1_1 //----- [1] Intro to Mario World - Ch.2 -----
{
  if sceneProgress=0
  {
    sceneDelay+=1*gDeltaTime
    if sceneDelay=1
    {
      charSwitcher(0)
      scenePChk(192,176,1,0.1,1)
    }
    else if sceneDelay>=30
    {
      fadeAlpha-=0.02*gDeltaTime
      if fadeAlpha<=0 {sceneDelay=0; sceneProgress+=1}
    }
  }
  else if sceneProgress=1
  {
    sceneDelay+=1*gDeltaTime
    if sceneDelay=35
    {
      efCharge=instance_create(oPlayer1.x,oPlayer1.y-26,oMisc)
      efCharge.sprite_index=sMMcharging; efCharge.image_speed=0.5; efCharge.depth=15
      efCharge.type=1; efCharge.image_xscale=4; efCharge.image_yscale=4

      for(i=0;i<4;i+=1)
      {
        efStars[i]=instance_create(oPlayer1.x,oPlayer1.y-26,oMisc)
        efStars[i].sprite_index=sMMcharging; efStars[i].image_speed=0.5; efStars[i].depth=15
        efStars[i].type=1; efStars[i].image_alpha=0.4-(0.075*i)
        efStars[i].image_xscale=1+i; efStars[i].image_yscale=1+i
      }
    }
    else if sceneDelay>=41 and sceneDelay<=79
    {
      for(i=0;i<4;i+=1)
      {
        if i mod 2=0 {efStars[i].image_angle+=2*(i*2)}
        else {efStars[i].image_angle-=2*(i*2)}
      }
      efCharge.image_xscale-=0.1*gDeltaTime
      efCharge.image_yscale-=0.1*gDeltaTime
    }
    else if sceneDelay=80
    {
      with efCharge
        instance_destroy()
    }
    else if sceneDelay=95
    {
      abilMario=instance_create(oPlayer1.x,oPlayer1.y-26,oMisc)
      abilMario.sprite_index=sAN_Mario; abilMario.depth=15; abilMario.type=1
      abilMario.image_xscale=4; abilMario.image_yscale=4; abilMario.image_alpha=0.75
    }
    else if sceneDelay>=96 and sceneDelay<134
    {
      abilMario.image_xscale-=0.1*gDeltaTime
      abilMario.image_yscale-=0.1*gDeltaTime
    }
    else if sceneDelay=135
    {
      with abilMario {instance_destroy()}
    }
    else if sceneDelay=180 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"Jerry","What now?",0,1,oMessageCutscene,1)
  else if sceneProgress=3
  {
    sceneDelay+=1*gDeltaTime
    if sceneDelay=5
    {
      abilLuigi=instance_create(oPlayer1.x,oPlayer1.y-26,oMisc)
      abilLuigi.sprite_index=sAN_Luigi; abilLuigi.depth=15; abilLuigi.type=1
      abilLuigi.image_xscale=4; abilLuigi.image_yscale=4; abilLuigi.image_alpha=0.75
    }
    else if sceneDelay>=6 and sceneDelay<44
    {
      abilLuigi.image_xscale-=0.1*gDeltaTime
      abilLuigi.image_yscale-=0.1*gDeltaTime
    }
    else if sceneDelay=45
    {
      with abilLuigi {instance_destroy()}
    }
    else if sceneDelay=55
    {
      var tEffect;
      tEffect=instance_create(oPlayer1.x,oPlayer1.y-26,oEffect)
      tEffect.sprite_index=sMMchargeComplete; tEffect.image_xscale=3; tEffect.image_yscale=3
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
      with oMisc {instance_destroy()}
      sceneDelay=0; sceneProgress+=1
    }
  }
  else if sceneProgress=4 and bWaitForInput=false
  {
    playSound(global.snd_NewAbilitySet,0,1,1)
    msgCreate(112,128,"","Jerry and Claire gained the Mario Ability Set!#They can now jump on bad guys from the Mario Universe.",6,2,oMessageCutscene,1)
  }
  else if sceneProgress=5
  {
    sceneDelay+=1*gDeltaTime
    if sceneDelay>=20 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=6 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Sweet!",0,3,oMessageCutscene,1)
  else if sceneProgress=7 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","This is what you two need to get by the Hammer Bros.",0,3,oMessageCutscene,1)
  else if sceneProgress=8 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Well that was easy.",0,3,oMessageCutscene,1)
  else if sceneProgress=9 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Not quite.",0,3,oMessageCutscene,1)
  else if sceneProgress=10 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Oh of COURSE NOT!!",0,3,oMessageCutscene,1)
  else if sceneProgress=11 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","There are two things. The first is we need something else from this place. It's a chip and I'll need it for the Virus.",0,3,oMessageCutscene,1)
  else if sceneProgress=12 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Wow you know a lot about this thing.",0,3,oMessageCutscene,1)
  else if sceneProgress=13 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","It pays to be informed. Plus I can see more than you can.",0,3,oMessageCutscene,1)
  else if sceneProgress=14 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Cheater.",0,3,oMessageCutscene,1)
  else if sceneProgress=15 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","The other thing is your new ability won't work outside of this area unless you stop what's interfering with this place.",0,3,oMessageCutscene,1)
  else if sceneProgress=16 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Naturally if something has the potential to be an obstacle, it will be.",0,3,oMessageCutscene,1)
  else if sceneProgress=17 and bWaitForInput=false
    msgCreate(0,0,"Claire","Optimistic much?",0,3,oMessageCutscene,1)
  else if sceneProgress=18 and bWaitForInput=false
    msgCreate(0,0,"Jerry","You didn't see all the things that went wrong before the Virus took over.",0,3,oMessageCutscene,1)
  else if sceneProgress=19 and bWaitForInput=false
    msgCreate(0,0,"Claire","Oh don't give me that...#Anyway what's with you floating in the air?",0,3,oMessageCutscene,1)
  else if sceneProgress=20 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Cutscene powers!!",0,3,oMessageCutscene,1)
  else if sceneProgress=21 and bWaitForInput=false
    msgCreate(0,0,"Claire","I shouldn't have asked.",0,3,oMessageCutscene,1)
  else if sceneProgress=22 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Anyway, I think it's time to get a move on.",0,3,oMessageCutscene,1)
  else if sceneProgress=23
  {
    sceneDelay=0; sceneProgress=0
    var tNewChapter,tempMplay;
    tNewChapter=instance_create(0,0,oChapterDisplay)
    tNewChapter.newChapter="Chapter 2#Jerry & Claire"
    tempMplay=findMusic(101)
    playMusic(tempMplay,0,0)
    global.hasAbilToken[0]=2
    global.gameProgress=160
    global.gamePaused=false
  }
}
else if global.gameProgress=160 and room=rMario1_1 //----- [2] (Unskippable until prog 5) Flag for 1-1 -----
{
  if sceneProgress=0
  {
    if oPlayer1.x>=5344 //144-304
    {
      stopAllMusic()
      playSound(global.snd_MarioFlag,0,0.95,1)
      global.gamePaused=true
      if round(oPlayer1.y)<=160
        flagAwardCheck=300
      else if round(oPlayer1.y)>=161 and round(oPlayer1.y)<=192
        flagAwardCheck=250
      else if round(oPlayer1.y)>=193 and round(oPlayer1.y)<=224
        flagAwardCheck=200
      else if round(oPlayer1.y)>=225 and round(oPlayer1.y)<=256
        flagAwardCheck=150
      else if round(oPlayer1.y)>=257 and round(oPlayer1.y)<=288
        flagAwardCheck=100
      else if round(oPlayer1.y)>=289
        flagAwardCheck=50

      oPlayer1.x=5344
      if global.activeCharacter=0 oPlayer1.sprite_index=sJerryHang
      else if global.activeCharacter=1 oPlayer1.sprite_index=sClaireHang
      oPlayer1.image_xscale=1
      sceneProgress+=1
    }
  }
  else if sceneProgress=1
  {
    if oPlayer1.y>=304
    {
      oPlayer1.y=304
      if global.activeCharacter=0 oPlayer1.sprite_index=sJerryIdle
      else if global.activeCharacter=1 oPlayer1.sprite_index=sClaireIdle
      oPlayer1.image_speed=0.1
    }
    else {oPlayer1.y+=4*gDeltaTime}
    sceneDelay+=1*gDeltaTime
    if sceneDelay>=40 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=2
  {
    sceneDelay+=1*gDeltaTime
    if sceneDelay=19
    {
      global.msc_MarioClear=SS_LoadSound(working_directory+"\Music\DT_MarioClear.ogg",0)
      playMusic(global.msc_MarioClear,0,1)
    }
    else if sceneDelay>=20
    {
      if global.activeCharacter=0 oPlayer1.sprite_index=sJerryWalk
      else if global.activeCharacter=1 oPlayer1.sprite_index=sClaireWalk
      oPlayer1.image_speed=0.5
      sceneDelay=0
      sceneProgress+=1
    }
  }
  else if sceneProgress=3
  {
    oPlayer1.x+=7*gDeltaTime
    if oPlayer1.x>=5496
    {
      oPlayer1.x=5496
      oPlayer1.visible=false
      sceneProgress+=1
    }
  }
  else if sceneProgress=4
  {
    sceneDelay+=1*gDeltaTime
    if sceneDelay=30
    {
      if global.difficulty>=2
      {
        global.recInterEarnTotal+=flagAwardCheck
        global.pMoney+=flagAwardCheck
        oPlayer1.currentMoney+=flagAwardCheck
        if oPlayer1.currentMoney>global.pMoneyMax {oPlayer1.currentMoney=global.pMoneyMax}
        if global.pMoney>global.pMoneyMax {global.pMoney=global.pMoneyMax}
        msgCreate(128,128,"",string(flagAwardCheck) +string(" Internetz awarded."),6,0,oMessagePerson,0)
        newMessage.fadingTime=60
      }
      else
      {
        msgCreate(128,128,"","No Internetz for you on Nightmare Mode.",6,1,oMessagePerson,0)
        newMessage.fadingTime=60
      }
    }
    else if sceneDelay>=150 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Claire","Is this normal?",0,3,oMessageCutscene,1)
  else if sceneProgress=6 and bWaitForInput=false
    msgCreate(0,0,"Jerry","We're used to it.",0,3,oMessageCutscene,1)
  else if sceneProgress=7
  {
    sceneDelay+=1*gDeltaTime
    if sceneDelay>=50 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=8 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Sooooo... we gonna go anywhere or are we stuck in cutscene purgatory?",0,3,oMessageCutscene,1)
  else if sceneProgress=9 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","I don't really know?",0,3,oMessageCutscene,1)
  else if sceneProgress=10 and bWaitForInput=false
    msgCreate(0,0,"Chao","Didn't old game cartridges freeze often?",0,3,oMessageCutscene,1)
  else if sceneProgress=11 and bWaitForInput=false
    msgCreate(0,0,"Jerry","This can't freeze, it's all still running off of The Darkness.",0,3,oMessageCutscene,1)
  else if sceneProgress=12 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","There must be a bug somewhere.",0,3,oMessageCutscene,1)
  else if sceneProgress=13 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Didn't we already establish that?",0,3,oMessageCutscene,1)
  else if sceneProgress=14 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","You know what I mean!",0,3,oMessageCutscene,1)
  else if sceneProgress=15 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Wow, you've been kind of jumpy lately, you okay?",0,3,oMessageCutscene,1)
  else if sceneProgress=16 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","I'm just trying to figure out how the Virus got out is all.",0,3,oMessageCutscene,1)
  else if sceneProgress=17 and bWaitForInput=false
    msgCreate(0,0,"Jerry","What do you mean?",0,3,oMessageCutscene,1)
  else if sceneProgress=18
  {
    sceneDelay+=1*gDeltaTime
    if sceneDelay=1 {fadeColor=c_black}
    else if sceneDelay>=2 and sceneDelay<=21 {fadeAlpha+=0.05*gDeltaTime}
    else if sceneDelay>=30 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=19 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Oh there we go.",0,3,oMessageCutscene,1)
  else if sceneProgress=20
  {
    global.gamePaused=false
    global.gameProgress=170
    global.recAreaTrans+=1
    global.newMapX=96
    global.newMapY=48
    writeToPlayerGlobals()
    transition_steps=40
    transition_kind=21
    room_goto(rMario1_2)
  }
}
else if global.gameProgress=190 and room=rMario1_3 //----- [Unskippable] Enemy Trap -----
{
  if global.gamePaused=false
  {
    if sceneProgress=0
    {
      if oPlayer1.x>=1976
      {
        var enemyCounter,enemyBarrier;
        enemyCounter=instance_create(0,0,oEnemyRemain)
        enemyCounter.enemyCount=8
        enemyBarrier=instance_create(1744,0,oEnemyBarrier); enemyBarrier.image_yscale=22
        enemyBarrier=instance_create(2192,0,oEnemyBarrier); enemyBarrier.image_yscale=22
        delaySpawn(1864,144,oGoomba,2,1,1,0.33)
        delaySpawn(2072,144,oGoomba,2,1,1,0.33)
        sceneProgress+=1
      }
    }
    else if sceneProgress=1
    {
      sceneDelay+=1*gDeltaTime
      if sceneDelay=80
      {
        delaySpawn(1800,224,oGoomba,2,1,1,0.33)
        delaySpawn(2136,224,oGoomba,2,1,1,0.33)
      }
      else if sceneDelay=150
      {
        delaySpawn(1808,176,oGreenParatroopa,2,1,1,0.33)
        delaySpawn(2144,224,oGreenParatroopa,2,1,1,0.33)
      }
      else if sceneDelay=250
      {
        delaySpawn(1824,272,oGoomba,2,1,1,0.33)
        delaySpawn(2128,272,oGoomba,2,1,1,0.33)
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
        global.gameProgress=200
      }
    }
  }
}
else if global.gameProgress=200 and room=rMario1_3 //----- [3] Messed up area -----
{
  if sceneProgress=0 and oPlayer1.x>=3712
  {
    sceneDelay+=1*gDeltaTime
    if sceneDelay=1
      global.gamePaused=true
    else if sceneDelay>=2
    {
      oPlayer1.y+=4*gDeltaTime
      if oPlayer1.y>=176
      {
        scenePChk(oPlayer1.x,176,0,0.1,1)
        sceneDelay=0
        sceneProgress+=1
      }
    }
  }
  else if sceneProgress=1
  {
    sceneDelay+=1*gDeltaTime
    if sceneDelay>=15 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"Claire","Is it supposed to look like that?",0,3,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Doubt it.",0,3,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","There's really nothing to worry about, you just don't get a flag bonus.",0,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Jerry","That's disappointing.",0,3,oMessageCutscene,1)
  else if sceneProgress=6
  {
    global.gamePaused=false
    global.gameProgress=210
  }
}
else if global.gameProgress=210 and room=rMario1_4 //----- [Assist] About Assist Mode -----
{
  if sceneProgress=0
  {
    sceneDelay+=1*gDeltaTime
    if sceneDelay=1 {global.gamePaused=true}
    else if sceneDelay>=15 {sceneDelay=0; sceneProgress+=1}
  }

  if global.bNightmareMode=0 //Normal Mode
  {
    if sceneProgress=1 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","Before you go any further, I've got something I want to tell you about. Something that may aid you at times, should you want it.",0,3,oMessageCutscene,1)
    else if sceneProgress=2 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","If things get too rough, there's a way to tone things down a bit. That said, I don't recommend using it much, if at all. On the Game Over menu, you can change the game mode now.",0,3,oMessageCutscene,1)
    else if sceneProgress=3 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","You are currently in Standard Mode. Everything is as it should be under this setting. However, if you need some assistance, you can place things under Assist Mode.",0,3,oMessageCutscene,1)
    else if sceneProgress=4 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","In Assist Mode, you will take half damage from every source. Helpful if you need just a bit more leeway at times. However, there are a lot of penalties under this setting. I would recommend only using it for a short time if needed.",0,3,oMessageCutscene,1)
    else if sceneProgress=5 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","You will gain no AP or money drops from enemies while in this mode. You will also be unable to pickup any collectibles. Use it sparingly. It will also automatically turn off when you exit a map.",0,3,oMessageCutscene,1)
    else if sceneProgress=6 and bWaitForInput=false
      msgCreate(0,0,"Jerry","So it's supposed to be a temporary help then, got it.",0,3,oMessageCutscene,1)
  }
  else if global.bNightmareMode=1 //Nightmare Mode
  {
    if sceneProgress=1 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","This is where I would tell you about Assist Mode, but you're playing on Nightmare mode, so... yeah, you're screwed.",0,3,oMessageCutscene,1)
    else if sceneProgress=2 and bWaitForInput=false
      msgCreate(0,0,"Jerry","Thanks for the encouragement.",0,3,oMessageCutscene,1)
    else if sceneProgress=3 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","Always thinking of you, buddy. <3",0,3,oMessageCutscene,1)
    else if sceneProgress=4 and bWaitForInput=false
      msgCreate(0,0,"Jerry","<3",0,3,oMessageCutscene,1)
    else if sceneProgress=5 {sceneProgress=7}
  }

  if sceneProgress=7
  {
    if global.bNightmareMode=0 {global.easyModeUnlocked=1}
    global.gamePaused=false
    global.gameProgress=220
  }
}
else if global.gameProgress=230 and room=rMario1_4Boss //----- [Unskippable] Boss Fight: Bowser -----
{
  if global.bossTrack=0
  {
    if sceneProgress=0 and oPlayer1.x>=720
    {
      viewFix=instance_create(720,176,oMisc)
      viewFix.type=0
      viewFix.sprite_index=sNull
      view_object[0]=viewFix
      sceneProgress+=1
    }
    else if sceneProgress=1
    {
      sceneDelay+=1*gDeltaTime
      if sceneDelay=15
      {
        instance_create(560,192,oBossBarrier)
        boss=instance_create(816,0,oBowser)
        var tBossTitle,tempMplay;
        tBossTitle=instance_create(0,0,oBossNameDisplay)
        tBossTitle.bossName="Bowser"
        tBossTitle.bossTitle="King of the Koopas"
        tempMplay=findMusic(801)
        playMusic(tempMplay,0,0)
      }
      else if sceneDelay>=16
      {
        boss.y+=8*gDeltaTime
        if boss.y>=272
        {
          boss.activateBoss=1
          global.currentBoss="Bowser"
          global.bossTrack=1
          sceneDelay=0; sceneProgress=0
        }
      }
    }
  }
  else if global.bossTrack=1
  {
    if sceneProgress=1 //End Boss
    {
      view_object[0]=oPlayer1
      with oMisc {instance_destroy()}
      var tFullHeartDrop;
      tFullHeartDrop=instance_create(832,112,oHealthPickup)
      tFullHeartDrop.sprite_index=sFullHealthPickup
      awardBossAP(100)
      var tempMplay;
      tempMplay=findMusic(102)
      playMusic(tempMplay,0,0)
      with oBossBarrier {instance_destroy()}
      sceneProgress=0
      global.currentBoss=""
      global.bossTrack=0
      global.gameProgress=240
    }
  }
}
else if global.gameProgress=250 and room=rMario1_4Story //----- [4] Cackletta takes the Program Chip -----
{
  if sceneProgress=0 and oPlayer1.x>=208
  {
    sceneDelay+=1*gDeltaTime
    if sceneDelay=1
    {
      global.gamePaused=true
      fadeAlpha=1
      pChip=instance_create(208,176,oProgramChip)
      pChip.chipType=0
      stopPlayer()
      oPlayer1.visible=0
      charJerry=instance_create(232,288,oMisc)
      charJerry.sprite_index=sJerryIdle; charJerry.image_speed=0.1
      charJerry.image_xscale=-1; charJerry.type=2
      charClaire=instance_create(184,288,oMisc)
      charClaire.sprite_index=sClaireIdle; charClaire.image_speed=0.1; charClaire.type=2
    }
    else if sceneDelay>=30
    {
      fadeAlpha-=0.02*gDeltaTime
      if fadeAlpha<=0 {sceneDelay=0; sceneProgress+=1}
    }
  }
  else if sceneProgress=1
  {
    sceneDelay+=1*gDeltaTime
    if sceneDelay>=15 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"Claire","What is that thing?",0,3,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","It's what I wanted you two to come in here to get.",0,3,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Is this that chip you mentioned?",0,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Yes, it's called a Program Chip. It will allow me to decode the encryption on the Virus' protection. Without this, it's virtually impossible to get through it.",0,3,oMessageCutscene,1)
  else if sceneProgress=6 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Wait a minute, if you can do that, can't you remove the Virus yourself then? If that's the only thing stopping you that is.",0,3,oMessageCutscene,1)
  else if sceneProgress=7 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","That's exactly what I plan to do.",0,3,oMessageCutscene,1)
  else if sceneProgress=8 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Oh well that was easy.",0,3,oMessageCutscene,1)
  else if sceneProgress=9 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Yep, just grab it and I shall commence with the hacking.",0,3,oMessageCutscene,1)
  else if sceneProgress=10 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Sweet, this was easier than taking on The Darkness.",0,3,oMessageCutscene,1)
  else if sceneProgress=11
  {
    sceneDelay+=1*gDeltaTime
    if sceneDelay>=11 and sceneDelay<=30 and current_frame mod 2 == 0 //QWH, added current_frame check here, might get stuck
      pChip.y+=1
    else if sceneDelay=31
    {
      fadeAlpha=1
      charCackletta=instance_create(208,212,oMisc)
      charCackletta.sprite_index=sCacklettaIdle
      charCackletta.image_speed=0.15; charCackletta.type=1
      charJerry.sprite_index=sJerryLookUp
    }
    else if sceneDelay=34
      fadeAlpha=0
    else if sceneDelay>=45 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=12 and bWaitForInput=false
    msgCreate(0,0,"Jerry","What the hell?",0,3,oMessageCutscene,1)
  else if sceneProgress=13 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","She's trying to take the Chip!",0,3,oMessageCutscene,1)
  else if sceneProgress=14 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Oh that is not happening!",0,3,oMessageCutscene,1)
  else if sceneProgress=15
  {
    sceneDelay+=1*gDeltaTime
    if sceneDelay=1
    {
      charCackletta.sprite_index=sCacklettaLaugh
      charCackletta.image_speed=0.33
    }
    else if sceneDelay=9
    {
      charJerry.sprite_index=sJerryJump
      var tEffect;
      tEffect=instance_create(charJerry.x,charJerry.y+2,oEffect)
      tEffect.sprite_index=sSpellCast; tEffect.image_xscale=0.6; tEffect.image_yscale=0.6
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    }
    else if sceneDelay>=10 and sceneDelay<=17
    {
      charJerry.x-=1*gDeltaTime
      charJerry.y-=7*gDeltaTime
    }
    else if sceneDelay=18
    {
      fadeAlpha=1
      with charCackletta {instance_destroy()}
      with oProgramChip {instance_destroy()}
      charJerry.x=272
      charJerry.y=288
      scenePCanim(charJerry,0,sJerryGetUp,1,0,0,0,0,0)
    }
    else if sceneDelay>=45
    {
      fadeAlpha-=0.02*gDeltaTime
      if fadeAlpha<=0 {sceneDelay=0; sceneProgress+=1}
    }
  }
  else if sceneProgress=16
  {
    sceneDelay+=1*gDeltaTime
    if sceneDelay>=15 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=17 and bWaitForInput=false
    msgCreate(0,0,"Jerry","I know, I know. She got away.",0,3,oMessageCutscene,1)
  else if sceneProgress=18
  {
    sceneDelay+=1*gDeltaTime
    if sceneDelay>=5
    {
      scenePCanim(charJerry,1,sJerryGetUp,1,0.1,3.7,sJerryIdle,0,0.1)
      sceneDelay=0; sceneProgress+=1
    }
  }
  else if sceneProgress=19 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","We need that Chip, chase her!",0,3,oMessageCutscene,1)
  else if sceneProgress=20 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Oh we plan on it!",0,3,oMessageCutscene,1)
  else if sceneProgress=21 and bWaitForInput=false
    msgCreate(0,0,"Claire","Let's get her, Jerry!",0,3,oMessageCutscene,1)
  else if sceneProgress=22
  {
    var tFlash;
    tFlash=instance_create(0,0,oScreenFlash); tFlash.fadeSpeed=0.2
    oPlayer1.visible=1
    if global.activeCharacter=0 oPlayer1.x=charJerry.x
    else if global.activeCharacter=1 oPlayer1.x=charClaire.x
    with oMisc {instance_destroy()}
    global.gamePaused=false
    global.gameProgress=260
  }
}
else if global.gameProgress=270 and room=rMario1_5 //----- [5] About AP and Skill Points -----
{
  if sceneProgress=0
  {
    sceneDelay+=1*gDeltaTime
    if sceneDelay=1 {global.gamePaused=true}
    else if sceneDelay>=15 {sceneDelay=0; sceneProgress+=1}
  }

  if global.bNightmareMode=0 //Normal Mode
  {
    if sceneProgress=1 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","Hold up, I haven't explained Ability Points (AP) yet.",0,3,oMessageCutscene,1)
    else if sceneProgress=2 and bWaitForInput=false
      msgCreate(0,0,"Jerry","Is there even a fourth wall left?",0,3,oMessageCutscene,1)
    else if sceneProgress=3 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","...So yeah, AP is earned after defeating enemies, it's that little number that appears after you stomped on all those Goombas. When enough AP is earned, you will boost your AP Level. Leveling up will award you 5 Skill Points.",0,3,oMessageCutscene,1)
    else if sceneProgress=4 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","These Skill Points can then be spent in the 'Skill Tree' submenu. A few things about that...",0,3,oMessageCutscene,1)
    else if sceneProgress=5 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","The red nodes are gate locks, only after a specified gate is unlocked and the previous skill bought, can you buy or view any skills past the red node. When the node is blue, that means all requirements for it have been met.",0,3,oMessageCutscene,1)
    else if sceneProgress=6 and bWaitForInput=false
      msgCreate(0,0,"Jerry","Anything else we should know?",0,3,oMessageCutscene,1)
    else if sceneProgress=7 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","If you scan an enemy, you will notice the 'Power Level' category. This is essentially the enemy's AP Level. If your AP Level is above theirs, the AP Award they give is reduced, but...",0,3,oMessageCutscene,1)
    else if sceneProgress=8 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","If your AP Level is below theirs... well you get the idea.",0,3,oMessageCutscene,1)
    else if sceneProgress=9 and bWaitForInput=false
      msgCreate(0,0,"Jerry","Anything el... actually I lost interest, let's move on.",0,3,oMessageCutscene,1)
    else if sceneProgress=10 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","I agree.",0,3,oMessageCutscene,1)
  }
  else if global.bNightmareMode=1 //Nightmare Mode
  {
    if sceneProgress=1 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","Here's where I would explain Ability Points, but you're on Nightmare Mode so what's the point?",0,3,oMessageCutscene,1)
    else if sceneProgress=2 and bWaitForInput=false
      msgCreate(0,0,"Jerry","There isn't one.",0,3,oMessageCutscene,1)
    else if sceneProgress=3 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","Good, then lets move on.",0,3,oMessageCutscene,1)
    else if sceneProgress=4 {sceneProgress=11}
  }

  if sceneProgress=11
  {
    global.gamePaused=false
    global.gameProgress=280
  }
}
else if global.gameProgress=290 and room=rMario1_5Hub //----- [6] Toad house -----
{
  if sceneProgress=0
  {
    sceneDelay+=1*gDeltaTime
    if sceneDelay=1 {global.gamePaused=true}
    else if sceneDelay>=15 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=1 and bWaitForInput=false
    msgCreate(0,0,"Claire","What is this?",0,3,oMessageCutscene,1)
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"Chao","A few toads live here.",0,3,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Will they be any help?",0,3,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Chao","About as helpful as a standard NPC could be.",0,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","As a reminder, you can talk with people by pressing [Up] near them.",0,3,oMessageCutscene,1)
  else if sceneProgress=6
  {
    global.gamePaused=false
    global.gameProgress=300
  }
}
else if global.gameProgress=330 and room=rMario1_8 //----- [7] Finding your friends -----
{
  if sceneProgress=0 and oPlayer1.x>=176
  {
    sceneDelay+=1*gDeltaTime
    if sceneDelay=1 {global.gamePaused=true}
    oPlayer1.y+=4*gDeltaTime
    if oPlayer1.y>=256
    {
      scenePChk(oPlayer1.x,256,0,0.1,1)
      stopPlayer()
      sceneProgress+=1
    }
  }
  else if sceneProgress=1
  {
    sceneDelay+=1*gDeltaTime
    if sceneDelay>=15 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Hold on. Up ahead is a small fortress owned by the Hammer Bros. I'm sure the key we need is in there, but be careful.",0,3,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Jerry","It'll be no problem.",0,3,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Claire","We've both dealt with worse.",0,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Jerry","It's true, though... I have a question, Claire. How did you know there was a problem back on that island where we tracked the Virus?",0,3,oMessageCutscene,1)
  else if sceneProgress=6 and bWaitForInput=false
    msgCreate(0,0,"Claire","Chao told me about it. She said it was making the world act funny.",0,3,oMessageCutscene,1)
  else if sceneProgress=7 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Did you know that I was going to be there? I mean I'm sure you heard about everything that me and Jeremy had done before all that.",0,3,oMessageCutscene,1)
  else if sceneProgress=8 and bWaitForInput=false
    msgCreate(0,0,"Chao","Jeremy and I.",0,3,oMessageCutscene,1)
  else if sceneProgress=9 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Right.",0,3,oMessageCutscene,1)
  else if sceneProgress=10 and bWaitForInput=false
    msgCreate(0,0,"Claire","I wasn't trying to find you if that's what you're implying.",0,3,oMessageCutscene,1)
  else if sceneProgress=11 and bWaitForInput=false
    msgCreate(0,0,"Jerry","But did you figure I would be there?",0,3,oMessageCutscene,1)
  else if sceneProgress=12 and bWaitForInput=false
    msgCreate(0,0,"Claire","I had my suspicions.",0,3,oMessageCutscene,1)
  else if sceneProgress=13 and bWaitForInput=false
    msgCreate(0,0,"Jerry","So...",0,3,oMessageCutscene,1)
  else if sceneProgress=14 and bWaitForInput=false
    msgCreate(0,0,"Claire","No Jerry, it had nothing to do with you.",0,3,oMessageCutscene,1)
  else if sceneProgress=15 and bWaitForInput=false
    msgCreate(0,0,"Chao","I knew he would be. I can track anything my brother does, his style stands out. Where Jeremy is, Jerry is close by.",0,3,oMessageCutscene,1)
  else if sceneProgress=16 and bWaitForInput=false
    msgCreate(0,0,"Jerry","So you admit to stalking.",0,3,oMessageCutscene,1)
  else if sceneProgress=17 and bWaitForInput=false
    msgCreate(0,0,"Chao","No! I was trying to find Jeremy.",0,3,oMessageCutscene,1)
  else if sceneProgress=18 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Really sis?",0,3,oMessageCutscene,1)
  else if sceneProgress=19 and bWaitForInput=false
    msgCreate(0,0,"Chao","Well... yeah. Ever since you two got that job, we never got to see each other again and then this whole thing happened. I searched everywhere in here to find you.",0,3,oMessageCutscene,1)
  else if sceneProgress=20 and bWaitForInput=false
    msgCreate(0,0,"Chao","When I heard it was you that befriended the program, I knew we would find you on the island, when everything that was wrong pointed there. I wanted to see you again.",0,3,oMessageCutscene,1)
  else if sceneProgress=21 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Why didn't you say something?",0,3,oMessageCutscene,1)
  else if sceneProgress=22 and bWaitForInput=false
    msgCreate(0,0,"Chao","You were busy with your life, I couldn't just...",0,3,oMessageCutscene,1)
  else if sceneProgress=23 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Hold on, I'm not trying to be rude, but I think we should move on.",0,3,oMessageCutscene,1)
  else if sceneProgress=24 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","We'll talk later Chao. Don't want Cackletta getting too far with the Chip.",0,3,oMessageCutscene,1)
  else if sceneProgress=25 and bWaitForInput=false
    msgCreate(0,0,"Chao","Yeah...",0,3,oMessageCutscene,1)
  else if sceneProgress=26
  {
    global.gamePaused=false
    global.gameProgress=340
  }
}
else if global.gameProgress=360 and room=rMario1_HFb //----- [8] Annoying room -----
{
  if sceneProgress=0
  {
    sceneDelay+=1*gDeltaTime
    if sceneDelay=1 {global.gamePaused=true}
    else if sceneDelay>=15 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=1 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","This room is going to be annoying.",0,3,oMessageCutscene,1)
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"Claire","How do you know?",0,3,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Chao","Oh he knows.",0,3,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Jeremy always knows.",0,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Claire","Forget I asked.",0,3,oMessageCutscene,1)
  else if sceneProgress=6
  {
    global.gamePaused=false
    global.gameProgress=370
  }
}
else if global.gameProgress=380 and room=rMario1_HFc //----- [Unskippable] Enemy Trap -----
{
  if global.gamePaused=false
  {
    if sceneProgress=0
    {
      if oPlayer1.x>=680
      {
        var enemyCounter,enemyBarrier;
        enemyCounter=instance_create(0,0,oEnemyRemain)
        enemyCounter.enemyCount=9

        oPlayer1.x-=32
        enemyBarrier=instance_create(272,256,oEnemyBarrier); enemyBarrier.image_yscale=4
        enemyBarrier=instance_create(672,64,oEnemyBarrier); enemyBarrier.image_yscale=4
        sceneProgress+=1
      }
    }
    else if sceneProgress=1
    {
      sceneDelay+=1*gDeltaTime
      if sceneDelay=30
      {
        delaySpawn(320,192,oBoomerBro,2,1,1,0.33)
        delaySpawn(640,192,oHammerBro,2,1,1,0.33)
      }
      else if sceneDelay=140
      {
        delaySpawn(432,320,oHammerBro,2,1,1,0.33)
        delaySpawn(528,320,oBoomerBro,2,1,1,0.33)
      }
      else if sceneDelay=230
      {
        delaySpawn(320,192,oFireBro,2,1,1,0.33)
        delaySpawn(640,192,oFireBro,2,1,1,0.33)
        sceneDelay=0; sceneProgress+=1
      }
    }
    else if sceneProgress=2
    {
      if oEnemyRemain.enemyCount<=5 {sceneProgress+=1}
    }
    else if sceneProgress=3
    {
      sceneDelay+=1*gDeltaTime
      if sceneDelay=30
        delaySpawn(480,128,oHammerBro,2,1,1,0.33)
      else if sceneDelay=50
      {
        delaySpawn(384,96,oFireBro,2,1,1,0.33)
        delaySpawn(576,96,oBoomerBro,2,1,1,0.33)
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
        global.gameProgress=390
      }
    }
  }
}
else if global.gameProgress=401 and room=rMario1_9Shop //----- [9] Shop & Item Explanation (Optional) -----
{
  if sceneProgress=0
  {
    sceneDelay+=1*gDeltaTime
    if sceneDelay=1 {global.gamePaused=true}
    else if sceneDelay>=15 {sceneDelay=0; sceneProgress+=1}
  }

  if global.bNightmareMode=0 //Normal Mode
  {
    if sceneProgress=1 and bWaitForInput=false
      msgCreate(0,0,"Chao","Oh you found a shop!",0,3,oMessageCutscene,1)
    else if sceneProgress=2 and bWaitForInput=false
      msgCreate(0,0,"Jerry","Here we go, Chao and her...",0,3,oMessageCutscene,1)
    else if sceneProgress=3 and bWaitForInput=false
      msgCreate(0,0,"Claire","Shut it, Jerry!#Chao, how does this work here?",0,3,oMessageCutscene,1)
    else if sceneProgress=4 and bWaitForInput=false
      msgCreate(0,0,"Chao","Easy enough, just approach a shop owner and press [Up] to open the shop window, from there, it's pretty self explanatory.",0,3,oMessageCutscene,1)
    else if sceneProgress=5 and bWaitForInput=false
      msgCreate(0,0,"Jerry","I didn't need an explanation for shops back in the day.",0,3,oMessageCutscene,1)
    else if sceneProgress=6 and bWaitForInput=false
      msgCreate(0,0,"Chao","Continuing to ignore Jerry... The shop keeper up there sells equipment. Over there is a vending machine that you can use to fill a bottle with life restoring substances. Don't ask, I don't get it either, but that's how it works.",0,3,oMessageCutscene,1)
    else if sceneProgress=7 and bWaitForInput=false
      msgCreate(0,0,"Claire","Speaking of equipment and consumables. How do they work?",0,3,oMessageCutscene,1)
    else if sceneProgress=8 and bWaitForInput=false
      msgCreate(0,0,"Jerry","That's easy, you just go to your Items tab, select Skittles and BAM! You're done.",0,3,oMessageCutscene,1)
    else if sceneProgress=9 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","Jerry... I hate to be the bearer of bad news but... it doesn't work like that anymore.",0,3,oMessageCutscene,1)
    else if sceneProgress=10 and bWaitForInput=false
      msgCreate(0,0,"Jerry","Ugh, fine then, explain.",0,3,oMessageCutscene,1)
    else if sceneProgress=11 and bWaitForInput=false
      msgCreate(0,0,"Chao","Press [Confirm] while selecting the 'Equipment' submenu.",0,3,oMessageCutscene,1)
    else if sceneProgress=12 and bWaitForInput=false
      msgCreate(0,0,"Chao","For consumables, press [Up]. From there, you can select to use what's in any available bottle. It seems you can't use items during boss encounters for some reason.",0,3,oMessageCutscene,1)
    else if sceneProgress=13 and bWaitForInput=false
      msgCreate(0,0,"Chao","Your equipable item slots are at the bottom of the menu. At this time, all but one are locked. You can unlock more equipment slots by finding their unlocks usually near stores like this.",0,3,oMessageCutscene,1)
    else if sceneProgress=14 and bWaitForInput=false
      msgCreate(0,0,"Chao","The menu has more contextual info on how equipping and removing equipment goes.",0,3,oMessageCutscene,1)
    else if sceneProgress=15 and bWaitForInput=false
      msgCreate(0,0,"Chao","And that's it for the basics. You'll figure the rest out on your own.",0,3,oMessageCutscene,1)
    else if sceneProgress=16 and bWaitForInput=false
      msgCreate(0,0,"Chao","Oh yeah! The first bottle you buy will be filled already with an Energy Drink, which restores half of your hearts.",0,3,oMessageCutscene,1)
  }
  else if global.bNightmareMode=1 //Nightmare Mode
  {
    if sceneProgress=1 and bWaitForInput=false
      msgCreate(0,0,"Jerry","Hey look, the place where we buy potions and such, but we can't get money on Nightmare Mode so there's no point in explaining this.",0,3,oMessageCutscene,1)
    else if sceneProgress=2 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","I guess you knew!",0,3,oMessageCutscene,1)
    else if sceneProgress=3 and bWaitForInput=false
      msgCreate(0,0,"Jerry","Duh! Video Games!",0,3,oMessageCutscene,1)
    else if sceneProgress=4 {sceneProgress=17}
  }

  if sceneProgress=17
  {
    global.gamePaused=false
    sceneProgress=0
    global.gameProgress=402
  }
}
else if global.gameProgress=420 and room=rMario1_11 //----- [10] Almost to Cackletta's Castle -----
{
  if sceneProgress=0
  {
    sceneDelay+=1*gDeltaTime
    if sceneDelay=1 {global.gamePaused=true}
    else if sceneDelay>=15 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=1 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","You're almost to her castle. It's up in the sky.",0,3,oMessageCutscene,1)
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"Claire","Jeremy, can't you access a lot of the functions in the program? Couldn't you teleport us to where we need to go?",0,3,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","The Darkness gave me access to nearly all of the high level functions, but since the Virus came in, I haven't been able to use many of them.",0,3,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Claire","That Program Chip should help you restore The Darkness' functions and control right?",0,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","That's the theory. You guys have to get it first.",0,3,oMessageCutscene,1)
  else if sceneProgress=6 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Won't be a problem.",0,3,oMessageCutscene,1)
  else if sceneProgress=7 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Get out there then.",0,3,oMessageCutscene,1)
  else if sceneProgress=8 and bWaitForInput=false
    msgCreate(0,0,"Jerry","I just realized we're never going to catch the last episode of the best show ever.",0,3,oMessageCutscene,1)
  else if sceneProgress=9 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","And now I'm depressed.",0,3,oMessageCutscene,1)
  else if sceneProgress=10
  {
    global.gamePaused=false
    global.gameProgress=430
  }
}
else if global.gameProgress=440 and room=rMario1_CCa //----- [11] Inside Cackletta's Castle -----
{
  if sceneProgress=0
  {
    sceneDelay+=1*gDeltaTime
    if sceneDelay=1 {global.gamePaused=true}
    else if sceneDelay>=15 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=1 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Aha! We're in!",0,3,oMessageCutscene,1)
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"Claire","This looks like the other two generic castles we were in.",0,3,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Picky!",0,3,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Claire","It's not being picky, Cackletta has no taste!",0,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","O-kay, so. Be a bit more careful in here, I'm not seeing any recovery points except for room entrances.",0,3,oMessageCutscene,1)
  else if sceneProgress=6 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Eh, we got this.",0,3,oMessageCutscene,1)
  else if sceneProgress=7
  {
    global.gamePaused=false
    global.gameProgress=450
  }
}
else if global.gameProgress=460 and room=rMario1_CCb //----- [12] J&C random gibberish -----
{
  if sceneProgress=0
  {
    sceneDelay+=1*gDeltaTime
    if sceneDelay=1 {global.gamePaused=true}
    else if sceneDelay>=15 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=1 and bWaitForInput=false
    msgCreate(0,0,"Jerry","This is going to be a fantastic room. Luckily you're the one doing it Claire.",0,3,oMessageCutscene,1)
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"Claire","I can always swap out.",0,3,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Jerry","And then I can do the same!",0,3,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Claire","Oh but Jerry, don't you want to show off your amazing skill?!",0,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Well when you put it that way...",0,3,oMessageCutscene,1)
  else if sceneProgress=6 and bWaitForInput=false
    msgCreate(0,0,"Claire","Oh so you WILL do this part?~",0,3,oMessageCutscene,1)
  else if sceneProgress=7 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Of course!",0,3,oMessageCutscene,1)
  else if sceneProgress=8 and bWaitForInput=false
    msgCreate(0,0,"Claire","So noble.",0,3,oMessageCutscene,1)
  else if sceneProgress=9 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","So whipped.",0,3,oMessageCutscene,1)
  else if sceneProgress=10
  {
    global.canCharSwap=1
    charSwitcher(0)
    global.gamePaused=false
    global.gameProgress=470
  }
}
else if global.gameProgress=500 and room=rMario1_CCBoss //----- [13] Boss Fight: Cackletta -----
{
  if global.bossTrack=0
  {
    if sceneProgress=0 and oPlayer1.x>=400
    {
      sceneDelay+=1*gDeltaTime
      if sceneDelay=1
        global.gamePaused=true
      oPlayer1.y+=4*gDeltaTime
      if oPlayer1.y>=272
      {
        scenePChk(oPlayer1.x,272,0,0.1,1)
        stopPlayer()
        sceneDelay=0; sceneProgress+=1
      }
    }
    else if sceneProgress=1
    {
      sceneDelay+=1*gDeltaTime
      if sceneDelay=10
      {
        viewFix=instance_create(400,176,oMisc)
        viewFix.type=0
        viewFix.sprite_index=sNull
        view_object[0]=viewFix
      }
      else if sceneDelay>=11 and sceneDelay<=50
        viewFix.x+=4*gDeltaTime //QWH not sure if this is good
      if sceneDelay>=70
      {
        sceneDelay=0
        sceneProgress+=1
      }
    }
    else if sceneProgress=2 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","She's here, get ready.",0,3,oMessageCutscene,1)
    else if sceneProgress=3
    {
      sceneDelay+=1*gDeltaTime
      if sceneDelay=1
      {
        boss=instance_create(464,176,oCackletta)
        boss.image_alpha=0
      }
      else if sceneDelay>=11 and sceneDelay<=30
        boss.image_alpha+=0.05*gDeltaTime
      else if sceneDelay>=50 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=4 and bWaitForInput=false
      msgCreate(0,0,"Jerry","She's really ugly.",0,3,oMessageCutscene,1)
    else if sceneProgress=5 and bWaitForInput=false
      msgCreate(0,0,"Claire","Tell me about it! I never looked that bad on my worst days.",0,3,oMessageCutscene,1)
    else if sceneProgress=6 and bWaitForInput=false
      msgCreate(0,0,"Jerry","Oh I'm pretty sure I can prove that one wrong.",0,3,oMessageCutscene,1)
    else if sceneProgress=7 and bWaitForInput=false
      msgCreate(0,0,"Claire","You really want to get hurt, don't you?",0,3,oMessageCutscene,1)
    else if sceneProgress=8 and bWaitForInput=false
      msgCreate(0,0,"Jerry","Ehhh, no, not really. Too far?",0,3,oMessageCutscene,1)
    else if sceneProgress=9 and bWaitForInput=false
      msgCreate(0,0,"Claire","Not yet, Jerry.",0,3,oMessageCutscene,1)
    else if sceneProgress=10 and bWaitForInput=false
      msgCreate(0,0,"Jerry","Sooo, you wanna fight her? Cause I really don't.",0,3,oMessageCutscene,1)
    else if sceneProgress=11 and bWaitForInput=false
      msgCreate(0,0,"Claire","Why, what's up?",0,3,oMessageCutscene,1)
    else if sceneProgress=12 and bWaitForInput=false
      msgCreate(0,0,"Jerry","Eh, she's gross.",0,3,oMessageCutscene,1)
    else if sceneProgress=13 and bWaitForInput=false
      msgCreate(0,0,"Claire","You took out that gross virus thing on that island.",0,3,oMessageCutscene,1)
    else if sceneProgress=14 and bWaitForInput=false
      msgCreate(0,0,"Jerry","That's... true. Just not feeling it. Besides, didn't Jeremy say you move faster, that's probably going to be better.",0,3,oMessageCutscene,1)
    else if sceneProgress=15 and bWaitForInput=false
      msgCreate(0,0,"Claire","Whatever Jerry, it's cool. I got this.",0,3,oMessageCutscene,1)
    else if sceneProgress=16 and bWaitForInput=false
      msgCreate(0,0,"Jerry","I mean, I'm still more awesome though.",0,3,oMessageCutscene,1)
    else if sceneProgress=17 and bWaitForInput=false
      msgCreate(0,0,"Claire","OH REALLY?!",0,3,oMessageCutscene,1)
    else if sceneProgress=18
    {
      if view_object=oPlayer1
      {
        viewFix=instance_create(400,176,oMisc)
        viewFix.type=0; viewFix.sprite_index=sNull
        view_object[0]=viewFix
      }
      viewFix.x=464
      global.gamePaused=false
      global.canCharSwap=0
      charSwitcher(1)
      instance_create(272,208,oBossBarrier)
      if !instance_exists(oCackletta) {boss=instance_create(464,176,oCackletta)}
      boss.activateBoss=1
      boss.image_alpha=1
      global.currentBoss="Cackletta"
      global.bossTrack=1
      var tBossTitle,tempMplay;
      tBossTitle=instance_create(0,0,oBossNameDisplay)
      tBossTitle.bossName="Cackletta"
      tBossTitle.bossTitle="Beany Babe"
      tempMplay=findMusic(801)
      playMusic(tempMplay,0,0)
      SS_SetSoundFreq(global.msc_BowserFight,21550)
      sceneDelay=0; sceneProgress=0
    }
  }
  else if global.bossTrack=1
  {
    if !instance_exists(oCackletta) and sceneProgress=0 //End Boss
    {
      global.gamePaused=true
      awardBossAP(250)
      with oBossBarrier {instance_destroy()}
      stopAllMusic()
      global.bossTrack=2
    }
  }
  else if global.bossTrack=2
  {
    if sceneProgress=0
    {
      if fadeAlpha<1 {fadeAlpha+=0.05*gDeltaTime}
      else if fadeAlpha>=1 {sceneProgress+=1}
    }
    else if sceneProgress=1
    {
      sceneDelay+=1*gDeltaTime
      if sceneDelay=1
      {
        endBoss()
        scenePChk(464,272,0,0.1,1)
        view_object[0]=oPlayer1
        with oMisc {instance_destroy()}
        oPlayer1.visible=0
        charJerry=instance_create(496,272,oMisc)
        charJerry.sprite_index=sJerryIdle; charJerry.image_speed=0.1
        charJerry.image_xscale=-1; charJerry.type=2
        charClaire=instance_create(432,272,oMisc)
        charClaire.sprite_index=sClaireIdle; charClaire.image_speed=0.1; charClaire.type=2
      }
      if sceneDelay>=60 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=2
    {
      if fadeAlpha>0 {fadeAlpha-=0.05*gDeltaTime}
      else if fadeAlpha<=0 {sceneProgress+=1}
    }
    else if sceneProgress=3
    {
      sceneDelay+=1*gDeltaTime
      if sceneDelay>=25 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=4 and bWaitForInput=false
      msgCreate(0,0,"Jerry","You didn't do too bad there, Claire. Good job.",0,3,oMessageCutscene,1)
    else if sceneProgress=5 and bWaitForInput=false
      msgCreate(0,0,"Claire","Thanks, she had nothing on me.",0,3,oMessageCutscene,1)
    else if sceneProgress=6 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","Get ready for the Chip.",0,3,oMessageCutscene,1)
    else if sceneProgress=7
    {
      sceneDelay+=1*gDeltaTime
      if sceneDelay=20
      {
        pChip=instance_create(464,160,oProgramChip)
        pChip.chipType=0; pChip.visible=0
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
    else if sceneProgress=8 and bWaitForInput=false
      msgCreate(0,0,"Jerry","This time, hopefully no one comes and snatches it away.",0,3,oMessageCutscene,1)
    else if sceneProgress=9
    {
      sceneDelay+=1*gDeltaTime
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
    else if sceneProgress=10 and bWaitForInput=false
      msgCreate(0,0,"Jerry","So with that, we can stop the Virus?",0,3,oMessageCutscene,1)
    else if sceneProgress=11 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","How many times have I said that?",0,3,oMessageCutscene,1)
    else if sceneProgress=12 and bWaitForInput=false
      msgCreate(0,0,"Jerry","I think three if you explained it again.",0,3,oMessageCutscene,1)
    else if sceneProgress=13 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","Alright, hold on you guys, I'm going to plug this into my hacking tools. Things might get a little weird, and I'm not sure how fast this will take effect. We're also gonna have to hope that The Darkness' memory is intact.",0,3,oMessageCutscene,1)
    else if sceneProgress=14 and bWaitForInput=false
      msgCreate(0,0,"Chao","With you on the job, I'm sure things will be fine.",0,3,oMessageCutscene,1)
    else if sceneProgress=15 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","... Yeah.",0,3,oMessageCutscene,1)
    else if sceneProgress=16 and bWaitForInput=false
      msgCreate(0,0,"Jerry","So Claire, do we make a decent team or what? We DID just save the world together.",0,3,oMessageCutscene,1)
    else if sceneProgress=17 and bWaitForInput=false
      msgCreate(0,0,"Claire","Yeah, we did well... especially me at the end!",0,3,oMessageCutscene,1)
    else if sceneProgress=18 and bWaitForInput=false
      msgCreate(0,0,"Jerry","That's supposed to be my thing.",0,3,oMessageCutscene,1)
    else if sceneProgress=19 and bWaitForInput=false
      msgCreate(0,0,"Claire","I'm kidding. Go us! We got through all this.",0,3,oMessageCutscene,1)
    else if sceneProgress=20 and bWaitForInput=false
      msgCreate(0,0,"Jerry","Ever thought about us being a team again?",0,3,oMessageCutscene,1)
    else if sceneProgress=21 and bWaitForInput=false
      msgCreate(0,0,"Claire","Eh, what Jerry?",0,3,oMessageCutscene,1)
    else if sceneProgress=22 and bWaitForInput=false
      msgCreate(0,0,"Jerry","How do I say this here...",0,3,oMessageCutscene,1)
    else if sceneProgress=23 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","Damn it! You're gonna have to save your date for later.",0,3,oMessageCutscene,1)
    else if sceneProgress=24 and bWaitForInput=false
      msgCreate(0,0,"Jerry","Who said it was a date?!",0,3,oMessageCutscene,1)
    else if sceneProgress=25 and bWaitForInput=false
      msgCreate(0,0,"Chao","You.",0,3,oMessageCutscene,1)
    else if sceneProgress=26 and bWaitForInput=false
      msgCreate(0,0,"Jerry","What the hell, Chao?!",0,3,oMessageCutscene,1)
    else if sceneProgress=27 and bWaitForInput=false
      msgCreate(0,0,"Chao","Wow Claire, you're right. He's easy to bother.#Jeremy, what's the problem?",0,3,oMessageCutscene,1)
    else if sceneProgress=28 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","I screwed up.#Or rather I underestimated the Virus... again.",0,3,oMessageCutscene,1)
    else if sceneProgress=29 and bWaitForInput=false
      msgCreate(0,0,"Jerry","What do you mean?",0,3,oMessageCutscene,1)
    else if sceneProgress=30 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","This Program Chip is incomplete. It's practically garbage.",0,3,oMessageCutscene,1)
    else if sceneProgress=31 and bWaitForInput=false
      msgCreate(0,0,"Jerry","How did you even know about the Chip?",0,3,oMessageCutscene,1)
    else if sceneProgress=32 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","This is infuriating, Jerry. Apparently this is only one of six parts of the Chip.",0,3,oMessageCutscene,1)
    else if sceneProgress=33 and bWaitForInput=false
      msgCreate(0,0,"Jerry","Ah damn it, another McGuffin hunt?",0,3,oMessageCutscene,1)
    else if sceneProgress=34 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","I'm afraid so.",0,3,oMessageCutscene,1)
    else if sceneProgress=35 and bWaitForInput=false
      msgCreate(0,0,"Jerry","Any idea where the others are?",0,3,oMessageCutscene,1)
    else if sceneProgress=36 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","Only that they are on the mainland... How about this. I was leading you guys to Central City before this diversion into Mario World. How about I continue to lead you guys there?",0,3,oMessageCutscene,1)
    else if sceneProgress=37 and bWaitForInput=false
      msgCreate(0,0,"Jerry","Sounds like a plan I guess.",0,3,oMessageCutscene,1)
    else if sceneProgress=38 and bWaitForInput=false
      msgCreate(0,0,"Chao","There's a lot of people there. I've picked up the signals too. I'm sure someone might be able to help us out.",0,3,oMessageCutscene,1)
    else if sceneProgress=39 and bWaitForInput=false
      msgCreate(0,0,"Jerry","Off to Central City then!",0,3,oMessageCutscene,1)
    else if sceneProgress=40 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","Oh yeah I almost forgot!#You guys can use the Mario ability outside of this Gate now. It seems getting the Chip was what unlocked that.",0,3,oMessageCutscene,1)
    else if sceneProgress=41 and bWaitForInput=false
      msgCreate(0,0,"Jerry","Time to go kick some Hammer Bro ass!",0,3,oMessageCutscene,1)
    else if sceneProgress=42
    {
      circleRad=0
      fadeAlpha=0
      var tFlash;
      tFlash=instance_create(0,0,oScreenFlash)
      tFlash.fadeSpeed=0.2
      oPlayer1.visible=1
      oPlayer1.x=charClaire.x
      with oMisc {instance_destroy()}
      with oProgramChip {instance_destroy()}
      var tempMplay;
      tempMplay=findMusic(103)
      playMusic(tempMplay,0,0)
      var tHeartContainer;
      tHeartContainer=instance_create(464,264,oHeartContainer)
      tHeartContainer.objectNum=1
      var newExit;
      newExit=instance_create(608,272,oExit)
      newExit.sprite_index=sWarpGateStand; newExit.bShowArrow=false; newExit.exitType=0
      newExit.newMapX=48; newExit.newMapY=192; newExit.toRoom=rMario1_1
      global.programChips=1
      global.canCharSwap=2
      global.gamePaused=false
      global.currentBoss=""
      global.bossTrack=0
      global.gameProgress=510
    }
  }
}

keyWaitForInput()

if oKeyCodes.kCodePressed[11]=1 and global.gamePaused=true and sceneProgress>=1 //Cutscene skip
{
  if !instance_exists(oPauseMenu)
  {
    if global.gameProgress=150 and room=rMario1_1 //[1]
    {
      bWaitForInput=false
      with oMisc {instance_destroy()}
      with oEffect {instance_destroy()}
      with oMessageCutscene {instance_destroy()}
      fadeAlpha=0
      sceneDelay=0
      sceneProgress=23
    }
    else if global.gameProgress=160 and room=rMario1_1 //[2]
    {
      if sceneProgress>=5
      {
        bWaitForInput=false
        with oMessageCutscene {instance_destroy()}
        fadeAlpha=0
        sceneDelay=0
        sceneProgress=20
      }
    }
    else if global.gameProgress=200 and room=rMario1_3 //[3]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      sceneDelay=0
      sceneProgress=6
    }
    else if global.gameProgress=210 and room=rMario1_4 //----- [Assist] About AP and Skill Points -----
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      sceneDelay=0
      sceneProgress=7
    }
    else if global.gameProgress=250 and room=rMario1_4Story //[4]
    {
      bWaitForInput=false
      with oProgramChip {instance_destroy()}
      with oMessageCutscene {instance_destroy()}
      oPlayer1.visible=1
      fadeAlpha=0
      sceneDelay=0
      sceneProgress=22
    }
    else if global.gameProgress=270 and room=rMario1_5 //[5]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      sceneDelay=0
      sceneProgress=11
    }
    else if global.gameProgress=290 and room=rMario1_5Hub //[6]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      sceneDelay=0
      sceneProgress=6
    }
    else if global.gameProgress=330 and room=rMario1_8 //[7]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      sceneDelay=0
      sceneProgress=26
    }
    else if global.gameProgress=360 and room=rMario1_HFb //[8]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      sceneDelay=0
      sceneProgress=6
    }
    else if global.gameProgress=401 and room=rMario1_9Shop //[9]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      sceneDelay=0
      sceneProgress=17
    }
    else if global.gameProgress=420 and room=rMario1_11 //[10]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      sceneDelay=0
      sceneProgress=10
    }
    else if global.gameProgress=440 and room=rMario1_CCa //[11]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      sceneDelay=0
      sceneProgress=7
    }
    else if global.gameProgress=460 and room=rMario1_CCb //[12]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      sceneDelay=0
      sceneProgress=10
    }
    else if global.gameProgress=500 and room=rMario1_CCBoss //[13]
    {
      if global.bossTrack=0
      {
        bWaitForInput=false
        with oMessageCutscene {instance_destroy()}
        sceneDelay=0
        sceneProgress=18
      }
      else if global.bossTrack=2 and sceneProgress>=2
      {
        bWaitForInput=false
        with oMessageCutscene {instance_destroy()}
        sceneDelay=0
        sceneProgress=42
      }
    }
  }
}

//---------- LEVEL EVENTS ----------
if global.gamePaused=false
{
  if room=rMario1_CCc //autoscroll
  {
    oPlayer1.bKeepPlayerOnScreen=0
    if autoScroll.x<room_width-256
      autoScroll.x+=xScrollSpd*gDeltaTime

    if autoScroll.x-(view_wview[0]/2)-20>oPlayer1.x
      oPlayer1.life-=oPlayer1.maxLife
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
if room=rMario1_CCBoss
{
  if circleRad>0
  {
    draw_set_color(c_white)
    draw_set_blend_mode_ext(bm_inv_dest_color,bm_zero)
    draw_circle(oProgramChip.x,oProgramChip.y,circleRad,0)
    draw_set_blend_mode(bm_normal)
  }
}
