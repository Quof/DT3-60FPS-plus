#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
image_blend=c_black
image_speed=0.33

//Enemy base statistics
bShowHealthBar=false
bShowDamage=false
bCanTakeDamage=false
atkProg=0
atkTime=0

runAcc=8
bClockWise=0
UP=0
DOWN=1
LEFT=2
RIGHT=3
currentDir=LEFT
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if atkProg=0
  {
    y-=runAcc/2
    atkTime+=1
    if atkTime>=8
    {
      if place_meeting(x,y-runAcc,oSolid)
      {
        if type=0 {bClockWise=1; currentDir=RIGHT}
        else {bClockWise=0; currentDir=LEFT}
        atkTime=0
        atkProg=1
      }
    }
  }
  else if atkProg=1
  {
    enemyFollowBorder()
    atkTime+=1
    if atkTime=150 {instance_destroy()}
  }
}
