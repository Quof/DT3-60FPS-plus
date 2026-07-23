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
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gameProgress=5340 and room=rWarshipZ_EscapeA //----- [1] ...Hex had a final trick -----
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
    msgCreate(0,0,"Jeremy","Nothing. Once these start, there's no stopping them.",0,3,oMessageCutscene,1)
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
    msgCreate(0,0,"Jeremy","I know. That's why all you need to get yourselves out.#JUST GO!",0,3,oMessageCutscene,1)
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
      oPlayer1.sprite_index=sJerryGuard
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
      oPlayer1.x-=8
      if oPlayer1.x<=1408
      {
        oPlayer1.sprite_index=sJerryDuck
        sceneDelay=100
      }
    }
    else if sceneDelay=110
    {
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
    else if sceneDelay=115 {oPlayer1.sprite_index=sJerryIdle}
    else if sceneDelay=125 {oPlayer1.sprite_index=sJerryWalk; oPlayer1.image_speed=0.33}
    else if sceneDelay>=126 and sceneDelay<=199
    {
      oPlayer1.x+=6
      if oPlayer1.x>=1436
      {
        oPlayer1.sprite_index=sJerryIdle; oPlayer1.image_speed=0.1
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
      oPlayer1.sprite_index=sJerryQuit; oPlayer1.image_speed=0.1
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
    else if sceneDelay=1350 {oPlayer1.sprite_index=sJerryIdle; oPlayer1.image_speed=0.1}
    else if sceneDelay>=1380 {sceneDelay=0; sceneProgress+=1}

    if jerryAnim>=1 //Jerry hits wall
    {
      jerryAnim+=1
      if jerryAnim=5 {oPlayer1.sprite_index=sJerryClawForward; oPlayer1.image_speed=0; oPlayer1.image_index=0}
      else if jerryAnim=20 {oPlayer1.image_index=1}
      else if jerryAnim=23 {oPlayer1.image_index=2}
      else if jerryAnim=26
      {
        oPlayer1.image_index=3
        playSound(global.snd_MMBulletDeflect,0,0.86,33000)
        playSound(global.snd_ArrowHit,0,0.94,28000)
        for(i=0;i<4;i+=1)
        {
          tEffect=instance_create(1458+random(4),224+random(4),oEffect)
          tEffect.sprite_index=sEfDiffusionParticle; tEffect.image_speed=0.5
          tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=random_range(-2,2); tEffect.ySpd=random_range(-2,2)
        }
      }
      else if jerryAnim=28 {oPlayer1.image_index=0}
      else if jerryAnim>=40 {jerryAnim=1}
    }
    if jerryTear=1 //Jerry tears
    {
      var tEffect;
      tEffect=instance_create(oPlayer1.x+4,oPlayer1.y-23,oEffectB)
      tEffect.type=3; tEffect.sprite_index=sEfDiffusionParticle; tEffect.newBlend=1
      tEffect.image_xscale=0.5; tEffect.image_yscale=0.5; tEffect.direction=270; tEffect.speed=1; tEffect.fadeSpd=0.065
      tEffect.AccelX=0; tEffect.AccelY=0; tEffect.followID=-1; tEffect.rotation=0
      jerryTear=0
    }
  }
  else if sceneProgress=24
  {
    sceneDelay+=1
    if sceneDelay=10 {msgCreate(0,0,"Jerry","Jeremy... Okay...",0,1,oMessagePerson,0); newMessage.fadingTime=60}
    else if sceneDelay=70 {msgCreate(0,0,"Jeremy","I love you guys. I'm not going to let you all die like this.",0,2,oMessagePerson,0); newMessage.fadingTime=120}
    else if sceneDelay=190 {msgCreate(0,0,"Jerry","Jeremy... you make it out, okay?",0,1,oMessagePerson,0); newMessage.fadingTime=90}
    else if sceneDelay=280 {msgCreate(0,0,"Jeremy","You got it, Jerry.",0,1,oMessagePerson,0); newMessage.fadingTime=70}
    else if sceneDelay=350 {msgCreate(0,0,"Jeremy","Sis... you make it out of here too.",0,1,oMessagePerson,0); newMessage.fadingTime=90}
    else if sceneDelay=440 {oPlayer1.image_xscale=-1}
    else if sceneDelay>=460 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=25 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","I'll try to buy you guys as much time as I can, but it's looking to be only 2 minutes. Chao, you still have abilities that I had. Get them to safety. I know you can lead them off the ship. You'll find a way.",0,3,oMessageCutscene,1)
  else if sceneProgress=26 and bWaitForInput=false
    msgCreate(0,0,"Chao","Jeremy... Okay, I can do it.",0,3,oMessageCutscene,1)
  else if sceneProgress=27
  {
    if global.gamePttT_Prog=100 {sceneProgress=28}
    else {sceneProgress=31}
  }
  else if sceneProgress=28 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","You can, sis! Look, if anything goes wrong, I'll try something.",0,3,oMessageCutscene,1)
  else if sceneProgress=29 and bWaitForInput=false
    msgCreate(0,0,"Chao","Jeremy...",0,3,oMessageCutscene,1)
  else if sceneProgress=30 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Go now!",0,3,oMessageCutscene,1)
  else if sceneProgress=31
  {
    global.newMapX=1424
    oNPC_GeneralA.image_xscale=1
    sceneDelay=0; sceneProgress=0
    global.bCanSave=false
    global.gameProgress=5350
    global.gamePaused=false
  }
}
else if global.gameProgress=5350 and room=rWarshipZ_EscapeB //----- [2] Claire realizes something -----
{
  if sceneProgress=0
  {
    if oPlayer1.x<=5280
    {
      msgCreate(0,0,"Chao","Just keep heading straight! The ship is falling apart, but I can lead you two to an escape capsule.",0,2,oMessagePerson,0); newMessage.fadingTime=140
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
    global.gameProgress=5360
    global.gamePaused=false
  }
}
else if global.gameProgress=5360 and room=rWarshipZ_EscapeB //----- [3] Jerry paralyzed, then tells Claire to go on ahead -----
{
  if sceneProgress=0
  {
    if oPlayer1.x<=1840
    {
      global.gamePaused=true
      oPlayer1.y+=8
      if oPlayer1.y>=240
      {
        global.canCharSwap=1
        charSwitcher(1)
        scenePChk(1840,240,0,0.1,-1)
        stopPlayer()
        oPlayer1.sprite_index=sClaireWalk; oPlayer1.image_speed=0.33
        jerryChar=instance_create(1840,240,oNPC_GeneralA)
        jerryChar.sprite_index=sJerrySickFall; jerryChar.image_speed=0; jerryChar.image_xscale=-1
        jerryChar.talker="Jerry"; jerryChar.boxSize=2
        jerryChar.stringToShow="Just go, Claire! You don't have much time!#Don't worry, I'll get back to Jeremy."
        sceneProgress+=1
      }
    }
  }
  else if sceneProgress=1
  {
    sceneDelay+=1
    if sceneDelay>=1 and sceneDelay<=12 {oPlayer1.x-=7}
    else if sceneDelay=13 {oPlayer1.sprite_index=sClaireIdle; oPlayer1.image_speed=0.1; oPlayer1.image_xscale=1}
    else if sceneDelay=24 {oPlayer1.sprite_index=sClaireWalk; oPlayer1.image_speed=0.33}
    else if sceneDelay>=25 and sceneDelay<=28 {oPlayer1.x+=7}
    else if sceneDelay=29 {oPlayer1.sprite_index=sClaireIdle; oPlayer1.image_speed=0.1; oPlayer1.image_xscale=1}

    if sceneDelay=10 {jerryChar.image_index=1}
    else if sceneDelay=13 {jerryChar.image_index=2}
    else if sceneDelay=16 {jerryChar.image_index=3}

    if sceneDelay=11 {msgCreate(0,0,"Jerry","Oh crap, the paralysis again.",0,1,oMessagePerson,0); newMessage.fadingTime=70}
    else if sceneDelay>=90 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"Claire","At a time like this!",0,3,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Claire","I'll carry you!",0,3,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Jerry","You and I both know that's not happening. You'll never make it to the other power source in time!",0,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Claire","I don't think so, Jerry! I'm carrying you!",0,3,oMessageCutscene,1)
  else if sceneProgress=6 and bWaitForInput=false
    msgCreate(0,0,"Jerry","You don't have that kind of time!",0,3,oMessageCutscene,1)
  else if sceneProgress=7 and bWaitForInput=false
  {
    showEmote(oIdentifier,0,-6,sEmExcite)
    msgCreate(0,0,"Chao","I'll come out of my fairy form and I'll help!",0,3,oMessageCutscene,1)
  }
  else if sceneProgress=8 and bWaitForInput=false
    msgCreate(0,0,"Jerry","No, Claire needs you where you are.",0,3,oMessageCutscene,1)
  else if sceneProgress=9 and bWaitForInput=false
    msgCreate(0,0,"Claire","We can't just leave you!",0,3,oMessageCutscene,1)
  else if sceneProgress=10 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Don't worry about me, Claire. Just go. When this paralysis wears out, I'm going back to get Jeremy.",0,3,oMessageCutscene,1)
  else if sceneProgress=11 and bWaitForInput=false
    msgCreate(0,0,"Claire","What will that even do?!",0,3,oMessageCutscene,1)
  else if sceneProgress=12 and bWaitForInput=false
    msgCreate(0,0,"Jerry","We always figure things out. You just go, you don't have much time.",0,3,oMessageCutscene,1)
  else if sceneProgress=13 and bWaitForInput=false
    msgCreate(0,0,"Claire","Jerry... just... stay safe. We still have so much to talk about.",0,3,oMessageCutscene,1)
  else if sceneProgress=14 and bWaitForInput=false
    msgCreate(0,0,"Jerry","I know. Everything will be all right. Now go!",0,3,oMessageCutscene,1)
  else if sceneProgress=15
  {
    sceneDelay=0; sceneProgress=0
    global.gameProgress=5370
    global.gamePaused=false
  }
}
else if global.gameProgress=5370 and room=rWarshipZ_EscapeD //----- [4] Claire stays behind -----
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
    msgCreate(0,0,"Chao","It wasn't very hard. Jeremy and Jerry will be able to get out then!",0,3,oMessageCutscene,1)
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
    msgCreate(0,0,"Claire","It resets itself to overload.",0,3,oMessageCutscene,1)
  else if sceneProgress=15 and bWaitForInput=false
    msgCreate(0,0,"Chao","Claire...",0,3,oMessageCutscene,1)
  else if sceneProgress=16 and bWaitForInput=false
    msgCreate(0,0,"Claire","You know what has to be done, Chao.",0,3,oMessageCutscene,1)
  else if sceneProgress=17 and bWaitForInput=false
    msgCreate(0,0,"Chao","I know.",0,3,oMessageCutscene,1)
  else if sceneProgress=18 and bWaitForInput=false
    msgCreate(0,0,"Claire","I want you to leave. I'll stay here and keep it from overloading while you escape.",0,3,oMessageCutscene,1)
  else if sceneProgress=19 and bWaitForInput=false
    msgCreate(0,0,"Chao","No Claire, you can't be serious. I'll stay!",0,3,oMessageCutscene,1)
  else if sceneProgress=20 and bWaitForInput=false
    msgCreate(0,0,"Claire","Get out now, Chao!",0,3,oMessageCutscene,1)
  else if sceneProgress=21 and bWaitForInput=false
    msgCreate(0,0,"Chao","I CAN'T JUST LEAVE MY BEST FRIEND HERE TO DIE!",0,3,oMessageCutscene,1)
  else if sceneProgress=22 and bWaitForInput=false
    msgCreate(0,0,"Claire","I know how you feel, but I'm not having you stay here.",0,3,oMessageCutscene,1)
  else if sceneProgress=23 and bWaitForInput=false
    msgCreate(0,0,"Chao","I just can't do that, Claire! I can't!",0,3,oMessageCutscene,1)
  else if sceneProgress=24 and bWaitForInput=false
    msgCreate(0,0,"Claire","If we both stay here, who will help keep this world safe? You know it better than most.",0,3,oMessageCutscene,1)
  else if sceneProgress=25 and bWaitForInput=false
    msgCreate(0,0,"Chao","I don't want to be here without my friends. What's the point?!",0,3,oMessageCutscene,1)
  else if sceneProgress=26 and bWaitForInput=false
    msgCreate(0,0,"Claire","Chao, we can't do this, you know time is running out. You and Jeremy kept us safe all this time and now it's my turn to keep you safe.",0,3,oMessageCutscene,1)
  else if sceneProgress=27 and bWaitForInput=false
    msgCreate(0,0,"Chao","I... can't.",0,3,oMessageCutscene,1)
  else if sceneProgress=28 and bWaitForInput=false
    msgCreate(0,0,"Claire","Get out! Just go, Chao. I want you to live.",0,3,oMessageCutscene,1)
  else if sceneProgress=29 and bWaitForInput=false
    msgCreate(0,0,"Claire","I don't want you to say anything... If I hadn't met you, my life wouldn't have turned out so great. I loved every moment I spent with you.",0,3,oMessageCutscene,1)
  else if sceneProgress=30 and bWaitForInput=false
    msgCreate(0,0,"Chao","Claire... why?",0,3,oMessageCutscene,1)
  else if sceneProgress=31 and bWaitForInput=false
    msgCreate(0,0,"Claire","Go Chao! JUST GO, DAMN IT!",0,3,oMessageCutscene,1)
  else if sceneProgress=32
  {
    sceneDelay+=1
    if sceneDelay>=30 {chaoGoToPoint=0; sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=33 and bWaitForInput=false
    msgCreate(0,0,"Chao","Claire... I... Thank you... for being my friend.",0,3,oMessageCutscene,1)
  else if sceneProgress=34
  {
    sceneDelay+=1
    if sceneDelay>=30
    {
      if oIdentifier.y>1025 {oIdentifier.y-=1}
      else if oIdentifier.y<1023 {oIdentifier.y+=1}

      oIdentifier.x-=4
      if oIdentifier.x<=96
      {
        oIdentifier.x=-128; oIdentifier.y=-128
        sceneDelay=0; sceneProgress+=1
      }
    }
  }
  else if sceneProgress=35 and bWaitForInput=false
    msgCreate(0,0,"Claire","Thank you, Chao. I know that was hard for you.",0,3,oMessageCutscene,1)
  else if sceneProgress=36
  {
    if global.gamePttT_Prog=100 {global.forceTime=150}
    else {global.forceTime=300}
    var tTimer;
    tTimer=instance_create(412,8,oScreenTimer)
    tTimer.type=3; tTimer.mainColor=c_white; tTimer.shadowColor=c_black
    sceneDelay=0; sceneProgress=0
    global.gameProgress=5380
    global.gamePaused=false
  }
}
else if global.gameProgress=5380 and room=rWarshipZ_EscapeD //----- [] Claire waits (Final gameplay moment) -----
{
  if sceneProgress=1
  {
    sceneDelay+=1
    if sceneDelay=1
    {
      oWarshipEscapeEffects.bExplosion=0
      musVolC=global.optMusic*100
      musFileP=findMusic(1020)
    }
    else if sceneDelay>=2
    {
      if musVolC>=7500 {musVolC-=50}
      else {musVolC-=400}
      SS_SetSoundVol(musFileP,musVolC)
      if musVolC<=1500 {musFileP=findMusic(0)}
    }

    if sceneDelay>=10
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
      if global.gamePttT_Prog=100 //Player got Jeremy to remember undo
      {
        with oWarshipEscapeEffects {instance_destroy()}
        with oEmSmokeA {instance_destroy()}
        oControlCenterComputer.compScrFade=2
        oWarship_PowerSource.image_speed=0; oWarship_PowerSource.overloading=2
        with oEffect_B_Stop {freezeFrame=1; image_speed=0}
        global.canPause=0

        fadeAlpha=0
        var tempMplay;
        tempMplay=findMusic(0)
        playMusic(tempMplay,0,0)
        sceneDelay=0; sceneProgress+=1
      }
      else //Ending 2
      {
        global.newMapX=0; global.newMapY=0
        room_goto(rEnd_PartA)
      }
    }
  }
  else if sceneProgress=3 //Chapter 21 unlocked (Freeze everything in scene)
  {
    sceneDelay+=1
    if sceneDelay=80
    {
      msgCreate(0,0,"Claire","What's happened?",0,1,oMessagePerson,0)
      newMessage.fadingTime=60
    }
    else if sceneDelay=140
    {
      msgCreate(0,0,"Claire","...",0,1,oMessagePerson,0)
      newMessage.fadingTime=50
    }
    else if sceneDelay=190
    {
      msgCreate(0,0,"Claire","Jeremy...? Did you do this?",0,1,oMessagePerson,0)
      newMessage.fadingTime=70
    }
    else if sceneDelay=310 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=4
  {
    sceneDelay+=1
    if sceneDelay=1 {oIdentifier.x=-16; oIdentifier.y=1024}
    else if sceneDelay=5
    {
      msgCreate(0,0,"Chao","Claire!",0,1,oMessagePerson,0)
      newMessage.fadingTime=60
    }

    if sceneDelay>=2
    {
      oIdentifier.x+=6
      if oIdentifier.x>=368 {sceneDelay=0; sceneProgress+=1}
    }
  }
  else if sceneProgress=5
  {
    sceneDelay+=1
    if sceneDelay=50
    {
      msgCreate(0,0,"Claire","Chao, what the heck is happening? Everything froze!",0,1,oMessagePerson,0)
      newMessage.fadingTime=90
    }
    else if sceneDelay=140
    {
      global.optChaoRoam=1
      msgCreate(0,0,"Chao","I don't know! I thought...",0,1,oMessagePerson,0)
      newMessage.fadingTime=60
    }
    else if sceneDelay=200 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=6
  {
    sceneDelay+=1
    if sceneDelay=1
    {
      playSound(global.snd_Static,0,0.96,22050+irandom_range(-4000,4000))
      var tUndoSrn;
      tUndoSrn=instance_create(view_xview[0],view_yview[0],oUndoSrnEf); tUndoSrn.fadeSpd=0.075
    }
    else if sceneDelay=20 {var tNewTear; tNewTear=instance_create(60,-16,oUndoScreenBreak); tNewTear.image_angle=290}
    else if sceneDelay=36 {var tNewTear; tNewTear=instance_create(284,368,oUndoScreenBreak); tNewTear.image_angle=70}
    else if sceneDelay=45 {var tNewTear; tNewTear=instance_create(-16,250,oUndoScreenBreak); tNewTear.image_angle=20}
    else if sceneDelay=60 {var tNewTear; tNewTear=instance_create(512,24,oUndoScreenBreak); tNewTear.image_angle=210}
    else if sceneDelay=70 {var tNewTear; tNewTear=instance_create(56,368,oUndoScreenBreak); tNewTear.image_angle=100}
    else if sceneDelay=88 {var tNewTear; tNewTear=instance_create(512,196,oUndoScreenBreak); tNewTear.image_angle=170}
    else if sceneDelay=104 {var tNewTear; tNewTear=instance_create(340,-16,oUndoScreenBreak); tNewTear.image_angle=250}
    else if sceneDelay=20 {var tNewTear; tNewTear=instance_create(-16,138,oUndoScreenBreak); tNewTear.image_angle=320}
    else if sceneDelay=180
    {
      playSound(global.snd_Static,0,1,1)
      playSound(global.snd_CShotA,0,1,1)
      abilSetRemove(0)
      global.canCharSwap=1
      global.activeAbility[0]=2
      global.activeAbility[1]=2
      global.gameProgress=5500
      global.newMapX=240; global.newMapY=272
      room_goto(rCh21_WarshipSkies)
    }

    if sceneDelay>=70 and sceneDelay mod 13=0 //Screen effect
    {
      var tUndoSrn;
      tUndoSrn=instance_create(view_xview[0]+irandom_range(-128,128),view_yview[0]+irandom_range(-96,96),oUndoSrnEf); tUndoSrn.fadeSpd=0.075
    }
  }
}

keyWaitForInput()

if oKeyCodes.kCodePressed[11]=1 and global.gamePaused=true and sceneProgress>=1 //Cutscene skip
{
  if !instance_exists(oPauseMenu)
  {
    if global.gameProgress=5340 and room=rWarshipZ_EscapeA //[1]
    {
      var tempMplay;
      tempMplay=findMusic(1020)
      playMusic(tempMplay,0,0)
      tile_layer_show(999999)
      oPlayer1.x=1424
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      fadeAlpha=0; sceneDelay=0
      sceneProgress=31
    }
    else if global.gameProgress=5350 and room=rWarshipZ_EscapeB and sceneProgress>=2
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      fadeAlpha=0; sceneDelay=0
      sceneProgress=10
    }
    else if global.gameProgress=5360 and room=rWarshipZ_EscapeB
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      fadeAlpha=0; sceneDelay=0
      sceneProgress=15
    }
    else if global.gameProgress=5370 and room=rWarshipZ_EscapeD
    {
      oIdentifier.x=-16; oIdentifier.y=1024
      oWarship_PowerSource.overloading=0
      chaoGoToPoint=0
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      fadeAlpha=0; sceneDelay=0
      sceneProgress=36
    }
  }
}

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
    if oPlayer1.x<=1888
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

if oPlayer1.y>=room_height-32 //Near fall effect
{
  for(i=0;i<4;i+=1)
  {
    tEffect=instance_create(oIdentifier.x,oIdentifier.y,oEffect)
    tEffect.sprite_index=sMMshotgunIceEffect; tEffect.followID=-1; tEffect.xFollow=0; tEffect.yFollow=0; tEffect.image_speed=0.33
    tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0; tEffect.speed=2; tEffect.image_angle=random(360)
    tEffect.direction=(oGame.time*6)*(i*90)
  }
}

if instance_exists(oScreenTimer)
{
  if global.forceTime<=0
  {
    if global.gameProgress=5380
    {
      if sceneProgress=0 {sceneProgress=1}
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
if fadeAlpha>0
{
  draw_set_alpha(fadeAlpha)
  draw_set_color(fadeColor)
  draw_rectangle(view_xview[0]-1,view_yview[0]-1,view_xview[0]+view_wview[0]+1,view_yview[0]+view_hview[0]+1,0)
}
