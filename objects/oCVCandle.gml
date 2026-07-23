#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_speed=0.33
#define Collision_oAttackBase
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
global.recObjectsBroken+=1
playSound(global.snd_BoxBreak,0,0.8,31000)
awardAwesome(10)
tEffect=instance_create(x,y,oEffect)
tEffect.sprite_index=sSamusCannonHit
tEffect.image_xscale=0.5; tEffect.image_yscale=0.5; tEffect.image_speed=0.5
tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0

tHeartDrop=instance_create(x,y,oWeaponPickup) //oCVEnergyPickup
tHeartDrop.sprite_index=sCVHeart
instance_destroy()
