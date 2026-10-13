event_inherited()
makeActive()
setCollisionBounds(-4,-4,4,4)
special=0
damageType="ELEMENTAL"
if global.TrueEnabled=1 and global.BelmontWaterTrue=1
{
	damageType="TRUE"
}
weaponTag=32
atkLv=global.stBelmont_Holywater[0]
tAlterOmen=0
if global.alterEquip=1
{
    for(i=0;i<3;i+=1)
    {
      if global.equipJerry[i]=27 {tAlterOmen=1}
      if global.equipClaire[i]=27 {tAlterOmen=1}
    }
}
if tAlterOmen=0
{
//atkPower=90+(global.stBelmont_Holywater[0]*2)+global.skillTree[12]
atkPower=90+(scrOmenLv(global.stBelmont_Holywater[0])*2)+global.skillTree[12] //dark omen change: the weapon level counts 10 lower while the New Dark Omen is on (scrOmenLv)
}
else
{
    atkPower=90+((global.stBelmont_Holywater[0]-10)*2)
}

atkPower=weaponDmgMod(1,atkPower)
global.recAtkNum+=1
global.stBelmont_Holywater[2]+=1
stunTime=10

if oPlayer1.image_xscale=1
{
  x+=12
  xVel=3.5
  image_angle=330
}
else
{
  x-=12
  xVel=-3.5
  image_angle=30
}
yVel=-3

bShatter=0


_speed=0
_direction=0
_hspeed=0
_vspeed=0
