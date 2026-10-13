if (show = true)
{
    xPort=view_xview[0]+340
    yPort=view_yview[0]+8
    draw_sprite_ext(sEnemyChat,0,xPort,yPort,0.55,1,0,c_white,1)
    
    draw_set_color(c_white)
    draw_set_alpha(1)
    draw_set_font(fnt_ColorTime)
    draw_set_halign(fa_center)
    timerText = string_format(floor(secondsLeft/60),1,0) + ":" + string_replace(string_format(secondsLeft mod 60,2,0),' ','0')
    draw_text(xPort+24,yPort+4,timerText)
}
