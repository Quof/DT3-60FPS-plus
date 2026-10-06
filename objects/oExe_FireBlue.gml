#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
image_speed=0
image_index=2

//Enemy base statistics
bShowHealthBar=false
bShowDamage=false
bCanTakeDamage=false

damageType="ELEMENTAL"
bCanBeBlocked=1
blockCost=100
bParryOpp=1

_direction=0
_speed=0
_hspeed=0
_vspeed=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//correctSpeedDirection(self)
event_inherited() //60fps change: this Step event (added during the speed/direction rename) replaced oExe_BulletBase's Step, which sets the speed and runs the curve/speed-change/orbit types, so these bullets never moved; the base Step also does the move (correctSpeedDirection)
