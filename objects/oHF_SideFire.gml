#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
image_alpha=0

//Enemy base statistics
atkPower=9
bCanTakeDamage=false
bCanDealDamage=false
bShowHealthBar=false
damageType="ELEMENTAL"

fireProg=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if fireProg=0
  {
    image_alpha+=0.01
    if image_alpha=0.5 {bCanDealDamage=true}
    else if image_alpha=1 {fireProg=1}
  }
}
