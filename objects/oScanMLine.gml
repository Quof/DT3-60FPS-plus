#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
visible=1
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_set_alpha(image_alpha)
if bMaster=1
{
  draw_set_color(make_color_rgb(0,251,254))
  newLine=instance_create(x+2,y,oScanMLine)
  newLine.bMaster=0
  x+=2
  if x>=oMessageEnemy.statsWindowX+328
    instance_destroy()
}
else
{
  draw_set_color(make_color_rgb(0,255,0))
  image_alpha-=0.01
  if image_alpha<=0
    instance_destroy()
}
draw_line_width(x,y,x,y+114,2)
