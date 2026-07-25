#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
image_speed=0.33

//Enemy base statistics
bShowHealthBar=false
bShowDamage=false
bCanTakeDamage=false
atkPower=4
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  y-=4.5*gDeltaTime
  x+=sin(oGame.time/1.5)*gDeltaTime

  if y<-8
    instance_destroy()
}
