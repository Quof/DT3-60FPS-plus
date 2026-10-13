if room=rWarshipZ_E3 //EX MODE
{
  if other.bCanPierce=0
  {
    with other
    {
      playSound(global.snd_MMBulletDeflect,0,1,1)
      var tEffect;
      tEffect=instance_create(x,y,oEffect)
      tEffect.sprite_index=sMMchargeComplete; tEffect.image_xscale=0.75; tEffect.image_yscale=0.75
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
      instance_destroy()
    }
  }
}
