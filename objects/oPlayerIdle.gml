#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
y+=1
image_speed=0.1
pauseTime=0
idleShield=instance_create(x,y-26,oPlayerShieldBubble)
view_hspeed[0]=32; view_vspeed[0]=32
alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if variable_local_exists("checkRev")
{
  if oPlayer1.x<xThres
  {
    x=newX
    y=newY
  }
}
else
{
  if oPlayer1.x>xThres
  {
    x=newX
    y=newY
  }
}

if global.activeCharacter=0
{
  sprite_index=sClaireIdle
  if variable_local_exists("newPose")
  {
    if newPose=1 {sprite_index=sClaireLayDown}
  }
}
else if global.activeCharacter=1
{
  sprite_index=sJerryIdle
  if variable_local_exists("newPose")
  {
    if newPose=1 {sprite_index=sJerryLayDown}
  }
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
idleShield.x=x
idleShield.y=y-26
if pauseTime>0
{
  pauseTime-=1
  if pauseTime=0
  {
    if global.gameOver=0 {global.gamePaused=false}
  }
}
