/*
This script returns the hidden item percentage.
argument0: Check type
-- 0: Percentage
-- 1: Item Amount
-- 2: Max Items
-- 3: Check if player has at least 1 of that item type
*/

var tItemChk,indexCheck,item_Num,item_Total;
tItemChk=argument0
item_Num=0
item_Total=522

itemC_HeartP=0
itemC_Chest=0
itemC_Arrow=0
itemC_HeartE=0
itemC_Missile=0
itemC_Ki=0
itemC_Air=0
itemC_Wallet=0
itemC_Weapon=0
itemC_AP=0
itemC_Extra=0

for(i=0;i<44;i+=1)
{
  indexCheck=string_char_at(global.heartPiece,i+1); if indexCheck="1" {item_Num+=1}
  if tItemChk=3
    indexCheck=string_char_at(global.heartPiece,i+1); if indexCheck="1" {itemC_HeartP+=1}
}
for(i=0;i<77;i+=1)
{
  indexCheck=string_char_at(global.chestMoney,i+1); if indexCheck="1" {item_Num+=1}
  if tItemChk=3
    indexCheck=string_char_at(global.chestMoney,i+1); if indexCheck="1" {itemC_Chest+=1}
}
for(i=0;i<30;i+=1)
{
  indexCheck=string_char_at(global.arrowQuiver,i+1); if indexCheck="1" {item_Num+=1}
  if tItemChk=3
    indexCheck=string_char_at(global.arrowQuiver,i+1); if indexCheck="1" {itemC_Arrow+=1}
}
for(i=0;i<28;i+=1)
{
  indexCheck=string_char_at(global.heartEnergy,i+1); if indexCheck="1" {item_Num+=1}
  if tItemChk=3
    indexCheck=string_char_at(global.heartEnergy,i+1); if indexCheck="1" {itemC_HeartE+=1}
}
for(i=0;i<30;i+=1)
{
  indexCheck=string_char_at(global.missilePack,i+1); if indexCheck="1" {item_Num+=1}
  if tItemChk=3
    indexCheck=string_char_at(global.missilePack,i+1); if indexCheck="1" {itemC_Missile+=1}
}
for(i=0;i<50;i+=1)
{
  indexCheck=string_char_at(global.kiEnergy,i+1); if indexCheck="1" {item_Num+=1}
  if tItemChk=3
    indexCheck=string_char_at(global.kiEnergy,i+1); if indexCheck="1" {itemC_Ki+=1}
}
for(i=0;i<10;i+=1)
{
  indexCheck=string_char_at(global.airUpgrade,i+1); if indexCheck="1" {item_Num+=1}
  if tItemChk=3
    indexCheck=string_char_at(global.airUpgrade,i+1); if indexCheck="1" {itemC_Air+=1}
}
for(i=0;i<20;i+=1)
{
  indexCheck=string_char_at(global.walletBoost,i+1); if indexCheck="1" {item_Num+=1}
  if tItemChk=3
    indexCheck=string_char_at(global.walletBoost,i+1); if indexCheck="1" {itemC_Wallet+=1}
}
for(i=0;i<120;i+=1)
{
  indexCheck=string_char_at(global.weaponLevels,i+1); if indexCheck="1" {item_Num+=1}
  if tItemChk=3
    indexCheck=string_char_at(global.weaponLevels,i+1); if indexCheck="1" {itemC_Weapon+=1}
}
for(i=0;i<100;i+=1)
{
  indexCheck=string_char_at(global.apBoost,i+1); if indexCheck="1" {item_Num+=1}
  if tItemChk=3
    indexCheck=string_char_at(global.apBoost,i+1); if indexCheck="1" {itemC_AP+=1}
}

if global.bNightmareMode=1
{
  for(i=0;i<20;i+=1)
  {
    indexCheck=string_char_at(global.weaponBoosts,i+1); if indexCheck="1" {item_Num+=1; itemC_Extra+=1}
  }
  item_Num+=global.itemFinder+global.hasBoostedXCharge+global.metSpringBall
  itemC_Extra+=global.hasBoostedXCharge+global.itemFinder+global.metSpringBall
}
else
{
  item_Num+=global.hasBoostedXCharge //1
  item_Num+=global.itemFinder //1
  item_Num+=global.metSpringBall //1
  item_Num+=global.linkBombUpgrade //5
  item_Num+=global.metBombUpgrade //5
  itemC_Extra+=global.hasBoostedXCharge+global.itemFinder+global.metSpringBall+global.linkBombUpgrade+global.metBombUpgrade //13 total
}

if tItemChk=0 //Return %
  item_Num=(item_Num/item_Total)*100
else if tItemChk=2
  item_Num=item_Total

if tItemChk!=3
  return item_Num
