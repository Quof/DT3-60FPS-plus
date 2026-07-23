#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
hitDelay=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=0
{
  if hitDelay>0 {hitDelay-=1}
}
#define Collision_oAttackBase
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if other.damageType="EXPLOSION" and other.bCanHitSwitch=1 and hitDelay=0
{
  if type=1 {oAbominationMain.leftWeakTimer=50}
  else if type=2 {oAbominationMain.rightWeakTimer=50}
  hitDelay=30
}
#define Collision_oMisc
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
with other
{
  image_alpha-=0.1
  if image_alpha<=0 {instance_destroy()}
}
