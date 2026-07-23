#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_speed=0.2

if room=rWarshipZ_EscapeA or room=rWarshipZ_EscapeD {overloading=1}
else {overloading=0}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if overloading=1
{
  for(i=0;i<3;i+=1)
  {
    var tFFScl,tEffect;
    tFFScl=random(0.1)
    tEffect=instance_create(x,y,oEffect_B_Stop)
    tEffect.type=3; tEffect.sprite_index=sEfFirefly; tEffect.newBlend=1
    tEffect.image_alpha=0.3; tEffect.image_xscale=0.15+tFFScl; tEffect.image_yscale=0.15+tFFScl
    tEffect.direction=random(360); tEffect.speed=random(5)+4; tEffect.friction=random(0.05)+0.05
    tEffect.fadeSpd=0.005; tEffect.image_blend=c_white
    tEffect.AccelX=0; tEffect.AccelY=0; tEffect.followID=-1; tEffect.rotation=0
  }
}
else if overloading=0
{
  var tFFScl,tEffect;
  tFFScl=random(0.1)
  tEffect=instance_create(x,y,oEffect_B_Stop)
  tEffect.type=3; tEffect.sprite_index=sEfFirefly; tEffect.newBlend=1
  tEffect.image_alpha=0.3; tEffect.image_xscale=0.15+tFFScl; tEffect.image_yscale=0.15+tFFScl
  tEffect.direction=random(360); tEffect.speed=random(2)+2; tEffect.friction=random(0.025)+0.025
  tEffect.fadeSpd=0.005; tEffect.image_blend=c_white
  tEffect.AccelX=0; tEffect.AccelY=0; tEffect.followID=-1; tEffect.rotation=0
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if overloading=1
{
  for(i=0;i<5;i+=1)
  {
    draw_sprite_ext(sWS_PowerSourceA,image_index,x,y,1+(i*0.66),1+(i*0.66),90,c_white,0.2)
  }
  for(i=0;i<5;i+=1)
  {
    draw_sprite_ext(sWS_PowerSourceA,image_index,x,y,1+(i*0.66),1+(i*0.6),0,c_white,0.2)
  }
}
else
{
  for(i=0;i<5;i+=1)
  {
    draw_sprite_ext(sWS_PowerSourceA,image_index,x,y,1+(i*0.25),1+(i*0.25),90,c_white,0.2)
  }
  for(i=0;i<5;i+=1)
  {
    draw_sprite_ext(sWS_PowerSourceA,image_index,x,y,1+(i*0.25),1+(i*0.25),0,c_white,0.2)
  }
}
