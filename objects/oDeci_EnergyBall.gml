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
atkPower=12
decayTime=150
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  decayTime-=1
  if decayTime<=0 {instance_destroy()}

  image_angle-=10
  speed=bulletSpeed
}
else {speed=0}
#define Collision_oAttackBase
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if other.weaponTag<100
{
  with other
  {
    if bCanPierce=0 {instance_destroy()}
  }

  var tEffect;
  tEffect=instance_create(x,y,oEffect)
  tEffect.sprite_index=sMMchargeComplete
  tEffect.followID=-1; tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
  instance_destroy()
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_sprite_ext(sDeci_EnergyBall,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,0.25)
draw_sprite_ext(sDeci_EnergyBall,image_index+1,x,y,image_xscale,image_yscale,image_angle+90,image_blend,0.25)
draw_sprite_ext(sDeci_EnergyBall,image_index,x,y,image_xscale,image_yscale,image_angle+180,image_blend,0.25)
draw_sprite_ext(sDeci_EnergyBall,image_index+1,x,y,image_xscale,image_yscale,image_angle+270,image_blend,0.25)
