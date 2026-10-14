image_alpha=0.6
decayTime=180
shotDelay=0

//spsp ns
if room=rAbomF {instance_destroy()}

var tEffect,tDir;
tDir=0
for(i=0;i<24;i+=1)
{
  tEffect=instance_create(x+lengthdir_x(18,tDir),y+lengthdir_y(18,tDir),oEffect)
  tEffect.sprite_index=sEfDiffusionParticle; tEffect.followID=-1; tEffect.xFollow=0; tEffect.yFollow=0
  tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0; tEffect.image_alpha=0.33
  tEffect.image_speed=0.5; tEffect.speed=1.5; tEffect.direction=tDir
  tDir+=360/24
}
