if global.gamePaused=false and life<=dead and (reviveFull - reviveTime <= 90)
{
    //shrinking circle
    draw_set_alpha(0.75)
    draw_set_color(c_white)
    draw_circle(x,y,(reviveFull - reviveTime)/2,1)
}
