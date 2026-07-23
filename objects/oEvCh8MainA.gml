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
beamDownProg=0
readyText=0
readyWidth=0
if global.tempAction[0]=1 {playerSpotY=192}
else if global.tempAction[0]=2 {playerSpotY=160}
else if global.tempAction[0]=3 {playerSpotY=272}

if room=rMega4_Gate
{
  if global.gameProgress=1760
  {
    fadeAlpha=1
    npcMMX=instance_create(304,304,oMisc)
    npcMMX.sprite_index=sMegamanXIdle; npcMMX.image_xscale=-1
    npcMMX.image_speed=0; npcMMX.type=1

    drawType=0
    for(i=0;i<4;i+=1)
    {
      colCh[i]=i*51
    }
    colS[0]=make_color_rgb(colCh[0],colCh[1],colCh[2])
    colS[1]=make_color_rgb(colCh[1],colCh[2],colCh[3])
    colS[2]=make_color_rgb(colCh[2],colCh[3],colCh[0])
    colS[3]=make_color_rgb(colCh[3],colCh[0],colCh[1])
    xOffset=14; yOffset=-39
    imageGrowMax=0

    triAlpha=0
    triAmt=3
    triDist=160
    triAng=0
    triWidth=15

    circleAlpha=0
    circleSize=0
  }
}
else if room=rMega4_Shop
{
  if global.gameProgress=1845
  {
    fadeColor=c_black
    fadeAlpha=1
  }
}
else if room=rMega4_IntroC
{
  wallCheck=0
}
else if room=rMega4_StormA or room=rMega4_StormB or room=rMega4_StormC or room=rMega4_StormE
{
  gameProgCheck=string_char_at(global.gameGate4Prog,1)
  if room=rMega4_StormB
  {
    rmProg=0
    for(i=0;i<3;i+=1)
    {
      cannonSpawn[i]=0
      cannonTime[i]=31+(i*150)
    }
  }
  if room=rMega4_StormE and gameProgCheck!="9"
  {
    fadeColor=c_black
    if global.bossTrack=0 {fadeAlpha=1}
  }
}
else if room=rMega4_OstrichB or room=rMega4_OstrichE
{
  gameProgCheck=string_char_at(global.gameGate4Prog,2)
  if room=rMega4_OstrichE and gameProgCheck!="9"
  {
    blendCl=0
    fadeColor=c_black
    if global.bossTrack=0 {fadeAlpha=1}
  }
}
else if room=rMega4_ToxicJungleB
{
  indexCheck=string_char_at(global.missilePack,6)
  if indexCheck="1" {pickupCheck=10000}
  else {pickupCheck=0}
}
else if room=rMega4_ToxicJungleC
{
  bWallSpawn=0
}
else if room=rMega4_ToxicJungleE
{
  gameProgCheck=string_char_at(global.gameGate4Prog,3)
  if gameProgCheck!="9"
  {
    fadeColor=c_black
    if global.bossTrack=0 {fadeAlpha=1}
  }
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gameProgress=1760 and room=rMega4_Gate //----- [Unskippable] Intro to Megapolis - Ch.8 -----
{
  if sceneProgress=0
  {
    sceneDelay+=1
    if sceneDelay=1
    {
      global.activeAbility[0]=0
      charSwitcher(0)
      scenePChk(192,304,0,0.1,1)
    }
    else if sceneDelay>=30
    {
      fadeAlpha-=0.02
      if fadeAlpha<=0
      {
        sceneDelay=0
        sceneProgress+=1
      }
    }
  }
  else if sceneProgress=1 and bWaitForInput=false
    msgCreate(0,0,"Jerry","It's awesome to fight with you again X. There's no way we can lose!",0,3,oMessageCutscene,1)
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"X","I will be with you, but not like this.",6,3,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Jerry","What do you mean? You're fighting along with me right?",0,3,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"X","I can't. I would only be a danger to you in this state. Sigma has been modified by the Virus. If I come into contact with him now, his corruption would quickly spread to me.",6,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Jerry","But...",0,3,oMessageCutscene,1)
  else if sceneProgress=6 and bWaitForInput=false
    msgCreate(0,0,"X","And you need to borrow my power. In order to do that, I have to give up this body.",6,3,oMessageCutscene,1)
  else if sceneProgress=7 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Is that what all the others have done when we enter into these Gates?",0,3,oMessageCutscene,1)
  else if sceneProgress=8 and bWaitForInput=false
    msgCreate(0,0,"X","Yes, they were all concealing themselves from the Virus. They knew they would all be a target. The only way to ensure their continued fight against the Virus threat was to give their abilities to you and secure themselves as part of you.",6,3,oMessageCutscene,1)
  else if sceneProgress=9 and bWaitForInput=false
    msgCreate(0,0,"Jerry","But what happens to you?",0,3,oMessageCutscene,1)
  else if sceneProgress=10 and bWaitForInput=false
    msgCreate(0,0,"X","I will be there with you just as all the others have been.",6,3,oMessageCutscene,1)
  else if sceneProgress=11
  {
    sceneDelay+=1
    if sceneDelay=1 //Start music
    {
      var tempMplay;
      tempMplay=findMusic(9)
      playMusic(tempMplay,0,1)
    }
    else if sceneDelay=30
    {
      msgCreate(0,0,"Jerry","Can't it be done another way?",0,3,oMessagePerson,0)
      newMessage.fadingTime=70
    }
    else if sceneDelay=110
    {
      msgCreate(0,0,"X","I trusted you in the past, and now I'm going to put my trust in you once more.",6,3,oMessagePerson,0)
      newMessage.fadingTime=140
    }
    else if sceneDelay=260
    {
      msgCreate(0,0,"Jerry","But X, wait!",0,3,oMessagePerson,0)
      newMessage.fadingTime=90
      oPlayer1.sprite_index=sJerryPose1
      sceneDelay=0
      sceneProgress+=1
    }
  }
  else if sceneProgress=12
  {
    triAng+=2
    sceneDelay+=1
    if sceneDelay>=31 and sceneDelay<=350 //X floats up
    {
      if sceneDelay>=95 and sceneDelay mod 11=0 //Flash Tri-Flash
      {
        if triAlpha<=0.2 and random(10)>6.75 {triAlpha=1}
      }

      if sceneDelay=31 {npcMMX.sprite_index=sMegamanXPowerA}
      else if sceneDelay=61 {npcMMX.image_index=1}
      else if sceneDelay=91 {npcMMX.image_index=2}
      else if sceneDelay=170
      {
        efCharge=instance_create(npcMMX.x,npcMMX.y-20,oMisc)
        efCharge.sprite_index=sMMcharging
        efCharge.image_speed=0.5
        efCharge.depth=15
        efCharge.type=1
        efCharge.image_xscale=4
        efCharge.image_yscale=4
      }

      npcMMX.y-=0.25
    }
    else if sceneDelay=380 //Complete float up
    {
      with efCharge {instance_destroy()}
      var tEffect;
      tEffect=instance_create(npcMMX.x,npcMMX.y-20,oEffect)
      tEffect.sprite_index=sMMchargeComplete; tEffect.image_xscale=2; tEffect.image_yscale=2
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
      scaleX=1
      drawType=1
    }

    if sceneDelay>=171 and sceneDelay<=379 //Charge effect scale down
    {
      efCharge.x=npcMMX.x; efCharge.y=npcMMX.y-20
      efCharge.image_xscale-=0.019; efCharge.image_yscale-=0.019
    }
    if sceneDelay<=379 {if triAlpha>0 {triAlpha-=0.1}} //Fade Tri-Flash effect
    if sceneDelay>=421 and sceneDelay<=480 and sceneDelay mod 3=0 //Back image effect
    {
      scaleX+=0.1
      imageGrow[imageGrowMax]=instance_create(npcMMX.x,npcMMX.y,oMisc)
      imageGrow[imageGrowMax].sprite_index=npcMMX.sprite_index
      imageGrow[imageGrowMax].image_xscale=scaleX*-1; imageGrow[imageGrowMax].image_yscale=scaleX
      imageGrow[imageGrowMax].image_speed=0
      imageGrow[imageGrowMax].depth=40+(scaleX*10)
      imageGrow[imageGrowMax].type=1
      imageGrowMax+=1
    }
    if sceneDelay=530 //Break image grow effect
    {
      triAlpha=0; triAmt=1; triWidth=0
      var tFlash;
      tFlash=instance_create(0,0,oScreenFlash)
      tFlash.fadeSpeed=0.2
      npcMMX.sprite_index=sMegamanXPowerB; npcMMX.image_index=0
      xOffset=23; yOffset=-48
      for(i=0;i<imageGrowMax;i+=1)
      {
        with imageGrow[i] {instance_destroy()}
      }
      for(i=0;i<60;i+=1)
      {
        var tFFScl,tEffect;
        tFFScl=random(0.1)
        tEffect=instance_create(npcMMX.x,npcMMX.y-20,oEffectB)
        tEffect.type=3; tEffect.sprite_index=sEfFirefly; tEffect.newBlend=1
        tEffect.image_alpha=0.5; tEffect.image_xscale=0.15+tFFScl; tEffect.image_yscale=0.15+tFFScl
        tEffect.direction=random(360); tEffect.speed=random(2)+1; tEffect.friction=random(0.02)+0.03
        tEffect.fadeSpd=0.005; tEffect.image_blend=make_color_rgb(40+random(60),40+random(60),255)
        tEffect.AccelX=0; tEffect.AccelY=0; tEffect.followID=-1; tEffect.rotation=0
      }
    }

    if sceneDelay>=601 and sceneDelay<=680 //Fade in Tri-Flash Spin
    {
      if triAlpha<0.8 {triAlpha+=0.02}
      if triWidth<15 {triWidth+=0.25}
    }
    else if sceneDelay=690
    {
      var tFlash;
      tFlash=instance_create(0,0,oScreenFlash)
      tFlash.fadeSpeed=0.2
      triAmt+=1
    }
    else if sceneDelay=750
    {
      var tFlash;
      tFlash=instance_create(0,0,oScreenFlash)
      tFlash.fadeSpeed=0.2
      triAmt+=1
    }

    if sceneDelay=810
    {
      msgCreate(0,0,"X","You can put an end to all of this, you can stop Sigma.",6,3,oMessagePerson,0)
      newMessage.fadingTime=120
    }
    else if sceneDelay=940
    {
      msgCreate(0,0,"Jerry","X, don't do this!",0,3,oMessagePerson,0)
      newMessage.fadingTime=50
    }
    else if sceneDelay=1000
    {
      msgCreate(0,0,"X","The others trusted you two with their power, and now it's my turn. This is the only way to keep it protected.",6,3,oMessagePerson,0)
      newMessage.fadingTime=180
    }
    else if sceneDelay=1190
    {
      msgCreate(0,0,"Jerry","We'll figure out another way!",0,3,oMessagePerson,0)
      newMessage.fadingTime=60
    }

    if sceneDelay>=1281 and sceneDelay<=1510 //Circle size increase (Slow)
    {
      if circleAlpha<1 {circleAlpha+=0.05}
      if circleSize<80 {circleSize+=0.25}
    }
    else if sceneDelay>=1511 and sceneDelay<=1630 //Circle size increase (Fast)
    {
      circleSize+=3.5
      triDist+=1
    }

    if sceneDelay=1370
    {
      msgCreate(0,0,"X","Together!#All of us!#We will fight to save our world!",6,3,oMessagePerson,0)
      newMessage.fadingTime=90
    }
    else if sceneDelay=1470
    {
      msgCreate(0,0,"Jerry","Damn it X! There has to be another way!",0,3,oMessagePerson,0)
      newMessage.fadingTime=80
    }

    if sceneDelay=1630 //Jerry in the air
    {
      triDist=160
      oPlayer1.sprite_index=sJerryPose2
      oPlayer1.y=224
    }
    else if sceneDelay>=1631 and sceneDelay<=1660 //Circle fade (screen white)
    {
      if circleAlpha>0 {circleAlpha-=0.04}
    }
    else if sceneDelay>=1681 and sceneDelay<=1760 //Bring Tri-Flash in
    {
      if sceneDelay=1681
      {
        npcMMX.sprite_index=sMegamanXPowerA; npcMMX.image_index=2
        xOffset=14; yOffset=-39
      }
      if triDist>0 {triDist-=2}
      if triWidth>3 {triWidth-=0.05}
      if triAlpha>0.1 {triAlpha-=0.01}

      if sceneDelay=1760 {triAlpha=0}
    }
    else if sceneDelay=1810
    {
      msgCreate(0,0,"X","The world is depending on you. Now go...",6,3,oMessagePerson,0)
      newMessage.fadingTime=90
    }
    else if sceneDelay=1910
    {
      drawType=0
      npcMMX.sprite_index=sMegamanXPowerB; npcMMX.image_index=0
      xOffset=23; yOffset=-48
      var tFlash;
      tFlash=instance_create(0,0,oScreenFlash)
      tFlash.fadeSpeed=0.2
      msgCreate(0,0,"X","AND SAVE IT!",6,3,oMessagePerson,0)
      newMessage.fadingTime=60
    }
    else if sceneDelay>=1911 and sceneDelay<=1920 {npcMMX.image_alpha-=0.1} //MMX fade out

    if sceneDelay=1911 //Normal ability notice
    {
      oPlayer1.sprite_index=sJerryJump
      abilNotice=instance_create(oPlayer1.x,oPlayer1.y-18,oMisc)
      abilNotice.sprite_index=sMegamanXPowerB
      abilNotice.image_speed=0; abilNotice.depth=15; abilNotice.type=1
      abilNotice.image_xscale=4; abilNotice.image_yscale=4; abilNotice.image_alpha=0.75
    }
    else if sceneDelay>=1912 and sceneDelay<=1951
    {
      abilNotice.image_xscale-=0.1
      abilNotice.image_yscale-=0.1
    }
    else if sceneDelay=1952
    {
      with abilNotice {instance_destroy()}
    }

    if sceneDelay>=1631 and sceneDelay<=1910 and sceneDelay mod 6=0 //Jerry afterimage
    {
      var afterImage;
      afterImage=instance_create(oPlayer1.x,oPlayer1.y,oSceneAfterImage)
      afterImage.image_alpha=0.7; afterImage.sprite_index=sJerryPose2
      afterImage.image_index=0; afterImage.image_blend=c_green; afterImage.depth=21
      afterImage.imageFade=0.1; afterImage.xScalingSet=0.1; afterImage.yScalingSet=0.1
    }

    if sceneDelay=1970 {stopAllMusic()}
    else if sceneDelay=1980
    {
      stopAllMusic()
      sceneDelay=0
      sceneProgress+=1
    }
  }
  else if sceneProgress=13
  {
    oPlayer1.y+=4
    if oPlayer1.y>=304
    {
      scenePChk(oPlayer1.x,304,0,0.1,1)
      stopPlayer()
      sceneProgress+=1
    }
  }
  else if sceneProgress=14 and bWaitForInput=false
    msgCreate(112,128,"","Jerry gained the Mega Man X Ability Set!#He can now use some of X's abilities.",6,2,oMessageCutscene,1)
  else if sceneProgress=15 and bWaitForInput=false
    msgCreate(0,0,"Jerry","This... this sucks you guys.",0,3,oMessageCutscene,1)
  else if sceneProgress=16 and bWaitForInput=false
    msgCreate(0,0,"Claire","I had no idea this is what was really happening...",0,3,oMessageCutscene,1)
  else if sceneProgress=17 and bWaitForInput=false
    msgCreate(0,0,"Chao","You guys! X wouldn't want you to be so down like this. He gave this part of himself to you for a reason! This is what he wanted.",0,3,oMessageCutscene,1)
  else if sceneProgress=18 and bWaitForInput=false
    msgCreate(0,0,"Jerry","I know, it just sucks.",0,3,oMessageCutscene,1)
  else if sceneProgress=19 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","It won't go to waste.",0,3,oMessageCutscene,1)
  else if sceneProgress=20 and bWaitForInput=false
    msgCreate(0,0,"Chao","He's right, you will put that power to good use. Right Claire?!",0,3,oMessageCutscene,1)
  else if sceneProgress=21 and bWaitForInput=false
    msgCreate(0,0,"Claire","Yeah...#You can do this, Jerry.",0,3,oMessageCutscene,1)
  else if sceneProgress=22 and bWaitForInput=false
    msgCreate(0,0,"Jerry","You're right... It's time to do this.",0,3,oMessageCutscene,1)
  else if sceneProgress=23 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Awesome, now there's one other thing X gave you aside from his X Buster.",0,3,oMessageCutscene,1)
  else if sceneProgress=24 and bWaitForInput=false
    msgCreate(0,0,"Jerry","What would that be?",0,3,oMessageCutscene,1)
  else if sceneProgress=25 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Within this Gate, you can wall jump.",0,3,oMessageCutscene,1)
  else if sceneProgress=26 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Whoa, hold up, are you serious?!",0,3,oMessageCutscene,1)
  else if sceneProgress=27 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Try it out yourself.",0,3,oMessageCutscene,1)
  else if sceneProgress=28
  {
    sceneDelay=0
    sceneProgress=0
    var tNewChapter;
    tNewChapter=instance_create(0,0,oChapterDisplay)
    tNewChapter.newChapter="Chapter 8#Mega Jerry"
    global.canCharSwap=1
    global.hasAbilToken[1]=1
    global.hasAbilToken[3]=2
    global.activeAbility[0]=2
    global.gameProgress=1770
    global.gamePaused=false
  }
}
else if global.gameProgress=1780 and room=rMega4_IntroA //----- [1] About red outlined obstacles -----
{
  if sceneProgress=0
  {
    sceneDelay+=1
    if sceneDelay=1
      global.gamePaused=true
    else if sceneDelay>=20
    {
      sceneDelay=0
      sceneProgress+=1
    }
  }
  else if sceneProgress=1 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Before you move on, there's something very very important that I need to tell you.",0,3,oMessageCutscene,1)
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Oh yeah?",0,3,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Any time you see an obstacle with a red outline, it means you can't dash through it unharmed.",0,3,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Jerry","So that works like those spinning spike wheels then.",0,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Exactly like that.",0,3,oMessageCutscene,1)
  else if sceneProgress=6 and bWaitForInput=false
    msgCreate(0,0,"Jerry","I totally blame you and that Virus... mostly you.",0,3,oMessageCutscene,1)
  else if sceneProgress=7 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Definitely 100% my fault.",0,3,oMessageCutscene,1)
  else if sceneProgress=8
  {
    sceneDelay=0
    sceneProgress=0
    global.gameProgress=1790
    global.gamePaused=false
  }
}
else if global.gameProgress=1790 and room=rMega4_IntroA //----- [] Tutorial: Wall Jumping 1 -----
{
  if sceneProgress=0
  {
    if oPlayer1.x>=992
    {
      var tNewTutorial;
      tNewTutorial=instance_create(0,0,oTutorialPanel)
      tNewTutorial.tutorialTitle="Wall Jumping 1"
      tNewTutorial.tutorialInfo="To jump off a wall, simply face a wall while in the air and press [Jump]. You don't need to hold the direction key against the wall to stick to it."
      tNewTutorial.scrAreaY=0
      sceneProgress+=1
    }
  }
}
else if global.gameProgress=1800 and room=rMega4_IntroB //----- [] Tutorial: Wall Jumping 2 -----
{
  if sceneProgress=0
  {
    if oPlayer1.x>=272
    {
      var tNewTutorial;
      tNewTutorial=instance_create(0,0,oTutorialPanel)
      tNewTutorial.tutorialTitle="Wall Jumping 2"
      tNewTutorial.tutorialInfo="To dash off a wall, simply hold [Down] when you jump off of it. The dash buttons work as well."
      tNewTutorial.scrAreaY=0
      sceneProgress+=1
    }
  }
}

