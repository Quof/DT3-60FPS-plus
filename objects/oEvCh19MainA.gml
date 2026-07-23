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
backgroundSpin=0
serenityEntry=100

if room=rTS_A and global.gameProgress=4550
{
  fadeAlpha=1
  global.gamePaused=true
}
else if room=rHiddenVillage
{
  if global.newMapX=104 and global.newMapY=1216
  {
    serenityEntry=0
    fadeAlpha=1
  }
  if global.gameProgress=4710
  {
    serenityEntry=100
    fadeColor=c_black
    fadeAlpha=1
  }
}
else if room=rDiscoA or room=rDiscoB or room=rDiscoC
{
  invertTime=1000
  if global.gameProgress=4580 {fadeAlpha=1}
  if room=rDiscoC
  {
    var tNewMace,tDir;
    tDir=0
    for(i=0;i<8;i+=1)
    {
      tNewMace=instance_create(496,56,oMarioChainBall)
      tNewMace.dir=tDir
      tNewMace.swingSpeed=3
      tNewMace.chainLinks=4
      tNewMace.image_blend=c_black
      tDir+=360/8
    }
    tDir=30
    for(i=0;i<8;i+=1)
    {
      tNewMace=instance_create(624,48,oMarioChainBall)
      tNewMace.dir=tDir
      tNewMace.swingSpeed=-3
      tNewMace.chainLinks=4
      tNewMace.image_blend=c_black
      tDir+=360/8
    }
    tDir=0
    for(i=0;i<8;i+=1)
    {
      tNewMace=instance_create(624,336,oMarioChainBall)
      tNewMace.dir=tDir
      tNewMace.swingSpeed=3
      tNewMace.chainLinks=4
      tNewMace.image_blend=c_black
      tDir+=360/8
    }
    tDir=30
    for(i=0;i<8;i+=1)
    {
      tNewMace=instance_create(768,320,oMarioChainBall)
      tNewMace.dir=tDir
      tNewMace.swingSpeed=-3
      tNewMace.chainLinks=4
      tNewMace.image_blend=c_black
      tDir+=360/8
    }
    tDir=0
    for(i=0;i<8;i+=1)
    {
      tNewMace=instance_create(784,120,oMarioChainBall)
      tNewMace.dir=tDir
      tNewMace.swingSpeed=3
      tNewMace.chainLinks=4
      tNewMace.image_blend=c_black
      tDir+=360/8
    }
    tDir=0
    for(i=0;i<12;i+=1)
    {
      tNewMace=instance_create(1072,112,oMarioChainBall)
      tNewMace.dir=tDir
      tNewMace.swingSpeed=-4
      tNewMace.chainLinks=5
      tNewMace.image_blend=c_black
      tDir+=360/12
    }
    tDir=0
    for(i=0;i<16;i+=1)
    {
      tNewMace=instance_create(1904,224,oMarioChainBall)
      tNewMace.dir=tDir
      tNewMace.swingSpeed=4
      tNewMace.chainLinks=6
      tNewMace.image_blend=c_black
      tDir+=360/16
    }
  }
}
else if room=rDiscoD {backgroundSpin=1}
else if room=rDiscoH and global.gameProgress<=4660 {playerRunSpeed=7}
else if room=rDiscoI and global.gameProgress=4670
{
  global.hasShoes[1]=1
  kirbyFade=0
}
else if room=rMain_92 and global.gameProgress=4930
{
  fadeAlpha=1
  global.gamePaused=true
}
else if room=rHiddenVillage_Destroyed and global.gameProgress=4940
{
  if global.Ch19WIn=15
  {
    fadeColor=c_black
    fadeAlpha=1
    global.gamePaused=true
  }
}
else if room=rHiddenVillage_Destroyed and global.gameProgress>=4950
{
  fadeAlpha=0.2
  fadeColor=c_red
}
else if room=rMC_L //Jump player up
{
  jumpTime=0
  if global.gameProgress=5000 {jumpProg=0}
  else {jumpProg=10}
}

