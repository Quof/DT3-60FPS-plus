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
xView=240; yView=280

dreamFigureA_Sprite=sNull
dreamFigureA_Frame=0
dreamFigureA_Alpha=0
dreamFigureA_X=216
dreamFigureA_Facing=1
dreamFigureB_Sprite=sNull
dreamFigureB_Frame=0
dreamFigureB_Alpha=0
dreamFigureB_X=264
dreamFigureB_Facing=-1

if room=rSF_A
{
  bombCheck=0
  if global.gameProgress=4790
  {
    fadeAlpha=1
    global.charScan[0]=0
    global.gamePaused=true
  }
}
else if room=rSF_C
{
  for(i=0;i<6;i+=1)
  {
    fakeSpike[i]=instance_create(3808+(i*16),496,oSF_FakeTrap)
  }
}
else if room=rSF_F
{
  if global.gameProgress<=4900
  {
    yBobDown=0
    yScrollSpd=0
    xScrollSpd=2
    autoScroll=instance_create(240,176,oMisc)
    autoScroll.type=0
    autoScroll.sprite_index=sNull
    view_object[0]=autoScroll
  }
}

if global.gameProgress<=4950 {oIdentifier.bCanScan=0; oIdentifier.deactivate=1}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if room=rSF_A
{
  if global.gameProgress=4790 //----- [1] Intro to Subconscious Filter -----
  {
    if sceneProgress=0
    {
      sceneDelay+=1
      if sceneDelay=1 {oCh19_WM_NPC.image_xscale=-1.25; global.gamePaused=true}
      else if sceneDelay>=31 and sceneDelay<=70 {fadeAlpha-=0.025}
      if sceneDelay>=90 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=1 and bWaitForInput=false
      msgCreate(0,0,"Jerry","Mario again? ... No really, AGAIN?!",0,3,oMessageCutscene,1)
    else if sceneProgress=2 and bWaitForInput=false
      msgCreate(0,0,"Warmaster","Great, you were caught too. It would have been much easier to escape had you not gotten yourself caught in it.",6,3,oMessageCutscene,1)
    else if sceneProgress=3 and bWaitForInput=false
      msgCreate(0,0,"Jerry","What does that even mean?",0,3,oMessageCutscene,1)
    else if sceneProgress=4 and bWaitForInput=false
      msgCreate(0,0,"Warmaster","Bubblun didn't tell you about what was in the ruins?",6,3,oMessageCutscene,1)
    else if sceneProgress=5 and bWaitForInput=false
      msgCreate(0,0,"Jerry","I doubt he knew there was a portal to... whatever this place is. So what is it?#Oh wait, Jeremy, what is this place?",0,3,oMessageCutscene,1)
    else if sceneProgress=6
    {
      sceneDelay+=1
      if sceneDelay>=50 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=7 and bWaitForInput=false
      msgCreate(0,0,"Jerry","Uh Jeremy?",0,3,oMessageCutscene,1)
    else if sceneProgress=8 and bWaitForInput=false
      msgCreate(0,0,"Warmaster","He can hear and see you I'm sure, but this place is probably keeping all outside influence from interacting.",6,3,oMessageCutscene,1)
    else if sceneProgress=9 and bWaitForInput=false
      msgCreate(0,0,"Jerry","You know a lot about us, don't you?",0,3,oMessageCutscene,1)
    else if sceneProgress=10 and bWaitForInput=false
      msgCreate(0,0,"Warmaster","There isn't a bot that doesn't at this point.",6,3,oMessageCutscene,1)
    else if sceneProgress=11 and bWaitForInput=false
      msgCreate(0,0,"Jerry","Alright, but really, what is this place?",0,3,oMessageCutscene,1)
    else if sceneProgress=12 and bWaitForInput=false
      msgCreate(0,0,"Warmaster","We call it the Subconscious Filter. It takes the thoughts of everyone in it and projects that into a physical form.",6,3,oMessageCutscene,1)
    else if sceneProgress=13 and bWaitForInput=false
      msgCreate(0,0,"Jerry","So that's why we're in a Mario world again? One of us is thinking about Mario right now?",0,3,oMessageCutscene,1)
    else if sceneProgress=14 and bWaitForInput=false
      msgCreate(0,0,"Warmaster","You're thinking about it far too simple.",6,3,oMessageCutscene,1)
    else if sceneProgress=15 and bWaitForInput=false
      msgCreate(0,0,"Claire","Think about the name, Jerry. Ugh.",0,3,oMessageCutscene,1)
    else if sceneProgress=16 and bWaitForInput=false
      msgCreate(0,0,"Warmaster","Now that you know. It is best for all of us if we stay away from one another.#Too many thoughts and memories in this place and things get unstable.",6,3,oMessageCutscene,1)
    else if sceneProgress=17 and bWaitForInput=false
      msgCreate(0,0,"Jerry","Do you know a way out of here?",0,3,oMessageCutscene,1)
    else if sceneProgress=18 and bWaitForInput=false
      msgCreate(0,0,"Warmaster","Yes, and now that I think about it. If you get lost in here, I won't have to deal with you.",6,3,oMessageCutscene,1)
    else if sceneProgress=19 and bWaitForInput=false
      msgCreate(0,0,"Claire","We need to keep up with him, Jerry.",0,3,oMessageCutscene,1)
    else if sceneProgress=20 and bWaitForInput=false
      msgCreate(0,0,"Jerry","Yep!",0,3,oMessageCutscene,1)
    else if sceneProgress=21 and bWaitForInput=false
      msgCreate(0,0,"Warmaster","Just try it.",6,3,oMessageCutscene,1)
    else if sceneProgress=22
    {
      oCh19_WM_NPC.image_xscale=1.25
      sceneDelay=0; sceneProgress=0
      global.gameProgress=4800
      global.gamePaused=false
    }
  }
  else if global.gameProgress=4810 and global.gamePaused=false //----- [] Bomberman Event -----
  {
    if sceneProgress=0
    {
      if oPlayer1.x>=2592
      {
        tile_layer_show(999990)
        myCollA=instance_create(2112,0,oInvisibleSolid)
        myCollA.image_xscale=4; myCollA.image_yscale=44
        myCollB=instance_create(3008,0,oInvisibleSolid)
        myCollB.image_xscale=4; myCollB.image_yscale=44
        sceneProgress+=1
      }
    }
    else if sceneProgress=1
    {
      if instance_exists(oBombermanExplode) {bombCheck=1}
      sceneDelay+=1
      if sceneDelay=40 {xSpawn=2464; ySpawn=352; objSpawn=oBomberBat; moveSpd=2; turnDelay=64; turnAmt=90; myDir=0; event_user(0)}
      else if sceneDelay=65 {xSpawn=2720; ySpawn=480; objSpawn=oBomberBat; moveSpd=2; turnDelay=64; turnAmt=-90; myDir=180; event_user(0)}
      else if sceneDelay=90 {xSpawn=2464; ySpawn=608; objSpawn=oBomberBat; moveSpd=4; turnDelay=64; turnAmt=90; myDir=0; event_user(0)}
      else if sceneDelay=115 {xSpawn=2848; ySpawn=96; objSpawn=oBomberCloud; moveSpd=4; turnDelay=64; turnAmt=90; myDir=180; event_user(0)}
      else if sceneDelay=300
      {
        if bombCheck=0
        {
          msgCreate(0,0,"Jerry","I just got an idea, Claire. I know it sounds crazy, but try your Morph Bombs.",0,2,oMessagePerson,0)
          newMessage.fadingTime=120
        }
      }
      if sceneDelay>=150
      {
        if !instance_exists(oEnemyBase) {sceneDelay=0; sceneProgress+=1}
      }
    }
    else if sceneProgress=2
    {
      sceneDelay+=1
      if sceneDelay=20
      {
        xSpawn=2464; ySpawn=352; objSpawn=oBomberBat; moveSpd=2; turnDelay=64; turnAmt=90; myDir=0; event_user(0)
        xSpawn=2208; ySpawn=352; objSpawn=oBomberBat; moveSpd=2; turnDelay=64; turnAmt=90; myDir=0; event_user(0)
      }
      else if sceneDelay=40 {xSpawn=2464; ySpawn=608; objSpawn=oBomberBat; moveSpd=1; turnDelay=128; turnAmt=90; myDir=0; event_user(0)}
      else if sceneDelay=60 {xSpawn=2848; ySpawn=224; objSpawn=oBomberBat; moveSpd=2; turnDelay=128; turnAmt=90; myDir=180; event_user(0)}
      else if sceneDelay=80 {xSpawn=2336; ySpawn=96; objSpawn=oBomberBat; moveSpd=4; turnDelay=128; turnAmt=-90; myDir=0; event_user(0)}
      else if sceneDelay=100 {xSpawn=2720; ySpawn=480; objSpawn=oBomberCloud; moveSpd=2; turnDelay=128; turnAmt=90; myDir=90; event_user(0)}
      else if sceneDelay=120
      {
        xSpawn=2464; ySpawn=224; objSpawn=oBomberCloud; moveSpd=2; turnDelay=128; turnAmt=90; myDir=270; event_user(0)
        xSpawn=2720; ySpawn=480; objSpawn=oBomberCloud; moveSpd=2; turnDelay=64; turnAmt=-90; myDir=180; event_user(0)
      }
      else if sceneDelay>=150
      {
        if !instance_exists(oEnemyBase)
        {
          sceneDelay=0; sceneProgress+=1
          tile_layer_hide(999990)
          with myCollA {instance_destroy()}
          with myCollB {instance_destroy()}
          global.gameProgress=4820
        }
      }
    }
  }
}
else if room=rSF_B
{
  if global.gameProgress=4840 and global.gamePaused=false //----- [] Flashback -----
  {
    if sceneProgress=0
    {
      if oPlayer1.x>=4352 {sceneProgress+=1}
    }
    else if sceneProgress=1
    {
      sceneDelay+=1
      if sceneDelay=10
      {
        dreamFigureA_Sprite=sClaireIdle
        dreamFigureB_Sprite=sChaoHumanForm
      }
      else if sceneDelay>=11 and sceneDelay<=20 {dreamFigureA_Alpha+=0.02; dreamFigureB_Alpha+=0.02}
      else if sceneDelay=30 {createScreenText(xView,yView,80,fnt_EnemyName,fa_middle,"-Claire-#Where's your brother?",3,c_white,1,0)}
      else if sceneDelay=110 {createScreenText(xView,yView,160,fnt_EnemyName,fa_middle,"-Chao-#He's working again. Like usual. How are things between you and Jerry?",3,c_white,1,0)}
      else if sceneDelay=270 {createScreenText(xView,yView,90,fnt_EnemyName,fa_middle,"-Claire-#Not so good... We broke up.",3,c_white,1,0)}
      else if sceneDelay=360 {createScreenText(xView,yView,50,fnt_EnemyName,fa_middle,"-Chao-#What happened?",3,c_white,1,0)}
      else if sceneDelay=400
      {
        var tStatic;
        tStatic=instance_create(0,0,oQuickStatic); tStatic.staticTime=10; tStatic.image_alpha=0.66
        dreamFigureA_Alpha=0; dreamFigureB_Alpha=0
      }
      else if sceneDelay=460
      {
        msgCreate(0,0,"Jerry","These again.",0,1,oMessagePerson,0)
        newMessage.fadingTime=50
      }
      else if sceneDelay>=521 and sceneDelay<=530 {dreamFigureA_Alpha+=0.02; dreamFigureB_Alpha+=0.02}
      else if sceneDelay=540 {createScreenText(xView,yView,130,fnt_EnemyName,fa_middle,"-Chao-#CLAIRE, you will never believe what Jeremy did!",3,c_white,1,0)}
      else if sceneDelay=670 {createScreenText(xView,yView,90,fnt_EnemyName,fa_middle,"-Claire-#What did he do this time?",3,c_white,1,0)}
      else if sceneDelay=760 {createScreenText(xView,yView,130,fnt_EnemyName,fa_middle,"-Chao-#Remember that national fighting game tournament?",3,c_white,1,0)}
      else if sceneDelay=890 {createScreenText(xView,yView,70,fnt_EnemyName,fa_middle,"-Claire-#No way... Did he win?!",3,c_white,1,0)}
      else if sceneDelay=960 {createScreenText(xView,yView,70,fnt_EnemyName,fa_middle,"-Chao-#Yes, well... sorta.",3,c_white,1,0)}
      else if sceneDelay=1030 {createScreenText(xView,yView,90,fnt_EnemyName,fa_middle,"-Claire-#How did he sorta win?",3,c_white,1,0)}
      else if sceneDelay=1120 {createScreenText(xView,yView,160,fnt_EnemyName,fa_middle,"-Chao-#Technically he didn't... but he would have, had he not thrown the match!",3,c_white,1,0)}
      else if sceneDelay=1280 {createScreenText(xView,yView,120,fnt_EnemyName,fa_middle,"-Claire-#Chao, are you sure it was that?",3,c_white,1,0)}
      else if sceneDelay=1400 {createScreenText(xView,yView,170,fnt_EnemyName,fa_middle,"-Chao-#I've seen what he does when he's trying to look like he's losing legitimately.",3,c_white,1,0)}
      else if sceneDelay=1570 {createScreenText(xView,yView,90,fnt_EnemyName,fa_middle,"-Claire-#Why did he do that?",3,c_white,1,0)}
      else if sceneDelay=1660 {createScreenText(xView,yView,140,fnt_EnemyName,fa_middle,"-Chao-#He said he just didn't have time for that stuff anymore.",3,c_white,1,0)}
      else if sceneDelay=1800 {createScreenText(xView,yView,120,fnt_EnemyName,fa_middle,"-Claire-#So he threw the match just for that?!",3,c_white,1,0)}
      else if sceneDelay=1920 {createScreenText(xView,yView,120,fnt_EnemyName,fa_middle,"-Chao-#Yeah, it upsets me and I don't know why.",3,c_white,1,0)}
      else if sceneDelay=2020
      {
        var tStatic;
        tStatic=instance_create(0,0,oQuickStatic); tStatic.staticTime=10; tStatic.image_alpha=0.66
        dreamFigureA_Alpha=0; dreamFigureB_Alpha=0
      }
    }
  }
}
else if room=rSF_C
{
  if global.gameProgress=4870 and global.gamePaused=false //----- [] Flashback -----
  {
    if sceneProgress=0
    {
      if oPlayer1.x>=2816 {sceneProgress+=1}
    }
    else if sceneProgress=1
    {
      sceneDelay+=1
      if sceneDelay=10
      {
        dreamFigureA_Sprite=sJerrySit; dreamFigureA_X=208
        dreamFigureB_Sprite=sClaireSitUp; dreamFigureB_Frame=2; dreamFigureB_X=272
      }
      else if sceneDelay>=11 and sceneDelay<=20 {dreamFigureA_Alpha+=0.02; dreamFigureB_Alpha+=0.02}
      else if sceneDelay=30 {createScreenText(xView,yView,80,fnt_EnemyName,fa_middle,"-Claire-#We need to talk, Jerry.",3,c_white,1,0)}
      else if sceneDelay=110 {createScreenText(xView,yView,80,fnt_EnemyName,fa_middle,"-Jerry-#I know what this is about.",3,c_white,1,0)}
      else if sceneDelay=190
      {
        dreamFigureB_Sprite=sClaireIdle
        createScreenText(xView,yView,140,fnt_EnemyName,fa_middle,"-Claire-#Then you should also know why this is happening.",3,c_white,1,0)
      }
      else if sceneDelay=330
      {
        dreamFigureA_Sprite=sJerryIdle
        createScreenText(xView,yView,110,fnt_EnemyName,fa_middle,"-Jerry-#And I said then why it was your fault!",3,c_white,1,0)
      }
      else if sceneDelay=440 {createScreenText(xView,yView,100,fnt_EnemyName,fa_middle,"-Claire-#Maybe if you weren't such an overbearing...",3,c_white,1,0)}
      else if sceneDelay=520
      {
        var tStatic;
        tStatic=instance_create(0,0,oQuickStatic); tStatic.staticTime=10; tStatic.image_alpha=0.66
      }
      else if sceneDelay=530 {dreamFigureB_Sprite=sClaireWalk; dreamFigureB_Facing=1}
      else if sceneDelay>=531 and sceneDelay<=539 {dreamFigureB_X+=6; dreamFigureB_Frame+=0.34}
      else if sceneDelay>=540
      {
        var tStatic;
        tStatic=instance_create(0,0,oQuickStatic); tStatic.staticTime=10; tStatic.image_alpha=0.66
        dreamFigureA_Alpha=0; dreamFigureB_Alpha=0
        sceneDelay=0; sceneProgress+=1
      }
    }
    else if sceneProgress=2
    {
      sceneDelay+=1
      if sceneDelay=10
      {
        msgCreate(0,0,"Jerry","I'm really sorry about that. It's embarrassing seeing how I treated you sometimes.",0,2,oMessagePerson,0)
        newMessage.fadingTime=130
      }
      else if sceneDelay=140
      {
        msgCreate(0,0,"Claire","I wasn't always that great to you either.",0,2,oMessagePerson,0)
        newMessage.fadingTime=80
      }
      else if sceneDelay=220
      {
        msgCreate(0,0,"Jerry","If I had been more understanding when we talked, things would have gone better.",0,2,oMessagePerson,0)
        newMessage.fadingTime=130
      }
      else if sceneDelay=350
      {
        msgCreate(0,0,"Claire","Looks like we both had a lot to learn.",0,2,oMessagePerson,0)
        newMessage.fadingTime=80
      }
    }
  }
  //Fake spikes
  if oPlayer1.x<3920 {for(i=0;i<6;i+=1) {fakeSpike[i].x=3808+(i*16)}}
  else {for(i=0;i<6;i+=1) {fakeSpike[i].x=3936+(i*16)}}
}
else if room=rSF_D
{
  if global.gameProgress=4880 and global.gamePaused=false //----- [] Advancing Death Wall -----
  {
    if sceneProgress=0
    {
      if oPlayer1.x>=144
      {
        instance_create(-28,0,oSpecialAdvDeathWall)
        sceneProgress+=1
      }
    }
    else if sceneProgress=1
    {
      sceneDelay+=1
      if sceneDelay=40
      {
        msgCreate(0,0,"Claire","Jerry, were you thinking about a death wall?!",0,1,oMessagePerson,0)
        newMessage.fadingTime=80
      }
      else if sceneDelay=120
      {
        msgCreate(0,0,"Jerry","What? NO! Of course I wasn't!",0,1,oMessagePerson,0)
        newMessage.fadingTime=60
      }
      else if sceneDelay=180
      {
        msgCreate(0,0,"Claire","Then why is there a death wall?!",0,1,oMessagePerson,0)
        newMessage.fadingTime=70
      }
      else if sceneDelay=250
      {
        msgCreate(0,0,"Jerry","Maybe you were thinking about one?... WAIT, I thought it didn't work like that. Wasn't it subconscious thoughts or... something?",0,3,oMessagePerson,0)
        newMessage.fadingTime=170
      }
      else if sceneDelay=420
      {
        msgCreate(0,0,"Claire","HEY, I wasn't thinking about them! But maybe one of us has a deep seated liking for them.",0,2,oMessagePerson,0)
        newMessage.fadingTime=140
      }
      else if sceneDelay=560
      {
        msgCreate(0,0,"Jerry","Nobody actually likes these things. It probably pulled them from me now that I think about it.",0,2,oMessagePerson,0)
        newMessage.fadingTime=140
      }
      else if sceneDelay=700
      {
        msgCreate(0,0,"Claire","Really, why?",0,1,oMessagePerson,0)
        newMessage.fadingTime=60
      }
      else if sceneDelay=760
      {
        msgCreate(0,0,"Jerry","You never got to experience 'Distortion WTF'.",0,1,oMessagePerson,0)
        newMessage.fadingTime=90
      }
      else if sceneDelay=850
      {
        msgCreate(0,0,"Claire","What?",0,1,oMessagePerson,0)
        newMessage.fadingTime=60
      }
      else if sceneDelay=910
      {
        msgCreate(0,0,"Jerry","Trust me, it's better that you don't know.",0,1,oMessagePerson,0)
        newMessage.fadingTime=90
      }
    }
  }
}
else if room=rSF_E
{
  if global.gameProgress=4890 and global.gamePaused=false //----- [] Advancing Death Wall -----
  {
    if sceneProgress=0
    {
      if oPlayer1.x>=144
      {
        instance_create(-28,0,oSpecialAdvDeathWall)
        sceneProgress+=1
      }
    }
    else if sceneProgress=1
    {
      sceneDelay+=1
      if sceneDelay=40
      {
        msgCreate(0,0,"Claire","Oh geez, again.",0,1,oMessagePerson,0)
        newMessage.fadingTime=60
      }
      else if sceneDelay=100
      {
        msgCreate(0,0,"Jerry","Now it's just getting silly.",0,1,oMessagePerson,0)
        newMessage.fadingTime=80
      }
    }
  }
}
else if room=rSF_F
{
  if global.gameProgress=4890 //----- [2] No more deathwalls -----
  {
    if sceneProgress=0
    {
      sceneDelay+=1
      if sceneDelay=1 {oCh19_WM_NPC.sprite_index=sWarmasterA_Idle; oCh19_WM_NPC.image_speed=0.15; oCh19_WM_NPC.image_xscale=-1.25; global.gamePaused=true}
      if sceneDelay>=30 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=1 and bWaitForInput=false
      msgCreate(0,0,"Warmaster","I don't care much for advancing spike walls, so if you could, please stop that.",6,3,oMessageCutscene,1)
    else if sceneProgress=2 and bWaitForInput=false
      msgCreate(0,0,"Jerry","It's not like we can control it.",0,3,oMessageCutscene,1)
    else if sceneProgress=3 and bWaitForInput=false
      msgCreate(0,0,"Warmaster","If you weren't following me so close, I wouldn't have to be around your manifestations.",6,3,oMessageCutscene,1)
    else if sceneProgress=4 and bWaitForInput=false
      msgCreate(0,0,"Jerry","We're gonna keep following you.",0,3,oMessageCutscene,1)
    else if sceneProgress=5 and bWaitForInput=false
      msgCreate(0,0,"Warmaster","How about this. If I lead you out, will you stop your useless assault against the warship? It's for your own good that you do.",6,3,oMessageCutscene,1)
    else if sceneProgress=6 and bWaitForInput=false
      msgCreate(0,0,"Jerry","Not happening.",0,3,oMessageCutscene,1)
    else if sceneProgress=7 and bWaitForInput=false
      msgCreate(0,0,"Warmaster","If you'd just stop...",6,3,oMessageCutscene,1)
    else if sceneProgress=8
    {
      sceneDelay+=1
      if sceneDelay=10
      {
        var tEffect;
        tEffect=instance_create(oCh19_WM_NPC.x,oCh19_WM_NPC.y-20,oEffect)
        tEffect.sprite_index=sEfEnergyRip; tEffect.image_speed=0.5; tEffect.image_alpha=0.5
        tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
        oCh19_WM_NPC.image_alpha=0
      }
      else if sceneDelay>=30 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=9 and bWaitForInput=false
      msgCreate(0,0,"Jerry","What a dirty cheater.",0,3,oMessageCutscene,1)
    else if sceneProgress=10
    {
      with oCh19_WM_NPC {instance_destroy()}
      sceneDelay=0; sceneProgress=0
      global.gameProgress=4900
      global.gamePaused=false
    }
  }
  else if global.gameProgress=4900
  {
    if global.gamePaused=false
    {
      if !instance_exists(oAchieveCheck)
      {
        var tCheckAchieve;
        tCheckAchieve=string_char_at(global.tokenRecognitions,10)
        if tCheckAchieve="0"
        {
          var tAchievement;
          tAchievement=instance_create(0,0,oAchievementNotice)
          tAchievement.myAchievement="Remember That"; tAchievement.checkNum=10
        }
      }

      oPlayer1.bKeepPlayerOnScreen=0
      if view_xview[0]>=3072 {xScrollSpd=3}

      if autoScroll.x<room_width-240
        autoScroll.x+=xScrollSpd

      if yBobDown=0
      {
        yScrollSpd+=0.018
        if yScrollSpd>=1
          yBobDown=1
      }
      else
      {
        yScrollSpd-=0.018
        if yScrollSpd<=-1
          yBobDown=0
      }
      autoScroll.y+=yScrollSpd

      if autoScroll.x-(view_wview[0]/2)-20>oPlayer1.x
        oPlayer1.life-=oPlayer1.maxLife
    }
  }
}
else if room=rSF_G
{
  if global.gameProgress=4900 //----- [3] I'm going to lose you this time -----
  {
    if sceneProgress=0
    {
      sceneDelay+=1
      if sceneDelay=1 {oCh19_WM_NPC.sprite_index=sWarmasterA_Idle; oCh19_WM_NPC.image_speed=0.15; oCh19_WM_NPC.image_xscale=-1.25; global.gamePaused=true}
      if sceneDelay>=30 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=1 and bWaitForInput=false
      msgCreate(0,0,"Jerry","Was that ship from you?",0,3,oMessageCutscene,1)
    else if sceneProgress=2 and bWaitForInput=false
      msgCreate(0,0,"Warmaster","What would you like to take credit for?",6,3,oMessageCutscene,1)
    else if sceneProgress=3 and bWaitForInput=false
      msgCreate(0,0,"Jerry","The spike wall for one.",0,3,oMessageCutscene,1)
    else if sceneProgress=4 and bWaitForInput=false
      msgCreate(0,0,"Warmaster","Great, your contribution has been a thorn in everyone's side. If you think that all I want is to burn this land, then place the ship on me.",6,3,oMessageCutscene,1)
    else if sceneProgress=5 and bWaitForInput=false
      msgCreate(0,0,"Jerry","I know what you're trying to say.",0,3,oMessageCutscene,1)
    else if sceneProgress=6 and bWaitForInput=false
      msgCreate(0,0,"Warmaster","Then you know that if you lose sight of me this time, that you'll be lost here forever.",6,3,oMessageCutscene,1)
    else if sceneProgress=7 and bWaitForInput=false
      msgCreate(0,0,"Jerry","Ahh, right.",0,3,oMessageCutscene,1)
    else if sceneProgress=8
    {
      oCh19_WM_NPC.image_xscale=1.25
      sceneDelay=0; sceneProgress=0
      global.gameProgress=4910
      global.gamePaused=false
    }
  }
  else if global.gameProgress=4910 //----- [4] Warmaster Chase -----
  {
    if sceneProgress=0
    {
      if oPlayer1.x>=2336
      {
        instance_create(0,0,oBikeViewFollow)
        view_object[0]=oBikeViewFollow
        oCh19_WM_NPC.image_xscale=1.25
        sceneProgress=1
      }
    }
    else if sceneProgress=2
    {
      sceneDelay+=1
      if sceneDelay=1
      {
        global.gamePaused=true
        var tFlash;
        tFlash=instance_create(0,0,oScreenFlash); tFlash.fadeSpeed=0.2
        scenePChk(11472,512,0,0.1,1)
        stopPlayer()
      }
      if sceneDelay>=45 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=3 and bWaitForInput=false
      msgCreate(0,0,"Jerry","You had fun with that.",0,3,oMessageCutscene,1)
    else if sceneProgress=4 and bWaitForInput=false
      msgCreate(0,0,"Warmaster","Didn't realize you could see that.",6,3,oMessageCutscene,1)
    else if sceneProgress=5 and bWaitForInput=false
      msgCreate(0,0,"Jerry","You're not going to lose us by the way.",0,3,oMessageCutscene,1)
    else if sceneProgress=6 and bWaitForInput=false
      msgCreate(0,0,"Warmaster","I can see that and fighting you off is not an option here... An exit is close by, I'll lead you there. As soon as we're out of this place, you better be out of sight.",6,3,oMessageCutscene,1)
    else if sceneProgress=7 and bWaitForInput=false
      msgCreate(0,0,"Jerry","Yeah, we know.",0,3,oMessageCutscene,1)
    else if sceneProgress=8 and bWaitForInput=false
      msgCreate(0,0,"Warmaster","Everything I said before still stands. If you back down, everything will be better. If you do not, I cannot stop Hex in what he will do.",6,3,oMessageCutscene,1)
    else if sceneProgress=9 and bWaitForInput=false
      msgCreate(0,0,"Jerry","And everything we said still stands.",0,3,oMessageCutscene,1)
    else if sceneProgress=10 and bWaitForInput=false
      msgCreate(0,0,"Warmaster","Sad... If we meet outside, it will be on the battlefield... I will admit, I've been curious in fighting you. You fought and won against the Shroud Lord, that isn't a small feat.",6,3,oMessageCutscene,1)
    else if sceneProgress=11 and bWaitForInput=false
      msgCreate(0,0,"Warmaster","And you Claire. You have a number of accomplishments yourself. However, we won't get the chance to fight, Hex will finish both of you.",6,3,oMessageCutscene,1)
    else if sceneProgress=12 and bWaitForInput=false
      msgCreate(0,0,"Jerry","You say that now. But anyway, where is this exit?",0,3,oMessageCutscene,1)
    else if sceneProgress=13 and bWaitForInput=false
      msgCreate(0,0,"Warmaster","Keep going, you'll see it soon.",6,3,oMessageCutscene,1)
    else if sceneProgress=14
    {
      sceneDelay+=1
      if sceneDelay=10
      {
        var tEffect;
        tEffect=instance_create(oCh19_WM_NPC.x,oCh19_WM_NPC.y-20,oEffect)
        tEffect.sprite_index=sEfEnergyRip; tEffect.image_speed=0.5; tEffect.image_alpha=0.5
        tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
        oCh19_WM_NPC.image_alpha=0
        sceneDelay=0; sceneProgress+=1
      }
    }
    else if sceneProgress=15
    {
      with oCh19_WM_NPC {instance_destroy()}
      sceneDelay=0; sceneProgress=0
      global.gameProgress=4920
      global.gamePaused=false
    }
  }
}
else if room=rSF_H
{
  if global.gameProgress=4920 and global.gamePaused=false //----- [] Flashback -----
  {
    if sceneProgress=0
    {
      if oPlayer1.x>=768 {sceneProgress+=1}
    }
    else if sceneProgress=1
    {
      sceneDelay+=1
      if sceneDelay=10
      {
        dreamFigureA_Sprite=sWarmasterA_Idle
        dreamFigureB_Sprite=sHex_A_Idle
      }
      else if sceneDelay>=11 and sceneDelay<=20 {dreamFigureA_Alpha+=0.02; dreamFigureB_Alpha+=0.02}
      else if sceneDelay=30 {createScreenText(xView,yView,120,fnt_EnemyName,fa_middle,"-Warmaster-#Who are you? You never explained yourself.",3,c_white,1,0)}
      else if sceneDelay=150 {createScreenText(xView,yView,150,fnt_EnemyName,fa_middle,"-Hex-#An ally. We can benefit greatly from one another if you'll agree to my terms.",3,c_white,1,0)}
      else if sceneDelay=300 {createScreenText(xView,yView,80,fnt_EnemyName,fa_middle,"-Warmaster-#What can you offer me?",3,c_white,1,0)}
      else if sceneDelay=370
      {
        var tStatic;
        tStatic=instance_create(0,0,oQuickStatic); tStatic.staticTime=10; tStatic.image_alpha=0.66
        dreamFigureA_Alpha=0; dreamFigureB_Alpha=0
      }
      else if sceneDelay=400
      {
        msgCreate(0,0,"Jerry","Wait a minute! We need to see these!",0,1,oMessagePerson,0)
        newMessage.fadingTime=80
      }
      else if sceneDelay=480 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=2
    {
      sceneDelay+=1
      if sceneDelay=10
      {
        dreamFigureA_Sprite=sWarmasterA_Idle
        dreamFigureB_Sprite=sHex_A_Idle
      }
      else if sceneDelay>=11 and sceneDelay<=20 {dreamFigureA_Alpha+=0.02; dreamFigureB_Alpha+=0.02}
      else if sceneDelay=30 {createScreenText(xView,yView,80,fnt_EnemyName,fa_middle,"-Warmaster-#Everything is set to go.",3,c_white,1,0)}
      else if sceneDelay=110 {createScreenText(xView,yView,180,fnt_EnemyName,fa_middle,"-Hex-#Perfect. Now all we need to do is wait for them#to remove the Virus and its locks will be lifted.",3,c_white,1,0)}
      else if sceneDelay=290 {createScreenText(xView,yView,180,fnt_EnemyName,fa_middle,"-Warmaster-#Remember that once the Virus is removed,#that the program will not resume control. We are all free.",3,c_white,1,0)}
      else if sceneDelay=470 {createScreenText(xView,yView,130,fnt_EnemyName,fa_middle,"-Hex-#Some things will be lost, but it is necessary for my plans.",3,c_white,1,0)}
      else if sceneDelay=600 {createScreenText(xView,yView,80,fnt_EnemyName,fa_middle,"-Warmaster-#What else do you need?",3,c_white,1,0)}
      else if sceneDelay=680 {createScreenText(xView,yView,90,fnt_EnemyName,fa_middle,"-Hex-#Give me control of CHAOS.",3,c_white,1,0)}
      else if sceneDelay=760
      {
        var tStatic;
        tStatic=instance_create(0,0,oQuickStatic); tStatic.staticTime=10; tStatic.image_alpha=0.66
        dreamFigureA_Alpha=0; dreamFigureB_Alpha=0
      }
      else if sceneDelay=790
      {
        msgCreate(0,0,"Claire","That explains things.",0,1,oMessagePerson,0)
        newMessage.fadingTime=60
      }
      else if sceneDelay=850 {sceneDelay=0; sceneProgress+=1}
    }
  }
}
else if room=rSF_I
{
  if global.gameProgress=4920 //----- [5] The end is close -----
  {
    if sceneProgress=0
    {
      sceneDelay+=1
      if sceneDelay=1 {oCh19_WM_NPC.sprite_index=sWarmasterA_Idle; oCh19_WM_NPC.image_speed=0.15; oCh19_WM_NPC.image_xscale=-1.25; global.gamePaused=true}
      if sceneDelay>=30 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=1 and bWaitForInput=false
      msgCreate(0,0,"Warmaster","An exit is just past this point.",6,3,oMessageCutscene,1)
    else if sceneProgress=2 and bWaitForInput=false
      msgCreate(0,0,"Jerry","Just a question. How many entrances to this place are there?",0,3,oMessageCutscene,1)
    else if sceneProgress=3 and bWaitForInput=false
      msgCreate(0,0,"Warmaster","There are many, but the exact number I don't know.",6,3,oMessageCutscene,1)
    else if sceneProgress=4 and bWaitForInput=false
      msgCreate(0,0,"Jerry","One more thing. Where will this exit bring us?",0,3,oMessageCutscene,1)
    else if sceneProgress=5 and bWaitForInput=false
      msgCreate(0,0,"Warmaster","It could drop us into a volcano or it could put us right back where we found the portal.",6,3,oMessageCutscene,1)
    else if sceneProgress=6 and bWaitForInput=false
      msgCreate(0,0,"Jerry","You don't know.",0,3,oMessageCutscene,1)
    else if sceneProgress=7 and bWaitForInput=false
      msgCreate(0,0,"Warmaster","Precisely. Now, I'll be going first. I do hope you will reconsider.",6,3,oMessageCutscene,1)
    else if sceneProgress=8
    {
      sceneDelay+=1
      if sceneDelay=10
      {
        var tEffect;
        tEffect=instance_create(oCh19_WM_NPC.x,oCh19_WM_NPC.y-20,oEffect)
        tEffect.sprite_index=sEfEnergyRip; tEffect.image_speed=0.5; tEffect.image_alpha=0.5
        tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
        oCh19_WM_NPC.image_alpha=0
      }
      else if sceneDelay>=30 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=9 and bWaitForInput=false
      msgCreate(0,0,"Claire","I wish I knew what he meant by not being able to stop Hex.",0,3,oMessageCutscene,1)
    else if sceneProgress=10 and bWaitForInput=false
      msgCreate(0,0,"Jerry","Yeah, that's freaking me out too.",0,3,oMessageCutscene,1)
    else if sceneProgress=11
    {
      with oCh19_WM_NPC {instance_destroy()}
      sceneDelay=0; sceneProgress=0
      global.gameProgress=4930
      global.gamePaused=false
    }
  }
  if global.gameProgress=4930 //----- [] Castle breaks apart -----
  {
    if sceneProgress=0
    {
      if oPlayer1.x>=1232
      {
        msgCreate(0,0,"Jerry","That's adorable, it's like a floating castle... sorta.",0,1,oMessagePerson,0)
        newMessage.fadingTime=100
        sceneProgress+=1
      }
    }
    else if sceneProgress=1
    {
      if oPlayer1.x>=2288 and oPlayer1.y<=1440
      {
        var tViewShake;
        tViewShake=instance_create(oPlayer1.x,oPlayer1.y,oVarViewShaker)
        tViewShake.turbulance=1; tViewShake.shakeTime=-1
        enemyBarrier=instance_create(48,1792,oEnemyBarrier); enemyBarrier.image_yscale=4
        for(i=0;i<4;i+=1)
        {
          instance_create(2016,1112+(i*64),oSF_Tile4)
        }
        sceneProgress+=1
      }
    }
    else if sceneProgress=2
    {
      sceneDelay+=1
      if sceneDelay=20
      {
        var tempMplay;
        tempMplay=findMusic(1002)
        playMusic(tempMplay,0,0)
      }
      else if sceneDelay=40
      {
        msgCreate(0,0,"Jerry","What the heck now?",0,1,oMessagePerson,0)
        newMessage.fadingTime=60
      }
      else if sceneDelay=100
      {
        msgCreate(0,0,"Claire","I think the Warmaster found the exit.",0,1,oMessagePerson,0)
        newMessage.fadingTime=90
      }
      else if sceneDelay=190
      {
        msgCreate(0,0,"Jerry","Ooh, so things are changing now.",0,1,oMessagePerson,0)
        newMessage.fadingTime=80
      }
      else if sceneDelay=240 //World Rip 1
      {
        var tWorldRip;
        tWorldRip=instance_create(2656,1360,oSF_WorldRip)
      }
      else if sceneDelay>=290
      {
        msgCreate(0,0,"Jerry","Is that doing what I think it is?",0,1,oMessagePerson,0)
        newMessage.fadingTime=80
        sceneDelay=0; sceneProgress+=1
      }
    }
    else if sceneProgress=3 //World Rip 2
    {
      if oPlayer1.y<=1120
      {
        var tWorldRip;
        tWorldRip=instance_create(2560,896,oSF_WorldRip); tWorldRip.image_angle=255; tWorldRip.image_xscale=1.05; tWorldRip.image_yscale=1.05
        sceneProgress+=1
      }
    }
    else if sceneProgress=4 //World Rip 3
    {
      if oPlayer1.x<=2480
      {
        var tWorldRip;
        tWorldRip=instance_create(2144,1104,oSF_WorldRip); tWorldRip.image_angle=35; tWorldRip.image_xscale=1.05; tWorldRip.image_yscale=1.05
        sceneProgress+=1
      }
    }
    else if sceneProgress=5 //World Rip 4
    {
      if oPlayer1.x<=2048 and oPlayer1.y<=832
      {
        var tWorldRip;
        tWorldRip=instance_create(1872,736,oSF_WorldRip); tWorldRip.image_angle=175
        sceneProgress+=1
      }
    }
    else if sceneProgress=6 //World Rip 5
    {
      if oPlayer1.x<=1072 and oPlayer1.y<=800
      {
        var tWorldRip;
        tWorldRip=instance_create(1200,912,oSF_WorldRip); tWorldRip.image_angle=80; tWorldRip.image_xscale=0.9; tWorldRip.image_yscale=0.9
        instance_create(1408,752,oSF_Tile2)
        sceneProgress+=1
      }
    }
    else if sceneProgress=7 //World Rip 6
    {
      if oPlayer1.x<=752 and oPlayer1.y<=992
      {
        var tWorldRip;
        tWorldRip=instance_create(560,736,oSF_WorldRip); tWorldRip.image_angle=80; tWorldRip.image_xscale=1.05; tWorldRip.image_yscale=1.05
        sceneProgress+=1
      }
    }
    else if sceneProgress=8 //World Rip 7
    {
      if oPlayer1.x>=864 and oPlayer1.y<=704
      {
        var tWorldRip;
        tWorldRip=instance_create(1104,544,oSF_WorldRip); tWorldRip.image_angle=350
        sceneProgress+=1
      }
    }
    else if sceneProgress=9 //World Rip 8
    {
      if oPlayer1.x>=1120 and oPlayer1.y<=704
      {
        var tWorldRip;
        tWorldRip=instance_create(1344,336,oSF_WorldRip); tWorldRip.image_angle=70
        sceneProgress+=1
      }
    }
    else if sceneProgress=10 //World Rip 9
    {
      if oPlayer1.x<=656 and oPlayer1.y<=240
      {
        var tWorldRip;
        tWorldRip=instance_create(592,176,oSF_WorldRip); tWorldRip.image_angle=85; tWorldRip.image_xscale=0.95; tWorldRip.image_yscale=0.95
        sceneProgress+=1
      }
    }
    else if sceneProgress=11 //World Rip 10 - 11 (Key 1)
    {
      if !instance_exists((419826))
      {
        for(i=0;i<2;i+=1) {instance_create(176,176+(i*64),oSF_Tile4)}
        for(i=0;i<4;i+=1) {instance_create(1520+(i*64),1056,oSF_Tile4)}
        var tWorldRip;
        tWorldRip=instance_create(640,384,oSF_WorldRip); tWorldRip.image_angle=150; tWorldRip.image_xscale=1.1; tWorldRip.image_yscale=1.1
        tWorldRip=instance_create(512,576,oSF_WorldRip); tWorldRip.image_angle=220; tWorldRip.image_xscale=1.1; tWorldRip.image_yscale=1.1
        sceneProgress+=1
      }
    }
    else if sceneProgress=12 //World Rip 12
    {
      sceneDelay+=1
      if sceneDelay=15
      {
        msgCreate(0,0,"Jerry","What the hell? Platforms appearing too?",0,1,oMessagePerson,0)
        newMessage.fadingTime=90
      }
      else if sceneDelay>=20
      {
        if oPlayer1.x>=1104
        {
          var tWorldRip;
          tWorldRip=instance_create(1488,544,oSF_WorldRip); tWorldRip.image_angle=105; tWorldRip.image_xscale=0.95; tWorldRip.image_yscale=0.95
          sceneDelay=0; sceneProgress+=1
        }
      }
    }
    else if sceneProgress=13 //World Rip 13 - 14
    {
      if oPlayer1.x>=1488
      {
        var tWorldRip;
        tWorldRip=instance_create(1808,640,oSF_WorldRip); tWorldRip.image_angle=90
        tWorldRip=instance_create(1904,896,oSF_WorldRip); tWorldRip.image_angle=75
        sceneProgress+=1
      }
    }
    else if sceneProgress=14 //World Rip 15 - 17
    {
      if oPlayer1.y>=928
      {
        var tWorldRip;
        tWorldRip=instance_create(1920,1152,oSF_WorldRip); tWorldRip.image_angle=45
        tWorldRip=instance_create(1744,1200,oSF_WorldRip); tWorldRip.image_angle=125
        tWorldRip=instance_create(1408,1120,oSF_WorldRip); tWorldRip.image_angle=5
        sceneProgress+=1
      }
    }
    else if sceneProgress=15 //World Rip 18
    {
      if oPlayer1.x>=2016
      {
        var tWorldRip;
        tWorldRip=instance_create(2256,1376,oSF_WorldRip); tWorldRip.image_angle=325
        sceneProgress+=1
      }
    }
    else if sceneProgress=16 //(Key 2)
    {
      if !instance_exists((419469))
      {
        for(i=0;i<2;i+=1)
        {
          instance_create(2080,544-(i*64),oSF_Tile4)
        }
        for(i=0;i<6;i+=1)
        {
          instance_create(1600,96+(i*64),oSF_Tile4)
        }
        for(i=0;i<4;i+=1) {instance_create(1952-(i*64),384,oSF_Tile4)}
        sceneProgress+=1
      }
    }
    else if sceneProgress=17 //World Rip 19
    {
      if oPlayer1.y<=1440
      {
        var tWorldRip;
        tWorldRip=instance_create(2720,1136,oSF_WorldRip); tWorldRip.image_angle=300
        sceneProgress+=1
      }
    }
    else if sceneProgress=18 //World Rip 20
    {
      if oPlayer1.x<=2544 and oPlayer1.y<=1056
      {
        var tWorldRip;
        tWorldRip=instance_create(2112,848,oSF_WorldRip); tWorldRip.image_angle=55
        sceneProgress+=1
      }
    }
    else if sceneProgress=19 //World Rip 21
    {
      if oPlayer1.y<=576
      {
        var tWorldRip;
        tWorldRip=instance_create(1696,512,oSF_WorldRip); tWorldRip.image_angle=255
        sceneProgress+=1
      }
    }
    else if sceneProgress=20 //World Rip 22
    {
      if oPlayer1.x<=1872 and oPlayer1.y>=688
      {
        var tWorldRip;
        tWorldRip=instance_create(1600,1040,oSF_WorldRip); tWorldRip.image_angle=55
        sceneProgress+=1
      }
    }
    else if sceneProgress=21 //World Rip 23
    {
      if oPlayer1.x<=1424
      {
        var tWorldRip;
        tWorldRip=instance_create(1072,880,oSF_WorldRip); tWorldRip.image_angle=65
        sceneProgress+=1
      }
    }
    else if sceneProgress=22 //World Rip 24
    {
      if oPlayer1.x<=432
      {
        var tWorldRip;
        tWorldRip=instance_create(544,928,oSF_WorldRip); tWorldRip.image_angle=75
        sceneProgress+=1
      }
    }
    else if sceneProgress=23 //(Key 3)
    {
      if !instance_exists((419645))
      {
        var tRedSpike;
        tRedSpike=instance_create(1248,1328,oStaticSpikeRed); tRedSpike.image_xscale=3; tRedSpike.image_yscale=3
        tRedSpike=instance_create(1200,1328,oStaticSpikeRed); tRedSpike.image_xscale=3; tRedSpike.image_yscale=3
        tRedSpike=instance_create(1200,1376,oStaticSpikeRed); tRedSpike.image_xscale=3; tRedSpike.image_yscale=3
        sceneProgress+=1
      }
    }
    else if sceneProgress=24 //World Rip 25 - 27
    {
      if oPlayer1.y>=1168
      {
        var tWorldRip;
        tWorldRip=instance_create(304,1472,oSF_WorldRip); tWorldRip.image_angle=85
        tWorldRip=instance_create(576,1440,oSF_WorldRip); tWorldRip.image_angle=10
        tWorldRip=instance_create(464,1648,oSF_WorldRip); tWorldRip.image_angle=35
        sceneProgress+=1
      }
    }
    else if sceneProgress=25 //World Rip 28 - 33
    {
      if oPlayer1.x>=1264
      {
        var tWorldRip;
        tWorldRip=instance_create(1456,1424,oSF_WorldRip); tWorldRip.image_angle=100
        tWorldRip=instance_create(1616,1504,oSF_WorldRip); tWorldRip.image_angle=345
        tWorldRip=instance_create(1808,1600,oSF_WorldRip); tWorldRip.image_angle=0; tWorldRip.image_xscale=0.9; tWorldRip.image_yscale=0.9
        tWorldRip=instance_create(1952,1552,oSF_WorldRip); tWorldRip.image_angle=15; tWorldRip.image_xscale=0.9; tWorldRip.image_yscale=0.9
        tWorldRip=instance_create(2096,1584,oSF_WorldRip); tWorldRip.image_angle=355; tWorldRip.image_xscale=0.9; tWorldRip.image_yscale=0.9
        sceneProgress+=1
      }
    }
    else if sceneProgress=26 //World Rip 34
    {
      if oPlayer1.x>=1840 and oPlayer1.y<=1392
      {
        var tWorldRip;
        tWorldRip=instance_create(2080,1392,oSF_WorldRip); tWorldRip.image_angle=10; tWorldRip.image_xscale=0.9; tWorldRip.image_yscale=0.9
        sceneProgress+=1
      }
    }
    else if sceneProgress=27 //World Rip 35 - 36
    {
      if oPlayer1.x>=2416 and oPlayer1.y<=704
      {
        var tWorldRip;
        tWorldRip=instance_create(2704,432,oSF_WorldRip); tWorldRip.image_angle=120
        tWorldRip=instance_create(2496,304,oSF_WorldRip); tWorldRip.image_angle=5
        sceneProgress+=1
      }
    }
  }
}

keyWaitForInput()

if oKeyCodes.kCodePressed[11]=1 and global.gamePaused=true //Cutscene skip
{
  if !instance_exists(oPauseMenu)
  {
    if global.gameProgress=4790 and room=rSF_A //[1]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      fadeAlpha=0; sceneDelay=0
      sceneProgress=22
    }
    else if global.gameProgress=4890 and room=rSF_F //[2]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      fadeAlpha=0; sceneDelay=0
      sceneProgress=10
    }
    else if global.gameProgress=4900 and room=rSF_G //[3]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      fadeAlpha=0; sceneDelay=0
      sceneProgress=8
    }
    else if global.gameProgress=4910 and room=rSF_G //[4]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      fadeAlpha=0; sceneDelay=0
      sceneProgress=15
    }
    else if global.gameProgress=4920 and room=rSF_I //[5]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      fadeAlpha=0; sceneDelay=0
      sceneProgress=11
    }
  }
}
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
var tNewSpawn;
tNewSpawn=instance_create(0,0,oSF_BombEnemySpawn)
tNewSpawn.xSpawn=xSpawn
tNewSpawn.ySpawn=ySpawn
tNewSpawn.objSpawn=objSpawn
tNewSpawn.moveSpd=moveSpd
tNewSpawn.turnDelay=turnDelay
tNewSpawn.turnAmt=turnAmt
tNewSpawn.myDir=myDir
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

if dreamFigureA_Alpha>0
{
  draw_sprite_ext(dreamFigureA_Sprite,dreamFigureA_Frame,view_xview[0]+dreamFigureA_X,view_yview[0]+264,1.5*dreamFigureA_Facing,1.5,0,c_black,dreamFigureA_Alpha)
}
if dreamFigureB_Alpha>0
{
  draw_sprite_ext(dreamFigureB_Sprite,dreamFigureB_Frame,view_xview[0]+dreamFigureB_X,view_yview[0]+264,1.5*dreamFigureB_Facing,1.5,0,c_black,dreamFigureB_Alpha)
}
