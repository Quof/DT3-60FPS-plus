#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Requires: bGrav
makeActive()
setCollisionBounds(-5,1,5,15)
image_speed=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if bGrav=1
  {
    yVel+=0.3
    moveTo(xVel,yVel)

    if isCollisionSolid() {y-=2}
    if y>room_height+24 {instance_destroy()}
  }
}
#define Collision_oPlayer1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
playSound(global.snd_SkillCapsule,0,1,1)
oEvKeyControl.keyCheck[image_index]=1
instance_destroy()
