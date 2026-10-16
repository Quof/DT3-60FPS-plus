//Evil Boss Gallery: the head's flight (see Create)
if global.gamePaused=false
{
  var tBack;
  tBack=2*v0/acc
  tossT+=1*gDeltaTime
  if tossT>tBack {tossT=tBack}
  x=x0+dir*((v0*tossT)-(0.5*acc*tossT*tossT))
  y=y0-34*sin(pi*tossT/tBack)
  image_angle+=18*dir*gDeltaTime
  if gDeltaDoTicks
  {
    var tEffect;
    tEffect=instance_create(x,y,oEffect)
    tEffect.sprite_index=sprite_index; tEffect.image_alpha=0.35; tEffect.image_xscale=1.5; tEffect.image_yscale=1.5
    tEffect.image_angle=image_angle; tEffect.decay=4; tEffect.image_speed=0
    tEffect.newBlend=-1; tEffect.followID=-1; tEffect.xSpd=0; tEffect.ySpd=0
  }
  if tossT>=tBack
  {
    if instance_exists(owner) {owner.headOff=0}
    instance_destroy()
  }
}
