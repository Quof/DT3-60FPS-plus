if other.damageType!="EXPLOSION" or false       //spsp
{

with other
{
  if bCanPierce=0 {instance_destroy()}
}

var tEffect;
tEffect=instance_create(x,y,oEffect)
tEffect.sprite_index=sMMchargeComplete
tEffect.followID=-1; tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
instance_destroy()

}
