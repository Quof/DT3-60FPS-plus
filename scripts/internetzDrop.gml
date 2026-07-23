/*
This script is used to calculate the amount of money an Internet drop is worth
argument0: Determine if enemy drop
-- 0: Not an enemy drop
-- 1: An enemy drops this
*/

var tEnDrop;
tEnDrop=argument0

var tExChance,tMoneyDrop,tEqpAdj;
tExChance=0; tEqpAdj=0

if global.activeCharacter=0
{
  for(i=0;i<3;i+=1)
  {
    if global.equipJerry[i]=6 {tEqpAdj+=15} //Equipment: Emerald Tiara
    if global.equipJerry[i]=7 {tEqpAdj+=30} //Equipment: Diamond Tiara
  }
}
else if global.activeCharacter=1
{
  for(i=0;i<3;i+=1)
  {
    if global.equipClaire[i]=6 {tEqpAdj+=15} //Equipment: Emerald Tiara
    if global.equipClaire[i]=7 {tEqpAdj+=30} //Equipment: Diamond Tiara
  }
}

if moneyWorth=20
{
  tExChance=70+(global.skillTree[19]*3)+tEqpAdj
  if round(random(100))>tExChance or oPlayer1.killChain<6 {moneyWorth=10}
}
if moneyWorth=10
{
  tExChance=70+(global.skillTree[19]*3)+tEqpAdj
  if round(random(100))>tExChance or oPlayer1.killChain<4 {moneyWorth=5}
}
if moneyWorth=5
{
  tExChance=70+(global.skillTree[19]*3)+tEqpAdj
  if round(random(100))>tExChance or oPlayer1.killChain<2 {moneyWorth=1}
}

if instance_exists(oEvCh19WarRoom) {moneyWorth=1} //When in War Room, only green can be dropped

var tIndexCheck,tWalNum,tMoneyType;
tMoneyType=moneyWorth
moneyWorth*=10
tWalNum=0
for(i=0;i<20;i+=1)
{
  tIndexCheck=string_char_at(global.walletBoost,i+1); if tIndexCheck="1" {tWalNum+=1}
}
moneyWorth*=(1+tWalNum*0.1)

tMoneyDrop=instance_create(round(bbox_left+(abs(sprite_width)/2)),round(bbox_top+(abs(sprite_height)/2)),oMoneyPickup)
tMoneyDrop.moneyType=tMoneyType; tMoneyDrop.moneyWorth=moneyWorth
if tEnDrop=1 {tMoneyDrop.enemyDrop=1}
