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

if global.gameProgress=3390 and room=rGame6_WhisperWoodsA
{
  fadeAlpha=1
}
else if room=rGame6_HeroPlainsF
{
  indexCheck=string_char_at(global.kiEnergy,3)
  if indexCheck="1" {sceneProgress=10}
}
else if room=rGame6_EarthH or room=rGame6_EarthI
{
  spikeInit=0
}
else if global.gameProgress=3520 and room=rGame6_Hometown
{
  fadeColor=c_black
  fadeAlpha=1
}
else if global.gameProgress=3480 and room=rGame6_JDream
{
  fadeColor=c_black
  fadeAlpha=1
}
else if room=rGame6_FireD
{
  wallCheck=0
}
else if global.gameProgress=3540 and room=rGame6_ESC_Scene
{
  fadeColor=c_black
  fadeAlpha=1
  oPlayer1.visible=0
}
else if global.gameProgress=3540 and room=rGame6_Gate
{
  fadeColor=c_black
  fadeAlpha=1
  charClaire=instance_create(128,288,oMisc)
  charClaire.sprite_index=sClaireIdle; charClaire.image_xscale=-1
  charClaire.image_speed=0.1; charClaire.type=1
}
else if room=rGame6_WindH
{
  bWallSpawn=0
}
else if room=rGame6_WindI
{
  if global.gameProgress=3620
  {
    musicFade=global.optMusic*100
  }
}
else if room=rGame6_DreamWoodsA
{
  if global.gameProgress=3640
  {
    fadeAlpha=1
  }
}
else if room=rGame6_CoDE
{
  bEnemyCheck=0
}
else if room=rGame6_CoDP
{
  if global.gameProgress<=3820 and global.bossTrack=0
  {
    npcBishonen=instance_create(1152,352,oMisc)
    npcBishonen.sprite_index=sWHB_Idle; npcBishonen.image_xscale=-1
    npcBishonen.image_speed=0; npcBishonen.type=1
  }
}
else if room=rGame6_CoDR
{
  bGridCheck=0
}
else if room=rGame6_CoDS
{
  var tTrap,tDir;
  tDir=0
  for(i=0;i<24;i+=1)
  {
    tTrap=instance_create(800,160,oMovingTrap)
    tTrap.shiftTime=0; tTrap.shiftMax=60; tTrap.moveSpd=3; tTrap.bShowLine=1
    tTrap.direction=tDir
    tDir+=360/24
  }
}
else if room=rGame6_CoDU
{
  lightningTime=0
  circleRad=0
  if global.gameProgress<=3860
  {
    fadeColor=c_black
    fadeAlpha=1
    musicFade=global.optMusic*100
    oHUD.visible=0
  }
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gameProgress=3390 and room=rGame6_WhisperWoodsA //----- [1] Chapter 15 -----
{
  if sceneProgress=0
  {
    sceneDelay+=1
    if sceneDelay=1
    {
      abilSetRemove(1)
      global.hasShoes[0]=2; global.hasShoes[1]=2
      charSwitcher(1)
      oPlayer1.sprite_index=sClaireLayDown
      oPlayer1.image_speed=0
    }
    else if sceneDelay>=30 and sceneDelay<=999
    {
      fadeAlpha-=0.02
      if fadeAlpha<=0 {sceneDelay=1000}
    }
    else if sceneDelay>=1060 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=1
  {
    sceneDelay+=1
    if sceneDelay=1 {showEmote(oIdentifier,0,-6,sEmThinking)}
    else if sceneDelay>=30 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"Chao","You okay, Claire?",0,3,oMessageCutscene,1)
  else if sceneProgress=3
  {
    sceneDelay+=1
    if sceneDelay=25 {oPlayer1.sprite_index=sClaireSitUp}
    else if sceneDelay=30 {oPlayer1.image_index=1}
    else if sceneDelay>=50 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Claire","Yeah. I just feel a bit weird, but other than that, everything is good.",0,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Chao","I guess that's good!",0,3,oMessageCutscene,1)
  else if sceneProgress=6
  {
    sceneDelay+=1
    if sceneDelay=15 {oPlayer1.image_index=2}
    else if sceneDelay=20 {oPlayer1.sprite_index=sClaireIdle; oPlayer1.image_speed=0.1}
    else if sceneDelay>=40 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=7 and bWaitForInput=false
    msgCreate(0,0,"Claire","So where are we? And where is the exit portal?",0,3,oMessageCutscene,1)
  else if sceneProgress=8 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","That's a good question... I don't know. Looks like the portal threw you somewhere else.",0,3,oMessageCutscene,1)
  else if sceneProgress=9 and bWaitForInput=false
    msgCreate(0,0,"Claire","Are we still in the Gate?",0,3,oMessageCutscene,1)
  else if sceneProgress=10 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Definitely, and... damn, it looks like it threw Jerry somewhere else.",0,3,oMessageCutscene,1)
  else if sceneProgress=11 and bWaitForInput=false
    msgCreate(0,0,"Claire","So he's missing?",0,3,oMessageCutscene,1)
  else if sceneProgress=12 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Yes. Where he is, I don't know either, but I'm willing to bet he didn't get sent too far from you.",0,3,oMessageCutscene,1)
  else if sceneProgress=13 and bWaitForInput=false
    msgCreate(0,0,"Claire","I hope he's okay. You're not able to monitor him?",0,3,oMessageCutscene,1)
  else if sceneProgress=14 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Nope, so lets find him as fast as possible.",0,3,oMessageCutscene,1)
  else if sceneProgress=15 and bWaitForInput=false
    msgCreate(0,0,"Claire","Hey, aren't I supposed to get a new ability?",0,3,oMessageCutscene,1)
  else if sceneProgress=16 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","It doesn't look like any bots were waiting for you here. Or if they were, they're certainly not in this area.",0,3,oMessageCutscene,1)
  else if sceneProgress=17 and bWaitForInput=false
    msgCreate(0,0,"Claire","Dang it! Well, I'm sure we'll find some offensive abilities eventually.",0,3,oMessageCutscene,1)
  else if sceneProgress=18 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Your dash has been taken as well. Don't worry about those things right now. First thing we need to do is find Jerry.",0,3,oMessageCutscene,1)
  else if sceneProgress=19
  {
    global.stJGame_C[0]=1000; global.stJGame_C[1]=1; global.stJGame_C[2]=0
    global.stCGame_C[0]=40; global.stCGame_C[1]=1336; global.stCGame_C[2]=1480
    var tNewChapter,tempMplay;
    tNewChapter=instance_create(0,0,oChapterDisplay)
    tNewChapter.newChapter="Chapter 15#Rapid Prototype Game"
    tempMplay=findMusic(601)
    playMusic(tempMplay,0,0)
    sceneDelay=0; sceneProgress=0
    global.gameProgress=3400
    global.gamePaused=false
  }
}
else if global.gameProgress=3400 and room=rGame6_Hometown //----- [2] Found Jerry, but he has amnesia -----
{
  if sceneProgress=0
  {
    if oPlayer1.x>=668
    {
      global.gamePaused=true
      oPlayer1.y+=4
      if oPlayer1.y>=296
      {
        scenePChk(oPlayer1.x,296,0,0.1,1)
        stopPlayer()
        sceneProgress+=1
      }
    }
  }
  else if sceneProgress=1 and bWaitForInput=false
    msgCreate(0,0,"Claire","It's Jerry!",0,3,oMessageCutscene,1)
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"NPC A","Ah, so there you are.",6,3,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Claire","You... know who I am?",0,3,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"NPC A","Of course, I've heard all about you in the prophecy.",6,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Claire","There's a prophecy about me?!",0,3,oMessageCutscene,1)
  else if sceneProgress=6 and bWaitForInput=false
    msgCreate(0,0,"NPC A","Not about you, Claire. You simply accompany 'The Chosen One'.",6,3,oMessageCutscene,1)
  else if sceneProgress=7 and bWaitForInput=false
    msgCreate(0,0,"Claire","Excuse me?",0,3,oMessageCutscene,1)
  else if sceneProgress=8 and bWaitForInput=false
    msgCreate(0,0,"NPC A","You see, 'The Chosen One' has a great destiny. You will accompany that one.",6,3,oMessageCutscene,1)
  else if sceneProgress=9 and bWaitForInput=false
    msgCreate(0,0,"Claire","Jerry is no 'Chosen One'...#Wait, I didn't try to quote that...",0,3,oMessageCutscene,1)
  else if sceneProgress=10 and bWaitForInput=false
    msgCreate(0,0,"NPC A","It is not your unconscious boyfriend. It is another. You must meet him in the Plains of the Hero.",6,3,oMessageCutscene,1)
  else if sceneProgress=11 and bWaitForInput=false
    msgCreate(0,0,"Claire","Sooo many things wrong with what you just said.",0,3,oMessageCutscene,1)
  else if sceneProgress=12 and bWaitForInput=false
    msgCreate(0,0,"NPC A","I have only stated truths. You want to help your friend, but even waking him will not be enough. You will need the spring water from those plains to cure his amnesia.",6,3,oMessageCutscene,1)
  else if sceneProgress=13 and bWaitForInput=false
    msgCreate(0,0,"Claire","Amnesia... Are you serious?",0,3,oMessageCutscene,1)
  else if sceneProgress=14 and bWaitForInput=false
    msgCreate(0,0,"NPC A","Very much so, I know amnesia when I see it.",6,3,oMessageCutscene,1)
  else if sceneProgress=15 and bWaitForInput=false
    msgCreate(0,0,"Claire","How is that even possible?! Damn it, Jerry! Why did you go and get yourself infected by that trope?",0,3,oMessageCutscene,1)
  else if sceneProgress=16 and bWaitForInput=false
    msgCreate(0,0,"NPC A","You will need to cure his amnesia, Jerry plays an important part in 'The Chosen One's destiny. Now off you go, get that water so the prophecy can be fulfilled.",6,3,oMessageCutscene,1)
  else if sceneProgress=17 and bWaitForInput=false
    msgCreate(0,0,"Claire","Okay, that's annoying. Jeremy, do you know where those plains are?",0,3,oMessageCutscene,1)
  else if sceneProgress=18 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Yep, head west from here, it should be there.",0,3,oMessageCutscene,1)
  else if sceneProgress=19 and bWaitForInput=false
    msgCreate(0,0,"Claire","Thanks.",0,3,oMessageCutscene,1)
  else if sceneProgress=20 and bWaitForInput=false
    msgCreate(0,0,"NPC A","Are you talking to voices in your head?",6,3,oMessageCutscene,1)
  else if sceneProgress=21 and bWaitForInput=false
    msgCreate(0,0,"Claire","It's my friend, Jeremy... Hmm, I guess you can't hear him.",0,3,oMessageCutscene,1)
  else if sceneProgress=22 and bWaitForInput=false
    msgCreate(0,0,"NPC A","I've been in this place for a long time. Outside forces cannot interact with those inside.",6,3,oMessageCutscene,1)
  else if sceneProgress=23 and bWaitForInput=false
    msgCreate(0,0,"Chao","Can he understand me?",0,3,oMessageCutscene,1)
  else if sceneProgress=24 and bWaitForInput=false
    msgCreate(0,0,"Claire","Are you able to understand my friend that's taking the form of the fairy?",0,3,oMessageCutscene,1)
  else if sceneProgress=25 and bWaitForInput=false
    msgCreate(0,0,"NPC A","Fairies cannot talk. Now do head out to help 'The Chosen One' fulfill his destiny. Operating word is his, not her.",6,3,oMessageCutscene,1)
  else if sceneProgress=26 and bWaitForInput=false
    msgCreate(0,0,"Claire","Ugh, I can tell this place is going to suck.",0,3,oMessageCutscene,1)
  else if sceneProgress=27
  {
    var tNewChapter;
    tNewChapter=instance_create(0,0,oChapterDisplay)
    tNewChapter.newChapter="Act 1#The Beginning"
    sceneDelay=0; sceneProgress=0
    global.gameProgress=3410
    global.gamePaused=false
  }
}
else if global.gameProgress=3410 and room=rGame6_HeroPlainsA //----- [3] Unfinished maps and 'The Chosen One' -----
{
  if sceneProgress=0
  {
    sceneDelay+=1
    if sceneDelay=1 {global.gamePaused=true}
    else if sceneDelay>=30 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=1 and bWaitForInput=false
    msgCreate(0,0,"Claire","What is this?",0,3,oMessageCutscene,1)
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Hmm... oh right. Remember when John said this was one of their prototype zones? ... He said it was unfinished.",0,3,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Claire","Wouldn't the program have filled it out for them?",0,3,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","That's what I thought, but it looks like they could tell it when not to do that. So... watch out for bugs.",0,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
  {
    showEmote(oWHB_NPC,0,-56,sEmThinking)
    msgCreate(0,0,"'The Chosen One'","Uhh, hey!",6,3,oMessageCutscene,1)
  }
  else if sceneProgress=6 and bWaitForInput=false
    msgCreate(0,0,"Claire","Sorry, I didn't see you there.",0,3,oMessageCutscene,1)
  else if sceneProgress=7 and bWaitForInput=false
    msgCreate(0,0,"Chao","I can see why you'd look past him, Claire.",0,3,oMessageCutscene,1)
  else if sceneProgress=8 and bWaitForInput=false
    msgCreate(0,0,"Claire","Yep!",0,3,oMessageCutscene,1)
  else if sceneProgress=9 and bWaitForInput=false
    msgCreate(0,0,"'The Chosen One'","Why are you here?",6,3,oMessageCutscene,1)
  else if sceneProgress=10 and bWaitForInput=false
    msgCreate(0,0,"Claire","I'm here to... ugh, find 'The Chosen One', so I can get some spring water for my friend.",0,3,oMessageCutscene,1)
  else if sceneProgress=11 and bWaitForInput=false
    msgCreate(0,0,"'The Chosen One'","That would be me! I am 'The Chosen One'!",6,3,oMessageCutscene,1)
  else if sceneProgress=12 and bWaitForInput=false
    msgCreate(0,0,"Claire","Yes, I can see that by your not so clever tag. So where's the spring water?",0,3,oMessageCutscene,1)
  else if sceneProgress=13 and bWaitForInput=false
    msgCreate(0,0,"'The Chosen One'","This is why you need me. This is part of my destiny!",6,3,oMessageCutscene,1)
  else if sceneProgress=14 and bWaitForInput=false
    msgCreate(0,0,"Claire","Please don't.",0,3,oMessageCutscene,1)
  else if sceneProgress=15 and bWaitForInput=false
    msgCreate(0,0,"'The Chosen One'","I must bring the weak and helpless girl to the spring water. This is the beginning of my destiny!",6,3,oMessageCutscene,1)
  else if sceneProgress=16 and bWaitForInput=false
    msgCreate(0,0,"Claire","Wow... just wow. Let's just get this over with. Bring me to the spring water.",0,3,oMessageCutscene,1)
  else if sceneProgress=17 and bWaitForInput=false
    msgCreate(0,0,"'The Chosen One'","Certainly!",6,3,oMessageCutscene,1)
  else if sceneProgress=18
  {
    oWHB_NPC.image_xscale=1
    sceneDelay=0; sceneProgress=0
    global.gameProgress=3420
    global.gamePaused=false
  }
}
else if global.gameProgress=3420 and room=rGame6_HeroPlainsA //----- [4] Combat Tutorial... sort of -----
{
  if sceneProgress=0
  {
    if oPlayer1.x>=840
    {
      global.gamePaused=true
      oPlayer1.y+=4
      if oPlayer1.y>=208
      {
        scenePChk(oPlayer1.x,208,0,0.1,1)
        stopPlayer()
        sceneProgress+=1
      }
    }
  }
  else if sceneProgress=1 and bWaitForInput=false
    msgCreate(0,0,"'The Chosen One'","Wait there. I will handle this!",6,3,oMessageCutscene,1)
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"Claire","Why not give me a weapon and I can help.",0,3,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"'The Chosen One'","Great idea! The first technique you should know#is [Blade Strike]. It's your standard close range melee attack. I'm a master of it since, you know, I'm 'The Chosen One' and all.",6,3,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Claire","Oh we know.",0,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"'The Chosen One'","This slime doesn't stand a chance against my superior skills!",6,3,oMessageCutscene,1)
  else if sceneProgress=6 and bWaitForInput=false
    msgCreate(0,0,"Claire","If you keep standing there chatting, it's going to get you first... which would be great.",0,3,oMessageCutscene,1)
  else if sceneProgress=7 and bWaitForInput=false
    msgCreate(0,0,"'The Chosen One'","Nonsense, I would simply use [Guard] and negate its attack! When you hold the guard button, you'll block all incoming melee attacks. But you have to be careful or your shield will break.",6,3,oMessageCutscene,1)
  else if sceneProgress=8 and bWaitForInput=false
    msgCreate(0,0,"'The Chosen One'","When that happens, you'll take double damage from every source until it regenerates. There's a trick too! If you guard right when the enemy's attack would connect, you'll parry.",6,3,oMessageCutscene,1)
  else if sceneProgress=9 and bWaitForInput=false
    msgCreate(0,0,"'The Chosen One'","For a very short time after this, you cannot take any damage (except from projectiles) AND, your attacks will deal triple damage. Also your shield completely regenerates after the parry state is over.",6,3,oMessageCutscene,1)
  else if sceneProgress=10 and bWaitForInput=false
    msgCreate(0,0,"'The Chosen One'","Naturally since I'm 'The Chosen One', I don't need to worry about all that.",6,3,oMessageCutscene,1)
  else if sceneProgress=11 and bWaitForInput=false
    msgCreate(0,0,"Claire","This would all be super useful information if you would just GIVE ME A WEAPON!",0,3,oMessageCutscene,1)
  else if sceneProgress=12 and bWaitForInput=false
    msgCreate(0,0,"'The Chosen One'","Nonsense, it is part of my destiny to bring you safely through here! And now for this slime!",6,3,oMessageCutscene,1)
  else if sceneProgress=13
  {
    sceneDelay+=1
    if sceneDelay=10 {oWHB_NPC.sprite_index=sWHB_Walk; oWHB_NPC.image_speed=0}
    else if sceneDelay=11
    {
      oWHB_NPC.x=992; oWHB_NPC.y=224
      playSound(global.snd_ComicHit1,0,0.95,27000)
      var tEffect;
      tEffect=instance_create(oMisc.x,oMisc.y-20,oEffect)
      tEffect.sprite_index=sRobotExplosion; tEffect.followID=-1; tEffect.xFollow=0; tEffect.yFollow=0
      tEffect.newBlend=1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
      tEffect.image_xscale=1.5; tEffect.image_yscale=1.5; tEffect.image_speed=0.5
      var tFlash; tFlash=instance_create(x,y,oScreenFlash); tFlash.fadeSpeed=0.2
      with (428761) {instance_destroy()}
    }
    else if sceneDelay=35 {oWHB_NPC.sprite_index=sWHB_AnimStand; oWHB_NPC.image_speed=0.15}
    else if sceneDelay=50 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=14 and bWaitForInput=false
    msgCreate(0,0,"'The Chosen One'","Oh man, did you see that!",6,3,oMessageCutscene,1)
  else if sceneProgress=15 and bWaitForInput=false
  {
    oWHB_NPC.image_xscale=-1
    msgCreate(0,0,"'The Chosen One'","DID YOU SEE THAT?!",6,3,oMessageCutscene,1)
  }
  else if sceneProgress=16 and bWaitForInput=false
    msgCreate(0,0,"Claire","Unfortunately, yes. Now can we just move on?",0,3,oMessageCutscene,1)
  else if sceneProgress=17 and bWaitForInput=false
    msgCreate(0,0,"'The Chosen One'","Yes, we should do that. Please keep up, there's a destiny to fulfill!",6,3,oMessageCutscene,1)
  else if sceneProgress=18
  {
    with oMisc {instance_destroy()}
    oWHB_NPC.image_xscale=1
    oWHB_NPC.xVel=oWHB_NPC.runAcc
    sceneDelay=0; sceneProgress=0
    global.gameProgress=3421
    global.gamePaused=false
  }
}
else if global.gameProgress=3421 and room=rGame6_HeroPlainsB //----- [5] 'The Chosen One' went ahead -----
{
  if sceneProgress=0
  {
    sceneDelay+=1
    if sceneDelay=1 {global.gamePaused=true}
    else if sceneDelay>=30 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=1 and bWaitForInput=false
    msgCreate(0,0,"Claire","Where did doofus go?",0,3,oMessageCutscene,1)
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","He ran ahead.",0,3,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Claire","So much for his destiny.",0,3,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","There's a spring a few maps to the right.",0,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Claire","What are we going to do about my lack of offensive abilities?",0,3,oMessageCutscene,1)
  else if sceneProgress=6 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","We'll figure something out. That 'Chosen One' guy mentioned a Blade Strike and Guard skill that seemed to be tagged. If the past has taught us anything, well you know.",0,3,oMessageCutscene,1)
  else if sceneProgress=7 and bWaitForInput=false
    msgCreate(0,0,"Claire","True. Really, why am I asking where that guy went, things are better without him.",0,3,oMessageCutscene,1)
  else if sceneProgress=8
  {
    sceneDelay=0; sceneProgress=0
    global.gameProgress=3422
    global.gamePaused=false
  }
}
else if global.gameProgress=3422 and room=rGame6_HeroPlainsD //----- [6] Spring Water -----
{
  if sceneProgress=0
  {
    if oPlayer1.x>=1264
    {
      global.gamePaused=true
      oPlayer1.y+=4
      if oPlayer1.y>=208
      {
        scenePChk(oPlayer1.x,208,0,0.1,1)
        stopPlayer()
        sceneProgress+=1
      }
    }
  }
  else if sceneProgress=1 and bWaitForInput=false
    msgCreate(0,0,"'The Chosen One'","We've reached the spring water and fulfilled part of my destiny!",6,3,oMessageCutscene,1)
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"Claire","You kinda ditched me back there.",0,3,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"'The Chosen One'","Nonsense, you simply utilized all that I had taught you. You've learned well.",6,3,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Claire","Riiight. Now that we're here, we can gather the spring water.",0,3,oMessageCutscene,1)
  else if sceneProgress=5
  {
    sceneDelay+=1
    if sceneDelay=1
    {
      npcChosen=instance_create(1472,240,oMisc)
      npcChosen.type=1; npcChosen.sprite_index=sSpringLight; npcChosen.image_alpha=0.7
    }
    else if sceneDelay>=2 and sceneDelay<=299
    {
      npcChosen.y-=1
      if npcChosen.y<=144 {sceneDelay=300}
    }
    else if sceneDelay=330 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=6 and bWaitForInput=false
    msgCreate(0,0,"Claire","What is that thing?",0,3,oMessageCutscene,1)
  else if sceneProgress=7 and bWaitForInput=false
    msgCreate(0,0,"The Prophecy","I am The Prophecy. I've waited here till the one with a great destiny would appear here.",6,3,oMessageCutscene,1)
  else if sceneProgress=8 and bWaitForInput=false
    msgCreate(0,0,"'The Chosen One'","Oh oh! That's me!! Tell me about how I can further my steps through my destiny!",6,3,oMessageCutscene,1)
  else if sceneProgress=9 and bWaitForInput=false
    msgCreate(0,0,"The Prophecy","It is you, Claire. You have a great destiny ahead of you here.",6,3,oMessageCutscene,1)
  else if sceneProgress=10 and bWaitForInput=false
  {
    oWHB_NPC.image_xscale=-1
    msgCreate(0,0,"'The Chosen One'","What?!",6,3,oMessageCutscene,1)
  }
  else if sceneProgress=11 and bWaitForInput=false
    msgCreate(0,0,"The Prophecy","You Claire. Are the Chosen One that will bring this land to peace.",6,3,oMessageCutscene,1)
  else if sceneProgress=12 and bWaitForInput=false
    msgCreate(0,0,"'The Chosen One'","But I'm 'The Chosen One'!! This is about me!!",6,3,oMessageCutscene,1)
  else if sceneProgress=13 and bWaitForInput=false
    msgCreate(0,0,"Claire","I like where this is going.",0,3,oMessageCutscene,1)
  else if sceneProgress=14 and bWaitForInput=false
    msgCreate(0,0,"The Prophecy","You Claire, you will be the one to gather the 4 Crystals and keep them from the Great Evil Overlord who wants to bring a terrible thing to these lands.",6,3,oMessageCutscene,1)
  else if sceneProgress=15 and bWaitForInput=false
    msgCreate(0,0,"Claire","Wait what?",0,3,oMessageCutscene,1)
  else if sceneProgress=16 and bWaitForInput=false
    msgCreate(0,0,"The Prophecy","The Great Evil Overlord is trying to find the 4 Crystals. If he gathers them all, he will have the power to bring a great calamity to the land.",6,3,oMessageCutscene,1)
  else if sceneProgress=17 and bWaitForInput=false
    msgCreate(0,0,"'The Chosen One'","This is wrong. All wrong! This is supposed to be about me!",6,3,oMessageCutscene,1)
  else if sceneProgress=18 and bWaitForInput=false
    msgCreate(0,0,"Claire","I didn't come here to know all this, I just need the Spring Water.",0,3,oMessageCutscene,1)
  else if sceneProgress=19 and bWaitForInput=false
    msgCreate(0,0,"The Prophecy","Then take the Spring Water and help your friend. You will fulfill the destiny.",6,3,oMessageCutscene,1)
  else if sceneProgress=20
  {
    sceneDelay+=1
    if sceneDelay>=1 and sceneDelay<=7
    {
      npcChosen.image_alpha-=0.1
    }
    else if sceneDelay=20
    {
      with npcChosen {instance_destroy()}
      sceneDelay=0; sceneProgress+=1
    }
  }
  else if sceneProgress=21 and bWaitForInput=false
    msgCreate(0,0,"'The Chosen One'","This is so wrong... and so angering!",6,3,oMessageCutscene,1)
  else if sceneProgress=22 and bWaitForInput=false
    msgCreate(0,0,"Claire","Oh whatever. Though I still need a weapon.",0,3,oMessageCutscene,1)
  else if sceneProgress=23
  {
    sceneDelay+=1
    if sceneDelay=1
    {
      enemySkele=instance_create(1408,0,oMisc)
      enemySkele.type=1; enemySkele.sprite_index=sPT_Skeleton_Jump; enemySkele.image_xscale=-1; enemySkele.image_index=1; enemySkele.image_speed=0
    }
    else if sceneDelay>=2 and sceneDelay<=99
    {
      enemySkele.x-=1; enemySkele.y+=6
      if enemySkele.y>=208
      {
        playSound(global.snd_ChargeStrike,0,0.95,1)
        WHB_Yvel=-6
        enemySkele.sprite_index=sPT_Skeleton_Walk; enemySkele.image_index=0; enemySkele.y=208
        oWHB_NPC.sprite_index=sWHB_HitBack; oWHB_NPC.image_xscale=1
        sceneDelay=100
      }
    }
    else if sceneDelay>=101 and sceneDelay<=199
    {
      oWHB_NPC.x-=7.5; oWHB_NPC.y+=WHB_Yvel
      if WHB_Yvel<8 {WHB_Yvel+=0.3}

      if oWHB_NPC.x<=1200 {oPlayer1.image_xscale=-1}
      if oWHB_NPC.y>=272
      {
        oWHB_NPC.sprite_index=sWHB_LayDown; oWHB_NPC.y=272
        sceneDelay=200
      }
    }
    else if sceneDelay=230 {WHB_Yvel=1 ;sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=24 and bWaitForInput=false
    msgCreate(0,0,"'The Chosen One'","Oh the pain!! THE PAIN!!",6,3,oMessageCutscene,1)
  else if sceneProgress=25 and bWaitForInput=false
    msgCreate(0,0,"Claire","You're really not all that hurt. It would be nice if you'd get up and take care of this skeleton, seeing how you're chosen or something AND YOU HAVE A WEAPON!",0,3,oMessageCutscene,1)
  else if sceneProgress=26 and bWaitForInput=false
    msgCreate(0,0,"'The Chosen One'","But I'm in so much pain! I can't get up!",6,3,oMessageCutscene,1)
  else if sceneProgress=27 and bWaitForInput=false
    msgCreate(0,0,"Claire","Ugh...",0,3,oMessageCutscene,1)
  else if sceneProgress=28
  {
    sceneDelay+=1
    if sceneDelay>=1 and sceneDelay<=99
    {
      oPlayer1.x-=7
      if oPlayer1.x<=1200
      {
        oPlayer1.sprite_index=sClaireJump
        WHB_Yvel+=0.3
        oPlayer1.y+=WHB_Yvel
        if oPlayer1.y>=272
        {
          oPlayer1.sprite_index=sClaireWalk; oPlayer1.y=272
          sceneDelay=100
        }
      }
      else {oPlayer1.sprite_index=sClaireWalk; oPlayer1.image_index=0.5}
    }
    else if sceneDelay>=101 and sceneDelay<=199
    {
      oPlayer1.x-=7; oPlayer1.image_index=0.5
      if oPlayer1.x<=oWHB_NPC.x+20
      {
        oPlayer1.sprite_index=sClaireIdle; oPlayer1.image_index=0.1
        sceneDelay=200
      }
    }
    else if sceneDelay=220 {oPlayer1.sprite_index=sClaireDuck}
    else if sceneDelay=250 {oPlayer1.sprite_index=sClaireIdle}
    else if sceneDelay=280 {oPlayer1.image_xscale=1; sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=29 and bWaitForInput=false
    msgCreate(0,0,"'The Chosen One'","Hey! That's mine!",6,3,oMessageCutscene,1)
  else if sceneProgress=30 and bWaitForInput=false
    msgCreate(0,0,"Claire","Not anymore since you're being a wuss.",0,3,oMessageCutscene,1)
  else if sceneProgress=31 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Claire, do you remember what he said earlier about Blade Strike and Guard?",0,3,oMessageCutscene,1)
  else if sceneProgress=32 and bWaitForInput=false
    msgCreate(0,0,"Claire","Sorta. Since it came from his mouth, I kind of ignored most of it.",0,3,oMessageCutscene,1)
  else if sceneProgress=33 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Fair enough. You'll use [Action A] to use [Blade Strike].#And [Action B] to use [Guard]. And... hmm, I'll just copy paste his wording of guarding.",0,3,oMessageCutscene,1)
  else if sceneProgress=34 and bWaitForInput=false
    msgCreate(0,0,"Jeremy's copypaste of 'The Chosen One's wording","Nonsense, I would simply use [Guard] and negate its attack! When you hold the guard button, you'll block all incoming melee attacks. But you have to be careful or your shield will break.",6,3,oMessageCutscene,1)
  else if sceneProgress=35 and bWaitForInput=false
    msgCreate(0,0,"Jeremy's copypaste of 'The Chosen One's wording","When that happens, you'll take double damage from every source until it regenerates. There's a trick too! If you guard right when the enemy's attack would connect, you'll parry.",6,3,oMessageCutscene,1)
  else if sceneProgress=36 and bWaitForInput=false
    msgCreate(0,0,"Jeremy's copypaste of 'The Chosen One's wording","For a very short time after this, you cannot take any damage (except from projectiles) AND, your attacks will deal triple damage. Also your shield completely regenerates after the parry state is over.",6,3,oMessageCutscene,1)
  else if sceneProgress=37 and bWaitForInput=false
    msgCreate(0,0,"Claire","Okay, let's do this then.",0,3,oMessageCutscene,1)
  else if sceneProgress=38
  {
    with oMisc {instance_destroy()}
    with oWHB_NPC {instance_destroy()}
    oPlayer1.x=1005; oPlayer1.y=272
    global.newMapX=1005; global.newMapY=272
    instance_create(0,0,oCheckpointNotice)
    global.hasAbilToken[6]=2
    global.activeAbility[1]=3
    sceneDelay=0; sceneProgress=0
    global.gameProgress=3430
    global.gamePaused=false
  }
}
else if global.gameProgress=3430 and room=rGame6_HeroPlainsD //----- [] Fight the skeleton -----
{
  if sceneProgress=0
  {
    instance_create(985,272,oWHB_NPC)
    oWHB_NPC.type=1; oWHB_NPC.sprite_index=sWHB_LayDown; oWHB_NPC.image_speed=0.15; oWHB_NPC.type=100
    enemyBarrier=instance_create(872,0,oEnemyBarrier); enemyBarrier.image_yscale=14
    enemyBarrier=instance_create(1200,0,oEnemyBarrier); enemyBarrier.image_yscale=14
    global.tempAction[0]=3
    createEnemy(1136,272,oPT_Skeleton,0,1,1)
    sceneProgress=1
  }
  else if sceneProgress=1
  {
    if !instance_exists(oPT_Skeleton)
    {
      global.gamePaused=true
      with oEnemyBarrier {instance_destroy()}
      var tFlash; tFlash=instance_create(x,y,oScreenFlash); tFlash.fadeSpeed=0.2
      oPlayer1.x=1088; oPlayer1.y=272; oPlayer1.sprite_index=sClaireIdle; oPlayer1.image_xscale=-1; oPlayer1.image_speed=0.1
      oWHB_NPC.sprite_index=sWHB_AnimStand
      sceneProgress=2
    }
  }
  else if sceneProgress=2
  {
    sceneDelay+=1
    if sceneDelay>=30 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(112,128,"","Claire obtained the [Spring Water]! For plot convenience, she has something to store it in.",6,2,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Claire","Well that was easy.",0,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"'The Chosen One'","This is still upsetting that the prophecy wasn't about me!",6,3,oMessageCutscene,1)
  else if sceneProgress=6 and bWaitForInput=false
    msgCreate(0,0,"Claire","Oh get over it.",0,3,oMessageCutscene,1)
  else if sceneProgress=7 and bWaitForInput=false
    msgCreate(0,0,"'The Chosen One'","Well then, since we're done here, I should go! I must find where my destiny brings me next!",6,3,oMessageCutscene,1)
  else if sceneProgress=8
  {
    sceneDelay+=1
    if sceneDelay=1 {oWHB_NPC.sprite_index=sWHB_Walk; oWHB_NPC.image_speed=0.2; oWHB_NPC.image_xscale=-1; WHB_Yvel=0}
    else if sceneDelay>=2 and sceneDelay<=99
    {
      oWHB_NPC.x-=6
      oWHB_NPC.y+=WHB_Yvel
      if sceneDelay=6 {WHB_Yvel=-6; oWHB_NPC.sprite_index=sWHB_Jump}
      else if sceneDelay>=7 {WHB_Yvel+=0.3}

      if oWHB_NPC.x<=688 {sceneDelay=100}
    }
    else if sceneDelay>=130 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=9 and bWaitForInput=false
    msgCreate(0,0,"Claire","He still had his weapon somehow...",0,3,oMessageCutscene,1)
  else if sceneProgress=10 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Now that you've got the water, let's get back to Jerry.",0,3,oMessageCutscene,1)
  else if sceneProgress=11 and bWaitForInput=false
    msgCreate(0,0,"Claire","Yes, then we can figure out where that Chip is.",0,3,oMessageCutscene,1)
  else if sceneProgress=12 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","It probably has to do with that prophecy and that overlord guy it mentioned.",0,3,oMessageCutscene,1)
  else if sceneProgress=13 and bWaitForInput=false
    msgCreate(0,0,"Claire","Oh yeah! Probably... And you know, if that chosen guy ends up being the overlord's right hand man, I'm gonna be pissed.",0,3,oMessageCutscene,1)
  else if sceneProgress=14 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Why?",0,3,oMessageCutscene,1)
  else if sceneProgress=15 and bWaitForInput=false
    msgCreate(0,0,"Claire","That's way too predictable and just dumb!",0,3,oMessageCutscene,1)
  else if sceneProgress=16
  {
    with oWHB_NPC {instance_destroy()}
    sceneDelay=0; sceneProgress=0
    global.gameProgress=3440
    global.gamePaused=false
  }
}
else if global.gameProgress=3440 and room=rGame6_HeroPlainsF //----- [] Enemy trap event for the Game Energy -----
{
  if sceneProgress=0
  {
    if oPlayer1.x>=416
    {
      global.tempAction[0]=3
      var enemyBarrier,tempMplay;
      enemyBarrier=instance_create(192,48,oEnemyBarrier); enemyBarrier.image_yscale=10
      enemyBarrier=instance_create(592,48,oEnemyBarrier); enemyBarrier.image_yscale=12
      tempMplay=findMusic(809)
      playMusic(tempMplay,0,0)
      sceneProgress+=1
    }
  }
  else if sceneProgress=1
  {
    if global.gamePaused=false
    {
      sceneDelay+=1
      if sceneDelay=10
      {
        delaySpawn(256,240,oPT_Skeleton,0,1,1,0.33)
      }
      else if sceneDelay=60 {sceneDelay=0; sceneProgress+=1}
    }
  }
  else if sceneProgress=2
  {
    if !instance_exists(oPT_Skeleton) {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=3
  {
    if global.gamePaused=false
    {
      sceneDelay+=1
      if sceneDelay=10
      {
        delaySpawn(560,240,oPT_Skeleton,0,1,1,0.33)
      }
      else if sceneDelay=60 {sceneDelay=0; sceneProgress+=1}
    }
  }
  else if sceneProgress=4
  {
    if !instance_exists(oPT_Skeleton) {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=5
  {
    if global.gamePaused=false
    {
      sceneDelay+=1
      if sceneDelay=10
      {
        delaySpawn(256,240,oPT_Skeleton,0,1,1,0.33)
        delaySpawn(560,240,oPT_Skeleton,0,1,1,0.33)
      }
      else if sceneDelay=60 {sceneDelay=0; sceneProgress+=1}
    }
  }
  else if sceneProgress=6
  {
    if !instance_exists(oPT_Skeleton)
    {
      with oEnemyBarrier {instance_destroy()}
      var tempMplay;
      tempMplay=findMusic(602)
      playMusic(tempMplay,0,0)
      sceneProgress=10
    }
  }
}
else if global.gameProgress=3440 and room=rGame6_Hometown //----- [8] Recover Jerry... but not really -----
{
  if sceneProgress=0
  {
    if oPlayer1.x>=668
    {
      fadeColor=c_black
      global.gamePaused=true
      oPlayer1.y+=4
      if oPlayer1.y>=296
      {
        scenePChk(oPlayer1.x,296,0,0.1,1)
        stopPlayer()
        sceneProgress+=1
      }
    }
  }
  else if sceneProgress=1
  {
    sceneDelay+=1
    if sceneDelay>=15 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"Claire","I got the water!",0,3,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"NPC A","I will apply it for you. Hand it to me.",6,3,oMessageCutscene,1)
  else if sceneProgress=4
  {
    sceneDelay+=1
    if sceneDelay>=11 and sceneDelay<=20 {fadeAlpha+=0.1}
    else if sceneDelay>=40 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"","One moment later...#[Animation omitted due to time and budget constraints]",0,3,oMessageCutscene,1)
  else if sceneProgress=6
  {
    sceneDelay+=1
    if sceneDelay>=11 and sceneDelay<=20 {fadeAlpha-=0.1}
    else if sceneDelay>=40 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=7 and bWaitForInput=false
    msgCreate(0,0,"NPC A","And it is done.",6,3,oMessageCutscene,1)
  else if sceneProgress=8 and bWaitForInput=false
    msgCreate(0,0,"Claire","But he's not awake.",0,3,oMessageCutscene,1)
  else if sceneProgress=9 and bWaitForInput=false
    msgCreate(0,0,"NPC A","You have to give it time.",6,3,oMessageCutscene,1)
  else if sceneProgress=10 and bWaitForInput=false
    msgCreate(0,0,"Claire","Like a few seconds or so?",0,3,oMessageCutscene,1)
  else if sceneProgress=11 and bWaitForInput=false
    msgCreate(0,0,"NPC A","Much more time than that, my friend. His amnesia was brought on by emotional trauma. It will take the water some time to work its magic on him.",6,3,oMessageCutscene,1)
  else if sceneProgress=12 and bWaitForInput=false
    msgCreate(0,0,"Claire","...",0,3,oMessageCutscene,1)
  else if sceneProgress=13 and bWaitForInput=false
    msgCreate(0,0,"Claire","Will he continue to be safe here?",0,3,oMessageCutscene,1)
  else if sceneProgress=14 and bWaitForInput=false
    msgCreate(0,0,"NPC A","Yes, I can assure you nothing comes around here anymore. You're the only things I've seen, both human and bot, around here for quite some time.",6,3,oMessageCutscene,1)
  else if sceneProgress=15 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Tell us about this Evil Overlord that we heard about from the prophecy.",0,3,oMessageCutscene,1)
  else if sceneProgress=16
  {
    sceneDelay+=1
    if sceneDelay=25 {showEmote(oNPC_GeneralC,0,-56,sEmThinking)}
    if sceneDelay>=45 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=17 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Well?",0,3,oMessageCutscene,1)
  else if sceneProgress=18 and bWaitForInput=false
    msgCreate(0,0,"Claire","Jeremy, he can't hear you.",0,3,oMessageCutscene,1)
  else if sceneProgress=19 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Oh right.",0,3,oMessageCutscene,1)
  else if sceneProgress=20 and bWaitForInput=false
    msgCreate(0,0,"Claire","We heard about some Evil Overlord from the prophecy. Do you know anything about him?",0,3,oMessageCutscene,1)
  else if sceneProgress=21 and bWaitForInput=false
    msgCreate(0,0,"NPC A","The Great Evil Overlord resides in a massive castle, far away from those who cannot fly. Even if one were to reach him, they could not harm him.",6,3,oMessageCutscene,1)
  else if sceneProgress=22 and bWaitForInput=false
    msgCreate(0,0,"NPC A","In order to do so, one would need the 4 Elemental Crystals.",6,3,oMessageCutscene,1)
  else if sceneProgress=23 and bWaitForInput=false
    msgCreate(0,0,"Claire","Really? Are you serious?",0,3,oMessageCutscene,1)
  else if sceneProgress=24 and bWaitForInput=false
    msgCreate(0,0,"NPC A","Quite serious. I would retrieve them myself, but bots like me cannot get into the temples. You however, could do so.",6,3,oMessageCutscene,1)
  else if sceneProgress=25 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","That's the only way to defeat him?",0,3,oMessageCutscene,1)
  else if sceneProgress=26 and bWaitForInput=false
    msgCreate(0,0,"Claire","Silly question Jeremy, did you ever play the old rpgs?",0,3,oMessageCutscene,1)
  else if sceneProgress=27 and bWaitForInput=false
    msgCreate(0,0,"NPC A","I assure you it is the only way.",6,3,oMessageCutscene,1)
  else if sceneProgress=28 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Hmm...",0,3,oMessageCutscene,1)
  else if sceneProgress=29 and bWaitForInput=false
    msgCreate(0,0,"Claire","We can't leave Jerry here that long.",0,3,oMessageCutscene,1)
  else if sceneProgress=30 and bWaitForInput=false
    msgCreate(0,0,"NPC A","Perhaps one of the crystals could speed up the healing process. Get yourself to the Great Earth Temple! The power of the land can cure him.",6,3,oMessageCutscene,1)
  else if sceneProgress=31 and bWaitForInput=false
    msgCreate(0,0,"Claire","Sigh... Well if that will help him. I just don't want to leave him like this for too long.",0,3,oMessageCutscene,1)
  else if sceneProgress=32 and bWaitForInput=false
    msgCreate(0,0,"NPC A","No harm will come to him.",6,3,oMessageCutscene,1)
  else if sceneProgress=33 and bWaitForInput=false
    msgCreate(0,0,"Claire","You better hope not!",0,3,oMessageCutscene,1)
  else if sceneProgress=34
  {
    fadeAlpha=0
    var tNewChapter;
    tNewChapter=instance_create(0,0,oChapterDisplay)
    tNewChapter.newChapter="Act 2#The Great Earth Temple"
    sceneDelay=0; sceneProgress=0
    global.gameProgress=3450
    global.gamePaused=false
  }
}
else if global.gameProgress=3450 and room=rGame6_EarthA //----- [9] Earth Temple entrance and Jerry is awake -----
{
  if sceneProgress=0
  {
    sceneDelay+=1
    if sceneDelay=1 {global.gamePaused=true}
    else if sceneDelay>=30 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=1 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Hey, Jerry disappeared.",0,3,oMessageCutscene,1)
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"Claire","Wait what?!",0,3,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Don't worry, Claire. He's fine. Trust me on that.",0,3,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Claire","You're absolutely sure?",0,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","100% sure. Just keep going to the Earth Crystal. We'd have to get it anyway.",0,3,oMessageCutscene,1)
  else if sceneProgress=6
  {
    sceneDelay=0; sceneProgress=0
    global.gameProgress=3460
    global.gamePaused=false
  }
}
else if global.gameProgress=3460 and room=rGame6_EarthG //----- [] Enemy trap event -----
{
  if sceneProgress=0
  {
    if oPlayer1.x>=1248
    {
      with oEnemyBase {instance_destroy()}
      var enemyBarrier;
      enemyBarrier=instance_create(1040,96,oEnemyBarrier); enemyBarrier.image_yscale=10
      enemyBarrier=instance_create(1440,160,oEnemyBarrier); enemyBarrier.image_yscale=6
      sceneProgress+=1
    }
  }
  else if sceneProgress=1
  {
    if global.gamePaused=false
    {
      sceneDelay+=1
      if sceneDelay=10
      {
        global.tempAction[0]=11
        delaySpawn(1104,272,oPT_Slime,0,1,1,0.33)
        delaySpawn(1392,272,oPT_Slime,0,1,1,0.33)
      }
      else if sceneDelay=60 {sceneDelay=0; sceneProgress+=1}
    }
  }
  else if sceneProgress=2
  {
    if !instance_exists(oPT_Slime) {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=3
  {
    if global.gamePaused=false
    {
      sceneDelay+=1
      if sceneDelay=10
      {
        global.tempAction[0]=12
        delaySpawn(1120,272,oPT_Slime,0,1,1,0.33)
        delaySpawn(1376,272,oPT_Slime,0,1,1,0.33)
      }
      else if sceneDelay=60 {sceneDelay=0; sceneProgress+=1}
    }
  }
  else if sceneProgress=4
  {
    if !instance_exists(oPT_Slime)
    {
      with oEnemyBarrier {instance_destroy()}
      sceneProgress+=1
    }
  }
  else if sceneProgress=5
  {
    if oPlayer1.x>=2128
    {
      with oEnemyBase {instance_destroy()}
      var enemyBarrier;
      enemyBarrier=instance_create(1888,64,oEnemyBarrier); enemyBarrier.image_yscale=14
      enemyBarrier=instance_create(2352,64,oEnemyBarrier); enemyBarrier.image_yscale=14
      sceneProgress+=1
    }
  }
  else if sceneProgress=6
  {
    if global.gamePaused=false
    {
      sceneDelay+=1
      if sceneDelay=10
      {
        global.tempAction[0]=11
        delaySpawn(1984,224,oPT_Slime,0,1,1,0.33)
        delaySpawn(2272,224,oPT_Slime,0,1,1,0.33)
      }
      else if sceneDelay=60 {sceneDelay=0; sceneProgress+=1}
    }
  }
  else if sceneProgress=7
  {
    if !instance_exists(oPT_Slime) {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=8
  {
    if global.gamePaused=false
    {
      sceneDelay+=1
      if sceneDelay=10
      {
        global.tempAction[0]=12
        delaySpawn(2048,224,oPT_Slime,0,1,1,0.33)
        delaySpawn(2208,224,oPT_Slime,0,1,1,0.33)
      }
      else if sceneDelay=60 {sceneDelay=0; sceneProgress+=1}
    }
  }
  else if sceneProgress=9
  {
    if !instance_exists(oPT_Slime)
    {
      with oEnemyBarrier {instance_destroy()}
      sceneProgress=0
      global.gameProgress=3470
    }
  }
}
else if global.gameProgress=3470 and room=rGame6_EarthJ //----- [] Boss Fight: The Stone Golem -----
{
  if global.bossTrack=0
  {
    if sceneProgress=0
    {
      if oPlayer1.x>=352
      {
        global.gamePaused=true
        oPlayer1.y+=4
        if oPlayer1.y>=288
        {
          scenePChk(352,288,0,0.1,1)
          stopPlayer()
          sceneProgress+=1
        }
      }
    }
    else if sceneProgress=1
    {
      sceneDelay+=1
      if sceneDelay=30
      {
        var tempMplay;
        tempMplay=findMusic(819)
        playMusic(tempMplay,0,0)
      }
      if sceneDelay=40
      {
        npcBoss=instance_create(512,288,oMisc)
        npcBoss.sprite_index=sPT_StoneGolem_Idle; npcBoss.image_xscale=-1; npcBoss.image_yscale=0.01
        npcBoss.image_speed=0; npcBoss.type=1
      }
      else if sceneDelay>=41
      {
        if sceneDelay mod 5=0 {playSound(global.snd_MetroidBomb,0,1,1)}

        for(i=0;i<4;i+=1)
        {
          var tEffect,tXSpd;
          tEffect=instance_create(npcBoss.x+random_range(-20,20),npcBoss.y+2-random(npcBoss.sprite_height+4),oEffect)
          tEffect.sprite_index=sMMSmokeCloud; tEffect.xSpd=0; tEffect.ySpd=0; tEffect.decay=-100; tEffect.image_speed=0.5
          tEffect.newBlend=-1; tEffect.followID=-1
        }

        tXSpd=random_range(-3,3)
        tEffect=instance_create(npcBoss.x+random_range(-16,16),npcBoss.y+random_range(-2,2),oEffectGrav)
        tEffect.sprite_index=sDTitanRock; tEffect.xSpd=tXSpd; tEffect.ySpd=-9+random(3); tEffect.fadeSpd=0.04
        tEffect.type=2; tEffect.grav=0.8; tEffect.rotation=tXSpd*2; tEffect.newBlend=-1; tEffect.followID=-1
        tEffect.image_xscale=0.25; tEffect.image_yscale=0.25

        npcBoss.image_yscale+=0.01
        if npcBoss.image_yscale>=1 {sceneDelay=0; sceneProgress+=1}
      }
    }
    else if sceneProgress=2
    {
      sceneDelay+=1
      if sceneDelay=40 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=3
    {
      global.gamePaused=false
      var tBossTitle,enemyBarrier;
      tBossTitle=instance_create(0,0,oBossNameDisplay)
      tBossTitle.bossName="The Stone Golem"
      tBossTitle.bossTitle="Earth Crystal Guardian"
      enemyBarrier=instance_create(176,224,oEnemyBarrier); enemyBarrier.image_yscale=4
      enemyBarrier=instance_create(640,224,oEnemyBarrier); enemyBarrier.image_yscale=4
      boss=instance_create(512,288,oPT_StoneGolem)
      boss.activateBoss=1
      global.currentBoss="Stone Golem"
      global.bossTrack=1
      with oMisc {instance_destroy()}
      viewFix=instance_create(416,176,oMisc)
      viewFix.type=0
      viewFix.sprite_index=sNull
      view_object[0]=viewFix
      storeStatus(0)
      sceneDelay=0; sceneProgress=0
    }
  }
  else if global.bossTrack=1
  {
    if sceneProgress=1 //End Boss
    {
      global.gamePaused=true
      view_object[0]=oPlayer1
      awardBossAP(5500)
      global.bossTrack=2
      sceneProgress=0
    }
  }
  else if global.bossTrack=2
  {
    if sceneProgress=0
    {
      var tFullHeartDrop,tempMplay;
      tFullHeartDrop=instance_create(416,128,oHealthPickup)
      tFullHeartDrop.sprite_index=sFullHealthPickup
      tempMplay=findMusic(605)
      playMusic(tempMplay,0,0)
      with oEnemyBarrier {instance_destroy()}
      global.gamePaused=false
      global.currentBoss=""
      global.bossTrack=0
      global.gameProgress=3480
    }
  }
}
else if global.gameProgress=3480 and room=rGame6_EarthK //----- [] Obtain Earth Crystal -----
{
  if sceneProgress=0
  {
    if oPlayer1.x>=240
    {
      global.gamePaused=true
      oPlayer1.y+=4
      if oPlayer1.y>=224
      {
        scenePChk(oPlayer1.x,224,0,0.1,1)
        stopPlayer()
        fadeColor=c_black
        sceneProgress+=1
      }
    }
  }
  else if sceneProgress=1
  {
    sceneDelay+=1
    if sceneDelay>=15 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","There it is. The first of the four.",0,3,oMessageCutscene,1)
  else if sceneProgress=3
  {
    sceneDelay+=1
    if sceneDelay>=11 and sceneDelay<=46 {oLevelDecal.y+=1}
    else if sceneDelay>=61 and sceneDelay<=70 {oLevelDecal.image_alpha-=0.1}
    else if sceneDelay>=90 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Claire","I'm worried about Jerry...",0,3,oMessageCutscene,1)
  else if sceneProgress=5
  {
    fadeAlpha+=0.02
    if fadeAlpha>=1
    {
      var tempMplay;
      tempMplay=findMusic(0)
      playMusic(tempMplay,0,0)
      oPlayer1.life=oPlayer1.maxLife
      global.pLife=global.pMaxLife
      global.activeCharacter=0
      global.charScan[0]=0; global.charScan[1]=0
      global.newMapX=192; global.newMapY=272
      room_goto(rGame6_JDream)
    }
  }
}

else if global.gameProgress=3480 and room=rGame6_JDream //----- [10] Jerry's dream -----
{
  if sceneProgress=0
  {
    sceneDelay+=1
    if sceneDelay>=30
    {
      fadeAlpha-=0.04
      if fadeAlpha<=0 {sceneDelay=0; sceneProgress+=1}
    }
  }
  else if sceneProgress=1 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Huh, and suddenly I'm in a forest...",0,3,oMessageCutscene,1)
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Looks like you're in some dream sequence right now.",0,3,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Oh, hey Jeremy! Didn't realize you could see me. You hadn't answered earlier when I woke up around some old guy.",0,3,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","I was watching Claire, well, I still am. I'm assuming the old guy told you to come here?",0,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Pretty much. He said something about me having amnesia and some Elemental Crystals, but I cut him off there. Was way too cliche for me.",0,3,oMessageCutscene,1)
  else if sceneProgress=6 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Yeah... While you were out, Claire and I found out that we're gonna need those crystals to fight against an evil overlord.",0,3,oMessageCutscene,1)
  else if sceneProgress=7 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Holy bad writing, Jeremy!",0,3,oMessageCutscene,1)
  else if sceneProgress=8 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","We just gotta go with it. I'm sure beating that overlord will reveal the Program Chip.",0,3,oMessageCutscene,1)
  else if sceneProgress=9 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Alrighty, well I was heading toward the Fire Crystal, but the moment I went into a fire cave, I wound up here. How do I get out of this?",0,3,oMessageCutscene,1)
  else if sceneProgress=10 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Hmm, Claire ran across something called The Prophecy earlier. I'd say move forward, you're bound to run into something like it. This place is pretty predictable and you were mentioned in that prophecy.",0,3,oMessageCutscene,1)
  else if sceneProgress=11 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Nice, at least I'm awesome enough to be part of a prophecy.",0,3,oMessageCutscene,1)
  else if sceneProgress=12 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Oh yeah, Chao is with Claire, so you won't have any damage or HP pop ups for now.",0,3,oMessageCutscene,1)
  else if sceneProgress=13
  {
    var tNewChapter,tempMplay;
    tNewChapter=instance_create(0,0,oChapterDisplay)
    tNewChapter.newChapter="Act 3#A Lucid Dream"
    tempMplay=findMusic(606)
    playMusic(tempMplay,0,0)
    sceneDelay=0; sceneProgress=0
    global.gameProgress=3490
    global.gamePaused=false
  }
}
else if global.gameProgress=3490 and room=rGame6_JDream //----- [11] Jerry's destiny -----
{
  if sceneProgress=0
  {
    if oPlayer1.x>=640
    {
      global.gamePaused=true
      oPlayer1.y+=4
      if oPlayer1.y>=272
      {
        scenePChk(oPlayer1.x,272,0,0.1,1)
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
      npcChosen=instance_create(720,208,oMisc)
      npcChosen.type=1; npcChosen.sprite_index=sSpringLight; npcChosen.image_alpha=0.7
    }
    else if sceneDelay=30 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"The Prophecy","You have arrived, Jerry.",6,3,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Yep, I'm awesome. Tell me about my great destiny.",0,3,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","You're really getting into this aren't you?",0,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Might as well, it's all pretty dumb anyway.",0,3,oMessageCutscene,1)
  else if sceneProgress=6 and bWaitForInput=false
    msgCreate(0,0,"The Prophecy","You Jerry, must see to assisting the other Chosen One. You two must gather the...",6,3,oMessageCutscene,1)
  else if sceneProgress=7 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Ah hold up. Crystals, evil overlords, yadda yadda. Jerry knows all this.",0,3,oMessageCutscene,1)
  else if sceneProgress=8 and bWaitForInput=false
    msgCreate(0,0,"The Prophecy","The Evil Overlord will gather...",6,3,oMessageCutscene,1)
  else if sceneProgress=9 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","No really, we know all this.",0,3,oMessageCutscene,1)
  else if sceneProgress=10 and bWaitForInput=false
    msgCreate(0,0,"The Prophecy","You really don't need me?",6,3,oMessageCutscene,1)
  else if sceneProgress=11 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","No, no not really. You can leave.",0,3,oMessageCutscene,1)
  else if sceneProgress=12 and bWaitForInput=false
    msgCreate(0,0,"The Prophecy","I'm a little sad now, but I can do one other thing!",6,3,oMessageCutscene,1)
  else if sceneProgress=13 and bWaitForInput=false
    msgCreate(0,0,"Jerry","It's not a long exposition, is it?",0,3,oMessageCutscene,1)
  else if sceneProgress=14 and bWaitForInput=false
    msgCreate(0,0,"The Prophecy","You need power to fulfill your destiny, power that I can grant you.",6,3,oMessageCutscene,1)
  else if sceneProgress=15 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Oh really now? GIVE IT TO ME!!",0,3,oMessageCutscene,1)
  else if sceneProgress=16
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
        efStars[i].depth=15; efStars[i].type=1; efStars[i].image_alpha=0.4-(0.075*i)
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
      efCharge.image_xscale-=0.1; efCharge.image_yscale-=0.1
    }
    else if sceneDelay=80
    {
      with efCharge {instance_destroy()}
    }
    else if sceneDelay=90
    {
      var tEffect;
      tEffect=instance_create(oPlayer1.x,oPlayer1.y-26,oEffect)
      tEffect.sprite_index=sMMchargeComplete; tEffect.image_xscale=3;tEffect.image_yscale=3
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
      
      with oMisc {instance_destroy()}
      npcChosen=instance_create(720,208,oMisc)
      npcChosen.type=1; npcChosen.sprite_index=sSpringLight; npcChosen.image_alpha=0.7
      sceneDelay=0
      sceneProgress+=1
    }
    else if sceneDelay=100 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=17 and bWaitForInput=false
    msgCreate(112,128,"","Jerry gained [Spam Shot] and [Guard]!",6,2,oMessageCutscene,1)
  else if sceneProgress=18 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Spam Shot... I have an idea of how that works, but how does Guard work here?",0,3,oMessageCutscene,1)
  else if sceneProgress=19 and bWaitForInput=false
    msgCreate(0,0,"The Prophecy","Guard seems to have a slight variance depending on the user. For you, it will only guard against projectile attacks. You can parry them as well if you guard just before the attack connects.",6,3,oMessageCutscene,1)
  else if sceneProgress=20 and bWaitForInput=false
    msgCreate(0,0,"The Prophecy","I've heard that performing a parry makes some users invulnerable for a short time. That won't work for you, but your parry duration for triple damage (only double for you) lasts longer, and increases the range on your Spam Shot.",6,3,oMessageCutscene,1)
  else if sceneProgress=21 and bWaitForInput=false
    msgCreate(0,0,"The Prophecy","There is one other useful thing. When you parry, it will send out a wave of awesome and destroy all projectiles around you.",6,3,oMessageCutscene,1)
  else if sceneProgress=22 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Sounds a little weird, but if that's the rules.",0,3,oMessageCutscene,1)
  else if sceneProgress=23 and bWaitForInput=false
    msgCreate(0,0,"The Prophecy","You'll get used to it.",6,3,oMessageCutscene,1)
  else if sceneProgress=24 and bWaitForInput=false
    msgCreate(0,0,"Jerry","I'm sure.",0,3,oMessageCutscene,1)
  else if sceneProgress=25 and bWaitForInput=false
    msgCreate(0,0,"The Prophecy","Yep.",6,3,oMessageCutscene,1)
  else if sceneProgress=26 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Mhmm.",0,3,oMessageCutscene,1)
  else if sceneProgress=27 and bWaitForInput=false
    msgCreate(0,0,"The Prophecy","... ... ...",6,3,oMessageCutscene,1)
  else if sceneProgress=28 and bWaitForInput=false
    msgCreate(0,0,"Jerry","...",0,3,oMessageCutscene,1)
  else if sceneProgress=29 and bWaitForInput=false
    msgCreate(0,0,"The Prophecy","GO AWAY!",6,3,oMessageCutscene,1)
  else if sceneProgress=30 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Sorry, was just trying to figure out how to end the conversation without it being awkward.",0,3,oMessageCutscene,1)
  else if sceneProgress=31 and bWaitForInput=false
    msgCreate(0,0,"The Prophecy","Just go get the Crystal.",6,3,oMessageCutscene,1)
  else if sceneProgress=32 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","To get out of the dream, just run to the right. You should end up in the fire cave again.",0,3,oMessageCutscene,1)
  else if sceneProgress=33
  {
    with oMisc {instance_destroy()}
    var tNewChapter;
    tNewChapter=instance_create(0,0,oChapterDisplay)
    tNewChapter.newChapter="Act 4#The Fire Tem... err, Cave"
    global.hasAbilToken[5]=2
    global.activeAbility[0]=3
    sceneDelay=0; sceneProgress=0
    global.gameProgress=3500
    global.gamePaused=false
  }
}
else if global.gameProgress=3503 and room=rGame6_FireE //----- [12] Meeting the High Heels Girl -----
{
  if sceneProgress=0
  {
    if oPlayer1.x>=656
    {
      global.gamePaused=true
      oPlayer1.y+=4
      if oPlayer1.y>=304
      {
        scenePChk(oPlayer1.x,304,0,0.1,1)
        stopPlayer()
        sceneProgress+=1
      }
    }
  }
  else if sceneProgress=1
  {
    sceneDelay+=1
    if sceneDelay=1 {showEmote(oMisc,0,-56,sEmExcite)}
    else if sceneDelay=10 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"High Heels Girl","There you are!",6,3,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Well hello there.",0,3,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"High Heels Girl","I've been waiting for you. They said you'd be passing through here soon.",6,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Who is they? And do you want to fight? Cause if so, I haven't had a boss fight yet, I'd love for you to bring it!",0,3,oMessageCutscene,1)
  else if sceneProgress=6 and bWaitForInput=false
    msgCreate(0,0,"High Heels Girl","Well... I WOULD fight you, AND I'd win, but THEY put me out here ill equipped!",6,3,oMessageCutscene,1)
  else if sceneProgress=7 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Seriously, who is they?",0,3,oMessageCutscene,1)
  else if sceneProgress=8 and bWaitForInput=false
    msgCreate(0,0,"High Heels Girl","I can't reveal anything about the Evil Shadowy Council, but still, no way am I fighting in this! How can I fight in the worst outfit in the world! High heels of all things! How can one fight in high heels?!",6,3,oMessageCutscene,1)
  else if sceneProgress=9 and bWaitForInput=false
    msgCreate(0,0,"Jerry","I guess you have a point there. So... we're not fighting?",0,3,oMessageCutscene,1)
  else if sceneProgress=10 and bWaitForInput=false
    msgCreate(0,0,"High Heels Girl","I already told you NO!",6,3,oMessageCutscene,1)
  else if sceneProgress=11 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","She got you there, Jerry.",0,3,oMessageCutscene,1)
  else if sceneProgress=12 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Yeah she did.",0,3,oMessageCutscene,1)
  else if sceneProgress=13 and bWaitForInput=false
    msgCreate(0,0,"High Heels Girl","Don't you refer to me like that!",6,3,oMessageCutscene,1)
  else if sceneProgress=14 and bWaitForInput=false
    msgCreate(0,0,"Jerry","I wasn't... oh right. You can't hear Jeremy.",0,3,oMessageCutscene,1)
  else if sceneProgress=15 and bWaitForInput=false
    msgCreate(0,0,"High Heels Girl","I'm getting out of here. Now you've got imaginary friends and that's just weird.",6,3,oMessageCutscene,1)
  else if sceneProgress=16
  {
    sceneDelay+=1
    if sceneDelay=1
    {
      for(i=0;i<8;i+=1)
      {
        var tEffect;
        tEffect=instance_create(oMisc.x+random_range(-12,12),oMisc.y+2-random(36),oEffect)
        tEffect.sprite_index=sDustCloud; tEffect.xSpd=0; tEffect.ySpd=0; tEffect.decay=-100; tEffect.image_speed=0.5
        tEffect.newBlend=-1; tEffect.followID=-1
      }
    }
    else if sceneDelay=2 {oMisc.image_alpha=0}
    else if sceneDelay=30 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=17 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Evil Shadowy Council eh? This gets more horrible every moment.",0,3,oMessageCutscene,1)
  else if sceneProgress=18 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Hmm, hold up, I'm gonna try something.",0,3,oMessageCutscene,1)
  else if sceneProgress=19 and bWaitForInput=false
    msgCreate(0,0,"Jerry","What?",0,3,oMessageCutscene,1)
  else if sceneProgress=20 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","You'll see, well... I will soon anyway.#And wait a minute... NPC A said bots couldn't come in these places to get the Crystals.",0,3,oMessageCutscene,1)
  else if sceneProgress=21 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Maybe he meant they couldn't go in the Crystal rooms?",0,3,oMessageCutscene,1)
  else if sceneProgress=22 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Maaaybe? I think this place just doesn't work right.",0,3,oMessageCutscene,1)
  else if sceneProgress=23
  {
    with oMisc {instance_destroy()}
    sceneDelay=0; sceneProgress=0
    global.gameProgress=3510
    global.gamePaused=false
  }
}
else if global.gameProgress=3510 and room=rGame6_FireE //----- [] Boss Fight: The Flame Elemental -----
{
  if global.bossTrack=0
  {
    if sceneProgress=0
    {
      if oPlayer1.x>=712
      {
        sceneProgress+=1
      }
    }
    else if sceneProgress=1
    {
      var tBossTitle,enemyBarrier,tempMplay;
      viewFix=instance_create(712,176,oMisc)
      viewFix.type=0
      viewFix.sprite_index=sNull
      view_object[0]=viewFix
      tempMplay=findMusic(819)
      playMusic(tempMplay,0,0)
      tBossTitle=instance_create(0,0,oBossNameDisplay)
      tBossTitle.bossName="The Flame Elemental"
      tBossTitle.bossTitle="Fire Crystal Guardian#      He really sucks"
      enemyBarrier=instance_create(560,112,oEnemyBarrier); enemyBarrier.image_yscale=12
      enemyBarrier=instance_create(848,80,oEnemyBarrier); enemyBarrier.image_yscale=14
      boss=instance_create(712,-48,oPT_FlameElemental)
      boss.activateBoss=1
      global.currentBoss="Flame Elemental"
      global.bossTrack=1
      storeStatus(0)
      sceneDelay=0; sceneProgress=0
    }
  }
  else if global.bossTrack=1
  {
    if sceneProgress=1 //End Boss
    {
      global.gamePaused=true
      view_object[0]=oPlayer1
      awardBossAP(5000)
      global.bossTrack=2
      sceneProgress=0
    }
  }
  else if global.bossTrack=2
  {
    if sceneProgress=0
    {
      var tFullHeartDrop,tempMplay;
      tFullHeartDrop=instance_create(712,176,oHealthPickup)
      tFullHeartDrop.sprite_index=sFullHealthPickup
      tempMplay=findMusic(605)
      playMusic(tempMplay,0,0)
      with oEnemyBarrier {instance_destroy()}
      global.gamePaused=false
      global.currentBoss=""
      global.bossTrack=0
      global.gameProgress=3520
    }
  }
}
else if global.gameProgress=3520 and room=rGame6_FireE //----- [] Short moment of lamentation about the fire boss -----
{
  if sceneProgress=0
  {
    if oPlayer1.x>=1152
    {
      global.gamePaused=true
      oPlayer1.y+=4
      if oPlayer1.y>=240
      {
        scenePChk(oPlayer1.x,240,0,0.1,1)
        stopPlayer()
        sceneProgress+=1
      }
    }
  }
  else if sceneProgress=1
  {
    sceneDelay+=1
    if sceneDelay=10 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Jeremy, that was disappointing.",0,3,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","It's not the worst thing that could happen.",0,3,oMessageCutscene,1)
  else if sceneProgress=4
  {
    sceneDelay=0; sceneProgress=0
    global.gameProgress=3530
    global.gamePaused=false
  }
}
else if global.gameProgress=3530 and room=rGame6_FireF //----- [13] Obtain Fire Crystal -----
{
  if sceneProgress=0
  {
    if oPlayer1.x>=240
    {
      fadeColor=c_black
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
  else if sceneProgress=1
  {
    sceneDelay+=1
    if sceneDelay>=15 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=2
  {
    sceneDelay+=1
    if sceneDelay>=11 and sceneDelay<=46 {oLevelDecal.y+=1}
    else if sceneDelay>=61 and sceneDelay<=70 {oLevelDecal.image_alpha-=0.1}
    else if sceneDelay>=90 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Awesome, Claire got the Earth Crystal just a moment ago.",0,3,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Maybe I forgot or I'm not understanding, but how do you know?",0,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","I'm watching both of you right now.",0,3,oMessageCutscene,1)
  else if sceneProgress=6 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Oh that's right. What do we do now?",0,3,oMessageCutscene,1)
  else if sceneProgress=7 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","I asked her to head to the Access Gate to meet up with you.",0,3,oMessageCutscene,1)
  else if sceneProgress=8 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Guess I'm going there next.",0,3,oMessageCutscene,1)
  else if sceneProgress=9 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","On your way there, I want to try something. Don't worry about what I'm doing, I'll tell you afterward.",0,3,oMessageCutscene,1)
  else if sceneProgress=10 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Ah, sure.",0,3,oMessageCutscene,1)
  else if sceneProgress=11
  {
    fadeAlpha+=0.02
    if fadeAlpha>=1
    {
      var tempMplay;
      tempMplay=findMusic(0)
      playMusic(tempMplay,0,0)
      oPlayer1.life=oPlayer1.maxLife
      global.pLife=global.pMaxLife
      global.activeCharacter=0
      global.charScan[0]=0; global.charScan[1]=0
      global.newMapX=32; global.newMapY=160
      global.gameProgress=3540
      room_goto(rGame6_ESC_Scene)
    }
  }
}

else if global.gameProgress=3540 and room=rGame6_ESC_Scene //----- [14] The Evil Shadowy Council meeting -----
{
  if sceneProgress=0
  {
    sceneDelay+=1
    if sceneDelay>=30
    {
      fadeAlpha-=0.04
      if fadeAlpha<=0 {sceneDelay=0; sceneProgress+=1}
    }
  }
  else if sceneProgress=1 and bWaitForInput=false
    msgCreate(0,0,"Shadowy Councilman A","Why did you summon us here, oh great one?",6,3,oMessageCutscene,1)
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"Great Evil Overlord","The heroes pre-spoken of in The Prophecy have arrived, earlier than expected. I want all of you out there putting a stop to them. I cannot have them ruining my plans!",6,3,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Shadowy Councilman A","Of course, great one. We have already begun our plans to thwart these so called heroes who invade our lands.",6,3,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"High Heels Girl","I saw one of them, he didn't look that strong and he also talks to himself. They might be easier to deal with than we think.",6,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Great Evil Overlord","Did you try to stop him in his quest?",6,3,oMessageCutscene,1)
  else if sceneProgress=6 and bWaitForInput=false
    msgCreate(0,0,"High Heels Girl","Well no, but that's because the Councilmen gave me high heels to fight in. What was I supposed to do?",6,3,oMessageCutscene,1)
  else if sceneProgress=7 and bWaitForInput=false
    msgCreate(0,0,"Shadowy Councilman A","There is nothing wrong with them, they grant special powers!",6,3,oMessageCutscene,1)
  else if sceneProgress=8 and bWaitForInput=false
    msgCreate(0,0,"Great Evil Overlord","You are requesting new footwear?",6,3,oMessageCutscene,1)
  else if sceneProgress=9 and bWaitForInput=false
    msgCreate(0,0,"High Heels Girl","Yes, it would be very much appreciated.",6,3,oMessageCutscene,1)
  else if sceneProgress=10 and bWaitForInput=false
    msgCreate(0,0,"Great Evil Overlord","Your request is denied. You will continue using what you are given.",6,3,oMessageCutscene,1)
  else if sceneProgress=11 and bWaitForInput=false
    msgCreate(0,0,"Shadowy Councilman A","Use their special powers.",6,3,oMessageCutscene,1)
  else if sceneProgress=12 and bWaitForInput=false
    msgCreate(0,0,"High Heels Girl","Right, whatever. I have a plan to stop them already.",6,3,oMessageCutscene,1)
  else if sceneProgress=13 and bWaitForInput=false
    msgCreate(0,0,"Great Evil Overlord","Good. I expect good news.",6,3,oMessageCutscene,1)
  else if sceneProgress=14 and bWaitForInput=false
    msgCreate(0,0,"Shadowy Councilman B","If she should fail, we have a plan.",6,3,oMessageCutscene,1)
  else if sceneProgress=15 and bWaitForInput=false
    msgCreate(0,0,"Great Evil Overlord","Good, now before you all go, I will schedule when we shall have our next meeting.",6,3,oMessageCutscene,1)
  else if sceneProgress=16 and bWaitForInput=false
    msgCreate(0,0,"Shadowy Councilman C","What will the topic be?",6,3,oMessageCutscene,1)
  else if sceneProgress=17 and bWaitForInput=false
    msgCreate(0,0,"Great Evil Overlord","We will be having a meeting in 2 days time to discuss when we will have a meeting to discuss something of great importance.",6,3,oMessageCutscene,1)
  else if sceneProgress=18 and bWaitForInput=false
    msgCreate(0,0,"Shadowy Councilman A","Good thinking, great one! One can never have too many scheduled meetings!",6,3,oMessageCutscene,1)
  else if sceneProgress=19 and bWaitForInput=false
    msgCreate(0,0,"Great Evil Overlord","This meeting is adjourned! I will see you all in 2 days at this precise time to discuss our plans to plan another meeting!",6,3,oMessageCutscene,1)
  else if sceneProgress=20
  {
    global.newMapX=80; global.newMapY=288
    room_goto(rGame6_Gate)
  }
}
else if global.gameProgress=3540 and room=rGame6_Gate //----- [15] The team is back together -----
{
  if sceneProgress=0
  {
    sceneDelay+=1
    if sceneDelay>=30
    {
      fadeAlpha-=0.02
      if fadeAlpha<=0 {sceneDelay=0; sceneProgress+=1}
    }
  }
  else if sceneProgress=1 and bWaitForInput=false
    msgCreate(0,0,"Chao","It's good to see everyone back together again.",0,3,oMessageCutscene,1)
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"Claire","I'm happy to see Jerry back too.",0,3,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Oh we know, Claire.",0,3,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Claire","Shut up, Jerry.",0,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Now that we're all reunited, we can finally talk about what we're doing.",0,3,oMessageCutscene,1)
  else if sceneProgress=6 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Stopping some overlord guy or something?",0,3,oMessageCutscene,1)
  else if sceneProgress=7 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Yeah, spoilers you guys, it's the old man in that abandoned town.",0,3,oMessageCutscene,1)
  else if sceneProgress=8 and bWaitForInput=false
    msgCreate(0,0,"Claire","Figures!",0,3,oMessageCutscene,1)
  else if sceneProgress=9 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Do we go rough him up now?",0,3,oMessageCutscene,1)
  else if sceneProgress=10 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","No, we should proceed like normal. I'm very sure we need to do this crystal quest first to get the Chip to appear.",0,3,oMessageCutscene,1)
  else if sceneProgress=11 and bWaitForInput=false
    msgCreate(0,0,"Claire","I guess that makes sense, but how do you know the overlord is the old man?",0,3,oMessageCutscene,1)
  else if sceneProgress=12 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","I just overheard a conversation he had. The overlord was the same voice as the old man. They apparently do have some shadowy council or... something.",0,3,oMessageCutscene,1)
  else if sceneProgress=13 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","We'll need to be on watch for them. Aside from the overlord himself, that girl you encountered was there, Jerry. Along with 3 other guys.",0,3,oMessageCutscene,1)
  else if sceneProgress=14 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Gonna have some fights then.#So what are we doing next?",0,3,oMessageCutscene,1)
  else if sceneProgress=15 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Head back to the old man, but pretend like we don't know who he is.",0,3,oMessageCutscene,1)
  else if sceneProgress=16
  {
    global.canCharSwap=2; global.charScan[0]=1; global.charScan[1]=1
    var tFlash; tFlash=instance_create(x,y,oScreenFlash); tFlash.fadeSpeed=0.2
    with oMisc {instance_destroy()}
    sceneDelay=0; sceneProgress=0
    global.gameProgress=3545
    global.gamePaused=false
  }
}
else if global.gameProgress=3545 and room=rGame6_Hometown //----- [16] Ask old man where to go -----
{
  if sceneProgress=0
  {
    if oPlayer1.x>=668
    {
      global.gamePaused=true
      oPlayer1.y+=4
      if oPlayer1.y>=296
      {
        scenePChk(oPlayer1.x,296,0,0.1,1)
        stopPlayer()
        sceneProgress+=1
      }
    }
  }
  else if sceneProgress=1 and bWaitForInput=false
    msgCreate(0,0,"NPC A","I see you have two of the Crystals, and that the two of you are back together again, it's adorable.",6,3,oMessageCutscene,1)
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"Claire","Please don't say that... it's gross.",0,3,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Where are we heading now, old man?",0,3,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"NPC A","The Water Temple should be your next location. You'll be able to find it far to the west and then to the south.",6,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Claire","I'm just curious, are you hiding anything?",0,3,oMessageCutscene,1)
  else if sceneProgress=6 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Claire, you're not supposed to let him know we're onto him.",0,3,oMessageCutscene,1)
  else if sceneProgress=7 and bWaitForInput=false
    msgCreate(0,0,"NPC A","I hide many things. I am the smartest bot in these lands you know. I know everything!",6,3,oMessageCutscene,1)
  else if sceneProgress=8 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Everything you say?",0,3,oMessageCutscene,1)
  else if sceneProgress=9 and bWaitForInput=false
    msgCreate(0,0,"NPC A","Absolutely.",6,3,oMessageCutscene,1)
  else if sceneProgress=10 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Do you know where 'that' birthmark is on Claire?",0,3,oMessageCutscene,1)
  else if sceneProgress=11 and bWaitForInput=false
    msgCreate(0,0,"Claire","NO, shut up, Jerry!",0,3,oMessageCutscene,1)
  else if sceneProgress=12 and bWaitForInput=false
    msgCreate(0,0,"Jerry","It's a legit question! I'm just testing this, it's for science, Claire!",0,3,oMessageCutscene,1)
  else if sceneProgress=13 and bWaitForInput=false
    msgCreate(0,0,"Claire","We're going to the water temple now.",0,3,oMessageCutscene,1)
  else if sceneProgress=14
  {
    var tNewChapter;
    tNewChapter=instance_create(0,0,oChapterDisplay)
    tNewChapter.newChapter="Act 12#The Less Than Steller#Temple of Water"
    sceneDelay=0; sceneProgress=0
    global.gameProgress=3550
    global.gamePaused=false
  }
}
else if global.gameProgress=3550 and room=rGame6_WaterB //----- [] Boss Fight: High Heels Girl -----
{
  if global.bossTrack=0
  {
    if sceneProgress=0
    {
      if oPlayer1.x>=256
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
    else if sceneProgress=1 and bWaitForInput=false
      msgCreate(0,0,"High Heels Girl","I knew you'd show up here.",6,3,oMessageCutscene,1)
    else if sceneProgress=2 and bWaitForInput=false
      msgCreate(0,0,"Jerry","Good intel I imagine. You want to fight this time?",0,3,oMessageCutscene,1)
    else if sceneProgress=3 and bWaitForInput=false
      msgCreate(0,0,"High Heels Girl","That is precisely why I'm here. I want to be the one to stop you. Not those others in the council!",6,3,oMessageCutscene,1)
    else if sceneProgress=4 and bWaitForInput=false
      msgCreate(0,0,"Claire","Jerry, can I take this one?",0,3,oMessageCutscene,1)
    else if sceneProgress=5 and bWaitForInput=false
      msgCreate(0,0,"Jerry","Sure, I suppose.",0,3,oMessageCutscene,1)
    else if sceneProgress=6 and bWaitForInput=false
      msgCreate(0,0,"High Heels Girl","Oh this is going to be good. I may still have these damned high heels on, but I can still beat you.",6,3,oMessageCutscene,1)
    else if sceneProgress=7 and bWaitForInput=false
      msgCreate(0,0,"Claire","Oh yeah, I've got this one, Jerry.",0,3,oMessageCutscene,1)
    else if sceneProgress=8
    {
      with oMisc {instance_destroy()}
      viewFix=instance_create(320,176,oMisc)
      viewFix.type=0
      viewFix.sprite_index=sNull
      view_object[0]=viewFix
      var boss,tBossTitle,enemyBarrier,tempMplay;
      tempMplay=findMusic(819)
      playMusic(tempMplay,0,0)
      tBossTitle=instance_create(0,0,oBossNameDisplay)
      tBossTitle.bossName="High Heels Girl"
      tBossTitle.bossTitle="Spoilers: You Should Use Claire"
      boss=instance_create(384,288,oPT_HighHeelsGirl)
      boss.activateBoss=1
      enemyBarrier=instance_create(144,128,oEnemyBarrier); enemyBarrier.image_yscale=10
      enemyBarrier=instance_create(480,128,oEnemyBarrier); enemyBarrier.image_yscale=10
      global.currentBoss="High Heels Girl"
      global.bossTrack=1
      global.gamePaused=false
      storeStatus(0)
      sceneDelay=0; sceneProgress=0
    }
  }
  else if global.bossTrack=1
  {
    if sceneProgress=1 //End Boss
    {
      view_object[0]=oPlayer1
      var tempMplay;
      tempMplay=findMusic(0)
      playMusic(tempMplay,0,0)
      global.gamePaused=true
      endBoss()
      awardBossAP(7000)
      global.bossTrack=2
      sceneProgress=0
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
        scenePChk(272,288,0,0.1,1)
        npcHHG=instance_create(368,288,oMisc)
        npcHHG.type=1; npcHHG.sprite_index=sHHG_Idle; npcHHG.image_speed=0; npcHHG.image_xscale=-1
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
      msgCreate(0,0,"High Heels Girl","I can't believe I lost to you.",6,3,oMessageCutscene,1)
    else if sceneProgress=5 and bWaitForInput=false
      msgCreate(0,0,"Claire","In Jerry's words. I'm pretty awesome.",0,3,oMessageCutscene,1)
    else if sceneProgress=6 and bWaitForInput=false
      msgCreate(0,0,"High Heels Girl","I'll get you back for this! YOU'LL SEE!",6,3,oMessageCutscene,1)
    else if sceneProgress=7
    {
      sceneDelay+=1
      if sceneDelay=1
      {
        for(i=0;i<8;i+=1)
        {
          var tEffect;
          tEffect=instance_create(oMisc.x+random_range(-12,12),oMisc.y+2-random(36),oEffect)
          tEffect.sprite_index=sDustCloud; tEffect.xSpd=0; tEffect.ySpd=0; tEffect.decay=-100; tEffect.image_speed=0.5
          tEffect.newBlend=-1; tEffect.followID=-1
        }
      }
      else if sceneDelay=2 {oMisc.image_alpha=0}
      else if sceneDelay=30 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=8 and bWaitForInput=false
      msgCreate(0,0,"Jerry","Now what?",0,3,oMessageCutscene,1)
    else if sceneProgress=9 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","The barrier in the previous room is no longer there.",0,3,oMessageCutscene,1)
    else if sceneProgress=10 and bWaitForInput=false
      msgCreate(0,0,"Jerry","Eh, why? No switch or anything?",0,3,oMessageCutscene,1)
    else if sceneProgress=11 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","What would the difference really be?",0,3,oMessageCutscene,1)
    else if sceneProgress=12 and bWaitForInput=false
      msgCreate(0,0,"Jerry","Good point.",0,3,oMessageCutscene,1)
    else if sceneProgress=13
    {
      var tFullHeartDrop,tempMplay;
      tFullHeartDrop=instance_create(320,176,oHealthPickup)
      tFullHeartDrop.sprite_index=sFullHealthPickup
      tempMplay=findMusic(605)
      playMusic(tempMplay,0,0)
      with oMisc {instance_destroy()}
      with oEnemyBarrier {instance_destroy()}
      global.gamePaused=false
      global.currentBoss=""
      global.bossTrack=0
      global.gameProgress=3570
    }
  }
}
else if global.gameProgress=3570 and room=rGame6_WaterA //----- [17] Obtain Water Crystal -----
{
  if sceneProgress=0
  {
    if oPlayer1.x>=528 and oPlayer1.x<=560 and oPlayer1.y<=216
    {
      fadeColor=c_black
      global.gamePaused=true
      oPlayer1.y+=4
      if oPlayer1.y>=208
      {
        scenePChk(oPlayer1.x,208,0,0.1,oPlayer1.image_xscale)
        stopPlayer()
        sceneProgress+=1
      }
    }
  }
  else if sceneProgress=1
  {
    sceneDelay+=1
    if sceneDelay>=15 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=2
  {
    sceneDelay+=1
    if sceneDelay>=11 and sceneDelay<=46 {oLevelDecal.y+=1}
    else if sceneDelay>=61 and sceneDelay<=70 {oLevelDecal.image_alpha-=0.1}
    else if sceneDelay>=90 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Chao","Wow, one more to go already!",0,3,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Yep, let's just go straight to the Wind Temple. We don't need direction from the creepy old man.",0,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Hey, this place was really... uh, well nothing to it.",0,3,oMessageCutscene,1)
  else if sceneProgress=6 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Are you complaining though? We already had to go through an elaborate water level. Do you really want to go through another one?",0,3,oMessageCutscene,1)
  else if sceneProgress=7 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Point taken I suppose.",0,3,oMessageCutscene,1)
  else if sceneProgress=8
  {
    with oLevelDecal {instance_destroy()}
    var tNewChapter;
    tNewChapter=instance_create(0,0,oChapterDisplay)
    tNewChapter.newChapter="Act 37#The Misdirection"
    sceneDelay=0; sceneProgress=0
    global.gameProgress=3580
    global.gamePaused=false
  }
}
else if global.gameProgress=3590 and room=rGame6_CoMB //----- [18] Getting Double Jump -----
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
        scenePChk(oPlayer1.x,240,0,0.1,1)
        sceneDelay=0; sceneProgress+=1
      }
    }
  }
  else if sceneProgress=1
  {
    sceneDelay+=1
    if sceneDelay>=70 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Not really sure what that was, but it enabled you to double jump.",0,3,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Is it exclusive to this place?",0,3,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","No, as soon as we get the Program Chip, you can use it outside.",0,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","To use it, just press the jump button while you're in the air. You can't be holding [Up] or [Down] since normally that will trigger your air dash. Unless you turned that off in the Options submenu, that is.",0,3,oMessageCutscene,1)
  else if sceneProgress=6 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","You regain your double jump when you land on the ground or deal damage to an enemy.",0,3,oMessageCutscene,1)
  else if sceneProgress=7 and bWaitForInput=false
    msgCreate(0,0,"Jerry","This is going to get complicated.",0,3,oMessageCutscene,1)
  else if sceneProgress=8
  {
    sceneDelay=0; sceneProgress=0
    var tNewChapter;
    tNewChapter=instance_create(0,0,oChapterDisplay)
    tNewChapter.newChapter="Act 77#The Troubling Wind Temple"
    global.newMapX=560
    global.newMapY=240
    instance_create(0,0,oCheckpointNotice)
    global.canDoubleJump=2
    global.gameProgress=3600
    global.gamePaused=false
  }
}
else if global.gameProgress=3600 and room=rGame6_WindC //----- [] Enemy trap event -----
{
  if sceneProgress=0
  {
    if oPlayer1.x>=368
    {
      var enemyCounter,enemyBarrier;
      enemyCounter=instance_create(0,0,oEnemyRemain)
      enemyCounter.enemyCount=9
      enemyBarrier=instance_create(80,224,oEnemyBarrier); enemyBarrier.image_yscale=4
      enemyBarrier=instance_create(640,224,oEnemyBarrier); enemyBarrier.image_yscale=4
      sceneProgress+=1
    }
  }
  else if sceneProgress=1
  {
    if global.gamePaused=false
    {
      sceneDelay+=1
      if sceneDelay=10
      {
        global.tempAction[0]=24
        delaySpawn(208,288,oPT_Skeleton,2,1,1,0.33)
        delaySpawn(528,288,oPT_Skeleton,2,1,1,0.33)
      }
      else if sceneDelay=60 {sceneDelay=0; sceneProgress+=1}
    }
  }
  else if sceneProgress=2
  {
    if !instance_exists(oEnemyBase) {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=3
  {
    if global.gamePaused=false
    {
      sceneDelay+=1
      if sceneDelay=10
      {
        delaySpawn(176,112,oPT_IceSpirit,2,1,1,0.33)
      }
      else if sceneDelay=30
      {
        delaySpawn(560,112,oPT_IceSpirit,2,1,1,0.33)
      }
      else if sceneDelay=60 {sceneDelay=0; sceneProgress+=1}
    }
  }
  else if sceneProgress=4
  {
    if !instance_exists(oEnemyBase) {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=5
  {
    if global.gamePaused=false
    {
      sceneDelay+=1
      if sceneDelay=10
      {
        delaySpawn(208,288,oPT_Skeleton,2,1,1,0.33)
        delaySpawn(528,288,oPT_Skeleton,2,1,1,0.33)
      }
      else if sceneDelay=80
      {
        delaySpawn(176,112,oPT_IceSpirit,2,1,1,0.33)
      }
      else if sceneDelay=120
      {
        delaySpawn(560,112,oPT_IceSpirit,2,1,1,0.33)
      }
      else if sceneDelay=240
      {
        delaySpawn(368,240,oPT_FireEye,2,1,1,0.33)
      }
      else if sceneDelay=300 {sceneDelay=0; sceneProgress+=1}
    }
  }
  else if sceneProgress=6
  {
    if !instance_exists(oEnemyBase)
    {
      with oEnemyBarrier {instance_destroy()}
      with oEnemyRemain {instance_destroy()}
      sceneProgress=0
      global.gameProgress=3610
    }
  }
}
else if global.gameProgress=3610 and room=rGame6_WindF //----- [] Enemy trap event -----
{
  if sceneProgress=0
  {
    if oPlayer1.x>=368
    {
      var enemyCounter,enemyBarrier;
      enemyCounter=instance_create(0,0,oEnemyRemain)
      enemyCounter.enemyCount=7
      enemyBarrier=instance_create(144,160,oEnemyBarrier); enemyBarrier.image_yscale=8
      enemyBarrier=instance_create(576,160,oEnemyBarrier); enemyBarrier.image_yscale=8
      sceneProgress+=1
    }
  }
  else if sceneProgress=1
  {
    if global.gamePaused=false
    {
      sceneDelay+=1
      if sceneDelay=10
      {
        global.tempAction[0]=28
        delaySpawn(240,96,oPT_IceSpirit,2,1,1,0.33)
      }
      else if sceneDelay=30
      {
        delaySpawn(496,288,oPT_IceSpirit,2,1,1,0.33)
      }
      else if sceneDelay=60 {sceneDelay=0; sceneProgress+=1}
    }
  }
  else if sceneProgress=2
  {
    if !instance_exists(oEnemyBase) {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=3
  {
    if global.gamePaused=false
    {
      sceneDelay+=1
      if sceneDelay=10
      {
        delaySpawn(336,192,oPT_FireEye,2,1,1,0.33)
      }
      else if sceneDelay=30
      {
        delaySpawn(400,96,oPT_FireEye,2,1,1,0.33)
      }
      else if sceneDelay=60 {sceneDelay=0; sceneProgress+=1}
    }
  }
  else if sceneProgress=4
  {
    if !instance_exists(oEnemyBase) {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=5
  {
    if global.gamePaused=false
    {
      sceneDelay+=1
      if sceneDelay=10
      {
        global.tempAction[0]=29
        delaySpawn(240,96,oPT_IceSpirit,2,1,1,0.33)
        delaySpawn(336,192,oPT_FireEye,2,1,1,0.33)
      }
      else if sceneDelay=60 {sceneDelay=0; sceneProgress+=1}
    }
  }
  else if sceneProgress=6
  {
    if !instance_exists(oEnemyBase) {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=7
  {
    if global.gamePaused=false
    {
      sceneDelay+=1
      if sceneDelay=10
      {
        global.tempAction[0]=50
        delaySpawn(368,192,oPT_IceSpirit,2,1,1,0.33)
      }
      else if sceneDelay=60 {sceneDelay=0; sceneProgress+=1}
    }
  }
  else if sceneProgress=8
  {
    if !instance_exists(oEnemyBase)
    {
      with oEnemyBarrier {instance_destroy()}
      with oEnemyRemain {instance_destroy()}
      sceneProgress=0
      global.gameProgress=3620
    }
  }
}
else if global.gameProgress=3620 and room=rGame6_WindI //----- [] Boss Fight: The Unforgotten -----
{
  if global.bossTrack=0
  {
    if sceneProgress=0
    {
      if oPlayer1.x>=368
      {
        global.gamePaused=true
        oPlayer1.y+=4
        if oPlayer1.y>=208
        {
          scenePChk(368,208,0,0.1,1)
          stopPlayer()
          var viewFix;
          viewFix=instance_create(368,208,oMisc)
          viewFix.type=0; viewFix.sprite_index=sNull
          view_object[0]=viewFix
          sceneProgress+=1
        }
      }
    }
    else if sceneProgress=1
    {
      sceneDelay+=1
      if sceneDelay>=20
      {
        musicFade-=30
        fadeVolume(global.msc_RPGElementsA,30)
        if musicFade<=5500
        {
          stopAllMusic()
          bossUnforgotten=instance_create(736,130,oPT_Unforgotten)
          sceneDelay=0; sceneProgress+=1
        }
      }
    }
    else if sceneProgress=2
    {
      sceneDelay+=1
      if sceneDelay=20
      {
        var tempMplay;
        tempMplay=findMusic(819)
        playMusic(tempMplay,0,0)
      }
      else if sceneDelay>=21
      {
        bossUnforgotten.x-=1
        if bossUnforgotten.x<=560 {sceneDelay=0; sceneProgress+=1}
      }
    }
    else if sceneProgress=3
    {
      sceneDelay+=1
      if sceneDelay>=20 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=4 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","Its weakness is most definitely its face!",0,3,oMessageCutscene,1)
    else if sceneProgress=5 and bWaitForInput=false
      msgCreate(0,0,"Jerry","Thanks Jeremy. Really good help.",0,3,oMessageCutscene,1)
    else if sceneProgress=6
    {
      global.gamePaused=false
      var tBossTitle,enemyBarrier;
      tBossTitle=instance_create(0,0,oBossNameDisplay)
      tBossTitle.bossName="The Unforgotten"
      tBossTitle.bossTitle="Nearly Forgotten Beast of the Past"
      enemyBarrier=instance_create(112,224,oEnemyBarrier); enemyBarrier.image_yscale=4
      enemyBarrier=instance_create(608,224,oEnemyBarrier); enemyBarrier.image_yscale=4
      bossUnforgotten.activateBoss=1
      global.currentBoss="Unforgotten"
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
      global.gamePaused=true
      awardBossAP(8500)
      global.bossTrack=2
      sceneProgress=0
    }
  }
  else if global.bossTrack=2
  {
    if sceneProgress=0
    {
      var tFullHeartDrop,tempMplay;
      tFullHeartDrop=instance_create(368,96,oHealthPickup)
      tFullHeartDrop.sprite_index=sFullHealthPickup
      tempMplay=findMusic(605)
      playMusic(tempMplay,0,0)
      with oEnemyBarrier {instance_destroy()}
      view_object[0]=oPlayer1
      global.gamePaused=false
      global.currentBoss=""
      global.bossTrack=0
      global.gameProgress=3630
    }
  }
}
else if global.gameProgress=3630 and room=rGame6_WindJ //----- [19] Obtain Wind Crystal -----
{
  if sceneProgress=0
  {
    if oPlayer1.x>=240
    {
      global.gamePaused=true
      oPlayer1.y+=4
      if oPlayer1.y>=208
      {
        scenePChk(oPlayer1.x,208,0,0.1,1)
        stopPlayer()
        sceneProgress+=1
      }
    }
  }
  else if sceneProgress=1
  {
    sceneDelay+=1
    if sceneDelay>=15 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=2
  {
    sceneDelay+=1
    if sceneDelay>=11 and sceneDelay<=46 {oLevelDecal.y+=1}
    else if sceneDelay>=61 and sceneDelay<=70 {oLevelDecal.image_alpha-=0.1}
    else if sceneDelay>=90 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Jerry","And got them all! We head back to the old man in Hometown, right?",0,3,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Yes, let's get this place completed as fast as possible. Hex hasn't tried to interfere and that's making me nervous.",0,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Chao","Do you think he might?",0,3,oMessageCutscene,1)
  else if sceneProgress=6 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","I have no idea and that worries me. I don't know how involved he is with CHAOS or even that much about them.",0,3,oMessageCutscene,1)
  else if sceneProgress=7 and bWaitForInput=false
    msgCreate(0,0,"Chao","Their bots didn't seem that strong.",0,3,oMessageCutscene,1)
  else if sceneProgress=8 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","They didn't seem to be, but there sure were a lot of them. Everything kept stating how disorganized they were, but that's not what we observed.",0,3,oMessageCutscene,1)
  else if sceneProgress=9 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Shouldn't we focus on the Chip first?",0,3,oMessageCutscene,1)
  else if sceneProgress=10 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Yeah.",0,3,oMessageCutscene,1)
  else if sceneProgress=11 and bWaitForInput=false
    msgCreate(0,0,"Jerry","And I was thinking, should we take out the old man before we give him the Crystals? Maybe we can get the Chip to appear like that?",0,3,oMessageCutscene,1)
  else if sceneProgress=12 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","No, play it out normally. As soon as he transforms, we'll beat him before he attains all his power... whatever that means.",0,3,oMessageCutscene,1)
  else if sceneProgress=13 and bWaitForInput=false
    msgCreate(0,0,"Jerry","RPGs are stupid.",0,3,oMessageCutscene,1)
  else if sceneProgress=14 and bWaitForInput=false
    msgCreate(0,0,"Claire","Stop hating, Jerry. They are not. This has nothing to do with them anyway.",0,3,oMessageCutscene,1)
  else if sceneProgress=15
  {
    with oLevelDecal {instance_destroy()}
    sceneDelay=0; sceneProgress=0
    global.gameProgress=3640
    global.gamePaused=false
  }
}
else if global.gameProgress=3640 and room=rGame6_Hometown //----- [20] Presenting the 4 Crystals to NPC A -----
{
  if sceneProgress=0
  {
    if oPlayer1.x>=668
    {
      global.gamePaused=true
      oPlayer1.y+=4
      if oPlayer1.y>=296
      {
        fadeColor=c_black
        scenePChk(oPlayer1.x,296,0,0.1,1)
        stopPlayer()
        sceneProgress+=1
      }
    }
  }
  else if sceneProgress=1 and bWaitForInput=false
    msgCreate(0,0,"Claire","We found all 4 Crystals. So how do we get to the Overlord's castle to defeat him?",0,3,oMessageCutscene,1)
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"NPC A","Very good, now toss them into the air and all will be revealed to us.",6,3,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Claire","Just like... throw them up?",0,3,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"NPC A","It is the way of the world.",6,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Jerry","You aren't going to betray us or anything are you? Like, hiding the fact that you probably ARE the Overlord?",0,3,oMessageCutscene,1)
  else if sceneProgress=6 and bWaitForInput=false
    msgCreate(0,0,"NPC A","I'm an old man. Simply NPC A, the first NPC placed here. I have much knowledge of the world.",6,3,oMessageCutscene,1)
  else if sceneProgress=7 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Well that didn't answer the question.",0,3,oMessageCutscene,1)
  else if sceneProgress=8 and bWaitForInput=false
    msgCreate(0,0,"NPC A","All will be revealed once you throw the Crystals into the air.",6,3,oMessageCutscene,1)
  else if sceneProgress=9 and bWaitForInput=false
    msgCreate(0,0,"Claire","Let's just do this.",0,3,oMessageCutscene,1)
  else if sceneProgress=10
  {
    sceneDelay+=1
    if sceneDelay=20
    {
      var tFlash;
      tFlash=instance_create(0,0,oScreenFlash)
      tFlash.fadeSpeed=0.1; tFlash.image_alpha=0.6
      myCrystal[0]=instance_create(oPlayer1.x,oPlayer1.y-26,oLevelDecal)
      myCrystal[0].sprite_index=sG6_Crystal; myCrystal[0].image_speed=0.15; myCrystal[0].image_blend=make_color_rgb(150,60,0)
      myCrystal[1]=instance_create(oPlayer1.x,oPlayer1.y-26,oLevelDecal)
      myCrystal[1].sprite_index=sG6_Crystal; myCrystal[1].image_speed=0.15; myCrystal[1].image_blend=make_color_rgb(220,20,0)
      myCrystal[2]=instance_create(oPlayer1.x,oPlayer1.y-26,oLevelDecal)
      myCrystal[2].sprite_index=sG6_Crystal; myCrystal[2].image_speed=0.15; myCrystal[2].image_blend=make_color_rgb(20,40,220)
      myCrystal[3]=instance_create(oPlayer1.x,oPlayer1.y-26,oLevelDecal)
      myCrystal[3].sprite_index=sG6_Crystal; myCrystal[3].image_speed=0.15; myCrystal[3].image_blend=make_color_rgb(0,150,20)
    }
    else if sceneDelay>=21 and sceneDelay<=90
    {
      for(i=0;i<4;i+=1)
      {
        myCrystal[i].y-=1
      }
      myCrystal[0].x-=1.1
      myCrystal[1].x-=0.45
      myCrystal[2].x+=0.45
      myCrystal[3].x+=1.1
    }
    else if sceneDelay>=105 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=11 and bWaitForInput=false
    msgCreate(0,0,"Claire","What now?",0,3,oMessageCutscene,1)
  else if sceneProgress=12 and bWaitForInput=false
    msgCreate(0,0,"NPC A","We will now...",6,3,oMessageCutscene,1)
  else if sceneProgress=13 and bWaitForInput=false
  {
    stopAllMusic()
    msgCreate(0,0,"NPC A","SHATTER THEM!!",6,3,oMessageCutscene,1)
  }
  else if sceneProgress=14
  {
    sceneDelay+=1
    if sceneDelay=1
    {
      playSound(global.snd_PotShatter,0,1,12000)
      var tFlash;
      tFlash=instance_create(0,0,oScreenFlash)
      tFlash.fadeSpeed=0.1; tFlash.image_alpha=0.6
      for(i=0;i<32;i+=1)
      {
        for(ii=0;ii<4;ii+=1)
        {
          tEffect=instance_create(myCrystal[ii].x,myCrystal[ii].y,oEffectB)
          tEffect.type=3; tEffect.sprite_index=sMMshotgunIceEffect
          tEffect.image_speed=0.5; tEffect.speed=random(4); tEffect.direction=random(360)
          tEffect.image_angle=random(360); tEffect.friction=random(0.1)+0.1; tEffect.fadeSpd=0.045
          tEffect.AccelX=0; tEffect.AccelY=0; tEffect.newBlend=-1; tEffect.followID=-1; tEffect.rotation=0
        }
      }
      with oLevelDecal {instance_destroy()}
    }
    else if sceneDelay=71 and sceneDelay<=80 {fadeAlpha+=0.05}
    else if sceneDelay=95
    {
      tEffect=instance_create(oNPC_GeneralC.x,oNPC_GeneralC.y-25,oEffectB)
      tEffect.type=3; tEffect.sprite_index=sEfEnergyRip
      tEffect.image_speed=0.5; tEffect.fadeSpd=0; tEffect.AccelX=0; tEffect.AccelY=0
      tEffect.newBlend=1; tEffect.followID=-1; tEffect.rotation=10
    }
    else if sceneDelay>=100 and sceneDelay<=120
    {
      if sceneDelay mod 10=0
      {
        var tFlash;
        tFlash=instance_create(0,0,oScreenFlash)
        tFlash.fadeSpeed=0.1; tFlash.image_alpha=0.3
      }
    }
    else if sceneDelay=125
    {
      with oEffectB {instance_destroy()}
      var tFlash;
      tFlash=instance_create(0,0,oScreenFlash)
      tFlash.fadeSpeed=0.05; tFlash.image_alpha=1
      oNPC_GeneralC.sprite_index=sG6NPC_TriviaLord
    }
    else if sceneDelay>=170 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=15 and bWaitForInput=false
    msgCreate(0,0,"The Overlord","I'm impressed you figured me out. I am indeed the Overlord. Or I would be impressed if you didn't have your friend Jeremy assisting you.",6,3,oMessageCutscene,1)
  else if sceneProgress=16 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","So you COULD hear what I said this whole time!",0,3,oMessageCutscene,1)
  else if sceneProgress=17 and bWaitForInput=false
    msgCreate(0,0,"The Overlord","Of course, being the first bot placed here has given me time to question my reality. I can see beyond this limited 'world' we were given here. The other bots are blind to it.",6,3,oMessageCutscene,1)
  else if sceneProgress=18 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","So you're not following a script then? What are you doing then? Why did you have us get the Crystals for you? Most of that was all just an act for sure.",0,3,oMessageCutscene,1)
  else if sceneProgress=19 and bWaitForInput=false
    msgCreate(0,0,"The Overlord","Unfortunately, myself and the other bots were unable to touch the Crystals. They sealed away something of mine.",6,3,oMessageCutscene,1)
  else if sceneProgress=20 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Ah, another thing where bots are unable to affect certain elements of the world. What was it sealing away?",0,3,oMessageCutscene,1)
  else if sceneProgress=21 and bWaitForInput=false
    msgCreate(0,0,"The Overlord","Abilities of mine that I haven't been able to tap into for some time. Memories and knowledge sealed away that I was unable to access. Thanks to you four, I have them back.",6,3,oMessageCutscene,1)
  else if sceneProgress=22 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","What are you going to do with it?",0,3,oMessageCutscene,1)
  else if sceneProgress=23 and bWaitForInput=false
    msgCreate(0,0,"The Overlord","Spoilers Jeremy. I can't let you know of my plans. I can't let anyone know!",6,3,oMessageCutscene,1)
  else if sceneProgress=24 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Since he's revealed himself, we can defeat him now, right?",0,3,oMessageCutscene,1)
  else if sceneProgress=25 and bWaitForInput=false
    msgCreate(0,0,"The Overlord","Oh, I shall not be faced here, I will first retreat to my fortress, where you will battle through my minions! However, there is another trial you must go through first.",6,3,oMessageCutscene,1)
  else if sceneProgress=26 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","I've had it with trials!",0,3,oMessageCutscene,1)
  else if sceneProgress=27 and bWaitForInput=false
    msgCreate(0,0,"The Overlord","I am going to send you to the farthest reachest of the land for that remark. If you will not arbitrarily face my trial before facing me, then you are not worthy!",6,3,oMessageCutscene,1)
  else if sceneProgress=28 and bWaitForInput=false
    msgCreate(0,0,"Jerry","I don't even understand this dude anymore! It's time to kick his ass!",0,3,oMessageCutscene,1)
  else if sceneProgress=29
  {
    sceneDelay+=1
    if sceneDelay=15
    {
      tEffect=instance_create(oNPC_GeneralC.x,oNPC_GeneralC.y-80,oEffectB)
      tEffect.type=3; tEffect.sprite_index=sEfEnergyRip
      tEffect.image_speed=0.5; tEffect.fadeSpd=0; tEffect.AccelX=0; tEffect.AccelY=0
      tEffect.newBlend=1; tEffect.followID=-1; tEffect.rotation=10
    }
    else if sceneDelay>=40 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=30 and bWaitForInput=false
    msgCreate(0,0,"The Overlord","I can see that you have no interest in what I will present, therefore you must be removed!",6,3,oMessageCutscene,1)
  else if sceneProgress=31
  {
    sceneDelay+=1
    if sceneDelay=5 {fadeColor=c_white}
    else if sceneDelay>=6 and sceneDelay<=10 {fadeAlpha+=0.1}
    else if sceneDelay>=11 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=32
  {
    stopAllMusic()
    playSound(global.snd_NewGateTransport,0,1,1)
    global.newMapX=192; global.newMapY=272
    room_goto(rGame6_DreamWoodsA)
  }
}
else if global.gameProgress=3640 and room=rGame6_DreamWoodsA //----- [21] The Dream Woods -----
{
  if sceneProgress=0
  {
    sceneDelay+=1
    if sceneDelay>=51 and sceneDelay<=150 {fadeAlpha-=0.01}
    else if sceneDelay>=160 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=1 and bWaitForInput=false
    msgCreate(0,0,"Claire","Where did he just send us?",0,3,oMessageCutscene,1)
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","He didn't send us anywhere.",0,3,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Claire","What?",0,3,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","The Overlord was about to send us through that portal, but something else zapped us here before he could do that.",0,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Claire","Do you know who did it?",0,3,oMessageCutscene,1)
  else if sceneProgress=6 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","No, and I've no idea where this place is.",0,3,oMessageCutscene,1)
  else if sceneProgress=7 and bWaitForInput=false
    msgCreate(0,0,"Chao","I think we're in a dream.",0,3,oMessageCutscene,1)
  else if sceneProgress=8 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","That's silly.",0,3,oMessageCutscene,1)
  else if sceneProgress=9 and bWaitForInput=false
    msgCreate(0,0,"Chao","The weird effect, bad timing. This is a dream sequence. It fits with the cliche of this whole place.",0,3,oMessageCutscene,1)
  else if sceneProgress=10 and bWaitForInput=false
    msgCreate(0,0,"Jerry","So the Overlord was going to send us to... wherever, but something else sent us into a dream?",0,3,oMessageCutscene,1)
  else if sceneProgress=11 and bWaitForInput=false
    msgCreate(0,0,"Chao","I think whoever it was, wants to show us something. Isn't that usually how these sorts of things work?",0,3,oMessageCutscene,1)
  else if sceneProgress=12 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Sure but... eh, yes.",0,3,oMessageCutscene,1)
  else if sceneProgress=13 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Let's do this then. Note that the rules of the world have not changed. You can still lose in here.",0,3,oMessageCutscene,1)
  else if sceneProgress=14 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Naturally.",0,3,oMessageCutscene,1)
  else if sceneProgress=15
  {
    var tNewChapter,tempMplay;
    tNewChapter=instance_create(0,0,oChapterDisplay)
    tNewChapter.newChapter="Act 293#The Dream Woods"
    tempMplay=findMusic(606)
    playMusic(tempMplay,0,0)
    sceneDelay=0; sceneProgress=0
    global.gameProgress=3650
    global.gamePaused=false
  }
}
else if global.gameProgress=3760 and room=rGame6_DreamWoodsF //----- [22] Jerry/Claire mentions the dream -----
{
  if sceneProgress=0
  {
    sceneDelay+=1
    if sceneDelay=1 {global.gamePaused=true}
    if sceneDelay>=20 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=1 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","What was all that?",0,3,oMessageCutscene,1)
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"Claire","That's what I saw in my dream when we were in the Vault.",0,3,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Same here. I know that's what I saw.",0,3,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","What about that message? 'Everyone will die.' Was that in your dream?",0,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Claire","In the dream, the Abomination, at least... I think that's what spoke, said we could save everyone we know if we could help it.",0,3,oMessageCutscene,1)
  else if sceneProgress=6 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","It doesn't say when though, does it?",0,3,oMessageCutscene,1)
  else if sceneProgress=7 and bWaitForInput=false
    msgCreate(0,0,"Claire","No, just that other thing there seemed to be feeding off of the Abomination.",0,3,oMessageCutscene,1)
  else if sceneProgress=8 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Interesting... but let's keep going.",0,3,oMessageCutscene,1)
  else if sceneProgress=9
  {
    sceneDelay=0; sceneProgress=0
    global.gameProgress=3770
    global.gamePaused=false
  }
}
else if global.gameProgress=3770 and room=rGame6_DreamWoodsF //----- [Unskippable] Gain 'Bird Swarm' and 'Chainblade Storm' -----
{
  if sceneProgress=0
  {
    if oPlayer1.x>=320
    {
      fadeAlpha=1
      stopPlayer()
      oPlayer1.x=320; oPlayer1.y=160
      if global.activeCharacter=0 {oPlayer1.sprite_index=sJerryPose2}
      else {oPlayer1.sprite_index=sClaireCasting}
      oPlayer1.image_alpha=0; oPlayer1.depth=-1
      global.gamePaused=true
      sceneProgress+=1
    }
  }
  else if sceneProgress=1
  {
    sceneDelay+=1
    if sceneDelay>=21 and sceneDelay<=70 {oPlayer1.image_alpha+=0.02}
    else if sceneDelay>=71 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=2
  {
    sceneDelay+=1
    if sceneDelay=35
    {
      efCharge=instance_create(oPlayer1.x,oPlayer1.y-26,oMisc)
      efCharge.sprite_index=sMMcharging; efCharge.image_speed=0.5; efCharge.depth=-2
      efCharge.type=1; efCharge.image_xscale=4; efCharge.image_yscale=4
      
      for(i=0;i<4;i+=1)
      {
        efStars[i]=instance_create(oPlayer1.x,oPlayer1.y-26,oMisc)
        efStars[i].sprite_index=sMMcharging; efStars[i].image_speed=0.5; efStars[i].depth=-2
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
      efCharge.image_xscale-=0.1; efCharge.image_yscale-=0.1
    }
    else if sceneDelay=80
    {
      with efCharge {instance_destroy()}
    }
    else if sceneDelay=90
    {
      var tEffect;
      tEffect=instance_create(oPlayer1.x,oPlayer1.y-26,oEffect)
      tEffect.sprite_index=sMMchargeComplete; tEffect.image_xscale=3;tEffect.image_yscale=3; tEffect.depth=-2
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
      with oMisc {instance_destroy()}
    }
    else if sceneDelay>=100 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(112,128,"","Jerry gained [Bird Swarm]!#Claire gained [Chainblade Storm]!",6,2,oMessageCutscene,1)
  else if sceneProgress=4
  {
    sceneDelay+=1
    if sceneDelay>=31 and sceneDelay<=80 {fadeAlpha-=0.02}
    else if sceneDelay=81 {oPlayer1.depth=20}
    else if sceneDelay>=100
    {
      oPlayer1.y+=1
      if oPlayer1.y>=272
      {
        scenePChk(oPlayer1.x,272,0,0.1,1)
        sceneDelay=0; sceneProgress+=1
      }
    }
  }
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Yay? Where did this come from?",0,3,oMessageCutscene,1)
  else if sceneProgress=6 and bWaitForInput=false
    msgCreate(0,0,"Alexander","I granted you those abilities.",0,3,oMessageCutscene,1)
  else if sceneProgress=7 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Wait... who said that?",0,3,oMessageCutscene,1)
  else if sceneProgress=8 and bWaitForInput=false
    msgCreate(0,0,"Alexander","The crow... right in front of you.",0,3,oMessageCutscene,1)
  else if sceneProgress=9 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Oh hey, there IS a crow there.",0,3,oMessageCutscene,1)
  else if sceneProgress=10 and bWaitForInput=false
    msgCreate(0,0,"Claire","Jerry's the observant one.",0,3,oMessageCutscene,1)
  else if sceneProgress=11 and bWaitForInput=false
    msgCreate(0,0,"Alexander","You freed me from those cages in the Vault. I'm here to repay the favor.",0,3,oMessageCutscene,1)
  else if sceneProgress=12 and bWaitForInput=false
    msgCreate(0,0,"Jerry","You guys already gave us the air dash.",0,3,oMessageCutscene,1)
  else if sceneProgress=13 and bWaitForInput=false
    msgCreate(0,0,"Claire","Shush Jerry.",0,3,oMessageCutscene,1)
  else if sceneProgress=14 and bWaitForInput=false
    msgCreate(0,0,"Alexander","Yes, but we wanted to do more. Jerry, you can now summon us to your aid. We'll seek out your foes and crush them for you! Claire... you have chainsaws.",0,3,oMessageCutscene,1)
  else if sceneProgress=15 and bWaitForInput=false
    msgCreate(0,0,"Claire","No complaints I suppose.",0,3,oMessageCutscene,1)
  else if sceneProgress=16 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Those abilities are executed with [Action C].",0,3,oMessageCutscene,1)
  else if sceneProgress=17 and bWaitForInput=false
    msgCreate(0,0,"Jerry","We kinda guessed that one.",0,3,oMessageCutscene,1)
  else if sceneProgress=18 and bWaitForInput=false
    msgCreate(0,0,"Alexander","Good luck out there.",0,3,oMessageCutscene,1)
  else if sceneProgress=19 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Thanks, I hope we can make good use of these abilities.",0,3,oMessageCutscene,1)
  else if sceneProgress=20
  {
    sceneDelay=0; sceneProgress=0
    global.hasAbilToken[5]=3
    global.hasAbilToken[6]=3
    global.gameProgress=3771
    global.gamePaused=false
  }
}
else if global.gameProgress=3771 and room=rGame6_DreamWoodsF //----- [Unskippable] Teleported out of Dream Woods -----
{
  if sceneProgress=0
  {
    if oPlayer1.x>=576
    {
      fadeAlpha=1
      global.newMapX=480; global.newMapY=296
      room_goto(rGame6_Hometown)
    }
  }
}
else if global.gameProgress=3771 and room=rGame6_Hometown //----- [Unskippable] Back to Hometown -----
{
  if sceneProgress=0
  {
    var tFlash;
    tFlash=instance_create(0,0,oScreenFlash); tFlash.fadeSpeed=0.02
    global.gameProgress=3780
  }
}
else if global.gameProgress=3780 and room=rGame6_Hometown //----- [23] Going back to Plot-Related Town -----
{
  if sceneProgress=0
  {
    if oPlayer1.x<=128 or oPlayer1.x>=832
    {
      global.gamePaused=true
      oPlayer1.y+=4
      if oPlayer1.y>=296
      {
        scenePChk(oPlayer1.x,296,0,0.1,oPlayer1.image_xscale)
        stopPlayer()
        sceneProgress+=1
      }
    }
  }
  else if sceneProgress=1 and bWaitForInput=false
    msgCreate(0,0,"Claire","What do we do now?",0,3,oMessageCutscene,1)
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"Chao","Only one place we can go.",0,3,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Claire","True, those people might know something, but... ugh, I don't like talking to them.",0,3,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Jerry","This is gonna be good.",0,3,oMessageCutscene,1)
  else if sceneProgress=5
  {
    var tNewChapter;
    tNewChapter=instance_create(0,0,oChapterDisplay)
    tNewChapter.newChapter="Act 312#The Great Bird"
    sceneDelay=0; sceneProgress=0
    global.gameProgress=3790
    global.gamePaused=false
  }
}
else if global.gameProgress=3800 and room=rGame6_WhisperWoodsA //----- [24] Finding the Great Bird -----
{
  if sceneProgress=0
  {
    if oPlayer1.x>=272
    {
      global.gamePaused=true
      oPlayer1.y+=4
      if oPlayer1.y>=256
      {
        global.recBirdsSeen+=1
        scenePChk(oPlayer1.x,256,0,0.1,1)
        stopPlayer()
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
    msgCreate(0,0,"Jerry","Well look at that. It's right there.",0,3,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Claire","Looks like we can ride it.",0,3,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Jerry","How do we get him to let us?",0,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Chao","He might just allow you to ride him now, if you ask. He seems non-hostile.",0,3,oMessageCutscene,1)
  else if sceneProgress=6 and bWaitForInput=false
    msgCreate(0,0,"Claire","That's it? Just ask?",0,3,oMessageCutscene,1)
  else if sceneProgress=7
  {
    sceneDelay+=1
    if sceneDelay>=20
    {
      oMisc.y-=3
      if oMisc.y<=-80 {sceneDelay=0; sceneProgress+=1}
    }
  }
  else if sceneProgress=8 and bWaitForInput=false
    msgCreate(0,0,"Jerry","So...",0,3,oMessageCutscene,1)
  else if sceneProgress=9 and bWaitForInput=false
    msgCreate(0,0,"Chao","He's waiting outside for you guys.",0,3,oMessageCutscene,1)
  else if sceneProgress=10 and bWaitForInput=false
    msgCreate(0,0,"Jerry","That was too easy, but I'm not really complaining. TO THE FINAL DUNGEON!",0,3,oMessageCutscene,1)
  else if sceneProgress=11 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Now that you can fly around the world, you should be able to find some side content to find more stuff and level up.",0,3,oMessageCutscene,1)
  else if sceneProgress=12 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Eh, I guess.",0,3,oMessageCutscene,1)
  else if sceneProgress=13 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","One other thing, should you ever get separated from the bird in such a way that he becomes unreachable because you do something super weird, you can call him to your location with [Action C] when on the world map.",0,3,oMessageCutscene,1)
  else if sceneProgress=14 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Oh yeah, and to get on it, just press [Jump] when standing over him... or her, I can't tell. To land, press [Action A], though you can't land in water or forests.",0,3,oMessageCutscene,1)
  else if sceneProgress=15
  {
    with oMisc {instance_destroy()}
    var tNewChapter;
    tNewChapter=instance_create(0,0,oChapterDisplay)
    tNewChapter.newChapter="Act 1000#Because 1000 is way#cooler looking than 10"
    global.stCGame_C[1]=1336; global.stCGame_C[2]=712
    sceneDelay=0; sceneProgress=0
    global.gameProgress=3810
    global.gamePaused=false
  }
}
else if global.gameProgress=3810 and room=rGame6_CoDB //----- [25] Intro to Castle of Doom -----
{
  if sceneProgress=0
  {
    sceneDelay+=1
    if sceneDelay=1 {global.gamePaused=true}
    else if sceneDelay>=20 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=1 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","And it's as I figured.",0,3,oMessageCutscene,1)
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"Jerry","What did you figure?",0,3,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","There is a central room somewhere here that requires you to break 3 objects before it'll open the way forward.",0,3,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Is it 3 crystal-shaped objects?",0,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","I'm willing to bet they are.",0,3,oMessageCutscene,1)
  else if sceneProgress=6
  {
    sceneDelay=0; sceneProgress=0
    global.gameProgress=3820
    global.gamePaused=false
  }
}
else if global.gameProgress=3820 and room=rGame6_CoDP //----- [26] Boss Fight: The Chosen One -----
{
  if global.bossTrack=0
  {
    if sceneProgress=0
    {
      if oPlayer1.x>=1056
      {
        global.gamePaused=true
        oPlayer1.y+=4
        if oPlayer1.y>=352
        {
          scenePChk(1056,352,0,0.1,1)
          stopPlayer()
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
      msgCreate(0,0,"'The Chosen One'","It's you again!",6,3,oMessageCutscene,1)
    else if sceneProgress=3 and bWaitForInput=false
      msgCreate(0,0,"Claire","Hey look, no surprise seeing you here!",0,3,oMessageCutscene,1)
    else if sceneProgress=4 and bWaitForInput=false
      msgCreate(0,0,"'The Chosen One'","Of course I'd be here. The Overlord is my father!",6,3,oMessageCutscene,1)
    else if sceneProgress=5 and bWaitForInput=false
      msgCreate(0,0,"Claire","I KNEW IT! Also you're a worthless trainer. I had to learn everything on my own.",0,3,oMessageCutscene,1)
    else if sceneProgress=6 and bWaitForInput=false
      msgCreate(0,0,"'The Chosen One'","That's quite insulting.",6,3,oMessageCutscene,1)
    else if sceneProgress=7 and bWaitForInput=false
      msgCreate(0,0,"Claire","That's the purpose. Now just move along so we can pass.",0,3,oMessageCutscene,1)
    else if sceneProgress=8
    {
      sceneDelay+=1
      if sceneDelay=1
      {
        stopAllMusic()
        depth=100
        npcBishonen.sprite_index=sWHB_Anger
        var tFlash;
        tFlash=instance_create(0,0,oScreenFlash)
        tFlash.fadeSpeed=0.1; tFlash.image_alpha=1
      }
      if sceneDelay>=11 and sceneDelay<=110
      {
        fadeColor=c_black
        fadeAlpha+=0.005
      }
      else if sceneDelay>=111 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=9 and bWaitForInput=false
      msgCreate(0,0,"'The Chosen One'","You fool...",6,3,oMessageCutscene,1)
    else if sceneProgress=10 and bWaitForInput=false
      msgCreate(0,0,"'The Chosen One'","Now you have angered me!",6,3,oMessageCutscene,1)
    else if sceneProgress=11 and bWaitForInput=false
      msgCreate(0,0,"Claire","Oh no, whatever will we do?!",0,3,oMessageCutscene,1)
    else if sceneProgress=12
    {
      sceneDelay+=1
      if sceneDelay>=15
      {
        if sceneDelay mod 3=0
        {
          var tFFScl,tEffect;
          tFFScl=random(0.1)
          tEffect=instance_create(npcBishonen.x+random_range(-16,16),npcBishonen.y-20+random_range(-20,20),oEffectB)
          tEffect.type=3; tEffect.sprite_index=sEfFirefly; tEffect.newBlend=-1; tEffect.image_alpha=1
          tEffect.image_xscale=0.15+tFFScl; tEffect.image_yscale=0.15+tFFScl; tEffect.direction=random(360)
          tEffect.speed=random(0.5)+0.5; tEffect.friction=random(0.01)+0.01; tEffect.fadeSpd=0.02
          tEffect.image_blend=c_black; tEffect.AccelX=0; tEffect.AccelY=0; tEffect.followID=-1; tEffect.rotation=0
        }
        npcBishonen.y+=1
        if npcBishonen.y>=room_height+56 {sceneDelay=0; sceneProgress+=1}
      }
    }
    else if sceneProgress=13
    {
      sceneDelay+=1
      if sceneDelay=1
      {
        with npcBishonen {instance_destroy()}
        bossTOTO=instance_create(992,592,oPT_TOTO)
      }
      else if sceneDelay>=2
      {
        bossTOTO.y-=2
        if bossTOTO.y<=224 {sceneDelay=0; sceneProgress+=1}
      }
    }
    else if sceneProgress=14 and bWaitForInput=false
      msgCreate(0,0,"'The Chosen One'","I will show you why I am called 'The Chosen One.'",6,3,oMessageCutscene,1)
    else if sceneProgress=15 and bWaitForInput=false
      msgCreate(0,0,"Claire","Huh, wasn't expecting that one.",0,3,oMessageCutscene,1)
    else if sceneProgress=16 and bWaitForInput=false
      msgCreate(0,0,"Jerry","Nice one, Claire.",0,3,oMessageCutscene,1)
    else if sceneProgress=17 and bWaitForInput=false
      msgCreate(0,0,"Claire","Shut up, doofus.",0,3,oMessageCutscene,1)
    else if sceneProgress=18
    {
      global.gamePaused=false
      fadeColor=c_black
      depth=0; fadeAlpha=0.3
      with oPT_TOTO {instance_destroy()}
      var tempMplay,tBossTitle,enemyBarrier;
      tempMplay=findMusic(819)
      playMusic(tempMplay,0,0)
      tBossTitle=instance_create(0,0,oBossNameDisplay)
      tBossTitle.bossName="The Chosen One"
      tBossTitle.bossTitle="But Is He Really?"
      boss=instance_create(992,224,oPT_TOTO)
      boss.activateBoss=1
      enemyBarrier=instance_create(448,-48,oEnemyBarrier); enemyBarrier.image_yscale=38
      enemyBarrier=instance_create(1648,-48,oEnemyBarrier); enemyBarrier.image_yscale=38
      global.currentBoss="Chosen One"
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
      global.gamePaused=true
      awardBossAP(8500)
      global.bossTrack=2
      sceneProgress=0
    }
  }
  else if global.bossTrack=2
  {
    if sceneProgress=0
    {
      var tFullHeartDrop,tempMplay;
      tFullHeartDrop=instance_create(1056,128,oHealthPickup)
      tFullHeartDrop.sprite_index=sFullHealthPickup
      tempMplay=findMusic(604)
      playMusic(tempMplay,0,0)
      with oEnemyBarrier {instance_destroy()}
      global.gamePaused=false
      global.currentBoss=""
      global.bossTrack=0
      global.gameProgress=3830
    }
  }
}
else if global.gameProgress=3830 and room=rGame6_CoDQ //----- [27] Regain Dash and Air-Dash -----
{
  if sceneProgress=0
  {
    sceneDelay+=1
    if sceneDelay=1 {global.gamePaused=true}
    else if sceneDelay>=20 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=1 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Huh, well that's a thing...",0,3,oMessageCutscene,1)
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"Jerry","What?",0,3,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","I just figured out how to get your dashes back in this Gate.",0,3,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Oh right, AFTER a big fight like that.",0,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Well you two took forever, so I had a lot of time to look around for what was blocking access to it.",0,3,oMessageCutscene,1)
  else if sceneProgress=6 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Happy to have it back in any case.",0,3,oMessageCutscene,1)
  else if sceneProgress=7
  {
    global.hasShoes[2]=2; global.hasShoes[3]=2
    sceneDelay=0; sceneProgress=0
    global.gameProgress=3840
    global.gamePaused=false
  }
}
else if global.gameProgress=3851 and room=rGame6_CoD_ESC //----- [Unskippable] Evil Shadowy Councelman A -----
{
  if sceneProgress=0
  {
    if oPlayer1.x>=224
    {
      global.gamePaused=true
      oPlayer1.y+=4
      if oPlayer1.y>=272
      {
        scenePChk(oPlayer1.x,272,0,0.1,1)
        stopPlayer()
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
    msgCreate(0,0,"Jerry","Who is this guy?",0,3,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","He's one of those 3 shadowy guys.",0,3,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Evil Shadowy Councilman A","It is unfortunate that you run into me first. I am Evil Shadowy Councilman A, and I happen to be the most powerful of us. Even more powerful than the Great Evil Overlord's son.",6,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Jerry","That's cool and all, but we're about twice as powerful as him.",0,3,oMessageCutscene,1)
  else if sceneProgress=6 and bWaitForInput=false
    msgCreate(0,0,"Evil Shadowy Councilman A","Even if that were true, our power amplifies when the 3 of us fuse together.",6,3,oMessageCutscene,1)
  else if sceneProgress=7 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","How much more can you get out of this guy, Jerry?",0,3,oMessageCutscene,1)
  else if sceneProgress=8 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Let's see.",0,3,oMessageCutscene,1)
  else if sceneProgress=9 and bWaitForInput=false
    msgCreate(0,0,"Evil Shadowy Councilman A","What?",6,3,oMessageCutscene,1)
  else if sceneProgress=10 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","I keep forgetting that only the overlord can hear me.",0,3,oMessageCutscene,1)
  else if sceneProgress=11 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Nothing man, carry on, tell us more... or just fight us!",0,3,oMessageCutscene,1)
  else if sceneProgress=12 and bWaitForInput=false
    msgCreate(0,0,"Evil Shadowy Councilman A","You don't understand what we've gone through. What we've had to endure. I will never forget what Councilman B has done for me.",6,3,oMessageCutscene,1)
  else if sceneProgress=13 and bWaitForInput=false
    msgCreate(0,0,"Evil Shadowy Councilman A","When he found me, I was still so young, so scared. He took me in and cared for me when no one else would. When the world turned its back on me.",6,3,oMessageCutscene,1)
  else if sceneProgress=14 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Is he really doing what I think he's doing?",0,3,oMessageCutscene,1)
  else if sceneProgress=15 and bWaitForInput=false
    msgCreate(0,0,"Evil Shadowy Councilman A","He taught me the ways of the world. He was more than a friend, he was like a brother to me.",6,3,oMessageCutscene,1)
  else if sceneProgress=16 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Oh no, he's actually going to tell us some tragic back story. Jerry, what the hell did you do to set this off?",0,3,oMessageCutscene,1)
  else if sceneProgress=17 and bWaitForInput=false
    msgCreate(0,0,"Evil Shadowy Councilman A","You don't understand the atrocities we suffered through to get here. When the Overlord found us, it changed everything.",6,3,oMessageCutscene,1)
  else if sceneProgress=18 and bWaitForInput=false
    msgCreate(0,0,"Jerry","I don't really care, honestly.",0,3,oMessageCutscene,1)
  else if sceneProgress=19 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Who wrote this? ... I'm gonna punch John in the face for this.",0,3,oMessageCutscene,1)
  else if sceneProgress=20 and bWaitForInput=false
    msgCreate(0,0,"Evil Shadowy Councilman A","But I have to tell you our story, so you understand. You'll understand everything. Where we came from.",6,3,oMessageCutscene,1)
  else if sceneProgress=21 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","You guys, just do whatever you want here.",0,3,oMessageCutscene,1)
  else if sceneProgress=22
  {
    (429501).dialogueSeq=1; (429501).bCanTakeDamage=1
    global.gamePaused=false
    sceneProgress+=1
  }
}
else if global.gameProgress=3852 and room=rGame6_CoD_ESC //----- [Unskippable] Evil Shadowy Councelman B -----
{
  if sceneProgress=0
  {
    if oPlayer1.x>=896
    {
      global.gamePaused=true
      oPlayer1.y+=4
      if oPlayer1.y>=272
      {
        scenePChk(oPlayer1.x,272,0,0.1,1)
        stopPlayer()
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
    msgCreate(0,0,"Jerry","Oh no, another one.",0,3,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Evil Shadowy Councilman B","I see you defeated Councilman A. It must have been a fierce battle! He often spoke of how he was the strongest of us three. It is simply not true. Councilman C is the strongest of us!",6,3,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Oh do tell... wait NO! DAMN IT!",0,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Evil Shadowy Councilman B","You must be thinking why I would undermine myself. I am not. I am actually stronger than Councilman A, but Councilman C is just that much more powerful.",6,3,oMessageCutscene,1)
  else if sceneProgress=6 and bWaitForInput=false
    msgCreate(0,0,"Claire","Thanks Jerry.",0,3,oMessageCutscene,1)
  else if sceneProgress=7 and bWaitForInput=false
    msgCreate(0,0,"Chao","Yeah, that was a bad move there.",0,3,oMessageCutscene,1)
  else if sceneProgress=8 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Even my sister is in on this. You really goofed this one.",0,3,oMessageCutscene,1)
  else if sceneProgress=9 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Whatever you guys. There was a tiny smidgen of curiosity.",0,3,oMessageCutscene,1)
  else if sceneProgress=10 and bWaitForInput=false
    msgCreate(0,0,"Evil Shadowy Councilman B","I taught Councilman A all he knew in the ways of combat. He learned quick, very quick actually. But I learned from Councilman C.",6,3,oMessageCutscene,1)
  else if sceneProgress=11 and bWaitForInput=false
    msgCreate(0,0,"Evil Shadowy Councilman B","He is so advanced that even with all that I taught him, Councilman A couldn't comprehend his impressive array of skill.",6,3,oMessageCutscene,1)
  else if sceneProgress=12 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Okay, we're done here.",0,3,oMessageCutscene,1)
  else if sceneProgress=13 and bWaitForInput=false
    msgCreate(0,0,"Evil Shadowy Councilman B","But you haven't even heard the best part!",6,3,oMessageCutscene,1)
  else if sceneProgress=14 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Ugh, it's going to happen regardless now.",0,3,oMessageCutscene,1)
  else if sceneProgress=15
  {
    (429502).dialogueSeq=1; (429502).bCanTakeDamage=1
    global.gamePaused=false
    sceneProgress+=1
  }
}
else if global.gameProgress=3853 and room=rGame6_CoD_ESC //----- [Unskippable] Evil Shadowy Councelman C -----
{
  if sceneProgress=0
  {
    if oPlayer1.x>=1456
    {
      global.gamePaused=true
      oPlayer1.y+=4
      if oPlayer1.y>=272
      {
        scenePChk(oPlayer1.x,272,0,0.1,1)
        stopPlayer()
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
    msgCreate(0,0,"Evil Shadowy Councilman C","You've done well to make it this far.",6,3,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Please don't tell us some silly story or go into some backstory that we don't care about.",0,3,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Evil Shadowy Councilman C","Ah yes, my back story, there is much to tell.",6,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Jerry","NO! DAMN IT AGAIN!",0,3,oMessageCutscene,1)
  else if sceneProgress=6 and bWaitForInput=false
    msgCreate(0,0,"Claire","You should probably stop talking, Jerry.",0,3,oMessageCutscene,1)
  else if sceneProgress=7 and bWaitForInput=false
    msgCreate(0,0,"Evil Shadowy Councilman C","Indeed he should, for I have much to tell you before we battle.",6,3,oMessageCutscene,1)
  else if sceneProgress=8 and bWaitForInput=false
    msgCreate(0,0,"Claire","You're the strongest, are you not?",0,3,oMessageCutscene,1)
  else if sceneProgress=9 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Oh what, Claire? WHAT?!",0,3,oMessageCutscene,1)
  else if sceneProgress=10 and bWaitForInput=false
    msgCreate(0,0,"Evil Shadowy Councilman C","That I am. I did not learn from just anyone. No, I learned from the land itself! I forged me. A warrior greater than any other!",6,3,oMessageCutscene,1)
  else if sceneProgress=11 and bWaitForInput=false
    msgCreate(0,0,"Chao","Was that a typo?",0,3,oMessageCutscene,1)
  else if sceneProgress=12 and bWaitForInput=false
    msgCreate(0,0,"Evil Shadowy Councilman C","And then something better revealed itself to me. He was the Overlord and he showed me that there was more.",6,3,oMessageCutscene,1)
  else if sceneProgress=13 and bWaitForInput=false
    msgCreate(0,0,"Evil Shadowy Councilman C","But I am incapable of his level of comprehension. He is indeed great.",6,3,oMessageCutscene,1)
  else if sceneProgress=14 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Don't care anymore!",0,3,oMessageCutscene,1)
  else if sceneProgress=15 and bWaitForInput=false
    msgCreate(0,0,"Evil Shadowy Councilman C","But I have something else to tell.",6,3,oMessageCutscene,1)
  else if sceneProgress=16
  {
    (429503).dialogueSeq=1; (429503).bCanTakeDamage=1
    global.gamePaused=false
    sceneProgress+=1
  }
}
else if global.gameProgress=3854 and room=rGame6_CoDT //----- [28] Prepare for the Overlord -----
{
  if sceneProgress=0
  {
    sceneDelay+=1
    if sceneDelay=1 {global.gamePaused=true}
    else if sceneDelay>=20 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=1 and bWaitForInput=false
    msgCreate(0,0,"Jerry","That was entirely pointless.",0,3,oMessageCutscene,1)
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"Claire","Says the one who instigated most of it.",0,3,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Hey, you did it too!",0,3,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Chao","Both of you kept that going.",0,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Bam, just like that.",0,3,oMessageCutscene,1)
  else if sceneProgress=6 and bWaitForInput=false
    msgCreate(0,0,"Claire","That includes you too.",0,3,oMessageCutscene,1)
  else if sceneProgress=7 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Eh, so you two know what's coming up?",0,3,oMessageCutscene,1)
  else if sceneProgress=8 and bWaitForInput=false
    msgCreate(0,0,"Jerry","That overlord guy. We know.",0,3,oMessageCutscene,1)
  else if sceneProgress=9 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Those shadow council guys may have been a joke, but this overlord guy is very aware of what's happening. We have no idea where he stands on things.",0,3,oMessageCutscene,1)
  else if sceneProgress=10 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Do you think he's working with Hex?",0,3,oMessageCutscene,1)
  else if sceneProgress=11 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","It's a possibility. If he is, getting the Chip may be a lot harder than we thought.",0,3,oMessageCutscene,1)
  else if sceneProgress=12 and bWaitForInput=false
    msgCreate(0,0,"Claire","We got this you guys.",0,3,oMessageCutscene,1)
  else if sceneProgress=13 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","I hope so. Just be ready for anything. Despite the way he acts, he's clearly not stupid.",0,3,oMessageCutscene,1)
  else if sceneProgress=14 and bWaitForInput=false
    msgCreate(0,0,"Chao","Last Program Chip. When we have this, we win.",0,3,oMessageCutscene,1)
  else if sceneProgress=15 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Yeah... let's do this.",0,3,oMessageCutscene,1)
  else if sceneProgress=16
  {
    sceneDelay=0; sceneProgress=0
    global.gameProgress=3860
    global.gamePaused=false
  }
}
else if global.gameProgress=3860 and room=rGame6_CoDU //----- [Unskippable] Intro to the Trivia Lord -----
{
  if lightningTime>=1
  {
    lightningTime+=1
    if lightningTime>=45
    {
      var tRoomLightning;
      tRoomLightning=instance_create(random_range(48,384),16+random(40),oG6_Lightning)
      tRoomLightning.image_angle=90+random_range(235,305)
      lightningTime=1+irandom(14)
    }
  }
  
  if sceneProgress=0
  {
    sceneDelay+=1
    if sceneDelay=1
    {
      oPlayer1.x=144; oPlayer1.y=816
      cameraFollow=instance_create(240,176,oMisc)
      cameraFollow.type=0; cameraFollow.sprite_index=sNull
      view_object[0]=cameraFollow
      global.gamePaused=true
    }
    else if sceneDelay>=30
    {
      musicFade-=90
      fadeVolume(global.msc_RPGDoomCastle,90)
      if musicFade<=5500
      {
        stopAllMusic()
        sceneDelay=0; sceneProgress+=1
      }
    }
  }
  else if sceneProgress=1
  {
    sceneDelay+=1
    if sceneDelay=1 //Load voice sound files
    {
      voice01=SS_LoadSound(working_directory+"\Sound\DT_VO01.wav",0)
      voice02=SS_LoadSound(working_directory+"\Sound\DT_VO02.wav",0)
      voice03=SS_LoadSound(working_directory+"\Sound\DT_VO03.wav",0)
      voice04=SS_LoadSound(working_directory+"\Sound\DT_VO04.wav",0)
      voice05=SS_LoadSound(working_directory+"\Sound\DT_VO05.wav",0)
      voice06=SS_LoadSound(working_directory+"\Sound\DT_VO06.wav",0)
      voice07=SS_LoadSound(working_directory+"\Sound\DT_VO07.wav",0)
      voice08=SS_LoadSound(working_directory+"\Sound\DT_VO08.wav",0)
      voice09=SS_LoadSound(working_directory+"\Sound\DT_VO09.wav",0)
      voice10=SS_LoadSound(working_directory+"\Sound\DT_VO10.wav",0)
    }
    if sceneDelay=30
    {
      musicFade=global.optMusic*100
      var tempMplay;
      tempMplay=findMusic(1011)
      playMusic(tempMplay,0,0)
    }
    else if sceneDelay>=31 and sceneDelay<=130
    {
      if sceneDelay=80 {lightningTime=50}
      fadeAlpha-=0.01
    }
    else if sceneDelay>=180 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=2
  {
    sceneDelay+=1
    if sceneDelay>=1 and sceneDelay<=699
    {
      if sceneDelay=240 {lightningTime=0}
      cameraFollow.y+=1
      if cameraFollow.y>=room_height-144 {sceneDelay=700}
    }
    else if sceneDelay>=720
    {
      musicFade-=40
      fadeVolume(global.msc_MasterPlan,40)
      if musicFade<=7500 {sceneDelay=0; sceneProgress+=1}
    }
  }
  else if sceneProgress=3 //VOICE WORK GOES HERE
  {
    sceneDelay+=1
    if sceneDelay=10
    {
      createScreenText(50,286,-1,fnt_Location,fa_left,"<Laughter>",3,c_white,1,0)
      playSound(voice10,0,1,1)
    }
    else if sceneDelay=80
    {
      event_user(0)
      createScreenText(50,286,-1,fnt_Location,fa_left,"YOU FINALLY ARRIVED TO MY LAIR!",3,c_white,1,0)
      playSound(voice02,0,1,1)
    }
    else if sceneDelay=170
    {
      event_user(0)
      createScreenText(50,286,-1,fnt_Location,fa_left,"NOW YOU SHALL WITNESS MY TRUE POWER!",3,c_white,1,0)
      playSound(voice03,0,1,1)
    }
    else if sceneDelay=280
    {
      event_user(0)
      createScreenText(50,286,-1,fnt_Location,fa_left,"MY HIDDEN POWERS HAD BEEN LOCKED#AWAY FOR AGES!",3,c_white,1,0)
      playSound(voice04,0,1,1)
    }
    else if sceneDelay=390
    {
      event_user(0)
      createScreenText(50,286,-1,fnt_Location,fa_left,"BUT THANKS TO YOU AND YOUR ENDEAVORS,#I CAN NOW UNLEASH THEM UPON THE#WORLD ONCE MORE!",3,c_white,1,0)
      playSound(voice05,0,1,1)
    }
    else if sceneDelay=560
    {
      event_user(0)
      createScreenText(50,286,-1,fnt_Location,fa_left,"AND THERE IS NOTHING YOU CAN#DO TO STOP IT!",3,c_white,1,0)
      playSound(voice06,0,1,1)
    }
    else if sceneDelay=640
    {
      event_user(0)
      createScreenText(50,286,-1,fnt_Location,fa_left,"FOR YOU, NOW FACE...",3,c_white,1,0)
      playSound(voice07,0,1,1)
    }
    else if sceneDelay=720
    {
      event_user(0)
      createScreenText(50,286,-1,fnt_Location,fa_left,"THE TRIVIA LORD...",3,c_white,1,0)
      playSound(voice08,0,1,1)
    }
    else if sceneDelay=750
    {
      event_user(0)
      createScreenText(50,286,-1,fnt_Location,fa_left,"OF TRIVIA!!",3,c_white,1,0)
      playSound(voice09,0,1,1)
    }
    else if sceneDelay=780
    {
      /*musicFade=(global.optMusic*100)-1500
      var tempMplay;
      tempMplay=findMusic(1012)
      playMusic(tempMplay,0,0)
      fadeVolume(global.msc_Trivia,1500)*/
      musicFade=(global.optMusic*100)
      var tempMplay;
      tempMplay=findMusic(1012)
      playMusic(tempMplay,0,0)
    }
    else if sceneDelay=800
    {
      event_user(0); createScreenText(50,286,-1,fnt_Location,fa_left,"<Laughter>",3,c_white,1,0)
      playSound(voice01,0,1,1)
    }
    else if sceneDelay>=880 {event_user(0); sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Jerry","The hell?",0,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Claire","I'm thinking the same thing Jerry is...",0,3,oMessageCutscene,1)
  else if sceneProgress=6 and bWaitForInput=false
    msgCreate(0,0,"Trivia Lord","You are confused?! I will remedy this!!",6,3,oMessageCutscene,1)
  else if sceneProgress=7 and bWaitForInput=false
    msgCreate(0,0,"Trivia Lord","I have knowledge of everything!!",6,3,oMessageCutscene,1)
  else if sceneProgress=8 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Everything?",0,3,oMessageCutscene,1)
  else if sceneProgress=9 and bWaitForInput=false
    msgCreate(0,0,"Trivia Lord","ALMOST everything!!",6,3,oMessageCutscene,1)
  else if sceneProgress=10 and bWaitForInput=false
    msgCreate(0,0,"Jerry","So... what is it you do? Like, are we going to fight?",0,3,oMessageCutscene,1)
  else if sceneProgress=11 and bWaitForInput=false
    msgCreate(0,0,"Trivia Lord","Fight?! I am the Trivia Lord, I do not battle, that is for primative beasts!! I ask questions!! Questions from all sorts of topics!!",6,3,oMessageCutscene,1)
  else if sceneProgress=12 and bWaitForInput=false
    msgCreate(0,0,"Jerry","You're really excited about this, aren't you?",0,3,oMessageCutscene,1)
  else if sceneProgress=13 and bWaitForInput=false
    msgCreate(0,0,"Trivia Lord","I am the Trivia Lord!! Asking trivia questions is what I have devoted my life to!!",6,3,oMessageCutscene,1)
  else if sceneProgress=14 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Hold up, why did you need to shatter the Crystals then?",0,3,oMessageCutscene,1)
  else if sceneProgress=15 and bWaitForInput=false
    msgCreate(0,0,"Trivia Lord","They were annoying!!",6,3,oMessageCutscene,1)
  else if sceneProgress=16 and bWaitForInput=false
    msgCreate(0,0,"Jerry","You're joking, right?",0,3,oMessageCutscene,1)
  else if sceneProgress=17 and bWaitForInput=false
    msgCreate(0,0,"Trivia Lord","NO!! They hid my questioning powers away!! Do you know how annoying that is?!",6,3,oMessageCutscene,1)
  else if sceneProgress=18 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Not particularly, but wait, what's up with this shadow evil council... thing or whatever?",0,3,oMessageCutscene,1)
  else if sceneProgress=19 and bWaitForInput=false
    msgCreate(0,0,"Trivia Lord","They were but mere pawns to buy me more time.",6,3,oMessageCutscene,1)
  else if sceneProgress=20 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","More time for what?",0,3,oMessageCutscene,1)
  else if sceneProgress=21 and bWaitForInput=false
    msgCreate(0,0,"Trivia Lord","To set up the hardest quiz show in history!!",6,3,oMessageCutscene,1)
  else if sceneProgress=22 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","That is so... just...",0,3,oMessageCutscene,1)
  else if sceneProgress=23 and bWaitForInput=false
    msgCreate(0,0,"Trivia Lord","Incredible! I know!! And I have succeeded!",6,3,oMessageCutscene,1)
  else if sceneProgress=24 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Yeah... anyway... we need something from you.",0,3,oMessageCutscene,1)
  else if sceneProgress=25 and bWaitForInput=false
    msgCreate(0,0,"Trivia Lord","Ah yes, that Program something or other. I have it. Why I have it, I don't know, but you can take it under one condition.",6,3,oMessageCutscene,1)
  else if sceneProgress=26 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","What would that be?",0,3,oMessageCutscene,1)
  else if sceneProgress=27 and bWaitForInput=false
    msgCreate(0,0,"Trivia Lord","YOU MUST PLAY MY TRIVIA GAME AND ENJOY IT NON-SARCASTICALLY!!",6,3,oMessageCutscene,1)
  else if sceneProgress=28 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","That's it? Sure we can do that.",0,3,oMessageCutscene,1)
  else if sceneProgress=29 and bWaitForInput=false
    msgCreate(0,0,"Trivia Lord","YES!! THE TRIVIA LORD HAS RETURNED TO HIS FORMER GLORY!! ON TO THE QUESTIONS!! NO WAIT!! I MUST TEACH YOU HOW TO ANSWER THEM!!",6,3,oMessageCutscene,1)
  else if sceneProgress=30 and bWaitForInput=false
    msgCreate(0,0,"Jerry","We don't really need...",0,3,oMessageCutscene,1)
  else if sceneProgress=31 and bWaitForInput=false
    msgCreate(0,0,"Trivia Lord","Step 1: Carefully read the question.#Step 2: Look over the provided answers. It's multiple choice!#Step 3: Analyze the question and answers provided.#Step 4: Think about and draw upon your vast knowledge!",6,3,oMessageCutscene,1)
  else if sceneProgress=32 and bWaitForInput=false
    msgCreate(0,0,"Trivia Lord","Step 5: Press the [Arrow Keys] to move the cursor over the answer you think... no... the answer you know is true!#STEP 6: ANSWER WITH ALL YOUR HEART!! The [Confirm/Jump] Key will unlock the path toward truth!",6,3,oMessageCutscene,1)
  else if sceneProgress=33 and bWaitForInput=false
    msgCreate(0,0,"Claire","Okay wow, it's just a menu that's going to pop up I'm sure. We don't need a whole tutorial on how to navigate a simple menu.",0,3,oMessageCutscene,1)
  else if sceneProgress=34 and bWaitForInput=false
    msgCreate(0,0,"Trivia Lord","I am pleased by this response! NOW WE MOVE ON TO THE QUESTIONS!! QUIZ TIME EVERYBODY!!",6,3,oMessageCutscene,1)
  else if sceneProgress=35
  {
    sceneDelay+=1
    if sceneDelay=15
    {
      myTrivia=instance_create(0,0,oTriviaWindow)
      myTrivia.quizType=1
      sceneDelay=0; sceneProgress+=1
    }
  }
  else if sceneProgress=50
  {
    sceneDelay+=1
    if sceneDelay=25 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=51 and bWaitForInput=false
    msgCreate(0,0,"Trivia Lord","SO WHAT DID YOU THINK OF MY TRIVIA?!",6,3,oMessageCutscene,1)
  else if sceneProgress=52 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Well... it was relevant to our interests.",0,3,oMessageCutscene,1)
  else if sceneProgress=53 and bWaitForInput=false
    msgCreate(0,0,"Trivia Lord","Relevant... to your interests...",6,3,oMessageCutscene,1)
  else if sceneProgress=54 and bWaitForInput=false
    msgCreate(0,0,"Trivia Lord","I KNEW IT!! I AM THE GREATEST TRIVIA GIVER TO HAVE EVER EXISTED!!",6,3,oMessageCutscene,1)
  else if sceneProgress=55 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","So we passed?",0,3,oMessageCutscene,1)
  else if sceneProgress=56 and bWaitForInput=false
    msgCreate(0,0,"Trivia Lord","Yes! You may have the McGuff... err, the Program thingie-ma-bob you were looking for.",6,3,oMessageCutscene,1)
  else if sceneProgress=57
  {
    sceneDelay+=1
    if sceneDelay=20
    {
      pChip=instance_create(oPlayer1.x,708,oProgramChip)
      pChip.chipType=5; pChip.visible=0
    }
    else if sceneDelay>=21 and sceneDelay<=35
    {
      circleRad+=2
      if sceneDelay=25 {pChip.visible=1}
    }
    else if sceneDelay>=36 and sceneDelay<=50 {circleRad-=2}
    else if sceneDelay>=75 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=58
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
    else if sceneDelay=160
    {
      global.programChips=6
      sceneDelay=0; sceneProgress+=1
    }
  }
  else if sceneProgress=59 and bWaitForInput=false
    msgCreate(0,0,"Claire","We finally have them all!",0,3,oMessageCutscene,1)
  else if sceneProgress=60 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Yes. We should head back to Central City. There should be something there that will allow us to activate these. When that happens, the Virus will be removed from the system.",0,3,oMessageCutscene,1)
  else if sceneProgress=61 and bWaitForInput=false
    msgCreate(0,0,"Jerry","So what's up with this Gate though, something isn't right here.",0,3,oMessageCutscene,1)
  else if sceneProgress=62 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","You mean your abilities not coming back here? It might be something to do with all the issues this place has, but it doesn't look like you'll be able to bring your other abilities in here, nor can you bring these outside of this place.",0,3,oMessageCutscene,1)
  else if sceneProgress=63 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Well that kinda sucks.",0,3,oMessageCutscene,1)
  else if sceneProgress=64 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","We're almost done though, you won't need the abilities here anyway.",0,3,oMessageCutscene,1)
  else if sceneProgress=65 and bWaitForInput=false
    msgCreate(0,0,"Trivia Lord","So that's what you needed the Chip for...",6,3,oMessageCutscene,1)
  else if sceneProgress=66 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Yeah, what of it?",0,3,oMessageCutscene,1)
  else if sceneProgress=67 and bWaitForInput=false
    msgCreate(0,0,"Trivia Lord","You should have said something sooner. I would have simply handed it over. The world being taken down means no trivia!",6,3,oMessageCutscene,1)
  else if sceneProgress=68 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Right... full disclosure next time.",0,3,oMessageCutscene,1)
  else if sceneProgress=69 and bWaitForInput=false
    msgCreate(0,0,"Trivia Lord","Well, you have important things to do, but do come back any time for more trivia! I have so many more questions to ask!!",6,3,oMessageCutscene,1)
  else if sceneProgress=70 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","We'll keep that in mind.",0,3,oMessageCutscene,1)
  else if sceneProgress=71 and bWaitForInput=false
    msgCreate(0,0,"Jerry","This is seriously upsetting.",0,3,oMessageCutscene,1)
  else if sceneProgress=72 and bWaitForInput=false
    msgCreate(0,0,"Claire","Why is that?",0,3,oMessageCutscene,1)
  else if sceneProgress=73 and bWaitForInput=false
    msgCreate(0,0,"Jerry","He was going to give us the damn Chip this whole time! THIS WHOLE THING WAS A WASTE OF TIME!",0,3,oMessageCutscene,1)
  else if sceneProgress=74 and bWaitForInput=false
    msgCreate(0,0,"Claire","You about to go on another rpg hating moment?",0,3,oMessageCutscene,1)
  else if sceneProgress=75 and bWaitForInput=false
    msgCreate(0,0,"Jerry","No, but this is the worst one ever.",0,3,oMessageCutscene,1)
  else if sceneProgress=76 and bWaitForInput=false
    msgCreate(0,0,"Claire","I... kind of agree. Certainly one of the worst.",0,3,oMessageCutscene,1)
  else if sceneProgress=77
  {
    SS_FreeSound(voice01); voice01=0
    SS_FreeSound(voice02); voice02=0
    SS_FreeSound(voice03); voice03=0
    SS_FreeSound(voice04); voice04=0
    SS_FreeSound(voice05); voice05=0
    SS_FreeSound(voice06); voice06=0
    SS_FreeSound(voice07); voice07=0
    SS_FreeSound(voice08); voice08=0
    SS_FreeSound(voice09); voice09=0
    SS_FreeSound(voice10); voice10=0
    var tHeartContainer;
    tHeartContainer=instance_create(240,808,oHeartContainer)
    tHeartContainer.objectNum=6
    sceneDelay=0; sceneProgress=0
    oHUD.visible=1
    global.gameProgress=3870
    global.gamePaused=false
  }
}

keyWaitForInput()

if oKeyCodes.kCodePressed[11]=1 and global.gamePaused=true and sceneProgress>=1 //Cutscene skip
{
  if !instance_exists(oPauseMenu)
  {
    if global.gameProgress=3390 and room=rGame6_WhisperWoodsA //[1]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      fadeAlpha=0; sceneDelay=0
      sceneProgress=19
    }
    else if global.gameProgress=3400 and room=rGame6_Hometown //[2]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      fadeAlpha=0; sceneDelay=0
      sceneProgress=27
    }
    else if global.gameProgress=3410 and room=rGame6_HeroPlainsA //[3]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      fadeAlpha=0; sceneDelay=0
      sceneProgress=18
    }
    else if global.gameProgress=3420 and room=rGame6_HeroPlainsA //[4]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      fadeAlpha=0; sceneDelay=0
      sceneProgress=18
    }
    else if global.gameProgress=3421 and room=rGame6_HeroPlainsB //[5]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      fadeAlpha=0; sceneDelay=0
      sceneProgress=8
    }
    else if global.gameProgress=3422 and room=rGame6_HeroPlainsD //[6]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      with oMisc {instance_destroy()}
      fadeAlpha=0; sceneDelay=0
      sceneProgress=38
    }
    else if global.gameProgress=3430 and room=rGame6_HeroPlainsD //[7]
    {
      if sceneProgress>=2
      {
        bWaitForInput=false
        with oMessageCutscene {instance_destroy()}
        with oMisc {instance_destroy()}
        fadeAlpha=0; sceneDelay=0
        sceneProgress=16
      }
    }
    else if global.gameProgress=3440 and room=rGame6_Hometown //[8]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      fadeAlpha=0; sceneDelay=0
      sceneProgress=34
    }
    else if global.gameProgress=3450 and room=rGame6_EarthA //[9]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      fadeAlpha=0; sceneDelay=0
      sceneProgress=6
    }
    else if global.gameProgress=3480 and room=rGame6_JDream //[10]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      fadeAlpha=0; sceneDelay=0
      sceneProgress=13
    }
    else if global.gameProgress=3490 and room=rGame6_JDream //[11]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      fadeAlpha=0; sceneDelay=0
      sceneProgress=33
    }
    else if global.gameProgress=3503 and room=rGame6_FireE //[12]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      fadeAlpha=0; sceneDelay=0
      sceneProgress=23
    }
    else if global.gameProgress=3530 and room=rGame6_FireF //[13]
    {
      if sceneProgress!=11
      {
        bWaitForInput=false
        with oMessageCutscene {instance_destroy()}
        fadeAlpha=0; sceneDelay=0
        sceneProgress=11
      }
    }
    else if global.gameProgress=3540 and room=rGame6_ESC_Scene //[14]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      fadeAlpha=0; sceneDelay=0
      sceneProgress=20
    }
    else if global.gameProgress=3540 and room=rGame6_Gate //[15]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      fadeAlpha=0; sceneDelay=0
      sceneProgress=16
    }
    else if global.gameProgress=3545 and room=rGame6_Hometown //[16]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      fadeAlpha=0; sceneDelay=0
      sceneProgress=14
    }
    else if global.gameProgress=3570 and room=rGame6_WaterA //[17]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      fadeAlpha=0; sceneDelay=0
      sceneProgress=8
    }
    else if global.gameProgress=3590 and room=rGame6_CoMB //[18]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      fadeAlpha=0; sceneDelay=0
      sceneProgress=8
    }
    else if global.gameProgress=3630 and room=rGame6_WindJ //[19]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      fadeAlpha=0; sceneDelay=0
      sceneProgress=15
    }
    else if global.gameProgress=3640 and room=rGame6_Hometown //[20]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      fadeColor=c_white
      fadeAlpha=1; sceneDelay=0
      sceneProgress=32
    }
    else if global.gameProgress=3640 and room=rGame6_DreamWoodsA //[21]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      fadeAlpha=0; sceneDelay=0
      sceneProgress=15
    }
    else if global.gameProgress=3760 and room=rGame6_DreamWoodsF //[22]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      fadeAlpha=0; sceneDelay=0
      sceneProgress=9
    }
    else if global.gameProgress=3780 and room=rGame6_Hometown //[23]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      fadeAlpha=0; sceneDelay=0
      sceneProgress=5
    }
    else if global.gameProgress=3800 and room=rGame6_WhisperWoodsA //[24]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      fadeAlpha=0; sceneDelay=0
      sceneProgress=15
    }
    else if global.gameProgress=3810 and room=rGame6_CoDB //[25]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      fadeAlpha=0; sceneDelay=0
      sceneProgress=6
    }
    else if global.gameProgress=3820 and room=rGame6_CoDP //[26]
    {
      if global.bossTrack=0
      {
        bWaitForInput=false
        with oMessageCutscene {instance_destroy()}
        fadeAlpha=0; sceneDelay=0
        sceneProgress=18
      }
    }
    else if global.gameProgress=3830 and room=rGame6_CoDQ //[27]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      fadeAlpha=0; sceneDelay=0
      sceneProgress=7
    }
    else if global.gameProgress=3854 and room=rGame6_CoDT //----- [29]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      fadeAlpha=0; sceneDelay=0
      sceneProgress=16
    }
  }
}

//----- Room specific events -----
if global.gamePaused=false
{
  if room=rGame6_EarthH
  {
    if spikeInit=0
    {
      with oTimedSpikeFloor {switchDelay=40}
      spikeInit=1
    }
  }
  else if room=rGame6_EarthI
  {
    if spikeInit=0
    {
      with oTimedSpikeFloor {switchDelay=22}
      spikeInit=1
    }
  }
  else if room=rGame6_FireD
  {
    if wallCheck=0
    {
      if !instance_exists((326218))
      {
        tile_layer_hide(9)
        wallCheck=1
      }
    }
  }
  else if room=rGame6_WindH
  {
    if oPlayer1.x>=192 and bWallSpawn=0
    {
      var tNewWall;
      tNewWall=instance_create(0,0,oAdvancingDeathWall)
      tNewWall.type=2
      tNewWall.xSpd=8.6
      tNewWall.xThres=0
      bWallSpawn=1
    }
    else if oPlayer1.x>=5584 and bWallSpawn=1
    {
      with oAdvancingDeathWall {instance_destroy()}
      bWallSpawn=2
    }
  }
  else if room=rGame6_CoDE
  {
    if bEnemyCheck=0
    {
      if !instance_exists((339042))
      {
        with (oEnemyBarrier) {instance_destroy()}
        bEnemyCheck=1
      }
    }
  }
  else if room=rGame6_CoDR
  {
    if bGridCheck=0
    {
      if oPlayer1.x>=864
      {
        instance_create(0,0,oG6_CastleBGrid)
        bGridCheck=1
      }
    }
  }
}
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
with oScreenText {instance_destroy()}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if room=rGame6_CoDU
{
  if circleRad>0
  {
    draw_set_color(c_white)
    draw_set_blend_mode_ext(bm_inv_dest_color,bm_zero)
    draw_circle(oProgramChip.x,oProgramChip.y,circleRad,0)
    draw_set_blend_mode(bm_normal)
  }
}

if fadeAlpha>0
{
  draw_set_alpha(fadeAlpha)
  draw_set_color(fadeColor)
  draw_rectangle(view_xview[0]-1,view_yview[0]-1,view_xview[0]+view_wview[0]+1,view_yview[0]+view_hview[0]+1,0)
}
