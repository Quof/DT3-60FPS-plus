//Evil Boss Gallery: the wave: heaving (prog 0), rolling (1)
if global.gamePaused=false
{
  t+=1*gDeltaTime
  if prog=0
  {
    if t>=warn
    {
      prog=1
      t=0
      base=y
      bCanDealDamage=true
      image_xscale=20
      image_yscale=40
      x-=10
      y=base-40
      playSound(global.snd_Splash,0,1,8000)
    }
  }
  else
  {
    x+=spd*dir*gDeltaTime
    if (dir=1 and x>600) or (dir=-1 and x<244) {instance_destroy()}
  }
}
