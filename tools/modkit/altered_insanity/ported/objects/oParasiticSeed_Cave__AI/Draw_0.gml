if waveAUp=1
{
  scaleWaveA+=0.004*gDeltaTime
  if scaleWaveA>=0.55 {waveAUp=0}
}
else
{
  scaleWaveA-=0.004*gDeltaTime
  if scaleWaveA<=0.45 {waveAUp=1}
}
image_xscale=0.5+scaleWaveA
image_yscale=0.5+scaleWaveA
draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)

if armorAlpha>0
{
  for(i=0;i<8;i+=1)
  {
    draw_sprite_ext(sPSF_Armor,image_index,x+lengthdir_x(armorDist,armorAngle+(i*45)),y+lengthdir_y(armorDist,armorAngle+(i*45)),image_xscale,image_yscale,armorAngle+(i*45),image_blend,armorAlpha)
  }
}
