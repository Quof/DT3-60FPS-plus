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
shipWhite=0; whiteAlpha=1

explosionsBehind=0
expSoundTime=0
charactersEscape=0
soundVol=0.91

bCharacterShields=0
shieldFrm=0
shieldAlpha=0.2

if room=rEnd_WarshipA
{
  fadeAlpha=1
  theWarship=instance_create(224,96,oMisc)
  theWarship.type=0; theWarship.sprite_index=sCHAOS_WarshipMain
  shipExplode=1
}
else if room=rEnd_SceneA
{
  oIdentifier.willFollowMouse=0
  global.optChaoRoam=0
  oPlayer1.x=196; oPlayer1.y=-16; oPlayer1.sprite_index=sClaireJump; oPlayer1.image_speed=0.1; oPlayer1.image_xscale=1
  oIdentifier.x=272; oIdentifier.y=-48
  bCharacterShields=1
  fadeColor=c_black
  fadeAlpha=1
}
else if room=rEnd_SceneB
{
  fadeColor=c_black
  fadeAlpha=1
  npcJohn=instance_create(368,272,oMisc)
  npcJohn.type=0; npcJohn.sprite_index=sNPC_John_Idle; npcJohn.image_speed=0.2
  npcJohn=instance_create(256,256,oMisc)
  npcJohn.type=0; npcJohn.sprite_index=sNPC_Syrus_Idle
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if room=rEnd_WarshipA //----- [] End A -----
{
  if sceneProgress=0
  {
    sceneDelay+=1
    if sceneDelay>=30
    {
      fadeAlpha-=0.04
      if fadeAlpha<=0
      {
        bubbleClaire=instance_create(350,64,oMisc)
        bubbleClaire.type=0; bubbleClaire.sprite_index=sWaterBarrier; bubbleClaire.image_speed=0.33
        bubbleClaire.image_xscale=0.1; bubbleClaire.image_yscale=0.1; bubbleClaire.visible=0
        bubbleChao=instance_create(380,64,oMisc)
        bubbleChao.type=0; bubbleChao.sprite_index=sWaterBarrier; bubbleChao.image_speed=0.33
        bubbleChao.image_xscale=0.1; bubbleChao.image_yscale=0.1; bubbleChao.visible=0
        sceneDelay=0; sceneProgress+=1
      }
    }
  }
  else if sceneProgress=1
  {
    sceneDelay+=1
    if sceneDelay=29
    {
      playSound(global.snd_BombExplode,0,1,14000)
      for(i=0;i<40;i+=1)
      {
        var tEffect;
        tEffect=instance_create(312+random_range(-128,160),96+random_range(-72,72),oEffect)
        tEffect.image_speed=0.33+random(0.33); tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
        tEffect.sprite_index=sBombExplosion; tEffect.image_xscale=0.5; tEffect.image_yscale=0.5
      }
    }
    if sceneDelay>=30
    {
      shipWhite+=4
      if shipWhite>20
      {
        shipExplode=0
        if charactersEscape=0
        {
          bubbleClaire.visible=1; bubbleChao.visible=1
          charactersEscape=1
        }
      }
      if shipWhite=136 {with theWarship {instance_destroy()}}
      else if shipWhite>=137 {whiteAlpha-=0.02}
    }
    if sceneDelay>=170 {fadeColor=c_black; sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=2
  {
    fadeAlpha+=0.04
    if fadeAlpha>=1
    {
      global.newMapX=112; global.newMapY=272
      room_goto(rEnd_SceneA)
    }
  }

  if charactersEscape=1
  {
    bubbleClaire.x-=1; bubbleClaire.y+=3
    bubbleChao.x-=1; bubbleChao.y+=3
  }

  if shipExplode=1
  {
    for(i=0;i<4;i+=1)
    {
      var tEffect;
      tEffect=instance_create(312+random_range(-128,160),96+random_range(-72,72),oEffect)
      tEffect.image_speed=0.33+random(0.33); tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
      tEffect.sprite_index=sBombExplosion; tEffect.image_xscale=0.25; tEffect.image_yscale=0.25
    }
    expSoundTime+=1
    if expSoundTime mod 6=0 {playSound(global.snd_MetroidBomb,0,soundVol,1)}
  }
}
else if room=rEnd_SceneA //----- [] End B -----
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
    if sceneDelay>=10 and sceneDelay<=199
    {
      oPlayer1.x-=1; oPlayer1.y+=4
      oIdentifier.x-=1; oIdentifier.y+=4
      if oPlayer1.y>=272
      {
        scenePChk(oPlayer1.x,272,0,0.1,1)
        stopPlayer()
        sceneDelay=200
      }
    }
    else if sceneDelay>=230 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=2
  {
    sceneDelay+=1
    if sceneDelay>=11 and sceneDelay<=20 {shieldAlpha-=0.01}
    else if sceneDelay=21 {bCharacterShields=0}
    else if sceneDelay>=40 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate(0,0,"Chao","Claire, are you okay?",0,3,oMessageCutscene,1)
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate(0,0,"Claire","I think so, it's just... how were we shielded?",0,3,oMessageCutscene,1)
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate(0,0,"Chao","It was Jeremy and Jerry that shielded us.",0,3,oMessageCutscene,1)
  else if sceneProgress=6 and bWaitForInput=false
    msgCreate(0,0,"Claire","But wait... did they make it out too?",0,3,oMessageCutscene,1)
  else if sceneProgress=7 and bWaitForInput=false
    msgCreate(0,0,"Chao","Claire...",0,3,oMessageCutscene,1)
  else if sceneProgress=8 and bWaitForInput=false
    msgCreate(0,0,"Claire","I know what they did...",0,3,oMessageCutscene,1)
  else if sceneProgress=9 and bWaitForInput=false
    msgCreate(0,0,"Chao","Yeah... I, you don't have to say anything.",0,3,oMessageCutscene,1)
  else if sceneProgress=10 and bWaitForInput=false
    msgCreate(0,0,"Claire","Just leave me be for a moment.",0,3,oMessageCutscene,1)
  else if sceneProgress=11
  {
    global.bSoundCanPlay=0
    global.gamePaused=0
    instance_create(0,0,oEvCredits)
    sceneProgress+=1
  }
}

keyWaitForInput()
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if bCharacterShields=1
{
  shieldFrm+=0.25
  for(i=0;i<3;i+=1)
  {
    draw_sprite_ext(sWaterBarrier,shieldFrm+i,oPlayer1.x,oPlayer1.y-26,image_xscale+(0.25*i),image_yscale+(0.25*i),image_angle,image_blend,shieldAlpha+(0.1*i))
    draw_sprite_ext(sWaterBarrier,shieldFrm+i,oIdentifier.x,oIdentifier.y,image_xscale+(0.25*i),image_yscale+(0.25*i),image_angle,image_blend,shieldAlpha+(0.1*i))
  }
}

if shipWhite>0
{
  draw_set_alpha(whiteAlpha)
  draw_set_color(c_white)
  draw_ellipse(312-(shipWhite*1.66),96-shipWhite,312+(shipWhite*1.66),96+shipWhite,0)
}

if fadeAlpha>0
{
  draw_set_alpha(fadeAlpha)
  draw_set_color(fadeColor)
  draw_rectangle(view_xview[0]-1,view_yview[0]-1,view_xview[0]+view_wview[0]+1,view_yview[0]+view_hview[0]+1,0)
}
