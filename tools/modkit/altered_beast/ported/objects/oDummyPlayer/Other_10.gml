//spawn in poof
var tEffect;
tEffect=instance_create(x,y-(sprite_height/2),oEffect)
tEffect.sprite_index=sDustCloud; tEffect.followID = -1
tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0; tEffect.image_speed=2
