#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
setCollisionBounds(-2,-2,2,2)

damageType="SHOT"
weaponTag=20
atkLv=global.stJGame_A[0]
atkPower=15+(global.stJGame_C[1]*2)
atkPower=weaponDmgMod(0,atkPower)
global.recAtkNum+=1
global.stJGame_A[2]+=1
stunTime=1

if global.stJGame_C[0]>=4000
{
  bulletSpeed=15
  lifeTime=12
}
else
{
  bulletSpeed=14
  lifeTime=10
}

if oPlayer1.image_xscale=1
{
  direction=random_range(-6,6)
}
else
{
  direction=random_range(174,186)
}
#define Destroy_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
tEffect=instance_create(x,y,oEffect)
tEffect.sprite_index=sSamusCannonHit; tEffect.depth=5
tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
if global.gamePaused=false
{
  image_angle=direction
  speed=bulletSpeed

  if global.optWeaponTrail=1 {instance_create(x,y,oEfWeaponTrail)}

  if checkScreenArea(x,y,32)=0 {instance_destroy()}

  lifeTime-=1
  if lifeTime<=0 {instance_destroy()}
  if isCollisionLeft(1)
    instance_destroy()
  if isCollisionRight(1)
    instance_destroy()
  if isCollisionBottom(1)
    instance_destroy()
  if isCollisionTop(1)
    instance_destroy()
}
else {speed=0}
