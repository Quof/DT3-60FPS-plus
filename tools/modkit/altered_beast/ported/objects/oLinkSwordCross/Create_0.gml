event_inherited()
damageType="NORMAL"
if global.TrueEnabled=1 and global.LinkSwordTrue=1
{
    damageType="TRUE"
}
weaponTag=0
atkLv=global.stLink_Sword[0]
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
    atkPower=120+round(global.stLink_Sword[0]*3)+(global.skillTree[8]*6)
}
else
{
    atkPower=120+round((global.stLink_Sword[0]-10)*3)
}
atkPower=weaponDmgMod(0,atkPower)
if tAlterOmen=0
{
    stunTime=5+global.skillTree[0]
}
else
{
    stunTime=5
}

bCanPierce=1
global.recAtkNum+=1
global.stLink_Sword[2]+=1
image_yscale = 1.5
