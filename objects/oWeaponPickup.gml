#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
makeActive()
setCollisionBounds(1,0,sprite_width,sprite_height)
image_speed=0.5
image_xscale=2
image_yscale=2
yVel=-4
yVelLimit=8
alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if sprite_index=sWepPickupArrows
  setCollisionBounds(-3,-6,3,6)
else if sprite_index=sCVHeart
{
  setCollisionBounds(-4,-4,4,4)
  yVel=0.4
  yVelLimit=0.6
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if sprite_index=sWepPickupArrows
  {
    yVel+=0.2
    if yVel>yVelLimit
      yVel=yVelLimit
  }
  else if sprite_index=sCVHeart
  {
    yVel+=0.01
    if yVel>yVelLimit
      yVel=yVelLimit
  }

  if sprite_index!=sMetroidMissile
  {
    if isCollisionBottom(1)
    {
      xVel=0
      yVel=0
    }
    else
    {
      if sprite_index=sCVHeart
        xVel=sin(oGame.time/6)
    }
    if isCollisionSolid()
      y-=2

    moveTo(xVel,yVel)
    if y>room_height+8
      instance_destroy()
  }
}
#define Collision_oPlayer1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if sprite_index=sWepPickupArrows
{
  global.hudLink_Arrows[0]+=3
  if global.hudLink_Arrows[0]>global.hudLink_Arrows[1]
    global.hudLink_Arrows[0]=global.hudLink_Arrows[1]
}
else if sprite_index=sCVHeart
{
  global.hudBelmont_WeaponEn[0]+=5
  if global.hudBelmont_WeaponEn[0]>global.hudBelmont_WeaponEn[1]
    global.hudBelmont_WeaponEn[0]=global.hudBelmont_WeaponEn[1]
}
else if sprite_index=sMetroidMissile
{
  global.hudSamus_Missiles[0]+=3
  if global.hudSamus_Missiles[0]>global.hudSamus_Missiles[1]
    global.hudSamus_Missiles[0]=global.hudSamus_Missiles[1]
}

awardAwesome(10)
playSound(global.snd_AmmoGrab,0,1,1)
tEffect=instance_create(oPlayer1.x,oPlayer1.y-(oPlayer1.sprite_height/2),oEffect)
tEffect.sprite_index=sHeal
tEffect.followID=oPlayer1.id; tEffect.xFollow=0; tEffect.yFollow=-(oPlayer1.sprite_height/2)
tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
instance_destroy()
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_sprite_ext(sprite_index,image_index,x,y,1,1,image_angle,image_blend,image_alpha)
