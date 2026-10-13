event_inherited()
setCollisionBounds(-4,-1,4,1)

damageType="PIERCE"
weaponTag=31
atkLv=global.stBelmont_Dagger[0]
//atkPower=65+(global.stBelmont_Dagger[0]*2)+global.skillTree[12]
atkPower=65+(scrOmenLv(global.stBelmont_Dagger[0])*2)+global.skillTree[12] //dark omen change: the weapon level counts 10 lower while the New Dark Omen is on (scrOmenLv)
atkPower=weaponDmgMod(1,atkPower)
global.recAtkNum+=1
global.stBelmont_Dagger[2]+=1
stunTime=7

_speed=0
_direction=0
_hspeed=0
_vspeed=0

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
