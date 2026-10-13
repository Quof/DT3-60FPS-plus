event_inherited()
setCollisionBounds(-2,-2,2,2)
image_speed=0.5
bCanDealDamage=false

damageType="SHOT"
weaponTag=10
atkLv=global.stMega_Buster[0]
//atkPower=30+global.stMega_Buster[0]+global.skillTree[10]
atkPower=30+scrOmenLv(global.stMega_Buster[0])+global.skillTree[10] //dark omen change: the weapon level counts 10 lower while the New Dark Omen is on (scrOmenLv)
atkPower=weaponDmgMod(0,atkPower)
global.recAtkNum+=1
global.stMega_Buster[2]+=1
stunTime=1
if oPlayer1.bWallGrab=1 {initFireDir*=-1}

bulletSpeed=12
lifeTime=50
lingerFrame=0
alarm[0]=1

_direction=0
_speed=0
