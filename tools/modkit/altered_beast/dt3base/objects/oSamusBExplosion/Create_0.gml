event_inherited()
image_speed=0.75
damageType="EXPLOSION"
weaponTag=42
atkLv=global.stSamus_Bomb[0]
//atkPower=75+round(global.stSamus_Bomb[0]*2)+global.skillTree[13]
atkPower=75+round(scrOmenLv(global.stSamus_Bomb[0])*2)+global.skillTree[13] //dark omen change: the weapon level counts 10 lower while the New Dark Omen is on (scrOmenLv)
atkPower=weaponDmgMod(1,atkPower)
//stunTime=13+round(global.stSamus_Bomb[0]/2)
stunTime=13+round(scrOmenLv(global.stSamus_Bomb[0])/2) //dark omen change: the weapon level counts 10 lower while the New Dark Omen is on (scrOmenLv)
bCanPierce=1
bCanBoost=1
image_xscale=1+(global.metBombUpgrade*0.07)
image_yscale=1+(global.metBombUpgrade*0.07)

_speed=0
_direction=0
_hspeed=0
_vspeed=0
