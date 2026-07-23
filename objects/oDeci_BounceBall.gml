#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
makeActive()
setCollisionBounds(-15,-15,15,15)

//Enemy base statistics
bShowHealthBar=false
bShowDamage=false
bCanTakeDamage=false
bDestroy=0
weight=100
grav=0.5
bounceNum=5
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if yVel<10 {yVel+=grav}

  if xVel>0.75 {xVel-=xFalloff}
  else if xVel<-0.75 {xVel+=xFalloff}

  if xVel>-1 and xVel<1
  {
    instance_destroy()
  }

  if isCollisionTop(1)
    yVel=4
  if isCollisionBottom(1)
  {
    yVel=-bounceNum*2
    bounceNum-=1
    if bounceNum=0 {instance_destroy()}
  }
  if isCollisionLeft(1)
  {
    var tBufX;
    tBufX=abs(xVel)
    xVel=tBufX
  }
  if isCollisionRight(1)
  {
    var tBufX;
    tBufX=abs(xVel)
    xVel=-tBufX
  }
  moveTo(xVel,yVel)


  if y>room_height+32
    instance_destroy()
}
