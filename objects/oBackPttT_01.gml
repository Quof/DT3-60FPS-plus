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
  moveTime+=1*gDeltaTime
  //if moveTime=320 {xScrollSpeed=-1*gDeltaTime; yScrollSpeed=0}
  if moveTime=320 {xScrollSpeed=-1; yScrollSpeed=0} //60fps change: speeds are per tick now; the Draw event scales them
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

//xx+=xScrollSpeed
//yy+=yScrollSpeed
xx+=xScrollSpeed*gDeltaTime //60fps change: scrolls per frame, so scale here (yScrollSpeed=1 from oEvPttT scrolled 2x/4x too fast at 60/120fps)
yy+=yScrollSpeed*gDeltaTime //60fps change
