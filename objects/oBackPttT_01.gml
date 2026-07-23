#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
xx=0
yy=0
xScrollSpeed=0
yScrollSpeed=0
moveType=0
moveTime=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if moveType=1
{
  moveTime+=1
  if moveTime=320 {xScrollSpeed=-1; yScrollSpeed=0}
  else if moveTime=640
  {
    xScrollSpeed=0; yScrollSpeed=1
    moveTime=0
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_background_tiled_ext(backSet,x+xx,y+yy,image_xscale,image_yscale,image_blend,image_alpha)

xx+=xScrollSpeed
yy+=yScrollSpeed
