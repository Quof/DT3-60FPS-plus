#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
makeActive()
setCollisionBounds(-5,-5,5,5)
image_speed=0.25
image_xscale=2
image_yscale=2
yVel=-4
yVelLimit=8
decayTime=450
if global.location=15 or global.location=103 {sprite_index=sCVChicken}
if global.location=29 or global.location=104 {sprite_index=sMMHealthPickup}
if global.location=49 or global.location=106 {sprite_index=sMetroidHealthPickup}
alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if sprite_index=sFullHealthPickup
{
  setCollisionBounds(-7,-7,7,7)
  yVel=0
  yVelLimit=4
}
else if sprite_index=sCVChicken
{
  yVel=0
}
else if sprite_index=sMMHealthPickup
{
  setCollisionBounds(-8,-6,8,6)
  image_speed=0.2
}
else if sprite_index=sMetroidHealthPickup
{
  image_speed=0.33
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if gDeltaDoTicks != 1 { exit; }
if global.gamePaused=false
{
  yVel+=0.2
  if yVel>yVelLimit {yVel=yVelLimit}

  if sprite_index!=sMetroidHealthPickup
  {
    if isCollisionBottom(1)
      yVel=0
    if isCollisionSolid()
      y-=2
    moveTo(xVel,yVel)

    if y>room_height+8 {instance_destroy()}
  }

  if room=rWarshipQ
  {
    decayTime-=1
    if decayTime>=1 and decayTime<=60
    {
      if image_alpha=0.75 {image_alpha=0.5}
      else {image_alpha=0.75}
    }
    if decayTime<=0 {instance_destroy()}
  }
}
#define Collision_oPlayer1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if sprite_index=sFullHealthPickup
{
  playSound(global.snd_HealingPlant,0,1,1)
  awardAwesome(150)
  global.hudLink_Arrows[0]=global.hudLink_Arrows[1]
  global.hudLink_BombEn[0]=150-(global.skillTree[1]*15)-15
  global.hudBelmont_WeaponEn[0]=global.hudBelmont_WeaponEn[1]
  global.hudMega_BusterEn[0]=32
  global.hudMega_ShotIceEn[0]=32
  global.hudMega_GravityEn[0]=32
  global.hudSamus_CannonEn[0]=0
  global.hudSamus_Missiles[0]=global.hudSamus_Missiles[1]
  global.hudGame_WeaponEn[0]=global.hudGame_WeaponEn[1]
  oPlayer1.life=oPlayer1.maxLife
  global.pLife=global.pMaxLife
}
else
{
  if room=rAbomD //Recover Game Power if HP is full on Executive
  {
    if oPlayer1.life=oPlayer1.maxLife
    {
      global.hudGame_WeaponEn[0]+=15
      if global.hudGame_WeaponEn[0]>global.hudGame_WeaponEn[1] {global.hudGame_WeaponEn[0]=global.hudGame_WeaponEn[1]}
    }
  }
  if sprite_index=sMetroidHealthPickup {playSound(global.snd_MetHealthPickup,0,1,1)}
  else {playSound(global.snd_HealthPickup,0,1,1)}
  awardAwesome(10)
  oPlayer1.life+=4
}

tEffect=instance_create(oPlayer1.x,oPlayer1.y-(oPlayer1.sprite_height/2),oEffect)
tEffect.sprite_index=sHeal; tEffect.followID=oPlayer1.id; tEffect.xFollow=0; tEffect.yFollow=-(oPlayer1.sprite_height/2)
tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
instance_destroy()
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_sprite_ext(sprite_index,image_index,x,y,1,1,image_angle,image_blend,image_alpha)
