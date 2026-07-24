#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
makeActive()
setCollisionBounds(1,0,sprite_width,sprite_height)
image_xscale=2
image_yscale=2
image_speed=0.33
yVel=-4
alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if moneyType=5
  sprite_index=sCoin_5
else if moneyType=10
  sprite_index=sCoin_10
else if moneyType=20
  sprite_index=sCoin_20
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  yVel+=0.3*gDeltaTime

  if isCollisionBottom(1)
    yVel=0
  if isCollisionSolid()
    y-=2
  moveTo(xVel*gDeltaTime,yVel*gDeltaTime)

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
  tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0; tEffect.image_alpha=0.9; tEffect.image_speed=0.75

  if variable_local_exists("enemyDrop") {global.recInterEarnEnemy+=moneyWorth}
  oPlayer1.moneyEarnedOnMap+=moneyWorth
  global.recInterEarnTotal+=moneyWorth
  oPlayer1.currentMoney+=moneyWorth
  if oPlayer1.currentMoney>global.pMoneyMax {oPlayer1.currentMoney=global.pMoneyMax}
  awardAwesome(moneyWorth*10)
  if global.optShowMoney=1
  {
    var tNewAmt;
    tNewAmt=instance_create(x+8,y+8,oMoneyAward)
    tNewAmt.moneyValue=round(moneyWorth)
  }
  instance_destroy()
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
magicInterpDrawStart()
draw_sprite_ext(sprite_index,image_index,x,y,1,1,image_angle,image_blend,image_alpha)
magicInterpDrawEnd()
