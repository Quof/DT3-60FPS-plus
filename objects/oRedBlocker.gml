#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
findTargetX=0
findTargetY=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
findTargetX=point_distance(oPlayer1.x,0,x,0)
findTargetY=point_distance(0,oPlayer1.y,0,y)
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if findTargetX<480 and findTargetY<352
{
  if global.rbSwitchBlueOn=true
  {
    mask_index=sprite_index
    image_alpha=1
  }
  else
  {
    mask_index=sNull
    image_alpha=0.6
  }

  draw_sprite_ext(sprite_index,global.rbSwitchBlueOn,x,y,1,1,0,c_white,image_alpha)
}
