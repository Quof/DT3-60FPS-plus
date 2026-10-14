if isCollisionCharacterBottom(1,0) and bHit=false and oPlayer1.yVel<0
{
  playSound(global.snd_MarioCoin,0,1,1)
  sprite_index=sMarioBlockHit
  visible=true
  instance_create(x,y,oInvisibleSolid)
  global.recQuestionBlockHit+=1
  bHit=true
  if global.location!=10
  {
      tMoneyDrop=instance_create(x,y-sprite_height,oMoneyPickupHop)
      tMoneyDrop.moneyType=1; tMoneyDrop.moneyWorth=4
  }
  awardAwesome(20)
}
