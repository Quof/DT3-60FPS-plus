#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
setCollisionBounds(0,0,sprite_width,sprite_height)
image_speed=0.15
hitTime=0
bTellMeToExplode=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if hitTime>0 and hitTime<=9
{
  hitTime+=1
  if hitTime>=3
    instance_destroy()
}
else if hitTime>=101 and hitTime<=104
{
  hitTime+=1
  if hitTime=102
    y-=2
  else if hitTime=104
    y+=2
}

if isCollisionCharacterBottom(1,0) and hitTime=0
{
  awardAwesome(10)
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
    else if altItem=3 //Coin 100%
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
      tMoneyDrop=instance_create(x,y,oMoneyPickup)
      tMoneyDrop.moneyType=1; tMoneyDrop.moneyWorth=moneyWorth
    }
    sprite_index=sMarioBlockHit
    hitTime=101
  }
  else
  {
    playSound(global.snd_MarioBlockBreak,0,1,1)
    for(i=0;i<4;i+=1)
    {
      newEffect=instance_create(x+8,y+8,oEfMarioBlock)
      newEffect.type=i
    }
    hitTime=1
  }
}

if bTellMeToExplode=1
{
  playSound(global.snd_MarioBlockBreak,0,1,1)
  for(i=0;i<4;i+=1)
  {
    newEffect=instance_create(x+8,y+8,oEfMarioBlock)
    newEffect.type=i
  }
  instance_destroy()
}
