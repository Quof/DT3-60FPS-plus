#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if turnType=0 //Top-left
{
  draw_background_part(tileDraw,0,0,16,16,x,y)
}
else if turnType=1 //Top-right
{
  draw_background_part(tileDraw,16,0,16,16,x,y)
}
else if turnType=2 //Bottom-right
{
  draw_background_part(tileDraw,16,16,16,16,x,y)
}
else if turnType=3 //Bottom-left
{
  draw_background_part(tileDraw,0,16,16,16,x,y)
}
