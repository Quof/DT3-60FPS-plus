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

if global.gameProgress=570
{
  fadeColor=c_black
  fadeAlpha=1

  oPlayer1.x=248; oPlayer1.y=288; oPlayer1.visible=0
  charJerry=instance_create(272,288,oMisc)
  charJerry.sprite_index=sJerryIdle
  charJerry.image_speed=0.1
  charJerry.type=2
  charClaire=instance_create(224,288,oMisc)
  charClaire.sprite_index=sClaireIdle
  charClaire.image_speed=0.1
  charClaire.type=2

  oNPC_Syrus.image_xscale=-1
  oNPC_Gene.x+=48
  oNPC_Gene.image_blend=c_black
  cBlend=0
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gameProgress=525 and room=rMain_8 //----- [1] Chapter 3 -----
{
  if sceneProgress=0
  {
    sceneDelay+=1
    if sceneDelay=1 {global.gamePaused=true}
    else if sceneDelay>=20 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=1 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","You're almost there! This field is a huge expansive land mass. It's the center of the digital mainland. You'll find Central City just to the east from where you are now. It won't take long to reach.",0,3,oMessageCutscene,1)
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"Chao","Wooow! You're right Jeremy!#This place is really cool and it goes so high up!",0,3,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Jerry","So it's going to make Claire's vertical challenges even more apparent huh?",0,3,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Claire","JERRY!! I'm taller than you in the real world!",0,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Yeah, but we're not there.",0,3,oMessageCutscene,1)
  else if sceneProgress=6 and bWaitForInput=false
    msgCreate(0,0,"Chao","Still counts.",0,3,oMessageCutscene,1)
  else if sceneProgress=7
  {
    var tNewChapter;
    tNewChapter=instance_create(0,0,oChapterDisplay)
    tNewChapter.newChapter="Chapter 3#Overrun"
    sceneDelay=0; sceneProgress=0
    global.gameProgress=530
    global.gamePaused=false
  }
}
else if global.gameProgress=530 and room=rMain_8 //----- [] Enemy Trap (Player must use birds to win) -----
{
  if global.gamePaused=false
  {
    if sceneProgress=0
    {
      if oPlayer1.x>=432
      {
        var enemyCounter,enemyBarrier;
        enemyCounter=instance_create(0,0,oEnemyRemain)
        enemyCounter.enemyCount=3
        enemyBarrier=instance_create(208,1152,oEnemyBarrier); enemyBarrier.image_yscale=12
        enemyBarrier=instance_create(624,1152,oEnemyBarrier); enemyBarrier.image_yscale=12
        //Spawn birds
        var tBird;
        for(i=0;i<22;i+=1)
        {
          tBird=instance_create(240+(i*16),1344,oDiveBird); tBird.diveIn=1
        }
        for(i=0;i<3;i+=1)
        {
          tBird=instance_create(300+(i*18),1280,oDiveBird); tBird.diveIn=1
        }
        tBird=instance_create(512,1280,oDiveBird); tBird.diveIn=1
        sceneProgress+=1
      }
    }
    else if sceneProgress=1
    {
      sceneDelay+=1
      if sceneDelay=30
      {
        delaySpawn(544,1344,oSprongySpring,2,1,1,0.33)
        delaySpawn(320,1344,oEggBot,2,1,1,0.33)
        delaySpawn(432,1216,oBombDropper,2,1,1,0.33)
      }
      else if sceneDelay=90
      {
        msgCreate(0,0,"Jerry","This is going to be a thing without offensive abilities.",0,1,oMessagePerson,0)
        newMessage.fadingTime=130
      }
      else if sceneDelay=220
      {
        msgCreate(0,0,"Jeremy","Those birds seem to be able to help.",0,1,oMessagePerson,0)
        newMessage.fadingTime=110
        sceneDelay=0; sceneProgress+=1
      }
    }
    else if sceneProgress=2
    {
      sceneDelay+=1
      if sceneDelay=210 and global.activeCharacter=1
      {
        msgCreate(0,0,"Jeremy","So yeah, the birds only respond to Jerry for some reason.",0,1,oMessagePerson,0)
        newMessage.fadingTime=110
      }

      if oEnemyRemain.enemyCount<=0
      {
        with oEnemyRemain {instance_destroy()}
        with oEnemyBarrier {instance_destroy()}
        sceneDelay=0; sceneProgress=0
        global.gameProgress=540
      }
    }
  }
}
else if global.gameProgress=550 and room=rCCity_NorthA //----- [2] Central City -----
{
  if sceneProgress=0
  {
    sceneDelay+=1
    if sceneDelay=1 {global.gamePaused=true}
    else if sceneDelay>=20 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=1 and bWaitForInput=false
    msgCreate(0,0,"Chao","Ooh, this is nice... sorta.",0,3,oMessageCutscene,1)
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Yeah, it would be if it weren't terribly overwhelmed by virus infected bots.",0,3,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Jerry","What's up with that anyway?",0,3,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Chao","The Virus is trying to remove any threats to itself.",0,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Jerry","And this city is one of them?",0,3,oMessageCutscene,1)
  else if sceneProgress=6 and bWaitForInput=false
    msgCreate(0,0,"Chao","Yes, but I think Jeremy knows more than me on that.",0,3,oMessageCutscene,1)
  else if sceneProgress=7 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","This is a center for both bots and humans. Having them co-exist is a problem for the Virus.",0,3,oMessageCutscene,1)
  else if sceneProgress=8 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Bots? I keep seeing that word get thrown around. One of the toads in that Gate said it.",0,3,oMessageCutscene,1)
  else if sceneProgress=9 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Bots are, simply put, programs. Whereas all of us are human.",0,3,oMessageCutscene,1)
  else if sceneProgress=10 and bWaitForInput=false
    msgCreate(0,0,"Jerry","I'm really glad that wasn't some verbose answer.",0,3,oMessageCutscene,1)
  else if sceneProgress=11 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","We're not in an RPG world.",0,3,oMessageCutscene,1)
  else if sceneProgress=12 and bWaitForInput=false
    msgCreate(0,0,"Jerry","What's the objective then?",0,3,oMessageCutscene,1)
  else if sceneProgress=13 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Find a way to get rid of these virus infected bots. There are defensive weapons posted around the city, but they are inactive.",0,3,oMessageCutscene,1)
  else if sceneProgress=14 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Ah right, get to them so you can program them to target anything virus infected.",0,3,oMessageCutscene,1)
  else if sceneProgress=15 and bWaitForInput=false
    msgCreate(0,0,"Claire","Nice Jerry... and unexpectedly insightful of you to figure that out.",0,3,oMessageCutscene,1)
  else if sceneProgress=16 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Your attempts at putting me down are just lame, Claire, you're gonna have to try harder than that.",0,3,oMessageCutscene,1)
  else if sceneProgress=17 and bWaitForInput=false
    msgCreate(0,0,"Claire","Who says I've ever tried?",0,3,oMessageCutscene,1)
  else if sceneProgress=18 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Well then you're just being a slacker.",0,3,oMessageCutscene,1)
  else if sceneProgress=19
  {
    sceneDelay=0; sceneProgress=0
    global.gameProgress=560
    global.gamePaused=false
  }
}
else if global.gameProgress=570 and room=rCCity_NA_S2 //----- [3] Reunion -----
{
  if sceneProgress=0
  {
    sceneDelay+=1
    if sceneDelay=1 {global.gamePaused=true}
    else if sceneDelay>=20 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=1 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Dude, you DID make it out!",0,3,oMessageCutscene,1)
  else if sceneProgress=2
  {
    sceneDelay+=1
    if sceneDelay>=30
    {
      fadeAlpha-=0.02
      if fadeAlpha<=0 {sceneDelay=0; sceneProgress+=1}
    }
  }
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Syrus","And why wouldn't I? The Darkness kept its word, it freed us all.",6,3,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Jerry","It is so good to see you again.",0,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Syrus","You too, and who is this with you?",6,3,oMessageCutscene,1)
  else if sceneProgress=6 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Remember Claire? She always hung out with Jeremy's sister and played games with us.",0,3,oMessageCutscene,1)
  else if sceneProgress=7 and bWaitForInput=false
    msgCreate(0,0,"Claire","Hey Syrus...#Jerry, did you really have to tell him something he already knew about me?",0,3,oMessageCutscene,1)
  else if sceneProgress=8 and bWaitForInput=false
    msgCreate(0,0,"Syrus","Oh, hey Claire. How did you two end up crossing paths in the program?",6,3,oMessageCutscene,1)
  else if sceneProgress=9 and bWaitForInput=false
    msgCreate(0,0,"Jerry","She couldn't get enough of me so she tracked me down.",0,3,oMessageCutscene,1)
  else if sceneProgress=10 and bWaitForInput=false
    msgCreate(0,0,"Claire","Jerry, I am going to hurt you so bad...",0,3,oMessageCutscene,1)
  else if sceneProgress=11 and bWaitForInput=false
    msgCreate(0,0,"Syrus","Actually, whatever the story is, we'll have to save it for later. As you can see, the Central City has been completely overrun with the Virus infected robots.",6,3,oMessageCutscene,1)
  else if sceneProgress=12 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","That's something I wanted to talk to you about.",0,3,oMessageCutscene,1)
  else if sceneProgress=13 and bWaitForInput=false
    msgCreate(0,0,"Syrus","Ah, so Jeremy is still with you.",6,3,oMessageCutscene,1)
  else if sceneProgress=14 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Yep... To get straight to the point, where is the Control Center for the city? I saw a defense system in place, but it was inactive.",0,3,oMessageCutscene,1)
  else if sceneProgress=15 and bWaitForInput=false
    msgCreate(0,0,"Syrus","I don't know much about that, but there is someone here who does?",6,3,oMessageCutscene,1)
  else if sceneProgress=16 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Ah, I knew someone else was here.",0,3,oMessageCutscene,1)
  else if sceneProgress=17 and bWaitForInput=false
    msgCreate(0,0,"Syrus","I think it's fine to show yourself.",6,3,oMessageCutscene,1)
  else if sceneProgress=18 and bWaitForInput=false
    msgCreate(0,0,"?????","Sounds good to me.",6,3,oMessageCutscene,1)
  else if sceneProgress=19
  {
    sceneDelay+=1
    if sceneDelay>=31 and sceneDelay<=81
    {
      cBlend+=5
      oNPC_Gene.image_blend=make_color_rgb(cBlend,cBlend,cBlend)
    }
    else if sceneDelay>=110 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=20 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Is that... really you Gene?",0,3,oMessageCutscene,1)
  else if sceneProgress=21 and bWaitForInput=false
    msgCreate(0,0,"Gene","In the flesh. Well, sorta. I know what you're thinking right now.",6,3,oMessageCutscene,1)
  else if sceneProgress=22 and bWaitForInput=false
    msgCreate(0,0,"Jerry","We know that wasn't really you back when we were battling the program, though that copy sure made it believable. Where were you anyway?",0,3,oMessageCutscene,1)
  else if sceneProgress=23 and bWaitForInput=false
    msgCreate(0,0,"Gene","Same place The Darkness stuck most other people.",6,3,oMessageCutscene,1)
  else if sceneProgress=24 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","The Vault?",0,3,oMessageCutscene,1)
  else if sceneProgress=25 and bWaitForInput=false
    msgCreate(0,0,"Gene","No, not there. It had a seperate secured zone for humans. When you guys fulfilled your agreement terms with The Darkness, it freed us all from it. Brought most of us to this city.",6,3,oMessageCutscene,1)
  else if sceneProgress=26 and bWaitForInput=false
    msgCreate(0,0,"Jerry","What is that thing you mentioned, the Vault?",0,3,oMessageCutscene,1)
  else if sceneProgress=27 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","It's The Darkness' virus vault basically. It's where it put unwanted programs.",0,3,oMessageCutscene,1)
  else if sceneProgress=28 and bWaitForInput=false
    msgCreate(0,0,"Gene","What he said. It has a location on the mainland as well, or at least an entry point.",6,3,oMessageCutscene,1)
  else if sceneProgress=29 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Isn't that a bit dangerous?",0,3,oMessageCutscene,1)
  else if sceneProgress=30 and bWaitForInput=false
    msgCreate(0,0,"Syrus","It's sealed up tight. Nothing goes in or out of that place... well it used to be that way.",6,3,oMessageCutscene,1)
  else if sceneProgress=31 and bWaitForInput=false
    msgCreate(0,0,"Gene","Yep, its been acting weird. Or had anyway. A few programs slipped out when the Virus took over, I guess The Darkness recoded the lock on it just before it lost control.",6,3,oMessageCutscene,1)
  else if sceneProgress=32 and bWaitForInput=false
    msgCreate(0,0,"Jerry","If it did that, it must have a high priority to keep everything in there.",0,3,oMessageCutscene,1)
  else if sceneProgress=33 and bWaitForInput=false
    msgCreate(0,0,"Gene","That's the assumption, but that isn't the current issue. Right now, we need to get these infected bots out of Central City.",6,3,oMessageCutscene,1)
  else if sceneProgress=34 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Yes, where is that Control Center?",0,3,oMessageCutscene,1)
  else if sceneProgress=35 and bWaitForInput=false
    msgCreate(0,0,"Gene","There is a bridge that leads to the south side of Central City. The Control Center is within the structure by that bridge. The issue is that we can't get through all the infected bots in there.",6,3,oMessageCutscene,1)
  else if sceneProgress=36 and bWaitForInput=false
    msgCreate(0,0,"Jerry","We can get through them and turn the defensive grid back on.",0,3,oMessageCutscene,1)
  else if sceneProgress=37 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","No we can't, you have no way of fighting back right now. All offensive abilities are locked down.",0,3,oMessageCutscene,1)
  else if sceneProgress=38 and bWaitForInput=false
    msgCreate(0,0,"Jerry","So we're S-O-L then?",0,3,oMessageCutscene,1)
  else if sceneProgress=39 and bWaitForInput=false
    msgCreate(0,0,"Syrus","Not necessarily. I've seen ways to, in a sense, harness the abilities of game characters that The Darkness had read into its system.",6,3,oMessageCutscene,1)
  else if sceneProgress=40 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Wait a minute, we've done that. Me and Claire...",0,3,oMessageCutscene,1)
  else if sceneProgress=41 and bWaitForInput=false
    msgCreate(0,0,"Chao","Claire and I.",0,3,oMessageCutscene,1)
  else if sceneProgress=42 and bWaitForInput=false
    msgCreate(0,0,"Jerry","ME and CLAIRE!... Can mimic Mario.",0,3,oMessageCutscene,1)
  else if sceneProgress=43 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Yes, but for some reason that ability set singles out specific data. You need something else.",0,3,oMessageCutscene,1)
  else if sceneProgress=44 and bWaitForInput=false
    msgCreate(0,0,"Syrus","There's a huge power emanating from the north-west parts of the Greatest Stretch. I'm willing to bet that you guys could use that.",6,3,oMessageCutscene,1)
  else if sceneProgress=45 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Emanating from it? What does that even mean in a place like this?",0,3,oMessageCutscene,1)
  else if sceneProgress=46 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","It's worth a shot.",0,3,oMessageCutscene,1)
  else if sceneProgress=47 and bWaitForInput=false
    msgCreate(0,0,"Chao","Jeremy, it gives off the same reading that Gate did. Do you think it might have one of those Program Chip parts?",0,3,oMessageCutscene,1)
  else if sceneProgress=48 and bWaitForInput=false
    msgCreate(0,0,"Jerry","A reading? What are you two even talking about?",0,3,oMessageCutscene,1)
  else if sceneProgress=49 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","You're right Chao, I didn't see that at first.#And Jerry, quit questioning 4th wall logic.",0,3,oMessageCutscene,1)
  else if sceneProgress=50 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Fine, but how are we going to get up there? Those ledges were way higher than we can jump.",0,3,oMessageCutscene,1)
  else if sceneProgress=51 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Fixed, you can get up there now.",0,3,oMessageCutscene,1)
  else if sceneProgress=52 and bWaitForInput=false
    msgCreate(0,0,"Jerry","This is so aggravating.",0,3,oMessageCutscene,1)
  else if sceneProgress=53 and bWaitForInput=false
    msgCreate(0,0,"Claire","It's okay Jerry, for once, I agree with you.",0,3,oMessageCutscene,1)
  else if sceneProgress=54 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Dear God, it's the end of the world.",0,3,oMessageCutscene,1)
  else if sceneProgress=55
  {
    var tFlash;
    tFlash=instance_create(0,0,oScreenFlash)
    tFlash.fadeSpeed=0.2
    oPlayer1.visible=1
    if global.activeCharacter=0 oPlayer1.x=charJerry.x
    else if global.activeCharacter=1 oPlayer1.x=charClaire.x
    with oMisc {instance_destroy()}
    oNPC_Gene.image_blend=c_white
    sceneDelay=0; sceneProgress=0
    global.gameProgress=580
    global.gamePaused=false
  }
}
else if global.gameProgress=590 and room=rMain_8Gate //----- [4] The next Access Gate -----
{
  if sceneProgress=0
  {
    sceneDelay+=1
    if sceneDelay=1
    {
      global.gamePaused=true
      oPlayer1.image_xscale=-1
    }
    else if sceneDelay>=20 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=1 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Yep, it's another one of those creepy gate things.",0,3,oMessageCutscene,1)
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"Claire","I wonder where this one will take us.",0,3,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Jerry","I'm really curious about that myself.",0,3,oMessageCutscene,1)
  else if sceneProgress=4
  {
    sceneDelay=0; sceneProgress=0
    global.gameProgress=600
    global.gamePaused=false
  }
}
else if global.gameProgress=610 and room=rMain_8Gate //----- [Unskippable] Access Gate 2 -----
{
  if sceneProgress=0
  {
    sceneDelay+=1
    if sceneDelay>=1
    {
      if sceneDelay=1 {global.gamePaused=true}
      fadeAlpha+=0.04
      if fadeAlpha>=1 {sceneDelay=0; sceneProgress+=1}
    }
  }
  else if sceneProgress=1
  {
    oPlayer1.life=oPlayer1.maxLife
    global.recAreaTrans+=1
    global.newMapX=400
    global.newMapY=256
    writeToPlayerGlobals()
    stopAllMusic()
    transition_steps=1
    transition_kind=0
    room_goto(rLink2_HP)
  }
}

keyWaitForInput()

if oKeyCodes.kCodePressed[11]=1 and global.gamePaused=true and sceneProgress>=1 //Cutscene skip
{
  if !instance_exists(oPauseMenu)
  {
    if global.gameProgress=530 and room=rMain_8 //[1]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      sceneDelay=0
      sceneProgress=7
    }
    else if global.gameProgress=550 and room=rCCity_NorthA //[2]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      sceneDelay=0
      sceneProgress=19
    }
    else if global.gameProgress=570 and room=rCCity_NA_S2 //[3]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      fadeAlpha=0
      sceneDelay=0
      sceneProgress=55
    }
    else if global.gameProgress=590 and room=rMain_8Gate //[4]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      sceneDelay=0
      sceneProgress=4
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
