#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
setCollisionBounds(-12,-12,12,12)
image_speed=0
image_xscale=0.2
image_yscale=0.2

//Enemy base statistics
bShowHealthBar=false
bShowDamage=false
bCanTakeDamage=false
explodeTime=22
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if type=0 //Arc shot
  {
    speed=bulletSpeed
  }
  else if type=1 //Fast shot
  {
    speed=bulletSpeed
    image_xscale+=0.05; image_yscale+=0.05

    explodeTime-=1
    if explodeTime<=0
    {
      newAttack=instance_create(x,y,oDamageExplosion)
      newAttack.atkPower=atkPower
      newAttack.sprite_index=sBombExplosion
      newAttack.image_xscale=1.75
      newAttack.image_yscale=1.75
      newAttack.decayTime=-100
      instance_destroy()
    }
  }
}
else {speed=0}
