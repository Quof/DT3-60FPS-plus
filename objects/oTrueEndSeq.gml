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

global.optShowHUD=0
global.gamePaused=1

jeremyLaser=0
laserScaleY=1
scaleUp=0.9

messageToDisplay=""
messageAlpha=0
messageX=240
messageY=80

messageTheEndA=0
messageTheEndB=0

scrollView=1
dtAlpha=0
thanksAlpha=0
pressAnyAlpha=0

darkModeText=0

if room=rTrueEnd_A
{
  oPlayer1.visible=0
  oPlayer1.sprite_index=sJeremyMechJump
}
else if room=rTrueEnd_B
{
  oPlayer1.visible=0
  fadeColor=c_black
  fadeAlpha=1
}
else if room=rTrueEnd_C
{
  oPlayer1.visible=0
  fadeColor=c_black
  fadeAlpha=1

  charJerry=instance_create(352,240,oMisc)
  charJerry.sprite_index=sJerrySit; charJerry.image_speed=0; charJerry.type=2
  charClaire=instance_create(240,240,oMisc)
  charClaire.sprite_index=sClaireSitUp; charClaire.image_index=2; charClaire.image_speed=0; charClaire.image_xscale=-1; charClaire.type=2
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if room=rTrueEnd_A //------------------------------ [] End A ------------------------------
{
  if sceneProgress=0
  {
    sceneDelay+=1
    if sceneDelay>=30
    {
      fadeAlpha-=0.05
      if fadeAlpha<=0 {fadeColor=c_black; sceneDelay=0; sceneProgress+=1}
    }
  }
  else if sceneProgress=1
  {
    sceneDelay+=1
    if sceneDelay=90
    {
      global.gameProgress=5650
      playSound(global.snd_Dec_Fire,0,1,15000)
      playSound(global.snd_GravityShot,0,1,15000)
      (466949).sprite_index=sJerrySit;
      var tFlash;
      tFlash=instance_create(0,0,oScreenFlash); tFlash.fadeSpeed=0.2
      jeremyLaser=1
    }
    else if sceneDelay=105
    {
      msgCreate(60,80,"Jerry","What the... hell?",0,1,oMessagePerson,0)
      newMessage.fadingTime=60
    }
    else if sceneDelay>=160 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=2
  {
    sceneDelay+=1
    if sceneDelay=10
    {
      playSound(global.snd_LightballSpread,0,0.95,13000)
      playSound(global.snd_Shock,0,0.88,32000)
      var tFlash;
      tFlash=instance_create(0,0,oScreenFlash); tFlash.fadeSpeed=0.2
      oPlayer1.image_xscale=-1
      oPlayer1.visible=1
      jeremyVelY=-7
      jeremyLaser=0
      with oDistortionDoorEf {instance_destroy()}
      with oDistortionGate
      {
        var tEffect,tFFScl,tFFDir;
        for(i=0;i<96;i+=1)
        {
          tFFScl=random(0.2)
          tFFDir=random(360)
          tEffect=instance_create(x,y,oEffectB)
          tEffect.type=3; tEffect.sprite_index=sEfFirefly; tEffect.newBlend=1
          tEffect.image_alpha=0.5; tEffect.image_xscale=0.1+tFFScl; tEffect.image_yscale=0.1+tFFScl
          tEffect.direction=tFFDir-180; tEffect.speed=11.9
          tEffect.fadeSpd=0.05; tEffect.AccelX=0; tEffect.AccelY=0; tEffect.followID=-1; tEffect.rotation=0
        }
        instance_destroy()
      }
    }
    else if sceneDelay>=11
    {
      if jeremyVelY<7 {jeremyVelY+=0.33}
      oPlayer1.y+=jeremyVelY

      if sceneDelay=20 {(466949).sprite_index=sJerryIdle;}

      if sceneDelay>20
      {
        if oPlayer1.y>=304
        {
          oPlayer1.sprite_index=sJeremyMechIdle
          oPlayer1.y=304
          sceneDelay=0; sceneProgress+=1
        }
      }
    }
  }
  else if sceneProgress=3
  {
    sceneDelay+=1
    if sceneDelay>=35 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Sooo... I take it you won.",0,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","You could say that. Basically I-",0,3,oMessageCutscene,1)
  else if sceneProgress=6 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Nope, I got it. I don't want a ten message box explanation.",0,3,oMessageCutscene,1)
  else if sceneProgress=7
  {
    sceneDelay+=1
    if sceneDelay>=35 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=8 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Glad you made it out, buddy.",0,3,oMessageCutscene,1)
  else if sceneProgress=9 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Glad I could be back...",0,3,oMessageCutscene,1)
  else if sceneProgress=10 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Eh, where's Claire and my sister?",0,3,oMessageCutscene,1)
  else if sceneProgress=11 and bWaitForInput=false
    msgCreate(0,0,"Jerry","They're here. Just waiting for you back there.",0,3,oMessageCutscene,1)
  else if sceneProgress=12 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Everyone's here, good.#You guys figure out what we're doing next?",0,3,oMessageCutscene,1)
  else if sceneProgress=13 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Uhhh, I'd like to rest for once.",0,3,oMessageCutscene,1)
  else if sceneProgress=14 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","I was thinking of traveling. This program is huge!",0,3,oMessageCutscene,1)
  else if sceneProgress=15 and bWaitForInput=false
    msgCreate(0,0,"Jerry","I was thinking of relaxing first. We've been going at this for what feels like forever.",0,3,oMessageCutscene,1)
  else if sceneProgress=16 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Dang, I'm ready to go now.",0,3,oMessageCutscene,1)
  else if sceneProgress=17 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Says the guy who only had to do the one thing... other than all that hacking stuff you do.",0,3,oMessageCutscene,1)
  else if sceneProgress=18 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Exactly. I'm ready for more!",0,3,oMessageCutscene,1)
  else if sceneProgress=19 and bWaitForInput=false
    msgCreate(0,0,"Jerry","After resting though.",0,3,oMessageCutscene,1)
  else if sceneProgress=20 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Alright, fair enough.",0,3,oMessageCutscene,1)
  else if sceneProgress=21
  {
    sceneDelay+=1
    if sceneDelay>=30
    {
      fadeAlpha+=0.02
      if fadeAlpha>=1 {sceneDelay=0; sceneProgress+=1}
    }
  }
  else if sceneProgress=22
  {
    sceneDelay+=1
    if sceneDelay>=10
    {
      global.newMapX=0; global.newMapY=0
      room_goto(rTrueEnd_B)
    }
  }
}
else if room=rTrueEnd_B //------------------------------ [] End B ------------------------------
{
  if sceneProgress=0
  {
    sceneDelay+=1
    if sceneDelay=30
    {
      view_object[0]=noone
      view_xview[0]=0

      var tempMplay;
      tempMplay=findMusic(1027)
      playMusic(tempMplay,0,0)
    }
    if sceneDelay>=30
    {
      fadeAlpha-=0.05
      if fadeAlpha<=0 {sceneDelay=0; sceneProgress+=1}
    }
  }
  else if sceneProgress=1 //----- SCENE 1 -----
  {
    if global.modeDark=1
    {
      darkModeText+=1
      if darkModeText=60
      {
        msgCreate(60,280,"Jerry","Oh cool, an ending sequence we can't even see.",0,2,oMessagePerson,0); newMessage.fadingTime=120
      }
      else if darkModeText=180
      {
        msgCreate(60,280,"Jerry","Like seriously, \#fixyourgame",0,2,oMessagePerson,0); newMessage.fadingTime=80
      }
      else if darkModeText=260
      {
        msgCreate(60,280,"Claire","What are you complaining about?",0,2,oMessagePerson,0); newMessage.fadingTime=100
      }
      else if darkModeText=360
      {
        msgCreate(60,280,"Claire","Oh...",0,2,oMessagePerson,0); newMessage.fadingTime=60
      }
      else if darkModeText=420
      {
        msgCreate(60,280,"Claire","Hey, a few birds were added to this sequence.",0,2,oMessagePerson,0); newMessage.fadingTime=120
      }
      else if darkModeText=540
      {
        msgCreate(60,280,"Jerry","It's a bandaid fix that doesn't fix anything.",0,2,oMessagePerson,0); newMessage.fadingTime=120
      }
    }

    sceneDelay+=1
    if sceneDelay>=20
    {
      if scrollView=1 {view_xview[0]+=1}

      if sceneDelay=50
      {
        myNPC_A=instance_create(-8,288,oNPC_End_A); myNPC_A.type=0
        myNPC_A=instance_create(1120,288,oNPC_End_A); myNPC_A.type=0; myNPC_A.image_xscale=-1
      }

      if view_xview[0]>=668
      {
        view_xview[0]=668
        darkModeText=0
        sceneDelay=0; sceneProgress+=1
      }
    }
  }
  else if sceneProgress=2
  {
    sceneDelay+=1
    if sceneDelay>=10 and sceneDelay<=99
    {
      fadeAlpha+=0.05
      if fadeAlpha>=1 {sceneDelay=100}
    }
    else if sceneDelay=105
    {
      view_xview[0]=1152
      with oNPC_End_A {instance_destroy()}
      with oBackgroundFollow {instance_destroy()}
      backFollow=instance_create(0,0,oBackgroundFollow)
      backFollow.type=2; backFollow.backSet=backBurningStretchA
      backFollow.xMoveScale=0.6; backFollow.yMoveScale=0.92; backFollow.depth=1499999
    }
    else if sceneDelay>=110
    {
      fadeAlpha-=0.05
      if fadeAlpha<=0 {sceneDelay=0; sceneProgress+=1}
    }
  }
  else if sceneProgress=3 //----- SCENE 2 -----
  {
    if global.modeDark=1
    {
      darkModeText+=1
      if darkModeText=10
      {
        msgCreate(60,280,"Jerry","Agreed and...",0,2,oMessagePerson,0); newMessage.fadingTime=50
      }
      else if darkModeText=160
      {
        msgCreate(60,280,"Claire","And what?",0,2,oMessagePerson,0); newMessage.fadingTime=60
      }
      else if darkModeText=220
      {
        msgCreate(60,280,"Jerry","They're talking, I'm trying not to be rude.",0,2,oMessagePerson,0); newMessage.fadingTime=120
      }
      else if darkModeText=340
      {
        msgCreate(60,280,"Claire","You? Trying not to be rude?",0,2,oMessagePerson,0); newMessage.fadingTime=90
      }
      else if darkModeText=430
      {
        msgCreate(60,280,"Jerry","It's character growth, Claire. You might try it sometime.",0,2,oMessagePerson,0); newMessage.fadingTime=140
      }
    }

    sceneDelay+=1
    if sceneDelay>=20
    {
      if sceneDelay=30
      {
        msgCreate(60,80,"Warmaster","I could use your help with CHAOS.",0,1,oMessagePerson,0)
        newMessage.fadingTime=60
      }
      else if sceneDelay=90
      {
        msgCreate(60,80,"John","I'd like to help, honestly. There's a lot of good we could do together.",0,2,oMessagePerson,0)
        newMessage.fadingTime=90
      }
      else if sceneDelay=100
      {
        scrollView=0
      }
      else if sceneDelay=180
      {
        msgCreate(60,80,"Warmaster","I have my bots helping to expand Central City as well as rebuild Neo Grime.",0,2,oMessagePerson,0)
        newMessage.fadingTime=100
      }
      else if sceneDelay=280
      {
        msgCreate(60,80,"John","You ever thought about a name change for it?",0,1,oMessagePerson,0)
        newMessage.fadingTime=60
      }
      else if sceneDelay=340
      {
        msgCreate(60,80,"Warmaster","It's a work in progress.",0,1,oMessagePerson,0)
        newMessage.fadingTime=50
      }
      else if sceneDelay=350
      {
        scrollView=1
      }

      if scrollView=1 {view_xview[0]+=1}
      if view_xview[0]>=1452
      {
        view_xview[0]=1452
        darkModeText=0
        sceneDelay=0; sceneProgress+=1
      }
    }
  }
  else if sceneProgress=4
  {
    sceneDelay+=1
    if sceneDelay>=10 and sceneDelay<=99
    {
      fadeAlpha+=0.05
      if fadeAlpha>=1 {sceneDelay=100}
    }
    else if sceneDelay=105
    {
      view_xview[0]=1936
      with oBackgroundFollow {instance_destroy()}
      backFollow=instance_create(0,0,oBackgroundFollow)
      backFollow.type=2; backFollow.backSet=backMeadeland1
      backFollow.xMoveScale=0.6; backFollow.yMoveScale=1; backFollow.depth=1499999
    }
    else if sceneDelay>=110
    {
      fadeAlpha-=0.05
      if fadeAlpha<=0 {sceneDelay=0; sceneProgress+=1}
    }
  }
  else if sceneProgress=5 //----- SCENE 3 -----
  {
    if global.modeDark=1
    {
      darkModeText+=1
      if darkModeText=10
      {
        msgCreate(60,280,"Claire","And you finally had a good one, that's slightly impressive.",0,2,oMessagePerson,0); newMessage.fadingTime=130
      }
      else if darkModeText=140
      {
        msgCreate(60,280,"Jerry","I impress myself sometimes.",0,2,oMessagePerson,0); newMessage.fadingTime=90
      }
    }

    sceneDelay+=1
    if sceneDelay>=20
    {
      if scrollView=1 {view_xview[0]+=1}
      if view_xview[0]>=2188
      {
        view_xview[0]=2188
        darkModeText=0
        sceneDelay=0; sceneProgress+=1
      }
    }
  }
  else if sceneProgress=6
  {
    sceneDelay+=1
    if sceneDelay>=10 and sceneDelay<=99
    {
      fadeAlpha+=0.05
      if fadeAlpha>=1 {sceneDelay=100}
    }
    else if sceneDelay=105
    {
      view_xview[0]=2672
      tile_layer_hide(1100000)
      with oBackgroundFollow {instance_destroy()}
      backFollow=instance_create(0,0,oBackgroundFollow)
      backFollow.type=2; backFollow.backSet=backNeoGrimeB
      backFollow.xMoveScale=0.6; backFollow.yMoveScale=0.92; backFollow.depth=1499999
      backFollow.image_xscale=2; backFollow.image_yscale=2
    }
    else if sceneDelay>=110
    {
      fadeAlpha-=0.05
      if fadeAlpha<=0 {sceneDelay=0; sceneProgress+=1}
    }
  }
  else if sceneProgress=7 //----- SCENE 4 -----
  {
    sceneDelay+=1
    if sceneDelay>=20
    {
      if sceneDelay=50
      {
        myNPC_A=instance_create(3600,320,oNPC_End_A); myNPC_A.type=2; myNPC_A.sprite_index=sNPC_BusyGuy ;myNPC_A.image_xscale=-1; myNPC_A.depth=40
        myNPC_A=instance_create(3636,320,oNPC_End_A); myNPC_A.type=2; myNPC_A.sprite_index=sCHAOS_ShockUnitWalkA ;myNPC_A.image_xscale=-1; myNPC_A.depth=40
        myNPC_A=instance_create(3672,320,oNPC_End_A); myNPC_A.type=2; myNPC_A.sprite_index=sCHAOS_ShockUnitWalkA ;myNPC_A.image_xscale=-1; myNPC_A.depth=40
      }
      else if sceneDelay=590
      {
        var tNewMessage;
        tNewMessage=instance_create(3584,224,oMessageSign)
        tNewMessage.message="Spider Drone is love!#Spider Drone is life!"
        tNewMessage.fadingTime=80
        tNewMessage.signSize=1
      }

      if scrollView=1 {view_xview[0]+=1}
      if view_xview[0]>=3340
      {
        view_xview[0]=3340
        sceneDelay=0; sceneProgress+=1
      }
    }
  }
  else if sceneProgress=8
  {
    sceneDelay+=1
    if sceneDelay>=10 and sceneDelay<=99
    {
      fadeAlpha+=0.05
      if fadeAlpha>=1 {sceneDelay=100}
    }
    else if sceneDelay=105
    {
      view_xview[0]=3824
      tile_layer_show(1100000)
      with oBackgroundFollow {instance_destroy()}
      backGrad=instance_create(0,0,oCh7GradientBack)
      backGrad.type=0
      backGrad.colorTop=make_color_rgb(48,152,248); backGrad.colorBottom=make_color_rgb(39,181,234)
      backGrad.yStart=0; backGrad.yEnd=152
      myNPC_A=instance_create(4272,192,oNPC_End_A); myNPC_A.type=1
    }
    else if sceneDelay>=110
    {
      fadeAlpha-=0.05
      if fadeAlpha<=0 {sceneDelay=0; sceneProgress+=1}
    }
  }
  else if sceneProgress=9 //----- SCENE 5 -----
  {
    if global.modeDark=1
    {
      darkModeText+=1
      if darkModeText=10
      {
        msgCreate(60,280,"Jerry","Got a bit quiet there.",0,2,oMessagePerson,0); newMessage.fadingTime=70
      }
      else if darkModeText=80
      {
        msgCreate(60,280,"Claire","Just thinking.",0,2,oMessagePerson,0); newMessage.fadingTime=60
      }
      else if darkModeText=140
      {
        msgCreate(60,280,"Jerry","About what?",0,2,oMessagePerson,0); newMessage.fadingTime=60
      }
      else if darkModeText=200
      {
        msgCreate(60,280,"Claire","You'll know in a moment.",0,2,oMessagePerson,0); newMessage.fadingTime=80
      }
    }

    sceneDelay+=1
    if sceneDelay>=20
    {
      if scrollView=1 {view_xview[0]+=1}
      if view_xview[0]>=4364
      {
        view_xview[0]=4364
        darkModeText=0
        sceneDelay=0; sceneProgress+=1
      }
    }
  }
  else if sceneProgress=10
  {
    sceneDelay+=1
    if sceneDelay=1
    {
      musVolC=global.optMusic*100
      musFileP=findMusic(1027)
    }
    if sceneDelay>=10 and sceneDelay<=99
    {
      fadeAlpha+=0.05

      if musVolC>=7500 {musVolC-=50}
      else {musVolC-=400}
      SS_SetSoundVol(musFileP,musVolC)
      if musVolC<=1500
      {
        stopAllMusic()
        sceneDelay=0; sceneProgress+=1
      }
    }
  }
  else if sceneProgress=11
  {
    sceneDelay+=1
    if sceneDelay>=10
    {
      room_goto(rTrueEnd_C)
    }
  }
}
else if room=rTrueEnd_C //------------------------------ [] End C ------------------------------
{
  if global.modeDark=1 //Dark mode end
  {
    if sceneProgress=0
    {
      sceneDelay+=1
      if sceneDelay>=30
      {
        fadeAlpha-=0.05
        if fadeAlpha<=0 {sceneDelay=0; sceneProgress+=1}
      }
    }
    else if sceneProgress=1
    {
      sceneDelay+=1
      if sceneDelay>=45 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=2 and bWaitForInput=false
      msgCreate(0,0,"Jerry","So... what were you thinking about? Last time we had this scene, I sorta badly hit on you.",0,3,oMessageCutscene,1)
    else if sceneProgress=3 and bWaitForInput=false
      msgCreate(0,0,"Claire","You really wanna know?",0,3,oMessageCutscene,1)
    else if sceneProgress=4 and bWaitForInput=false
      msgCreate(0,0,"Jerry","Well yeah!",0,3,oMessageCutscene,1)
    else if sceneProgress=5 and bWaitForInput=false
      msgCreate(0,0,"Claire","Okay then... here it goes...",0,3,oMessageCutscene,1)
    else if sceneProgress=6
    {
      sceneDelay+=1
      if sceneDelay>=30 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=7 and bWaitForInput=false
      msgCreate(0,0,"Claire","The moment you've been waiting for, the thought I had in the prior scene.",0,3,oMessageCutscene,1)
    else if sceneProgress=8
    {
      sceneDelay+=1
      if sceneDelay>=30 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=9 and bWaitForInput=false
      msgCreate(0,0,"Claire","It's about...",0,3,oMessageCutscene,1)
    else if sceneProgress=10
    {
      sceneDelay+=1
      if sceneDelay=1
      {
        global.gameCompleted=2
        ini_open(global.paraString[0])
        sectionWrite="ALPHA"
        ini_write_real(sectionWrite,"144",global.gameCompleted)
        ini_close()
      }
      else if sceneDelay=30
      {
        msgCreate(0,0,"Claire","This scene getting skipped!",0,2,oMessagePerson,0)
        newMessage.fadingTime=120
      }
      else if sceneDelay>=42
      {
        playSound(global.snd_MenuCancel,0,1,1)
        room_goto(rTitle)
      }
    }
  }
  else //All other ends
  {
    if sceneProgress=0
    {
      sceneDelay+=1
      if sceneDelay>=30
      {
        fadeAlpha-=0.05
        if fadeAlpha<=0 {sceneDelay=0; sceneProgress+=1}
      }
    }
    else if sceneProgress=1
    {
      sceneDelay+=1
      if sceneDelay>=45 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=2 and bWaitForInput=false
      msgCreate(0,0,"Jerry","This place is trash, you know that, right?",0,3,oMessageCutscene,1)
    else if sceneProgress=3 and bWaitForInput=false
      msgCreate(0,0,"Claire","We're both experiencing it. Yes, I'm aware of said trash levels of quality.",0,3,oMessageCutscene,1)
    else if sceneProgress=4 and bWaitForInput=false
      msgCreate(0,0,"Jerry","Do you have any idea how long this place is?",0,3,oMessageCutscene,1)
    else if sceneProgress=5 and bWaitForInput=false
      msgCreate(0,0,"Claire","I know just as much as you do...#And Jerry, could you please use your bombs to stun the bigger dudes for me? I took a sword to the face because you were too busy playing around with arrows.",0,3,oMessageCutscene,1)
    else if sceneProgress=6 and bWaitForInput=false
      msgCreate(0,0,"Jerry","My arrow DPS was way better there and I thought you'd dash in time.",0,3,oMessageCutscene,1)
    else if sceneProgress=7 and bWaitForInput=false
      msgCreate(0,0,"Claire","No, I stepped into that anti-dash field by accident.",0,3,oMessageCutscene,1)
    else if sceneProgress=8 and bWaitForInput=false
      msgCreate(0,0,"Jerry","Sounds to me like the lack of bombs weren't the problem, but I'll do it anyway.",0,3,oMessageCutscene,1)
    else if sceneProgress=9 and bWaitForInput=false
      msgCreate(0,0,"Claire","Fair enough, I thought I had him anyway. That laser cannon was pointed at me so it was the field or the laser.",0,3,oMessageCutscene,1)
    else if sceneProgress=10 and bWaitForInput=false
      msgCreate(0,0,"Jerry","Ooh right, the cannon. I was still on bomb cooldown because I tried to stun that.",0,3,oMessageCutscene,1)
    else if sceneProgress=11 and bWaitForInput=false
      msgCreate(0,0,"Claire","Really? That's actually a better idea. I'd missile the cannon, but every time I switch to that ability, the sword guys go into some berserk mode.",0,3,oMessageCutscene,1)
    else if sceneProgress=12 and bWaitForInput=false
      msgCreate(0,0,"Jerry","The encounters aren't the problem anyway. It's the garbage design of this place that's the problem.",0,3,oMessageCutscene,1)
    else if sceneProgress=13 and bWaitForInput=false
      msgCreate(0,0,"Claire","I see some Morph Ball only places and you know what that means.",0,3,oMessageCutscene,1)
    else if sceneProgress=14
    {
      sceneDelay+=1
      if sceneDelay=1
      {
        msgCreate(60,80,"Jerry","More trashy split mechanic traps.",0,1,oMessagePerson,0)
        newMessage.fadingTime=70
        msgCreate(60,140,"Claire","More precision garbage with lasers.",0,1,oMessagePerson,0)
        newMessage.fadingTime=70
      }
      else if sceneDelay>=70 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=15 and bWaitForInput=false
      msgCreate(0,0,"Claire","Close enough.",0,3,oMessageCutscene,1)
    else if sceneProgress=16 and bWaitForInput=false
      msgCreate(0,0,"Jerry","I bet I'm gonna have to time one of my bombs with your bombs.",0,3,oMessageCutscene,1)
    else if sceneProgress=17 and bWaitForInput=false
      msgCreate(0,0,"Claire","Bring it. We've completed harder puzzles.",0,3,oMessageCutscene,1)
    else if sceneProgress=18 and bWaitForInput=false
      msgCreate(0,0,"Jerry","And it'll be timed.",0,3,oMessageCutscene,1)
    else if sceneProgress=19 and bWaitForInput=false
      msgCreate(0,0,"Claire","Please don't jinx it.",0,3,oMessageCutscene,1)
    else if sceneProgress=20 and bWaitForInput=false
      msgCreate(0,0,"Jerry","So, you dashed into Morph Ball to get into that hole covered by a spike trap, came out the other end and out of Morph Ball to double jump, then dashed into Morph Ball again to get into that hole that had to be timed to undashable lasers.",0,3,oMessageCutscene,1)
    else if sceneProgress=21 and bWaitForInput=false
      msgCreate(0,0,"Claire","Yeah, that wasn't all that bad, despite it also having an advancing wall of death.",0,3,oMessageCutscene,1)
    else if sceneProgress=22 and bWaitForInput=false
      msgCreate(0,0,"Jerry","But you did it on your first try.",0,3,oMessageCutscene,1)
    else if sceneProgress=23 and bWaitForInput=false
      msgCreate(0,0,"Claire","Having working respawning mechanics in here takes some of the edge off.",0,3,oMessageCutscene,1)
    else if sceneProgress=24 and bWaitForInput=false
      msgCreate(0,0,"Jerry","That has nothing to do with you doing it first try. It was pretty damn incredible looking.",0,3,oMessageCutscene,1)
    else if sceneProgress=25 and bWaitForInput=false
      msgCreate(0,0,"Claire","In your words. Yeah, I'm awesome like that.",0,3,oMessageCutscene,1)
    else if sceneProgress=26
    {
      sceneDelay+=1
      if sceneDelay>=40 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=27 and bWaitForInput=false
      msgCreate(0,0,"Claire","Ready to continue? I'm done taking a break.",0,3,oMessageCutscene,1)
    else if sceneProgress=28 and bWaitForInput=false
    {
      charJerry.sprite_index=sJerryIdle; charJerry.image_speed=0.1
      msgCreate(0,0,"Jerry","Yep. I think we're almost to the end of this one.",0,3,oMessageCutscene,1)
    }
    else if sceneProgress=29 and bWaitForInput=false
    {
      charClaire.sprite_index=sClaireIdle; charClaire.image_speed=0.1
      msgCreate(0,0,"Claire","Cool. I'll take the bottom-left route and you take the top-right.",0,3,oMessageCutscene,1)
    }
    else if sceneProgress=30 and bWaitForInput=false
    {
      charJerry.image_xscale=-1
      msgCreate(0,0,"Jerry","Hey Claire.",0,3,oMessageCutscene,1)
    }
    else if sceneProgress=31 and bWaitForInput=false
      msgCreate(0,0,"Claire","What is it?",0,3,oMessageCutscene,1)
    else if sceneProgress=32
    {
      if sceneDelay>=20 {fadeAlpha+=0.02}

      sceneDelay+=1
      if sceneDelay=1
      {
        msgCreate(60,80,"Jerry","Exploring these places is kinda like a date!",0,1,oMessagePerson,0)
        newMessage.fadingTime=80
      }
      else if sceneDelay=80
      {
        msgCreate(60,140,"Claire","Shut up, Jerry.",0,1,oMessagePerson,0)
        newMessage.fadingTime=70
      }
      else if sceneDelay>=140 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=33
    {
      sceneDelay+=1
      if sceneDelay=1
      {
        global.gameCompleted=2
        ini_open(global.paraString[0])
        sectionWrite="ALPHA"
        ini_write_real(sectionWrite,"144",global.gameCompleted)
        ini_close()
      }
      else if sceneDelay>=31 and sceneDelay<=80
      {
        dtAlpha+=0.02
      }
      else if sceneDelay>=111 and sceneDelay<=130
      {
        thanksAlpha+=0.05
      }
      else if sceneDelay>=135 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=34
    {
      sceneDelay+=1
      if sceneDelay=210 {pressAnyAlpha=1}

      var tButtonCheck;
      tButtonCheck=0
      for(i=0;i<14;i+=1)
      {
        if oKeyCodes.kCodePressed[i]=1 {tButtonCheck=1}
      }
      if keyboard_check_pressed(vk_anykey) or tButtonCheck=1
      {
        playSound(global.snd_MenuCancel,0,1,1)
        room_goto(rTitle)
      }
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
if jeremyLaser>0
{
  if scaleUp=1
  {
    laserScaleY+=0.01
    if laserScaleY>=0.9 {scaleUp=0}
  }
  else
  {
    laserScaleY-=0.01
    if laserScaleY<=0.8 {scaleUp=1}
  }

  draw_sprite_ext(sDeci_BigLaser,0,1088,272,20,laserScaleY,115,c_white,1)
  var tEffect,tFFScl,tFFDir;
  for(i=0;i<4;i+=1)
  {
    tFFScl=random(0.2)
    tFFDir=random(360)
    tEffect=instance_create(x+lengthdir_x(8,tFFDir),y+lengthdir_y(8,tFFDir),oEffectB)
    tEffect.type=3; tEffect.sprite_index=sEfFirefly; tEffect.newBlend=1
    tEffect.image_alpha=0.5; tEffect.image_xscale=0.2+tFFScl; tEffect.image_yscale=0.2+tFFScl
    tEffect.direction=tFFDir; tEffect.speed=10
    tEffect.fadeSpd=0.05; tEffect.AccelX=0; tEffect.AccelY=0; tEffect.followID=-1; tEffect.rotation=0
  }
}

if fadeAlpha>0
{
  draw_set_alpha(fadeAlpha)
  draw_set_color(fadeColor)
  draw_rectangle(view_xview[0]-1,view_yview[0]-1,view_xview[0]+view_wview[0]+1,view_yview[0]+view_hview[0]+1,0)
}

if dtAlpha>=0
{
  draw_sprite_ext(sEndingLogo,0,240,128,1,1,0,c_white,dtAlpha)
}
if thanksAlpha>0
{
  draw_set_font(fnt_UnrealGuy)
  draw_set_halign(fa_center)
  draw_set_alpha(thanksAlpha)
  draw_set_color(c_white)
  draw_text(240,196,"Thanks for playing!")
}
if pressAnyAlpha=1
{
  draw_set_font(fnt_EnemyName)
  draw_set_halign(fa_right)
  draw_set_alpha(1)
  draw_set_color(c_white)
  draw_text(468,320,"Pst, you've uh, kinda won, so you're allowed to stop now.#Press any button to return to the title screen.")
}
