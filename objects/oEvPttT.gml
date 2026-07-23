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

phasingBack=0
backSwap=0
changeToGlitch=0

tile_layer_hide(999998)
originalBack=background_duplicate(backSeedEscapeCaveA_Normal)
originalTile=background_duplicate(tileSeedEscapeA_Normal)
if room=rPttT_02 or room=rPttT_03 or room=rPttT_04 or room=rPttT_05
{
  phasingBack=1
  backFollow01=instance_create(0,0,oBackgroundFollow)
  backFollow01.type=2; backFollow01.backSet=backSeedEscapeCaveA_Normal
  backFollow01.xMoveScale=0.6; backFollow01.yMoveScale=1
  backFollow01.depth=1499999; backFollow01.image_xscale=2.45; backFollow01.image_yscale=2.45

  backGrid01=instance_create(0,0,oBackPttT_01) //backSeedEscapeCaveB,backSeedEscapeCaveC,backNull
  backGrid01.moveType=0; backGrid01.backSet=backNull; backGrid01.depth=1490001
  backGrid01.xScrollSpeed=0; backGrid01.yScrollSpeed=0; backGrid01.image_alpha=0

  backGrid02=instance_create(0,0,oBackPttT_01)
  backGrid02.moveType=1; backGrid02.backSet=backNull; backGrid02.depth=1490000
  backGrid02.xScrollSpeed=0; backGrid02.yScrollSpeed=1; backGrid02.image_alpha=0
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePttT_Prog=0 and room=rPttT_01 //----- [1] Here we go -----
{
  if sceneProgress=0
  {
    sceneDelay+=1
    if sceneDelay=1 {global.gamePaused=true}
    if sceneDelay>=30 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=1 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Huh, so it DID survive.",0,3,oMessageCutscene,1)
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"Jerry","What are you talking about?",0,3,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","That thing that was controlling the Abomination. When it shattered, a part of it escaped this way. There's no location data for this place, so maybe it was able to mask its location.",0,3,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Should we chase it? That's just going to give Hex more time with his warship.",0,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Yes, we need to get rid of that thing. Something else important is here too. I can feel it. Just be ready for it to retaliate if it senses us close.",0,3,oMessageCutscene,1)
  else if sceneProgress=6 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Sure thing.",0,3,oMessageCutscene,1)
  else if sceneProgress=7
  {
    sceneDelay=0; sceneProgress=0
    global.gamePttT_Prog=10
    global.gamePaused=false
  }
}
else if global.gamePttT_Prog=60 and room=rPttT_06 //----- [2] The Parasite is close -----
{
  if sceneProgress=0
  {
    if oPlayer1.x>=192
    {
      global.gamePaused=true
      oPlayer1.y+=4
      if oPlayer1.y>=208
      {
        scenePChk(oPlayer1.x,208,0,0.1,1)
        stopPlayer()
        sceneProgress+=1
      }
    }
  }
  else if sceneProgress=1 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Okay, we've backed it into a tunnel.",0,3,oMessageCutscene,1)
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Which one?",0,3,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","The path leading down. Those others are dead ends.",0,3,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Jerry","So wait, does it know we're chasing it?",0,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Very likely. It's going to try escaping in the long tunnel below, but we can get it before it does. We'll use the rail system down there to keep up with it.",0,3,oMessageCutscene,1)
  else if sceneProgress=6 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Bottomless pit?",0,3,oMessageCutscene,1)
  else if sceneProgress=7 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","Yes... So remember, this is the last remnant of that virus. It just can't self-replicate anymore, but we need to get rid of it.",0,3,oMessageCutscene,1)
  else if sceneProgress=8 and bWaitForInput=false
    msgCreate(0,0,"Jerry","As long as it can't infect us, we're good.",0,3,oMessageCutscene,1)
  else if sceneProgress=9 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","It can't. Ah, and before you go. You can teleport to the entrance of this cave now. There should be portals to every map here.",0,3,oMessageCutscene,1)
  else if sceneProgress=10 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Ah... okay then.",0,3,oMessageCutscene,1)
  else if sceneProgress=11
  {
    sceneDelay=0; sceneProgress=0
    global.gamePttT_Prog=70
    global.gamePaused=false
  }
}
else if global.gamePttT_Prog=70 and room=rPttT_07 //----- [] Boss Fight: Parasitic Seed - Cave -----
{
  if global.bossTrack=0
  {
    if sceneProgress=0 and global.gamePaused=0
    {
      sceneDelay+=1
      if sceneDelay=120
      {
        var tempMplay,tBossTitle;
        tempMplay=findMusic(831)
        playMusic(tempMplay,0,0)

        tBossTitle=instance_create(0,0,oBossNameDisplay)
        tBossTitle.bossName="Parasitic Seed"
        tBossTitle.bossTitle="?????"
        global.currentBoss="Parasitic Seed"

        storeStatus(0)
        boss=instance_create(80,144,oParasiticSeed_Cave)
        boss.activateBoss=1
        sceneDelay=0; sceneProgress=0
        global.bossTrack=1
      }
    }
  }
  else if global.bossTrack=1
  {
    if sceneProgress=0
    {
      sceneDelay+=1
      if sceneDelay=1 or sceneDelay mod 3=0
      {
        playSound(global.snd_BombExplode,0,1,1)
        playSound(global.snd_Bobomb,0,0.95,1)
        var tEffect,tScale;
        tScale=0
        for(i=0;i<2;i+=1)
        {
          tScale=random(0.25)
          tEffect=instance_create(0,144+random_range(-40,40),oEffect)
          tEffect.sprite_index=sShipExplosion; tEffect.image_speed=0.75
          tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=30+i; tEffect.xSpd=4+random(1); tEffect.ySpd=random_range(-3,3)
          tEffect.image_xscale=0.75+tScale; tEffect.image_yscale=0.75+tScale; tEffect.image_angle=random(360)
        }
        for(i=0;i<8;i+=1)
        {
          tScale=random(0.5)
          tEffect=instance_create(0,144+random_range(-40,40),oEffect)
          tEffect.sprite_index=sSamusMissileEffect; tEffect.image_speed=0.25; tEffect.image_alpha=0.33+random(0.33)
          tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=30+i; tEffect.xSpd=6+random(4); tEffect.ySpd=random_range(-5,5)
          tEffect.image_xscale=1+tScale; tEffect.image_yscale=1+tScale; tEffect.image_angle=random(360)
        }
      }
      if sceneDelay mod 5=0
      {
        playSound(global.snd_BombExplode,0,0.93,22050+random(6000))
        playSound(global.snd_Bobomb,0,0.88,22050+random(6000))
      }
      if sceneDelay>=35
      {
        sceneDelay=0; sceneProgress+=1
      }
    }
    if sceneProgress=2 //End Boss
    {
      stopPlayer()
      var tempMplay;
      tempMplay=findMusic(0)
      playMusic(tempMplay,0,0)
      oPlayer1.life=oPlayer1.maxLife; global.pLife=global.pMaxLife
      global.bossTrack=2
      sceneProgress=0
    }
  }
  else if global.bossTrack=2
  {
    if sceneProgress=0 and global.gamePaused=0
    {
      global.canPause=0
      global.currentBoss=""
      global.bossTrack=0
      global.gamePttT_Prog=80
    }
  }
}
else if global.gamePttT_Prog=80 and room=rPttT_07 //----- [] Boss fight end -----
{
  if global.gamePaused=0
  {
    if sceneProgress=0
    {
      sceneDelay+=1
      if sceneDelay>=31 and sceneDelay<=55
      {
        fadeAlpha+=0.04
      }
      else if sceneDelay>=60
      {
        global.newMapX=160; global.newMapY=48; room_goto(rPttT_08)
      }
    }
  }
}
else if global.gamePttT_Prog=80 and room=rPttT_08 //----- [3] If only we could go back -----
{
  if sceneProgress=0
  {
    if oPlayer1.x>=288
    {
      global.gamePaused=true
      oPlayer1.y+=4
      if oPlayer1.y>=256
      {
        scenePChk(oPlayer1.x,256,0,0.1,1)
        stopPlayer()
        sceneProgress+=1
      }
    }
  }
  else if sceneProgress=1 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","While you guys were fighting that thing, I was gathering all sorts of data on it. I'm not sure how to tell you guys what I found.",0,3,oMessageCutscene,1)
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate(0,0,"Jerry","Hit us with it straight. It's all we want.",0,3,oMessageCutscene,1)
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","We made a mistake in how we fought the Abomination. We could have saved it.",0,3,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Chao","So it WAS calling out for us to help it, not destroy it!",0,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","You're right, Chao.",0,3,oMessageCutscene,1)
  else if sceneProgress=6 and bWaitForInput=false
    msgCreate(0,0,"Jerry","But what could we have done differently?",0,3,oMessageCutscene,1)
  else if sceneProgress=7 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","I'm not sure the Parasite even knew this itself, but coaxing the thing out was a mistake. We needed to get inside the Abomination and destroy the Parasite from within.",0,3,oMessageCutscene,1)
  else if sceneProgress=8 and bWaitForInput=false
    msgCreate(0,0,"Jerry","How...",0,3,oMessageCutscene,1)
  else if sceneProgress=9 and bWaitForInput=false
    msgCreate(0,0,"Jeremy","It doesn't matter how anymore... Damn you guys. If we could have known about this...",0,3,oMessageCutscene,1)
  else if sceneProgress=10
  {
    sceneDelay=0; sceneProgress=0
    global.canPause=1
    global.gamePttT_Prog=90
    global.gamePaused=false
  }
}

keyWaitForInput()
//-------------------- Cutscene skip --------------------
if oKeyCodes.kCodePressed[11]=1 and global.gamePaused=true and sceneProgress>=1
{
  if !instance_exists(oPauseMenu)
  {
    if global.gamePttT_Prog=0 and room=rPttT_01 //[1]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      fadeAlpha=0; sceneDelay=0
      sceneProgress=7
    }
    else if global.gamePttT_Prog=60 and room=rPttT_06 //[2]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      fadeAlpha=0; sceneDelay=0
      sceneProgress=11
    }
    else if global.gamePttT_Prog=80 and room=rPttT_08 //[3]
    {
      bWaitForInput=false
      with oMessageCutscene {instance_destroy()}
      fadeAlpha=0; sceneDelay=0
      sceneProgress=10
    }
  }
}

