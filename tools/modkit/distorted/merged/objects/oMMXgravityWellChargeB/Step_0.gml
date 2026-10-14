event_inherited()
if global.gamePaused=false
{
  if lingerFrame=0
  {
    if place_meeting(x,y,oNightmareEffect) {bulletSpeed=7}
    else {bulletSpeed=14}
    _speed=bulletSpeed


    if checkScreenArea(x,y,48)=0 and room!=rDoubleSplit2 {instance_destroy()} //spsp DDLC

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
