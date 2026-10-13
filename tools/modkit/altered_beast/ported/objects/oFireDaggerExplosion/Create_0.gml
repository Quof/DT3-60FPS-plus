event_inherited()
image_speed=0.75
damageType="EXPLOSION"
if global.TrueEnabled=1 and global.BelmontKnifeTrue=1
{
damageType="TRUE"
}
weaponTag=2
atkLv=global.stBelmont_Dagger[0]
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
    atkPower=100+(global.stBelmont_Dagger[0]*2.5)
}
else
{
    atkPower=100+((global.stBelmont_Dagger[0]-10)*2.5)
}

atkPower=weaponDmgMod(0,atkPower)

stunTime=7

bCanPierce=1


image_xscale=1
image_yscale=1

if global.alterEquip=1
{
    if global.activeCharacter=1
    {
      for(i=0;i<3;i+=1)
      {
        if global.equipClaire[i]=15 {weakenTime=90} //Equipment: Bomber Jacket
      }
    }
}

if global.alterEquip=1
{
    if global.activeCharacter=0
    {
      for(i=0;i<3;i+=1)
      {
        if global.equipClaire[i]=24
        {
            image_xscale*=2
            image_yscale*=2
            atkPower*=0.7
        }
      }
    }
}
special=1
