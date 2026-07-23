#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Requires: spdInc,hitMax
event_inherited()
image_xscale=0.1; image_yscale=0.1

//Enemy base statistics
bShowHealthBar=false
bShowDamage=false
bCanTakeDamage=false
bCanDealDamage=false

bCanBeHitBack=false
hitBackNum=0
hitByPlayer=0
initSoundPlay=0

atkPower=oHexor_Main_R2.atkPower*3

bulletSpeed=4
atkProg=0
atkTime=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if atkProg=0
  {
    if initSoundPlay=0
    {
      playSound(global.snd_WepCharge,0,0.94,13000)
      playSound(global.snd_Dec_ChargeUp,0,0.95,24000)
      initSoundPlay=1
    }
    image_xscale+=0.02; image_yscale+=0.02

    var tEffect,tFFScl,tFFDir;
    tFFScl=random(0.1)
    tFFDir=random(360)
    tEffect=instance_create(x+lengthdir_x(60,tFFDir),y+lengthdir_y(60,tFFDir),oEffectB)
    tEffect.type=3; tEffect.sprite_index=sEfFirefly; tEffect.newBlend=1
    tEffect.image_alpha=0.5; tEffect.image_xscale=0.1+tFFScl; tEffect.image_yscale=0.1+tFFScl
    tEffect.direction=tFFDir-180; tEffect.speed=5.8
    tEffect.fadeSpd=0.05; tEffect.AccelX=0; tEffect.AccelY=0; tEffect.followID=-1; tEffect.rotation=0

    if image_xscale>=1
    {
      SS_StopSound(global.snd_WepCharge)
      SS_StopSound(global.snd_Dec_ChargeUp)
      playSound(global.snd_Dec_Fire,0,0.95,32000)
      playSound(global.snd_ChargeStrike,0,0.95,32000)
      var tEfCir;
      tEfCir=instance_create(x,y,oEfCircleBlast)
      tEfCir.image_alpha=0.75; tEfCir.myRad=8; tEfCir.radScl=2; tEfCir.fadeSpeed=0.08
      direction=point_direction(x,y,oPlayer1.x,oPlayer1.y-32)
      bCanDealDamage=1
      bCanBeHitBack=1
      atkProg=1
    }
  }
  else if atkProg=1
  {
    instance_create(x,y,oGanonOrbAE)
    speed=bulletSpeed
  }
}
else {speed=0}
#define Collision_oPlayer1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
redDmgHit(0)
event_user(0)
instance_destroy()
#define Collision_oAttackBase
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if bCanBeHitBack=1 and hitByPlayer=0
{
  var tEfCir;
  tEfCir=instance_create(x,y,oEfCircleBlast)
  tEfCir.image_alpha=0.75; tEfCir.myRad=8; tEfCir.radScl=2; tEfCir.fadeSpeed=0.08
  bulletSpeed+=spdInc
  hitBackNum+=1
  hitByPlayer=1
  playSound(global.snd_HitOrb,0,1,22000+(hitBackNum*2000))
  direction=point_direction(x,y,oHexor_Main_R2.x,oHexor_Main_R2.y)
}
#define Collision_oHexor_Main_R2
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if hitByPlayer=1
{
  if hitBackNum>=hitMax
  {
    event_user(0)
    oHexor_Main_R2.timesHitWithOrb+=1
    oHexor_Main_R2.life-=165
    instance_destroy()
  }
  else
  {
    playSound(global.snd_HitOrb,0,1,23000+(hitBackNum*2000))
    var tEfCir;
    tEfCir=instance_create(x,y,oEfCircleBlast)
    tEfCir.image_alpha=0.75; tEfCir.myRad=8; tEfCir.radScl=2; tEfCir.fadeSpeed=0.08

    direction=point_direction(x,y,oPlayer1.x,oPlayer1.y-32)
    hitByPlayer=0
  }
}
#define Other_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
instance_destroy()
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
playSound(global.snd_LightballSpread,0,1,17000)
playSound(global.snd_Shock,0,0.88,17000)
var tNewInvert; tNewInvert=instance_create(0,0,oScreenInvert); tNewInvert.invertTime=6
var tEffect,tScl,tEfCir;
for(i=0;i<24;i+=1)
{
  tScl=0.35+random(0.25)
  tEffect=instance_create(x+random_range(-2,2),y+random_range(-2,2),oEffect)
  tEffect.sprite_index=sEfLinkLightning; tEffect.image_speed=0.25; tEffect.image_angle=random(360)
  tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
  tEffect.image_xscale=tScl; tEffect.image_yscale=tScl
}

tEfCir=instance_create(x,y,oEfCircleBlast)
tEfCir.image_alpha=0.7; tEfCir.myRad=8; tEfCir.radScl=8; tEfCir.fadeSpeed=0.1
