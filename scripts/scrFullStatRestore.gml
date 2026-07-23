//Fully restore all player stats to max

var tEquipA;
tEquipA=0
for(i=0;i<3;i+=1)
{
  if global.equipJerry[i]=20
  {
    tEquipA=15
    break;
  }
}
global.pLife=global.pMaxLife
oPlayer1.life=global.pLife
global.hudLink_Arrows[0]=global.hudLink_Arrows[1]
global.hudLink_BombEn[0]=150-(global.skillTree[1]*15)-tEquipA
global.hudBelmont_WeaponEn[0]=global.hudBelmont_WeaponEn[1]
global.hudMega_BusterEn[0]=32
global.hudMega_ShotIceEn[0]=32
global.hudMega_GravityEn[0]=32
global.hudSamus_CannonEn[0]=0
global.hudSamus_Missiles[0]=global.hudSamus_Missiles[1]
global.hudGame_WeaponEn[0]=global.hudGame_WeaponEn[1]
