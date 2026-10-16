//Evil Boss Gallery: Death's draw (his hit spot's flash), faded while he's vanished (fadeA), flashing pale while he's
//staggered, red as his soul siphon is about to reap
draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,myHS.image_blend,image_alpha*fadeA)
var tFl;
tFl=0
if staggerTime>0
{
  if (floor(staggerTime/4) mod 2)=0 {tFl=1}
}
if evgMove=3 and evgStage=1 and evgT>=66
{
  if (floor(evgT/3) mod 2)=0 {tFl=2}
}
if tFl>0
{
  draw_set_blend_mode(bm_add)
  if tFl=1 {draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,make_color_rgb(110,110,150),image_alpha*0.7)}
  else {draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,make_color_rgb(170,20,40),image_alpha*0.8)}
  draw_set_blend_mode(bm_normal)
}
if staggerTime>0 //dizzy wisps over his head
{
  var k,tA;
  draw_set_color(make_color_rgb(255,230,150))
  for(k=0;k<3;k+=1)
  {
    tA=staggerTime*8+k*120
    draw_circle(x+lengthdir_x(14,tA),y-84+lengthdir_y(4,tA),2,0)
  }
  draw_set_color(c_white)
}
