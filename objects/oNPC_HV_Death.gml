#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
paraAngle=0
bShowPara=1
eventProg=0
eventTime=0

if global.gameProgress>=4950 {instance_destroy()}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
paraAngle+=10

if eventProg=1
{
  eventTime+=1
  if eventTime=1 {bShowPara=0}
  else if eventTime=10 {playSound(global.snd_FadeAway,0,0.92,1)}
  else if eventTime>=11
  {
    image_alpha-=0.05
    var tFFScl,tEffect;
    for(i=0;i<3;i+=1)
    {
      tFFScl=random(0.1)
      tEffect=instance_create(x+random_range(-sprite_width/2+2,sprite_width/2-2),y-1-random(sprite_height-2),oEffectB)
      tEffect.type=3; tEffect.sprite_index=sEfFirefly; tEffect.newBlend=1
      tEffect.image_alpha=0.3; tEffect.image_xscale=0.15+tFFScl; tEffect.image_yscale=0.15+tFFScl
      tEffect.direction=random_range(70,110); tEffect.speed=random(1)+1; tEffect.friction=random(0.02)+0.02
      tEffect.fadeSpd=0.005; tEffect.image_blend=make_color_rgb(random(50),random(50),255)
      tEffect.AccelX=0; tEffect.AccelY=0; tEffect.followID=-1; tEffect.rotation=0
    }
  }

  if image_alpha<=0
  {
    instance_create(x-16,y-16,oZeldaBreakPot)
    instance_create(x,y-16,oZeldaBreakPot)
    instance_destroy()
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)

if bShowPara=1
{
  draw_sprite_ext(sParalyzingRing,image_index,x,y-(sprite_height/2),1.5,1.5,-paraAngle,image_blend,0.2)
  draw_sprite_ext(sParalyzingRing,image_index,x,y-(sprite_height/2),1,1,paraAngle,image_blend,0.66)
}
