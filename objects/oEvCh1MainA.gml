#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
enemyCount=-1
fadeColor=c_white
if global.gameProgress=0
{
  fadeColor=c_black
  fadeAlpha=1
}
else {fadeAlpha=0}

checkMinigameHit=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gameProgress=0 and room=rMain_1 //----- [1] Jerry dropping down -----
{
  if sceneProgress=0
  {
    sceneDelay+=1*gDeltaTime
    if sceneDelay=1 {oPlayer1.visible=0}
    else if sceneDelay>=30
    {
      fadeAlpha-=0.02*gDeltaTime
      if fadeAlpha<=0 {sceneDelay=0; sceneProgress+=1}
    }
  }
  else if sceneProgress=1
  {
    sceneDelay+=1*gDeltaTime
    if sceneDelay=30
    {
      playSound(global.snd_Teleport,0,1,1)
      var tEffect;
      tEffect=instance_create(oPlayer1.x,oPlayer1.y-26,oEffect)
      tEffect.sprite_index=sHeal; tEffect.image_speed=0.5
      tEffect.image_xscale=3; tEffect.image_yscale=3
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    }
    if sceneDelay=50
    {
      playSound(global.snd_BombExplode,0,0.92,1)
      var tEffect;
      tEffect=instance_create(oPlayer1.x,oPlayer1.y-26,oEffect)
      tEffect.sprite_index=sShipExplosion; tEffect.image_speed=0.5
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    }
    else if sceneDelay=60
    {
      oPlayer1.visible=1
      var tEffect;
      tEffect=instance_create(oPlayer1.x,oPlayer1.y-26,oEffect)
      tEffect.sprite_index=sMMchargeComplete; tEffect.image_xscale=3; tEffect.image_yscale=3
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    }
    else if sceneDelay=95
    {
      oPlayer1.sprite_index=sJerryJump
      sceneDelay=0; sceneProgress+=1
    }
  }
  else if sceneProgress=2
  {
    if current_frame mod (1/gDeltaTime) == 0 {oPlayer1.y+=1} //QWH

    sceneDelay+=1*gDeltaTime
    if sceneDelay=5
    {
      msgCreate(0,0,"Jerry","Okay we've got a problem Jeremy. I can't move!",0,1,oMessagePerson,0)
      newMessage.fadingTime=105
    }
    else if sceneDelay=120
    {
      msgCreate(0,0,"Jeremy","Hold on a sec, the Virus messed things up.",0,1,oMessagePerson,0)
      newMessage.fadingTime=100
    }
    else if sceneDelay=230
    {
      msgCreate(0,0,"Jerry","This is going to be a recurring pattern isn't it?",0,1,oMessagePerson,0)
      newMessage.fadingTime=105
    }
    else if sceneDelay=345
    {
      msgCreate(0,0,"Claire","HEY! Why am I stuck here spectating?",0,2,oMessagePerson,0)
      newMessage.fadingTime=100
    }
    else if sceneDelay=455
    {
      msgCreate(0,0,"Jeremy","Seriously you two, I'm trying to figure it out. Hold on.",0,1,oMessagePerson,0)
      newMessage.fadingTime=100
    }
    else if sceneDelay=565
    {
      msgCreate(0,0,"Claire","What do you mean hold on!? I'm stuck watching! This is SO unfair!",0,2,oMessagePerson,0)
      newMessage.fadingTime=110
    }
    else if sceneDelay=685
    {
      msgCreate(0,0,"Jerry","You wouldn't be upset if it were me stuck wherever you are.",0,1,oMessagePerson,0)
      newMessage.fadingTime=100
    }
    else if sceneDelay=795
    {
      msgCreate(0,0,"Claire","Well yeah, Jerry. This is just going to be boring for me.",0,2,oMessagePerson,0)
      newMessage.fadingTime=110
    }
    else if sceneDelay=915
    {
      msgCreate(0,0,"Jerry","I'm fine with doing everything...#As long as this doesn't lead to spikes.",0,1,oMessagePerson,0)
      newMessage.fadingTime=110
    }
    else if sceneDelay=1035
    {
      msgCreate(0,0,"Claire","That would make this infinitely less boring.",0,2,oMessagePerson,0)
      newMessage.fadingTime=95
    }
    else if sceneDelay=1140
    {
      msgCreate(0,0,"Jerry","Hey, anyone else think it's funny that Claire's text boxes are bigger?",0,1,oMessagePerson,0)
      newMessage.fadingTime=110
    }
    else if sceneDelay=1260
    {
      msgCreate(0,0,"Claire","Whatever Jerry. You know that's just a bug.",0,2,oMessagePerson,0)
      newMessage.fadingTime=100
    }
    else if sceneDelay=1370
    {
      msgCreate(0,0,"Jerry","Damn, well... that didn't work on you.",0,1,oMessagePerson,0)
      newMessage.fadingTime=100
    }
    else if sceneDelay=1480
    {
      msgCreate(0,0,"Jeremy","Ah, I think I figured this out.",0,1,oMessagePerson,0)
      newMessage.fadingTime=100
    }
    else if sceneDelay=1590
    {
      msgCreate(0,0,"Jerry","Yay, the ground!",0,1,oMessagePerson,0)
      newMessage.fadingTime=90
    }
    if oPlayer1.y>=2048
    {
      oPlayer1.sprite_index=sJerryIdle
      sceneDelay=0; sceneProgress+=1
    }
  }
  else if sceneProgress=3
  {
    sceneDelay+=1*gDeltaTime
    if sceneDelay>=25 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Jerry","You said you figured this all out, so what's the problem?",0,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Claire","And the problem with me being here?",0,3,oMessageCutscene,1)
  else if sceneProgress=6 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","The Virus locked us out of everything.#Movement, jumping, just everything.",0,3,oMessageCutscene,1)
  else if sceneProgress=7 and bWaitForInput=false
    msgCreate(0,0,"Jerry","What do we do?",0,3,oMessageCutscene,1)
  else if sceneProgress=8 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","I can get your movement back, but we'll need a power source for jumping. I'll lead you to one. As for you Claire, I'll look into that in a sec.",0,3,oMessageCutscene,1)
  else if sceneProgress=9 and bWaitForInput=false
    msgCreate(0,0,"Claire","Ugh, this is annoying.",0,3,oMessageCutscene,1)
  else if sceneProgress=10 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Look on the bright side Claire, you can backseat game now!",0,3,oMessageCutscene,1)
  else if sceneProgress=11 and bWaitForInput=false
    msgCreate(0,0,"Claire","Oh I plan to!",0,3,oMessageCutscene,1)
  else if sceneProgress=12 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Getting movement back on is going to take some time, give me a moment.",0,3,oMessageCutscene,1)
  else if sceneProgress=13 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Great, we get to wait.",0,3,oMessageCutscene,1)
  else if sceneProgress=14
  {
    global.newMapX=240; global.newMapY=2048
    global.bCanSave=false
    global.gamePaused=false
    global.bRecordHits=0
    sceneDelay=0; sceneProgress=0
    global.gameProgress=1
  }
}
else if global.gameProgress=1 and room=rMain_1 //----- [] Virus attacks -----
{
  if global.gamePaused=false
  {
    if sceneProgress=0
    {
      sceneDelay+=1*gDeltaTime
      if sceneDelay=40
        createScreenText(80,200,160,fnt_EnemyName,fa_left,string("You can 'duck' by holding the [") +string(global.ctrlDown) +string("] or [Down Arrow] key."),3,c_white,1,0)
      else if sceneDelay=120
      {
        virusAtk=instance_create(room_width+8,2032,oSeekerVirusBasic)
        virusAtk.type=0; virusAtk.moveSpd=1; virusAtk.direction=180
      }
      else if sceneDelay>=150 and sceneDelay<=999
      {
        if virusAtk.x<=192
        {
          msgCreate(0,0,"Jerry","WHAT?! THAT WAS UNFAIR!! I couldn't even duck that!",0,1,oMessagePerson,0)
          newMessage.fadingTime=120
          sceneDelay=1000
        }
      }
      else if sceneDelay>=1030 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=1 //That's not fair, but the hit doesn't count
    {
      sceneDelay+=1*gDeltaTime
      if global.bOneHitKillMode=0
      {
        if sceneDelay=100
        {
          msgCreate(0,0,"Claire","Now that's funny. There goes any chance at a perfect run.",0,1,oMessagePerson,0)
          newMessage.fadingTime=125
        }
        else if sceneDelay=230
        {
          msgCreate(0,0,"Jerry","That is so not funny, it's annoying really!",0,1,oMessagePerson,0)
          newMessage.fadingTime=120
        }
        else if sceneDelay=355
        {
          msgCreate(0,0,"Jeremy","Eh, no worries, I hacked that so it won't record the hit.",0,1,oMessagePerson,0)
          newMessage.fadingTime=125
        }
        else if sceneDelay=485
        {
          msgCreate(0,0,"Chao","Looks like there are more of them coming.",0,1,oMessagePerson,0)
          newMessage.fadingTime=95
        }
        else if sceneDelay=585
        {
          msgCreate(0,0,"Jeremy","I won't be able to get your movement back on in time, but hold on, I've got an idea.",0,2,oMessagePerson,0)
          newMessage.fadingTime=155
        }
        else if sceneDelay=745 {sceneDelay=0; sceneProgress+=1}
      }
      else
      {
        if sceneDelay=100
        {
          msgCreate(0,0,"Claire","Ah wait, what... I thought you were supposed to die in one hit...",0,1,oMessagePerson,0)
          newMessage.fadingTime=130
        }
        else if sceneDelay=230
        {
          msgCreate(0,0,"Jeremy","Oh you wanted that mode on? I'll fix that.",0,1,oMessagePerson,0)
          newMessage.fadingTime=120
        }
        else if sceneDelay=350
        {
          msgCreate(0,0,"Jerry","Hold up, I never said I wanted that!",0,1,oMessagePerson,0)
          newMessage.fadingTime=110
        }
        else if sceneDelay=460
        {
          msgCreate(0,0,"Jeremy","Oooh damn, too late.",0,1,oMessagePerson,0)
          newMessage.fadingTime=70
        }
        else if sceneDelay=530
        {
          msgCreate(0,0,"Claire","I was joking, Jeremy.",0,1,oMessagePerson,0)
          newMessage.fadingTime=70
        }
        else if sceneDelay=600
        {
          msgCreate(0,0,"Jeremy","Son of a... there's no way to turn it off now.",0,1,oMessagePerson,0)
          newMessage.fadingTime=120
        }
        else if sceneDelay=720
        {
          msgCreate(0,0,"Jerry","Thaaanks Claire.",0,1,oMessagePerson,0)
          newMessage.fadingTime=60
        }
        else if sceneDelay=780
        {
          msgCreate(0,0,"Claire","You know, screw it! Perfect run this! LET'S GO!!",0,1,oMessagePerson,0)
          newMessage.fadingTime=120
        }
        else if sceneDelay=900
        {
          msgCreate(0,0,"Jerry","Well... SURE!! YEAH!!",0,1,oMessagePerson,0)
          newMessage.fadingTime=70
        }
        else if sceneDelay=970 {sceneDelay=0; sceneProgress+=1}
      }
    }
    else if sceneProgress=2 //Spawn and explain Bubble Machine
    {
      sceneDelay+=1*gDeltaTime
      if sceneDelay=1
      {
        instance_create(224,2048,oBustMoveMachine)
        var tFFScl,tEffect;
        tFFScl=random(0.3)
        for(i=0;i<64;i+=1)
        {
          tEffect=instance_create(oBustMoveMachine.x-24+random(48),oBustMoveMachine.y-2-random(20),oEffectB)
          tEffect.type=3
          tEffect.sprite_index=choose(sBelmontWepEffect,sMMshotgunIceEffect,sMMchargeEffect1)
          tEffect.image_alpha=0.9; tEffect.image_xscale=0.7+tFFScl; tEffect.image_yscale=0.7+tFFScl
          tEffect.image_speed=0.5; tEffect.direction=random(360); tEffect.speed=random(1)+1.5
          tEffect.friction=random(0.01)+0.01; tEffect.fadeSpd=0.01
          tEffect.AccelX=0; tEffect.AccelY=0; tEffect.newBlend=-1; tEffect.followID=-1; tEffect.rotation=0
        }

        msgCreate(170,190,"Jeremy","BAM!!",0,0,oMessagePerson,0)
        newMessage.fadingTime=60
      }
      else if sceneDelay=60
      {
        msgCreate(0,0,"Jerry","What is this crazy contraption?",0,1,oMessagePerson,0)
        newMessage.fadingTime=90
      }
      else if sceneDelay=150
      {
        msgCreate(0,0,"Jeremy","Here's how it works.",0,1,oMessagePerson,0)
        newMessage.fadingTime=80
      }
      else if sceneDelay=230
        createScreenText(60,160,570,fnt_EnemyName,fa_left,string("Control the angle of the arrow by holding [Left] or [") +string(global.ctrlLeft) +string("] to rotate left.#[Right] or [") +string(global.ctrlRight) +string("] to rotate right.#To fire a Virus Control Bubble, press [") +string(global.ctrlActA) +string("]Red, [") +string(global.ctrlActB) +string("]Green, or [") +string(global.ctrlActC) +string("]Blue.#Keep Jerry safe from the Virus attacks."),3,c_white,1,0)
      else if sceneDelay=670
      {
        msgCreate(0,0,"Jeremy","Fend them off while I get your movement working again.",0,1,oMessagePerson,0)
        newMessage.fadingTime=120
      }
      else if sceneDelay=800
      {
        global.bRecordHits=1
        sceneDelay=0; sceneProgress=0
        storeStatus(0)
        global.gameProgress=2
      }
    }
  }
}
else if global.gameProgress=2 and room=rMain_1 //----- [] Virus Bubble minigame -----
{
  if global.gamePaused=false
  {
    oPlayer1.x=234; oPlayer1.y=2049
    if sceneProgress=0
    {
      var tNewVirus,tYStart,tXTPlayer,tYTPlayer;
      tYStart=1752
      tXTPlayer=224; tYTPlayer=2012

      sceneDelay+=1*gDeltaTime
      if sceneDelay=1
      {
        var tTimer;
        tTimer=instance_create(204,312,oScreenTimer)
        tTimer.type=2; tTimer.mainColor=c_white; tTimer.shadowColor=c_black
        global.forceTime=1250/gDeltaTime
      }
      else if sceneDelay=30
      {
        var tXPos; tXPos=160
        for(i=0;i<3;i+=1)
        {
          tNewVirus=instance_create(tXPos,tYStart,oSeekerVirusBasic)
          tNewVirus.type=i; tNewVirus.moveSpd=0.75
          tXPos+=64
        }
      }
      else if sceneDelay=120
      {
        tNewVirus=instance_create(room_width+8,tYTPlayer,oSeekerVirusBasic)
        tNewVirus.type=9; tNewVirus.moveSpd=1.5; tNewVirus.direction=180
      }
      else if sceneDelay=190
      {
        var tXPos; tXPos=176
        for(i=0;i<2;i+=1)
        {
          tNewVirus=instance_create(tXPos,tYStart,oSeekerVirusBasic)
          tNewVirus.type=1; tNewVirus.moveSpd=1
          tXPos+=96
        }
      }
      else if sceneDelay=210
      {
        tNewVirus=instance_create(tXTPlayer,tYStart,oSeekerVirusBasic)
        tNewVirus.type=0; tNewVirus.moveSpd=1.5
      }
      else if sceneDelay=260
      {
        tNewVirus=instance_create(tXTPlayer,tYStart,oSeekerVirusBasic)
        tNewVirus.type=2; tNewVirus.moveSpd=1
      }
      else if sceneDelay=320
      {
        tNewVirus=instance_create(-8,1824,oSeekerVirusBasic)
        tNewVirus.type=1; tNewVirus.moveSpd=0.75
        tNewVirus=instance_create(room_width+8,1808,oSeekerVirusBasic)
        tNewVirus.type=1; tNewVirus.moveSpd=0.75
      }
      else if sceneDelay=350
      {
        tNewVirus=instance_create(-8,tYTPlayer,oSeekerVirusBasic)
        tNewVirus.type=9; tNewVirus.moveSpd=3; tNewVirus.direction=0
      }
      else if sceneDelay=420
      {
        var tXPos; tXPos=176
        for(i=0;i<6;i+=1)
        {
          tNewVirus=instance_create(tXPos,tYStart,oSeekerVirusBasic)
          tNewVirus.type=0; tNewVirus.moveSpd=0.5
          tXPos+=24
        }
      }
      else if sceneDelay=480
      {
        tNewVirus=instance_create(tXTPlayer,tYStart,oSeekerVirusBasic)
        tNewVirus.type=2; tNewVirus.moveSpd=1
      }
      else if sceneDelay=550
      {
        tNewVirus=instance_create(room_width+8,tYTPlayer,oSeekerVirusBasic)
        tNewVirus.type=9; tNewVirus.moveSpd=3; tNewVirus.direction=180
      }
      else if sceneDelay=610
      {
        var tXPos; tXPos=-8
        for(i=0;i<3;i+=1)
        {
          tNewVirus=instance_create(tXPos,tYTPlayer-80,oSeekerVirusBasic)
          tNewVirus.type=9; tNewVirus.moveSpd=1; tNewVirus.direction=0
          tXPos-=16
        }
        var tXPos; tXPos=room_width+8
        for(i=0;i<3;i+=1)
        {
          tNewVirus=instance_create(tXPos,tYTPlayer-80,oSeekerVirusBasic)
          tNewVirus.type=9; tNewVirus.moveSpd=1; tNewVirus.direction=180
          tXPos+=16
        }
      }
      else if sceneDelay=670
      {
        var tXPos; tXPos=176
        for(i=0;i<6;i+=1)
        {
          tNewVirus=instance_create(tXPos,tYStart,oSeekerVirusBasic)
          tNewVirus.type=1; tNewVirus.moveSpd=0.5
          tXPos+=24
        }
      }
      else if sceneDelay=770
      {
        tNewVirus=instance_create(-8,1824,oSeekerVirusBasic)
        tNewVirus.type=2; tNewVirus.moveSpd=0.75
        tNewVirus=instance_create(room_width+8,1808,oSeekerVirusBasic)
        tNewVirus.type=2; tNewVirus.moveSpd=0.75
      }
      else if sceneDelay=820
      {
        tNewVirus=instance_create(-8,tYTPlayer,oSeekerVirusBasic)
        tNewVirus.type=9; tNewVirus.moveSpd=3; tNewVirus.direction=0
        tNewVirus=instance_create(room_width+8,tYTPlayer,oSeekerVirusBasic)
        tNewVirus.type=9; tNewVirus.moveSpd=3; tNewVirus.direction=180
      }
      else if sceneDelay=980
      {
        var tXPos; tXPos=160
        for(i=0;i<3;i+=1)
        {
          tNewVirus=instance_create(tXPos,tYStart,oSeekerVirusBasic)
          tNewVirus.type=i; tNewVirus.moveSpd=0.8
          tXPos+=64
        }
      }
      else if sceneDelay=1930
      {
        tNewVirus=instance_create(160,tYStart,oSeekerVirusBasic)
        tNewVirus.type=1; tNewVirus.moveSpd=0.75
        tNewVirus=instance_create(224,tYStart,oSeekerVirusBasic)
        tNewVirus.type=2; tNewVirus.moveSpd=0.75
        tNewVirus=instance_create(288,tYStart,oSeekerVirusBasic)
        tNewVirus.type=0; tNewVirus.moveSpd=0.75
      }
      else if sceneDelay=1080
      {
        tNewVirus=instance_create(160,tYStart,oSeekerVirusBasic)
        tNewVirus.type=2; tNewVirus.moveSpd=0.7
        tNewVirus=instance_create(224,tYStart,oSeekerVirusBasic)
        tNewVirus.type=0; tNewVirus.moveSpd=0.7
        tNewVirus=instance_create(288,tYStart,oSeekerVirusBasic)
        tNewVirus.type=1; tNewVirus.moveSpd=0.7
      }
      else if sceneDelay=1130
      {
        var tXPos; tXPos=160
        for(i=0;i<3;i+=1)
        {
          tNewVirus=instance_create(tXPos,tYStart,oSeekerVirusBasic)
          tNewVirus.type=i; tNewVirus.moveSpd=0.65
          tXPos+=64
        }
      }
      else if sceneDelay=1250
      {
        msgCreate(0,0,"Jerry","Wait wait, add more time! This is fun!",0,1,oMessagePerson,0)
        newMessage.fadingTime=120
        global.forceTime+=250
      }
      else if sceneDelay=1500 //Win
      {
        var tFlash;
        tFlash=instance_create(0,0,oScreenFlash)
        tFlash.fadeSpeed=0.2
        oPlayer1.life=oPlayer1.maxLife
        with oScreenTimer {instance_destroy()}
        with oBustMoveMachine {instance_destroy()}
        with oBustMoveBubble {instance_destroy()}
        with oSeekerVirusBasic {instance_destroy()}
        oPlayer1.sprite_index=sJerryIdle
        oPlayer1.image_speed=0.1
        sceneDelay=0; sceneProgress=0
        global.gameProgress=9
        global.gamePaused=true
      }
    }
  }
}
else if global.gameProgress=9 and room=rMain_1 //----- [2] Regaining Movement -----
{
  if sceneProgress=0 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Okay, movement is back online.",0,3,oMessageCutscene,1)
  else if sceneProgress=1 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Sweet.",0,3,oMessageCutscene,1)
  else if sceneProgress=2
  {
    var tNewTutorial;
    tNewTutorial=instance_create(0,0,oTutorialPanel)
    tNewTutorial.tutorialTitle="Movement"
    tNewTutorial.tutorialInfo=string("To move left or right, use the [Arrow Keys], [") +string(global.ctrlLeft) +string("], or [") +string(global.ctrlRight) +string("]. To duck, press [S]. You can slide if you duck after running.")
    tNewTutorial.scrAreaY=0
    sceneDelay=0; sceneProgress=0
    global.newMapX=240
    global.newMapY=2048
    global.hasShoes[0]=2
    global.gameProgress=10
    var tempMplay;
    tempMplay=findMusic(1)
    playMusic(tempMplay,0,0)
    global.bCanSave=true
    global.gamePaused=false
  }
}
else if global.gameProgress=20 and room=rMain_2 //----- [3] Chapter 1 -----
{
  if sceneProgress=0
  {
    sceneDelay+=1
    if sceneDelay=1 {global.gamePaused=true}
    else if sceneDelay>=20 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=1 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","There are conveniently some Jump Boots in this place. It's going to take a bit of work, but you can get to them.",0,3,oMessageCutscene,1)
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"Claire","What about me?",0,3,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Hang tight, I'll figure out what's up with that.",0,3,oMessageCutscene,1)
  else if sceneProgress=4
  {
    var tNewChapter;
    tNewChapter=instance_create(0,0,oChapterDisplay)
    tNewChapter.newChapter="Chapter 1#Everything Has a Beginning"
    sceneDelay=0; sceneProgress=0
    global.gameProgress=30
    global.gamePaused=false
  }
}
else if global.gameProgress=50 and room=rMain_4 //----- [4] Jump Boots in this map -----
{
  if sceneProgress=0
  {
    sceneDelay+=1
    if sceneDelay=1 {global.gamePaused=true}
    else if sceneDelay>=20 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=1 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","The Jump Boots are in this map. It might be a bit tricky, but you can figure it out.",0,3,oMessageCutscene,1)
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"Jerry","I know, they're right above me.",0,3,oMessageCutscene,1)
  else if sceneProgress=3
  {
    sceneDelay=0; sceneProgress=0
    global.gameProgress=60
    global.gamePaused=false
  }
}
else if global.gameProgress=60 and room=rMain_4 //----- [5] After grabbing Jump Boots -----
{
  if sceneProgress=0 and !instance_exists(oStoryObject)
  {
    sceneDelay+=1*gDeltaTime
    if sceneDelay=1 {global.gamePaused=true}
    else if sceneDelay>=2
    {
      oPlayer1.y+=4
      if oPlayer1.y>=416
      {
        oPlayer1.y=416
        oPlayer1.sprite_index=sJerryIdle
        oPlayer1.image_speed=0.1
        sceneDelay=0; sceneProgress+=1
      }
    }
  }
  else if sceneProgress=1
  {
    sceneDelay+=1*gDeltaTime
    if sceneDelay>=60 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Okay, now you should be able to get to Central City.",0,3,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Jerry","How far is it?",0,3,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Not far at all.",0,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Claire","What about me?",0,3,oMessageCutscene,1)
  else if sceneProgress=6 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","I've almost got this figured out.",0,3,oMessageCutscene,1)
  else if sceneProgress=7 and bWaitForInput=false
    msgCreate(0,0,"Claire","Oh thank God.",0,3,oMessageCutscene,1)
  else if sceneProgress=8 and bWaitForInput=false
    msgCreate(0,0,"Jerry","What happened to your backseat gaming?",0,3,oMessageCutscene,1)
  else if sceneProgress=9 and bWaitForInput=false
    msgCreate(0,0,"Claire","I haven't forgotten.",0,3,oMessageCutscene,1)
  else if sceneProgress=10
  {
    indexCheckDoor=string_char_at(global.lockedDoor,5)
    if indexCheckDoor="0"
    {
      var tCheckAchieve;
      tCheckAchieve=string_char_at(global.tokenRecognitions,2)
      if tCheckAchieve="0"
      {
        var tAchievement;
        tAchievement=instance_create(0,0,oAchievementNotice)
        tAchievement.myAchievement="Dirty Cheater"; tAchievement.checkNum=2
      }
      sceneProgress=20
    }
    else {sceneProgress=30}
  }
  else if sceneProgress=20 //Player cheated
    msgCreate(0,0,"Jeremy","Hold on, it appears you're trying to cheat...",0,3,oMessageCutscene,1)
  else if sceneProgress=21
    msgCreate(0,0,"Jerry","Yeah you caught me there.",0,3,oMessageCutscene,1)
  else if sceneProgress=22
    msgCreate(0,0,"Jeremy","I'm both disappointed and amazed you thought to do that. But we can't allow things like that to go uncorrected. Bugs in the system like that cause instabilities, so I'm going to fix up your mess.",0,3,oMessageCutscene,1)
  else if sceneProgress=23
    msgCreate(0,0,"Jerry","Lame, I figured I could get an extra key.",0,3,oMessageCutscene,1)
  else if sceneProgress=24
    sceneProgress=30
  else if sceneProgress=30
  {
    var tNewString;
    tNewString=string_delete(global.lockedDoor,4,1)
    tNewString=string_insert("1",tNewString,4)
    global.lockedDoor=tNewString
    tNewString=string_delete(global.lockedDoor,5,1)
    tNewString=string_insert("1",tNewString,5)
    global.lockedDoor=tNewString
    tNewString=string_delete(global.lockedDoor,6,1)
    tNewString=string_insert("1",tNewString,6)
    global.lockedDoor=tNewString
    tNewString=string_delete(global.doorKey,4,1)
    tNewString=string_insert("1",tNewString,4)
    global.doorKey=tNewString
    tNewString=string_delete(global.doorKey,5,1)
    tNewString=string_insert("1",tNewString,5)
    global.doorKey=tNewString
    tNewString=string_delete(global.doorKey,6,1)
    tNewString=string_insert("1",tNewString,6)
    global.doorKey=tNewString
    with oLockedDoor {instance_destroy();}
    with oDoorKey {instance_destroy();}

    var tNewTutorial;
    tNewTutorial=instance_create(0,0,oTutorialPanel)
    tNewTutorial.tutorialTitle="Jumping"
    tNewTutorial.tutorialInfo=string("To jump, press [") +string(global.ctrlJump) +string("]. The longer it is held down, the higher you will jump.")
    tNewTutorial.scrAreaY=0
    sceneDelay=0; sceneProgress=0
    global.hasShoes[1]=2
    global.gameProgress=70
    global.gamePaused=false
  }
}
else if global.gameProgress=80 and room=rMain_5 //----- [6] Go this way & Scanning -----
{
  if sceneProgress=0
  {
    sceneDelay+=1*gDeltaTime
    if sceneDelay=1
      global.gamePaused=true
    else if sceneDelay>=20
    {
      sceneDelay=0
      sceneProgress+=1
    }
  }
  else if sceneProgress=1 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Head straight and you'll reach the city.",0,3,oMessageCutscene,1)
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"Jerry","What's so important about this place?",0,3,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","You'll see when you get there. Trust me, we'll need the city's resources to fight the Virus.",0,3,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Alrighty.",0,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Claire","Figured it out yet?",0,3,oMessageCutscene,1)
  else if sceneProgress=6 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Not yet, but I'll let you know when I do. There's also something I need to tell you about scanning.",0,3,oMessageCutscene,1)
  else if sceneProgress=7 and bWaitForInput=false
    msgCreate(0,0,"Chao","I take care of scanning for you!",0,3,oMessageCutscene,1)
  else if sceneProgress=8 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","That's right, you can use the mouse to guide Chao over an enemy and left click them for more information. I'll explain all the attributes of it at a later time when it is more important.",0,3,oMessageCutscene,1)
  else if sceneProgress=9 and bWaitForInput=false
    msgCreate(0,0,"Chao","Hey! I was supposed to explain that! I'm the one that flies around doing all the work!",0,3,oMessageCutscene,1)
  else if sceneProgress=10 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Sorry about that sis, I'll let you explain the Attack Type attributes when that time comes around.",0,3,oMessageCutscene,1)
  else if sceneProgress=11
  {
    sceneDelay=0; sceneProgress=0
    global.gameProgress=90
    global.gamePaused=false
  }
}
else if global.gameProgress=100 and room=rMain_5 //----- [7] Swap characters -----
{
  if sceneProgress=0 and oPlayer1.x>=560 and oPlayer1.y<=480
  {
    sceneDelay+=1*gDeltaTime
    if sceneDelay=1 {global.gamePaused=true}
    else if sceneDelay>=2
    {
      oPlayer1.y+=4
      if oPlayer1.y>=464
      {
        oPlayer1.y=464
        oPlayer1.sprite_index=sJerryIdle
        oPlayer1.image_speed=0.1
        sceneDelay=0; sceneProgress+=1
      }
    }
  }
  else if sceneProgress=1
  {
    sceneDelay+=1*gDeltaTime
    if sceneDelay>=15 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","I got it!!",0,3,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Got what?",0,3,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","I figured out how to get Claire out of this place.",0,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Claire","YOU DID!?",0,3,oMessageCutscene,1)
  else if sceneProgress=6 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Yep, there is an issue though...#Due to some problems that I'm not even going to try explaining, you both can't be out at the same time for very long.",0,3,oMessageCutscene,1)
  else if sceneProgress=7 and bWaitForInput=false
    msgCreate(0,0,"Jerry","So that means when one of us comes out, the other has to leave?",0,3,oMessageCutscene,1)
  else if sceneProgress=8 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Yes, as unfortunate as it is. A quick note on your differences. Claire, you run a bit faster. Jerry, you have a somewhat smaller hitbox when running... I think that's about it for now, but other differences will definitely show up.",0,3,oMessageCutscene,1)
  else if sceneProgress=9 and bWaitForInput=false
    msgCreate(0,0,"Claire","I guess I can work with that. Just don't try to hog the spotlight all the time Jerry.",0,3,oMessageCutscene,1)
  else if sceneProgress=10 and bWaitForInput=false
    msgCreate(0,0,"Jerry","This works for me, I can leave the annoying parts for Claire.",0,3,oMessageCutscene,1)
  else if sceneProgress=11 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Oh hey, Jerry. I noticed you're still cosplaying... you gonna change that?",0,3,oMessageCutscene,1)
  else if sceneProgress=12 and bWaitForInput=false
    msgCreate(0,0,"Jerry","I could have but... wait, Claire's still doing that too.",0,3,oMessageCutscene,1)
  else if sceneProgress=13 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","So you're not changing it...",0,3,oMessageCutscene,1)
  else if sceneProgress=14 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Nope.",0,3,oMessageCutscene,1)
  else if sceneProgress=15 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Fair enough.",0,3,oMessageCutscene,1)
  else if sceneProgress=16
  {
    global.canCharSwap=2
    var tNewTutorial;
    tNewTutorial=instance_create(0,0,oTutorialPanel)
    tNewTutorial.tutorialTitle="Character Swapping"
    tNewTutorial.tutorialInfo=string("To swap out characters, press [") +string(global.ctrlCharSwap) +string("]. There is a slight delay before you can swap again after using it.")
    tNewTutorial.scrAreaY=0
    sceneDelay=0; sceneProgress=0
    global.gameProgress=110
    global.gamePaused=false
  }
}
else if global.gameProgress=120 and room=rMain_5Gate //----- [8] What is that? It's an Access Gate -----
{
  if sceneProgress=0
  {
    sceneDelay+=1*gDeltaTime
    if sceneDelay=1
    {
      global.gamePaused=true
      oPlayer1.image_xscale=-1
    }
    else if sceneDelay>=20 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=1 and bWaitForInput=false
    msgCreate(0,0,"Jerry","What is that thing? That's not a plot hole is it?",0,3,oMessageCutscene,1)
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","No, this is an Access Gate.",0,3,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Jerry","To what?",0,3,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Another world...#I need you to go in.",0,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Claire","Do you even know what's on the other side?",0,3,oMessageCutscene,1)
  else if sceneProgress=6 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Sorta...",0,3,oMessageCutscene,1)
  else if sceneProgress=7 and bWaitForInput=false
    msgCreate(0,0,"Claire","We're supposed to go in based on that?",0,3,oMessageCutscene,1)
  else if sceneProgress=8 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Beyond this gate lies something we need to fight the Virus.",0,3,oMessageCutscene,1)
  else if sceneProgress=9 and bWaitForInput=false
    msgCreate(0,0,"Jerry","How do you know all this?",0,3,oMessageCutscene,1)
  else if sceneProgress=10 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Trust me on this one, I'll explain it later. It also has what we need to get past those Hammer Bros.",0,3,oMessageCutscene,1)
  else if sceneProgress=11 and bWaitForInput=false
    msgCreate(0,0,"Jerry","If you say so...#That thing looks so weird.",0,3,oMessageCutscene,1)
  else if sceneProgress=12
  {
    sceneDelay=0; sceneProgress=0
    global.gameProgress=130
    global.gamePaused=false
  }
}
else if global.gameProgress=140 and room=rMain_5Gate //----- [Unskippable] Access Gate 1 -----
{
  if sceneProgress=0
  {
    sceneDelay+=1*gDeltaTime
    if sceneDelay>=1
    {
      if sceneDelay=1 {global.gamePaused=true}
      fadeAlpha+=0.04*gDeltaTime
      if fadeAlpha>=1 {sceneDelay=0; sceneProgress+=1}
    }
  }
  else if sceneProgress=1
  {
    oPlayer1.life=oPlayer1.maxLife
    global.recAreaTrans+=1
    global.newMapX=120
    global.newMapY=288
    writeToPlayerGlobals()
    stopAllMusic()
    transition_steps=1
    transition_kind=0
    room_goto(rMario1_1)
  }
}
else if global.gameProgress=510 and room=rMain_5Gate //----- [9] The Nightmare Gates -----
{
  if sceneProgress=0
  {
    sceneDelay+=1*gDeltaTime
    if sceneDelay=1 {global.gamePaused=true}
    else if sceneDelay>=20 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=1 and bWaitForInput=false
    msgCreate(0,0,"Claire","What is that other portal up there?",0,3,oMessageCutscene,1)
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","It's weird to explain, it suddenly appeared after you got the Program Chip though.",0,3,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Claire","Do you have any idea where it leads to?",0,3,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","It is a gate much like the one you just went through, but there are some other nuances. A red gate like that will always resemble the gate it is closest to. In this instance, Mario.",0,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Don't tell me we have to put the Program Chip in there.",0,3,oMessageCutscene,1)
  else if sceneProgress=6 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","No, nothing like that. Whatever is in there, it doesn't look like we'll need it to stop the Virus. There's nothing stopping you from going in, but I must warn you, the contents within the red gates are not to be trifled with lightly.",0,3,oMessageCutscene,1)
  else if sceneProgress=7 and bWaitForInput=false
    msgCreate(0,0,"Jerry","In other words, it's side content that's super difficult?",0,3,oMessageCutscene,1)
  else if sceneProgress=8 and bWaitForInput=false
    msgCreate(0,0,"Claire","I like Jeremy's explanation better.",0,3,oMessageCutscene,1)
  else if sceneProgress=9 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Do you, or are you just messing with me?",0,3,oMessageCutscene,1)
  else if sceneProgress=10 and bWaitForInput=false
    msgCreate(0,0,"Claire","Probably.",0,3,oMessageCutscene,1)
  else if sceneProgress=11 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Fair enough, what should we call them?",0,3,oMessageCutscene,1)
  else if sceneProgress=12 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","I don't know... Extra Gates?",0,3,oMessageCutscene,1)
  else if sceneProgress=13 and bWaitForInput=false
    msgCreate(0,0,"Chao","How about Nightmare Gates? Considering what's probably on the other side.",0,3,oMessageCutscene,1)
  else if sceneProgress=14 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","I like that...#So while I know whatever is in there has nothing to do with the Virus, I don't know if we'll need anything in there or not. Eh, hard to say at this point.",0,3,oMessageCutscene,1)
  else if sceneProgress=15 and bWaitForInput=false
    msgCreate(0,0,"Jerry","No objections here.",0,3,oMessageCutscene,1)
  else if sceneProgress=16
  {
    sceneDelay=0; sceneProgress=0
    global.gameProgress=511
    global.gamePaused=false
  }
}
else if global.gameProgress=511 and room=rMain_5 //----- [Unskippable] Beat the 2 Hammer Bros -----
{
  if global.gamePaused=false
  {
    if sceneProgress=0
    {
      if !instance_exists((119321)) and !instance_exists((119322))
      {
        var enemyCounter,enemyBarrier;
        enemyCounter=instance_create(0,0,oEnemyRemain)
        enemyCounter.enemyCount=8
        
        enemyBarrier=instance_create(912,800,oEnemyBarrier); enemyBarrier.image_yscale=6
        sceneProgress+=1
      }
    }
    else if sceneProgress=1
    {
      sceneDelay+=1*gDeltaTime
      if sceneDelay=30
      {
        delaySpawn(1424,928,oFireBro,2,1,1,0.33)
        delaySpawn(1504,928,oHammerBro,2,1,1,0.33)
        delaySpawn(1632,928,oHammerBro,2,1,1,0.33)
        delaySpawn(1712,928,oFireBro,2,1,1,0.33)
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
      if sceneDelay=15
      {
        delaySpawn(1424,784,oHammerBro,2,1,1,0.33)
        delaySpawn(1504,784,oFireBro,2,1,1,0.33)
        delaySpawn(1632,784,oFireBro,2,1,1,0.33)
        delaySpawn(1712,784,oHammerBro,2,1,1,0.33)
        sceneDelay=0
        sceneProgress+=1
      }
    }
    else if sceneProgress=4
    {
      if oEnemyRemain.enemyCount<=0
      {
        with oEnemyRemain {instance_destroy()}
        with oEnemyBarrier {instance_destroy()}
        sceneProgress=0
        global.gameProgress=520
      }
    }
  }
}

keyWaitForInput()

if oKeyCodes.kCodePressed[11]=1 and global.gamePaused=true and sceneProgress>=1 //Cutscene skip
{
  if !instance_exists(oPauseMenu)
  {
    if global.gameProgress=0 and room=rMain_1 //[1]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      with oMessagePerson {instance_destroy()}
      oPlayer1.y=2048
      oPlayer1.visible=1
      fadeAlpha=0
      sceneDelay=0; sceneProgress=14
    }
    else if global.gameProgress=9 and room=rMain_1 //[2]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      sceneDelay=0; sceneProgress=2
    }
    else if global.gameProgress=20 and room=rMain_2 //[3]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      sceneDelay=0; sceneProgress=4
    }
    else if global.gameProgress=50 and room=rMain_4 //[4]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      sceneDelay=0; sceneProgress=3
    }
    else if global.gameProgress=60 and room=rMain_4 //[5]
    {
      if sceneProgress>=1
      {
        bWaitForInput=false
        with oMessageCutscene {instance_destroy()}
        sceneDelay=0
        if sceneProgress<10 {sceneProgress=10}
        else {sceneProgress=30}
      }
    }
    else if global.gameProgress=80 and room=rMain_5 //[6]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      sceneDelay=0; sceneProgress=11
    }
    else if global.gameProgress=100 and room=rMain_5 //[7]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      sceneDelay=0; sceneProgress=16
    }
    else if global.gameProgress=120 and room=rMain_5Gate //[8]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      sceneDelay=0; sceneProgress=12
    }
    else if global.gameProgress=510 and room=rMain_5Gate //[9]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      sceneDelay=0; sceneProgress=16
    }
  }
}

//----- Room specific events -----
if global.gamePaused=false
{
  if room=rMain_1 and global.gameProgress=10
  {
    if oPlayer1.xVel!=0
    {
      var tCheckAchieve;
      tCheckAchieve=string_char_at(global.tokenRecognitions,1)
      if tCheckAchieve="0"
      {
        var tAchievement;
        tAchievement=instance_create(0,0,oAchievementNotice)
        tAchievement.myAchievement="First Steps"; tAchievement.checkNum=1
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
