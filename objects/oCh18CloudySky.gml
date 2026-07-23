#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
drawNum=ceil(room_width/128)+1
scrollX=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
scrollX-=2
if scrollX<=-64 {scrollX=0}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
for(i=0;i<drawNum;i+=1)
{
  draw_background_ext(backStarrySkiesB,scrollX+(i*128),64,2,2,0,c_white,0.3)
}
