#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Requires: decayTime,bulletSpeed
event_inherited()

//Enemy base statistics
bShowHealthBar=false
bShowDamage=false
bCanTakeDamage=false
decayTime=50
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  speed=bulletSpeed
  image_angle=direction
  image_blend=make_color_rgb(155+random(100),155+random(100),155+random(100))
  if oGame.time mod 2=0
  {
    tEffect=instance_create(x+random_range(-5,5),y+random_range(-5,5),oEffect)
    tEffect.sprite_index=sMMshotgunIceEffect; tEffect.image_speed=0.5; tEffect.image_angle=random(360); tEffect.image_blend=image_blend
    tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=random_range(-1,1); tEffect.ySpd=random_range(-1,1)
  }

  decayTime-=1
  if decayTime<=0 {instance_destroy()}
}
else {speed=0}