else if global.gameProgress=1830 and room=rMega4_IntroE //----- [Unskippable] Boss Fight: Maoh the Giant -----
{
  if global.bossTrack=0
  {
    if sceneProgress=0 and oPlayer1.x>=336
    {
      sceneDelay+=1
      if sceneDelay=1 {global.gamePaused=true}
      oPlayer1.y+=4
      if oPlayer1.y>=240
      {
        oPlayer1.y=240
        oPlayer1.sprite_index=sJerryIdle
        stopPlayer()
        sceneDelay=0
        sceneProgress+=1
      }
    }
    else if sceneProgress=1
    {
      sceneDelay+=1
      if sceneDelay=1
      {
        tempMplay=findMusic(402)
        playMusic(tempMplay,0,0)
      }
      else if sceneDelay=50 {boss=instance_create(336,334,oMaohTheGiant)}
      else if sceneDelay>=51 and sceneDelay<=300
      {
        boss.y-=1
        if boss.y<=176
        {
          sceneDelay=0
          sceneProgress+=1
        }
      }
    }
    else if sceneProgress=2
    {
      sceneDelay+=1
      if sceneDelay=50
      {
        showBossHP=instance_create(0,0,oBossLifeDisplay)
        showBossHP.bossID=oMaohTheGiant; showBossHP.type=1; showBossHP.lifeFill=0
      }
      else if sceneDelay>=51 and sceneDelay<=300
      {
        if sceneDelay mod 2=0
        {
          playSound(global.snd_MMLifeBlip,0,1,1)
          showBossHP.healthTrack+=2
        }
        if showBossHP.healthTrack=50 {sceneDelay=500}
      }
      else if sceneDelay>=510
      {
        sceneDelay=0
        sceneProgress+=1
      }
    }
    else if sceneProgress=3
    {
      with showBossHP {instance_destroy()}
      global.gamePaused=false
      var tBossTitle,tempMplay,bossBarr;
      bossBarr=instance_create(80,176,oBossBarrier)
      tBossTitle=instance_create(0,0,oBossNameDisplay)
      tBossTitle.bossName="Maoh the Giant"
      tBossTitle.bossTitle="It already has a title in the name"
      tempMplay=findMusic(810)
      playMusic(tempMplay,0,0)
      boss.activateBoss=1
      global.currentBoss="Maoh"
      global.bossTrack=1
      oPlayer1.life=oPlayer1.maxLife
      storeStatus(0)
      sceneDelay=0
      sceneProgress=0
    }
  }
  else if global.bossTrack=1
  {
    if !instance_exists(oMaohTheGiant) and sceneProgress=0 //End Boss
    {
      global.gamePaused=true
      awardBossAP(2200)
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
        endBoss()
        scenePChk(336,240,0,0.1,1)
      }
      if sceneDelay>=60
      {
        sceneDelay=0
        sceneProgress+=1
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
      if sceneDelay>=25
      {
        sceneDelay=0
        sceneProgress+=1
      }
    }
    else if sceneProgress=4 and bWaitForInput=false
      msgCreate(0,0,"Jerry","What did I accomplish here? Wouldn't the idea be to drop me right into Sigma's Fortress... which we KNOW he has?!",0,3,oMessageCutscene,1)
    else if sceneProgress=5 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","I don't control where the Gates lead you, but while you were in here, Chao and I did find you a few tidbits of info.",0,3,oMessageCutscene,1)
    else if sceneProgress=6 and bWaitForInput=false
      msgCreate(0,0,"Jerry","Throw it at me then.",0,3,oMessageCutscene,1)
    else if sceneProgress=7 and bWaitForInput=false
      msgCreate(0,0,"Chao","We located said obvious fortress, but it's being shielded by various generators so... you'll know what to do.",0,3,oMessageCutscene,1)
    else if sceneProgress=8 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","We've made a hub for you to choose which generator to go after first.",0,3,oMessageCutscene,1)
    else if sceneProgress=9 and bWaitForInput=false
      msgCreate(0,0,"Jerry","That was to be expected, considering where we are.",0,3,oMessageCutscene,1)
    else if sceneProgress=10 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","When you confront Sigma, we need to see if we can get him to speak about the Virus. I know he's not the one that made it, but I'm willing to bet he knows how it was spread. The Virus has properties similar to Sigma, he has to have been involved.",0,3,oMessageCutscene,1)
    else if sceneProgress=11 and bWaitForInput=false
      msgCreate(0,0,"Jerry","We'll try our best. In the games, he typically spilled the beans all the time. It shouldn't be too hard, I just have to reach him.",0,3,oMessageCutscene,1)
    else if sceneProgress=12 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","Anyway, time to beam you up!",0,3,oMessageCutscene,1)
    else if sceneProgress=13
    {
      sceneDelay+=1
      if sceneDelay=30
      {
        var tempMplay;
        tempMplay=findMusic(403)
        playMusic(tempMplay,0,1)
      }
      else if sceneDelay=215
      {
        playSound(global.snd_MMVictoryShine,0,1,1)
        oPlayer1.sprite_index=sJerryCasted; oPlayer1.image_index=0; oPlayer1.image_speed=0
        tEffect=instance_create(oPlayer1.x+18,oPlayer1.y-33,oEffect)
        tEffect.sprite_index=sMMX_Win; tEffect.image_speed=0.5
        tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
      }
      else if sceneDelay=240
      {
        playSound(global.snd_MMBeamUp,0,1,1)
        oPlayer1.sprite_index=sPlayerDiscombobulate; oPlayer1.image_index=1
      }
      else if sceneDelay=243 {oPlayer1.image_index=0}
      else if sceneDelay>=244
      {
        oPlayer1.y-=16
        if oPlayer1.y<=-16
        {
          sceneDelay=0
          sceneProgress+=1
        }
      }
    }
    else if sceneProgress=14
    {
      sceneDelay+=1
      if sceneDelay>=30
      {
        sceneDelay=0
        sceneProgress+=1
      }
    }
    else if sceneProgress=15
    {
      global.gamePaused=false
      global.currentBoss=""
      global.bossTrack=0
      global.gameProgress=1840
      room_goto(rMega4_Map)
    }
  }
}
else if room=rMega4_StormA //----- [] Explain Enemy Bullet Catchers -----
{
  if gameProgCheck="0"
  {
    if sceneProgress=0
    {
      if oPlayer1.x>=3376 and oPlayer1.y<=240
      {
        msgCreate(0,0,"Jeremy","Ignore the green thing, it simply stops enemy bullets.",0,1,oMessagePerson,0)
        newMessage.fadingTime=95
        sceneProgress+=1
      }
    }
  }
}
else if room=rMega4_StormC //----- [Unskippable] Bit appears and destroys canister bridge -----
{
  if gameProgCheck="1" //Bit talks
  {
    if sceneProgress=0 and oPlayer1.x>=208
    {
      sceneDelay+=1
      if sceneDelay=1 {global.gamePaused=true}
      oPlayer1.y+=4
      if oPlayer1.y>=288
      {
        scenePChk(208,288,0,0.1,1)
        stopPlayer()
        sceneDelay=0
        sceneProgress+=1
      }
    }
    else if sceneProgress=1
    {
      sceneDelay+=1
      if sceneDelay=25
      {
        npcBitA=instance_create(92,288,oMisc)
        npcBitA.sprite_index=sBit_ArmUp; npcBitA.image_speed=0; npcBitA.type=1; npcBitA.image_alpha=0
        npcBitB=instance_create(132,288,oMisc)
        npcBitB.sprite_index=sBit_ArmUp; npcBitB.image_speed=0; npcBitB.type=1; npcBitB.image_alpha=0
      }
      else if sceneDelay>=26 and sceneDelay<=45
      {
        npcBitA.x+=1; npcBitA.image_alpha+=0.05
        npcBitB.x-=1; npcBitB.image_alpha+=0.05
      }
      else if sceneDelay>=70
      {
        with npcBitB {instance_destroy()}
        oPlayer1.image_xscale=-1
        sceneDelay=0
        sceneProgress+=1
      }
    }
    else if sceneProgress=2 and bWaitForInput=false
      msgCreate(0,0,"Bit","You're progressing much too fast, Sigma's preparations are not yet complete.",8,3,oMessageCutscene,1)
    else if sceneProgress=3 and bWaitForInput=false
      msgCreate(0,0,"Jerry","Whatever man.",0,3,oMessageCutscene,1)
    else if sceneProgress=4 and bWaitForInput=false
    {
      showEmote(npcBitA.id,0,-47,sEmEmbarrass)
      msgCreate(0,0,"Bit","It ends here!",8,3,oMessageCutscene,1)
    }
    else if sceneProgress=5
    {
      sceneDelay+=1
      if sceneDelay=5 {npcBitA.image_index=1}
      else if sceneDelay=10 {npcBitA.image_index=2}
      else if sceneDelay=20
      {
        var tEffect;
        tEffect=instance_create(npcBitA.x+18,npcBitA.y-47,oEffect)
        tEffect.sprite_index=sBitBall; tEffect.decay=90
        tEffect.newBlend=-1; tEffect.followID=-1; tEffect.xSpd=0; tEffect.ySpd=0
      }
      else if sceneDelay>=21 and sceneDelay<=60
      {
        var tFFScl,tEffect;
        tFFScl=random(0.15)
        tEffect=instance_create(npcBitA.x+18,npcBitA.y-47,oEffectB)
        tEffect.type=3; tEffect.sprite_index=sEfFirefly; tEffect.newBlend=1
        tEffect.image_alpha=0.6; tEffect.image_xscale=0.15+tFFScl; tEffect.image_yscale=0.15+tFFScl
        tEffect.direction=random(360); tEffect.speed=random(1)+1; tEffect.friction=random(0.03)+0.03
        tEffect.fadeSpd=0.02; tEffect.image_blend=make_color_rgb(225,225,random(60))
        tEffect.AccelX=0; tEffect.AccelY=0; tEffect.followID=-1; tEffect.rotation=0
      }
      else if sceneDelay=61
      {
        with oEffect {instance_destroy()}
        with npcBitA {instance_destroy()}
        gameProgCheck="2"
        var tNewString;
        tNewString=string_delete(global.gameGate4Prog,1,1)
        tNewString=string_insert("2",tNewString,1)
        global.gameGate4Prog=tNewString
        global.gamePaused=false
        sceneDelay=0
        sceneProgress=0
      }
    }
  }
  else if gameProgCheck="2" or gameProgCheck="9" //Bridge breaks
  {
    if sceneProgress=0 and oPlayer1.x>=206
    {
      playSound(global.snd_BombExplode,0,0.92,1)
      instance_create(112,320,oLinkBExplosion)
      sceneProgress+=1
    }
    else if sceneProgress=1
    {
      if oPlayer1.x>=4240
      {
        var enemyCounter,enemyBarrier;
        enemyCounter=instance_create(0,0,oEnemyRemain)
        enemyCounter.enemyCount=2

        enemyBarrier=instance_create(4032,-64,oEnemyBarrier); enemyBarrier.image_yscale=26
        enemyBarrier=instance_create(4416,-64,oEnemyBarrier); enemyBarrier.image_yscale=26
        createEnemy(4096,240,oBallDeVouxMain,2,1,1)
        createEnemy(4368,288,oNotorBanger,2,1,1)
        sceneProgress+=1
      }
    }
    else if sceneProgress=2
    {
      if oEnemyRemain.enemyCount<=0
      {
        with oEnemyRemain
          instance_destroy()
        with oEnemyBarrier
          instance_destroy()
        sceneProgress+=1
      }
    }
  }
}
else if room=rMega4_StormE //----- [Unskippable] Boss Fight: Storm Eagle -----
{
  if gameProgCheck!="9"
  {
    if global.bossTrack=0
    {
      if sceneProgress=0
      {
        sceneDelay+=1
        if sceneDelay=1
        {
          global.gamePaused=true
          stopAllMusic()
        }
        else if sceneDelay>=30
        {
          oPlayer1.sprite_index=sJerryJump
          fadeAlpha-=0.02
          if fadeAlpha<=0
          {
            sceneDelay=0
            sceneProgress+=1
          }
        }
      }
      else if sceneProgress=1
      {
        sceneDelay+=1
        oPlayer1.y+=6
        if oPlayer1.y>=272
        {
          oPlayer1.sprite_index=sJerryIdle
          oPlayer1.y=272
          stopPlayer()
          sceneDelay=0
          sceneProgress+=1
        }
      }
      else if sceneProgress=2
      {
        sceneDelay+=1
        if sceneDelay>=20
        {
          oPlayer1.sprite_index=sJerryWalk; oPlayer1.image_speed=0.5
          sceneDelay=0
          sceneProgress+=1
        }
      }
      else if sceneProgress=3
      {
        sceneDelay+=1
        oPlayer1.x+=6.68
        if oPlayer1.x>=432
        {
          scenePChk(432,272,0,0.1,1)
          stopPlayer()
          sceneDelay=0
          sceneProgress+=1
        }
      }
      else if sceneProgress=4
      {
        sceneDelay+=1
        if sceneDelay=1
        {
          tempMplay=findMusic(402)
          playMusic(tempMplay,0,0)
        }
        else if sceneDelay=30
        {
          boss=instance_create(576,-16,oStormEagle)
          boss.image_xscale=-1; boss.sprite_index=sStormE_Fly
        }
        else if sceneDelay>=31 and sceneDelay<=300
        {
          boss.y+=3
          if boss.y>=272
          {
            boss.sprite_index=sStormE_Idle; boss.image_speed=0; boss.image_index=0
            boss.y=272
            sceneDelay=0
            sceneProgress+=1
          }
        }
      }
      else if sceneProgress=5
      {
        sceneDelay+=1
        if sceneDelay=50 {boss.sprite_index=sStormE_StandFlap}
        else if sceneDelay=58 {boss.image_index=2}
        else if sceneDelay=64 {boss.sprite_index=sStormE_Pose; boss.image_speed=0.2; boss.image_index=0}
        else if sceneDelay>=80
        {
          sceneDelay=0
          sceneProgress+=1
        }
      }
      else if sceneProgress=6 and bWaitForInput=false
        msgCreate(0,0,"S. Eagle","Go no further!",8,3,oMessageCutscene,1)
      else if sceneProgress=7 and bWaitForInput=false
        msgCreate(0,0,"Jerry","Not happening man. We need to destroy the generators that power the shield around Sigma's place.",0,3,oMessageCutscene,1)
      else if sceneProgress=8 and bWaitForInput=false
        msgCreate(0,0,"S. Eagle","My orders are to keep you from Sigma's Fortress while he finishes his preparations. Your task is in direct conflict with this. Therefore I will stop you here.",8,3,oMessageCutscene,1)
      else if sceneProgress=9 and bWaitForInput=false
        msgCreate(0,0,"Jerry","Hey, shouldn't you be one of the good guys?",0,3,oMessageCutscene,1)
      else if sceneProgress=10 and bWaitForInput=false
        msgCreate(0,0,"S. Eagle","What is good and evil is irrelevant to my orders.",8,3,oMessageCutscene,1)
      else if sceneProgress=11 and bWaitForInput=false
        msgCreate(0,0,"Jeremy","I really doubt he can be reasoned with. Besides, his last interpreted data would have him hostile and working with Sigma.",0,3,oMessageCutscene,1)
      else if sceneProgress=12 and bWaitForInput=false
        msgCreate(0,0,"Jerry","Dang, you're right.",0,3,oMessageCutscene,1)
      else if sceneProgress=13
      {
        sceneDelay+=1
        if sceneDelay=30
        {
          showBossHP=instance_create(0,0,oBossLifeDisplay)
          showBossHP.bossID=oStormEagle; showBossHP.type=1; showBossHP.lifeFill=0
        }
        else if sceneDelay>=31 and sceneDelay<=300
        {
          if sceneDelay mod 2=0
          {
            playSound(global.snd_MMLifeBlip,0,1,1)
            showBossHP.healthTrack+=2
          }
          if showBossHP.healthTrack=50 {sceneDelay=500}
        }
        else if sceneDelay>=510
        {
          sceneDelay=0
          sceneProgress+=1
        }
      }
      else if sceneProgress=14
      {
        with showBossHP {instance_destroy()}
        global.gamePaused=false
        boss.sprite_index=sStormE_Idle
        var tBossTitle,tempMplay;
        tBossTitle=instance_create(0,0,oBossNameDisplay)
        tBossTitle.bossName="Storm Eagle"
        tBossTitle.bossTitle="Elite Aeriel Hunter"
        tempMplay=findMusic(810)
        playMusic(tempMplay,0,0)
        boss.activateBoss=1
        global.currentBoss="Storm Eagle"
        global.bossTrack=1
        storeStatus(0)
        sceneDelay=0
        sceneProgress=0
      }
    }
    else if global.bossTrack=1
    {
      if !instance_exists(oStormEagle) and sceneProgress=0 //End Boss
      {
        global.gamePaused=true
        awardBossAP(2300)
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
          scenePChk(432,272,0,0.1,1)
        }
        if sceneDelay>=60
        {
          sceneDelay=0
          sceneProgress+=1
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
        if sceneDelay>=25
        {
          sceneDelay=0
          sceneProgress+=1
        }
      }
      else if sceneProgress=4 and bWaitForInput=false
        msgCreate(0,0,"Jeremy","The generator seems to have been destroyed in the fight.",0,3,oMessageCutscene,1)
      else if sceneProgress=5 and bWaitForInput=false
        msgCreate(0,0,"Jerry","That was my next question. We're done here, right?",0,3,oMessageCutscene,1)
      else if sceneProgress=6 and bWaitForInput=false
        msgCreate(0,0,"Jeremy","Yes, it's time to beam you up.",0,3,oMessageCutscene,1)
      else if sceneProgress=7
      {
        sceneDelay+=1
        if sceneDelay=30
        {
          var tempMplay;
          tempMplay=findMusic(403)
          playMusic(tempMplay,0,1)
        }
        else if sceneDelay=215
        {
          playSound(global.snd_MMVictoryShine,0,1,1)
          oPlayer1.sprite_index=sJerryCasted; oPlayer1.image_index=0; oPlayer1.image_speed=0
          tEffect=instance_create(oPlayer1.x+18,oPlayer1.y-33,oEffect)
          tEffect.sprite_index=sMMX_Win; tEffect.image_speed=0.5
          tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
        }
        else if sceneDelay=240
        {
          playSound(global.snd_MMBeamUp,0,1,1)
          oPlayer1.sprite_index=sPlayerDiscombobulate; oPlayer1.image_index=1
        }
        else if sceneDelay=243 {oPlayer1.image_index=0}
        else if sceneDelay>=244
        {
          oPlayer1.y-=16
          if oPlayer1.y<=-16
          {
            sceneDelay=0
            sceneProgress+=1
          }
        }
      }
      else if sceneProgress=8
      {
        sceneDelay+=1
        if sceneDelay>=30
        {
          sceneDelay=0
          sceneProgress+=1
        }
      }
      else if sceneProgress=9
      {
        global.gamePaused=false
        global.currentBoss=""
        global.bossTrack=0

        gameProgCheck="9"
        var tNewString;
        tNewString=string_delete(global.gameGate4Prog,1,1)
        tNewString=string_insert("9",tNewString,1)
        global.gameGate4Prog=tNewString
        if global.gameProgress=1840 {global.newMapX=1}
        else if global.gameProgress=1843 {global.newMapX=2}
        else if global.gameProgress=1844 {global.newMapX=3}
        room_goto(rMega4_WeaponGet)
      }
    }
  }
}
else if global.gameProgress=1842 and global.tempAction[0]=0 //----- [2] Weapon sequence -----
{
  if sceneProgress=0
  {
    sceneDelay+=1
    if sceneDelay=1
    {
      oPlayer1.sprite_index=sJerryIdle
      global.gamePaused=true
    }
    else if sceneDelay>=20
    {
      sceneDelay=0
      sceneProgress+=1
    }
  }
  else if sceneProgress=1 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Shotgun Ice doesn't make any sense.",0,3,oMessageCutscene,1)
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","What do you mean? It works just as it should.",0,3,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Jerry","It doesn't make sense that that's the weapon I got.",0,3,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Ah, I don't think the Maverick you beat had anything to do with the weapon you got. I believe all they're doing is unlocking the ones that X managed to give to you.",0,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Well then, now I know. It's not very Mega Man like, but I guess that's just how this works in here.",0,3,oMessageCutscene,1)
  else if sceneProgress=6
  {
    sceneDelay=0
    sceneProgress=0
    global.gameProgress+=1
    global.gamePaused=false
  }
}
else if room=rMega4_OstrichB //----- [3] Introduce Motorbike -----
{
  if gameProgCheck="0"
  {
    if sceneProgress=0
    {
      sceneDelay+=1
      if sceneDelay=1 {global.gamePaused=true}
      else if sceneDelay>=20
      {
        sceneDelay=0
        sceneProgress+=1
      }
    }
    else if sceneProgress=1 and bWaitForInput=false
      msgCreate(0,0,"Jerry","Dude, I get to ride that, don't I?",0,3,oMessageCutscene,1)
    else if sceneProgress=2 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","It's fully operational, so why not?",0,3,oMessageCutscene,1)
    else if sceneProgress=3 and bWaitForInput=false
      msgCreate(0,0,"Jerry","You made it work, didn't you?",0,3,oMessageCutscene,1)
    else if sceneProgress=4 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","I 'may' have had a hand in this.",0,3,oMessageCutscene,1)
    else if sceneProgress=5 and bWaitForInput=false
      msgCreate(0,0,"Jerry","Does it have a cannon?",0,3,oMessageCutscene,1)
    else if sceneProgress=6 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","Yes, you'll fire that with [Action A].#Jump is the same as usual.#The bike can boost as well, which is done#by holding [Action C].",0,3,oMessageCutscene,1)
    else if sceneProgress=7 and bWaitForInput=false
      msgCreate(0,0,"Jerry","Best thing ever, Jeremy. Best thing ever!",0,3,oMessageCutscene,1)
    else if sceneProgress=8
    {
      sceneDelay=0
      sceneProgress=0
      gameProgCheck="1"
      var tNewString;
      tNewString=string_delete(global.gameGate4Prog,2,1)
      tNewString=string_insert("1",tNewString,2)
      global.gameGate4Prog=tNewString
      global.gamePaused=false
    }
  }
}
else if room=rMega4_OstrichE //----- [Unskippable] Boss Fight: Overdrive Ostrich -----
{
  if gameProgCheck!="9"
  {
    if global.bossTrack=0
    {
      if sceneProgress=0
      {
        sceneDelay+=1
        if sceneDelay=1
        {
          global.gamePaused=true
          stopAllMusic()
        }
        else if sceneDelay>=30
        {
          oPlayer1.sprite_index=sJerryJump
          fadeAlpha-=0.02
          if fadeAlpha<=0
          {
            sceneDelay=0
            sceneProgress+=1
          }
        }
      }
      else if sceneProgress=1
      {
        sceneDelay+=1
        oPlayer1.y+=6
        if oPlayer1.y>=288
        {
          oPlayer1.sprite_index=sJerryIdle
          oPlayer1.y=288
          stopPlayer()
          sceneDelay=0
          sceneProgress+=1
        }
      }
      else if sceneProgress=2
      {
        sceneDelay+=1
        if sceneDelay=1
        {
          tempMplay=findMusic(402)
          playMusic(tempMplay,0,0)
        }
        else if sceneDelay=30
        {
          boss=instance_create(192,208,oOverdriveOstrich)
          boss.sprite_index=sOOstrich_Run; boss.image_speed=0.3
          boss.image_xscale=0.2; boss.image_yscale=0.2; boss.image_blend=c_black
        }
        else if sceneDelay>=31 and sceneDelay<=300
        {
          if sceneDelay mod 3=0
          {
            var tSkidEffect;
            tSkidEffect=instance_create(boss.x,boss.y,oEffect)
            tSkidEffect.sprite_index=sMMSmokeCloud; tSkidEffect.image_blend=c_black
            tSkidEffect.image_alpha=0.75; tSkidEffect.xSpd=-0.5-random(0.5); tSkidEffect.ySpd=-0.5-random(0.5)
            tSkidEffect.image_xscale=0.25; tSkidEffect.image_yscale=0.25
            tSkidEffect.newBlend=-1; tSkidEffect.followID=-1; tSkidEffect.decay=-100
          }

          boss.x+=4
          if boss.x>=592
          {
            boss.sprite_index=sOOstrich_Jumping; boss.image_speed=0; boss.image_index=0
            yVel=-6
            sceneDelay=0
            sceneProgress+=1
          }
        }
      }
      else if sceneProgress=3
      {
        if boss.x<624 {x+=1}
        if blendCl<255
        {
          blendCl+=5
          boss.image_blend=make_color_rgb(blendCl,blendCl,blendCl)
        }
        if boss.image_xscale<1
        {
          boss.image_xscale+=0.02
          boss.image_yscale+=0.02
        }
        if yVel<8
        {
          yVel+=0.25
          if yVel>0 {boss.sprite_index=sOOstrich_Falling}
        }
        boss.y+=yVel
        if boss.y>=272
        {
          boss.y=272
          boss.image_xscale=-1
          boss.sprite_index=sOOstrich_Idle
          sceneProgress+=1
        }
      }
      else if sceneProgress=4
      {
        sceneDelay+=1
        if sceneDelay=20 {boss.sprite_index=sOOstrich_Ready}
        else if sceneDelay=25 {boss.image_index=1}
        else if sceneDelay>=45
        {
          sceneDelay=0
          sceneProgress+=1
        }
      }
      else if sceneProgress=5 and bWaitForInput=false
        msgCreate(0,0,"O. Ostrich","You're here for the shield generator, correct?",8,3,oMessageCutscene,1)
      else if sceneProgress=6 and bWaitForInput=false
        msgCreate(0,0,"Jerry","Yeah, I need to get into Sigma's Fortress.",0,3,oMessageCutscene,1)
      else if sceneProgress=7 and bWaitForInput=false
        msgCreate(0,0,"O. Ostrich","The generator is my power core.",8,3,oMessageCutscene,1)
      else if sceneProgress=8 and bWaitForInput=false
        msgCreate(0,0,"Jerry","Well that uh... sucks. Can we replace it... your power core I mean?",0,3,oMessageCutscene,1)
      else if sceneProgress=9 and bWaitForInput=false
        msgCreate(0,0,"O. Ostrich","I will serve Sigma to the end, that was never an issue.",8,3,oMessageCutscene,1)
      else if sceneProgress=10 and bWaitForInput=false
        msgCreate(0,0,"Jerry","Great, blind devotion. Well let's do this.",0,3,oMessageCutscene,1)
      else if sceneProgress=11
      {
        sceneDelay+=1
        if sceneDelay=30
        {
          showBossHP=instance_create(0,0,oBossLifeDisplay)
          showBossHP.bossID=oOverdriveOstrich; showBossHP.type=1; showBossHP.lifeFill=0
        }
        else if sceneDelay>=31 and sceneDelay<=300
        {
          if sceneDelay mod 2=0
          {
            playSound(global.snd_MMLifeBlip,0,1,1)
            showBossHP.healthTrack+=2
          }
          if showBossHP.healthTrack=50 {sceneDelay=500}
        }
        else if sceneDelay>=510
        {
          sceneDelay=0
          sceneProgress+=1
        }
      }
      else if sceneProgress=12
      {
        with showBossHP {instance_destroy()}
        global.gamePaused=false
        boss.sprite_index=sOOstrich_Idle
        var tBossTitle,tempMplay;
        tBossTitle=instance_create(0,0,oBossNameDisplay)
        tBossTitle.bossName="Overdrive Ostrich"
        tBossTitle.bossTitle="Swift Runner of the Sandy Plains"
        tempMplay=findMusic(810)
        playMusic(tempMplay,0,0)
        boss.activateBoss=1
        global.currentBoss="Overdrive Ostrich"
        global.bossTrack=1
        storeStatus(0)
        sceneDelay=0
        sceneProgress=0
      }
    }
    else if global.bossTrack=1
    {
      if !instance_exists(oOverdriveOstrich) and sceneProgress=0 //End Boss
      {
        global.gamePaused=true
        awardBossAP(2300)
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
          scenePChk(464,288,0,0.1,1)
        }
        if sceneDelay>=60
        {
          sceneDelay=0
          sceneProgress+=1
        }
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
        if sceneDelay>=25
        {
          sceneDelay=0
          sceneProgress+=1
        }
      }
      else if sceneProgress=4 and bWaitForInput=false
        msgCreate(0,0,"Jeremy","That did the trick, the generator is no longer active.",0,3,oMessageCutscene,1)
      else if sceneProgress=5 and bWaitForInput=false
        msgCreate(0,0,"Jerry","No kidding.",0,3,oMessageCutscene,1)
      else if sceneProgress=6 and bWaitForInput=false
        msgCreate(0,0,"Jeremy","Alrighty, getting you out of there.",0,3,oMessageCutscene,1)
      else if sceneProgress=7
      {
        sceneDelay+=1
        if sceneDelay=30
        {
          var tempMplay;
          tempMplay=findMusic(403)
          playMusic(tempMplay,0,1)
        }
        else if sceneDelay=215
        {
          playSound(global.snd_MMVictoryShine,0,1,1)
          oPlayer1.sprite_index=sJerryCasted; oPlayer1.image_index=0; oPlayer1.image_speed=0
          tEffect=instance_create(oPlayer1.x+18,oPlayer1.y-33,oEffect)
          tEffect.sprite_index=sMMX_Win; tEffect.image_speed=0.5
          tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
        }
        else if sceneDelay=240
        {
          playSound(global.snd_MMBeamUp,0,1,1)
          oPlayer1.sprite_index=sPlayerDiscombobulate; oPlayer1.image_index=1
        }
        else if sceneDelay=243 {oPlayer1.image_index=0}
        else if sceneDelay>=244
        {
          oPlayer1.y-=16
          if oPlayer1.y<=-16
          {
            sceneDelay=0
            sceneProgress+=1
          }
        }
      }
      else if sceneProgress=8
      {
        sceneDelay+=1
        if sceneDelay>=30
        {
          sceneDelay=0
          sceneProgress+=1
        }
      }
      else if sceneProgress=9
      {
        global.gamePaused=false
        global.currentBoss=""
        global.bossTrack=0

        gameProgCheck="9"
        var tNewString;
        tNewString=string_delete(global.gameGate4Prog,2,1)
        tNewString=string_insert("9",tNewString,2)
        global.gameGate4Prog=tNewString
        if global.gameProgress=1840 {global.newMapX=1}
        else if global.gameProgress=1843 {global.newMapX=2}
        else if global.gameProgress=1844 {global.newMapX=3}
        room_goto(rMega4_WeaponGet)
      }
    }
  }
}
else if room=rMega4_ToxicJungleE //----- [Unskippable] Boss Fight: Gravity Beetle -----
{
  if gameProgCheck!="9"
  {
    if global.bossTrack=0
    {
      if sceneProgress=0
      {
        sceneDelay+=1
        if sceneDelay=1
        {
          global.gamePaused=true
          oPlayer1.sprite_index=sJerryIdle
          stopPlayer()
          stopAllMusic()
        }
        else if sceneDelay>=30
        {
          fadeAlpha-=0.02
          if fadeAlpha<=0
          {
            sceneDelay=0
            sceneProgress+=1
          }
        }
      }
      else if sceneProgress=1
      {
        sceneDelay+=1
        if sceneDelay=10
        {
          tempMplay=findMusic(402)
          playMusic(tempMplay,0,0)
        }
        else if sceneDelay=60
        {
          boss=instance_create(336,-8,oGravityBeetle)
          boss.sprite_index=sToxicSeahorsePose; boss.image_xscale=-1; boss.image_speed=0
        }
        else if sceneDelay>=61
        {
          boss.y+=8
          if boss.y>=288
          {
            sceneDelay=0
            sceneProgress+=1
          }
        }
      }
      else if sceneProgress=2
      {
        sceneDelay+=1
        if sceneDelay>=30
        {
          sceneDelay=0
          sceneProgress+=1
        }
      }
      else if sceneProgress=3
      {
        sceneDelay+=1
        if sceneDelay=30
        {
          showBossHP=instance_create(0,0,oBossLifeDisplay)
          showBossHP.bossID=oGravityBeetle; showBossHP.type=1; showBossHP.lifeFill=0
        }
        else if sceneDelay>=31 and sceneDelay<=300
        {
          if sceneDelay mod 2=0
          {
            playSound(global.snd_MMLifeBlip,0,1,1)
            showBossHP.healthTrack+=2
          }
          if showBossHP.healthTrack=50 {sceneDelay=500}
        }
        else if sceneDelay>=530
        {
          sceneDelay=0
          sceneProgress+=1
        }
      }
      else if sceneProgress=4
      {
        sceneDelay+=1
        if sceneDelay>=31
        {
          if newGravEf.image_xscale<1
          {
            newGravEf.image_xscale+=0.05
            newGravEf.image_yscale+=0.05
          }
          if sceneDelay mod 4=0 {newGravEf.image_angle=random(360)}
        }

        if sceneDelay=30
        {
          newGravEf=instance_create(336,208,oMisc)
          newGravEf.sprite_index=sGBeetleGBomb; newGravEf.type=1
          newGravEf.image_xscale=0.1; newGravEf.image_yscale=0.1
        }
        else if sceneDelay=60 {boss.sprite_index=sToxicSeahorseMelt}
        else if sceneDelay=65 {boss.image_index=1}
        else if sceneDelay=70 {boss.image_index=2}
        else if sceneDelay=75 {boss.image_index=3}
        else if sceneDelay=80 {boss.image_index=4}
        else if sceneDelay=85 {boss.image_index=5}
        else if sceneDelay=90 {boss.image_index=6}
        else if sceneDelay=95 {boss.image_index=7}
        else if sceneDelay=100
        {
          boss.visible=0
          with oBossLifeDisplay {instance_destroy()}
        }
        else if sceneDelay>=105
        {
          newGravEf.image_alpha-=0.1
          if newGravEf.image_alpha<=0
          {
            with newGravEf {instance_destroy()}
            sceneDelay=0
            sceneProgress+=1
          }
        }
      }
      else if sceneProgress=5
      {
        sceneDelay+=1
        if sceneDelay>=15 and sceneDelay<=60
        {
          for(i=0;i<3;i+=1)
          {
            var tGroundSmoke;
            tGroundSmoke=instance_create(312+random(48),288+random(64),oEffect)
            tGroundSmoke.sprite_index=sMMSmokeCloud; tGroundSmoke.image_speed=0.3+random(0.45)
            tGroundSmoke.newBlend=-1; tGroundSmoke.followID=-1; tGroundSmoke.decay=-100
            tGroundSmoke.xSpd=0; tGroundSmoke.ySpd=0
          }
        }
        else if sceneDelay=61
        {
          playSound(global.snd_Earthquake,0,1,88200)
          var tFlash;
          tFlash=instance_create(0,0,oScreenFlash)
          tFlash.fadeSpeed=0.2
          boss.sprite_index=sGBeetle_Jump; boss.image_index=0; boss.visible=1; boss.y-=4
          yVel=-8
        }
        else if sceneDelay>=62 and sceneDelay<=299
        {
          boss.y+=yVel
          yVel+=0.25
          if boss.y>=288
          {
            boss.sprite_index=sGBeetle_Idle
            boss.y=288
            sceneDelay=300
          }
        }
        else if sceneDelay>=320
        {
          sceneDelay=0
          sceneProgress+=1
        }
      }
      else if sceneProgress=6 and bWaitForInput=false
        msgCreate(0,0,"Jerry","That's just wrong.",0,3,oMessageCutscene,1)
      else if sceneProgress=7 and bWaitForInput=false
        msgCreate(0,0,"Jeremy","The generator is part of him. His back stabbing ways just give you even more reason to blast him away.",0,3,oMessageCutscene,1)
      else if sceneProgress=8
      {
        sceneDelay+=1
        if sceneDelay=30
        {
          showBossHP=instance_create(0,0,oBossLifeDisplay)
          showBossHP.bossID=oGravityBeetle; showBossHP.type=1; showBossHP.lifeFill=0
        }
        else if sceneDelay>=31 and sceneDelay<=300
        {
          if sceneDelay mod 2=0
          {
            playSound(global.snd_MMLifeBlip,0,1,1)
            showBossHP.healthTrack+=2
          }
          if showBossHP.healthTrack=50 {sceneDelay=500}
        }
        else if sceneDelay>=510
        {
          sceneDelay=0
          sceneProgress+=1
        }
      }
      else if sceneProgress=9
      {
        with showBossHP {instance_destroy()}
        global.gamePaused=false
        boss.sprite_index=sGBeetle_Idle
        var tBossTitle,tempMplay;
        tBossTitle=instance_create(0,0,oBossNameDisplay)
        tBossTitle.bossName="Gravity Beetle"
        tBossTitle.bossTitle="Traitorous Bastard"
        tempMplay=findMusic(810)
        playMusic(tempMplay,0,0)
        boss.activateBoss=1
        global.currentBoss="Gravity Beetle"
        global.bossTrack=1
        storeStatus(0)
        sceneDelay=0
        sceneProgress=0
      }
    }
    else if global.bossTrack=1
    {
      if !instance_exists(oGravityBeetle) and sceneProgress=0 //End Boss
      {
        global.gamePaused=true
        awardBossAP(2300)
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
          scenePChk(240,288,0,0.1,1)
        }
        if sceneDelay>=60
        {
          sceneDelay=0
          sceneProgress+=1
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
        if sceneDelay>=25
        {
          sceneDelay=0
          sceneProgress+=1
        }
      }
      else if sceneProgress=4 and bWaitForInput=false
        msgCreate(0,0,"Jeremy","Good job, the generator is down, time to bring you back to base.",0,3,oMessageCutscene,1)
      else if sceneProgress=5
      {
        sceneDelay+=1
        if sceneDelay=30
        {
          var tempMplay;
          tempMplay=findMusic(403)
          playMusic(tempMplay,0,1)
        }
        else if sceneDelay=215
        {
          playSound(global.snd_MMVictoryShine,0,1,1)
          oPlayer1.sprite_index=sJerryCasted; oPlayer1.image_index=0; oPlayer1.image_speed=0
          tEffect=instance_create(oPlayer1.x+18,oPlayer1.y-33,oEffect)
          tEffect.sprite_index=sMMX_Win; tEffect.image_speed=0.5
          tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
        }
        else if sceneDelay=240
        {
          playSound(global.snd_MMBeamUp,0,1,1)
          oPlayer1.sprite_index=sPlayerDiscombobulate; oPlayer1.image_index=1
        }
        else if sceneDelay=243 {oPlayer1.image_index=0}
        else if sceneDelay>=244
        {
          oPlayer1.y-=16
          if oPlayer1.y<=-16
          {
            sceneDelay=0
            sceneProgress+=1
          }
        }
      }
      else if sceneProgress=6
      {
        sceneDelay+=1
        if sceneDelay>=30
        {
          sceneDelay=0
          sceneProgress+=1
        }
      }
      else if sceneProgress=7
      {
        global.gamePaused=false
        global.currentBoss=""
        global.bossTrack=0

        gameProgCheck="9"
        var tNewString;
        tNewString=string_delete(global.gameGate4Prog,3,1)
        tNewString=string_insert("9",tNewString,3)
        global.gameGate4Prog=tNewString
        if global.gameProgress=1840 {global.newMapX=1}
        else if global.gameProgress=1843 {global.newMapX=2}
        else if global.gameProgress=1844 {global.newMapX=3}
        room_goto(rMega4_WeaponGet)
      }
    }
  }
}
else if room=rMega4_Shop and global.gameProgress=1845 //----- [4] All Mavericks defeated -----
{
  if sceneProgress=0
  {
    sceneDelay+=1
    if sceneDelay=1
    {
      global.gamePaused=true
      oPlayer1.sprite_index=sJerryIdle
      stopPlayer()
      stopAllMusic()
    }
    else if sceneDelay>=30
    {
      fadeAlpha-=0.02
      if fadeAlpha<=0
      {
        sceneDelay=0
        sceneProgress+=1
      }
    }
  }
  else if sceneProgress=1
  {
    sceneDelay+=1
    if sceneDelay>=30
    {
      sceneDelay=0
      sceneProgress+=1
    }
  }
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Now that the generators have been destroyed, what now? You have the location of Sigma's Fortress, right?",0,3,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Yes, I'm updating your map viewer with those details. I'd teleport you straight to Sigma, but I can't view into the fortress itself. I should be able to give you a few teleport spots within it eventually though.",0,3,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Chao","Did you guys catch what Bit and Storm Eagle said?",0,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Eh?",0,3,oMessageCutscene,1)
  else if sceneProgress=6 and bWaitForInput=false
    msgCreate(0,0,"Chao","They said Sigma was preparing something. Any ideas on that?",0,3,oMessageCutscene,1)
  else if sceneProgress=7 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Bleh, not at all, it really could be anything. Jerry, get to him as soon as you can. I want to know what he's done to that Virus. I know he had a hand in this. He just had to.",0,3,oMessageCutscene,1)
  else if sceneProgress=8 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Shooting things and kicking ass is what I do best, so you can count on me.",0,3,oMessageCutscene,1)
  else if sceneProgress=9
  {
    var tempMplay;
    tempMplay=findMusic(405)
    playMusic(tempMplay,0,0)
    sceneDelay=0
    sceneProgress=0
    global.gameProgress=1850
    global.gamePaused=false
  }
}

