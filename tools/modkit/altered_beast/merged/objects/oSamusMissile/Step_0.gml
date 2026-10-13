event_inherited()
if global.gamePaused=false
{
  if lingerFrame=0
  {
    if oGame.time mod (3/gDeltaTime)=0
    {
      var tExpLight;
      tExpLight=instance_create(x,y,oWepEf_Light); tExpLight.image_xscale=0.5; tExpLight.image_yscale=0.5
    }

    image_angle=_direction
    if sprite_index=sSamusMissile
    {
      if oGame.time mod (3/gDeltaTime)=0
      {
        var tEffect,tXOffset;
        tXOffset=0
        if image_angle=90 or image_angle=270 {tXOffset=4}
        tEffect=instance_create(x+(4*image_xscale)-tXOffset,y,oEffect)
        tEffect.sprite_index=sSamusMissileEffect; tEffect.image_speed=0.5
        tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
      }
    }
    else if sprite_index=sSamusSuperMissile
    {
      if oGame.time mod (3/gDeltaTime)=0
      {
        var tEffect,tXOffset;
        tXOffset=0
        if image_angle=90 or image_angle=270 {tXOffset=4}
        tEffect=instance_create(x+(4*image_xscale)-tXOffset,y,oEffect)
        tEffect.sprite_index=sSamusSMissileEffect; tEffect.image_speed=0.5
        tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
      }
    }

    //if bulletSpeed<12 {bulletSpeed+=accel}
    bulletSpeed=scrTickAcc(bulletSpeed,accel*(bulletSpeed<12),0) //60fps change: as DT3+'s, speed up per 30fps tick (scrTickAcc), by the missile's own accel

    lifeTime-=1*gDeltaTime

    //if place_meeting(x,y,oNightmareEffect) {speed=bulletSpeed/2}
    //else {speed=bulletSpeed}
    if place_meeting(x,y,oNightmareEffect) {_speed=(bulletSpeed+scrTickAccB(0))/2} //60fps change: DT3+'s own motion (_speed; scrTickAccB corrects the movement while it speeds up)
    else {_speed=bulletSpeed+scrTickAccB(0)} //60fps change
    if checkScreenArea(x,y,48)=0 {instance_destroy()}

    if isCollisionLeft(1) {lingerFrame=1; _speed=0; visible=0}
    if isCollisionRight(1) {lingerFrame=1; _speed=0; visible=0}
    if isCollisionBottom(1) {lingerFrame=1; _speed=0; visible=0}
    if isCollisionTop(1) {lingerFrame=1; _speed=0; visible=0}

    if lifeTime=0 {instance_destroy()}
  }
  else if lingerFrame=1 {instance_destroy()}
}
else {_speed=0}

correctSpeedDirection(self)
