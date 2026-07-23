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
  if oGame.time mod 4=0 {image_angle=random(360)}

  if hitProg=0
  {
    if isCollisionLeft(1) {xVel=moveSpd; yVel=-moveSpd; hitProg=1}
    if isCollisionRight(1) {xVel=-moveSpd; yVel=-moveSpd; hitProg=1}
    if isCollisionTop(1)
    {
      if type=0 {xVel=-moveSpd}
      else {xVel=moveSpd}
      yVel=moveSpd
      hitProg=1
    }
  }
  else if hitProg=1
  {
    if isCollisionBottom(1) {yVel*=-1; hitWall+=1}
    if isCollisionLeft(1) {xVel*=-1; hitWall+=1}
    if isCollisionRight(1) {xVel*=-1; hitWall+=1}
    if isCollisionTop(1) {yVel*=-1; hitWall+=1}
    if hitWall>=bounceMax {instance_destroy()}
  }
  moveTo(xVel,yVel)
}
