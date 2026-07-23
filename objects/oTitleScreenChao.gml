#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_speed=0.3
moveProg=0
effectDelay=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//----- Movement -----
moveProg+=1
if moveProg=30
{
  direction=175
  speed=3.5
}
else if moveProg>=111 and moveProg<=190
{
  direction-=0.5
  speed-=0.015
}
else if moveProg=320
{
  x=-16
  y=40
  direction=0
  speed=1.2
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
    speed=2
    direction=65
    moveProg=10000
  }
}

//----- Effect -----
effectDelay+=1
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
