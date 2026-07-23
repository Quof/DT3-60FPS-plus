#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
swingSpeed=0

//Enemy base statistics
atkPower=8
bCanTakeDamage=false
bShowHealthBar=false
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  image_angle+=swingSpeed

  if image_angle>360
  {
    swingSpeed-=0.05
    if swingSpeed<-4
      swingSpeed=-4
  }
  else
  {
    swingSpeed+=0.05
    if swingSpeed>4
      swingSpeed=4
  }
}
