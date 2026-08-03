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
damageType="EXPLOSION"
_speed=0
_direction=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false //24
{
  image_alpha-=0.035*gDeltaTime
  if image_alpha<=0.25 {bCanDealDamage=false}
  image_speed=animSpeed
  _speed=0
  _speed=bulletSpeed

}
else
{
  image_speed=0
  _speed=0
}
correctSpeedDirection(self)
#define Other_7
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
instance_destroy()
