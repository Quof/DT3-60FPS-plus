//Rope (Form A)
if bRope=1
{
  draw_sprite_ext(sWarmasterA_RopeA,dashEfFrm,ropeX,48,1,ropeYscl,0,c_white,1)
}

//Dash effect
if dashEfType=1
{
  draw_sprite_ext(sWarmasterD_DashEfA,dashEfFrm,x,y,image_xscale,image_yscale,image_angle,c_white,0.9)
}
else if dashEfType=2
{
  draw_sprite_ext(sWarmasterD_DashEfB,dashEfFrm,x,y,image_xscale,image_yscale,image_angle,c_white,0.9)
}
if sprite_index=sWarmasterC_JetB
{
  jetEfFrm+=0.33*gDeltaTime
  draw_sprite_ext(sWarmasterC_JetEfA,jetEfFrm,x-(7*image_xscale),y-46,image_xscale,image_yscale,image_angle,c_white,0.9)
}
else if sprite_index=sWarmasterD_Hover
{
  jetEfFrm+=0.33*gDeltaTime
  draw_sprite_ext(sWarmasterD_HoverEfA,jetEfFrm,x-(3*image_xscale),y-24,image_xscale,image_yscale,image_angle,c_white,0.9)
}

if sprite_index=sWarmasterA_SwordRoll {draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,swdRollAng,image_blend,image_alpha)}
else {draw_self()}

//if pepsiLogo>=16 and pepsiLogo<=17
if pepsiLogo>15 and pepsiLogo<=17 //60fps change: shown for all of ticks 16-17
{
  draw_sprite_ext(sPepsiLogo,0,xCenter,yGround-128,1,1,0,c_white,1)
}

//DELETE
/*
draw_set_color(c_red)
draw_set_alpha(1)
draw_set_font(fnt_EnemyName)
draw_set_halign(fa_center)
draw_text(x,y-72,tornadoNum)
