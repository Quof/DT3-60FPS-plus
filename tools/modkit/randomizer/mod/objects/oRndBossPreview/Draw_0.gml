//Randomizer: the preview. Its look (pvMode 0): faint, rising and falling a little and fading in and out, every 3 to 4
//seconds. The smoke (pvMode 1): a dark heart, 12 puffs rising out of it, each growing and fading as it goes (a puff's
//life is 90 ticks, 3 seconds: its phase tP 0 to 1, the 12 a twelfth of it apart), and a dim red glow coming and going
//(added on: bm_add). Everything from pvT, so at any frame rate it moves the same
var i,tP,tS,tA;
if pvMode=0
{
  tA=0.42+0.12*sin(pvT*0.07)
  draw_sprite_ext(pvSpr,0,x,y+3*sin(pvT*0.055),1,1,0,c_white,tA)
  exit
}
draw_sprite_ext(sRndBossSmoke,0,x,y+8,1.6+0.1*sin(pvT*0.08),1.2+0.08*sin(pvT*0.08),-pvT*0.5,make_color_rgb(24,12,30),0.75)
for(i=0;i<12;i+=1)
{
  tP=frac(pvT/90+i/12)
  tS=0.6+tP*0.8
  draw_sprite_ext(sRndBossSmoke,i mod 4,x+10*sin(pvT*0.03+i*2.1)*tP+lengthdir_x(10,i*30)*(1-tP),y+28-tP*56,tS,tS,pvT*0.6+i*30,make_color_rgb(64,40,84),0.7*sin(tP*pi))
}
draw_set_blend_mode(bm_add)
draw_sprite_ext(sRndBossSmoke,1,x,y,1.1,1.1,pvT*0.3,make_color_rgb(120,14,30),0.2+0.14*sin(pvT*0.09))
draw_set_blend_mode(bm_normal)
