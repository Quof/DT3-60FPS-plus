//Evil Boss Gallery: the rock's shadow on the islands (growing as it nears), and the rock once it falls
var tS;
tS=0.4+0.6*min(1,t/warn)
if prog=1 {tS=1}
draw_set_color(c_black)
draw_set_alpha(0.45)
draw_ellipse(x-12*tS,yLand-3,x+12*tS,yLand+2,0)
draw_set_alpha(1)
draw_set_color(c_white)
if prog=1 {draw_sprite_ext(sprite_index,0,x,y,image_xscale,image_yscale,image_angle,c_white,1)}
