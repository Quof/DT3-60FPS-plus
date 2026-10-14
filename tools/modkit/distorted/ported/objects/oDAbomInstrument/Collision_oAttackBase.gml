if bCanTakeDamage=1 and other.damageType="NORMAL" //spsp ns
{
  activeTime=1500
  bCanTakeDamage=0
  playSound(global.snd_SwitchHit,0,0.95,25000)
  if other.bCanPierce=0
  {
    with other {instance_destroy()}
  }
}
