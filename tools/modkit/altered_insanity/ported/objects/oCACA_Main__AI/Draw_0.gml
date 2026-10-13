draw_sprite_ext(sCACA_LeftLeg,0,x-(44*image_xscale),y+42,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
draw_sprite_ext(sCACA_Body,0,x-(96*image_xscale),y+11,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
if bChestLight=1
{
  draw_sprite_ext(sCACA_ChestLight,0,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
}
draw_sprite_ext(sCACA_RightLeg,0,x-(90*image_xscale),y+24,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
draw_sprite_ext(sCACA_Arm,0,x-(88*image_xscale),y+24,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
draw_sprite_ext(sCACA_Fingers,fingerFrm,x+(56*image_xscale),y+58,image_xscale,image_yscale,image_angle,image_blend,image_alpha)

if laserWarn>0
{
  draw_set_alpha(circleAlpha)
  draw_set_color(c_red)
  for(i=0;i<4;i+=1)
  {
    draw_circle(x+(13*image_xscale),y-90,cirRad*(i+1),1)
  }
}
