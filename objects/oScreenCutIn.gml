#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
type=0
screenCut=176
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if type=0
{
  image_alpha-=0.1
  if image_alpha<=0 {instance_destroy()}
}
else if type=1
{
  screenCut-=16
  if screenCut<=0 {instance_destroy()}
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_set_alpha(image_alpha)
draw_set_color(c_black)

if type=0
  draw_rectangle(view_xview[0]-1,view_yview[0]-1,view_xview[0]+view_wview[0]+1,view_yview[0]+view_hview[0]+1,0)
else if type=1
{
  draw_rectangle(view_xview[0]-1,view_yview[0]-1,view_xview[0]+view_wview[0]+1,view_yview[0]-1+screenCut,0)
  draw_rectangle(view_xview[0]-1,view_yview[0]+view_hview[0]+1,view_xview[0]+view_wview[0]+1,view_yview[0]+view_hview[0]-screenCut,0)
}