keyWaitForInput()

if oKeyCodes.kCodePressed[11]=1 and global.gamePaused=true and sceneProgress>=1 //Cutscene skip
{
  if !instance_exists(oPauseMenu)
  {
    if global.gameProgress=1780 and room=rMega4_IntroA //[1]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      sceneDelay=0
      sceneProgress=8
    }
    else if global.gameProgress=1842 and global.tempAction[0]=0 //[2]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      sceneDelay=0
      sceneProgress=6
    }
    else if room=rMega4_OstrichB //[3]
    {
      if gameProgCheck="0"
      {
        bWaitForInput=false
        with oMessageCutscene {instance_destroy()}
        sceneDelay=0
        sceneProgress=8
      }
    }
    else if global.gameProgress=1845 and room=rMega4_Shop //[4]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      sceneDelay=0
      sceneProgress=9
    }
  }
}

//----- Room specific events -----
if room=rMega4_IntroC //Start crush walls
{
  if oPlayer1.y<=2528 and wallCheck=0
  {
    (215040).moveSeq=1
    (215041).moveSeq=1
    (215042).moveSeq=1
    (215043).moveSeq=1
    (215059).moveSeq=1
    wallCheck+=1
  }
  else if oPlayer1.y<=1568 and wallCheck=1
  {
    (215060).moveSeq=1
    (215061).moveSeq=1
    (215062).moveSeq=1
    wallCheck+=1
  }
  else if oPlayer1.y<=848 and wallCheck=2
  {
    (215179).moveSeq=1
    (215180).moveSeq=1
    wallCheck+=1
  }
}
else if room=rMega4_StormB //Wasp Bot fight
{
  if gameProgCheck="0"
  {
    if rmProg=0
    {
      if oPlayer1.x>=1616
      {
        var newEnemy,newBarrier;
        newEnemy=instance_create(1984,208,oWaspBot) newEnemy.bActive=1; newEnemy.yDist=16
        newBarrier=instance_create(1072,-64,oBossBarrier); newBarrier.image_yscale=7.5
        newBarrier=instance_create(2016,-64,oBossBarrier); newBarrier.image_yscale=7.5
        rmProg+=1
      }
    }
    else if rmProg=1
    {
      for(i=0;i<3;i+=1)
      {
        if !instance_exists(cannonSpawn[i])
        {
          cannonTime[i]-=1
          if cannonTime[i]=30
          {
            var tEffect;
            if i=0
            {
              tEffect=instance_create(1456,168,oEffect)
              tEffect.sprite_index=sEfEnemyAppear; tEffect.image_speed=0.33
              tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
            }
            if i=1
            {
              tEffect=instance_create(1872,184,oEffect)
              tEffect.sprite_index=sEfEnemyAppear; tEffect.image_speed=0.33
              tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
            }
            if i=2
            {
              tEffect=instance_create(1456,372,oEffect)
              tEffect.sprite_index=sEfEnemyAppear; tEffect.image_speed=0.33
              tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
            }
          }
          else if cannonTime[i]=0
          {
            if i=0
            {
              cannonSpawn[i]=instance_create(1456,160,oTurnCannon)
              cannonSpawn[i].bFollow=0; cannonSpawn[i].bActive=1; cannonSpawn[i].image_angle=180
              cannonTime[i]=2700
            }
            if i=1
            {
              cannonSpawn[i]=instance_create(1872,176,oTurnCannon)
              cannonSpawn[i].bFollow=0; cannonSpawn[i].bActive=1; cannonSpawn[i].image_angle=180
              cannonTime[i]=2700
            }
            if i=2
            {
              cannonSpawn[i]=instance_create(1456,384,oTurnCannon)
              cannonSpawn[i].bFollow=0; cannonSpawn[i].bActive=1
              cannonTime[i]=2700
            }
          }
        }
      }

      if !instance_exists(oWaspBot)
      {
        with oBossBarrier {instance_destroy()}
        gameProgCheck="1"
        var tNewString;
        tNewString=string_delete(global.gameGate4Prog,1,1)
        tNewString=string_insert("1",tNewString,1)
        global.gameGate4Prog=tNewString
        rmProg+=1
      }
    }
  }
}
else if room=rMega4_ToxicJungleC //----- [Unskippable] Advancing fire wall of doom -----
{
  if oPlayer1.x>=448 and bWallSpawn=0
  {
    oBackgroundFollow.image_blend=make_color_rgb(224,64,32)
    var tFlash,tNewWall;
    tFlash=instance_create(0,0,oScreenFlash)
    tFlash.fadeSpeed=0.2

    tNewWall=instance_create(112,0,oAdvancingDeathWall)
    tNewWall.type=1
    tNewWall.xSpd=2.75
    tNewWall.xThres=16
    bWallSpawn=1
  }
}

