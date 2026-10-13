event_inherited()
setCollisionBounds(-2,-2,2,2)

damageType="SPECIAL"
if global.TrueEnabled=1 and global.XGravTrue=1
{
	damageType="TRUE"
}
weaponTag=12
atkLv=global.stMega_Gravity[0]
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
//atkPower=round((45+round(global.stMega_Gravity[0]*1.5)+global.skillTree[10])/2)
atkPower=round((45+round(scrOmenLv(global.stMega_Gravity[0])*1.5)+global.skillTree[10])/2) //dark omen change: the weapon level counts 10 lower while the New Dark Omen is on (scrOmenLv)
}
else
{
    atkPower=round((45+round((global.stMega_Gravity[0]-10)*1.5))/2)
}

atkPower=weaponDmgMod(0,atkPower)
stunTime=4

bCanHitSwitch=0
bulletSpeed=14
lifeTime=40
lingerFrame=0
alarm[0]=1


_speed=0
_direction=0
