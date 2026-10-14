//if bCanTakeDamage=0 and life>0 {scaleWave+=pi/60}
if bCanTakeDamage=0 and life>0 {scaleWave+=(pi/60)*gDeltaTime} //60fps change: per frame
/*for(i=0;i<5;i+=1)
{
  draw_sprite_ext(sAbomBodyConnectorA,0,x+lengthdir_x(20+(18*i),_direction),y+lengthdir_y(20+(18*i),_direction),1.25+(sin(scaleWave+i)/2),1.25+(sin(scaleWave+i)/2),i*20,c_white,image_alpha)
}*/
if resType[0]>1
{
draw_sprite_ext(sAbomHitSpotA,animFrm,x,y,image_xscale,image_yscale,0,image_blend,image_alpha)
draw_sprite_ext(sAbomHitSpotA,animFrm+1,x,y,image_xscale,image_yscale,90,image_blend,image_alpha)
draw_sprite_ext(sAbomHitSpotA,animFrm+2,x,y,image_xscale,image_yscale,180,image_blend,image_alpha)
draw_sprite_ext(sAbomHitSpotA,animFrm+3,x,y,image_xscale,image_yscale,270,image_blend,image_alpha)
}
else //phase 2
{
draw_sprite_ext(sAbomHitSpotB,animFrm,x,y,image_xscale,image_yscale,0,image_blend,image_alpha)
draw_sprite_ext(sAbomHitSpotB,animFrm+1,x,y,image_xscale,image_yscale,90,image_blend,image_alpha)
draw_sprite_ext(sAbomHitSpotB,animFrm+2,x,y,image_xscale,image_yscale,180,image_blend,image_alpha)
draw_sprite_ext(sAbomHitSpotB,animFrm+3,x,y,image_xscale,image_yscale,270,image_blend,image_alpha)
}
//spsp ns
if bombflag=2 and life>0
{
  draw_sprite_ext(sBombShieldAbom,round(BSturn),x,y,1,1,0,image_blend,0.6)
}
else if bombflag=1 and life>0 and BStimer>90
{
  BStemp=1*(3-2*BStimer/BSdelay)
  draw_sprite_ext(sBombShieldAbom,round(BSturn),x,y,BStemp,BStemp,0,image_blend,0.2)
  draw_circle_color(x,y,22,c_white,c_white,true)
  draw_circle_color(x,y,23,c_white,c_white,true)
}
