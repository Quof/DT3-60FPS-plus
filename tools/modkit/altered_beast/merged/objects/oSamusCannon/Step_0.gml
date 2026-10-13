event_inherited()
if global.gamePaused=false
{
  if lingerFrame=0
  {
    image_angle=_direction
    if gDeltaDoTicks and image_alpha=1 {image_alpha=0.5}
    else {image_alpha=1}
    if sprite_index=sMMXbuster3
    {
      if oGame.time mod (4/gDeltaTime)=0
      {
        var tEffect;
        tEffect=instance_create(x-(sprite_width/2-3)+random(sprite_width-6),y-(sprite_height/2-3)+random(sprite_height-6),oEffect)
        tEffect.sprite_index=sMMchargeEffect1; tEffect.image_speed=0.25; tEffect.xSpd=random(0.3)*-image_xscale
        tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.ySpd=0
      }
    }
    if place_meeting(x,y,oNightmareEffect) {bulletSpeed=5.75}
    else {bulletSpeed=11.5}
    _speed=bulletSpeed
    if checkScreenArea(x,y,48)=0 {instance_destroy()}
    if isCollisionLeft(1) {lingerFrame=1; _speed=0; visible=0}
    if isCollisionRight(1) {lingerFrame=1; _speed=0; visible=0}
    if isCollisionBottom(1) {lingerFrame=1; _speed=0; visible=0}
    if isCollisionTop(1) {lingerFrame=1; _speed=0; visible=0}
    lifeTime-=1*gDeltaTime
    if lifeTime=0 {instance_destroy()}
  }
  else if lingerFrame=1 {instance_destroy()}
}
else {_speed=0}

correctSpeedDirection(self)
