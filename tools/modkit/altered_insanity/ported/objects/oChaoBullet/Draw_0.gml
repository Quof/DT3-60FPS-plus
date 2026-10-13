draw_sprite_ext(sVP_ChaoBullet,-1,x,y,image_xscale,image_yscale,image_angle,c_white,1)

draw_set_blend_mode(bm_add)
if blend[0]!=c_white
{
    draw_sprite_ext(sVP_ChaoBullet,-1,x,y,image_xscale,image_yscale,image_angle,blend[0],0.5)
}
if blend[1]!=c_white
{
    draw_sprite_ext(sVP_ChaoBullet,-1,x,y,image_xscale,image_yscale,image_angle,blend[1],0.5)
}
if blend[2]!=c_white
{
    draw_sprite_ext(sVP_ChaoBullet,-1,x,y,image_xscale,image_yscale,image_angle,blend[2],0.5)
}
draw_set_blend_mode(bm_normal)
