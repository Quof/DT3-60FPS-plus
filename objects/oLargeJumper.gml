#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
makeActive()
setCollisionBounds(2,0,sprite_width-2,abs(sprite_height)-1)
bouncePlayerTime=0
restTick=0 //60fps change (added): reached the ground on the last 30fps tick (Step)
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
    //oPlayer1.yVel=-16
    oPlayer1.yVel=-16; oPlayer1.yVelSetExt=1 //60fps change: velocity set every frame, use the 30fps formula (pMoveToWrapNew), like oBegoniaFan
    bouncePlayerTime-=1*gDeltaTime
  }
  yVel=scrGravAcc(yVel,0.3,1)
  if isCollisionBottom(1)
    yVel=0
  //moveTo(xVel*gDeltaTime,yVel*gDeltaTime)
  //60fps change: between ticks, a jumper that reached the ground on the tick stays where the tick left it. Upside-down
  //ones sit a bit into the ground and every tick go down to it and get pushed back up 2px (below), as at 30fps; moving
  //back down on the frames in between, without the push, made them bounce 2px every frame.
  if !(restTick and gDeltaDoTicks=0) {moveTo(xVel*gDeltaTime,yVel*gDeltaTime)}
  if gDeltaDoTicks {restTick=isCollisionBottom(1)} //60fps change (added)
  //if isCollisionSolid()
  if isCollisionSolid() and gDeltaDoTicks //60fps change: the 2px push once per 30fps tick; every frame it beat the fall (moveTo is per frame) and the jumper hung in the air near the ground
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
