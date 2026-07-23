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

if global.gameProgress=5340
{
  if room=rWarshipZ_EscapeA
  {
    tile_layer_hide(999999)
    oPlayer1.sprite_index=sClaireIdle; oPlayer1.image_speed=0.1
    oPlayer1.image_xscale=1
    playSound(global.snd_Static,0,1,1)
    playSound(global.snd_CShotA,0,1,1)
    fadeAlpha=1
  }
}

jerryTear=0
jerryAnim=0
chaoGoToPoint=0

gameplayProg=0
gameplayTime=0

bCharacterShields=0
shieldFrm=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gameProgress=5340 and room=rWarshipZ_EscapeA //----- [] ...Hex had a final trick, but Jeremy defies it -----
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
    msgCreate(0,0,"Claire","What just happened?",0,3,oMessageCutscene,1)
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"Chao","What's it doing?",0,3,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Oh no... No way he did that.",0,3,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Chao","Jeremy, what's going on?!",0,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","It's like he's always knowing what I'm going to do next!#Damn it! Hex set these to overload!",0,3,oMessageCutscene,1)
  else if sceneProgress=6 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Are you serious? What the hell do we do now?",0,3,oMessageCutscene,1)
  else if sceneProgress=7 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","I'm not sure. Once these start, there's no stopping them.",0,3,oMessageCutscene,1)
  else if sceneProgress=8 and bWaitForInput=false
    msgCreate(0,0,"Claire","Jeremy, you said these things overloading would destroy most of the mainland though!",0,3,oMessageCutscene,1)
  else if sceneProgress=9 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","I know! I thought we had this and then... Hex set it all up. The moment that I tampered with it, it set it off.",0,3,oMessageCutscene,1)
  else if sceneProgress=10 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Come on Jeremy. There's something we can do. We're not just going to go out like that.",0,3,oMessageCutscene,1)
  else if sceneProgress=11 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","... You're right... There is a way that I can stop it.",0,3,oMessageCutscene,1)
  else if sceneProgress=12 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Right on, just let us know what we can do.",0,3,oMessageCutscene,1)
  else if sceneProgress=13 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","You all need to leave. I can manually set it to stop.",0,3,oMessageCutscene,1)
  else if sceneProgress=14 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Hell no Jeremy! We're not doing that!",0,3,oMessageCutscene,1)
  else if sceneProgress=15 and bWaitForInput=false
  {
    oNPC_GeneralA.image_xscale=-1
    msgCreate(0,0,"Jeremy","There's no other way, Jerry. I've got to stay here to stop the overload.",0,3,oMessageCutscene,1)
  }
  else if sceneProgress=16 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Dude, this ship is going down!",0,3,oMessageCutscene,1)
  else if sceneProgress=17 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","I know. That's why all of you need to get yourselves out.#JUST GO!",0,3,oMessageCutscene,1)
  else if sceneProgress=18 and bWaitForInput=false
    msgCreate(0,0,"Jerry","No, we're not doing that!",0,3,oMessageCutscene,1)
  else if sceneProgress=19
  {
    sceneDelay+=1
    if sceneDelay=1
    {
      msgCreate(0,0,"Jeremy","GET OUT NOW!!",0,1,oMessagePerson,0)
      newMessage.fadingTime=70
      oNPC_GeneralA.sprite_index=sJeremyMechWalk
    }
    else if sceneDelay=5
    {
      playSound(global.snd_EnemyDieMM,0,1,1)
      oMisc.sprite_index=sJerryGuard
      oPlayer1.sprite_index=sClaireGuard
      var tFlash,tEffect;
      tFlash=instance_create(0,0,oScreenFlash); tFlash.image_alpha=0.7 tFlash.fadeSpeed=0.1
      tEffect=instance_create(oPlayer1.x,oPlayer1.y-26,oEffect)
      tEffect.sprite_index=sRobotExplosion; tEffect.image_speed=0.5
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
      tEffect=instance_create(oNPC_GeneralA.x-17,oNPC_GeneralA.y-34,oEffect)
      tEffect.sprite_index=sMMchargeComplete; tEffect.image_speed=0.5; tEffect.image_xscale=0.75; tEffect.image_yscale=0.75
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
      tEffect=instance_create(oNPC_GeneralA.x-17,oNPC_GeneralA.y-34,oEffect)
      tEffect.sprite_index=sMMSmokeCloud; tEffect.image_speed=0.5
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=-2
    }
    else if sceneDelay>=6 and sceneDelay<=99
    {
      oMisc.x-=8
      oPlayer1.x-=8
      if oMisc.x<=1408
      {
        oMisc.sprite_index=sJerryDuck
        oPlayer1.sprite_index=sClaireDuck
        sceneDelay=100
      }
    }
    else if sceneDelay=110
    {
      oNPC_GeneralA.sprite_index=sJeremyMechIdle
      playSound(global.snd_MMRocks,0,1,1)
      tile_layer_show(999999)
      var tEffect;
      for(i=0;i<24;i+=1)
      {
        tEffect=instance_create(1456+random(32),192+random(64),oEffect)
        tEffect.sprite_index=sMMSmokeCloud; tEffect.image_speed=0.5
        tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=-0.5-random(1)
        tEffect=instance_create(1456+random(32),192+random(64),oEffect)
        tEffect.sprite_index=sRobotExplosion; tEffect.image_speed=0.5; tEffect.image_xscale=0.75; tEffect.image_yscale=0.75
        tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
      }
    }
    else if sceneDelay=115 {oMisc.sprite_index=sJerryIdle}
    else if sceneDelay=125 {oMisc.sprite_index=sJerryWalk; oMisc.image_speed=0.33; oPlayer1.sprite_index=sClaireIdle}
    else if sceneDelay>=126 and sceneDelay<=199
    {
      oMisc.x+=6
      if oMisc.x>=1436
      {
        oMisc.sprite_index=sJerryIdle; oMisc.image_speed=0.1
        sceneDelay=200
      }
    }
    else if sceneDelay>=210 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=20 and bWaitForInput=false
    msgCreate(0,0,"Jerry","What are you doing, Jeremy?!",0,3,oMessageCutscene,1)
  else if sceneProgress=21 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","What I have to.",0,3,oMessageCutscene,1)
  else if sceneProgress=22
  {
    sceneDelay+=1
    if sceneDelay=10 {msgCreate(0,0,"Jerry","No you don't!",0,1,oMessagePerson,0); newMessage.fadingTime=60}
    else if sceneDelay>=70 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=23
  {
    sceneDelay+=1
    if sceneDelay=1 {jerryAnim=1}
    else if sceneDelay=10 {msgCreate(0,0,"Jerry","Don't do this, Jeremy!",0,1,oMessagePerson,0); newMessage.fadingTime=70}
    else if sceneDelay=90 {msgCreate(0,0,"Jerry","Open it, Jeremy!",0,1,oMessagePerson,0); newMessage.fadingTime=60}
    else if sceneDelay=180 {msgCreate(0,0,"Jerry","God damnit, Jeremy! Don't you do this!",0,1,oMessagePerson,0); newMessage.fadingTime=90}
    else if sceneDelay=290
    {
      jerryAnim=0
      oMisc.sprite_index=sJerryQuit; oMisc.image_speed=0.1
    }
    else if sceneDelay=320 {msgCreate(0,0,"Jerry","Isn't there another way?",0,1,oMessagePerson,0); newMessage.fadingTime=60}
    else if sceneDelay=390 {msgCreate(0,0,"Jeremy","You were the best friend someone could ever have, Jerry. Being your friend made life worth it.",0,2,oMessagePerson,0); newMessage.fadingTime=160}
    else if sceneDelay=550 {msgCreate(0,0,"Jeremy","Sis, I'm sorry... but I have to do this.",0,1,oMessagePerson,0); newMessage.fadingTime=90}
    else if sceneDelay=640 {msgCreate(0,0,"Chao","...",0,1,oMessagePerson,0); newMessage.fadingTime=50}
    else if sceneDelay=700 {msgCreate(0,0,"Jerry","I don't accept this. If you're trying to prove something or redeem yourself, screw that!",0,2,oMessagePerson,0); newMessage.fadingTime=150}
    else if sceneDelay=850 {msgCreate(0,0,"Jeremy","You guys, there isn't much time before this thing goes. You have to leave! I can stop it from overloading, but I can't stop it from blowing up and bringing the ship down.",0,3,oMessagePerson,0); newMessage.fadingTime=220}
    else if sceneDelay=1080
    {
      var tempMplay;
      tempMplay=findMusic(1020)
      playMusic(tempMplay,0,0)
      jerryTear=1
      msgCreate(0,0,"Jerry","Screw you, Jeremy. You're not supposed to die...",0,1,oMessagePerson,0); newMessage.fadingTime=100
    }
    else if sceneDelay=1105 {jerryTear=1}
    else if sceneDelay=1130 {jerryTear=1}
    else if sceneDelay=1180 {msgCreate(0,0,"Jeremy","And neither are you. Get yourself out of here. I can't buy you that much time. Just go!",0,2,oMessagePerson,0); newMessage.fadingTime=160}
    else if sceneDelay=1350 {oMisc.sprite_index=sJerryIdle; oMisc.image_speed=0.1}
    else if sceneDelay>=1400 {sceneDelay=0; sceneProgress+=1}

    if jerryAnim>=1 //Jerry hits wall
    {
      jerryAnim+=1
      if jerryAnim=5 {oMisc.sprite_index=sJerryClawForward; oMisc.image_speed=0; oMisc.image_index=0}
      else if jerryAnim=20 {oMisc.image_index=1}
      else if jerryAnim=23 {oMisc.image_index=2}
      else if jerryAnim=26
      {
        oMisc.image_index=3
        playSound(global.snd_MMBulletDeflect,0,0.86,33000)
        playSound(global.snd_ArrowHit,0,0.94,28000)
        for(i=0;i<4;i+=1)
        {
          tEffect=instance_create(1458+random(4),224+random(4),oEffect)
          tEffect.sprite_index=sEfDiffusionParticle; tEffect.image_speed=0.5
          tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=random_range(-2,2); tEffect.ySpd=random_range(-2,2)
        }
      }
      else if jerryAnim=28 {oMisc.image_index=0}
      else if jerryAnim>=40 {jerryAnim=1}
    }
    if jerryTear=1 //Jerry tears
    {
      var tEffect;
      tEffect=instance_create(oMisc.x+4,oMisc.y-23,oEffectB)
      tEffect.type=3; tEffect.sprite_index=sEfDiffusionParticle; tEffect.newBlend=1
      tEffect.image_xscale=0.5; tEffect.image_yscale=0.5; tEffect.direction=270; tEffect.speed=1; tEffect.fadeSpd=0.065
      tEffect.AccelX=0; tEffect.AccelY=0; tEffect.followID=-1; tEffect.rotation=0
      jerryTear=0
    }
  }
  else if sceneProgress=24 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Jeremy... Okay...",0,3,oMessageCutscene,1)
  else if sceneProgress=25 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","I love you guys. I'm not going to let you all die like this.",0,3,oMessageCutscene,1)
  else if sceneProgress=26 and bWaitForInput=false
    msgCreate(0,0,"Jerry","This isn't right.",0,3,oMessageCutscene,1)
  else if sceneProgress=27 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","I know what Hex was trying to do, and screw that. I'll protect this place and you guys.",0,3,oMessageCutscene,1)
  else if sceneProgress=28 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Isn't there another way?",0,3,oMessageCutscene,1)
  else if sceneProgress=29 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","There's no shutting these down, not anymore.",0,3,oMessageCutscene,1)
  else if sceneProgress=30 and bWaitForInput=false
    msgCreate(0,0,"Jerry","I'm staying here with you.",0,3,oMessageCutscene,1)
  else if sceneProgress=31 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Like hell you are!",0,3,oMessageCutscene,1)
  else if sceneProgress=32 and bWaitForInput=false
    msgCreate(0,0,"Claire","Jerry...",0,3,oMessageCutscene,1)
  else if sceneProgress=33 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Claire... don't worry about me... The thing is, we always figure out a way, you know? Besides, if this is how it is, I want to be with my friend.",0,3,oMessageCutscene,1)
  else if sceneProgress=34 and bWaitForInput=false
    msgCreate(0,0,"Claire","I don't approve.",0,3,oMessageCutscene,1)
  else if sceneProgress=35 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","You're really staying here, aren't you?",0,3,oMessageCutscene,1)
  else if sceneProgress=36 and bWaitForInput=false
    msgCreate(0,0,"Jerry","We'll figure something out.",0,3,oMessageCutscene,1)
  else if sceneProgress=37 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","You're right about that.",0,3,oMessageCutscene,1)
  else if sceneProgress=38 and bWaitForInput=false
  {
    oMisc.image_xscale=-1
    msgCreate(0,0,"Jerry","Claire, you and Chao find a way out. Jeremy and I will think of something here.",0,3,oMessageCutscene,1)
  }
  else if sceneProgress=39 and bWaitForInput=false
    msgCreate(0,0,"Claire","Just, okay. You and Jeremy stay safe.",0,3,oMessageCutscene,1)
  else if sceneProgress=40 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","I'll try to buy you two as much time as I can, but it's looking to be only 2 minutes. Chao, you still have abilities that I had. Get Claire to safety. I know you'll find a way.",0,3,oMessageCutscene,1)
  else if sceneProgress=41 and bWaitForInput=false
    msgCreate(0,0,"Chao","Jeremy... Okay, I can do it.",0,3,oMessageCutscene,1)
  else if sceneProgress=42 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Don't worry about us, I have a plan.",0,3,oMessageCutscene,1)
  else if sceneProgress=43 and bWaitForInput=false
    msgCreate(0,0,"Jerry","I know what Jeremy's thinking. You two don't have anything to worry about... promise.",0,3,oMessageCutscene,1)
  else if sceneProgress=44 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","I know you want to say more, but we don't have that kind of time. Get going before this thing goes down.",0,3,oMessageCutscene,1)
  else if sceneProgress=45
  {
    with oMisc {instance_destroy()}
    jerryChar=instance_create(1424,256,oNPC_GeneralA)
    jerryChar.sprite_index=sJerryIdle; jerryChar.image_speed=0; jerryChar.image_xscale=-1
    jerryChar.talker="Jerry"; jerryChar.boxSize=2
    jerryChar.stringToShow="Just go, Claire! You don't have much time! We've got this, don't you worry."
    global.newMapX=1392
    oNPC_GeneralA.image_xscale=1
    sceneDelay=0; sceneProgress=0
    global.canCharSwap=1
    global.bCanSave=false
    global.gameProgress=5350
    global.gamePaused=false
  }
}



else if global.gameProgress=5350 and room=rWarshipZ_EscapeB //----- [] Claire realizes something -----
{
  if sceneProgress=0
  {
    if oPlayer1.x<=5280
    {
      msgCreate(0,0,"Chao","Just keep heading straight! The ship is falling apart, but I can lead you to an escape capsule.",0,2,oMessagePerson,0); newMessage.fadingTime=140
      sceneProgress+=1
    }
  }
  else if sceneProgress=1
  {
    if oPlayer1.x<=3520
    {
      global.gamePaused=true
      oPlayer1.y+=8
      if oPlayer1.y>=288
      {
        scenePChk(3520,288,0,0.1,-1)
        stopPlayer()
        sceneProgress+=1
      }
    }
  }
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"Claire","Wait a minute, something isn't right.",0,3,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Chao","What is it?",0,3,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Claire","The other power source... I bet it's also set to overload! Knowing Hex, he set them both to do it.",0,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Chao","You're right!",0,3,oMessageCutscene,1)
  else if sceneProgress=6 and bWaitForInput=false
    msgCreate(0,0,"Claire","Chao, where is it from this point?",0,3,oMessageCutscene,1)
  else if sceneProgress=7 and bWaitForInput=false
    msgCreate(0,0,"Chao","It's just ahead and below us, but...",0,3,oMessageCutscene,1)
  else if sceneProgress=8 and bWaitForInput=false
    msgCreate(0,0,"Claire","We can't leave it, Chao! You know that we can't. We came here to protect this place.",0,3,oMessageCutscene,1)
  else if sceneProgress=9 and bWaitForInput=false
    msgCreate(0,0,"Chao","I know, it's just... Okay, I'll lead you there. Those escape pods weren't too far away...",0,3,oMessageCutscene,1)
  else if sceneProgress=10
  {
    sceneDelay=0; sceneProgress=0
    global.gameProgress=5370
    global.gamePaused=false
  }
}
else if global.gameProgress=5370 and room=rWarshipZ_EscapeD //----- [] Claire stays behind -----
{
  if chaoGoToPoint=1
  {
    if oIdentifier.x<412 {oIdentifier.x+=4}
    else if oIdentifier.x>420 {oIdentifier.x-=4}

    if oIdentifier.y<1036 {oIdentifier.y+=4}
    else if oIdentifier.y>1044 {oIdentifier.y-=4}
  }

  if sceneProgress=0
  {
    if oPlayer1.y>=1040
    {
      global.gamePaused=true
      oPlayer1.y+=12
      if oPlayer1.y>=1088
      {
        chaoGoToPoint=1
        global.canPause=0
        oIdentifier.willFollowMouse=0
        global.optChaoRoam=0
        with oScreenTimer {instance_destroy()}
        scenePChk(oPlayer1.x,1088,0,0.1,1)
        if oPlayer1.x<416 {oPlayer1.image_xscale=1}
        else {oPlayer1.image_xscale=-1}
        stopPlayer()
        sceneProgress+=1
      }
    }
  }
  else if sceneProgress=1 and bWaitForInput=false
    msgCreate(0,0,"Claire","Okay, how do we stop this thing from overloading?",0,3,oMessageCutscene,1)
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"Chao","Hold on, I can stop it.",0,3,oMessageCutscene,1)
  else if sceneProgress=3
  {
    sceneDelay+=1
    if sceneDelay=30 {oWarship_PowerSource.overloading=0}
    else if sceneDelay>=60 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Claire","Oh wow, you did it!",0,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Chao","It wasn't very hard. Jeremy and Jerry will be able to get out then if it's this easy!",0,3,oMessageCutscene,1)
  else if sceneProgress=6 and bWaitForInput=false
    msgCreate(0,0,"Claire","It's what I was just thinking.",0,3,oMessageCutscene,1)
  else if sceneProgress=7 and bWaitForInput=false
    msgCreate(0,0,"Chao","Now let's get you out of here.",0,3,oMessageCutscene,1)
  else if sceneProgress=8
  {
    sceneDelay+=1
    if sceneDelay=30 {oWarship_PowerSource.overloading=1}
    else if sceneDelay>=60 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=9 and bWaitForInput=false
    msgCreate(0,0,"Claire","Oh what?! It started overloading again!",0,3,oMessageCutscene,1)
  else if sceneProgress=10 and bWaitForInput=false
    msgCreate(0,0,"Chao","Claire, I'm going to get you out, there's a path...",0,3,oMessageCutscene,1)
  else if sceneProgress=11 and bWaitForInput=false
    msgCreate(0,0,"Claire","Hold on, I want to check something!",0,3,oMessageCutscene,1)
  else if sceneProgress=12
  {
    sceneDelay+=1
    if sceneDelay=30
    {
      oPlayer1.sprite_index=sClaireWalk; oPlayer1.image_speed=0.33
      if oPlayer1.x<416 {oPlayer1.image_xscale=1; sceneDelay=100} //Claire on left side
      else {oPlayer1.image_xscale=-1; sceneDelay=200} //Claire on right side
    }
    else if sceneDelay>=101 and sceneDelay<=199
    {
      oPlayer1.x+=7
      if oPlayer1.x>=384 {oPlayer1.sprite_index=sClaireIdle; oPlayer1.image_speed=0.1; sceneDelay=500}
    }
    else if sceneDelay>=201 and sceneDelay<=299
    {
      oPlayer1.x-=7
      if oPlayer1.x<=448 {oPlayer1.sprite_index=sClaireIdle; oPlayer1.image_speed=0.1; sceneDelay=500}
    }
    if sceneDelay=540 {oWarship_PowerSource.overloading=0}
    else if sceneDelay>=580 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=13 and bWaitForInput=false
    msgCreate(0,0,"Claire","I understand it now...",0,3,oMessageCutscene,1)
  else if sceneProgress=14 and bWaitForInput=false
    msgCreate(0,0,"Claire","It constantly resets itself to overload.",0,3,oMessageCutscene,1)
  else if sceneProgress=15 and bWaitForInput=false
    msgCreate(0,0,"Chao","Claire...",0,3,oMessageCutscene,1)
  else if sceneProgress=16 and bWaitForInput=false
    msgCreate(0,0,"Claire","You know what has to be done, Chao.",0,3,oMessageCutscene,1)
  else if sceneProgress=17 and bWaitForInput=false
    msgCreate(0,0,"Chao","I know, and don't you dare ask me to leave you here. You know I'm not doing that.",0,3,oMessageCutscene,1)
  else if sceneProgress=18 and bWaitForInput=false
    msgCreate(0,0,"Claire","I was, actually...",0,3,oMessageCutscene,1)
  else if sceneProgress=19 and bWaitForInput=false
    msgCreate(0,0,"Chao","It's not happening. I gotta stay in case something goes wrong.",0,3,oMessageCutscene,1)
  else if sceneProgress=20 and bWaitForInput=false
    msgCreate(0,0,"Claire","That's what it's going to be then?",0,3,oMessageCutscene,1)
  else if sceneProgress=21 and bWaitForInput=false
    msgCreate(0,0,"Chao","Yep! I'll stay by the controls. Uh, look around and see if maybe there's a way to escape though?",0,3,oMessageCutscene,1)
  else if sceneProgress=22 and bWaitForInput=false
    msgCreate(0,0,"Claire","Well yeah!",0,3,oMessageCutscene,1)
  else if sceneProgress=23
  {
    global.forceTime=780
    var tTimer;
    tTimer=instance_create(412,8,oScreenTimer)
    tTimer.type=3; tTimer.mainColor=c_white; tTimer.shadowColor=c_black
    sceneDelay=0; sceneProgress=0
    global.canPause=0
    global.gameProgress=5380
    global.gamePaused=false
  }
}
else if global.gameProgress=5380 and room=rWarshipZ_EscapeD //----- [] Claire waits (Final gameplay moment) -----
{
  if sceneProgress=0
  {
    sceneDelay+=1
    if sceneDelay=90
    {
      msgCreate(0,0,"Chao","You scared?",0,1,oMessagePerson,0)
      newMessage.fadingTime=70
    }
    else if sceneDelay=170
    {
      msgCreate(0,0,"Claire","Of course I'm scared. I'm scared for all of us.",0,1,oMessagePerson,0)
      newMessage.fadingTime=130
    }
    else if sceneDelay=310
    {
      msgCreate(0,0,"Chao","Me too.",0,1,oMessagePerson,0)
      newMessage.fadingTime=70
    }
    else if sceneDelay=390
    {
      msgCreate(0,0,"Claire","You could leave, Chao. I could stay and keep it from overloading.",0,1,oMessagePerson,0)
      newMessage.fadingTime=160
    }
    else if sceneDelay=560
    {
      msgCreate(0,0,"Chao","Don't say that so casual like that. You know I'm not going to do that.",0,1,oMessagePerson,0)
      newMessage.fadingTime=160
    }
    else if sceneDelay=730
    {
      msgCreate(0,0,"Claire","I know, and...",0,1,oMessagePerson,0)
      newMessage.fadingTime=70
    }
    else if sceneDelay>=800 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=1
  {
    sceneDelay+=1
    if sceneDelay=1
    {
      musVolC=global.optMusic*100
      musFileP=findMusic(1020)
    }
    else if sceneDelay>=2
    {
      if musVolC>=7500 {musVolC-=50}
      else {musVolC-=400}
      SS_SetSoundVol(musFileP,musVolC)
      if musVolC>=100 and musVolC<=1500
      {
        musFileP=findMusic(0)
        musVolC=0
      }
    }

    if sceneDelay=25 {oWarshipEscapeEffects.extraExplosions=1}
    else if sceneDelay=30 {bCharacterShields=1}

    if sceneDelay>=15 //Fade out and end
    {
      oWarshipEscapeEffects.redFadeAlpha-=0.01
      fadeAlpha+=0.015
      if fadeAlpha>=1 {sceneDelay=0; sceneProgress+=1}
    }
  }
  else if sceneProgress=2
  {
    sceneDelay+=1
    if sceneDelay>=30
    {
      global.newMapX=0; global.newMapY=0
      global.optShowHUD=0
      global.gamePaused=1
      room_goto(rEnd_WarshipA)
    }
  }
}



keyWaitForInput()

if global.gameProgress>=5350 and room=rWarshipZ_EscapeA //----- [] Set time -----
{
  if sceneProgress=0
  {
    global.gameProgress=5350
    global.forceTime=3600
    var tTimer;
    tTimer=instance_create(412,8,oScreenTimer)
    tTimer.type=3; tTimer.mainColor=c_white; tTimer.shadowColor=c_black
    sceneProgress+=1
  }
}
if room=rWarshipZ_EscapeB //----- Gameplay sequences -----
{
  if gameplayProg=0
  {
    if oPlayer1.x<=5104
    {
      (453270).eventProg=1
      gameplayProg+=1
    }
  }
  else if gameplayProg=1
  {
    if oPlayer1.x<=4448
    {
      (453338).eventProg=1
      (453339).eventProg=1
      gameplayProg+=1
    }
  }
  else if gameplayProg=2
  {
    if oPlayer1.x<=4176
    {
      (453340).eventProg=1
      (453341).eventProg=1
      gameplayProg+=1
    }
  }
  else if gameplayProg=3
  {
    if oPlayer1.x<=2896
    {
      (453374).eventProg=1
      (453385).eventProg=1
      gameplayProg+=1
    }
  }
  else if gameplayProg=4
  {
    if oPlayer1.x<=2496
    {
      (453386).eventProg=1
      (453387).eventProg=1
      (453388).eventProg=1
      (453389).eventProg=1
      gameplayProg+=1
    }
  }
  else if gameplayProg=5
  {
    if oPlayer1.x<=1568
    {
      (453406).eventProg=1
      gameplayProg+=1
    }
  }
  else if gameplayProg=6
  {
    if oPlayer1.x<=1152
    {
      (453407).eventProg=1
      gameplayProg+=1
    }
  }
  else if gameplayProg=7
  {
    if oPlayer1.x<=928
    {
      msgCreate(0,0,"Claire","I am not in the mood!",0,1,oMessagePerson,0); newMessage.fadingTime=80
      gameplayProg+=1
    }
  }
  else if gameplayProg=8
  {
    if oPlayer1.x<=592
    {
      (453437).eventProg=1
      gameplayProg+=1
    }
  }
}
if room=rWarshipZ_EscapeC //----- Gameplay sequences -----
{
  if gameplayProg=0
  {
    if oPlayer1.x<=1856
    {
      (453599).eventProg=1
      gameplayProg+=1
    }
  }
  else if gameplayProg=1
  {
    if oPlayer1.x<=736
    {
      msgCreate(0,0,"Chao","Head down from here! The other power source is close!",0,1,oMessagePerson,0); newMessage.fadingTime=130
      gameplayProg+=1
    }
  }
}
/*if room=rWarshipZ_EscapeD //----- Gameplay sequences (Jerry talks to Chao directly) -----
{
  if gameplayProg=0
  {
    if oPlayer1.y>=224
    {
      msgCreate(0,0,"Jerry","I know you can see this, Chao. Jeremy once showed me how to send messages directly.",0,2,oMessagePerson,0); newMessage.fadingTime=130
      gameplayProg+=1
    }
  }
  else if gameplayProg=1
  {
    gamePlayTime+=1
    if gamePlayTime=130 {msgCreate(0,0,"Jerry","Don't tell Claire...",0,1,oMessagePerson,0); newMessage.fadingTime=70}
    else if gamePlayTime=200 {msgCreate(0,0,"Jerry","I'm not making it out of here.",0,1,oMessagePerson,0); newMessage.fadingTime=90}
    else if gamePlayTime=290 {msgCreate(0,0,"Jerry","She knows it I'm sure.",0,1,oMessagePerson,0); newMessage.fadingTime=80}
    else if gamePlayTime=370 {msgCreate(0,0,"Jerry","I want you two to get out.",0,1,oMessagePerson,0); newMessage.fadingTime=80}
  }
}*/

if instance_exists(oScreenTimer)
{
  if global.forceTime<=0
  {
    if global.gameProgress=5380
    {
      if sceneProgress=0 {sceneDelay=0; sceneProgress=1}
    }
    else
    {
      oPlayer1.life-=oPlayer1.maxLife
    }
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if bCharacterShields=1
{
  shieldFrm+=0.25
  for(i=0;i<3;i+=1)
  {
    draw_sprite_ext(sWaterBarrier,shieldFrm+i,oPlayer1.x,oPlayer1.y-26,image_xscale+(0.25*i),image_yscale+(0.25*i),image_angle,image_blend,0.2+(0.1*i))
    draw_sprite_ext(sWaterBarrier,shieldFrm+i,oIdentifier.x,oIdentifier.y,image_xscale+(0.25*i),image_yscale+(0.25*i),image_angle,image_blend,0.2+(0.1*i))
  }
}

if fadeAlpha>0
{
  draw_set_alpha(fadeAlpha)
  draw_set_color(fadeColor)
  draw_rectangle(view_xview[0]-1,view_yview[0]-1,view_xview[0]+view_wview[0]+1,view_yview[0]+view_hview[0]+1,0)
}
