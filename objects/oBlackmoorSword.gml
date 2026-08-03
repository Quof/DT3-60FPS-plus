#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
image_alpha=0

//Enemy base statistics
bShowHealthBar=false
bShowDamage=false
bCanTakeDamage=false
atkPower=6

atkProg=0
atkTime=0
bulletSpeed=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  atkTime+=1*gDeltaTime
  if atkProg=0
  {
    image_alpha+=0.1*gDeltaTime
    image_angle+=15*gDeltaTime
    if atkTime>=45
    {
      image_angle=point_direction(x,y,oPlayer1.x,returnPlayerYCenter())
      atkTime=0; atkProg+=1
    }
  }
  else if atkProg=1
  {
    if atkTime>=30
    {
      _direction=image_angle
      atkTime=0; atkProg+=1
    }
  }
  else if atkProg=2
  {
    if bulletSpeed<8 {bulletSpeed+=0.1*gDeltaTime}
    _speed=bulletSpeed
  }
}

else {_speed=0}
correctSpeedDirection(self)
#define Other_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
instance_destroy()
