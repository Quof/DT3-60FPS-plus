//Randomizer: its part of the HUD (oHUD's draw, after the game's own parts): the trap items on (rndSnareSpring) and how
//long each has left, at the top right
var k,tY,tS,tSec;
if global.rndActive=0 {exit}
if global.rndSnareT[1]<=0 and global.rndSnareT[2]<=0 and global.rndSnareT[4]<=0 and global.rndSnareT[5]<=0 {exit}
draw_set_font(fnt_NES)
draw_set_halign(fa_right)
tY=view_yview[0]+24
for(k=1;k<=5;k+=1)
{
  if global.rndSnareT[k]>0
  {
    tS=ceil(global.rndSnareT[k]/30)
    tSec=string(tS mod 60)
    if string_length(tSec)<2 {tSec="0"+tSec}
    textDropShadow(global.rndSnareHUD[k]+" "+string(tS div 60)+":"+tSec,view_xview[0]+474,tY,make_color_rgb(255,120,120),c_black,3)
    tY+=12
  }
}
draw_set_halign(fa_left)
