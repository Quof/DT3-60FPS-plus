#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
maxLife=150
life=maxLife
#define Collision_oAttackBase
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (other.damageType="ELEMENTAL" or other.damageType="SHOT" or other.damageType="EXPLOSION" or other.damageType="SPECIAL") and other.weaponTag<100
{
  life-=other.atkPower
  if other.damageType!="EXPLOSION" {with other {instance_destroy()}}
  if life<=0
  {
    awardAwesome(100)
    global.recObjectsBroken+=1
    if checkScreenArea(x,y,64)=1 {playSound(global.snd_BombExplode,0,0.9,1)}
    tEffect=instance_create(x+(sprite_width/2),y+(sprite_height/2),oEffect)
    tEffect.sprite_index=sShipExplosion; tEffect.followID=-1; tEffect.xFollow=0; tEffect.yFollow=0
    tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0; tEffect.image_speed=0.5
    tEffect.image_xscale=1.75; tEffect.image_yscale=1.75; tEffect.depth=30
    instance_destroy()
  }
}
