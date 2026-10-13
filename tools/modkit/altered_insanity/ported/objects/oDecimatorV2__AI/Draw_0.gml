if bLaserCannon=1
{
  draw_sprite_ext(sDeciLaserCannon,0,x+4,y+12,-1,1,image_angle,cannonBlend,image_alpha)
}
event_inherited()
draw_sprite_ext(sDeciLightningRod,0,x,y+40,1,1,image_angle,image_blend,image_alpha)

if bGuns=1
{
  draw_sprite_ext(sDeciGun,0,x+18,y+6,1,1,gunAngleA,gunA_Blend,image_alpha)
  draw_sprite_ext(sDeciGun,0,x-18,y+6,1,1,gunAngleB,gunB_Blend,image_alpha)
}
