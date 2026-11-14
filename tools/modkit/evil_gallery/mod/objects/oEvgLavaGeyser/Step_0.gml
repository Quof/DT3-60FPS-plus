//Evil Boss Gallery: the geyser: bubbling (prog 0), up (1), dying down (2)
if global.gamePaused=false
{
  t+=1*gDeltaTime
  if prog=0
  {
    if t>=warn
    {
      prog=1
      t=0
      bCanDealDamage=true
      x=cx-14
      y=yTopC
      image_xscale=28
      image_yscale=yLava+16-yTopC
      playSound(global.snd_FireLoop,0,0.9,15000)
      var tG,k;
      for(k=-1;k<=1;k+=2)
      {
        tG=instance_create(cx,yLava-40,oGravBulletAlt)
        tG.sprite_index=sFireBroFire; tG.atkPower=atkPower; tG.bExplode=0; tG.damageType="ELEMENTAL"
        tG.xVel=2.4*k; tG.yVel=-9; tG.xGrav=0; tG.yGrav=0.3
      }
    }
  }
  else if prog=1
  {
    if t>=24
    {
      prog=2
      t=0
      bCanDealDamage=false
    }
  }
  else if t>=8 {instance_destroy()}
}
