//Evil Boss Gallery: the claw wave runs on (see Create)
if global.gamePaused=false
{
  t+=1*gDeltaTime
  x+=spd*dir*gDeltaTime
  image_xscale=dir
  if gDeltaDoTicks and (floor(t) mod 2)=0
  {
    var tEffect;
    tEffect=instance_create(x-dir*6,y+random_range(-2,2),oEffect)
    tEffect.sprite_index=sZeldaEnemyDie; tEffect.image_speed=0.3; tEffect.image_blend=c_gray
    tEffect.followID=-1; tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
  }
  if x<xMin or x>xMax {instance_destroy()}
}
