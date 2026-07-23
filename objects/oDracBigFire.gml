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
damageType="EXPLOSION"
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  tRanSize=random(0.2)
  tEffect=instance_create(x-(16*image_xscale)+random(32*image_xscale),y-(16*image_yscale)+random(32*image_yscale),oEffect)
  tEffect.sprite_index=choose(sSamusCannonHit,sSamusMissileHit)
  tEffect.image_xscale=0.3+tRanSize; tEffect.image_yscale=0.3+tRanSize
  tEffect.image_alpha=0.4+random(0.2); tEffect.image_speed=0.4+random(0.3)
  tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0

  speed=bulletSpeed
  if bulletSpeed<bulletMax
    bulletSpeed+=bulletAcc

  if direction>=90 and direction<=270
    image_angle+=rotSpd
  else
    image_angle-=rotSpd
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
