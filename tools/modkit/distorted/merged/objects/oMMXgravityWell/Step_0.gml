event_inherited()
if global.gamePaused=false
{
  if gravityProg=0
  {
    if place_meeting(x,y,oNightmareEffect) {bulletSpeed=2}
    else {bulletSpeed=4}

    _speed=bulletSpeed
    if checkScreenArea(x,y,48)=0 and room!=rDoubleSplit2 {instance_destroy()} //spsp DDLC

    if isCollisionLeft(1) {gravityProg=1}
    if isCollisionRight(1) {gravityProg=1}
    if isCollisionBottom(1) {gravityProg=1}
    if isCollisionTop(1) {gravityProg=1}
    lifeTime-=1*gDeltaTime
    if lifeTime=0 {gravityProg=1}
  }
  else if gravityProg=1
  {
    _speed=0
    sprite_index=sMMXgravityWell3
    image_alpha=0.75
    lifeTime=30
    gravityProg=2
  }
  else if gravityProg=2
  {
    if oGame.time mod (3/gDeltaTime)=0 {image_angle=random(360)}
    lifeTime-=1*gDeltaTime
    if lifeTime=0 {instance_destroy()}
  }
}
else {_speed=0}

correctSpeedDirection(self)
