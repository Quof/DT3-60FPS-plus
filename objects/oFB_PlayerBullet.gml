#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_blend=c_blue
moveSpd=8
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  x+=moveSpd
  if x>=room_width+8 {instance_destroy()}
}
#define Collision_oFB_HexorPaddle
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
oFB_HexorPaddle.life-=5
playSound(global.snd_LightballSpread,0,0.95,9000+random(3000))
tEffect=instance_create(x,y,oEffect)
tEffect.sprite_index=sEfPongBulBreak; tEffect.image_speed=0.25; tEffect.image_blend=image_blend
tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
instance_destroy()
#define Collision_oFB_PongBullet
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
with other
{
  tEffect=instance_create(x,y,oEffect)
  tEffect.sprite_index=sEfPongBulBreak; tEffect.image_speed=0.25; tEffect.image_blend=image_blend
  tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
  instance_destroy()
}
playSound(global.snd_MarioBlockBreak,0,0.94,26000+random(8000))
tEffect=instance_create(x,y,oEffect)
tEffect.sprite_index=sEfPongBulBreak; tEffect.image_speed=0.25; tEffect.image_blend=image_blend
tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
instance_destroy()