//---------- Room specific events ----------
if global.gamePaused=false
{

}

//==================================================
if phasingBack>0 //----- Background phasing -----
{
  if room=rPttT_02 or room=rPttT_03 or room=rPttT_04 or room=rPttT_05
  {
    if changeToGlitch>0
    {
      changeToGlitch-=1
      phasingBack=2
    }
    else
    {
      phasingBack=1
    }

    if phasingBack=1 //To normal
    {
      if backSwap=1
      {
        tile_layer_hide(999998)
        tile_layer_show(999999)
        background_assign(tileSeedEscapeA_Normal,originalTile)
        background_assign(backSeedEscapeCaveA_Normal,originalBack)
        backSwap=0
      }
      if backFollow01.image_alpha<1 {backFollow01.image_alpha+=0.002}
      if backGrid01.image_alpha>0 {backGrid01.image_alpha-=0.002}
      if backGrid02.image_alpha>0 {backGrid02.image_alpha-=0.002}
    }
    else //To glitch
    {
      if backSwap=0
      {
        tile_layer_hide(999999)
        tile_layer_show(999998)
        background_assign(tileSeedEscapeA_Normal,tileSeedEscapeA_Glitch)
        background_assign(backSeedEscapeCaveA_Normal,backSeedEscapeCaveA_Glitch)
        backSwap=1
      }
      if backFollow01.image_alpha>0.9 {backFollow01.image_alpha-=0.002}
      if backGrid01.image_alpha<0.05 {backGrid01.image_alpha+=0.002}
      if backGrid02.image_alpha<0.05 {backGrid02.image_alpha+=0.002}
    }
  }
}
#define Other_5
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
background_assign(tileSeedEscapeA_Normal,originalTile)
background_assign(backSeedEscapeCaveA_Normal,originalBack)
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
