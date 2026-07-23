#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.newMapX=1 {lifeTime=35}
else if global.newMapX=2
{
  sprite_index=sMMXgravityWell1
  image_speed=0.4
  lifeTime=50
  gravityProg=0
}
else if global.newMapX=3
{
  sprite_index=sMMXstrikeChainEnd
  bodyFrm=0
  extend=0
  bRetract=0
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if type=1 //Shotgun Ice Main
{
  if oGame.time mod 2=0
  {
    tEffect=instance_create(x,y,oEffect)
    tEffect.sprite_index=sMMshotgunIceEffect; tEffect.image_speed=0.5; tEffect.ySpd=1.5
    tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0
  }
  speed=11
  image_angle-=10

  lifeTime-=1
  if lifeTime=0
  {
    var playerAttack,tIceDir; tIceDir=135
    for(i=0;i<3;i+=1)
    {
      playerAttack=instance_create(x-9,y,oEvCh8WepTest)
      playerAttack.direction=tIceDir; playerAttack.image_xscale=-1
      playerAttack.type=2; playerAttack.sprite_index=sMMXshotgunIce2
      tIceDir+=45
    }
    instance_destroy()
  }
}
else if type=2 //Shotgun Ice Break
{
  speed=11
  image_angle+=10
  lifeTime-=1
  if lifeTime=0 {instance_destroy()}
}
else if type=11 //Gravity Well
{
  if gravityProg=0
  {
    speed=4
    lifeTime-=1
    if lifeTime=0 {gravityProg=1}
  }
  else if gravityProg=1
  {
    speed=0
    sprite_index=sMMXgravityWell3
    image_alpha=0.75
    lifeTime=30
    gravityProg=2
  }
  else if gravityProg=2
  {
    if lifeTime mod 3=0 {image_angle=random(360)}
    lifeTime-=1
    if lifeTime=0 {instance_destroy()}
  }
}
else if type=21 //Strike Chain
{
  bodyFrm+=0.33
  if bRetract=0
  {
    extend+=8
    if extend>=64 {bRetract=1}
  }
  else
  {
    extend-=8
    if extend<=0 {instance_destroy()}
  }
  x=108+extend
  y=252
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if type=21
{
  for(i=0;i<extend/8;i+=1)
  {
    draw_sprite_ext(sMMXstrikeChainBody,bodyFrm,x-(i*8),y,1,1,0,image_blend,image_alpha)
  }
  draw_sprite_ext(sprite_index,image_index,x,y,1,1,0,image_blend,image_alpha)
}
else
{
  draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
}
