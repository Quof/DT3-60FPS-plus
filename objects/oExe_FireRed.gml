#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
image_speed=0

//Enemy base statistics
bShowHealthBar=false
bShowDamage=false
bCanTakeDamage=false

damageType="ELEMENTAL"
#define Collision_oPlayer1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if oPlayer1.extraBulletCheck=0
{
  if oPlayer1.attackState=oPlayer1.ACT_BLOCK
  {
    exBulletBlockCheck+=1
    if exBulletBlockCheck>=3
    {
      exBulletBlockCheck=0
      redDmgHit(0)
    }
  }
  else
  {
    exBulletNormalCheck+=1
    if exBulletNormalCheck>=1
    {
      exBulletNormalCheck=0
      redDmgHit(0)
    }
  }
}