//Beam down at the start of stages
if global.tempAction[0]>=1
{
  beamDownProg+=1
  if beamDownProg=1
  {
    viewFix=instance_create(oPlayer1.x,playerSpotY,oMisc)
    viewFix.type=0
    viewFix.sprite_index=sNull
    view_object[0]=viewFix
    oPlayer1.y=-2
    oPlayer1.sprite_index=sPlayerDiscombobulate; oPlayer1.image_speed=0
  }
  else if beamDownProg=30 {readyText=1}
  else if beamDownProg>=31 and beamDownProg<=69 {readyWidth+=1}
  else if beamDownProg>=80 and beamDownProg<=119
  {
    if beamDownProg mod 8=0
    {
      if readyText=0 {readyText=1}
      else {readyText=0}
    }
  }
  else if beamDownProg=120 {readyText=0}
  else if beamDownProg=135 {playSound(global.snd_MMBeamDown,0,1,1)}
  else if beamDownProg>=136 and beamDownProg<=199
  {
    oPlayer1.y+=16
    if oPlayer1.y>=playerSpotY {oPlayer1.y=playerSpotY; oPlayer1.image_index=1; beamDownProg=200}
  }
  else if beamDownProg>=203
  {
    view_object[0]=oPlayer1
    with viewFix {instance_destroy()}
    oPlayer1.sprite_index=sJerryIdle; oPlayer1.image_speed=0.1
    global.tempAction[0]=0
    global.gamePaused=false
  }
}

