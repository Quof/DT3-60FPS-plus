//Evil Boss Gallery: the rock: dust and shadow (prog 0), falling (1)
if global.gamePaused=false
{
  t+=1*gDeltaTime
  if prog=0
  {
    if gDeltaDoTicks and (floor(t) mod 3)=0
    {
      var tEffect;
      tEffect=instance_create(x+random_range(-8,8),y,oEffect)
      tEffect.sprite_index=sZeldaEnemyDie; tEffect.image_speed=0.3; tEffect.image_blend=c_gray
      tEffect.followID=-1; tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=1
    }
    if t>=warn {prog=1; bCanDealDamage=true}
  }
  else
  {
    y+=8*gDeltaTime
    image_angle+=6*gDeltaTime
    if y+11>=yLand and position_meeting(x,yLand+4,oSolid)
    {
      playSound(global.snd_HardHit2,0,0.8,1)
      var tEffect,k;
      for(k=0;k<4;k+=1)
      {
        tEffect=instance_create(x,yLand-6,oEffectGrav)
        tEffect.sprite_index=sSmallBoulder; tEffect.image_xscale=0.25; tEffect.image_yscale=0.25
        tEffect.followID=-1; tEffect.newBlend=-1; tEffect.xSpd=random_range(-3,3); tEffect.ySpd=-2-random(3); tEffect.grav=0.4
        tEffect.rotation=random_range(-8,8); tEffect.type=2; tEffect.fadeSpd=0.06
      }
      instance_destroy()
    }
    else if y>room_height+32 {instance_destroy()}
  }
}
