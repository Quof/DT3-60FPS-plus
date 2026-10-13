if lifeTime<43 //trail
{
  draw_set_blend_mode(bm_add)
  draw_line_color(x,y,x-(68*image_xscale),y,c_red,c_black)
  draw_set_blend_mode(bm_normal)
}
draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,0.75)
draw_sprite_ext(sBelmontDagger,0,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
