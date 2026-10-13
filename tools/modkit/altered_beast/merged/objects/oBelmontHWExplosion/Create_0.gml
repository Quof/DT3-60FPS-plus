event_inherited()
image_speed=0
image_xscale=2.5
image_yscale=2.5
damageType="ELEMENTAL"
if global.TrueEnabled=1 and global.BelmontWaterTrue=1
{
damageType="TRUE"
}
weaponTag=32
atkLv=global.stBelmont_Holywater[0]
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
//atkPower=round((90+(global.stBelmont_Holywater[0]*2)+global.skillTree[12])*1.25)
atkPower=round((90+(scrOmenLv(global.stBelmont_Holywater[0])*2)+global.skillTree[12])*1.25) //dark omen change: the weapon level counts 10 lower while the New Dark Omen is on (scrOmenLv)
}
else
{
    atkPower=round((90+((global.stBelmont_Holywater[0]-10)*2))*1.25)
}

atkPower=weaponDmgMod(1,atkPower)
stunTime=15
bCanPierce=1
trailSpd=4


_speed=0
_direction=0
_hspeed=0
_vspeed=0


if global.alterEquip=1
{
      for(i=0;i<3;i+=1)
        if global.equipClaire[i]=39
            weakenTime=90
}
