#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
fadeAlpha=0.3
fadeColor=c_purple

backFollowFore=instance_create(0,0,oBackgroundFollow)
backFollowFore.type=1; backFollowFore.backSet=backCastlevaniaF
backFollowFore.xScrollSpeed=-0.9; backFollowFore.yScrollSpeed=0.1
backFollowFore.depth=1400000; backFollowFore.image_alpha=0.8
backFollowFore=instance_create(0,0,oBackgroundFollow)
backFollowFore.type=1; backFollowFore.backSet=backCastlevaniaF
backFollowFore.xScrollSpeed=1.1; backFollowFore.yScrollSpeed=0.2
backFollowFore.depth=0; backFollowFore.image_alpha=0.4
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if fadeAlpha>0
{
  draw_set_alpha(fadeAlpha)
  draw_set_color(fadeColor)
  draw_rectangle(view_xview[0]-1,view_yview[0]-1,view_xview[0]+view_wview[0]+1,view_yview[0]+view_hview[0]+1,0)
}
