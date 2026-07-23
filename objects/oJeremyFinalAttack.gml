#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//-7,-29
image_blend=c_teal
image_xscale=0.001; image_yscale=0.001
initSoundPlay=0

atkProg=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if atkProg=0
{
  if initSoundPlay=0
  {
    playSound(global.snd_WepCharge,0,0.95,11000)
    initSoundPlay=1
  }
  image_xscale+=0.01; image_yscale+=0.01

  var tEffect,tFFScl,tFFDir;
  tFFScl=random(0.1)
  tFFDir=random(360)
  tEffect=instance_create(x+lengthdir_x(120,tFFDir),y+lengthdir_y(120,tFFDir),oEffectB)
  tEffect.type=3; tEffect.sprite_index=sEfFirefly; tEffect.newBlend=1
  tEffect.image_alpha=0.5; tEffect.image_xscale=0.1+tFFScl; tEffect.image_yscale=0.1+tFFScl
  tEffect.direction=tFFDir-180; tEffect.speed=11.9
  tEffect.fadeSpd=0.05; tEffect.AccelX=0; tEffect.AccelY=0; tEffect.followID=-1; tEffect.rotation=0

  if image_xscale>=1
  {
    oEvCh21MainA.sceneProgress=40
    atkProg=1
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
for(i=0;i<3;i+=1)
{
  draw_sprite_ext(sHexor_GanonOrb,0,x,y,image_xscale+(i*1.33),image_yscale+(i*1.33),image_angle,image_blend,0.5-(0.1*i))
}

draw_sprite_ext(sHexor_GanonOrb,0,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)

draw_set_blend_mode(bm_add)
draw_set_alpha(0.35)
draw_circle_color(x,y,80*image_xscale,c_white,c_black,false)
draw_set_blend_mode(bm_normal)
