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

instrumentProg=0
instrumentActNum=0
instrumentReq=6
musicPlaying=1 //0 Abomination, 1 Instrument
spawnWalls=0

if room=rCh21_Main_76
{
  instrMoveProg=0
  instrDist=30
  instrAng=0
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gateHProg=100 and room=rMain_76 //----- [1] How do we beat this thing? -----
{
  if sceneProgress=0
  {
    if sceneProgress=0 and oPlayer1.x>=160
    {
      sceneDelay+=1
      if sceneDelay=1 {global.gamePaused=true}
      else if sceneDelay>=2
      {
        oPlayer1.y+=4
        if oPlayer1.y>=160
        {
          scenePChk(oPlayer1.x,160,0,0.1,1)
          stopPlayer()
          sceneProgress+=1
        }
      }
    }
  }
  else if sceneProgress=1
  {
    sceneDelay+=1
    if sceneDelay>=30 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"Claire","Here it is, what do we do with the instruments? We weren't given any instruction.",0,3,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","If you attack this thing, it will wake up. I know that much, but eh, I don't really know how to use them.",0,3,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Chao","I do! While you were in that nightmare, Claire, I was looking through the code for the instruments and those messages left behind.",0,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Chao","Those messages were left by the Abomination itself. It was altered and is under someone's control. I think Hex messed with it via the Virus and can now call on it any time.",0,3,oMessageCutscene,1)
  else if sceneProgress=6 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","What does that mean then? That Hex had this creature as a back up plan to the Warship?",0,3,oMessageCutscene,1)
  else if sceneProgress=7 and bWaitForInput=false
    msgCreate(0,0,"Chao","That's precisely what that means. The other thing I figured out was about the creature itself. We know that it changes to meet new threats, but it can also bond with other things in the world, given enough time.",0,3,oMessageCutscene,1)
  else if sceneProgress=8 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Wait a minute... So if we bring down the Warship, Hex will just call on this creature to assimilate with the Warship itself?",0,3,oMessageCutscene,1)
  else if sceneProgress=9 and bWaitForInput=false
    msgCreate(0,0,"Chao","Yes. We can't beat Hex unless this creature is removed from Hex's control.",0,3,oMessageCutscene,1)
  else if sceneProgress=10 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Holy balls... Okay Chao, what do we have to do then?",0,3,oMessageCutscene,1)
  else if sceneProgress=11 and bWaitForInput=false
    msgCreate(0,0,"Chao","You'll need to awaken the creature by striking it with anything. After this, you need to send out the instruments, Jeremy.",0,3,oMessageCutscene,1)
  else if sceneProgress=12 and bWaitForInput=false
    msgCreate(0,0,"Chao","The instruments should start playing the tune that will calm the creature enough for you to be able to damage whatever is controlling it... at least that's what I see anyway.",0,3,oMessageCutscene,1)
  else if sceneProgress=13 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Break whatever is controlling it?",0,3,oMessageCutscene,1)
  else if sceneProgress=14 and bWaitForInput=false
    msgCreate(0,0,"Chao","Yeah, I'm shaky on this part of it. There's stuff I couldn't access. But what I do know is that the creature, or something anyway, will be actively trying to keep the instruments from playing.",0,3,oMessageCutscene,1)
  else if sceneProgress=15 and bWaitForInput=false
    msgCreate(0,0,"Chao","You need to monitor the instruments and strike them with any attack to reactivate it.",0,3,oMessageCutscene,1)
  else if sceneProgress=16 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Did you two get all that?",0,3,oMessageCutscene,1)
  else if sceneProgress=17 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Yeah, that part seems pretty straight forward.",0,3,oMessageCutscene,1)
  else if sceneProgress=18 and bWaitForInput=false
    msgCreate(0,0,"Claire","Yes, though what are we doing while the instruments play?",0,3,oMessageCutscene,1)
  else if sceneProgress=19 and bWaitForInput=false
    msgCreate(0,0,"Chao","I don't quite know. In theory, weak spots should appear on the creature. Those weak spots will probably only be vulnerable if most, if not all, of the instruments are playing.",0,3,oMessageCutscene,1)
  else if sceneProgress=20 and bWaitForInput=false
    msgCreate(0,0,"Chao","On some things, you might be able to get by with at least 6 of the 8 playing.",0,3,oMessageCutscene,1)
  else if sceneProgress=21 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Alrighty you guys. Go in there and hit it to get this started. Just do it only when you're ready. We saw this thing in action once, but it wasn't truly threatened then.",0,3,oMessageCutscene,1)
  else if sceneProgress=22 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","We don't know what it's going to do when it's actually vulnerable.",0,3,oMessageCutscene,1)
  else if sceneProgress=23 and bWaitForInput=false
    msgCreate(0,0,"Chao","You two can do it. We know you can! Whatever is controlling it, put a stop to it!",0,3,oMessageCutscene,1)
  else if sceneProgress=24
  {
    sceneDelay=0; sceneProgress=0
    global.gateHProg=101
    global.gamePaused=false
  }
}

keyWaitForInput()

if oKeyCodes.kCodePressed[11]=1 and global.gamePaused=true //Cutscene skip
{
  if !instance_exists(oPauseMenu)
  {
    if global.gateHProg=100 and room=rMain_76 //[1]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      fadeAlpha=0; sceneDelay=0
      sceneProgress=24
    }
  }
}

if spawnWalls=1
{
  enemyBarrierA=instance_create(176,-128,oEnemyBarrier); enemyBarrierA.image_yscale=18; enemyBarrierA.visible=0
  enemyBarrierB=instance_create(1056,-128,oEnemyBarrier); enemyBarrierB.image_yscale=18; enemyBarrierB.visible=0
  spawnWalls=2
}

//Instrument Controller
if room=rCh21_Main_76 //-------------------- Chapter 21 --------------------
{
  if instrumentProg=1 //Spawn Instruments
  {
    myInstrument[0]=instance_create(544,408,oAbomInstrument); myInstrument[0].image_index=0
    myInstrument[1]=instance_create(544,408,oAbomInstrument); myInstrument[1].image_index=1
    myInstrument[2]=instance_create(544,408,oAbomInstrument); myInstrument[2].image_index=2
    myInstrument[3]=instance_create(544,408,oAbomInstrument); myInstrument[3].image_index=3

    myInstrument[4]=instance_create(696,408,oAbomInstrument); myInstrument[4].image_index=4
    myInstrument[5]=instance_create(696,408,oAbomInstrument); myInstrument[5].image_index=5
    myInstrument[6]=instance_create(696,408,oAbomInstrument); myInstrument[6].image_index=6
    myInstrument[7]=instance_create(696,408,oAbomInstrument); myInstrument[7].image_index=7

    instrumentProg+=1
  }
  else if instrumentProg=2
  {
    for(i=0;i<4;i+=1)
    {
      myInstrument[i].x=544+lengthdir_x(instrDist,instrAng+(i*90))
      myInstrument[i].y=408+lengthdir_y(instrDist,instrAng+(i*90))

      myInstrument[i+4].x=696+lengthdir_x(instrDist,instrAng+45+(i*90))
      myInstrument[i+4].y=408+lengthdir_y(instrDist,instrAng+45+(i*90))
    }

    instrAng-=3
    if instrMoveProg=0
    {
      instrDist+=0.5
      if instrDist>=35 {instrMoveProg=1}
    }
    else
    {
      instrDist-=0.5
      if instrDist<=20 {instrMoveProg=0}
    }
  }
}
else //-------------------- Normal fight --------------------
{
  if instrumentProg=1 //Spawn Instruments
  {
    myInstrument[0]=instance_create(512,128,oAbomInstrument); myInstrument[0].image_index=0
    myInstrument[1]=instance_create(464,176,oAbomInstrument); myInstrument[1].image_index=1
    myInstrument[2]=instance_create(448,240,oAbomInstrument); myInstrument[2].image_index=2
    myInstrument[3]=instance_create(416,288,oAbomInstrument); myInstrument[3].image_index=3
    myInstrument[4]=instance_create(736,128,oAbomInstrument); myInstrument[4].image_index=4
    myInstrument[5]=instance_create(784,176,oAbomInstrument); myInstrument[5].image_index=5
    myInstrument[6]=instance_create(816,240,oAbomInstrument); myInstrument[6].image_index=6
    myInstrument[7]=instance_create(848,288,oAbomInstrument); myInstrument[7].image_index=7

    instrumentProg+=1
  }
  else if instrumentProg=2 //Check for active instruments
  {
    instrumentActNum=0
    for(i=0;i<8;i+=1)
    {
      if myInstrument[i].bCanTakeDamage=0 {instrumentActNum+=1}
    }

    if instrumentActNum>=instrumentReq //Set the music that is playing
    {
      if musicPlaying=0
      {
        var tempMplay;
        tempMplay=findMusic(1019)
        playMusic(tempMplay,0,0)
        musicPlaying=1
      }
    }
    else
    {
      if musicPlaying=1
      {
        var tempMplay;
        tempMplay=findMusic(822)
        playMusic(tempMplay,0,0)
        musicPlaying=0
      }
    }
  }
  else if instrumentProg=4 //Abomination defeated
  {
    sceneDelay+=1
    if sceneProgress=0
    {
      if sceneDelay=80 {msgCreate(0,0,"Jerry","We... we did it!",0,3,oMessagePerson,0); newMessage.fadingTime=60}
      else if sceneDelay=140 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=1
    {
      if sceneDelay=1 {msgCreate(0,0,"Jeremy","Wait... did you?",0,3,oMessagePerson,0); newMessage.fadingTime=60}
      else if sceneDelay=60 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=2
    {
      if sceneDelay=1 {msgCreate(0,0,"Jerry","It DID explode into a million pieces... which... I wasn't expecting.",0,3,oMessagePerson,0); newMessage.fadingTime=140}
      else if sceneDelay=140 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=3
    {
      if sceneDelay=1 {msgCreate(0,0,"Jeremy","I'm just messing with you, Jerry. But really, I'm not seeing it anymore, other than the barriers, it's gone.",0,3,oMessagePerson,0); newMessage.fadingTime=170}
      else if sceneDelay=170 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=4
    {
      if sceneDelay=1 {msgCreate(0,0,"Jerry","Which means Hex won't be able to call on it any longer.",0,3,oMessagePerson,0); newMessage.fadingTime=120}
      else if sceneDelay=120 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=5
    {
      if sceneDelay=1 {msgCreate(0,0,"Jeremy","Yes, his back up plan is over.",0,3,oMessagePerson,0); newMessage.fadingTime=80}
      else if sceneDelay=80 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=6
    {
      if sceneDelay=1 {msgCreate(0,0,"Chao","I am a little sad though...",0,3,oMessagePerson,0); newMessage.fadingTime=60}
      else if sceneDelay=60 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=7
    {
      if sceneDelay=1 {msgCreate(0,0,"Jeremy","Why? What's up sis?",0,3,oMessagePerson,0); newMessage.fadingTime=60}
      else if sceneDelay=60 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=8
    {
      if sceneDelay=1 {msgCreate(0,0,"Chao","That creature was calling out to us to help it. And look what we did.",0,3,oMessagePerson,0); newMessage.fadingTime=140}
      else if sceneDelay=140 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=9
    {
      if sceneDelay=1 {msgCreate(0,0,"Jeremy","There was no way we could have known it was going to happen like that.",0,3,oMessagePerson,0); newMessage.fadingTime=140}
      else if sceneDelay=140 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=10
    {
      if sceneDelay=1 {msgCreate(0,0,"Chao","Was there though? Both of us should have been able to foresee that the parasite would have done this on its demise. Maybe we could have prevented that.",0,3,oMessagePerson,0); newMessage.fadingTime=220}
      else if sceneDelay=220 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=11
    {
      if sceneDelay=1 {msgCreate(0,0,"Jeremy","I don't know what to say, sis. I really don't.",0,3,oMessagePerson,0); newMessage.fadingTime=110}
      else if sceneDelay=110 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=12
    {
      if sceneDelay=1 {msgCreate(0,0,"Chao","It's fine, I guess, I was just really hoping to help it.",0,3,oMessagePerson,0); newMessage.fadingTime=110}
      else if sceneDelay=110 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=13
    {
      if sceneDelay=1 {msgCreate(0,0,"Claire","Sorry Chao.",0,3,oMessagePerson,0); newMessage.fadingTime=60}
      else if sceneDelay=60 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=14
    {
      if sceneDelay=1 {msgCreate(0,0,"Chao","It's okay, Claire. It's not your fault.",0,3,oMessagePerson,0); newMessage.fadingTime=90}
      else if sceneDelay=90 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=15
    {
      if sceneDelay=1 {msgCreate(0,0,"Jeremy","Well... There's only one thing left.",0,3,oMessagePerson,0); newMessage.fadingTime=90}
      else if sceneDelay=90 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=16
    {
      if sceneDelay=1 {msgCreate(0,0,"Jerry","Yeah. Let's take down that ship, and Hex with it.",0,3,oMessagePerson,0); newMessage.fadingTime=90}
      else if sceneDelay=90 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=17
    {
      var tFlash,secretExit;
      tFlash=instance_create(0,0,oScreenFlash); tFlash.fadeSpeed=0.2
      with oAbomSideBarriers {instance_destroy()}
      with enemyBarrierA {instance_destroy()}
      with enemyBarrierB {instance_destroy()}

      awardBossAP(25000)
      global.gateHProg=200
      sceneDelay=0; sceneProgress=0
      instrumentProg=5
    }
  }
  else if instrumentProg=5
  {
    secretExit=instance_create(1136,128,oExit)
    secretExit.bShowArrow=false; secretExit.exitType=1
    secretExit.newMapX=48; secretExit.newMapY=304; secretExit.toRoom=rPttT_01
    instrumentProg=6
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
