event_inherited()
setCollisionBounds(-5,-5,5,5)

damageType="THROW"
weaponTag=31
atkLv=global.stBelmont_Axe[0]
atkPower=global.stBelmont_Axe[3]
atkPower=weaponDmgMod(1,atkPower)
global.recAtkNum+=1
stunTime=6

if oPlayer1.image_xscale=1
{
  x+=12
  _direction=80
}
else
{
  image_xscale=-1
  x-=12
  _direction=100
}

if oPlayer1.yVel>0
{
  oPlayer1.yVel=0
  scrSlowFall(2,0.5,0)
}
bulletSpeed=12
arcTime=25
lifeTime=45

_speed=0
_direction=0
_hspeed=0
_vspeed=0
