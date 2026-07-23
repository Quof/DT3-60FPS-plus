#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Requires: decayTime,bulletSpeed
event_inherited()
image_blend=make_color_rgb(255,190,180)

//Enemy base statistics
bShowHealthBar=false
bShowDamage=false
bCanTakeDamage=false
init=0
arcTime=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if init=0 {init=1}

  arcTime+=1
  if arcTime>=1 and arcTime<=10 {direction+=4}
  else if arcTime>=11 and arcTime<=30 {direction-=4}
  else
  {
    direction+=4
    if arcTime>=40 {arcTime=0}
  }

  speed=bulletSpeed
  image_angle=direction
}
else {speed=0}
#define Other_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if decayTime=-100 and init=1
  instance_destroy()
