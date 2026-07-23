#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
setCollisionBounds(-6,-6,6,6)
image_speed=0.35

damageType="SHOT"
weaponTag=102
atkPower=200
bulletSpeed=24
stunTime=1

lifeTime=50
#define Destroy_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
for(i=0;i<3;i+=1)
{
  tEffect=instance_create(x+random_range(-3,3),y+random_range(-3,3),oEffect)
  tEffect.sprite_index=sSamusSMissileEffect
  tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
if global.gamePaused=false
{
  if place_meeting(x,y,oNightmareEffect) {bulletSpeed=12}
  else {bulletSpeed=24}
  speed=bulletSpeed
  if x<view_xview[0]
    instance_destroy()
  if x>view_xview[0]+view_wview[0]
    instance_destroy()

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
#define Other_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
instance_destroy()
