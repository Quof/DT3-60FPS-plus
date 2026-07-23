#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
viscidTop=1
makeActive()
setCollisionBounds(1,0,sprite_width,sprite_height)
#define Collision_oAttackBase
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if other.damageType="NORMAL" and other.weaponTag<100
{
  playSound(global.snd_BoxBreak,0,0.94,1)
  awardAwesome(20)
  var tEffect;
  for(i=0;i<8;i+=1)
  {
    tEffect=instance_create(x+16+random_range(-12,12),y+16+random_range(-12,12),oEffectB)
    tEffect.type=3; tEffect.sprite_index=sMMSmokeCloud; tEffect.newBlend=-1; tEffect.image_alpha=0.75
    tEffect.direction=random(360); tEffect.speed=random(1)+0.5; tEffect.fadeSpd=0.025; tEffect.image_speed=0.25
    tEffect.AccelX=0; tEffect.AccelY=0; tEffect.followID=-1; tEffect.rotation=random_range(-5,5)
  }
  instance_destroy()
}
