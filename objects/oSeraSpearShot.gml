#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
image_speed=0.33
image_xscale=1.5
image_yscale=1.5

damageType="SHOT"
weaponTag=106
atkPower=50
bulletSpeed=16
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
  speed=bulletSpeed
  image_angle=direction
  lifeTime-=1
  if lifeTime=0 {instance_destroy()}
}
else {speed=0}
#define Other_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
instance_destroy()
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_sprite_ext(sprite_index,image_index,x,y,1,1,image_angle,image_blend,image_alpha)
