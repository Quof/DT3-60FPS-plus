if timeToDecide >= 0
{
draw_set_alpha(1)
draw_set_color(c_white)
draw_line(centerPoint,0,centerPoint,10000)

draw_set_color(c_red)
draw_set_alpha(1)
draw_set_font(fnt_NES)
draw_set_halign(fa_center)
draw_text(centerPoint,70,"CHOOSE YOUR FATE  " + string_format(timeToDecide,3,0))
draw_set_halign(fa_right)
draw_set_color(c_red)
draw_text(centerPoint -60, 90, "BONKERS")
draw_set_halign(fa_left)
draw_set_color(c_white)
draw_text(centerPoint +60, 90, "HARD")
}
else
{

    draw_set_color(c_red)
    draw_set_alpha(1)
    draw_set_font(fnt_NES)
    draw_set_halign(fa_center)  
    if path = 1
    {
        draw_set_color(c_white)
        draw_text(centerPoint,70,"FATE WAS CHOSEN [HARD]. " + msg)
    }
    else
    {
        draw_set_color(c_red)
        draw_text(centerPoint,70,"FATE WAS CHOSEN [BONKERS]. " + msg)
    }
}
