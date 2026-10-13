draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)

if (hasBomb = 1)
{
    draw_sprite_ext(sLinkBomb,0,x+lengthdir_x(15,image_angle),y+lengthdir_y(15,image_angle),1,1,0,image_blend,image_alpha)
}
