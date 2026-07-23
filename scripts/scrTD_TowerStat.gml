/*
Initializes stats for a tower being summoned.
use: scrTD_TowerStat(tower,util)

argument0: which tower to use
argument1: 0=construct, 1=upgrade, 2=deploy price, 3=upgrade price

return: nothing unless getting a price check
*/

var tTowerChk,tTowerUtil;
tTowerChk=argument0
tTowerUtil=argument1

if tTowerUtil=0 //-------------------- Construct --------------------
{
  turLevel=1
  if tTowerChk=1
  {
    type="GROUND"
    turPower=100
    turFireRate=1.5
    turCost=100
  }
  else if tTowerChk=2
  {
    sprite_index=sTurret_Float
    type="FLOAT"
    turPower=85
    turFireRate=1
    turCost=120
  }
  else if tTowerChk=3
  {
    sprite_index=sTurret_Air
    type="AIR"
    turPower=40
    turFireRate=2
    turCost=130
  }
  else if tTowerChk=4
  {
    sprite_index=sTurret_Shock
    type="SHOCK"
    turPower=20
    turFireRate=0.75
    turCost=140
  }
  else if tTowerChk=5
  {
    sprite_index=sTurret_Mega
    type="MEGA"
    turPower=450
    turFireRate=0.2
    turCost=250
  }
}
else if tTowerUtil=1 //-------------------- Upgrade --------------------
{
  turLevel+=1
  if tTowerChk=1
  {
    turPower+=15
    turFireRate+=0.2
  }
  else if tTowerChk=2
  {
    turPower+=13
    turFireRate+=0.16
  }
  else if tTowerChk=3
  {
    turPower+=5
    turFireRate+=0.35
  }
  else if tTowerChk=4
  {
    turPower+=6
    turFireRate+=0.05
  }
  else if tTowerChk=5
  {
    turPower+=35
    turFireRate+=0.02
  }
}
else if tTowerUtil=2 //-------------------- Deploy Price --------------------
{
  if tTowerChk=1 {turCost=100}
  else if tTowerChk=2 {turCost=120}
  else if tTowerChk=3 {turCost=130}
  else if tTowerChk=4 {turCost=140}
  else if tTowerChk=5 {turCost=250}
  return turCost;
}
else if tTowerUtil=3 //-------------------- Upgrade Price --------------------
{
  if tTowerChk=1 {turCost=50+(90*turLevel)}
  else if tTowerChk=2 {turCost=60+(110*turLevel)}
  else if tTowerChk=3 {turCost=60+(120*turLevel)}
  else if tTowerChk=4 {turCost=70+(130*turLevel)}
  else if tTowerChk=5 {turCost=150+(200*turLevel)}
  return turCost;
}
