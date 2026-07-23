#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
setCollisionBounds(0,0,sprite_width,sprite_height)
image_speed=0.15
bHit=false
moveAnim=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if moveAnim>=1 and moveAnim<=4
{
  moveAnim+=1
  if moveAnim=2
    y-=2
  else if moveAnim=4
    y+=2
}

if isCollisionCharacterBottom(1,0) and bHit=false
{
  global.recQuestionBlockHit+=1
  if global.hasAbilToken[0]>=2 {instance_create(x,y-8,oAtkBumpBlock)}
  if variable_local_exists("altItem")
  {
    if altItem=1 //Starman
    {
      playSound(global.snd_ItemSprout,0,1,1)
      var tStarman;
      tStarman=instance_create(x,y-2,oStarman)
    }
    else if altItem=2 //Heart
    {
      playSound(global.snd_ItemSprout,0,1,1)
      var tHeart;
      tHeart=instance_create(x+8,y-2,oHealthPickup)
    }
    else if altItem=3 //100% Coin
    {
      playSound(global.snd_MarioCoin,0,1,1)
      var tIndexCheck,tWalNum,tMoneyDrop,moneyWorth;
      moneyWorth=10
      tWalNum=0
      for(i=0;i<20;i+=1)
      {
        tIndexCheck=string_char_at(global.walletBoost,i+1); if tIndexCheck="1" {tWalNum+=1}
      }
      moneyWorth*=(1+tWalNum*0.1)
      tMoneyDrop=instance_create(x,y-sprite_height,oMoneyPickupHop)
      tMoneyDrop.moneyType=1; tMoneyDrop.moneyWorth=moneyWorth
    }
  }
  else
  {
    playSound(global.snd_MarioCoin,0,1,1)
    var tItemChance,tMoneyDrop;
    tItemChance=round(random(100)) //find item drop chance
    if tItemChance>=(80)
    {
      var tIndexCheck,tWalNum,tMoneyDrop,moneyWorth;
      moneyWorth=10
      tWalNum=0
      for(i=0;i<20;i+=1)
      {
        tIndexCheck=string_char_at(global.walletBoost,i+1); if tIndexCheck="1" {tWalNum+=1}
      }
      moneyWorth*=(1+tWalNum*0.1)
      tMoneyDrop=instance_create(x,y-sprite_height,oMoneyPickupHop)
      tMoneyDrop.moneyType=1; tMoneyDrop.moneyWorth=moneyWorth
    }
    else
    {
      if global.difficulty>=2
      {
        var tEffect;
        tEffect=instance_create(x+2,y+2,oEffect)
        tEffect.sprite_index=sMarioCoin; tEffect.image_xscale=0.75; tEffect.image_yscale=0.75
        tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=15; tEffect.xSpd=0; tEffect.ySpd=-3
        global.recStdMarioCoins+=1
        oPlayer1.moneyEarnedOnMap+=1
        global.recInterEarnTotal+=1
        oPlayer1.currentMoney+=1
        if oPlayer1.currentMoney>global.pMoneyMax {oPlayer1.currentMoney=global.pMoneyMax}
      }
    }
  }
  awardAwesome(20)
  moveAnim=1
  sprite_index=sMarioBlockHit
  bHit=true
}
