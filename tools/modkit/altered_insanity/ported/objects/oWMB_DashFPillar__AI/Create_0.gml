//Floor dash fire pillars
event_inherited()
image_speed=0

//Enemy base statistics
bShowHealthBar=false
bShowDamage=false
bCanTakeDamage=false
bCanDealDamage=false
damageType="EXPLOSION"
atkProg=0
atkTime=0

var tEffect,tScaling;
for(i=0;i<20;i+=1)
{
  tScaling=0.6+random(0.4)
  tEffect=instance_create(x-14+random(28),y,oEffect)
  tEffect.sprite_index=sMMSmokeCloud; tEffect.image_alpha=0.7+random(0.2); tEffect.image_speed=0.35
  tEffect.image_xscale=tScaling; tEffect.image_yscale=tScaling
  tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=-2-random(5)
}
