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
atkPower=12
runAcc=1
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if oGame.time mod 3=0
  {
    var tEffect;
    tEffect=instance_create(x+23,y+24,oEffect)
    tEffect.sprite_index=sMMSmokeCloud; tEffect.followID=-1; tEffect.xFollow=0; tEffect.yFollow=0
    tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0.5+random(1.5); tEffect.ySpd=random_range(-0.25,0.25); tEffect.image_alpha=0.5
    tEffect.image_xscale=0.5; tEffect.image_yscale=0.5; tEffect.image_speed=0.2
  }
  x-=runAcc
  if x<=-48 {instance_destroy()}
}
#define Collision_oAttackBase
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if other.bCanPierce=0
{
  with other {instance_destroy()}
}
