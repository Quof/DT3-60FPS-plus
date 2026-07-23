#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
enemyCount=-1
fadeColor=c_black
fadeAlpha=0
xView=0; yView=64

if room=rGame6_DreamWoodsE
{
  background_index[6]=backStatic
  background_visible[6]=false
  background_foreground[6]=true
  background_alpha[6]=0.33
  background_hspeed[6]=31
  background_vspeed[6]=21
  staticVol=0.7
  staticTime=0
  PDAlpha=0.3
  abomAlpha=0.2
  abomTime=0
  PDTime=0
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if global.gameProgress=3650 and room=rGame6_DreamWoodsA //----- [A] -----
  {
    if sceneProgress=0
    {
      if oPlayer1.x>=592
      {
        xView=640
        sceneProgress=1
      }
    }
    else if sceneProgress=1
    {
      sceneDelay+=1
      if sceneDelay>=1 and sceneDelay<=20 {fadeAlpha+=0.025}
      else if sceneDelay=40
      {
        npc_A=instance_create(xView-48,yView+64,oMisc)
        npc_A.sprite_index=sClaireIdle; npc_A.image_speed=0; npc_A.image_alpha=0 npc_A.type=1; npc_A.image_blend=c_black; npc_A.depth=0
        npc_B=instance_create(xView-16,yView+64,oMisc)
        npc_B.sprite_index=sJerryIdle; npc_B.image_speed=0; npc_B.image_alpha=0 npc_B.type=1; npc_B.image_blend=c_black; npc_B.depth=0
        npc_C=instance_create(xView+16,yView+64,oMisc)
        npc_C.sprite_index=sChaoHumanForm; npc_C.image_speed=0; npc_C.image_alpha=0 npc_C.type=1; npc_C.image_blend=c_black; npc_C.depth=0
        npc_D=instance_create(xView+48,yView+64,oMisc)
        npc_D.sprite_index=sJeremyDream; npc_D.image_speed=0; npc_D.image_alpha=0 npc_D.type=1; npc_D.image_blend=c_black; npc_D.depth=0
      }
      else if sceneDelay>=41 and sceneDelay<=60 {npc_A.image_alpha+=0.025; npc_B.image_alpha+=0.025; npc_C.image_alpha+=0.025; npc_D.image_alpha+=0.025}
      else if sceneDelay=80 {createScreenText(xView,yView+84,90,fnt_EnemyName,fa_middle,"-Claire-#Where did he just send us?",3,c_white,0,0)}
      else if sceneDelay=170 {createScreenText(xView,yView+84,90,fnt_EnemyName,fa_middle,"-Jeremy-#He didn't send us anywhere.",3,c_white,0,0)}
      else if sceneDelay=260 {createScreenText(xView,yView+84,50,fnt_EnemyName,fa_middle,"-Claire-#What?",3,c_white,0,0)}
      else if sceneDelay=310
      {
        createScreenText(xView,yView+84,200,fnt_EnemyName,fa_middle,"-Jeremy-#The Overlord was about to send us through#that portal, but something else zapped us#here before he could do that.",3,c_white,0,0)
        msgCreate(0,0,"Jerry","Oh good, this place can show us flashbacks TO THINGS THAT JUST HAPPENED!!",0,2,oMessagePerson,0); newMessage.fadingTime=160
      }
      else if sceneDelay=510
      {
        createScreenText(xView,yView+84,90,fnt_EnemyName,fa_middle,"-Claire-#Do you know who did it?",3,c_white,0,0)
        msgCreate(0,0,"Jeremy","Bug maybe?",0,2,oMessagePerson,0); newMessage.fadingTime=70
      }
      else if sceneDelay=600
      {
        createScreenText(xView,yView+84,110,fnt_EnemyName,fa_middle,"-Jeremy-#No, and I've no idea where this place is.",3,c_white,0,0)
        msgCreate(0,0,"Chao","I told ya that someone would be trying to show us something!",0,2,oMessagePerson,0); newMessage.fadingTime=110
      }
      else if sceneDelay=710
      {
        createScreenText(xView,yView+84,90,fnt_EnemyName,fa_middle,"-Chao-#I think we're in a dream.",3,c_white,0,0)
        msgCreate(0,0,"Jerry","This isn't helping.",0,2,oMessagePerson,0); newMessage.fadingTime=70
      }
      else if sceneDelay=800
      {
        createScreenText(xView,yView+84,80,fnt_EnemyName,fa_middle,"-Jeremy-#That's silly.",3,c_white,0,0)
        msgCreate(0,0,"Jeremy","Meh, anyway, let's move on.",0,2,oMessagePerson,0); newMessage.fadingTime=80
      }
      else if sceneDelay=880 {createScreenText(xView,yView+84,180,fnt_EnemyName,fa_middle,"-Chao-#The weird effect, bad timing. This is a dream sequence.#It fits with the cliche of this whole place.",3,c_white,0,0)}
      else if sceneDelay=1060 {createScreenText(xView,yView+84,170,fnt_EnemyName,fa_middle,"-Jerry-#So the Overlord was going to send us to...#wherever, but something else sent us into a dream?",3,c_white,0,0)}
      else if sceneDelay=1230 {createScreenText(xView,yView+84,180,fnt_EnemyName,fa_middle,"-Chao-#I think whoever it was, wants to show us something.#Isn't that usually how these sorts of things work?",3,c_white,0,0)}
      else if sceneDelay=1410 {createScreenText(xView,yView+84,90,fnt_EnemyName,fa_middle,"-Jerry-#Sure but... eh, yes.",3,c_white,0,0)}
      else if sceneDelay=1500 {createScreenText(xView,yView+84,180,fnt_EnemyName,fa_middle,"-Jeremy-#Let's do this then.#Note that the rules of the world have not changed.#You can still lose in here.",3,c_white,0,0)}
      else if sceneDelay=1680 {createScreenText(xView,yView+84,90,fnt_EnemyName,fa_middle,"-Jerry-#Naturally.",3,c_white,0,0)}
      else if sceneDelay>=1791 and sceneDelay<=1810 {npc_A.image_alpha-=0.025; npc_B.image_alpha-=0.025; npc_C.image_alpha-=0.025; npc_D.image_alpha-=0.025}
      else if sceneDelay>=1831 and sceneDelay<=1850 {fadeAlpha-=0.025}
      else if sceneDelay>=1850
      {
        var tCheckAchieve;
        tCheckAchieve=string_char_at(global.tokenRecognitions,22)
        if tCheckAchieve="0"
        {
          var tAchievement;
          tAchievement=instance_create(0,0,oAchievementNotice)
          tAchievement.myAchievement="Double Cutscene"; tAchievement.checkNum=22
        }
        event_user(0)
        msgCreate(0,0,"Jeremy","Wow, you guys actually stood through all that.",0,2,oMessagePerson,0)
        newMessage.fadingTime=120
        global.gameProgress=3660
      }
    }
  }
  else if global.gameProgress=3660 and room=rGame6_DreamWoodsB //----- [B] -----
  {
    if sceneProgress=0
    {
      if oPlayer1.x>=752
      {
        xView=800
        sceneProgress=1
      }
    }
    else if sceneProgress=1
    {
      sceneDelay+=1
      if sceneDelay>=1 and sceneDelay<=20 {fadeAlpha+=0.025}
      else if sceneDelay=40
      {
        npc_A=instance_create(xView-32,yView+64,oMisc)
        npc_A.sprite_index=sJerryIdle; npc_A.image_speed=0; npc_A.image_alpha=0 npc_A.type=1; npc_A.image_blend=c_black; npc_A.depth=0
        npc_B=instance_create(xView+32,yView+64,oMisc)
        npc_B.sprite_index=sJeremyDream; npc_B.image_speed=0; npc_B.image_alpha=0 npc_B.type=1; npc_B.image_blend=c_black; npc_B.depth=0; npc_B.image_xscale=-1
      }
      else if sceneDelay>=41 and sceneDelay<=60 {npc_A.image_alpha+=0.025; npc_B.image_alpha+=0.025}
      else if sceneDelay=80 {createScreenText(xView,yView+84,150,fnt_EnemyName,fa_middle,"-Jerry-#Hey Jeremy! My mom got me the Super Nintendo yesterday!#You gotta come play it!",3,c_white,0,0)}
      else if sceneDelay=230 {createScreenText(xView,yView+84,140,fnt_EnemyName,fa_middle,"-Jeremy-#Awesome! I got grounded from my Sega for a week. A whole week!",3,c_white,0,0)}
      else if sceneDelay=370 {createScreenText(xView,yView+84,110,fnt_EnemyName,fa_middle,"-Jerry-#What did you do? You never get in trouble.",3,c_white,0,0)}
      else if sceneDelay=480 {createScreenText(xView,yView+84,120,fnt_EnemyName,fa_middle,"-Jeremy-#My dad caught me messing with his computer again.",3,c_white,0,0)}
      else if sceneDelay=600 {createScreenText(xView,yView+84,140,fnt_EnemyName,fa_middle,"-Jerry-#Super lame. Oh hey! For summer break,#do you wanna trade game systems?",3,c_white,0,0)}
      else if sceneDelay=740 {createScreenText(xView,yView+84,200,fnt_EnemyName,fa_middle,"-Jeremy-#I bet I can convince my dad to let me#bring my TV and Sega over to your place.#We can play everything together then!",3,c_white,0,0)}
      else if sceneDelay>=960 and sceneDelay<=980 {npc_A.image_alpha-=0.025; npc_B.image_alpha-=0.025}
      else if sceneDelay>=1001 and sceneDelay<=1020 {fadeAlpha-=0.025}
      else if sceneDelay>=1030 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=2
    {
      sceneDelay+=1
      if sceneDelay=10
      {
        msgCreate(0,0,"Jeremy","Aside from the fact that we were actually 10 at the time, the program got that right... which is damn creepy.",0,2,oMessagePerson,0)
        newMessage.fadingTime=140
      }
      else if sceneDelay=150
      {
        msgCreate(0,0,"Jerry","I still remember that summer. It was a great one.",0,1,oMessagePerson,0)
        newMessage.fadingTime=90
      }
      else if sceneDelay=240
      {
        event_user(0)
        global.gameProgress=3670
      }
    }
    if oPlayer1.x>=1440
    {
      event_user(0)
      global.gameProgress=3670
    }
  }
  else if global.gameProgress=3670 and room=rGame6_DreamWoodsB //----- [C] -----
  {
    if sceneProgress=0
    {
      if oPlayer1.x>=1728
      {
        xView=1776
        sceneProgress=1
      }
    }
    else if sceneProgress=1
    {
      sceneDelay+=1
      if sceneDelay>=1 and sceneDelay<=20 {fadeAlpha+=0.025}
      else if sceneDelay=40
      {
        npc_A=instance_create(xView-32,yView+64,oMisc)
        npc_A.sprite_index=sJerryIdle; npc_A.image_speed=0; npc_A.image_alpha=0 npc_A.type=1; npc_A.image_blend=c_black; npc_A.depth=0
        npc_B=instance_create(xView+32,yView+64,oMisc)
        npc_B.sprite_index=sJeremyDream; npc_B.image_speed=0; npc_B.image_alpha=0 npc_B.type=1; npc_B.image_blend=c_black; npc_B.depth=0; npc_B.image_xscale=-1
      }
      else if sceneDelay>=41 and sceneDelay<=60 {npc_A.image_alpha+=0.025; npc_B.image_alpha+=0.025}
      else if sceneDelay=80 {createScreenText(xView,yView+84,110,fnt_EnemyName,fa_middle,"-Jerry-#How's that PC you got last year?",3,c_white,0,0)}
      else if sceneDelay=190 {createScreenText(xView,yView+84,170,fnt_EnemyName,fa_middle,"-Jeremy-#My dad showed me a bunch of stuff and gave me#a compiler a few weeks ago!",3,c_white,0,0)}
      else if sceneDelay=360 {createScreenText(xView,yView+84,150,fnt_EnemyName,fa_middle,"-Jerry-#What's a compiler? Can a Mac even get those?",3,c_white,0,0)}
      else if sceneDelay>=510 and sceneDelay<=530 {npc_A.image_alpha-=0.025; npc_B.image_alpha-=0.025}
      else if sceneDelay>=551 and sceneDelay<=570 {fadeAlpha-=0.025}
      else if sceneDelay>=580 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=2
    {
      sceneDelay+=1
      if sceneDelay=10
      {
        msgCreate(0,0,"Jerry","You had that Mac for a long time.",0,1,oMessagePerson,0)
        newMessage.fadingTime=80
      }
      else if sceneDelay=90
      {
        msgCreate(0,0,"Jeremy","I hated that thing, NO GAMES!",0,1,oMessagePerson,0)
        newMessage.fadingTime=80
      }
      else if sceneDelay=170
      {
        sceneDelay=0; sceneProgress=0
        global.gameProgress=3680
      }
    }
    if oPlayer1.x>=2304
    {
      event_user(0)
      global.gameProgress=3680
    }
  }
  else if global.gameProgress=3680 and room=rGame6_DreamWoodsB //----- [] Enemy trap event -----
  {
    if sceneProgress=0
    {
      if oPlayer1.x>=2496
      {
        global.tempAction[0]=33
        var enemyCounter,enemyBarrier;
        enemyCounter=instance_create(0,0,oEnemyRemain)
        enemyCounter.enemyCount=7
        enemyBarrier=instance_create(2304,-48,oEnemyBarrier); enemyBarrier.image_yscale=18
        enemyBarrier=instance_create(2662,-48,oEnemyBarrier); enemyBarrier.image_yscale=18
        sceneProgress+=1
      }
    }
    else if sceneProgress=1
    {
      sceneDelay+=1
      if sceneDelay=10
      {
        delaySpawn(2432,272,oPT_Skeleton,2,1,1,0.33)
        delaySpawn(2560,272,oPT_Skeleton,2,1,1,0.33)
      }
      else if sceneDelay>=20
      {
        if oEnemyRemain.enemyCount<=5 {sceneDelay=0; sceneProgress+=1}
      }
    }
    else if sceneProgress=2
    {
      sceneDelay+=1
      if sceneDelay=10
      {
        delaySpawn(2432,64,oPT_IceSpirit,2,1,1,0.33)
      }
      else if sceneDelay=30
      {
        delaySpawn(2560,64,oPT_IceSpirit,2,1,1,0.33)
      }
      else if sceneDelay=50
      {
        delaySpawn(2496,160,oPT_IceSpirit,2,1,1,0.33)
      }
      else if sceneDelay>=60
      {
        if oEnemyRemain.enemyCount<=2 {sceneDelay=0; sceneProgress+=1}
      }
    }
    else if sceneProgress=3
    {
      sceneDelay+=1
      if sceneDelay=10
      {
        delaySpawn(2496,272,oPT_Skeleton,2,1,1,0.33)
        delaySpawn(2496,144,oPT_FireEye,2,1,1,0.33)
      }
      else if sceneDelay>=20
      {
        if oEnemyRemain.enemyCount<=0
        {
          with oEnemyBarrier {instance_destroy()}
          with oEnemyRemain {instance_destroy()}
          sceneDelay=0; sceneProgress=0
          global.gameProgress=3690
        }
      }
    }
  }
  else if global.gameProgress=3690 and room=rGame6_DreamWoodsC //----- [] Enemy trap event -----
  {
    if sceneProgress=0
    {
      if oPlayer1.x>=336
      {
        global.tempAction[0]=34
        var enemyCounter,enemyBarrier;
        enemyCounter=instance_create(0,0,oEnemyRemain)
        enemyCounter.enemyCount=3
        enemyBarrier=instance_create(192,-48,oEnemyBarrier); enemyBarrier.image_yscale=20
        enemyBarrier=instance_create(464,-48,oEnemyBarrier); enemyBarrier.image_yscale=18
        sceneProgress+=1
      }
    }
    else if sceneProgress=1
    {
      sceneDelay+=1
      if sceneDelay=10
      {
        delaySpawn(288,240,oPT_Skeleton,2,1,1,0.33)
      }
      else if sceneDelay>=20
      {
        if oEnemyRemain.enemyCount<=2 {sceneDelay=0; sceneProgress+=1}
      }
    }
    else if sceneProgress=2
    {
      sceneDelay+=1
      if sceneDelay=10
      {
        delaySpawn(240,144,oPT_IceSpirit,2,1,1,0.33)
        delaySpawn(432,112,oPT_FireEye,2,1,1,0.33)
      }
      else if sceneDelay>=20
      {
        if oEnemyRemain.enemyCount<=0
        {
          with oEnemyBarrier {instance_destroy()}
          with oEnemyRemain {instance_destroy()}
          sceneDelay=0; sceneProgress=0
          global.gameProgress=3700
        }
      }
    }
  }
  else if global.gameProgress=3700 and room=rGame6_DreamWoodsC //----- [D] -----
  {
    if sceneProgress=0
    {
      if oPlayer1.x>=1184
      {
        xView=1232
        sceneProgress=1
      }
    }
    else if sceneProgress=1
    {
      sceneDelay+=1
      if sceneDelay>=1 and sceneDelay<=20 {fadeAlpha+=0.025}
      else if sceneDelay=40
      {
        npc_A=instance_create(xView-32,yView+64,oMisc)
        npc_A.sprite_index=sJeremyDream; npc_A.image_speed=0; npc_A.image_alpha=0 npc_A.type=1; npc_A.image_blend=c_black
        npc_B=instance_create(xView+32,yView+64,oMisc)
        npc_B.sprite_index=sChaoHumanForm; npc_B.image_speed=0; npc_B.image_alpha=0 npc_B.type=1; npc_B.image_blend=c_black; npc_B.image_xscale=-1
      }
      else if sceneDelay>=41 and sceneDelay<=60 {npc_A.image_alpha+=0.025; npc_B.image_alpha+=0.025}
      else if sceneDelay=80 {createScreenText(xView,yView+84,120,fnt_EnemyName,fa_middle,"-Jeremy-#Sis, did you rewrite some of my project code?",3,c_white,0,0)}
      else if sceneDelay=200 {createScreenText(xView,yView+84,160,fnt_EnemyName,fa_middle,"-Chao-#Yea... I fixed the exception handling that was causing a few bugs.",3,c_white,0,0)}
      else if sceneDelay=360 {createScreenText(xView,yView+84,90,fnt_EnemyName,fa_middle,"-Jeremy-#I was getting to it!",3,c_white,0,0)}
      else if sceneDelay=450 {createScreenText(xView,yView+84,140,fnt_EnemyName,fa_middle,"-Chao-#I just wanted to help. Your project is really cool!",3,c_white,0,0)}
      else if sceneDelay=590 {createScreenText(xView,yView+84,140,fnt_EnemyName,fa_middle,"-Jeremy-#Well, thanks... Just show me what you changed, okay?",3,c_white,0,0)}
      else if sceneDelay=730 {createScreenText(xView,yView+84,120,fnt_EnemyName,fa_middle,"-Chao-#Sure! This is going to be the best game ever!",3,c_white,0,0)}
      else if sceneDelay>=850 and sceneDelay<=870 {npc_A.image_alpha-=0.025; npc_B.image_alpha-=0.025}
      else if sceneDelay>=891 and sceneDelay<=910 {fadeAlpha-=0.025}
      else if sceneDelay>=920 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=2
    {
      sceneDelay+=1
      if sceneDelay=10
      {
        msgCreate(0,0,"Jerry","I remember you showing me a game you made.",0,1,oMessagePerson,0)
        newMessage.fadingTime=90
      }
      else if sceneDelay=100
      {
        msgCreate(0,0,"Jeremy","Yeah, it wasn't very good, but I had fun making it.",0,1,oMessagePerson,0)
        newMessage.fadingTime=100
      }
      else if sceneDelay=200
      {
        msgCreate(0,0,"Chao","And we got to work on it together!",0,1,oMessagePerson,0)
        newMessage.fadingTime=80
      }
      else if sceneDelay=280
      {
        sceneDelay=0; sceneProgress=0
        global.gameProgress=3710
      }
    }
    if oPlayer1.x>=1584
    {
      event_user(0)
      global.gameProgress=3710
    }
  }
  else if global.gameProgress=3710 and room=rGame6_DreamWoodsC //----- [] Enemy trap event -----
  {
    if sceneProgress=0
    {
      if oPlayer1.x>=2288
      {
        global.tempAction[0]=35
        var enemyCounter,enemyBarrier;
        enemyCounter=instance_create(0,0,oEnemyRemain)
        enemyCounter.enemyCount=10
        enemyBarrier=instance_create(2048,-48,oEnemyBarrier); enemyBarrier.image_yscale=22
        enemyBarrier=instance_create(2624,-48,oEnemyBarrier); enemyBarrier.image_yscale=20
        sceneProgress+=1
      }
    }
    else if sceneProgress=1
    {
      sceneDelay+=1
      if sceneDelay=10
      {
        delaySpawn(2096,304,oPT_Skeleton,2,1,1,0.33)
        delaySpawn(2480,272,oPT_Skeleton,2,1,1,0.33)
      }
      else if sceneDelay>=20
      {
        if oEnemyRemain.enemyCount<=8 {sceneDelay=0; sceneProgress+=1}
      }
    }
    else if sceneProgress=2
    {
      sceneDelay+=1
      if sceneDelay=10
      {
        delaySpawn(2096,128,oPT_FireEye,2,1,1,0.33)
      }
      else if sceneDelay=30
      {
        delaySpawn(2368,96,oPT_FireEye,2,1,1,0.33)
      }
      else if sceneDelay=50
      {
        delaySpawn(2544,224,oPT_FireEye,2,1,1,0.33)
      }
      else if sceneDelay>=60
      {
        if oEnemyRemain.enemyCount<=5 {sceneDelay=0; sceneProgress+=1}
      }
    }
    else if sceneProgress=3
    {
      sceneDelay+=1
      if sceneDelay=10
      {
        delaySpawn(2096,304,oPT_Skeleton,2,1,1,0.33)
        delaySpawn(2096,128,oPT_FireEye,2,1,1,0.33)
      }
      else if sceneDelay=60
      {
        delaySpawn(2368,96,oPT_IceSpirit,2,1,1,0.33)
      }
      else if sceneDelay=110
      {
        delaySpawn(2480,272,oPT_Skeleton,2,1,1,0.33)
        delaySpawn(2544,224,oPT_FireEye,2,1,1,0.33)
      }
      else if sceneDelay>=120
      {
        if oEnemyRemain.enemyCount<=0
        {
          with oEnemyBarrier {instance_destroy()}
          with oEnemyRemain {instance_destroy()}
          sceneDelay=0; sceneProgress=0
          global.gameProgress=3720
        }
      }
    }
  }
  else if global.gameProgress=3720 and room=rGame6_DreamWoodsD //----- [E] -----
  {
    if sceneProgress=0
    {
      if oPlayer1.x>=224
      {
        xView=256
        sceneProgress=1
      }
    }
    else if sceneProgress=1
    {
      sceneDelay+=1
      if sceneDelay>=1 and sceneDelay<=20 {fadeAlpha+=0.025}
      else if sceneDelay=40
      {
        npc_A=instance_create(xView-32,yView+64,oMisc)
        npc_A.sprite_index=sClaireIdle; npc_A.image_speed=0; npc_A.image_alpha=0 npc_A.type=1; npc_A.image_blend=c_black
        npc_B=instance_create(xView+32,yView+64,oMisc)
        npc_B.sprite_index=sChaoHumanForm; npc_B.image_speed=0; npc_B.image_alpha=0 npc_B.type=1; npc_B.image_blend=c_black; npc_B.image_xscale=-1
      }
      else if sceneDelay>=41 and sceneDelay<=60 {npc_A.image_alpha+=0.025; npc_B.image_alpha+=0.025}
      else if sceneDelay=80 {createScreenText(xView,yView+84,120,fnt_EnemyName,fa_middle,"-Chao-#I saw you looking at Jerry last time everyone was over here.",3,c_white,0,0)}
      else if sceneDelay=200 {createScreenText(xView,yView+84,160,fnt_EnemyName,fa_middle,"-Claire-#Yeah, he's kinda cute and when#he's not being mean, he's...",3,c_white,0,0)}
      else if sceneDelay>=201 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=2
    {
      sceneDelay+=1
      if sceneDelay>=10 and sceneDelay<=120
      {
        if sceneDelay mod 4=0
        {
          msgCreate(32+random(240),144+random(48),"Claire","Nope!",0,0,oMessagePerson,0); newMessage.fadingTime=80; newMessage.depth=-101
        }
      }
      else if sceneDelay>=121 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=3
    {
      sceneDelay+=1
      if sceneDelay>=1 and sceneDelay<=20 {npc_A.image_alpha-=0.025; npc_B.image_alpha-=0.025}
      else if sceneDelay>=41 and sceneDelay<=60 {fadeAlpha-=0.025}
      else if sceneDelay>=70 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=4
    {
      sceneDelay+=1
      if sceneDelay=10
      {
        msgCreate(0,0,"Jerry","I wanted to see that one.",0,1,oMessagePerson,0)
        newMessage.fadingTime=90
      }
      else if sceneDelay=100
      {
        msgCreate(0,0,"Claire","Nope, skipping that. NEXT!",0,1,oMessagePerson,0)
        newMessage.fadingTime=90
      }
      else if sceneDelay=190
      {
        sceneDelay=0; sceneProgress=0
        global.gameProgress=3730
      }
    }
    if oPlayer1.x>=672
    {
      event_user(0)
      global.gameProgress=3730
    }
  }
  else if global.gameProgress=3730 and room=rGame6_DreamWoodsD //----- [] Enemy trap event -----
  {
    if sceneProgress=0
    {
      if oPlayer1.x>=1024
      {
        global.tempAction[0]=36
        var enemyCounter,enemyBarrier;
        enemyCounter=instance_create(0,0,oEnemyRemain)
        enemyCounter.enemyCount=10
        enemyBarrier=instance_create(816,-48,oEnemyBarrier); enemyBarrier.image_yscale=22
        enemyBarrier=instance_create(1248,-48,oEnemyBarrier); enemyBarrier.image_yscale=22
        sceneProgress+=1
      }
    }
    else if sceneProgress=1
    {
      sceneDelay+=1
      if sceneDelay=10
      {
        delaySpawn(928,304,oPT_Skeleton,2,1,1,0.33)
        delaySpawn(1152,304,oPT_Slime,2,1,1,0.33)
        delaySpawn(1120,128,oPT_FireEye,2,1,1,0.33)
      }
      else if sceneDelay>=20
      {
        if oEnemyRemain.enemyCount<=7 {sceneDelay=0; sceneProgress+=1}
      }
    }
    else if sceneProgress=2
    {
      sceneDelay+=1
      if sceneDelay=10
      {
        delaySpawn(944,96,oPT_IceSpirit,2,1,1,0.33)
        delaySpawn(1120,128,oPT_FireEye,2,1,1,0.33)
        delaySpawn(1024,224,oPT_IceSpirit,2,1,1,0.33)
      }
      else if sceneDelay>=20
      {
        if oEnemyRemain.enemyCount<=4 {sceneDelay=0; sceneProgress+=1}
      }
    }
    else if sceneProgress=3
    {
      sceneDelay+=1
      if sceneDelay=10
      {
        delaySpawn(928,304,oPT_Skeleton,2,1,1,0.33)
        delaySpawn(1152,304,oPT_Skeleton,2,1,1,0.33)
      }
      else if sceneDelay=50
      {
        delaySpawn(944,96,oPT_FireEye,2,1,1,0.33)
        delaySpawn(1024,224,oPT_IceSpirit,2,1,1,0.33)
      }
      else if sceneDelay>=60
      {
        if oEnemyRemain.enemyCount<=0
        {
          with oEnemyBarrier {instance_destroy()}
          with oEnemyRemain {instance_destroy()}
          sceneDelay=0; sceneProgress=0
          global.gameProgress=3740
        }
      }
    }
  }
  if global.gameProgress=3740 and room=rGame6_DreamWoodsD //----- [Characters Talk] -----
  {
    if sceneProgress=0
    {
      if oPlayer1.x>=1536 {sceneProgress=1}
    }
    else if sceneProgress=1
    {
      sceneDelay+=1
      if sceneDelay=10
      {
        msgCreate(0,0,"Claire","What's with these?",0,1,oMessagePerson,0)
        newMessage.fadingTime=60
      }
      else if sceneDelay=70
      {
        msgCreate(0,0,"Chao","Someone is trying to show us something. It's probably just leading us up to that.",0,2,oMessagePerson,0)
        newMessage.fadingTime=140
      }
      else if sceneDelay=210
      {
        msgCreate(0,0,"Claire","But are these others really necessary?",0,1,oMessagePerson,0)
        newMessage.fadingTime=90
      }
      else if sceneDelay=300
      {
        msgCreate(0,0,"Chao","Maybe it's having trouble finding the right memory.",0,1,oMessagePerson,0)
        newMessage.fadingTime=110
      }
      else if sceneDelay>=410
      {
        sceneDelay=0; sceneProgress=0
        global.gameProgress=3750
      }
    }
  }
  else if global.gameProgress=3750 and room=rGame6_DreamWoodsE //----- [Jerry/Claire Vision from the Vault] -----
  {
    if sceneProgress=0
    {
      if oPlayer1.x>=1680
      {
        global.canCharSwap=1
        oPlayer1.runAcc*=0.5; oPlayer1.initialJumpAcc*=0.5; oPlayer1.doubleJumpAcc*=0.5
        npc_PDImageA=instance_create(view_xview[0]+240,view_yview[0]+160,oMisc)
        npc_PDImageA.sprite_index=sAbom_ParasiteA; npc_PDImageA.image_alpha=0
        npc_PDImageA.type=1; npc_PDImageA.depth=0
        npc_PDImageB=instance_create(view_xview[0]+240,view_yview[0]+160,oMisc)
        npc_PDImageB.sprite_index=sAbom_ParasiteA; npc_PDImageB.image_alpha=0
        npc_PDImageB.type=1; npc_PDImageB.depth=0
        npc_AbomImage=instance_create(view_xview[0]+240,view_yview[0]+192,oMisc)
        npc_AbomImage.sprite_index=sAbom_Base; npc_AbomImage.image_alpha=0
        npc_AbomImage.type=1; npc_AbomImage.depth=0; npc_AbomImage.image_xscale=2; npc_AbomImage.image_yscale=2
        with (333247) {instance_destroy()}; with (333248) {instance_destroy()}
        stopAllMusic()
        staticTime=29; sceneProgress+=1
      }
    }
    else if sceneProgress=1
    {
      if oPlayer1.x>=1984
      {
        staticTime=129; abomAlpha=0.3; sceneProgress+=1
      }
    }
    else if sceneProgress=2
    {
      if oPlayer1.x>=2272
      {
        staticTime=129; abomAlpha=0.4; sceneProgress+=1
      }
    }
    else if sceneProgress=3
    {
      if oPlayer1.x>=2448
      {
        staticTime=129; abomAlpha=0.5; sceneProgress+=1
      }
    }
    else if sceneProgress=4
    {
      sceneDelay+=1
      if sceneDelay=20 {staticTime=129; background_alpha[6]=0.4; PDAlpha=0.35; staticVol=0.75}
      else if sceneDelay=40 {staticTime=129; background_alpha[6]=0.5; PDAlpha=0.4; staticVol=0.8}
      else if sceneDelay=60 {staticTime=129; background_alpha[6]=0.6; PDAlpha=0.45; staticVol=0.9}
      else if sceneDelay=80 {staticTime=129; background_alpha[6]=0.7; PDAlpha=0.5; staticVol=1}
      else if sceneDelay>=81 and sceneDelay<=100
      {
        if sceneDelay mod 3=0
        {
          staticTime=129
          createScreenText(64+irandom(304),irandom(304),45,fnt_Chapter,fa_middle,"EVERYONE WILL DIE",3,c_red,1,0)
        }
      }
      else if sceneDelay>=105
      {
        var tFlash;
        tFlash=instance_create(0,0,oScreenFlash); tFlash.fadeSpeed=0.02
        global.canCharSwap=2
        oPlayer1.runAcc*=2; oPlayer1.initialJumpAcc*=2; oPlayer1.doubleJumpAcc*=2
        background_visible[6]=false
        with npc_PDImageA {instance_destroy()}
        with npc_PDImageB {instance_destroy()}
        with npc_AbomImage {instance_destroy()}
        sceneDelay=0; sceneProgress=0
        global.gameProgress=3760
      }
    }

    if sceneProgress>=1 //Static
    {
      staticTime+=1
      if staticTime=30
      {
        playSound(global.snd_Static,0,0.8,1)
        background_visible[6]=true
      }
      else if staticTime=45
      {
        background_visible[6]=false
        staticTime=irandom(15)
      }
      else if staticTime=130
      {
        playSound(global.snd_Static,0,staticVol,1)
        background_visible[6]=true
        npc_PDImageA.image_alpha=PDAlpha; npc_PDImageA.x=view_xview[0]+240; npc_PDImageA.y=view_yview[0]+160
      }
      else if staticTime=134
      {
        npc_PDImageA.image_alpha=0
        background_visible[6]=false
        staticTime=irandom(15)
      }

      abomTime+=1
      if abomTime=50
      {
        npc_AbomImage.image_alpha=abomAlpha
        npc_AbomImage.x=view_xview[0]+240; npc_AbomImage.y=view_yview[0]+192
      }
      else if abomTime=54
      {
        npc_AbomImage.image_alpha=0
        abomTime=irandom(15)
      }

      PDTime+=1
      if PDTime=70
      {
        npc_PDImageB.image_alpha=0.35
        npc_PDImageB.x=view_xview[0]+240; npc_PDImageB.y=view_yview[0]+288
      }
      else if PDTime=73
      {
        npc_PDImageB.image_alpha=0
        PDTime=irandom(15)
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
with oMisc {instance_destroy()}
with oMessagePerson {instance_destroy()}
fadeAlpha=0
sceneDelay=0; sceneProgress=0
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
  draw_rectangle(xView-64,yView,xView+64,yView+80,0)
}
