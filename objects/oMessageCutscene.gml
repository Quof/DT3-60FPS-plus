#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_speed=0.25
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
showMessage(view_xview[0]+x,view_yview[0]+y,message,talker,wColor,1,wSize)

//Show continue message icon
if wSize=0
  draw_sprite(sMsgArrow,image_index,view_xview[0]+x+132,view_yview[0]+y+36)
else if wSize=1
  draw_sprite(sMsgArrow,image_index,view_xview[0]+x+192,view_yview[0]+y+49)
else if wSize=2
  draw_sprite(sMsgArrow,image_index,view_xview[0]+x+252,view_yview[0]+y+62)
else if wSize=3
  draw_sprite(sMsgArrow,image_index,view_xview[0]+x+312,view_yview[0]+y+75)
