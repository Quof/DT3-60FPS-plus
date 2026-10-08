/*
jukebox change (added): textDropShadow's all-round shadow (type 4), squeezed narrower when the text is wider than it has
room for. For the music credits (scrMusicCredit). Uses the font and alignment already set.
argument0: text
argument1: x
argument2: y
argument3: the widest it can be
argument4: text color
argument5: shadow color
*/
var tScale,tI,tJ;
tScale=1
if string_width(argument0)>argument3 {tScale=argument3/string_width(argument0)}
draw_set_color(argument5)
for(tI=-1;tI<=1;tI+=1)
{
  for(tJ=-1;tJ<=1;tJ+=1)
  {
    if tI!=0 or tJ!=0 {draw_text_transformed(argument1+tI,argument2+tJ,argument0,tScale,1,0)}
  }
}
draw_set_color(argument4)
draw_text_transformed(argument1,argument2,argument0,tScale,1,0)
