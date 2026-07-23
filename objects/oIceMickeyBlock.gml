#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
bPlatformReady=0
#define Collision_oAttackBase
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if other.damageType="ELEMENTAL" and bPlatformReady=0
{
  awardAwesome(50)
  bPlatformReady=1
  myPlat=instance_create(x+(8*mySide),y,oIceMickeyPlat)
  myPlat.myOwner=id; myPlat.myScale=mySide; myPlat.image_xscale=0.1*mySide
  if other.bCanPierce=0
  {
    with other {instance_destroy()}
  }
}
