#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//global.gateHProg=200
event_inherited()
enemyCount=-1
fadeColor=c_white
fadeAlpha=0

if global.gameProgress=5040
{
  charSwitcher(0)
  animCheck=0
  charYSpd=4
  global.gamePaused=true
  fadeColor=c_black
  fadeAlpha=1
  with oExit {visible=0}
  for(i=0;i<5;i+=1)
  {
    background_hspeed[i]=-10-(i*2)
  }
  oPlayer1.x=240; oPlayer1.y=256; oPlayer1.visible=0; oPlayerIdle.visible=0; oPlayerShieldBubble.visible=0
  shipJerry=instance_create(-32,oPlayer1.y-14,oMisc)
  shipJerry.type=0; shipJerry.sprite_index=sJerryAirDash; shipJerry.image_speed=0.66
  shipClaire=instance_create(-40,oPlayer1.y+14,oMisc)
  shipClaire.type=0; shipClaire.sprite_index=sClaireAirDash; shipClaire.image_speed=0.66
  oPlayer1.x=shipJerry.x; oPlayer1.y=shipJerry.y //Keep player object on Jerry
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gameProgress=5040 and room=rWarshipA //----- [] Intro to CHAOS Warship -----
{
  if sceneProgress=0
  {
    sceneDelay+=1
    if sceneDelay>=20
    {
      fadeAlpha-=0.02
      if fadeAlpha<=0 {sceneDelay=0; sceneProgress+=1}
    }
  }
  else if sceneProgress=1
  {
    sceneDelay+=1
    if sceneDelay>=1 and sceneDelay<=99
    {
      if shipJerry.x<240
      {
        shipJerry.x+=16; shipClaire.x+=16
        oPlayer1.x=shipJerry.x; oPlayer1.y=shipJerry.y //Keep player object on Jerry
      }
      else {sceneDelay=100}
    }
    else if sceneDelay=120
    {
      var tNewChapter;
      tNewChapter=instance_create(0,0,oChapterDisplay)
      tNewChapter.newChapter="Chapter 20#Trust"
    }
    else if sceneDelay=200
    {
      for(i=0;i<5;i+=1)
      {
        background_hspeed[i]=-1-i
      }
    }
    else if sceneDelay>=201
    {
      //Move Jerry and Claire to the right
      if shipJerry.y<416 {shipJerry.x+=12}
      if shipClaire.y<416 {shipClaire.x+=12}
      if animCheck=1 //Move Jerry and Claire down and land
      {
        if charYSpd<8 {charYSpd+=0.5}
        if shipJerry.y<416 {shipJerry.y+=charYSpd}
        else {shipJerry.y=417; shipJerry.sprite_index=sJerryIdle; shipJerry.image_speed=0.1}

        if shipClaire.y<416 {shipClaire.y+=charYSpd}
        else {shipClaire.y=417; shipClaire.sprite_index=sClaireIdle; shipClaire.image_speed=0.1}
      }
      oPlayer1.x=shipJerry.x; oPlayer1.y=shipJerry.y //Keep player object on Jerry

      if shipJerry.x>=800 and animCheck=0 //Start drop
      {
        shipJerry.sprite_index=sJerryJumpForward
        shipClaire.sprite_index=sClaireAirRoll
        animCheck=1
      }
    }
    if sceneDelay>=290 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Made it! Good job everyone.",0,3,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Jerry","That was something.",0,3,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Chao","I've already started scanning the place for ways to bring it down.",0,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Did you find anything?",0,3,oMessageCutscene,1)
  else if sceneProgress=6 and bWaitForInput=false
    msgCreate(0,0,"Chao","There are two major power sources keeping the ship going. Surprisingly all we gotta do is bring those two power sources down.",0,3,oMessageCutscene,1)
  else if sceneProgress=7 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Yeah, but we know those aren't going to be easy to get to and we know who's guarding them.",0,3,oMessageCutscene,1)
  else if sceneProgress=8 and bWaitForInput=false
    msgCreate(0,0,"Chao","Yep, Hex is guarding one, while I'm sure the Warmaster is guarding the other. But who knows, they may have some other bot that we've never seen guarding one of them.",0,3,oMessageCutscene,1)
  else if sceneProgress=9 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Well then, the mission is pretty straight forward. Just get to those power sources and blow them up.",0,3,oMessageCutscene,1)
  else if sceneProgress=10 and bWaitForInput=false
    msgCreate(0,0,"Jerry","What about our escape?",0,3,oMessageCutscene,1)
  else if sceneProgress=11 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Hmm, I can't teleport you guys out of the inside. We're gonna have to make a run for it when the second one goes down.",0,3,oMessageCutscene,1)
  else if sceneProgress=12 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Oh boy, should be fun times.",0,3,oMessageCutscene,1)
  else if sceneProgress=13 and bWaitForInput=false
    msgCreate(0,0,"Chao","First thing you two gotta do is find a way inside. Jeremy and I will see about finding or making an entrance too.",0,3,oMessageCutscene,1)
  else if sceneProgress=14 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Sounds good.",0,3,oMessageCutscene,1)
  else if sceneProgress=15 and bWaitForInput=false
    msgCreate(0,0,"Chao","Good luck you two.",0,3,oMessageCutscene,1)
  else if sceneProgress=16 and bWaitForInput=false
    msgCreate(0,0,"Claire","We'll be fine. We got this.",0,3,oMessageCutscene,1)
  else if sceneProgress=17
  {
    with oExit {visible=1}
    oPlayerIdle.x=shipClaire.x; oPlayerIdle.y=shipClaire.y
    with shipJerry {instance_destroy()}
    with shipClaire {instance_destroy()}
    oPlayer1.visible=1; oPlayerIdle.visible=1; oPlayerShieldBubble.visible=1
    sceneDelay=0; sceneProgress=0
    global.gameProgress=5050
    global.gamePaused=false
  }
}
else if global.gameProgress=5070 and room=rWarshipB //----- [] Fight with Hex enemies and CHAOS enemies -----
{
  if global.gamePaused=false
  {
    if sceneProgress=0
    {
      if oPlayer1.x>=1280 and oPlayer1.x<=1456 and oPlayer1.y<=224
      {
        var enemyBarrier;
        oPlayerIdle.x=1168; oPlayerIdle.y=336
        enemyBarrier=instance_create(1056,32,oEnemyBarrier); enemyBarrier.image_yscale=30
        enemyBarrier=instance_create(1456,32,oEnemyBarrier); enemyBarrier.image_yscale=30
        sceneProgress+=1
      }
    }
    else if sceneProgress=1
    {
      sceneDelay+=1
      if sceneDelay=30 {delaySpawn(1104,208,oBloodTyrant,0,1,1,0.33)}
      else if sceneDelay=50 {delaySpawn(1152,264,oWS_WarPanelTurret,0,1,1,0.66)}
      else if sceneDelay=62 {delaySpawn(1280,264,oWS_WarPanelTurret,0,1,1,0.66)}
      else if sceneDelay=74 {delaySpawn(1408,264,oWS_WarPanelTurret,0,1,1,0.66)}
      else if sceneDelay>=100
      {
        if !instance_exists(oBloodTyrant) {sceneDelay=0; sceneProgress+=1}
        else {sceneDelay=90}
      }
    }
    else if sceneProgress=2
    {
      sceneDelay+=1
      if sceneDelay=30 {delaySpawn(1104,208,oBloodTyrant,0,1,1,0.33)}
      else if sceneDelay=50 {delaySpawn(1520,-16,oCHAOS_Rocketeer,0,1,1,0.66); sceneDelay=180}
      else if sceneDelay=230 {delaySpawn(1328,264,oWS_WarPanelTurret,0,1,1,0.66)}
      else if sceneDelay>=280
      {
        if !instance_exists(oBloodTyrant)
        {
          with oEnemyBarrier {instance_destroy()}
          global.gameProgress=5080
          sceneDelay=0; sceneProgress=0
        }
        else
        {
          if !position_meeting(1328,264,oWS_WarPanelTurret) {sceneDelay=60}
          else {sceneDelay=270}
        }
      }
    }
  }
}
else if global.gameProgress=5080 and room=rWarshipB //----- [] Fight with Warship enemies -----
{
  if global.gamePaused=false
  {
    if sceneProgress=0
    {
      if oPlayer1.x>=3120 and oPlayer1.y>=184
      {
        var enemyCounter,enemyBarrier;
        enemyCounter=instance_create(0,0,oEnemyRemain)
        enemyCounter.enemyCount=5; enemyCounter.visible=0
        enemyBarrier=instance_create(2912,192,oEnemyBarrier); enemyBarrier.image_yscale=18
        enemyBarrier=instance_create(3616,160,oEnemyBarrier); enemyBarrier.image_yscale=20
        sceneProgress+=1
      }
    }
    else if sceneProgress=1
    {
      sceneDelay+=1
      if sceneDelay=30 {delaySpawn(3028,268,oWS_TargetingWarTurret,2,1,1,0.33)}
      else if sceneDelay=50 {delaySpawn(3404,236,oWS_TargetingWarTurret,2,1,1,0.33)}
      else if sceneDelay>=80 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=2
    {
      if oEnemyRemain.enemyCount<=3 {sceneProgress+=1}
    }
    else if sceneProgress=3
    {
      sceneDelay+=1
      if sceneDelay=30 {delaySpawn(3028,268,oWS_TargetingWarTurret,2,1,1,0.33)}
      else if sceneDelay=50 {delaySpawn(3212,300,oWS_TargetingWarTurret,2,1,1,0.33)}
      else if sceneDelay=70 {delaySpawn(3404,236,oWS_TargetingWarTurret,2,1,1,0.33)}
      else if sceneDelay>=100 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=4
    {
      if oEnemyRemain.enemyCount<=0
      {
        with oEnemyBarrier {instance_destroy()}
        global.gameProgress=5090
        sceneDelay=0; sceneProgress=0
      }
    }
  }
}
else if global.gameProgress=5100 and room=rWarshipC //----- [] Fight with Hex enemies and Rocketeer -----
{
  if global.gamePaused=false
  {
    if sceneProgress=0
    {
      if oPlayer1.x>=736
      {
        oPlayerIdle.x=688; oPlayerIdle.y=304
        enemyBarrier=instance_create(416,192,oEnemyBarrier); enemyBarrier.image_yscale=8
        enemyBarrier=instance_create(1040,192,oEnemyBarrier); enemyBarrier.image_yscale=8
        sceneProgress+=1
      }
    }
    else if sceneProgress=1
    {
      sceneDelay+=1
      if sceneDelay=30 {delaySpawn(928,304,oMalignantOoze,0,1,1,0.33)}
      else if sceneDelay=100 {delaySpawn(464,48,oCHAOS_Rocketeer,0,1,1,0.33)}
      else if sceneDelay>=150 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=2
    {
      if !instance_exists(oMalignantOoze)
      {
        with oEnemyBarrier {instance_destroy()}
        global.gameProgress=5110
        sceneDelay=0; sceneProgress=0
      }
    }
  }
}
else if global.gameProgress=5110 and room=rWarshipC //----- [] Clear the two War Panels -----
{
  if global.gamePaused=false
  {
    if !instance_exists(oWS_WarPanelTurret) {global.gameProgress=5120}
  }
}
else if global.gameProgress=5140 and room=rWarshipE //----- [] Something is wrong with Jerry -----
{
  if sceneProgress=0
  {
    if oPlayer1.x>=1016
    {
      global.gamePaused=true
      oPlayer1.y+=4
      if oPlayer1.y>=192
      {
        scenePChk(oPlayer1.x,192,0,0.1,1)
        stopPlayer()
        oPlayer1.sprite_index=sJerrySickFall; oPlayer1.image_speed=0; oPlayer1.image_index=0
        sceneProgress+=1
      }
    }
  }
  else if sceneProgress=1
  {
    sceneDelay+=1
    if sceneDelay=20 {oPlayer1.image_index=1}
    else if sceneDelay=24 {oPlayer1.image_index=2}
    else if sceneDelay=27 {oPlayer1.image_index=3}
    else if sceneDelay>=40 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Whoa, hey Jerry, are you okay?",0,3,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Yeah, I'm fine... I think.",0,3,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Claire","Jerry, what happened?!",0,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Jerry","I just fell over, I'm fine.",0,3,oMessageCutscene,1)
  else if sceneProgress=6 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","You guys don't just fall over. Chao, do you see anything wrong?",0,3,oMessageCutscene,1)
  else if sceneProgress=7 and bWaitForInput=false
    msgCreate(0,0,"Jerry","It's cool you guys, I'm good.",0,3,oMessageCutscene,1)
  else if sceneProgress=8 and bWaitForInput=false
    msgCreate(0,0,"Chao","Nothing strange with Jerry or with the area.",0,3,oMessageCutscene,1)
  else if sceneProgress=9 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Okay, well I'm not convinced. I'll be keeping an eye out for possible invisible traps.",0,3,oMessageCutscene,1)
  else if sceneProgress=10
  {
    sceneDelay=0; sceneProgress=0
    global.gameProgress=5141
    global.gamePaused=false
  }
}
else if global.gameProgress=5141 and room=rWarshipF //----- [] Fight with lots of things plus red flashy thing of death -----
{
  if global.gamePaused=false
  {
    if sceneProgress=0
    {
      if oPlayer1.x>=384
      {
        msgCreate(0,0,"Jeremy","If you see an area turning red, get out of that red zone quickly.",0,2,oMessagePerson,0)
        newMessage.fadingTime=120
        sceneProgress+=1
      }
    }
    else if sceneProgress=1
    {
      if oPlayer1.x>=1232
      {
        if oPlayer1.y<=256 {oPlayerIdle.x=1232; oPlayerIdle.y=448}
        else {oPlayerIdle.x=1232; oPlayerIdle.y=240}
        instance_create(x,y,oWarship_RmEDmgZone)
        enemyBarrier=instance_create(1040,48,oEnemyBarrier); enemyBarrier.image_yscale=12
        enemyBarrier=instance_create(1040,432,oEnemyBarrier); enemyBarrier.image_yscale=1
        enemyBarrier=instance_create(1584,48,oEnemyBarrier); enemyBarrier.image_yscale=6
        enemyBarrier=instance_create(1584,272,oEnemyBarrier); enemyBarrier.image_yscale=5
        sceneProgress+=1
      }
    }
    else if sceneProgress=2
    {
      sceneDelay+=1
      if sceneDelay=15
      {
        delaySpawn(496,32,oCHAOS_Rocketeer,0,1,1,0.33)
        delaySpawn(800,80,oCHAOS_Rocketeer,0,1,1,0.33)
      }
      else if sceneDelay>=80 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=3
    {
      if !instance_exists(oEnemyBase) {sceneProgress+=1}
    }
    else if sceneProgress=4
    {
      sceneDelay+=1
      if sceneDelay=15
      {
        delaySpawn(1376,240,oBloodTyrant,0,1,1,0.33)
        delaySpawn(1264,448,oBloodTyrant,0,1,1,0.33)
      }
      else if sceneDelay=130
      {
        delaySpawn(1536,240,oCHAOS_Robear,0,1,1,0.33)
        delaySpawn(1088,448,oCHAOS_Robear,0,1,1,0.33)
      }
      else if sceneDelay>=180 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=5
    {
      if !instance_exists(oEnemyBase)
      {
        with oWarship_RmEDmgZone {instance_destroy()}
        with oEnemyBarrier {instance_destroy()}
        global.gameProgress=5150
        sceneDelay=0; sceneProgress=0
      }
    }
  }
}
else if global.gameProgress=5150 and room=rWarshipG //----- [] Fight with Rocketeers on Turrets -----
{
  if global.gamePaused=false
  {
    if sceneProgress=0
    {
      if oPlayer1.x>=1360
      {
        oPlayerIdle.x=1536; oPlayerIdle.y=240
        enemyBarrier=instance_create(1040,0,oEnemyBarrier); enemyBarrier.image_yscale=18
        enemyBarrier=instance_create(1696,0,oEnemyBarrier); enemyBarrier.image_yscale=18
        sceneProgress+=1
      }
    }
    else if sceneProgress=1
    {
      sceneDelay+=1
      if sceneDelay=10 {delaySpawn(1600,0,oCHAOS_Rocketeer,0,1,1,0.33)}
      else if sceneDelay>=60 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=2
    {
      if !instance_exists(oCHAOS_Rocketeer) {sceneProgress+=1}
    }
    else if sceneProgress=3
    {
      sceneDelay+=1
      if sceneDelay=10 {delaySpawn(1200,0,oCHAOS_Rocketeer,0,1,1,0.33)}
      else if sceneDelay>=60 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=4
    {
      if !instance_exists(oCHAOS_Rocketeer)
      {
        with oEnemyBarrier {instance_destroy()}
        global.gameProgress=5160
        sceneDelay=0; sceneProgress=0
      }
    }
  }
}
else if room=rWarshipI //----- [] Fight with anger -----
{
  if global.gameProgress=5170
  {
    if global.gamePaused=false
    {
      if sceneProgress=0
      {
        if !instance_exists(oWS_WarPanelTurret)
        {
          with oEnemyBarrier {instance_destroy()}
          sceneProgress+=1
        }
      }
      else if sceneProgress=1
      {
        if oPlayer1.x>=2304
        {
          oPlayerIdle.x=2112; oPlayerIdle.y=256
          var enemyCounter,enemyBarrier;
          enemyCounter=instance_create(0,0,oEnemyRemain)
          enemyCounter.enemyCount=7; enemyCounter.visible=0
          enemyBarrier=instance_create(1984,32,oEnemyBarrier); enemyBarrier.image_yscale=14
          enemyBarrier=instance_create(2416,32,oEnemyBarrier); enemyBarrier.image_yscale=14
          for(i=0;i<14;i+=1)
          {
            instance_create(2000,32+(i*16),oStaticSpike)
            instance_create(2400,32+(i*16),oStaticSpike)
          }
          sceneProgress+=1
        }
      }
      else if sceneProgress=2
      {
        sceneDelay+=1
        if sceneDelay=10 {delaySpawn(2384,-32,oCHAOS_Rocketeer,2,1,1,0.33)}
        else if sceneDelay=30 {delaySpawn(2256,80,oCHAOS_Healer,2,1,1,0.33)}
        else if sceneDelay=80 {delaySpawn(2256,256,oBloodTyrant,2,1,1,0.33)}
        else if sceneDelay>=130 {sceneDelay=0; sceneProgress+=1}
      }
      else if sceneProgress=3
      {
        if oEnemyRemain.enemyCount<=4 {sceneProgress+=1}
      }
      else if sceneProgress=4
      {
        sceneDelay+=1
        if sceneDelay=10
        {
          delaySpawn(2048,256,oZakoSoldier,2,1,1,0.33)
          delaySpawn(2368,256,oZakoSoldier,2,1,1,0.33)
        }
        else if sceneDelay=30 {delaySpawn(2224,32,oCHAOS_Healer,2,1,1,0.33)}
        else if sceneDelay=90
        {
          var tEfCreate;
          tEfCreate=instance_create(2224,256,oEffect)
          tEfCreate.sprite_index=sEfEnemyAppear; tEfCreate.image_speed=0.33
          tEfCreate.newBlend=-1; tEfCreate.followID=-1; tEfCreate.decay=-100; tEfCreate.xSpd=0; tEfCreate.ySpd=0
        }
        else if sceneDelay=120
        {
          createEnemy(2224,256,oCHAOS_ShockUnit,2,1,1)
          newEnemy.newName="Buttface McGee"
        }
        else if sceneDelay=180 {delaySpawn(2224,80,oCHAOS_Sabotage,2,1,1,0.33)}
        else if sceneDelay>=230 {sceneDelay=0; sceneProgress+=1}
      }
      else if sceneProgress=5
      {
        if oEnemyRemain.enemyCount<=0
        {
          with oEnemyBarrier {instance_destroy()}
          with oStaticSpike {instance_destroy()}
          global.gameProgress=5180
          sceneDelay=0; sceneProgress=0
        }
      }
    }
  }
}
else if global.gameProgress=5190 and room=rWarshipK //----- [] Something is wrong with Jerry again -----
{
  if sceneProgress=0
  {
    if oPlayer1.x>=496 and global.activeCharacter=0
    {
      if (oPlayer1.y>=496 and oPlayer1.y<=592) or (oPlayer1.y>=1040 and oPlayer1.y<=1184)
      global.gamePaused=true
      oPlayer1.y+=4
      if oPlayer1.y<640
      {
        if oPlayer1.y>=576
        {
          scenePChk(oPlayer1.x,576,0,0.1,1)
          stopPlayer()
          oPlayer1.sprite_index=sJerrySickFall; oPlayer1.image_speed=0; oPlayer1.image_index=0
          sceneProgress+=1
        }
      }
      else
      {
        if oPlayer1.y>=1168
        {
          scenePChk(oPlayer1.x,1168,0,0.1,1)
          stopPlayer()
          oPlayer1.sprite_index=sJerrySickFall; oPlayer1.image_speed=0; oPlayer1.image_index=0
          sceneProgress+=1
        }
      }
    }
  }
  else if sceneProgress=1
  {
    sceneDelay+=1
    if sceneDelay=20 {oPlayer1.image_index=1}
    else if sceneDelay=24 {oPlayer1.image_index=2}
    else if sceneDelay=27 {oPlayer1.image_index=3}
    else if sceneDelay>=40 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Ah damn, can't move again!",0,3,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","What do you mean again? You mean you couldn't move last time?",0,3,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Yeah, like my body just seizes up and I'm stuck.",0,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Claire","Jerry, stay where you are, I'll come get you.",0,3,oMessageCutscene,1)
  else if sceneProgress=6 and bWaitForInput=false
    msgCreate(0,0,"Jerry","I don't know if that was to be funny or not, but if you're being serious, I wouldn't mind that.",0,3,oMessageCutscene,1)
  else if sceneProgress=7 and bWaitForInput=false
    msgCreate(0,0,"Claire","I wouldn't joke with you on this.",0,3,oMessageCutscene,1)
  else if sceneProgress=8 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","You seeing anything, Chao?",0,3,oMessageCutscene,1)
  else if sceneProgress=9 and bWaitForInput=false
    msgCreate(0,0,"Chao","I do this time. He's afflicted with something that is trying to paralyze him. I just don't know how to remove it.",0,3,oMessageCutscene,1)
  else if sceneProgress=10 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","I don't like this, I can't see it. Claire, get over to Jerry.",0,3,oMessageCutscene,1)
  else if sceneProgress=11 and bWaitForInput=false
    msgCreate(0,0,"Claire","Will do.",0,3,oMessageCutscene,1)
  else if sceneProgress=12 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Actually it's cool you guys, I can move again.",0,3,oMessageCutscene,1)
  else if sceneProgress=13 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","That doesn't sit well with me.",0,3,oMessageCutscene,1)
  else if sceneProgress=14 and bWaitForInput=false
    msgCreate(0,0,"Jerry","No really, it's fine. Trust me, I'll be okay here.",0,3,oMessageCutscene,1)
  else if sceneProgress=15 and bWaitForInput=false
    msgCreate(0,0,"Claire","You're absolutely sure, Jerry?",0,3,oMessageCutscene,1)
  else if sceneProgress=16 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Positive. Let's just get this done.",0,3,oMessageCutscene,1)
  else if sceneProgress=17 and bWaitForInput=false
    msgCreate(0,0,"Claire","I really don't like this. Keep a look out for Jerry for me, Chao.",0,3,oMessageCutscene,1)
  else if sceneProgress=18
  {
    sceneDelay=0; sceneProgress=0
    global.gameProgress=5200
    global.gamePaused=false
  }
}
else if room=rWarshipM and global.gameProgress=5220 //----- [] Fight with CHAOS bots and laser grid room -----
{
  if global.gamePaused=false
  {
    if sceneProgress=0
    {
      if !instance_exists((446612))
      {
        var enemyBarrier;
        enemyBarrier=instance_create(464,192,oEnemyBarrier); enemyBarrier.image_yscale=4
        sceneProgress+=1
      }
    }
    else if sceneProgress=1
    {
      sceneDelay+=1
      if sceneDelay=10 {delaySpawn(560,64,oCHAOS_Rocketeer,0,1,1,0.33)}
      else if sceneDelay=50 {sceneProgress+=1}
    }
    else if sceneProgress=2
    {
      if !instance_exists((446613))
      {
        with oMovingTrapRed {instance_destroy()}
        var tRedTrap;
        tRedTrap=instance_create(480,32,oMovingTrapRed)
        tRedTrap.image_xscale=4.5; tRedTrap.image_angle=270; tRedTrap.shiftTime=0; tRedTrap.shiftMax=236; tRedTrap.moveSpd=4; tRedTrap.bShowLine=0
        tRedTrap=instance_create(480,352,oMovingTrapRed)
        tRedTrap.image_xscale=4.5; tRedTrap.image_angle=270; tRedTrap.shiftTime=0; tRedTrap.shiftMax=236; tRedTrap.moveSpd=4; tRedTrap.bShowLine=0
        tRedTrap=instance_create(1424,192,oMovingTrapRed)
        tRedTrap.image_xscale=4.5; tRedTrap.image_angle=270; tRedTrap.shiftTime=0; tRedTrap.shiftMax=236; tRedTrap.moveSpd=4; tRedTrap.bShowLine=0; tRedTrap.direction=180

        tRedTrap=instance_create(488,32,oMovingTrapRed)
        tRedTrap.image_xscale=4; tRedTrap.shiftTime=0; tRedTrap.shiftMax=185; tRedTrap.moveSpd=2.5; tRedTrap.bShowLine=0; tRedTrap.direction=270
        tRedTrap=instance_create(808,32,oMovingTrapRed)
        tRedTrap.image_xscale=4; tRedTrap.shiftTime=0; tRedTrap.shiftMax=185; tRedTrap.moveSpd=2.5; tRedTrap.bShowLine=0; tRedTrap.direction=270
        tRedTrap=instance_create(1128,32,oMovingTrapRed)
        tRedTrap.image_xscale=4; tRedTrap.shiftTime=0; tRedTrap.shiftMax=185; tRedTrap.moveSpd=2.5; tRedTrap.bShowLine=0; tRedTrap.direction=270
        tRedTrap=instance_create(648,496,oMovingTrapRed)
        tRedTrap.image_xscale=4; tRedTrap.shiftTime=0; tRedTrap.shiftMax=185; tRedTrap.moveSpd=2.5; tRedTrap.bShowLine=0; tRedTrap.direction=90
        tRedTrap=instance_create(968,496,oMovingTrapRed)
        tRedTrap.image_xscale=4; tRedTrap.shiftTime=0; tRedTrap.shiftMax=185; tRedTrap.moveSpd=2.5; tRedTrap.bShowLine=0; tRedTrap.direction=90
        tRedTrap=instance_create(1288,496,oMovingTrapRed)
        tRedTrap.image_xscale=4; tRedTrap.shiftTime=0; tRedTrap.shiftMax=185; tRedTrap.moveSpd=2.5; tRedTrap.bShowLine=0; tRedTrap.direction=90
        sceneProgress+=1
      }
    }
  }
}
else if global.gameProgress=5230 and room=rWarshipN //----- [] Take the lower path first -----
{
  if sceneProgress=0
  {
    sceneDelay+=1
    if sceneDelay=1 {global.gamePaused=true}
    if sceneDelay>=20 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=1 and bWaitForInput=false
    msgCreate(0,0,"Chao","We're nearing the power sources. From here, there are two paths.",0,3,oMessageCutscene,1)
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Take the lower path first.",0,3,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Why is that?",0,3,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Once those power sources both go down, this ship also goes down. If I'm seeing the layout just right, there's a way we can escape from the top path. The lower path is sealed up pretty tight.",0,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Chao","I'm seeing that too. I agree with Jeremy, take the lower path first.",0,3,oMessageCutscene,1)
  else if sceneProgress=6 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Any idea who's guarding each of them?",0,3,oMessageCutscene,1)
  else if sceneProgress=7 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Not at all. Though there's quite a bit of energy coming from the lower path. At least more than the upper one.",0,3,oMessageCutscene,1)
  else if sceneProgress=8 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Oh hey look. There's one of those handy portals up ahead!",0,3,oMessageCutscene,1)
  else if sceneProgress=9 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Yes, you can use that to go back to the entrance we used for the Warship. Those portals are powered by the ship though, so they too go down when the power is taken out.",0,3,oMessageCutscene,1)
  else if sceneProgress=10 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Noted.",0,3,oMessageCutscene,1)
  else if sceneProgress=11 and bWaitForInput=false
    msgCreate(0,0,"Claire","I'm kinda anxious for what might happen.",0,3,oMessageCutscene,1)
  else if sceneProgress=12 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","I am too, but I think we can convince the Warmaster to help us. I'm pretty sure he's at the bottom route considering the energy levels, Hex never gave off that kind of power. Not gonna lie, that guy is crazy strong.",0,3,oMessageCutscene,1)
  else if sceneProgress=13 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Still though, you know Hex always has some weird trick, so if he is somehow down there, watch yourself. I just hope not, I'd like to get the Warmaster's help in dealing with Hex.",0,3,oMessageCutscene,1)
  else if sceneProgress=14 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Only one way to find out.",0,3,oMessageCutscene,1)
  else if sceneProgress=15
  {
    sceneDelay=0; sceneProgress=0
    global.gameProgress=5240
    global.gamePaused=false
  }
}
else if global.gameProgress=5240 and room=rWarshipP //----- [] Hex speaks -----
{
  if sceneProgress>=1
  {
    oPlayer1.runAcc=1.5
    global.hasShoes[2]=1; global.hasShoes[3]=1
  }

  if sceneProgress=0
  {
    if oPlayer1.x>=128
    {
      var tStatic;
      tStatic=instance_create(0,0,oQuickStatic)
      tStatic.staticTime=8
      playSound(global.snd_Static,0,0.9,1)
      var tempMplay;
      tempMplay=findMusic(0)
      playMusic(tempMplay,0,0)
      with (447534) {instance_destroy()}
      xView=240; yView=144
      sceneProgress+=1
    }
  }
  else if sceneProgress=1
  {
    sceneDelay+=1
    if sceneDelay=60
    {
      var tempMplay;
      tempMplay=findMusic(1001)
      playMusic(tempMplay,0,0)
      createScreenText(xView,yView,90,fnt_EnemyName,fa_middle,"Don't think I haven't been watching you.",3,c_white,1,0)
    }
    else if sceneDelay=160 {createScreenText(xView,yView,100,fnt_EnemyName,fa_middle,"You really think you can change the Warmaster's mind?",3,c_white,1,0)}
    else if sceneDelay=270 {createScreenText(xView,yView,130,fnt_EnemyName,fa_middle,"Do you really know what he wants?#Do you even know what I want?",3,c_white,1,0)}
    else if sceneDelay>=410 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=2
  {
    sceneDelay+=1
    if sceneDelay=1
    {
      msgCreate(0,0,"Jeremy","Not exactly, but you've never bothered to truly tell us. What do you want?",0,3,oMessagePerson,0)
      newMessage.fadingTime=120
    }
    else if sceneDelay>=130 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=3
  {
    sceneDelay+=1
    if sceneDelay=1 {createScreenText(xView,yView,100,fnt_EnemyName,fa_middle,"There's nothing at all to declare about my desires.",3,c_white,1,0)}
    else if sceneDelay=110 {createScreenText(xView,yView,100,fnt_EnemyName,fa_middle,"I'm a fabricated existence.#In a world that isn't even real.",3,c_white,1,0)}
    else if sceneDelay=220 {createScreenText(xView,yView,240,fnt_EnemyName,fa_middle,"At its roots, I want nothing at all.#Everything here, all of it.#You, me, your friends. All of this.#Everything is meaningless in the end.#I desire none of this.",3,c_white,1,0)}
    else if sceneDelay>=490 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=4
  {
    sceneDelay+=1
    if sceneDelay=1
    {
      msgCreate(0,0,"Jeremy","That's a lovely speech, Hex. And maybe I'd feel for you, but you're an asshole! Things didn't have to be this way! You made all this happen!",0,3,oMessagePerson,0)
      newMessage.fadingTime=200
    }
    else if sceneDelay>=210 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=5
  {
    sceneDelay+=1
    if sceneDelay=1 {createScreenText(xView,yView,100,fnt_EnemyName,fa_middle,"Oh yes, how did I forget? I do desire one thing.",3,c_white,1,0)}
    else if sceneDelay=110 {createScreenText(xView,yView,130,fnt_EnemyName,fa_middle,"I want to see you suffer, Jeremy.#You are the reason for my meaningless existence.",3,c_white,1,0)}
    else if sceneDelay=250 {createScreenText(xView,yView,120,fnt_EnemyName,fa_middle,"I'm going to force you to watch everything you love,#die and fade away.",3,c_white,1,0)}
    else if sceneDelay=380 {createScreenText(xView,yView,240,fnt_EnemyName,fa_middle,"I will destroy every reason you have to cling to life.#And when I do, I too will fade into nothingness.#I will see to it that you are the last life left.",3,c_white,1,0)}
    else if sceneDelay>=660
    {
      sceneDelay=0; sceneProgress=0
      oPlayer1.runAcc=6.9
      global.hasShoes[2]=2; global.hasShoes[3]=2
      var tStatic;
      tStatic=instance_create(0,0,oQuickStatic)
      tStatic.staticTime=8
      playSound(global.snd_Static,0,0.9,1)
      global.gameProgress=5250
    }
  }
}
else if global.gameProgress=5250 and room=rWarshipQ //----- [] Boss Fight: Hex Final -----
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
          oPlayerIdle.x=272; oPlayerIdle.y=288
          if global.activeCharacter=0 {oPlayerIdle.sprite_index=sClaireIdle}
          else if global.activeCharacter=1 {oPlayerIdle.sprite_index=sJerryIdle}
          sceneProgress+=1
        }
      }
    }
    else if sceneProgress=1
    {
      sceneDelay+=1
      if sceneDelay=10
      {
        var tCamera;
        tCamera=instance_create(oPlayer1.x,round(oPlayer1.y),oGameCamera); tCamera.type=0
      }
      else if sceneDelay>=11 and sceneDelay<=999
      {
        oGameCamera.x+=1
        if oGameCamera.x>=448 {oGameCamera.x=448; sceneDelay=1000}
      }
      else if sceneDelay=1020 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=1 and bWaitForInput=false
      msgCreate(0,0,"Hex","Were you expecting someone else?",0,3,oMessageCutscene,1)
    else if sceneProgress=2 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","You're not gonna send the Warmaster in?",0,3,oMessageCutscene,1)
    else if sceneProgress=3 and bWaitForInput=false
      msgCreate(0,0,"Hex","You are too predictable, Jeremy. If you think I'm going to allow you to speak to him, you'd be dead wrong.",0,3,oMessageCutscene,1)
    else if sceneProgress=4 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","You scared he'll turn against you?",0,3,oMessageCutscene,1)
    else if sceneProgress=5 and bWaitForInput=false
      msgCreate(0,0,"Hex","He would, given the chance, but not yet. And he'll never side with you.",0,3,oMessageCutscene,1)
    else if sceneProgress=6 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","You do know he led us out of the Subconscious Filter, don't you? He could have left us behind there.",0,3,oMessageCutscene,1)
    else if sceneProgress=7 and bWaitForInput=false
      msgCreate(0,0,"Hex","I'm very aware of his actions in that place. I don't fully understand him myself, but I know him better than you. Besides, this gives me the opportunity to see you in agony as you watch your friends die.",0,3,oMessageCutscene,1)
    else if sceneProgress=8 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","I'm about tired of you.",0,3,oMessageCutscene,1)
    else if sceneProgress=9 and bWaitForInput=false
      msgCreate(0,0,"Hex","We're just getting started here. Did you enjoy the poison, Jerry? Did you really think those two bubbles really fixed you up fully? It seemed a bit too easy didn't it?",0,3,oMessageCutscene,1)
    else if sceneProgress=10 and bWaitForInput=false
      msgCreate(0,0,"Jerry","Screw you. We'll fix it.",0,3,oMessageCutscene,1)
    else if sceneProgress=11 and bWaitForInput=false
      msgCreate(0,0,"Hex","That's your only retort? Bah, I'm bored now.",0,3,oMessageCutscene,1)
    else if sceneProgress=12 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","I'm with Jerry, screw you! Let's get him out of the way you guys. We have a ship to bring down!",0,3,oMessageCutscene,1)

    if global.gateHProg=200 //If player has defeated the Abomination
    {
      if sceneProgress=13 and bWaitForInput=false
      {
        var tStatic;
        tStatic=instance_create(0,0,oQuickStatic)
        tStatic.staticTime=8
        playSound(global.snd_Static,0,0.9,1)
        msgCreate(0,0,"Hex","I was wondering when we would start... Oh... oh I see now. You figured out my plan with the Abomination. That's why it took you so long to get here.",0,3,oMessageCutscene,1)
      }
      else if sceneProgress=14 and bWaitForInput=false
        msgCreate(0,0,"Jeremy","I knew something was up with that thing, but it was actually my sister who figured out most of it.",0,3,oMessageCutscene,1)
      else if sceneProgress=15 and bWaitForInput=false
        msgCreate(0,0,"Hex","Really now? ... Come to think of it, I never got to figure you out, Chao.",0,3,oMessageCutscene,1)
      else if sceneProgress=16 and bWaitForInput=false
        msgCreate(0,0,"Jeremy","You're not to talk to her!",0,3,oMessageCutscene,1)
      else if sceneProgress=17 and bWaitForInput=false
        msgCreate(0,0,"Hex","It's rude to speak for someone else, Jeremy. Besides, we were well aquainted in the Vault.",0,3,oMessageCutscene,1)
      else if sceneProgress=18 and bWaitForInput=false
        msgCreate(0,0,"Chao","I don't want to talk to you.",0,3,oMessageCutscene,1)
      else if sceneProgress=19 and bWaitForInput=false
        msgCreate(0,0,"Hex","It doesn't matter. None of this matters. I don't need the Abomination anyway. While you were out there, it did allow me to prepare something much more special anyway. I think you'll like it.",0,3,oMessageCutscene,1)
      else if sceneProgress=20 and bWaitForInput=false
        msgCreate(0,0,"Jeremy","I don't want to hear anything else from you. Let's get rid of him, you guys.",0,3,oMessageCutscene,1)
      else if sceneProgress=21 and bWaitForInput=false
        msgCreate(0,0,"Jerry","Hell yes! You pumped, Claire?",0,3,oMessageCutscene,1)
      else if sceneProgress=22 and bWaitForInput=false
        msgCreate(0,0,"Claire","As much as I'll ever be.",0,3,oMessageCutscene,1)
      else if sceneProgress=23 {sceneProgress=50}
    }
    else //If player has not beaten the Abomination
    {
      if sceneProgress=13 and bWaitForInput=false
        msgCreate(0,0,"Hex","I was wondering when we would start.",0,3,oMessageCutscene,1)
      else if sceneProgress=14 {sceneProgress=50}
    }

    if sceneProgress=50 //Start fight
    {
      sceneDelay+=1
      if sceneDelay=15
      {
        if global.gateHProg=200
        {
          var tempMplay;
          tempMplay=findMusic(0)
          playMusic(tempMplay,0,0)
        }
      }
      else if sceneDelay>=45 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=51
    {
      if !instance_exists(oGameCamera) {tCamera=instance_create(448,304,oGameCamera); tCamera.type=0}
      else {oGameCamera.x=448; oGameCamera.y=304}
      stopAllMusic()
      global.gamePaused=false
      var tBossTitle,tempMplay,enemyBarrier;
      tBossTitle=instance_create(0,0,oBossNameDisplay)
      tBossTitle.bossName="Hex"
      tBossTitle.bossTitle="... ... ..."
      enemyBarrier=instance_create(192,192,oEnemyBarrier); enemyBarrier.image_yscale=4
      enemyBarrier=instance_create(688,176,oEnemyBarrier); enemyBarrier.image_yscale=4
      if global.gateHProg=200
      {
        tempMplay=findMusic(830)
        playMusic(tempMplay,0,0)
        boss=instance_create(448,160,oHex_Final_Main)
      }
      else
      {
        tempMplay=findMusic(807)
        playMusic(tempMplay,0,0)
        boss=instance_create(448,160,oHex_Final_BadEnd)
      }
      boss.activateBoss=1
      global.currentBoss="Hex Final"
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
      stopPlayer()
      global.bossTrack=2
      sceneProgress=0
    }
  }
  else if global.bossTrack=2
  {
    if sceneProgress=0
    {
      view_object[0]=oPlayer1
      with oEnemyBarrier {instance_destroy()}
      global.gamePaused=false
      global.currentBoss=""
      global.bossTrack=0
      global.gameProgress=5260
    }
  }
}
else if global.gameProgress=5260 and room=rWarshipQ //----- [] Got to first power source -----
{
  if sceneProgress=0
  {
    if oPlayer1.x>=1248
    {
      if sceneDelay=0
      {
        var tempMplay;
        tempMplay=findMusic(0)
        playMusic(tempMplay,0,0)
        sceneDelay=1
      }
      global.gamePaused=true
      oPlayer1.y+=4
      if oPlayer1.y>=288
      {
        scenePChk(1248,288,0,0.1,1)
        stopPlayer()
        oPlayerIdle.x=1216; oPlayerIdle.y=288
        if global.activeCharacter=0 {oPlayerIdle.sprite_index=sClaireIdle}
        else if global.activeCharacter=1 {oPlayerIdle.sprite_index=sJerryIdle}
        sceneDelay=0; sceneProgress+=1
      }
    }
  }
  else if sceneProgress=1
  {
    sceneDelay+=1
    if sceneDelay>=30 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=1 and bWaitForInput=false
    msgCreate(0,0,"Jerry","What do we do to destroy this thing? We don't have our abilities back.",0,3,oMessageCutscene,1)
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Now that you're here, I can set the source to self-destruct. We'll do the same for the other one when we get there.",0,3,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Wait a minute. If you can do that, then you could blow both of them at the same time, right?",0,3,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Yeah, that's the idea.",0,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Jerry","But then, can't you destroy them both when we've left the ship?",0,3,oMessageCutscene,1)
  else if sceneProgress=6 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","That's the idea. I hadn't thought of it that way until you guys were battling Hex. So... yeah, you guys will be well out of harm's way when we blow this thing.",0,3,oMessageCutscene,1)
  else if sceneProgress=7 and bWaitForInput=false
    msgCreate(0,0,"Jerry","That makes things better. And with Hex gone, things should go smoothly.",0,3,oMessageCutscene,1)
  else if sceneProgress=8 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","There is a problem though and I don't know how to fix it. Your abilities haven't returned. I figured they would have come back afterwards.",0,3,oMessageCutscene,1)
  else if sceneProgress=9 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Do we press on to the second one still, or do you have another plan?",0,3,oMessageCutscene,1)
  else if sceneProgress=10 and bWaitForInput=false
    msgCreate(0,0,"Claire","I say we keep going. We're not backing out of this when we're this close to ending it.",0,3,oMessageCutscene,1)
  else if sceneProgress=11 and bWaitForInput=false
    msgCreate(0,0,"Jerry","I'm with that idea. No abilities hasn't really stopped us before.",0,3,oMessageCutscene,1)
  else if sceneProgress=12 and bWaitForInput=false
    msgCreate(0,0,"Chao","Technically it did.",0,3,oMessageCutscene,1)
  else if sceneProgress=13 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Shhh, that doesn't count. And ah, what's that computer doing there?",0,3,oMessageCutscene,1)
  else if sceneProgress=14 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","It controls everything about the power source. From that console, you can shut it down or even expand its power. Basically overloads it, causing it to explode, think super nova style.",0,3,oMessageCutscene,1)
  else if sceneProgress=15 and bWaitForInput=false
    msgCreate(0,0,"Jerry","That sounds bad, your self-destruct dealybob doesn't do that, does it?",0,3,oMessageCutscene,1)
  else if sceneProgress=16 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Nah, nothing like that. Mine makes them go boom, as opposed to the BOOM that overloading them would cause. Hex was thorough, I'm sure that was one of his plans.",0,3,oMessageCutscene,1)
  else if sceneProgress=17 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Don't have to deal with that anymore at least.",0,3,oMessageCutscene,1)
  else if sceneProgress=18 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Well, the self-destruct function is set. Lets head for the upper route.",0,3,oMessageCutscene,1)
  else if sceneProgress=19
  {
    sceneDelay=0; sceneProgress=0
    global.gameProgress=5270
    global.gamePaused=false
  }
}
else if global.gameProgress=5270 and room=rWarshipN //----- [] About your abilities -----
{
  if sceneProgress=0
  {
    if oPlayer1.x<=704
    {
      global.gamePaused=true
      oPlayer1.y+=4
      if oPlayer1.y>=1120
      {
        scenePChk(704,1120,0,0.1,-1)
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
    msgCreate(0,0,"Jeremy","About your abilities...#They haven't returned.",0,3,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Jerry","But how about now though, we clearly have them here.",0,3,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","In this area and any area prior to this, your abilities will work. Basically for gameplay reasons and backtracking if you wanted.",0,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Jerry","The 4th wall is non-existent, but we understand.",0,3,oMessageCutscene,1)
  else if sceneProgress=6
  {
    sceneDelay=0; sceneProgress=0
    global.gameProgress=5280
    global.gamePaused=false
  }
}
else if global.gameProgress=5280 and room=rWarshipZ_A //----- [] The final stretch -----
{
  if sceneProgress=0
  {
    sceneDelay+=1
    if sceneDelay=1 {global.gamePaused=true}
    else if sceneDelay>=20 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=1 and bWaitForInput=false
    msgCreate(0,0,"Claire","This is it, isn't it? The final stretch.",0,3,oMessageCutscene,1)
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","It is and we know who is down these halls.",0,3,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Any chance that we won't have to go toe to toe with him?",0,3,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Maybe, but let's not cling to the idea that we won't.",0,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Jerry","For sure, so what are we up against in here?",0,3,oMessageCutscene,1)
  else if sceneProgress=6 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Not sure, Hex had blocked some of my functions to see into this place. Like your abilities, a lot of those are still gone.",0,3,oMessageCutscene,1)
  else if sceneProgress=7 and bWaitForInput=false
    msgCreate(0,0,"Chao","I've got limited sight here too, not sure why.",0,3,oMessageCutscene,1)
  else if sceneProgress=8 and bWaitForInput=false
    msgCreate(0,0,"Claire","Power through it, Jerry?",0,3,oMessageCutscene,1)
  else if sceneProgress=9 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Power through it!",0,3,oMessageCutscene,1)
  else if sceneProgress=10 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","A note about that... everything here has like 14 base power, so watch yourself.",0,3,oMessageCutscene,1)
  else if sceneProgress=11
  {
    sceneDelay=0; sceneProgress=0
    global.gameProgress=5290
    global.gamePaused=false
  }
}
else if global.gameProgress=5290 and room=rWarshipZ_C //----- [] Fight with Guardians -----
{
  if global.gamePaused=false
  {
    if sceneProgress=0
    {
      if oPlayer1.x>=304
      {
        var enemyCounter,enemyBarrier;
        enemyCounter=instance_create(0,0,oEnemyRemain)
        enemyCounter.enemyCount=5; enemyCounter.visible=0
        enemyBarrier=instance_create(240,32,oEnemyBarrier); enemyBarrier.image_yscale=10
        enemyBarrier=instance_create(576,160,oEnemyBarrier); enemyBarrier.image_yscale=4
        delaySpawn(352,256,oWS_TheGuardian,2,1,1,0.33)
        delaySpawn(544,256,oWS_TheGuardian,2,1,1,0.33)
        sceneProgress+=1
      }
    }
    else if sceneProgress=1
    {
      if oEnemyRemain.enemyCount<=3
      {
        delaySpawn(416,320,oWS_TheGuardian,2,1,1,0.33)
        delaySpawn(480,192,oWS_TheGuardian,2,1,1,0.33)
        sceneProgress+=1
      }
    }
    else if sceneProgress=2
    {
      if oEnemyRemain.enemyCount<=1
      {
        delaySpawn(416,192,oWS_TheGuardian,2,1,1,0.33)
        sceneProgress+=1
      }
    }
    else if sceneProgress=3
    {
      if oEnemyRemain.enemyCount<=0
      {
        with oEnemyBarrier {instance_destroy()}
        global.gameProgress=5300
        sceneDelay=0; sceneProgress=0
      }
    }
  }
}
else if global.gameProgress=5305 and room=rWarshipZ_E2 //----- [Final Boss Fight] The Warmaster -----
{
  if global.bossTrack=0
  {
    if sceneProgress=0
    {
      if oPlayer1.x>=288
      {
        global.gamePaused=true
        oPlayer1.y+=4
        if oPlayer1.y>=304
        {
          scenePChk(288,304,0,0.1,1)
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
        var tCamera;
        tCamera=instance_create(oPlayer1.x,round(oPlayer1.y),oGameCamera); tCamera.type=0
      }
      else if sceneDelay>=11
      {
        oGameCamera.x+=2
        if oGameCamera.x>=368 {oGameCamera.x=368; sceneDelay=0; sceneProgress+=1}
      }
    }
    else if sceneProgress=2
    {
      sceneDelay+=1
      if sceneDelay=30
      {
        musVolC=global.optMusic*100
        musFileP=findMusic(1016)
      }
      else if sceneDelay>=31 and sceneDelay<=499
      {
        if musVolC>=7500 {musVolC-=50}
        else {musVolC-=400}
        SS_SetSoundVol(musFileP,musVolC)
        if musVolC<=1500
        {
          stopAllMusic()
          sceneDelay=500
        }
      }
      else if sceneDelay=520
      {
        var tempMplay;
        tempMplay=findMusic(1022)
        playMusic(tempMplay,0,0)
      }
      else if sceneDelay>=550 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=3 and bWaitForInput=false
      msgCreate(0,0,"Warmaster","You actually prevailed over Hex.",6,3,oMessageCutscene,1)
    else if sceneProgress=4 and bWaitForInput=false
      msgCreate(0,0,"Jerry","Surprised?",0,3,oMessageCutscene,1)
    else if sceneProgress=5 and bWaitForInput=false
      msgCreate(0,0,"Warmaster","It doesn't matter anymore. You're here for the second power source, which lies behind me.",6,3,oMessageCutscene,1)
    else if sceneProgress=6 and bWaitForInput=false
      msgCreate(0,0,"Jerry","You going to let us through?",0,3,oMessageCutscene,1)
    else if sceneProgress=7 and bWaitForInput=false
      msgCreate(0,0,"Warmaster","Why should I? With this ship, I have the ability to get anything I want. Removing you and the rest of the humans from this island would be a start.",6,3,oMessageCutscene,1)
    else if sceneProgress=8 and bWaitForInput=false
      msgCreate(0,0,"Claire","We read those logs of yours.",0,3,oMessageCutscene,1)
    else if sceneProgress=9 and bWaitForInput=false
      msgCreate(0,0,"Warmaster","You think that I'll back down from my position now, simply because Hex used CHAOS to get this ship?",6,3,oMessageCutscene,1)
    else if sceneProgress=10 and bWaitForInput=false
      msgCreate(0,0,"Claire","Actually... yes. You know this is wrong, you even stated yourself you don't want to continue.",0,3,oMessageCutscene,1)
    else if sceneProgress=11 and bWaitForInput=false
      msgCreate(0,0,"Warmaster","Giving us a safe place is what I've sought after all this time. Removing you humans is a way to do that.",6,3,oMessageCutscene,1)
    else if sceneProgress=12 and bWaitForInput=false
      msgCreate(0,0,"Claire","But you don't actually think it's the right way to go about it, do you?",0,3,oMessageCutscene,1)
    else if sceneProgress=13 and bWaitForInput=false
      msgCreate(0,0,"Warmaster","Don't pretend you understand me! You too are willing to go to extremes to save your friends.",6,3,oMessageCutscene,1)
    else if sceneProgress=14 and bWaitForInput=false
      msgCreate(0,0,"Jerry","Yeah...",0,3,oMessageCutscene,1)
    else if sceneProgress=15 and bWaitForInput=false
      msgCreate(0,0,"Warmaster","How many bots did you cut down without a second thought? How many to get here?",6,3,oMessageCutscene,1)
    else if sceneProgress=16 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","...",0,3,oMessageCutscene,1)
    else if sceneProgress=17 and bWaitForInput=false
      msgCreate(0,0,"Warmaster","They're just bots, is what you're thinking I'm sure.",6,3,oMessageCutscene,1)
    else if sceneProgress=18 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","Did we ever have alternatives here?",0,3,oMessageCutscene,1)
    else if sceneProgress=19 and bWaitForInput=false
      msgCreate(0,0,"Warmaster","Do I have one now? What happens if this ship goes down? What happens to those I want to keep safe?",6,3,oMessageCutscene,1)
    else if sceneProgress=20 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","What do we do then? I'll ask all of you.",0,3,oMessageCutscene,1)
    else if sceneProgress=21 and bWaitForInput=false
      msgCreate(0,0,"Jerry","If we let him keep this ship, we know what he'll use it for.",0,3,oMessageCutscene,1)
    else if sceneProgress=22 and bWaitForInput=false
      msgCreate(0,0,"Claire","It's obvious what we should do, then. He doesn't seem like that bad of a guy, but we can't stand by while he has this.",0,3,oMessageCutscene,1)
    else if sceneProgress=23 and bWaitForInput=false
      msgCreate(0,0,"Warmaster","What do you think you can do without any of your abilities? They're all locked away.",6,3,oMessageCutscene,1)
    else if sceneProgress=24 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","That's not entirely true. They can still access them temporarily.",0,3,oMessageCutscene,1)
    else if sceneProgress=25 and bWaitForInput=false
      msgCreate(0,0,"Jerry","Oh what? How so, Jeremy?",0,3,oMessageCutscene,1)
    else if sceneProgress=26 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","We've only got one shot at this... Kirby.",0,3,oMessageCutscene,1)
    else if sceneProgress=27 and bWaitForInput=false
      msgCreate(0,0,"Jerry","Eh?",0,3,oMessageCutscene,1)
    else if sceneProgress=28 and bWaitForInput=false
      msgCreate(0,0,"Chao","Jeremy. You used Kirby's copy ability to store their abilities?",0,3,oMessageCutscene,1)
    else if sceneProgress=29 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","Yes, and like that, this can only be temporary. I'll grant them to you now.",0,3,oMessageCutscene,1)
    else if sceneProgress=30 and bWaitForInput=false
      msgCreate(0,0,"Warmaster","It changes nothing. I'm sure you've heard that I've never been beaten.",6,3,oMessageCutscene,1)
    else if sceneProgress=31 and bWaitForInput=false
      msgCreate(0,0,"Jerry","We've... kinda sorta never been beaten... okay we have. But that's not stopped us till now. And the program makes sure that there are no impossible scenarios.",0,3,oMessageCutscene,1)
    else if sceneProgress=32 and bWaitForInput=false
      msgCreate(0,0,"Warmaster","You misunderstand what that means by the program being unable to create impossible scenarios. For one, we are outside of that rule, and the rule does not apply to giving YOU no impossible scenarios.",6,3,oMessageCutscene,1)
    else if sceneProgress=33 and bWaitForInput=false
      msgCreate(0,0,"Jerry","I thought it was for players... I guess humans like us.",0,3,oMessageCutscene,1)
    else if sceneProgress=34 and bWaitForInput=false
      msgCreate(0,0,"Warmaster","You're not that special. It means the program always finds a way to keep itself running. That is all. It will always present a scenario that benefits itself. It's simply up to you... us, to figure out the solution. Victory is not guaranteed, it never was.",6,3,oMessageCutscene,1)
    else if sceneProgress=35 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","And Hex was going against that programming.",0,3,oMessageCutscene,1)
    else if sceneProgress=36 and bWaitForInput=false
      msgCreate(0,0,"Chao","Why did you help us in the Subconscious Filter?",0,3,oMessageCutscene,1)
    else if sceneProgress=37 and bWaitForInput=false
      msgCreate(0,0,"Warmaster","It was my goal, with Hex's help, to use this ship to drive away all the humans from this place. If they refused to leave, I would have the power to force them out. However, Hex had other ideas for this ship.",6,3,oMessageCutscene,1)
    else if sceneProgress=38 and bWaitForInput=false
      msgCreate(0,0,"Warmaster","It was already too late for me to stop him and I didn't have the power to do it myself. At the time, I no longer had control of my own forces. Even if I did, I'm not able to access those Gates.",6,3,oMessageCutscene,1)
    else if sceneProgress=39 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","Why would you need access to the Gates?",0,3,oMessageCutscene,1)
    else if sceneProgress=40 and bWaitForInput=false
      msgCreate(0,0,"Warmaster","Hex's idea was to merge that creature with the Warship. That creature already couldn't be stopped by normal means. With the firepower that consuming this ship would give it, and Hex's direction, this world would be doomed.",6,3,oMessageCutscene,1)
    else if sceneProgress=41 and bWaitForInput=false
      msgCreate(0,0,"Warmaster","I knew that you had access to the Gates. The program foresaw a problem, a function that was luckily still active, and allowed you a way to counter the creature. It showed you those Gates.",6,3,oMessageCutscene,1)
    else if sceneProgress=42 and bWaitForInput=false
      msgCreate(0,0,"Warmaster","But don't make the mistake in thinking we are allies. You've fulfilled all that you need to do here. I'll offer you a choice. You can turn around now, or you can die here.",6,3,oMessageCutscene,1)
    else if sceneProgress=43 and bWaitForInput=false
      msgCreate(0,0,"Jerry","Screw that! Super bot or not, we're getting through you to that power source to shut this down.",0,3,oMessageCutscene,1)
    else if sceneProgress=44 and bWaitForInput=false
      msgCreate(0,0,"Claire","That's right, we're not backing down!",0,3,oMessageCutscene,1)
    else if sceneProgress=45 and bWaitForInput=false
      msgCreate(0,0,"Warmaster","Don't waste any more time then. I've been curious to see what you can do, personally.",6,3,oMessageCutscene,1)
    else if sceneProgress=46
    {
      sceneDelay+=1
      if sceneDelay=30
      {
        musVolC=global.optMusic*100
        musFileP=findMusic(1022)
      }
      else if sceneDelay>=31 and sceneDelay<=499
      {
        if musVolC>=7500 {musVolC-=50}
        else {musVolC-=400}
        SS_SetSoundVol(musFileP,musVolC)
        if musVolC<=1500
        {
          stopAllMusic()
          sceneDelay=500
        }
      }
      else if sceneDelay=520
      {
        var tempMplay;
        tempMplay=findMusic(829)
        playMusic(tempMplay,0,0)
      }
      else if sceneDelay=540
      {
        var tMyTitleCard;
        tMyTitleCard=instance_create(368,128,oWarmasterTitlecard); tMyTitleCard.type=0
        tMyTitleCard.image_xscale=2; tMyTitleCard.image_yscale=2; tMyTitleCard.image_alpha=0
      }
      else if sceneDelay>=640 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=47
    {
      abilSetRemove(0)
      with oNPC_GeneralC {instance_destroy()}
      global.gamePaused=false
      var tCamera,tBossTitle;
      tCamera=instance_create(368,304,oGameCamera); tCamera.type=0
      instance_create(128,240,oWarshipFinalDoor)
      boss=instance_create(448,304,oCHAOS_Warmaster_Main)
      boss.activateBoss=1
      global.currentBoss="Warmaster"
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
        warmasterEnd=instance_create(432,304,oMisc)
        warmasterEnd.type=0; warmasterEnd.sprite_index=sWarmasterA_End
        warmasterEnd.image_speed=0.15; warmasterEnd.image_xscale=-1.25; warmasterEnd.image_yscale=1.25
        charSwitcher(0)
        scenePChk(304,304,0,0.1,1)
        oPlayer1.sprite_index=sJerryQuit
        with oCHAOS_Warmaster_Main {instance_destroy()}
        with oAttackBase {instance_destroy()}
        sceneProgress+=1
      }
    }
    else if sceneProgress=3
    {
      sceneDelay+=1
      if sceneDelay=50
      {
        view_object[0]=oPlayer1
        with oGameCamera {instance_destroy()}
      }
      else if sceneDelay>=51 and sceneDelay<=60  {fadeAlpha-=0.1}
      else if sceneDelay>=80 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=4 and bWaitForInput=false
      msgCreate(0,0,"Warmaster","Incredible...",6,3,oMessageCutscene,1)
    else if sceneProgress=5 and bWaitForInput=false
    {
      oPlayer1.sprite_index=sJerryIdle
      msgCreate(0,0,"Jerry","That's all you've got to say?",0,3,oMessageCutscene,1)
    }
    else if sceneProgress=6 and bWaitForInput=false
      msgCreate(0,0,"Warmaster","There's nothing left to say. You got what you wanted.",6,3,oMessageCutscene,1)
    else if sceneProgress=7 and bWaitForInput=false
      msgCreate(0,0,"Jerry","We just want this ship out of the sky.",0,3,oMessageCutscene,1)
    else if sceneProgress=8 and bWaitForInput=false
      msgCreate(0,0,"Warmaster","And you will succeed. Go forward and claim your reward for everything you've done. You've certainly earned it.",6,3,oMessageCutscene,1)
    else if sceneProgress=9 and bWaitForInput=false
      msgCreate(0,0,"Jerry","You're not being very genuine.",0,3,oMessageCutscene,1)
    else if sceneProgress=10 and bWaitForInput=false
      msgCreate(0,0,"Warmaster","You're an idiot if you think that.",6,3,oMessageCutscene,1)
    else if sceneProgress=11 and bWaitForInput=false
      msgCreate(0,0,"Jerry","Yeah, I'm not too smart most of the time.",0,3,oMessageCutscene,1)
    else if sceneProgress=12
    {
      sceneDelay+=1
      if sceneDelay=1
      {
        msgCreate(0,0,"Warmaster","There's only one thing beyond this door. Go forth gamers, see what you've earned.",6,3,oMessagePerson,0)
        newMessage.fadingTime=150
      }
      else if sceneDelay=120
      {
        playSound(global.snd_FadeAway,0,0.92,1)
        var tFFScl,tEffect;
        for(i=0;i<24;i+=1)
        {
          tFFScl=random(0.1)
          tEffect=instance_create(oMisc.x-random_range(-12,12),oMisc.y-random(48),oEffectB)
          tEffect.type=3; tEffect.sprite_index=sEfFirefly; tEffect.newBlend=1
          tEffect.image_alpha=0.3; tEffect.image_xscale=0.15+tFFScl; tEffect.image_yscale=0.15+tFFScl
          tEffect.direction=random_range(70,110); tEffect.speed=random(1)+1; tEffect.friction=random(0.02)+0.02
          tEffect.fadeSpd=0.005; tEffect.image_blend=make_color_rgb(random(50),random(50),255)
          tEffect.AccelX=0; tEffect.AccelY=0; tEffect.followID=-1; tEffect.rotation=0
        }
      }
      else if sceneDelay>=121 and sceneDelay<=140 {oMisc.image_alpha-=0.05}
      else if sceneDelay=141 {with oMisc {instance_destroy()}}
      else if sceneDelay>=200 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=13 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","Let's continue.",0,3,oMessageCutscene,1)
    else if sceneProgress=14 and bWaitForInput=false
      msgCreate(0,0,"Jerry","Yeah...",0,3,oMessageCutscene,1)
    else if sceneProgress=15
    {
      oPlayer1.life=oPlayer1.maxLife
      global.pLife=global.pMaxLife
      abilSetRemove(1)
      global.hasShoes[0]=2; global.hasShoes[1]=2
      global.canCharSwap=2; global.canDoubleJump=2
      global.hasAbilToken[0]=2
      sceneDelay=0; sceneProgress=0
      global.gameProgress=5310
      global.currentBoss=""
      global.bossTrack=0
      global.gamePaused=false
    }
  }
}
else if global.gameProgress=5310 and room=rWarshipZ_E2 //----- [] This door -----
{
  if sceneProgress=0
  {
    if oPlayer1.x>=512
    {
      global.gamePaused=true
      oPlayer1.y+=4
      if oPlayer1.y>=304
      {
        scenePChk(512,304,0,0.1,1)
        stopPlayer()
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
    msgCreate(0,0,"Jerry","Hey, what's up with this door?",0,3,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Just another defense against any intruders.",0,3,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Jerry","We lost our abilities after that fight, so... what now?",0,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","We've... well, we've got one other thing.",0,3,oMessageCutscene,1)
  else if sceneProgress=6 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Care to share? Are we able to use those towers in here or that RPG ability?",0,3,oMessageCutscene,1)
  else if sceneProgress=7 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","No, Hex took those away too. We have another though...",0,3,oMessageCutscene,1)
  else if sceneProgress=8 and bWaitForInput=false
    msgCreate(0,0,"Claire","Well?!",0,3,oMessageCutscene,1)
  else if sceneProgress=9 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","I can come in and use that mech I have.",0,3,oMessageCutscene,1)
  else if sceneProgress=10 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Oooh, so your weapons would blow this door away then?",0,3,oMessageCutscene,1)
  else if sceneProgress=11 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Yep!",0,3,oMessageCutscene,1)
  else if sceneProgress=12 and bWaitForInput=false
    msgCreate(0,0,"Chao","Wait a minute though. If you do that, you won't be able to return to where you are. It's a one way path now.",0,3,oMessageCutscene,1)
  else if sceneProgress=13 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","I know, but we have to do something. Those power sources will eventually overload and when they do... well, there goes the entire Mainland.",0,3,oMessageCutscene,1)
  else if sceneProgress=14 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","And a quick note. You can still leave this area if you need to do something, but my mech and abilities here, like your abilities, are...",0,3,oMessageCutscene,1)
  else if sceneProgress=15 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Yeah we know, gameplay and 4th wall. No true 'points of no return' and all that, whatever, just do what you're going to do.",0,3,oMessageCutscene,1)
  else if sceneProgress=16 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Okay you guys, I'm coming in!",0,3,oMessageCutscene,1)
  else if sceneProgress=17
  {
    sceneDelay+=1
    if sceneDelay=30
    {
      var tEffect;
      for(i=0;i<16;i+=1)
      {
        tEffect=instance_create(oPlayer1.x+random_range(-12,12),oPlayer1.y-random(52),oEffect)
        tEffect.sprite_index=sDustCloud; tEffect.followID=-1; tEffect.xFollow=0; tEffect.yFollow=0
        tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0; tEffect.image_alpha=0.9
        tEffect.image_xscale=1.25; tEffect.image_yscale=1.25
      }
    }
    else if sceneDelay=31
    {
      global.activeCharacter=2
      oPlayer1.sprite_index=sJeremyMechIdle
      oPlayer1.runAcc=4.5; oPlayer1.initialJumpAcc=-7; oPlayer1.jumpTimeTotal=60; oPlayer1.frictionDuckingX=0.5
      global.canCharSwap=1; global.canDoubleJump=1; global.hasAbilToken[0]=1
    }
    else if sceneDelay>=70 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=18 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","There we go!",0,3,oMessageCutscene,1)
  else if sceneProgress=19 and bWaitForInput=false
    msgCreate(0,0,"Jerry","No cool sound effects or anything?",0,3,oMessageCutscene,1)
  else if sceneProgress=20 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Hey man, it doesn't have to be a spectacular entrance.",0,3,oMessageCutscene,1)
  else if sceneProgress=21 and bWaitForInput=false
    msgCreate(0,0,"Jerry","I just wanted something more awesome... So what do we do now?",0,3,oMessageCutscene,1)
  else if sceneProgress=22 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","The thing that I had to do this whole time, but reverse... watch me do awesome things.",0,3,oMessageCutscene,1)
  else if sceneProgress=23 and bWaitForInput=false
    msgCreate(0,0,"Jerry","That'll work.",0,3,oMessageCutscene,1)
  else if sceneProgress=24 and bWaitForInput=false
    msgCreate(0,0,"Chao","Careful Jeremy.",0,3,oMessageCutscene,1)
  else if sceneProgress=25 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","I know sis. Everything will be fine. I can still do what I need to do to the power sources from here, I just need to be right next to them.",0,3,oMessageCutscene,1)
  else if sceneProgress=26
  {
    sceneDelay=0; sceneProgress=0
    global.gameProgress=5320
    global.gamePaused=false
  }
}
else if global.gameProgress=5330 and room=rWarshipZ_I //----- [] Final Warning -----
{
  if sceneProgress=0
  {
    if oPlayer1.x>=112
    {
      global.gamePaused=true
      oPlayer1.y+=4
      if oPlayer1.y>=208
      {
        scenePChk(112,208,0,0.1,1)
        stopPlayer()
        oPlayer1.sprite_index=sJeremyMechIdle
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
    msgCreate(0,0,"Jeremy","If there's anything we need to do, we can use that portal there to go back. After this, there's no turning back.",0,3,oMessageCutscene,1)
  else if sceneProgress=3
  {
    sceneDelay=0; sceneProgress=0
    global.gameProgress=5340
    global.gamePaused=false
  }
}
else if global.gameProgress=5340 and room=rWarshipZ_I //----- [] The last power source... -----
{
  if sceneProgress=0
  {
    if oPlayer1.x>=640
    {
      global.gamePaused=true
      oPlayer1.y+=4
      if oPlayer1.y>=256
      {
        scenePChk(640,256,0,0.1,1)
        stopPlayer()
        oPlayer1.sprite_index=sJeremyMechIdle
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
    msgCreate(0,0,"Jeremy","Here it is. When I set this one to shut off, it's all over.",0,3,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Chao","Do it, Jeremy. Lets end it!",0,3,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Okay, here we go.",0,3,oMessageCutscene,1)
  else if sceneProgress=5
  {
    sceneDelay+=1
    if sceneDelay>=30
    {
      global.optShowScore=0
      global.optShowHUD=0
      oPlayer1.life=oPlayer1.maxLife
      global.pLife=global.pMaxLife
      global.newMapX=1568; global.newMapY=256
      room_goto(rWarshipZ_EscapeA)
    }
  }
}

keyWaitForInput()
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
