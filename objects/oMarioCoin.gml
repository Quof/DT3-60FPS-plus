#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_speed=0.4
moneyWorth=1
#define Collision_oPlayer1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.difficulty>=2
{
  playSound(global.snd_MarioCoin,0,0.9,1)
  tEffect=instance_create(x+8,y+8,oEffect)
  tEffect.sprite_index=sEfInternetzGrab; tEffect.followID=-1; tEffect.xFollow=0; tEffect.yFollow=0
  tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0; tEffect.image_alpha=0.75
  tEffect.image_xscale=0.75; tEffect.image_yscale=0.75

  global.recStdMarioCoins+=1
  oPlayer1.moneyEarnedOnMap+=moneyWorth
  global.recInterEarnTotal+=moneyWorth
  oPlayer1.currentMoney+=moneyWorth
  if oPlayer1.currentMoney>global.pMoneyMax {oPlayer1.currentMoney=global.pMoneyMax}
  awardAwesome(10)
  instance_destroy()
}
