event_inherited()
damageType="ELEMENTAL"
if global.TrueEnabled=1 and global.LinkArrowTrue=1
{
    damageType="TRUE"
}
weaponTag=42
atkLv=0
maxSpd=5
spdDecay = 0
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
    atkPower=round(50+(round(global.stLink_Arrow[0]*2)))
}
else
{
    atkPower=round(50+(round((global.stLink_Arrow[0]-10)*2)))
}
atkPower=weaponDmgMod(0,atkPower)

stunTime=2
bCanPierce=1




//direction=90
_direction=90 //60fps change: moves by _speed/_direction (correctSpeedDirection in the step)
special=1
active=false
alarm[0]=1
