//Evil Boss Gallery: Evil Helmethead hit, before the damage (oDamagableBase's user event 14): during the shield charge
//(and the stagger after it), a hit from in front does nothing (a clank), one from behind double; Other_25 puts his
//resistances back
if actProg=2 and myBarrier=0
{
  evgRes0=resType[0]; evgRes1=resType[1]; evgRes4=resType[4]
  if (other.x-x)*image_xscale>=0
  {
    resType[0]=1; resType[1]=1; resType[4]=1
    playSound(global.snd_MMBulletDeflect,0,1,1)
    var tEffect;
    tEffect=instance_create(x+(10*image_xscale),y-18,oEffect)
    tEffect.sprite_index=sMMchargeComplete; tEffect.image_xscale=0.5; tEffect.image_yscale=0.5; tEffect.image_speed=0.5
    tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
  }
  else
  {
    resType[0]=4; resType[1]=4; resType[4]=4
  }
  evgResSet=1
}
