event_inherited()
setCollisionBounds(-4,-1,4,1)

damageType="PIERCE"
if global.TrueEnabled=1 and global.BelmontKnifeTrue=1
{
damageType="TRUE"
}
weaponTag=31
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
    atkPower=100+(global.stBelmont_Dagger[0]*2.5)+global.skillTree[12]
}
else
{
    atkPower=100+((global.stBelmont_Dagger[0]-10)*2.5)
}

atkPower=weaponDmgMod(1,atkPower)
global.recAtkNum+=1
global.stBelmont_Dagger[2]+=1
stunTime=9

if oPlayer1.image_xscale=1
  x+=10
else
{
  image_xscale=-1
  x-=10
  _direction=180
}

bCollide=0
//bulletSpeed=15
lifeTime=45
lingerFrame=0

_speed=0
_direction=0
_hspeed=0
_vspeed=0
special=1
