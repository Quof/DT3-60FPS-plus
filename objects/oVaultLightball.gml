#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_blend=make_color_rgb(130,130,255)
image_alpha=0.5
speed=4
timeOnScreen=0
efTime=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
efTime+=1
if efTime mod 3=0
{
  var tDir,tFFScl;
  tDir=direction+160+random(40)
  tFFScl=random(0.15)
  tEffect=instance_create(x,y,oEffectB)
  tEffect.type=3; tEffect.sprite_index=sEfFirefly; tEffect.image_alpha=0.1
  tEffect.image_xscale=0.3+tFFScl; tEffect.image_yscale=0.3+tFFScl; tEffect.direction=tDir
  tEffect.speed=random(0.5)+1; tEffect.fadeSpd=0.005; tEffect.image_blend=image_blend
  tEffect.AccelX=0; tEffect.AccelY=0; tEffect.newBlend=1; tEffect.followID=-1; tEffect.rotation=0
}

timeOnScreen+=1
if timeOnScreen>=45
{
  if checkScreenArea(x,y,16)=0 {instance_destroy()}
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_set_alpha(image_alpha)
draw_set_blend_mode(bm_add)
draw_circle_color(x,y,16,image_blend,c_black,false)
draw_set_blend_mode(bm_normal)
