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
_direction=0
_speed=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if init=0 {init=1}

  arcTime+=1*gDeltaTime
  //if arcTime>=1 and arcTime<=10 {_direction+=4*gDeltaTime}
  if arcTime>0 and arcTime<=10 {_direction+=4*gDeltaTime} //60fps change: covers every frame of each tick; the first frame(s) of tick 11 fell to the else below and turned the wrong way, so the arc drifted 4/6 degrees per cycle at 60/120fps
  //else if arcTime>=11 and arcTime<=30 {_direction-=4*gDeltaTime}
  else if arcTime>10 and arcTime<=30 {_direction-=4*gDeltaTime} //60fps change: see above
  else
  {
    _direction+=4*gDeltaTime
    if arcTime>=40 {arcTime=0}
  }

  _speed=bulletSpeed
  image_angle=_direction
}
else {_speed=0}

correctSpeedDirection(self)
#define Other_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if decayTime=-100 and init=1
  instance_destroy()
