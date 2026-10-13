event_inherited()
damageType="NORMAL"
if global.TrueEnabled=1 and global.BelmontWhipTrue=1
{
	damageType="TRUE"
}
weaponTag=30
atkLv=global.stBelmont_HairWhip[0]
tAlterOmen=0
if global.alterEquip=1
{
    for(i=0;i<3;i+=1)
    {
      if global.equipJerry[i]=27 {tAlterOmen=1}
      if global.equipClaire[i]=27 {tAlterOmen=1}
    }
}
if tAlterOmen=0
{
//atkPower=105+round(global.stBelmont_HairWhip[0]*3)+(global.skillTree[11]*4)
atkPower=105+round(scrOmenLv(global.stBelmont_HairWhip[0])*3)+(global.skillTree[11]*4) //dark omen change: the weapon level counts 10 lower while the New Dark Omen is on (scrOmenLv)
}
else
{
    atkPower=105+round((global.stBelmont_HairWhip[0]-10)*3)
}
atkPower=weaponDmgMod(1,atkPower)
if tAlterOmen=0
{
stunTime=12+global.skillTree[26]
}
else
{
    stunTime=12
}

bCanPierce=1
global.recAtkNum+=1
global.stBelmont_HairWhip[2]+=1
rangeMod = 1
