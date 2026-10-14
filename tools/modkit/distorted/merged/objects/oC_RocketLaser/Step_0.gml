if global.gamePaused=false
{
  effectDelay+=1*gDeltaTime
  if effectDelay mod 10=0
  {
    var tFFScl,tEffect;
    for(i=0;i<19;i+=1)
    {
      tFFScl=random(0.1)
      tEffect=instance_create(x+lengthdir_x(16*i,image_angle),y+lengthdir_y(16*i,image_angle),oEffectB)
      tEffect.type=3; tEffect.sprite_index=sEfFirefly; tEffect.newBlend=1
      tEffect.image_xscale=0.15+tFFScl; tEffect.image_yscale=0.15+tFFScl
      tEffect.fadeSpd=0.1; tEffect.image_blend=c_teal
      tEffect.AccelX=0; tEffect.AccelY=0; tEffect.followID=-1; tEffect.rotation=0
    }
  }

  if gDeltaDoTicks { //60fps change (added): one spark at the laser's end per 30fps tick (was 2x/4x as many at 60/120fps)
  tFFScl=random(0.1)
  tEffect=instance_create(x+lengthdir_x(288,image_angle),y+lengthdir_y(288,image_angle),oEffectB)
  tEffect.type=3; tEffect.sprite_index=sEfFirefly; tEffect.newBlend=1
  tEffect.image_xscale=0.3+tFFScl; tEffect.image_yscale=0.3+tFFScl
  tEffect.fadeSpd=0.1; tEffect.image_blend=c_teal
  tEffect.AccelX=0; tEffect.AccelY=0; tEffect.followID=-1; tEffect.rotation=0
  } //60fps change (added)

  laserProg+=1*gDeltaTime
  if laserProg>=10
  {
    instance_destroy()
  }
  if room=rExtGateE_2 and laserProg>=4      //spsp
  {
    instance_destroy()
}
  else if room=rVault_21 and laserProg=7    //spsp
  {
    instance_destroy()
  }
  else if (room=rNGC_LC_C or room=rNGC_LC_D) and laserProg=8    //spsp
  {
    instance_destroy()
  }
}
