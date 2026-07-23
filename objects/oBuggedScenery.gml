#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if drawType=0
{
  if oPlayer1.x mod 2=0
  {
    draw_background_part(tileLavaCave,96,64,32,16,x,y)
  }
}
else if drawType=1
{
  if oPlayer1.x<1072
  {
    if oPlayer1.x mod 14!=0
    {
      for(i=0;i<image_xscale;i+=1)
      {
        draw_sprite(sLava,image_index+(i*0.01),x+(i*16),y)
      }
      draw_background_part_ext(tileLavaCave,128,64,16,16,x,y+16,image_xscale,image_yscale,c_white,1)
    }
  }
}
else if drawType=2
{
  if oPlayer1.y<772
  {
    for(i=0;i<image_xscale;i+=1)
    {
      draw_sprite(sLava,image_index+(i*0.01),x+(i*16),y)
    }
    draw_background_part_ext(tileLavaCave,128,64,16,16,x,y+16,image_xscale,image_yscale,c_white,1)
  }
}
else if drawType=3
{
  if oPlayer1.x mod 14!=0
  {
    for(i=0;i<image_yscale;i+=1)
    {
      draw_background_part(tileLavaCave,96,64,16,16,x,y+(16*i))
    }
  }
}
else if drawType=4
{
  for(i=0;i<image_yscale;i+=1)
  {
    draw_background_part(tileLavaCave,96,64,16,16,x,y+(16*i))
  }
}
