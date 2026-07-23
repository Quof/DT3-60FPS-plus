#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
sprite_index=sScaledCollision
image_alpha=0.18 //0.6
image_speed=0.1 //0.15
waterFrame=0
waterColor=make_color_rgb(24,24,80)
targetWLevel=y
if global.location=49 or global.location=58 {bSelfControl=0}
else {bSelfControl=1}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
waterFrame+=image_speed

if global.gamePaused=false
{
  if bSelfControl=1
  {
    if y>targetWLevel
      y-=2
    else if y<targetWLevel
      y+=2
  }
}

if global.debugMenu=true
{
  if keyboard_check(ord("R"))
  {
    targetWLevel-=2
    y-=2
  }
  else if keyboard_check(ord("F"))
  {
    targetWLevel+=2
    y+=2
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.location=49
{
  for(i=0;i<image_xscale;i+=64)
  {
    draw_sprite_ext(sWaterTopB,waterFrame,x+i,round(y),1,1,0,image_blend,image_alpha)
    for(ii=0;ii<image_yscale;ii+=64)
    {
      draw_sprite_ext(sWaterOverlay,waterFrame,x+i,round(y+8+ii),1,1,0,image_blend,image_alpha)
    }
  }
}
else
{
  image_alpha=0.6
  image_speed=0.15
  for(i=0;i<image_xscale;i+=32)
  {
    draw_sprite_ext(sWaterTopA,waterFrame,x+i,round(y),1,1,0,image_blend,image_alpha)
  }
  draw_set_alpha(image_alpha)
  draw_set_color(waterColor)
  draw_rectangle(x,y+8,x+image_xscale,round(y+8+image_yscale),0)
}
