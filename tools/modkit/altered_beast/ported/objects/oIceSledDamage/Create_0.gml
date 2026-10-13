setCollisionBounds(-20,-8,20,8)
event_inherited()
special=0
damageType="ELEMENTAL"
if global.TrueEnabled=1 and global.XIceTrue=1
{
damageType="TRUE"
}
weaponTag=11
atkLv=global.stMega_ShotIce[0]
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
    atkPower=100+round(global.stMega_ShotIce[0]*2.5)+global.skillTree[10]
}
else
{
    atkPower=100+round((global.stMega_ShotIce[0]-10)*2.5)
}
atkPower=weaponDmgMod(0,atkPower)
global.recAtkNum+=1
global.stMega_ShotIce[2]+=1
stunTime=3
if oPlayer1.bWallGrab=1 {initFireDir*=-1}
bCanPierce=0
image_xscale = oPlayer1.image_xscale