if global.gamePaused=false
{
  if room=rMega4_ToxicJungleB
  {
    if pickupCheck=0
    {
      if oPlayer1.x>=3008 and oPlayer1.x<=3152 and oPlayer1.y>=176
      {
        var tNewEnemy;
        tNewEnemy=instance_create(3024,192,oCrablaster)
        tNewEnemy=instance_create(2968,272,oDrillWaying); tNewEnemy.drillMax=5
        tNewEnemy=instance_create(3064,272,oDrillWaying); tNewEnemy.drillMax=5
        pickupCheck=1
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

if room=rMega4_Gate
{
  if global.gameProgress=1760
  {
    if drawType=1 //Flashing rainbow effect
    {
      for(i=0;i<4;i+=1)
      {
        colCh[i]+=12
      }
      colS[0]=make_color_rgb(colCh[0],colCh[1],colCh[2])
      colS[1]=make_color_rgb(colCh[1],colCh[2],colCh[3])
      colS[2]=make_color_rgb(colCh[2],colCh[3],colCh[0])
      colS[3]=make_color_rgb(colCh[3],colCh[0],colCh[1])
      draw_sprite_general(npcMMX.sprite_index,npcMMX.image_index,0,0,45,55,npcMMX.x+xOffset,npcMMX.y+yOffset,-1,1,0,colS[0],colS[1],colS[2],colS[3],image_alpha)
    }

    //Tri-Flash effect
    draw_set_alpha(triAlpha)
    draw_set_color(c_white)
    for(i=0;i<triAmt;i+=1)
    {
      draw_triangle(npcMMX.x,npcMMX.y-20,npcMMX.x+lengthdir_x(triDist,(i*120)+triAng+triWidth),npcMMX.y-20+lengthdir_y(triDist,(i*120)+triAng+triWidth),npcMMX.x+lengthdir_x(triDist,(i*120)+triAng-triWidth),npcMMX.y-20+lengthdir_y(triDist,(i*120)+triAng-triWidth),0)
    }

    //Circle
    draw_set_alpha(circleAlpha)
    draw_circle(npcMMX.x,npcMMX.y-20,circleSize,0)
  }
}

if readyText=1 {draw_sprite_part(sMMReadyText,-1,0,0,readyWidth,13,view_xview[0]+221,view_yview[0]+170)}
