if isCollisionWaterTop(0)
{
  if checkScreenArea(x,y,64)=1 {playSound(global.snd_LinkBomb,0,0.92,10000)}
  tEffect=instance_create(x,y,oEffect)
  tEffect.sprite_index=sSamusSMissileEffect; tEffect.image_speed=0.5
  tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
}
else
{
  if checkScreenArea(x,y,64)=1 {playSound(global.snd_BombExplode,0,0.92,20000)}
  var tExpLight;
  tExpLight=instance_create(x,y,oWepEf_Light); tExpLight.image_xscale=3.5; tExpLight.image_yscale=3.5
  boom=instance_create(x,y,oLinkBExplosion)
  boom.special=1
}
instance_destroy()
      
