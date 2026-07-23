#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
makeActive()
setCollisionBounds(-4,-4,4,4)

damageType="ELEMENTAL"
weaponTag=32
atkLv=global.stBelmont_Holywater[0]
atkPower=90+(global.stBelmont_Holywater[0]*2)+global.skillTree[12]
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
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
if global.gamePaused=false
{
  yVel+=0.4

  if checkScreenArea(x,y,48)=0 {instance_destroy()}
  if isCollisionLeft(1)
    bShatter=1
  if isCollisionRight(1)
    bShatter=1
  if isCollisionBottom(1)
    bShatter=1
  if isCollisionTop(1)
    bShatter=1

  moveTo(xVel,yVel)

  if global.optWeaponTrail=1 {instance_create(x,y,oEfWeaponTrail)}

  if bShatter=1
  {
    if checkScreenArea(x,y,64)=1 {playSound(global.snd_HolyWater,0,0.98,1)}
    var tExpLight;
    tExpLight=instance_create(x,y,oWepEf_Light); tExpLight.image_xscale=1.1; tExpLight.image_yscale=1.1
    var tBelmontExplode;
    tBelmontExplode=instance_create(x,bbox_bottom,oBelmontHWExplosion)
    tBelmontExplode.bTrail=bTrail
    if xVel>0 {tBelmontExplode.myDir=1}
    else {tBelmontExplode.myDir=-1}
    instance_destroy()
  }
}
