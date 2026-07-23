#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
makeActive()
setCollisionBounds(-7,-7,7,7)
image_xscale=1.5
image_yscale=1.5
image_speed=0.4
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  yVel+=0.3
  if isCollisionBottom(1)
  {
    xVel=0
    yVel=0
  }
  if isCollisionLeft(1)
    xVel*=-1
  if isCollisionRight(1)
    xVel*=-1
  moveTo(xVel,yVel)

  if isCollisionSolid()
    y-=2

  if y>room_height+24
    instance_destroy()
}
#define Collision_oPlayer1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.difficulty>=2
{
  playSound(global.snd_MoneyPickup,0,0.9,1)
  tEffect=instance_create(x+8,y+8,oEffect)
  tEffect.sprite_index=sEfInternetzGrab; tEffect.followID=-1; tEffect.xFollow=0; tEffect.yFollow=0
  tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0; tEffect.image_alpha=0.75
  tEffect.image_xscale=0.75; tEffect.image_yscale=0.75

  oPlayer1.moneyEarnedOnMap+=moneyWorth
  global.recInterEarnTotal+=moneyWorth
  oPlayer1.currentMoney+=moneyWorth
  if oPlayer1.currentMoney>global.pMoneyMax {oPlayer1.currentMoney=global.pMoneyMax}
  awardAwesome(10)
  instance_destroy()
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_sprite_ext(sprite_index,image_index,x,y,1,1,image_angle,image_blend,image_alpha)
