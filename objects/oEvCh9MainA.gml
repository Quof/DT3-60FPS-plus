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

if global.gameProgress=2000
{
  fadeColor=c_black
  fadeAlpha=1
  oNPC_Syrus.image_xscale=-1
}

if room=rMain_32
{
  indexCheck=string_char_at(global.apBoost,29)
  if indexCheck="1" or global.newMapY=1152
  {
    with (239892) {instance_destroy()}
    with (239269) {instance_destroy()}
    with (239270) {instance_destroy()}
    tile_layer_hide(999995)
  }
}
else if room=rMain_34
{
  if global.gameProgress>=2100
  {
    with (241042) {instance_destroy()}
    with (241136) {instance_destroy()}
    with (243531) {instance_destroy()}
    tile_layer_hide(999995)
  }
}
else if room=rMain_35
{
  indexCheck=string_char_at(global.heartPiece,23)
  if indexCheck="1"
  {
    with (244121) {instance_destroy()}
    tile_layer_hide(999995)
  }
}
else if room=rMain_36
{
  indexCheck=string_char_at(global.apBoost,36)
  if indexCheck="1" or global.newMapY=80
  {
    with (244634) {instance_destroy()}
    with (244636) {instance_destroy()}
    with (244638) {instance_destroy()}
    with (244640) {instance_destroy()}
    instance_create(4160,112,oLargeJumper)
    tile_layer_hide(999995)
  }
}
else if room=rMain_39
{
  sizeMod=0
  bSizeUp=false

  fingerSprite=0
  for(i=0;i<23;i+=1)
  {
    fingerWave[i]=0
    fingerBend[i]=pi/2
    fingerSize[i]=random(0.5)
  }
}
else if room=rMain_39Vault
{
  if global.gameProgress<=2160
  {
    fadeColor=c_black
    fadeAlpha=1
  }
  else if global.gameProgress=2540 {fadeAlpha=1}
  pullIn=0
  pullPwr=8
  pullTime=0
  particleTime=0
  objectTime=0
}
else if room=rBubbleTowerA4
{
  eggBotCheck=0
}
else if room=rBubbleTowerA5
{
  achieveCheck=0
}
else if room=rBubbleTowerA7
{
  if global.gameProgress=2080 and global.bossTrack=0
  {
    fadeColor=c_black
    fadeAlpha=1
    npcBubblin=instance_create(416,96,oMisc)
    npcBubblin.sprite_index=sBubblun_Idle; npcBubblin.image_xscale=-1; npcBubblin.image_speed=0.05; npcBubblin.type=1
  }
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gameProgress=2000 and room=rCCity_NA_S2 //----- [1] The Vault must be closed -----
{
  if sceneProgress=0
  {
    sceneDelay+=1
    if sceneDelay=1
    {
      global.gamePaused=true
      scenePChk(240,288,0,0.1,1)
      oPlayer1.visible=0
      charJerry=instance_create(256,288,oMisc)
      charJerry.sprite_index=sJerryIdle; charJerry.image_speed=0.1; charJerry.type=2
      charClaire=instance_create(224,288,oMisc)
      charClaire.sprite_index=sClaireIdle; charClaire.image_speed=0.1; charClaire.type=2
    }
    else if sceneDelay>=30
    {
      fadeAlpha-=0.01
      if fadeAlpha<=0 {sceneDelay=0; sceneProgress+=1}
    }
  }
  else if sceneProgress=1 and bWaitForInput=false
    msgCreate(0,0,"Jerry","We've got big problems.",0,3,oMessageCutscene,1)
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"Syrus","Do tell.",6,3,oMessageCutscene,1)
  else if sceneProgress=3
  {
    fadeAlpha+=0.02
    if fadeAlpha>=1 {sceneProgress+=1}
  }
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"","The group informed Syrus and Gene on what they had found out from Sigma.",6,3,oMessageCutscene,1)
  else if sceneProgress=5
  {
    fadeAlpha-=0.02
    if fadeAlpha<=0 {sceneProgress+=1}
  }
  else if sceneProgress=6 and bWaitForInput=false
    msgCreate(0,0,"Syrus","So this Virus is all that Hexor guy's doing?",6,3,oMessageCutscene,1)
  else if sceneProgress=7 and bWaitForInput=false
    msgCreate(0,0,"Jerry","That's what we're assuming. He's definitely the one that let Sigma loose from the Vault.",0,3,oMessageCutscene,1)
  else if sceneProgress=8 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","We need to get close to the Vault, I'm sure there's a way to seal it up. Do you have that program ready that will fix up the jumbled data next to the Vault?",0,3,oMessageCutscene,1)
  else if sceneProgress=9 and bWaitForInput=false
    msgCreate(0,0,"Syrus","Yes, take it.",6,3,oMessageCutscene,1)
  else if sceneProgress=10 and bWaitForInput=false
  {
    playSound(global.snd_HeartPiece,0,1,1)
    msgCreate(0,0,"","You received the Data Descrambler!",6,3,oMessageCutscene,1)
  }
  else if sceneProgress=11 and bWaitForInput=false
    msgCreate(0,0,"Syrus","You can get through the distortion in Magical Hills now. There shouldn't be any more fuzz.",6,3,oMessageCutscene,1)
  else if sceneProgress=12 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Awesome.",0,3,oMessageCutscene,1)
  else if sceneProgress=13 and bWaitForInput=false
    msgCreate(0,0,"Gene","Just a warning before you go. Whatever you do, don't go into the Vault. It's clear that it isn't working correctly. Whatever is in there, be it Hex or something else, it has control of the place. There's no guarantee you'll be able to get out.",6,3,oMessageCutscene,1)
  else if sceneProgress=14 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","We're just going there to observe.",0,3,oMessageCutscene,1)
  else if sceneProgress=15 and bWaitForInput=false
    msgCreate(0,0,"Gene","Be safe you guys. I don't like this, but I guess there's really no other choice. Looks like we'll need to put the Chips on hold for now while we deal with this.",6,3,oMessageCutscene,1)
  else if sceneProgress=16 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","We'll be okay. It seems the world stability functions are a lot harder to disrupt than we all thought. It's taking the Virus quite some time to get through to it.",0,3,oMessageCutscene,1)
  else if sceneProgress=17
  {
    var tFlash;
    tFlash=instance_create(0,0,oScreenFlash)
    tFlash.fadeSpeed=0.2
    var tNewChapter,tempMplay;
    tNewChapter=instance_create(0,0,oChapterDisplay)
    tNewChapter.newChapter="Chapter 9#Recollection"
    oPlayer1.visible=1
    if global.activeCharacter=0 oPlayer1.x=charJerry.x
    else if global.activeCharacter=1 oPlayer1.x=charClaire.x
    with oMisc {instance_destroy()}
    sceneDelay=0; sceneProgress=0
    global.gameProgress=2010
    global.gamePaused=false
  }
}
else if global.gameProgress=2010 and room=rMain_30 //----- [] Tutorial: Ability Swapping -----
{
  if sceneProgress=0
  {
    var tNewTutorial;
    tNewTutorial=instance_create(0,0,oTutorialPanel)
    tNewTutorial.tutorialTitle="Ability Swapping"
    tNewTutorial.tutorialInfo=string("To swap between Ability Sets, press [") +string(global.ctrlAbilSwap) +string("]. Currently, only Jerry has more than one.")
    tNewTutorial.scrAreaY=1
    sceneProgress+=1
  }
}
else if global.gameProgress=2020 and room=rMain_31 //----- [2] The Vault is near this place? -----
{
  if sceneProgress=0
  {
    sceneDelay+=1
    if sceneDelay=1 {global.gamePaused=true}
    else if sceneDelay>=20 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=1 and bWaitForInput=false
    msgCreate(0,0,"Chao","Oh wow, uh... what is this?",0,3,oMessageCutscene,1)
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"Claire","This isn't what I was expecting... Jeremy?",0,3,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Hey I didn't know what this place would be either. Looks like we're gonna have to explore this place a bit to find the Vault. Just remember, we cannot go into it.",0,3,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Chao","Can you tell me a bit about this Hex guy that was mentioned?",0,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Yeah, I'll send messages privately so we don't clutter up things for Jerry and Claire.",0,3,oMessageCutscene,1)
  else if sceneProgress=6 and bWaitForInput=false
    msgCreate(0,0,"Claire","I may want to hear about it too you know.",0,3,oMessageCutscene,1)
  else if sceneProgress=7 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Chao will tell you about it later. You two just do your thing.",0,3,oMessageCutscene,1)
  else if sceneProgress=8
  {
    sceneDelay=0; sceneProgress=0
    global.gameProgress=2030
    global.gamePaused=false
  }
}
else if global.gameProgress=2030 and room=rMain_34 //----- [3] Bubble Tower and huge cliff -----
{
  if sceneProgress=0
  {
    if oPlayer1.x>=720
    {
      if global.activeCharacter=0 //Tower?
      {
        msgCreate(0,0,"Jerry","That's an interesting looking thing. A bit out of place... but interesting.",0,1,oMessagePerson,0)
        newMessage.fadingTime=120
      }
      else if global.activeCharacter=1
      {
        msgCreate(0,0,"Claire","Is that tower like building from Kirby? It looks like it.",0,1,oMessagePerson,0)
        newMessage.fadingTime=110
      }
      sceneProgress+=1
    }
  }
  else if sceneProgress=1 //Go back
  {
    if oPlayer1.x>=1424 and oPlayer1.y<=1088
    {
      msgCreate(0,0,"Jeremy","Hmm, go back to that tower entrance. I'll see if I can hack that door to be usable. We're gonna need to find another way to the top of this cliff.",0,2,oMessagePerson,0)
      newMessage.fadingTime=160
      npcBubblin=instance_create(1120,1104,oMisc)
      npcBubblin.sprite_index=sBubblun_Idle; npcBubblin.image_speed=0.05; npcBubblin.type=1
      sceneProgress+=1
    }
  }
  else if sceneProgress=2 //Talk to Bubblin
  {
    if oPlayer1.x<=1232
    {
      sceneDelay+=1
      if sceneDelay=1 {global.gamePaused=true}
      oPlayer1.y+=4
      if oPlayer1.y>=1088
      {
        scenePChk(1232,1088,0,0.1,-1)
        stopPlayer()
        sceneDelay=0; sceneProgress+=1
      }
    }
  }
  else if sceneProgress=3
  {
    sceneDelay+=1
    if sceneDelay>=20 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Oh hey, it's one of those Bubble Bobble guys!",0,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Bubblun","What are you doing here?!",6,3,oMessageCutscene,1)
  else if sceneProgress=6 and bWaitForInput=false
    msgCreate(0,0,"Jerry","We're just trying to find a way over that large hill to the east... Hey, do you know a way over it?",0,3,oMessageCutscene,1)
  else if sceneProgress=7 and bWaitForInput=false
    msgCreate(0,0,"Bubblun","Yes, but I won't help you. Go away, there is nothing out here for you!",6,3,oMessageCutscene,1)
  else if sceneProgress=8 and bWaitForInput=false
    msgCreate(0,0,"Jerry","We really need to get over that hill.",0,3,oMessageCutscene,1)
  else if sceneProgress=9 and bWaitForInput=false
    msgCreate(0,0,"Bubblun","There is only one thing out here and you are forbidden from going near it.",6,3,oMessageCutscene,1)
  else if sceneProgress=10 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Look man, you can't just decide that we're not allowed near the Vault, we have a reason for this.",0,3,oMessageCutscene,1)
  else if sceneProgress=11 and bWaitForInput=false
    msgCreate(0,0,"Bubblun","I forbid it! You have no place here, so leave!",6,3,oMessageCutscene,1)
  else if sceneProgress=12 and bWaitForInput=false
    msgCreate(0,0,"Jerry","I don't think you're in a position nor capable of forcing us to leave.",0,3,oMessageCutscene,1)
  else if sceneProgress=13 and bWaitForInput=false
  {
    showEmote(npcBubblin.id,0,-26,sEmMad)
    msgCreate(0,0,"Bubblun","Oh not this again. Nothing good can come from approaching it. I have been working hard to keep everyone out of that place, we do not need someone like you messing up everything.",6,3,oMessageCutscene,1)
  }
  else if sceneProgress=14 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Those locks won't hold. The Virus is slowly eating away at those securities. We just need to get close to investigate.",0,3,oMessageCutscene,1)
  else if sceneProgress=15 and bWaitForInput=false
  {
    showEmote(npcBubblin.id,0,-26,sEmMad)
    msgCreate(0,0,"Bubblun","I SAID NO!! I have not granted you permission! The path is impossible for one as limited as yourself anyway. I am at least thankful for that. And it looks like I need to redo the static codes again, not sure how you got past that.",6,3,oMessageCutscene,1)
  }
  else if sceneProgress=16
  {
    sceneDelay+=1
    if sceneDelay=15 {showEmote(oSignPost.id,0,-48,sEmHappy)}
    else if sceneDelay=50 {npcBubblin.image_xscale=-1}
    else if sceneDelay=65 {showEmote(npcBubblin.id,0,-26,sEmThinking)}
    else if sceneDelay=110 {npcBubblin.image_xscale=1}
    else if sceneDelay>=125 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=17 and bWaitForInput=false
    msgCreate(0,0,"Bubblun","I have other matters to attend to. You will leave this place now. Just... ugh. Between the Vault and CHAOS, I have enough things to deal with.",6,3,oMessageCutscene,1)
  else if sceneProgress=18
  {

    sceneDelay+=1
    if sceneDelay=15
    {
      npcBubblin.sprite_index=sBubblun_Walk; npcBubblin.image_xscale=-1; npcBubblin.image_speed=0.15
    }
    else if sceneDelay>=16 and sceneDelay<=48 {npcBubblin.x-=1}
    else if sceneDelay=49 {npcBubblin.sprite_index=sBubblun_Idle; npcBubblin.image_speed=0.05}
    else if sceneDelay=60 {with npcBubblin {instance_destroy()}}
    else if sceneDelay>=75 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=19 and bWaitForInput=false
    msgCreate(0,0,"Jerry","We're chasing after him? And... what was that CHAOS thing he mentioned? It sounds familiar.",0,3,oMessageCutscene,1)
  else if sceneProgress=20 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Yes, you're chasing after him. And that... I don't know entirely just yet, but I'll look them up some more.",0,3,oMessageCutscene,1)
  else if sceneProgress=21 and bWaitForInput=false
    msgCreate(0,0,"Jerry","You think that this tower will get us over or around that hill?",0,3,oMessageCutscene,1)
  else if sceneProgress=22 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","There's no other options.",0,3,oMessageCutscene,1)
  else if sceneProgress=23 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Well then, into the tower we go!",0,3,oMessageCutscene,1)
  else if sceneProgress=24 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Which is open. That door was really easy to hack open.",0,3,oMessageCutscene,1)
  else if sceneProgress=25
  {
    if instance_exists(npcBubblin) {with npcBubblin {instance_destroy()}}
    sceneDelay=0; sceneProgress=0
    var newDoor;
    newDoor=instance_create(1080,1072,oExit)
    newDoor.bShowArrow=true; newDoor.exitType=0
    newDoor.newMapX=240; newDoor.newMapY=304; newDoor.toRoom=rBubbleTowerMain
    with oSignPost {instance_destroy()}
    global.gameProgress=2040
    global.gamePaused=false
  }
}
else if global.gameProgress=2040 and room=rBubbleTowerA1 //----- [4] Going could be rough -----
{
  if sceneProgress=0
  {
    sceneDelay+=1
    if sceneDelay=1 {global.gamePaused=true}
    else if sceneDelay>=20 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=1 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Jeremy, you can't tell me that little guy went up this way.",0,3,oMessageCutscene,1)
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Probably not, but it's our only way up this tower.",0,3,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Jerry","A trap filled tower, where have we seen that before...",0,3,oMessageCutscene,1)
  else if sceneProgress=4
  {
    sceneDelay=0; sceneProgress=0
    global.gameProgress=2050
    global.gamePaused=false
  }
}
else if global.gameProgress=2080 and room=rBubbleTowerA7 //----- [5] Boss: Army Eye -----
{
  if global.bossTrack=0
  {
    if sceneProgress=0
    {
      sceneDelay+=1
      if sceneDelay=1
      {
        stopAllMusic()
        with oExit {instance_destroy()}
        oPlayer1.x=272; oPlayer1.image_xscale=-1
        global.gamePaused=true
      }
      else if sceneDelay>=30
      {
        fadeAlpha-=0.01
        if fadeAlpha<=0 {sceneDelay=0; sceneProgress+=1}
      }
    }
    else if sceneProgress=1 and bWaitForInput=false
      msgCreate(0,0,"Bubblun","You did not stop when I told you...",6,3,oMessageCutscene,1)
    else if sceneProgress=2 and bWaitForInput=false
      msgCreate(0,0,"Jerry","We only need a way to the Vault so we can check on it.",0,3,oMessageCutscene,1)
    else if sceneProgress=3 and bWaitForInput=false
      msgCreate(0,0,"Bubblun","Your meddling will only speed up the process of the lock breaking.",6,3,oMessageCutscene,1)
    else if sceneProgress=4 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","So you DO know the Vault is having problems.",0,3,oMessageCutscene,1)
    else if sceneProgress=5 and bWaitForInput=false
      msgCreate(0,0,"Bubblun","Everyone does, but we need more time to figure out how to keep it locked. Time all of you will take from us if you do not leave.",6,3,oMessageCutscene,1)
    else if sceneProgress=6 and bWaitForInput=false
      msgCreate(0,0,"Jerry","We're not turning back.",0,3,oMessageCutscene,1)
    else if sceneProgress=7 and bWaitForInput=false
      msgCreate(0,0,"Bubblun","Since you can not be reasoned with, I will activate the war bot we fixed up.",6,3,oMessageCutscene,1)
    else if sceneProgress=8 and bWaitForInput=false
      msgCreate(0,0,"Jerry","Oh so that's what that is. I'm surprised you don't have a giant Bubble Bobble robot like in that one game.",0,3,oMessageCutscene,1)
    else if sceneProgress=9 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","Just wanted to mention that homing attacks, both here and practically anywhere, can be destroyed by EXPLOSIVE type damage.",0,3,oMessageCutscene,1)
    else if sceneProgress=10
    {
      global.gamePaused=false
      var tBossTitle,tempMplay;
      tBossTitle=instance_create(0,0,oBossNameDisplay)
      tBossTitle.bossName="Army Eye"
      tBossTitle.bossTitle="Generic Uninspired#Defense Shifting Robot"
      tempMplay=findMusic(813)
      playMusic(tempMplay,0,0)
      oArmyEye.activateBoss=1
      global.currentBoss="Army Eye"
      global.bossTrack=1
      storeStatus(0)
      sceneDelay=0; sceneProgress=0
    }
  }
  else if global.bossTrack=1
  {
    if !instance_exists(oArmyEye) and sceneProgress=0 //End Boss
    {
      global.gamePaused=true
      awardBossAP(3100)
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
        with oMisc {instance_destroy()}
        endBoss()
        scenePChk(160,320,0,0.1,1)
        oPlayerIdle.x=128; oPlayerIdle.y=320; oPlayerIdle.image_xscale=1; oPlayerShieldBubble.visible=0
        if global.activeCharacter=0 {oPlayerIdle.sprite_index=sClaireIdle}
        else if global.activeCharacter=1 {oPlayerIdle.sprite_index=sJerryIdle}

        npcBubblin=instance_create(208,320,oMisc)
        npcBubblin.sprite_index=sBubblun_Idle; npcBubblin.image_speed=0.05; npcBubblin.type=1; npcBubblin.image_xscale=-1
      }
      if sceneDelay>=60 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=2
    {
      if fadeAlpha>0
        fadeAlpha-=0.05
      else if fadeAlpha<=0
        sceneProgress+=1
    }
    else if sceneProgress=3
    {
      sceneDelay+=1
      if sceneDelay>=25 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=4 and bWaitForInput=false
    {
      showEmote(npcBubblin.id,0,-26,sEmMad)
      msgCreate(0,0,"Bubblun","You... YOU DESTROYED MY ROBOT!!",6,3,oMessageCutscene,1)
    }
    else if sceneProgress=5 and bWaitForInput=false
      msgCreate(0,0,"Jerry","Well yeah. It was going to BLOW US UP!",0,3,oMessageCutscene,1)
    else if sceneProgress=6 and bWaitForInput=false
      msgCreate(0,0,"Bubblun","It was only set to trap you so I could remove you from the Farreaches. I don't harm humans if at all possible, but you are pushing it.",6,3,oMessageCutscene,1)
    else if sceneProgress=7 and bWaitForInput=false
      msgCreate(0,0,"Jerry","Could have fooled us with that robot.",0,3,oMessageCutscene,1)
    else if sceneProgress=8 and bWaitForInput=false
    {
      showEmote(npcBubblin.id,0,-26,sEmMad)
      msgCreate(0,0,"Bubblun","WHY WILL YOU NOT GO AWAY!?",6,3,oMessageCutscene,1)
    }
    else if sceneProgress=9 and bWaitForInput=false
      msgCreate(0,0,"Jerry","We've said it before, we need to get to the Vault.",0,3,oMessageCutscene,1)
    else if sceneProgress=10 and bWaitForInput=false
      msgCreate(0,0,"Bubblun","And I have already said that I forbid it.",6,3,oMessageCutscene,1)
    else if sceneProgress=11
    {
      sceneDelay+=1
      if sceneDelay=1
      {
        npcLovelun=instance_create(240,320,oMisc)
        npcLovelun.sprite_index=sLovelun_Idle; npcLovelun.image_speed=0.05
        npcLovelun.type=1; npcLovelun.image_xscale=-1; npcLovelun.visible=0
        showEmote(npcLovelun.id,0,-26,sEmExcite)
      }
      else if sceneDelay>=15 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=12 and bWaitForInput=false
      msgCreate(0,0,"?????","What's all this commotion in here? Bubby, I thought you said you were done tinkering with the robot...",6,3,oMessageCutscene,1)
    else if sceneProgress=13 and bWaitForInput=false
    {
      showEmote(npcBubblin.id,0,-26,sEmThinking)
      npcBubblin.image_xscale=1
      msgCreate(0,0,"Bubblun","Give me a minute!",6,3,oMessageCutscene,1)
    }
    else if sceneProgress=14 and bWaitForInput=false
      msgCreate(0,0,"Jerry","What the mess...?",0,3,oMessageCutscene,1)
    else if sceneProgress=15 and bWaitForInput=false
    {
      npcBubblin.image_xscale=-1
      msgCreate(0,0,"Bubblun","GET OUT!",6,3,oMessageCutscene,1)
    }
    else if sceneProgress=16
    {
      sceneDelay+=1
      if sceneDelay=1 {npcLovelun.visible=1}
      else if sceneDelay=15 {showEmote(npcLovelun.id,0,-26,sEmExcite)}
      else if sceneDelay>=30 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=17 and bWaitForInput=false
      msgCreate(0,0,"Lovelun","Oh hey! We have visitors!",6,3,oMessageCutscene,1)
    else if sceneProgress=18 and bWaitForInput=false
    {
      npcBubblin.image_xscale=1
      msgCreate(0,0,"Bubblun","They are trying to see the Vault.",6,3,oMessageCutscene,1)
    }
    else if sceneProgress=19 and bWaitForInput=false
      msgCreate(0,0,"Lovelun","Why would anyone want to go to that horrible place?",6,3,oMessageCutscene,1)
    else if sceneProgress=20 and bWaitForInput=false
      msgCreate(0,0,"Jerry","We've been trying to tell you, but you won't listen! Jeremy, tell him why, I don't know the details very well.",0,3,oMessageCutscene,1)
    else if sceneProgress=21 and bWaitForInput=false
    {
      showEmote(npcBubblin.id,0,-26,sEmExcite)
      npcBubblin.image_xscale=-1
      msgCreate(0,0,"Bubblun","Did you say, Jeremy?",6,3,oMessageCutscene,1)
    }
    else if sceneProgress=22 and bWaitForInput=false
      msgCreate(0,0,"Jerry","Yeah... You know, mission control and all that jazz.",0,3,oMessageCutscene,1)
    else if sceneProgress=23 and bWaitForInput=false
      msgCreate(0,0,"Bubblun","Jeremy is the one that stabilized the program. He made the peaceful agreement possible!",6,3,oMessageCutscene,1)
    else if sceneProgress=24 and bWaitForInput=false
      msgCreate(0,0,"Lovelun","Jeremy is here?!",6,3,oMessageCutscene,1)
    else if sceneProgress=25 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","If you consider where I am to actually be 'here', then sure.",0,3,oMessageCutscene,1)
    else if sceneProgress=26 and bWaitForInput=false
      msgCreate(0,0,"Bubblun","If you had said you were the humans that put a stop to that whole mess, I would not have sent the robot on you... And you would not have had to destroy it... I am still mad about that!",6,3,oMessageCutscene,1)
    else if sceneProgress=27 and bWaitForInput=false
      msgCreate(0,0,"Lovelun","They destroyed your work?",6,3,oMessageCutscene,1)
    else if sceneProgress=28 and bWaitForInput=false
      msgCreate(0,0,"Bubblun","We will talk about that later.",6,3,oMessageCutscene,1)
    else if sceneProgress=29 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","I didn't know I was a celebrity.",0,3,oMessageCutscene,1)
    else if sceneProgress=30 and bWaitForInput=false
      msgCreate(0,0,"Bubblun","Before we proceed, I need to ask... What exactly do you want with the Vault?",6,3,oMessageCutscene,1)
    else if sceneProgress=31 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","The lock is weakening and we think the cause is someone inside using the Virus to get himself out.",0,3,oMessageCutscene,1)
    else if sceneProgress=32 and bWaitForInput=false
      msgCreate(0,0,"Bubblun","Plenty of bots are trying to get out, but something far worse is kept inside.",6,3,oMessageCutscene,1)
    else if sceneProgress=33 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","We're aware of that, that's why we need to check on it.",0,3,oMessageCutscene,1)
    else if sceneProgress=34 and bWaitForInput=false
      msgCreate(0,0,"Bubblun","The program trusted you with some control of the world. I think I can trust you with access to the Vault. Just... do not do anything that could push the lock closer to being broken.",6,3,oMessageCutscene,1)
    else if sceneProgress=35 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","You have our word. We are only going to investigate to see if there's anything our programming buddies can do to assist the lock.",0,3,oMessageCutscene,1)
    else if sceneProgress=36 and bWaitForInput=false
      msgCreate(0,0,"Lovelun","Did you hear that, Bubby? No more of those horrible bots getting out.",6,3,oMessageCutscene,1)
    else if sceneProgress=37 and bWaitForInput=false
    {
      npcBubblin.image_xscale=1
      msgCreate(0,0,"Bubblun","I hope so. That Sigma bot nearly harmed you.",6,3,oMessageCutscene,1)
    }
    else if sceneProgress=38 and bWaitForInput=false
    {
      showEmote(npcLovelun.id,0,-26,sEmHappy)
      msgCreate(0,0,"Lovelun","You clawed him right in the jaw for me!",6,3,oMessageCutscene,1)
    }
    else if sceneProgress=39 and bWaitForInput=false
      msgCreate(0,0,"Jerry","So how do we get over that hill?",0,3,oMessageCutscene,1)
    else if sceneProgress=40 and bWaitForInput=false
    {
      npcBubblin.image_xscale=-1
      msgCreate(0,0,"Bubblun","Oh that. Come outside and we will help you up.",6,3,oMessageCutscene,1)
    }
    else if sceneProgress=41 and bWaitForInput=false
      msgCreate(0,0,"Jerry","Awesome, let's do this.",0,3,oMessageCutscene,1)
    else if sceneProgress=42
    {
      sceneDelay+=1
      if sceneDelay=15
      {
        npcBubblin.sprite_index=sBubblun_Walk; npcBubblin.image_xscale=1; npcBubblin.image_speed=0.15
      }
      else if sceneDelay>=16 and sceneDelay<=48 {npcBubblin.x+=1}
      else if sceneDelay=49 {npcBubblin.sprite_index=sBubblun_Idle; npcBubblin.image_speed=0.05}
      else if sceneDelay=60 {with npcBubblin {instance_destroy()}}
      else if sceneDelay>=75 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=43 and bWaitForInput=false
      msgCreate(0,0,"Lovelun","It's really great to meet you all! I hope we have another chance to talk!",6,3,oMessageCutscene,1)
    else if sceneProgress=44
    {
      sceneDelay+=1
      if sceneDelay=10 {with npcLovelun {instance_destroy()}}
      else if sceneDelay>=20 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=45 and bWaitForInput=false
      msgCreate(0,0,"Chao","Those two are cute.",0,3,oMessageCutscene,1)
    else if sceneProgress=46
    {
      var tFullHeartDrop,tempMplay,newExit;
      tFullHeartDrop=instance_create(240,112,oHealthPickup)
      tFullHeartDrop.sprite_index=sFullHealthPickup
      tempMplay=findMusic(10)
      playMusic(tempMplay,0,0)

      newExit=instance_create(240,224,oExit)
      newExit.sprite_index=sWarpGateStand
      newExit.bShowArrow=false; newExit.exitType=0
      newExit.newMapX=176; newExit.newMapY=304; newExit.toRoom=rBubbleTowerMain
      newExit=instance_create(232,288,oExit)
      newExit.bShowArrow=true; newExit.exitType=0
      newExit.newMapX=352; newExit.newMapY=304; newExit.toRoom=rBubbleTowerA6

      global.gamePaused=false
      global.currentBoss=""
      global.bossTrack=0
      global.gameProgress=2090
    }
  }
}
else if global.gameProgress=2100 and room=rMain_36 //----- [Unskippable] Enemy Trap (Dragon Knight) -----
{
  if global.gamePaused=false
  {
    if global.bossTrack=0
    {
      if sceneProgress=0
      {
        if oPlayer1.x<=4000
        {
          instance_create(0,0,oScreenColorOverlay)
          oScreenColorOverlay.image_blend=c_red
          var enemyBarrier;
          enemyBarrier=instance_create(3744,16,oEnemyBarrier); enemyBarrier.image_yscale=16
          enemyBarrier=instance_create(4080,80,oEnemyBarrier); enemyBarrier.image_yscale=12
          var tempMplay;
          tempMplay=findMusic(809)
          playMusic(tempMplay,0,0)
          sceneProgress+=1
        }
      }
      else if sceneProgress=1
      {
        sceneDelay+=1
        if sceneDelay>=1 and sceneDelay<=40
        {
          oScreenColorOverlay.image_alpha+=0.005
          if sceneDelay=30
            {msgCreate(0,0,"Jerry","One of these guys again?",0,1,oMessagePerson,0); newMessage.fadingTime=60}
        }
        else if sceneDelay>=120
        {
          enemyImage=instance_create(3824,288,oMisc)
          enemyImage.sprite_index=sDK_Roll; enemyImage.image_speed=0.3; enemyImage.type=1
          sceneDelay=0; sceneProgress+=1
        }

        tEffect=instance_create(3792+random(64),264+random(32),oEffect)
        tEffect.sprite_index=sBombExplosion
        tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
        if sceneDelay mod 5=0 {playSound(global.snd_BombExplode,0,0.95,1)}
      }
      else if sceneProgress=2
      {
        sceneDelay+=1
        if sceneDelay>=1 and sceneDelay<=20 {enemyImage.y-=8}
        else if sceneDelay=21 {enemyImage.sprite_index=sDK_Fly; enemyImage.image_speed=0.15}
        if sceneDelay>=61 and sceneDelay<=132
        {
          enemyImage.y+=2
          if sceneDelay=132
          {
            enemyImage.sprite_index=sDK_Idle
            sceneDelay=0; sceneProgress+=1
          }
        }
      }
      else if sceneProgress=3
      {
        sceneDelay+=1
        if sceneDelay=30
        {
          msgCreate(0,0,"Dragon Knight","I will crush all who oppose my master!",5,2,oMessagePerson,0); newMessage.fadingTime=100
          enemyImage.sprite_index=sDK_Swing; enemyImage.image_index=0; enemyImage.image_speed=0
          playSound(global.snd_DemonLaugh,0,0.96,1)
        }
        else if sceneDelay>=31 and sceneDelay<=42
        {
          var tAfterI;
          tAfterI=instance_create(x,y,oEnemyAfterImage)
          tAfterI.sprite_index=sDK_Swing; tAfterI.image_index=image_index; tAfterI.image_blend=c_red
          tAfterI.image_alpha=0.75; tAfterI.image_xscale=image_xscale; tAfterI.imageFade=0.05
          tAfterI.xScaling=0.05; tAfterI.yScaling=0.05; tAfterI.xShift=0; tAfterI.yShift=0
          tAfterI.bFollow=1; tAfterI.idFollow=id; tAfterI.xFollow=0; tAfterI.yFollow=0
        }
        else if sceneDelay>=130
        {
          with enemyImage {instance_destroy()}
          var enemyCounter;
          enemyCounter=instance_create(0,0,oEnemyRemain)
          enemyCounter.enemyCount=1
          createEnemy(3824,272,oDragonKnight,2,0,1)
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
        if oEnemyRemain.enemyCount<=0
        {
          with oEnemyRemain {instance_destroy()}
          with oEnemyBarrier {instance_destroy()}
          sceneProgress+=1
        }
      }
      else if sceneProgress=1
      {
        oScreenColorOverlay.image_alpha-=0.01
        if oScreenColorOverlay.image_alpha<=0
        {
          with oScreenColorOverlay {instance_destroy()}
          var tempMplay;
          tempMplay=findMusic(10)
          playMusic(tempMplay,0,0)
          msgCreate(0,0,"Jeremy","Sigh...",0,0,oMessagePerson,0); newMessage.fadingTime=130
          sceneProgress=0
          global.bossTrack=0
          global.gameProgress=2110
        }
      }
    }
  }
}
else if global.gameProgress=2120 and room=rMain_39 //----- [Unskippable] What is going on? -----
{
  if sceneProgress=0
  {
    sceneDelay+=1
    if sceneDelay=1
    {
      oPlayer1.image_xscale=-1
      global.gamePaused=true
      musVolC=global.optMusic*100
      musFileP=findMusic(10)
    }
    else if sceneDelay>=10
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
    if sceneDelay=15
    {
      var tempMplay;
      tempMplay=findMusic(202)
      playMusic(tempMplay,0,0)
      sceneDelay=0; sceneProgress+=1
    }
  }
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"Claire","Eh?",0,3,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Jerry","'Eh?' were my thoughts too.",0,3,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","The Vault is close. Search the area.",0,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Chao","I don't see any hostiles nearby.",0,3,oMessageCutscene,1)
  else if sceneProgress=6 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Then you can see more than I can.",0,3,oMessageCutscene,1)
  else if sceneProgress=7 and bWaitForInput=false
    msgCreate(0,0,"Chao","We shouldn't go any closer. Something is wrong here.",0,3,oMessageCutscene,1)
  else if sceneProgress=8 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","That much I can see, but we need a closer look.",0,3,oMessageCutscene,1)
  else if sceneProgress=9 and bWaitForInput=false
    msgCreate(0,0,"Chao","If you say so.",0,3,oMessageCutscene,1)
  else if sceneProgress=10
  {
    sceneDelay=0; sceneProgress=0
    global.gameProgress=2130
    global.gamePaused=false
  }
}
else if global.gameProgress=2130 and room=rMain_39 //----- [Unskippable] No turning back after this -----
{
  if sceneProgress=0
  {
    if oPlayer1.x<=144 and oPlayer1.y<=208
    {
      sceneDelay+=1
      if sceneDelay=1 {global.gamePaused=true}
      oPlayer1.y+=4
      if oPlayer1.y>=192
      {
        scenePChk(144,192,0,0.1,-1)
        stopPlayer()
        sceneDelay=0; sceneProgress+=1
      }
    }
  }
  else if sceneProgress=1 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Hold up.",0,3,oMessageCutscene,1)
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"Jerry","What's going on, Jeremy?",0,3,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Before you move on, be absolutely sure you're ready.",0,3,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Jerry","I'm always ready.",0,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Don't joke. Just make sure you're prepared before you go any further. I don't know what will happen once we pass through this checkpoint.",0,3,oMessageCutscene,1)
  else if sceneProgress=6 and bWaitForInput=false
    msgCreate(0,0,"Jerry","You're freaking me out, but okay, I'll prepare...",0,3,oMessageCutscene,1)
  else if sceneProgress=7
  {
    sceneDelay=0; sceneProgress=0
    global.gameProgress=2140
    global.gamePaused=false
  }
}
else if global.gameProgress=2140 and room=rMain_39Vault //----- [Unskippable] Start the Vault pull sequence -----
{
  if sceneProgress=0
  {
    sceneDelay+=1
    if sceneDelay=1
    {
      musVolC=global.optMusic*100
      musFileP=findMusic(202)
      oPlayer1.x=336; oPlayer1.image_xscale=-1
      global.gamePaused=true
    }
    else if sceneDelay>=30
    {
      fadeAlpha-=0.01
      if fadeAlpha<=0 {sceneDelay=0; sceneProgress+=1}
    }
  }
  else if sceneProgress=1 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Oh wow. It doesn't even look like there's a lock on it at all...",0,3,oMessageCutscene,1)
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"Jerry","What would be keeping the rest of the malicious bots in there then?",0,3,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","I just said it looks like there isn't, but now that we're here...",0,3,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","I need you to get a bit closer.",0,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Hell no! There's some weird lag field around what I guess is the entrance... we're not going anywhere near that!",0,3,oMessageCutscene,1)
  else if sceneProgress=6 and bWaitForInput=false
    msgCreate(0,0,"Chao","They really shouldn't go any closer, Jeremy. We don't know anything about this.",0,3,oMessageCutscene,1)
  else if sceneProgress=7 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Okay, just stay in the area while I figure out how to read what's going on here.",0,3,oMessageCutscene,1)
  else if sceneProgress=8 and bWaitForInput=false
    msgCreate(0,0,"Chao","Do it quick, they really shouldn't be close to that thing. I... don't like this.",0,3,oMessageCutscene,1)
  else if sceneProgress=9
  {
    sceneDelay+=1
    if sceneDelay=5
    {
      showEmote(oIdentifier,0,-6,sEmExcite)
      scenePChk(oPlayer1.x,oPlayer1.y,2,0.1,-1)
      var tFlash;
      tFlash=instance_create(0,0,oScreenFlash)
      tFlash.image_alpha=0.7; tFlash.fadeSpeed=0.1
      pullIn=1
    }
    else if sceneDelay>=45 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=10 and bWaitForInput=false
    msgCreate(0,0,"Claire","What's happening?!",0,3,oMessageCutscene,1)
  else if sceneProgress=11 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Oh man, get away from that thing!",0,3,oMessageCutscene,1)
  else if sceneProgress=12
  {
    sceneDelay=0; sceneProgress=0
    with oExit {instance_destroy()}
    global.bCanSave=false; global.bCanForceGO=false
    global.gameProgress=2150
    global.gamePaused=false
  }
}
else if global.gameProgress=2160 and room=rMain_39Vault //----- [Unskippable] The Vault -----
{
  if sceneProgress=0
  {
    sceneDelay+=1
    if sceneDelay>=1
    {
      if sceneDelay=1 {global.gamePaused=true}
      fadeAlpha+=0.04
      if fadeAlpha>=1 {sceneDelay=0; sceneProgress+=1}
    }
  }
  else if sceneProgress=1
  {
    oPlayer1.life=oPlayer1.maxLife
    global.recAreaTrans+=1
    global.newMapX=160
    global.newMapY=288
    writeToPlayerGlobals()
    stopAllMusic()
    transition_steps=1
    transition_kind=0
    room_goto(rVault_1)
  }
}
else if global.gameProgress=2540 and room=rMain_39Vault //----- [6] Got out of the Vault -----
{
  if sceneProgress=0
  {
    sceneDelay+=1
    if sceneDelay=1 {global.gamePaused=true}
    else if sceneDelay>=20
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
    msgCreate(0,0,"Jerry","Wait a minute...",0,3,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Claire","What?",0,3,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Jerry","WE ACTUALLY MADE IT!",0,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Jerry","And I'm not really sure how. Jeremy pulled some strings there.",0,3,oMessageCutscene,1)
  else if sceneProgress=6 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Well you know. I still had a few tricks.",0,3,oMessageCutscene,1)
  else if sceneProgress=7 and bWaitForInput=false
    msgCreate(0,0,"Chao","Hey I helped too!",0,3,oMessageCutscene,1)
  else if sceneProgress=8 and bWaitForInput=false
    msgCreate(0,0,"Jerry","... So...",0,3,oMessageCutscene,1)
  else if sceneProgress=9 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","I don't know what happened to the Abomination. I can't track it at all. What about you, Chao?",0,3,oMessageCutscene,1)
  else if sceneProgress=10 and bWaitForInput=false
    msgCreate(0,0,"Chao","Same here. It was way too far ahead to see.",0,3,oMessageCutscene,1)
  else if sceneProgress=11 and bWaitForInput=false
    msgCreate(0,0,"Jerry","If it got out, wouldn't this place be leveled by now?",0,3,oMessageCutscene,1)
  else if sceneProgress=12 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","You would think so.",0,3,oMessageCutscene,1)
  else if sceneProgress=13 and bWaitForInput=false
    msgCreate(0,0,"Jerry","That's not comforting... So what are we doing now? Do we go after Hex or get the other 2 Program Chips?",0,3,oMessageCutscene,1)
  else if sceneProgress=14 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Get back to Syrus and Gene. We need to update them with what we've found. We'll decide what to do from there.",0,3,oMessageCutscene,1)
  else if sceneProgress=15 and bWaitForInput=false
    msgCreate(0,0,"Jerry","What about the Vault gate here?",0,3,oMessageCutscene,1)
  else if sceneProgress=16 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","It looks like you can still go back in. Now that things have settled and we're out here again, I've set this spot as a teleport location for when you're in the Vault.",0,3,oMessageCutscene,1)
  else if sceneProgress=17 and bWaitForInput=false
    msgCreate(0,0,"Jerry","So nothing bad will happen if I go back in?",0,3,oMessageCutscene,1)
  else if sceneProgress=18 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Nope. Also it looks like there's a red gate accessible now.",0,3,oMessageCutscene,1)
  else if sceneProgress=19
  {
    sceneDelay=0; sceneProgress=0
    global.gameProgress=2550
    global.gamePaused=false
  }
}

keyWaitForInput()

if oKeyCodes.kCodePressed[11]=1 and global.gamePaused=true and sceneProgress>=1 //Cutscene skip
{
  if !instance_exists(oPauseMenu)
  {
    if global.gameProgress=2000 and room=rCCity_NA_S2 //[1]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      fadeAlpha=0; sceneDelay=0
      sceneProgress=17
    }
    else if global.gameProgress=2020 and room=rMain_31 //[2]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      fadeAlpha=0; sceneDelay=0
      sceneProgress=8
    }
    else if global.gameProgress=2030 and room=rMain_34 //[3]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      fadeAlpha=0; sceneDelay=0
      sceneProgress=25
    }
    else if global.gameProgress=2040 and room=rBubbleTowerA1 //[4]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      fadeAlpha=0; sceneDelay=0
      sceneProgress=4
    }
    else if global.gameProgress=2080 and room=rBubbleTowerA7 //[5: Boss: Army Eye]
    {
      if global.bossTrack=0
      {
        bWaitForInput=false
        with oMessageCutscene {instance_destroy()}
        fadeAlpha=0; sceneDelay=0
        sceneProgress=10
      }
      else if global.bossTrack=2
      {
        bWaitForInput=false
        with oMessageCutscene {instance_destroy()}
        with oMisc {instance_destroy()}
        fadeAlpha=0; sceneDelay=0
        sceneProgress=46
      }
    }
    else if global.gameProgress=2540 and room=rMain_39Vault //[6]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      fadeAlpha=0; sceneDelay=0
      sceneProgress=19
    }
  }
}

//----- Room specific events -----
if room=rMain_32 //Check if wall destroyed
{
  if indexCheck="0"
  {
    if !instance_exists((239892))
    {
      with (239269) {instance_destroy()}
      with (239270) {instance_destroy()}
      tile_layer_hide(999995)
      var tEffect;
      for(i=0;i<10;i+=1)
      {
        tEffect=instance_create(0+random(64),1072+random(80),oEffect)
        tEffect.sprite_index=sRobotExplosion; tEffect.image_speed=0.4+random(0.2)
        tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
      }
      indexCheck="1"
    }
  }
}
else if room=rMain_34 //Check if wall destroyed
{
  if global.gameProgress=2090
  {
    if sceneProgress=0
    {
      if oPlayer1.x>=1952 and oPlayer1.y>=752
      {
        msgCreate(0,0,"Jeremy","Watch for those arrows formed from rocks. They point to places to blow up!",0,2,oMessagePerson,0)
        newMessage.fadingTime=160
        sceneProgress+=1
      }
    }

    if !instance_exists((243531))
    {
      with (241042) {instance_destroy()}
      with (241136) {instance_destroy()}
      tile_layer_hide(999995)
      var tEffect;
      for(i=0;i<40;i+=1)
      {
        tEffect=instance_create(1568+random(384),784+random(128),oEffect)
        tEffect.sprite_index=sRobotExplosion; tEffect.image_speed=0.4+random(0.2)
        tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
      }
      for(i=0;i<24;i+=1)
      {
        tEffect=instance_create(1952+random(176),848+random(144),oEffect)
        tEffect.sprite_index=sRobotExplosion; tEffect.image_speed=0.4+random(0.2)
        tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
      }
      global.gameProgress=2100
    }
  }
}
else if room=rMain_35 //Check if wall destroyed
{
  if indexCheck="0"
  {
    if !instance_exists((244121))
    {
      tile_layer_hide(999995)
      var tEffect;
      for(i=0;i<12;i+=1)
      {
        tEffect=instance_create(688+random(80),944+random(80),oEffect)
        tEffect.sprite_index=sRobotExplosion; tEffect.image_speed=0.4+random(0.2)
        tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
      }
      indexCheck="1"
    }
  }
}
else if room=rMain_36 //Check if wall destroyed
{
  if indexCheck="0"
  {
    if !instance_exists((244640))
    {
      with (244634) {instance_destroy()}
      with (244636) {instance_destroy()}
      with (244638) {instance_destroy()}
      tile_layer_hide(999995)
      instance_create(4160,112,oLargeJumper)
      var tEffect;
      for(i=0;i<30;i+=1)
      {
        tEffect=instance_create(4144+random(224),16+random(96),oEffect)
        tEffect.sprite_index=sRobotExplosion; tEffect.image_speed=0.4+random(0.2)
        tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
      }
      indexCheck="1"
    }
  }
}
else if room=rMain_39Vault
{
  if pullIn=1
  {
    particleTime-=1
    if particleTime<=0
    {
      var tNewObj,tYY,tSize;
      tSize=1+random(0.4)
      tYY=32+random(room_height-64)
      tNewObj=instance_create(room_width+8,tYY,oMisc)
      tNewObj.sprite_index=sBelmontWepEffect; tNewObj.turnSpd=0
      tNewObj.type=3; tNewObj.image_xscale=tSize; tNewObj.image_yscale=tSize; tNewObj.image_alpha=0.5+random(0.3)
      tNewObj.direction=point_direction(room_width+8,tYY,oVaultGate.x+32,oVaultGate.y+32); tNewObj.speed=1+random(1)
      particleTime=4+irandom(5)
    }

    objectTime-=1
    if objectTime<=0
    {
      var tNewObj,tYY,tSprite;
      tYY=8+random(room_height-16)
      tSprite=irandom_range(0,5)
      tNewObj=instance_create(room_width+8,tYY,oMisc)
      if tSprite=0 {tNewObj.sprite_index=sGoomba}
      else if tSprite=1 {tNewObj.sprite_index=sGreenParatroopa}
      else if tSprite=2 {tNewObj.sprite_index=sMagicalBeeFly}
      else if tSprite=3 {tNewObj.sprite_index=sWB_Crab_Walk}
      else if tSprite=4 {tNewObj.sprite_index=sWB_BigBat_Fly}
      else if tSprite=5 {tNewObj.sprite_index=sSparkyDown}
      tNewObj.type=3; tNewObj.image_alpha=0.5+random(0.3); tNewObj.turnSpd=irandom_range(-10,10)
      tNewObj.direction=point_direction(room_width+8,tYY,oVaultGate.x+32,oVaultGate.y+32); tNewObj.speed=1+random(1)
      objectTime=30+irandom(30)
    }

    if global.gamePaused=false
    {
      pullTime+=1
      if pullTime=60 {pullPwr+=1}
      else if pullTime=120 {pullPwr+=1}
      else if pullTime=180 {pullPwr+=1}
      else if pullTime=240 {pullPwr+=1}
      else if pullTime=300 {pullPwr+=1}
      else if pullTime=360 {pullPwr+=1}
      else if pullTime=420 {pullPwr+=1}
      else if pullTime=480 {pullPwr+=1}
      oPlayer1.xVel=-pullPwr
      if oPlayer1.dashEnergy>10 {oPlayer1.dashEnergy-=10}

      var tDistToVault,tNewVol;
      tDistToVault=point_distance(oPlayer1.x,oPlayer1.y-26,oVaultGate.x+32,oVaultGate.y+32)
      tNewVol=5000-(tDistToVault*20)
      musVolC=(global.optMusic*100)-tNewVol
      SS_SetSoundVol(musFileP,musVolC)
    }
  }
}
else if room=rBubbleTowerA4 //Assistance
{
  if global.gameProgress<=2070 and eggBotCheck=0
  {
    if !instance_exists(oEggBot)
    {
      msgCreate(0,0,"Chao","That Eggbot may have been useful for something...",0,1,oMessagePerson,0)
      newMessage.fadingTime=150
      eggBotCheck=1
    }
  }
}
else if room=rBubbleTowerA5 //Achievement
{
  if achieveCheck=0
  {
    if !instance_exists(oWB_Crab)
    {
      var tCheckAchieve;
      tCheckAchieve=string_char_at(global.tokenRecognitions,37)
      if tCheckAchieve="0"
      {
        var tAchievement;
        tAchievement=instance_create(0,0,oAchievementNotice)
        tAchievement.myAchievement="Let None Live"; tAchievement.checkNum=37
      }
      achieveCheck=1
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

if room=rMain_39
{
  colorInverter(1,352+sizeMod,0)
}
