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

if room=rDesertedTowerB
{
  platformSpawn=210
  if global.newMapY=2752
  {
    with oPlayer1
    {
      setCollisionBounds(-7,-13,7,-1)
      runAcc=7.6
      attackState=ACT_MORPHBALL
    }
  }
}
else if room=rDesertedTowerC
{
  platformSpawn=270
  if global.newMapY=272
  {
    with oPlayer1
    {
      setCollisionBounds(-7,-13,7,-1)
      runAcc=7.6
      attackState=ACT_MORPHBALL
    }
  }
}
else if room=rMain_56
{
  if global.gameProgress=3100
  {
    fadeColor=c_black
    fadeAlpha=1
  }
}
else if room=rNGC_LC_A
{
  fadeColor=make_color_rgb(130,0,0)
  if global.gameProgress=3190 {fadeAlpha=1}
  else {fadeAlpha=0.3}
}
else if room=rNGC_LC_B
{
  fadeColor=make_color_rgb(130,0,0)
  fadeAlpha=0.3
}
else if room=rNGC_LC_C
{
  if global.gameProgress=3230
  {
    musicFade=global.optMusic*100
    fadeColor=c_black
    fadeAlpha=0.4
  }
  else
  {
    fadeColor=make_color_rgb(130,0,0)
    fadeAlpha=0.15
  }
}
else if room=rNGC_LC_D
{
  fadeColor=make_color_rgb(130,0,0)
  fadeAlpha=0.15
}
else if room=rNGC_BR_B
{
  jerryTime=0
  jerryY=-6
  claireTime=0
  claireY=-6
  truckSpd=0
}
else if room=rMain_56
{
  if global.gameProgress=3360
  {
    fadeColor=c_black
    fadeAlpha=1
  }
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gameProgress=3080 and room=rMain_50 //----- [1] Head east to reach Gate 6 -----
{
  if sceneProgress=0
  {
    sceneDelay+=1
    if sceneDelay=1 {global.gamePaused=true}
    else if sceneDelay>=30 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=1 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Just keep heading east and we'll eventually reach the final Gate.",0,3,oMessageCutscene,1)
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Any idea what's between us and the Gate?",0,3,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Sorta. I'll tell you more about it when you get closer. One thing I'm sure of is Hex does not want us getting there.",0,3,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Jerry","So basically we'll stomp all over his plans during this?",0,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","I hope so.",0,3,oMessageCutscene,1)
  else if sceneProgress=6
  {
    var tNewChapter;
    tNewChapter=instance_create(0,0,oChapterDisplay)
    tNewChapter.newChapter="Chapter 14#Truths Revealed"
    sceneDelay=0; sceneProgress=0
    global.gameProgress=3090
    global.gamePaused=false
  }
}
else if global.gameProgress=3090 and room=rMain_51 //----- [2] Burning Stretch and CHAOS -----
{
  if sceneProgress=0
  {
    sceneDelay+=1
    if sceneDelay=1 {global.gamePaused=true}
    else if sceneDelay>=30 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=1 and bWaitForInput=false
    msgCreate(0,0,"Jerry","So why did Chapter 14 start back there?",0,3,oMessageCutscene,1)
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"Claire","Ignore Jerry. What is this place?",0,3,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","The Burning Stretch. It's a pretty nice place, well it was anyway.",0,3,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Claire","Was?",0,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","You might remember the name CHAOS from before. I figured out that they're a large militant group of bots. They recently took over this area and completely seized control of a city to the east.",0,3,oMessageCutscene,1)
  else if sceneProgress=6 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Should we avoid them?",0,3,oMessageCutscene,1)
  else if sceneProgress=7 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Yeah, I'll get you routes around the city, Neo Grime. I don't know how organized they are in combat, but there sure are a lot of them.",0,3,oMessageCutscene,1)
  else if sceneProgress=8 and bWaitForInput=false
    msgCreate(0,0,"Jerry","As long as they don't get in the way to this last Gate, we're good.",0,3,oMessageCutscene,1)
  else if sceneProgress=9 and bWaitForInput=false
    msgCreate(0,0,"Claire","What's CHAOS an acronym for anyway?",0,3,oMessageCutscene,1)
  else if sceneProgress=10 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Claire Has An Odd Secret.",0,3,oMessageCutscene,1)
  else if sceneProgress=11 and bWaitForInput=false
    msgCreate(0,0,"Claire","Really? And what might that secret be?",0,3,oMessageCutscene,1)
  else if sceneProgress=12 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Eh... I got nothing.",0,3,oMessageCutscene,1)
  else if sceneProgress=13 and bWaitForInput=false
    msgCreate(0,0,"Claire","Uh-huh.",0,3,oMessageCutscene,1)
  else if sceneProgress=14
  {
    sceneDelay=0; sceneProgress=0
    global.gameProgress=3100
    global.gamePaused=false
  }
}
else if global.gameProgress=3100 and room=rMain_56 //----- [3] You must find the Engineer -----
{
  if sceneProgress=0
  {
    sceneDelay+=1
    if sceneDelay=1
    {
      global.gamePaused=true
      stopAllMusic()
      oPlayer1.x=752; oPlayer1.y=160
      (308182).image_xscale=-1; (308183).image_xscale=-1
    }
    else if sceneDelay>=35
    {
      if fadeAlpha>0 {fadeAlpha-=0.02}
      else if fadeAlpha<=0 {sceneDelay=0; sceneProgress+=1}
    }
  }
  else if sceneProgress=1
  {
    sceneDelay+=1
    if sceneDelay>=30 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"Bubblun","You're here to get into the final Access Gate, correct?",6,3,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Yeah, just one more Chip and we can put a stop to the Virus.",0,3,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Bubblun","It's here, but unfortunately it's locked up.",6,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Figures.",0,3,oMessageCutscene,1)
  else if sceneProgress=6 and bWaitForInput=false
    msgCreate(0,0,"Bubblun","Lovelun and I can open it... Well, we could with some help.",6,3,oMessageCutscene,1)
  else if sceneProgress=7 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Anything we can do?",0,3,oMessageCutscene,1)
  else if sceneProgress=8 and bWaitForInput=false
    msgCreate(0,0,"Bubblun","Yes, it's something we're not able to... I need you to get into Neo Grime City and free our friend. Without him, that Gate is not getting open.",6,3,oMessageCutscene,1)
  else if sceneProgress=9 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Your friend eh? Another bubbly guy?",0,3,oMessageCutscene,1)
  else if sceneProgress=10 and bWaitForInput=false
    msgCreate(0,0,"Bubblun","No, not a bot.",6,3,oMessageCutscene,1)
  else if sceneProgress=11 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","We'll need more than that.",0,3,oMessageCutscene,1)
  else if sceneProgress=12 and bWaitForInput=false
    msgCreate(0,0,"Bubblun","He was the program's lead engineer.",6,3,oMessageCutscene,1)
  else if sceneProgress=13 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","What, really?",0,3,oMessageCutscene,1)
  else if sceneProgress=14 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Didn't he go by 'Flame Instigator' when we first met him, using that Fefnir look from the Mega Man games?",0,3,oMessageCutscene,1)
  else if sceneProgress=15 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","That's him, probably to hide from the program back then.",0,3,oMessageCutscene,1)
  else if sceneProgress=16 and bWaitForInput=false
    msgCreate(0,0,"Bubblun","Oh good, you're all acquainted then.",6,3,oMessageCutscene,1)
  else if sceneProgress=17 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Neo Grime City is under heavy watch by CHAOS. What was the engineer doing in there?",0,3,oMessageCutscene,1)
  else if sceneProgress=18 and bWaitForInput=false
    msgCreate(0,0,"Bubblun","Trying to remove their control of it I think, but he was found and imprisoned there.",6,3,oMessageCutscene,1)
  else if sceneProgress=19 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","This is going to be difficult. How do we even get in the city?",0,3,oMessageCutscene,1)
  else if sceneProgress=20 and bWaitForInput=false
    msgCreate(0,0,"Bubblun","I'll create a distraction so you two can enter from the east side of the city.",6,3,oMessageCutscene,1)
  else if sceneProgress=21 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","What are we even looking for?",0,3,oMessageCutscene,1)
  else if sceneProgress=22 and bWaitForInput=false
    msgCreate(0,0,"Bubblun","They have him in the dungeons below, that's all I know. We need him to open the Gate, but more than that, he's our friend.",6,3,oMessageCutscene,1)
  else if sceneProgress=23 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","I have questions for him as well. He'll definitely be helpful against this Virus.",0,3,oMessageCutscene,1)
  else if sceneProgress=24 and bWaitForInput=false
    msgCreate(0,0,"Bubblun","Good, by the time you get to the city, the guards should be on alert, but not for you.",6,3,oMessageCutscene,1)
  else if sceneProgress=25 and bWaitForInput=false
    msgCreate(0,0,"Jerry","There isn't going to be some sneaky stuff we'll have to do, right? Cause that's kinda lame.",0,3,oMessageCutscene,1)
  else if sceneProgress=26 and bWaitForInput=false
    msgCreate(0,0,"Bubblun","I wouldn't recommend doing what you normally do, but do what you can to get our friend out of there safely.",6,3,oMessageCutscene,1)
  else if sceneProgress=27 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","In other words, Jerry. If you alert them to you, you're going to have A LOT to deal with. It might be good to remain unspotted.",0,3,oMessageCutscene,1)
  else if sceneProgress=28 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Ugh, fine.",0,3,oMessageCutscene,1)
  else if sceneProgress=29
  {
    sceneDelay=0; sceneProgress=0
    global.gameProgress=3110
    global.gamePaused=false
  }
}
else if global.gameProgress=3110 and room=rNGC_A //----- [4] Welp, screw sneaking in -----
{
  if sceneProgress=0
  {
    sceneDelay+=1
    if sceneDelay=1 {global.gamePaused=true}
    else if sceneDelay>=30 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=1 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Welp, screw sneaking in. They already knew we were coming.",0,3,oMessageCutscene,1)
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"Chao","But they don't know why we're here.",0,3,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","That's true. Jerry, Claire... head straight down this road, I'll mark the building to enter that has a way down.",0,3,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Sounds good.",0,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Luckily this city was easy to map out. There's quite an expansive labyrinth of networks below the city. Luckily, you won't need to traverse any of that. By the time you reach the marked building, I'll know the way to the dungeons.",0,3,oMessageCutscene,1)
  else if sceneProgress=6
  {
    sceneDelay=0; sceneProgress=0
    global.gameProgress=3120
    global.gamePaused=false
  }
}
else if global.gameProgress=3120 and room=rNGC_A //----- [] Enemy trap -----
{
  if sceneProgress=0
  {
    if oPlayer1.x<=1984
    {
      var enemyCounter,enemyBarrier;
      enemyCounter=instance_create(0,0,oEnemyRemain)
      enemyCounter.enemyCount=1
      enemyBarrier=instance_create(1728,0,oEnemyBarrier); enemyBarrier.image_yscale=16
      enemyBarrier=instance_create(2240,0,oEnemyBarrier); enemyBarrier.image_yscale=18
      sceneProgress+=1
    }
  }
  else if sceneProgress=1
  {
    if global.gamePaused=false
    {
      sceneDelay+=1
      if sceneDelay=60
      {
        delaySpawn(1984,96,oFlyingGMWonderbird,2,1,1,0.33)
        sceneDelay=0; sceneProgress+=1
      }
    }
  }
  else if sceneProgress=2
  {
    if oEnemyRemain.enemyCount<=0
    {
      with oEnemyRemain {instance_destroy()}
      with oEnemyBarrier {instance_destroy()}
      sceneProgress=0
      global.gameProgress=3130
    }
  }
}
else if global.gameProgress=3130 and room=rNGC_B //----- [5] Remember those B2 Bombers from Windy Slopes -----
{
  if sceneProgress=0
  {
    sceneDelay+=1
    if sceneDelay=1 {global.gamePaused=true}
    else if sceneDelay>=30 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=1 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Remember those B2 Bombers from Windy Slopes way back in the day?",0,3,oMessageCutscene,1)
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"Jerry","You mentioning them means they're here.",0,3,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Yep. Those missiles have been upgraded to pierce through your dash. Careful.",0,3,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Claire","What are we talking about?",0,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Jerry","You'll see... and then you'll be annoyed.",0,3,oMessageCutscene,1)
  else if sceneProgress=6
  {
    sceneDelay=0; sceneProgress=0
    global.gameProgress=3140
    global.gamePaused=false
  }
}
else if global.gameProgress=3140 and room=rNGC_B //----- [] Enemy trap -----
{
  if sceneProgress=0
  {
    if oPlayer1.x<=2864
    {
      var enemyCounter,enemyBarrier;
      enemyCounter=instance_create(0,0,oEnemyRemain)
      enemyCounter.enemyCount=13
      enemyBarrier=instance_create(2528,0,oEnemyBarrier); enemyBarrier.image_yscale=14
      enemyBarrier=instance_create(3168,0,oEnemyBarrier); enemyBarrier.image_yscale=14
      sceneProgress+=1
    }
  }
  else if sceneProgress=1
  {
    if global.gamePaused=false
    {
      sceneDelay+=1
      if sceneDelay=20
      {
        delaySpawn(2592,112,oZakoCannonfodder,2,1,1,0.33)
        delaySpawn(3136,112,oZakoCannonfodder,2,1,1,0.33)
      }
      else if sceneDelay=70
      {
        delaySpawn(2656,112,oZakoCannonfodder,2,1,1,0.33)
        delaySpawn(3072,112,oZakoCannonfodder,2,1,1,0.33)
      }
      else if sceneDelay=160
      {
        delaySpawn(2640,224,oZakoSoldier,2,1,1,0.33)
        delaySpawn(3088,224,oZakoSoldier,2,1,1,0.33)
      }
      else if sceneDelay=260
      {
        if oEnemyRemain.enemyCount<=8
        {
          delaySpawn(2784,112,oZakoCannonfodder,2,1,1,0.33)
          delaySpawn(2944,112,oZakoCannonfodder,2,1,1,0.33)
        }
        else {sceneDelay=230}
      }
      else if sceneDelay=350
      {
        delaySpawn(2624,224,oZakoBomber,2,1,1,0.33)
        delaySpawn(3104,224,oZakoBomber,2,1,1,0.33)
      }
      else if sceneDelay=400
      {
        delaySpawn(2656,112,oZakoCannonfodder,2,1,1,0.33)
        delaySpawn(3072,112,oZakoCannonfodder,2,1,1,0.33)
      }
      else if sceneDelay=490
      {
        if oEnemyRemain.enemyCount<=1
        {
          delaySpawn(2864,96,oFlyingGMWonderbird,2,1,1,0.33)
          sceneDelay=0; sceneProgress+=1
        }
        else {sceneDelay=460}
      }
    }
  }
  else if sceneProgress=2
  {
    if oEnemyRemain.enemyCount<=0
    {
      with oEnemyRemain {instance_destroy()}
      with oEnemyBarrier {instance_destroy()}
      sceneProgress=0
      global.gameProgress=3150
    }
  }
}
else if global.gameProgress=3150 and room=rNGC_RB_A //----- [6] Blowing up out-of-place generators -----
{
  if sceneProgress=0
  {
    sceneDelay+=1
    if sceneDelay=1 {global.gamePaused=true}
    else if sceneDelay>=30 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=1 and bWaitForInput=false
    msgCreate(0,0,"Jerry","This is the building you marked.",0,3,oMessageCutscene,1)
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Yes, this is some research facility. I don't know what for, but just keep going down. An entrance to the dungeons can be found farther down here.",0,3,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Jerry","More pew pew action.",0,3,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Also there's a barrier and some out-of-place generators in this room... You know what to do. I think a Z like pattern through this should do just fine.",0,3,oMessageCutscene,1)
  else if sceneProgress=5
  {
    sceneDelay=0; sceneProgress=0
    global.gameProgress=3160
    global.gamePaused=false
  }
}
else if global.gameProgress=3160 and room=rNGC_RB_A //----- [] Blow up all generators -----
{
  if !instance_exists(oNGCRmGen) {global.gameProgress=3170}
}
else if global.gameProgress=3170 and room=rNGC_RB_B //----- [] Blow up all generators -----
{
  if !instance_exists(oNGCRmGen) {global.gameProgress=3180}
}
else if global.gameProgress=3180 and room=rNGC_RB_EleA //----- [7] Remember those B2 Bombers from Windy Slopes -----
{
  if sceneProgress=0
  {
    sceneDelay+=1
    if sceneDelay=1 {global.gamePaused=true}
    else if sceneDelay>=30 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=1 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Be sure you're ready for this. I don't know if the elevator will go back up and I'm pretty sure we'll need to find a different way out once you go down.",0,3,oMessageCutscene,1)
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Thanks for the heads up.",0,3,oMessageCutscene,1)
  else if sceneProgress=3
  {
    sceneDelay=0; sceneProgress=0
    global.gameProgress=3190
    global.gamePaused=false
  }
}
else if global.gameProgress=3190 and room=rNGC_RB_EleA //----- [8] Elevator ride down -----
{
  if sceneProgress=0
  {
    if oPlayer1.x>=240
    {
      scenePChk(oPlayer1.x,oPlayer1.y,1,0.1,1)
      global.gamePaused=true
      oPlayer1.y+=4
      if oPlayer1.y>=196
      {
        playSound(global.snd_BombExplode,0,0.95,1)
        for(i=0;i<5;i+=1)
        {
          tEffect=instance_create(32,32+(64*i),oEffect)
          tEffect.sprite_index=sShipExplosion; tEffect.followID=-1; tEffect.xFollow=0; tEffect.yFollow=0
          tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
        }
        tile_layer_hide(999998)
        with (311614) {instance_destroy()}
        with (311615) {instance_destroy()}
        with (oExit) {instance_destroy()}
        background_vspeed[0]=-2; background_vspeed[1]=-2.25; background_vspeed[2]=-2.25
        scenePChk(oPlayer1.x,196,0,0.1,1)
        stopPlayer()
        sceneProgress+=1
      }
    }
  }
  else if sceneProgress=1
  {
    sceneDelay+=1
    if sceneDelay>=30 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Okay, we're going down to the lower research area. This is where they are keeping the Engineer. It shouldn't be a problem getting there, I know the way.",0,3,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Hex","Oh hi there everyone.",0,3,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Ugh, go away. We're in the middle of something.",0,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Hex","Oh I know. I don't really care about you saving your engineer friend, I mean, I'm pretty busy preparing to destroy this program and all.",0,3,oMessageCutscene,1)
  else if sceneProgress=6 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Then why are you here?",0,3,oMessageCutscene,1)
  else if sceneProgress=7 and bWaitForInput=false
    msgCreate(0,0,"Hex","Unfinished business with you. I mean look what I can do here.",0,3,oMessageCutscene,1)
  else if sceneProgress=8
  {
    sceneDelay+=1
    if sceneDelay=20
    {
      background_vspeed[0]=-8; background_vspeed[1]=-9; background_vspeed[2]=-9
    }
    else if sceneDelay>=40 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=9 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Dude, Jeremy...",0,3,oMessageCutscene,1)
  else if sceneProgress=10 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Hex, that can't hurt them.",0,3,oMessageCutscene,1)
  else if sceneProgress=11 and bWaitForInput=false
    msgCreate(0,0,"Hex","I know the rules.",0,3,oMessageCutscene,1)
  else if sceneProgress=12 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Then why? Just go away.",0,3,oMessageCutscene,1)
  else if sceneProgress=13 and bWaitForInput=false
    msgCreate(0,0,"Hex","You just passed your floor. I'll be seeing you soon.",0,3,oMessageCutscene,1)
  else if sceneProgress=14
  {
    sceneDelay+=1
    if sceneDelay=10 {background_vspeed[0]=-12; background_vspeed[1]=-13.5; background_vspeed[2]=-13.5}
    else if sceneDelay>=20 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=15 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Can you stop it?",0,3,oMessageCutscene,1)
  else if sceneProgress=16 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","I'm trying!",0,3,oMessageCutscene,1)
  else if sceneProgress=17
  {
    sceneDelay+=1
    if sceneDelay=20
    {
      stopAllMusic()
      playSound(global.snd_HardHit1,0,1,14000)
      playSound(global.snd_BombExplode,0,1,14000)
      fadeColor=c_black
      fadeAlpha=1
    }
    else if sceneDelay>=50
    {
      global.pLife=global.pMaxLife
      oPlayer1.life=oPlayer1.maxLife
      global.newMapX=128
      global.newMapY=288
      room_goto(rNGC_LC_A)
    }
  }
}
else if global.gameProgress=3190 and room=rNGC_LC_A //----- [9] We're stuck down here -----
{
  if sceneProgress=0
  {
    sceneDelay+=1
    if sceneDelay=1
    {
      if global.activeCharacter=0 {oPlayer1.sprite_index=sJerryLayDown}
      else {oPlayer1.sprite_index=sClaireLayDown}
    }
    else if sceneDelay>=50
    {
      fadeAlpha-=0.01
      if fadeAlpha<=0.3 {sceneDelay=0; sceneProgress+=1}
    }
  }
  else if sceneProgress=1
  {
    sceneDelay+=1
    if sceneDelay=20
    {
      if global.activeCharacter=0 {oPlayer1.sprite_index=sJerryGetUp}
      else {oPlayer1.sprite_index=sClaireSitUp}
    }
    else if sceneDelay=24 {image_index=1}
    else if sceneDelay=28 {image_index=2}
    else if sceneDelay=32 {scenePChk(oPlayer1.x,oPlayer1.y,0,0.1,1)}
    if sceneDelay>=45 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Well you were right about the elevator not going back up.",0,3,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Sorry about that. I couldn't stop the thing.",0,3,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Claire","Great, so how far are we from the Engineer?",0,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Not much farther off from our original path actually. I can still get you to him quickly. Just watch yourself, CHAOS has all sorts of weird stuff down here. I'll try to lead you guys around them.",0,3,oMessageCutscene,1)
  else if sceneProgress=6
  {
    var tempMplay;
    tempMplay=findMusic(16)
    playMusic(tempMplay,0,0)
    sceneDelay=0; sceneProgress=0
    global.gameProgress=3200
    global.gamePaused=false
  }
}
else if global.gameProgress=3200 and room=rNGC_LC_A //----- [] Kill all enemies -----
{
  if !instance_exists(oEnemyBase)
  {
    with oEnemyBarrier {instance_destroy()}
    global.gameProgress=3210
  }
}
else if global.gameProgress=3210 and room=rNGC_LC_B //----- [10] Hex knows who made the Virus -----
{
  if sceneProgress=0
  {
    sceneDelay+=1
    if sceneDelay=1 {global.gamePaused=true}
    else if sceneDelay>=30 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=1 and bWaitForInput=false
    msgCreate(0,0,"Hex","You ever wondered where the Virus came from? Its origins are quite interesting.",0,3,oMessageCutscene,1)
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"Claire","We already told you to go away.",0,3,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Hex","That's rude Claire. And I was going to tell you too.",0,3,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Claire","Like you even know.",0,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Hex","It's painfully obvious. Think about the timing of it all. It was convenient... at least for me anyway. I gotta give the guy props for starting something so grand. It just needed a few finishing touches.",0,3,oMessageCutscene,1)
  else if sceneProgress=6 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Yeah I think we've heard enough from you.",0,3,oMessageCutscene,1)
  else if sceneProgress=7 and bWaitForInput=false
    msgCreate(0,0,"Hex","I do think the timing isn't quite right yet. Just don't ruin it.",0,3,oMessageCutscene,1)
  else if sceneProgress=8
  {
    sceneDelay=0; sceneProgress=0
    global.gameProgress=3220
    global.gamePaused=false
  }
}
else if global.gameProgress=3220 and room=rNGC_LC_B //----- [] Kill all enemies -----
{
  if !instance_exists(oEnemyBase)
  {
    with oEnemyBarrier {instance_destroy()}
    global.gameProgress=3230
  }
}
else if global.gameProgress=3230 and room=rNGC_LC_C //----- [Unskippable] Jeremy made the Virus; The lights go out -----
{
  if musicFade>0 and sceneProgress>=9 and sceneProgress<=18 //Fade music
  {
    musicFade-=8
    fadeVolume(global.msc_NGCLowerChamber,8)
  }
  
  if sceneProgress=0
  {
    sceneDelay+=1
    if sceneDelay=1 {global.gamePaused=true}
    else if sceneDelay>=30 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=1 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","The path splits off somewhere around here, but I'll get you to the right place shortly.",0,3,oMessageCutscene,1)
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"Hex","I wonder, Jeremy. How long are you going to go on with this?",0,3,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Can we just block this guy out?",0,3,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Hex","So do you want to know where it came from?",0,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Jerry","You know, if you're so adamant about telling us, just say it.",0,3,oMessageCutscene,1)
  else if sceneProgress=6 and bWaitForInput=false
    msgCreate(0,0,"Hex","The answer has been right there the whole time.",0,3,oMessageCutscene,1)
  else if sceneProgress=7 and bWaitForInput=false
    msgCreate(0,0,"Jerry","What sort of clue is that?",0,3,oMessageCutscene,1)
  else if sceneProgress=8 and bWaitForInput=false
    msgCreate(0,0,"Claire","He's messing with us again.",0,3,oMessageCutscene,1)
  else if sceneProgress=9 and bWaitForInput=false
    msgCreate(0,0,"Hex","How do you think your friend here knew how to stop it? How did he know about those Program Chips? Kinda makes you think, doesn't it?",0,3,oMessageCutscene,1)
  else if sceneProgress=10 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Whoa, what are you saying?",0,3,oMessageCutscene,1)
  else if sceneProgress=11 and bWaitForInput=false
    msgCreate(0,0,"Hex","Oh come on, have you not thought about that?",0,3,oMessageCutscene,1)
  else if sceneProgress=12 and bWaitForInput=false
    msgCreate(0,0,"Jerry","That's not even possible.",0,3,oMessageCutscene,1)
  else if sceneProgress=13 and bWaitForInput=false
    msgCreate(0,0,"Hex","Tell them, Jeremy. You made this all happen.",0,3,oMessageCutscene,1)
  else if sceneProgress=14 and bWaitForInput=false
    msgCreate(0,0,"Jerry","That's a damn lie! Jeremy wouldn't make the Virus! That doesn't even make any sense!",0,3,oMessageCutscene,1)
  else if sceneProgress=15 and bWaitForInput=false
    msgCreate(0,0,"Hex","Just come forth, why hide it any longer?#TELL THEM!!",0,3,oMessageCutscene,1)
  else if sceneProgress=16 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Jeremy...?",0,3,oMessageCutscene,1)
  else if sceneProgress=17 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","...",0,3,oMessageCutscene,1)
  else if sceneProgress=18 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Look you guys... Yes, I did do it, but I can explain...",0,3,oMessageCutscene,1)
  else if sceneProgress=19
  {
    sceneDelay+=1
    if sceneDelay=1
    {
      stopAllMusic()
      playSound(global.snd_HardHit1,0,1,1)
      playSound(global.snd_Slam,0,0.82,35000)
      fadeAlpha=0.8
    }
    else if sceneDelay=30
    {
      playSound(global.snd_HardHit1,0,1,1)
      playSound(global.snd_Slam,0,0.88,30000)
      fadeAlpha=1
      global.charScan[0]=0; global.charScan[1]=0
      oIdentifier.bCanScan=0; oIdentifier.bChaoActive=0
      global.optShowHUD+=2
    }
    else if sceneDelay>=70 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=20
  {
    playSound(global.snd_HardHit1,0,1,1)
    playSound(global.snd_Slam,0,1,1)
    rmLight=instance_create(0,0,oSurfLightC)
    with (312590) {instance_destroy()}
    global.activeAbility[0]=0; global.activeAbility[1]=0
    global.hasShoes[2]=1; global.hasShoes[3]=1
    for(i=0;i<5;i+=1) {global.hasAbilToken[i]=1}
    var tempMplay;
    tempMplay=findMusic(1004)
    playMusic(tempMplay,0,0)
    fadeColor=make_color_rgb(130,0,0)
    fadeAlpha=0.15
    sceneProgress+=1
  }
  else if sceneProgress=21
  {
    sceneDelay+=1
    if sceneDelay=1 {global.gamePaused=true}
    else if sceneDelay>=45 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=22 and bWaitForInput=false
    msgCreate(0,0,"Jerry","What... just happened?",0,3,oMessageCutscene,1)
  else if sceneProgress=23 and bWaitForInput=false
    msgCreate(0,0,"Claire","I think we lost contact with Jeremy.",0,3,oMessageCutscene,1)
  else if sceneProgress=24 and bWaitForInput=false
    msgCreate(0,0,"Jerry","That and... what?",0,3,oMessageCutscene,1)
  else if sceneProgress=25 and bWaitForInput=false
    msgCreate(0,0,"Claire","I don't know, but Chao is gone too.",0,3,oMessageCutscene,1)
  else if sceneProgress=26 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Okay, why didn't Jeremy just tell us about the Virus?",0,3,oMessageCutscene,1)
  else if sceneProgress=27 and bWaitForInput=false
    msgCreate(0,0,"Claire","Jerry, this isn't a good time for that. We don't know where to go and this weird... lights thing happened.",0,3,oMessageCutscene,1)
  else if sceneProgress=28 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Okay, but Jeremy needs to figure out how to get back in contact with us, cause this is silly.",0,3,oMessageCutscene,1)
  else if sceneProgress=29
  {
    sceneDelay=0; sceneProgress=0
    global.gameProgress=3240
    global.gamePaused=false
  }
}
else if global.gameProgress=3250 and room=rNGC_LC_E //----- [11] Onward -----
{
  if sceneProgress=0
  {
    sceneDelay+=1
    if sceneDelay=1 {global.gamePaused=true}
    else if sceneDelay>=30 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=1 and bWaitForInput=false
    msgCreate(0,0,"Claire","I think we're out of that mess.",0,3,oMessageCutscene,1)
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Except we don't know where we are or where to go.",0,3,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Claire","I'm willing to bet Jeremy laid out the way for us.",0,3,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Jerry","What about Chao?",0,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Claire","I think if Jeremy can get through again, he should be able to find her.",0,3,oMessageCutscene,1)
  else if sceneProgress=6 and bWaitForInput=false
    msgCreate(0,0,"Jerry","How are you so calm, Claire?",0,3,oMessageCutscene,1)
  else if sceneProgress=7 and bWaitForInput=false
    msgCreate(0,0,"Claire","I'm not, we just have to pull through this.",0,3,oMessageCutscene,1)
  else if sceneProgress=8 and bWaitForInput=false
    msgCreate(0,0,"Jerry","You're right about that.",0,3,oMessageCutscene,1)
  else if sceneProgress=9 and bWaitForInput=false
    msgCreate(0,0,"Claire","I just realized our abilities are still blocked.",0,3,oMessageCutscene,1)
  else if sceneProgress=10 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Ugh, I wish I knew more about how this program worked.",0,3,oMessageCutscene,1)
  else if sceneProgress=11 and bWaitForInput=false
    msgCreate(0,0,"Claire","Yeah... let's just keep going and see if we can at least find the Engineer.",0,3,oMessageCutscene,1)
  else if sceneProgress=12
  {
    global.pLife=global.pMaxLife
    oPlayer1.life=oPlayer1.maxLife
    sceneDelay=0; sceneProgress=0
    global.gameProgress=3260
    global.gamePaused=false
  }
}
else if global.gameProgress=3260 and room=rNGC_LC_F //----- [12] Boss: Malevolence -----
{
  if global.bossTrack=0
  {
    if global.gamePaused=false
    {
      if sceneProgress=0
      {
        if oPlayer1.y>=1342
        {
          stopAllMusic()
          sceneProgress+=1
        }
      }
      else if sceneProgress=1
      {
        sceneDelay+=1
        if sceneDelay=45
        {
          var tempMplay;
          tempMplay=findMusic(813)
          playMusic(tempMplay,0,0)
          boss=instance_create(240,room_height+112,oMalevolence)
          boss.image_alpha=0
        }
        else if sceneDelay>=46
        {
          var tEffect;
          for(i=0;i<8;i+=1)
          {
            tEffect=instance_create(112+random(256),1344+random(16),oEffect)
            tEffect.sprite_index=sMMSmokeCloud; tEffect.image_speed=0.1+random(0.1); tEffect.image_alpha=0.6; tEffect.depth=9
            tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=-0.5-random(1)
          }
          boss.y-=2
          boss.image_alpha+=0.01
          if boss.y<=1264
          {
            boss.y=1264
            sceneDelay=0; sceneProgress+=1
          }
        }
      }
      else if sceneProgress=2
      {
        sceneDelay+=1
        if sceneDelay>=40 {sceneDelay=0; sceneProgress+=1}
      }
      else if sceneProgress=3
      {
        with oMalevolence {instance_destroy()}
        var tempMplay,tBossTitle,boss;
        tempMplay=findMusic(813)
        playMusic(tempMplay,0,0)
        tBossTitle=instance_create(0,0,oBossNameDisplay)
        tBossTitle.bossName="Malevolence"
        tBossTitle.bossTitle="Intentionally Infected Bot"
        boss=instance_create(240,1264,oMalevolence)
        boss.activateBoss=1
        global.currentBoss="Malevolence"
        global.bossTrack=1
        global.gamePaused=false
        global.pLife=global.pMaxLife
        oPlayer1.life=oPlayer1.maxLife
        sceneDelay=0; sceneProgress=0
      }
    }
  }
  else if global.bossTrack=1
  {
    if global.gamePaused=false
    {
      if sceneProgress=0
      {
        sceneDelay+=1
        if sceneDelay=300
        {
          createScreenText(70,48,130,fnt_ScreenText,fa_left,"Hold out just a little longer,#I've almost gotten through.",3,c_white,1,0)
        }
        else if sceneDelay=510
        {
          createScreenText(70,48,70,fnt_ScreenText,fa_left,"Almost there...",3,c_white,1,0)
        }
        else if sceneDelay=630
        {
          createScreenText(70,48,130,fnt_ScreenText,fa_left,"And got it! You should have#your abilities back soon!",3,c_white,1,0)
        }
        else if sceneDelay=780
        {
          var tFlash;
          tFlash=instance_create(0,0,oScreenFlash)
          tFlash.image_alpha=0.5 tFlash.fadeSpeed=0.1
          abilSetRemove(0)
          global.activeAbility[0]=1; global.activeAbility[1]=1
          global.charScan[0]=1; global.charScan[1]=1
          oIdentifier.bCanScan=1; oIdentifier.bChaoActive=1
          global.optShowHUD-=2
          global.pLife=global.pMaxLife
          oPlayer1.life=oPlayer1.maxLife
          global.hudLink_Arrows[0]=global.hudLink_Arrows[1]
          global.hudBelmont_WeaponEn[0]=global.hudBelmont_WeaponEn[1]
          global.hudSamus_Missiles[0]=global.hudSamus_Missiles[1]
          instance_create(0,0,oCheckpointNotice)
          global.bossTrack=2
          sceneDelay=0; sceneProgress=0
        }
      }
    }
  }
  else if global.bossTrack=2
  {
    if !instance_exists(oMalevolence) and sceneProgress=0 //End Boss
    {
      global.gamePaused=true
      awardBossAP(6500)
      stopAllMusic()
      global.bossTrack=3
    }
  }
  else if global.bossTrack=3
  {
    if sceneProgress=0
    {
      if fadeAlpha<1 {fadeAlpha+=0.05}
      else if fadeAlpha>=1 {sceneProgress+=1}
    }
    else if sceneProgress=1
    {
      sceneDelay+=1
      if sceneDelay=1
      {
        endBoss()
        scenePChk(240,1344,0,0.1,1)
      }
      if sceneDelay>=60
      {
        sceneDelay=0
        sceneProgress+=1
      }
    }
    else if sceneProgress=2
    {
      if fadeAlpha>0 {fadeAlpha-=0.05}
      else if fadeAlpha<=0 {sceneProgress+=1}
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
      msgCreate(0,0,"Jerry","That was kind of easy... sorta.",0,3,oMessageCutscene,1)
    else if sceneProgress=5 and bWaitForInput=false
      msgCreate(0,0,"Claire","Yeah it was.",0,3,oMessageCutscene,1)
    else if sceneProgress=6 and bWaitForInput=false
      msgCreate(0,0,"Chao","So glad you two can see me again!",0,3,oMessageCutscene,1)
    else if sceneProgress=7 and bWaitForInput=false
      msgCreate(0,0,"Claire","What happened?",0,3,oMessageCutscene,1)
    else if sceneProgress=8 and bWaitForInput=false
      msgCreate(0,0,"Chao","I was still with you, but you couldn't see me and I couldn't make any sort of contact.",0,3,oMessageCutscene,1)
    else if sceneProgress=9 and bWaitForInput=false
      msgCreate(0,0,"Jerry","...",0,3,oMessageCutscene,1)
    else if sceneProgress=10 and bWaitForInput=false
      msgCreate(0,0,"Claire","What's wrong, Jerry?",0,3,oMessageCutscene,1)
    else if sceneProgress=11 and bWaitForInput=false
      msgCreate(0,0,"Jerry","You know what's wrong! Why didn't you just tell us about the Virus, Jeremy?",0,3,oMessageCutscene,1)
    else if sceneProgress=12 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","What would I even say? Look guys, I made this thing that's about to end the world. Really great place that puts me.",0,3,oMessageCutscene,1)
    else if sceneProgress=13 and bWaitForInput=false
      msgCreate(0,0,"Jerry","I'd have been a little weirded out, but at least not super pissed off! We've been friends like... forever! Why would you even make that thing?!",0,3,oMessageCutscene,1)
    else if sceneProgress=14 and bWaitForInput=false
      msgCreate(0,0,"Claire","Jerry, I'm sure there's a good reason.",0,3,oMessageCutscene,1)
    else if sceneProgress=15 and bWaitForInput=false
      msgCreate(0,0,"Jerry","Why are you so calm, Claire? This could have helped us!",0,3,oMessageCutscene,1)
    else if sceneProgress=16 and bWaitForInput=false
      msgCreate(0,0,"Claire","I'm not calm, I already said that! I just know Jeremy has his reasons. You should know that!",0,3,oMessageCutscene,1)
    else if sceneProgress=17 and bWaitForInput=false
      msgCreate(0,0,"Jerry","Usually you're the one pissed about these things... Whatever, I just want to know why.",0,3,oMessageCutscene,1)
    else if sceneProgress=18 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","It was wrong of me to keep that from you guys, and I'm really sorry. I didn't even know it was my virus at first. Not till you guys got into that Mario Gate. I had my suspicions, but they were confirmed there.",0,3,oMessageCutscene,1)
    else if sceneProgress=19 and bWaitForInput=false
      msgCreate(0,0,"Jerry","Huh? What do you mean?",0,3,oMessageCutscene,1)
    else if sceneProgress=20 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","When we figured out that we were in a computer simulation, I started to make it. I was already getting familiar with how everything worked. Just another benefit of being where I was.",0,3,oMessageCutscene,1)
    else if sceneProgress=21 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","I set up the Virus to be covert and take down important parts of the program. I figured if the program was forced to shut down, we would all be freed. When the Engineer told us the truth about the program, I stored it in the Vault.",0,3,oMessageCutscene,1)
    else if sceneProgress=22 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","I didn't outright delete the Virus since I wasn't completely sure that the program and the Engineer were telling the truth. I wanted to keep it as backup in case we couldn't make an agreement with the program.",0,3,oMessageCutscene,1)
    else if sceneProgress=23 and bWaitForInput=false
      msgCreate(0,0,"Jerry","Huh... hold up! So that's how Hex got a hold of it.",0,3,oMessageCutscene,1)
    else if sceneProgress=24 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","Yes, he must have known about it somehow. Maybe he could see the contents of the Vault back when things were properly running. I don't know exactly how, but he pulled it out of there. I know he modified it too. This Virus is different.",0,3,oMessageCutscene,1)
    else if sceneProgress=25 and bWaitForInput=false
      msgCreate(0,0,"Jerry","So that's how you knew about the Program Chips... but hold up. Did you make those too? Why would you make a backup to the backup?",0,3,oMessageCutscene,1)
    else if sceneProgress=26 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","I didn't make those. The program made them for us.",0,3,oMessageCutscene,1)
    else if sceneProgress=27 and bWaitForInput=false
      msgCreate(0,0,"Jerry","Okay, now I'm super confused. Like, WHAT?!",0,3,oMessageCutscene,1)
    else if sceneProgress=28 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","I'll let the Engineer explain that one. I bet he knows more about that than I would. I'd explain it to you now, but we've got those Stalker things coming.",0,3,oMessageCutscene,1)
    else if sceneProgress=29 and bWaitForInput=false
      msgCreate(0,0,"Jerry","You mean those annoying things in the dark earlier?",0,3,oMessageCutscene,1)
    else if sceneProgress=30 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","Yeah. I think CHAOS made those things. Which... that would mean bots can make other bots... But that's not important, you just don't want to be around when they show up again.",0,3,oMessageCutscene,1)
    else if sceneProgress=31 and bWaitForInput=false
      msgCreate(0,0,"Jerry","Okay, lead the way... And by the way, I'm still kinda pissed at you.",0,3,oMessageCutscene,1)
    else if sceneProgress=32 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","Fair enough. We're pretty close now.",0,3,oMessageCutscene,1)
    else if sceneProgress=33
    {
      var tFullHeartDrop,tempMplay,tEffect;
      tFullHeartDrop=instance_create(1168,96,oHealthPickup)
      tFullHeartDrop.sprite_index=sFullHealthPickup
      tempMplay=findMusic(16)
      playMusic(tempMplay,0,0)
      tEffect=instance_create(448,1312,oEffect)
      tEffect.sprite_index=sShipExplosion; tEffect.image_speed=0.25
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=-0.5-random(1)
      tile_layer_hide(999990)
      with (314507) {instance_destroy()} //Destroy wall
      with (314799) {x-=16} //Move right side exit into view
      oHealingPost.y-=128
      global.gamePaused=false
      global.currentBoss=""
      global.bossTrack=0
      global.gameProgress=3270
    }
  }
}
else if global.gameProgress=3270 and room=rNGC_LC_G //----- [] Enemy Trap -----
{
  if sceneProgress=0
  {
    if oPlayer1.x>=1024
    {
      var enemyBarrier,tempMplay;
      enemyBarrier=instance_create(656,160,oEnemyBarrier); enemyBarrier.image_yscale=4
      enemyBarrier=instance_create(1376,160,oEnemyBarrier); enemyBarrier.image_yscale=4
      tempMplay=findMusic(809)
      playMusic(tempMplay,0,0)
      fadeColor=make_color_rgb(130,0,0); fadeAlpha=0.15
      sceneProgress+=1
    }
  }
  else if sceneProgress=1
  {
    if global.gamePaused=false
    {
      sceneDelay+=1
      if sceneDelay=30 {delaySpawn(880,224,oBloodTyrant,0,1,1,0.33)}
      else if sceneDelay=270 {delaySpawn(1168,224,oBloodTyrant,0,1,1,0.33)}
      else if sceneDelay=360 {sceneDelay=0; sceneProgress+=1}
    }
  }
  else if sceneProgress=2
  {
    if !instance_exists(oBloodTyrant)
    {
      var tempMplay;
      tempMplay=findMusic(16)
      playMusic(tempMplay,0,0)
      with oEnemyBarrier {instance_destroy()}
      fadeAlpha=0
      sceneProgress=0
      global.gameProgress=3280
    }
  }
}
else if global.gameProgress=3280 and room=rNGC_LC_H //----- [] Enemy Trap -----
{
  if sceneProgress=0
  {
    if oPlayer1.x>=464
    {
      var enemyBarrier,tempMplay;
      enemyBarrier=instance_create(224,224,oEnemyBarrier); enemyBarrier.image_yscale=4
      enemyBarrier=instance_create(848,224,oEnemyBarrier); enemyBarrier.image_yscale=4
      tempMplay=findMusic(809)
      playMusic(tempMplay,0,0)
      fadeColor=make_color_rgb(130,0,0); fadeAlpha=0.15
      sceneProgress+=1
    }
  }
  else if sceneProgress=1
  {
    if global.gamePaused=false
    {
      sceneDelay+=1
      if sceneDelay=30 {delaySpawn(624,288,oBloodTyrant,0,1,1,0.33)}
      else if sceneDelay=120 {sceneDelay=0; sceneProgress+=1}
    }
  }
  else if sceneProgress=2
  {
    if !instance_exists(oBloodTyrant) {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=3
  {
    if global.gamePaused=false
    {
      sceneDelay+=1
      if sceneDelay=1 {delaySpawn(464,288,oBloodTyrant,0,1,1,0.33)}
      else if sceneDelay=90 {sceneDelay=0; sceneProgress+=1}
    }
  }
  else if sceneProgress=4
  {
    if !instance_exists(oBloodTyrant)
    {
      var tempMplay;
      tempMplay=findMusic(16)
      playMusic(tempMplay,0,0)
      with oEnemyBarrier {instance_destroy()}
      fadeAlpha=0
      sceneProgress=0
      global.gameProgress=3290
    }
  }
}
else if global.gameProgress=3290 and room=rNGC_LC_H //----- [13] Finding the Engineer (John) -----
{
  if sceneProgress=0
  {
    if oPlayer1.x>=1136
    {
      global.gamePaused=true
      oPlayer1.y+=4
      if oPlayer1.y>=288
      {
        var tFlash;
        tFlash=instance_create(0,0,oScreenFlash)
        tFlash.image_alpha=0.5 tFlash.fadeSpeed=0.1
        global.activeCharacter=0
        scenePChk(1136,288,0,0.1,1)
        stopPlayer()
        charClaire=instance_create(1104,288,oMisc)
        charClaire.sprite_index=sClaireIdle; charClaire.image_speed=0.1; charClaire.type=2
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
    msgCreate(0,0,"Jerry","Who's this guy?",0,3,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","You know who we're here to save.",0,3,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Yeah, but he doesn't look like... nevermind, I get it.",0,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Engineer","I wasn't expecting to see you guys here.",6,3,oMessageCutscene,1)
  else if sceneProgress=6 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","We're here to break you out. Your Bubble Bobble friends sent us here.",0,3,oMessageCutscene,1)
  else if sceneProgress=7 and bWaitForInput=false
    msgCreate(0,0,"Engineer","Really? This program advanced way farther than I imagined.",6,3,oMessageCutscene,1)
  else if sceneProgress=8 and bWaitForInput=false
    msgCreate(0,0,"Jerry","What do you mean? We've seen other bots display that behavior as well.",0,3,oMessageCutscene,1)
  else if sceneProgress=9 and bWaitForInput=false
    msgCreate(0,0,"Engineer","It's different with those two. They've displayed emotions with...",6,3,oMessageCutscene,1)
  else if sceneProgress=10 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Not to be rude, but we need to get you out of this place quickly. There's some things down here in pursuit.",0,3,oMessageCutscene,1)
  else if sceneProgress=11 and bWaitForInput=false
    msgCreate(0,0,"Engineer","The Stalkers? I know of them.",6,3,oMessageCutscene,1)
  else if sceneProgress=12 and bWaitForInput=false
    msgCreate(0,0,"Jerry","What were you even doing here, and more importantly, why the appearance change?",0,3,oMessageCutscene,1)
  else if sceneProgress=13 and bWaitForInput=false
    msgCreate(0,0,"Engineer","I happen to like this character, and... my name is John.",6,3,oMessageCutscene,1)
  else if sceneProgress=14 and bWaitForInput=false
    msgCreate(0,0,"John","And those Stalkers are part of the reason I'm down here. CHAOS has been developing quite a few deadly bots here. I came to shut it all down.",6,3,oMessageCutscene,1)
  else if sceneProgress=15 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","How so?",0,3,oMessageCutscene,1)
  else if sceneProgress=16 and bWaitForInput=false
    msgCreate(0,0,"John","How else? Blow it up.",6,3,oMessageCutscene,1)
  else if sceneProgress=17 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Straight forward and effective I guess.",0,3,oMessageCutscene,1)
  else if sceneProgress=18 and bWaitForInput=false
    msgCreate(0,0,"John","It was a wasted effort though.",6,3,oMessageCutscene,1)
  else if sceneProgress=19 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Why, what happened here?",0,3,oMessageCutscene,1)
  else if sceneProgress=20 and bWaitForInput=false
    msgCreate(0,0,"John","Even if I were to escape now, my explosives were taken, and there's no getting those back. That doesn't matter either. Destroying this place would be meaningless now.",6,3,oMessageCutscene,1)
  else if sceneProgress=21 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Meaningless? Is CHAOS moving their efforts somewhere else?",0,3,oMessageCutscene,1)
  else if sceneProgress=22 and bWaitForInput=false
    msgCreate(0,0,"John","This isn't their only facility where they're doing this sort of thing. There are others, but I don't know where they are. But it seems when they figured out I snuck into this place, they moved a lot of their operations elsewhere.",6,3,oMessageCutscene,1)
  else if sceneProgress=23 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","They really don't want anyone figuring out what they're doing, do they? But we need to have this discussion later. I need to get you out of here so you can unlock a Gate for us.",0,3,oMessageCutscene,1)
  else if sceneProgress=24 and bWaitForInput=false
    msgCreate(0,0,"John","The Access Gates, how many more of those do you have left to open?",6,3,oMessageCutscene,1)
  else if sceneProgress=25 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Just the one that you need to unlock for us, according to Bubblun anyway. I'm pretty sure the Virus is getting close to shutting down the program. We need to keep you safe and get you out of this place.",0,3,oMessageCutscene,1)
  else if sceneProgress=26 and bWaitForInput=false
    msgCreate(0,0,"John","Do you know how to get this barrier removed?",6,3,oMessageCutscene,1)
  else if sceneProgress=27 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Yeah, give me a second.",0,3,oMessageCutscene,1)
  else if sceneProgress=28
  {
    sceneDelay+=1
    if sceneDelay=35
    {
      var tFlash;
      tFlash=instance_create(0,0,oScreenFlash)
      tFlash.image_alpha=0.5 tFlash.fadeSpeed=0.1
      with oEventBarrier {instance_destroy()}
    }
    else if sceneDelay>=60 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=29 and bWaitForInput=false
    msgCreate(0,0,"John","You still know your way around this thing... and, who's the girl? I should warn you, Jerry, that dating bots isn't a good idea.",6,3,oMessageCutscene,1)
  else if sceneProgress=30 and bWaitForInput=false
    msgCreate(0,0,"Claire","Seriously!?",0,3,oMessageCutscene,1)
  else if sceneProgress=31 and bWaitForInput=false
    msgCreate(0,0,"Jerry","I like you a lot more now, John.",0,3,oMessageCutscene,1)
  else if sceneProgress=32 and bWaitForInput=false
    msgCreate(0,0,"John","Oh... my mistake.",6,3,oMessageCutscene,1)
  else if sceneProgress=33 and bWaitForInput=false
    msgCreate(0,0,"Jerry","She's a good friend of ours.",0,3,oMessageCutscene,1)
  else if sceneProgress=34 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Anyway, I'm going to send you to a safe zone for now, John. I can only keep you there for a short time. I've kept this hidden till now, so the Virus wouldn't close it out.",0,3,oMessageCutscene,1)
  else if sceneProgress=35 and bWaitForInput=false
    msgCreate(0,0,"John","I suppose I can work with that.",6,3,oMessageCutscene,1)
  else if sceneProgress=36
  {
    sceneDelay+=1
    if sceneDelay>=16 and sceneDelay<=25
    {
      oNPC_John.image_alpha-=0.1
    }
    else if sceneDelay>=40 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=37 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","You don't have much of a choice. I was going to send you anyway. For the escape route, head up back there.",0,3,oMessageCutscene,1)
  else if sceneProgress=38
  {
    var tFlash;
    tFlash=instance_create(0,0,oScreenFlash)
    tFlash.image_alpha=0.5 tFlash.fadeSpeed=0.1
    with charClaire {instance_destroy()}
    (315034).y+=80
    sceneDelay=0; sceneProgress=0
    global.gameProgress=3300
    global.gamePaused=false
  }
}
else if global.gameProgress=3310 and room=rNGC_LC_EleA //----- [14] Start the elevator ride -----
{
  if sceneProgress=0
  {
    if oPlayer1.x>=432
    {
      global.gamePaused=true
      oPlayer1.y+=4
      if oPlayer1.y>=244 {scenePChk(432,244,0,0.1,1); sceneProgress+=1}
    }
  }
  else if sceneProgress=1
  {
    sceneDelay+=1
    if sceneDelay>=20 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","This elevator will bring you to the surface, be sure you're ready. I know CHAOS is on to us by now, and starting this elevator will set off an alarm.",0,3,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Noted.",0,3,oMessageCutscene,1)
  else if sceneProgress=4
  {
    sceneDelay=0; sceneProgress=0
    global.gameProgress=3320
    global.gamePaused=false
  }
}
else if global.gameProgress=3320 and room=rNGC_Elevator //----- [] Elevator ride -----
{
  if sceneProgress=0
  {
    if global.gamePaused=false
    {
      sceneDelay+=1
      if sceneDelay=45
      {
        delaySpawn(80,228,oZakoCannonfodder,0,1,1,0.33)
        delaySpawn(160,228,oZakoCannonfodder,0,1,1,0.33)
      }
      else if sceneDelay=105
      {
        delaySpawn(320,228,oZakoCannonfodder,0,1,1,0.33)
        delaySpawn(400,228,oZakoCannonfodder,0,1,1,0.33)
      }
      else if sceneDelay=180
      {
        delaySpawn(80,228,oZakoCannonfodder,0,1,1,0.33)
        delaySpawn(400,228,oZakoCannonfodder,0,1,1,0.33)
      }
      else if sceneDelay=220
      {
        delaySpawn(128,228,oZakoCannonfodder,0,1,1,0.33)
        delaySpawn(368,228,oZakoCannonfodder,0,1,1,0.33)
      }
      else if sceneDelay=320
      {
        delaySpawn(80,228,oZakoBomber,0,1,1,0.33)
        delaySpawn(128,228,oZakoBomber,0,1,1,0.33)
        delaySpawn(160,228,oZakoBomber,0,1,1,0.33)
      }
      else if sceneDelay=430
      {
        delaySpawn(320,228,oZakoBomber,0,1,1,0.33)
        delaySpawn(368,228,oZakoBomber,0,1,1,0.33)
        delaySpawn(400,228,oZakoBomber,0,1,1,0.33)
      }
      else if sceneDelay=540
      {
        delaySpawn(80,228,oZakoSoldier,0,1,1,0.33)
        delaySpawn(400,228,oZakoSoldier,0,1,1,0.33)
      }
      else if sceneDelay=750
      {
        delaySpawn(80,228,oZakoBomber,0,1,1,0.33)
        delaySpawn(128,228,oZakoSoldier,0,1,1,0.33)
        delaySpawn(160,228,oZakoCannonfodder,0,1,1,0.33)
      }
      else if sceneDelay=840
      {
        delaySpawn(400,228,oZakoBomber,0,1,1,0.33)
        delaySpawn(368,228,oZakoSoldier,0,1,1,0.33)
        delaySpawn(320,228,oZakoCannonfodder,0,1,1,0.33)
      }
      else if sceneDelay=980
      {
        delaySpawn(80,228,oZakoBomber,0,1,1,0.33)
        delaySpawn(400,228,oZakoBomber,0,1,1,0.33)
      }
      else if sceneDelay=1150
      {
        delaySpawn(160,228,oZakoSoldier,0,1,1,0.33)
        delaySpawn(320,228,oZakoSoldier,0,1,1,0.33)
      }
      else if sceneDelay=1230
      {
        delaySpawn(128,228,oZakoBomber,0,1,1,0.33)
        delaySpawn(368,228,oZakoBomber,0,1,1,0.33)
      }
      else if sceneDelay=1360
      {
        delaySpawn(80,228,oZakoBomber,0,1,1,0.33)
        delaySpawn(160,228,oZakoBomber,0,1,1,0.33)
        delaySpawn(320,228,oZakoBomber,0,1,1,0.33)
        delaySpawn(400,228,oZakoBomber,0,1,1,0.33)
      }
      else if sceneDelay=1550 {delaySpawn(-48,32,oB2SpiritPlane,0,1,1,0.33)}
      else if sceneDelay=1630 {delaySpawn(room_width+48,32,oB2SpiritPlane,0,1,1,0.33)}
      else if sceneDelay=1700
      {
        delaySpawn(48,32,oBikeSoldier,0,1,1,0.33)
        delaySpawn(room_width-48,32,oBikeSoldier,0,1,1,0.33)
      }
      else if sceneDelay=1790 {delaySpawn(240,56,oFlyingGMWonderbird,0,1,1,0.33)}
      else if sceneDelay>=1880
      {
        if !instance_exists(oEnemyBase)
        {
          sceneDelay=0; sceneProgress+=1
        }
        else {sceneDelay=1850}
      }
    }
  }
  else if sceneProgress=1
  {
    sceneDelay+=1
    if sceneDelay>=45
    {
      global.pLife=global.pMaxLife
      oPlayer1.life=oPlayer1.maxLife
      global.newMapX=96
      global.newMapY=224
      room_goto(rNGC_RB_BR)
    }
  }
}
else if global.gameProgress=3320 and room=rNGC_BR_A //----- [] Enemy Trap -----
{
  if sceneProgress=0
  {
    if oPlayer1.x>=3840
    {
      var enemyBarrier;
      enemyBarrier=instance_create(3264,0,oEnemyBarrier); enemyBarrier.image_yscale=14
      enemyBarrier=instance_create(4400,0,oEnemyBarrier); enemyBarrier.image_yscale=14
      sceneProgress+=1
    }
  }
  else if sceneProgress=1
  {
    if global.gamePaused=false
    {
      sceneDelay+=1
      if sceneDelay=30
      {
        createEnemy(3552,320,oCHAOS_Tank,0,1,1)
      }
      else if sceneDelay=120 {sceneDelay=0; sceneProgress+=1}
    }
  }
  else if sceneProgress=2
  {
    if !instance_exists(oCHAOS_Tank)
    {
      with oEnemyBarrier {instance_destroy()}
      sceneProgress=0
      global.gameProgress=3330
    }
  }
}
else if global.gameProgress=3330 and room=rNGC_BR_B //----- [15] Before the truck drive -----
{
  if sceneProgress=0
  {
    if oPlayer1.x>=80
    {
      global.gamePaused=true
      oPlayer1.y+=4
      if oPlayer1.y>=320 {scenePChk(80,320,0,0.1,1); sceneProgress+=1}
    }
  }
  else if sceneProgress=1
  {
    sceneDelay+=1
    if sceneDelay>=20 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Did you plant that there, Jeremy?",0,3,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","No, but it's good timing, cause there's a lot of those tanks coming.",0,3,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Oh hell no, I don't want to deal with that again.",0,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","When you're ready, just approach.",0,3,oMessageCutscene,1)
  else if sceneProgress=6
  {
    sceneDelay=0; sceneProgress=0
    global.gameProgress=3340
    global.gamePaused=false
  }
}
else if global.gameProgress=3340 and room=rNGC_BR_B //----- [Unskippable] Getting in truck -----
{
  if sceneProgress=0
  {
    if oPlayer1.x>=224
    {
      global.gamePaused=true
      var tFlash;
      tFlash=instance_create(0,0,oScreenFlash)
      tFlash.fadeSpeed=0.2
      stopPlayer()
      oPlayer1.x=224; oPlayer1.visible=0
      charJerry=instance_create(160,320,oMisc)
      charJerry.sprite_index=sJerryIdle; charJerry.image_speed=0.1; charJerry.type=2
      charClaire=instance_create(208,320,oMisc)
      charClaire.sprite_index=sClaireIdle; charClaire.image_speed=0.1; charClaire.type=2
      sceneProgress+=1
    }
  }
  else if sceneProgress=1
  {
    sceneDelay+=1
    if sceneDelay>=20 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"Claire","I'm driving.",0,3,oMessageCutscene,1)
  else if sceneProgress=3
  {
    sceneDelay+=1
    if sceneDelay=5 {charClaire.sprite_index=sClaireWalk; charClaire.image_speed=0.5}
    else if sceneDelay>=6 and sceneDelay<=14 {charClaire.x+=6}
    else if sceneDelay>=15
    {
      charClaire.sprite_index=sClaireIdle; charClaire.image_speed=0.1
      sceneDelay=0; sceneProgress+=1
    }
  }
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Really?",0,3,oMessageCutscene,1)
  else if sceneProgress=5
  {
    sceneDelay+=1
    if sceneDelay=25 {charClaire.image_xscale=-1}
    else if sceneDelay>=40 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=6 and bWaitForInput=false
    msgCreate(0,0,"Claire","No, Jerry. You're not driving. Get to the gunner seat. It's how we always played.",0,3,oMessageCutscene,1)
  else if sceneProgress=7 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Wow... You're right! We totally played like that! Let's do this!",0,3,oMessageCutscene,1)
  else if sceneProgress=8
  {
    jerryTime+=1
    if jerryTime=5 {charJerry.sprite_index=sJerryWalk; charJerry.image_speed=0.5}
    else if jerryTime>=6 and jerryTime<=20 {charJerry.x+=6}
    else if jerryTime=21 {charJerry.sprite_index=sJerryJump}
    else if jerryTime>=22 and jerryTime<=99
    {
      charJerry.y+=jerryY
      jerryY+=0.33
      if jerryY>=4.5 {jerryTime=100}
    }
    else if jerryTime=101 {charJerry.y=290; charJerry.sprite_index=sJerryOnTruck; charJerry.depth=101}
    
    claireTime+=1
    if claireTime=5 {charClaire.sprite_index=sClaireWalk; charClaire.image_xscale=1; charClaire.image_speed=0.5}
    else if claireTime>=6 and claireTime<=12 {charClaire.x+=6}
    else if claireTime=13 {charClaire.sprite_index=sClaireJump}
    else if claireTime>=14 and claireTime<=99
    {
      charClaire.y+=claireY
      claireY+=0.33
      if claireY>=4.5 {claireTime=100}
    }
    else if claireTime=101 {charClaire.y=290; charClaire.sprite_index=sClaireCasting; charClaire.image_speed=0; charClaire.depth=101}
    
    if jerryTime>=101 and claireTime>=101
    {
      var tempMplay;
      tempMplay=findMusic(17)
      playMusic(tempMplay,0,0)
      sceneProgress+=1
    }
  }
  else if sceneProgress=9
  {
    sceneDelay+=1
    if sceneDelay>=30
    {
      if truckSpd<8 {truckSpd+=0.5}
      oLevelDecal.x+=truckSpd
      charJerry.x+=truckSpd
      charClaire.x+=truckSpd
      if oLevelDecal.x>=576
      {
        global.pLife=global.pMaxLife
        oPlayer1.life=oPlayer1.maxLife
        global.newMapX=128
        global.newMapY=320
        room_goto(rNGC_RoadRage)
      }
    }
  }
}
else if global.gameProgress=3360 and room=rMain_56 //----- [16] The Engineer is back -----
{
  if sceneProgress=0
  {
    sceneDelay+=1
    if sceneDelay=1
    {
      playSound(global.snd_BombExplode,0,0.97,1)
      playSound(global.snd_HardHit1,0,0.99,1)
      playSound(global.snd_HolyWater,0,0.95,1)
      global.gamePaused=true
      stopAllMusic()
      oNPC_John.image_alpha=0; oNPC_John.x=640; oNPC_John.y=208; oNPC_John.image_xscale=-1
      oPlayer1.sprite_index=sJerryLayDown; oPlayer1.image_speed=0;
      (308182).image_xscale=-1; (308182).x=560; (308182).y=224;
      (308183).image_xscale=-1; (308183).x=592; (308183).y=224;
    }
    else if sceneDelay>=35
    {
      if fadeAlpha>0 {fadeAlpha-=0.02}
      else if fadeAlpha<=0 {sceneDelay=0; sceneProgress+=1}
    }
  }
  else if sceneProgress=1
  {
    sceneDelay+=1
    if sceneDelay=55 {oPlayer1.sprite_index=sJerryGetUp}
    else if sceneDelay=60 {oPlayer1.image_index=1}
    else if sceneDelay=65 {oPlayer1.image_index=2}
    else if sceneDelay=70 {oPlayer1.image_index=3}
    else if sceneDelay=75 {oPlayer1.sprite_index=sJerryIdle; oPlayer1.image_speed=0.1}
    else if sceneDelay>=95 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Did you really have to ramp into that building and boost out of the window like that?",0,3,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Claire","It got us out of the city, didn't it?",0,3,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Good point.",0,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Bubblun","You're back... did you find him?",6,3,oMessageCutscene,1)
  else if sceneProgress=6 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Hold up, I can answer that.",0,3,oMessageCutscene,1)
  else if sceneProgress=7
  {
    sceneDelay+=1
    if sceneDelay>=21 and sceneDelay<=30 {oNPC_John.image_alpha+=0.1}
    else if sceneDelay=50 {(308182).image_xscale=1; (308183).image_xscale=1}
    else if sceneDelay=55
    {
      showEmote((308182).id,0,-26,sEmExcite)
      showEmote((308183).id,0,-26,sEmExcite)
    }
    else if sceneDelay>=75 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=8 and bWaitForInput=false
    msgCreate(0,0,"Lovelun","John's back!",6,3,oMessageCutscene,1)
  else if sceneProgress=9 and bWaitForInput=false
    msgCreate(0,0,"John","Hey, sorry I worried you so much.",6,3,oMessageCutscene,1)
  else if sceneProgress=10 and bWaitForInput=false
    msgCreate(0,0,"Bubblun","Why would you do that?! You knew CHAOS had control of that city!",6,3,oMessageCutscene,1)
  else if sceneProgress=11 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Oh, so it's not just us he's always mad at.",0,3,oMessageCutscene,1)
  else if sceneProgress=12 and bWaitForInput=false
    msgCreate(0,0,"John","I'll tell you all about what I was doing, but first...",6,3,oMessageCutscene,1)
  else if sceneProgress=13
  {
    sceneDelay+=1
    if sceneDelay=20 {(308182).image_xscale=-1; (308183).image_xscale=-1}
    else if sceneDelay>=40 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=14 and bWaitForInput=false
    msgCreate(0,0,"John","You guys need to get into the Gate in this area.",6,3,oMessageCutscene,1)
  else if sceneProgress=15 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Would be much appreciated.",0,3,oMessageCutscene,1)
  else if sceneProgress=16 and bWaitForInput=false
    msgCreate(0,0,"John","The doorway leading to it is on a small island behind us. It was shrouded till now.",6,3,oMessageCutscene,1)
  else if sceneProgress=17 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","You can do that?",0,3,oMessageCutscene,1)
  else if sceneProgress=18 and bWaitForInput=false
    msgCreate(0,0,"John","For that place, sure. I don't know why or how one of those Program Chips managed to get in there, but it's there apparently.",6,3,oMessageCutscene,1)
  else if sceneProgress=19 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Do you know what's in that Gate?",0,3,oMessageCutscene,1)
  else if sceneProgress=20 and bWaitForInput=false
    msgCreate(0,0,"John","I do. It was one of the first scenarios we made for the program. Used primarily for our QA team to work out the kinks in our dynamic systems.",6,3,oMessageCutscene,1)
  else if sceneProgress=21 and bWaitForInput=false
    msgCreate(0,0,"Jerry","So basically...",0,3,oMessageCutscene,1)
  else if sceneProgress=22 and bWaitForInput=false
    msgCreate(0,0,"John","It's a prototype game within this program. It was unfinished though.",6,3,oMessageCutscene,1)
  else if sceneProgress=23 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Do you know where the Chip might be in there, or better yet, how to get it to show up?",0,3,oMessageCutscene,1)
  else if sceneProgress=24 and bWaitForInput=false
    msgCreate(0,0,"John","You probably need to beat what's available of the prototype.",6,3,oMessageCutscene,1)
  else if sceneProgress=25 and bWaitForInput=false
    msgCreate(0,0,"Jerry","How does that even work? Hold up, Jeremy, you said you would explain that more. I'm still confused how the program made those Chips.",0,3,oMessageCutscene,1)
  else if sceneProgress=26 and bWaitForInput=false
    msgCreate(0,0,"John","So you figured out that part of the system, Jeremy?",6,3,oMessageCutscene,1)
  else if sceneProgress=27 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Yes, but I think you can explain it better.",0,3,oMessageCutscene,1)
  else if sceneProgress=28 and bWaitForInput=false
    msgCreate(0,0,"John","It's simple. In any given situation, the program always has to provide a way to win. Even if that method is near impossible, there will always be one.",6,3,oMessageCutscene,1)
  else if sceneProgress=29 and bWaitForInput=false
    msgCreate(0,0,"John","Since the end goal was to provide dynamic procedurally generated scenarios, there must always be a way to win.",6,3,oMessageCutscene,1)
  else if sceneProgress=30 and bWaitForInput=false
    msgCreate(0,0,"John","It is possible to take that part of the program down, which I know the Virus is certainly gunning for. It's easier to remove that function than bring down world stability.",6,3,oMessageCutscene,1)
  else if sceneProgress=31 and bWaitForInput=false
    msgCreate(0,0,"John","With that system, it detected the Virus to not just be a threat, because the Virus became an entity within this as well. The program responded by doing what it does best. Making a game out of it.",6,3,oMessageCutscene,1)
  else if sceneProgress=32 and bWaitForInput=false
    msgCreate(0,0,"John","Of course it's a bit uh... simple. It created your standard item collection quest. This is why being great gamers like yourselves has given you so many benefits here.",6,3,oMessageCutscene,1)
  else if sceneProgress=33 and bWaitForInput=false
    msgCreate(0,0,"John","You're essentially just playing the program's game. Whether it wants you to or not.",6,3,oMessageCutscene,1)
  else if sceneProgress=34 and bWaitForInput=false
    msgCreate(0,0,"Jerry","So, I get that the Virus isn't able to mess with the Chips in those Gates, but why does everything have to be so difficult?",0,3,oMessageCutscene,1)
  else if sceneProgress=35 and bWaitForInput=false
    msgCreate(0,0,"John","With the Virus screwing things up, I don't really know what to tell you. It tries to tailor the experience to the user, last I checked. The problem with that now is we have all these free thinking bots.",6,3,oMessageCutscene,1)
  else if sceneProgress=36 and bWaitForInput=false
    msgCreate(0,0,"John","The program can't control the bots anymore. Bots like those within CHAOS aren't something it can simply factor into that anymore.",6,3,oMessageCutscene,1)
  else if sceneProgress=37 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Hex doesn't make things any easier either.",0,3,oMessageCutscene,1)
  else if sceneProgress=38 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Things would have been easier had you told us you made the Virus.",0,3,oMessageCutscene,1)
  else if sceneProgress=39 and bWaitForInput=false
    msgCreate(0,0,"John","Hold up, you made that thing? How?! I think I can understand why you did, but how were you able to write that within this?",6,3,oMessageCutscene,1)
  else if sceneProgress=40 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","My unique position allowed me to do quite a lot. I was a menace to the program, so much so that it had to create Hex to counteract me whenever possible.",0,3,oMessageCutscene,1)
  else if sceneProgress=41 and bWaitForInput=false
    msgCreate(0,0,"John","Speaking of that bot. It seems hellbent on destroying this program.",6,3,oMessageCutscene,1)
  else if sceneProgress=42 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","You've met him?",0,3,oMessageCutscene,1)
  else if sceneProgress=43 and bWaitForInput=false
    msgCreate(0,0,"John","Yes, Hex was there when I was captured by CHAOS. He was talking to the Warmaster about some backup plan.",6,3,oMessageCutscene,1)
  else if sceneProgress=44 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Did you overhear any of it?",0,3,oMessageCutscene,1)
  else if sceneProgress=45 and bWaitForInput=false
    msgCreate(0,0,"John","Something about a large warship. That's all I know. Unfortunately I don't know anything about a warship added into the program.",6,3,oMessageCutscene,1)
  else if sceneProgress=46 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Damn, was hoping for more.",0,3,oMessageCutscene,1)
  else if sceneProgress=47 and bWaitForInput=false
    msgCreate(0,0,"John","Well, you guys should get a move on. The three of us will see if we can figure out what's going on between Hex and CHAOS.",6,3,oMessageCutscene,1)
  else if sceneProgress=48 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","After we take the Virus down, we'll see what we can do to help.",0,3,oMessageCutscene,1)
  else if sceneProgress=49 and bWaitForInput=false
    msgCreate(0,0,"John","Good luck in that place.",6,3,oMessageCutscene,1)
  else if sceneProgress=50
  {
    sceneDelay=0; sceneProgress=0
    abilSetRemove(0)
    global.optShowDamage-=2
    global.optEnemyHP-=2
    oNPC_John.image_alpha=1
    global.gameProgress=3370
    global.gamePaused=false
  }
}
else if global.gameProgress=3370 and room=rMain_56Gate //----- [17] The Final Gate -----
{
  if sceneProgress=0
  {
    sceneDelay+=1
    if sceneDelay=1 {global.gamePaused=true}
    else if sceneDelay>=35 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=1 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Okay, you guys ready?",0,3,oMessageCutscene,1)
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"Claire","As ready as we'll ever be.",0,3,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Chao","Hey you guys, John mentioned a 'Warmaster'. Any idea who that was?",0,3,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Not at all, but we'll ask John about it when we come back.",0,3,oMessageCutscene,1)
  else if sceneProgress=5
  {
    sceneDelay=0; sceneProgress=0
    global.gameProgress=3380
    global.gamePaused=false
  }
}
else if global.gameProgress=3390 and room=rMain_56Gate //----- [Unskippable] Access Gate 6 -----
{
  if sceneProgress=0
  {
    sceneDelay+=1
    if sceneDelay>=1
    {
      if sceneDelay=1 {global.gamePaused=true}
      fadeAlpha+=0.04
      if fadeAlpha>=1
      {
        sceneDelay=0
        sceneProgress+=1
      }
    }
  }
  else if sceneProgress=1
  {
    oPlayer1.life=oPlayer1.maxLife
    global.recAreaTrans+=1
    global.newMapX=480
    global.newMapY=272
    writeToPlayerGlobals()
    stopAllMusic()
    transition_steps=1
    transition_kind=0
    room_goto(rGame6_WhisperWoodsA)
  }
}

if global.gameOptDT=2 and room=rDesertedTowerD //----- [EX1] Boss: Sand Crawler -----
{
  if global.bossTrack=0
  {
    if sceneProgress=0
    {
      if oPlayer1.y>=624
      {
        scenePChk(oPlayer1.x,oPlayer1.y,1,0.1,1)
        global.gamePaused=true
        oPlayer1.y+=12
        if oPlayer1.y>=784
        {
          scenePChk(oPlayer1.x,784,0,0.1,1)
          stopAllMusic()
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
    else if sceneProgress=2
    {
      sceneDelay+=1
      if sceneDelay>=1 and sceneDelay<=40
      {
        var tEffect;
        for(i=0;i<8;i+=1)
        {
          tEffect=instance_create(random(208),896+random(32),oEffect)
          tEffect.sprite_index=sMMSmokeCloud; tEffect.image_speed=0.1+random(0.2); tEffect.image_alpha=0.6; tEffect.depth=9
          tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=-0.5-random(1); tEffect.image_blend=c_orange
          tEffect=instance_create(208+random(224),864+random(32),oEffect)
          tEffect.sprite_index=sMMSmokeCloud; tEffect.image_speed=0.1+random(0.2); tEffect.image_alpha=0.6; tEffect.depth=9
          tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=-0.5-random(1); tEffect.image_blend=c_orange
          tEffect=instance_create(432+random(208),896+random(32),oEffect)
          tEffect.sprite_index=sMMSmokeCloud; tEffect.image_speed=0.1+random(0.2); tEffect.image_alpha=0.6; tEffect.depth=9
          tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=-0.5-random(1); tEffect.image_blend=c_orange
        }
      }
      else if sceneDelay>=55 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=3 and bWaitForInput=false
      msgCreate(0,0,"Claire","Is that what I think it is?",0,3,oMessageCutscene,1)
    else if sceneProgress=4 and bWaitForInput=false
      msgCreate(0,0,"Chao","It's that thing again.",0,3,oMessageCutscene,1)
    else if sceneProgress=5 and bWaitForInput=false
      msgCreate(0,0,"Claire","It never leaves us alone!",0,3,oMessageCutscene,1)
    else if sceneProgress=6 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","I'm pretty tired of it too. I've been working on a way to make it vulnerable, but haven't been able to. However, in this place, you can hurt him. I think its insta-kill is still active... or it was until I fixed that problem.",0,3,oMessageCutscene,1)
    else if sceneProgress=7 and bWaitForInput=false
      msgCreate(0,0,"Claire","So what you're saying is...",0,3,oMessageCutscene,1)
    else if sceneProgress=8 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","Take it out. We have a chance in here.",0,3,oMessageCutscene,1)
    else if sceneProgress=9
    {
      var tempMplay,tBossTitle,boss;
      tempMplay=findMusic(813)
      playMusic(tempMplay,0,0)
      tBossTitle=instance_create(0,0,oBossNameDisplay)
      tBossTitle.bossName="Sand Crawler"
      tBossTitle.bossTitle="Nuisance Across Sequels"
      boss=instance_create(320,room_height+128,oSandCrawlerBoss)
      boss.activateBoss=1
      global.currentBoss="Sand Crawler"
      global.bossTrack=1
      global.gamePaused=false
      storeStatus(0)
      sceneDelay=0; sceneProgress=0
    }
  }
  else if global.bossTrack=1
  {
    if sceneProgress=1
    {
      msgCreate(0,0,"Claire","YES! Done with it forever!!",0,1,oMessagePerson,0)
      newMessage.fadingTime=90
      awardBossAP(5000)
      var tFullHeartDrop,tempMplay,tNewDoor;
      tFullHeartDrop=instance_create(320,640,oHealthPickup)
      tFullHeartDrop.sprite_index=sFullHealthPickup
      tempMplay=findMusic(8)
      playMusic(tempMplay,0,0)
      global.currentBoss=""
      global.bossTrack=0
      tNewDoor=instance_create(312,752,oExit)
      tNewDoor.sprite_index=sNormalDoor; tNewDoor.bShowArrow=true; tNewDoor.exitType=0
      tNewDoor.newMapX=576; tNewDoor.newMapY=848; tNewDoor.toRoom=rDesertedTowerA
      sceneProgress=0
      global.gameOptDT=3
    }
  }
}

keyWaitForInput()

if oKeyCodes.kCodePressed[11]=1 and global.gamePaused=true and sceneProgress>=1 //Cutscene skip
{
  if !instance_exists(oPauseMenu)
  {
    if global.gameProgress=3080 and room=rMain_50 //[1]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      fadeAlpha=0; sceneDelay=0
      sceneProgress=6
    }
    else if global.gameProgress=3090 and room=rMain_51 //[2]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      fadeAlpha=0; sceneDelay=0
      sceneProgress=14
    }
    else if global.gameProgress=3100 and room=rMain_56 //[3]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      fadeAlpha=0; sceneDelay=0
      sceneProgress=29
    }
    else if global.gameProgress=3110 and room=rNGC_A //[4]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      fadeAlpha=0; sceneDelay=0
      sceneProgress=6
    }
    else if global.gameProgress=3130 and room=rNGC_B //[5]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      fadeAlpha=0; sceneDelay=0
      sceneProgress=6
    }
    else if global.gameProgress=3150 and room=rNGC_RB_A //[6]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      fadeAlpha=0; sceneDelay=0
      sceneProgress=5
    }
    else if global.gameProgress=3180 and room=rNGC_RB_EleA //[7]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      fadeAlpha=0; sceneDelay=0
      sceneProgress=3
    }
    else if global.gameProgress=3190 and room=rNGC_RB_EleA //[8]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      fadeColor=c_black
      fadeAlpha=1
      sceneDelay=40
      sceneProgress=17
    }
    else if global.gameProgress=3190 and room=rNGC_LC_A //[9]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      fadeAlpha=0; sceneDelay=0
      sceneProgress=6
    }
    else if global.gameProgress=3210 and room=rNGC_LC_B //[10]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      fadeAlpha=0; sceneDelay=0
      sceneProgress=8
    }
    else if global.gameProgress=3250 and room=rNGC_LC_E //[11]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      fadeAlpha=0; sceneDelay=0
      sceneProgress=12
    }
    else if global.gameProgress=3260 and room=rNGC_LC_F //[12]
    {
      if global.bossTrack=3
      {
        bWaitForInput=false
        with oMessageCutscene {instance_destroy()}
        fadeAlpha=0; sceneDelay=0
        sceneProgress=33
      }
    }
    else if global.gameProgress=3300 and room=rNGC_LC_H //[13]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      fadeAlpha=0; sceneDelay=0
      sceneProgress=38
    }
    else if global.gameProgress=3310 and room=rNGC_LC_EleA //[14]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      fadeAlpha=0; sceneDelay=0
      sceneProgress=4
    }
    else if global.gameProgress=3330 and room=rNGC_BR_B //[15]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      fadeAlpha=0; sceneDelay=0
      sceneProgress=6
    }
    else if global.gameProgress=3360 and room=rMain_56 //[16]
    {
      if sceneProgress>=1
      {
        bWaitForInput=false
        with oMessageCutscene {instance_destroy()}
        fadeAlpha=0; sceneDelay=0
        sceneProgress=50
      }
    }
    else if global.gameProgress=3370 and room=rMain_56Gate //[17]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      fadeAlpha=0; sceneDelay=0
      sceneProgress=5
    }
    
    if global.gameOptDT=2 and room=rDesertedTowerD //[EX1]
    {
      if global.bossTrack=0
      {
        bWaitForInput=false
        with oMessageCutscene {instance_destroy()}
        fadeAlpha=0; sceneDelay=0
        sceneProgress=9
      }
    }
  }
}

//----- Room specific events -----
if global.gamePaused=false
{
  if room=rDesertedTowerB
  {
    platformSpawn+=1
    if platformSpawn>=300
    {
      var tNewPlat;
      tNewPlat=instance_create(536,-32,oPlatformRailA)
      tNewPlat.moveSpd=4; tNewPlat.xMove=0; tNewPlat.yMove=4
      platformSpawn=0
    }
    if global.gameOptDT=0
    {
      if oPlayer1.x<=192 and oPlayer1.y>=2560 {global.gameOptDT=1}
    }
  }
  else if room=rDesertedTowerC
  {
    platformSpawn+=1
    if platformSpawn>=300
    {
      var tNewPlat;
      tNewPlat=instance_create(3640,264,oPlatformRailA)
      tNewPlat.moveSpd=2; tNewPlat.xMove=-2; tNewPlat.yMove=0
      platformSpawn=0
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
