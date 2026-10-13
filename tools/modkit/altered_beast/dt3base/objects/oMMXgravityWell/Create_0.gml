event_inherited()
setCollisionBounds(-7,-7,7,7)
image_speed=0.4

damageType="SPECIAL"
weaponTag=12
atkLv=global.stMega_Gravity[0]
//atkPower=45+round(global.stMega_Gravity[0]*1.5)+global.skillTree[10]
atkPower=45+round(scrOmenLv(global.stMega_Gravity[0])*1.5)+global.skillTree[10] //dark omen change: the weapon level counts 10 lower while the New Dark Omen is on (scrOmenLv)
atkPower=weaponDmgMod(0,atkPower)
global.recAtkNum+=1
global.stMega_Gravity[2]+=1
stunTime=5
bCanPierce=1
if oPlayer1.bWallGrab=1 {initFireDir*=-1}

bulletSpeed=4
lifeTime=50
gravityProg=0

_speed=0
_direction=0
