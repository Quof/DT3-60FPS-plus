#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Overworld map object
bOnMe=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if !instance_exists(oZeldaSaveMenu) and oPlayerGameIcon.bMoveStep=0
{
  if point_distance(x+8,y+8,oPlayerGameIcon.x,oPlayerGameIcon.y)<18
  {
    if point_direction(x+8,y+8,oPlayerGameIcon.x,oPlayerGameIcon.y)=0 or point_direction(x+8,y+8,oPlayerGameIcon.x,oPlayerGameIcon.y)=90 or point_direction(x+8,y+8,oPlayerGameIcon.x,oPlayerGameIcon.y)=180 or point_direction(x+8,y+8,oPlayerGameIcon.x,oPlayerGameIcon.y)=270
    {
      bOnMe=1
    }
  }
}
#define Step_1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
bOnMe=0
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_sprite(sprite_index,image_index,x,y)
if bOnMe=1
{
  draw_set_font(fnt_NES)
  draw_set_halign(fa_middle)
  textDropShadow(myMessage,oPlayerGameIcon.x+8,oPlayerGameIcon.y-24,c_white,c_black,3)
}
