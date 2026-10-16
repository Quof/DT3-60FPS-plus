//Evil Boss Gallery: rings closing in on Evil Death, motes spiralling in, and a tether to the player being pulled
var k,r,a;
draw_set_color(make_color_rgb(150,30,80))
for(k=0;k<4;k+=1)
{
  r=128-((t*3+(k*32)) mod 128)
  draw_set_alpha(str*0.55*(r/128))
  draw_circle(x,y,r,1)
  draw_circle(x,y,r+1,1)
}
draw_set_color(make_color_rgb(230,120,200))
for(k=0;k<12;k+=1)
{
  r=112-((t*2+(k*19)) mod 112)
  a=(k*30)+(t*6)+(r*1.5)
  draw_set_alpha(str*0.9*(r/112))
  draw_circle(x+lengthdir_x(r,a),y+lengthdir_y(r*0.6,a),2,0)
}
if instance_exists(oPlayer1)
{
  draw_set_color(make_color_rgb(200,60,130))
  draw_set_alpha(str*(0.3+0.2*((floor(t/2) mod 2)=0)))
  draw_line_width(x,y,oPlayer1.x,oPlayer1.y-20,2)
}
draw_set_alpha(1)
draw_set_color(c_white)
