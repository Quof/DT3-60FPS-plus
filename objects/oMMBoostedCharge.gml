#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
x+=8
image_xscale=0.5
xCenter=2912
yCenter=144
sceneProg=0

if global.hasBoostedXCharge=1 {instance_destroy()}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if sceneProg>0
{
  sceneProg+=1
  if sceneProg=2
  {
    oPlayer1.x=xCenter; oPlayer1.y=yCenter
    stopPlayer()
    oPlayer1.sprite_index=sJerryIdle
    var tFlash;
    tFlash=instance_create(0,0,oScreenFlash)
    tFlash.fadeSpeed=0.2
  }
  else if sceneProg>=21 and sceneProg<=90
  {
    oPlayer1.image_blend=make_color_rgb(random(255),random(255),random(255))
    var tEffect;
    tEffect=instance_create(xCenter-12+random(24),yCenter-44,oEffect)
    tEffect.sprite_index=sMMchargeEffect1; tEffect.image_angle=90
    tEffect.ySpd=8 tEffect.decay=5
    tEffect.newBlend=-1; tEffect.followID=-1; tEffect.xSpd=0
  }
  else if sceneProg=91
  {
    oPlayer1.image_blend=c_white
    var tFlash;
    tFlash=instance_create(0,0,oScreenFlash)
    tFlash.fadeSpeed=0.2
  }
  else if sceneProg=110
  {
    playSound(global.snd_MMVictoryShine,0,1,1)
    oPlayer1.sprite_index=sJerryCasted; oPlayer1.image_index=0; oPlayer1.image_speed=0
    tEffect=instance_create(oPlayer1.x+(18*oPlayer1.image_xscale),oPlayer1.y-33,oEffect)
    tEffect.sprite_index=sMMX_Win; tEffect.image_speed=0.5
    tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
  }
  else if sceneProg=130
  {
    playSound(global.snd_MMItemGet,0,1,1)
    msgCreate(170,30,"","You can now charge your X-Specials.",6,1,oMessagePerson,0)
    newMessage.fadingTime=90
    global.hasBoostedXCharge=1
    global.gamePaused=false
    instance_destroy()
  }
}
#define Collision_oPlayer1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/*
Power up script.
objectNum relates to which global flag to write to.
0 = has not been obtained.
1 = has been obtained.
*/
if sceneProg=0 and global.gamePaused=false
{
  global.gamePaused=true
  sceneProg=1
}
