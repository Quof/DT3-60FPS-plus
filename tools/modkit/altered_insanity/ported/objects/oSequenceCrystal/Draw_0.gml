draw_sprite_ext(sColorZoneDiamond,set,x,y,image_xscale,image_yscale,0,image_blend,image_alpha)
//draw 1 ahead
if (current < maxPosition)
{
    draw_sprite_ext(sColorZoneDiamond,set,positionsX[current+1],positionsY[current+1],image_xscale,image_yscale,0,image_blend,0.5)
    
    if (current+1 < maxPosition)
    {
        draw_sprite_ext(sColorZoneDiamond,set,positionsX[current+2],positionsY[current+2],image_xscale,image_yscale,0,image_blend,0.1)
    }
    else if (looping = true)
    {
            draw_sprite_ext(sColorZoneDiamond,set,positionsX[0],positionsY[0],image_xscale,image_yscale,0,image_blend,0.1)
    }
}
else if (looping = true)
{
    draw_sprite_ext(sColorZoneDiamond,set,positionsX[0],positionsY[0],image_xscale,image_yscale,0,image_blend,0.5)
    draw_sprite_ext(sColorZoneDiamond,set,positionsX[1],positionsY[1],image_xscale,image_yscale,0,image_blend,0.1)
}

//draw_set_color(c_white)
//draw_set_alpha(1)
//draw_set_font(fnt_ColorTime)
//draw_set_halign(fa_center)
//timerText = string_format(current,2,0) + ":" + string_format(maxPosition,2,0)
//draw_text(x,y,timerText)
