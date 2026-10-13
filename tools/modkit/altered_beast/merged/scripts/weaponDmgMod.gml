/*
This script is used to find damage mods from skills and equipment for player weapons
argument0: Which character is throwing the weapon
argument1: Damage before mods
*/

var tCharWep,tCurrDmg,tDmgMod,tEqpAdj,tCurseCheck;
tCharWep=argument0
tCurrDmg=argument1
tEqpAdj=0
tCurseCheck=0
tDmgMod=1
tAlterOmen=0
if global.alterEquip=1
{
    for(i=0;i<3;i+=1)
    {
      if global.equipJerry[i]=27 {tAlterOmen=1}
      if global.equipClaire[i]=27 {tAlterOmen=1}
    }
}

if tCharWep=0 //---------- Jerry ----------
{
  if (global.alterEquip=0)
{
  for(i=0;i<3;i+=1)
  {
    if global.equipJerry[i]=1 {tEqpAdj+=0.05} //Equipment: Magic Sword
    else if global.equipJerry[i]=2 {tEqpAdj+=0.1} //Equipment: Sword Bravery
    else if global.equipJerry[i]=3 {tEqpAdj+=0.15} //Equipment: Power Glove
    else if global.equipJerry[i]=18 {tEqpAdj-=0.1} //Equipment: Plot Armor (-10% damage)

    if global.challengeRoom>0 //Cursed Equipment
    {
      if global.equipJerry[i]=10 {tCurseCheck+=1}
      else if global.equipJerry[i]=11 {tCurseCheck+=1}
      else if global.equipJerry[i]=12 {tCurseCheck+=1}
    }
  }
  }
  tDmgMod=1+(global.skillTree[20]*0.02+tEqpAdj)
}
else if tCharWep=1 //---------- Claire ----------
{
  if (global.alterEquip=0)
{
  for(i=0;i<3;i+=1)
  {
    if global.equipClaire[i]=1 {tEqpAdj+=0.05} //Equipment: Magic Sword
    else if global.equipClaire[i]=2 {tEqpAdj+=0.1} //Equipment: Sword Bravery
    else if global.equipClaire[i]=3 {tEqpAdj+=0.15} //Equipment: Power Glove
    else if global.equipClaire[i]=18 {tEqpAdj-=0.1} //Equipment: Plot Armor (-10% damage)

    if global.challengeRoom>0 //Cursed Equipment
    {
      if global.equipClaire[i]=10 {tCurseCheck+=1}
      else if global.equipClaire[i]=11 {tCurseCheck+=1}
      else if global.equipClaire[i]=12 {tCurseCheck+=1}
    }
  }
  }
  tDmgMod=1+(global.skillTree[21]*0.02+tEqpAdj)
}

if (tAlterOmen=1)
{
    tDmgMod=1
}
if oPlayer1.battleRage>0
{
    tDmgMod+=0.15
}
tCurrDmg*=tDmgMod
if tCurseCheck=3 {tCurrDmg*=2}

return(tCurrDmg);
