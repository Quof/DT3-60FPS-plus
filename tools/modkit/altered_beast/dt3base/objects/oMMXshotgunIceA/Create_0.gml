event_inherited()
setCollisionBounds(-5,-5,5,5)

damageType="ELEMENTAL"
weaponTag=11
atkLv=global.stMega_ShotIce[0]
//atkPower=50+round(global.stMega_ShotIce[0]*1.5)+global.skillTree[10]
atkPower=50+round(scrOmenLv(global.stMega_ShotIce[0])*1.5)+global.skillTree[10] //dark omen change: the weapon level counts 10 lower while the New Dark Omen is on (scrOmenLv)
atkPower=weaponDmgMod(0,atkPower)
global.recAtkNum+=1
global.stMega_ShotIce[2]+=1
stunTime=3
if oPlayer1.bWallGrab=1 {initFireDir*=-1}

bulletSpeed=11
lifeTime=35
lingerFrame=0
