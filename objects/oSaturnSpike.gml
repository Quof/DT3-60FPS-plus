#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
image_speed=0.5

//Enemy base statistics
atkPower=50000000000+irandom(50000000000)
bCanTakeDamage=false
bShowHealthBar=false
decayTime=16
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  speed=9
  decayTime-=1
  if decayTime<=0 {instance_destroy()}
}
else {speed=0}
