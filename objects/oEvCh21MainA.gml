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

if global.gameProgress=5520 and room=rCh21_Main_75
{
  npcJerry=instance_create(688,288,oMisc)
  npcJerry.type=0; npcJerry.sprite_index=sJerrySit; npcJerry.image_xscale=-1
  npcJerry.image_speed=0
  stopPlayer()
  oPlayer1.sprite_index=sClaireLayDown
  global.gamePaused=1
  fadeColor=c_black
  fadeAlpha=1
}
else if room=rAbomF
{
  if global.gameProgress=5550 and global.bossTrack=0
  {
    global.gamePaused=1
    fadeColor=c_black
    fadeAlpha=1
  }
}
else if global.gameProgress=5560 and room=rAbomCutA
{
  fadeColor=c_black
  fadeAlpha=1
  theWarship=instance_create(208,240,oMisc)
  theWarship.type=0; theWarship.sprite_index=sCHAOS_WarshipMain
  theWarship.image_xscale=0.3; theWarship.image_yscale=0.3

  theAbomination=instance_create(240,432,oMisc)
  theAbomination.type=0; theAbomination.sprite_index=sAbom_Base
  theAbomination.image_xscale=0.3; theAbomination.image_yscale=0.3
}
else if global.gameProgress=5560 and room=rCh21_WastelandA
{
  abilSetRemove(0)
  charSwitcher(0)
  fadeColor=c_black
  fadeAlpha=1
}
else if global.gameProgress=5590 and room=rDistortionA
{
  global.gamePaused=1
  fadeColor=c_black
  fadeAlpha=1
}
else if room=rDistFinal_Round2
{
  hexorFadeBlack=255
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gameProgress=5520 and room=rCh21_Main_75 //----- [1] Jeremy said you'd fall here -----
{
  if sceneProgress=0
  {
    sceneDelay+=1
    if sceneDelay=1 {stopAllMusic()}
    if sceneDelay>=30
    {
      fadeAlpha-=0.02
      if fadeAlpha<=0 {sceneDelay=0; sceneProgress+=1}
    }
  }
  else if sceneProgress=1 and bWaitForInput=false
    msgCreate(0,0,"Jerry","You called it, Jeremy. Fell right where you said she would.",0,3,oMessageCutscene,1)
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"Claire","I'm fine, no help from you guys.",0,3,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Oh we know.",0,3,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Claire","Yeah, I'll just lie here for now. Do you know what's going on?",0,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Jeremy, everyone's here. Can you please explain now? I'm pretty lost too.",0,3,oMessageCutscene,1)
  else if sceneProgress=6 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","It's simple. I've undone the game state. Things reverted back to a specific point.",0,3,oMessageCutscene,1)
  else if sceneProgress=7 and bWaitForInput=false
    msgCreate(0,0,"Jerry","So like... time travel?",0,3,oMessageCutscene,1)
  else if sceneProgress=8 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Uh... yes and no. I used that one time undo that I was given, but there was no telling how far that would actually go. Everything reverted back. Bots that were removed are now back nor do they have any recollection of what happened.",0,3,oMessageCutscene,1)
  else if sceneProgress=9 and bWaitForInput=false
    msgCreate(0,0,"Jerry","But we do?",0,3,oMessageCutscene,1)
  else if sceneProgress=10 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Humans wouldn't be affected it seems.",0,3,oMessageCutscene,1)
  else if sceneProgress=11 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Oh man, I'm afraid to ask... how far back did we go? Please don't tell me we have to fight the Shroud Lord again.",0,3,oMessageCutscene,1)
  else if sceneProgress=12 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Not THAT far back. We've gone back to the point just before we were going to take on the Abomination.",0,3,oMessageCutscene,1)
  else if sceneProgress=13 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Ah f... Wait... that means Hex is back?",0,3,oMessageCutscene,1)
  else if sceneProgress=14 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Unfortunately, yes, but we...",0,3,oMessageCutscene,1)
  else if sceneProgress=15 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Okay so, hold on. The warship disappeared when you used that undo.",0,3,oMessageCutscene,1)
  else if sceneProgress=16 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","As I said, everything reverted back to the state it was in during this exact moment, except for humans. We kept our position, that is all.",0,3,oMessageCutscene,1)
  else if sceneProgress=17 and bWaitForInput=false
  {
    showEmote(oIdentifier,0,-6,sEmIdea)
    msgCreate(0,0,"Chao","Wait a minute! That means we have the upper hand now. Jeremy... you know what this means.",0,3,oMessageCutscene,1)
  }
  else if sceneProgress=18 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Yes. When we scanned the Parasite in the cave, it revealed very detailed data on what went wrong.",0,3,oMessageCutscene,1)
  else if sceneProgress=19 and bWaitForInput=false
    msgCreate(0,0,"Jerry","I don't follow. Advantage as in we know all their attacks? It should be easier this time around, right?",0,3,oMessageCutscene,1)
  else if sceneProgress=20 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","We can't do things the same way as before. Jerry, all of us were going to die. Hex set the ship to blow up on us all.",0,3,oMessageCutscene,1)
  else if sceneProgress=21 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","I saw it happening and I'm not going to allow that to happen again. For once, we have the upper hand on Hex. We know exactly what he's going to do.",0,3,oMessageCutscene,1)
  else if sceneProgress=22 and bWaitForInput=false
    msgCreate(0,0,"Jerry","So you have a plan, then?",0,3,oMessageCutscene,1)
  else if sceneProgress=23 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Yes, Chao and I both do. You want to explain this one, sis?",0,3,oMessageCutscene,1)
  else if sceneProgress=24 and bWaitForInput=false
    msgCreate(0,0,"Chao","It's simple. Forcing the Parasite out of the Abomination will kill the Abomination.",0,3,oMessageCutscene,1)
  else if sceneProgress=25 and bWaitForInput=false
    msgCreate(0,0,"Claire","Oh gross, you're not really suggesting what I think you are.",0,3,oMessageCutscene,1)
  else if sceneProgress=26 and bWaitForInput=false
    msgCreate(0,0,"Chao","I am. We need to get inside the Abomination and destroy the Parasite from within it.",0,3,oMessageCutscene,1)
  else if sceneProgress=27 and bWaitForInput=false
    msgCreate(0,0,"Claire","... How do we get inside that thing?",0,3,oMessageCutscene,1)
  else if sceneProgress=28 and bWaitForInput=false
    msgCreate(0,0,"Chao","Simple, we used the instruments wrong. We weren't supposed to use them to weaken the creature from the outside, but from the inside. They would have told us about the real weak spots if we knew how to use them properly.",0,3,oMessageCutscene,1)
  else if sceneProgress=29 and bWaitForInput=false
    msgCreate(0,0,"Chao","Okay so, listen carefully. When you two wake up the Abominaton, Jeremy and I will have the instruments display where you're supposed to attack. There will be two spots to hit, but both need to be hit at almost the same time.",0,3,oMessageCutscene,1)
  else if sceneProgress=30 and bWaitForInput=false
    msgCreate(0,0,"Chao","There's another thing. You'll need to do it 3 times.",0,3,oMessageCutscene,1)
  else if sceneProgress=31 and bWaitForInput=false
    msgCreate(0,0,"Claire","That shouldn't be hard. If I understand this right, the instruments will mark the two spots we need to hit at roughly the same time, and we need to do it 3 times.",0,3,oMessageCutscene,1)
  else if sceneProgress=32 and bWaitForInput=false
    msgCreate(0,0,"Chao","Right, but explosives are the only thing that will damage these... invisible weak spots. Claire, your Morph Bombs should suffice.",0,3,oMessageCutscene,1)
  else if sceneProgress=33 and bWaitForInput=false
    msgCreate(0,0,"Chao","There's one other thing. Based on what we data mined from the fight in the cave, this will only work on its first phase.",0,3,oMessageCutscene,1)
  else if sceneProgress=34 and bWaitForInput=false
    msgCreate(0,0,"Claire","That's...",0,3,oMessageCutscene,1)
  else if sceneProgress=35 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Amazing!",0,3,oMessageCutscene,1)
  else if sceneProgress=36 and bWaitForInput=false
    msgCreate(0,0,"Claire","Amazingly dumb.",0,3,oMessageCutscene,1)
  else if sceneProgress=37 and bWaitForInput=false
    msgCreate(0,0,"Jerry","You don't like weird secret stuff like that?",0,3,oMessageCutscene,1)
  else if sceneProgress=38 and bWaitForInput=false
    msgCreate(0,0,"Claire","I don't like things you need game guides for to figure out.",0,3,oMessageCutscene,1)
  else if sceneProgress=39 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Gonna have to stop you two there. You both know what to do now.",0,3,oMessageCutscene,1)
  else if sceneProgress=40 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Yep. We do.",0,3,oMessageCutscene,1)
  else if sceneProgress=41 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","We only get one shot at this. If we can pull this off, the Abomination will no longer be under Hex's control.",0,3,oMessageCutscene,1)
  else if sceneProgress=42 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Huh, hopefully this all works.",0,3,oMessageCutscene,1)
  else if sceneProgress=43 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","It has to. I've seen what the alternate outcome would be.",0,3,oMessageCutscene,1)
  else if sceneProgress=44 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","WAIT WAIT... one more thing.",0,3,oMessageCutscene,1)
  else if sceneProgress=45 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","The pipe there next to the sign. If for any reason you need to return to the world before all this undo mess, that'll do it for you. Ya know, for gameplay reasons.",0,3,oMessageCutscene,1)
  else if sceneProgress=46
  {
    global.canCharSwap=2
    var tFlash,tempMplay;
    tFlash=instance_create(0,0,oScreenFlash); tFlash.fadeSpeed=0.2
    with oMisc {instance_destroy()}
    tempMplay=findMusic(13)
    playMusic(tempMplay,0,0)
    global.gamePaused=0
    sceneDelay=0; sceneProgress=0
    global.gameProgress=5530
  }
}
else if global.gameProgress=5530 and room=rAbomA //----- [2] The plan -----
{
  if sceneProgress=0
  {
    if oPlayer1.x>=304
    {
      global.gamePaused=1
      oPlayer1.y+=4
      if oPlayer1.y>=248
      {
        scenePChk(oPlayer1.x,248,0,0.1,1)
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
    msgCreate(0,0,"Claire","Hold on you guys, but what exactly is the plan here? I assume there is one?",0,3,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","My bad, I should have explained better... Okay, once you guys destroy the Parasite from inside, it'll lose control of the Abomination and well...",0,3,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Claire","Hold on... no way, Jeremy. You're really gonna try... THAT?!",0,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","We're finally one step ahead of Hex now. That ship is all he has left.",0,3,oMessageCutscene,1)
  else if sceneProgress=6 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Okay, I'm just really slow right now. What the hell is the plan here?",0,3,oMessageCutscene,1)
  else if sceneProgress=7 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","We're going to ask the Abomination to absorb the warship.",0,3,oMessageCutscene,1)
  else if sceneProgress=8 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Is that really a good idea? The whole point of this was to prevent that from happening.",0,3,oMessageCutscene,1)
  else if sceneProgress=9 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","It won't be under Hex's control any longer. It wanted us to save it from this Parasite.",0,3,oMessageCutscene,1)
  else if sceneProgress=10 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Then what? What will this thing do after it absorbs the ship's firepower? What if the Abomination says no?",0,3,oMessageCutscene,1)
  else if sceneProgress=11 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Do you have any other ideas, then? We can't go back to that ship now. Hex will know something is up.",0,3,oMessageCutscene,1)
  else if sceneProgress=12 and bWaitForInput=false
    msgCreate(0,0,"Jerry","No, I don't, but if all of you are okay with this plan, I'll go along with it. We've just gotten screwed every step of the way.",0,3,oMessageCutscene,1)
  else if sceneProgress=13 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","I'll keep my guard up. I know this sounds crazy, but I know it'll work.",0,3,oMessageCutscene,1)
  else if sceneProgress=14 and bWaitForInput=false
    msgCreate(0,0,"Jerry","I trust you, Jeremy... as crazy as THAT sounds.",0,3,oMessageCutscene,1)
  else if sceneProgress=15 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","I deserve that.",0,3,oMessageCutscene,1)
  else if sceneProgress=16 and bWaitForInput=false
    msgCreate(0,0,"Jerry","This whole thing has been a bumpy ride, but I know you. The crazier these things are, the better it's going to be when it actually works.",0,3,oMessageCutscene,1)
  else if sceneProgress=17 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Alright you guys, let's do this.",0,3,oMessageCutscene,1)
  else if sceneProgress=18
  {
    global.gamePaused=0
    sceneDelay=0; sceneProgress=0
    global.gameProgress=5540
  }
}
else if global.gameProgress=5540 and room=rAbomD //----- [] Chao attack tutorial -----
{
  if sceneProgress=0
  {
    if oPlayer1.x>=864 {sceneProgress+=1}
  }
  else if sceneProgress=1
  {
    sceneDelay+=1
    if sceneDelay>=40 {sceneDelay=120; sceneProgress+=1}
  }
  else if sceneProgress=2
  {
    sceneDelay+=1
    if sceneDelay=130
    {
      tNewAtkSpot=instance_create(752,112,oVP_AtkSpot); tNewAtkSpot.image_blend=c_green
    }
    else if sceneDelay=260
    {
      tNewAtkSpot=instance_create(864,112,oVP_AtkSpot); tNewAtkSpot.image_blend=c_green
    }
    else if sceneDelay=390
    {
      tNewAtkSpot=instance_create(976,112,oVP_AtkSpot); tNewAtkSpot.image_blend=c_green
    }
    else if sceneDelay=420 {sceneDelay=0}
  }
}
else if global.gameProgress=5550 and room=rAbomF //----- [3] Boss Fight: Virus Parasite -----
{
  if global.bossTrack=0
  {
    if sceneProgress=0
    {
      sceneDelay+=1
      if sceneDelay=1 {stopAllMusic()}
      if sceneDelay>=30
      {
        fadeAlpha-=0.02
        if fadeAlpha<=0 {sceneDelay=0; sceneProgress+=1}
      }
    }
    else if sceneProgress=1
    {
      sceneDelay+=1
      if sceneDelay>=20 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=2 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","Just like I thought, it's taken on a different form.",0,3,oMessageCutscene,1)
    else if sceneProgress=3 and bWaitForInput=false
      msgCreate(0,0,"Jerry","Hey, what's going on? Neither Claire nor myself are in there.",0,3,oMessageCutscene,1)
    else if sceneProgress=4 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","Oh crap...",0,3,oMessageCutscene,1)
    else if sceneProgress=5 and bWaitForInput=false
      msgCreate(0,0,"Jerry","Oh crap? That's not acceptable. What's going on?",0,3,oMessageCutscene,1)
    else if sceneProgress=6 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","Chao, you're gonna have to do this one.",0,3,oMessageCutscene,1)
    else if sceneProgress=7 and bWaitForInput=false
      msgCreate(0,0,"Chao","What?! Uh, well alright. I'll do my best.",0,3,oMessageCutscene,1)
    else if sceneProgress=8 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","I know you will. Just ya know, don't touch the fire or anything really.",0,3,oMessageCutscene,1)
    else if sceneProgress=9 and bWaitForInput=false
      msgCreate(0,0,"Chao","I can still scan it at least.",0,3,oMessageCutscene,1)
    else if sceneProgress=10 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","Alright, you've got this! But before that...",0,3,oMessageCutscene,1)
    else if sceneProgress=11
    {
      sceneDelay+=1
      if sceneDelay=20
      {
        playSound(global.snd_Magic,0,1,8000)
        for(i=0;i<8;i+=1)
        {
          myInstr[i]=instance_create(240,176,oMisc)
          myInstr[i].type=0; myInstr[i].sprite_index=sPauseM_Instruments; myInstr[i].image_index=i
          myInstr[i].image_speed=0; myInstr[i].depth=20; myInstr[i].visible=0
        }
        instrDist=320
        instrAng=0
      }
      else if sceneDelay>=22 and sceneDelay<=199
      {
        for(i=0;i<8;i+=1)
        {
          myInstr[i].visible=1
          myInstr[i].x=240+lengthdir_x(instrDist,instrAng+(i*45))
          myInstr[i].y=176+lengthdir_y(instrDist,instrAng+(i*45))
        }
        instrAng-=3
        instrDist-=8
        if instrDist<=64 {sceneDelay=200}
      }
      else if sceneDelay>=201 and sceneDelay<=399
      {
        for(i=0;i<8;i+=1)
        {
          myInstr[i].x=240+lengthdir_x(instrDist,instrAng+(i*45))
          myInstr[i].y=176+lengthdir_y(instrDist,instrAng+(i*45))
        }
        instrAng-=3
        if sceneDelay>=260
        {
          instrDist-=2
          if instrDist<=4
          {
            playSound(global.snd_Magic,0,1,41000)
            with oMisc {instance_destroy()}
            var tFlash;
            tFlash=instance_create(0,0,oScreenFlash); tFlash.fadeSpeed=0.2
            sceneDelay=400
          }
        }
      }
      else if sceneDelay>=420 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=12 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","It can't escape, Chao. Now's your chance!",0,3,oMessageCutscene,1)
    else if sceneProgress=13 and bWaitForInput=false
      msgCreate(0,0,"Chao","I can do this!",0,3,oMessageCutscene,1)
    else if sceneProgress=14
    {
      global.gamePaused=0
      var tBossTitle,tempMplay,enemyBarrier;
      tBossTitle=instance_create(0,0,oBossNameDisplay)
      tBossTitle.bossName="Virus Parasite"
      tBossTitle.bossTitle="Hex's Secret"
      tempMplay=findMusic(832)
      playMusic(tempMplay,0,0)
      oVirusParasite_Main.activateBoss=1
      global.currentBoss="Virus Parasite"
      global.bossTrack=1
      sceneDelay=0; sceneProgress=0
    }
  }
  else if global.bossTrack=1
  {
    if sceneProgress=1 //End Boss
    {
      oHUD.visible=0
      global.gamePaused=true
      tempMplay=findMusic(0)
      playMusic(tempMplay,0,0)
      fadeColor=c_black
      sceneProgress+=1
    }
    else if sceneProgress=2
    {
      sceneDelay+=1
      if sceneDelay>=60 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=3 and bWaitForInput=false
      msgCreate(0,0,"Chao","I... I did it!",0,3,oMessageCutscene,1)
    else if sceneProgress=4
    {
      sceneDelay+=1
      if sceneDelay>=30 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=5 and bWaitForInput=false
      msgCreate(0,0,"Chao","Guys?",0,3,oMessageCutscene,1)
    else if sceneProgress=6 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","We're here. Just... focusing. I want to make sure nothing goes wrong.",0,3,oMessageCutscene,1)
    else if sceneProgress=7
    {
      sceneDelay+=1
      if sceneDelay>=21 and sceneDelay<=70 {fadeAlpha+=0.02}
      if sceneDelay=40
      {
        msgCreate(0,0,"Chao","Guys? What's going on?",0,1,oMessagePerson,0)
        newMessage.fadingTime=70
      }
      else if sceneDelay>=140 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=8 and bWaitForInput=false
      msgCreate(0,0,"Chao","... Anyone?",0,3,oMessageCutscene,1)
    else if sceneProgress=9
    {
      sceneDelay+=1
      if sceneDelay>=30 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=10 and bWaitForInput=false
      msgCreate(32,80,"Booming Voice","I understand your request.",0,3,oMessageCutscene,1)
    else if sceneProgress=11 and bWaitForInput=false
    {
      showEmote(oIdentifier,0,-6,sEmExcite)
      msgCreate(0,0,"Chao","...",0,3,oMessageCutscene,1)
    }
    else if sceneProgress=12 and bWaitForInput=false
      msgCreate(0,0,"Chao","Are you the creature we helped free?",0,3,oMessageCutscene,1)
    else if sceneProgress=13 and bWaitForInput=false
      msgCreate(32,80,"Booming Voice","You are correct, little fairy. I have heard the request made of me and will carry it out.",0,3,oMessageCutscene,1)
    else if sceneProgress=14 and bWaitForInput=false
      msgCreate(0,0,"Chao","Thank you for helping us.",0,3,oMessageCutscene,1)
    else if sceneProgress=15 and bWaitForInput=false
      msgCreate(32,80,"Booming Voice","I do not carry out this request for you. Simply, such power cannot exist within one entity. Neither of them should exist if at all possible.",0,3,oMessageCutscene,1)
    else if sceneProgress=16 and bWaitForInput=false
      msgCreate(0,0,"Chao","What do you mean by that? Who are we talking about?",0,3,oMessageCutscene,1)
    else if sceneProgress=17 and bWaitForInput=false
      msgCreate(32,80,"Booming Voice","The power to change the world as one desires. No one entity should have this power.",0,3,oMessageCutscene,1)
    else if sceneProgress=18 and bWaitForInput=false
      msgCreate(32,80,"Booming Voice","You must go. There is not much time before I cannot stop myself. I will consume that monstrosity in the sky.",0,3,oMessageCutscene,1)
    else if sceneProgress=19 and bWaitForInput=false
      msgCreate(0,0,"Chao","Will you be okay?",0,3,oMessageCutscene,1)
    else if sceneProgress=20 and bWaitForInput=false
      msgCreate(32,80,"Booming Voice","The concern is admirable, but you must leave now.",0,3,oMessageCutscene,1)
    else if sceneProgress=21
    {
      global.currentBoss=""
      global.bossTrack=0
      global.gameProgress=5560
      room_goto(rAbomCutA)
    }
  }
}
else if global.gameProgress=5560 and room=rAbomCutA //----- [4] Abomination destroys the Warship -----
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
  else if sceneProgress=1
  {
    sceneDelay+=1
    if sceneDelay>=20
    {
      theAbomination.y-=1
    }
    if sceneDelay>=80
    {
      fadeAlpha+=0.02
      if fadeAlpha>=1 {sceneDelay=0; sceneProgress+=1}
    }
  }
  else if sceneProgress=2
  {
    sceneDelay+=1
    if sceneDelay>=30 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=3
  {
    global.newMapX=176
    global.newMapY=304
    room_goto(rCh21_WastelandA)
  }
}
else if global.gameProgress=5560 and room=rCh21_WastelandA //----- [] The wasteland -----
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
  else if sceneProgress=1
  {
    sceneDelay+=1
    if sceneDelay>=20 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=2
  {
    global.gamePaused=0
    sceneDelay=0; sceneProgress=0
    global.gameProgress=5570
  }
}
else if global.gameProgress=5570 and room=rCh21_WastelandA //----- [5] Meeting with Warmaster -----
{
  if sceneProgress=0
  {
    warmasterEnd=instance_create(528,304,oMisc)
    warmasterEnd.type=0; warmasterEnd.sprite_index=sWarmasterA_Idle
    warmasterEnd.image_speed=0.15; warmasterEnd.image_xscale=-1.25; warmasterEnd.image_yscale=1.25
    sceneProgress+=1
  }
  else if sceneProgress=1
  {
    if sceneDelay=0
    {
      if oPlayer1.x>=432
      {
        global.gamePaused=1
        var tFlash;
        tFlash=instance_create(0,0,oScreenFlash); tFlash.fadeSpeed=0.2
        oPlayer1.visible=0
        charJerry=instance_create(432,304,oMisc)
        charJerry.sprite_index=sJerryIdle; charJerry.image_speed=0.1; charJerry.type=2
        charClaire=instance_create(384,304,oMisc)
        charClaire.sprite_index=sClaireIdle; charClaire.image_speed=0.1; charClaire.type=2
        scenePChk(496,304,0,0.1,1)
        stopPlayer()
        sceneDelay=1
      }
    }
    else if sceneDelay>=1
    {
      sceneDelay+=1
      if sceneDelay>=30
      {
        fadeAlpha-=0.02
        if fadeAlpha<=0 {sceneDelay=0; sceneProgress+=1}
      }
    }
  }
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"Warmaster","I don't know how you managed what you did, but don't think this is over.",6,3,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","No, it is over. Hex's plans are over and you don't need to follow him anymore. You've got nothing now.",0,3,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Warmaster","You want me to stop now? After all this?",6,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","You said so yourself the last time we met. We know what you want, but choosing to resort to violence to keep humans off this island isn't going to work now. We're all in this together now.",0,3,oMessageCutscene,1)
  else if sceneProgress=6 and bWaitForInput=false
    msgCreate(0,0,"Warmaster","And now you speak lies to me. We spoke of no such thing.",6,3,oMessageCutscene,1)
  else if sceneProgress=7 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","We did... you just don't have any memory of it.",0,3,oMessageCutscene,1)
  else if sceneProgress=8 and bWaitForInput=false
    msgCreate(0,0,"Warmaster","What are you saying? ...Jeremy, have you gone so deep that you can change our thoughts?",6,3,oMessageCutscene,1)
  else if sceneProgress=9 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","No, I don't have that kind of access. There was something I could do that was left from before. Believe me, I didn't want to resort to it, but I felt I had to.",0,3,oMessageCutscene,1)
  else if sceneProgress=10 and bWaitForInput=false
    msgCreate(0,0,"Warmaster","...What did you do?",6,3,oMessageCutscene,1)
  else if sceneProgress=11 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","I don't think you'd believe me if I told you. Though I can say for certain that you would lose against us.",0,3,oMessageCutscene,1)
  else if sceneProgress=12 and bWaitForInput=false
    msgCreate(0,0,"Warmaster","Impossible! You're just trying to get me to back down. You may be right that I don't need to follow Hex any longer or that I don't have any leverage... but...",6,3,oMessageCutscene,1)
  else if sceneProgress=13 and bWaitForInput=false
    msgCreate(0,0,"Jerry","But nothing, man. It doesn't matter. You'll remember what you did in Subconscious Filter. We know you led us out of there so we could free the Abomination and stop Hex.",0,3,oMessageCutscene,1)
  else if sceneProgress=14 and bWaitForInput=false
    msgCreate(0,0,"Warmaster","And that matters how?",6,3,oMessageCutscene,1)
  else if sceneProgress=15 and bWaitForInput=false
    msgCreate(0,0,"Jerry","On the ship... we read your notes.",0,3,oMessageCutscene,1)
  else if sceneProgress=16 and bWaitForInput=false
    msgCreate(0,0,"Warmaster","...Is that so? From what I recall, you never stepped foot in that portion of the ship, so that is not...",6,3,oMessageCutscene,1)
  else if sceneProgress=17 and bWaitForInput=false
    msgCreate(0,0,"Warmaster","It's true then. In some way or another, you've seen what was to come. I am afraid to know the extent of what you did. But know that the sort of power you have should not be allowed.",6,3,oMessageCutscene,1)
  else if sceneProgress=18 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","That's why I need to find Hex... where is he?",0,3,oMessageCutscene,1)
  else if sceneProgress=19 and bWaitForInput=false
    msgCreate(0,0,"Warmaster","He ran to a place where you shouldn't follow. A place where he has control.",6,3,oMessageCutscene,1)
  else if sceneProgress=20 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Do you know what he plans to do?",0,3,oMessageCutscene,1)
  else if sceneProgress=21 and bWaitForInput=false
    msgCreate(0,0,"Warmaster","He has no plans, Jeremy. You crushed that. What do you think he would do? Where do you think he would go?",6,3,oMessageCutscene,1)
  else if sceneProgress=22 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","I know exactly where he is... I have to go there.",0,3,oMessageCutscene,1)
  else if sceneProgress=23 and bWaitForInput=false
    msgCreate(0,0,"Warmaster","That is dangerous, but it is your responsibility. I won't impede this and will back away.",6,3,oMessageCutscene,1)
  else if sceneProgress=24 and bWaitForInput=false
    msgCreate(0,0,"Warmaster","As I may have once said, we are not friends, but we are not enemies either. If one day we meet again, I hope it is under better circumstances.",6,3,oMessageCutscene,1)
  else if sceneProgress=25 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Maybe we can have a duel sometime... for fun... and to show you how we beat you.",0,3,oMessageCutscene,1)
  else if sceneProgress=26 and bWaitForInput=false
    msgCreate(0,0,"Warmaster","I'm pretty sure it was Claire that did most of it.",6,3,oMessageCutscene,1)
  else if sceneProgress=27
  {
    sceneDelay+=1
    if sceneDelay=5
    {
      warmasterEnd.sprite_index=sPlayerDiscombobulate
      warmasterEnd.image_index=0; warmasterEnd.image_speed=0
    }
    else if sceneDelay>=6 and sceneDelay<=35 {warmasterEnd.y-=14}
    else if sceneDelay>=40
    {
      with warmasterEnd {instance_destroy()}
      sceneDelay=0; sceneProgress+=1
    }
  }
  else if sceneProgress=28 and bWaitForInput=false
    msgCreate(0,0,"Claire","He's right you know.",0,3,oMessageCutscene,1)
  else if sceneProgress=29 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Yeah yeah, I know, but really though, more importantly...",0,3,oMessageCutscene,1)
  else if sceneProgress=30 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Yeah, I know where Hex is.",0,3,oMessageCutscene,1)
  else if sceneProgress=31 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","He's in the distortion worlds.",0,3,oMessageCutscene,1)
  else if sceneProgress=32 and bWaitForInput=false
    msgCreate(0,0,"Jerry","And how would we even get in those?",0,3,oMessageCutscene,1)
  else if sceneProgress=33 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","There is no we in this. I'm going in alone.",0,3,oMessageCutscene,1)
  else if sceneProgress=34 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Like hell you are.",0,3,oMessageCutscene,1)
  else if sceneProgress=35 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Jerry, that paralysis is still affecting you. I'm not allowing you in a place that Hex can control to that degree. Claire, I won't allow you either, you'll need to look after Jerry.",0,3,oMessageCutscene,1)
  else if sceneProgress=36 and bWaitForInput=false
    msgCreate(0,0,"Chao","Jeremy, I get it, but at least allow me to come in there with you.",0,3,oMessageCutscene,1)
  else if sceneProgress=37 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","You know what I'm going to say to that. This is just something I have to do alone. Hex is my problem and I'm going to take care of it.",0,3,oMessageCutscene,1)
  else if sceneProgress=38 and bWaitForInput=false
    msgCreate(0,0,"Chao","You be careful then.",0,3,oMessageCutscene,1)
  else if sceneProgress=39 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Of course I will, sis.",0,3,oMessageCutscene,1)
  else if sceneProgress=40 and bWaitForInput=false
    msgCreate(0,0,"Chao","We'll see you soon?",0,3,oMessageCutscene,1)
  else if sceneProgress=41 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Yeah.",0,3,oMessageCutscene,1)
  else if sceneProgress=42
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
      oPlayer1.visible=1
      global.activeCharacter=2
      oPlayer1.sprite_index=sJeremyMechIdle
      abilSetRemove(1)
      global.hasShoes[0]=2; global.hasShoes[1]=2
      charSwitcher(2)
    }
    else if sceneDelay>=70 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=43 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Ugh, still not flashy.",0,3,oMessageCutscene,1)
  else if sceneProgress=44 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Hater.",0,3,oMessageCutscene,1)
  else if sceneProgress=45 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Always! ...Hope to see you soon, man.",0,3,oMessageCutscene,1)
  else if sceneProgress=46 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Yep.",0,3,oMessageCutscene,1)
  else if sceneProgress=47
  {
    oPlayer1.visible=1
    global.activeCharacter=2
    oPlayer1.sprite_index=sJeremyMechIdle
    abilSetRemove(1)
    global.hasShoes[0]=2; global.hasShoes[1]=2
    charSwitcher(2)
    with oMisc {instance_destroy()}
    with oNPC_GeneralA {y=304}
    oIdentifier.followTarget=oNPC_GeneralA
    global.gamePaused=0
    sceneDelay=0; sceneProgress=0
    global.gameProgress=5580
  }
}
else if global.gameProgress=5580 and room=rCh21_WastelandB //----- [6] Jerry talks to Jeremy -----
{
  if sceneProgress=0
  {
    if oPlayer1.x>=736
    {
      global.gamePaused=true
      oPlayer1.y+=4
      if oPlayer1.y>=304
      {
        with oAttackBase {instance_destroy()}
        charJerry=instance_create(464,304,oMisc)
        charJerry.sprite_index=sJerryWalk; charJerry.image_speed=0.33; charJerry.type=2
        scenePChk(736,304,0,0.1,1)
        stopPlayer()
        oPlayer1.sprite_index=sJeremyMechIdle; oPlayer1.image_speed=0; oPlayer1.image_index=0
        sceneProgress+=1
      }
    }
  }
  else if sceneProgress=1 and bWaitForInput=false
  {
    showEmote(oPlayer1,0,-50,sEmQuestion)
    msgCreate(0,0,"Jerry","Yo!",0,3,oMessageCutscene,1)
  }
  else if sceneProgress=2
  {
    sceneDelay+=1
    if sceneDelay=1
    {
      oPlayer1.image_xscale=-1
      oPlayer1.facing=oPlayer1.RIGHT
    }
    
    charJerry.x+=6
    if charJerry.x>=688
    {
      charJerry.x=688
      charJerry.sprite_index=sJerryIdle; charJerry.image_speed=0.1
      sceneDelay=0; sceneProgress+=1
    }
  }
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","I don't want you coming with me, Jerry. I told you, in there...",0,3,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Yeah I know. Unpredictable, Hex is dangerous, all that. Look, I know you better than anyone. I know what you're trying to do.",0,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Do you?",0,3,oMessageCutscene,1)
  else if sceneProgress=6 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Look man. What you said to me on the ship back then, when we all thought that was it... Right back at you, ya know? You don't have to go through with all this.",0,3,oMessageCutscene,1)
  else if sceneProgress=7 and bWaitForInput=false
    msgCreate(0,0,"Jerry","I know what the Abomination and the Warmaster said back there bothered you. About all that power you and Hex hold.#I don't give a damn about any of that though.",0,3,oMessageCutscene,1)
  else if sceneProgress=8 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","What do you want, Jerry? Just tell me.",0,3,oMessageCutscene,1)
  else if sceneProgress=9 and bWaitForInput=false
    msgCreate(0,0,"Jerry","I want you to come back. Look, I'm not going to stop you or lecture you. We just want you to come back. I don't know if you fooled Claire or your sister, but I know what you're going to do.",0,3,oMessageCutscene,1)
  else if sceneProgress=10 and bWaitForInput=false
    msgCreate(0,0,"Jerry","None of us care that you have these world changing powers. You're still you, so what are you worried about?",0,3,oMessageCutscene,1)
  else if sceneProgress=11 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","If it wasn't for me, Jerry, none of this would have happened.",0,3,oMessageCutscene,1)
  else if sceneProgress=12 and bWaitForInput=false
    msgCreate(0,0,"Jerry","But it did happen and there's no changing that. Just come back to us when you're done in there. I'm not gonna try to stop you, but promise me, your best friend, that you're coming out of there alive.",0,3,oMessageCutscene,1)
  else if sceneProgress=13 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Yeah, I'll be back.",0,3,oMessageCutscene,1)
  else if sceneProgress=14 and bWaitForInput=false
    msgCreate(0,0,"Jerry","From the beginning, I didn't mind any of this. Before we were pulled in, we barely had any time together. Life just took us apart.",0,3,oMessageCutscene,1)
  else if sceneProgress=15 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","I remember.",0,3,oMessageCutscene,1)
  else if sceneProgress=16 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Even though it was jarring to be pulled from it all, I was finally with my best friend again. Hell, we were kinda gaming together.",0,3,oMessageCutscene,1)
  else if sceneProgress=17 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","It was all fun. You're right! We were in our element, weren't we?",0,3,oMessageCutscene,1)
  else if sceneProgress=18 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Like those games we played together. Those were the best times!",0,3,oMessageCutscene,1)
  else if sceneProgress=19 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","This all did feel like that, didn't it?",0,3,oMessageCutscene,1)
  else if sceneProgress=20 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Let's keep it going. Well, after you take care of business... Man I've always wanted to say that.",0,3,oMessageCutscene,1)
  else if sceneProgress=21 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","You got it. I'll be coming back. I promise.",0,3,oMessageCutscene,1)
  else if sceneProgress=22
  {
    with oMisc {instance_destroy()}
    with oNPC_GeneralA {y=304}
    global.gamePaused=0
    sceneDelay=0; sceneProgress=0
    global.gameProgress=5590
  }
}
else if global.gameProgress=5590 and room=rDistortionA //----- [7] Jeremy goes forward -----
{
  if sceneProgress=0 {sceneProgress+=1} //So players can skip the fade-in
  else if sceneProgress=1
  {
    sceneDelay+=1
    if sceneDelay=1
    {
      oPlayer1.sprite_index=sJeremyMechIdle
      stopAllMusic()
    }
    if sceneDelay>=30
    {
      fadeAlpha-=0.01
      if fadeAlpha<=0 {sceneDelay=0; sceneProgress+=1}
    }
  }
  else if sceneProgress=2
  {
    sceneDelay+=1
    if sceneDelay>=30 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","It's time to end this...#Hex, I'm coming for you.",0,3,oMessageCutscene,1)
  else if sceneProgress=4
  {
    var tempMplay;
    tempMplay=findMusic(1026)
    playMusic(tempMplay,0,0)
    global.gamePaused=0
    sceneDelay=0; sceneProgress=0
    global.gameProgress=5600
  }
}
else if global.gameProgress=5640 and room=rDistortionF //----- [8] Final Boss Fight: Hexor -----
{
  if global.bossTrack=0
  {
    if sceneProgress=0
    {
      if oPlayer1.x>=160
      {
        global.gamePaused=true
        oPlayer1.y+=4
        if oPlayer1.y>=288
        {
          with oAttackBase {instance_destroy()}
          scenePChk(160,288,0,0.1,1)
          stopPlayer()
          oPlayer1.sprite_index=sJeremyMechIdle; oPlayer1.image_speed=0; oPlayer1.image_index=0
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
      msgCreate(0,0,"Jeremy","You decided to not run.",0,3,oMessageCutscene,1)
    else if sceneProgress=3 and bWaitForInput=false
      msgCreate(0,0,"Hex","You weren't entirely wrong when you stated I have nothing. I don't have the power I boast here.",0,3,oMessageCutscene,1)
    else if sceneProgress=4 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","You've never had any. You have others do it all for you while everything else you do is for show. You're a fake.",0,3,oMessageCutscene,1)
    else if sceneProgress=5 and bWaitForInput=false
      msgCreate(0,0,"Hex","That's right, I'm a fake. If I'm one, then so are you. We are the same, Jeremy. Simply... different goals.",0,3,oMessageCutscene,1)
    else if sceneProgress=6 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","... I'll ask it only once more, Hex... What do you want?",0,3,oMessageCutscene,1)
    else if sceneProgress=7 and bWaitForInput=false
      msgCreate(0,0,"Hex","I want the same thing you did when I was made. I want out of this, but we both know that's impossible.",0,3,oMessageCutscene,1)
    else if sceneProgress=8 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","What would you do if I walked away right now?",0,3,oMessageCutscene,1)
    else if sceneProgress=9 and bWaitForInput=false
      msgCreate(0,0,"Hex","You know what I'd do.",0,3,oMessageCutscene,1)
    else if sceneProgress=10 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","And that's why I'm here, Hex.",0,3,oMessageCutscene,1)
    else if sceneProgress=11 and bWaitForInput=false
      msgCreate(0,0,"Hex","Please Jeremy, it's Hexor.",0,3,oMessageCutscene,1)
    else if sceneProgress=12
    {
      sceneDelay+=1
      if sceneDelay=20 {oHexor_Main.bShowTentacles=1}
      else if sceneDelay>=21 and sceneDelay<=70 {oHexor_Main.tentacleScale+=0.02}
      else if sceneDelay>=90 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=13 and bWaitForInput=false
      msgCreate(0,0,"Hexor","You were wrong to say I've got no power here.",0,3,oMessageCutscene,1)
    else if sceneProgress=14 and bWaitForInput=false
      msgCreate(0,0,"Hexor","Let us see which of us is truly superior.",0,3,oMessageCutscene,1)
    else if sceneProgress=15
    {
      global.gamePaused=0
      with oExit {instance_destroy()}
      var tBossTitle,tempMplay,enemyBarrier;
      tBossTitle=instance_create(0,0,oBossNameDisplay)
      tBossTitle.bossName="Hexor"
      tBossTitle.bossTitle="00110001"
      tempMplay=findMusic(833)
      playMusic(tempMplay,0,0)
      storeStatus(0)
      with oMisc {instance_destroy()}
      with oHexor_Main {instance_destroy()}
      instance_create(320,224,oHexor_Main)
      oHexor_Main.activateBoss=1; oHexor_Main.bShowTentacles=1; oHexor_Main.tentacleScale=1
      global.currentBoss="Hexor"
      global.bossTrack=1
      sceneDelay=0; sceneProgress=0
    }
  }
}
else if room=rDistFinal_Round2 //----- [9] Hexor asks Jeremy how he took the ship down -----
{
  if sceneProgress=1
  {
    if fadeAlpha<1 {fadeAlpha+=0.05}
    else if fadeAlpha>=1 {sceneProgress+=1}
  }
  else if sceneProgress=2
  {
    sceneDelay+=1
    if sceneDelay=1
    {
      var tempMplay;
      tempMplay=findMusic(0)
      playMusic(tempMplay,0,0)
      playSound(global.snd_EnemyDie,0,1,1)
      with oAttackBase {instance_destroy()}
      with oPlayerAfterImage {instance_destroy()}
      with oHexor_MachinePartA {instance_destroy()}
      oHexor_Main_R2.x=352; oHexor_Main_R2.y=288; oHexor_Main_R2.image_xscale=-1; oHexor_Main_R2.sprite_index=sHex_A_Idle
      oPlayer1.x=128; oPlayer1.y=288; oPlayer1.image_xscale=1; oPlayer1.sprite_index=sJF_Idle
    }
    if sceneDelay>=60 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=3
  {
    if fadeAlpha>0 {fadeAlpha-=0.05}
    else if fadeAlpha<=0 {sceneProgress+=1}
  }
  else if sceneProgress=4
  {
    sceneDelay+=1
    if sceneDelay>=20 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Hexor","How did you do it? How did you know not to kill the Abomination? I left no choice, no loophole, nothing... so how did you do it?",0,3,oMessageCutscene,1)
  else if sceneProgress=6 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","There WAS a loophole. We figured out that the Abomination would be saved by simply removing the parasite from within.",0,3,oMessageCutscene,1)
  else if sceneProgress=7 and bWaitForInput=false
    msgCreate(0,0,"Hexor","BUT HOW?! HOW DID YOU KNOW ABOUT IT?! There's no way you could have known how to get inside.",0,3,oMessageCutscene,1)
  else if sceneProgress=8 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","You wouldn't believe me anyway.",0,3,oMessageCutscene,1)
  else if sceneProgress=9 and bWaitForInput=false
    msgCreate(0,0,"Hexor","We have the power to change this world to our liking and you say that.",0,3,oMessageCutscene,1)
  else if sceneProgress=10 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","It won't change anything now... And we did fall for your trap. That's how I knew about it. And how I knew I had to prevent it.",0,3,oMessageCutscene,1)
  else if sceneProgress=11 and bWaitForInput=false
    msgCreate(0,0,"Hexor","Lies, we wouldn't be standing here right now if you had.#Me, the Warmaster, and your friends would be gone and you would be the only one left alive.",0,3,oMessageCutscene,1)
  else if sceneProgress=12 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Your plan didn't work that way.",0,3,oMessageCutscene,1)
  else if sceneProgress=13 and bWaitForInput=false
    msgCreate(0,0,"Hexor","TELL ME HOW YOU DID IT, JEREMY! How...",0,3,oMessageCutscene,1)
  else if sceneProgress=14 and bWaitForInput=false
    msgCreate(0,0,"Hexor","You couldn't have known.",0,3,oMessageCutscene,1)
  else if sceneProgress=15 and bWaitForInput=false
    msgCreate(0,0,"Hexor","Wait... No... You couldn't have.",0,3,oMessageCutscene,1)
  else if sceneProgress=16 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Eh?",0,3,oMessageCutscene,1)
  else if sceneProgress=17 and bWaitForInput=false
    msgCreate(0,0,"Hexor","Now I remember. I was there for it too. In fact, it might be in this very room you were told of this power.",0,3,oMessageCutscene,1)
  else if sceneProgress=18 and bWaitForInput=false
    msgCreate(0,0,"Hexor","You really went and turned back the world state. Let me guess, you had no idea what that would do.",0,3,oMessageCutscene,1)
  else if sceneProgress=19 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","How could I?",0,3,oMessageCutscene,1)
  else if sceneProgress=20 and bWaitForInput=false
    msgCreate(0,0,"Hexor","So... it all did go as planned. I had beaten you.",0,3,oMessageCutscene,1)
  else if sceneProgress=21 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","I don't know about that.",0,3,oMessageCutscene,1)
  else if sceneProgress=22 and bWaitForInput=false
    msgCreate(0,0,"Hexor","No no, this changes everything. I beat you once, I can do it again.",0,3,oMessageCutscene,1)
  else if sceneProgress=23 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","I'm not letting you out of here.",0,3,oMessageCutscene,1)
  else if sceneProgress=24 and bWaitForInput=false
    msgCreate(0,0,"Hexor","Go ahead and try, Jeremy.",0,3,oMessageCutscene,1)
  else if sceneProgress=25
  {
    sceneDelay+=1
    if sceneDelay>=20
    {
      oHexor_Main_R2.image_xscale-=0.2; oHexor_Main_R2.image_yscale+=0.2
      if hexorFadeBlack>0
      {
        hexorFadeBlack-=5
        oHexor_Main_R2.image_blend=make_color_rgb(hexorFadeBlack,hexorFadeBlack,hexorFadeBlack)
      }
    }
    if sceneDelay>=140 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=26
  {
    global.recAreaTrans+=1
    global.finalBossHP=1000
    global.pLife=global.pMaxLife
    global.jeremySuperEnergy=1500
    global.hasShoes[2]=1
    transition_steps=1; transition_kind=21
    room_goto(rDistFinal_Round3)
  }
}
else if room=rDistFinal_Round3 //----- [10] Jeremy gets bigger -----
{
  if sceneProgress=0 //Before punch
  {
    sceneDelay+=1
    if sceneDelay>=30 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=1 and bWaitForInput=false
    msgCreate(0,0,"Hexor","I've won, Jeremy.",0,3,oMessageCutscene,1)
  else if sceneProgress=2
  {
    sceneDelay+=1
    if sceneDelay=20
    {
      (467397).image_xscale=0;
      (467397).image_yscale=0;
    }
    else if sceneDelay>=21 and sceneDelay<=70
    {
      (467397).image_xscale+=0.02;
      (467397).image_yscale+=0.02;
    }
    else if sceneDelay=71
    {
      oPlayer1.visible=1
      with (467397) {instance_destroy()}
    }
    else if sceneDelay>=90 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Hexor","Expected.",0,3,oMessageCutscene,1)
  else if sceneProgress=4
  {
    sceneDelay+=1
    if sceneDelay>=1
    {
      (467396).x+=6;
    }
    
    if sceneDelay>=60
    {
      with (467396) {instance_destroy()}
      sceneDelay=0; sceneProgress+=1
    }
  }
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","I told you, I'm not letting you escape.",0,3,oMessageCutscene,1)
  else if sceneProgress=6
  {
    with (oMisc) {instance_destroy()}
    oHexor_Main_R3.bWindSound=1
    oPlayer1.visible=1
    global.gamePaused=false
    sceneProgress=10
  }
  
  if sceneProgress=11 //After punch
  {
    sceneDelay+=1
    if sceneDelay=1
    {
      SS_StopSound(global.snd_WindBlow)
      oHexor_Main_R3.bWindSound=0
      oPlayer1.image_speed=0; oPlayer1.image_index=0
    }
    if sceneDelay>=50 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=12 and bWaitForInput=false
    msgCreate(0,0,"Hexor","What have you done?",0,3,oMessageCutscene,1)
  else if sceneProgress=13 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","You have extreme control in here... Well...",0,3,oMessageCutscene,1)
  else if sceneProgress=14 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","So do I.",0,3,oMessageCutscene,1)
  else if sceneProgress=15 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","And I've placed us both in a state of statis.",0,3,oMessageCutscene,1)
  else if sceneProgress=16 and bWaitForInput=false
    msgCreate(0,0,"Hexor","Then you can't move.",0,3,oMessageCutscene,1)
  else if sceneProgress=17 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","That's correct. So how does that sound? An eternity of being frozen in time with a fist from the one you hate the most going straight into your face.",0,3,oMessageCutscene,1)
  else if sceneProgress=18 and bWaitForInput=false
    msgCreate(0,0,"Hexor","You'll really stay here forever to keep me trapped here? I'm sure your friend Jerry will have something to say about that.",0,3,oMessageCutscene,1)
  else if sceneProgress=19 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Nah, I was just relishing in this moment, cause I'm kind of an ass.",0,3,oMessageCutscene,1)
  else if sceneProgress=20
  {
    with oAttackBase {instance_destroy()}
    instance_create(oPlayer1.x-7,oPlayer1.y-29,oHexor_MashButtons)
    jeremyVelY=-2
    sceneDelay=0; sceneProgress+=1
  }
  
  if sceneProgress=30 //After combo
  {
    sceneDelay+=1
    if sceneDelay>=1
    {
      if jeremyVelY<0 {oPlayer1.sprite_index=sJF_Jump}
      else {oPlayer1.sprite_index=sJF_Fall}
      oPlayer1.x-=3
      oPlayer1.y+=jeremyVelY
      jeremyVelY+=0.33
      if sceneDelay>=5
      {
        if oPlayer1.y>=304
        {
          oPlayer1.y=304
          oPlayer1.sprite_index=sJF_Idle
          sceneDelay=0; sceneProgress+=1
        }
      }
    }
  }
  else if sceneProgress=31
  {
    sceneDelay+=1
    if sceneDelay=15 {oPlayer1.sprite_index=sJF_FinalAttack}
    else if sceneDelay=25
    {
      instance_create(oPlayer1.x-7,oPlayer1.y-29,oJeremyFinalAttack)
    }
  }
  
  if sceneProgress=40 //After finisher
  {
    fadeAlpha+=0.1
    if fadeAlpha>=1
    {
      room_goto(rTrueEnd_A)
    }
  }
}

keyWaitForInput()

if oKeyCodes.kCodePressed[11]=1 and global.gamePaused=true and sceneProgress>=1 //Cutscene skip
{
  if !instance_exists(oPauseMenu)
  {
    if global.gameProgress=5520 and room=rCh21_Main_75 //[1]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      fadeAlpha=0; sceneDelay=0
      sceneProgress=46
    }
    else if global.gameProgress=5530 and room=rAbomA //[2]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      fadeAlpha=0; sceneDelay=0
      sceneProgress=18
    }
    else if global.gameProgress=5550 and room=rAbomF //[3]
    {
      if global.bossTrack=0
      {
        bWaitForInput=false
        with oMessageCutscene {instance_destroy()}
        fadeAlpha=0; sceneDelay=0
        sceneProgress=14
      }
    }
    else if global.gameProgress=5560 and room=rAbomCutA //[4]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      fadeAlpha=1; sceneDelay=0
      sceneProgress=3
    }
    else if global.gameProgress=5570 and room=rCh21_WastelandA //[5]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      fadeAlpha=0; sceneDelay=0
      sceneProgress=47
    }
    else if global.gameProgress=5580 and room=rCh21_WastelandB //[6]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      fadeAlpha=0; sceneDelay=0
      sceneProgress=22
    }
    else if global.gameProgress=5590 and room=rDistortionA //[7]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      fadeAlpha=0; sceneDelay=0
      sceneProgress=4
    }
    else if global.gameProgress=5640 and room=rDistortionF //[8]
    {
      if global.bossTrack=0
      {
        bWaitForInput=false
        with oMessageCutscene {instance_destroy()}
        fadeAlpha=0; sceneDelay=0
        sceneProgress=15
      }
    }
    else if room=rDistFinal_Round2 //[9]
    {
      if sceneProgress>=2
      {
        bWaitForInput=false
        with oMessageCutscene {instance_destroy()}
        fadeAlpha=0; sceneDelay=0
        sceneProgress=26
      }
    }
    else if room=rDistFinal_Round3 //[10]
    {
      if sceneProgress<=5
      {
        bWaitForInput=false
        with oMessageCutscene {instance_destroy()}
        fadeAlpha=0; sceneDelay=0
        sceneProgress=6
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
