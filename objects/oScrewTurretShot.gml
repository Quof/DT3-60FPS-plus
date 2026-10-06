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
_direction=0
_speed=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  _speed=bulletSpeed
  image_angle=_direction
  //image_blend=make_color_rgb(155+random(100),155+random(100),155+random(100))
  if gDeltaDoTicks {image_blend=make_color_rgb(155+random(100),155+random(100),155+random(100))} //60fps change: new random color once per 30fps tick (flickered 2x/4x as fast at 60/120fps)
  //if oGame.time mod 2=0
  if oGame.time mod (2/gDeltaTime)=0 //60fps change: oGame.time counts frames, so this made 2x/4x the sparkles at 60/120fps
  {
    tEffect=instance_create(x+random_range(-5,5),y+random_range(-5,5),oEffect)
    tEffect.sprite_index=sMMshotgunIceEffect; tEffect.image_speed=0.5; tEffect.image_angle=random(360); tEffect.image_blend=image_blend
    tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=random_range(-1,1); tEffect.ySpd=random_range(-1,1)
  }

  decayTime-=1*gDeltaTime
  if decayTime<=0 {instance_destroy()}
}
else {_speed=0}

correctSpeedDirection(self)
