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

if global.gameProgress=2560
{
  fadeColor=c_black
  fadeAlpha=1
  oNPC_Syrus.image_xscale=-1
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gameProgress=2560 and room=rCCity_NA_S2 //----- [1] Another talk with Syrus -----
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
      charJerry.sprite_index=sJerryIdle
      charJerry.image_speed=0.1
      charJerry.type=2
      charClaire=instance_create(224,288,oMisc)
      charClaire.sprite_index=sClaireIdle
      charClaire.image_speed=0.1
      charClaire.type=2
    }
    else if sceneDelay>=30
    {
      sceneDelay=0
      sceneProgress+=1
    }
  }
  else if sceneProgress=1 and bWaitForInput=false
    msgCreate(0,0,"","The team informed everyone about what had been found in the Vault.",0,3,oMessageCutscene,1)
  else if sceneProgress=2
  {
    sceneDelay+=1
    if sceneDelay>=20
    {
      fadeAlpha-=0.01
      if fadeAlpha<=0
      {
        sceneDelay=0
        sceneProgress+=1
      }
    }
  }
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Syrus","So it really was Hex in there all along...",6,3,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Yes, I was hoping that I was just wrong.",0,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Syrus","What's up with that guy? Why is he so dangerous?",6,3,oMessageCutscene,1)
  else if sceneProgress=6 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","We don't know what his motives are or what he's striving for. He has the same methods of looking into the program's code like I can, but unlike me, he can come and go from this. If I leave where I am, I won't be able to go back in.",0,3,oMessageCutscene,1)
  else if sceneProgress=7 and bWaitForInput=false
    msgCreate(0,0,"Syrus","He can alter the world through the system itself?",6,3,oMessageCutscene,1)
  else if sceneProgress=8 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Yes, and he's able to be present within the world as well. He's altered the Virus in a way that allows him a lot of freedom within this. It doesn't impede what he's doing at all.",0,3,oMessageCutscene,1)
  else if sceneProgress=9 and bWaitForInput=false
    msgCreate(0,0,"Jerry","So should we go after Hex then?",0,3,oMessageCutscene,1)
  else if sceneProgress=10 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","No, the Virus may be taking longer than we thought to corrupt the world stability, but it is still a high threat. We need those Program Chips. I don't think the Virus will let us do much to Hex while it's active anyway. The Virus is still our top priority.",0,3,oMessageCutscene,1)
  else if sceneProgress=11 and bWaitForInput=false
    msgCreate(0,0,"Syrus","Speaking of that. The bridge to the south side of Central City is fixed. There might be something there to help you in your search.",6,3,oMessageCutscene,1)
  else if sceneProgress=12 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","That's our next destination. Just in case you forgot, the bridge is where the Control Center is, to the east.",0,3,oMessageCutscene,1)
  else if sceneProgress=13 and bWaitForInput=false
    msgCreate(0,0,"Syrus","Oh, one other thing. I saw 'him.'",6,3,oMessageCutscene,1)
  else if sceneProgress=14 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Who?",0,3,oMessageCutscene,1)
  else if sceneProgress=15 and bWaitForInput=false
    msgCreate(0,0,"Syrus","Do you remember the Engineer? The guy that used Fefnir as his look in the world?",6,3,oMessageCutscene,1)
  else if sceneProgress=16 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","You saw him? Where was he?",0,3,oMessageCutscene,1)
  else if sceneProgress=17 and bWaitForInput=false
    msgCreate(0,0,"Syrus","He passed through the city. He's no longer got the same look, but there's no doubt about it. It was definitely him and he certainly had somewhere to be.",6,3,oMessageCutscene,1)
  else if sceneProgress=18 and bWaitForInput=false
    msgCreate(0,0,"Claire","Who are we talking about now?",0,3,oMessageCutscene,1)
  else if sceneProgress=19 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","The program's lead engineer is still here. He helped us back when the program was still targeting us as hostile.",0,3,oMessageCutscene,1)
  else if sceneProgress=20 and bWaitForInput=false
    msgCreate(0,0,"Claire","So he's on our side?",0,3,oMessageCutscene,1)
  else if sceneProgress=21 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","I hope so.",0,3,oMessageCutscene,1)
  else if sceneProgress=22 and bWaitForInput=false
    msgCreate(0,0,"Syrus","In any case, good luck.",6,3,oMessageCutscene,1)
  else if sceneProgress=23
  {
    var tFlash;
    tFlash=instance_create(0,0,oScreenFlash)
    tFlash.fadeSpeed=0.2
    var tNewChapter;
    tNewChapter=instance_create(0,0,oChapterDisplay)
    tNewChapter.newChapter="Chapter 11#Intermission"
    oPlayer1.visible=1
    if global.activeCharacter=0 oPlayer1.x=charJerry.x
    else if global.activeCharacter=1 oPlayer1.x=charClaire.x
    with oMisc {instance_destroy()}
    sceneDelay=0
    sceneProgress=0
    global.gameProgress=2570
    global.gamePaused=false
  }
}
else if global.gameProgress=2570 and room=rCCity_SouthA //----- [2] Wow it's loud here -----
{
  if sceneProgress=0
  {
    sceneDelay+=1
    if sceneDelay=1 {global.gamePaused=true}
    else if sceneDelay>=30 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=1 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Wow it's loud here.",0,3,oMessageCutscene,1)
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"Chao","It's a busy place. The city folk sometimes talk about things they've seen, but I don't know how much of it could be important.",0,3,oMessageCutscene,1)
  else if sceneProgress=3
  {
    sceneDelay=0
    sceneProgress=0
    global.gameProgress=2571
    global.gamePaused=false
  }
}
else if global.gameProgress=2581 and room=rCCity_SA_S1 //----- [3] Talk with Important Guy -----
{
  if sceneProgress=0
  {
    global.gamePaused=true
    fadeColor=c_black
    if fadeAlpha<1
      fadeAlpha+=0.05
    else if fadeAlpha>=1
      sceneProgress+=1
  }
  else if sceneProgress=1
  {
    sceneDelay+=1
    if sceneDelay>=25
    {
      (260306).image_xscale=-1
      charSwitcher(0)
      scenePChk(336,304,0,0.1,1)
      sceneDelay=0
      sceneProgress+=1
    }
  }
  else if sceneProgress=2
  {
    if fadeAlpha>0
      fadeAlpha-=0.05
    else if fadeAlpha<=0
      sceneProgress+=1
  }
  else if sceneProgress=3
  {
    sceneDelay+=1
    if sceneDelay>=25
    {
      sceneDelay=0
      sceneProgress+=1
    }
  }
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Important Guy","You must be Jerry and Claire. Gene told me all about you two.",6,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Did he now? A bit disappointing that you didn't use the 'I've been expecting you' line, with an awesome deep voice.",0,3,oMessageCutscene,1)
  else if sceneProgress=6 and bWaitForInput=false
    msgCreate(0,0,"Claire","Just ignore him. He mentioned us for a reason, right?",0,3,oMessageCutscene,1)
  else if sceneProgress=7 and bWaitForInput=false
    msgCreate(0,0,"Important Guy","Yes, he has already briefed me on the situation. He came to me due to my knowledge of the southern parts of the Mainland. You want to know about them?",6,3,oMessageCutscene,1)
  else if sceneProgress=8 and bWaitForInput=false
    msgCreate(0,0,"Claire","Anything you know would be super helpful.",0,3,oMessageCutscene,1)
  else if sceneProgress=9 and bWaitForInput=false
    msgCreate(0,0,"Important Guy","Just south of here is a grand desert. Within it, lies a Gate that you've been seeking.",6,3,oMessageCutscene,1)
  else if sceneProgress=10 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Awesome, just tell us the way!",0,3,oMessageCutscene,1)
  else if sceneProgress=11 and bWaitForInput=false
    msgCreate(0,0,"Important Guy","It's not as simple as that. Even if you know the way, getting there is quite the task. That area utilizes heat.",6,3,oMessageCutscene,1)
  else if sceneProgress=12 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","That's to be expected. Is there a counter to it, maybe a way to turn it off?",0,3,oMessageCutscene,1)
  else if sceneProgress=13 and bWaitForInput=false
    msgCreate(0,0,"Important Guy","It can't be turned off, but if you can find water, you can counteract the heat parameters.",6,3,oMessageCutscene,1)
  else if sceneProgress=14 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Well that's straightforward. Do you know the way through the desert?",0,3,oMessageCutscene,1)
  else if sceneProgress=15 and bWaitForInput=false
    msgCreate(0,0,"Important Guy","Yes and no. I know of a clue that I found in the desert. At the Twin Rocks, it reads; 'The Konami Code is the path to victory'.",6,3,oMessageCutscene,1)
  else if sceneProgress=16 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Can it get any easier?",0,3,oMessageCutscene,1)
  else if sceneProgress=17 and bWaitForInput=false
    msgCreate(0,0,"Jerry","I know, right? So find water and look out for these twin rock thingymabobs. We got this.",0,3,oMessageCutscene,1)
  else if sceneProgress=18 and bWaitForInput=false
    msgCreate(0,0,"Important Guy","Good luck out there. Watch out for the Sand Crawler and that CHAOS group. I've heard they're close by that area.",6,3,oMessageCutscene,1)
  else if sceneProgress=19 and bWaitForInput=false
    msgCreate(0,0,"Jerry","That name again... Jeremy, did you ever figure out anything about them?",0,3,oMessageCutscene,1)
  else if sceneProgress=20 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","With all that's been going on, not really. So far, all I know is they're a group of bots led by... someone? Can't seem to find any info there.",0,3,oMessageCutscene,1)
  else if sceneProgress=21 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Fair enough. TO THE DESERT!",0,3,oMessageCutscene,1)
  else if sceneProgress=22
  {
    sceneDelay=0
    sceneProgress=0
    global.gameProgress=2590
    global.gamePaused=false
  }
}

keyWaitForInput()

if oKeyCodes.kCodePressed[11]=1 and global.gamePaused=true //Cutscene skip
{
  if !instance_exists(oPauseMenu)
  {
    if global.gameProgress=2560 and room=rCCity_NA_S2 //[1]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      fadeAlpha=0; sceneDelay=0
      sceneProgress=23
    }
    else if global.gameProgress=2570 and room=rCCity_SouthA//[2]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      fadeAlpha=0; sceneDelay=0
      sceneProgress=3
    }
    else if global.gameProgress=2581 and room=rCCity_SA_S1 //[3]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      fadeAlpha=0; sceneDelay=0
      sceneProgress=22
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
