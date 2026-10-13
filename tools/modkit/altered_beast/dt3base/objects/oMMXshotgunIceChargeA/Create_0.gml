event_inherited()
setCollisionBounds(-12,-12,12,12)

damageType="ELEMENTAL"
weaponTag=11
atkLv=global.stMega_ShotIce[0]
//atkPower=round((50+round(global.stMega_ShotIce[0]*1.5)+global.skillTree[10])*1.5)
atkPower=round((50+round(scrOmenLv(global.stMega_ShotIce[0])*1.5)+global.skillTree[10])*1.5) //dark omen change: the weapon level counts 10 lower while the New Dark Omen is on (scrOmenLv)
atkPower=weaponDmgMod(0,atkPower)
global.recAtkNum+=1
global.stMega_ShotIce[2]+=1
stunTime=3
bCanPierce=1
_direction=90
bulletSpeed=3
lifeTime=40
bShatter=0
lingerFrame=0
