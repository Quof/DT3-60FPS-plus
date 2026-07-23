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
size=2
direction=point_direction(oArmyEye.x,oArmyEye.y-16,oPlayer1.x,oPlayer1.y-26)
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  turn_toward_direction(point_direction(oArmyEye.x,oArmyEye.y-16,oPlayer1.x,oPlayer1.y-26),1.9)
  image_angle=direction
  x=oArmyEye.x+lengthdir_x(shieldDist,direction)
  y=oArmyEye.y-16+lengthdir_y(shieldDist,direction)
}
#define Collision_oAttackBase
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
with other
{
  if damageType!="NORMAL"
  {
    var tEffect;
    tEffect=instance_create(x,y,oEffect)
    tEffect.sprite_index=sSamusSMissileEffect
    tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    instance_destroy()
  }
}
