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
waterFrame+=image_speed*gDeltaTime

if global.gamePaused=false
{
  if bSelfControl=1
  {
    if y>targetWLevel
      y-=2*gDeltaTime
    else if y<targetWLevel
      y+=2*gDeltaTime
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
var tWY; tWY=floor(y+0.5) //60fps change: floor(y+0.5) (the water rises/falls 2px a tick, so it sits on half pixels between ticks, and GM8's round() rounds .5 to the even number, which stepped the surface 0 then 2 pixels)
if global.location=49
{
  for(i=0;i<image_xscale;i+=64)
  {
    //draw_sprite_ext(sWaterTopB,waterFrame,x+i,round(y),1,1,0,image_blend,image_alpha)
    draw_sprite_ext(sWaterTopB,waterFrame,x+i,tWY,1,1,0,image_blend,image_alpha) //60fps change: see the top
    for(ii=0;ii<image_yscale;ii+=64)
    {
      //draw_sprite_ext(sWaterOverlay,waterFrame,x+i,round(y+8+ii),1,1,0,image_blend,image_alpha)
      draw_sprite_ext(sWaterOverlay,waterFrame,x+i,tWY+8+ii,1,1,0,image_blend,image_alpha) //60fps change: see the top
    }
  }
}
else
{
  image_alpha=0.6
  image_speed=0.15
  for(i=0;i<image_xscale;i+=32)
  {
    //draw_sprite_ext(sWaterTopA,waterFrame,x+i,round(y),1,1,0,image_blend,image_alpha)
    draw_sprite_ext(sWaterTopA,waterFrame,x+i,tWY,1,1,0,image_blend,image_alpha) //60fps change: see the top
  }
  draw_set_alpha(image_alpha)
  draw_set_color(waterColor)
  //draw_rectangle(x,y+8,x+image_xscale,round(y+8+image_yscale),0)
  draw_rectangle(x,tWY+8,x+image_xscale,floor(y+8+image_yscale+0.5),0) //60fps change: see the top (the top edge is on the same whole pixel as the surface sprite)
}
