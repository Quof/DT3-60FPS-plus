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
atkPower=12
lifeTime=0
_direction=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  image_angle=_direction
  lifeTime+=1*gDeltaTime
  //if lifeTime>=1 and lifeTime<=35 and gDeltaDoTicks
  if lifeTime>=1 and lifeTime<=35 and frac(lifeTime)=0 //60fps change: trail on this shot's own ticks (35 like 30fps)
  {
    var tEffect,tScale;
    tScale=random(0.17)
    tEffect=instance_create(x+random_range(-8,8),y+random_range(-8,8),oEffect)
    tEffect.sprite_index=sAbom_Tentacle; tEffect.image_speed=0.33; tEffect.image_alpha=0.75
    tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=15; tEffect.xSpd=random_range(-2,2); tEffect.ySpd=random_range(-2,2)
    tEffect.image_xscale=0.13+tScale; tEffect.image_yscale=0.13+tScale; tEffect.image_angle=random(360)
  }
  //if lifeTime=50
  if lifeTime=49+gDeltaTime //60fps change: aims on the first frame of tick 50, so it moves on every frame of that tick
  {
    _direction=point_direction(x,y,oPlayer1.x,returnPlayerYCenter())
  }

  //if lifeTime>=1 and lifeTime<=35 {_speed=5.5}
  //else if lifeTime>=50 {_speed=10}
  if lifeTime>0 and lifeTime<=35 {_speed=5.5} //60fps change: covers every frame of ticks 1-35 (the burst fell up to 4px short at 60/120fps)
  else if lifeTime>49 {_speed=10} //60fps change: covers every frame of tick 50
  else {_speed=0}
}
else {_speed=0}

correctSpeedDirection(self)
#define Other_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if lifeTime>=50 {instance_destroy()}
