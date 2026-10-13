var tExpLight;
tExpLight=instance_create(x,y,oWepEf_Light); tExpLight.image_xscale=0.75; tExpLight.image_yscale=0.75


  tEffect=instance_create(x,y,oEffect)
  tEffect.sprite_index=sSamusSMissileHit; tEffect.image_speed=0.5; tEffect.depth=6
  tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
  instance_create(x,y,oSamusDiffusionManager)
