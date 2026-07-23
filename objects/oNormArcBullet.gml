#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
setCollisionBounds(-3,-3,3,3)

//Enemy base statistics
bShowHealthBar=false
bShowDamage=false
bCanTakeDamage=false
hitWall=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  speed=bulletSpeed
  direction+=arcAmt
  image_angle=direction

  if arcAmt!=0
  {
    if falloff>0
      arcAmt-=falloff
    else
      arcAmt+=falloff
  }
  if arcAmt<0.2 and arcAmt>-0.2
    arcAmt=0

  if isCollisionTop(1)
    hitWall=1
  if isCollisionBottom(1)
    hitWall=2
  if isCollisionLeft(1)
    hitWall=3
  if isCollisionRight(1)
    hitWall=4

  if hitWall>=1
  {
    if type=1
    {
      explosion=instance_create(x,y,oDamageExplosion)
      explosion.sprite_index=sTBBurstEffect
      explosion.image_speed=0.65
      explosion.image_xscale=0.75
      explosion.image_yscale=0.75
      explosion.atkPower=atkPower
      explosion.decayTime=-100
    }
    instance_destroy()
  }
}
else
  speed=0
#define Other_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
instance_destroy()
