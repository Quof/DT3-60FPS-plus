/*
This script is used to check which weapon dealt damage
use: checkWeaponHit(pWeapon_id)

argument0: Player Weapon id
*/
var tPWepId;
tPWepId=argument0

//find which ability was used
if tPWepId.weaponTag=0
{
  if global.hudLink_BombEn[0]<120 {global.hudLink_BombEn[0]+=2}
  global.stLink_Sword[1]+=1
}
else if tPWepId.weaponTag=1 {global.stLink_Arrow[1]+=1}
else if tPWepId.weaponTag=2 {global.stLink_Bomb[1]+=1}
else if tPWepId.weaponTag=10 {global.stMega_Buster[1]+=1}
else if tPWepId.weaponTag=11 {global.stMega_ShotIce[1]+=1}
else if tPWepId.weaponTag=12 {global.stMega_Gravity[1]+=1}
else if tPWepId.weaponTag=20 {global.stJGame_A[1]+=1}
else if tPWepId.weaponTag=21 {global.stJGame_B[1]+=1}
else if tPWepId.weaponTag=30
{
  if global.hudBelmont_WeaponEn[0]<global.hudBelmont_WeaponEn[1] {global.hudBelmont_WeaponEn[0]+=1}
  for(i=0;i<3;i+=1)
  {
    if global.equipClaire[i]=28
    {
      global.hudBelmont_WeaponEn[0]+=3
      if global.hudBelmont_WeaponEn[0]>global.hudBelmont_WeaponEn[1] {global.hudBelmont_WeaponEn[0]=global.hudBelmont_WeaponEn[1]}
      break;
    }
  }
  global.stBelmont_HairWhip[1]+=1
}
else if tPWepId.weaponTag=31 {global.stBelmont_Dagger[1]+=1}
else if tPWepId.weaponTag=32 {global.stBelmont_Holywater[1]+=1}
else if tPWepId.weaponTag=40 {global.stSamus_Cannon[1]+=1}
else if tPWepId.weaponTag=41 {global.stSamus_Missile[1]+=1}
else if tPWepId.weaponTag=42 {global.stSamus_Bomb[1]+=1}
else if tPWepId.weaponTag=50 {global.stCGame_A[1]+=1}
else if tPWepId.weaponTag=51 {global.stCGame_B[1]+=1}
