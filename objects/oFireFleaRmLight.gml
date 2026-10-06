#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_alpha=0
phase=0
darkNum=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
phase+=1*gDeltaTime
//if phase>=1 and phase<=20 {image_alpha+=0.0025*gDeltaTime}
if phase>0 and phase<=20 {image_alpha+=0.0025*gDeltaTime} //60fps change: covers every frame of ticks 1 and 22, so the darkness pulse is as deep as at 30fps
//else if phase>=22 and phase<=41 {image_alpha-=0.0025*gDeltaTime}
else if phase>21 and phase<=41 {image_alpha-=0.0025*gDeltaTime} //60fps change: see above
else if phase>=42 {phase=0}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_set_color(c_black)
draw_set_alpha(image_alpha)
draw_rectangle(-1,-1,room_width+1,room_height+1,0)
