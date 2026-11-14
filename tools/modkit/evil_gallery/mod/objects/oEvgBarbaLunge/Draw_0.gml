//Evil Boss Gallery: the lunging head (facing the way it goes) and three body segments behind it, along the band
var k,tCy;
tCy=y+10
for(k=4;k>=1;k-=1)
{
  draw_sprite_ext(sBarbaBody,0,hx-dir*(8+k*14),tCy+2*sin((t+k*3)*0.6),1,1,0,c_white,1)
}
draw_sprite_ext(sBarbaHead,1,hx-dir*8,tCy,dir,1,0,c_white,1)
