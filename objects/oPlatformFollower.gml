#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
//makeActive()
//setCollisionBounds(-15,-15,15,15)
image_speed=0.33

//Enemy base statistics
atkPower=8
bCanTakeDamage=false
bShowHealthBar=false
detectDistY=288
runAcc=2 //should always be a power of 2
UP=0
DOWN=1
LEFT=2
RIGHT=3
bClockWise=false
currentDir=LEFT
alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if variable_local_exists("newSpd")
  runAcc=newSpd
if variable_local_exists("newDir")
  currentDir=newDir
if variable_local_exists("bClock")
  bClockWise=true
if variable_local_exists("startAct")
  bActive=true
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if bActive=true
  {
    enemyFollowBorder()
  }
  else
  {
    makeEnemyActive(0)
  }
}
