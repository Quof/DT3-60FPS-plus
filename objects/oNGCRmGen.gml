#define Collision_oAttackBase
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if other.weaponTag<100
{
  tFlash=instance_create(0,0,oScreenFlash)
  tFlash.image_alpha=0.6; tFlash.fadeSpeed=0.2

  for(i=0;i<64;i+=1)
  {
    tEffect=instance_create(x-24+random(48),y-random(80),oEffectB)
    tEffect.type=3; tEffect.sprite_index=sMMshotgunIceEffect
    tEffect.image_speed=0.5; tEffect.speed=random(4); tEffect.direction=random(360)
    tEffect.image_angle=random(360); tEffect.friction=random(0.1)+0.1; tEffect.fadeSpd=0.045
    tEffect.AccelX=0; tEffect.AccelY=0; tEffect.newBlend=-1; tEffect.followID=-1; tEffect.rotation=0
  }
  instance_destroy()
}
