/*
Draws one of the color indicator's diamonds (oColorIndControl) in its color zone's color (global.czColor, set in
Options > Graphics > Color Zone Colors). At the default color it's the original sprite frame; otherwise it's
sColorZoneDiamondW (white shading tinted with the color) with its light facet whitened on top.
argument0: zone (1-4)   argument1, argument2: x, y   argument3: scale   argument4: rotation   argument5: alpha
*/
var z;
z=argument0
if global.czColor[z]=global.czDefault[z]
{
  draw_sprite_ext(sColorZoneDiamond,z-1,argument1,argument2,argument3,argument3,argument4,image_blend,argument5)
}
else
{
  draw_sprite_ext(sColorZoneDiamondW,0,argument1,argument2,argument3,argument3,argument4,global.czColor[z],argument5)
  draw_sprite_ext(sColorZoneDiamondW,1,argument1,argument2,argument3,argument3,argument4,c_white,argument5*0.4)
}
