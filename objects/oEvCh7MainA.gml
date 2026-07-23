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
progressBar=0
achievementCoins=0

if global.gameProgress=1530
{
  fadeColor=c_black
  fadeAlpha=1
  oNPC_Syrus.image_xscale=-1
}

if room=rMain_21
{
  skyBeamAlpha=0
  skyBeamX=1232
  skyBeamWidth=0
}
else if room=rMountTemple_J
{
  if global.gameProgress=1690
  {
    npcMMX=instance_create(240,288,oMisc)
    npcMMX.sprite_index=sMegamanXIdle
    npcMMX.type=1
    storyObject=instance_create(288,256,oMisc)
    storyObject.sprite_index=sAccessCode
    storyObject.type=1
  }
}
else if room=rMain_28
{
  if global.gameProgress=1720
  {
    npcMMX=instance_create(1248,288,oMisc)
    npcMMX.sprite_index=sMegamanXKneel
    npcMMX.type=1
  }
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gameProgress=1530 and room=rCCity_NA_S2 //----- [1] X went out west -----
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
    else if sceneDelay=30
    {
      var tNewChapter,tempMplay;
      tNewChapter=instance_create(0,0,oChapterDisplay)
      tNewChapter.newChapter="Chapter 7#Familiar Ways"
    }
    else if sceneDelay>=60
    {
      fadeAlpha-=0.01
      if fadeAlpha<=0 {sceneDelay=0; sceneProgress+=1}
    }
  }
  else if sceneProgress=1 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Claire got the 3rd Program Chip along with the ability to not be useless.",0,3,oMessageCutscene,1)
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"Syrus","You two really need to stop fighting.",6,3,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Excuse me?",0,3,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Oh no... Uh, moving on...",0,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Syrus","You may want to know about the status of the Vault.",6,3,oMessageCutscene,1)
  else if sceneProgress=6 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Definitely. What's happening with that?",0,3,oMessageCutscene,1)
  else if sceneProgress=7 and bWaitForInput=false
    msgCreate(0,0,"Gene","As we said before, it's unstable at best, but still holding up.",6,3,oMessageCutscene,1)
  else if sceneProgress=8 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Did you find any way of keeping it closed up?",0,3,oMessageCutscene,1)
  else if sceneProgress=9 and bWaitForInput=false
    msgCreate(0,0,"Gene","No. The issue, I believe, is not just the Virus, but something in the Vault itself. Since it's not acting as it should, we believe an entity inside is causing the lock to falter and leak those malicious bots.",0,3,oMessageCutscene,1)
  else if sceneProgress=10 and bWaitForInput=false
    msgCreate(0,0,"Jerry","What if we went in?",0,3,oMessageCutscene,1)
  else if sceneProgress=11 and bWaitForInput=false
    msgCreate(0,0,"Gene","That's a highly dangerous idea. There's no guarantee that you would be able to make it out. And if something from inside is indeed the cause of these problems with it, then it is safe to assume it has control of the inner workings of the Vault.",6,3,oMessageCutscene,1)
  else if sceneProgress=12 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","So you're saying it would be the equivalent of the distortion worlds we came across before?",0,3,oMessageCutscene,1)
  else if sceneProgress=13 and bWaitForInput=false
    msgCreate(0,0,"Gene","Yes. Just as Hexor had a fair amount of control over those places, whatever is inside the Vault has that much control over it, if not more. This is all speculation though.",6,3,oMessageCutscene,1)
  else if sceneProgress=14 and bWaitForInput=false
    msgCreate(0,0,"Syrus","My idea was for one of us to go inspect the entrance.",6,3,oMessageCutscene,1)
  else if sceneProgress=15 and bWaitForInput=false
    msgCreate(0,0,"Claire","We couldn't get near it, the world gets fuzzy if we go anywhere near that area.",0,3,oMessageCutscene,1)
  else if sceneProgress=16 and bWaitForInput=false
    msgCreate(0,0,"Gene","I'm working on a program that should let you through that. And while I'm uneasy with Syrus' idea of going near that place, it seems to be the only option we have.",6,3,oMessageCutscene,1)
  else if sceneProgress=17 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","What can we do while you're working on the program?",0,3,oMessageCutscene,1)
  else if sceneProgress=18 and bWaitForInput=false
    msgCreate(0,0,"Syrus","X went out west just a few moments before you arrived. He left in a hurry and didn't explain why.",6,3,oMessageCutscene,1)
  else if sceneProgress=19 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Let's follow him.",0,3,oMessageCutscene,1)
  else if sceneProgress=20 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","I'm picking up an access code from that area, but the west gate exit is blocked.",0,3,oMessageCutscene,1)
  else if sceneProgress=21 and bWaitForInput=false
    msgCreate(0,0,"Syrus","Not anymore. We lifted the lock on that barrier some time ago.",6,3,oMessageCutscene,1)
  else if sceneProgress=22 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Seems we have our destination.",0,3,oMessageCutscene,1)
  else if sceneProgress=23 and bWaitForInput=false
    msgCreate(0,0,"Syrus","Good luck to you all. I'll have that program done before you get back.",6,3,oMessageCutscene,1)
  else if sceneProgress=24
  {
    var tFlash;
    tFlash=instance_create(0,0,oScreenFlash)
    tFlash.fadeSpeed=0.2
    oPlayer1.visible=1
    if global.activeCharacter=0 oPlayer1.x=charJerry.x
    else if global.activeCharacter=1 oPlayer1.x=charClaire.x
    with oMisc {instance_destroy()}
    sceneDelay=0; sceneProgress=0
    global.gameProgress=1540
    global.gamePaused=false
  }
}
else if global.gameProgress=1550 and room=rMain_20 //----- [2] New places to go -----
{
  if sceneProgress=0
  {
    sceneDelay+=1
    if sceneDelay=1 {global.gamePaused=true}
    else if sceneDelay>=20 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=1 and bWaitForInput=false
    msgCreate(0,0,"Chao","Lovely.",0,3,oMessageCutscene,1)
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"Jerry","I played this game way back.",0,3,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Like many others we've seen here.",0,3,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Hey hey, we'll have none of that.",0,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Oh whatever Jerry.",0,3,oMessageCutscene,1)
  else if sceneProgress=6 and bWaitForInput=false
    msgCreate(0,0,"Chao","Jeremy, do you see that?",0,3,oMessageCutscene,1)
  else if sceneProgress=7 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","See what?",0,3,oMessageCutscene,1)
  else if sceneProgress=8 and bWaitForInput=false
    msgCreate(0,0,"Chao","There's something really strong out here.",0,3,oMessageCutscene,1)
  else if sceneProgress=9 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","I'm sort of picking it up, but it's weak for me.",0,3,oMessageCutscene,1)
  else if sceneProgress=10 and bWaitForInput=false
    msgCreate(0,0,"Chao","Weird, I can see it clearly. Move with caution you guys, there's something really strong close by.",0,3,oMessageCutscene,1)
  else if sceneProgress=11
  {
    sceneDelay=0; sceneProgress=0
    global.gameProgress=1560
    global.gamePaused=false
  }
}
else if global.gameProgress=1570 and room=rMain_21 //----- [Unskippable] Enemy Trap (Blood Tyrant) -----
{
  if global.gamePaused=false
  {
    if global.bossTrack=0
    {
      if sceneProgress=0
      {
        if oPlayer1.x<=1456
        {
          instance_create(0,0,oScreenColorOverlay)
          oScreenColorOverlay.image_blend=c_red
          var enemyBarrier;
          enemyBarrier=instance_create(1136,0,oEnemyBarrier); enemyBarrier.image_yscale=16
          enemyBarrier=instance_create(1536,0,oEnemyBarrier); enemyBarrier.image_yscale=16
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
            {msgCreate(0,0,"Jerry","Eh, what's this?",0,1,oMessagePerson,0); newMessage.fadingTime=60}
        }
        else if sceneDelay>=51 and sceneDelay<=100
        {
          if sceneDelay<=70
          {
            skyBeamAlpha+=0.01
            skyBeamWidth+=1
          }
        }
        else if sceneDelay=111
          {msgCreate(0,0,"Chao","Something bad is coming down...",0,1,oMessagePerson,0); newMessage.fadingTime=80}
        else if sceneDelay=200
        {
          eImageDrop=instance_create(1232,0,oMisc)
          eImageDrop.sprite_index=sBT_Idle; eImageDrop.image_speed=0; eImageDrop.type=1
          var tempMplay;
          tempMplay=findMusic(809)
          playMusic(tempMplay,0,0)
        }
        else if sceneDelay>=201
        {
          if sceneDelay=290
            {msgCreate(0,0,"Jerry","What is that thing?",0,1,oMessagePerson,0); newMessage.fadingTime=60}
          else if sceneDelay=360
            {msgCreate(0,0,"Chao","I don't know, but it's incredibly dangerous.",0,1,oMessagePerson,0); newMessage.fadingTime=90}
          else if sceneDelay=450
            {msgCreate(0,0,"Jeremy","This is weird, I can't access any of its data.",0,1,oMessagePerson,0); newMessage.fadingTime=90}
          else if sceneDelay=540
            {msgCreate(0,0,"Claire","We can handle this.",0,1,oMessagePerson,0); newMessage.fadingTime=60}
          else if sceneDelay=630
            {msgCreate(0,0,"Jerry","I don't like this...",0,1,oMessagePerson,0); newMessage.fadingTime=60}

          eImageDrop.y+=0.5
          if eImageDrop.y>=288 {sceneDelay=0; sceneProgress+=1}
        }
      }
      else if sceneProgress=2
      {
        sceneDelay+=1
        if sceneDelay>=30
        {
          skyBeamWidth-=1
          skyBeamAlpha-=0.02
          if skyBeamAlpha<=0 {sceneDelay=0; sceneProgress+=1}
        }
      }
      else if sceneProgress=3
      {
        sceneDelay+=1
        if sceneDelay=20
          {msgCreate(0,0,"Blood Tyrant","Our master has ordered your removal from the system.#Swift execution of this task begins now!",5,2,oMessagePerson,0); newMessage.fadingTime=130}
        else if sceneDelay>=160
        {
          with eImageDrop {instance_destroy()}
          var enemyCounter;
          enemyCounter=instance_create(0,0,oEnemyRemain)
          enemyCounter.enemyCount=1
          createEnemy(1232,288,oBloodTyrant,2,0,1)
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
          tempMplay=findMusic(7)
          playMusic(tempMplay,0,0)
          msgCreate(0,0,"Jeremy","What's going on with this, I couldn't bring up ANY info on that thing!?",0,1,oMessagePerson,0); newMessage.fadingTime=130
          sceneProgress=0
          global.bossTrack=0
          global.gameProgress=1580
        }
      }
    }
  }
}
else if global.gameProgress=1580 and room=rMain_22 //----- [3] Locked data -----
{
  if sceneProgress=0
  {
    sceneDelay+=1
    if sceneDelay=1 {global.gamePaused=true}
    else if sceneDelay>=20 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=1 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Chao, you were able to see that thing's data?",0,3,oMessageCutscene,1)
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"Chao","Most of it.",0,3,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","That's weird... Where did it come from?",0,3,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Chao","I don't know, but the AI procedures were a bit more advanced than anything else we've seen.",0,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Claire","It said, 'our master.' Any idea what that was about?",0,3,oMessageCutscene,1)
  else if sceneProgress=6 and bWaitForInput=false
    msgCreate(0,0,"Chao","I know as much as you there. It's kind of creepy though and makes me feel like someone is watching us.",0,3,oMessageCutscene,1)
  else if sceneProgress=7 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Well, whoever it is doesn't want you guys out here.",0,3,oMessageCutscene,1)
  else if sceneProgress=8 and bWaitForInput=false
    msgCreate(0,0,"Chao","Yep, there are more of those too. I'll try to give you a heads up when one gets close.",0,3,oMessageCutscene,1)
  else if sceneProgress=9 and bWaitForInput=false
    msgCreate(0,0,"Jerry","As long as two of them don't show up...",0,3,oMessageCutscene,1)
  else if sceneProgress=10
  {
    sceneDelay=0; sceneProgress=0
    global.gameProgress=1590
    global.gamePaused=false
  }
}
else if global.gameProgress=1590 and room=rMountTemple_A //----- [4] X is here -----
{
  if sceneProgress=0
  {
    sceneDelay+=1
    if sceneDelay=1 {global.gamePaused=true}
    else if sceneDelay>=20 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=1 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","X is here.",0,3,oMessageCutscene,1)
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"Chao","And confirmed, I can see that he is in this place too.",0,3,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Anything we should be mindful of?",0,3,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Lots of traps.",0,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Dusty Ruins all over again.",0,3,oMessageCutscene,1)
  else if sceneProgress=6
  {
    sceneDelay=0; sceneProgress=0
    global.gameProgress=1600
    global.gamePaused=false
  }
}
else if global.gameProgress=1610 and room=rMountTemple_C //----- [5] A Blood Tyrant -----
{
  if sceneProgress=0
  {
    sceneDelay+=1
    if sceneDelay=1 {global.gamePaused=true}
    else if sceneDelay>=20 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=1 and bWaitForInput=false
    msgCreate(0,0,"Chao","One of those Blood Tyrants is close by, and I've detected something from that Castlevania Gate. I'll warn you when the Blood Tyrant gets close.",0,3,oMessageCutscene,1)
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","You're also gonna have to split up and I'm not sure where the Blood Tyrant will attack.",0,3,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Claire","We can handle it.",0,3,oMessageCutscene,1)
  else if sceneProgress=4
  {
    sceneDelay=0; sceneProgress=0
    global.gameProgress=1620
    global.gamePaused=false
  }
}
else if global.gameProgress=1620 and room=rMountTemple_C //----- [] Blood Tyrant (Sword Knights) fight -----
{
  if sceneProgress=0
  {
    enTyrantA=0; enTyrantB=0
    sceneProgress+=1
  }
  else if sceneProgress=1
  {
    if enTyrantA=0
    {
      if oPlayer1.x>=2272 and oPlayer1.x<=2384 and oPlayer1.y>=496
      {
        newSwordA=instance_create(2144,656,oCV_SwordKnight); newSwordA.bActive=1
        newSwordB=instance_create(2400,656,oCV_SwordKnight); newSwordB.bActive=1
        enemyBarrierA=instance_create(2064,528,oEnemyBarrier); enemyBarrierA.image_yscale=4
        enTyrantA=1
      }
    }
    else if enTyrantA=1
    {
      if !instance_exists(oCV_SwordKnight)
      {
        with enemyBarrierA {instance_destroy()}
        with (205945) {instance_destroy()}
        enTyrantA=2
      }
    }

    if enTyrantB=0
    {
      if oPlayer1.x<=848 and oPlayer1.y>=704
      {
        msgCreate(0,0,"Jeremy","Careful, one of those Tyrants are up ahead.",0,1,oMessagePerson,0)
        newMessage.fadingTime=100
        enTyrantB=1
      }
    }
    if enTyrantB=1
    {
      if oPlayer1.x<=528 and oPlayer1.y>=704
      {
        newTyrantB=instance_create(304,816,oBloodTyrant); newTyrantB.bActive=1
        enemyBarrierB=instance_create(672,720,oEnemyBarrier); enemyBarrierB.image_yscale=6
        enTyrantB=2
      }
    }
    else if enTyrantB=2
    {
      if !instance_exists(newTyrantB)
      {
        with enemyBarrierB {instance_destroy()}
        with (205946) {instance_destroy()}
        enTyrantB=3
      }
    }
  }
}
else if global.gameProgress=1630 and room=rMountTemple_D //----- [] Blood Tyrant again -----
{
  if sceneProgress=0
  {
    if oPlayer1.x>=144
    {
      var newEnemy,enemyBarrier;
      newEnemy=instance_create(432,288,oBloodTyrant); newEnemy.bActive=1
      enemyBarrier=instance_create(80,96,oEnemyBarrier); enemyBarrier.image_yscale=12
      enemyBarrier=instance_create(480,96,oEnemyBarrier); enemyBarrier.image_yscale=8
      sceneProgress+=1
    }
  }
  else if sceneProgress=1
  {
    if !instance_exists(oBloodTyrant)
    {
      with oEnemyBarrier {instance_destroy()}
      global.gameProgress=1640
      sceneProgress=0
    }
  }
}
else if global.gameProgress=1640 and room=rMountTemple_D //----- [6] Get Mermaid Curves -----
{
  if sceneProgress=0 and !instance_exists(oStoryObject)
  {
    sceneDelay+=1
    if sceneDelay=1 {global.gamePaused=true}
    else if sceneDelay>=2
    {
      oPlayer1.y+=4
      if oPlayer1.y>=208
      {
        scenePChk(oPlayer1.x,208,0,0.1,1)
        stopPlayer()
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
    msgCreate(0,0,"Jerry","I'm tired of all these Tyrants now.",0,3,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Chao","Lucky for you, I don't see any more in the temple.",0,3,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Jerry","This place reminds me of something else I had to do in the past.",0,3,oMessageCutscene,1)
  else if sceneProgress=5
  {
    var tNewTutorial;
    tNewTutorial=instance_create(0,0,oTutorialPanel)
    tNewTutorial.tutorialTitle="Useless"
    tNewTutorial.tutorialInfo="This is just here to take up space and bother you for a moment to read it."
    tNewTutorial.scrAreaY=0
    sceneDelay=0; sceneProgress=0
    global.gameProgress=1650
    global.gamePaused=false
  }
}
else if global.gameProgress=1650 and room=rMountTemple_G //----- [7] X is close -----
{
  if sceneProgress=0
  {
    sceneDelay+=1
    if sceneDelay=1 {global.gamePaused=true}
    else if sceneDelay>=20 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=1 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","X is close by, but he's not in this temple.",0,3,oMessageCutscene,1)
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Then why are we in here?",0,3,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","To get to the other side?",0,3,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Oh man, couldn't we have just gone around?",0,3,oMessageCutscene,1)
  else if sceneProgress=5
  {
    sceneDelay+=1
    if sceneDelay=1
    {
      msgCreate(0,0,"Jeremy","N...",0,3,oMessagePerson,0)
      newMessage.fadingTime=15
    }
    else if sceneDelay>=9 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=6 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Don't explain it! Let's just do this.",0,3,oMessageCutscene,1)
  else if sceneProgress=7
  {
    sceneDelay=0; sceneProgress=0
    with oMessagePerson {instance_destroy()}
    global.gameProgress=1660
    global.gamePaused=false
  }
}
else if global.gameProgress=1660 and room=rMountTemple_G //----- [] Getting Player stuck -----
{
  if sceneProgress=0
  {
    if oPlayer1.x>=1392 and oPlayer1.x<=1424 and oPlayer1.y>=512 and oPlayer1.y<=628
    {
      if (oPlayerIdle.y>=756) or (oPlayerIdle.x>=1456 and oPlayerIdle.y>=512)
      if global.activeCharacter=0 {sceneProgress=1}
      else {sceneProgress=2}
    }
    else if oPlayerIdle.x>=1392 and oPlayerIdle.x<=1424 and oPlayerIdle.y>=512 and oPlayerIdle.y<=628
    {
      if (oPlayer1.y>=756) or (oPlayer1.x>=1456 and oPlayer1.y>=512)
      if global.activeCharacter=0 {sceneProgress=2}
      else {sceneProgress=1}
    }
  }
  else if sceneProgress=1 //Jerry trapped
  {
    sceneDelay+=1
    if sceneDelay=1
    {
      msgCreate(0,0,"Jerry","So uh... yeah, what the hell Claire?",0,3,oMessagePerson,0)
      newMessage.fadingTime=70
    }
    else if sceneDelay=70
    {
      msgCreate(0,0,"Claire","Hey, you're the one that didn't get yourself out of there.",0,3,oMessagePerson,0)
      newMessage.fadingTime=85
    }
    else if sceneDelay=165
    {
      msgCreate(0,0,"Jerry","Damn, that is cold hearted.",0,3,oMessagePerson,0)
      newMessage.fadingTime=65
    }
    else if sceneDelay=230
    {
      msgCreate(0,0,"Chao","Bet you won't make silly comments toward Claire anymore.",0,3,oMessagePerson,0)
      newMessage.fadingTime=90
    }
    else if sceneDelay=320
    {
      msgCreate(0,0,"Jerry","No no, I'm going to make them even more now!",0,3,oMessagePerson,0)
      newMessage.fadingTime=80
    }
    else if sceneDelay>=400
    {
      sceneDelay=0
      sceneProgress=3
    }
  }
  else if sceneProgress=2 //Claire trapped
  {
    sceneDelay+=1
    if sceneDelay=1
    {
      msgCreate(0,0,"Claire","Oh come on, Jerry!",0,3,oMessagePerson,0)
      newMessage.fadingTime=60
    }
    else if sceneDelay=60
    {
      msgCreate(0,0,"Jerry","We need a screenshot feature so bad! I think it's F9, Jeremy.",0,3,oMessagePerson,0)
      newMessage.fadingTime=90
    }
    else if sceneDelay=150
    {
      msgCreate(0,0,"Claire","You're horrible!",0,3,oMessagePerson,0)
      newMessage.fadingTime=60
    }
    else if sceneDelay=210
    {
      msgCreate(0,0,"Jerry","You'd be far worse if the reverse of this happened.",0,3,oMessagePerson,0)
      newMessage.fadingTime=90
    }
    else if sceneDelay=300
    {
      msgCreate(0,0,"Claire","Whatever, Jerry... but yes I would.",0,3,oMessagePerson,0)
      newMessage.fadingTime=90
    }
    else if sceneDelay>=390
    {
      sceneDelay=0
      sceneProgress=3
    }
  }
  else if sceneProgress=3 //Jeremy fixing the problem
  {
    sceneDelay+=1
    if sceneDelay=1
    {
      msgCreate(0,0,"Jeremy","Eh, I'll fix this.",0,3,oMessagePerson,0)
      newMessage.fadingTime=80
    }
    else if sceneDelay=100
    {
      if oPlayer1.x>=1392 and oPlayer1.x<=1424 and oPlayer1.y>=512 and oPlayer1.y<=628
      {
        oPlayer1.x=1312
        oPlayer1.y=656
      }
      else if oPlayerIdle.x>=1392 and oPlayerIdle.x<=1424 and oPlayerIdle.y>=512 and oPlayerIdle.y<=628
      {
        oPlayerIdle.x=1312
        oPlayerIdle.y=656
      }
      var tCheckAchieve;
      tCheckAchieve=string_char_at(global.tokenRecognitions,31)
      if tCheckAchieve="0"
      {
        var tAchievement;
        tAchievement=instance_create(0,0,oAchievementNotice)
        tAchievement.myAchievement="Stuck in the Mountains"; tAchievement.checkNum=31
      }
      sceneDelay=0; sceneProgress+=1
    }
  }
}
else if global.gameProgress=1670 and room=rMountTemple_H //----- [Unskippable] Enemy Trap -----
{
  if global.gamePaused=false
  {
    if sceneProgress=0
    {
      if oPlayer1.x<=432
      {
        var enemyCounter,enemyBarrier;
        enemyCounter=instance_create(0,0,oEnemyRemain)
        enemyCounter.enemyCount=2

        enemyBarrier=instance_create(672,160,oEnemyBarrier); enemyBarrier.image_yscale=6
        enemyBarrier=instance_create(272,96,oEnemyBarrier); enemyBarrier.image_yscale=12
        createEnemy(320,0,oWB_SilverKnight,2,0,1)
        createEnemy(544,0,oWB_SilverKnight,2,0,1)
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
        global.gameProgress=1680
      }
    }
  }
}
else if global.gameProgress=1680 and room=rMountTemple_I //----- [8] Boss Fight: Enmity -----
{
  if global.bossTrack=0
  {
    if sceneProgress=0 and oPlayer1.x>=288
    {
      with oExit {instance_destroy()}
      sceneProgress+=1
    }
    else if sceneProgress=1
    {
      sceneDelay+=1
      if sceneDelay=1
      {
        virusEntity=instance_create(oEnmity.x,oEnmity.y,oMisc)
        virusEntity.sprite_index=sVirusSpikeIdle; virusEntity.image_speed=0.1
        virusEntity.image_alpha=0; virusEntity.depth=24; virusEntity.type=2
        virDist=160; virDir=0
        sceneDelay=0; sceneProgress+=1
      }
    }
    else if sceneProgress=2
    {
      sceneDelay+=1
      virusEntity.x=oEnmity.x+lengthdir_x(virDist,virDir)
      virusEntity.y=oEnmity.y+lengthdir_y(virDist,virDir)
      virDir+=2

      if sceneDelay>=20 and virusEntity.image_alpha<1
      {
        virusEntity.image_alpha+=0.01
        tDir=0
      }

      if sceneDelay=25
      {
        msgCreate(0,0,"Hostile Virus","You will not proceed.",5,0,oMessagePerson,0)
        newMessage.fadingTime=60
      }
      else if sceneDelay=95
      {
        msgCreate(0,0,"Jerry","Oh man, it talks.",0,0,oMessagePerson,0)
        newMessage.fadingTime=60
      }
      else if sceneDelay=155
      {
        msgCreate(0,0,"Claire","Jerry, we knew that already, it talked on the island.",0,1,oMessagePerson,0)
        newMessage.fadingTime=90
      }

      if sceneDelay>=80
      {
        virDist-=1
        if virDist<=1
        {
          for(i=0;i<40;i+=1)
          {
            tEffect=instance_create(virusEntity.x,virusEntity.y,oEffectB)
            tEffect.type=3; tEffect.sprite_index=sVirusGel; tEffect.image_alpha=0.75
            tEffect.image_speed=0.15; tEffect.direction=tDir+irandom_range(-2,2); tEffect.friction=0.01
            tEffect.speed=random(1)+1; tEffect.fadeSpd=0.01
            tEffect.AccelX=0; tEffect.AccelY=0; tEffect.newBlend=-1; tEffect.followID=-1; tEffect.rotation=0
            tDir+=360/40
          }
          with virusEntity {instance_destroy()}

          var tBossTitle,tempMplay;
          tBossTitle=instance_create(0,0,oBossNameDisplay)
          tBossTitle.bossName="Enmity"
          tBossTitle.bossTitle="Virus Infected Mechanical Terror"
          tempMplay=findMusic(809)
          playMusic(tempMplay,0,0)
          sceneDelay=0; sceneProgress+=1
        }
      }
    }
    else if sceneProgress=3
    {
      sceneDelay+=1
      if sceneDelay=1
      {
        fadeInColor=100
      }
      else if sceneDelay>=2 and sceneDelay<=499
      {
        fadeInColor+=1
        oEnemyBase.image_blend=make_color_rgb(fadeInColor,fadeInColor,fadeInColor)
        if fadeInColor=255 {sceneDelay=500}
      }
      else if sceneDelay>=520 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=4
    {
      msgCreate(0,0,"Hostile Virus","This ends here.",5,0,oMessagePerson,0)
      newMessage.fadingTime=55
      oEnmity.activateBoss=1
      global.currentBoss="Enmity"
      global.bossTrack=1
      storeStatus(0)
      sceneDelay=0; sceneProgress=0
    }
  }
  else if global.bossTrack=1
  {
    if !instance_exists(oEnmity) and sceneProgress=0 //End Boss
    {
      global.gamePaused=true
      awardBossAP(2100)
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
        scenePChk(288,320,0,0.1,1)
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
      msgCreate(0,0,"Jerry","What the mess, did we really just do that, Claire?",0,3,oMessageCutscene,1)
    else if sceneProgress=5 and bWaitForInput=false
      msgCreate(0,0,"Claire","Yes? ... JEREMY! How did we do that?!",0,3,oMessageCutscene,1)
    else if sceneProgress=6 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","Frustration? I don't know. You two seemed to know what you were doing though.",0,3,oMessageCutscene,1)
    else if sceneProgress=7 and bWaitForInput=false
      msgCreate(0,0,"Chao","It was pretty cool!",0,3,oMessageCutscene,1)
    else if sceneProgress=8 and bWaitForInput=false
      msgCreate(0,0,"Claire","Yeah, I guess it was!",0,3,oMessageCutscene,1)
    else if sceneProgress=9 and bWaitForInput=false
      msgCreate(0,0,"Chao","See? You two work great as a team.",0,3,oMessageCutscene,1)
    else if sceneProgress=10 and bWaitForInput=false
      msgCreate(0,0,"Jerry","Merely a moment of desperation is all.",0,3,oMessageCutscene,1)
    else if sceneProgress=11 and bWaitForInput=false
      msgCreate(0,0,"Claire","Yeah, that's all it was.",0,3,oMessageCutscene,1)
    else if sceneProgress=12 and bWaitForInput=false
      msgCreate(0,0,"Chao","Suuure.",0,3,oMessageCutscene,1)
    else if sceneProgress=13 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","So it seems I simply lost the signal that X was giving off, he's on this side of the temple and very close.",0,3,oMessageCutscene,1)
    else if sceneProgress=14 and bWaitForInput=false
      msgCreate(0,0,"Jerry","I assume right through that door.",0,3,oMessageCutscene,1)
    else if sceneProgress=15 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","I would assume the same.",0,3,oMessageCutscene,1)
    else if sceneProgress=16
    {
      var tFullHeartDrop;
      tFullHeartDrop=instance_create(288,96,oHealthPickup)
      tFullHeartDrop.sprite_index=sFullHealthPickup
      var tempMplay;
      tempMplay=findMusic(8)
      playMusic(tempMplay,0,0)

      var newExit;
      newExit=instance_create(40,256,oExit)
      newExit.bShowArrow=true; newExit.exitType=0
      newExit.newMapX=80; newExit.newMapY=240; newExit.toRoom=rMountTemple_H

      newExit=instance_create(520,256,oExit)
      newExit.bShowArrow=true; newExit.exitType=0
      newExit.newMapX=80; newExit.newMapY=288; newExit.toRoom=rMountTemple_J

      global.gamePaused=false
      global.currentBoss=""
      global.bossTrack=0
      global.gameProgress=1690
    }
  }
}
else if global.gameProgress=1690 and room=rMountTemple_J //----- [9] Get Access Code, X mentions Sigma -----
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
    if sceneDelay>=20 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"Jerry","How did you get in here, X?",0,3,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"X","Sometimes Jerry, I worry that the world hangs on your shoulders.",6,3,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Claire","Even I got that.",0,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Yeah yeah, I was still hyped up about what we pulled off back there.",0,3,oMessageCutscene,1)
  else if sceneProgress=6 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Anyway, that device there is the access code we're looking for.",0,3,oMessageCutscene,1)
  else if sceneProgress=7
  {
    sceneDelay+=1
    if sceneDelay=15 {npcMMX.image_xscale=-1}
    else if sceneDelay>=30 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=8 and bWaitForInput=false
    msgCreate(0,0,"X","Yes, and I need you to use it on a specific Gate. Something important has come up.",6,3,oMessageCutscene,1)
  else if sceneProgress=9 and bWaitForInput=false
    msgCreate(0,0,"Jerry","What's going on?",0,3,oMessageCutscene,1)
  else if sceneProgress=10 and bWaitForInput=false
    msgCreate(0,0,"X","It's Sigma, he escaped from the Vault. It can't be put off, we need to stop him now!",6,3,oMessageCutscene,1)
  else if sceneProgress=11 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Sigma? From your series?",0,3,oMessageCutscene,1)
  else if sceneProgress=12 and bWaitForInput=false
    msgCreate(0,0,"X","Yes, and we can't allow him to roam free through the world. His corruption spreads to other bots fast. He's an incredibly high threat to the system. We're lucky the Virus has these kinds of things locked down.",6,3,oMessageCutscene,1)
  else if sceneProgress=13 and bWaitForInput=false
    msgCreate(0,0,"Jerry","If these entities are so dangerous, why did the program create them, just to stick them in the Vault?",0,3,oMessageCutscene,1)
  else if sceneProgress=14 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Jerry, we've gone over this. The Darkness had no choice, it was simply following instructions.",0,3,oMessageCutscene,1)
  else if sceneProgress=15 and bWaitForInput=false
    msgCreate(0,0,"Jerry","But how does it determine what would go into the Vault? Remember for some of the characters, it could be ambiguous whether or not it would be a danger to others in the system.",0,3,oMessageCutscene,1)
  else if sceneProgress=16 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Take Cynder from the Spyro series for example. In one game, she was a villain, and in the next... well you saw what happened.",0,3,oMessageCutscene,1)
  else if sceneProgress=17 and bWaitForInput=false
    msgCreate(0,0,"X","It's not whether they were a threat in one world or not. The program reads their overall behavior and from that determined where to put them. Sigma was classified as a high level threat, and for good reason.",6,3,oMessageCutscene,1)
  else if sceneProgress=18 and bWaitForInput=false
    msgCreate(0,0,"Chao","Hey, could Sigma be the one behind The Virus? Isn't Sigma himself just a virus?",0,3,oMessageCutscene,1)
  else if sceneProgress=19 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","... No, it couldn't be him. The Sigma virus corrupted its hosts, it didn't try to shut them down like this Virus is doing.",0,3,oMessageCutscene,1)
  else if sceneProgress=20 and bWaitForInput=false
    msgCreate(0,0,"Chao","True, but this Virus has shown behaviors similar to what Sigma could do. I'm not saying that Sigma is the Virus, just that he could be responsible.",0,3,oMessageCutscene,1)
  else if sceneProgress=21 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Okay, that makes some sense, but... ugh, this is frustrating.",0,3,oMessageCutscene,1)
  else if sceneProgress=22 and bWaitForInput=false
    msgCreate(0,0,"Chao","Hey, didn't you make a really sophisticated virus a few years ago that brought down those corporate servers?",0,3,oMessageCutscene,1)
  else if sceneProgress=23 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","I uh... yeah, I hacked in to steal something, then inserted the virus to help cover my tracks and send red herrings about where I was... and it did have the side effects of bringing their whole system down.",0,3,oMessageCutscene,1)
  else if sceneProgress=24 and bWaitForInput=false
    msgCreate(0,0,"Chao","Think you could use that knowledge for this Virus here?",0,3,oMessageCutscene,1)
  else if sceneProgress=25 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","It is useful knowing how these things work, but the Virus here has a lot more going on and seems to adapt. It goes beyond things that I've made.",0,3,oMessageCutscene,1)
  else if sceneProgress=26 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Well in any case, we still need to find him. Where is Sigma?",0,3,oMessageCutscene,1)
  else if sceneProgress=27 and bWaitForInput=false
    msgCreate(0,0,"X","He's in a Gate. I don't know where you were planning to use that access code, but I need you to use it on the Gate that Sigma went into. If it's like the other Gates, there should be one of those Program Chips in there as well.",6,3,oMessageCutscene,1)
  else if sceneProgress=28 and bWaitForInput=false
    msgCreate(0,0,"Jerry","I'm going to get locked out of my other ability sets aren't I?",0,3,oMessageCutscene,1)
  else if sceneProgress=29 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Probably.",0,3,oMessageCutscene,1)
  else if sceneProgress=30 and bWaitForInput=false
    msgCreate(0,0,"X","Even if you do, when you get inside, I'll give you access to my abilities. It'll be limited, but should be enough.",6,3,oMessageCutscene,1)
  else if sceneProgress=31 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Really? That's awesome!",0,3,oMessageCutscene,1)
  else if sceneProgress=32 and bWaitForInput=false
    msgCreate(0,0,"X","Sigma is my enemy, I'll help you as much as I can.",6,3,oMessageCutscene,1)
  else if sceneProgress=33 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Oh man! Working alongside you again is an honor and is SO awesome!",0,3,oMessageCutscene,1)
  else if sceneProgress=34 and bWaitForInput=false
    msgCreate(0,0,"X","...",6,3,oMessageCutscene,1)
  else if sceneProgress=35
  {
    sceneDelay+=1
    if sceneDelay=5
    {
      playSound(global.snd_MMBeamUp,0,1,1)
      npcMMX.sprite_index=sPlayerDiscombobulate
      npcMMX.image_index=0; npcMMX.image_speed=0
    }
    else if sceneDelay>=6 and sceneDelay<=35 {npcMMX.y-=14}
    else if sceneDelay>=40 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=36 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","X sent me the location of the Gate he wants us to go to. It's technically west from here, but you'll need to loop around back to the beach to get there. This code should work on a door in that area.",0,3,oMessageCutscene,1)
  else if sceneProgress=37
  {
    var tDir;
    tDir=0
    for(i=0;i<12;i+=1)
    {
      var tFFScl;
      tFFScl=random(0.1)
      tEffect=instance_create(288,256,oEffectB)
      tEffect.type=3; tEffect.sprite_index=sEfFirefly; tEffect.newBlend=1
      tEffect.image_alpha=0.5; tEffect.image_xscale=0.2+tFFScl; tEffect.image_yscale=0.2+tFFScl
      tEffect.direction=tDir; tEffect.speed=random(0.25)+0.75
      tEffect.fadeSpd=0.01; tEffect.image_blend=c_teal
      tEffect.AccelX=0; tEffect.AccelY=0; tEffect.followID=-1; tEffect.rotation=0
      tDir+=360/12
    }
    sceneDelay=0; sceneProgress=0
    with oMisc {instance_destroy()}
    global.gameProgress=1700
    global.gamePaused=false
  }
}
else if global.gameProgress=1700 and room=rMain_21 //----- [10] New places to go -----
{
  if sceneProgress=0
  {
    sceneDelay+=1
    if sceneDelay=1 {global.gamePaused=true}
    else if sceneDelay>=20 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=1 and bWaitForInput=false
    msgCreate(0,0,"Jerry","That was lovely.",0,3,oMessageCutscene,1)
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"Claire","Why thank you.",0,3,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Jerry","...",0,3,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Claire","...",0,3,oMessageCutscene,1)
  else if sceneProgress=5
  {
    sceneDelay=0; sceneProgress=0
    global.gameProgress=1710
    global.gamePaused=false
  }
}
else if global.gameProgress=1710 and room=rMain_27 //----- [] Decoding west door -----
{
  if global.gamePaused=false
  {
    if sceneProgress=0
    {
      if oPlayer1.x<=256 and oPlayer1.y>=672
      {
        enemyBarrier=instance_create(448,704,oEnemyBarrier); enemyBarrier.image_yscale=4
        msgCreate(0,0,"Jeremy","I'm starting the decoding process now.#Give me a bit of time on the door.",0,2,oMessagePerson,0)
        newMessage.fadingTime=100
        sceneDelay=0; sceneProgress+=1
      }
    }
    else if sceneProgress=1
    {
      sceneDelay+=1
      if sceneDelay>=80
      {
        delaySpawn(96,704,oWB_BigBat,0,1,1,0.33)
        delaySpawn(448,704,oWB_BigBat,0,1,1,0.33)
        delaySpawn(448,896,oWB_BigBat,0,1,1,0.33)
        sceneDelay=0; sceneProgress+=1
      }
    }
    else if sceneProgress=2
    {
      sceneDelay+=1
      if sceneDelay>=25
      {
        progressBar+=1
        if progressBar=300
        {
          delaySpawn(96,752,oWB_BigBat,0,1,1,0.33)
          delaySpawn(448,752,oWB_BigBat,0,1,1,0.33)
        }
        else if progressBar>=600
        {
          sceneDelay=0; sceneProgress=0
          progressBar=0

          with oEnemyBarrier {instance_destroy()}
          for(i=0;i<8;i+=1)
          {
            var tEffect,tFFScl;
            tFFScl=random(0.2)
            tEffect=instance_create(oEventBarrier.x+random(16),oEventBarrier.y+random(64),oEffect)
            tEffect.sprite_index=sRobotExplosion; tEffect.image_speed=0.3+random(0.3)
            tEffect.image_xscale=0.8; tEffect.image_yscale=0.8
            tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
          }
          global.gameProgress=1720
        }
      }
    }
  }
}
else if global.gameProgress=1720 and room=rMain_28 //----- [11] Virus & Twin Wasp Bots -----
{
  if global.bossTrack=0
  {
    if sceneProgress=0
    {
      if oPlayer1.x<=1408 and oPlayer1.y<=304
      {
        oPlayer1.y+=4
        if oPlayer1.y>=288
        {
          scenePChk(1408,288,0,0.1,-1)
          stopPlayer()
          global.gamePaused=true
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
      msgCreate(0,0,"X","I tried getting to the Gate, but it seems Sigma doesn't want anyone getting in there.",6,3,oMessageCutscene,1)
    else if sceneProgress=3 and bWaitForInput=false
      msgCreate(0,0,"Jerry","Got us blocked out?",0,3,oMessageCutscene,1)
    else if sceneProgress=4 and bWaitForInput=false
      msgCreate(0,0,"X","Yes, you can't get close without getting blasted. I tried, and now I can't move.",6,3,oMessageCutscene,1)
    else if sceneProgress=5 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","For plot convenience of course.",0,3,oMessageCutscene,1)
    else if sceneProgress=6 and bWaitForInput=false
      msgCreate(0,0,"X","It's a good thing you showed up, there's a Virus on the way.",6,3,oMessageCutscene,1)
    else if sceneProgress=7 and bWaitForInput=false
      msgCreate(0,0,"Jerry","What do you mean?",0,3,oMessageCutscene,1)
    else if sceneProgress=8 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","It's going to infect him.",0,3,oMessageCutscene,1)
    else if sceneProgress=9 and bWaitForInput=false
      msgCreate(0,0,"Jerry","Really? What do we need to do to get you moving again?",0,3,oMessageCutscene,1)
    else if sceneProgress=10 and bWaitForInput=false
      msgCreate(0,0,"X","Before I was shot down, I managed to set up a bomb on the defenses Sigma has on the Gate. I just need you to destroy the Virus that was sent here before it can reach me.",6,3,oMessageCutscene,1)
    else if sceneProgress=11 and bWaitForInput=false
      msgCreate(0,0,"Jerry","We won't let it reach you.",0,3,oMessageCutscene,1)
    else if sceneProgress=12
    {
      var newEnemy,newBarrier;
      newEnemy=instance_create(432,192,oWaspBot) newEnemy.bActive=1; newEnemy.yDist=128
      newEnemy=instance_create(2288,656,oWaspBot) newEnemy.bActive=1; newEnemy.yDist=-128
      instance_create(2288,656,oMalevolentVirus)
      newBarrier=instance_create(2432,704,oBossBarrier)
      with (213291) {instance_destroy()}
      var tempMplay;
      tempMplay=findMusic(809)
      playMusic(tempMplay,0,0)
      global.bossTrack=101
      storeStatus(0)
      sceneDelay=0; sceneProgress=0
      global.gamePaused=false
    }
  }
  else if global.bossTrack=101
  {
    if sceneProgress=0
    {
      if !instance_exists(oMalevolentVirus)
      {
        if !instance_exists(oWaspBot)
        {
          var tCheckAchieve;
          tCheckAchieve=string_char_at(global.tokenRecognitions,8)
          if tCheckAchieve="0"
          {
            var tAchievement;
            tAchievement=instance_create(0,0,oAchievementNotice)
            tAchievement.myAchievement="Beehind You"; tAchievement.checkNum=8
          }
        }
        global.gamePaused=true
        stopAllMusic()
        sceneProgress+=1
      }
    }
    else if sceneProgress=1
    {
      if fadeAlpha<1 {fadeAlpha+=0.05}
      else if fadeAlpha>=1 {sceneProgress+=1}
    }
    else if sceneProgress=2
    {
      sceneDelay+=1
      if sceneDelay=1
      {
        npcMMX.sprite_index=sMegamanXIdle
        endBoss()
        scenePChk(1408,288,0,0.1,-1)
      }
      if sceneDelay>=60 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=3
    {
      if fadeAlpha>0 {fadeAlpha-=0.05}
      else if fadeAlpha<=0 {sceneProgress+=1}
    }
    else if sceneProgress=4
    {
      sceneDelay+=1
      if sceneDelay>=25 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=5 and bWaitForInput=false
      msgCreate(0,0,"X","I'll go on ahead.",6,3,oMessageCutscene,1)
    else if sceneProgress=6
    {
      sceneDelay+=1
      if sceneDelay=5
      {
        npcMMX.sprite_index=sPlayerDiscombobulate
        npcMMX.image_index=0; npcMMX.image_speed=0
      }
      else if sceneDelay>=6 and sceneDelay<=35 {npcMMX.y-=14}
      else if sceneDelay>=40
      {
        with npcMMX {instance_destroy()}
        sceneDelay=0; sceneProgress+=1
      }
    }
    else if sceneProgress=7 and bWaitForInput=false
      msgCreate(0,0,"Jerry","The Virus is getting more aggressive now.",0,3,oMessageCutscene,1)
    else if sceneProgress=8 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","It's aware of what we're doing, so we'll need to be more careful now.",0,3,oMessageCutscene,1)
    else if sceneProgress=9
    {
      var tempMplay;
      tempMplay=findMusic(7)
      playMusic(tempMplay,0,0)
      with oEnemyBarrier {instance_destroy()}
      with oBossBarrier {instance_destroy()}

      global.gamePaused=false
      global.currentBoss=""
      global.bossTrack=0
      global.gameProgress=1730
    }
  }
}
else if global.gameProgress=1750 and room=rMain_28Gate //----- [Unskippable] Access Gate 4 -----
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
    global.newMapX=192
    global.newMapY=304
    writeToPlayerGlobals()
    stopAllMusic()
    transition_steps=1
    transition_kind=0
    room_goto(rMega4_Gate)
  }
}

keyWaitForInput()

if oKeyCodes.kCodePressed[11]=1 and global.gamePaused=true and sceneProgress>=1 //Cutscene skip
{
  if !instance_exists(oPauseMenu)
  {
    if global.gameProgress=1530 and room=rCCity_NA_S2 //[1]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      fadeAlpha=0
      sceneDelay=0
      sceneProgress=24
    }
    else if global.gameProgress=1550 and room=rMain_20 //[2]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      fadeAlpha=0
      sceneDelay=0
      sceneProgress=11
    }
    else if global.gameProgress=1580 and room=rMain_22 //[3]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      fadeAlpha=0
      sceneDelay=0
      sceneProgress=10
    }
    else if global.gameProgress=1590 and room=rMountTemple_A //[4]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      fadeAlpha=0
      sceneDelay=0
      sceneProgress=6
    }
    else if global.gameProgress=1610 and room=rMountTemple_C //[5]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      fadeAlpha=0
      sceneDelay=0
      sceneProgress=4
    }
    else if global.gameProgress=1640 and room=rMountTemple_D //[6]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      fadeAlpha=0
      sceneDelay=0
      sceneProgress=5
    }
    else if global.gameProgress=1650 and room=rMountTemple_G //[7]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      fadeAlpha=0
      sceneDelay=0
      sceneProgress=7
    }
    else if global.gameProgress=1680 and room=rMountTemple_I //[8]
    {
      if global.bossTrack=2 and sceneProgress>=2
      {
        fadeAlpha=0
        bWaitForInput=false
        with oMessageCutscene {instance_destroy()}
        sceneDelay=0
        sceneProgress=16
      }
    }
    else if global.gameProgress=1690 and room=rMountTemple_G //[9]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      fadeAlpha=0
      sceneDelay=0
      sceneProgress=37
    }
    else if global.gameProgress=1700 and room=rMain_21 //[10]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      fadeAlpha=0
      sceneDelay=0
      sceneProgress=5
    }
    else if global.gameProgress=1720 and room=rMain_28 //[11]
    {
      if global.bossTrack=0
      {
        bWaitForInput=false
        with oMessageCutscene {instance_destroy()}
        fadeAlpha=0
        sceneDelay=0
        sceneProgress=12
      }
      else if global.bossTrack=101
      {
        bWaitForInput=false
        with oMessageCutscene {instance_destroy()}
        fadeAlpha=0
        sceneDelay=0
        sceneProgress=9
      }
    }
  }
}

if room=rMain_20
{
  if achievementCoins=0
  {
    if !instance_exists(oMarioCoin_Achieve)
    {
      var tCheckAchieve;
      tCheckAchieve=string_char_at(global.tokenRecognitions,15)
      if tCheckAchieve="0"
      {
        var tAchievement;
        tAchievement=instance_create(0,0,oAchievementNotice)
        tAchievement.myAchievement="Coin Islander"; tAchievement.checkNum=15
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

if room=rMain_21
{
  draw_set_alpha(skyBeamAlpha)
  draw_set_color(c_red)
  draw_rectangle(skyBeamX-skyBeamWidth,0,skyBeamX+skyBeamWidth,288,0)
}

if progressBar>=1 //When Jeremy decodes the east gate on map(rMain_27)
{
  var tPBar;
  tPBar=(progressBar/600)*200
  draw_set_font(fnt_Swap)
  draw_set_halign(fa_left)
  draw_set_alpha(1)
  textDropShadow("DECODING PROGRESS",view_xview[0]+16,view_yview[0]+327,c_green,c_black,1)
  draw_set_color(c_gray)
  draw_rectangle(view_xview[0]+16,view_yview[0]+342,view_xview[0]+216,view_yview[0]+350,0)
  draw_set_color(c_green)
  draw_rectangle(view_xview[0]+16,view_yview[0]+342,view_xview[0]+16+tPBar,view_yview[0]+350,0)
  draw_set_color(c_black)
  draw_rectangle(view_xview[0]+16,view_yview[0]+342,view_xview[0]+216,view_yview[0]+350,1)
}
