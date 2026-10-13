event_inherited()
damageType="NORMAL"
weaponTag=30
atkLv=global.stBelmont_HairWhip[0]
//atkPower=105+round(global.stBelmont_HairWhip[0]*3)+(global.skillTree[11]*4)
atkPower=105+round(scrOmenLv(global.stBelmont_HairWhip[0])*3)+(global.skillTree[11]*4) //dark omen change: the weapon level counts 10 lower while the New Dark Omen is on (scrOmenLv)
atkPower=weaponDmgMod(1,atkPower)
stunTime=12+global.skillTree[26]
bCanPierce=1
global.recAtkNum+=1
global.stBelmont_HairWhip[2]+=1
