if atkPhase=2
{
    draw_set_color(make_color_rgb(0,255,0))
    draw_set_alpha(1)
    draw_circle(x,y,400,1)
}

if atkPhase=3
{
    draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
    if tempSeph>=0
    {
        draw_sprite_ext(sSeph_Summon,tempSeph,720,312,1,1,0,c_white,1)
        draw_sprite_ext(sSeph_Summon,tempSeph,1008,312,-1,1,0,c_white,1)
    }
    if atkTime[0]>0 {draw_sprite_ext(sLeek,0,x-30,y-16,1,1,danceTime,c_white,1)}
}
else if atkPhase=4
{
    if cycleCounter=0
    {
        draw_set_color(newColorFinal)
        draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,c_blue,image_alpha)
    }
    else if cycleCounter>0
    {
        draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
    }
    if chatcool>0
    {
        draw_sprite_ext(sLeek,0,x+leekX,y+leekY,1,1,leekAngle,c_white,1)
    }
    /*if atkTime[1] mod ( applewait-5*(bossProgress-1) ) > ( applewait-5*(bossProgress-1) ) - 30
    {
        draw_set_color(make_color_rgb(0,255,0))
        draw_set_alpha(0.5)
        draw_circle(x,y,16,0)
    }*/
}
else
{
    draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
}

// infinity sign
/*if atkPhase=5
{
    if atkTime[0]<110
    {
        if atkTime[0] mod 20 < 10
        {
            draw_sprite_ext(sEfInf,0,oPlayer1.x,oPlayer1.y-40,1,1,0,c_white,1)
        }
    }
}*/
