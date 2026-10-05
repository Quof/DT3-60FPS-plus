#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
setCollisionBounds(-11,-11,11,11)

//Enemy base statistics
bShowHealthBar=false
bShowDamage=false
bCanTakeDamage=false
hitProg=0
hitWall=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if oGame.time mod (4/gDeltaTime)=0 {image_angle=random(360)}

  //60fps change (added): the wall checks run at the start of each of the bomb's OWN 30fps ticks (bombTk counts from its
  //creation), like the 30fps code: it reaches a wall partway through a tick, waits there for the rest of that tick (sliding
  //along it), then bounces. gDeltaDoTicks is the game-wide tick, so the wait was a random 0-3 frames per bounce instead,
  //and the bounce pattern drifted from the 30fps one. (Checking every frame isn't safe: at 1px/frame it would bounce twice.)
  if !variable_local_exists("bombTk") {bombTk=0}
  var bTick; bTick=(frac(bombTk)=0)
  if hitProg=0
  {
    //if gDeltaDoTicks and isCollisionLeft(1) {xVel=moveSpd; yVel=-moveSpd; hitProg=1}
    //if gDeltaDoTicks and  isCollisionRight(1) {xVel=-moveSpd; yVel=-moveSpd; hitProg=1}
    //if gDeltaDoTicks and  isCollisionTop(1)
    if bTick and isCollisionLeft(1) {xVel=moveSpd; yVel=-moveSpd; hitProg=1} //60fps change: bTick (the bomb's own tick) instead of gDeltaDoTicks
    if bTick and  isCollisionRight(1) {xVel=-moveSpd; yVel=-moveSpd; hitProg=1} //60fps change: bTick
    if bTick and  isCollisionTop(1) //60fps change: bTick
    {
      if type=0 {xVel=-moveSpd}
      else {xVel=moveSpd}
      yVel=moveSpd
      hitProg=1
    }
  }
  else if hitProg=1
  {
    //if gDeltaDoTicks and  isCollisionBottom(1) {yVel*=-1; hitWall+=1}
    //if gDeltaDoTicks and  isCollisionLeft(1) {xVel*=-1; hitWall+=1}
    //if gDeltaDoTicks and  isCollisionRight(1) {xVel*=-1; hitWall+=1}
    //if gDeltaDoTicks and  isCollisionTop(1) {yVel*=-1; hitWall+=1}
    if bTick and  isCollisionBottom(1) {yVel*=-1; hitWall+=1} //60fps change: bTick (the bomb's own tick) instead of gDeltaDoTicks
    if bTick and  isCollisionLeft(1) {xVel*=-1; hitWall+=1} //60fps change: bTick
    if bTick and  isCollisionRight(1) {xVel*=-1; hitWall+=1} //60fps change: bTick
    if bTick and  isCollisionTop(1) {yVel*=-1; hitWall+=1} //60fps change: bTick
    if hitWall>=bounceMax {instance_destroy()}
  }
  moveTo(xVel*gDeltaTime,yVel*gDeltaTime)
  bombTk+=gDeltaTime //60fps change (added)
}
