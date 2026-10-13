event_inherited()
setCollisionBounds(-2,-2,2,2)
image_speed=0.5
bCanDealDamage=false

damageType="SHOT"
if global.TrueEnabled=1 and global.XBusterTrue=1
{
	damageType="TRUE"
}
weaponTag=10
atkLv=global.stMega_Buster[0]
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
    atkPower=10+(global.stMega_Buster[0]*0.5)+global.skillTree[10]
}
else
{
    atkPower=10+((global.stMega_Buster[0]-10) * 0.5)
}

atkPower=weaponDmgMod(0,atkPower)
stunTime=1
if oPlayer1.bWallGrab=1 {initFireDir*=-1}

bulletSpeed=0
lifeTime=60
image_speed=1
alarm[0]=1
special=1
weaponRehitTime=5
speed=0
bCanPierce=1
