if drawType=1 //Gate 2 - Water Dungeon Barrier
{
  for(i=0;i<4;i+=1)
  {
    for(ii=0;ii<8;ii+=1)
    {
      draw_sprite(sZapBarrier,image_index,x+(i*16),y+(ii*16))
    }
  }
}
else if drawType=2 //andrew's evil barrier
{
    if global.cousinoer5Progress >= 1000 and room=rBT_Cousinoer5HUB_Newer
    {
        for(i=0;i<16;i+=1)
        {
            for(ii=0;ii<16;ii+=1)
            {
              draw_sprite_ext(sZapBarrier,image_index,x+(i*16),y+(ii*16),1,1,0,c_green,1)
            }
        }
    }
    else
    {
        for(i=0;i<16;i+=1)
        {
            for(ii=0;ii<16;ii+=1)
            {
              draw_sprite_ext(sZapBarrier,image_index,x+(i*16),y+(ii*16),1,1,0,c_red,1)
            }
        }
    }
}
