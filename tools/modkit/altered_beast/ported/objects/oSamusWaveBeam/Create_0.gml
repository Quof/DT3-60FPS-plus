event_inherited()
setCollisionBounds(-2,-2,2,2)
bCanDealDamage=false

damageType="SHOT"
if global.TrueEnabled=1 and global.SamusCannonTrue=1
{
damageType="TRUE"
}
weaponTag=10
atkLv=global.stSamus_Cannon[0]
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
    atkPower=25+(global.stSamus_Cannon[0]*1.5)+global.skillTree[13]
}
else
{
    atkPower=25+((global.stSamus_Cannon[0]*1.5)-10)
}

atkPower=weaponDmgMod(1,atkPower)
basePower=atkPower
global.recAtkNum+=1
global.stSamus_Cannon[2]+=1
stunTime=3

bulletSpeed=12
lifeTime=50
lingerFrame=0
alarm[0]=1

_speed=0
_direction=0
_hspeed=0
_vspeed=0
weaponRehitTime=1
bCanPierce=1
special=1
