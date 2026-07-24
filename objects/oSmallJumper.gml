#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
makeActive()
setCollisionBounds(2,0,sprite_width-2,sprite_height-1)
bouncePlayerTime=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if bouncePlayerTime>0
  {
    oPlayer1.yVel=-14
    bouncePlayerTime-=1*gDeltaTime
  }
  yVel+=0.3*gDeltaTime
  if isCollisionBottom(1)
    yVel=0
  moveTo(xVel,yVel)
  if isCollisionSolid()
    y-=2
  if y>room_height+24
    instance_destroy()
}
#define Collision_oCharacter
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if other.yVel>0
{
  playSound(global.snd_SpringJump,0,0.9,1)
  oPlayer1.canAirDash=1
  oPlayer1.doubleJumpCheck=1
  other.yVel=-14
  bouncePlayerTime=3
}
