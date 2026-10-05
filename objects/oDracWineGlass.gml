#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
makeActive()
setCollisionBounds(-2,-3,2,3)

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
  yVel=scrGravAcc(yVel,grav,1)

  if xVel>0
    //image_angle-=2
    image_angle-=2*gDeltaTime //60fps change: was spinning 2x/4x as fast at 60/120fps
  else if xVel<0
    //image_angle+=2
    image_angle+=2*gDeltaTime //60fps change: was spinning 2x/4x as fast at 60/120fps

  if isCollisionTop(1)
    bDestroy=1
  if isCollisionBottom(1)
    bDestroy=1
  if isCollisionLeft(1)
    bDestroy=1
  if isCollisionRight(1)
    bDestroy=1
  moveTo(xVel*gDeltaTime,yVel*gDeltaTime)

  if bDestroy=1
  {
    playSound(global.snd_PotShatter,0,0.95,1)
    newAttack=instance_create(x,oDracula.yGround,oDamageExplosion)
    newAttack.atkPower=atkPower
    newAttack.sprite_index=sFlameUp
    newAttack.decayTime=-100
    instance_destroy()
  }
}
