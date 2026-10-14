image_blend=make_color_rgb(255,255,colTime)
if bWaggle=0
{
  draw_sprite_ext(sChaosLaserBeam,0,x,y,image_xscale,1,image_angle,image_blend,1)
  draw_sprite_ext(sChaosLaserBorder,0,x,y,image_xscale,1,image_angle,c_white,1)
  draw_sprite(sChaosLaserBase,0,x,y)
  draw_sprite_ext(sChaosLaserGun,0,x,y,1,1,image_angle,c_white,1)
}
else
{
  draw_sprite_ext(sChaosLaserBeam,0,x,y,image_xscale,1,myDir,image_blend,1)
  draw_sprite_ext(sChaosLaserBorder,0,x,y,image_xscale,1,myDir,c_white,1)
  draw_sprite(sChaosLaserBase,0,x,y)
  draw_sprite_ext(sChaosLaserGun,0,x,y,1,1,myDir,c_white,1)
}
