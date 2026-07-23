#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
setCollisionBounds(-5,-5,5,5)

damageType="EXPLOSION"
weaponTag=104
atkPower=100
stunTime=1
bounces=0
#define Destroy_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
playSound(global.snd_Bobomb,0,1,1)
tEffect=instance_create(x,y,oEffect)
tEffect.sprite_index=sBombExplosion; tEffect.image_xscale=0.75; tEffect.image_yscale=0.75
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
  image_angle+=3
  yVel+=0.2
  if isCollisionBottom(1)
  {
    bounces+=1
    if bounces=1 {yVel=-3.75}
    else if bounces=2 {yVel=-2.75}
    else if bounces>=3 {instance_destroy()}
  }
  moveTo(xVel,yVel)
}
#define Other_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
instance_destroy()
