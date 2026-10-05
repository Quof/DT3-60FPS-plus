#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_speed=0.3
moveProg=0
effectDelay=0
_speed=0
_direction=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//----- Movement -----
moveProg+=1*gDeltaTime
if moveProg=30
{
  _direction=175
  _speed=3.5
}
//else if moveProg>=111 and moveProg<=190
else if moveProg>110 and moveProg<=190 //60fps change: covers every frame of ticks 111-190
{
  //_direction-=0.5
  //_speed-=0.015
  _direction-=0.5*gDeltaTime //60fps change: the curve turned 2x/4x as much at 60/120fps
  _speed-=0.015*gDeltaTime //60fps change: and slowed 2x/4x as much
}
else if moveProg=320
{
  x=-16
  y=40
  _direction=0
  _speed=1.2
}
else if moveProg>=321 and moveProg<=900
{
  if x>=12
  {
    oInitializeGame.introProg=1
    moveProg=1000
  }
}
else if moveProg>=1000 and moveProg<=9000
{
  var tFFScl;
  tFFScl=random(0.1)
  tEffect=instance_create(x,y,oEffectB)
  tEffect.depth=-5; tEffect.type=3; tEffect.sprite_index=sEfFirefly; tEffect.image_alpha=0.3
  tEffect.image_xscale=0.2+tFFScl; tEffect.image_yscale=0.2+tFFScl; tEffect.direction=random_range(265,275)
  tEffect.speed=random(1.25)+2.25; tEffect.friction=random(0.03)+0.03; tEffect.fadeSpd=0.005
  tEffect.image_blend=make_color_rgb(random(80),255,random(80))
  tEffect.AccelX=0; tEffect.AccelY=0; tEffect.newBlend=1; tEffect.followID=-1; tEffect.rotation=0

  if x>=452
  {
    _speed=2
    _direction=65
    moveProg=10000
  }
}
//_speed=0
//60fps change: removed the "_speed=0" above; it ran every step after the movement code set _speed, so the title screen Chao never moved (it used to be "speed=0", stopping GM's built-in motion while this object moved itself; renaming it to _speed=0 zeroed the speed instead)

//----- Effect -----
effectDelay+=1*gDeltaTime
if effectDelay mod 6=0
{
  var tFFScl;
  tFFScl=random(0.1)
  tEffect=instance_create(x,y,oEffectB)
  tEffect.type=3; tEffect.sprite_index=sEfFirefly; tEffect.image_alpha=0.3
  tEffect.image_xscale=0.15+tFFScl; tEffect.image_yscale=0.15+tFFScl; tEffect.direction=random(360)
  tEffect.speed=random(1)+0.5; tEffect.friction=random(0.03)+0.01; tEffect.fadeSpd=0.005
  tEffect.image_blend=make_color_rgb(random(50),255,random(50))
  tEffect.AccelX=0; tEffect.AccelY=0; tEffect.newBlend=1; tEffect.followID=-1; tEffect.rotation=0
}
correctSpeedDirection(self)
