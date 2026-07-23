#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
makeActive()
setCollisionBounds(-3,-3,3,3)

//Enemy base statistics
bShowHealthBar=false
bShowDamage=false
bCanTakeDamage=false
bDestroy=0
weight=50
grav=0.2
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  yVel+=grav
  if sprite_index=sKingWormSpike
  {
    if xVel>0 {image_angle-=10}
    else if xVel<0 {image_angle+=10}
  }

  if isCollisionTop(1) {bDestroy=1}
  if isCollisionBottom(1) {bDestroy=1}
  if isCollisionLeft(1) {bDestroy=1}
  if isCollisionRight(1) {bDestroy=1}
  moveTo(xVel,yVel)

  if bDestroy=1 {instance_destroy()}
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
instance_destroy()
