event_inherited()
damageType="NORMAL"
image_xscale=2.7*oPlayer1.image_xscale
image_yscale=2.7
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
    atkPower=110+round(global.stBelmont_HairWhip[0]*3)+(global.skillTree[11]*4)
}
else
{
    atkPower=110+round((global.stBelmont_HairWhip[0]-10)*3)
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
special=1
rotateSpeed=36*oPlayer1.image_xscale
lifeTime=10
image_speed=0
