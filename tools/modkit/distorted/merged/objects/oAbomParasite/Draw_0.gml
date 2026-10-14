scaleWaveA+=(pi/60)*gDeltaTime
/*for(i=0;i<8;i+=1)
{
  draw_sprite_ext(sAbomBodyConnectorA,0,x+lengthdir_x(20+(18*i),30),y+lengthdir_y(20+(18*i),30),1.25+(sin(scaleWaveA+i)/2),1.25+(sin(scaleWaveA+i)/2),i*20,c_white,image_alpha)
  draw_sprite_ext(sAbomBodyConnectorA,0,x+lengthdir_x(20+(18*i),330),y+lengthdir_y(20+(18*i),330),1.25+(sin(scaleWaveA+i)/2),1.25+(sin(scaleWaveA+i)/2),i*20,c_white,image_alpha)
  draw_sprite_ext(sAbomBodyConnectorA,0,x+lengthdir_x(20+(18*i),150),y+lengthdir_y(20+(18*i),150),1.25+(sin(scaleWaveA+i)/2),1.25+(sin(scaleWaveA+i)/2),i*20,c_white,image_alpha)
  draw_sprite_ext(sAbomBodyConnectorA,0,x+lengthdir_x(20+(18*i),210),y+lengthdir_y(20+(18*i),210),1.25+(sin(scaleWaveA+i)/2),1.25+(sin(scaleWaveA+i)/2),i*20,c_white,image_alpha)
}*/

if waveBUp=1
{
  scaleWaveB+=0.004*gDeltaTime
  if scaleWaveB>=1.05 {waveBUp=0}
}
else
{
  scaleWaveB-=0.004*gDeltaTime
  if scaleWaveB<=0.95 {waveBUp=1}
}
image_xscale=1+scaleWaveB
image_yscale=1+scaleWaveB
draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
