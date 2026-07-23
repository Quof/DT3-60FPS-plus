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
lifeTime=0
seekTime=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  lifeTime+=1
  seekTime+=1
  if seekTime>=60
  {
    turn_toward_direction(point_direction(x,y,oPlayer1.x,returnPlayerYCenter()),2)
    if seekTime>=90 {seekTime=0}
  }

  speed=bulletSpeed
  image_angle-=15
}
else {speed=0}
#define Collision_oAttackBase
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
with other
{
  if bCanPierce=0 {instance_destroy()}
}

var tEffect;
tEffect=instance_create(x,y,oEffect)
tEffect.sprite_index=sMMchargeComplete
tEffect.followID=-1; tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
instance_destroy()
#define Other_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if lifeTime>=150 {instance_destroy()}
