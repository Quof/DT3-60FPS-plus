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

if global.gameProgress=3870 and room=rCCity_NA_S2
{
  fadeColor=c_black
  fadeAlpha=1
}
else if global.gameProgress=3920 and room=rCCity_NA_S1
{
  fadeColor=c_black
  fadeAlpha=1
  efDustY=384
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gameProgress=3870 and room=rCCity_NA_S2 //----- [1] On the defensive -----
{
  if sceneProgress=0
  {
    sceneDelay+=1
    if sceneDelay=1
    {
      global.gamePaused=true
      scenePChk(240,288,0,0.1,1)
      oPlayer1.visible=0
      charJerry=instance_create(256,288,oMisc)
      charJerry.sprite_index=sJerryIdle; charJerry.image_speed=0.1; charJerry.type=2
      charClaire=instance_create(224,288,oMisc)
      charClaire.sprite_index=sClaireIdle; charClaire.image_speed=0.1; charClaire.type=2
      oNPC_Syrus.image_xscale=-1
    }
    else if sceneDelay>=20 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=1 and bWaitForInput=false
    msgCreate(0,0,"","The group gave a recap to Syrus and Gene on everything up to this point. Also John was there to help explain.",6,3,oMessageCutscene,1)
  else if sceneProgress=2
  {
    sceneDelay+=1
    if sceneDelay>=30
    {
      fadeAlpha-=0.01
      if fadeAlpha<=0 {sceneDelay=0; sceneProgress+=1}
    }
  }
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","And that's it. We now have all the Program Chips to remove the Virus. I know how to use them, but I don't know exactly where. I do know it's here in this city.",0,3,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Syrus","I think I can help with that.",6,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","That would be great.",0,3,oMessageCutscene,1)
  else if sceneProgress=6 and bWaitForInput=false
    msgCreate(0,0,"Syrus","I've been in this city for some time, and inspected every nook and cranny. There's one place though, that I've been trying to figure out the purpose of. In the house next to this is a stairway down into a facility.",6,3,oMessageCutscene,1)
  else if sceneProgress=7 and bWaitForInput=false
    msgCreate(0,0,"Syrus","There's a computer system down there that's well guarded.",6,3,oMessageCutscene,1)
  else if sceneProgress=8 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","You think that's where these things would go?",0,3,oMessageCutscene,1)
  else if sceneProgress=9 and bWaitForInput=false
    msgCreate(0,0,"Syrus","It has to be. Luckily for us, those defenses are on our side. They'll only target virus infected bots.",6,3,oMessageCutscene,1)
  else if sceneProgress=10 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","I thought there was something strange about that building.",0,3,oMessageCutscene,1)
  else if sceneProgress=11 and bWaitForInput=false
    msgCreate(0,0,"John","Before we go down there and stop this whole thing... What did you guys think of that Gate's content?",6,3,oMessageCutscene,1)
  else if sceneProgress=12 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","It was pretty bad. Some things didn't even work properly.",0,3,oMessageCutscene,1)
  else if sceneProgress=13 and bWaitForInput=false
    msgCreate(0,0,"John","It was unfinished!",6,3,oMessageCutscene,1)
  else if sceneProgress=14 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","It was still bad, I've made better things from my home PC.",0,3,oMessageCutscene,1)
  else if sceneProgress=15
  {
    sceneDelay+=1
    if sceneDelay=10
    {
      npcMatt=instance_create(-32,320,oMisc)
      npcMatt.sprite_index=sNPC_Matt_Dash; npcMatt.type=1
    }
    else if sceneDelay>=11 and sceneDelay<=99
    {
      npcMatt.x+=4
      if npcMatt.x>=48
      {
        npcMatt.sprite_index=sNPC_Matt_Idle
        sceneDelay=100
      }
    }
    else if sceneDelay>=115
    {
      charJerry.image_xscale=-1
      charClaire.image_xscale=-1
      oNPC_John.image_xscale=-1
      sceneDelay=0; sceneProgress+=1
    }
  }
  else if sceneProgress=16 and bWaitForInput=false
    msgCreate(0,0,"Matt","You guys, they've started the invasion!",6,3,oMessageCutscene,1)
  else if sceneProgress=17 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","What invasion?",0,3,oMessageCutscene,1)
  else if sceneProgress=18 and bWaitForInput=false
    msgCreate(0,0,"Syrus","CHAOS has been acting up a lot lately. We recently saw that they had an army ready to assault the city. While virus infected bots can't get in, CHAOS still can. The defenses we have set up right now aren't enough.",6,3,oMessageCutscene,1)
  else if sceneProgress=19 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","You sound like you've got a plan though.",0,3,oMessageCutscene,1)
  else if sceneProgress=20 and bWaitForInput=false
    msgCreate(0,0,"Syrus","More like John over there has a plan.",6,3,oMessageCutscene,1)
  else if sceneProgress=21 and bWaitForInput=false
  {
    oNPC_John.image_xscale=1
    msgCreate(0,0,"John","When I was down in that CHAOS facility, I had noticed their growing army. So while you guys were in that Gate, I began finishing something I had started that should be able to help repel that invasion.",6,3,oMessageCutscene,1)
  }
  else if sceneProgress=22 and bWaitForInput=false
    msgCreate(0,0,"John","I'm going to grant you the ability to summon defensive structures outside the city walls and its surrounding area. You can swap to it the normal way you swap abilities.",6,3,oMessageCutscene,1)
  else if sceneProgress=23 and bWaitForInput=false
    msgCreate(0,0,"John","There are multiple structures you can use. [Action A] will... hold up, why don't we go out to the field where explaining it will make more sense. Talk to me outside this building when you're ready for this.",6,3,oMessageCutscene,1)
  else if sceneProgress=24
  {
    sceneDelay+=1
    if sceneDelay=5
    {
      npcMatt.sprite_index=sNPC_Matt_Dash; npcMatt.image_xscale=-1
    }
    else if sceneDelay>=6 and sceneDelay<=22 {npcMatt.x-=4}
    else if sceneDelay=25
    {
      tEffect=instance_create(oNPC_John.x,oNPC_John.y-18,oEffect)
      tEffect.sprite_index=sDustCloud; tEffect.followID=-1; tEffect.xFollow=0; tEffect.yFollow=0
      tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
      with oNPC_John {instance_destroy()}
    }
    else if sceneDelay>=30
    {
      charJerry.image_xscale=1
      charClaire.image_xscale=1
      sceneDelay=0; sceneProgress+=1
    }
  }
  else if sceneProgress=25 and bWaitForInput=false
    msgCreate(0,0,"Syrus","We'll get to the Program Chips in a moment.",6,3,oMessageCutscene,1)
  else if sceneProgress=26
  {
    var tFlash;
    tFlash=instance_create(0,0,oScreenFlash)
    tFlash.fadeSpeed=0.2
    var tNewChapter;
    tNewChapter=instance_create(0,0,oChapterDisplay)
    tNewChapter.newChapter="Chapter 16#On the Defensive"
    oPlayer1.visible=1
    if global.activeCharacter=0 {oPlayer1.x=charJerry.x}
    else if global.activeCharacter=1 {oPlayer1.x=charClaire.x}
    oPlayer1.y=288
    with oMisc {instance_destroy()}
    with oNPC_John {instance_destroy()}
    sceneDelay=0
    sceneProgress=0
    global.gameProgress=3880
    global.gamePaused=false
  }
}
else if global.gameProgress=3880 and room=rCCity_NorthA //----- [2] Talk to John (Go to TD1) -----
{
  if sceneProgress=0
  {
    if oNPC_John.bTalkedTo=1 {global.gamePaused=true; sceneProgress+=1}
  }
  else if sceneProgress=1
  {
    oPlayer1.y+=4
    if oPlayer1.y>=288
    {
      scenePChk(1200,288,0,0.1,1)
      oNPC_John.image_xscale=-1
      stopPlayer()
      sceneProgress+=1
    }
  }
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"John","CHAOS is sending in quite a few of its weapons through portals to get into the city. I bet they're going after the city's protections so virus-infected bots can get in as well.",6,3,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","How can we help?",0,3,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"John","I had developed a set of abilities that will allow you to deploy defensive structures, such as turrets, to fend off the invasion.",6,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Claire","Chao, this is all you! You loved these games!",0,3,oMessageCutscene,1)
  else if sceneProgress=6 and bWaitForInput=false
    msgCreate(0,0,"John","Unfortunately I can't set her with the ability due to her 'unique' circumstances, but I can give both you and Jerry a copy of it. You'll still be able to use your other abilities, but I'm sure CHAOS has set up some sort of defense against that.",6,3,oMessageCutscene,1)
  else if sceneProgress=7 and bWaitForInput=false
    msgCreate(0,0,"Claire","Eh?",0,3,oMessageCutscene,1)
  else if sceneProgress=8 and bWaitForInput=false
    msgCreate(0,0,"John","To be more precise, they've probably got a 50% damage resist against all of your attacks, regardless of resist types.",6,3,oMessageCutscene,1)
  else if sceneProgress=9 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","That's pretty specific. How do you know so much about CHAOS?",0,3,oMessageCutscene,1)
  else if sceneProgress=10 and bWaitForInput=false
    msgCreate(0,0,"John","I lead the engineering team and oversaw most of this program's development. I'm curious to know about all the big developments within it.",6,3,oMessageCutscene,1)
  else if sceneProgress=11 and bWaitForInput=false
    msgCreate(0,0,"John","CHAOS isn't something I would have ever thought possible in this. Not as sophisticated as they are anyway, I find them fascinating.",6,3,oMessageCutscene,1)
  else if sceneProgress=12 and bWaitForInput=false
    msgCreate(0,0,"John","Anyway, how about we go out to the field to meet them head on. You'll understand once you've used this ability. I have some instructions for you, which you may skip, but I recommend at least looking at the Controls and Base Info.",6,3,oMessageCutscene,1)
  else if sceneProgress=13
  {
    sceneDelay+=1
    if sceneDelay>=10
    {
      global.newMapX=192
      global.newMapY=560
      writeToPlayerGlobals()
      global.bTowerDefense=1
      room_goto(rTD_Lv1)
    }
  }
}
else if global.gameProgress=3890 and room=rTD_Lv1 //----- [] Completed all enemy waves (First) -----
{
  if global.gameOver=false
  {
    if sceneProgress=0
    {
      sceneDelay+=1
      if sceneDelay=1 {global.gamePaused=true}
      else if sceneDelay>=20 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=1 and bWaitForInput=false
      msgCreate(0,0,"John","Awesome, you fought them all off! Let's go back to the city.",6,3,oMessageCutscene,1)
    else if sceneProgress=2
    {
      sceneDelay+=1
      if sceneDelay>=20
      {
        global.activeAbility[0]=1
        global.activeAbility[1]=1
        global.newMapX=1200
        global.newMapY=288
        writeToPlayerGlobals()
        room_goto(rCCity_NorthA)
      }
    }
  }
}
else if global.gameProgress=3890 and room=rCCity_NorthA //----- [3] Another enemy wave incoming -----
{
  if sceneProgress=0
  {
    sceneDelay+=1
    if sceneDelay=1 {oPlayer1.image_xscale=1; oNPC_John.image_xscale=-1}
    else if sceneDelay>=20 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=1 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","CHAOS has a lot of tanks.",0,3,oMessageCutscene,1)
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"John","Well they have more incoming, but from a different direction this time.",6,3,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Seriously? Alrighty, we're up to it again.",0,3,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"John","I have a feeling they're going to put more into it this time. I'll see about getting more resources from the city to give you a bigger starting pool this time.",6,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Jerry","So that's where our starting resources come from then.",0,3,oMessageCutscene,1)
  else if sceneProgress=6 and bWaitForInput=false
    msgCreate(0,0,"John","Yep. When you're ready to counter the next offense, just talk to me again.",6,3,oMessageCutscene,1)
  else if sceneProgress=7
  {
    sceneDelay=0
    sceneProgress=0
    global.gameProgress=3900
    global.gamePaused=false
  }
}
else if global.gameProgress=3900 and room=rCCity_NorthA //----- [4] Talk to John (Go to TD2) -----
{
  if sceneProgress=0
  {
    if oNPC_John.bTalkedTo=1 {global.gamePaused=true; sceneProgress+=1}
  }
  else if sceneProgress=1
  {
    oPlayer1.y+=4
    if oPlayer1.y>=288
    {
      scenePChk(1200,288,0,0.1,1)
      oNPC_John.image_xscale=-1
      stopPlayer()
      sceneProgress+=1
    }
  }
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"John","I'm really hoping the Warmaster isn't with the offensive.",6,3,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Who is that? I've been hearing about him, but I don't know much.",0,3,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"John","The bot that leads CHAOS. I've seen this guy, you don't want to mess with him. Even for you two, he'd be overwhelming.",6,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Did you make him?",0,3,oMessageCutscene,1)
  else if sceneProgress=6 and bWaitForInput=false
    msgCreate(0,0,"John","None of us on the project made him. A few bots were simply made by the program, but it still used existing data.",6,3,oMessageCutscene,1)
  else if sceneProgress=7 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","What makes the Warmaster so bad?",0,3,oMessageCutscene,1)
  else if sceneProgress=8 and bWaitForInput=false
    msgCreate(0,0,"John","To be honest, no one really knows much about him. Whats been gathered though, is he's never been beaten. It wasn't recorded when and how CHAOS was formed, but it is known that the Warmaster was the one that started and leads them.",6,3,oMessageCutscene,1)
  else if sceneProgress=9 and bWaitForInput=false
    msgCreate(0,0,"John","CHAOS is simply a group of bots under him that follow exactly as he says. I don't know what his agendas are, but he hates humans. To make things worse, he's apparently working with that Hex bot.",6,3,oMessageCutscene,1)
  else if sceneProgress=10 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Well, once the program comes back on, it can remove all the existing hostile bots.",0,3,oMessageCutscene,1)
  else if sceneProgress=11 and bWaitForInput=false
    msgCreate(0,0,"John","Yes, the Warmaster avoided the Vault before by staying neutral in his actions, he won't be so lucky this time. He attacks bots that side with humans as well.",6,3,oMessageCutscene,1)
  else if sceneProgress=12 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Huh... anyway let's do this!",0,3,oMessageCutscene,1)
  else if sceneProgress=13
  {
    sceneDelay+=1
    if sceneDelay>=10
    {
      global.newMapX=240
      global.newMapY=576
      writeToPlayerGlobals()
      global.bTowerDefense=2
      room_goto(rTD_Lv2)
    }
  }
}
else if global.gameProgress=3910 and room=rTD_Lv2 //----- [] Completed all enemy waves (Second) -----
{
  if global.gameOver=false
  {
    if sceneProgress=0
    {
      sceneDelay+=1
      if sceneDelay=1 {global.gamePaused=true}
      else if sceneDelay>=20 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=1 and bWaitForInput=false
      msgCreate(0,0,"John","They tried and failed! Looks like they have all backed off now. Let's return to the city.",6,3,oMessageCutscene,1)
    else if sceneProgress=2
    {
      sceneDelay+=1
      if sceneDelay>=20
      {
        global.activeAbility[0]=1
        global.activeAbility[1]=1
        global.newMapX=1200
        global.newMapY=288
        writeToPlayerGlobals()
        room_goto(rCCity_NorthA)
      }
    }
  }
}
else if global.gameProgress=3910 and room=rCCity_NorthA //----- [5] CHAOS backed off -----
{
  if sceneProgress=0
  {
    sceneDelay+=1
    if sceneDelay=1 {oPlayer1.image_xscale=1; oNPC_John.image_xscale=-1}
    else if sceneDelay>=20 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=1 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","That was interesting and pretty awesome looking.",0,3,oMessageCutscene,1)
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"John","Yep, and it looks like they won't be trying that again any time soon.",6,3,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Good. Now we can get a move on to this facility beneath the city.",0,3,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"John","Syrus and Gene went into the house to the left here while you were defending the city. I'll be in after you.",6,3,oMessageCutscene,1)
  else if sceneProgress=5
  {
    sceneDelay=0
    sceneProgress=0
    global.gameProgress=3920
    global.gamePaused=false
  }
}
if global.gameProgress=3920 and room=rCCity_NA_S1 //----- [6] The facility below -----
{
  if sceneProgress=0
  {
    sceneDelay+=1
    if sceneDelay=1
    {
      global.gamePaused=true
      scenePChk(240,288,0,0.1,1)
      oPlayer1.x=112; oPlayer1.y=384
      oPlayer1.visible=0
      charJerry=instance_create(112,384,oMisc)
      charJerry.sprite_index=sJerryIdle
      charJerry.image_speed=0.1
      charJerry.type=2
      charClaire=instance_create(48,352,oMisc)
      charClaire.sprite_index=sClaireIdle
      charClaire.image_speed=0.1
      charClaire.type=2
      oNPC_Gene.image_xscale=-1
    }
    else if sceneDelay>=20 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=1
  {
    sceneDelay+=1
    if sceneDelay>=30
    {
      fadeAlpha-=0.01
      if fadeAlpha<=0 {sceneDelay=0; sceneProgress+=1}
    }
  }
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"Syrus","That facility is right beneath us. Check this out.",6,3,oMessageCutscene,1)
  else if sceneProgress=3
  {
    sceneDelay+=1
    if sceneDelay>=30
    {
      tile_layer_shift(999999,0,1)
      var tEffect;
      tEffect=instance_create(208+random(176),efDustY,oEffect)
      tEffect.sprite_index=sMMSmokeCloud; tEffect.image_speed=0.5; tEffect.ySpd=-1-random(1)
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0
      efDustY+=1
      if efDustY>=560
      {
        tile_layer_delete(999999)
        sceneDelay=0; sceneProgress+=1
      }
    }
  }
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Jerry","That's something.",0,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","You've been a huge help, Syrus. Really, all of you guys have been.",0,3,oMessageCutscene,1)
  else if sceneProgress=6 and bWaitForInput=false
    msgCreate(0,0,"Gene","We want to keep this thing running just as much as you.",6,3,oMessageCutscene,1)
  else if sceneProgress=7 and bWaitForInput=false
    msgCreate(0,0,"Syrus","While you're down there, we'll keep an eye out for CHAOS.",6,3,oMessageCutscene,1)
  else if sceneProgress=8 and bWaitForInput=false
    msgCreate(0,0,"John","They probably won't attack again. Hex has no idea what we're doing. I know he can spy on us somehow, but he can't see into the city.",6,3,oMessageCutscene,1)
  else if sceneProgress=9 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Don't trust that assumption. We'll try to be as quick as we can. If all goes right, Hex and CHAOS will no longer be a problem by the time we come back up.",0,3,oMessageCutscene,1)
  else if sceneProgress=10 and bWaitForInput=false
    msgCreate(0,0,"Syrus","Good luck you guys. I know the computer system down there is on our side, but you know as well as I do, that things don't always go smoothly.",6,3,oMessageCutscene,1)
  else if sceneProgress=11 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","We'll be careful.",0,3,oMessageCutscene,1)
  else if sceneProgress=12
  {
    var tFlash;
    tFlash=instance_create(0,0,oScreenFlash)
    tFlash.fadeSpeed=0.2
    oPlayer1.visible=1
    if global.activeCharacter=0 {oPlayer1.x=charJerry.x; oPlayer1.y=charJerry.y}
    else if global.activeCharacter=1 {oPlayer1.x=charClaire.x; oPlayer1.y=charClaire.y}
    tile_layer_delete(999999)
    with (134496) {instance_destroy()}
    with oMisc {instance_destroy()}
    sceneDelay=0
    sceneProgress=0
    global.gameProgress=3930
    global.gamePaused=false
  }
}

keyWaitForInput()

if oKeyCodes.kCodePressed[11]=1 and global.gamePaused=true and sceneProgress>=1 //Cutscene skip
{
  if !instance_exists(oPauseMenu)
  {
    if global.gameProgress=3870 and room=rCCity_NA_S2 //[1]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      fadeAlpha=0; sceneDelay=0
      sceneProgress=26
    }
    else if global.gameProgress=3880 and room=rCCity_NorthA //[2]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      fadeAlpha=0; sceneDelay=0
      sceneProgress=13
    }
    else if global.gameProgress=3890 and room=rCCity_NorthA //[3]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      fadeAlpha=0; sceneDelay=0
      sceneProgress=7
    }
    else if global.gameProgress=3900 and room=rCCity_NorthA //[4]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      fadeAlpha=0; sceneDelay=0
      sceneProgress=13
    }
    else if global.gameProgress=3910 and room=rCCity_NorthA //[5]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      fadeAlpha=0; sceneDelay=0
      sceneProgress=5
    }
    else if global.gameProgress=3920 and room=rCCity_NA_S1 //[6]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      fadeAlpha=0; sceneDelay=0
      sceneProgress=12
    }
  }
}

//----- Room specific events -----
if global.gamePaused=false
{

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
