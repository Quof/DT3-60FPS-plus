#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
makeActive()
setCollisionBounds(2,0,sprite_width-2,abs(sprite_height)-1)
bouncePlayerTime=0
alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if image_yscale=-1 {setCollisionBounds(2,abs(sprite_height)+1,sprite_width-2,-3)}
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
    oPlayer1.yVel=-16
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
if room=rPttT_07
{
  oPlayer1.canAirDash=1
  oPlayer1.doubleJumpCheck=1
  other.yVel=-16
  bouncePlayerTime=round(7*image_xscale)
}
else
{
  if other.yVel>0
  {
    playSound(global.snd_SpringJump,0,0.95,1)
    oPlayer1.canAirDash=1
    oPlayer1.doubleJumpCheck=1
    other.yVel=-16
    bouncePlayerTime=round(7*image_xscale)
  }
}
