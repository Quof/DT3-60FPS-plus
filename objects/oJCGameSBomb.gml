#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
setCollisionBounds(-4,-4,4,4)
bCanDealDamage=false
image_speed=0.5

damageType="EXPLOSION"
weaponTag=21
atkLv=global.stJGame_B[0]
atkPower=20+global.stJGame_B[0]
atkPower=weaponDmgMod(0,atkPower)
global.recAtkNum+=1
stunTime=1
bCanHitSwitch=0

xVel=random_range(-2,2)
yVel=-6.5-random(3)
timeTillDamage=0
#define Destroy_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
tEffect=instance_create(x,y,oEffect)
tEffect.sprite_index=sJCGameBombExplosion; tEffect.image_speed=0.5; tEffect.image_alpha=0.5
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
  timeTillDamage+=1
  if timeTillDamage=4 {bCanDealDamage=true}

  if yVel<16 {yVel+=0.3}

  hspeed=xVel; vspeed=yVel
  image_angle=direction
  hspeed=0; vspeed=0
  if oGame.time mod 8=0
  {
    var tEffect;
    tEffect=instance_create(x,y,oEffect)
    tEffect.sprite_index=sSamusMissileEffect; tEffect.image_speed=0.5; tEffect.image_alpha=0.5
    tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
  }

  moveTo(xVel,yVel)

  if isCollisionLeft(1)
    instance_destroy()
  if isCollisionRight(1)
    instance_destroy()
  if isCollisionBottom(1)
    instance_destroy()
  if isCollisionTop(1)
    instance_destroy()
  if y>=room_height+24
    instance_destroy()
}
