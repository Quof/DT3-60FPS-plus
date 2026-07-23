#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Requires: moveSpd
image_blend=c_red
lifeTime=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=0
{
  speed=moveSpd
  lifeTime+=1
}
else {speed=0}
#define Collision_oFB_PlayerPaddle
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.bOneHitKillMode=1 {oFB_PlayerPaddle.life-=10000}
else {oFB_PlayerPaddle.life-=25}
playSound(global.snd_PlayerDamaged[0],0,0.95,10000+random(3000))
tEffect=instance_create(x,y,oEffect)
tEffect.sprite_index=sEfPongBulBreak; tEffect.image_speed=0.25; tEffect.image_blend=image_blend
tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
instance_destroy()
#define Other_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if lifeTime>=45 {instance_destroy()}
