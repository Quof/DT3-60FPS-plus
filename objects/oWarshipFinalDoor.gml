#define Collision_oJMechShotA
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
playSound(global.snd_EnemyDieMM,0,1,1)
tEffect=instance_create(x+16,y+16,oEffect)
tEffect.sprite_index=sMMExplosion; tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
tEffect=instance_create(x+16,y+48,oEffect)
tEffect.sprite_index=sMMExplosion; tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0

instance_destroy()
