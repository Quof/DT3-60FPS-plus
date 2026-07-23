#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
setCollisionBounds(-5,-5,5,5)

//Enemy base statistics
bShowHealthBar=false
bShowDamage=false
bCanTakeDamage=false
atkProg=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if atkProg=0 //Go toward wall
  {
    image_angle+=5*image_xscale
    if isCollisionLeft(1) {atkProg=1}
    if isCollisionRight(1) {atkProg=1}
    moveTo(xVel,yVel)
  }
  else if atkProg=1 //Stick to wall
  {
    if x<oMMByte.xCenter {x=oMMByte.xCenter-oMMByte.roomSpan}
    else {x=oMMByte.xCenter+oMMByte.roomSpan}
    image_angle=0
    sprite_index=sByteBombSet
    atkProg=2
  }
  else if atkProg=2 //Pull player
  {
    if x<oMMByte.xCenter {oPlayer1.extForceX=-2}
    else {oPlayer1.extForceX=2}

    if oPlayer1.y<y {oPlayer1.extForceY=0.5}
    else {oPlayer1.extForceY=0}
  }
}
