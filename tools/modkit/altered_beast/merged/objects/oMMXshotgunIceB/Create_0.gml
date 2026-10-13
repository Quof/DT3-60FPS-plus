event_inherited()
setCollisionBounds(-3,-3,3,3)
special=0
damageType="ELEMENTAL"
if global.TrueEnabled=1 and global.XIceTrue=1
{
	damageType="TRUE"
}
weaponTag=11
atkLv=global.stMega_ShotIce[0]
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
//atkPower=round((50+round(global.stMega_ShotIce[0]*1.5)+global.skillTree[10])*0.5)
atkPower=round((50+round(scrOmenLv(global.stMega_ShotIce[0])*1.5)+global.skillTree[10])*0.5) //dark omen change: the weapon level counts 10 lower while the New Dark Omen is on (scrOmenLv)
}
else
{
    atkPower=round((50+round((global.stMega_ShotIce[0]-10)*1.5))*0.5)
}

atkPower=weaponDmgMod(0,atkPower)
stunTime=3

bulletSpeed=11
lifeTime=35
bShatter=0
lingerFrame=0
alarm[0]=1

_speed=0
_direction=0
