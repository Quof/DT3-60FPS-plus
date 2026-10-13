event_inherited()
setCollisionBounds(-3,-3,3,3)

damageType="ELEMENTAL"
weaponTag=11
atkLv=global.stMega_ShotIce[0]
//atkPower=round((50+round(global.stMega_ShotIce[0]*1.5)+global.skillTree[10])*0.75)
atkPower=round((50+round(scrOmenLv(global.stMega_ShotIce[0])*1.5)+global.skillTree[10])*0.75) //dark omen change: the weapon level counts 10 lower while the New Dark Omen is on (scrOmenLv)
atkPower=weaponDmgMod(0,atkPower)
stunTime=3

_speed=0
_direction=0
bulletSpeed=9
lifeTime=30
bShatter=0
lingerFrame=0
