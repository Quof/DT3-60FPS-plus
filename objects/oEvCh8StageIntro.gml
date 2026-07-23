#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
transition_steps=10
transition_kind=21

introProg=0
bossBlend=0
flashWhite=0
triangleX=150
triangleY=-155
redLineY=396
logoSpd=9
bShowBossName=0
colorText=make_color_rgb(130,201,224)
fadeOut=0

if global.newMapX=1
{
  bossSprite=sStormE_Idle
  bossFrame=0
  yOffset=sprite_get_yoffset(sStormE_Idle)
  bossName="STORM EAGLE"
}
else if global.newMapX=2
{
  bossSprite=sOOstrich_Idle
  bossFrame=0
  yOffset=sprite_get_yoffset(sOOstrich_Idle)
  bossName="OVERDRIVE OSTRICH"
}
else if global.newMapX=3
{
  bossSprite=sToxicSeahorsePose
  bossFrame=0
  yOffset=sprite_get_yoffset(sToxicSeahorsePose)
  bossName="TOXIC SEAHORSE"
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
introProg+=1
if introProg=20 //----- Play music -----
{
  var tempMplay;
  tempMplay=findMusic(406)
  playMusic(tempMplay,0,1)
}
else if introProg=30 //----- First lightning -----
{
  playSound(global.snd_MMBuster[2],0,1,1)
  var tEffect;
  for(i=0;i<4;i+=1)
  {
    tEffect=instance_create(240+lengthdir_x(260,45+(i*90)),176+lengthdir_y(260,45+(i*90)),oEffect)
    tEffect.sprite_index=sZapTrap; tEffect.image_angle=45+(i*90)-180; tEffect.direction=45+(i*90)-180
    tEffect.image_xscale=1.75; tEffect.image_yscale=1.5; tEffect.speed=12; tEffect.decay=16
    tEffect.newBlend=-1; tEffect.followID=-1; tEffect.xSpd=0; tEffect.ySpd=0
  }
}
else if introProg=50
{
  var tEffect,tDir;
  tDir=0
  for(i=0;i<20;i+=1)
  {
    tEffect=instance_create(240,176,oEffect)
    tEffect.sprite_index=sZapTrap; tEffect.image_angle=tDir
    tEffect.image_xscale=1.25+random(0.25); tEffect.image_yscale=1.25+random(0.25); tEffect.decay=5
    tEffect.newBlend=-1; tEffect.followID=-1; tEffect.xSpd=0; tEffect.ySpd=0
    tDir+=360/20
  }
}
else if introProg=60 //----- Second lightning -----
{
  playSound(global.snd_MMBuster[2],0,1,1)
  for(i=0;i<4;i+=1)
  {
    var tEffect;
    tEffect=instance_create(240+lengthdir_x(260,45+(i*90)),176+lengthdir_y(260,45+(i*90)),oEffect)
    tEffect.sprite_index=sZapTrap; tEffect.image_angle=45+(i*90)-180; tEffect.direction=45+(i*90)-180
    tEffect.image_xscale=1.75; tEffect.image_yscale=1.5; tEffect.speed=12; tEffect.decay=16
    tEffect.newBlend=-1; tEffect.followID=-1; tEffect.xSpd=0; tEffect.ySpd=0
  }
}
else if introProg=80
{
  var tEffect,tDir;
  tDir=0
  for(i=0;i<20;i+=1)
  {
    tEffect=instance_create(240,176,oEffect)
    tEffect.sprite_index=sZapTrap; tEffect.image_angle=tDir
    tEffect.image_xscale=1.25+random(0.25); tEffect.image_yscale=1.25+random(0.25); tEffect.decay=5
    tEffect.newBlend=-1; tEffect.followID=-1; tEffect.xSpd=0; tEffect.ySpd=0
    tDir+=360/20
  }
}
else if introProg=95 //----- Last lightning -----
{
  playSound(global.snd_MMBuster[2],0,1,1)
  for(i=0;i<4;i+=1)
  {
    var tEffect;
    tEffect=instance_create(240+lengthdir_x(260,45+(i*90)),176+lengthdir_y(260,45+(i*90)),oEffect)
    tEffect.sprite_index=sZapTrap; tEffect.image_angle=45+(i*90)-180; tEffect.direction=45+(i*90)-180
    tEffect.image_xscale=1.75; tEffect.image_yscale=1.5; tEffect.speed=12; tEffect.decay=16
    tEffect.newBlend=-1; tEffect.followID=-1; tEffect.xSpd=0; tEffect.ySpd=0
  }
}
else if introProg=115
{
  var tEffect,tDir;
  tDir=0
  for(i=0;i<20;i+=1)
  {
    tEffect=instance_create(240,176,oEffect)
    tEffect.sprite_index=sZapTrap; tEffect.image_angle=tDir
    tEffect.image_xscale=1.25+random(0.25); tEffect.image_yscale=1.25+random(0.25); tEffect.decay=5
    tEffect.newBlend=-1; tEffect.followID=-1; tEffect.xSpd=0; tEffect.ySpd=0
    tDir+=360/20
  }
}
else if introProg=118 //White flash
{
  flashWhite=1
  bossBlend=255
  background_color=make_color_rgb(17,78,153)
}
else if introProg>=132 and introProg<=190 //Logo scroll
{
  triangleY+=logoSpd
  redLineY-=logoSpd
  if introProg>=160
  {
    if logoSpd>-9 {logoSpd-=0.6}
  }
}
else if introProg=191 {bShowBossName=1}

//----- Boss poses -----
if global.newMapX=1
{
  if introProg=192 {bossSprite=sStormE_StandFlap}
  else if introProg=197 {bossFrame=2}
  else if introProg=202 {bossFrame=1}
  else if introProg=207 {bossSprite=sStormE_Pose}
}
else if global.newMapX=2
{
  if introProg=192 {bossSprite=sOOstrich_Ready}
  else if introProg=197 {bossFrame=1}
}
else if global.newMapX=3
{
  if introProg=192 {bossFrame=1}
  else if introProg=198 {bossFrame=2}
}

if introProg>=261 and introProg<=270 {fadeOut+=0.1}
else if introProg=275 //End sequence
{
  global.tempAction[0]=global.newMapX
  global.gamePaused=true
  if global.newMapX=1
  {
    global.newMapX=80; global.newMapY=192; room_goto(rMega4_StormA)
  }
  else if global.newMapX=2
  {
    global.newMapX=128; global.newMapY=160; room_goto(rMega4_OstrichA)
  }
  else if global.newMapX=3
  {
    global.newMapX=80; global.newMapY=272; room_goto(rMega4_ToxicJungleA)
  }
}

if flashWhite>0
{
  draw_set_alpha(flashWhite)
  draw_set_color(c_white)
  draw_rectangle(-1,-1,room_width+1,room_height+1,0)
  flashWhite-=0.05
}

draw_set_alpha(1)
draw_set_color(make_color_rgb(100,38,22)) //dark red
draw_rectangle(-1,redLineY,room_width+1,redLineY+52,0)
draw_set_color(make_color_rgb(169,79,56)) //light red
draw_rectangle(-1,redLineY,room_width+1,redLineY+52,1)
draw_set_color(make_color_rgb(106,64,140)) //light purple
draw_triangle(triangleX,triangleY,triangleX+176,triangleY,triangleX+88,triangleY+154,0)
draw_set_color(make_color_rgb(71,23,114)) //dark purple
draw_triangle(triangleX,triangleY,triangleX+176,triangleY,triangleX+88,triangleY+154,1)
draw_sprite_ext(sAffiliationIcons,4,triangleX+88,triangleY+77,2,2,0,c_white,1)

draw_sprite_ext(bossSprite,bossFrame,240,176+(yOffset/2),1,1,0,make_color_rgb(bossBlend,bossBlend,bossBlend),1)

if bShowBossName=1
{
  draw_set_font(fnt_Timer)
  draw_set_halign(fa_center)
  textDropShadow(bossName,240,260,colorText,c_black,4)
}

if fadeOut>0
{
  draw_set_alpha(fadeOut)
  draw_set_color(c_black)
  draw_rectangle(-1,-1,room_width+1,room_height+1,0)
}
