event_inherited()
if global.gamePaused=false
{
  timeTillDamage+=1*gDeltaTime
  if timeTillDamage=4 {bCanDealDamage=true}

  if yVel<16 {yVel=scrGravAcc(yVel,0.3,1)}

  _hspeed=xVel; _vspeed=yVel
  //image_angle=_direction
  image_angle=point_direction(0,0,xVel,yVel) //restored game powers change: _direction isn't set from _hspeed/_vspeed here (the original's built-in hspeed/vspeed set direction), so the missile faced right; its flight's direction instead
  _hspeed=0; _vspeed=0
  if oGame.time mod (8/gDeltaTime)=0
  {
    var tEffect;
    tEffect=instance_create(x,y,oEffect)
    tEffect.sprite_index=sSamusMissileEffect; tEffect.image_speed=0.5; tEffect.image_alpha=0.5
    tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
  }

  moveTo(xVel*gDeltaTime,yVel*gDeltaTime)

  if isCollisionLeft(1)
    instance_destroy()
  if isCollisionRight(1)
    instance_destroy()
  if isCollisionBottom(1)
    instance_destroy()
  if isCollisionTop(1)
    instance_destroy()
  if y>=room_height+24
    instance_destroy()
}
