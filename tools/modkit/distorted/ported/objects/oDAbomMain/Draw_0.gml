draw_self()

if spikeScale>0
{
  //if spikeScale<2 {spikeScale+=0.05}
  if spikeScale<2 {spikeScale+=0.05*gDeltaTime} //60fps change: per frame (Draw runs every frame)
  draw_sprite_ext(sAbom_Spike,0,x-156,y-54,spikeScale,spikeScale,image_angle+155,image_blend,image_alpha)
  draw_sprite_ext(sAbom_Spike,0,x-144,y-139,spikeScale,spikeScale,image_angle+135,image_blend,image_alpha)
  draw_sprite_ext(sAbom_Spike,0,x-142,y-214,spikeScale,spikeScale,image_angle+130,image_blend,image_alpha)
  draw_sprite_ext(sAbom_Spike,0,x-131,y-282,spikeScale,spikeScale,image_angle+125,image_blend,image_alpha)
  draw_sprite_ext(sAbom_Spike,0,x-114,y-308,spikeScale,spikeScale,image_angle+65,image_blend,image_alpha)
  draw_sprite_ext(sAbom_Spike,0,x-115,y-253,spikeScale,spikeScale,image_angle+40,image_blend,image_alpha)
  draw_sprite_ext(sAbom_Spike,0,x-87,y-195,spikeScale,spikeScale,image_angle+75,image_blend,image_alpha)
  draw_sprite_ext(sAbom_Spike,0,x-30,y-194,spikeScale,spikeScale,image_angle+100,image_blend,image_alpha)
  draw_sprite_ext(sAbom_Spike,0,x-20,y-213,spikeScale,spikeScale,image_angle+70,image_blend,image_alpha)
  draw_sprite_ext(sAbom_Spike,0,x+29,y-192,spikeScale,spikeScale,image_angle+85,image_blend,image_alpha)
  draw_sprite_ext(sAbom_Spike,0,x+87,y-184,spikeScale,spikeScale,image_angle+115,image_blend,image_alpha)
  draw_sprite_ext(sAbom_Spike,0,x+117,y-229,spikeScale,spikeScale,image_angle+125,image_blend,image_alpha)
  draw_sprite_ext(sAbom_Spike,0,x+117,y-270,spikeScale,spikeScale,image_angle+90,image_blend,image_alpha)
  draw_sprite_ext(sAbom_Spike,0,x+142,y-267,spikeScale,spikeScale,image_angle+65,image_blend,image_alpha)
  draw_sprite_ext(sAbom_Spike,0,x+138,y-204,spikeScale,spikeScale,image_angle+50,image_blend,image_alpha)
  draw_sprite_ext(sAbom_Spike,0,x+141,y-91,spikeScale,spikeScale,image_angle+30,image_blend,image_alpha)
}
/*
draw_set_alpha(0)
for(jj=0;jj<spinPhase;jj+=1)
{
  draw_rectangle_color(-5,-5,room_width+5,room_height+5,c_red,c_red,c_red,c_red,false)
}
*/
