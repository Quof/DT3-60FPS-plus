event_inherited()
damageType="NORMAL"
weaponTag=0
atkLv=global.stLink_Sword[0]
//atkPower=100+round(global.stLink_Sword[0]*2.5)+(global.skillTree[8]*6)
atkPower=100+round(scrOmenLv(global.stLink_Sword[0])*2.5)+(global.skillTree[8]*6) //dark omen change: the weapon level counts 10 lower while the New Dark Omen is on (scrOmenLv)
atkPower=weaponDmgMod(0,atkPower)
stunTime=8+global.skillTree[0]
bCanPierce=1
global.recAtkNum+=1
global.stLink_Sword[2]+=1
