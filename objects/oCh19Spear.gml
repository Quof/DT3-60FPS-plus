#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
setCollisionBounds(-3,-3,3,3)

//Enemy base statistics
atkPower=12
bCanTakeDamage=false
bShowHealthBar=false
moveSpeed=7.5
hitWall=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  speed=moveSpeed

  if isCollisionTop(1) {hitWall=1}
  if isCollisionBottom(1) {hitWall=2}
  if isCollisionLeft(1) {hitWall=3}
  if isCollisionRight(1) {hitWall=4}

  if hitWall>=1
  {
    var tEffect;
    tEffect=instance_create(x,y,oEffect)
    tEffect.sprite_index=sMMSmokeCloud; tEffect.image_blend=c_gray
    tEffect.image_speed=0.33; tEffect.xSpd=0; tEffect.ySpd=0
    tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100
    instance_destroy()
  }
}
else {speed=0}
