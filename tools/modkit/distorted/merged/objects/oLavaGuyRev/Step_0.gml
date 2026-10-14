if global.gamePaused=false
{
  if bActive=0 {makeEnemyActive(1)}
  if bActive=true and rising>=0
  {
    glowScl+=0.025*gDeltaTime
    if glowScl>=1.4 {glowScl=1.1}
    if rising=0
    {
      playSound(global.snd_Fireball,0,0.85,33075)
      yVel=10
      if room=rReckoningOne {yVel=7}    //spsp DDLC
      visible=true
      rising=1
    }
    if yVel<0
      image_yscale=1
    else
      image_yscale=-1
    yVel=scrGravAcc(yVel,-0.3,1)
    y+=yVel*gDeltaTime
    if yVel<1 and y<ystart
    {
      var tEffect;
      tEffect=instance_create(x+2,ystart-4,oEffectGrav)
      tEffect.sprite_index=sEfMarioFireHit; tEffect.image_speed=0.33; tEffect.image_yscale=-1
      tEffect.type=1; tEffect.xSpd=1; tEffect.ySpd=2; tEffect.grav=-0.3; tEffect.image_blend=image_blend
      tEffect.newBlend=-1; tEffect.decay=45; tEffect.followID=-1; tEffect.rotation=0
      tEffect=instance_create(x-2,ystart-4,oEffectGrav)
      tEffect.sprite_index=sEfMarioFireHit; tEffect.image_speed=0.33; tEffect.image_xscale=-1; tEffect.image_yscale=-1
      tEffect.type=1; tEffect.xSpd=-1; tEffect.ySpd=2; tEffect.grav=-0.3; tEffect.image_blend=image_blend
      tEffect.newBlend=-1; tEffect.decay=45; tEffect.followID=-1; tEffect.rotation=0

      yVel=0
      y=ystart
      bActive=false
      visible=false
      rising=-50
    }
  }
  if rising<0 {rising+=1*gDeltaTime}
}
