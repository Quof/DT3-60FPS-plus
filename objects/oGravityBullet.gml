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
if global.gamePaused=false //&& gDeltaDoTicks != 0
{
  yVel+=grav*gDeltaTime
  if sprite_index=sHammerBHam or sprite_index=sHammerThrowerHammer or sprite_index=sFireBroFire or sprite_index=sKingWormSpike or sprite_index=sLargeSnowball
  {
    if xVel>0 {image_angle-=10}
    else if xVel<0 {image_angle+=10}
  }

  if isCollisionTop(1) {bDestroy=1}
  if isCollisionBottom(1) {bDestroy=1}
  if isCollisionLeft(1) {bDestroy=1}
  if isCollisionRight(1) {bDestroy=1}
  moveTo(xVel*gDeltaTime,yVel*gDeltaTime)

  if bDestroy=1
  {
    if sprite_index=sBDBomb or sprite_index=sEnmityBomb
    {
      newAttack=instance_create(x,y,oDamageExplosion)
      newAttack.atkPower=atkPower; newAttack.sprite_index=sBombExplosion
      newAttack.image_xscale=0.75; newAttack.image_yscale=0.75; newAttack.decayTime=-100
    }
    else if sprite_index=sNotorBangerBomb
    {
      newAttack=instance_create(x,y,oDamageExplosion)
      newAttack.atkPower=atkPower; newAttack.sprite_index=sBombExplosion; newAttack.decayTime=-100
    }
    else if sprite_index=sBelmontHolyWater
    {
      newAttack=instance_create(x,y,oDamageExplosion)
      newAttack.atkPower=atkPower; newAttack.sprite_index=sBelmontHolyFire; newAttack.decayTime=-100
      newAttack.image_xscale=1.75; newAttack.image_yscale=1.75
      newAttack.image_blend=c_black
    }
    else if sprite_index=sC_TurretBombA
    {
      newAttack=instance_create(x,y,oDamageExplosion)
      newAttack.atkPower=atkPower; newAttack.sprite_index=sC_TBExplodeA; newAttack.decayTime=-100
    }
    else if sprite_index=sC_TurretBombB
    {
      newAttack=instance_create(x,y,oDamageExplosion)
      newAttack.atkPower=atkPower; newAttack.sprite_index=sC_TBExplodeB; newAttack.decayTime=-100
    }
    instance_destroy()
  }
  if y>room_height+32 {instance_destroy()}
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
magicInterpDrawStart()
event_inherited()
magicInterpDrawEnd()
