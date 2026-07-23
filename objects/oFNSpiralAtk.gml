#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()

//Enemy base statistics
bShowHealthBar=false
bShowDamage=false
bCanTakeDamage=false
decay=180
myDist=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  direction-=2.25
  myDist+=2
  x=xstart+lengthdir_x(myDist,dirSeg+direction)
  y=ystart+lengthdir_y(myDist,dirSeg+direction)

  decay-=1
  if decay=0 {instance_destroy()}
}
