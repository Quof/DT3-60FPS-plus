event_inherited()
setCollisionBounds(-2,-2,2,2)

damageType="SPECIAL"
weaponTag=12
atkLv=global.stMega_Gravity[0]
//atkPower=round((45+round(global.stMega_Gravity[0]*1.5)+global.skillTree[10])/2)
atkPower=round((45+round(scrOmenLv(global.stMega_Gravity[0])*1.5)+global.skillTree[10])/2) //dark omen change: the weapon level counts 10 lower while the New Dark Omen is on (scrOmenLv)
atkPower=weaponDmgMod(0,atkPower)
stunTime=4

bCanHitSwitch=0
bulletSpeed=14
lifeTime=40
lingerFrame=0
alarm[0]=1


_speed=0
_direction=0
