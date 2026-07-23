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

exCharTalkATime=0
exCharTalkACheck=string_char_at(global.extraFlags,4)
if exCharTalkACheck="1" {exCharTalkAProg=100}
else {exCharTalkAProg=0}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gameProgress=2590 and room=rMain_42 //----- [1] Intro to Barrens -----
{
  if sceneProgress=0
  {
    sceneDelay+=1
    if sceneDelay=1 {global.gamePaused=true}
    else if sceneDelay>=30 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=1 and bWaitForInput=false
    msgCreate(0,0,"Jerry","So here we are... a desert. I hate deserts.",0,3,oMessageCutscene,1)
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"Claire","I already had to deal with one.",0,3,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Hey, so did I!",0,3,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Claire","Yours was weak compared to mine, Jerry.",0,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Yeah well... your face!",0,3,oMessageCutscene,1)
  else if sceneProgress=6 and bWaitForInput=false
    msgCreate(0,0,"Claire","Whatever Jerry. You can always let me handle things.",0,3,oMessageCutscene,1)
  else if sceneProgress=7 and bWaitForInput=false
    msgCreate(0,0,"Jerry","And let you steal the spotlight... nope!",0,3,oMessageCutscene,1)
  else if sceneProgress=8 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","It never stops.",0,3,oMessageCutscene,1)
  else if sceneProgress=9 and bWaitForInput=false
    msgCreate(0,0,"Chao","Nope.",0,3,oMessageCutscene,1)
  else if sceneProgress=10
  {
    var tNewChapter;
    tNewChapter=instance_create(0,0,oChapterDisplay)
    tNewChapter.newChapter="Chapter 12#Barren Bewilderment"
    sceneDelay=0; sceneProgress=0
    global.gameProgress=2600
    global.gamePaused=false
  }
}
else if global.gameProgress=2600 and room=rMain_46 //----- [2] Got past the Twin Rocks puzzle -----
{
  if oPlayer1.x>3000
  {
    if sceneProgress=0
    {
      sceneDelay+=1
      if sceneDelay=1 {global.gamePaused=true}
      else if sceneDelay>=30 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=1 and bWaitForInput=false
      msgCreate(0,0,"Jerry","Well of course it's that code!",0,3,oMessageCutscene,1)
    else if sceneProgress=2 and bWaitForInput=false
      msgCreate(0,0,"Claire","Yeah...",0,3,oMessageCutscene,1)
    else if sceneProgress=3 and bWaitForInput=false
      msgCreate(0,0,"Jerry","Surprised I figured it out?",0,3,oMessageCutscene,1)
    else if sceneProgress=4 and bWaitForInput=false
      msgCreate(0,0,"Claire","That was me that figured it out.",0,3,oMessageCutscene,1)
    else if sceneProgress=5 and bWaitForInput=false
      msgCreate(0,0,"Jerry","No Claire... it was me.",0,3,oMessageCutscene,1)
    else if sceneProgress=6 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","So who was it?",0,3,oMessageCutscene,1)
    else if sceneProgress=7 and bWaitForInput=false
      msgCreate(0,0,"Chao","The world may never know.",0,3,oMessageCutscene,1)
    else if sceneProgress=8
    {
      sceneDelay=0; sceneProgress=0
      global.gameProgress=2610
      global.gamePaused=false
    }
  }
}
else if global.gameProgress=2620 and room=rMain_47 //----- [3] Boss Fight: Vault Demon -----
{
  if global.bossTrack=0
  {
    if sceneProgress=0
    {
      if oPlayer1.x>=2128
      {
        global.gamePaused=true
        oPlayer1.y+=4
        if oPlayer1.y>=352
        {
          scenePChk(2128,352,0,0.1,1)
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
        musFileP=findMusic(13)
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
        var tCamera;
        tCamera=instance_create(oPlayer1.x,round(oPlayer1.y),oGameCamera); tCamera.type=0
      }
      else if sceneDelay>=11 and sceneDelay<=999
      {
        oGameCamera.x+=1
        if oGameCamera.y!=304
        {
          if oGameCamera.y>304 {oGameCamera.y-=1}
          else if oGameCamera<304 {oGameCamera.y+=1}
        }
        if oGameCamera.x>=2208 {oGameCamera.x=2208; sceneDelay=1000}
      }
      else if sceneDelay=1020 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=3
    {
      sceneDelay+=1
      if sceneDelay=10
      {
        npcVD=instance_create(2288,288,oMisc)
        npcVD.sprite_index=sVaultDemonFadeIn; npcVD.image_xscale=-1; npcVD.image_speed=0; npcVD.type=1
      }
      else if sceneDelay=14 {npcVD.image_index=1}
      else if sceneDelay=18 {npcVD.image_index=2}
      else if sceneDelay=22 {npcVD.image_index=3}
      else if sceneDelay=26 {npcVD.image_index=4}
      else if sceneDelay=30 {npcVD.image_index=5}
      else if sceneDelay=34 {npcVD.sprite_index=sVaultDemonIdle; npcVD.image_speed=0.25}
      else if sceneDelay>=50 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=4 and bWaitForInput=false
      msgCreate(0,0,"Vault Demon","You are of no use to my master now.",5,3,oMessageCutscene,1)
    else if sceneProgress=5 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","Looks like Hex has it out for us.",0,3,oMessageCutscene,1)
    else if sceneProgress=6 and bWaitForInput=false
      msgCreate(0,0,"Jerry","Yeah... so what is it?",0,3,oMessageCutscene,1)
    else if sceneProgress=7 and bWaitForInput=false
      msgCreate(0,0,"Chao","It's from the Vault, gimmie a sec while I scan for more.",0,3,oMessageCutscene,1)
    else if sceneProgress=8 and bWaitForInput=false
      msgCreate(0,0,"Vault Demon","Primary Objective: Jerry.#Secondary Objective: The other one.",5,3,oMessageCutscene,1)
    else if sceneProgress=9 and bWaitForInput=false
      msgCreate(0,0,"Claire","WHY IS EVERYONE SO MEAN TO ME AND PRETEND I'M NOT HERE?!",0,3,oMessageCutscene,1)
    else if sceneProgress=10 and bWaitForInput=false
      msgCreate(0,0,"Jerry","Maybe Luigi gave you more than just jumping powers.",0,3,oMessageCutscene,1)
    else if sceneProgress=11
    {
      with oStealthBug {instance_destroy()}
      if !instance_exists(oGameCamera) {tCamera=instance_create(2208,304,oGameCamera); tCamera.type=0}
      else {oGameCamera.x=2208; oGameCamera.y=304}
      stopAllMusic()
      global.gamePaused=false
      var tBossTitle,tempMplay,enemyBarrier;
      tBossTitle=instance_create(0,0,oBossNameDisplay)
      tBossTitle.bossName="Vault Demon"
      tBossTitle.bossTitle="Abysmal Creation"
      tempMplay=findMusic(813)
      playMusic(tempMplay,0,0)
      enemyBarrier=instance_create(1952,0,oEnemyBarrier); enemyBarrier.image_yscale=32
      enemyBarrier=instance_create(2448,0,oEnemyBarrier); enemyBarrier.image_yscale=32
      boss=instance_create(2288,288,oVaultDemon)
      boss.activateBoss=1
      global.currentBoss="Vault Demon"
      global.bossTrack=1
      with oMisc {instance_destroy()}
      storeStatus(0)
      sceneDelay=0; sceneProgress=0
    }
  }
  else if global.bossTrack=1
  {
    if sceneProgress=1 //End Boss
    {
      stopPlayer()
      global.gamePaused=true
      awardBossAP(4100)
      global.bossTrack=2
      sceneProgress=0
    }
  }
  else if global.bossTrack=2
  {
    if sceneProgress=0
    {
      var tFullHeartDrop,tempMplay;
      tFullHeartDrop=instance_create(2208,240,oHealthPickup)
      tFullHeartDrop.sprite_index=sFullHealthPickup
      tempMplay=findMusic(13)
      playMusic(tempMplay,0,0)
      view_object[0]=oPlayer1
      with oEnemyBarrier {instance_destroy()}
      global.gamePaused=false
      global.currentBoss=""
      global.bossTrack=0
      global.gameProgress=2630
    }
  }
}
else if global.gameProgress=2630 and room=rMain_48 //----- [4] Meeting Bubblin & Lovelun at Oasis -----
{
  if sceneProgress=0
  {
    if oPlayer1.x>=1408 and oPlayer1.x<=1504
    {
      global.gamePaused=true
      oPlayer1.y+=4
      if oPlayer1.y>=320
      {
        scenePChk(1408,320,0,0.1,1)
        stopPlayer()
        sceneProgress+=1
      }
    }
  }
  else if sceneProgress=1
  {
    sceneDelay+=1
    if sceneDelay>=30 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"Lovelun","'And goooooo, BOO!' she said! It was cute and funny!",6,3,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Bubblun","I don't understand it, but anything we do together is always great.",6,3,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Chao","Jerry could learn a thing or two from him.",0,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Jerry","You just had to go there.",0,3,oMessageCutscene,1)
  else if sceneProgress=6 and bWaitForInput=false
  {
    showEmote(oIdentifier,0,-6,sEmHappy)
    msgCreate(0,0,"Chao","You bet!",0,3,oMessageCutscene,1)
  }
  else if sceneProgress=7
  {
    sceneDelay+=1
    if sceneDelay=10
    {
      (264631).image_xscale=-1
      with (oEfHeartEmitter) {instance_destroy()}
    }
    else if sceneDelay=30
    {
      showEmote((264631),0,-24,sEmMad)
      showEmote((264632),0,-24,sEmHappy)
    }
    else if sceneDelay>=50 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=8 and bWaitForInput=false
    msgCreate(0,0,"Bubblun","Oh, it's you...",6,3,oMessageCutscene,1)
  else if sceneProgress=9 and bWaitForInput=false
    msgCreate(0,0,"Lovelun","Hey you guys!",6,3,oMessageCutscene,1)
  else if sceneProgress=10 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Well someone isn't happy to see us. What's up with you suddenly?",0,3,oMessageCutscene,1)
  else if sceneProgress=11 and bWaitForInput=false
  {
    (264631).sprite_index=sBubblun_Run
    msgCreate(0,0,"Bubblun","It's your fault the creature was set loose! I told you not to go into the Vault!",6,3,oMessageCutscene,1)
  }
  else if sceneProgress=12 and bWaitForInput=false
    msgCreate(0,0,"Lovelun","Hey now, Bubby. We talked about this.",6,3,oMessageCutscene,1)
  else if sceneProgress=13 and bWaitForInput=false
  {
    (264631).sprite_index=sBubblun_Idle;
    (264631).image_xscale=1
    msgCreate(0,0,"Bubblun","I know the creature would have escaped eventually, but at least we could have been better prepared.",6,3,oMessageCutscene,1)
  }
  else if sceneProgress=14 and bWaitForInput=false
    msgCreate(0,0,"Claire","We're just trying to help.",0,3,oMessageCutscene,1)
  else if sceneProgress=15 and bWaitForInput=false
  {
    (264631).image_xscale=-1
    msgCreate(0,0,"Bubblun","Your help isn't wanted or asked for. You're just causing more problems than you're fixing at this rate.",6,3,oMessageCutscene,1)
  }
  else if sceneProgress=16 and bWaitForInput=false
    msgCreate(0,0,"Lovelun","Bubby, please calm down. That's why we came here, to relax!",6,3,oMessageCutscene,1)
  else if sceneProgress=17 and bWaitForInput=false
  {
    (264631).image_xscale=1
    msgCreate(0,0,"Bubblun","I'm sorry, these humans just upset me with their curiosity. But I'll try to relax.",6,3,oMessageCutscene,1)
  }
  else if sceneProgress=18 and bWaitForInput=false
    msgCreate(0,0,"Lovelun","You four should leave us for now. You look busy anyway.",6,3,oMessageCutscene,1)
  else if sceneProgress=19 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Very busy... Trying to fix all this.",0,3,oMessageCutscene,1)
  else if sceneProgress=20 and bWaitForInput=false
    msgCreate(0,0,"Bubblun","Whatever. Nothing we can do about it anyway. Please go.",6,3,oMessageCutscene,1)
  else if sceneProgress=21
  {
    if !instance_exists(oEfHeartEmitter)
    {
      var tHeartEm;
      tHeartEm=instance_create(1496,280,oEfHeartEmitter); tHeartEm.efDelay=60
    }
    sceneDelay=0; sceneProgress=0
    global.gameProgress=2640
    global.gamePaused=false
  }
}
else if global.gameProgress=2660 and room=rMain_48Gate //----- [Unskippable] Access Gate 5 -----
{
  if sceneProgress=0
  {
    sceneDelay+=1
    if sceneDelay>=1
    {
      if sceneDelay=1 {global.gamePaused=true}
      fadeAlpha+=0.04
      if fadeAlpha>=1
      {
        sceneDelay=0
        sceneProgress+=1
      }
    }
  }
  else if sceneProgress=1
  {
    oPlayer1.life=oPlayer1.maxLife
    global.recAreaTrans+=1
    global.newMapX=256
    global.newMapY=288
    writeToPlayerGlobals()
    stopAllMusic()
    transition_steps=1
    transition_kind=0
    room_goto(rSamus5_Gate)
  }
}

keyWaitForInput()

if oKeyCodes.kCodePressed[11]=1 and global.gamePaused=true and sceneProgress>=1 //Cutscene skip
{
  if !instance_exists(oPauseMenu)
  {
    if global.gameProgress=2590 and room=rMain_42 //[1]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      fadeAlpha=0; sceneDelay=0
      sceneProgress=10
    }
    else if global.gameProgress=2600 and room=rMain_46 //[2]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      fadeAlpha=0; sceneDelay=0
      sceneProgress=8
    }
    else if global.gameProgress=2620 and room=rMain_47 //[3]
    {
      if global.bossTrack=0
      {
        bWaitForInput=false
        with oMessageCutscene {instance_destroy()}
        fadeAlpha=0; sceneDelay=0
        sceneProgress=11
      }
    }
    else if global.gameProgress=2630 and room=rMain_48 //[4]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      fadeAlpha=0; sceneDelay=0
      sceneProgress=21
    }
  }
}

if global.gamePaused=false
{
  if exCharTalkAProg=0 //Talk about the messed up map and the lack of Sand Crawler (if alive)
  {
    if room=rMain_75 and oPlayer1.x>=752 {exCharTalkAProg=1}
  }
  else if exCharTalkAProg>=1 and exCharTalkAProg<=99
  {
    exCharTalkATime+=1
    if exCharTalkAProg=1
    {
      msgCreate(0,0,"Claire","So you guys, any idea what's up with this place and why it's all messed up?",0,2,oMessagePerson,0)
      newMessage.fadingTime=120; exCharTalkAProg+=1
    }
    else if exCharTalkAProg=2 {if exCharTalkATime>=120 {exCharTalkATime=0; exCharTalkAProg+=1}}
    else if exCharTalkAProg=3
    {
      msgCreate(0,0,"Jeremy","Something big was here recently and screwed it all up. My guess is whatever it is, it messed up the integrity of the place too.",0,2,oMessagePerson,0)
      newMessage.fadingTime=170; exCharTalkAProg+=1
    }
    else if exCharTalkAProg=4 {if exCharTalkATime>=170 {exCharTalkATime=0; exCharTalkAProg+=1}}
    else if exCharTalkAProg=5
    {
      msgCreate(0,0,"Claire","That's super weird, but uh... oh yeah. Didn't some people in Central City say they saw a huge creature in the desert? Think it's that Abomination thing?",0,3,oMessagePerson,0)
      newMessage.fadingTime=200; exCharTalkAProg+=1
    }
    else if exCharTalkAProg=6 {if exCharTalkATime>=200 {exCharTalkATime=0; exCharTalkAProg+=1}}
    else if exCharTalkAProg=7
    {
      if global.gateHProg=100 {msgCreate(0,0,"Jeremy","If it is, this is where we need to be.",0,2,oMessagePerson,0)}
      else {msgCreate(0,0,"Jeremy","If it is, I wouldn't recommend going near it.",0,2,oMessagePerson,0)}
      newMessage.fadingTime=110; exCharTalkAProg+=1
    }
    else if exCharTalkAProg=8 {if exCharTalkATime>=110 {exCharTalkATime=0; exCharTalkAProg+=1}}
    else if exCharTalkAProg=9
    {
      msgCreate(0,0,"Jerry","In any case, this place is weird looking.",0,2,oMessagePerson,0)
      newMessage.fadingTime=100; exCharTalkAProg+=1
    }
    else if exCharTalkAProg=10
    {
      if exCharTalkATime>=100
      {
        exCharTalkATime=0
        if global.gameOptDT<=2 {exCharTalkAProg+=1} //Sand Crawler not defeated
        else {exCharTalkAProg=99}
      }
    }
    else if exCharTalkAProg=11
    {
      msgCreate(0,0,"Jeremy","Also the sand here is safe to touch. The Sand Crawler won't come out here because it fears bigger creatures than it.",0,2,oMessagePerson,0)
      newMessage.fadingTime=170; exCharTalkAProg+=1
    }
    else if exCharTalkAProg=12 {if exCharTalkATime>=170 {exCharTalkATime=0; exCharTalkAProg+=1}}
    else if exCharTalkAProg=13
    {
      msgCreate(0,0,"Jerry","Wow, that thing sucks even more than I imagined.",0,2,oMessagePerson,0)
      newMessage.fadingTime=100; exCharTalkAProg+=1
    }
    else if exCharTalkAProg=14 {if exCharTalkATime>=100 {exCharTalkATime=0; exCharTalkAProg=99}}
    else if exCharTalkAProg=99
    {
      var tNewString;
      tNewString=string_delete(global.extraFlags,4,1)
      tNewString=string_insert("1",tNewString,4)
      global.extraFlags=tNewString
      exCharTalkAProg=100
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
