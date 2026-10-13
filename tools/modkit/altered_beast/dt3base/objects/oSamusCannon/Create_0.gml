event_inherited()
setCollisionBounds(-2,-2,2,2)
bCanDealDamage=false

damageType="SHOT"
weaponTag=40
atkLv=global.stSamus_Cannon[0]
//atkPower=30+global.stSamus_Cannon[0]+global.skillTree[13]
atkPower=30+scrOmenLv(global.stSamus_Cannon[0])+global.skillTree[13] //dark omen change: the weapon level counts 10 lower while the New Dark Omen is on (scrOmenLv)
atkPower=weaponDmgMod(1,atkPower)
basePower=atkPower
global.recAtkNum+=1
global.stSamus_Cannon[2]+=1
stunTime=3

bulletSpeed=11.5
lifeTime=50
lingerFrame=0
alarm[0]=1

_speed=0
_direction=0
_hspeed=0
_vspeed=0
