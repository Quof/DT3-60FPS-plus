//Evil Boss Gallery: the flame's life: waiting (prog 0), rising (1), burning (2), dying down (3)
if global.gamePaused=false
{
  flameT+=1*gDeltaTime
  image_index+=0.25*gDeltaTime
  if prog=0
  {
    if flameT>=delay {prog=1; flameT=0}
  }
  else if prog=1
  {
    image_yscale=min(1,flameT/6)
    bCanDealDamage=(image_yscale>=0.5)
    if flameT>=6 {prog=2; flameT=0}
  }
  else if prog=2
  {
    image_yscale=1+0.12*sin(flameT*0.5)
    bCanDealDamage=true
    if flameT>=burnTime {prog=3; flameT=0}
  }
  else
  {
    image_yscale=max(0,1-(flameT/8))
    bCanDealDamage=false
    if flameT>=8 {instance_destroy()}
  }
}
