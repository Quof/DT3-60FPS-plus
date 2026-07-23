#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
compScrFade=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if compScrFade=0
{
  image_alpha-=0.01
  if image_alpha<=0.6 {compScrFade=1}
}
else if compScrFade=1
{
  image_alpha+=0.01
  if image_alpha>=1 {compScrFade=0}
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_sprite(sprite_index,0,x,y)
draw_sprite_ext(sControlCenterOverlay,0,x,y-30,1,1,0,c_white,image_alpha)
