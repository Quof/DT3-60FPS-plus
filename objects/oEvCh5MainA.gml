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

if global.gameProgress=910 and room=rCCity_CCA
{
  var enemyCounter;
  enemyCounter=instance_create(0,0,oEnemyRemain)
  enemyCounter.enemyCount=5

  createEnemy(240,192,oBombDropper,2,1,1)
  createEnemy(464,192,oBombDropper,2,1,1)
  createEnemy(432,304,oEggBot,2,1,1)
  createEnemy(496,304,oSprongySpring,2,1,1)
  createEnemy(352,48,oEggBot,2,1,1)
}
else if global.gameProgress=1000
{
  fadeColor=c_black
  fadeAlpha=1
  oNPC_Syrus.image_xscale=-1
}
else if global.gameProgress=1070
{
  fadeColor=c_black
  fadeAlpha=1
}

if room=rMain_11 or room=rMain_12 or room=rMain_13 or room=rMain_14
{
  followBack=1
  background_x[0]=view_xview[0]*0.6
  background_y[0]=view_yview[0]*0.5
  background_x[1]=view_xview[0]*0.3
  background_y[1]=room_height-198
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gameProgress=910 and room=rCCity_CCA //----- [1] Enemy clear -----
{
  if sceneProgress=0
  {
    if oEnemyRemain.enemyCount<=0
    {
      global.gamePaused=true
      with oEnemyRemain {instance_destroy()}
      with oAttackBase {instance_destroy()}
      scenePChk(oPlayer1.x,oPlayer1.y,0,0.1,1)
      sceneProgress+=1
    }
  }
  else if sceneProgress=1
  {
    sceneDelay+=1
    if sceneDelay>=25 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Now you can get in.",0,3,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Sweet, time to get the city back.",0,3,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Claire","I wish I could help.",0,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Jerry","All in due time.",0,3,oMessageCutscene,1)
  else if sceneProgress=6
  {
    sceneDelay=0; sceneProgress=0
    global.gameProgress=920
    global.gamePaused=false
  }
}
else if global.gameProgress=920 and room=rCCity_CCA //----- [] Path to Control Center - Ch.5 -----
{
  if sceneProgress=0
  {
    if oPlayer1.x>=560
    {
      var tempMplay;
      tempMplay=findMusic(3)
      playMusic(tempMplay,0,0)
      var tNewChapter;
      tNewChapter=instance_create(0,0,oChapterDisplay)
      tNewChapter.newChapter="Chapter 5#Reclaiming What's Lost"
      global.gameProgress=930
    }
  }
}
else if global.gameProgress=940 and room=rCCity_CCB //----- [2] To the control center -----
{
  if sceneProgress=0
  {
    sceneDelay+=1
    if sceneDelay=1
      global.gamePaused=true
    else if sceneDelay>=20 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=1 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","The control center is further up this place.",0,3,oMessageCutscene,1)
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Any major obstacles that you guys can see?",0,3,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Nope, looks like a straight shot. This should be pretty easy.",0,3,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Is it ever though?",0,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Oh you're right, what was I thinking?",0,3,oMessageCutscene,1)
  else if sceneProgress=6
  {
    sceneDelay=0; sceneProgress=0
    global.gameProgress=950
    global.gamePaused=false
  }
}
else if global.gameProgress=980 and room=rCCity_CCE //----- [3] Boss Fight: Control Virus -----
{
  if global.bossTrack=0
  {
    if sceneProgress=0 and oPlayer1.x>=224
    {
      global.gamePaused=true
      oPlayer1.y+=4
      if oPlayer1.y>=288
      {
        oPlayer1.y=288
        oPlayer1.sprite_index=sJerryIdle
        stopPlayer()
        sceneProgress+=1
      }
    }
    else if sceneProgress=1
    {
      sceneDelay+=1
      if sceneDelay>=20 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=2 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","This is the control center. From here, I can get the defenses back on... or I would be able to, but there's a lock on it.",0,3,oMessageCutscene,1)
    else if sceneProgress=3 and bWaitForInput=false
      msgCreate(0,0,"Jerry","What's locking it?",0,3,oMessageCutscene,1)
    else if sceneProgress=4 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","The machine beyond the conveyor there. It's all virus controlled. If you can get rid of it, I can get into the system no problem from here.",0,3,oMessageCutscene,1)
    else if sceneProgress=5 and bWaitForInput=false
      msgCreate(0,0,"Jerry","Gotcha.",0,3,oMessageCutscene,1)
    else if sceneProgress=6
    {
      sceneDelay+=1
      if sceneDelay=20 {oCh5CC_CompScr.sequence=1}
      else if sceneDelay>=40 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=7 and bWaitForInput=false
      msgCreate(0,0,"Claire","What's that?",0,3,oMessageCutscene,1)
    else if sceneProgress=8 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","Ah damn, Jerry, you're gonna need to be quick about this. Once that timer reaches zero, it's going to completely lock down the system. If that happens, it's all over.",0,3,oMessageCutscene,1)
    else if sceneProgress=9 and bWaitForInput=false
      msgCreate(0,0,"Jerry","What are the chances that the count down happens the moment we drop in?",0,3,oMessageCutscene,1)
    else if sceneProgress=10
    {
      global.gamePaused=false
      viewFix=instance_create(336,176,oMisc)
      viewFix.type=0
      viewFix.sprite_index=sNull
      view_object[0]=viewFix
      var bossBarr;
      bossBarr=instance_create(112,144,oBossBarrier)
      bossBarr.image_yscale=2.25
      var tBossTitle,tempMplay;
      tBossTitle=instance_create(0,0,oBossNameDisplay)
      tBossTitle.bossName="Control Virus"
      tBossTitle.bossTitle="System Locker"
      tempMplay=findMusic(813)
      playMusic(tempMplay,0,0)
      boss=instance_create(528,272,oControlVirus)
      boss.activateBoss=1
      global.currentBoss="Control Virus"
      global.bossTrack=1
      storeStatus(0)
      sceneDelay=0; sceneProgress=0
    }
  }
  else if global.bossTrack=1
  {
    if !instance_exists(oControlVirus) and sceneProgress=0 //End Boss
    {
      global.gamePaused=true
      view_object[0]=oPlayer1
      awardBossAP(900)
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
        with oSolidVirusBlock {instance_destroy()}
        endBoss()
        scenePChk(224,288,0,0.1,1)
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
      msgCreate(0,0,"Jerry","And that's how I roll.",0,3,oMessageCutscene,1)
    else if sceneProgress=5 and bWaitForInput=false
      msgCreate(0,0,"Claire","I could have done that faster.",0,3,oMessageCutscene,1)
    else if sceneProgress=6 and bWaitForInput=false
      msgCreate(0,0,"Jerry","We could have it out right here Claire.",0,3,oMessageCutscene,1)
    else if sceneProgress=7 and bWaitForInput=false
      msgCreate(0,0,"Claire","You don't stand a chance Jerry.",0,3,oMessageCutscene,1)
    else if sceneProgress=8 and bWaitForInput=false
      msgCreate(0,0,"Chao","Technically Claire, you don't.",0,3,oMessageCutscene,1)
    else if sceneProgress=9 and bWaitForInput=false
      msgCreate(0,0,"Claire","Who's side are you on?!",0,3,oMessageCutscene,1)
    else if sceneProgress=10 and bWaitForInput=false
      msgCreate(0,0,"Jerry","I always beat you in Smash Bros.",0,3,oMessageCutscene,1)
    else if sceneProgress=11 and bWaitForInput=false
      msgCreate(0,0,"Claire","Not in Brawl.",0,3,oMessageCutscene,1)
    else if sceneProgress=12 and bWaitForInput=false
      msgCreate(0,0,"Jerry","Melee is where it's at Claire, everyone knows that. Brawl is easily forgotten!",0,3,oMessageCutscene,1)
    else if sceneProgress=13 and bWaitForInput=false
      msgCreate(0,0,"Claire","I remember how excited you were to play that game.",0,3,oMessageCutscene,1)
    else if sceneProgress=14 and bWaitForInput=false
      msgCreate(0,0,"Jerry","Because I thought it wouldn't suck!",0,3,oMessageCutscene,1)
    else if sceneProgress=15 and bWaitForInput=false
      msgCreate(0,0,"Claire","It didn't suck, it just wasn't what you wanted it to be.",0,3,oMessageCutscene,1)
    else if sceneProgress=16 and bWaitForInput=false
      msgCreate(0,0,"Jerry","Well... ... ... your face!",0,3,oMessageCutscene,1)
    else if sceneProgress=17 and bWaitForInput=false
      msgCreate(0,0,"Claire","Really Jerry? That's all you've got?",0,3,oMessageCutscene,1)
    else if sceneProgress=18 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","While you two were doing your usual routine, I got the city defenses back online and working.",0,3,oMessageCutscene,1)
    else if sceneProgress=19 and bWaitForInput=false
      msgCreate(0,0,"Jerry","That was kind of anti-climatic, Jeremy.",0,3,oMessageCutscene,1)
    else if sceneProgress=20 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","I was just trying to get things done, so let's get back up to Syrus and Gene. I have no leads on where any other Program Chips are.",0,3,oMessageCutscene,1)
    else if sceneProgress=21 and bWaitForInput=false
      msgCreate(0,0,"Jerry","Definitely a good idea.",0,3,oMessageCutscene,1)
    else if sceneProgress=22 and bWaitForInput=false
      msgCreate(0,0,"Claire","One more point for me.",0,3,oMessageCutscene,1)
    else if sceneProgress=23 and bWaitForInput=false
      msgCreate(0,0,"Jerry","Ahem, it's a good idea for us to leave now.",0,3,oMessageCutscene,1)
    else if sceneProgress=24
    {
      var tFullHeartDrop;
      tFullHeartDrop=instance_create(288,160,oHealthPickup)
      tFullHeartDrop.sprite_index=sFullHealthPickup
      var tempMplay;
      tempMplay=findMusic(3)
      playMusic(tempMplay,0,0)
      var newExit;
      newExit=instance_create(352,288,oExit)
      newExit.sprite_index=sWarpGateStand; newExit.bShowArrow=false; newExit.exitType=0
      newExit.newMapX=352; newExit.newMapY=304; newExit.toRoom=rCCity_CCA
      global.gamePaused=false
      global.currentBoss=""
      global.bossTrack=0
      global.gameProgress=990
    }
  }
}
else if global.gameProgress=1000 and room=rCCity_NA_S2 //----- [4] Back to Syrus & Gene -----
{
  if sceneProgress=0
  {
    sceneDelay+=1
    if sceneDelay=1
    {
      global.gamePaused=true
      scenePChk(240,288,0,0.1,1)
    }
    else if sceneDelay>=30
    {
      fadeAlpha-=0.02
      if fadeAlpha<=0 {sceneDelay=0; sceneProgress+=1}
    }
  }
  else if sceneProgress=1 and bWaitForInput=false
    msgCreate(0,0,"Syrus","You continue to impress, Jerry.",6,3,oMessageCutscene,1)
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"Jerry","What can I say, I'm in my element here.",0,3,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Claire","I won't say a word.",0,3,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Oh please Claire, you know I love your cute little pokes at me.",0,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Claire","Ugh, really Jerry? I think you're trying too hard.",0,3,oMessageCutscene,1)
  else if sceneProgress=6 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Oh I'm not flirting, I'm simply making your bad attempts at insulting me a lot harder.",0,3,oMessageCutscene,1)
  else if sceneProgress=7 and bWaitForInput=false
    msgCreate(0,0,"Claire","That doesn't even make any sense with what you just said!",0,3,oMessageCutscene,1)
  else if sceneProgress=8 and bWaitForInput=false
    msgCreate(0,0,"Syrus","Sooo... Jeremy, did you have any plans on what to do next?",6,3,oMessageCutscene,1)
  else if sceneProgress=9 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","There's another Gate I've detected to the east, but that area is locked up.",0,3,oMessageCutscene,1)
  else if sceneProgress=10 and bWaitForInput=false
    msgCreate(0,0,"Syrus","There should be someone on the west side of the city that can decode that lock.",6,3,oMessageCutscene,1)
  else if sceneProgress=11 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Whoa, hold up! Are you seriously sending us on an NPC hunt?",0,3,oMessageCutscene,1)
  else if sceneProgress=12 and bWaitForInput=false
    msgCreate(0,0,"Syrus","Yeah yeah. Just do it. Plus it will help to acquaint yourself with the city as I have a feeling you're going to be coming back here a lot.",6,3,oMessageCutscene,1)
  else if sceneProgress=13 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Gamer's intuition?",0,3,oMessageCutscene,1)
  else if sceneProgress=14 and bWaitForInput=false
    msgCreate(0,0,"Syrus","Gamer's intuition!",6,3,oMessageCutscene,1)
  else if sceneProgress=15 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Nice!",0,3,oMessageCutscene,1)
  else if sceneProgress=16
  {
    var tCheckAchieve;
    tCheckAchieve=string_char_at(global.tokenRecognitions,14)
    if tCheckAchieve="0"
    {
      var tAchievement;
      tAchievement=instance_create(0,0,oAchievementNotice)
      tAchievement.myAchievement="Gamer's Intuition"; tAchievement.checkNum=14
    }
    sceneDelay=0; sceneProgress=0
    global.gameProgress=1010
    global.gamePaused=false
  }
}
else if global.gameProgress=1020 and room=rCCity_NorthB //----- [5] Talk with Matt -----
{
  if sceneProgress=0
  {
    global.gamePaused=true
    fadeColor=c_black
    if fadeAlpha<1 {fadeAlpha+=0.05}
    else if fadeAlpha>=1 {sceneProgress+=1}
  }
  else if sceneProgress=1
  {
    sceneDelay+=1
    if sceneDelay>=25
    {
      (161270).image_xscale=1
      charSwitcher(0)
      scenePChk(640,288,0,0.1,-1)
      sceneDelay=0; sceneProgress+=1
    }
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
    msgCreate(0,0,"Matt","Jerry! Haven't seen you since that whole situation with The Darkness. How are you and Jeremy doing?",6,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Eh, well I suppose. Things have gotten worse as you can see.",0,3,oMessageCutscene,1)
  else if sceneProgress=6 and bWaitForInput=false
    msgCreate(0,0,"Matt","You guys went missing for awhile, but now that you're back, I'm sure you'll set things straight. That virus is a pain in the ass, but I'm sure it's nothing Jeremy can't handle. Hell, he wrote a few in his hacking days.",6,3,oMessageCutscene,1)
  else if sceneProgress=7 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Oh I remember.",0,3,oMessageCutscene,1)
  else if sceneProgress=8 and bWaitForInput=false
    msgCreate(0,0,"Matt","What brings you over here?",6,3,oMessageCutscene,1)
  else if sceneProgress=9 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Syrus said someone over here would have an access code for a gate to the east. I was wondering if you knew anything about that.",0,3,oMessageCutscene,1)
  else if sceneProgress=10 and bWaitForInput=false
    msgCreate(0,0,"Matt","Yeah, the guy in this house here has something like that. He's trapped himself in there though, trying to protect himself from the Virus attack and all that.",6,3,oMessageCutscene,1)
  else if sceneProgress=11 and bWaitForInput=false
    msgCreate(0,0,"Jerry","You don't suppose if I go in there and get him out, he'll give us the access code, do you?",0,3,oMessageCutscene,1)
  else if sceneProgress=12 and bWaitForInput=false
    msgCreate(0,0,"Matt","Like he has any use for it. He's holed up in there pretty good. Got some crazy contraptions protecting him.",6,3,oMessageCutscene,1)
  else if sceneProgress=13 and bWaitForInput=false
    msgCreate(0,0,"Jerry","We talking shoot to kill contraptions?",0,3,oMessageCutscene,1)
  else if sceneProgress=14 and bWaitForInput=false
    msgCreate(0,0,"Matt","Yes and no. I do know it would take two people to get through some of that mess.",6,3,oMessageCutscene,1)
  else if sceneProgress=15 and bWaitForInput=false
    msgCreate(0,0,"Jerry","No problem there, Claire is with me now.",0,3,oMessageCutscene,1)
  else if sceneProgress=16 and bWaitForInput=false
    msgCreate(0,0,"Matt","Lucky son of a...",6,3,oMessageCutscene,1)
  else if sceneProgress=17 and bWaitForInput=false
    msgCreate(0,0,"Claire","Yeah hi, I'm here too.",0,3,oMessageCutscene,1)
  else if sceneProgress=18 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Don't ask, some weird obstruction makes it hard for both of us to be present at once.",0,3,oMessageCutscene,1)
  else if sceneProgress=19 and bWaitForInput=false
    msgCreate(0,0,"Matt","That's gotta suck. I'll let you tell me about it later though. The guy is in here.",6,3,oMessageCutscene,1)
  else if sceneProgress=20
  {
    if fadeAlpha<1 {fadeAlpha+=0.05}
    else if fadeAlpha>=1 {sceneProgress+=1}
  }
  else if sceneProgress=21
  {
    sceneDelay+=1
    if sceneDelay>=25
    {
      var newExit;
      newExit=instance_create(584,256,oExit)
      newExit.bShowArrow=true; newExit.exitType=0
      newExit.newMapX=48; newExit.newMapY=512; newExit.toRoom=rCCity_NB_S1a;
      (161270).x-=48
      sceneDelay=0; sceneProgress+=1
    }
  }
  else if sceneProgress=22
  {
    if fadeAlpha>0 {fadeAlpha-=0.05}
    else if fadeAlpha<=0 {sceneProgress+=1}
  }
  else if sceneProgress=23
  {
    sceneDelay=0; sceneProgress=0
    global.gameProgress=1030
    global.gamePaused=false
  }
}
else if global.gameProgress=1040 and room=rCCity_NB_S1a //----- [6] Explain party split -----
{
  if sceneProgress=0
  {
    sceneDelay+=1
    if sceneDelay=1 {global.gamePaused=true}
    else if sceneDelay>=20 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=1 and bWaitForInput=false
    msgCreate(0,0,"Jerry","What's going on here?",0,3,oMessageCutscene,1)
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","I've detected that you're both needed for this. While it takes a bit of work on my end, I've managed to get you both active during this.",0,3,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Claire","We actually have to work together don't we?",0,3,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","As tough as that sounds, yes. Only one of you will technically be active, but when you swap, your control and perspective changes to the other.",0,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Any chance that we'll need to protect our idle partner?",0,3,oMessageCutscene,1)
  else if sceneProgress=6 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","No, your buddy will be shielded. Which, by the way, will stop nearly all enemy projectiles.",0,3,oMessageCutscene,1)
  else if sceneProgress=7 and bWaitForInput=false
    msgCreate(0,0,"Claire","I suppose since it's not going to be for that long, we can pull this off.",0,3,oMessageCutscene,1)
  else if sceneProgress=8 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Good, because as scary as this sounds, technically the fate of the world depends on you two getting along.",0,3,oMessageCutscene,1)
  else if sceneProgress=9
  {
    sceneDelay=0; sceneProgress=0
    global.gameProgress=1050
    global.gamePaused=false
  }
}
else if global.gameProgress=1070 and room=rCCity_NB_S1b //----- [7] Reunion with X -----
{
  if sceneProgress=0
  {
    sceneDelay+=1
    if sceneDelay=1
    {
      global.gamePaused=true
      oPlayer1.visible=0; oPlayer1.x=208; oPlayer1.y=256
      charJerry=instance_create(228,256,oMisc)
      charJerry.sprite_index=sJerryIdle; charJerry.image_speed=0.1; charJerry.type=2
      charClaire=instance_create(196,256,oMisc)
      charClaire.sprite_index=sClaireIdle; charClaire.image_speed=0.1; charClaire.type=2
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
    if sceneDelay>=25 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"X","I was expecting to see you again soon.",6,3,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Jerry","I figured we'd run into each other again too, just not... in a place like this. Dejavu much? Why are you hiding down here?",0,3,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"X","I'm not hiding. I've been scanning for what feels like forever, to find key locations the Virus has struck.",6,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Anything interesting?",0,3,oMessageCutscene,1)
  else if sceneProgress=6 and bWaitForInput=false
    msgCreate(0,0,"X","Oh yeah, it is everywhere, as you already know. Nearly every system in the program is infected. The world data is still fairly secure, but nearly everything else is lost.",6,3,oMessageCutscene,1)
  else if sceneProgress=7 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Yeah, all of our abilities were locked down. Jeremy has been leading us around to gain new ones.",0,3,oMessageCutscene,1)
  else if sceneProgress=8 and bWaitForInput=false
    msgCreate(0,0,"X","Our? ... Oh, the girl. Who is that? She looks familiar.",6,3,oMessageCutscene,1)
  else if sceneProgress=9 and bWaitForInput=false
    msgCreate(0,0,"Claire","Just a close friend.",0,3,oMessageCutscene,1)
  else if sceneProgress=10 and bWaitForInput=false
    msgCreate(0,0,"Jerry","My ex girlfriend.",0,3,oMessageCutscene,1)
  else if sceneProgress=11 and bWaitForInput=false
    msgCreate(0,0,"Claire","Yes, let's keep bringing that out like that!",0,3,oMessageCutscene,1)
  else if sceneProgress=12 and bWaitForInput=false
    msgCreate(0,0,"X","...",6,3,oMessageCutscene,1)
  else if sceneProgress=13 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","And moving on! X, we heard you had access codes for the sector east of the Greatest Stretch. If you do, we need them.",0,3,oMessageCutscene,1)
  else if sceneProgress=14 and bWaitForInput=false
    msgCreate(0,0,"X","Yes, I have them. Hold on, I will send them to you now, Jeremy.",6,3,oMessageCutscene,1)
  else if sceneProgress=15 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Awesome.",0,3,oMessageCutscene,1)
  else if sceneProgress=16 and bWaitForInput=false
    msgCreate(0,0,"X","I know it is an effort to stop the Virus, but I must warn you to be careful in the east sector. An access point to the Vault is out there. It starts scattering data when you get close.",6,3,oMessageCutscene,1)
  else if sceneProgress=17 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","There's really an access point to it that close?",0,3,oMessageCutscene,1)
  else if sceneProgress=18 and bWaitForInput=false
    msgCreate(0,0,"X","Yes. Syrus, Gene, and myself have been keeping watch of it carefully. The activity around it is strange.",6,3,oMessageCutscene,1)
  else if sceneProgress=19 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","That's what we've heard.",0,3,oMessageCutscene,1)
  else if sceneProgress=20 and bWaitForInput=false
    msgCreate(0,0,"X","The Darkness had a very good hold on that, it should not break.",6,3,oMessageCutscene,1)
  else if sceneProgress=21 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","We'd better hurry then. I've got the codes to unlock the Gate now.",0,3,oMessageCutscene,1)
  else if sceneProgress=22 and bWaitForInput=false
    msgCreate(0,0,"X","I will be here to continue my scans. By the time you get back from doing whatever it is you are doing, I should have found some useful data for you.",6,3,oMessageCutscene,1)
  else if sceneProgress=23
  {
    var tFlash;
    tFlash=instance_create(0,0,oScreenFlash); tFlash.fadeSpeed=0.2
    oPlayer1.visible=1
    if global.activeCharacter=0 oPlayer1.x=charJerry.x
    else if global.activeCharacter=1 oPlayer1.x=charClaire.x
    with oMisc {instance_destroy()}
    sceneDelay=0; sceneProgress=0
    global.gameProgress=1080
    global.gamePaused=false
  }
}
else if global.gameProgress=1090 and room=rMain_11 //----- [8] In the Magical Forest -----
{
  if sceneProgress=0
  {
    sceneDelay+=1
    if sceneDelay=1 {global.gamePaused=true}
    else if sceneDelay>=20 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=1 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Keep heading east from here. Oh, though you need to take the upper road. I'm seeing a severe interference from the lower route.",0,3,oMessageCutscene,1)
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"Claire","Hey, when do I get to play?",0,3,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Uh, play?",0,3,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Claire","You know what I mean!",0,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Oh right... probably soon... unfortunately.",0,3,oMessageCutscene,1)
  else if sceneProgress=6
  {
    sceneDelay=0; sceneProgress=0
    global.gameProgress=1100
    global.gamePaused=false
  }
}
else if global.gameProgress=1100 and room=rMain_11 //----- [] Decoding east door -----
{
  if global.gamePaused=false
  {
    if sceneProgress=0
    {
      if oPlayer1.x>=2672 and oPlayer1.y<=420
      {
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
        delaySpawn(2544,320,oMagicalBee,0,1,1,0.33)
        delaySpawn(2672,256,oMagicalBee,0,1,1,0.33)
        delaySpawn(2832,272,oMagicalBee,0,1,1,0.33)
        sceneDelay=0; sceneProgress+=1
      }
    }
    else if sceneProgress=2
    {
      sceneDelay+=1
      if sceneDelay>=25
      {
        progressBar+=1
        if progressBar>=400
        {
          sceneDelay=0
          sceneProgress=0
          progressBar=0

          for(i=0;i<8;i+=1)
          {
            var tEffect,tFFScl;
            tFFScl=random(0.2)
            tEffect=instance_create(oEventBarrier.x+random(16),oEventBarrier.y+random(64),oEffect)
            tEffect.sprite_index=sRobotExplosion
            tEffect.image_speed=0.3+random(0.3); tEffect.image_xscale=0.8; tEffect.image_yscale=0.8
            tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
          }
          global.gameProgress=1110
        }
      }
    }
  }
}
else if global.gameProgress=1120 and room=rMain_13 //----- [9] Gate is close by -----
{
  if sceneProgress=0
  {
    sceneDelay+=1
    if sceneDelay=1 {global.gamePaused=true}
    else if sceneDelay>=20 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=1 and bWaitForInput=false
    msgCreate(0,0,"Chao","The Access Gate is close by. Just a little more.",0,3,oMessageCutscene,1)
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"Claire","Hopefully there's something in the Gate that I can use.",0,3,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Then you'd be as awesome as me.",0,3,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Claire","As awesome, or more awesome?",0,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Slightly below?",0,3,oMessageCutscene,1)
  else if sceneProgress=6 and bWaitForInput=false
    msgCreate(0,0,"Claire","You wish.",0,3,oMessageCutscene,1)
  else if sceneProgress=7 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Pretty much.",0,3,oMessageCutscene,1)
  else if sceneProgress=8
  {
    sceneDelay=0; sceneProgress=0
    global.gameProgress=1130
    global.gamePaused=false
  }
}
else if global.gameProgress=1140 and room=rMain_14Gate //----- [Unskippable] Access Gate 3 -----
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
    global.newMapY=288
    writeToPlayerGlobals()
    stopAllMusic()
    transition_steps=1
    transition_kind=0
    room_goto(rBelmont3_Gate)
  }
}

keyWaitForInput()

if oKeyCodes.kCodePressed[11]=1 and global.gamePaused=true and sceneProgress>=1 //Cutscene skip
{
  if !instance_exists(oPauseMenu)
  {
    if global.gameProgress=910 and room=rCCity_CCA //[1]
    {
      if sceneProgress>=1
      {
        bWaitForInput=false
        with oMessageCutscene {instance_destroy()}
        fadeAlpha=0
        sceneDelay=0
        sceneProgress=6
      }
    }
    else if global.gameProgress=940 and room=rCCity_CCB //[2]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      fadeAlpha=0
      sceneDelay=0
      sceneProgress=6
    }
    else if global.gameProgress=980 and room=rCCity_CCE //[3]
    {
      if global.bossTrack=0
      {
        bWaitForInput=false
        with oMessageCutscene {instance_destroy()}
        sceneDelay=0
        sceneProgress=10
      }
      else if global.bossTrack=2 and sceneProgress>=2
      {
        fadeAlpha=0
        bWaitForInput=false
        with oMessageCutscene {instance_destroy()}
        sceneDelay=0
        sceneProgress=24
      }
    }
    else if global.gameProgress=1000 and room=rCCity_NA_S2 //[4]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      fadeAlpha=0
      sceneDelay=0
      sceneProgress=16
    }
    else if global.gameProgress=1020 and room=rCCity_NorthB //[5]
    {
      if sceneProgress<21
      {
        bWaitForInput=false
        with oMessageCutscene {instance_destroy()}
        sceneDelay=0
        sceneProgress=21
      }
    }
    else if global.gameProgress=1040 and room=rCCity_NB_S1a //[6]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      sceneDelay=0
      sceneProgress=9
    }
    else if global.gameProgress=1070 and room=rCCity_NB_S1b //[7]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      fadeAlpha=0
      sceneDelay=0
      sceneProgress=23
    }
    else if global.gameProgress=1090 and room=rMain_11 //[8]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      sceneDelay=0
      sceneProgress=6
    }
    else if global.gameProgress=1120 and room=rMain_13 //[9]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      sceneDelay=0
      sceneProgress=8
    }
  }
}

//-- Map stuff --
if followBack=1
{
  background_x[0]=view_xview[0]*0.6
  background_y[0]=view_yview[0]*0.5
  background_x[1]=view_xview[0]*0.3
  background_y[1]=room_height-198
}

if room=rLeafCaveB //Defeat all enemies
{
  if sceneProgress=0
  {
    if !instance_exists(oEnemyBase)
    {
      with oEnemyBarrier {instance_destroy()}
      sceneProgress=1
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

if progressBar>=1 //When Jeremy decodes the east gate on map(rMain_11)
{
  draw_set_font(fnt_Swap)
  draw_set_halign(fa_left)
  draw_set_alpha(1)
  textDropShadow("DECODING PROGRESS",view_xview[0]+16,view_yview[0]+327,c_green,c_black,1)
  draw_set_color(c_gray)
  draw_rectangle(view_xview[0]+16,view_yview[0]+342,view_xview[0]+216,view_yview[0]+350,0)
  draw_set_color(c_green)
  draw_rectangle(view_xview[0]+16,view_yview[0]+342,view_xview[0]+16+(progressBar/2),view_yview[0]+350,0)
  draw_set_color(c_black)
  draw_rectangle(view_xview[0]+16,view_yview[0]+342,view_xview[0]+216,view_yview[0]+350,1)
}