//----------------------------------- BACKGROUND SPIN -----------------------------------
if backgroundSpin=1
{
  backFollow[0]=instance_create(0,0,oBackSpriteRotate)
  backFollow[0].backSet=sEfEnergyRip; backFollow[0].image_xscale=5; backFollow[0].image_yscale=5
  backFollow[0].image_speed=0; backFollow[0].image_alpha=0.025; backFollow[0].rotateSpeed=0.5
  backFollow[0].xx=256; backFollow[0].yy=176
  backFollow[1]=instance_create(0,0,oBackSpriteRotate)
  backFollow[1].backSet=sEfEnergyRip; backFollow[1].image_xscale=5; backFollow[1].image_yscale=5
  backFollow[1].image_speed=0; backFollow[1].image_alpha=0.025; backFollow[1].rotateSpeed=-0.5
  backFollow[1].xx=256; backFollow[1].yy=176
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gameProgress=4520 and room=rMain_79 //----- [1] Intro to Highlands -----
{
  if sceneProgress=0
  {
    sceneDelay+=1
    if sceneDelay=1 {global.gamePaused=true}
    if sceneDelay>=20 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=1 and bWaitForInput=false
    msgCreate(0,0,"Jerry","This is that Tranquil Serenity place that Bubblun was talking about?",0,3,oMessageCutscene,1)
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Definitely not. That place is further ahead. It looks to be some cave of sorts, though of course, I can't see into it at all. Interesting enough, it has the same code signature that a lot of Gate 6 did.",0,3,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Jerry","What do you mean?",0,3,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","It was made by John.",0,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Oh, well then we know it'll be nonsensical garbage at least.",0,3,oMessageCutscene,1)
  else if sceneProgress=6 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","I'm pretty sure John wasn't the one that wrote all that. The bots obviously changed the script by then. And that place was strictly a test, who knows what this will be and why it was made.",0,3,oMessageCutscene,1)
  else if sceneProgress=7 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Well... yes. Oh yeah, I figured out what that place is that Bubblun was talking about.",0,3,oMessageCutscene,1)
  else if sceneProgress=8 and bWaitForInput=false
    msgCreate(0,0,"Claire","This'll be good.",0,3,oMessageCutscene,1)
  else if sceneProgress=9 and bWaitForInput=false
    msgCreate(0,0,"Jerry","It's a village of bots.",0,3,oMessageCutscene,1)
  else if sceneProgress=10 and bWaitForInput=false
    msgCreate(0,0,"Claire","We figured that out already.",0,3,oMessageCutscene,1)
  else if sceneProgress=11 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Shut up, cause I knew YOU would say that!",0,3,oMessageCutscene,1)
  else if sceneProgress=12 and bWaitForInput=false
    msgCreate(0,0,"Claire","That's adorable Jerry, it really is.",0,3,oMessageCutscene,1)
  else if sceneProgress=13
  {
    var tNewChapter;
    tNewChapter=instance_create(0,0,oChapterDisplay)
    tNewChapter.newChapter="Chapter 19#That Which can be Taken"
    sceneDelay=0; sceneProgress=0
    global.gameProgress=4530
    global.gamePaused=false
  }
}
else if global.gameProgress=4540 and room=rMain_84 //----- [2] Lovelun in front of the Tranquil Serenity -----
{
  if sceneProgress=0
  {
    if oPlayer1.x>=3664 and oPlayer1.y>=320
    {
      global.gamePaused=true
      oPlayer1.y+=4
      if oPlayer1.y>=480
      {
        scenePChk(oPlayer1.x,480,0,0.1,1)
        stopPlayer()
        sceneProgress+=1
      }
    }
  }
  else if sceneProgress=1 and bWaitForInput=false
    msgCreate(0,0,"Claire","Oh hey.",0,3,oMessageCutscene,1)
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"Lovelun","When you get to the other side, come find Bubby and myself. We'll try talking to some of the bots there before you reach it.",6,3,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Claire","Thanks.",0,3,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Lovelun","The bots there don't like CHAOS very much, but many do fear them. Whether or not they join in the fight depends on you.",6,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Well, we ARE awesome.",0,3,oMessageCutscene,1)
  else if sceneProgress=6 and bWaitForInput=false
    msgCreate(0,0,"Claire","I don't think that will work, Jerry.",0,3,oMessageCutscene,1)
  else if sceneProgress=7 and bWaitForInput=false
    msgCreate(0,0,"Jerry","We'll just have to show them.",0,3,oMessageCutscene,1)
  else if sceneProgress=8 and bWaitForInput=false
    msgCreate(0,0,"Lovelun","Some feat of strength may be necessary, but maybe not.",6,3,oMessageCutscene,1)
  else if sceneProgress=9 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","How... very video game like.",0,3,oMessageCutscene,1)
  else if sceneProgress=10 and bWaitForInput=false
    msgCreate(0,0,"Lovelun","Yes, but that's what you guys are good at. Show them that and they'll definitely follow you to fight CHAOS.",6,3,oMessageCutscene,1)
  else if sceneProgress=11 and bWaitForInput=false
    msgCreate(0,0,"Claire","I wonder what the test will be...",0,3,oMessageCutscene,1)
  else if sceneProgress=12 and bWaitForInput=false
    msgCreate(0,0,"Lovelun","Not even I know that, but for now, you have to reach the place. I'll see you there.",6,3,oMessageCutscene,1)
  else if sceneProgress=13
  {
    sceneDelay=0; sceneProgress=0
    global.gameProgress=4550
    global.gamePaused=false
  }
}
else if global.gameProgress=4550 and room=rTS_A //----- [] Intro to Tranquil Serenity -----
{
  if sceneProgress=0
  {
    sceneDelay+=1
    if sceneDelay>=50
    {
      if fadeAlpha>0.5 {fadeAlpha-=0.005}
      else {fadeAlpha-=0.01}
      if fadeAlpha<=0 {sceneDelay=0; sceneProgress+=1}
    }
  }
  else if sceneProgress=1
  {
    sceneDelay+=1
    if sceneDelay>=30
    {
      var tempMplay;
      tempMplay=findMusic(26)
      playMusic(tempMplay,0,0)
      sceneDelay=0; sceneProgress=0
      global.gameProgress=4560
      global.gamePaused=false
    }
  }
}
else if global.gameProgress=4560 and room=rHiddenVillage //----- [3] Intro to Hidden Bot Village -----
{
  if sceneProgress=0
  {
    sceneDelay+=1
    if sceneDelay=1 {global.gamePaused=true}
    if sceneDelay>=20
    {
      fadeAlpha-=0.025
      if fadeAlpha<=0 {sceneDelay=0; sceneProgress+=1}
    }
  }
  else if sceneProgress=1 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Huh...",0,3,oMessageCutscene,1)
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"Chao","I like that place.",0,3,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","I do too, reminds me of something when we were younger.",0,3,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Of what?",0,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Chao","We don't need to go into that.#Lovelun said to go find her, let's go.",0,3,oMessageCutscene,1)
  else if sceneProgress=6 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Just a heads up, some of the bots here won't speak to you, you know, you being human and all. This place is nifty though and bots will 'project' their thoughts. I'll see if I can interpret that and let you know what they're thinking.",0,3,oMessageCutscene,1)
  else if sceneProgress=7 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Odd, but cool.",0,3,oMessageCutscene,1)
  else if sceneProgress=8
  {
    fadeAlpha=0
    serenityEntry=100
    sceneDelay=0; sceneProgress=0
    var tempMplay;
    tempMplay=findMusic(27)
    playMusic(tempMplay,0,0)
    global.gameProgress=4570
    global.gamePaused=false
  }
}
else if global.gameProgress=4570 and room=rHiddenVillage //----- [4] What to do about CHAOS -----
{
  if sceneProgress=0
  {
    if oPlayer1.x>=2528 and oPlayer1.y<=312
    {
      global.gamePaused=true
      oPlayer1.y+=4
      if oPlayer1.y>=304
      {
        var tFlash;
        tFlash=instance_create(0,0,oScreenFlash); tFlash.fadeSpeed=0.2
        scenePChk(oPlayer1.x,304,0,0.1,1)
        stopPlayer()
        oPlayer1.visible=0
        charJerry=instance_create(2528,304,oMisc)
        charJerry.sprite_index=sJerryIdle; charJerry.image_speed=0.1; charJerry.type=2
        charClaire=instance_create(2496,304,oMisc)
        charClaire.sprite_index=sClaireIdle; charClaire.image_speed=0.1; charClaire.type=2
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
    msgCreate(0,0,"Bubblun","I'm glad you all made it here.",6,3,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","It didn't look too rough for these two on the way to this place. As for the bots here, it seems most of them want to fight against CHAOS.",0,3,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Bubblun","I won't lie, I was surprised to see them so willing to help despite most of us fearing CHAOS.",6,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Jerry","I was pretty sure we would have to go through some sort of trial or test to prove ourselves.",0,3,oMessageCutscene,1)
  else if sceneProgress=6 and bWaitForInput=false
    msgCreate(0,0,"Claire","I was thinking the same thing!",0,3,oMessageCutscene,1)
  else if sceneProgress=7 and bWaitForInput=false
    msgCreate(0,0,"Bubblun","That's... really odd to think that. You've already proven you're very capable plenty of times.",6,3,oMessageCutscene,1)
  else if sceneProgress=8 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Yes! That!",0,3,oMessageCutscene,1)
  else if sceneProgress=9 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","So... is there a plan to get to that ship?",0,3,oMessageCutscene,1)
  else if sceneProgress=10 and bWaitForInput=false
    msgCreate(0,0,"Bubblun","We've thought of a few here, but most of them seem to conclude with us being shot down way before we reach the ship.",6,3,oMessageCutscene,1)
  else if sceneProgress=11 and bWaitForInput=false
    msgCreate(0,0,"Lovelun","Bubby, they don't care about those ideas. Tell them the plan we DO have.",6,3,oMessageCutscene,1)
  else if sceneProgress=12 and bWaitForInput=false
    msgCreate(0,0,"Bubblun","Of course, Love! There is one way that you two can reach the place, but the bot that can help you isn't here and... well...",6,3,oMessageCutscene,1)
  else if sceneProgress=13 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","That bad?",0,3,oMessageCutscene,1)
  else if sceneProgress=14 and bWaitForInput=false
    msgCreate(0,0,"Bubblun","None of us have seen him for awhile, but we do know where he is. I'm pretty sure he'll help, but getting to him might be tricky.",6,3,oMessageCutscene,1)
  else if sceneProgress=15 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Okay seriously, who is it?!",0,3,oMessageCutscene,1)
  else if sceneProgress=16 and bWaitForInput=false
    msgCreate(0,0,"Bubblun","Kirby. He can get you up there.",6,3,oMessageCutscene,1)
  else if sceneProgress=17 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","How in the hell?",0,3,oMessageCutscene,1)
  else if sceneProgress=18 and bWaitForInput=false
    msgCreate(0,0,"Bubblun","Kirby can use the Dragoon if it is fully assembled to get you to the warship.",6,3,oMessageCutscene,1)
  else if sceneProgress=19 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","That'll actually work?",0,3,oMessageCutscene,1)
  else if sceneProgress=20 and bWaitForInput=false
    msgCreate(0,0,"Bubblun","Of course it'll work, the problems we have are getting to Kirby and getting the three pieces of the Dragoon. Luckily Kirby already has one with him, that we know of anyway.",6,3,oMessageCutscene,1)
  else if sceneProgress=21 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Okay, so the first thing we need to do is find Kirby, and then have him help us.",0,3,oMessageCutscene,1)
  else if sceneProgress=22 and bWaitForInput=false
    msgCreate(0,0,"Bubblun","Yes, and of the other two pieces, we know the location of one. I will try my best to figure out where the other is while you're finding Kirby.",6,3,oMessageCutscene,1)
  else if sceneProgress=23 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","On that note, where IS Kirby?",0,3,oMessageCutscene,1)
  else if sceneProgress=24 and bWaitForInput=false
    msgCreate(0,0,"Bubblun","In the south-west most part of the Barrens. Kirby has kept himself in a place that almost no one else will ever go to. I think he initially went there to hide from the Virus to keep from being infected.",6,3,oMessageCutscene,1)
  else if sceneProgress=25 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Someone needs to update him on things.",0,3,oMessageCutscene,1)
  else if sceneProgress=26 and bWaitForInput=false
    msgCreate(0,0,"Bubblun","I'm very sure he has no idea that the Virus has been destroyed. Given the place he's in, it's very hard to see the outside world from it.",6,3,oMessageCutscene,1)
  else if sceneProgress=27 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","He does know of CHAOS, right? I only ask because we will also have to convince him to help us.",0,3,oMessageCutscene,1)
  else if sceneProgress=28 and bWaitForInput=false
    msgCreate(0,0,"Bubblun","He... should listen to you. He doesn't like CHAOS any more than we do. Though Kirby isn't the most sane bot out there. He doesn't hate humans, but he usually won't talk to them.",6,3,oMessageCutscene,1)
  else if sceneProgress=29 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Well that might make things difficult.",0,3,oMessageCutscene,1)
  else if sceneProgress=30 and bWaitForInput=false
    msgCreate(0,0,"Bubblun","You don't have much of a choice. I can't think of anything else that will get you safely to the warship. We could get help from elsewhere, maybe outside of the mainland, but that will take too long.",6,3,oMessageCutscene,1)
  else if sceneProgress=31 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Well then, let's do this you guys.",0,3,oMessageCutscene,1)
  else if sceneProgress=32 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Great, we're going to visit a psycho bot that can copy any ability. Let's do it.",0,3,oMessageCutscene,1)
  else if sceneProgress=33
  {
    var tFlash;
    tFlash=instance_create(0,0,oScreenFlash); tFlash.fadeSpeed=0.2
    with oMisc {instance_destroy()}
    oPlayer1.visible=1
    sceneDelay=0; sceneProgress=0
    global.gameProgress=4580
    global.gamePaused=false
  }
}
else if global.gameProgress=4580 and room=rDiscoA //----- [5] Intro to The Discombobulated -----
{
  if sceneProgress=0
  {
    sceneDelay+=1
    if sceneDelay=1 {global.gamePaused=true}
    else if sceneDelay>=31 and sceneDelay<=70 {fadeAlpha-=0.025}
    if sceneDelay>=80 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=1 and bWaitForInput=false
    msgCreate(0,0,"Jerry","This again?!",0,3,oMessageCutscene,1)
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Good news, I can even kinda do what I did in Primary Memory.",0,3,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Jerry","You probably won't need to though. Is there anything threatening in here?",0,3,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","I see a few bots in here that might be hostile. They seem to be bugging out though, like, their actual sprites aren't displaying properly.",0,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Jerry","So would you be able to give us infinite... everything?",0,3,oMessageCutscene,1)
  else if sceneProgress=6 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Maybe. I can edit quite a few things here, but give me a bit. It's not quite as open as Primary Memory was.",0,3,oMessageCutscene,1)
  else if sceneProgress=7 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Sweet.",0,3,oMessageCutscene,1)
  else if sceneProgress=8
  {
    fadeAlpha=0
    sceneDelay=0; sceneProgress=0
    global.gameProgress=4590
    global.gamePaused=false
  }
}
else if global.gameProgress=4610 and room=rDiscoD //----- [6] Hex shows up -----
{
  if sceneProgress=0
  {
    if oPlayer1.x>=288
    {
      global.gamePaused=true
      oPlayer1.y+=4
      if oPlayer1.y>=288
      {
        scenePChk(oPlayer1.x,288,0,0.1,1)
        stopPlayer()
        sceneProgress+=1
      }
    }
  }
  else if sceneProgress=1
  {
    sceneDelay+=1
    if sceneDelay=10
    {
      var tempMplay;
      tempMplay=findMusic(1001)
      playMusic(tempMplay,0,0)
    }
    if sceneDelay>=20 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"Jerry","What the hell? Really?",0,3,oMessageCutscene,1)
  else if sceneProgress=3
  {
    sceneDelay+=1
    if sceneDelay=20 {(399156).image_xscale=-1;}
    if sceneDelay>=40 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Hex","So you did survive the take off, and I was really hoping to be done with you.",0,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","What are you doing here?",0,3,oMessageCutscene,1)
  else if sceneProgress=6 and bWaitForInput=false
    msgCreate(0,0,"Hex","The Warmaster informed me that a troublesome bot was here... wait...",0,3,oMessageCutscene,1)
  else if sceneProgress=7 and bWaitForInput=false
    msgCreate(0,0,"Hex","Ah, I know why you're here! You know, I was going to let Kirby live, the Warmaster said he'd like to keep him around. However, I'm pretty pissed off that you destroyed my robot army in the facility.",0,3,oMessageCutscene,1)
  else if sceneProgress=8 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Well, you know what they say about that.",0,3,oMessageCutscene,1)
  else if sceneProgress=9 and bWaitForInput=false
    msgCreate(0,0,"Hex","I do not, and I don't care to hear it. My CHAOS army will find Kirby before you do, I can ensure you of that!",0,3,oMessageCutscene,1)
  else if sceneProgress=10
  {
    sceneDelay+=1
    if sceneDelay>=10 {(399156).x+=6}
    if sceneDelay>=40 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=11 and bWaitForInput=false
    msgCreate(0,0,"Hex","Jeremy may be able to assist you again, but this time, it won't be enough. You don't have the Shrouds nor do you have X to back you up. Have fun dying!",0,3,oMessageCutscene,1)
  else if sceneProgress=12 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Damn, he's kinda right. There's not as much I can edit here.",0,3,oMessageCutscene,1)
  else if sceneProgress=13 and bWaitForInput=false
    msgCreate(0,0,"Claire","We still have to try!",0,3,oMessageCutscene,1)
  else if sceneProgress=14
  {
    with (399156) {instance_destroy()}
    sceneDelay=0; sceneProgress=0
    global.gameProgress=4620
    global.gamePaused=false
  }
}
else if room=rDiscoE //----- [] Message boxes help us through -----
{
  if global.gamePaused=false
  {
    if sceneProgress=0
    {
      sceneDelay+=1
      if sceneDelay=70 {msgCreate(192,1472,"Jeremy","Huh, is this a dead end? Hmm... you can go up, but how...?",0,1,oMessageCollision,0)}
      else if sceneDelay=160 {msgCreate(240,1512,"Jerry","Can you like... make platforms appear or something?",0,1,oMessageCollision,0)}
      else if sceneDelay=250 {msgCreate(192,1552,"Jeremy","Maybe, I'll see what I can do and... why the hell aren't these disappearing?",0,2,oMessageCollision,0)}
      else if sceneDelay>=251
      {
        if oPlayer1.y<=1440 {sceneDelay=0; sceneProgress+=1}
      }
    }
    else if sceneProgress=1
    {
      sceneDelay+=1
      if sceneDelay=30 {msgCreate(272,1328,"Jeremy","Oh, well look at that...",0,0,oMessageCollision,0)}
      if sceneDelay=110 {msgCreate(448,1264,"Jerry","That's pretty awesome.",0,0,oMessageCollision,0)}
      else if sceneDelay>=111
      {
        if oPlayer1.y<=1256 {sceneDelay=0; sceneProgress+=1}
      }
    }
    else if sceneProgress=2
    {
      sceneDelay+=1
      if sceneDelay=30 {msgCreate(224,1200,"Jeremy","I'm not even sure how this works.",0,1,oMessageCollision,0)}
      if sceneDelay=120 {msgCreate(48,1136,"Jerry","Just keep talking!",0,1,oMessageCollision,0)}
      if sceneDelay=190 {msgCreate(304,1072,"Jeremy","...",0,0,oMessageCollision,0)}
      if sceneDelay=260 {msgCreate(480,1008,"Jerry","That works too.",0,1,oMessageCollision,0)}
      else if sceneDelay>=261
      {
        if oPlayer1.y<=904 {sceneDelay=0; sceneProgress+=1}
      }
    }
    else if sceneProgress=3
    {
      sceneDelay+=1
      if sceneDelay=80 {msgCreate(400,864,"Jerry","Jeremy, why aren't you saying anything?",0,1,oMessageCollision,0)}
      else if sceneDelay=170 {msgCreate(240,784,"Jeremy","You could always talk.",0,0,oMessageCollision,0)}
      else if sceneDelay=250 {msgCreate(112,720,"Jerry","I'd rather you do it.",0,0,oMessageCollision,0)}
      else if sceneDelay=330 {msgCreate(352,656,"Jeremy","Nah, it's better if you talk.",0,1,oMessageCollision,0)}
      else if sceneDelay>=331
      {
        if oPlayer1.y<=672 {sceneDelay=0; sceneProgress+=1}
      }
    }
    else if sceneProgress=4
    {
      sceneDelay+=1
      if sceneDelay=10
      {
        msgCreate(1,368,"Chao","Bunnies!!",0,0,oMessageCollision,0)
        msgCreate(528,368,"Chao","Bunnies!!",0,0,oMessageCollision,0)
      }
      else if sceneDelay=15
      {
        msgCreate(1,400,"Chao","Bunnies!!",0,0,oMessageCollision,0)
        msgCreate(528,400,"Chao","Bunnies!!",0,0,oMessageCollision,0)
      }
      else if sceneDelay=20
      {
        msgCreate(1,432,"Chao","Bunnies!!",0,0,oMessageCollision,0)
        msgCreate(528,432,"Chao","Bunnies!!",0,0,oMessageCollision,0)
      }
      else if sceneDelay=25
      {
        msgCreate(1,464,"Chao","Bunnies!!",0,0,oMessageCollision,0)
        msgCreate(528,464,"Chao","Bunnies!!",0,0,oMessageCollision,0)
      }
      else if sceneDelay=30
      {
        msgCreate(1,496,"Chao","Bunnies!!",0,0,oMessageCollision,0)
        msgCreate(528,496,"Chao","Bunnies!!",0,0,oMessageCollision,0)
      }
      else if sceneDelay=35
      {
        msgCreate(1,528,"Chao","Bunnies!!",0,0,oMessageCollision,0)
        msgCreate(528,528,"Chao","Bunnies!!",0,0,oMessageCollision,0)
      }
      else if sceneDelay=40
      {
        msgCreate(1,560,"Chao","Bunnies!!",0,0,oMessageCollision,0)
        msgCreate(528,560,"Chao","Bunnies!!",0,0,oMessageCollision,0)
      }
      else if sceneDelay=45
      {
        msgCreate(1,592,"Chao","Bunnies!!",0,0,oMessageCollision,0)
        msgCreate(528,592,"Chao","Bunnies!!",0,0,oMessageCollision,0)
      }
      else if sceneDelay=50
      {
        msgCreate(1,624,"Chao","Bunnies!!",0,0,oMessageCollision,0)
        msgCreate(528,624,"Chao","Bunnies!!",0,0,oMessageCollision,0)
      }
      else if sceneDelay=110 {msgCreate(1,560,"Claire","That was awesome, Chao!",0,3,oMessageCollision,0)}
      else if sceneDelay>=111
      {
        if oPlayer1.y<=568 {sceneDelay=0; sceneProgress+=1}
      }
    }
    else if sceneProgress=5
    {
      sceneDelay+=1
      if sceneDelay=20 {msgCreate(352,496,"Jerry","Wow Claire, way to use a bigger message box than needed.",0,1,oMessageCollision,0)}
      else if sceneDelay>=21
      {
        if oPlayer1.y<=504 {sceneDelay=0; sceneProgress+=1}
      }
    }
    else if sceneProgress=6
    {
      sceneDelay+=1
      if sceneDelay=30 {msgCreate(96,416,"Claire","...",0,0,oMessageCollision,0)}
      else if sceneDelay>=31
      {
        if oPlayer1.y<=376 {sceneDelay=0; sceneProgress+=1}
      }
    }
    else if sceneProgress=7
    {
      sceneDelay+=1
      if sceneDelay=20 {msgCreate(188,288,"Jerry","See, all you need to do.",0,3,oMessageCollision,0)}
      else if sceneDelay=90 {msgCreate(240,320,"Jerry","Oh what?",0,0,oMessageCollision,0)}
      else if sceneDelay=140 {msgCreate(80,208,"Claire","Thanks, Jeremy.",0,0,oMessageCollision,0)}
      else if sceneDelay=200 {msgCreate(304,144,"Jeremy","No problem.",0,0,oMessageCollision,0)}
    }
  }
}
else if global.gameProgress=4635 and room=rDiscoF //----- [7] We need to hurry -----
{
  if sceneProgress=0
  {
    sceneDelay+=1
    if sceneDelay=1 {global.gamePaused=true}
    if sceneDelay>=20 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=1 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","We should probably hurry. I've gotten your run speed increased, let's use this to hopefully get a lead.",0,3,oMessageCutscene,1)
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"Claire","You two have done this before, haven't you?",0,3,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Yep, hey couldn't you see what we were doing there?",0,3,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Claire","I just knew where you were at the time.",0,3,oMessageCutscene,1)
  else if sceneProgress=5
  {
    sceneDelay=0; sceneProgress=0
    global.gameProgress=4640
    global.gamePaused=false
  }
}
else if room=rDiscoH //----- [8] No more buffs / Time till Hex finds Kirby -----
{
  if global.gameProgress=4650
  {
    if sceneProgress=0
    {
      sceneDelay+=1
      if sceneDelay=1 {global.gamePaused=true}
      if sceneDelay>=20 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=1 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","Damn it! I think Hex figured out how to lock out my hacks.",0,3,oMessageCutscene,1)
    else if sceneProgress=2 and bWaitForInput=false
      msgCreate(0,0,"Claire","We don't need them anyway.",0,3,oMessageCutscene,1)
    else if sceneProgress=3 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","It's just annoying, but at least I know where Kirby and Hex are.",0,3,oMessageCutscene,1)
    else if sceneProgress=4 and bWaitForInput=false
      msgCreate(0,0,"Jerry","Oh what, really? Lead the way!",0,3,oMessageCutscene,1)
    else if sceneProgress=5 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","We don't have much time, Hex will close in on Kirby in about 45 seconds.",0,3,oMessageCutscene,1)
    else if sceneProgress=6
    {
      global.forceTime=1260
      var tTimer;
      tTimer=instance_create(412,8,oScreenTimer)
      tTimer.type=3; tTimer.mainColor=c_white; tTimer.shadowColor=c_black
      sceneDelay=0; sceneProgress=0
      global.gameProgress=4660
      global.gamePaused=false
    }
  }
  else if global.gameProgress=4660
  {
    if sceneProgress=0
    {
      if global.forceTime<=420
      {
        msgCreate(0,0,"Jerry","Eh... Jeremy, we're almost out of time! Can you speed us up?!",0,1,oMessagePerson,0)
        newMessage.fadingTime=100
        sceneProgress+=1
      }
    }
    else if sceneProgress=1
    {
      if global.forceTime<=320
      {
        msgCreate(0,0,"Jeremy","Trying!!",0,0,oMessagePerson,0)
        newMessage.fadingTime=60
        sceneProgress+=1
      }
    }
    else if sceneProgress=2
    {
      if global.forceTime<=0
      {
        with oScreenTimer {instance_destroy()}
        sceneProgress+=1
      }
    }
  }
}
else if room=rDiscoI //----- [] Boss Fight: Defective -----
{
  if global.gameProgress=4670 //Kirby dies
  {
    if sceneProgress=0
    {
      if oPlayer1.x>=712
      {
        if global.activeCharacter=0
        {
          msgCreate(0,0,"Jerry","Kirby, behind you!",0,1,oMessagePerson,0)
          newMessage.fadingTime=30
          oPlayer1.sprite_index=sJerryWalk
        }
        else if global.activeCharacter=1
        {
          msgCreate(0,0,"Claire","Look out Kirby!",0,1,oMessagePerson,0)
          newMessage.fadingTime=30
          oPlayer1.sprite_index=sClaireWalk
        }
        oPlayer1.image_xscale=1; oPlayer1.image_speed=0.33
        global.gamePaused=true
        sceneProgress+=1
      }
    }
    else if sceneProgress=1
    {
      oPlayer1.x+=4
      if oPlayer1.x>=816 {(401983).x-=7; (401983).y+=7}
      if oPlayer1.x>=832
      {
        var tempMplay;
        tempMplay=findMusic(0)
        playMusic(tempMplay,0,0)
        (401981).sprite_index=sNPC_Kirby_Die
        oPlayer1.image_speed=0.05
        sceneProgress+=1
      }
    }
    else if sceneProgress=2
    {
      oPlayer1.x+=0.5
      if oPlayer1.x>=856
      {
        playSound(global.snd_FadeAway,0,0.92,1)
        kirbyFade=1; sceneProgress+=1
      }
    }
    else if sceneProgress=3
    {
      oPlayer1.x+=0.5
      if oPlayer1.x>=884
      {
        if global.activeCharacter=0 {oPlayer1.sprite_index=sJerryDuck}
        else if global.activeCharacter=1 {oPlayer1.sprite_index=sClaireDuck}
        sceneProgress+=1
      }
    }
    else if sceneProgress=4
    {
      sceneDelay+=1
      if sceneDelay=60
      {
        if global.activeCharacter=0
        {
          msgCreate(0,0,"Jerry","What the hell... why?",0,1,oMessagePerson,0)
          newMessage.fadingTime=80
        }
        else if global.activeCharacter=1
        {
          msgCreate(0,0,"Claire","You're a monster!",0,1,oMessagePerson,0)
          newMessage.fadingTime=80
        }
      }
      else if sceneDelay>=120 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=5
    {
      (401982).x+=10
      sceneDelay+=1
      if sceneDelay>=30
      {
        with (401981) {instance_destroy()}
        with (401982) {instance_destroy()}
        with (401983) {instance_destroy()}
        charSwitcher(global.activeCharacter)
        global.newMapX=884
        global.hasShoes[1]=2
        oPlayer1.dashEnergy=10000
        global.gamePaused=false
        sceneDelay=0; sceneProgress=0
        global.gameProgress=4680
      }
    }

    if kirbyFade>0 and kirbyFade<100 //Fade Kirby away
    {
      kirbyFade+=1
      var tFFScl,tEffect;
      tFFScl=random(0.1)
      tEffect=instance_create((401981).x+random_range(-8,8),(401981).y-1-random(14),oEffectB)
      tEffect.type=3; tEffect.sprite_index=sEfFirefly; tEffect.newBlend=1
      tEffect.image_alpha=0.3; tEffect.image_xscale=0.15+tFFScl; tEffect.image_yscale=0.15+tFFScl
      tEffect.direction=random_range(70,110); tEffect.speed=random(1)+1; tEffect.friction=random(0.02)+0.02
      tEffect.fadeSpd=0.005; tEffect.image_blend=make_color_rgb(random(50),random(50),255)
      tEffect.AccelX=0; tEffect.AccelY=0; tEffect.followID=-1; tEffect.rotation=0
      (401981).image_alpha-=0.02
      (401983).image_alpha-=0.02
      if kirbyFade>=52 {kirbyFade=1000}
    }
  }
  else if global.gameProgress=4680 //Boss fight
  {
    if global.bossTrack=0
    {
      if global.gamePaused=false
      {
        if sceneProgress=0
        {
          sceneDelay+=1
          if sceneDelay=1
          {
            var enemyBarrier;
            enemyBarrier=instance_create(576,0,oEnemyBarrier); enemyBarrier.image_yscale=16; enemyBarrier.image_blend=c_dkgray
            enemyBarrier=instance_create(1136,0,oEnemyBarrier); enemyBarrier.image_yscale=16; enemyBarrier.image_blend=c_dkgray
          }
          else if sceneDelay=90
          {
            boss=instance_create(992,128,oDefective)
            boss.image_alpha=0; boss.bCanDealDamage=0; boss.bCanTakeDamage=0
          }
          else if sceneDelay>=91 and sceneDelay<=110 {boss.image_alpha+=0.05}
          else if sceneDelay=140
          {
            boss.bCanDealDamage=1; boss.bCanTakeDamage=1; boss.activateBoss=1
            var tBossTitle,tempMplay;
            tBossTitle=instance_create(0,0,oBossNameDisplay)
            tBossTitle.bossName="Defective"
            tBossTitle.bossTitle=". . ."
            tempMplay=findMusic(826)
            playMusic(tempMplay,0,0)
            global.currentBoss="Defective"
            global.bossTrack=1
            storeStatus(0)
            sceneDelay=0; sceneProgress=0
          }
        }
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
        tempMplay=findMusic(0)
        playMusic(tempMplay,0,0)
        with oEnemyBarrier {instance_destroy()}
        abilSetRemove(0)
        global.gamePaused=false
        global.currentBoss=""
        global.bossTrack=0
        global.gameProgress=4690
      }
    }
  }
  else if global.gameProgress=4690 //Go forward to the Dragoon Piece
  {
    if sceneProgress=0
    {
      var enemyBarrier;
      enemyBarrier=instance_create(576,0,oEnemyBarrier); enemyBarrier.image_yscale=16; enemyBarrier.image_blend=c_dkgray
      sceneProgress+=1
    }
    else if sceneProgress=1
    {
      if oPlayer1.x>=1632
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
    else if sceneProgress=2
    {
      sceneDelay+=1
      if sceneDelay>=20 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=3 and bWaitForInput=false
      msgCreate(0,0,"Jerry","It feels wrong even taking this.",0,3,oMessageCutscene,1)
    else if sceneProgress=4 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","I know, but we need it.",0,3,oMessageCutscene,1)
    else if sceneProgress=5 and bWaitForInput=false
      msgCreate(0,0,"Jerry","And what should we do after this?",0,3,oMessageCutscene,1)
    else if sceneProgress=6 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","Let's go back to Bubblun. He probably knows where another piece is.",0,3,oMessageCutscene,1)
    else if sceneProgress=7
    {
      sceneDelay=0; sceneProgress=0
      global.gameProgress=4700
      global.gamePaused=false
    }
  }
  else if global.gameProgress=4700 //Take the Dragoon Piece
  {
    if sceneProgress=0 and !instance_exists(oStoryObject)
    {
      global.gameProgress=4710
    }
  }
  else if global.gameProgress>=4710 //Spawn portal
  {
    if sceneProgress=0
    {
      var myExit;
      myExit=instance_create(1808,256,oExit)
      myExit.sprite_index=sWarpGateStand; myExit.bShowArrow=false; myExit.exitType=0
      myExit.newMapX=208; myExit.newMapY=288; myExit.toRoom=rDiscoA
      sceneProgress+=1
    }
  }
}
else if room=rHiddenVillage //----- [10] The next piece of the Dragoon -----
{
  if global.gameProgress=4710
  {
    if sceneProgress=0
    {
      sceneDelay+=1
      if sceneDelay=1
      {
        var tempMplay;
        tempMplay=findMusic(0)
        playMusic(tempMplay,0,0)
        global.gamePaused=true
        global.newMapX=2528; global.newMapY=304
        oPlayer1.x=2528; oPlayer1.y=304
        stopPlayer()
        oPlayer1.visible=0
        charJerry=instance_create(2528,304,oMisc)
        charJerry.sprite_index=sJerryIdle; charJerry.image_speed=0.1; charJerry.type=2
        charClaire=instance_create(2496,304,oMisc)
        charClaire.sprite_index=sClaireIdle; charClaire.image_speed=0.1; charClaire.type=2
      }
      else if sceneDelay>=40 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=1 and bWaitForInput=false
      msgCreate(0,0,"","Bubblun and Lovelun were informed of what took place within the Discombobulated.",6,3,oMessageCutscene,1)
    else if sceneProgress=2
    {
      sceneDelay+=1
      if sceneDelay>=31 and sceneDelay<=55 {fadeAlpha-=0.04}
      else if sceneDelay>=80 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=3 and bWaitForInput=false
      msgCreate(0,0,"Chao","We're really sorry you guys.",0,3,oMessageCutscene,1)
    else if sceneProgress=4 and bWaitForInput=false
      msgCreate(0,0,"Bubblun","...",6,3,oMessageCutscene,1)
    else if sceneProgress=5 and bWaitForInput=false
      msgCreate(0,0,"Jerry","You going to be okay?",0,3,oMessageCutscene,1)
    else if sceneProgress=6 and bWaitForInput=false
      msgCreate(0,0,"Bubblun","...Yes, I know where another piece of the Dragoon is.",6,3,oMessageCutscene,1)
    else if sceneProgress=7 and bWaitForInput=false
      msgCreate(0,0,"Lovelun","Bubby!",6,3,oMessageCutscene,1)
    else if sceneProgress=8 and bWaitForInput=false
      msgCreate(0,0,"Bubblun","I know Love, but what happened to Kirby will happen to others if we don't do something.",6,3,oMessageCutscene,1)
    else if sceneProgress=9
    {
      sceneDelay+=1
      if sceneDelay=20 {(396259).image_xscale=1}
      else if sceneDelay>=40 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=10 and bWaitForInput=false
      msgCreate(0,0,"Bubblun","I'm not happy about this either, Love, but I don't want to lose any other friends.",6,3,oMessageCutscene,1)
    else if sceneProgress=11
    {
      sceneDelay+=1
      if sceneDelay=20 {(396259).image_xscale=-1}
      else if sceneDelay>=40 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=12 and bWaitForInput=false
      msgCreate(0,0,"Bubblun","For now, we need those 3 Dragoon pieces.",6,3,oMessageCutscene,1)
    else if sceneProgress=13 and bWaitForInput=false
      msgCreate(0,0,"Jerry","Can we pilot the thing?",0,3,oMessageCutscene,1)
    else if sceneProgress=14 and bWaitForInput=false
      msgCreate(0,0,"Bubblun","Of course! ... I mean, I'm very sure you can.",6,3,oMessageCutscene,1)
    else if sceneProgress=15 and bWaitForInput=false
      msgCreate(0,0,"Lovelun","Of course they can, Bubby.",0,3,oMessageCutscene,1)
    else if sceneProgress=16 and bWaitForInput=false
      msgCreate(0,0,"Jerry","Then it's Claire that'll be piloting it. I already know what's going to happen when we get on that thing.",0,3,oMessageCutscene,1)
    else if sceneProgress=17 and bWaitForInput=false
      msgCreate(0,0,"Claire","Where is this other piece?",0,3,oMessageCutscene,1)
    else if sceneProgress=18 and bWaitForInput=false
      msgCreate(0,0,"Bubblun","In the southern area of the Farreaches. There's an old temple there that houses it.",6,3,oMessageCutscene,1)
    else if sceneProgress=19 and bWaitForInput=false
      msgCreate(0,0,"Jerry","Ooh, we get to go spelunking!",0,3,oMessageCutscene,1)
    else if sceneProgress=20 and bWaitForInput=false
      msgCreate(0,0,"Bubblun","Yes, and I'm very sure it's a trap infestation. Not a lot of bots travel there. Humans definitely don't, at least that I've heard of. I'm pretty sure its been abandoned since the program's creation.",6,3,oMessageCutscene,1)
    else if sceneProgress=21 and bWaitForInput=false
      msgCreate(0,0,"Jerry","This is gonna be good.",0,3,oMessageCutscene,1)
    else if sceneProgress=22 and bWaitForInput=false
      msgCreate(0,0,"Bubblun","Before you go, I'd like to ask that you not tell any of the other bots here what happened to Kirby.",6,3,oMessageCutscene,1)
    else if sceneProgress=23 and bWaitForInput=false
      msgCreate(0,0,"Claire","Why?",0,3,oMessageCutscene,1)
    else if sceneProgress=24 and bWaitForInput=false
      msgCreate(0,0,"Bubblun","I don't want them to worry. Some of them might get very angry and may try to take on CHAOS by themselves. Just please don't tell them.",6,3,oMessageCutscene,1)
    else if sceneProgress=25 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","We'll keep quiet.",0,3,oMessageCutscene,1)
    else if sceneProgress=26
    {
      var tFlash;
      tFlash=instance_create(0,0,oScreenFlash); tFlash.fadeSpeed=0.2
      with oMisc {instance_destroy()}
      oPlayer1.visible=1
      var tempMplay;
      tempMplay=findMusic(27)
      playMusic(tempMplay,0,0)
      sceneDelay=0; sceneProgress=0
      global.gameProgress=4720
      global.gamePaused=false
    }
  }
}
else if room=rMain_92 //----- [11] Back to the Hidden Village -----
{
  if global.gameProgress=4930
  {
    if sceneProgress=0
    {
      sceneDelay+=1
      if sceneDelay=1
      {
        var tempMplay;
        tempMplay=findMusic(0)
        playMusic(tempMplay,0,0)
        global.gamePaused=true
        global.newMapX=216; global.newMapY=304
        oPlayer1.x=216; oPlayer1.y=304
        stopPlayer()
        oPlayer1.visible=0
        charJerry=instance_create(216,304,oMisc)
        charJerry.sprite_index=sJerrySit; charJerry.image_speed=0; charJerry.type=2; charJerry.image_xscale=-1
        charClaire=instance_create(168,304,oMisc)
        charClaire.sprite_index=sClaireSitUp; charClaire.image_speed=0; charClaire.image_index=2; charClaire.type=2
      }
      else if sceneDelay>=50 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=1
    {
      sceneDelay+=1
      if sceneDelay>=1 and sceneDelay<=50 {fadeAlpha-=0.02}
      else if sceneDelay>=70 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=2 and bWaitForInput=false
      msgCreate(0,0,"Jerry","Sooo, here we are!",0,3,oMessageCutscene,1)
    else if sceneProgress=3 and bWaitForInput=false
      msgCreate(0,0,"Claire","The Warmaster did say we could end up anywhere. And hey! We got out and we have the second piece of the Dragoon!",0,3,oMessageCutscene,1)
    else if sceneProgress=4 and bWaitForInput=false
      msgCreate(0,0,"Jerry","That's a win there! So Jeremy, should we head to the Hidden Village to see where that last piece is?",0,3,oMessageCutscene,1)
    else if sceneProgress=5
    {
      sceneDelay+=1
      if sceneDelay=25 {showEmote(charJerry,0,-32,sEmQuestion)}
      else if sceneDelay>=50 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=6 and bWaitForInput=false
      msgCreate(0,0,"Jerry","Wait a minute, we're not still in that place, are we?",0,3,oMessageCutscene,1)
    else if sceneProgress=7 and bWaitForInput=false
    {
      charClaire.sprite_index=sClaireIdle; charClaire.image_speed=0.1
      msgCreate(0,0,"Claire","No way, we're back on the Mainland...",0,3,oMessageCutscene,1)
    }
    else if sceneProgress=8 and bWaitForInput=false
    {
      charJerry.sprite_index=sJerryIdle; charJerry.image_speed=0.1
      msgCreate(0,0,"Jerry","Chao is still gone too. What the heck is happening now?",0,3,oMessageCutscene,1)
    }
    else if sceneProgress=9 and bWaitForInput=false
      msgCreate(0,0,"Claire","What do you propose we do?",0,3,oMessageCutscene,1)
    else if sceneProgress=10 and bWaitForInput=false
      msgCreate(0,0,"Jerry","I say we still head for the Hidden Village. Jeremy is probably still able to see us like before, so he should be up to date on what's happening. We'd be going there anyway.",0,3,oMessageCutscene,1)
    else if sceneProgress=11 and bWaitForInput=false
      msgCreate(0,0,"Claire","Would Bubblun have an idea on what's happening?",0,3,oMessageCutscene,1)
    else if sceneProgress=12 and bWaitForInput=false
      msgCreate(0,0,"Jerry","John might, but I doubt he's in Central City anymore.",0,3,oMessageCutscene,1)
    else if sceneProgress=13 and bWaitForInput=false
      msgCreate(0,0,"Claire","Yeah, then let's get to the Hidden Village.",0,3,oMessageCutscene,1)
    else if sceneProgress=14
    {
      oPlayer1.life=oPlayer1.maxLife
      global.pLife=global.pMaxLife
      var tFlash;
      tFlash=instance_create(0,0,oScreenFlash); tFlash.fadeSpeed=0.2
      with oMisc {instance_destroy()}
      oPlayer1.visible=1
      var tempMplay;
      tempMplay=findMusic(10)
      playMusic(tempMplay,0,0)
      sceneDelay=0; sceneProgress=0
      global.gameProgress=4940
      global.gamePaused=false
    }
  }
}
else if room=rMain_84 and global.gameProgress=4940 //----- [12] Did that hit the Village? -----
{
  if global.Ch19WIn=14
  {
    if sceneProgress=0
    {
      sceneDelay+=1
      if sceneDelay=1
      {
        oPlayer1.x=3072; oPlayer1.y=256
        stopPlayer()
        oPlayer1.visible=0
        charJerry=instance_create(3072,256,oMisc)
        charJerry.sprite_index=sJerrySit; charJerry.image_speed=0; charJerry.type=2
        charClaire=instance_create(3136,256,oMisc)
        charClaire.sprite_index=sClaireSitUp; charClaire.image_speed=0; charClaire.image_index=2; charClaire.type=2
      }
      else if sceneDelay>=31 and sceneDelay<=70 {fadeAlpha-=0.025}
      else if sceneDelay=130 {charClaire.sprite_index=sClaireIdle; charClaire.image_speed=0.1}
      else if sceneDelay>=140 {eventTime=0; sceneProgress+=1}
    }
    else if sceneProgress=1 and bWaitForInput=false
      msgCreate(0,0,"Claire","Jerry, did that blast hit the village?! They didn't fire on them, did they?!",0,3,oMessageCutscene,1)
    else if sceneProgress=2 and bWaitForInput=false
    {
      charJerry.sprite_index=sJerryIdle; charJerry.image_speed=0.1
      msgCreate(0,0,"Jerry","We're going to check. No worries Claire, things will be okay. They always are.",0,3,oMessageCutscene,1)
    }
    else if sceneProgress=3 and bWaitForInput=false
      msgCreate(0,0,"Claire","I hope so. Maybe Jeremy was able to shield the village. Maybe they already had a defense against this.",0,3,oMessageCutscene,1)
    else if sceneProgress=4
    {
      global.newMapX=3120; global.newMapY=256
      var tFlash;
      tFlash=instance_create(0,0,oScreenFlash); tFlash.fadeSpeed=0.2
      with oMisc {instance_destroy()}
      oPlayer1.visible=1
      var tBlocker;
      tBlocker=instance_create(2480,0,oEvCh19Door); tBlocker.image_yscale=10
      sceneDelay=0; sceneProgress=0
      global.Ch19WIn=15
      global.gamePaused=false
    }
  }
}
else if room=rHiddenVillage_Destroyed and global.gameProgress=4940 //----- [13] The Village destroyed -----
{
  if global.Ch19WIn=15
  {
    if sceneProgress=0
    {
      sceneDelay+=1
      if sceneDelay>=41 and sceneDelay<=90 {fadeAlpha-=0.02}
      else if sceneDelay>=120 {eventTime=0; sceneProgress+=1}
    }
    else if sceneProgress=1 and bWaitForInput=false
      msgCreate(0,0,"Claire","This is awful!",0,3,oMessageCutscene,1)
    else if sceneProgress=2 and bWaitForInput=false
      msgCreate(0,0,"Jerry","...",0,3,oMessageCutscene,1)
    else if sceneProgress=3 and bWaitForInput=false
      msgCreate(0,0,"Jerry","We know what they're going to do. We've got to save them, Claire! All of them!",0,3,oMessageCutscene,1)
    else if sceneProgress=4
    {
      sceneDelay=0; sceneProgress=0
      global.Ch19WIn=16
      global.gamePaused=false
    }
  }
  else if global.Ch19WIn=17
  {
    if sceneProgress=0
    {
      oPlayer1.y+=4
      if oPlayer1.y>=304
      {
        scenePChk(oPlayer1.x,304,0,0.1,1)
        stopPlayer()
        sceneProgress+=1
      }
    }
    else if sceneProgress=1 and bWaitForInput=false
      msgCreate(0,0,"Hex","That's far enough. Any closer and these two... well you saw what happened to the rest.",0,3,oMessageCutscene,1)
    else if sceneProgress=2 and bWaitForInput=false
      msgCreate(0,0,"Jerry","Why? What's the point of all this?",0,3,oMessageCutscene,1)
    else if sceneProgress=3 and bWaitForInput=false
      msgCreate(0,0,"Hex","You were warned to back down and these bots showed allegiance to you. I told you the warship's power was great.",0,3,oMessageCutscene,1)
    else if sceneProgress=4 and bWaitForInput=false
      msgCreate(0,0,"Jerry","What do you want, Hex? What can we do for you to spare them?",0,3,oMessageCutscene,1)
    else if sceneProgress=5 and bWaitForInput=false
      msgCreate(0,0,"Hex","Really? Why does it matter? None of us are real anyway!",0,3,oMessageCutscene,1)
    else if sceneProgress=6 and bWaitForInput=false
      msgCreate(0,0,"Jerry","I'm serious.",0,3,oMessageCutscene,1)
    else if sceneProgress=7 and bWaitForInput=false
      msgCreate(0,0,"Hex","... If you insist.",0,3,oMessageCutscene,1)
    else if sceneProgress=8 and bWaitForInput=false
      msgCreate(0,0,"Hex","Stop gathering the Dragoon pieces.",0,3,oMessageCutscene,1)
    else if sceneProgress=9 and bWaitForInput=false
      msgCreate(0,0,"Bubblun","Jerry, don't stop what you're doing! You know he'll never keep his end of the deal.",6,3,oMessageCutscene,1)
    else if sceneProgress=10 and bWaitForInput=false
      msgCreate(0,0,"Hex","Shut it, traitor!.. Though he's right. You, him, everyone, you're all dead anyway!",0,3,oMessageCutscene,1)
    else if sceneProgress=11 and bWaitForInput=false
      msgCreate(0,0,"Claire","Does this really have to happen?",0,3,oMessageCutscene,1)
    else if sceneProgress=12 and bWaitForInput=false
      msgCreate(0,0,"Hex","Yes Claire. It does because I say it happens. I find it all kind of ironic and silly.",0,3,oMessageCutscene,1)
    else if sceneProgress=13 and bWaitForInput=false
      msgCreate(0,0,"Jerry","What?",0,3,oMessageCutscene,1)
    else if sceneProgress=14 and bWaitForInput=false
      msgCreate(0,0,"Hex","In the end, put down by the thing you think you love. I find these things you call video games to be a joke. I can't stand this existence, but it can't be helped.",0,3,oMessageCutscene,1)
    else if sceneProgress=15 and bWaitForInput=false
      msgCreate(0,0,"Jerry","You don't have to make everyone else suffer because you hate everything.",0,3,oMessageCutscene,1)
    else if sceneProgress=16 and bWaitForInput=false
      msgCreate(0,0,"Hex","You know...",0,3,oMessageCutscene,1)
    else if sceneProgress=17 and bWaitForInput=false
      msgCreate(0,0,"Hex","I'm so bored of this. Time's up.",0,3,oMessageCutscene,1)
    else if sceneProgress=18 and bWaitForInput=false
    {
      var tEfCir;
      tEfCir=instance_create(oMisc.x-16,oMisc.y,oEfCircleBlast)
      tEfCir.image_alpha=0.75; tEfCir.myRad=4; tEfCir.radScl=3; tEfCir.fadeSpeed=0.08
      with oMisc {instance_destroy()}
      msgCreate(0,0,"Jerry","Wait!!",0,3,oMessageCutscene,1)
    }
    else if sceneProgress=19 and bWaitForInput=false
      msgCreate(0,0,"Jerry","Okay, we can still save you guys.",0,3,oMessageCutscene,1)
    else if sceneProgress=20
    {
      sceneDelay+=1
      if sceneDelay=1
      {
        var tShield;
        tShield=instance_create(oPlayer1.x,oPlayer1.y-26,oMisc)
        tShield.type=0; tShield.sprite_index=sWaterBarrier
        //tShield=instance_create(2624,294,oMisc)
        //tShield.type=0; tShield.sprite_index=sWaterBarrier; tShield.image_xscale=0.75; tShield.image_yscale=0.75
        //tShield=instance_create(2656,294,oMisc)
        //tShield.type=0; tShield.sprite_index=sWaterBarrier; tShield.image_xscale=0.75; tShield.image_yscale=0.75
      }
      else if sceneDelay>=3 and sceneDelay<=32
      {
        if sceneDelay=3
        {
          fadeColor=c_white
          var tempMplay;
          tempMplay=findMusic(0)
          playMusic(tempMplay,0,0)
          playSound(global.snd_HardHit2,0,1,2000)
          oEvCh19WorldEv.explodeAlpha=1
        }
        oEvCh19WorldEv.explodeRad+=24
      }
      else if sceneDelay=33
      {
        with oNPC_HV_Death {instance_destroy()}
        with oHVD_BackEnemy {instance_destroy()}
        with oMisc {instance_destroy()}
        oEvCh19WorldEv.explodeRad=0
        fadeAlpha=1
      }
      else if sceneDelay>=230 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=21 and bWaitForInput=false
    {
      oIdentifier.bCanScan=1; oIdentifier.bChaoActive=1; global.charScan[0]=1
      msgCreate(0,0,"Jeremy","Can you guys hear me?",0,3,oMessageCutscene,1)
    }
    else if sceneProgress=22 and bWaitForInput=false
      msgCreate(0,0,"Jerry","Jeremy? You're back!",0,3,oMessageCutscene,1)
    else if sceneProgress=23 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","Did my shield work for... wait...",0,3,oMessageCutscene,1)
    else if sceneProgress=24 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","Why didn't it work for all of you? They should have been shielded from the blast too!",0,3,oMessageCutscene,1)
    else if sceneProgress=25 and bWaitForInput=false
      msgCreate(0,0,"Jerry","...",0,3,oMessageCutscene,1)
    else if sceneProgress=26 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","Damn it you guys. I'm sorry...",0,3,oMessageCutscene,1)
    else if sceneProgress=27 and bWaitForInput=false
      msgCreate(0,0,"Claire","Hex is going to do this to Central City too.",0,3,oMessageCutscene,1)
    else if sceneProgress=28 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","Yes, that's another of his targets and he'll move on from there afterwards.",0,3,oMessageCutscene,1)
    else if sceneProgress=29 and bWaitForInput=false
      msgCreate(0,0,"Jerry","So you COULD see everything!",0,3,oMessageCutscene,1)
    else if sceneProgress=30 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","Always.",0,3,oMessageCutscene,1)
    else if sceneProgress=31 and bWaitForInput=false
      msgCreate(0,0,"Jerry","Jeremy, Hex waited for us. On every one of them.",0,3,oMessageCutscene,1)
    else if sceneProgress=32 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","I know. We'll get them back for this.",0,3,oMessageCutscene,1)
    else if sceneProgress=33 and bWaitForInput=false
      msgCreate(0,0,"Jerry","Any ideas where that last piece of the Dragoon is then?",0,3,oMessageCutscene,1)
    else if sceneProgress=34 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","No.",0,3,oMessageCutscene,1)
    else if sceneProgress=35 and bWaitForInput=false
      msgCreate(0,0,"Jerry","Hmm. We need to find John, or maybe Syrus and Gene. Speaking of, where the heck have they been?",0,3,oMessageCutscene,1)
    else if sceneProgress=36 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","I can't track their movements, but I wish I knew they were safe.",0,3,oMessageCutscene,1)
    else if sceneProgress=37 and bWaitForInput=false
      msgCreate(0,0,"Claire","Maybe we can find some help in Central City.",0,3,oMessageCutscene,1)
    else if sceneProgress=38 and bWaitForInput=false
      msgCreate(0,0,"Jerry","I'm afraid to go there. Hex will probably follow us and strike there too.",0,3,oMessageCutscene,1)
    else if sceneProgress=39 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","But we have no where else to try.",0,3,oMessageCutscene,1)
    else if sceneProgress=40 and bWaitForInput=false
      msgCreate(0,0,"Chao","We won't have to go there.",0,3,oMessageCutscene,1)
    else if sceneProgress=41 and bWaitForInput=false
      msgCreate(0,0,"Jerry","Eh?",0,3,oMessageCutscene,1)
    else if sceneProgress=42 and bWaitForInput=false
      msgCreate(0,0,"Chao","I saw something before you guys came in here.",0,3,oMessageCutscene,1)
    else if sceneProgress=43 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","What do you mean, Chao?",0,3,oMessageCutscene,1)
    else if sceneProgress=44 and bWaitForInput=false
      msgCreate(0,0,"Chao","Get out of this place, you'll see.",0,3,oMessageCutscene,1)
    else if sceneProgress=45 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","Sis, you really shouldn't be like that.",0,3,oMessageCutscene,1)
    else if sceneProgress=46 and bWaitForInput=false
      msgCreate(0,0,"Chao","I know, but just trust me.",0,3,oMessageCutscene,1)
    else if sceneProgress=47 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","Well you heard her.",0,3,oMessageCutscene,1)
    else if sceneProgress=48
    {
      var tExit;
      tExit=instance_create(96,992,oExit)
      tExit.sprite_index=sNormalDoor; tExit.bShowArrow=true; tExit.exitType=0
      tExit.newMapX=3744; tExit.newMapY=288; tExit.toRoom=rMain_84; tExit.colorChange=1
      oIdentifier.bCanScan=1; oIdentifier.bChaoActive=1; global.charScan[0]=1
      with oNPC_HV_Death {instance_destroy()}
      with oHVD_BackEnemy {instance_destroy()}
      with oMisc {instance_destroy()}
      oEvCh19WorldEv.explodeRad=0
      fadeAlpha=0
      var tempMplay;
      tempMplay=findMusic(1014)
      playMusic(tempMplay,0,0)
      instance_create(0,0,oCheckpointNotice)
      writeToPlayerGlobals()
      global.CHAOS_Upgrade=1
      playSound(global.snd_FireCrackle,1,0.88,1)
      global.newMapX=2480; global.newMapY=304
      sceneDelay=0; sceneProgress=0
      global.gameProgress=4950
      global.gamePaused=false
    }
  }
}
else if room=rMain_84 and global.gameProgress=4950 //----- [14] Reunited with Gene & Syrus -----
{
  if sceneProgress=0
  {
    if oPlayer1.x<=3120
    {
      global.gamePaused=true
      oPlayer1.y+=4
      if oPlayer1.y>=256
      {
        scenePChk(oPlayer1.x,256,0,0.1,-1)
        stopPlayer()
        fadeColor=c_black
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
    msgCreate(0,0,"Jerry","Whoa!!",0,3,oMessageCutscene,1)
  else if sceneProgress=3
  {
    sceneDelay+=1
    if sceneDelay=1 {showEmote((420748),0,-60,sEmExcite)}
    else if sceneDelay=20 {(420748).image_xscale=1}
    else if sceneDelay>=50 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Syrus","There you are! We were just about to head in there. We'd have followed you in much earlier, but some barriers popped up.",6,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Jerry","We know all about those barriers... Oh wait, so they dropped then?",0,3,oMessageCutscene,1)
  else if sceneProgress=6 and bWaitForInput=false
    msgCreate(0,0,"Syrus","Yes, just a moment ago. So what happened here?",6,3,oMessageCutscene,1)
  else if sceneProgress=7
  {
    sceneDelay+=1
    if sceneDelay>=1 and sceneDelay<=20 {fadeAlpha+=0.05}
    else if sceneDelay>=61 and sceneDelay<=80 {fadeAlpha-=0.05}
    else if sceneDelay>=100 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=8 and bWaitForInput=false
    msgCreate(0,0,"Syrus","Geez, you guys have been through a lot.",6,3,oMessageCutscene,1)
  else if sceneProgress=9 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","We really just need to find the last piece of the Dragoon.",0,3,oMessageCutscene,1)
  else if sceneProgress=10 and bWaitForInput=false
    msgCreate(0,0,"Gene","About that... I was looking up places that some of the bots used to frequent. Kirby was one of them.",6,3,oMessageCutscene,1)
  else if sceneProgress=11 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","What did you find?",0,3,oMessageCutscene,1)
  else if sceneProgress=12 and bWaitForInput=false
    msgCreate(0,0,"Gene","The two places you mentioned to me a moment ago were among the places Kirby would go. Another one, aside from the Village back there was a castle on the far east side of the Magical Hills.",6,3,oMessageCutscene,1)
  else if sceneProgress=13 and bWaitForInput=false
    msgCreate(0,0,"Gene","It's possible you've seen the place. It's way up on a hill in a place called 'Magical Treeless Pass'. It's actually not very far from here.",6,3,oMessageCutscene,1)
  else if sceneProgress=14 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Well, this area is different now, so who knows.",0,3,oMessageCutscene,1)
  else if sceneProgress=15 and bWaitForInput=false
    msgCreate(0,0,"Gene","Yeah... not sure how this happened, but it was pretty sudden. CHAOS is in this place now and they seem to be searching for something.",6,3,oMessageCutscene,1)
  else if sceneProgress=16 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","No doubt they're trying to find the last Dragoon piece, before we do, now that they know what we're up to.",0,3,oMessageCutscene,1)
  else if sceneProgress=17 and bWaitForInput=false
    msgCreate(0,0,"Syrus","Are you familiar with the gold armored units they have?",6,3,oMessageCutscene,1)
  else if sceneProgress=18 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Some of them have gold armor, yes.",0,3,oMessageCutscene,1)
  else if sceneProgress=19 and bWaitForInput=false
    msgCreate(0,0,"Syrus","Nearly all of them have that now. It seems they've upgraded their armor.",6,3,oMessageCutscene,1)
  else if sceneProgress=20 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Great. That's not something I wanted to hear.",0,3,oMessageCutscene,1)
  else if sceneProgress=21 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","We need to get going then. If CHAOS is now modding their units, then they'll keep improving on that.",0,3,oMessageCutscene,1)
  else if sceneProgress=22 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Are we sure the last piece is in that castle?",0,3,oMessageCutscene,1)
  else if sceneProgress=23 and bWaitForInput=false
    msgCreate(0,0,"Claire","I'm willing to bet we don't have many other options, Jerry.",0,3,oMessageCutscene,1)
  else if sceneProgress=24 and bWaitForInput=false
    msgCreate(0,0,"Jerry","To a castle we go then!",0,3,oMessageCutscene,1)
  else if sceneProgress=25 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","You guys be careful out here with CHAOS around.",0,3,oMessageCutscene,1)
  else if sceneProgress=26 and bWaitForInput=false
    msgCreate(0,0,"Syrus","We'll be fine. You guys stay safe yourself.",6,3,oMessageCutscene,1)
  else if sceneProgress=27 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Right, we're heading right into an old castle... I hope there's no spikes.",0,3,oMessageCutscene,1)
  else if sceneProgress=28
  {
    sceneDelay=0; sceneProgress=0
    global.gameProgress=4960
    global.gamePaused=false
  }
}
else if room=rMC_A
{
  if global.gameProgress=4960 //----- [15] Intro to Magical Castle -----
  {
    if sceneProgress=0
    {
      sceneDelay+=1
      if sceneDelay=1 {global.gamePaused=true}
      if sceneDelay>=20 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=1 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","Oh there we go.",0,3,oMessageCutscene,1)
    else if sceneProgress=2 and bWaitForInput=false
      msgCreate(0,0,"Chao","What's going on, Jeremy?",0,3,oMessageCutscene,1)
    else if sceneProgress=3 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","Those Teleport Stones outside should be working again.",0,3,oMessageCutscene,1)
    else if sceneProgress=4 and bWaitForInput=false
      msgCreate(0,0,"Jerry","Sweet. So Jeremy, anything special we should know about this place?",0,3,oMessageCutscene,1)
    else if sceneProgress=5 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","No, just get the Dragoon piece and get out. I'm not sure how to use them to get the thing flying, but we'll figure that out later.",0,3,oMessageCutscene,1)
    else if sceneProgress=6 and bWaitForInput=false
      msgCreate(0,0,"Jerry","Gotcha.",0,3,oMessageCutscene,1)
    else if sceneProgress=7 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","Oh wait, hold up!",0,3,oMessageCutscene,1)
    else if sceneProgress=8 and bWaitForInput=false
      msgCreate(0,0,"Jerry","What's going on now?",0,3,oMessageCutscene,1)
    else if sceneProgress=9 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","Something just appeared in the Hidden Village. Hmm... it's one of those red gates.",0,3,oMessageCutscene,1)
    else if sceneProgress=10 and bWaitForInput=false
      msgCreate(0,0,"Claire","I was wondering about those...",0,3,oMessageCutscene,1)
    else if sceneProgress=11 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","I don't quite know just yet what's going on with those, but I'm sure we all have an idea.",0,3,oMessageCutscene,1)
    else if sceneProgress=12 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","It's up to you guys whether or not you want to use the teleport stone outside to go back to the Village or keep going.",0,3,oMessageCutscene,1)
    else if sceneProgress=13 and bWaitForInput=false
      msgCreate(0,0,"Jerry","It's up to Claire.",0,3,oMessageCutscene,1)
    else if sceneProgress=14 and bWaitForInput=false
      msgCreate(0,0,"Claire","If that's what you want.",0,3,oMessageCutscene,1)
    else if sceneProgress=15
    {
      sceneDelay=0; sceneProgress=0
      global.gameProgress=4970
      global.gamePaused=false
    }
  }
  else if global.gameProgress<=4950 //----- [] Before the player is ready -----
  {
    if sceneProgress=0
    {
      if oPlayer1.x>=432
      {
        msgCreate(0,0,"","A mysterious force prevents you from advancing any further.",7,1,oMessagePerson,0)
        newMessage.fadingTime=150
        sceneProgress=1
      }
    }
  }
}
else if room=rMC_K //----- [] Get to end of map -----
{
  if global.gameProgress=4990
  {
    if oPlayer1.x>=2672 {global.gameProgress=5000}
  }
}
else if room=rMC_L //----- [] Pete appears -----
{
  if global.gameProgress=5000
  {
    if sceneProgress=0
    {
      sceneDelay+=1
      if sceneDelay=1 {global.canPause=0}
      else if sceneDelay>=20
      {
        instance_create(400,-70,oBowserMachine)
        sceneDelay=0; sceneProgress+=1
      }
    }
    else if sceneProgress=2
    {
      sceneDelay+=1
      if sceneDelay=40 {awardBossAP(1000)}
      else if sceneDelay=90
      {
        var tCheckAchieve;
        tCheckAchieve=string_char_at(global.tokenRecognitions,12)
        if tCheckAchieve="0"
        {
          var tAchievement;
          tAchievement=instance_create(0,0,oAchievementNotice)
          tAchievement.myAchievement="Just Goofy"; tAchievement.checkNum=12
        }
      }
      else if sceneDelay>=150 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=3
    {
      sceneDelay+=1
      if sceneDelay=10
      {
        msgCreate(0,0,"Jerry","Eh... what just happened?",0,1,oMessagePerson,0)
        newMessage.fadingTime=60
      }
      else if sceneDelay=70
      {
        msgCreate(0,0,"Jeremy","Looks like Pete got blown out of the air.",0,1,oMessagePerson,0)
        newMessage.fadingTime=90
      }
      else if sceneDelay=160
      {
        msgCreate(0,0,"Jerry","Do we... uh... move on?",0,1,oMessagePerson,0)
        newMessage.fadingTime=60
      }
      else if sceneDelay=220
      {
        msgCreate(0,0,"Jeremy","Yep, keep going.",0,1,oMessagePerson,0)
        newMessage.fadingTime=50
      }
      else if sceneDelay=270
      {
        view_object[0]=oPlayer1
        global.canPause=1
        sceneDelay=0; sceneProgress=0
        global.gameProgress=5010
      }
    }
  }
}
else if room=rMC_N and global.gameProgress=5010 //----- [] Boss Fight: Decimator 10000 -----
{
  if global.bossTrack=0
  {
    if sceneProgress=0 //Start boss fight
    {
      if oPlayer1.x>=304
      {
        var enemyBarrier;
        enemyBarrier=instance_create(48,96,oEnemyBarrier); enemyBarrier.image_yscale=4
        var tBossTitle,tempMplay,boss;
        tBossTitle=instance_create(0,0,oBossNameDisplay)
        tBossTitle.bossName="Decimator 10000"
        tBossTitle.bossTitle="It Won't Divide By 0"
        tempMplay=findMusic(828)
        playMusic(tempMplay,0,0)
        global.currentBoss="Decimator"
        global.bossTrack=1
        boss=instance_create(-16,208,oDecimator)
        boss.activateBoss=1
        storeStatus(0)
      }
    }
  }
  else if global.bossTrack=3
  {
    if sceneProgress=1 //End Boss
    {
      stopPlayer()
      global.gamePaused=true
      awardBossAP(17500)
      var tempMplay;
      tempMplay=findMusic(0)
      playMusic(tempMplay,0,0)
      sceneProgress+=1
    }
    else if sceneProgress=2
    {
      fadeAlpha+=0.1
      if fadeAlpha>=1
      {
        oJohnMech.sprite_index=sNPC_John_Idle; oJohnMech.x=688
        scenePChk(720,320,0,0.1,-1)
        with oAttackBase {instance_destroy()}
        sceneProgress+=1
      }
    }
    else if sceneProgress=3
    {
      sceneDelay+=1
      if sceneDelay=50
      {
        with oJohnMech {instance_destroy()}
        oNPC_SStoryChar.y=320
        stopPlayer()
        oPlayer1.image_xscale=-1
        view_object[0]=oPlayer1
        with oRm_MC_Camera {instance_destroy()}
      }
      else if sceneDelay>=51 and sceneDelay<=60  {fadeAlpha-=0.1}
      else if sceneDelay>=80 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=4 and bWaitForInput=false
      msgCreate(0,0,"John","That was a close one.",6,3,oMessageCutscene,1)
    else if sceneProgress=5 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","For sure... I was really hoping CHAOS wouldn't find us here.",0,3,oMessageCutscene,1)
    else if sceneProgress=6 and bWaitForInput=false
      msgCreate(0,0,"John","Their scouts are everywhere now, it was bound to happen.",6,3,oMessageCutscene,1)
    else if sceneProgress=7 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","We still need that last Dragoon piece too. It's definitely in here.",0,3,oMessageCutscene,1)
    else if sceneProgress=8 and bWaitForInput=false
      msgCreate(0,0,"John","Hmm, keep looking around. I'll be right here for a moment.",6,3,oMessageCutscene,1)
    else if sceneProgress=9
    {
      var tFullHeartDrop;
      tFullHeartDrop=instance_create(768,144,oHealthPickup)
      tFullHeartDrop.sprite_index=sFullHealthPickup
      with oEnemyBarrier {instance_destroy()}
      var tempMplay;
      tempMplay=findMusic(602)
      playMusic(tempMplay,0,0)
      global.gamePaused=false
      global.currentBoss=""
      global.bossTrack=0
      global.gameProgress=5020
    }
  }
}
else if room=rMC_O and global.gameProgress=5020 //Take the Dragoon Piece
{
  {
    if sceneProgress=0 and !instance_exists(oStoryObject)
    {
      global.gameProgress=5030
    }
  }
}
else if room=rMC_N and global.gameProgress=5030 //----- [16] The 3 Dragoon Pieces -----
{
  if sceneProgress=0
  {
    if oPlayer1.x>=592 and oPlayer1.y<=336
    {
      global.gamePaused=true
      oPlayer1.y+=4
      if oPlayer1.y>=320
      {
        scenePChk(oPlayer1.x,320,0,0.1,1)
        stopPlayer()
        sceneProgress+=1
      }
    }
  }
  else if sceneProgress=1 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Turns out the piece was in a room back there.",0,3,oMessageCutscene,1)
  else if sceneProgress=2 and bWaitForInput=false
  {
    oNPC_SStoryChar.image_xscale=-1
    msgCreate(0,0,"John","Well that's convenient...",6,3,oMessageCutscene,1)
  }
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Now the problem is that we don't know how to use them.",0,3,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"John","I do, which is why I removed the platforms that used to be here. The Warship is directly north from this location. You can use that ledge to the right as a launching pad for the Dragoon.",6,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","What do we do then?",0,3,oMessageCutscene,1)
  else if sceneProgress=6 and bWaitForInput=false
    msgCreate(0,0,"John","Throw them out and I'll have them constructed.",6,3,oMessageCutscene,1)
  else if sceneProgress=7 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Yes, because that makes all the sense, but hey let's do it.",0,3,oMessageCutscene,1)
  else if sceneProgress=8
  {
    sceneDelay+=1
    if sceneDelay=10
    {
      var tFlash;
      tFlash=instance_create(0,0,oScreenFlash)
      tFlash.fadeSpeed=0.2
      chipDir=0; chipDist=8; chipSpd=5
      chipX=oPlayer1.x; chipY=oPlayer1.y-26
      for(i=0;i<3;i+=1)
      {
        pChip[i]=instance_create(chipX+lengthdir_x(chipDist,i*120),chipY-96+lengthdir_y(chipDist,i*120),oMisc)
        pChip[i].sprite_index=sDragoonPickup; pChip[i].image_index=i
        pChip[i].image_speed=0; pChip[i].type=1
      }
    }
    else if sceneDelay>=11 and sceneDelay<=499
    {
      for(i=0;i<3;i+=1)
      {
        pChip[i].x=chipX+lengthdir_x(chipDist,chipDir+(i*120))
        pChip[i].y=chipY+lengthdir_y(chipDist,chipDir+(i*120))
      }
      chipDir+=chipSpd
      if chipDist<64 {chipDist+=1}

      chipY-=1
      if chipY<=240
      {
        chipY=240
        sceneDelay=500
      }
    }
    else if sceneDelay>=500 and sceneDelay<=999
    {
      for(i=0;i<3;i+=1)
      {
        pChip[i].x=chipX+lengthdir_x(chipDist,chipDir+(i*120))
        pChip[i].y=chipY+lengthdir_y(chipDist,chipDir+(i*120))
      }
      if chipSpd<20 {chipSpd+=0.25}
      chipDir+=chipSpd
      if sceneDelay>=501 and sceneDelay<=560 {chipDist+=1} //Pieces out
      else if sceneDelay>=591 {chipDist-=2} //Pieces in

      if chipDist<=0
      {
        var tEffect,tEfCir;
        tEffect=instance_create(chipX,chipY,oEffect)
        tEffect.sprite_index=sEfInternetzGrab; tEffect.image_xscale=2; tEffect.image_yscale=2
        tEffect.followID=-1; tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
        tEfCir=instance_create(x,y,oEfCircleBlast)
        tEfCir.image_alpha=0.75; tEfCir.myRad=4; tEfCir.radScl=3; tEfCir.fadeSpeed=0.08
        with oMisc {instance_destroy()}
        theDragoon=instance_create(chipX,chipY,oMisc)
        theDragoon.sprite_index=sDragoonFlier; theDragoon.image_speed=0; theDragoon.type=1
        sceneDelay=1000
      }
    }
    else if sceneDelay>=1060
    {
      theDragoon.x+=8
      if theDragoon.x>=912
      {
        theDragoon.x=912; theDragoon.y=240
        sceneDelay=0; sceneProgress+=1
      }
    }
  }
  else if sceneProgress=9
  {
    sceneDelay+=1
    if sceneDelay>=30 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=10 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Well, that works.",0,3,oMessageCutscene,1)
  else if sceneProgress=11 and bWaitForInput=false
    msgCreate(0,0,"John","When you're ready to go to the Warship, just touch the Dragoon and you'll be able to fly it there.",6,3,oMessageCutscene,1)
  else if sceneProgress=12 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Huh... so this is it then?",0,3,oMessageCutscene,1)
  else if sceneProgress=13 and bWaitForInput=false
    msgCreate(0,0,"John","Yep...",6,3,oMessageCutscene,1)
  else if sceneProgress=14 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Taking the fight to them again, finally.",0,3,oMessageCutscene,1)
  else if sceneProgress=15 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","So you guys know what's coming up, don't you?",0,3,oMessageCutscene,1)
  else if sceneProgress=16 and bWaitForInput=false
    msgCreate(0,0,"Claire","Yep! I'm taking control of it too!",0,3,oMessageCutscene,1)
  else if sceneProgress=17 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Good, you know I'm not a fan of shooters.",0,3,oMessageCutscene,1)
  else if sceneProgress=18 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","There's a problem though, you guys have no offensive abilities up there.",0,3,oMessageCutscene,1)
  else if sceneProgress=19 and bWaitForInput=false
    msgCreate(0,0,"John","Yes you do. The Dragoon has a standard cannon. It's a bit weak, but that's not what you have going for you.",6,3,oMessageCutscene,1)
  else if sceneProgress=20 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Eh?",0,3,oMessageCutscene,1)
  else if sceneProgress=21 and bWaitForInput=false
    msgCreate(0,0,"John","Jeremy, I'm surprised you haven't picked up on this yet.",6,3,oMessageCutscene,1)
  else if sceneProgress=22 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","What?",0,3,oMessageCutscene,1)
  else if sceneProgress=23 and bWaitForInput=false
    msgCreate(0,0,"John","Jerry and Claire absorbed another ability, though none of you seem to have noticed. Probably because the ability remained dormant.",6,3,oMessageCutscene,1)
  else if sceneProgress=24 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Could you just tell us?",0,3,oMessageCutscene,1)
  else if sceneProgress=25 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Yeah, I'm curious too.",0,3,oMessageCutscene,1)
  else if sceneProgress=26 and bWaitForInput=false
    msgCreate(0,0,"John","Kirby passed on his ability to you two.",6,3,oMessageCutscene,1)
  else if sceneProgress=27 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Really!? But how?",0,3,oMessageCutscene,1)
  else if sceneProgress=28 and bWaitForInput=false
    msgCreate(0,0,"John","Kirby was pretty clever with his dance clone there. Instead, the real Kirby passed on his ability to you guys. When you're on the Dragoon, you will be able to invoke the ability to copy enemy attacks.",6,3,oMessageCutscene,1)
 else if sceneProgress=29 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Wait, so he timed all that to keep Hex from knowing that he gave his ability to Claire and Jerry?",0,3,oMessageCutscene,1)
  else if sceneProgress=30 and bWaitForInput=false
    msgCreate(0,0,"John","Yep!",6,3,oMessageCutscene,1)
  else if sceneProgress=31 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","How do you know all this though?",0,3,oMessageCutscene,1)
  else if sceneProgress=32 and bWaitForInput=false
    msgCreate(0,0,"John","Kirby and myself planned it. I didn't want to go through with it considering what it would do to him, but he insisted. I imagine Hex would have hunted Kirby down eventually, considering what he's capable of.",6,3,oMessageCutscene,1)
  else if sceneProgress=33 and bWaitForInput=false
    msgCreate(0,0,"John","I needed to keep it all from you guys too. If Hex was onto Kirby's ability transfer, he would figure out about the Dragoons a lot quicker than he did.",6,3,oMessageCutscene,1)
  else if sceneProgress=34 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Okay, so...",0,3,oMessageCutscene,1)
  else if sceneProgress=35 and bWaitForInput=false
    msgCreate(0,0,"John","Like I said, touch the Dragoon and it'll send you off. There are some nuances I can explain to you if you need help. Just talk with me if you want to know how to use the Dragoon.",6,3,oMessageCutscene,1)
  else if sceneProgress=36 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Hey... thanks.",0,3,oMessageCutscene,1)
  else if sceneProgress=37 and bWaitForInput=false
    msgCreate(0,0,"John","It's necessary. We need that ship taken down, and right now, only you guys have the tools to get there and bring it down.",6,3,oMessageCutscene,1)
  else if sceneProgress=38 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","All right you guys. This is it. You know as soon as we start, Hex will detect us and they're probably aware of the Dragoon at this point. So... prepare for a lot of bullets.",0,3,oMessageCutscene,1)
  else if sceneProgress=39
  {
    with oNPC_SStoryChar {instance_destroy()}
    with oMisc {instance_destroy()}
    instance_create(912,240,oShooter_Start)
    instance_create(688,320,oShooter_Rules)
    global.gamePaused=false
    global.gameProgress=5040
  }
}

keyWaitForInput()

if oKeyCodes.kCodePressed[11]=1 and global.gamePaused=true and sceneProgress>=1 //Cutscene skip
{
  if !instance_exists(oPauseMenu)
  {
    if global.gameProgress=4520 and room=rMain_79 //[1]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      fadeAlpha=0; sceneDelay=0
      sceneProgress=13
    }
    else if global.gameProgress=4540 and room=rMain_84 //[2]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      fadeAlpha=0; sceneDelay=0
      sceneProgress=13
    }
    else if global.gameProgress=4560 and room=rHiddenVillage //[3]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      fadeAlpha=0; sceneDelay=0
      sceneProgress=8
    }
    else if global.gameProgress=4570 and room=rHiddenVillage //[4]
    {
      if sceneProgress>=1
      {
        bWaitForInput=false
        with oMessageCutscene {instance_destroy()}
        fadeAlpha=0; sceneDelay=0
        sceneProgress=33
      }
    }
    else if global.gameProgress=4580 and room=rDiscoA //[5]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      fadeAlpha=0; sceneDelay=0
      sceneProgress=8
    }
    else if global.gameProgress=4610 and room=rDiscoD //[6]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      fadeAlpha=0; sceneDelay=0
      sceneProgress=14
    }
    else if global.gameProgress=4635 and room=rDiscoF //[7]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      fadeAlpha=0; sceneDelay=0
      sceneProgress=5
    }
    else if global.gameProgress=4640 and room=rDiscoH //[8]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      fadeAlpha=0; sceneDelay=0
      sceneProgress=6
    }
    else if global.gameProgress=4690 and room=rDiscoI //[9]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      fadeAlpha=0; sceneDelay=0
      sceneProgress=7
    }
    else if global.gameProgress=4710 and room=rHiddenVillage //[10]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      fadeAlpha=0; sceneDelay=0
      sceneProgress=26
    }
    else if global.gameProgress=4930 and room=rMain_92 //[11]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      fadeAlpha=0; sceneDelay=0
      sceneProgress=14
    }
    else if global.gameProgress=4940 and room=rMain_84 //[12]
    {
      if global.Ch19WIn=14
      {
        bWaitForInput=false
        with oMessageCutscene {instance_destroy()}
        fadeAlpha=0; sceneDelay=0
        sceneProgress=4
      }
    }
    else if global.gameProgress=4940 and room=rHiddenVillage_Destroyed //[13]
    {
      if global.Ch19WIn=15
      {
        bWaitForInput=false
        with oMessageCutscene {instance_destroy()}
        fadeAlpha=0; sceneDelay=0
        sceneProgress=4
      }
      else if global.Ch19WIn=17
      {
        bWaitForInput=false
        with oMessageCutscene {instance_destroy()}
        fadeAlpha=0; sceneDelay=0
        sceneProgress=48
      }
    }
    else if room=rMain_84 and global.gameProgress=4950 //[14]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      fadeAlpha=0; sceneDelay=0
      sceneProgress=28
    }
    else if global.gameProgress=4960 and room=rMC_A //[15]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      fadeAlpha=0; sceneDelay=0
      sceneProgress=15
    }
    else if room=rMC_N and global.gameProgress=5030 //[16]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      fadeAlpha=0; sceneDelay=0
      sceneProgress=39
    }
  }
}

//----- Room specific events -----
if global.gamePaused=false
{
  if room=rHiddenVillage
  {
    if serenityEntry<100
    {
      fadeAlpha-=0.04
      if fadeAlpha<=0 {serenityEntry=100}
    }
  }
  else if room=rDiscoA or room=rDiscoB or room=rDiscoC
  {
    invertTime+=1
    if invertTime>=104
    {
      var tInverter;
      tInverter=instance_create(view_xview[0]+view_wview[0],0,oDiscoColorInvert)
      tInverter.xMove=2; tInverter.xSize=176
      invertTime=0
    }
  }
  else if room=rDiscoF or room=rDiscoG {oPlayer1.runAcc=12; oPlayer1.xAccLimit=12}
  else if room=rDiscoH and global.gameProgress<=4660
  {
    if global.forceTime mod 30=0
    {
      background_x[0]-=16
    }

    if oPlayer1.x>=720 {playerRunSpeed=6.4; SS_SetSoundFreq(global.msc_Discombobulated,19800)}
    if oPlayer1.x>=1392 {playerRunSpeed=5.8; SS_SetSoundFreq(global.msc_Discombobulated,17550)}
    if oPlayer1.x>=1904 {playerRunSpeed=5.2; SS_SetSoundFreq(global.msc_Discombobulated,15300)}
    if oPlayer1.x>=2752 {playerRunSpeed=4.6; SS_SetSoundFreq(global.msc_Discombobulated,13050)}
    if oPlayer1.x>=3504 {playerRunSpeed=4; SS_SetSoundFreq(global.msc_Discombobulated,10800)}
    if oPlayer1.x>=4144 {playerRunSpeed=3.5; SS_SetSoundFreq(global.msc_Discombobulated,8550)}
    if oPlayer1.x>=4928 {playerRunSpeed=3; SS_SetSoundFreq(global.msc_Discombobulated,6300)}
    oPlayer1.runAcc=playerRunSpeed
    oPlayer1.dashEnergy=0
  }
  else if room=rDiscoI and global.gameProgress=4670 {oPlayer1.runAcc=4; oPlayer1.dashEnergy=0}
  else if room=rMC_L //Jump player up
  {
    if jumpProg=0
    {
      if jumpTime<=7 {oPlayer1.yVel=-20}
      jumpTime+=1
      if jumpTime>=15
      {
        stopAllMusic()
        playSound(global.snd_HardHit1,0,1,1)
        tile_layer_show(999990)
        for(i=0;i<64;i+=1)
        {
          tEffect=instance_create(192+random(96),288+random(64),oEffectB)
          tEffect.type=3; tEffect.sprite_index=sMMSmokeCloud; tEffect.newBlend=-1; tEffect.image_speed=0.2
          tEffect.fadeSpd=0.075; tEffect.AccelX=0; tEffect.AccelY=0; tEffect.followID=-1; tEffect.rotation=0
        }
        var tColl;
        tColl=instance_create(208,288,oInvisibleSolid)
        tColl.image_xscale=4; tColl.image_yscale=4
        jumpTime=0; jumpProg=10
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
