#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()

weaponTag=109
atkPower=750
stunTime=10
lifeTime=150
#define Destroy_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
playSound(global.snd_BombExplode,0,0.95,19000)
var tEffect;
tEffect=instance_create(x,y,oEffect)
tEffect.sprite_index=sBombExplosion; tEffect.image_speed=0.5; tEffect.image_xscale=2; tEffect.image_yscale=2
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
  speed=moveSpd
  lifeTime-=1
  if lifeTime<=0 {instance_destroy()}
}
else {speed=0}
