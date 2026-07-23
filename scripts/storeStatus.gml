/*
This script is called to store the player status.
argument0 is whether to read or write to the values
-- 0: write
-- 1: read
*/
var twr; twr=argument0
if argument0=0
{
  global.pStatusStore[0]=oPlayer1.life
  global.pStatusStore[1]=global.hudLink_Arrows[0]
  global.pStatusStore[2]=global.hudBelmont_WeaponEn[0]
  global.pStatusStore[3]=global.hudSamus_Missiles[0]
  global.pStatusStore[4]=global.hudGame_WeaponEn[0]
}
else if argument0=1
{
  oPlayer1.life=global.pStatusStore[0]
  global.hudLink_Arrows[0]=global.pStatusStore[1]
  global.hudBelmont_WeaponEn[0]=global.pStatusStore[2]
  global.hudSamus_Missiles[0]=global.pStatusStore[3]
  global.hudGame_WeaponEn[0]=global.pStatusStore[4]
}

var tBombEquipCheck;
tBombEquipCheck=0
for(i=0;i<3;i+=1)
{
  if global.equipJerry[i]=20
  {
    tBombEquipCheck=15
    break;
  }
}
global.hudLink_BombEn[0]=150-(global.skillTree[1]*15)-tBombEquipCheck
