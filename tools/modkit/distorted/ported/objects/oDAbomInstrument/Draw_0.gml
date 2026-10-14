if bCanTakeDamage=0
  {
    for (i=0;i<3;i+=1)
    {
      if effectSize[i]<1.75
      {
        effectSize[i]+=0.01*gDeltaTime
        effectAlpha[i]-=0.01*gDeltaTime
      }
      else
      {
        effectSize[i]=1
        effectAlpha[i]=0.75
      }
    }
    draw_set_blend_mode(bm_add)
    draw_set_alpha(0.4)
    draw_circle_color(x,y,20,make_color_rgb(240,160,70),c_black,false)
    draw_set_alpha(0.3)
    draw_circle_color(x,y,35,make_color_rgb(240,160,70),c_black,false)
    draw_set_alpha(0.2)
    draw_circle_color(x,y,50,make_color_rgb(240,160,70),c_black,false)
    for(i=0;i<3;i+=1) {draw_sprite_ext(sprite_index,image_index,x,y,effectSize[i],effectSize[i],0,c_white,effectAlpha[i])}
    draw_set_blend_mode(bm_normal)
  draw_sprite_ext(sprite_index,image_index,x,y,1,1,0,c_white,image_alpha)
}
else
{
  draw_sprite_ext(sprite_index,image_index,x,y,1,1,0,c_gray,image_alpha)
}
if instance_exists(oDAbomMain)
{
  if oDAbomMain.spinPhase=3 and bCanTakeDamage=1
  {
    draw_set_alpha(0.8)
    draw_circle_color(x,y,16,c_white,c_white,true)
    draw_circle_color(x,y,15,c_white,c_white,true)
  }
}
