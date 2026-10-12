#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//if gDeltaDoTicks != 1 { exit; }
//60fps change: runs every frame. Once per 30fps tick, its per-frame gravity (scrGravAcc) and move (*gDeltaTime) were a
//half/quarter of a tick's at 60/120fps, so the coins floated down 2x/4x too slowly
if global.gamePaused=false
{
  yVel=scrGravAcc(yVel,0.3,1)
  if isCollisionBottom(1)
  {
    xVel=0
    yVel=0
  }
  //if isCollisionLeft(1)
  //  xVel*=-1
  //if isCollisionRight(1)
  //  xVel*=-1
  if isCollisionLeft(1) and xVel<0 //60fps change: only when moving into the wall (it can still touch it the next frame, which flipped it back)
    xVel*=-1
  if isCollisionRight(1) and xVel>0 //60fps change: see above
    xVel*=-1
  moveTo(xVel*gDeltaTime,yVel*gDeltaTime)

  if isCollisionSolid()
    //y-=2
    y-=2*gDeltaTime //60fps change: per frame now, so 2px per 30fps tick as before

  if y>room_height+24
    instance_destroy()
}
