///kill arms and segments with blue worm effects
with oAbomFieldSegA
{
  var tEffect,tScale;
  for(i=0;i<8;i+=1)
  {
    tScale=random(0.17)
    tEffect=instance_create(x+random_range(-16,16),y+random_range(-16,16),oEffect)
    tEffect.sprite_index=sAbom_Tentacle; tEffect.image_speed=0.33; tEffect.image_alpha=0.75
    tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=30+(i*2); tEffect.xSpd=random_range(-2,2); tEffect.ySpd=random_range(-2,2)
    tEffect.image_xscale=0.33+tScale; tEffect.image_yscale=0.33+tScale; tEffect.image_angle=random(360)
  }
  instance_destroy()
}
with oAbomFieldArmA
{
  var tEffect,tScale;
  for(i=0;i<8;i+=1)
  {
    tScale=random(0.17)
    tEffect=instance_create(x+random_range(-16,16),y+random_range(-16,16),oEffect)
    tEffect.sprite_index=sAbom_Tentacle; tEffect.image_speed=0.33; tEffect.image_alpha=0.75
    tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=30+(i*2); tEffect.xSpd=random_range(-2,2); tEffect.ySpd=random_range(-2,2)
    tEffect.image_xscale=0.33+tScale; tEffect.image_yscale=0.33+tScale; tEffect.image_angle=random(360)
  }
  instance_destroy()
}
