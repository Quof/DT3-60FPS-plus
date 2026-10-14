draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,myHS.image_blend,image_alpha)

if specProg>=70
{
  //if specBackAlpha=0.8 {specBackAlpha=0.6}
  //else {specBackAlpha=0.8}
  if gDeltaDoTicks //60fps change (added): flicker once per 30fps tick (Draw runs every frame, so it flickered 4x as fast at 120fps)
  {
  if specBackAlpha=0.8 {specBackAlpha=0.6}
  else {specBackAlpha=0.8}
  } //60fps change (added)
  draw_sprite_ext(sE_SpecialBack,image_index,x,y-20,image_xscale,image_yscale,image_angle,image_blend,specBackAlpha)
}

if activateBoss=2 and specProg!=0 //spsp ns
{
  draw_sprite(sE_SpecBar,0,view_xview[0]+137,view_yview[0]+334)
  /*if specProg=0
  {
    specTrack=(specTime/specMax)*200
    if specTrack>200 {specTrack=200}
    draw_sprite_ext(sEnemyLifeTrack,0,view_xview[0]+140,view_yview[0]+337,specTrack,1.6,0,c_purple,1)
  }*/
  /*else
  {*/
    specTrack=(specHP/15)*200
    if specTrack>200 {specTrack=200}
    draw_sprite_ext(sEnemyLifeTrack,0,view_xview[0]+140,view_yview[0]+337,specTrack,1.6,0,c_purple,1)
  /*}*/
  }
