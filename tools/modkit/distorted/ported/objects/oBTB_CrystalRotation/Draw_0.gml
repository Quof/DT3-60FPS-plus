if armsCreated=1
{
  for(i=0;i<armNum;i+=1)
  {
    draw_sprite_ext(sBM_Chain,0,x,y,armLength/75,0.3,(i*(360/armNum))+armsRotation,image_blend,0.7)
  }
}
