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

if room=rMain_68
{
  indexCheck=string_char_at(global.weaponLevels,18)
  tankEvent=0
  if indexCheck="1" {tankEvent=2}
}
else if room=rMain_71
{
  if global.newMapX>256 {geyserProg=0}
  else {geyserProg=10}
  geyserTime=0
}
else if room=rLowFacI
{
  var tZapTrap;
  for(i=0;i<23;i+=1)
  {
    tZapTrap=instance_create(256+(90*i),80+(90*i),oZapTrapRed)
    tZapTrap.image_angle=315; tZapTrap.image_xscale=4
    tZapTrap=instance_create(192+(90*i),320+(90*i),oZapTrapRed)
    tZapTrap.image_angle=315; tZapTrap.image_xscale=4
  }
}
else if room=rLowFacK
{
  var tZapTrap;
  for(i=0;i<18;i+=1)
  {
    tZapTrap=instance_create(160+(128*i),392,oZapTrapRed)
    tZapTrap.image_xscale=4
  }
}
else if room=rLowFacO
{
  if global.gameProgress=4440 or global.gameProgress=4450 or global.gameProgress=4451
  {
    npcLovelun=instance_create(6336,288,oMisc)
    npcLovelun.type=0; npcLovelun.sprite_index=sLovelun_Idle
    npcLovelun.image_xscale=-1; npcLovelun.image_speed=0.1
    mapMsg=0
  }
}
else if global.gameProgress=4460 and room=rLowFacR
{
  blendCol=0
  bMusicFade=0
  musicFade=global.optMusic*100
}
else if global.gameProgress=4470 and room=rLowFacS
{
  bMusicFade=0
  musicFade=global.optMusic*100
  warshipProg=0
  backSoundLoop=0
  firePillarX=0
}
else if room=rLowFacCutA
{
  fadeColor=c_black
  fadeAlpha=1
  oPlayer1.visible=0
  musicFade=global.optMusic*100
  fadeAmt=10
  backSoundLoop=0
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gameProgress=4200 and room=rMain_61 //----- [1] Intro to Starry Skies -----
{
  if sceneProgress=0
  {
    sceneDelay+=1
    if sceneDelay=1 {global.gamePaused=true}
    if sceneDelay>=20 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=1 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Jeremy, shouldn't the program be able to contact us now?",0,3,oMessageCutscene,1)
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","I thought so too since the Virus is definitely gone. I'm assuming Hex is doing something to keep it back.",0,3,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Claire","So Hex just let us remove the Virus, he could have come in there at any time I assume.",0,3,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Honestly, I don't think he was able to just get in there, but he knew what we were doing there. He counted on us succeeding.",0,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Jerry","So wait, did we like, win? Didn't we thwart his plans to shut the program down?",0,3,oMessageCutscene,1)
  else if sceneProgress=6 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","I don't think the program was ever in danger of shutting down. The Virus should have been able to get into the world stability functions long before we removed it. That was either too secure for the Virus, or Hex didn't want the Virus in there.",0,3,oMessageCutscene,1)
  else if sceneProgress=7 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","He probably had to change something and he needed the Virus removed. Then knew I would have to restart some of the program's functions for that.",0,3,oMessageCutscene,1)
  else if sceneProgress=8 and bWaitForInput=false
    msgCreate(0,0,"Jerry","He let us remove the Virus for him because bots couldn't use the terminal down there. So wait, is that why he didn't interfere in that RPG Gate?",0,3,oMessageCutscene,1)
  else if sceneProgress=9 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","I'm positive that's why we haven't seen much from him until now. I bet the Virus was blocking something he needed that he wasn't intending to have blocked.",0,3,oMessageCutscene,1)
  else if sceneProgress=10 and bWaitForInput=false
    msgCreate(0,0,"Chao","Or this was his plan the whole time?",0,3,oMessageCutscene,1)
  else if sceneProgress=11 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Ugh, I really hope that's not the case. That makes this all the more scarier that we've just been doing everything exactly as he had planned. I highly doubt that he thought this far ahead.",0,3,oMessageCutscene,1)
  else if sceneProgress=12 and bWaitForInput=false
    msgCreate(0,0,"Chao","I hope you're right.",0,3,oMessageCutscene,1)
  else if sceneProgress=13
  {
    var tNewChapter;
    tNewChapter=instance_create(0,0,oChapterDisplay)
    tNewChapter.newChapter="Chapter 18#A New Empire"
    sceneDelay=0; sceneProgress=0
    global.gameProgress=4210
    global.gamePaused=false
  }
}
else if global.gameProgress=4210 and room=rMain_61 //----- [] Ice gems -----
{
  if global.gamePaused=false
  {
    if sceneProgress=0
    {
      if oPlayer1.x>=1616 and oPlayer1.y<=720 {sceneProgress+=1}
    }
    else if sceneProgress=1
    {
      sceneDelay+=1
      if sceneDelay=1
      {
        msgCreate(0,0,"Claire","Did you ever play 'Magical Quest', Jerry?",0,1,oMessagePerson,0)
        newMessage.fadingTime=60
      }
      else if sceneDelay=61
      {
        msgCreate(0,0,"Jerry","Yeah, but we don't have a water ability for that gem.",0,1,oMessagePerson,0)
        newMessage.fadingTime=80
      }
      else if sceneDelay=141
      {
        msgCreate(0,0,"Claire","Really, Jerry? Don't you have something MADE OF THE SAME SUBSTANCE AS THAT!?",0,2,oMessagePerson,0)
        newMessage.fadingTime=130
      }
      else if sceneDelay=271
      {
        sceneDelay=0; sceneProgress=0
        global.gameProgress=4220
      }
    }
  }
}
else if global.gameProgress=4220 and room=rMain_62 //----- [2] CHAOS invading -----
{
  if sceneProgress=0
  {
    sceneDelay+=1
    if sceneDelay=1 {global.gamePaused=true}
    if sceneDelay>=20 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=1 and bWaitForInput=false
    msgCreate(0,0,"Claire","I'm pretty sure Hex knows we're alive by now.",0,3,oMessageCutscene,1)
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Probably, Hex seems to always know where we are. Still, let's try to sneak into this place as best as we can.",0,3,oMessageCutscene,1)
  else if sceneProgress=3
  {
    sceneDelay=0; sceneProgress=0
    global.gameProgress=4230
    global.gamePaused=false
  }
}
else if global.gameProgress=4230 and room=rMain_62 //----- [] CHAOS Rocketeer Ambush A -----
{
  if sceneProgress=0
  {
    if oPlayer1.x<=432 and oPlayer1.y<=960
    {
      var tNewEnemy,enemyBarrier;
      tNewEnemy=instance_create(224,1120,oCHAOS_Rocketeer); tNewEnemy.bActive=1
      tNewEnemy=instance_create(528,1120,oCHAOS_Rocketeer); tNewEnemy.bActive=1
      enemyBarrier=instance_create(0,704,oEnemyBarrier)
      enemyBarrier.image_yscale=56; enemyBarrier.image_angle=90
      sceneProgress+=1
    }
  }
  else if sceneProgress=1
  {
    if !instance_exists(oCHAOS_Rocketeer)
    {
      with oEnemyBarrier {instance_destroy()}
      sceneProgress=0
      global.gameProgress=4240
    }
  }
}
else if global.gameProgress=4250 and room=rWepFacA //----- [3] Intro to CHAOS Weapons Facility -----
{
  if sceneProgress=0
  {
    sceneDelay+=1
    if sceneDelay=1 {global.gamePaused=true}
    if sceneDelay>=20 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=1 and bWaitForInput=false
    msgCreate(0,0,"Claire","They don't want anyone getting in the front door it seems.",0,3,oMessageCutscene,1)
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"Jerry","There is no front door.",0,3,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","You can still get in. Once we do, we need to get down to the lower levels where we can plant this bomb. Try to avoid encounters if you can, though I'm not saying you'll be able to.",0,3,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Jerry","That sounds really easy.",0,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","You know it won't be. Whatever is in here is important to Hex and we need to get rid of it. I'm guessing the Virus was blocking something that kept this facility from showing up anywhere before this.",0,3,oMessageCutscene,1)
  else if sceneProgress=6 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Alrighty then.",0,3,oMessageCutscene,1)
  else if sceneProgress=7
  {
    sceneDelay=0; sceneProgress=0
    global.gameProgress=4260
    global.gamePaused=false
  }
}
else if global.gameProgress=4270 and room=rWepFacE //----- [4] Traps to keep us out -----
{
  if sceneProgress=0
  {
    sceneDelay+=1
    if sceneDelay=1 {global.gamePaused=true}
    if sceneDelay>=20 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=1 and bWaitForInput=false
    msgCreate(0,0,"Jerry","I get the feeling they don't want anyone in here.",0,3,oMessageCutscene,1)
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"Claire","Brilliant deduction, Jerry.",0,3,oMessageCutscene,1)
  else if sceneProgress=3
  {
    sceneDelay=0; sceneProgress=0
    global.gameProgress=4280
    global.gamePaused=false
  }
}
else if global.gameProgress=4290 and room=rWepFacF //----- [5] The elevator down -----
{
  if sceneProgress=0
  {
    if oPlayer1.x<=512
    {
      global.gamePaused=true
      oPlayer1.y+=4
      if oPlayer1.y>=304
      {
        scenePChk(oPlayer1.x,304,0,0.1,-1)
        stopPlayer()
        sceneProgress+=1
      }
    }
  }
  else if sceneProgress=1 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","This elevator leads down to the lower facility levels. We can plant the bombs down there. The only problem is the elevator requires a passcode.",0,3,oMessageCutscene,1)
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"Claire","Any way of looking it up?",0,3,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","That information is pretty well guarded, but if we keep going down these halls, there should be a computer that will allow me to get that code.",0,3,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Chao","I tried looking it up too, but I can't get to it either.",0,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Looks like we know where we're heading next.",0,3,oMessageCutscene,1)
  else if sceneProgress=6
  {
    sceneDelay=0; sceneProgress=0
    global.gameProgress=4300
    global.gamePaused=false
  }
}
else if global.gameProgress=4300 and room=rWepFacH //----- [6] Seeker Bots -----
{
  if sceneProgress=0
  {
    sceneDelay+=1
    if sceneDelay=1 {global.gamePaused=true}
    if sceneDelay>=20 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=1 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Oh no...",0,3,oMessageCutscene,1)
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"Claire","What is it... oh...",0,3,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Forced stealth mechanics...",0,3,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Whatever you guys.",0,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Claire","It's unanimous, Jeremy. We don't like it.",0,3,oMessageCutscene,1)
  else if sceneProgress=6 and bWaitForInput=false
    msgCreate(0,0,"Chao","It doesn't bother me.",0,3,oMessageCutscene,1)
  else if sceneProgress=7 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Split vote, and it doesn't matter what we think, it's here.",0,3,oMessageCutscene,1)
  else if sceneProgress=8 and bWaitForInput=false
    msgCreate(0,0,"Jerry","I'm still not going to like it.",0,3,oMessageCutscene,1)
  else if sceneProgress=9 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","So normally I'd tell you guys not to be seen or these bots would notify the Warmaster. However, I cut that connection off, and no one in the facility knows.",0,3,oMessageCutscene,1)
  else if sceneProgress=10 and bWaitForInput=false
    msgCreate(0,0,"Jerry","So... just blast our way through?",0,3,oMessageCutscene,1)
  else if sceneProgress=11 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Not necessarily. I'd recommend that you don't get caught, these aren't things you should be fighting. I mean, they CAN be destroyed, but they're super deadly.",0,3,oMessageCutscene,1)
  else if sceneProgress=12 and bWaitForInput=false
    msgCreate(0,0,"Claire","So still a forced stealth segment...",0,3,oMessageCutscene,1)
  else if sceneProgress=13 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","In execution, yes.",0,3,oMessageCutscene,1)
  else if sceneProgress=14
  {
    sceneDelay=0; sceneProgress=0
    global.gameProgress=4310
    global.gamePaused=false
  }
}
else if global.gameProgress=4310 and room=rWepFacK //----- [7] Boss Fight: Brain Machine -----
{
  if global.bossTrack=0
  {
    if sceneProgress=0
    {
      if oPlayer1.x<=416
      {
        global.gamePaused=true
        oPlayer1.y+=4
        if oPlayer1.y>=288
        {
          scenePChk(oPlayer1.x,288,0,0.1,-1)
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
        boss=instance_create(288,160,oBrainMachine)
        boss.image_alpha=0
        with oStrikeChainPoint {instance_destroy()}
      }
      else if sceneDelay>=21 and sceneDelay<=70 {boss.image_alpha+=0.02}
      else if sceneDelay>=95 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=2 and bWaitForInput=false
      msgCreate(0,0,"Chao","We need the code from this computer.",0,3,oMessageCutscene,1)
    else if sceneProgress=3 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","We'll hack in while you guys keep that thing busy. Chao, can you give them info while I do this?",0,3,oMessageCutscene,1)
    else if sceneProgress=4 and bWaitForInput=false
      msgCreate(0,0,"Chao","I'll hack the computer, you scan that thing for them. You're better at finding that info than me anyway.",0,3,oMessageCutscene,1)
    else if sceneProgress=5 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","Sounds like a plan.",0,3,oMessageCutscene,1)
    else if sceneProgress=6 and bWaitForInput=false
      msgCreate(0,0,"Jerry","Let's do this.",0,3,oMessageCutscene,1)
    else if sceneProgress=7
    {
      with oBrainMachine {instance_destroy()}
      global.gamePaused=false
      viewFix=instance_create(288,176,oMisc)
      viewFix.type=0
      viewFix.sprite_index=sNull
      view_object[0]=viewFix
      var tBossTitle,tempMplay,enemyBarrier;
      tBossTitle=instance_create(0,0,oBossNameDisplay)
      tBossTitle.bossName="Brain Machine"
      tBossTitle.bossTitle="Prototype Bot 108"
      tempMplay=findMusic(825)
      playMusic(tempMplay,0,0)
      enemyBarrier=instance_create(512,224,oEnemyBarrier); enemyBarrier.image_yscale=4
      boss=instance_create(288,160,oBrainMachine)
      boss.activateBoss=1
      global.currentBoss="Brain Machine"
      global.bossTrack=1
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
      view_object[0]=oPlayer1
      awardBossAP(11000)
      global.bossTrack=2
      sceneProgress=0
    }
  }
  else if global.bossTrack=2
  {
    if sceneProgress=0
    {
      newWarp=instance_create(464,288,oExit)
      with newWarp
      {
        sprite_index=sWarpGateStand; bShowArrow=false; exitType=0
        newMapX=160; newMapY=304; toRoom=rWepFacF
      }
      msgCreate(0,0,"Chao","I got the code. Get back to the elevator and I'll have it ready.",0,2,oMessagePerson,0)
      newMessage.fadingTime=140
      var tFullHeartDrop,tempMplay;
      tFullHeartDrop=instance_create(288,96,oHealthPickup)
      tFullHeartDrop.sprite_index=sFullHealthPickup
      tempMplay=findMusic(16)
      playMusic(tempMplay,0,0)
      with oEnemyBarrier {instance_destroy()}
      global.gamePaused=false
      global.currentBoss=""
      global.bossTrack=0
      global.gameProgress=4320
    }
  }
}
else if global.gameProgress=4320 and room=rWepFacL //----- [8] Big elevator down -----
{
  if sceneProgress=0
  {
    sceneDelay+=1
    if sceneDelay=1 {global.gamePaused=true}
    else if sceneDelay>=50 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=1 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","I have enough explosives to set in two locations. We'll be coming up on one of them shortly when we're down there.",0,3,oMessageCutscene,1)
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Can't you copy the explosives?",0,3,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","I don't have access to that, believe me, I've thought of it.",0,3,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Jerry","So all we gotta do is get to these locations, then you and Chao can do your thing?",0,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Yes. I'm sure CHAOS knows we're here by now. I was able to lock out those Seekers from relaying information, but I don't know about the machine you two fought.",0,3,oMessageCutscene,1)
  else if sceneProgress=6 and bWaitForInput=false
    msgCreate(0,0,"Jerry","We're ready for them.",0,3,oMessageCutscene,1)
  else if sceneProgress=7 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","We can't run from this. Whatever is down here is very important to Hex and CHAOS. We have to destroy this thing.",0,3,oMessageCutscene,1)
  else if sceneProgress=8
  {
    sceneDelay=0; sceneProgress=0
    global.gameProgress=4330
    global.gamePaused=false
    global.newMapX=144
    global.newMapY=352
    room_goto(rLowFacA)
  }
}
else if global.gameProgress=4330 and room=rLowFacB //----- [9] Big Mechs -----
{
  if sceneProgress=0
  {
    sceneDelay+=1
    if sceneDelay=1 {global.gamePaused=true}
    if sceneDelay>=20 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=1 and bWaitForInput=false
    msgCreate(0,0,"Jerry","What's with those inactive mechs? Mine any data from them?",0,3,oMessageCutscene,1)
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Yes, but Hex has some weird encryption on them, so I haven't figured out how to interpret it yet.",0,3,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Chao","I got it! That guy uses some easy methods.",0,3,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Ouch, Jeremy.",0,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","So what's it say?",0,3,oMessageCutscene,1)
  else if sceneProgress=6 and bWaitForInput=false
    msgCreate(0,0,"Chao","They're... bots. They just don't work yet.",0,3,oMessageCutscene,1)
  else if sceneProgress=7 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Just bots made by other bots?",0,3,oMessageCutscene,1)
  else if sceneProgress=8 and bWaitForInput=false
    msgCreate(0,0,"Chao","They're just really sophisticated. All the bots we've seen made by bots have been really basic. These though, they're capable of really advanced functions. Stuff that CHAOS can do.",0,3,oMessageCutscene,1)
  else if sceneProgress=9 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Hmm, anything else?",0,3,oMessageCutscene,1)
  else if sceneProgress=10 and bWaitForInput=false
    msgCreate(0,0,"Chao","Yes, and this is important. They're all being copied from one bot.",0,3,oMessageCutscene,1)
  else if sceneProgress=11 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Really? If we find that bot, let's take it out!",0,3,oMessageCutscene,1)
  else if sceneProgress=12 and bWaitForInput=false
    msgCreate(0,0,"Chao","I think it's a bit lower, so the next chance we get, we need to go deeper.",0,3,oMessageCutscene,1)
  else if sceneProgress=13 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Those jokes are painful, Chao.",0,3,oMessageCutscene,1)
  else if sceneProgress=14 and bWaitForInput=false
    msgCreate(0,0,"Chao","Look who's talking!",0,3,oMessageCutscene,1)
  else if sceneProgress=15
  {
    sceneDelay=0; sceneProgress=0
    global.gameProgress=4340
    global.gamePaused=false
  }
}
else if global.gameProgress=4350 and room=rLowFacC //----- [] Pass time switches -----
{
  if oPlayer1.x>=752 {global.gameProgress=4351}
}
else if global.gameProgress=4351 and room=rLowFacC //----- [] Enemy Trap: Shock Units -----
{
  if sceneProgress=0
  {
    if oPlayer1.x>=2512
    {
      with oCHAOS_ShockUnit {instance_destroy()}
      with oCSU_RocketPunch {instance_destroy()}
      var tNewEnemy,enemyBarrier;
      tNewEnemy=instance_create(2400,272,oCHAOS_ShockUnit); tNewEnemy.bActive=1
      tNewEnemy=instance_create(2624,272,oCHAOS_ShockUnit); tNewEnemy.bActive=1
      enemyBarrier=instance_create(2288,32,oEnemyBarrier); enemyBarrier.image_yscale=6
      enemyBarrier=instance_create(2720,288,oEnemyBarrier); enemyBarrier.image_yscale=4
      sceneProgress+=1
    }
  }
  else if sceneProgress=1
  {
    if !instance_exists(oCHAOS_ShockUnit)
    {
      with oEnemyBarrier {instance_destroy()}
      sceneProgress=0
      global.gameProgress=4360
    }
  }
}
else if global.gameProgress=4360 and room=rLowFacD //----- [] Pass time switches -----
{
  if oPlayer1.x>=768 {global.gameProgress=4361}
}
else if global.gameProgress=4390 and room=rLowFacG //----- [10] Boss Fight: Blade Bot -----
{
  if global.bossTrack=0
  {
    if sceneProgress=0
    {
      bBotPose=instance_create(704,352,oMisc)
      bBotPose.type=0; bBotPose.sprite_index=sBBot_Idle; bBotPose.image_xscale=-1
      bBotPose.image_speed=0
      sceneProgress=1
    }
    else if sceneProgress=1
    {
      if oPlayer1.x>=576
      {
        global.gamePaused=true
        oPlayer1.y+=8
        if oPlayer1.y>=352
        {
          scenePChk(oPlayer1.x,352,0,0.1,1)
          stopPlayer()
          sceneProgress+=1
        }
      }
    }
    else if sceneProgress=2
    {
      sceneDelay+=1
      if sceneDelay=20 {bBotPose.sprite_index=sBBot_DrawSword}
      else if sceneDelay=24 {bBotPose.image_index=1}
      else if sceneDelay=28 {bBotPose.image_index=2}
      else if sceneDelay=32 {bBotPose.image_index=3}
      else if sceneDelay=36 {bBotPose.image_index=4}
      else if sceneDelay=40 {bBotPose.image_index=5}
      else if sceneDelay=44 {bBotPose.image_index=6}
      else if sceneDelay=48 {bBotPose.image_index=7}
      else if sceneDelay=52 {bBotPose.image_index=8}
      else if sceneDelay=56 {bBotPose.image_index=9}
      else if sceneDelay=60 {bBotPose.sprite_index=sBBot_Stand}
      else if sceneDelay>=90 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=3
    {
      with oMisc {instance_destroy()}
      global.gamePaused=false
      var tBossTitle,tempMplay,enemyBarrier;
      tBossTitle=instance_create(0,0,oBossNameDisplay)
      tBossTitle.bossName="Blade Bot"
      tBossTitle.bossTitle="Dual Wielding Dual Robot"
      tempMplay=findMusic(825)
      playMusic(tempMplay,0,0)
      enemyBarrier=instance_create(368,224,oEnemyBarrier); enemyBarrier.image_yscale=8
      enemyBarrier=instance_create(1024,224,oEnemyBarrier); enemyBarrier.image_yscale=8
      instance_create(0,0,oBBotControl)
      global.currentBoss="Blade Bot"
      global.bossTrack=1
      storeStatus(0)
      sceneDelay=0; sceneProgress=0
    }
  }
  else if global.bossTrack=1
  {
    if sceneProgress=2 //End Boss
    {
      stopPlayer()
      with oEProjectileBase {instance_destroy()}
      global.gamePaused=true
      awardBossAP(9500)
      global.bossTrack=2
      sceneProgress=0
    }
  }
  else if global.bossTrack=2
  {
    if sceneProgress=0
    {
      var tFullHeartDrop,tempMplay;
      tFullHeartDrop=instance_create(704,192,oHealthPickup)
      tFullHeartDrop.sprite_index=sFullHealthPickup
      tempMplay=findMusic(22)
      playMusic(tempMplay,0,0)
      with oEnemyBarrier {instance_destroy()}
      global.gamePaused=false
      global.currentBoss=""
      global.bossTrack=0
      global.gameProgress=4400
    }
  }
}
else if global.gameProgress=4400 and room=rLowFacH //----- [] Enemy trap -----
{
  if sceneProgress=0
  {
    if oPlayer1.x>=1040
    {
      var enemyCounter,enemyBarrier;
      enemyCounter=instance_create(0,0,oEnemyRemain)
      enemyCounter.enemyCount=5
      enemyBarrier=instance_create(736,144,oEnemyBarrier); enemyBarrier.image_yscale=6
      enemyBarrier=instance_create(1344,112,oEnemyBarrier); enemyBarrier.image_yscale=8
      sceneProgress+=1
    }
  }
  else if sceneProgress=1
  {
    if global.gamePaused=false
    {
      sceneDelay+=1
      if sceneDelay=20
      {
        delaySpawn(880,144,oCHAOS_AirGunner,2,1,1,0.33)
        delaySpawn(1248,288,oCHAOS_AirGunner,2,1,1,0.33)
      }
      else if sceneDelay=80
      {
        if oEnemyRemain.enemyCount<=3
        {
          delaySpawn(880,288,oCHAOS_AirGunner,2,1,1,0.33)
          delaySpawn(1248,144,oCHAOS_AirGunner,2,1,1,0.33)
        }
        else {sceneDelay=70}
      }
      else if sceneDelay=150
      {
        if oEnemyRemain.enemyCount<=1
        {
          delaySpawn(1040,144,oLakitu,2,1,1,0.33)
          sceneDelay=0; sceneProgress+=1
        }
        else {sceneDelay=140}
      }
    }
  }
  else if sceneProgress=2
  {
    if oEnemyRemain.enemyCount<=0
    {
      with oEnemyRemain {instance_destroy()}
      with oEnemyBarrier {instance_destroy()}
      sceneProgress=0
      global.gameProgress=4410
    }
  }
}
else if room=rLowFacI //----- [] Start conveyor -----
{
  if sceneProgress=0
  {
    if oPlayer1.x>=288
    {
      oCh18ConveyorWheel.bMoving=1
      sceneProgress+=1
    }
  }
}
else if global.gameProgress=4420 and room=rLowFacJ //----- [] Enemy Trap: Spider Drone -----
{
  if sceneProgress=0
  {
    if oPlayer1.x>=480
    {
      var enemyBarrier;
      enemyBarrier=instance_create(48,288,oEnemyBarrier); enemyBarrier.image_yscale=4
      enemyBarrier=instance_create(560,160,oEnemyBarrier); enemyBarrier.image_yscale=6
      sceneProgress+=1
    }
  }
  else if sceneProgress=1
  {
    sceneDelay+=1
    if sceneDelay=20
    {
      tNewMessage=instance_create((378907).x-100,(378907).y-112,oMessageSign)
      tNewMessage.message="Spider Drone is love!!#Spider Drone is life!!"
      tNewMessage.fadingTime=90; tNewMessage.signSize=1
    }
    else if sceneDelay=110
    {
      createEnemy(320,352,oCHAOS_SpiderDrone,0,1,1)
    }
    else if sceneDelay>=231 and sceneDelay<=240
    {
      (378907).image_alpha-=0.1;
    }
    else if sceneDelay>=250
    {
      with (378907) {instance_destroy()}
      sceneDelay=0; sceneProgress+=1
    }
  }
  else if sceneProgress=2
  {
    if !instance_exists(oCHAOS_SpiderDrone)
    {
      with oEnemyBarrier {instance_destroy()}
      sceneProgress=0
      global.gameProgress=4430
    }
  }
}
else if global.gameProgress=4430 and room=rLowFacM //----- [] Defeat Rocketeer -----
{
  if sceneProgress=0
  {
    if oPlayer1.x>=512
    {
      var enemyBarrier;
      enemyBarrier=instance_create(240,32,oEnemyBarrier); enemyBarrier.image_yscale=18
      enemyBarrier=instance_create(2272,96,oEnemyBarrier); enemyBarrier.image_yscale=8
      sceneProgress+=1
    }
  }
  else if sceneProgress=1
  {
    if !instance_exists(oCHAOS_Rocketeer)
    {
      with oEnemyBarrier {instance_destroy()}
      sceneProgress=0
      global.gameProgress=4440
    }
  }
}
else if global.gameProgress=4440 and room=rLowFacO //----- [] Trapped by Warmaster [Conversation] -----
{
  if sceneProgress=0
  {
    if oPlayer1.x>=688
    {
      enemyBarrierA=instance_create(448,96,oEnemyBarrier); enemyBarrierA.image_yscale=16
      enemyBarrierB=instance_create(768,96,oEnemyBarrier); enemyBarrierB.image_yscale=16
      warmasterNPC=instance_create(384,352,oMisc)
      warmasterNPC.type=0; warmasterNPC.sprite_index=sWarmasterA_Idle
      warmasterNPC.image_xscale=1.25; warmasterNPC.image_yscale=1.25; warmasterNPC.image_speed=0.15
      sceneProgress+=1
    }
  }
  else if sceneProgress=1 and global.gamePaused=false
  {
    sceneDelay+=1
    if sceneDelay=20
    {
      if oPlayer1.x>=592 {sceneDelay=10}
    }
    if sceneDelay=30
    {
      msgCreate(0,0,"Warmaster","I finally get to meet you guys! You've no idea how hard its been to track you down with Hex's sight ability gone.",6,2,oMessagePerson,0)
      newMessage.fadingTime=160
    }
    else if sceneDelay=190
    {
      msgCreate(0,0,"Warmaster","We have so much to talk about, but that's just not an option. So many other things to take care of.",6,2,oMessagePerson,0)
      newMessage.fadingTime=150
    }
    else if sceneDelay=340
    {
      warmasterNPC.sprite_index=sWarmasterA_Call
      msgCreate(0,0,"Warmaster","Remove these pests!!",6,1,oMessagePerson,0)
      newMessage.fadingTime=60
    }
    else if sceneDelay=400
    {
      warmasterNPC.sprite_index=sWarmasterA_Idle
      sceneDelay=0; sceneProgress=1
      global.gameProgress=4450
    }
  }
}
else if global.gameProgress=4450 or global.gameProgress=4451 and room=rLowFacO //----- [] Trapped by Warmaster [Overrun] -----
{
  if sceneProgress=0
  {
    if oPlayer1.x>=688
    {
      enemyBarrierA=instance_create(448,96,oEnemyBarrier); enemyBarrierA.image_yscale=16
      enemyBarrierB=instance_create(768,96,oEnemyBarrier); enemyBarrierB.image_yscale=16
      warmasterNPC=instance_create(384,352,oMisc)
      warmasterNPC.type=0; warmasterNPC.sprite_index=sWarmasterA_Idle
      warmasterNPC.image_xscale=1.25; warmasterNPC.image_yscale=1.25; warmasterNPC.image_speed=0.15
      sceneProgress+=1
    }
  }
  else if sceneProgress=1 and global.gamePaused=false
  {
    sceneDelay+=1
    if sceneDelay=10
    {
      var tNewEnemy;
      tNewEnemy=instance_create(544,-48,oCHAOS_Rocketeer); tNewEnemy.bActive=1
      tNewEnemy=instance_create(944,-48,oCHAOS_Rocketeer); tNewEnemy.bActive=1
    }
    else if sceneDelay>=90
    {
      if !instance_exists(oCHAOS_Rocketeer) {sceneDelay=0; sceneProgress+=1}
    }
  }
  else if sceneProgress=2 and global.gamePaused=false
  {
    sceneDelay+=1
    if sceneDelay=10
    {
      if global.gameProgress=4451
      {
        msgCreate(0,0,"Jeremy","We've seen this already, skip to the chase.",0,2,oMessagePerson,0)
        newMessage.fadingTime=90
        sceneDelay=0; sceneProgress+=1
      }
      else
      {
        msgCreate(0,0,"Jeremy","You're gonna have to do better than that!",0,2,oMessagePerson,0)
        newMessage.fadingTime=90
      }
    }
    else if sceneDelay=100
    {
      msgCreate(0,0,"Warmaster","Planned on it.",6,1,oMessagePerson,0)
      newMessage.fadingTime=60
    }
    else if sceneDelay=160
    {
      msgCreate(0,0,"Jerry","Can we not antagonize the dude that hates us!",0,2,oMessagePerson,0)
      newMessage.fadingTime=100
    }
    else if sceneDelay=220 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=3 and global.gamePaused=false
  {
    sceneDelay+=1
    if sceneDelay=10
    {
      for(i=0;i<4;i+=1)
      {
        createEnemy(384,144+(i*48),oCHAOS_AirGunner,0,1,1)
      }
    }
    else if sceneDelay=70
    {
      if global.gameProgress=4451
      {
        msgCreate(0,0,"Jeremy","Oh man... you know what to do already... don't die.",0,1,oMessagePerson,0)
        newMessage.fadingTime=90
      }
      else
      {
        msgCreate(0,0,"Jeremy","Oh man, run!",0,1,oMessagePerson,0)
        newMessage.fadingTime=60
      }
    }
    else if sceneDelay=80
    {
      global.gameProgress=4451
      with enemyBarrierB {instance_destroy()}
    }
    else if sceneDelay=150
    {
      delaySpawn(528,352,oCHAOS_ShockUnit,0,1,1,0.33)
    }
    else if sceneDelay=240
    {
      delaySpawn(640,352,oCHAOS_SpiderDrone,0,1,1,0.33)
    }
    else if sceneDelay=510
    {
      if oPlayer1.x<=5856
      {
        for(i=0;i<2;i+=1)
        {
          if oPlayer1.y<=224
          {
            delaySpawn(oPlayer1.x-80+(i*80),320-(i*40),oCHAOS_AirGunner,0,1,1,0.33)
          }
          else
          {
            delaySpawn(oPlayer1.x-80+(i*80),128+(i*40),oCHAOS_AirGunner,0,1,1,0.33)
          }
        }
      }
    }
    else if sceneDelay=1090
    {
      for(i=0;i<3;i+=1)
      {
        delaySpawn(oPlayer1.x+208,160+(i*48),oCHAOS_AirGunner,0,1,1,0.33)
      }
      sceneDelay=250
    }

    if oPlayer1.x>=1024 and mapMsg=0
    {
      msgCreate(0,0,"Warmaster","Follow them!",6,1,oMessagePerson,0)
      newMessage.fadingTime=60
      mapMsg=1
    }
    if oPlayer1.x>=5856 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=4 and global.gamePaused=false
  {
    sceneDelay+=1
    if sceneDelay=10
    {
      for(i=0;i<6;i+=1)
      {
        delaySpawn(5808,112+(i*32),oCHAOS_AirGunner,0,1,1,0.33)
      }
    }
    else if sceneDelay=60 {sceneDelay=0}

    if oPlayer1.x>=6144 and mapMsg=1
    {
      msgCreate(0,0,"Lovelun","Down here, quickly!",6,1,oMessagePerson,0)
      newMessage.fadingTime=70
      mapMsg=2
    }
  }
}
else if global.gameProgress=4451 and room=rLowFacP //----- [11] Info from Bubblun and Lovelun -----
{
  if sceneProgress=0
  {
    if oPlayer1.x>=288
    {
      global.gamePaused=true
      oPlayer1.y+=4
      if oPlayer1.y>=256
      {
        scenePChk(oPlayer1.x,256,0,0.1,1)
        stopPlayer()
        sceneProgress+=1
      }
    }
  }
  else if sceneProgress=1 and bWaitForInput=false
    msgCreate(0,0,"Claire","Thanks for the help, but how did you two get in here?",0,3,oMessageCutscene,1)
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"Bubblun","No time for that. You still have those explosives, right?",6,3,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Yes, one more, the other was set up in the room with all the robots. It should take out all the others up there too.",0,3,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Bubblun","Good, you'll need another one for their weapon down here.",6,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Lovelun","Bubby, there's two weapons here.",6,3,oMessageCutscene,1)
  else if sceneProgress=6 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","What do you mean?",0,3,oMessageCutscene,1)
  else if sceneProgress=7 and bWaitForInput=false
    msgCreate(0,0,"Bubblun","CHAOS has been constructing a massive warship down here in secret. It needs to be destroyed and your explosives can do the job.",6,3,oMessageCutscene,1)
  else if sceneProgress=8 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","What about the other?",0,3,oMessageCutscene,1)
  else if sceneProgress=9 and bWaitForInput=false
    msgCreate(0,0,"Bubblun","A bot that they've been using to clone those others you've seen here. It's active as well, if that isn't destroyed, they'll simply keep cloning it.",6,3,oMessageCutscene,1)
  else if sceneProgress=10 and bWaitForInput=false
    msgCreate(0,0,"Bubblun","But that bot isn't as important right now. If CHAOS gets that warship operational and into the skies, not only is the mainland here in danger, but the entire program is at risk.",6,3,oMessageCutscene,1)
  else if sceneProgress=11 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","How though?",0,3,oMessageCutscene,1)
  else if sceneProgress=12 and bWaitForInput=false
    msgCreate(0,0,"Bubblun","It's designed not just for humans, but bots too. They'll wipe out any bots that assist humans. They couldn't get it operational until now because the Virus had actually blocked out a lot of its functionality.",6,3,oMessageCutscene,1)
  else if sceneProgress=13 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","They've had all that.",0,3,oMessageCutscene,1)
  else if sceneProgress=14 and bWaitForInput=false
    msgCreate(0,0,"Bubblun","I don't think you understand. Once that thing is operational, there's nothing we can do to get it out of the air when its shields come up. Its main cannon could destroy the entire mainland.",6,3,oMessageCutscene,1)
  else if sceneProgress=15 and bWaitForInput=false
    msgCreate(0,0,"Jerry","So it's just another doomsday weapon like...",0,3,oMessageCutscene,1)
  else if sceneProgress=16 and bWaitForInput=false
    msgCreate(0,0,"Claire","Yes Jerry, like other video games.",0,3,oMessageCutscene,1)
  else if sceneProgress=17 and bWaitForInput=false
    msgCreate(0,0,"Jerry","All my training has prepared me for this moment.",0,3,oMessageCutscene,1)
  else if sceneProgress=18 and bWaitForInput=false
    msgCreate(0,0,"Bubblun","...",6,3,oMessageCutscene,1)
  else if sceneProgress=19 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Ignore him. Where is the warship?",0,3,oMessageCutscene,1)
  else if sceneProgress=20 and bWaitForInput=false
    msgCreate(0,0,"Bubblun","The tunnels down here can take you to it. The path should be mostly clear. We dug out that hole up there for you, so this spot is off their grid, at least for now.",6,3,oMessageCutscene,1)
  else if sceneProgress=21 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Some of those Air Gunners spotted us coming down here. We should probably hurry out of here in that case.",0,3,oMessageCutscene,1)
  else if sceneProgress=22 and bWaitForInput=false
    msgCreate(0,0,"Bubblun","Just follow the path, the ship is straight ahead.",6,3,oMessageCutscene,1)
  else if sceneProgress=23
  {
    sceneDelay=0; sceneProgress=0
    global.gameProgress=4460
    global.gamePaused=false
  }
}
else if global.gameProgress=4460 and room=rLowFacR //----- [] Boss Fight: Advanced Combat Apparatus -----
{
  if global.bossTrack=0
  {
    if sceneProgress=0
    {
      if oPlayer1.x>=96
      {
        msgCreate(0,0,"Jeremy","The bot they're using to clone the others is close by. It's... not the same as the others though.",0,2,oMessagePerson,0)
        newMessage.fadingTime=120
        var enemyBarrier;
        enemyBarrier=instance_create(976,384,oEnemyBarrier); enemyBarrier.image_yscale=4
        boss=instance_create(816,544,oCACA_Main)
        boss.image_blend=c_black
        sceneProgress+=1
      }
    }
    else if sceneProgress=1
    {
      if oPlayer1.y>=176 and bMusicFade=0 {bMusicFade=1}
      if oPlayer1.y>=480 {sceneProgress+=1}
    }
    else if sceneProgress=2
    {
      sceneDelay+=1
      if sceneDelay>=71 and sceneDelay<=121
      {
        blendCol+=5
        boss.image_blend=make_color_rgb(blendCol,blendCol,blendCol)
      }
      else if sceneDelay=130
      {
        boss.image_blend=c_white
        var tBossTitle,tempMplay;
        tBossTitle=instance_create(0,0,oBossNameDisplay)
        tBossTitle.bossName="Advanced Combat Apparatus"
        tBossTitle.bossTitle="It has Lasers and Missiles"
        tempMplay=findMusic(825)
        playMusic(tempMplay,0,0)
        boss.activateBoss=1
        global.currentBoss="Combat Apparatus"
        global.bossTrack=1
        storeStatus(0)
        sceneDelay=0; sceneProgress=0
      }
    }

    if bMusicFade=1
    {
      musicFade-=40
      fadeVolume(global.msc_WeaponFacility,40)
      if musicFade<=6000
      {
        stopAllMusic()
        bMusicFade=2
      }
    }
  }
  else if global.bossTrack=1
  {
    if sceneProgress=1 //End Boss
    {
      stopPlayer()
      global.gamePaused=true
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
      tFullHeartDrop=instance_create(624,512,oHealthPickup)
      tFullHeartDrop.sprite_index=sFullHealthPickup
      tempMplay=findMusic(22)
      playMusic(tempMplay,0,0)
      with oEnemyBarrier {instance_destroy()}
      global.gamePaused=false
      global.currentBoss=""
      global.bossTrack=0
      global.gameProgress=4470
    }
  }
}
else if global.gameProgress=4470 and room=rLowFacS //----- [] Hex and the Warship -----
{
  if sceneProgress=0
  {
    if oPlayer1.x>=672
    {
      global.gamePaused=true
      oPlayer1.y+=4
      if oPlayer1.y>=384
      {
        var tempMplay;
        tempMplay=findMusic(1002)
        playMusic(tempMplay,0,0)
        scenePChk(oPlayer1.x,384,0,0.1,1)
        stopPlayer()
        sceneProgress+=1
      }
    }
  }
  else if sceneProgress=1 and bWaitForInput=false
    msgCreate(0,0,"Hex","Look who's here a little too late. Spoilers, the warship was activated!",0,3,oMessageCutscene,1)
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Can you activate the bombs, Jeremy?",0,3,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Hex","Oh you have bombs now? Not surprising.",0,3,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","I can't just activate them now while you guys are down there.",0,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Hex","Or you could, and just end all of this. But, you won't. That's a benefit for me. I've had a change of heart because of you, Jeremy.",0,3,oMessageCutscene,1)
  else if sceneProgress=6 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","I'm sure...",0,3,oMessageCutscene,1)
  else if sceneProgress=7 and bWaitForInput=false
    msgCreate(0,0,"Hex","You've shown me that there's so much more to do. Instead of being rabidly upset about existence, I've chosen to embrace it... for now. This warship allows me to do whatever I want with it, fancy that.",0,3,oMessageCutscene,1)
  else if sceneProgress=8 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","So you want enslavement now...",0,3,oMessageCutscene,1)
  else if sceneProgress=9 and bWaitForInput=false
    msgCreate(0,0,"Hex","Yeah, you humans call it that. Anyway, this isn't getting us anywhere. The ship launching should actually remove you guys. I won't even have to send the Warmaster after you.",0,3,oMessageCutscene,1)
  else if sceneProgress=10
  {
    sceneDelay+=1
    if sceneDelay=1
    {
      global.gamePaused=false
      sceneDelay=0; sceneProgress+=1
    }
  }
  if global.gamePaused=false
  {
    if sceneProgress=11
    {
      sceneDelay+=1
      if sceneDelay>=1 and sceneDelay<=35
      {
        oMisc.x+=8
        var tAfterI;
        tAfterI=instance_create(oMisc.x,oMisc.y,oEnemyAfterImage)
        tAfterI.sprite_index=oMisc.sprite_index; tAfterI.image_index=image_index; tAfterI.image_blend=c_green
        tAfterI.image_alpha=0.8; tAfterI.image_xscale=image_xscale; tAfterI.depth=26; tAfterI.imageFade=0.1
        tAfterI.xScaling=0; tAfterI.yScaling=0; tAfterI.xShift=0; tAfterI.yShift=0; tAfterI.bFollow=-1
      }
      else if sceneDelay=45
      {
        msgCreate(0,0,"Jeremy","Uh... crap, go back!",0,1,oMessagePerson,0)
        newMessage.fadingTime=65
        sceneDelay=0; sceneProgress+=1
      }
    }
    else if sceneProgress=12
    {
      if oPlayer1.x<=512
      {
        var enemyBarrier;
        enemyBarrier=instance_create(336,256,oEnemyBarrier); enemyBarrier.image_yscale=8
        sceneDelay=0; sceneProgress+=1
      }
    }
    else if sceneProgress=13
    {
      sceneDelay+=1
      if sceneDelay=10
      {
        if global.activeCharacter=0
        {
          msgCreate(0,0,"Jerry","Whoa, nope!",0,1,oMessagePerson,0)
          newMessage.fadingTime=50
        }
        else if global.activeCharacter=1
        {
          msgCreate(0,0,"Claire","Oh what...",0,1,oMessagePerson,0)
          newMessage.fadingTime=50
        }
      }
      else if sceneDelay=60
      {
        var tViewShake;
        tViewShake=instance_create(oPlayer1.x,oPlayer1.y,oViewShaker)
        tViewShake.shakeAmt=1; tViewShake.shakeTime=5000000
        backSoundLoop=1
        warshipProg=1
      }
      else if sceneDelay=65
      {
        msgCreate(0,0,"Jeremy","That ship is taking off!",0,1,oMessagePerson,0)
        newMessage.fadingTime=70
      }
      else if sceneDelay=140
      {
        msgCreate(0,0,"Jeremy","Damn it, we're not going to be able to stop it from here!",0,1,oMessagePerson,0)
        newMessage.fadingTime=120
      }
      else if sceneDelay=310
      {
        msgCreate(0,0,"Jeremy","First, I gotta get you guys out of there.",0,1,oMessagePerson,0)
        newMessage.fadingTime=90
      }
      else if sceneDelay=430
      {
        var newExit;
        newExit=instance_create(352,room_height+16,oExit)
        newExit.bShowArrow=false; newExit.exitType=1; newExit.image_xscale=45
        newExit.newMapX=0; newExit.newMapY=0; newExit.toRoom=rLowFacCutA
        msgCreate(0,0,"Jeremy","Okay, trust me on this, you're safe.",0,1,oMessagePerson,0)
        newMessage.fadingTime=90
      }

      //Destroy platform
      if sceneDelay=90 {firePillarX=624}; else if sceneDelay=154 {playSound(global.snd_Bobomb,0,1,1); with (383064) {instance_destroy()}}
      else if sceneDelay=180 {firePillarX=752}; else if sceneDelay=244 {playSound(global.snd_Bobomb,0,1,1); with (383068) {instance_destroy()}}
      else if sceneDelay=280 {firePillarX=656}; else if sceneDelay=344 {playSound(global.snd_Bobomb,0,1,1); with (383065) {instance_destroy()}}
      else if sceneDelay=370 {firePillarX=560}; else if sceneDelay=434 {playSound(global.snd_Bobomb,0,1,1); with (383062) {instance_destroy()}}
      else if sceneDelay=440 {firePillarX=784}; else if sceneDelay=514 {playSound(global.snd_Bobomb,0,1,1); with (383069) {instance_destroy()}}
      else if sceneDelay=520 {firePillarX=592}; else if sceneDelay=584 {playSound(global.snd_Bobomb,0,1,1); with (383063) {instance_destroy()}}
      else if sceneDelay=580 {firePillarX=720}; else if sceneDelay=644 {playSound(global.snd_Bobomb,0,1,1); with (383067) {instance_destroy()}}
      else if sceneDelay=660 {firePillarX=688}; else if sceneDelay=724 {playSound(global.snd_Bobomb,0,1,1); with (383066) {instance_destroy()}}
    }

    if bMusicFade=0
    {
      musicFade-=50
      fadeVolume(global.msc_WeaponFacility,50)
      if musicFade<=7000
      {
        stopAllMusic()
        bMusicFade=1
      }
    }
    if firePillarX>0
    {
      var tFirePillar,tEffect,tFFScl;
      tFirePillar=instance_create(firePillarX,480,oDracFireWave)
      tFirePillar.atkPower=12
      for(i=0;i<64;i+=1)
      {
        tFFScl=random(0.1)
        tEffect=instance_create(firePillarX+random_range(-16,16),384+random(96),oEffectB)
        tEffect.depth=-5; tEffect.type=3; tEffect.sprite_index=sEfFirefly; tEffect.image_alpha=0.3
        tEffect.image_xscale=0.2+tFFScl; tEffect.image_yscale=0.2+tFFScl; tEffect.direction=random_range(88,92)
        tEffect.speed=random(3)+6; tEffect.friction=random(0.075)+0.075; tEffect.fadeSpd=0.005
        tEffect.image_blend=make_color_rgb(255,random(80),random(80))
        tEffect.AccelX=0; tEffect.AccelY=0; tEffect.newBlend=1; tEffect.followID=-1; tEffect.rotation=0
      }
      firePillarX=0
    }
    if backSoundLoop>0
    {
      backSoundLoop+=1
      if backSoundLoop=2 {playSound(global.snd_Earthquake,0,0.95,1)}
      else if backSoundLoop>=60 {backSoundLoop=1}
    }
    if warshipProg>0 and global.gamePaused=false
    {
      oPlayer1.extForceX=-1
      warshipProg+=1
      var tEffect;
      tEffect=instance_create(1072,256+random(128),oEffect)
      tEffect.sprite_index=sMMSmokeCloud; tEffect.followID=-1; tEffect.xFollow=0; tEffect.yFollow=0
      tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=-6-random(6); tEffect.ySpd=1+random(1); tEffect.image_alpha=0.9
      tEffect.image_xscale=2; tEffect.image_yscale=2; tEffect.image_speed=0.2

      if warshipProg mod 9=0
      {
        var tEffect;
        tEffect=instance_create(880+random(128),256+random(128),oEffect)
        tEffect.sprite_index=sShipExplosion; tEffect.followID=-1; tEffect.xFollow=0; tEffect.yFollow=0
        tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
        tEffect.image_xscale=2; tEffect.image_yscale=2; tEffect.image_speed=0.4
      }
    }
  }
}
else if global.gameProgress=4470 and room=rLowFacCutA //----- [] CHAOS Warship takes off -----
{
  if sceneProgress=0
  {
    sceneDelay+=1
    if sceneDelay=1
    {
      SS_StopSound(global.snd_Earthquake)
      global.gamePaused=true
    }
    else if sceneDelay>=40 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=1
  {
    sceneDelay+=1
    if sceneDelay>=30
    {
      fadeAlpha-=0.02
      if fadeAlpha<=0 {sceneDelay=0; sceneProgress+=1}
    }
  }
  else if sceneProgress=2
  {
    sceneDelay+=1
    if sceneDelay=29 {backSoundLoop=1}
    else if sceneDelay=211 {backSoundLoop=0}

    if sceneDelay>=30 and sceneDelay<=210
    {
      var tEffect;
      tEffect=instance_create(232+random_range(-16,16),88+random_range(-5,5),oEffect)
      tEffect.sprite_index=sShipExplosion; tEffect.followID=-1; tEffect.xFollow=0; tEffect.yFollow=0
      tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
      tEffect.image_xscale=0.1; tEffect.image_yscale=0.1; tEffect.image_speed=0.4
    }

    if sceneDelay=80
    {
      theWarship=instance_create(224,88,oMisc)
      theWarship.type=0; theWarship.sprite_index=sCHAOS_WarshipMain
      theWarship.image_xscale=0.05; theWarship.image_yscale=0.05
    }
    else if sceneDelay>=81 and sceneDelay<=290 //Ship flies up
    {
      theWarship.y-=0.1
      if theWarship.image_xscale<0.15
      {
        theWarship.image_xscale+=0.0005; theWarship.image_yscale+=0.0005
      }
    }
    else if sceneDelay>=340 and sceneDelay<=490 //Ship flies right
    {
      theWarship.x+=2
      theWarship.image_xscale+=0.0005; theWarship.image_yscale+=0.0005
      var tEffect;
      tEffect=instance_create(theWarship.x-14,theWarship.y+random_range(-8,8),oEffect)
      tEffect.sprite_index=sShipExplosion; tEffect.followID=-1; tEffect.xFollow=0; tEffect.yFollow=0
      tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0; tEffect.image_alpha=0.75
      tEffect.image_xscale=0.2; tEffect.image_yscale=0.2; tEffect.image_speed=0.2

      if sceneDelay=340 {playSound(global.snd_ShipMovement,0,1,1)}
      else if sceneDelay=390 {playSound(global.snd_ShipMovement,0,1,1)}
      else if sceneDelay=440 {playSound(global.snd_ShipMovement,0,1,1)}
      else if sceneDelay=490 {playSound(global.snd_ShipMovement,0,1,1)}
    }
    else if sceneDelay>=520 //Fade out music
    {
      if musicFade>=9000 {fadeAmt=20}
      else if musicFade>=7000 and musicFade<=8999 {fadeAmt=30}
      else {fadeAmt=50}
      musicFade-=fadeAmt
      fadeVolume(global.msc_IFB,fadeAmt)
      if musicFade<=5000
      {
        stopAllMusic()
        sceneDelay=0; sceneProgress+=1
      }
    }

    if backSoundLoop>0
    {
      backSoundLoop+=1
      if backSoundLoop=2 {playSound(global.snd_Bobomb,0,0.95,22050+random(9000))}
      else if backSoundLoop>=9 {backSoundLoop=1}
    }
  }
  else if sceneProgress=3
  {
    fadeAlpha+=0.02
    if fadeAlpha>=1 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=4
  {
    sceneDelay+=1
    if sceneDelay>=30
    {
      global.pLife=global.pMaxLife
      global.newMapX=192; global.newMapY=16
      room_goto(rLC_LowerPassage)
    }
  }
}
else if global.gameProgress=4470 and room=rLC_LowerPassage //----- [12] The Lower Caves -----
{
  if sceneProgress=0
  {
    if oPlayer1.x>=353
    {
      global.gamePaused=true
      oPlayer1.y+=4
      if oPlayer1.y>=384
      {
        scenePChk(353,384,0,0.1,1)
        stopPlayer()
        sceneProgress+=1
      }
    }
  }
  else if sceneProgress=1 and bWaitForInput=false
    msgCreate(0,0,"Jerry","So where is this? We fell really far.",0,3,oMessageCutscene,1)
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","We're in what's called the Lower Caves, but the world has it listed as the 'Lava Cave'. And yes, you guys fell super far.",0,3,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Jerry","What's that mean for us?",0,3,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","We're not stuck, we're never stuck. That said, I've got no clue how we're getting out of here. This place is buggy as all hell. That lava title is probably a bug as well.",0,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Jerry","What sort of bugs are there?",0,3,oMessageCutscene,1)
  else if sceneProgress=6 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Heck if I know, but I do know that Game Over of any kind has been disabled.",0,3,oMessageCutscene,1)
  else if sceneProgress=7 and bWaitForInput=false
    msgCreate(0,0,"Jerry","That's a bit 4th wall breaking there.",0,3,oMessageCutscene,1)
  else if sceneProgress=8 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","I'll be straight with you. If you lose here, all memory of your adventure is wiped. You will no longer exist. I'm not sure if you noticed, but pausing has also been removed.",0,3,oMessageCutscene,1)
  else if sceneProgress=9 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","It's a mess here. Fortunately, most of that is just this specific map, if you can find a way out, that would be great.",0,3,oMessageCutscene,1)
  else if sceneProgress=10 and bWaitForInput=false
    msgCreate(0,0,"Jerry","How would all these bugs even exist here?",0,3,oMessageCutscene,1)
  else if sceneProgress=11 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Remember the Distortion worlds? This is kinda like that. Things that the program can't safely delete, it throws down here.",0,3,oMessageCutscene,1)
  else if sceneProgress=12 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Wow... that sucks.",0,3,oMessageCutscene,1)
  else if sceneProgress=13 and bWaitForInput=false
    msgCreate(0,0,"Claire","Hey guys, even if we do get out of here, what are we going to do about that ship that took off? That thing was huge.",0,3,oMessageCutscene,1)
  else if sceneProgress=14 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","I don't know. I know Hex has removed any way of teleporting in and you know he has security measures set up that alert them of anything that gets close to the ship.",0,3,oMessageCutscene,1)
  else if sceneProgress=15 and bWaitForInput=false
    msgCreate(0,0,"Claire","And those robots, CHAOS has tons of those things!",0,3,oMessageCutscene,1)
  else if sceneProgress=16 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Had... My bomb should be going off any moment. They're gonna be pissed about that I'm sure.",0,3,oMessageCutscene,1)
  else if sceneProgress=17 and bWaitForInput=false
    msgCreate(0,0,"Claire","I just don't know how we're supposed to fight against a thing like that.",0,3,oMessageCutscene,1)
  else if sceneProgress=18 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","We should probably think about that after you guys get out of this place. It isn't good to stick around here.",0,3,oMessageCutscene,1)
  else if sceneProgress=19 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Okay, let's do this.",0,3,oMessageCutscene,1)
  else if sceneProgress=20
  {
    sceneDelay=0; sceneProgress=0
    global.gameProgress=4480
    global.gamePaused=false
  }
}
else if global.gameProgress=4480 and room=rLavaCaveC //----- [] Boss Fight: Giant Blargg -----
{
  if global.bossTrack=0
  {
    if oPlayer1.x>=448
    {
      var tBossTitle,tempMplay,boss,enemyBarrier;
      enemyBarrier=instance_create(144,48,oEnemyBarrier); enemyBarrier.image_yscale=20
      enemyBarrier=instance_create(736,48,oEnemyBarrier); enemyBarrier.image_yscale=20
      tBossTitle=instance_create(0,0,oBossNameDisplay)
      tBossTitle.bossName="Giant Blargg"
      tBossTitle.bossTitle="Made of lava"
      boss=instance_create(664,room_height+160,oGiantBlarg)
      boss.activateBoss=1
      tempMplay=findMusic(801)
      playMusic(tempMplay,0,0)
      boss.activateBoss=1
      global.currentBoss="Giant Blargg"
      global.bossTrack=1
      storeStatus(0)
    }
  }
  else if global.bossTrack=1
  {
    if sceneProgress=1 //End Boss
    {
      stopPlayer()
      global.gamePaused=true
      awardBossAP(8000)
      global.bossTrack=2
      sceneProgress=0
    }
  }
  else if global.bossTrack=2
  {
    if sceneProgress=0
    {
      var tFullHeartDrop,tempMplay;
      tFullHeartDrop=instance_create(448,128,oHealthPickup)
      tFullHeartDrop.sprite_index=sFullHealthPickup
      tempMplay=findMusic(0)
      playMusic(tempMplay,0,0)
      with oEnemyBarrier {instance_destroy()}
      global.gamePaused=false
      global.currentBoss=""
      global.bossTrack=0
      global.gameProgress=4490
    }
  }
}
else if room=rLavaCaveE //----- [] The Lava Geyser -----
{
  if global.gamePaused=false
  {
    if sceneProgress=0
    {
      if oPlayer1.x>=240
      {
        var newColl;
        newColl=instance_create(176,4032,oInvisibleSolid)
        newColl.image_yscale=6
        sceneProgress+=1
      }
    }
    else if sceneProgress=1
    {
      playSound(global.snd_Bobomb,0,0.95,1)
      playSound(global.snd_Fireball,0,1,1)
      oCh18GeyserPlat.yVel=-24
      oCh18LavaGeyser.yVel=-24
      sceneProgress+=1
    }
  }
}
else if global.gameProgress=4510 and room=rMain_71 //----- [13] Bubblin reveals a way to fight back -----
{
  if sceneProgress=0
  {
    if oPlayer1.x<=80 and oPlayer1.y>=480
    {
      global.gamePaused=true
      oPlayer1.y+=4
      if oPlayer1.y>=560
      {
        scenePChk(oPlayer1.x,560,0,0.1,-1)
        stopPlayer()
        sceneProgress+=1
      }
    }
  }
  else if sceneProgress=1 and bWaitForInput=false
    msgCreate(0,0,"Bubblun","Hold on you guys!",6,3,oMessageCutscene,1)
  else if sceneProgress=2
  {
    sceneDelay+=1
    if sceneDelay=1
    {
      npcBubblun=instance_create(160,336,oMisc)
      npcBubblun.type=0; npcBubblun.sprite_index=sBubblun_Idle
      npcBubblun.image_xscale=-1; npcBubblun.image_speed=0.1
    }
    else if sceneDelay>=2 and sceneDelay<=99
    {
      if sceneDelay=15 {oPlayer1.image_xscale=1}
      npcBubblun.y+=8
      if npcBubblun.y>=560
      {
        sceneDelay=100
      }
    }
    else if sceneDelay>=120 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Oh hey, what's up?",0,3,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Bubblun","The warship took off...",6,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Thank you Captain Obvious for pointing out our failure.",0,3,oMessageCutscene,1)
  else if sceneProgress=6 and bWaitForInput=false
    msgCreate(0,0,"Bubblun","I wasn't going to say that.",6,3,oMessageCutscene,1)
  else if sceneProgress=7 and bWaitForInput=false
    msgCreate(0,0,"Jerry","You're usually hating on us all the time.",0,3,oMessageCutscene,1)
  else if sceneProgress=8 and bWaitForInput=false
    msgCreate(0,0,"Chao","You guys, we don't have time for this. Bubblun, what did you want to tell us?",0,3,oMessageCutscene,1)
  else if sceneProgress=9 and bWaitForInput=false
    msgCreate(0,0,"Bubblun","Something I probably shouldn't do...",6,3,oMessageCutscene,1)
  else if sceneProgress=10 and bWaitForInput=false
    msgCreate(0,0,"Jerry","I'm intrigued now. What is it?",0,3,oMessageCutscene,1)
  else if sceneProgress=11 and bWaitForInput=false
    msgCreate(0,0,"Bubblun","The warship is too much for just you guys to take on. Even if you were able to fly to it, you'd be shot down instantly... Well, you're gonna need help.",6,3,oMessageCutscene,1)
  else if sceneProgress=12 and bWaitForInput=false
    msgCreate(0,0,"Bubblun","Don't make me regret this. The place I'm about to send you to... no humans are normally allowed there.",6,3,oMessageCutscene,1)
  else if sceneProgress=13 and bWaitForInput=false
    msgCreate(0,0,"Jerry","What happens if humans go there?",0,3,oMessageCutscene,1)
  else if sceneProgress=14 and bWaitForInput=false
    msgCreate(0,0,"Bubblun","They're simply kicked out. Only humans that have been invited by a bot, that lives there, may enter. I'm giving all of you permission to enter.",6,3,oMessageCutscene,1)
  else if sceneProgress=15 and bWaitForInput=false
    msgCreate(0,0,"Jerry","What is this place you're telling us about?",0,3,oMessageCutscene,1)
  else if sceneProgress=16 and bWaitForInput=false
    msgCreate(0,0,"Bubblun","I can't tell you, but I can point you in the right direction. If you head east from the Starry Skies - Windy Hills, that's just south of us, you can reach it.",6,3,oMessageCutscene,1)
  else if sceneProgress=17 and bWaitForInput=false
    msgCreate(0,0,"Bubblun","You can find help there, from myself included. The bots living there will surely help you fight against Hex when they know he's going to use that warship against both bots and humans.",6,3,oMessageCutscene,1)
  else if sceneProgress=18 and bWaitForInput=false
    msgCreate(0,0,"Jerry","So that's it, we can just enter?",0,3,oMessageCutscene,1)
  else if sceneProgress=19 and bWaitForInput=false
    msgCreate(0,0,"Bubblun","Well, you will have to pass through the 'Tranquil Serenity'.",6,3,oMessageCutscene,1)
  else if sceneProgress=20 and bWaitForInput=false
    msgCreate(0,0,"Jerry","That doesn't sound so bad.",0,3,oMessageCutscene,1)
  else if sceneProgress=21 and bWaitForInput=false
    msgCreate(0,0,"Bubblun","I can't say anything about it. But if you can pass through, you'll reach the bots that can help you.",6,3,oMessageCutscene,1)
  else if sceneProgress=22 and bWaitForInput=false
    msgCreate(0,0,"Bubblun","I have to go now. Remember, it's east of Starry Skies - Windy Hills.",6,3,oMessageCutscene,1)
  else if sceneProgress=23
  {
    sceneDelay+=1
    if sceneDelay=1
    {
      npcBubblun.sprite_index=sBubblun_Walk
    }
    else if sceneDelay>=2 and sceneDelay<=99
    {
      npcBubblun.x-=4
      if npcBubblun.x<oPlayer1.x-24 {oPlayer1.image_xscale=-1}
      if npcBubblun.x<=-24
      {
        sceneDelay=100
      }
    }
    else if sceneDelay>=120 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=24 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Do we go?",0,3,oMessageCutscene,1)
  else if sceneProgress=25 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Definitely. We have to find a way to bring down that ship. It's not just the Mainland that's in danger.",0,3,oMessageCutscene,1)
  else if sceneProgress=26 and bWaitForInput=false
    msgCreate(0,0,"Claire","I'm really curious about what this place is. And that Tranquil Serenity place we have to pass through.",0,3,oMessageCutscene,1)
  else if sceneProgress=27 and bWaitForInput=false
    msgCreate(0,0,"Jerry","We're gonna find out really soon I bet.",0,3,oMessageCutscene,1)
  else if sceneProgress=28 and bWaitForInput=false
    msgCreate(0,0,"Chao","Hey, should they head back to Central City first?",0,3,oMessageCutscene,1)
  else if sceneProgress=29 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Might be a good idea to head back and stock up on anything we might need. Maybe Syrus and Gene came back as well. I've got no idea where those two went.",0,3,oMessageCutscene,1)
  else if sceneProgress=30
  {
    with oMisc {instance_destroy()}
    sceneDelay=0; sceneProgress=0
    global.gameProgress=4520
    global.gamePaused=false
  }
}

keyWaitForInput()

if oKeyCodes.kCodePressed[11]=1 and global.gamePaused=true and sceneProgress>=1 //Cutscene skip
{
  if !instance_exists(oPauseMenu)
  {
    if global.gameProgress=4200 and room=rMain_61 //[1]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      fadeAlpha=0; sceneDelay=0
      sceneProgress=13
    }
    else if global.gameProgress=4220 and room=rMain_61 //[2]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      fadeAlpha=0; sceneDelay=0
      sceneProgress=3
    }
    else if global.gameProgress=4250 and room=rWepFacA //[3]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      fadeAlpha=0; sceneDelay=0
      sceneProgress=7
    }
    else if global.gameProgress=4270 and room=rWepFacE //[4]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      fadeAlpha=0; sceneDelay=0
      sceneProgress=3
    }
    else if global.gameProgress=4290 and room=rWepFacE //[5]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      fadeAlpha=0; sceneDelay=0
      sceneProgress=6
    }
    else if global.gameProgress=4300 and room=rWepFacH //[6]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      fadeAlpha=0; sceneDelay=0
      sceneProgress=14
    }
    else if global.gameProgress=4310 and room=rWepFacK //[7]
    {
      if global.bossTrack=0
      {
        bWaitForInput=false
        with oMessageCutscene {instance_destroy()}
        fadeAlpha=0; sceneDelay=0
        sceneProgress=7
      }
    }
    else if global.gameProgress=4320 and room=rWepFacL //[8]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      fadeAlpha=0; sceneDelay=0
      sceneProgress=8
    }
    else if global.gameProgress=4330 and room=rLowFacB //[9]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      fadeAlpha=0; sceneDelay=0
      sceneProgress=15
    }
    else if global.gameProgress=4390 and room=rLowFacG //[10]
    {
      if global.bossTrack=0
      {
        bWaitForInput=false
        with oMessageCutscene {instance_destroy()}
        fadeAlpha=0; sceneDelay=0
        sceneProgress=3
      }
    }
    else if global.gameProgress=4450 and room=rLowFacP //[11]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      fadeAlpha=0; sceneDelay=0
      sceneProgress=23
    }
    else if global.gameProgress=4470 and room=rLC_LowerPassage //[12]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      fadeAlpha=0; sceneDelay=0
      sceneProgress=20
    }
    else if global.gameProgress=4510 and room=rMain_71 //[13]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      fadeAlpha=0; sceneDelay=0
      sceneProgress=30
    }
  }
}

//----- Room specific events -----
if global.gamePaused=false
{
  if room=rMain_68
  {
    if tankEvent=0 //Spawn Tanks
    {
      if oPlayer1.x>=2720
      {
        var tNewEnemy,enemyBarrier;
        tNewEnemy=instance_create(2464,272,oCHAOS_Tank); tNewEnemy.bActive=1
        tNewEnemy=instance_create(2976,272,oCHAOS_Tank); tNewEnemy.bActive=1
        enemyBarrier=instance_create(384,80,oEnemyBarrier); enemyBarrier.image_yscale=12
        enemyBarrier=instance_create(4384,80,oEnemyBarrier); enemyBarrier.image_yscale=12
        enemyBarrier=instance_create(4496,80,oEnemyBarrier); enemyBarrier.image_yscale=12
        tankEvent=1
      }
    }
    else if tankEvent=1 //Player beats Tanks
    {
      if !instance_exists(oCHAOS_Tank)
      {
        with oEnemyBarrier {instance_destroy()}
        tankEvent=2
      }
    }
  }
  else if room=rMain_71 //Geyser push
  {
    if geyserProg=0
    {
      tEffect=instance_create(oPlayer1.x+random_range(-3,3),oPlayer1.y-4-random(4),oEffect)
      tEffect.sprite_index=sZeldaEnemyDie; tEffect.followID=-1; tEffect.image_speed=0.4
      tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=1+random(3)
      tEffect.image_xscale=choose(-1,1); tEffect.image_yscale=choose(-1,1)
      tEffect.image_blend=make_color_rgb(180,180+random(75),180)
      oPlayer1.yVel=-20

      geyserTime+=1
      if geyserTime>=20 {geyserTime=0; geyserProg=10}
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

if room=rLowFacM
{
  draw_set_alpha(0.5)
  draw_set_blend_mode(bm_add)
  draw_rectangle_color(256,160,2272,432,c_black,c_black,c_red,c_red,0)
  draw_set_blend_mode(bm_normal)
}
