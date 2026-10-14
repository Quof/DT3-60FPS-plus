event_inherited()
if global.gamePaused=false
{
  if lingerFrame=0
  {
    if sprite_index=sMMXbuster3 or sprite_index=sMMXbuster4
    {
      var tEffect;
      if oGame.time mod (3/gDeltaTime)=0
      {
        tEffect=instance_create(x-(abs(sprite_width)/2-3)+random(abs(sprite_width)-6),y-(sprite_height/2-3)+random(sprite_height-6),oEffectB)
        tEffect.sprite_index=sMMchargeEffect1; tEffect.image_speed=0.25; tEffect.direction=_direction
        tEffect.type=4; tEffect.speed=bulletSpeed-2; tEffect.AccelX=-0.65
        tEffect.AccelY=0; tEffect.newBlend=-1; tEffect.followID=-1; tEffect.rotation=0
      }
    }

    if place_meeting(x,y,oNightmareEffect) {bulletSpeed=6}
    else {bulletSpeed=12}
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
