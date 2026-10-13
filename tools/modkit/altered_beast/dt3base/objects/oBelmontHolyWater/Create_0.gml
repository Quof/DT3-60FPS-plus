event_inherited()
makeActive()
setCollisionBounds(-4,-4,4,4)

damageType="ELEMENTAL"
weaponTag=32
atkLv=global.stBelmont_Holywater[0]
//atkPower=90+(global.stBelmont_Holywater[0]*2)+global.skillTree[12]
atkPower=90+(scrOmenLv(global.stBelmont_Holywater[0])*2)+global.skillTree[12] //dark omen change: the weapon level counts 10 lower while the New Dark Omen is on (scrOmenLv)
atkPower=weaponDmgMod(1,atkPower)
global.recAtkNum+=1
global.stBelmont_Holywater[2]+=1
stunTime=10

if oPlayer1.image_xscale=1
{
  x+=12
  xVel=3.5
  image_angle=330
}
else
{
  x-=12
  xVel=-3.5
  image_angle=30
}
yVel=-3

bShatter=0


_speed=0
_direction=0
_hspeed=0
_vspeed=0
