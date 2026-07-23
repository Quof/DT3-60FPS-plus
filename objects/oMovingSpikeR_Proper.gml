#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/*
** Requires shiftTime, shiftMax, moveSpd, bScaling, bShowLine

** shiftTime: Starting time
** shiftMax: Max distance
** moveSpd: Move speed
** bScaling: If scaling along x or y
** bShowLine: Show movement line
** ** If true - Needs: offsetX, offsetY
*/
event_inherited()

//Enemy base statistics
initDir=direction
bCanTakeDamage=false
bShowHealthBar=false

alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
initDir=direction
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  x+=moveSpd*cos(degtorad(direction))
  y+=-moveSpd*sin(degtorad(direction))
  if shiftTime>=shiftMax
  {
    shiftTime=0
    direction+=180
  }
  else {shiftTime+=1}
}
#define Collision_oPlayer1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
redDmgHit(1)
