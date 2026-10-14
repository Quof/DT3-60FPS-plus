if global.gameOver=false and bChaoActive=1
{
  if bTargetActive=1 and room!=rDistortedAbom //spsp ns
  {
    chaoTargetFrm+=0.2*gDeltaTime
    draw_sprite(sChaoTarget,chaoTargetFrm,chaoTargetX,chaoTargetY)
  }

  if dotPointer=1
  {
    draw_set_color(c_yellow)
    draw_set_alpha(1)
    draw_rectangle(mouse_x-1,mouse_y-1,mouse_x+1,mouse_y+1,0)
  }
  draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)

  if chaoEndAssisted>0
  {
    draw_sprite_ext(sEfPlayerTrail,0,x,y,2,2,image_angle,image_blend,chaoLightAssistAlpha)
  }
}

//-------------------- emotes --------------------
/*
if global.gameOver=false
{
  if emoteType=EM_EXCITE //-------------------- Excited --------------------
  {
    if emoteScale<1
      emoteScale+=0.1
    draw_sprite_ext(sEmExcite,0,x,bbox_top-4,emoteScale,emoteScale,0,c_white,emoteAlpha)
  }
  else if emoteType=EM_IDEA //-------------------- Idea --------------------
  {
    if emoteScale<1
      emoteScale+=0.1
    draw_sprite_ext(sEmIdea,0,x,bbox_top-4,emoteScale,emoteScale,0,c_white,emoteAlpha)
  }
  else if emoteType=EM_MAD //-------------------- Mad --------------------
  {
    if emoteScale<1
      emoteScale+=0.1
    if emoteTime mod 4=0
    {
      emoteFrame+=1
      if emoteFrame=3
        emoteFrame=0
    }
    draw_sprite_ext(sEmMad,emoteFrame,x,bbox_top-4,emoteScale,emoteScale,0,c_white,emoteAlpha)
  }
  else if emoteType=EM_LOVE //-------------------- Love --------------------
  {
    if emoteScale<1
      emoteScale+=0.1
    draw_sprite_ext(sEmLove,0,x,bbox_top-4,emoteScale,emoteScale,0,c_white,emoteAlpha)
  }
  else if emoteType=EM_EMBARRASS //-------------------- Embarrass --------------------
  {
    if emoteScale<1
      emoteScale+=0.1
    draw_sprite_ext(sEmEmbarrass,0,x,bbox_top-4,emoteScale,emoteScale,0,c_white,emoteAlpha)
  }

  if emoteType>0 //fade emotes
  {
    emoteTime+=1
    if emoteTime>=35
    {
      emoteAlpha-=0.1
      if emoteAlpha<=0
      {
        emoteTime=0
        emoteType=0
        emoteFrame=0
        emoteScale=0.1
        emoteAlpha=1
      }
    }
  }
}
