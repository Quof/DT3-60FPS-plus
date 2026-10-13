event_inherited()
setCollisionBounds(-6,-1,6,1)

damageType="PIERCE"
weaponTag=1
atkLv=global.stLink_Arrow[0]
var tCrossbow;
tCrossbow=1
for(i=0;i<3;i+=1)
{
  if global.equipJerry[i]=36 //Equipment: Crossbow
  {
    tCrossbow=1.5
    break;
  }
}
//atkPower=round((50+(round(global.stLink_Arrow[0]*1.5)+global.skillTree[9]))*tCrossbow)
atkPower=round((50+(round(scrOmenLv(global.stLink_Arrow[0])*1.5)+global.skillTree[9]))*tCrossbow) //dark omen change: the weapon level counts 10 lower while the New Dark Omen is on (scrOmenLv)
atkPower=weaponDmgMod(0,atkPower)
global.recAtkNum+=1
global.stLink_Arrow[2]+=1
stunTime=5

if oPlayer1.image_xscale=1
{
  bDir=0
  arrowProg=0
}
else
  bDir=1

bulletSpeed=0
_speed=0
_direction=0
bCollide=0
lingerFrame=0
arrowTick=0 //60fps change (added): the arrow's own 30fps tick count, so it turns once per tick (see the Step event)
//alarm[0]=1
alarm[0]=round(1/gDeltaTime) //60fps change: the speed is set one 30fps tick after creation, as at 30fps. Alarms count frames, so with 1 the arrow started moving after half/a quarter of a tick, having turned 2 degrees once instead of twice, and the whole arc flew ~2 degrees higher (over Army Eye)
