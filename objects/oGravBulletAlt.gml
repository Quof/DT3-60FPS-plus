#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//requires: xGrav,yGrav,bExplode
event_inherited()
makeActive()
setCollisionBounds(-3,-3,3,3)

//Enemy base statistics
bShowHealthBar=false
bShowDamage=false
bCanTakeDamage=false
bDestroy=0
weight=50
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  xVel+=xGrav
  yVel+=yGrav
  hspeed=xVel
  vspeed=yVel
  image_angle=direction

  if isCollisionTop(1)
    bDestroy=1
  if isCollisionBottom(1)
    bDestroy=1
  if isCollisionLeft(1)
    bDestroy=1
  if isCollisionRight(1)
    bDestroy=1

  if bDestroy=1
  {
    if bExplode=1
    {
      if sprite_index=sNotorBangerBomb
      {
        newAttack=instance_create(x,y,oDamageExplosion)
        newAttack.atkPower=atkPower; newAttack.sprite_index=sBombExplosion
        newAttack.decayTime=-100
      }
      else if sprite_index=sAbomRainAtkA
      {
        newAttack=instance_create(x,y,oDamageExplosion)
        newAttack.atkPower=atkPower; newAttack.sprite_index=sBombExplosion
        newAttack.decayTime=-100
      }
      else
      {
        newAttack=instance_create(x,y,oDamageExplosion)
        newAttack.atkPower=atkPower; newAttack.sprite_index=sBombExplosion
        newAttack.image_xscale=0.75; newAttack.image_yscale=0.75; newAttack.decayTime=-100
      }
    }
    instance_destroy()
  }
  if y>room_height+32
    instance_destroy()
}
else
{
  hspeed=0
  vspeed=0
}
