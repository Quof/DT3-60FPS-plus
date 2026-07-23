#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
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
  direction=80
}
else
{
  image_xscale=-1
  x-=12
  direction=100
}

if oPlayer1.yVel>0
{
  oPlayer1.yVel=0
  scrSlowFall(2,0.5,0)
}
bulletSpeed=12
arcTime=25
lifeTime=45
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
if global.gamePaused=false
{
  speed=bulletSpeed

  if arcTime>0
  {
    arcTime-=1
    if arcTime>20
    {
      if image_xscale=1
        direction-=3
      else
        direction+=3
    }
    else
    {
      if image_xscale=1
        direction-=6
      else
        direction+=6
    }
  }
  if image_xscale=1
    image_angle-=20
  else
    image_angle+=20

  if isCollisionLeft(1)
    instance_destroy()
  if isCollisionRight(1)
    instance_destroy()
  if isCollisionBottom(1)
    instance_destroy()
  if isCollisionTop(1)
    instance_destroy()
  lifeTime-=1
  if lifeTime=0
    instance_destroy()
}
else
  speed=0
