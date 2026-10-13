event_inherited()
setCollisionBounds(-6,-2,6,2)
image_speed=0.5

damageType="SPECIAL"
weaponTag=41
atkLv=global.stSamus_Missile[0]
//atkPower=75+global.stSamus_Missile[0]+global.skillTree[13]
atkPower=75+scrOmenLv(global.stSamus_Missile[0])+global.skillTree[13] //dark omen change: the weapon level counts 10 lower while the New Dark Omen is on (scrOmenLv)
atkPower=weaponDmgMod(1,atkPower)
global.recAtkNum+=1
global.stSamus_Missile[2]+=1
stunTime=12
bulletSpeed=3
lifeTime=55
lingerFrame=0
alarm[0]=1

_speed=0
_direction=0
_hspeed=0
_vspeed=0
