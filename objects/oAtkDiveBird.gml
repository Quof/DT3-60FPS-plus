#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()

damageType="NORMAL"
weaponTag=100
atkPower=50
bulletSpeed=14
_speed=14
stunTime=1
bCanPierce=1
_direction=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
if global.gamePaused=false
  {
    //_speed=bulletSpeed
    _speed=bulletSpeed  }
else
  _speed=0
correctSpeedDirection(self)
#define Other_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
instance_destroy()
