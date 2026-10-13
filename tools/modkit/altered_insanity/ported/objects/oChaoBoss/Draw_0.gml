if bTargetActive=1
{
  //chaoTargetFrm+=0.2
  chaoTargetFrm+=0.2*gDeltaTime //60fps change
  draw_sprite(sChaoTarget,chaoTargetFrm,chaoTargetX,chaoTargetY)
}

draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)

draw_text(x,y+20, string(actPhase) + " " + string(actTime) + string(waitTime) + " " + string(waitDelay))
