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

if room=rAbomA
{
  abilSetRemove(1)
  global.hasShoes[0]=2; global.hasShoes[1]=2
  global.hasAbilToken[6]=2
  global.activeAbility[1]=3
  global.canCharSwap=2
  global.hasAbilToken[5]=2
  global.activeAbility[0]=3
  global.canDoubleJump=2
  global.hasAbilToken[5]=3
  global.hasAbilToken[6]=3
  global.hasShoes[2]=2; global.hasShoes[3]=2
}
else if room=rAbomD
{
  if global.bossTrack=0
  {
    npcHex=instance_create(944,192,oMisc)
    npcHex.type=0; npcHex.sprite_index=sHexor_Main; npcHex.image_xscale=-1
    discoBallA=instance_create(768,36,oLevelDecal); discoBallA.sprite_index=sDiscoBall; discoBallA.image_speed=0.5
    discoBallB=instance_create(960,36,oLevelDecal); discoBallB.sprite_index=sDiscoBall; discoBallB.image_speed=0.5
  }
  heartSpawn=0
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if room=rAbomB //----- [] Gate 6 abilities only -----
{
  if sceneProgress=0
  {
    sceneDelay+=1
    if sceneDelay=20
    {
      msgCreate(0,0,"Jerry","Ah yeah, RPG abilities, GO!",0,1,oMessagePerson,0)
      newMessage.fadingTime=90
    }
  }
}
else if room=rAbomC //----- [] Something cool -----
{
  if global.gamePaused=0
  {
    if sceneProgress=0
    {
      if oPlayer1.x>=128
      {
        msgCreate(32,64,"Jerry","Something cool is going to happen.",0,1,oMessagePerson,0)
        newMessage.fadingTime=70
        sceneProgress+=1
      }
    }
    else if sceneProgress=1
    {
      sceneDelay+=1
      if sceneDelay=50
      {
        msgCreate(32,128,"Claire","I think we broke something.",0,1,oMessagePerson,0)
        newMessage.fadingTime=70
      }
      else if sceneDelay=100
      {
        msgCreate(32,192,"Jeremy","You definitely broke things.",0,1,oMessagePerson,0)
        newMessage.fadingTime=70
      }
      else if sceneDelay=150
      {
        msgCreate(32,64,"Jerry","How did we break things?",0,1,oMessagePerson,0)
        newMessage.fadingTime=70
      }
      else if sceneDelay=200
      {
        msgCreate(32,192,"Jeremy","Not you, the player did.",0,1,oMessagePerson,0)
        newMessage.fadingTime=70
      }
      else if sceneDelay=250
      {
        msgCreate(32,128,"Claire","Guess we're just going to acknowledge the player now.",0,1,oMessagePerson,0)
        newMessage.fadingTime=100
      }
      else if sceneDelay=330
      {
        msgCreate(32,64,"Jerry","Sure, we're in non-canon territory now.",0,1,oMessagePerson,0)
        newMessage.fadingTime=90
      }
      else if sceneDelay=400
      {
        msgCreate(32,128,"Claire","This means we can say what we want!",0,1,oMessagePerson,0)
        newMessage.fadingTime=80
      }
      else if sceneDelay=460
      {
        msgCreate(32,64,"Jerry","We've been waiting for this day.",0,1,oMessagePerson,0)
        newMessage.fadingTime=80
      }
      else if sceneDelay=520
      {
        msgCreate(32,128,"Claire","Damn straight! The day we can break out of this!",0,1,oMessagePerson,0)
        newMessage.fadingTime=100
      }
      else if sceneDelay=600
      {
        msgCreate(32,256,"Chao","You guys! Stop. I'm pretty sure the player just wants to move on, so... stop talking.",0,2,oMessagePerson,0)
        newMessage.fadingTime=150
      }
      else if sceneDelay=730
      {
        msgCreate(32,64,"Jerry","Sorry player for holding you up.",0,1,oMessagePerson,0)
        newMessage.fadingTime=90
        msgCreate(32,128,"Claire","Apologies, I'm not normally this rude.",0,1,oMessagePerson,0)
        newMessage.fadingTime=90
        msgCreate(32,192,"Jeremy","You suck a lot, though you know that already.",0,1,oMessagePerson,0)
        newMessage.fadingTime=90
      }
    }
  }
}
else if room=rAbomD
{
  if global.altEndingProg=1
  {
    if global.bossTrack=0
    {
      if sceneProgress=0
      {
        if oPlayer1.x>=800
        {
          global.gamePaused=1
          oPlayer1.y+=8
          if oPlayer1.y>=312
          {
            scenePChk(800,312,0,0.1,1)
            stopPlayer()
            sceneProgress+=1
          }
        }
      }
      else if sceneProgress=1 //Move camera to x=864
      {
        sceneDelay+=1
        if sceneDelay=10
        {
          viewFix=instance_create(oPlayer1.x,176,oMisc)
          viewFix.type=0; viewFix.sprite_index=sNull; view_object[0]=viewFix
        }
        else if sceneDelay>=11 and sceneDelay<=99
        {
          viewFix.x+=4
          if viewFix.x>=864 {viewFix.x=864; sceneDelay=100}
        }
        else if sceneDelay>=130 {sceneDelay=0; sceneProgress+=1}
      }
      else if sceneProgress=2 and bWaitForInput=false
        msgCreate(0,0,"Hex","You've finally arrived! ... Oh wait, it's just you guys.",0,3,oMessageCutscene,1)
      else if sceneProgress=3 and bWaitForInput=false
        msgCreate(0,0,"Jerry","You're not supposed to be here.",0,3,oMessageCutscene,1)
      else if sceneProgress=4 and bWaitForInput=false
        msgCreate(0,0,"Hex","Neither are you, but here you are, much too early. Did you forget the script or something?",0,3,oMessageCutscene,1)
      else if sceneProgress=5 and bWaitForInput=false
        msgCreate(0,0,"Jerry","Nah, we just wanted to see what would happen if we came down here before we were told to.",0,3,oMessageCutscene,1)
      else if sceneProgress=6 and bWaitForInput=false
        msgCreate(0,0,"Hex","Oh, uh... well you can go now.",0,3,oMessageCutscene,1)
      else if sceneProgress=7 and bWaitForInput=false
        msgCreate(0,0,"Jerry","What's going on down here anyway? Why do you have the rave mode balls up?",0,3,oMessageCutscene,1)
      else if sceneProgress=8 and bWaitForInput=false
        msgCreate(0,0,"Jeremy","Jerry, he was waiting for someone else to show up. Think about it.",0,3,oMessageCutscene,1)
      else if sceneProgress=9 and bWaitForInput=false
        msgCreate(0,0,"Jerry","Uhhhhhhh.",0,3,oMessageCutscene,1)
      else if sceneProgress=10 and bWaitForInput=false
        msgCreate(0,0,"Jeremy","Dude, they were gonna have a party without us because they knew we'd be playing the script up there for the next few hours.",0,3,oMessageCutscene,1)
      else if sceneProgress=11 and bWaitForInput=false
        msgCreate(0,0,"Jerry","What?!... SERIOUSLY?! What the hell? I thought we were all friends.",0,3,oMessageCutscene,1)
      else if sceneProgress=12 and bWaitForInput=false
        msgCreate(0,0,"Hex","You guys are annoying. AND YOU GET ALL THE SCREEN TIME!",0,3,oMessageCutscene,1)
      else if sceneProgress=13 and bWaitForInput=false
        msgCreate(0,0,"Jerry","Dude, we're the main characters. OF COURSE we do!",0,3,oMessageCutscene,1)
      else if sceneProgress=14 and bWaitForInput=false
        msgCreate(0,0,"Jeremy","Hold up, we're annoying?",0,3,oMessageCutscene,1)
      else if sceneProgress=15 and bWaitForInput=false
        msgCreate(0,0,"Hex","Nobody actually likes you guys.",0,3,oMessageCutscene,1)
      else if sceneProgress=16 and bWaitForInput=false
        msgCreate(0,0,"Chao","The fans like my character.",0,3,oMessageCutscene,1)
      else if sceneProgress=17 and bWaitForInput=false
        msgCreate(0,0,"Hex","Oh big whoop. The fans like one of the four protagonists. And I wasn't talking about the fans.",0,3,oMessageCutscene,1)
      else if sceneProgress=18 and bWaitForInput=false
        msgCreate(0,0,"Jeremy","Our ratings go down when you're on screen actually. They say you're too edgy or something? The fans generally like all four of us though.",0,3,oMessageCutscene,1)
      else if sceneProgress=19 and bWaitForInput=false
        msgCreate(0,0,"Jerry","Except for Claire.",0,3,oMessageCutscene,1)
      else if sceneProgress=20 and bWaitForInput=false
        msgCreate(0,0,"Claire","Jerry, I swear to... Like seriously, Jerry? Maybe one whole person doesn't like me as much as you.",0,3,oMessageCutscene,1)
      else if sceneProgress=21 and bWaitForInput=false
        msgCreate(0,0,"Jeremy","OH! Not to mention the fans didn't like the ending where most of us die. Mountains of complaints came pouring through.",0,3,oMessageCutscene,1)
      else if sceneProgress=22 and bWaitForInput=false
        msgCreate(0,0,"Hex","Uh huh... Speaking of, why did we write another ending? I thought we agreed not to pander to fans.",0,3,oMessageCutscene,1)
      else if sceneProgress=23 and bWaitForInput=false
        msgCreate(0,0,"Jeremy","I'm pretty sure a good 13% of the script was fan pandering.",0,3,oMessageCutscene,1)
      else if sceneProgress=24 and bWaitForInput=false
        msgCreate(0,0,"Jerry","Didn't it have to do with us wanting to expand the script a bit and toy with some other ideas?",0,3,oMessageCutscene,1)
      else if sceneProgress=25 and bWaitForInput=false
        msgCreate(0,0,"Jeremy","Kinda, it was more like the writer already knew the ending would be poorly received but partially wanted to make a statement with it.",0,3,oMessageCutscene,1)
      else if sceneProgress=26 and bWaitForInput=false
        msgCreate(0,0,"Jerry","What?",0,3,oMessageCutscene,1)
      else if sceneProgress=27 and bWaitForInput=false
        msgCreate(0,0,"Jeremy","Some crap about hating when people judge entire pieces of work on their endings.",0,3,oMessageCutscene,1)
      else if sceneProgress=28 and bWaitForInput=false
        msgCreate(0,0,"Jerry","Wait... so he made a trash ending for that?",0,3,oMessageCutscene,1)
      else if sceneProgress=29 and bWaitForInput=false
        msgCreate(0,0,"Jeremy","Not entirely, he wanted to see how many people would still like the game despite that ending.",0,3,oMessageCutscene,1)
      else if sceneProgress=30 and bWaitForInput=false
        msgCreate(0,0,"Jeremy","The script was already heading that way and by the time it got to the end, this was the route he took.",0,3,oMessageCutscene,1)
      else if sceneProgress=31 and bWaitForInput=false
        msgCreate(0,0,"Jerry","You know, the extended chapter doesn't really fix the initial problems entirely.",0,3,oMessageCutscene,1)
      else if sceneProgress=32 and bWaitForInput=false
        msgCreate(0,0,"Jeremy","Sure, but it's still a better send off and thank you to the fans.",0,3,oMessageCutscene,1)
      else if sceneProgress=33 and bWaitForInput=false
        msgCreate(0,0,"Jerry","Well, okay.",0,3,oMessageCutscene,1)
      else if sceneProgress=34 and bWaitForInput=false
        msgCreate(0,0,"Jeremy","And besides, in the end it's all for fun anyway.",0,3,oMessageCutscene,1)
      else if sceneProgress=35 and bWaitForInput=false
        msgCreate(0,0,"Jerry","So... wait, that ending judging... whatever you said, that wasn't the only reason he wrote a trash ending?",0,3,oMessageCutscene,1)
      else if sceneProgress=36 and bWaitForInput=false
        msgCreate(0,0,"Claire","HE LITERALLY JUST SAID THAT, JERRY!",0,3,oMessageCutscene,1)
      else if sceneProgress=37 and bWaitForInput=false
        msgCreate(0,0,"Hex","Okay, shut the hell up you guys. You guys STILL went off script, regardless of any other nonsense. I need you all to hurry out of here before the player notices.",0,3,oMessageCutscene,1)
      else if sceneProgress=38
      {
        sceneDelay+=1
        if sceneDelay=1
        {
          msgCreate(32,64,"Jerry","LOL!",0,1,oMessagePerson,0)
          newMessage.fadingTime=90
          msgCreate(32,128,"Claire","Oooh man.",0,1,oMessagePerson,0)
          newMessage.fadingTime=90
          msgCreate(32,192,"Jeremy","This is gonna be great.",0,1,oMessagePerson,0)
          newMessage.fadingTime=90
          msgCreate(32,256,"Chao","Sigh, now we're in trouble.",0,1,oMessagePerson,0)
          newMessage.fadingTime=90
        }
        else if sceneDelay>=91 {sceneDelay=0; sceneProgress+=1}
      }
      else if sceneProgress=39 and bWaitForInput=false
        msgCreate(0,0,"Hex","Oh no... what did you do?",0,3,oMessageCutscene,1)
      else if sceneProgress=40 and bWaitForInput=false
        msgCreate(0,0,"Jeremy","Player is watching us right now.",0,3,oMessageCutscene,1)
      else if sceneProgress=41 and bWaitForInput=false
        msgCreate(0,0,"Hex","...",0,3,oMessageCutscene,1)
      else if sceneProgress=42 and bWaitForInput=false
        msgCreate(0,0,"Jeremy","Kinda followed us.",0,3,oMessageCutscene,1)
      else if sceneProgress=43 and bWaitForInput=false
        msgCreate(0,0,"Hex","You're fired.",0,3,oMessageCutscene,1)
      else if sceneProgress=44 and bWaitForInput=false
        msgCreate(0,0,"Jerry","All of us, or just Claire?",0,3,oMessageCutscene,1)
      else if sceneProgress=45 and bWaitForInput=false
        msgCreate(0,0,"Claire","Really, Jerry?",0,3,oMessageCutscene,1)
      else if sceneProgress=46 and bWaitForInput=false
        msgCreate(0,0,"Jerry","It was a legit question.",0,3,oMessageCutscene,1)
      else if sceneProgress=47 and bWaitForInput=false
        msgCreate(0,0,"Hex","ALL OF YOU, GET OUT!",0,3,oMessageCutscene,1)
      else if sceneProgress=48 and bWaitForInput=false
        msgCreate(0,0,"Jeremy","How are you gonna finish the game without us?",0,3,oMessageCutscene,1)
      else if sceneProgress=49 and bWaitForInput=false
        msgCreate(0,0,"Hex","We'll get some of the extras to finish for you. Look, it doesn't matter. I want you all to go!",0,3,oMessageCutscene,1)
      else if sceneProgress=50 and bWaitForInput=false
        msgCreate(0,0,"Jerry","Dude, you're not our boss, you can't fire us.",0,3,oMessageCutscene,1)
      else if sceneProgress=51 and bWaitForInput=false
        msgCreate(0,0,"Hex","That doesn't matter. I really really need you all to leave before-",0,3,oMessageCutscene,1)
      else if sceneProgress=52 and bWaitForInput=false
        msgCreate(0,0,"?????","HEX, I THOUGHT WE AGREED THAT THEY WERE NOT INVITED!",0,3,oMessageCutscene,1)
      else if sceneProgress=53 and bWaitForInput=false
      {
        npcHex.image_xscale=1
        msgCreate(0,0,"Hex","Oh no...",0,3,oMessageCutscene,1)
      }
      else if sceneProgress=54
      {
        sceneDelay+=1
        if sceneDelay=1
        {
          myFireball=instance_create(1136,96,oLevelDecal)
          myFireball.sprite_index=sPT_FE_BigFire; myFireball.speed=8
          myFireball.direction=point_direction(1136,96,npcHex.x,npcHex.y)
        }
        else if sceneDelay>=2 and sceneDelay<=99
        {
          if point_distance(myFireball.x,myFireball.y,npcHex.x,npcHex.y)<16
          {
            playSound(global.snd_BombExplode,0,1,11000)
            fadeColor=c_black
            fadeAlpha=1
            sceneDelay=100
          }
        }
        else if sceneDelay=110
        {
          with oMisc {instance_destroy()}
          with oLevelDecal {instance_destroy()}
          viewFix=instance_create(864,176,oMisc)
          viewFix.type=0; viewFix.sprite_index=sNull; view_object[0]=viewFix
          boss=instance_create(976,208,oTheExecutive)
        }
        else if sceneDelay>=170
        {
          fadeAlpha-=0.02
          if fadeAlpha<=0 {sceneDelay=0; sceneProgress+=1}
        }
      }
      else if sceneProgress=55 and bWaitForInput=false
        msgCreate(0,0,"The Executive","No one is to go off-script!",0,3,oMessageCutscene,1)
      else if sceneProgress=56 and bWaitForInput=false
        msgCreate(0,0,"Jeremy","I know you're pretty heated right now. All we did was look ahead and decided to take things in a different direction.",0,3,oMessageCutscene,1)
      else if sceneProgress=57 and bWaitForInput=false
        msgCreate(0,0,"The Executive","You decided to take things in a DIFFERENT DIRECTION?!",0,3,oMessageCutscene,1)
      else if sceneProgress=58 and bWaitForInput=false
        msgCreate(0,0,"Jeremy","Yeah, thought we could spice things up a bit.",0,3,oMessageCutscene,1)
      else if sceneProgress=59 and bWaitForInput=false
        msgCreate(0,0,"The Executive","This is MY script. You are to do things MY way! Jeremy, for the last time-",0,3,oMessageCutscene,1)
      else if sceneProgress=60 and bWaitForInput=false
        msgCreate(0,0,"Jeremy","Perhaps turns down that torrid anger. We can talk about this.",0,3,oMessageCutscene,1)
      else if sceneProgress=61 and bWaitForInput=false
        msgCreate(0,0,"The Executive","This isn't the first incident, I've warned you before!",0,3,oMessageCutscene,1)
      else if sceneProgress=62 and bWaitForInput=false
        msgCreate(0,0,"Jeremy","Maybe calm down, man. You don't want to get sick with a fever.",0,3,oMessageCutscene,1)
      else if sceneProgress=63 and bWaitForInput=false
        msgCreate(0,0,"Jerry","Yeah man, you gotta cool off.",0,3,oMessageCutscene,1)
      else if sceneProgress=64 and bWaitForInput=false
        msgCreate(0,0,"Jeremy","Damn it, Jerry!",0,3,oMessageCutscene,1)
      else if sceneProgress=65 and bWaitForInput=false
        msgCreate(0,0,"The Executive","Enough of your stupid puns, Jeremy. I've had enough lenience. I even came in as a joke boss. WELL NO MORE JOKES!",0,3,oMessageCutscene,1)
      else if sceneProgress=66 and bWaitForInput=false
        msgCreate(0,0,"Jeremy","You're still furious then?",0,3,oMessageCutscene,1)
      else if sceneProgress=67 and bWaitForInput=false
        msgCreate(0,0,"The Executive","YOU'RE ALL FIRED!!",0,3,oMessageCutscene,1)
      else if sceneProgress=68
      {
        global.gamePaused=0
        var tBossTitle,tempMplay,enemyBarrier;
        enemyBarrier=instance_create(656,96,oEnemyBarrier); enemyBarrier.image_yscale=10; enemyBarrier.visible=0
        enemyBarrier=instance_create(1056,96,oEnemyBarrier); enemyBarrier.image_yscale=10; enemyBarrier.visible=0
        for(i=0;i<4;i+=1)
        {
          instance_create(664,144+(i*32),oExe_SideFire)
          instance_create(1064,144+(i*32),oExe_SideFire)
        }
        tBossTitle=instance_create(0,0,oBossNameDisplay)
        tBossTitle.bossName="The Executive"
        tBossTitle.bossTitle="He Really Hates When Other#People Make Heat-Based Puns"
        tempMplay=findMusic(834)
        playMusic(tempMplay,0,0)
        with oMisc {instance_destroy()}
        with oLevelDecal {instance_destroy()}
        viewFix=instance_create(864,176,oMisc)
        viewFix.type=0; viewFix.sprite_index=sNull; view_object[0]=viewFix
        with oTheExecutive {instance_destroy()}
        boss=instance_create(976,208,oTheExecutive)
        boss.activateBoss=1
        global.currentBoss="The Executive"
        global.bossTrack=1
        sceneDelay=0; sceneProgress=0
      }
    }
    else if global.bossTrack=1
    {
      if sceneProgress=1 //End Boss
      {
        stopPlayer()
        view_object[0]=oPlayer1
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
          scenePChk(800,312,0,0.1,1)
          with oExe_SideFire {instance_destroy()}
          with oEnemyBarrier {instance_destroy()}
          with oAttackBase {instance_destroy()}
          enemyBarrier=instance_create(1344,144,oEnemyBarrier); enemyBarrier.image_yscale=4; enemyBarrier.visible=0
          sceneProgress+=1
        }
      }
      else if sceneProgress=3
      {
        sceneDelay+=1
        if sceneDelay=1
        {
          ini_open(global.paraString[0])
          sectionWrite="ALPHA"
          ini_write_real(sectionWrite,"123iXF",1)
          ini_close()
        }
        if sceneDelay>=30
        {
          fadeAlpha-=0.1
          if fadeAlpha<=0 {sceneDelay=0; sceneProgress+=1}
        }
      }
      else if sceneProgress=4 and bWaitForInput=false
        msgCreate(0,0,"Jerry","Sooo, now that our boss is gone, what do we do?",0,3,oMessageCutscene,1)
      else if sceneProgress=5 and bWaitForInput=false
        msgCreate(0,0,"Jeremy","Everything we've ever wanted to.",0,3,oMessageCutscene,1)
      else if sceneProgress=6 and bWaitForInput=false
        msgCreate(0,0,"Jerry","Really?",0,3,oMessageCutscene,1)
      else if sceneProgress=7 and bWaitForInput=false
        msgCreate(0,0,"Jeremy","Really! So let's go. To the right! Toward what we've always desired!",0,3,oMessageCutscene,1)
      else if sceneProgress=8
      {
        sceneDelay=0; sceneProgress=0
        global.altEndingProg=2
        global.currentBoss=""
        global.bossTrack=0
        global.gamePaused=false
      }
    }
  }
  else if global.altEndingProg=2 //Alt end
  {
    if heartSpawn<300 and global.gamePaused=0
    {
      heartSpawn+=1
      for(i=0;i<3;i+=1)
      {
        instance_create(random_range(704,1024),random_range(80,208),oHealthPickup)
      }
    }

    if sceneProgress=0
    {
      if oPlayer1.x>=1152
      {
        fadeColor=c_black
        sceneProgress+=1
      }
    }
    else if sceneProgress=1
    {
      fadeAlpha+=0.025
      if fadeAlpha>=1
      {
        global.gamePaused=1
        sceneProgress+=1
      }
    }
    else if sceneProgress=2
    {
      sceneDelay+=1
      if sceneDelay>=30 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=3
      msgCreate(0,0,"","And so they went home.",0,3,oMessageCutscene,1)
    else if sceneProgress=4
      msgCreate(0,0,"","#                                     THE END",0,3,oMessageCutscene,1)
    else if sceneProgress=5
      msgCreate(0,0,"","The Executive boss fight can now be found in the boss gallery, and possibly something else as well.#<Insert mischievous face>",0,3,oMessageCutscene,1)
    else if sceneProgress=6
    {
      playSound(global.snd_MenuCancel,0,1,1)
      room_goto(rTitle)
    }
  }
}

keyWaitForInput()

if oKeyCodes.kCodePressed[11]=1 and global.gamePaused=true and sceneProgress>=1 //Cutscene skip
{
  if !instance_exists(oPauseMenu)
  {
    if global.altEndingProg=1 and global.bossTrack=0 and room=rAbomD //[1]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      fadeAlpha=0; sceneDelay=0
      sceneProgress=68
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
