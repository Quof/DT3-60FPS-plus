/*
This script is called in the enemy draw event.
*/
draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
if weakened > 0
{
     draw_sprite(sScanMenuHitDetect,0,round(bbox_left+(abs(sprite_width/2))),bbox_top-20)
}
