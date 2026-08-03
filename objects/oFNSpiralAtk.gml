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
  _direction-=2.25*gDeltaTime
  myDist+=2*gDeltaTime
  x=xstart+lengthdir_x(myDist,dirSeg+_direction)
  y=ystart+lengthdir_y(myDist,dirSeg+_direction)

  decay-=1*gDeltaTime
  if decay=0 {instance_destroy()}
}
correctSpeedDirection(self)
