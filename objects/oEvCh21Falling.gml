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
lockCharacterY=-1

if global.gameProgress=5500 {fadeAlpha=1}
else if global.gameProgress>=5520
{
  tile_layer_hide(1000000)
  with oInvisibleSolid {instance_destroy()}
  lockCharacterY=112
}

metSpd=3
metDir=90
setLocation=0
metSpawnY=room_height+40
metOffsetY=0

metAlternateA=0
metAlternateB=0
metAlternateC=0

skyRingOffset=0
skyRingAmt=0

cloudBlend=255

//Checkpoints
if global.newMapX=241
{
  background_visible[5]=1
  sceneProgress=6
}
else if global.newMapX=242
{
  background_visible[5]=1
  sceneProgress=9
}
else if global.newMapX=243
{
  background_visible[5]=1
  sceneProgress=11
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gameProgress=5500 and room=rCh21_WarshipSkies //----- [1] Chapter 21 -----
{
  if sceneProgress=0
  {
    sceneDelay+=1
    if sceneDelay=2
    {
      fadeAlpha=0
      sceneDelay=0; sceneProgress+=1
    }
  }
  else if sceneProgress=1
  {
    sceneDelay+=1
    if sceneDelay=40
    {
      var tCheckAchieve;
      tCheckAchieve=string_char_at(global.tokenRecognitionsSetTwo,7)
      if tCheckAchieve="0"
      {
        var tAchievement;
        tAchievement=instance_create(0,0,oAchievementNoticeSS)
        tAchievement.myAchievement="Saved Game"; tAchievement.checkNum=7
      }
    }
    else if sceneDelay=210
    {
      msgCreate(0,0,"Claire","Chao... what's happening? This isn't the boom that Jeremy mentioned.",0,1,oMessagePerson,0)
      newMessage.fadingTime=100
    }
    else if sceneDelay=310
    {
      msgCreate(0,0,"Chao","I don't know, but I'm not going to leave you this time.",0,1,oMessagePerson,0)
      newMessage.fadingTime=90
    }
    else if sceneDelay=430 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=2 //Display chapter title
  {
    sceneDelay+=1
    if sceneDelay=1
    {
      var tNewChapter;
      tNewChapter=instance_create(0,0,oChapterDisplay)
      tNewChapter.newChapter="Chapter 21#Distorted Travesty"
    }
    else if sceneDelay=210 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=3
  {
    sceneDelay+=1
    if sceneDelay=10
    {
      playSound(global.snd_Static,0,1,1)
      playSound(global.snd_CShotA,0,1,1)
      tile_layer_hide(1000000)
      with oInvisibleSolid {instance_destroy()}
      lockCharacterY=112
      fadeAlpha=1
    }
    else if sceneDelay>=11 and sceneDelay<=15 {fadeAlpha-=0.2}
    else if sceneDelay>=16
    {
      sceneDelay=0; sceneProgress=0
      global.canPause=1
      global.gameProgress=5510
    }
  }
}
else if global.gameProgress=5510 //----- [] What happened -----
{
  if global.gamePaused=0
  {
    if sceneProgress=0
    {
      sceneDelay+=1
      if sceneDelay=60
      {
        msgCreate(0,0,"Claire","NOW WHAT'S HAPPENING?!",0,1,oMessagePerson,0)
        newMessage.fadingTime=60
      }
      else if sceneDelay=120
      {
        msgCreate(0,0,"Chao","I... don't know?",0,1,oMessagePerson,0)
        newMessage.fadingTime=60
      }
      else if sceneDelay=180
      {
        msgCreate(0,0,"Claire","What happened to the Warship. It just disappeared!",0,1,oMessagePerson,0)
        newMessage.fadingTime=90
      }
      else if sceneDelay=270
      {
        msgCreate(0,0,"Chao","It still exists, it just teleported, at least I think it teleported?",0,1,oMessagePerson,0)
        newMessage.fadingTime=110
      }
      else if sceneDelay=380
      {
        msgCreate(0,0,"Claire","Okay, with that out of the way... I'm still falling!",0,1,oMessagePerson,0)
        newMessage.fadingTime=90
      }
      else if sceneDelay=470
      {
        msgCreate(0,0,"Chao","You don't take falling damage?",0,1,oMessagePerson,0)
        newMessage.fadingTime=80
      }
      else if sceneDelay=550
      {
        msgCreate(0,0,"Claire","Right... Okay then where am I? Am I still in the same place as before?",0,1,oMessagePerson,0)
        newMessage.fadingTime=120
      }
      else if sceneDelay=670
      {
        msgCreate(0,0,"Chao","You're in the same place as before, it's just the ship that moved... or something. I don't know!",0,2,oMessagePerson,0)
        newMessage.fadingTime=140
      }
      else if sceneDelay=810
      {
        msgCreate(0,0,"Chao","Okay, before we go into anything else. Look out, Claire, you're gonna need to dodge things.",0,2,oMessagePerson,0)
        newMessage.fadingTime=140
      }
      else if sceneDelay=950
      {
        global.optShowScore=1
        global.optShowHUD=1
      }
      else if sceneDelay=1000
      {
        msgCreate(0,0,"Claire","Wait, my abilities are back... ALL OF THEM!",0,1,oMessagePerson,0)
        newMessage.fadingTime=90
      }
      else if sceneDelay>=1090
      {
        var tempMplay;
        tempMplay=findMusic(1025)
        playMusic(tempMplay,0,0)
        sceneDelay=0; sceneProgress=0
        global.canPause=1
        global.bCanSave=1
        global.gameProgress=5520
      }
    }
  }
}
else if global.gameProgress=5520 //Falling minigame
{
  if global.gamePaused=0
  {
    if sceneProgress=0 //28 seconds
    {
      sceneDelay+=1
      if sceneDelay=30
      {
        newMet=instance_create(16,metSpawnY,oSkyfallMeteor); newMet.bBlue=0; newMet.moveSpd=3; newMet.direction=90
        newMet=instance_create(208,metSpawnY,oSkyfallMeteor); newMet.bBlue=0; newMet.moveSpd=3; newMet.direction=90
        newMet=instance_create(272,metSpawnY,oSkyfallMeteor); newMet.bBlue=0; newMet.moveSpd=3; newMet.direction=90
        newMet=instance_create(464,metSpawnY,oSkyfallMeteor); newMet.bBlue=0; newMet.moveSpd=3; newMet.direction=90
      }
      else if sceneDelay=110 {setLocation=2; event_user(0)}
      else if sceneDelay=190 {setLocation=3; event_user(0)}
      else if sceneDelay=270 {setLocation=0; event_user(0)}
      else if sceneDelay=350
      {
        setLocation=2; metSpd=1; event_user(0)
        setLocation=2; metSpd=3; event_user(0)
      }
      else if sceneDelay=440
      {
        setLocation=3; metSpd=1; event_user(0)
        setLocation=3; metSpd=3; event_user(0)
      }
      else if sceneDelay=750 {setLocation=4; event_user(0)}
      else if sceneDelay=790 {newMet=instance_create(16,metSpawnY,oSkyfallMeteor); newMet.bBlue=1; newMet.moveSpd=3; newMet.direction=point_direction(16,metSpawnY,oPlayer1.x,oPlayer1.y-26)}
      else if sceneDelay>=850 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=1 //17 seconds
    {
      sceneDelay+=1
      if sceneDelay=30 {setLocation=0; event_user(0)}
      else if sceneDelay=50 {setLocation=0; event_user(0)}
      else if sceneDelay=70 {setLocation=0; event_user(0)}
      else if sceneDelay=90 {setLocation=0; event_user(0)}
      else if sceneDelay=110 {setLocation=0; event_user(0)}
      else if sceneDelay=170 {metSpd=4; setLocation=6; event_user(0)}
      else if sceneDelay=200 {setLocation=7; event_user(0)}
      else if sceneDelay=230 {setLocation=6; event_user(0)}
      else if sceneDelay=260 {setLocation=7; event_user(0)}
      else if sceneDelay=290 {setLocation=6; event_user(0)}
      else if sceneDelay=320 {setLocation=7; event_user(0); setLocation=8; event_user(0)}
      else if sceneDelay=350 {setLocation=6; event_user(0); setLocation=9; event_user(0)}
      else if sceneDelay=380 {setLocation=7; event_user(0); setLocation=8; event_user(0)}
      else if sceneDelay=395 {setLocation=9; event_user(0)}
      else if sceneDelay=410 {setLocation=6; event_user(0); setLocation=9; event_user(0)}
      else if sceneDelay=425 {setLocation=8; event_user(0)}
      else if sceneDelay=440 {setLocation=7; event_user(0); setLocation=8; event_user(0)}
      else if sceneDelay=455 {setLocation=9; event_user(0)}
      else if sceneDelay=470 {setLocation=6; event_user(0); setLocation=9; event_user(0)}
      else if sceneDelay>=530 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=2 //22 seconds
    {
      sceneDelay+=1
      if sceneDelay=30 {metSpd=3; setLocation=5; event_user(0)}
      else if sceneDelay=130 {setLocation=4; event_user(0)}
      else if sceneDelay=230 {setLocation=5; event_user(0)} //Blues and aimed meteors start
      else if sceneDelay=330 {setLocation=4; event_user(0)}
      else if sceneDelay=430 {setLocation=5; event_user(0)}
      else if sceneDelay=530 {setLocation=4; event_user(0)}
      else if sceneDelay>=670 {sceneDelay=0; sceneProgress+=1}

      if sceneDelay=220 {newMet=instance_create(16,metSpawnY,oSkyfallMeteor); newMet.bBlue=1; newMet.moveSpd=3; newMet.direction=90}
      else if sceneDelay=320 {newMet=instance_create(464,metSpawnY,oSkyfallMeteor); newMet.bBlue=1; newMet.moveSpd=3; newMet.direction=90}
      else if sceneDelay=420 {newMet=instance_create(16,metSpawnY,oSkyfallMeteor); newMet.bBlue=1; newMet.moveSpd=3; newMet.direction=90}
      else if sceneDelay=520 {newMet=instance_create(464,metSpawnY,oSkyfallMeteor); newMet.bBlue=1; newMet.moveSpd=3; newMet.direction=90}

      if sceneDelay>=190 and sceneDelay<=620 and sceneDelay mod 23=0 {newMet=instance_create(240,metSpawnY,oSkyfallMeteor); newMet.bBlue=0; newMet.moveSpd=3; newMet.direction=90}

      if sceneDelay>=190 and sceneDelay<=620 and sceneDelay mod 50=0 {newMet=instance_create(240,metSpawnY,oSkyfallMeteor); newMet.bBlue=0; newMet.moveSpd=6; newMet.direction=point_direction(240,metSpawnY,oPlayer1.x,oPlayer1.y-26)}
    }
    else if sceneProgress=3 //16 seconds
    {
      sceneDelay+=1
      if sceneDelay=30 {metSpd=5; setLocation=10; event_user(0)}
      else if sceneDelay=60 {setLocation=11; event_user(0)}
      else if sceneDelay=90 {setLocation=10; event_user(0)}
      else if sceneDelay=120 {setLocation=11; event_user(0)}
      else if sceneDelay=150 {setLocation=10; event_user(0)}
      else if sceneDelay=180 {setLocation=11; event_user(0)}
      else if sceneDelay=210 {setLocation=10; event_user(0)}
      else if sceneDelay=240 {setLocation=11; event_user(0)}
      else if sceneDelay=280 {setLocation=2; event_user(0)}
      else if sceneDelay=320 {setLocation=3; event_user(0)}
      else if sceneDelay=360 {setLocation=2; event_user(0)}
      else if sceneDelay=400 {setLocation=3; event_user(0)}
      else if sceneDelay>=500 {metAlternateA=0; sceneDelay=0; sceneProgress+=1}

      if sceneDelay>=110 and sceneDelay<=450 and sceneDelay mod 24=0
      {
        if metAlternateA=0
        {
          newMet=instance_create(16,metSpawnY,oSkyfallMeteor); newMet.bBlue=0; newMet.moveSpd=6; newMet.direction=point_direction(16,metSpawnY,oPlayer1.x,oPlayer1.y-26)
          metAlternateA=1
        }
        else if metAlternateA=1
        {
          newMet=instance_create(240,metSpawnY,oSkyfallMeteor); newMet.bBlue=0; newMet.moveSpd=6; newMet.direction=point_direction(240,metSpawnY,oPlayer1.x,oPlayer1.y-26)
          metAlternateA=2
        }
        else if metAlternateA=2
        {
          newMet=instance_create(464,metSpawnY,oSkyfallMeteor); newMet.bBlue=0; newMet.moveSpd=6; newMet.direction=point_direction(464,metSpawnY,oPlayer1.x,oPlayer1.y-26)
          metAlternateA=3
        }
        else if metAlternateA=3
        {
          newMet=instance_create(100,metSpawnY,oSkyfallMeteor); newMet.bBlue=1; newMet.moveSpd=7; newMet.direction=90
          newMet=instance_create(380,metSpawnY,oSkyfallMeteor); newMet.bBlue=1; newMet.moveSpd=7; newMet.direction=90
          metAlternateA=0
        }
      }
    }
    else if sceneProgress=4 //29
    {
      sceneDelay+=1
      if sceneDelay=30 {metSpd=3; setLocation=13; event_user(0)}
      else if sceneDelay=120
      {
        newMet=instance_create(208,metSpawnY,oSkyfallMeteor); newMet.bBlue=0; newMet.moveSpd=3; newMet.direction=90
        newMet=instance_create(272,metSpawnY,oSkyfallMeteor); newMet.bBlue=0; newMet.moveSpd=3; newMet.direction=90
      }
      else if sceneDelay=150
      {
        newMet=instance_create(144,metSpawnY,oSkyfallMeteor); newMet.bBlue=0; newMet.moveSpd=6; newMet.direction=90
        newMet=instance_create(336,metSpawnY,oSkyfallMeteor); newMet.bBlue=0; newMet.moveSpd=6; newMet.direction=90
      }
      else if sceneDelay=220 {metSpd=4; setLocation=14; event_user(0)}
      else if sceneDelay=300 {newMet=instance_create(272,metSpawnY,oSkyfallMeteor); newMet.bBlue=1; newMet.moveSpd=4; newMet.direction=90}
      else if sceneDelay=316 {metSpd=4; setLocation=15; event_user(0)}
      //Start narrower path
      if sceneDelay=410 {newMet=instance_create(208,metSpawnY,oSkyfallMeteor); newMet.bBlue=0; newMet.moveSpd=4; newMet.direction=90}
      else if sceneDelay=445 {newMet=instance_create(272,metSpawnY,oSkyfallMeteor); newMet.bBlue=0; newMet.moveSpd=4; newMet.direction=90}
      else if sceneDelay=480 {newMet=instance_create(208,metSpawnY,oSkyfallMeteor); newMet.bBlue=0; newMet.moveSpd=4; newMet.direction=90}
      else if sceneDelay=515 {newMet=instance_create(272,metSpawnY,oSkyfallMeteor); newMet.bBlue=0; newMet.moveSpd=4; newMet.direction=90}
      else if sceneDelay=560 {newMet=instance_create(208,metSpawnY,oSkyfallMeteor); newMet.bBlue=0; newMet.moveSpd=5; newMet.direction=90}
      else if sceneDelay=580 {newMet=instance_create(272,metSpawnY,oSkyfallMeteor); newMet.bBlue=0; newMet.moveSpd=5; newMet.direction=90}
      else if sceneDelay=600 {newMet=instance_create(208,metSpawnY,oSkyfallMeteor); newMet.bBlue=0; newMet.moveSpd=5; newMet.direction=90}
      else if sceneDelay=620 {newMet=instance_create(272,metSpawnY,oSkyfallMeteor); newMet.bBlue=0; newMet.moveSpd=5; newMet.direction=90}
      else if sceneDelay=650 {newMet=instance_create(208,metSpawnY,oSkyfallMeteor); newMet.bBlue=0; newMet.moveSpd=6; newMet.direction=90}
      else if sceneDelay=665 {newMet=instance_create(272,metSpawnY,oSkyfallMeteor); newMet.bBlue=0; newMet.moveSpd=6; newMet.direction=90}
      else if sceneDelay=680 {newMet=instance_create(208,metSpawnY,oSkyfallMeteor); newMet.bBlue=0; newMet.moveSpd=6; newMet.direction=90}
      else if sceneDelay=695 {newMet=instance_create(272,metSpawnY,oSkyfallMeteor); newMet.bBlue=0; newMet.moveSpd=6; newMet.direction=90}

      if sceneDelay=720 {newMet=instance_create(208,metSpawnY,oSkyfallMeteor); newMet.bBlue=0; newMet.moveSpd=4; newMet.direction=90}
      else if sceneDelay=735 {newMet=instance_create(272,metSpawnY,oSkyfallMeteor); newMet.bBlue=0; newMet.moveSpd=4; newMet.direction=90}
      else if sceneDelay=750 {newMet=instance_create(208,metSpawnY,oSkyfallMeteor); newMet.bBlue=0; newMet.moveSpd=4; newMet.direction=90}
      else if sceneDelay=765 {newMet=instance_create(272,metSpawnY,oSkyfallMeteor); newMet.bBlue=0; newMet.moveSpd=4; newMet.direction=90}
      else if sceneDelay=780 {newMet=instance_create(208,metSpawnY,oSkyfallMeteor); newMet.bBlue=0; newMet.moveSpd=4; newMet.direction=90}
      else if sceneDelay=795 {newMet=instance_create(272,metSpawnY,oSkyfallMeteor); newMet.bBlue=0; newMet.moveSpd=4; newMet.direction=90}
      else if sceneDelay>=870 {sceneDelay=0; sceneProgress+=1}

      if sceneDelay>=50 and sceneDelay<=400 and sceneDelay mod 10=0
      {
        newMet=instance_create(16,metSpawnY,oSkyfallMeteor); newMet.bBlue=0; newMet.moveSpd=6; newMet.direction=90
        newMet=instance_create(80,metSpawnY,oSkyfallMeteor); newMet.bBlue=0; newMet.moveSpd=6; newMet.direction=90
        newMet=instance_create(400,metSpawnY,oSkyfallMeteor); newMet.bBlue=0; newMet.moveSpd=6; newMet.direction=90
        newMet=instance_create(464,metSpawnY,oSkyfallMeteor); newMet.bBlue=0; newMet.moveSpd=6; newMet.direction=90
      }
      else if sceneDelay>=410 and sceneDelay<=840 and sceneDelay mod 10=0
      {
        newMet=instance_create(16,metSpawnY,oSkyfallMeteor); newMet.bBlue=0; newMet.moveSpd=6; newMet.direction=90
        newMet=instance_create(80,metSpawnY,oSkyfallMeteor); newMet.bBlue=0; newMet.moveSpd=6; newMet.direction=90
        newMet=instance_create(144,metSpawnY,oSkyfallMeteor); newMet.bBlue=0; newMet.moveSpd=6; newMet.direction=90
        newMet=instance_create(336,metSpawnY,oSkyfallMeteor); newMet.bBlue=0; newMet.moveSpd=6; newMet.direction=90
        newMet=instance_create(400,metSpawnY,oSkyfallMeteor); newMet.bBlue=0; newMet.moveSpd=6; newMet.direction=90
        newMet=instance_create(464,metSpawnY,oSkyfallMeteor); newMet.bBlue=0; newMet.moveSpd=6; newMet.direction=90
      }
    }
    else if sceneProgress=5 //Checkpoint 1
    {
      sceneDelay+=1
      if sceneDelay=1
      {
        backCloud=instance_create(0,0,oBackgroundFollow)
        backCloud.type=1; backCloud.backSet=backShooterCloudMist; backCloud.xMoveScale=0.6; backCloud.yMoveScale=1
        backCloud.image_xscale=1.38; backCloud.image_yscale=1.38; backCloud.image_alpha=0
        backCloud.depth=1400000; backCloud.xScrollSpeed=-8
      }
      if sceneDelay>=1 and sceneDelay<=20 {backCloud.image_alpha+=0.05}
      else if sceneDelay=21 {background_visible[5]=1; with oWarshipCloudBack {instance_destroy()}}
      else if sceneDelay>=41 and sceneDelay<=60 {backCloud.image_alpha-=0.05}
      else if sceneDelay>=61
      {
        with backCloud {instance_destroy()}
        oPlayer1.life=oPlayer1.maxLife
        global.pLife=global.pMaxLife
        instance_create(0,0,oCheckpointNotice)
        global.newMapX=241
        sceneDelay=0; sceneProgress+=1
      }
    }
    else if sceneProgress=6 //35 seconds
    {
      sceneDelay+=1
      if sceneDelay=1 {metSpd=5; metAlternateC=40}
      else if sceneDelay=200 {metAlternateC=30}
      else if sceneDelay=400 {metAlternateC=25}
      else if sceneDelay=600 {metAlternateC=20}
      else if sceneDelay=800 {metAlternateC=15}
      else if sceneDelay=1070 {sceneDelay=0; sceneProgress+=1}

      if sceneDelay>=50 and sceneDelay<=1000 and sceneDelay mod 60=0 //Alternating red
      {
        if metAlternateA=0
        {
          setLocation=6; event_user(0)
          metAlternateA=1
        }
        else if metAlternateA=1
        {
          setLocation=7; event_user(0)
          metAlternateA=0
        }
      }
      if sceneDelay>=50 and sceneDelay<=1000 and sceneDelay mod 180=0 //Blue line
      {
        newMet=instance_create(16,metSpawnY+160,oSkyfallMeteor); newMet.bBlue=1; newMet.moveSpd=metSpd; newMet.direction=metDir
        newMet=instance_create(80,metSpawnY+160,oSkyfallMeteor); newMet.bBlue=1; newMet.moveSpd=metSpd; newMet.direction=metDir
        newMet=instance_create(144,metSpawnY+160,oSkyfallMeteor); newMet.bBlue=1; newMet.moveSpd=metSpd; newMet.direction=metDir
        newMet=instance_create(208,metSpawnY+160,oSkyfallMeteor); newMet.bBlue=1; newMet.moveSpd=metSpd; newMet.direction=metDir
        newMet=instance_create(272,metSpawnY+160,oSkyfallMeteor); newMet.bBlue=1; newMet.moveSpd=metSpd; newMet.direction=metDir
        newMet=instance_create(336,metSpawnY+160,oSkyfallMeteor); newMet.bBlue=1; newMet.moveSpd=metSpd; newMet.direction=metDir
        newMet=instance_create(400,metSpawnY+160,oSkyfallMeteor); newMet.bBlue=1; newMet.moveSpd=metSpd; newMet.direction=metDir
        newMet=instance_create(464,metSpawnY+160,oSkyfallMeteor); newMet.bBlue=1; newMet.moveSpd=metSpd; newMet.direction=metDir
      }
      if sceneDelay>=50 and sceneDelay<=1000 and sceneDelay mod metAlternateC=0 //Alternating red
      {
        if metAlternateB=0
        {
          newMet=instance_create(16,metSpawnY,oSkyfallMeteor); newMet.bBlue=0; newMet.moveSpd=8; newMet.direction=point_direction(16,metSpawnY,oPlayer1.x,oPlayer1.y-26)
          metAlternateB=1
        }
        else if metAlternateB=1
        {
          newMet=instance_create(240,metSpawnY,oSkyfallMeteor); newMet.bBlue=0; newMet.moveSpd=8; newMet.direction=point_direction(240,metSpawnY,oPlayer1.x,oPlayer1.y-26)
          metAlternateB=2
        }
        else if metAlternateB=2
        {
          newMet=instance_create(464,metSpawnY,oSkyfallMeteor); newMet.bBlue=0; newMet.moveSpd=8; newMet.direction=point_direction(464,metSpawnY,oPlayer1.x,oPlayer1.y-26)
          metAlternateB=0
        }
      }
    }
    else if sceneProgress=7 //39 seconds
    {
      sceneDelay+=1
      if sceneDelay=30
      {
        newMet=instance_create(208,metSpawnY,oSkyfallMeteor); newMet.bBlue=0; newMet.moveSpd=2; newMet.direction=90
        newMet=instance_create(336,metSpawnY+128,oSkyfallMeteor); newMet.bBlue=0; newMet.moveSpd=2; newMet.direction=90
        for(i=0;i<3;i+=1)
        {
          newMet=instance_create(16,metSpawnY,oSkyfallMeteor); newMet.bBlue=1; newMet.moveSpd=3.5+(i*0.5); newMet.direction=32+(i*12)
        }
      }
      else if sceneDelay=190
      {
        newMet=instance_create(144,metSpawnY,oSkyfallMeteor); newMet.bBlue=0; newMet.moveSpd=2; newMet.direction=90
        newMet=instance_create(272,metSpawnY+128,oSkyfallMeteor); newMet.bBlue=0; newMet.moveSpd=2; newMet.direction=90
        for(i=0;i<3;i+=1)
        {
          newMet=instance_create(464,metSpawnY,oSkyfallMeteor); newMet.bBlue=1; newMet.moveSpd=3.5+(i*0.5); newMet.direction=158-(i*12)
        }
      }
      else if sceneDelay=350
      {
        newMet=instance_create(208,metSpawnY+128,oSkyfallMeteor); newMet.bBlue=0; newMet.moveSpd=2; newMet.direction=90
        newMet=instance_create(336,metSpawnY,oSkyfallMeteor); newMet.bBlue=0; newMet.moveSpd=2; newMet.direction=90
        for(i=0;i<3;i+=1)
        {
          newMet=instance_create(16,metSpawnY,oSkyfallMeteor); newMet.bBlue=1; newMet.moveSpd=3.5+(i*0.5); newMet.direction=32+(i*12)
        }
      }
      else if sceneDelay=510
      {
        newMet=instance_create(144,metSpawnY,oSkyfallMeteor); newMet.bBlue=0; newMet.moveSpd=2; newMet.direction=90
        newMet=instance_create(272,metSpawnY+128,oSkyfallMeteor); newMet.bBlue=0; newMet.moveSpd=2; newMet.direction=90
      }
      else if sceneDelay=530
      {
        for(i=0;i<3;i+=1)
        {
          newMet=instance_create(464,metSpawnY,oSkyfallMeteor); newMet.bBlue=1; newMet.moveSpd=1.5+(i*0.5); newMet.direction=158-(i*12)
        }
      }
      else if sceneDelay=670
      {
        newMet=instance_create(208,metSpawnY+128,oSkyfallMeteor); newMet.bBlue=0; newMet.moveSpd=2; newMet.direction=90
        newMet=instance_create(336,metSpawnY,oSkyfallMeteor); newMet.bBlue=0; newMet.moveSpd=2; newMet.direction=90
        for(i=0;i<3;i+=1)
        {
          //newMet=instance_create(16,metSpawnY,oSkyfallMeteor); newMet.bBlue=1; newMet.moveSpd=3.5+(i*0.5); newMet.direction=32+(i*12)
        }
      }
      else if sceneDelay=830
      {
        newMet=instance_create(144,metSpawnY,oSkyfallMeteor); newMet.bBlue=0; newMet.moveSpd=2; newMet.direction=90
        newMet=instance_create(272,metSpawnY+128,oSkyfallMeteor); newMet.bBlue=0; newMet.moveSpd=2; newMet.direction=90
      }
      else if sceneDelay=850
      {
        for(i=0;i<3;i+=1)
        {
          newMet=instance_create(464,metSpawnY,oSkyfallMeteor); newMet.bBlue=1; newMet.moveSpd=3.5+(i*0.5); newMet.direction=158-(i*12)
        }
      }
      else if sceneDelay=1170 {sceneDelay=0; sceneProgress+=1}

      if (sceneDelay=1) or (sceneDelay>=30 and sceneDelay<=1000 and sceneDelay mod 30=0) //Sides
      {
        metSpd=2
        newMet=instance_create(16,metSpawnY,oSkyfallMeteor); newMet.bBlue=0; newMet.moveSpd=2; newMet.direction=90
        newMet=instance_create(80,metSpawnY,oSkyfallMeteor); newMet.bBlue=0; newMet.moveSpd=2; newMet.direction=90
        newMet=instance_create(400,metSpawnY,oSkyfallMeteor); newMet.bBlue=0; newMet.moveSpd=2; newMet.direction=90
        newMet=instance_create(464,metSpawnY,oSkyfallMeteor); newMet.bBlue=0; newMet.moveSpd=2; newMet.direction=90
      }

      if (sceneDelay=1) or (sceneDelay>=20 and sceneDelay<=1000 and sceneDelay mod 160=0) //Mid lines
      {
        if metAlternateA=0
        {
          for(i=0;i<5;i+=1)
          {
            newMet=instance_create(144,metSpawnY+(i*64),oSkyfallMeteor); newMet.bBlue=0; newMet.moveSpd=2; newMet.direction=90
            newMet=instance_create(272,metSpawnY+(i*64),oSkyfallMeteor); newMet.bBlue=0; newMet.moveSpd=2; newMet.direction=90
          }
          metAlternateA=1
        }
        else if metAlternateA=1
        {
          for(i=0;i<5;i+=1)
          {
            newMet=instance_create(208,metSpawnY+(i*64),oSkyfallMeteor); newMet.bBlue=0; newMet.moveSpd=2; newMet.direction=90
            newMet=instance_create(336,metSpawnY+(i*64),oSkyfallMeteor); newMet.bBlue=0; newMet.moveSpd=2; newMet.direction=90
          }
          metAlternateA=0
        }
      }
    }
    else if sceneProgress=8 //Checkpoint 2
    {
      sceneDelay+=1
      if sceneDelay=60
      {
        oPlayer1.life=oPlayer1.maxLife
        global.pLife=global.pMaxLife
        instance_create(0,0,oCheckpointNotice)
        global.newMapX=242
        sceneDelay=0; sceneProgress+=1
      }
    }
    else if sceneProgress=9 //14 seconds
    {
      sceneDelay+=1
      if sceneDelay=35
      {
        msgCreate(0,0,"Claire","Of course!",0,0,oMessagePerson,0)
        newMessage.fadingTime=50
      }
      if sceneDelay=30 //340
      {
        newRing=instance_create(240,metSpawnY+skyRingOffset,oSkyfallRing); newRing.moveSpd=4
        newRing=instance_create(240,metSpawnY+skyRingOffset,oSkyfallRing); newRing.moveSpd=4
        newRing=instance_create(272,metSpawnY+skyRingOffset,oSkyfallRing); newRing.moveSpd=4
        newRing=instance_create(304,metSpawnY+skyRingOffset,oSkyfallRing); newRing.moveSpd=4
        newRing=instance_create(336,metSpawnY+skyRingOffset,oSkyfallRing); newRing.moveSpd=4

        newRing=instance_create(304,metSpawnY+skyRingOffset,oSkyfallRing); newRing.moveSpd=4
        newRing=instance_create(272,metSpawnY+skyRingOffset,oSkyfallRing); newRing.moveSpd=4
        newRing=instance_create(240,metSpawnY+skyRingOffset,oSkyfallRing); newRing.moveSpd=4
        newRing=instance_create(200,metSpawnY+skyRingOffset,oSkyfallRing); newRing.moveSpd=4
        newRing=instance_create(160,metSpawnY+skyRingOffset,oSkyfallRing); newRing.moveSpd=4

        newRing=instance_create(100,metSpawnY+skyRingOffset,oSkyfallRing); newRing.moveSpd=4
        newRing=instance_create(180,metSpawnY+skyRingOffset,oSkyfallRing); newRing.moveSpd=4
        newRing=instance_create(260,metSpawnY+skyRingOffset,oSkyfallRing); newRing.moveSpd=4
        newRing=instance_create(340,metSpawnY+skyRingOffset,oSkyfallRing); newRing.moveSpd=4
        newRing=instance_create(400,metSpawnY+skyRingOffset,oSkyfallRing); newRing.moveSpd=4

        newRing=instance_create(350,metSpawnY+skyRingOffset,oSkyfallRing); newRing.moveSpd=4
        newRing=instance_create(400,metSpawnY+skyRingOffset,oSkyfallRing); newRing.moveSpd=4
        newRing=instance_create(440,metSpawnY+skyRingOffset,oSkyfallRing); newRing.moveSpd=4
        newRing=instance_create(380,metSpawnY+skyRingOffset,oSkyfallRing); newRing.moveSpd=4
        newRing=instance_create(320,metSpawnY+skyRingOffset,oSkyfallRing); newRing.moveSpd=4

        newRing=instance_create(280,metSpawnY+skyRingOffset,oSkyfallRing); newRing.moveSpd=4
        newRing=instance_create(240,metSpawnY+skyRingOffset,oSkyfallRing); newRing.moveSpd=4
        newRing=instance_create(240,metSpawnY+skyRingOffset,oSkyfallRing); newRing.moveSpd=4
      }
      else if sceneDelay=420 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=10 //Checkpoint 3
    {
      sceneDelay+=1
      if sceneDelay=60
      {
        instance_create(0,0,oCheckpointNotice)
        global.newMapX=243
        sceneDelay=0; sceneProgress+=1
      }
    }
    else if sceneProgress=11 //Boss intro
    {
      sceneDelay+=1
      if sceneDelay=30
      {
        musVolC=global.optMusic*100
        musFileP=findMusic(1025)
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
      else if sceneDelay=530
      {
        var tBossTitle,tempMplay;
        tBossTitle=instance_create(0,0,oBossNameDisplay)
        tBossTitle.bossName="CHAOS DeadEye"
        tBossTitle.bossTitle="Really, CHAOS has MORE bots??"
        tempMplay=findMusic(828)
        playMusic(tempMplay,0,0)
      }
      else if sceneDelay>=620
      {
        instance_create(240,room_height+96,oDeadEye_Main)
        sceneDelay=0; sceneProgress+=1
      }

      if sceneDelay>=31 and sceneDelay<=60
      {
        cloudBlend-=2
        background_blend[5]=make_color_rgb(255,cloudBlend,cloudBlend)
      }
    }
    else if sceneProgress=12 //Boss end
    {
      if sceneDelay=1
      {
        var tCheckAchieve;
        tCheckAchieve=string_char_at(global.tokenRecognitionsSetTwo,9)
        if tCheckAchieve="0"
        {
          var tAchievement;
          tAchievement=instance_create(0,0,oAchievementNoticeSS)
          tAchievement.myAchievement="Hardest Encounter"; tAchievement.checkNum=9
        }
        background_blend[5]=c_white
        fadeColor=c_black
        sceneDelay=0; sceneProgress+=1
      }
    }
    else if sceneProgress=13
    {
      sceneDelay+=1
      if sceneDelay=90
      {
        msgCreate(0,0,"Claire","How much farther till we hit the ground?",0,1,oMessagePerson,0)
        newMessage.fadingTime=90
      }
      else if sceneDelay=180
      {
        msgCreate(0,0,"Chao","Well...",0,1,oMessagePerson,0)
        newMessage.fadingTime=60
      }
      else if sceneDelay=240 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=14
    {
      fadeAlpha+=0.04
      if fadeAlpha>=1 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=15
    {
      sceneDelay+=1
      if sceneDelay=20
      {
        stopAllMusic()
        playSound(global.snd_HardHit1,0,1,15000)
      }
      else if sceneDelay>=50
      {
        global.newMapX=608; global.newMapY=288
        room_goto(rCh21_Main_75)
      }
    }
  }
}

if lockCharacterY>0 {oPlayer1.y=lockCharacterY} //Lock character in a set y coordinate

keyWaitForInput()

if oKeyCodes.kCodePressed[11]=1 and global.gamePaused=true and sceneProgress>=1 //Cutscene skip
{
  if !instance_exists(oPauseMenu)
  {
    if global.gameProgress=2590 and room=rMain_42 //[1]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      fadeAlpha=0; sceneDelay=0
      sceneProgress=10
    }
  }
}
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Predefined spawn locations
if setLocation=0 //BBBBBBBB
{
  newMet=instance_create(16,metSpawnY+metOffsetY,oSkyfallMeteor); newMet.bBlue=1; newMet.moveSpd=metSpd; newMet.direction=metDir
  newMet=instance_create(80,metSpawnY+metOffsetY,oSkyfallMeteor); newMet.bBlue=1; newMet.moveSpd=metSpd; newMet.direction=metDir
  newMet=instance_create(144,metSpawnY+metOffsetY,oSkyfallMeteor); newMet.bBlue=1; newMet.moveSpd=metSpd; newMet.direction=metDir
  newMet=instance_create(208,metSpawnY+metOffsetY,oSkyfallMeteor); newMet.bBlue=1; newMet.moveSpd=metSpd; newMet.direction=metDir
  newMet=instance_create(272,metSpawnY+metOffsetY,oSkyfallMeteor); newMet.bBlue=1; newMet.moveSpd=metSpd; newMet.direction=metDir
  newMet=instance_create(336,metSpawnY+metOffsetY,oSkyfallMeteor); newMet.bBlue=1; newMet.moveSpd=metSpd; newMet.direction=metDir
  newMet=instance_create(400,metSpawnY+metOffsetY,oSkyfallMeteor); newMet.bBlue=1; newMet.moveSpd=metSpd; newMet.direction=metDir
  newMet=instance_create(464,metSpawnY+metOffsetY,oSkyfallMeteor); newMet.bBlue=1; newMet.moveSpd=metSpd; newMet.direction=metDir
}
else if setLocation=1 //RBRRRRBR
{
  newMet=instance_create(16,metSpawnY+metOffsetY,oSkyfallMeteor); newMet.bBlue=0; newMet.moveSpd=metSpd; newMet.direction=metDir
  newMet=instance_create(80,metSpawnY+metOffsetY,oSkyfallMeteor); newMet.bBlue=1; newMet.moveSpd=metSpd; newMet.direction=metDir
  newMet=instance_create(144,metSpawnY+metOffsetY,oSkyfallMeteor); newMet.bBlue=0; newMet.moveSpd=metSpd; newMet.direction=metDir
  newMet=instance_create(208,metSpawnY+metOffsetY,oSkyfallMeteor); newMet.bBlue=0; newMet.moveSpd=metSpd; newMet.direction=metDir
  newMet=instance_create(272,metSpawnY+metOffsetY,oSkyfallMeteor); newMet.bBlue=0; newMet.moveSpd=metSpd; newMet.direction=metDir
  newMet=instance_create(336,metSpawnY+metOffsetY,oSkyfallMeteor); newMet.bBlue=0; newMet.moveSpd=metSpd; newMet.direction=metDir
  newMet=instance_create(400,metSpawnY+metOffsetY,oSkyfallMeteor); newMet.bBlue=1; newMet.moveSpd=metSpd; newMet.direction=metDir
  newMet=instance_create(464,metSpawnY+metOffsetY,oSkyfallMeteor); newMet.bBlue=0; newMet.moveSpd=metSpd; newMet.direction=metDir
}
else if setLocation=2 //RRRRRXXX
{
  newMet=instance_create(16,metSpawnY+metOffsetY,oSkyfallMeteor); newMet.bBlue=0; newMet.moveSpd=metSpd; newMet.direction=metDir
  newMet=instance_create(80,metSpawnY+metOffsetY,oSkyfallMeteor); newMet.bBlue=0; newMet.moveSpd=metSpd; newMet.direction=metDir
  newMet=instance_create(144,metSpawnY+metOffsetY,oSkyfallMeteor); newMet.bBlue=0; newMet.moveSpd=metSpd; newMet.direction=metDir
  newMet=instance_create(208,metSpawnY+metOffsetY,oSkyfallMeteor); newMet.bBlue=0; newMet.moveSpd=metSpd; newMet.direction=metDir
  newMet=instance_create(272,metSpawnY+metOffsetY,oSkyfallMeteor); newMet.bBlue=0; newMet.moveSpd=metSpd; newMet.direction=metDir
}
else if setLocation=3 //XXXRRRRR
{
  newMet=instance_create(208,metSpawnY+metOffsetY,oSkyfallMeteor); newMet.bBlue=0; newMet.moveSpd=metSpd; newMet.direction=metDir
  newMet=instance_create(272,metSpawnY+metOffsetY,oSkyfallMeteor); newMet.bBlue=0; newMet.moveSpd=metSpd; newMet.direction=metDir
  newMet=instance_create(336,metSpawnY+metOffsetY,oSkyfallMeteor); newMet.bBlue=0; newMet.moveSpd=metSpd; newMet.direction=metDir
  newMet=instance_create(400,metSpawnY+metOffsetY,oSkyfallMeteor); newMet.bBlue=0; newMet.moveSpd=metSpd; newMet.direction=metDir
  newMet=instance_create(464,metSpawnY+metOffsetY,oSkyfallMeteor); newMet.bBlue=0; newMet.moveSpd=metSpd; newMet.direction=metDir
}
else if setLocation=4 //RRRRRRXX - XXRRRRRR (Offset step /)
{
  newMet=instance_create(16,metSpawnY+metOffsetY+100,oSkyfallMeteor); newMet.bBlue=0; newMet.moveSpd=metSpd; newMet.direction=metDir
  newMet=instance_create(80,metSpawnY+metOffsetY+80,oSkyfallMeteor); newMet.bBlue=0; newMet.moveSpd=metSpd; newMet.direction=metDir
  newMet=instance_create(144,metSpawnY+metOffsetY+60,oSkyfallMeteor); newMet.bBlue=0; newMet.moveSpd=metSpd; newMet.direction=metDir
  newMet=instance_create(208,metSpawnY+metOffsetY+40,oSkyfallMeteor); newMet.bBlue=0; newMet.moveSpd=metSpd; newMet.direction=metDir
  newMet=instance_create(272,metSpawnY+metOffsetY+20,oSkyfallMeteor); newMet.bBlue=0; newMet.moveSpd=metSpd; newMet.direction=metDir
  newMet=instance_create(336,metSpawnY+metOffsetY,oSkyfallMeteor); newMet.bBlue=0; newMet.moveSpd=metSpd; newMet.direction=metDir

  newMet=instance_create(144,metSpawnY+metOffsetY+240,oSkyfallMeteor); newMet.bBlue=0; newMet.moveSpd=metSpd; newMet.direction=metDir
  newMet=instance_create(208,metSpawnY+metOffsetY+220,oSkyfallMeteor); newMet.bBlue=0; newMet.moveSpd=metSpd; newMet.direction=metDir
  newMet=instance_create(272,metSpawnY+metOffsetY+200,oSkyfallMeteor); newMet.bBlue=0; newMet.moveSpd=metSpd; newMet.direction=metDir
  newMet=instance_create(336,metSpawnY+metOffsetY+180,oSkyfallMeteor); newMet.bBlue=0; newMet.moveSpd=metSpd; newMet.direction=metDir
  newMet=instance_create(400,metSpawnY+metOffsetY+160,oSkyfallMeteor); newMet.bBlue=0; newMet.moveSpd=metSpd; newMet.direction=metDir
  newMet=instance_create(464,metSpawnY+metOffsetY+140,oSkyfallMeteor); newMet.bBlue=0; newMet.moveSpd=metSpd; newMet.direction=metDir
}
else if setLocation=5 //XXRRRRRR - RRRRRRXX (Offset step \)
{
  newMet=instance_create(16,metSpawnY+metOffsetY+140,oSkyfallMeteor); newMet.bBlue=0; newMet.moveSpd=metSpd; newMet.direction=metDir
  newMet=instance_create(80,metSpawnY+metOffsetY+160,oSkyfallMeteor); newMet.bBlue=0; newMet.moveSpd=metSpd; newMet.direction=metDir
  newMet=instance_create(144,metSpawnY+metOffsetY+180,oSkyfallMeteor); newMet.bBlue=0; newMet.moveSpd=metSpd; newMet.direction=metDir
  newMet=instance_create(208,metSpawnY+metOffsetY+200,oSkyfallMeteor); newMet.bBlue=0; newMet.moveSpd=metSpd; newMet.direction=metDir
  newMet=instance_create(272,metSpawnY+metOffsetY+220,oSkyfallMeteor); newMet.bBlue=0; newMet.moveSpd=metSpd; newMet.direction=metDir
  newMet=instance_create(336,metSpawnY+metOffsetY+240,oSkyfallMeteor); newMet.bBlue=0; newMet.moveSpd=metSpd; newMet.direction=metDir

  newMet=instance_create(144,metSpawnY+metOffsetY,oSkyfallMeteor); newMet.bBlue=0; newMet.moveSpd=metSpd; newMet.direction=metDir
  newMet=instance_create(208,metSpawnY+metOffsetY+20,oSkyfallMeteor); newMet.bBlue=0; newMet.moveSpd=metSpd; newMet.direction=metDir
  newMet=instance_create(272,metSpawnY+metOffsetY+40,oSkyfallMeteor); newMet.bBlue=0; newMet.moveSpd=metSpd; newMet.direction=metDir
  newMet=instance_create(336,metSpawnY+metOffsetY+60,oSkyfallMeteor); newMet.bBlue=0; newMet.moveSpd=metSpd; newMet.direction=metDir
  newMet=instance_create(400,metSpawnY+metOffsetY+80,oSkyfallMeteor); newMet.bBlue=0; newMet.moveSpd=metSpd; newMet.direction=metDir
  newMet=instance_create(464,metSpawnY+metOffsetY+100,oSkyfallMeteor); newMet.bBlue=0; newMet.moveSpd=metSpd; newMet.direction=metDir
}
else if setLocation=6 //RXRXRXRX
{
  newMet=instance_create(16,metSpawnY+metOffsetY,oSkyfallMeteor); newMet.bBlue=0; newMet.moveSpd=metSpd; newMet.direction=metDir
  newMet=instance_create(144,metSpawnY+metOffsetY,oSkyfallMeteor); newMet.bBlue=0; newMet.moveSpd=metSpd; newMet.direction=metDir
  newMet=instance_create(272,metSpawnY+metOffsetY,oSkyfallMeteor); newMet.bBlue=0; newMet.moveSpd=metSpd; newMet.direction=metDir
  newMet=instance_create(400,metSpawnY+metOffsetY,oSkyfallMeteor); newMet.bBlue=0; newMet.moveSpd=metSpd; newMet.direction=metDir
}
else if setLocation=7 //XRXRXRXR
{
  newMet=instance_create(80,metSpawnY+metOffsetY,oSkyfallMeteor); newMet.bBlue=0; newMet.moveSpd=metSpd; newMet.direction=metDir
  newMet=instance_create(208,metSpawnY+metOffsetY,oSkyfallMeteor); newMet.bBlue=0; newMet.moveSpd=metSpd; newMet.direction=metDir
  newMet=instance_create(336,metSpawnY+metOffsetY,oSkyfallMeteor); newMet.bBlue=0; newMet.moveSpd=metSpd; newMet.direction=metDir
  newMet=instance_create(464,metSpawnY+metOffsetY,oSkyfallMeteor); newMet.bBlue=0; newMet.moveSpd=metSpd; newMet.direction=metDir
}
else if setLocation=8 //BXBXBXBX
{
  newMet=instance_create(16,metSpawnY+metOffsetY,oSkyfallMeteor); newMet.bBlue=1; newMet.moveSpd=metSpd; newMet.direction=metDir
  newMet=instance_create(144,metSpawnY+metOffsetY,oSkyfallMeteor); newMet.bBlue=1; newMet.moveSpd=metSpd; newMet.direction=metDir
  newMet=instance_create(272,metSpawnY+metOffsetY,oSkyfallMeteor); newMet.bBlue=1; newMet.moveSpd=metSpd; newMet.direction=metDir
  newMet=instance_create(400,metSpawnY+metOffsetY,oSkyfallMeteor); newMet.bBlue=1; newMet.moveSpd=metSpd; newMet.direction=metDir
}
else if setLocation=9 //XBXBXBXB
{
  newMet=instance_create(80,metSpawnY+metOffsetY,oSkyfallMeteor); newMet.bBlue=1; newMet.moveSpd=metSpd; newMet.direction=metDir
  newMet=instance_create(208,metSpawnY+metOffsetY,oSkyfallMeteor); newMet.bBlue=1; newMet.moveSpd=metSpd; newMet.direction=metDir
  newMet=instance_create(336,metSpawnY+metOffsetY,oSkyfallMeteor); newMet.bBlue=1; newMet.moveSpd=metSpd; newMet.direction=metDir
  newMet=instance_create(464,metSpawnY+metOffsetY,oSkyfallMeteor); newMet.bBlue=1; newMet.moveSpd=metSpd; newMet.direction=metDir
}
else if setLocation=10 //RRXXRRXX
{
  newMet=instance_create(16,metSpawnY+metOffsetY,oSkyfallMeteor); newMet.bBlue=0; newMet.moveSpd=metSpd; newMet.direction=metDir
  newMet=instance_create(80,metSpawnY+metOffsetY,oSkyfallMeteor); newMet.bBlue=0; newMet.moveSpd=metSpd; newMet.direction=metDir
  newMet=instance_create(272,metSpawnY+metOffsetY,oSkyfallMeteor); newMet.bBlue=0; newMet.moveSpd=metSpd; newMet.direction=metDir
  newMet=instance_create(336,metSpawnY+metOffsetY,oSkyfallMeteor); newMet.bBlue=0; newMet.moveSpd=metSpd; newMet.direction=metDir
}
else if setLocation=11 //XXRRXXRR
{
  newMet=instance_create(144,metSpawnY+metOffsetY,oSkyfallMeteor); newMet.bBlue=0; newMet.moveSpd=metSpd; newMet.direction=metDir
  newMet=instance_create(208,metSpawnY+metOffsetY,oSkyfallMeteor); newMet.bBlue=0; newMet.moveSpd=metSpd; newMet.direction=metDir
  newMet=instance_create(400,metSpawnY+metOffsetY,oSkyfallMeteor); newMet.bBlue=0; newMet.moveSpd=metSpd; newMet.direction=metDir
  newMet=instance_create(464,metSpawnY+metOffsetY,oSkyfallMeteor); newMet.bBlue=0; newMet.moveSpd=metSpd; newMet.direction=metDir
}
else if setLocation=12 //XXRRRRXX
{
  newMet=instance_create(144,metSpawnY+metOffsetY,oSkyfallMeteor); newMet.bBlue=0; newMet.moveSpd=metSpd; newMet.direction=metDir
  newMet=instance_create(208,metSpawnY+metOffsetY,oSkyfallMeteor); newMet.bBlue=0; newMet.moveSpd=metSpd; newMet.direction=metDir
  newMet=instance_create(272,metSpawnY+metOffsetY,oSkyfallMeteor); newMet.bBlue=0; newMet.moveSpd=metSpd; newMet.direction=metDir
  newMet=instance_create(336,metSpawnY+metOffsetY,oSkyfallMeteor); newMet.bBlue=0; newMet.moveSpd=metSpd; newMet.direction=metDir
}
else if setLocation=13 //XXBBBBXX
{
  newMet=instance_create(144,metSpawnY+metOffsetY,oSkyfallMeteor); newMet.bBlue=1; newMet.moveSpd=metSpd; newMet.direction=metDir
  newMet=instance_create(208,metSpawnY+metOffsetY,oSkyfallMeteor); newMet.bBlue=1; newMet.moveSpd=metSpd; newMet.direction=metDir
  newMet=instance_create(272,metSpawnY+metOffsetY,oSkyfallMeteor); newMet.bBlue=1; newMet.moveSpd=metSpd; newMet.direction=metDir
  newMet=instance_create(336,metSpawnY+metOffsetY,oSkyfallMeteor); newMet.bBlue=1; newMet.moveSpd=metSpd; newMet.direction=metDir
}
else if setLocation=14 //L shape
{
  newMet=instance_create(144,metSpawnY+metOffsetY,oSkyfallMeteor); newMet.bBlue=0; newMet.moveSpd=4; newMet.direction=90
  newMet=instance_create(208,metSpawnY+metOffsetY,oSkyfallMeteor); newMet.bBlue=0; newMet.moveSpd=4; newMet.direction=90
  newMet=instance_create(208,metSpawnY+metOffsetY+64,oSkyfallMeteor); newMet.bBlue=0; newMet.moveSpd=4; newMet.direction=90
  newMet=instance_create(208,metSpawnY+metOffsetY+128,oSkyfallMeteor); newMet.bBlue=0; newMet.moveSpd=4; newMet.direction=90
  newMet=instance_create(208,metSpawnY+metOffsetY+192,oSkyfallMeteor); newMet.bBlue=0; newMet.moveSpd=4; newMet.direction=90
  newMet=instance_create(208,metSpawnY+metOffsetY+256,oSkyfallMeteor); newMet.bBlue=0; newMet.moveSpd=4; newMet.direction=90
  newMet=instance_create(272,metSpawnY+metOffsetY+256,oSkyfallMeteor); newMet.bBlue=0; newMet.moveSpd=4; newMet.direction=90
  newMet=instance_create(336,metSpawnY+metOffsetY+256,oSkyfallMeteor); newMet.bBlue=0; newMet.moveSpd=4; newMet.direction=90
}
else if setLocation=15 //Back-L shape
{
  newMet=instance_create(208,metSpawnY+metOffsetY,oSkyfallMeteor); newMet.bBlue=0; newMet.moveSpd=4; newMet.direction=90
  newMet=instance_create(272,metSpawnY+metOffsetY,oSkyfallMeteor); newMet.bBlue=0; newMet.moveSpd=4; newMet.direction=90
  newMet=instance_create(336,metSpawnY+metOffsetY,oSkyfallMeteor); newMet.bBlue=0; newMet.moveSpd=4; newMet.direction=90
  newMet=instance_create(208,metSpawnY+metOffsetY+64,oSkyfallMeteor); newMet.bBlue=0; newMet.moveSpd=4; newMet.direction=90
  newMet=instance_create(208,metSpawnY+metOffsetY+128,oSkyfallMeteor); newMet.bBlue=0; newMet.moveSpd=4; newMet.direction=90
  newMet=instance_create(208,metSpawnY+metOffsetY+192,oSkyfallMeteor); newMet.bBlue=0; newMet.moveSpd=4; newMet.direction=90
  newMet=instance_create(144,metSpawnY+metOffsetY+256,oSkyfallMeteor); newMet.bBlue=0; newMet.moveSpd=4; newMet.direction=90
  newMet=instance_create(208,metSpawnY+metOffsetY+256,oSkyfallMeteor); newMet.bBlue=0; newMet.moveSpd=4; newMet.direction=90
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
