//Evil Boss Gallery: the claw at the front, and two smaller ones sinking behind it
var k;
for(k=2;k>=1;k-=1)
{
  draw_sprite_ext(sprite_index,image_index,x-dir*k*10,y+k*6,image_xscale,1-k*0.25,0,c_white,1-k*0.3)
}
draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,1,0,c_white,1)
