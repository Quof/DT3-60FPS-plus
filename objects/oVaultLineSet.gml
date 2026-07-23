#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
barColor=make_color_rgb(236,236,236)
image_alpha=0.4
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if checkScreenArea(x,y,barMax*(barSize+1)+4)=1
{
  draw_set_color(barColor)
  draw_set_alpha(image_alpha)
  for(i=0;i<barMax;i+=1)
  {
    draw_line_width(x+(i*(barSize+1)),y+16,x+(i*(barSize+1)),y+16-1-irandom(maxLength),barSize)
  }
}
