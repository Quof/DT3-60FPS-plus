#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
makeActive()
setCollisionBounds(-16,-16,16,16)

//Enemy base statistics
bShowHealthBar=false
bShowDamage=false
bCanTakeDamage=false
size=2
bDestroy=0
weight=100
grav=0.5
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if yVel<10 {yVel=scrGravAcc(yVel,grav,1)}

  xVel=scrTickAcc(xVel,xFalloff*((xVel<-0.75)-(xVel>0.75)),0) //slow down toward 0, per 30fps tick (scrTickAcc)

  if xVel>-1 and xVel<1
  {
    instance_destroy()
  }

  if isCollisionTop(1)
    yVel=4
  if isCollisionBottom(1)
    yVel=-9
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
  moveTo((xVel+scrTickAccB(0))*gDeltaTime,yVel*gDeltaTime)


  if y>room_height+32
    instance_destroy()
}
