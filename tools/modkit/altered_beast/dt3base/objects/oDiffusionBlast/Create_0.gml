event_inherited()
setCollisionBounds(-6,-2,6,2)
image_speed=0.5

damageType="SPECIAL"
weaponTag=41
atkLv=global.stSamus_Missile[0]
//atkPower=75+global.stSamus_Missile[0]+global.skillTree[13]
atkPower=75+scrOmenLv(global.stSamus_Missile[0])+global.skillTree[13] //dark omen change: the weapon level counts 10 lower while the New Dark Omen is on (scrOmenLv)
atkPower=weaponDmgMod(1,atkPower)
stunTime=12
weaponRehitTime=30
bCanPierce=1
blastDamage=0

_speed=0
_direction=0
_hspeed=0
_vspeed=0
