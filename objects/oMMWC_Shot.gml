#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
setCollisionBounds(-6,-6,6,6)
image_speed=0.33

//Enemy base statistics
bShowHealthBar=false
bShowDamage=false
bCanTakeDamage=false
damageType="ELEMENTAL"
hitWall=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if isCollisionBottom(1) {yVel*=-1; hitWall+=1}
  if isCollisionLeft(1) {xVel*=-1; hitWall+=1}
  if isCollisionRight(1) {xVel*=-1; hitWall+=1}
  if isCollisionTop(1) {yVel*=-1; hitWall+=1}
  moveTo(xVel,yVel)

  if hitWall>=3 {instance_destroy()}
}
#define Other_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
instance_destroy()
