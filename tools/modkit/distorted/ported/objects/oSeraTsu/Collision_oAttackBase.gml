if enemyDeflect(1,1,1,1,1,1)=1 and sprite_index=sSeraSpearSpin
{
  playSound(global.snd_MMBulletDeflect,0,1,1)
  var tEffect;
  tEffect=instance_create(x+random_range(-11,11),y-4-random(44),oEffect)
  tEffect.sprite_index=sMMchargeComplete
  tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
}
else {event_inherited()}
