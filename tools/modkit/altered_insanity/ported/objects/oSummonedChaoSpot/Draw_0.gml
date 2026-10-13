draw_sprite_ext(sCircle,-1,x,y,image_xscale,image_yscale,0,image_blend,image_alpha)
if (transformAddColor != 0)
{
    draw_sprite_ext(sCircle,-1,x,y,image_xscale-0.3,image_yscale-0.3,0,second_blend,image_alpha) //add extra blend circle
}
draw_sprite_ext(sCircle,-1,x,y,image_xscale*2.2,image_yscale*2.2,0,c_gray,0.2) //aoe of no summon
draw_pie(x ,y ,decayTime, 240, c_white, 18, 0.4)
