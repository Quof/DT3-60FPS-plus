#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
enemyCount=-1
fadeColor=c_black
fadeAlpha=1
npcJohn=instance_create(368,272,oMisc)
npcJohn.type=0; npcJohn.sprite_index=sNPC_John_Idle; npcJohn.image_speed=0.2
npcJohn=instance_create(256,256,oMisc)
npcJohn.type=0; npcJohn.sprite_index=sNPC_Syrus_Idle
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if room=rEnd_SceneB //----- [] Epilogue -----
{
  if sceneProgress=0
  {
    sceneDelay+=1
    if sceneDelay=30 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=1 and bWaitForInput=false
    msgCreate(0,0,"","One month later...",6,3,oMessageCutscene,1)
  else if sceneProgress=2
  {
    sceneDelay+=1
    if sceneDelay>=30
    {
      fadeAlpha-=0.02
      if fadeAlpha<=0 {sceneDelay=0; sceneProgress+=1}
    }
  }
  else if sceneProgress=3
  {
    sceneDelay+=1
    if sceneDelay>=30 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Syrus","I figured I'd find you out here again.",6,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"John","No one comes out here. It gives me a place to think.",6,3,oMessageCutscene,1)
  else if sceneProgress=6 and bWaitForInput=false
    msgCreate(0,0,"Syrus","I won't bother you long.",6,3,oMessageCutscene,1)
  else if sceneProgress=7 and bWaitForInput=false
    msgCreate(0,0,"John","Eh, what did you want?",6,3,oMessageCutscene,1)
  else if sceneProgress=8 and bWaitForInput=false
    msgCreate(0,0,"Syrus","What are you thinking about?",6,3,oMessageCutscene,1)
  else if sceneProgress=9 and bWaitForInput=false
    msgCreate(0,0,"John","About what I should be doing now. I worked on this program for someone and they couldn't be here.",6,3,oMessageCutscene,1)
  else if sceneProgress=10 and bWaitForInput=false
    msgCreate(0,0,"Syrus","You never told us much about that.",6,3,oMessageCutscene,1)
  else if sceneProgress=11 and bWaitForInput=false
    msgCreate(0,0,"John","And I won't. I just don't know what I should be doing in this place anymore. Things settled after those four brought down that ship.",6,3,oMessageCutscene,1)
  else if sceneProgress=12 and bWaitForInput=false
    msgCreate(0,0,"Syrus","There's still plenty of malicious bots out there. You could be helping us with that.",6,3,oMessageCutscene,1)
  else if sceneProgress=13 and bWaitForInput=false
    msgCreate(0,0,"John","They'll be found eventually. I just don't care to intervene anymore.",6,3,oMessageCutscene,1)
  else if sceneProgress=14 and bWaitForInput=false
    msgCreate(0,0,"Syrus","Why did you step in with CHAOS?",6,3,oMessageCutscene,1)
  else if sceneProgress=15 and bWaitForInput=false
    msgCreate(0,0,"John","The Warmaster, him along with that Hex bot. They were both fascinating. Bubblun and Lovelun were the only bots we set to think and interpret. The Warmaster and Hex, and even bots they influenced were capable of the same thing.",6,3,oMessageCutscene,1)
  else if sceneProgress=16 and bWaitForInput=false
    msgCreate(0,0,"John","We messed up when making this program. It got out of control and the results were bots like those two.",6,3,oMessageCutscene,1)
  else if sceneProgress=17 and bWaitForInput=false
    msgCreate(0,0,"Syrus","That sounds more like success to me, even if that wasn't intentional.",6,3,oMessageCutscene,1)
  else if sceneProgress=18 and bWaitForInput=false
    msgCreate(0,0,"John","It's the self-awareness of those bots and what they did with that knowledge that keeps me thinking this was all a mistake.",6,3,oMessageCutscene,1)
  else if sceneProgress=19 and bWaitForInput=false
    msgCreate(0,0,"John","The Warmaster was fascinating though. He wasn't the malicious bot I kept thinking he was.",6,3,oMessageCutscene,1)
  else if sceneProgress=20 and bWaitForInput=false
    msgCreate(0,0,"Syrus","What about Hex?",6,3,oMessageCutscene,1)
  else if sceneProgress=21 and bWaitForInput=false
    msgCreate(0,0,"John","He surprised me. He was only created by the program to counter Jeremy's hacking since it couldn't do much about that.",6,3,oMessageCutscene,1)
  else if sceneProgress=22 and bWaitForInput=false
    msgCreate(0,0,"Syrus","To a scary extent.",6,3,oMessageCutscene,1)
  else if sceneProgress=23 and bWaitForInput=false
    msgCreate(0,0,"John","Yes. I don't know how, but he gained full awareness of what he was and what he was designed for. None of the bots were supposed to be able to interpret their commands in such a way.",6,3,oMessageCutscene,1)
  else if sceneProgress=24 and bWaitForInput=false
    msgCreate(0,0,"John","That and what it was able to do by seeing into the code like Jeremy could, made him dangerous. Especially to Jeremy.",6,3,oMessageCutscene,1)
  else if sceneProgress=25 and bWaitForInput=false
    msgCreate(0,0,"John","Everything Hex did was to make Jeremy miserable.",6,3,oMessageCutscene,1)
  else if sceneProgress=26 and bWaitForInput=false
    msgCreate(0,0,"Syrus","...",6,3,oMessageCutscene,1)
  else if sceneProgress=27 and bWaitForInput=false
    msgCreate(0,0,"Syrus","What are you going to do now?",6,3,oMessageCutscene,1)
  else if sceneProgress=28 and bWaitForInput=false
    msgCreate(0,0,"John","I don't know just yet. Disappear for awhile and explore. I don't have much holding me here.",6,3,oMessageCutscene,1)
  else if sceneProgress=29 and bWaitForInput=false
    msgCreate(0,0,"Syrus","So, before you go, did you talk to Chao at all? She just up and left soon after it all happened. Where did she go?",6,3,oMessageCutscene,1)

  if global.gamePttT_Prog<90 //If Parasitic Seed is not defeated
  {
    if sceneProgress=30 and bWaitForInput=false
      msgCreate(0,0,"John","She didn't say, only that she found out something about the Abomination and needed to investigate it.",6,3,oMessageCutscene,1)
    else if sceneProgress=31 and bWaitForInput=false
      msgCreate(0,0,"Syrus","Hold on, hold on! I thought they destroyed that thing?",6,3,oMessageCutscene,1)
    else if sceneProgress=32 and bWaitForInput=false
      msgCreate(0,0,"John","They thought they did, but apparently there must've been something left behind. Something really powerful, by the sound of it.",6,3,oMessageCutscene,1)
    else if sceneProgress=33 and bWaitForInput=false
      msgCreate(0,0,"John","All I really know is that it went far to the south-east, beyond where we've scouted out and into some unknown part of the land.",6,3,oMessageCutscene,1)
    else if sceneProgress=34 and bWaitForInput=false
      msgCreate(0,0,"Syrus","Do you think she'll be okay out there?",6,3,oMessageCutscene,1)
    else if sceneProgress=35 and bWaitForInput=false
      msgCreate(0,0,"John","Of course she will. You should know her by now.",6,3,oMessageCutscene,1)
    else if sceneProgress=36 and bWaitForInput=false
      msgCreate(0,0,"Syrus","True, but... all by herself?",6,3,oMessageCutscene,1)
    else if sceneProgress=37 and bWaitForInput=false
      msgCreate(0,0,"John","Maybe she thinks she'll find the others there, through some miracle. Maybe she regrets not finishing off something that dangerous before everything went downhill.",6,3,oMessageCutscene,1)
    else if sceneProgress=38 and bWaitForInput=false
      msgCreate(0,0,"John","Maybe she just wants to know if whatever power it had could've saved her friends.",6,3,oMessageCutscene,1)
    else if sceneProgress=39 and bWaitForInput=false
      msgCreate(0,0,"Syrus","And you John? What do you think?",6,3,oMessageCutscene,1)
    else if sceneProgress=40 and bWaitForInput=false
      msgCreate(0,0,"John","I think that it's too late for it to make a difference now. If they took it out before bringing down the Warship, then maybe they could've had a chance. But now?",6,3,oMessageCutscene,1)
    else if sceneProgress=41 and bWaitForInput=false
      msgCreate(0,0,"John","Those three made their decision in order to save us all. We're the ones who have to live with it, and there's simply nothing that we can do about it.",6,3,oMessageCutscene,1)
    else if sceneProgress=42 and bWaitForInput=false
      msgCreate(0,0,"John","But still... It would have been nice. A future where all of them are still alive.",6,3,oMessageCutscene,1)
  }
  else //If Parasitic Seed is defeated
  {
    if sceneProgress=30 and bWaitForInput=false
      msgCreate(0,0,"John","She didn't say much of anything about that. Just that she wanted to find new lands.",6,3,oMessageCutscene,1)
    else if sceneProgress=31 and bWaitForInput=false
      msgCreate(0,0,"Syrus","New lands?",6,3,oMessageCutscene,1)
    else if sceneProgress=32 and bWaitForInput=false
      msgCreate(0,0,"John","The world is large. I'm sure there are places that aren't used by either bots or humans. Most of it was generated by the program, even I'm unsure of what places it created.",6,3,oMessageCutscene,1)
    else if sceneProgress=33 and bWaitForInput=false
      msgCreate(0,0,"Syrus","Is she going to be okay?",6,3,oMessageCutscene,1)
    else if sceneProgress=34 and bWaitForInput=false
      msgCreate(0,0,"John","We're in a video game simulation and she's one hell of a gamer from what her brother had said. She's going to be perfectly okay.",6,3,oMessageCutscene,1)
    else if sceneProgress=35 {sceneProgress=43}
  }

  if sceneProgress=43
  {
    sceneDelay+=1
    if sceneDelay>=30
    {
      fadeAlpha+=0.02
      if fadeAlpha>=1
      {
        if global.gamePttT_Prog<90 {sceneDelay=0; sceneProgress+=1}
        else {sceneDelay=0; sceneProgress=45}
      }
    }
  }
  else if sceneProgress=44 and bWaitForInput=false
    msgCreate(0,0,"John","I only wish that was how things actually played out.",6,3,oMessageCutscene,1)
  else if sceneProgress=45
  {
    sceneDelay+=1
    if sceneDelay=30 {instance_create(0,0,oTextTheEnd)}
    else if sceneDelay=210 //Save that game was completed
    {
      global.gameCompleted=1
      ini_open(global.paraString[0])
      sectionWrite="ALPHA"
      ini_write_real(sectionWrite,"144",global.gameCompleted)
      ini_close()
    }
    else if sceneDelay>=215 //Go to title screen
    {
      room_goto(rTitle)
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
