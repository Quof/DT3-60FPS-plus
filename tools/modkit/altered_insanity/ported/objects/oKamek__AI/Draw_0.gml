if bShadow=1 //Shadow
{
  draw_sprite_ext(sprite_index,image_index,x,y,-shadowScl,shadowScl*1.25,image_angle,c_black,0.6)
}

draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
if wandState=2 //Barrier
{
  //shieldAnim+=0.2
  shieldAnim+=0.2*gDeltaTime //60fps change: scaled
  draw_sprite_ext(sWaterBarrier,shieldAnim,x,y-21,image_xscale,image_yscale,image_angle,image_blend,0.33)
}

if shockPass=1000 //Fire charge effect
{
  var tEfAlpha,tEfScl;
  //if oGame.time mod 2=0 {tEfAlpha=0.4} else {tEfAlpha=0.6}
  //if oGame.time mod 3=0 {tEfScl=1} else {tEfScl=1.2}
  //60fps change: flicker per 30fps tick (oGame.time counts frames, which made it flicker 2-4x faster above 30fps)
  if oGame.time30 mod 2=0 {tEfAlpha=0.4} else {tEfAlpha=0.6}
  if oGame.time30 mod 3=0 {tEfScl=1} else {tEfScl=1.2}
  draw_sprite_ext(sEfPowerWave,0,x,y,tEfScl,tEfScl,0,c_white,tEfAlpha)
}
