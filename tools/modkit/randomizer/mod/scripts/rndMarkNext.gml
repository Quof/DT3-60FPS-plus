//Randomizer: marks the next free place of the game's own string for a kind of item (argument0: the item kind), so the
//pause menu's progress page and the item % count the items the player has. A place the game's general shop sells
//(oOtherShopA: it reads and marks its own) is skipped. The bomb upgrades share weaponBoosts: Link's 1-5, Samus' 6-10
var k,s,i,n,skip,lo,hi;
k=argument0
skip=-1
lo=1
hi=999
switch (k)
{
  case 1: s=global.heartPiece; skip=27; break
  case 2: case 3: s=global.chestMoney; break
  case 4: s=global.arrowQuiver; skip=21; break
  case 5: s=global.heartEnergy; skip=26; break
  case 6: s=global.missilePack; skip=12; break
  case 7: s=global.kiEnergy; break
  case 8: s=global.airUpgrade; break
  case 9: s=global.walletBoost; break
  case 10: s=global.weaponLevels; break
  case 11: s=global.apBoost; skip=42; break
  case 12: s=global.weaponBoosts; hi=5; break
  case 13: s=global.weaponBoosts; lo=6; break
  case 14: s=global.doorKey; break
  case 15: s=global.fullHeartContainer; break
  default: exit
}
n=string_length(s)
for(i=max(1,lo);i<=min(n,hi);i+=1)
{
  if i!=skip and string_char_at(s,i)="0"
  {
    s=rndSetChar(s,i,"1")
    break
  }
}
switch (k)
{
  case 1: global.heartPiece=s; break
  case 2: case 3: global.chestMoney=s; break
  case 4: global.arrowQuiver=s; break
  case 5: global.heartEnergy=s; break
  case 6: global.missilePack=s; break
  case 7: global.kiEnergy=s; break
  case 8: global.airUpgrade=s; break
  case 9: global.walletBoost=s; break
  case 10: global.weaponLevels=s; break
  case 11: global.apBoost=s; break
  case 12: case 13: global.weaponBoosts=s; break
  case 14: global.doorKey=s; break
  case 15: global.fullHeartContainer=s; break
}
