if bFromGround=0
{
  draw_sprite_ext(sKingWormEye,0,x+xEye,y+yEye,image_xscale,1,image_angle,image_blend,image_alpha)

  if eyelidFrame=1
  {
    draw_sprite_ext(sKingWormEyelid,1,x,y+4,image_xscale,-1,image_angle,image_blend,image_alpha)
  }
  else if eyelidFrame=2 //Eye closed
  {
    draw_sprite_ext(sKingWormEyelid,1,x,y+8,image_xscale,1,image_angle,image_blend,image_alpha)
    draw_sprite_ext(sKingWormEyelid,0,x,y+3,image_xscale,1,image_angle,image_blend,image_alpha)
  }

  draw_sprite_ext(sKingWormHead,0,x,y+6,image_xscale,1,image_angle,image_blend,image_alpha)
}
else if bFromGround=1
{
  draw_sprite_ext(sKingWormEye,0,x+xEye,y-yEye,image_xscale,-1,image_angle,image_blend,image_alpha)

  if eyelidFrame=1
  {
    draw_sprite_ext(sKingWormEyelid,1,x,y-4,image_xscale,1,image_angle,image_blend,image_alpha)
  }
  else if eyelidFrame=2 //Eye closed
  {
    draw_sprite_ext(sKingWormEyelid,1,x,y-8,image_xscale,-1,image_angle,image_blend,image_alpha)
    draw_sprite_ext(sKingWormEyelid,0,x,y-3,image_xscale,-1,image_angle,image_blend,image_alpha)
  }

  draw_sprite_ext(sKingWormHead,0,x,y-6,image_xscale,-1,image_angle,image_blend,image_alpha)
}
