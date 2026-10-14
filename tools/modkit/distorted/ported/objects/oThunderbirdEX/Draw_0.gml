if shieldUp=0
{
draw_sprite_ext(sThunderbirdBody,0,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
draw_sprite_ext(sThunderbirdWing,animFrame,x+15,y-23,1,image_yscale,image_angle,image_blend,image_alpha)
draw_sprite_ext(sThunderbirdWing,animFrame,x-15,y-23,-1,image_yscale,image_angle,image_blend,image_alpha)
}
else
{
    draw_sprite_ext(sTEXbodyshield,0,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
    draw_sprite_ext(sTEXwingshield,animFrame,x+15,y-23,1,image_yscale,image_angle,image_blend,image_alpha)
    draw_sprite_ext(sTEXwingshield,animFrame,x-15,y-23,-1,image_yscale,image_angle,image_blend,image_alpha)
}
