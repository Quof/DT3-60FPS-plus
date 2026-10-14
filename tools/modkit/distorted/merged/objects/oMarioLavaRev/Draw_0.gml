lavaFrm+=image_speed*gDeltaTime
if room=rReckoningOne
{
    for(i=0;i<image_xscale;i+=1)
    {
      draw_sprite_ext(sLavaRevBlue,lavaFrm,x+(i*16),y,1,1,image_angle,image_blend,image_alpha)
    }
    if yDraw>0
    {
      draw_sprite_part_ext(sLavaRevBlue,0,0,14,1,1,x,y,image_xscale*16,-yDraw,image_blend,image_alpha)
    }
}
else    //spsp DDLC
{
for(i=0;i<image_xscale;i+=1)
{
  draw_sprite_ext(sLavaRev,lavaFrm,x+(i*16),y,1,1,image_angle,image_blend,image_alpha)
}
if yDraw>0
{
  draw_sprite_part_ext(sLavaRev,0,0,14,1,1,x,y,image_xscale*16,-yDraw,image_blend,image_alpha)
}
}
